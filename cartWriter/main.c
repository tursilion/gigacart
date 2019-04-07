// Program to read data from a Compact Flash card and write it to a Gigacart Seahorse board
//
// The board requires a special CPLD load and a system hardware modification so that
// the GROM Select pin is actually the >E000 address select pin.
// 
// CPLD uses writes to >6000 to set internal data:
// Bits >03 are the most significant bits of the address latch (the rest comes from the address bus)
// Bit >04 enables >E000 writes to the LSB
// Bit >08 enables >E000 writes to the MSB
// Bit >10 directly controls the flash reset pin (active low reset)
//
// When either write bit is enabled, reads from >6000 are disabled - otherwise changing the latch breaks the unlock.
// Reads from >E000 are always disabled.
//
// To load the code I'm actually using a modified console that has Editor/Assembler
// on the motherboard, and using the CF7 device.
//
// Since the range at >E000 is dual-purposed, we mustn't put any code or data there.
//
// The first 400k of the CF card is DSK1, which contains the program. Doing it this way
// lets us load it.
// 
// The CF card is memory mapped when CRU >1100 is turned on. The 16 registers are available
// at >5E00 for reads, and >5F00 for writes. The card is in IDE mode and not all cards work
// with the CF7. (In fact in my testing, most cards don't work.)
//
// Due to a hardware bug on the Seahorse board, the first 128k of the flash can not be
// programmed, so this code currently skips over that. The software needs to cope.
// However, for the sake of testing and so forth, the entire 128MB image is still created.
//
// A second, very late bug is that the flash chip needs us to control CE, not reset, so
// a modification lets us autodetect which board version is plugged in (as CE is inverted
// compared to reset, at least so far as reading the chip goes). The CFI read function
// is used to determine which way to go, since it's the first code called.
//
// TODO: The flash datasheets say that polling for write status might go away in the future,
// and only status word reads will work. So someday we need to figure out why they don't.

// uses libti99
#include "vdp.h"
#include "conio.h"		// only using for clrscr
#include "string.h"

#ifndef bool
#define bool int
#define false 0
#define true 1
#endif
#ifndef NULL
#define NULL 0
#endif

// define this to enable gigacart verify print back
//#define VERIFYLATCH

// forward declarations
void flashReset() ;
void flashUnlock() ;
void flashDetectReset() ;
void flashReadCfi() ;
bool flashWaitForWrite(unsigned int page, unsigned int adr, unsigned char val) ;
bool flashWriteFast(unsigned int page, unsigned int adr) ;
bool flashWriteSlow(unsigned int page, unsigned int adr) ;
bool flashSectorErase(unsigned int page) ;
bool flashChipErase() ;
bool flashChecksum();

// asm code in scratchpad
extern void cf7ReadSectorLoop();
extern void flashWriteFastLoop(unsigned int off, unsigned int adr);
extern unsigned int flashVerifyLoop(unsigned int adr);
extern void setupScratchpad();

// classic99 puts the CF7 at >1000 instead of >1100
bool CF7Classic99 = false;
#define CLASSIC99_CRU_ON __asm__( "li r12,>1000\n\tsbo 0" : : : "r12" )
#define CLASSIC99_CRU_OFF __asm__( "li r12,>1000\n\tsbz 0" : : : "r12" )
#define REAL_CF7_CRU_ON __asm__( "li r12,>1100\n\tsbo 0" : : : "r12" )
#define REAL_CF7_CRU_OFF __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" )
#define CF7_CRU_ON if (CF7Classic99) CLASSIC99_CRU_ON; else REAL_CF7_CRU_ON;
#define CF7_CRU_OFF if (CF7Classic99) CLASSIC99_CRU_OFF; else REAL_CF7_CRU_OFF;

void cf7Reset() ;
void cf7Init() ; 
void cf7SetAddress(unsigned int high, unsigned int low) ;
void cf7CardError() ;
bool cf7WaitForReady() ;
void cf7IdentifyDevice() ;
bool cf7ReadSector(unsigned int high, unsigned int low) ;
bool cf7WriteSector(unsigned int high, unsigned int low) ;

// this is where we store buffers from the CF device
unsigned char buffer[512];
// this is where we read the keyboard to
unsigned char kscan_key;
// this used to be a constant. Now it's not
unsigned char FLASH_UNRESET;

#ifdef VERIFYLATCH
volatile unsigned char verify;
volatile unsigned int verifylatch;

// write to this to set the control bits on the flash (note you write ALL of them!)
#define FLASH_SETBITS(yy) *((volatile unsigned char*)0x6000)=verify=(yy); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (yy));
// or this one is you need a non-zero latch
#define FLASH_SETLATCH(xx,yy) verifylatch=(xx); *((volatile unsigned char*)(0x6000+(xx)))=verify=(yy); printf("%s - latch >%X%X = >%X\n", __FUNCTION__, (0x6000+(xx))>>8, (0x6000+(xx))&0xff, (yy));
// write to this one to write data to the flash (within 8k, of course, and based on the bits)
#define FLASH_WRITE(xx,yy) verifylatch=(xx); *((volatile unsigned char*)(0xE000+(xx)))=verify=(yy); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(xx))>>8, (0xe000+(xx))&0xff, (yy));
#else
// write to this to set the control bits on the flash (note you write ALL of them!)
#define FLASH_SETBITS(yy) *((volatile unsigned char*)0x6000)=yy
// or this one is you need a non-zero latch
#define FLASH_SETLATCH(xx,yy) *((volatile unsigned char*)(0x6000+(xx)))=(yy);
// write to this one to write data to the flash (within 8k, of course, and based on the bits)
#define FLASH_WRITE(xx,yy) *((volatile unsigned char*)(0xE000+(xx)))=(yy)
#endif

// and read from this for data
#define FLASH_READ(xx) *((volatile unsigned char*)(0x6000+(xx)))

// these are the bitflags
#define FLASH_WRITELSB 0x04
#define FLASH_WRITEMSB 0x08
// reset/ce is now shared, depending on which cart is in use
// so 'flash_unreset' has to be a variable. This won't impact performance much... I think
// when it's CE, this needs to be zero instead
#define FLASH_UNRESET_DEFAULT  0x10

#if 0
// the offset is 128k, which is 16 (8k) pages. Latches are every 2 addresses.
#define FLASH_SKIPOFFSET (128*1024)
// There are only 16384 pages total, which fits in 16 bit. This gives 16 today.
#define FLASH_FIRSTPAGE (((FLASH_SKIPOFFSET)/(8*1024)))
// and we need to skip some CF7 sectors for the disk image
#define CF7_SKIPOFFSET (1600)
// Then we need to skip the flash offset too... (today this gives sector 1856)
#define CF7_FIRSTSECTOR (CF7_SKIPOFFSET+(FLASH_SKIPOFFSET/512))
// The last sector is always 128MB after the SKIPOFFSET (inclusive)
// This gives us a value of 262,143, which is too big for a 16-bit counter.
// I wonder how well 32-bit ints work in this compiler... sigh. Don't think
// I'll risk it today, so split into high and low.
#define CF7_LASTSECTOR (CF7_SKIPOFFSET+((128*1024*1024)/512)-1)
#define CF7_LASTSECTOR_HIGH (CF7_LASTSECTOR>>16)
#define CF7_LASTSECTOR_LOW  (CF7_LASTSECTOR&0xffff)
#else
// no 32-bit math in macros, eh? Fine. :) (even intermediates need to be 16 bit)
//
// There are only 16384 pages total, which fits in 16 bit. This gives 16 today.
#define FLASH_FIRSTPAGE 16
// Then we need to skip the flash offset too... (today this gives sector 1856)
#define CF7_FIRSTSECTOR 1856
// The last sector is always 128MB after the SKIPOFFSET (inclusive)
// This gives us a value of 262,143, which is too big for a 16-bit counter.
#define CF7_LASTSECTOR_HIGH 0x0004
#define CF7_LASTSECTOR_LOW  0x063F
#endif

// use this to read a CF7 register (CRU must be on)
#define CF7_READ(xx) *((volatile unsigned char*)(0x5e00+(xx)))
// use this to write a CF7 register (CRU must be on)
#define CF7_WRITE(xx) *((volatile unsigned char*)(0x5f00+(xx)))

// these are the registers (all odd on purpose)
#define CF7_DATA        1
#define CF7_FEATURES    3
#define CF7_ERROR       3
#define CF7_SECTOR_CNT  5
#define CF7_SECTOR_NO   7
#define CF7_CYL_LOW     9
#define CF7_CYL_HIGH    0xb
#define CF7_CARD_HEAD   0xd
#define CF7_COMMAND     0xf
#define CF7_STATUS      0xf
#define CF7_CONTROL     0x1d

//////////////////////////
// My fast screen scroll that leaves the top row alone
//////////////////////////

extern unsigned char vdp_bigbuf[256];

void my_fast_scrn_scroll() {
    // similar to the slow scrn_scroll, but uses a larger fixed
    // buffer for far more speed.
    // Leaves the top row alone for the progress bar.
    const int line = nTextEnd - nTextRow + 1;
    const int end = nTextEnd + gImage;
    int adr = gImage+line+line;
    int size = sizeof(vdp_bigbuf);

    while (adr+size < end) {
        vdpmemread(adr, vdp_bigbuf, size);
        vdpmemcpy(adr - line, vdp_bigbuf, size);
        adr += size;
    }
    if (adr <= end) {
        // copy whatever was left
        size = end - adr + 1;
        vdpmemread(adr, vdp_bigbuf, size);
        vdpmemcpy(adr - line, vdp_bigbuf, size);
    }
    vdpmemset(nTextRow, ' ', line);	// clear the last line
}

//////////////////////////
// My KSCAN that uses a local variable to save scratchpad
//////////////////////////
// By columns, then rows. 8 Rows per column. No shift states
const unsigned char keymap[] = {
		61,32,13,255,1,2,3,255,
		'.','L','O','9','2','S','W','X',
		',','K','I','8','3','D','E','C',
		'M','J','U','7','4','F','R','V',
		'N','H','Y','6','5','G','T','B',
		'/',';','P','0','1','A','Q','Z'
};

void kscanfast(int mode) {
	if (mode == 0) {
		kscan_key = 0xff;
		for (unsigned int col=0; col < 0x0600; col += 0x0100) {
			unsigned int key;
			__asm__("li r12,>0024\n\tldcr %1,3\n\tsrc r12,7\n\tli r12,>0006\n\tclr %0\n\tstcr %0,8" : "=r"(key) : "r"(col) : "r12");	// set cru, column, delay, read
			unsigned int shift=0x8000;

			for (int cnt=7; cnt>=0; cnt--) {
				// a pressed key returns a 0 bit
				if (key & shift) {
					shift>>=1;
					continue;
				}
				// found one
				kscan_key = keymap[(col>>5)+cnt];
				return;
			}
		}
	} else {
		unsigned int key;

		int col = 0x0600;		// joystick 1 fire column

		if (mode == 2) {
			col = 0x0700;		// make that joystick 2
		}

		__asm__("li r12,>0024\n\tldcr %1,3\n\tsrc r12,7\n\tli r12,>0006\n\tclr %0\n\tstcr %0,1" : "=r"(key) : "r"(col) : "r12");	// set cru, column, delay, read (only need 1 bit)
		if (key == 0) {
			kscan_key = 18;
		} else {
			kscan_key = 0xff;
		}
	}
}


//////////////////////////
// Flash functions
//////////////////////////

// does the reset. Release reset by setting the latch bits
void flashReset() {
	if (FLASH_UNRESET == FLASH_UNRESET_DEFAULT) {
		// assert reset by bringing it low. The other bits are don't care
		FLASH_SETBITS(0);
	} else {
		// we don't have reset, but we WILL deselect chip enable
		// again, we don't care about the other bits
		FLASH_SETBITS(FLASH_UNRESET_DEFAULT);
	}
}

// hacky shotgun style function to walk through the various resets
void flashSoftResetAll() {
    // ASO exit/reset
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);
    FLASH_WRITE(0xaaa, 0xf0);

    // write to buffer abort reset
    flashUnlock();
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);
    FLASH_WRITE(0xaaa, 0xf0);

    // status register clear
    FLASH_WRITE(0xaaa, 0x71);
}

#if 0
// toggle the MSB/LSB bits to see if reads are sneaking through on transition
// (they weren't)
void flashToggle() {
    do {
        FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);     // enable writes
        FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITELSB);     // enable writes
        kscanfast(0);
    } while (kscan_key != ' ');
}
#endif

// unlock sequence required for most operations
void flashUnlock() {
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);     // enable writes
    FLASH_WRITE(0xaaa, 0xaa);                          // unlock step 1
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITELSB);     // enable writes
    FLASH_WRITE(0x555, 0x55);                          // unlock step 2
}

// try to read CFI (start only) and determine whether we have a flash
// Reset line or a flash CE line.
void flashDetectReset() {
	// assume classic board
	FLASH_UNRESET = FLASH_UNRESET_DEFAULT;

	printf("Trying to read CFI with reset: ");
	
    // No unlock is needed - note that CFI is one of the only
    // commands that uses 0x0AA instead of 0xAAA
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);     // enable writes
    FLASH_WRITE(0xaa, 0x98);                           // CFI
    FLASH_SETBITS(FLASH_UNRESET);                      // enable reads

    // copy defined bytes (per the datasheet)
    // since we're 8-bit, we get the least significant byte
    // of every 16-bit pairing (twice)
    // do a 16-bit read for performance
	*((unsigned int*)(&buffer[0x20])) = *((volatile unsigned int*)(0x6000+0x20));
	*((unsigned int*)(&buffer[0x22])) = *((volatile unsigned int*)(0x6000+0x22));
	*((unsigned int*)(&buffer[0x24])) = *((volatile unsigned int*)(0x6000+0x24));

    // exit CFI mode
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);     // enable writes
    FLASH_WRITE(0xaa, 0xf0);
    FLASH_SETBITS(FLASH_UNRESET);                      // enable reads

    // check for the QRY string - if we found it, we were the right way around
    if ((buffer[0x20]=='Q') && (buffer[0x22]=='R') && (buffer[0x24]=='Y')) {
		printf("OK!\n");
		return;
	}
	
	// Since CE has been high for the above test, it's okay to drop it now
	
	printf("Fail\nTrying to read CFI with CE: ");
	
    // No unlock is needed - note that CFI is one of the only
    // commands that uses 0x0AA instead of 0xAAA
    FLASH_SETBITS(FLASH_WRITEMSB);     // enable writes
    FLASH_WRITE(0xaa, 0x98);           // CFI
    FLASH_SETBITS(0);                  // enable reads

    // copy defined bytes (per the datasheet)
    // since we're 8-bit, we get the least significant byte
    // of every 16-bit pairing (twice)
    // do a 16-bit read for performance
	*((unsigned int*)(&buffer[0x20])) = *((volatile unsigned int*)(0x6020));
	*((unsigned int*)(&buffer[0x22])) = *((volatile unsigned int*)(0x6022));
	*((unsigned int*)(&buffer[0x24])) = *((volatile unsigned int*)(0x6024));

    // exit CFI mode
    FLASH_SETBITS(FLASH_WRITEMSB);     // enable writes
    FLASH_WRITE(0xaa, 0xf0);
    FLASH_SETBITS(0);                  // enable reads

    // check for the QRY string - if we found it, we were the right way around
    if ((buffer[0x20]=='Q') && (buffer[0x22]=='R') && (buffer[0x24]=='Y')) {
		printf("OK!\n");
		FLASH_UNRESET = 0;
		return;
	}
	
	printf("Fail\nBoth tests failed - assuming reset pin.\n");
}

// read the CFI data from the flash, and spit some of it out
void flashReadCfi() {
    // There's lots of cool data in there, so it would be fun
    // to print as much of it makes any sense...
    bool fail = false;

//    printf("Flash CFI information:\n");

    // No unlock is needed - note that CFI is one of the only
    // commands that uses 0x0AA instead of 0xAAA
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);     // enable writes
    FLASH_WRITE(0xaa, 0x98);                           // CFI
    FLASH_SETBITS(FLASH_UNRESET);                      // enable reads

    // copy defined bytes (per the datasheet)
    // since we're 8-bit, we get the least significant byte
    // of every 16-bit pairing (twice)
    for (int idx=0; idx<0xf4; idx+=2) {
        // do a 16-bit read for performance
        *((unsigned int*)(&buffer[idx])) = *((volatile unsigned int*)(0x6000+idx));
    }

    // exit CFI mode
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);     // enable writes
    FLASH_WRITE(0xaa, 0xf0);
    FLASH_SETBITS(FLASH_UNRESET);                      // enable reads

    // check for the QRY string - if this isn't there, we may not have data
    if ((buffer[0x20]!='Q') || (buffer[0x22]!='R') || (buffer[0x24]!='Y')) {
        printf("Did NOT get QRY string: %c%c%c\n", buffer[0x20], buffer[0x22], buffer[0x24]);
        printf("Make sure the >E000 adapter/hack is\nin the cartridge slot\n");
        fail=true;
    } else {
        printf("Flash size: 2^%d bytes", (int)buffer[0x4e]);
        if (buffer[0x4e] != 0x1b) {
            printf(" [small]");
        }
        printf("\n");

        if (buffer[0x50] == 1) {
            printf("Device reports 16-bit only!\n");
        }

        printf("Vcc Min/Max: %d.%d / %d.%d V\n", (int)(buffer[0x36]>>4), (int)(buffer[0x36]&0x0f),
                                                 (int)(buffer[0x38]>>4), (int)(buffer[0x38]&0x0f));
        int x = 1;
        for (int idx = 0; idx<buffer[0x3e]; ++idx) x <<= 1;
        printf("Timeout: Word write: %d uS\n", x);
        printf("         Chip erase: 2^%d mS\n", (int)(buffer[0x44]));
    
        x = 1;
        for (int idx = 0; idx<buffer[0x54]; ++idx) x <<= 1;
        printf("Max multi-byte write size: %d bytes\n", x);
    }

    if ((buffer[0x2a] != 0x40) || (buffer[0x80] != 'P') || (buffer[0x82] != 'R') || (buffer[0x84] != 'I')) {
        printf("Did NOT get PRI or not at 0x40: %c%c%c\n", buffer[0x80], buffer[0x82], buffer[0x84]);
    } else {
        printf("CFI version 1.%d\n", (int)(buffer[0x88]&0x0f));

        printf("Process: ");
        switch((buffer[0x8a]>>2)&0x0f) {
            case 0: printf(".23um floating\n"); break;
            case 1: printf(".17us floating\n"); break;
            case 2: printf(".23um MirrorBit\n"); break;
            case 3: printf(".13um floating\n"); break;
            case 4: printf(".11um MirrorBit\n"); break;
            case 5: printf(".09um MirrorBit\n"); break;
            case 6: printf(".09um floating\n"); break;
            case 7: printf(".065um MirrorBit Ec\n"); break;
            case 8: printf(".065um MirrorBit\n"); break;
            case 9: printf("0.045um MirrorBit\n"); break;
            default: printf("unknown: %d\n", (int)((buffer[0x8a]>>2)&0x0f));
        }
        if (buffer[0x8a]&0x03) {
            printf("Unlock is not address sensitive.\n");
        }

        printf("WP# pin: ");
        switch(buffer[0x9e]) {
            case 0: printf("none\n"); break;
            case 1: printf("64kb dual boot\n"); break;
            case 2: printf("bottom boot\n"); break;
            case 3: printf("top boot\n"); break;
            case 4: printf("uniform bottom boot\n"); break;
            case 5: printf("uniform top boot\n"); break;
            case 6: printf("all sectors\n"); break;
            case 7: printf("uniform dual\n"); break;
            default: printf("unknown: %d\n", (int)(buffer[0x9e]));
        }

        // only available since CFI 1.5
        if (buffer[0x88] >= 0x35) {
            printf("Customer OTP area: 2^%d (%slocked)\n", (int)(buffer[0xa4]), (buffer[0x6]&0x40)?"":"un");
            unsigned int x = 1;
            for (int idx = 0; idx<buffer[0xa8]; ++idx) x <<= 1;
            printf("Page size = %d bytes\n", x);
        } else {
            printf("Page size not available pre 1.5\n");
        }
    }

    if (fail) {
        for (int idx=0; idx<512; ++idx) {
            if ((buffer[idx]>=' ')&&(buffer[idx]<='z')) {
                putchar(buffer[idx]); 
            } else {
                putchar(' '); 
            } 
        }
        printf("\n");
    }

}

// read the flash status register
// this doesn't work .. maybe it's not supported?
// can't make it work by hand either...
void flashReadStatus() {
    // commented out until it works...
#if 0
    // No unlock is needed
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);     // enable writes
    FLASH_WRITE(0xaaa, 0x70);                          // Status register
    FLASH_SETBITS(FLASH_UNRESET);                      // enable reads

    // the hardware layout means we can only read the LSB of the status register,
    // since we can't mask out reads (and LSB is first). Fortunately, that's the
    // byte we need!
    // Except, as noted above, it doesn't work. Maybe the TI is throwing in
    // an extra cycle that costs it...?
    // Another possibility is that it's illegal to read the LSB first, the
    // docs only mention a "transition" on the A(-1) line...
    unsigned int tmp = *((volatile unsigned int*)0x6000);

#ifdef VERIFYLATCH
    printf("Status word read: >%X%X\n", tmp>>8, tmp&0xff);
#endif

    unsigned char x = tmp&0xff;                   // we need the LSB

    if (x&0x80) {
        // device ready
        printf("Ready          : yes\n");
        printf("Erase suspend  : %s\n", (x&0x40)?"yes":"no");
        printf("Erase status   : %s\n", (x&0x20)?"fail":"ok");
        printf("Program status : %s\n", (x&0x10)?"fail":"ok");
        printf("Write Buf Abort: %s\n", (x&0x08)?"yes":"no");
        printf("Program suspend: %s\n", (x&0x04)?"yes":"no");
        printf("Sector locked  : %s\n", (x&0x04)?"yes":"no");
        printf("Continuity     : %s\n", (x&0x04)?"ok":"no");
    } else {
        // all other bits are invalid if ready is not set
        printf("Ready          : no\n");
    }

    // clear the status register by writing 0x71
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);     // enable writes
    FLASH_WRITE(0xaaa, 0x71);                          // Clear Status register
    FLASH_SETBITS(FLASH_UNRESET);                      // enable reads
#endif
}

// wait for a write operation to complete
// takes in the address to read back, and the byte value to expect
bool flashWaitForWrite(unsigned int page, unsigned int adr, unsigned char val) {
    int latch = (page&0xfff) << 1;
    unsigned char bits = (page>>12) & 0x03;
    FLASH_SETLATCH(latch, bits | FLASH_UNRESET);

    int time = 0;
    int cycles = 0;

    // only say waiting if we wait over 1 second
    //printf("Waiting...");
    
    // the toggle mechanism of the status word is defeated
    // by the multiplexer - this makes false positives tricky

    for (;;) {
        //printf(".");
        unsigned char x = FLASH_READ(adr);  // reads twice, at different addresses
        if (x == val) {
            if (time > 0) {
                printf("\n");
            }
#ifdef VERIFYLATCH
            printf("Write complete. %X=%X at %X%X\n", x, val, adr>>8,adr&0xff);
#endif
            return true;
        }
        if (x & 0x22) {
            // one more read to make sure it's not a false positive caused by transition
            // recommended by the datasheet
            x = FLASH_READ(adr);  // reads twice, at different addresses
            if (x == val) {
#ifdef VERIFYLATCH
                printf("Write complete, %X=%X at %X%X\n", x, val, adr>>8,adr&0xff);
#endif
                return true;
            }
            printf(">%X: ", x);
            if (x & 0x08) {
                printf("Erase operation reports %s\n", (x&0x02) ? "aborted":"failed");
            } else {
                printf("Write operation reports %s\n", (x&0x02) ? "aborted":"failed");
            }
            flashReadStatus();
            return false;
        }

        // this is the racy read, but it doesn't need to be accurate
        if (VDPST & VDP_ST_INT) {
            ++cycles;
            if (cycles >= 60) {
                ++time;
                cycles=0;
                printf("\rWaiting... >%X != >%X - %ds", x, val, time);
                kscanfast(0);
                if (kscan_key == ' ') {
                    printf("\n-- Aborted by keypress\n");
                    return false;
                }
            }
        }
    }
}

// this writes a 512 byte sector 256 bytes at a time through buffer[]
// Note that the old chip only allowed 32 bytes, but this one has more.
// If we had a 16-bit port, we could actually do 512 bytes, but we can't
// write a big enough word count with 8-bits! :)
// latch is the full 14 bit address, we'll do the splitting up
// page is not allowed to change through the 512 bytes, and we must
// be 256 byte aligned too.
// You should do a verify after success to make sure the data wrote correctly,
// since this can be too fast to verify in code.
// If STEPSIZE changes, the assembly loop will also need to change.
#define STEPSIZE 256
bool flashWriteFast(unsigned int page, unsigned int adr) {
    int latch = (page&0xfff) << 1;
    unsigned char bits = (page>>12) & 0x03;

    // some data is written to the /sector/ offset, which per the
    // library is a 4k boundary. Since we are working in 8k pages
    // we can happily just mask. (adr should not be larger than >1FFF)
    // The actual address used in the Spansion code is:
    // (adr & SA_OFFSET_MASK) + LLD_UNLOCK_ADDR2
    // SA_OFFSET_MASK is 0xfffff000, so 4k
    // LLD_UNLOCK_ADDR2 is 0x555, and it notes that it's added
    // only for backward compatibility, but we should match it.
//    unsigned int sa = (adr&0x1000)+0x555;
    // all that said, this doesn't work terribly well. If we assume sector
    // address means the /erase/ sector, then we need to use 128k instead of 4k
    // that means probably a separate latch, too... adr would always be zero
//      unsigned int sa = (adr&0x1000);
    // every page is 8k, so 128k is 16 pages, bits stay the same
    unsigned int sa_latch = (page&0x0ff0) << 1;

    if (adr%STEPSIZE) {
        printf("* Can't write to unaligned address: %X%X\n", (adr>>8), (adr&0xff));
        return false;
    }

#if 0
    printf("WRITING page %d, address 0x%X%X\n", page, adr>>8, adr&0xff);
#endif

    for (int off=0; off<512; off+=STEPSIZE) {
        flashUnlock();

        // This needs to go to the /sector/ address.
        FLASH_SETLATCH(sa_latch, bits | FLASH_UNRESET | FLASH_WRITEMSB);
        FLASH_WRITE(0, 0x25);        // buffer write (note sure - datasheet says sa, example says adr?)
        FLASH_WRITE(0, STEPSIZE-1);  // number of writes will follow (start with -1)

        // we can enable full 16-bit writes!!
        FLASH_SETLATCH(latch, bits | FLASH_UNRESET | FLASH_WRITEMSB | FLASH_WRITELSB);

#if 0
        // write 16-bit words to the flash. The multiplexer will do 2 8-bit writes each
        for (unsigned int idx=off; idx<off+STEPSIZE; idx+=2) {
            // FLASH_WRITE is only 8 bit, so we need a 16-bit version
            unsigned int data = *((unsigned int*)(&buffer[idx]));
            unsigned int outadr = 0xe000 + (adr+idx);
            *((volatile unsigned int*)(outadr)) = data;
#ifdef VERIFYLATCH
            printf("%s - write >%X%X = >%X%X\r", __FUNCTION__, outadr>>8, outadr&0xff, data>>8, data&0xff);
#endif
        }
#else
		// use the scratchpad version
		flashWriteFastLoop(off, adr);
#endif

        // this should be the right place to write the start command to...
        FLASH_SETLATCH(sa_latch, bits | FLASH_UNRESET | FLASH_WRITEMSB);
        FLASH_WRITE(0, 0x29);        // start the process (datasheet says sa, example says adr)

        // expected time is 512uS to 2048uS
        // Watch out - on hardware LSB is first, MSB is second. This does seem to work!
        // Spansion polls by checking the status register instead....
        if (!flashWaitForWrite(page, adr+off+STEPSIZE-2, buffer[off+STEPSIZE-2])) {
            return false;
        }
    }

    return true;
}

// this writes a 512 byte sector 1 byte at a time through buffer[]
// this is here because I've tested it manually and know the concept works,
// but it's going to be quite slow compared to the fast write, and will
// also screw up the newer chip's built-in ECC, so we want the other one
// to work in the end.
// This is pretty reliable, since whether it started or not, a match is a match.
bool flashWriteSlow(unsigned int page, unsigned int adr) {
    int latch = (page&0xfff) << 1;
    unsigned char bits = (page>>12) & 0x03;

    printf("Writing page 0x%d, address 0x%X%X\n", page, adr>>8, adr&0xff);

    for (int off=0; off<512; off++, adr++) {
        flashUnlock();

        // send the command
        FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);
        FLASH_WRITE(0xaaa, 0xa0);        // single word (byte) write

        // write the data
        if (adr & 1) {
            FLASH_SETLATCH(latch, bits | FLASH_UNRESET | FLASH_WRITELSB);
        } else {
            FLASH_SETLATCH(latch, bits | FLASH_UNRESET | FLASH_WRITEMSB);
        }
        FLASH_WRITE(adr, buffer[off]);

        // TODO: do we need to wait? the program time ranges from
        // 256uS to 2048uS.. on the TI 256uS is about 80 instructions.
        if (!flashWaitForWrite(page, adr, buffer[off])) {
            return false;
        }
    }

    return true;
}

// verify the sector against the buffer
bool flashVerify(unsigned int page, unsigned int adr) {
    int latch = (page&0xfff) << 1;
    unsigned char bits = (page>>12) & 0x03;
    bool ret = true;

#ifdef VERIFYLATCH
    printf("Verifying page 0x%d, address 0x%X%X\n", page, adr>>8, adr&0xff);
#endif

    // read back the correct page
    FLASH_SETLATCH(latch, bits | FLASH_UNRESET);

#if 0
    // validate against the buffer
    for (int off=0; off<512; off+=2, adr+=2) {
        // FLASH_WRITE is only 8 bit, so we need a 16-bit version
        unsigned int data = *((unsigned int*)(&buffer[off]));
        unsigned int inadr = 0x6000 + adr;
        unsigned int cart = *((volatile unsigned int*)(inadr));
        if (cart != data) {
            printf("V: Page %d >%X%X, cart >%X%X != >%X%X\n", page, inadr>>8,inadr&0xff, cart>>8,cart&0xff, data>>8,data&0xff);
            ret = false;
            break;
        }
    }
    return ret;
#else
	// scratchpad version
	if (!flashVerifyLoop(adr)) {
		// addresses in GPLWS are already incremented by 2, so subtract that out
		unsigned int inadr = (*((unsigned int*)0x83e0)) - 0x8002;	// gplws r0 (E000 to 6000), minus the two
        unsigned int cart = *((volatile unsigned int*)(inadr));
		unsigned int bufadr = (*((unsigned int*)0x8302)) - 2;		// pointer into the buffer array
        unsigned int data = *((volatile unsigned int*)(bufadr));
		printf("V: Page %d >%X%X, cart >%X%X != >%X%X\n", page, inadr>>8,inadr&0xff, cart>>8,cart&0xff, data>>8,data&0xff);
		return false;
	}
	return true;
#endif
}

// erase a single sector
// erase sectors are 128k in size, so must be aligned. Thus, we take in
// a page index only (pages are 8k each), since the adr must be 0
bool flashSectorErase(unsigned int page) {
    int latch = (page&0xfff) << 1;
    unsigned char bits = (page>>12) & 0x03;

    if (page % 16) {
        printf("Sector erase page %d is not 128k aligned\n", page);
        return false;
    }

    printf("Erasing sector %d\n", page);

    // send the command
    flashUnlock();
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);
    FLASH_WRITE(0xaaa, 0x80);      // first step

    flashUnlock();
    FLASH_SETLATCH(latch, bits | FLASH_UNRESET | FLASH_WRITEMSB);
    FLASH_WRITE(0, 0x30);          // start erase

    if (!flashWaitForWrite(page, 0, 0xff)) {
        return false;
    }

    // it's very possible for that byte to already be 0xff and for the
    // operation to not even start, so do a quick validate of the sector
    // This is a workaround for not having the status register working
    // Note there's 128k worth of verify needed
    printf("Verifying...");
    memset(buffer, 0xff, 512);
    unsigned int offset = 0;
    for (int idx=0; idx<256; ++idx) {   // 128KB / 512 bytes
        if (!flashVerify(page, offset)) {
            printf("Failed\n");
            printf("Index %d on page %d is not erased.\n", idx, page);
            return false;
        }
        offset+=512;
        if (offset >= 0x2000) {
            offset = 0;
            ++page;
        }
    }
    printf("OK!\n");
}

// erase the entire chip -- yeah, want to be careful with this one
bool flashChipErase() {

    printf("Resetting flash chip...\n");

    // we don't need any other delay - the printfs are more
    // than slow enough to give the chip enough time
    printf("Erasing flash chip...\n");

    flashUnlock();
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);
    FLASH_WRITE(0xaaa, 0x80);      // first step
    
    flashUnlock();
    FLASH_SETBITS(FLASH_UNRESET | FLASH_WRITEMSB);
    FLASH_WRITE(0xaaa, 0x10);      // second step, operation starts

    // unlike all the other options, we know this does not finish immediately
    // so, just do a quick check if it actually started
    // This is a workaround for not having the status register working
    // Let's also not check the locked sector, we'll read further in
    FLASH_SETLATCH(0x20, FLASH_UNRESET);
    unsigned char x = FLASH_READ(0);
    if (x == 0xff) {
        // 0xff is the data we want, so anything else flashWaitForWrite can cope with
        printf("Erase failed to start, failing.\n");
        return false;
    } else {
        printf("Status >%X - assuming erase start.\n", x);
    }

    // this takes over ten minutes!
    if (!flashWaitForWrite(16, 0, 0xff)) {
        return false;
    }

    printf("Erase completed\n");
    return true;
}

// runs the same checksum that Dragon's Lair runs to see whether it
// will pass, and provide details if it doesn't
bool flashChecksum() {
	bool ret = true;
	
	printf("Running checksum...\n");
	
	// this is just to make the normal load come out of reset,
	// by setting a GROM address of 0x8000
	*((volatile unsigned char*)(0x9c02))=0x80;
	*((volatile unsigned char*)(0x9c02))=0x00;
	
	// we are running from RAM, so we don't need the scratchpad code
	// Since I'm using scratchpad for programming, I don't want to
	// add more there.
	// start past the 128k seahorse flaw
	for (unsigned int page = 16; page<0x4000; ++page) {
		unsigned int sum = page;
		int latch = (page&0xfff) << 1;
		unsigned char bits = (page>>12) & 0x03;
		
		// set page to read
		FLASH_SETLATCH(latch, bits | FLASH_UNRESET);
		
		// for the checksum - 256 bytes only
		for (int idx=0x6000; idx<0x6100; idx+=2) {
			sum += *((volatile unsigned int*)(idx));
		}

		// compare against stored value
		if (sum != *((volatile unsigned int*)(0x7ffe)) ) {
			unsigned int data = *((volatile unsigned int*)(0x7ffe));
			printf("Checksum fail, page %d. Sum %X%X != %X%X\n",
				page, sum>>8, sum&0xff, data>>8, data&0xff);
			ret = false;
		}
	}
			
	return ret;
}

//////////////////////////
// CF7 functions
//////////////////////////

// seem to need a long (seconds?) delay after this...?
// this will blow away 8-bit mode
void cf7Reset() {
    volatile int idx;

    CF7_CRU_ON;

        CF7_WRITE(CF7_CONTROL) = 0x04;      // reset on
        for (idx=0; idx<500; ++idx) {
            idx = idx;                      // waste some time
        }
        CF7_WRITE(CF7_CONTROL) = 0;         // reset off

    CF7_CRU_OFF;
}

void cf7Init() { 
    CF7_CRU_ON;

        CF7_WRITE(CF7_FEATURES) = 0x01;         // 8-bit mode (0x81 is disable 8-bit mode)
        CF7_WRITE(CF7_SECTOR_CNT) = 0;          // no config
        CF7_WRITE(CF7_CARD_HEAD) = 0;           // drive zero
        CF7_WRITE(CF7_COMMAND) = 0xef;          // set features

    CF7_CRU_OFF;
}

// need to track a 28-bit address
// CRU must /already/ be on, this function doesn't do it for performance reasons
void cf7SetAddress(unsigned int high, unsigned int low) {
    CF7_WRITE(CF7_CARD_HEAD)    = 0xe0 + ((high>>8)&0x0f);    // LBA mode on drive 1, plus 4 bits of address
    CF7_WRITE(CF7_CYL_HIGH)     = high&0xff;                  // next 8 bits of address
    CF7_WRITE(CF7_CYL_LOW)      = low>>8;                     // next 8 bits of address
    CF7_WRITE(CF7_SECTOR_NO)    = low&0xff;                   // last 8 bits of address
    CF7_WRITE(CF7_SECTOR_CNT)   = 1;                          // we always work on just 1 sector at a time
}

// reads the card error through Request Sense
void cf7CardError() {

    CF7_CRU_ON;
        CF7_WRITE(CF7_COMMAND) = 0x03;      // request sense - data returns in the error register
        int err = CF7_READ(CF7_ERROR);      // get the code
        
        if (!cf7WaitForReady()) {
            CF7_CRU_OFF;
            return;
        }

        printf("Error: ");
        switch (err) {
            case 0:     printf("No error\n"); break;
            case 1:     printf("Self test OK\n"); break;
            case 9:     printf("Miscellaneous error\n"); break;
            case 0x20:  printf("Invalid command\n"); break;
            case 0x21:  printf("Invalid address\n"); break;
            case 0x2f:  printf("Address overflow\n"); break;
            case 0x35:
            case 0x36:  printf("Voltage out of tolerance\n"); break;
            case 0x11:  printf("Uncorrectable ECC\n"); break;
            case 0x18:  printf("Corrected ECC\n"); break;
            case 0x05:
            case 0x30:
            case 0x31:
            case 0x32:
            case 0x33:
            case 0x34:
            case 0x37:
            case 0x3e:  printf("Diagnostic failed.\n"); break;
            case 0x10:
            case 0x14:  printf("ID not found\n"); break;
            case 0x3a:  printf("Spare sectors exhausted.\n"); break;
            case 0x1f:  printf("Data transfer aborted\n"); break;
            case 0x0c:
            case 0x38:
            case 0x3b:
            case 0x3c:
            case 0x3f:  printf("Corrupted media\n"); break;
            case 0x03:  printf("Write/erase failed.\n"); break;
            default: printf("Unknown (0x%X)\n", (unsigned char)(err&0xff));
        }

    CF7_CRU_OFF;
}

// this should normally be very fast, unless something is wrong
// so again, CRU must /already/ be on
bool cf7WaitForReady() {
    int cnt = 0;
    for (;;) {
        unsigned char x = CF7_READ(CF7_STATUS);
        if (!(x&0x80)) {    // busy bit
            if (x&0x50) {
                if ((x&0x50) != 0x50) {
                    printf("RDY=%d, DSC=%d\n", (int)(x&40), (int)(x&010));
                } else {
#ifdef VERIFYLATCH
                    if (x&0x04) {
                        printf("Warning: ECC reported\n");
                    }
#endif
                    return true;
                }
            }
            if (x&0x20) {
                printf("* CF Write fault\n");
                cf7CardError();
                return false;
            }
            if (x&0x01) {
                printf(" * CF error occurred\n");
                cf7CardError();
                return false;
            }
        }
        if (++cnt >= 100) {
            cnt = 0;
            kscanfast(0);
            if (kscan_key == ' ') {
                printf("\n-- CF aborted by keypress\n");
                return false;
            }
        }
    }
}

void cf7IdentifyDevice() {
    CF7_CRU_ON;

        if (!cf7WaitForReady()) {
            CF7_CRU_OFF;
            return;
        }

        CF7_WRITE(CF7_COMMAND) = 0xec;      // identify device

        if (!cf7WaitForReady()) {
            CF7_CRU_OFF;
            return;
        }

        if (!(CF7_READ(CF7_STATUS) & 0x08)) {
            CF7_CRU_OFF;
            printf("No data!\n");
            return;
        }

        // the data comes in 16-bit swapped (only for this, normal reads and writes are fine)
        for (int off=0; off<512; off+=2) {
            buffer[off+1] = CF7_READ(CF7_DATA);
            buffer[off] = CF7_READ(CF7_DATA);
        }

    CF7_CRU_OFF;

    // now parse the useful data...
    // I don't think these are coming from the right places...
    printf("CF Size : 0x%X%X%X%X sectors\n", buffer[14], buffer[15], buffer[16], buffer[17]);
    // these next two have the opposite word order to the first one... weird (but confirmed).
    printf("Capacity: 0x%X%X%X%X sectors\n", buffer[116], buffer[117], buffer[114], buffer[115]);
    printf("LBA     : 0x%X%X%X%X sectors\n", buffer[122], buffer[123], buffer[120], buffer[121]);
    printf("Serial: ");
        for (int idx=20; idx<40; ++idx) { putchar(buffer[idx]); }
        putchar('\n');
    printf("Model: ");
        // note: there are really 40 bytes available here, only reading 32
        for (int idx=46; idx<76; ++idx) { putchar(buffer[idx]); }
        putchar('\n');

#ifdef VERIFYLATCH
    // dump what we read
    for (int idx=0; idx<512; ++idx) {
        if ((buffer[idx]>=' ')&&(buffer[idx]<='z')) {
            putchar(buffer[idx]); 
        } else {
            putchar(' '); 
        } 
    }
    printf("\n");
#endif

}

bool cf7ReadSector(unsigned int high, unsigned int low) {
    volatile int idx = 0;

    CF7_CRU_ON;

        cf7SetAddress(high, low);
        
        if (!cf7WaitForReady()) {
            CF7_CRU_OFF;
            return false;
        }
#if 0
        printf("CF reading 0x%X%X%X%X - ", high>>8, high&0xff, low>>8, low&0xff);
#endif
        CF7_WRITE(CF7_COMMAND) = 0x20;      // read sector

        // we must wait 400uS before checking status...
        // average instruction is 14 cycles or 4us (8-bit memory)
        // Hmm. Datasheet says 400nS... maybe the ref online was a typo?
//        for (idx = 0; idx<100; ++idx) { }   // waste time

        if (!cf7WaitForReady()) {
            CF7_CRU_OFF;
            return false;
        }

        if (!(CF7_READ(CF7_STATUS) & 0x08)) {
            CF7_CRU_OFF;
            printf("No data!\n");
            return false;
        }

#if 0
        for (int off=0; off<512; ++off) {
            buffer[off] = CF7_READ(CF7_DATA);
        }
#else
		// run the scratchpad inline version
		cf7ReadSectorLoop();
#endif


    CF7_CRU_OFF;

    return true;
}

// I don't really need a write, but might as well have it somewhere - can
// throw it into libti99 later...
// don't need to swap the buffer for writes...
bool cf7WriteSector(unsigned int high, unsigned int low) {
    volatile int idx = 0;

    CF7_CRU_ON;

        cf7SetAddress(high, low);

        if (!cf7WaitForReady()) {
            CF7_CRU_OFF;
            return false;
        }

        printf("CF writing 0x%X%X%X%X - ", high>>8, high&0xff, low>>8, low&0xff);
        CF7_WRITE(CF7_COMMAND) = 0x30;      // write sector

        // we must wait 400uS before checking status...
        // average instruction is 14 cycles or 4us (8-bit memory)
        // Hmm. Datasheet says 400nS... maybe the ref online was a typo?
        for (idx = 0; idx<100; ++idx) { }   // waste time

        if (!cf7WaitForReady()) {
            CF7_CRU_OFF;
            return false;
        }

        if (!(CF7_READ(CF7_STATUS) & 0x08)) {
            CF7_CRU_OFF;
            printf("No data!\n");
            return false;
        }

        printf(".");
        for (int off=0; off<512; ++off) {
            CF7_WRITE(CF7_DATA) = buffer[off];
        }
        printf("..");

        if (!cf7WaitForReady()) {
            CF7_CRU_OFF;
            return false;
        }

        printf("OK!\n");

    CF7_CRU_OFF;

    return true;
}

// scan DSR ROMs at >1100 and >1000 to see which has the CF7
void cf7DetectClassic99() {
    REAL_CF7_CRU_ON;
        for (int idx=0; idx<256; ++idx) {
            if (0 == memcmp((char*)(0x4000+idx), "CF7+",4)) {
                REAL_CF7_CRU_OFF;
                CF7Classic99 = false;
                return;
            }
        }
    REAL_CF7_CRU_OFF;

    CLASSIC99_CRU_ON;
        for (int idx=0; idx<256; ++idx) {
            if (0 == memcmp((char*)(0x4000+idx), "CF7+",4)) {
                CLASSIC99_CRU_OFF;
                CF7Classic99 = true;
                printf("CF7 detected on Classic99 base >1000\n");
                return;
            }
        }
    CLASSIC99_CRU_OFF;

    printf("CF7 not detected at >1100 or >1000\n");
}

//////////////////////////
// test function
//////////////////////////
int testapp() {
    int cflow=1598, cfhigh=0;

    // a little test menu for now....
    for (int idx=0; idx<512; ++idx) {
        buffer[idx]=(idx&0xff);
    }
    for (;;) {
        int loop = 1;
        printf("\nPress:\n");
        printf("  C to read flash CFI\n");
        printf("  F to test flash fast write\n");
        printf("  S to test flash slow write\n");
        printf("  X to test sector erase\n");
        printf("  E to test flash erase\n");
        printf("  K to run post-program checksum\n");
        printf("  I for flash status info (broken)\n");
        printf("  T to toggle flash select lines\n");
        printf("  R to put flash in reset\n");
        printf("\n  1 to reset CF7\n");
        printf("  2 to read CF info\n");
        printf("  3 to read CF7\n");
        printf("  4 to write CF7 (destructive!)\n");
        printf("  5 to check CF card error\n");
        printf("\n  Q to quit\n");
        while (loop) {
            kscanfast(0);
            switch (kscan_key) {
                case 'Q':   return 0;
                
                case 'C':   flashReadCfi(); 
                            loop=0; 
                            break;

                case 'K':   flashChecksum();
                            loop=0; 
                            break;

#if 0
                case 'T':   printf("Space to exit...\n");
                            flashToggle();
                            loop = 0;
                            break;
#endif

                case 'F':   printf("Fast: Page 16, address 512\n"); 
                            for (int idx=0; idx<512; ++idx) {
                                buffer[idx]=(idx&0xff);
                            }
                            if (flashWriteFast(16,512)) {
                                printf("OK!\n"); 
                                if (!flashVerify(16,512)) {
                                    printf("Verify failed!\n");
                                }
                            } else {
                                printf("Failed!\n");
                            }
                            loop=0; 
                            break;

                case 'S':   printf("Slow: Page 16, address 1024\n"); 
                            for (int idx=0; idx<512; ++idx) {
                                buffer[idx]=(idx&0xff);
                            }
                            if (flashWriteSlow(16,1024)) {
                                printf("OK!\n");
                                if (!flashVerify(16,1024)) {
                                    printf("Verify failed!\n");
                                }
                            } else {
                                printf("Failed!\n"); 
                            }
                            loop=0; 
                            break;

                case 'X':   if (!flashSectorErase(16)) {
                                printf("Failed!\n"); 
                            }   
                            loop=0; 
                            break;

                case 'E':   if (!flashChipErase()) {
                                printf("Failed!\n");
                            }
                            loop=0; 
                            break;

                case 'I':   flashReadStatus(); 
                            loop=0; 
                            break;

                case 'R':   flashReset(); 
                            loop=0; 
                            break;

                case '1':   cf7Init(); 
                            loop=0; 
                            break;

                case '2':   cf7IdentifyDevice(); 
                            loop=0; 
                            break;

                case '3':   if (cf7ReadSector(cfhigh, cflow)) {
                                for (int idx=0; idx<512; ++idx) {
									vdpchar(nTextPos, buffer[idx]);
									nTextPos++;
									if (nTextPos > nTextEnd) {
										scrn_scroll();
										nTextPos = nTextRow;
									}
                                }
                                printf("\n");
                            } else {
                                printf("Failed!\n"); 
                            }
                            ++cflow; 
                            if (cflow == 0) ++cfhigh; 
                            loop=0; 
                            break;

                case '4':   for (int idx=0; idx<512; ++idx) {
                                buffer[idx]=(idx&0xff);
                            }
                            strcpy(buffer,"Mike was here");
                            if (cf7WriteSector(0, 5)) {
                                printf("OK!\n");
                            } else {
                                printf("Failed!\n"); 
                            }
                            loop=0; 
                            break;

                case '5':   cf7CardError(); 
                            loop=0; 
                            break;
            }
        }
        printf("Press a key...\n");
        kscan_key=0xff;
        while (kscan_key == 0xff) { kscanfast(0); }
    }

	return 0;
}

//////////////////////////
// actual programming code
//////////////////////////
bool program() {
    // the purpose of this code is to write the contents of a compact flash card
    // holding a 128MB image to the flash cartridge as described in the header
    // block. Minimal diagnostic is performed.

    // Format of the flash chip:
    // 128MB, however, due to a hardware error on the seahorse board, the first
    // 128KB is write-protected. (WP# is tied low instead of high or floating.)
    // So, we can't write to the first 128KB and must skip it to avoid errors.
    // The macro FLASH_FIRSTPAGE contain the data for the latching page so we
    // can easily update it in the future. We must write the entire remaining
    // space, particularly because the top 256 bytes contain the game's boot code.

    // Format of the Compact Flash card:
    // Formatted for use with the CF7/NanoPEB, this card is also how we load the
    // software and the CF7 is where we get memory expansion to run in.
    // Thus, the first 800KB of the card is reserved for the first disk image.
    // (We don't need the whole thing, but skipping it should reduce conflicts
    // with TI99Dir when we need to update the disk image.)
    // It's 800k, not 400k, because the CF7 skips every other byte, so everything
    // is twice as big as it should be. (Ok, not %$#%# TI99Dir, it's %$##%$ CF7...)
    // So this means that the first CF sector is number 1600. then we skip the
    // flash error, giving a first sector in the macro CF7_FIRSTSECTOR.
    // The last sector is given as CF7_LASTSECTOR, since the counting is much easier there.

    // some tracking variables
    unsigned int flashAdr = 0;      // 8k of cart space
    unsigned int flashPage = FLASH_FIRSTPAGE;
    unsigned int CF7High = 0;       // we know the start is less than 65,536 sectors in (also 32MB)
    unsigned int CF7Low = CF7_FIRSTSECTOR;
    bool ret = true;
    
    // undoubtedly I need this only because I'm not sending some exit command...
    flashSoftResetAll();

    // most chips should not need to erase..?? so even though testing
    // for this will take a while, it should be faster than the 10+
    // minutes that an actual erase takes
    // It's not, for some reason, and I could speed it up, but damn it,
    // I'm almost done now. Just live with it. It takes 90 minutes to
    // program anyway.
#if 0
    printf("Checking if erase is needed...\n");
    {
        unsigned int flashBits = 0;     // we know the start is less than 32MB
        unsigned int flashLatch = FLASH_FIRSTPAGE*2;    // we know this is small enough to work
        ret = true;
        for (;;) {
            FLASH_SETLATCH(flashLatch, flashBits | FLASH_UNRESET);

            // read 16-bits at a time for the whole page
            for (int adr = 0; adr < 0x2000; adr+=2) {
                unsigned int inadr = 0x6000 + adr;
                unsigned int cart = *((unsigned int*)(inadr));
                if (cart != 0xffff) {
					printf("latch >%X, adr >%X%X, read >%X%X != >FFFF", flashLatch, inadr>>8, inadr&0xff, cart>>8,cart&0xff);
                    ret = false;
                    break;
                }
            }
            if (!ret) break;

            // increment latch
            flashLatch+=2;
            if (flashLatch >= 0x2000) {
                flashLatch=0;
                ++flashBits;
                if (flashBits > 3) {
                    break;
                }
                // report every 25%
                printf("%d%%...", flashBits*25);
            }
        }
    }
    printf("\n");

    if (!ret) {
        printf("Yes, ");
        if (!flashChipErase()) {
            return false;
        }
    }
#else
	if (!flashChipErase()) {
		return false;
	}
#endif

    // reset the flags and the flash
    ret = true;         // reset the flag
    printf("Programming...\n");
    vdpmemset(gImage, ' ', 40); // clear top row for bargraph

    // variables to make the bargraph easier
    int stepcnt = 0;
    int stepcol = 0;
    int stepchar = 0;
    int mancnt = 0;
    int manchar = 0;

    // lazy loop
    for (;;) {
        // emit some kind of progress indicator (top row?)
        // how do we convert 128MB into 40 characters?
        // We have 262144 sectors of 512 bytes each... 
        // (minus the initial 256 sectors that we skip)
        // 262144 sectors / 40 is 6553 sectors per screen position
        // Or if we do a pixel progress bar, that's 240 pixels (text mode)
        // which is 1092 steps per pixel.
        ++stepcnt;                  // count one
        if (stepcnt >= 1092) {      // roll-over
            stepcnt = 0;            
            ++stepchar;             // increment bar graph pixel
            if (stepchar >= 6) {    // roll-over
                stepchar = 0;
                ++stepcol;          // increment screen position
            }
            // clear the top row, just in case
            vdpmemset(gImage, ' ', 40);
            if (stepcol > 0) {
                // solid part of the bar
                vdpmemset(gImage, 128+5, stepcol);
            }
            vdpchar(gImage+stepcol, 128+stepchar);
        }
        // this little man adds 10-20 seconds to the total count
        // (of almost 4 hours). Worth it.
        if (stepcol < 39) {
			++mancnt;
			if (mancnt >= 8) {
				mancnt = 0;
				++manchar;
				if (manchar > 3) {
					manchar = 0;
				}
				vdpchar(gImage+stepcol+1, 134+manchar);
			}
		}

        // first, read the CF data into the buffer
        if (!cf7ReadSector(CF7High, CF7Low)) {
            ret = false;
            break;
        }

        // then, write it to the flash
        if (!flashWriteFast(flashPage, flashAdr)) {
            ret = false;
            break;
        }

        // then, verify the flash
        if (!flashVerify(flashPage, flashAdr)) {
            ret = false;
            break;
        }

        // increment the counters
        flashAdr += 512;
        if (flashAdr >= 0x2000) {
            flashAdr = 0;
            ++flashPage;
        }
        ++CF7Low;
        if (CF7Low == 0) {
            // wrapped around
            ++CF7High;
        }

        // stop if finished
        if (((CF7High > CF7_LASTSECTOR_HIGH)) ||
            ((CF7High == CF7_LASTSECTOR_HIGH) && (CF7Low > CF7_LASTSECTOR_LOW))) {
            break;
        }
    }

    if (ret) {
		// not checking the return code here - it'll be visible on the screen
		// I'm not sure the checksum wasn't broken somehow by the code move...
		flashChecksum();
        printf("\n\n** DONE **\n");
    } else {
        // print the failure location
        // start by subtracting the offset
        if (CF7_FIRSTSECTOR > CF7Low) {
            // need to borrow ;)
            --CF7High;
            CF7Low = CF7Low-CF7_FIRSTSECTOR+65536;
        } else {
            CF7Low -= CF7_FIRSTSECTOR;
        }
        printf("\nFailed at CF Sector >%X%X%X%X\n", CF7High>>8, CF7High&0xff, CF7Low>>8, CF7Low&0xff);
    }

    return ret;
}

//////////////////////////
// main function
//////////////////////////

// a 6 pixel wide bargraph
const unsigned char bargraph[] = {
    0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 128
    0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 
    0xe0, 0xe0, 0xe0, 0xe0, 0xe0, 0xe0, 0xe0, 0xe0, 
    0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 
    0xf8, 0xf8, 0xf8, 0xf8, 0xf8, 0xf8, 0xf8, 0xf8, 
    0xfc, 0xfc, 0xfc, 0xfc, 0xfc, 0xfc, 0xfc, 0xfc,

// running man for the bargraph (cause it moves very slowly)
// copied from HeroX, in turn from AtariAge
	0x0c,0x0c,0x18,0x18,0x1c,0x18,0x38,0x08,	// 134
	0x0c,0x0c,0x18,0x18,0x18,0x18,0x18,0x10,
	0x0c,0x0c,0x18,0x38,0x3c,0x1c,0x24,0x20,
	0x0c,0x0c,0x38,0x5e,0x18,0x24,0x44,0x04
};

// chars for the first digit (3x5)
const unsigned char fonts1[] = {
	0x40,0xa0,0xa0,0xa0,0x40,	// 0
	0x40,0x40,0x40,0x40,0x40,	// 1
	0xe0,0x20,0xe0,0x80,0xe0,	// 2
	0xe0,0x20,0xe0,0x20,0xe0,	// 3
	0xa0,0xa0,0xe0,0x20,0x20,	// 4
	0xe0,0x80,0xe0,0x20,0xe0,	// 5
	0x40,0x80,0xe0,0xa0,0xe0,	// 6
	0xe0,0x20,0x40,0x40,0x40,	// 7
	0xe0,0xa0,0x40,0xa0,0xe0,	// 8
	0xe0,0xa0,0xe0,0x20,0x40,	// 9
	0xe0,0xa0,0xe0,0xa0,0xa0,	// A
	0xe0,0xa0,0xc0,0xa0,0xe0,	// B
	0x40,0xa0,0x80,0xa0,0x40,	// C
	0xc0,0xa0,0xa0,0xa0,0xc0,	// D
	0xe0,0x80,0xc0,0x80,0xe0,	// E
	0xe0,0x80,0xc0,0x80,0x80	// F
};

int main() {
	// init the screen
	{
		int x;
        x = set_text_raw();
        clrscr();
        setupScratchpad();
		
		// build a control character font - data has 3x5 for chars 0-F
		// 3 rows of as-is, 2 rows of overlap, and 3 rows right shifted 3
		for (int ch=0; ch<256; ++ch) {
			int off = gPattern + ch*8;
			const unsigned char* pat1 = ((ch>>4)*5)+fonts1;
			const unsigned char* pat2 = ((ch&0xf)*5)+fonts1;
			vdpchar(off++, *(pat1++));
			vdpchar(off++, *(pat1++));
			vdpchar(off++, *(pat1++));
			vdpchar(off++, (*(pat1++))|((*(pat2++))>>3));
			vdpchar(off++, (*(pat1++))|((*(pat2++))>>3));
			vdpchar(off++, ((*(pat2++))>>3));
			vdpchar(off++, ((*(pat2++))>>3));
			vdpchar(off++, ((*(pat2++))>>3));
		}
		// now load the program character set
		charsetlc();
        vdpmemcpy(gPattern+(128*8), bargraph, 8*10); // 6 bargraph + 4 man characters starting at 128
		
		// turn on the screen
		VDP_SET_REGISTER(VDP_REG_MODE1, x);
		VDP_REG1_KSCAN_MIRROR = x;
		VDP_SET_REGISTER(VDP_REG_COL, 0x17);
        scrn_scroll = my_fast_scrn_scroll;
	}
	
	// print banner (will be erased by programming bar)
	vdpmemcpy(0, "CF7 to Seahorse board programmer", 32);

    // figure out which system we're running on
    cf7DetectClassic99();
	flashDetectReset();

bigloop:
    flashReset();
    cf7Init();

    // dump information about the attached devices
    flashReadCfi();
    printf("\n");
    cf7IdentifyDevice();

    // now wait for the user to tell us to proceed
    printf("Press 'T' for test or 'P' to proceed.\n");
    printf("Press 'Q' to quit.\n");

    int loop = 1;
    while (loop) {
        kscanfast(0);
        switch (kscan_key) {
            case 'T':   
                testapp(); 
                goto bigloop;

            case 'Q':   loop = 0; break;
            case 'P': 
                // going to attempt letting this loop...
                program(); 
                printf("Press any key...\n");
                do {
                    kscanfast(0);
                } while (kscan_key==0xff);
                goto bigloop;       // I'm soooooo evil... ;)
                break;
        }
    }

    // exit app
    return 0;
}
