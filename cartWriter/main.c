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

// uses libti99
#include "vdp.h"
#include "kscan.h"
#include "string.h"

#ifndef bool
#define bool int
#define false 0
#define true 1
#endif
#ifndef NULL
#define NULL 0
#endif

// forward declarations
void flashReset() ;
void flashUnlock() ;
void flashReadCfi() ;
bool flashWaitForWrite(unsigned int page, unsigned int adr, unsigned char val) ;
bool flashWriteFast(unsigned int page, unsigned int adr) ;
bool flashWriteSlow(unsigned int page, unsigned int adr) ;
bool flashSectorErase(unsigned int page) ;
bool flashChipErase() ;

// classic99 puts the CF7 at >1000 instead of >1100
//#define CLASSIC99
#ifdef CLASSIC99
#define CF7_CRU_ON __asm__( "li r12,>1000\n\tsbo 0" : : : "r12" );
#define CF7_CRU_OFF __asm__( "li r12,>1000\n\tsbz 0" : : : "r12" );
#else
#define CF7_CRU_ON __asm__( "li r12,>1100\n\tsbo 0" : : : "r12" );
#define CF7_CRU_OFF __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );
#endif

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

// write to this to set the control bits on the flash (note you write ALL of them!)
#define FLASH_SETBITS *((volatile unsigned char*)0x6000)
// or this one is you need a non-zero latch
#define FLASH_SETLATCH(xx) *((volatile unsigned char*)(0x6000+(xx)))
// and read from this for data
#define FLASH_READ(xx) *((volatile unsigned char*)(0x6000+(xx)))

// these are the bitflags
#define FLASH_WRITELSB 0x04
#define FLASH_WRITEMSB 0x08
#define FLASH_UNRESET  0x10

// write to this one to write data to the flash (within 8k, of course, and based on the bits)
#define FLASH_WRITE(xx) *((volatile unsigned char*)(0xE000+(xx)))

// the offset is 128k, which is 16 (8k) pages. Latches are every 2 addresses.
#define FLASH_SKIPOFFSET (128*1024)
// since we're only 16-bit, we track the latch explicitly
#define FLASH_FIRSTLATCH (((SKIPOFFSET)/(8*1024)*2)+0x6000)

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
// Flash functions
//////////////////////////

// does the reset. Release reset by setting the latch bits
void flashReset() {
    FLASH_SETBITS = 0;
}

// unlock sequence required for most operations
void flashUnlock() {
    FLASH_SETBITS = FLASH_UNRESET | FLASH_WRITEMSB;     // enable writes
    FLASH_WRITE(0xaa) = 0xaa;                           // unlock step 1
    FLASH_WRITE(0x554)= 0x55;                           // unlock step 2
}

// read the CFI data from the flash, and spit some of it out
void flashReadCfi() {
    // There's lots of cool data in there, so it would be fun
    // to print as much of it makes any sense...
    bool fail = false;

    printf("Flash CFI information:\n");

    // No unlock is needed
    FLASH_SETBITS = FLASH_UNRESET | FLASH_WRITEMSB;     // enable writes
    FLASH_WRITE(0xaa) = 0x98;                           // CFI
    FLASH_SETBITS = FLASH_UNRESET;                      // enable reads

    // copy 256 bytes (they won't all be useful)
    // since we're 8-bit, we get the least significant byte
    // of every 16-bit pairing (twice)
    for (int idx=0; idx<256; ++idx) {
        buffer[idx] = FLASH_READ(idx);
    }

    // exit CFI mode
    FLASH_SETBITS = FLASH_UNRESET | FLASH_WRITEMSB;     // enable writes
    FLASH_WRITE(0xaa) = 0xf0;
    FLASH_SETBITS = FLASH_UNRESET;                      // enable reads

    // check for the QRY string - if this isn't there, we may not have data
    if ((buffer[0x20]!='Q') || (buffer[0x22]!='R') || (buffer[0x24]!='Y')) {
        printf("Did NOT get QRY string: %c%c%c\n", buffer[0x20], buffer[0x22], buffer[0x24]);
        fail=true;
    }
    printf("Device size: 2^%d bytes", (int)buffer[0x4e]);
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

    if ((buffer[0x2a] != 0x40) || (buffer[0x80] != 'P') || (buffer[0x82] != 'R') || (buffer[0x84] != 'I')) {
        printf("Did NOT get PRI or not at 0x40: %c%c%c\n", buffer[0x80], buffer[0x82], buffer[0x84]);
    }

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
        x = 1;
        for (int idx = 0; idx<buffer[0xa8]; ++idx) x <<= 1;
        printf("Page size = %d bytes\n", x);
    } else {
        printf("Page size not available pre 1.5\n");
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

// wait for a write operation to complete
// takes in the address to read back, and the byte value to expect
bool flashWaitForWrite(unsigned int page, unsigned int adr, unsigned char val) {
    int latch = (page&0xfff) << 1;
    unsigned char bits = (page>>12) & 0x03;
    FLASH_SETLATCH(latch) = bits | FLASH_UNRESET;

    int time = 0;
    int cycles = 0;

    printf("Waiting...");

    for (;;) {
        unsigned char x = FLASH_READ(adr);
        if (x == val) {
            printf("\rOk.       \n");
            return true;
        }
        if (x & 0x02) {
            // one more read to make sure it's not a false positive caused by transition
            // recommended by the datasheet
            x = FLASH_READ(adr);
            if (x == val) {
                return true;
            }
            printf("\nWrite operation reports failed\n");
            return false;
        }

        // this is the racy read, but it doesn't need to be accurate
        if (VDPST & VDP_ST_INT) {
            ++cycles;
            if (cycles >= 60) {
                ++time;
                cycles=0;
                printf("\rWaiting... %ds", time);
                kscanfast(0);
                if (KSCAN_KEY == ' ') {
                    printf("\n-- Aborted by keypress\n");
                    return false;
                }
            }
        }
    }
}

// this writes a 512 byte sector 32 bytes at a time through buffer[]
// latch is the full 14 bit address, we'll do the splitting up
// page is not allowed to change through the 512 bytes, and we must
// be 32 byte aligned too.
bool flashWriteFast(unsigned int page, unsigned int adr) {
    int latch = (page&0xfff) << 1;
    unsigned char bits = (page>>12) & 0x03;

    if (adr%32) {
        printf("* Can't write to unaligned address: %X%X\n", (adr>>8), (adr&0xff));
        return false;
    }

    printf("WRITING page %X%X, address %X%X\n", page>>8, page&0xff, adr>>8, adr&0xff);

    for (int off=0; off<512; off+=32, adr+=32) {
        flashUnlock();
        FLASH_SETLATCH(latch) = bits | FLASH_UNRESET | FLASH_WRITEMSB;

        FLASH_WRITE(adr) = 0x25;        // buffer write
        FLASH_WRITE(adr) = 31;          // 32 writes will follow (start with -1)

        // todo: fully untested - can we enable full 16-bit writes??
        FLASH_SETLATCH(latch) = bits | FLASH_UNRESET | FLASH_WRITEMSB | FLASH_WRITELSB;

        // write 32 16-bit words to the flash. The multiplexer will do 32 8-bit writes
        for (int idx=off; idx<off+32; idx+=2) {
            FLASH_WRITE(adr+idx) = *((unsigned int*)(&buffer[idx]));
        }

        FLASH_SETLATCH(latch) = bits | FLASH_UNRESET | FLASH_WRITEMSB;

        FLASH_WRITE(adr) = 0x29;        // start the process

        // expected time is 512uS to 2048uS
        if (!flashWaitForWrite(page, adr+31, buffer[31])) {
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
bool flashWriteSlow(unsigned int page, unsigned int adr) {
    int latch = (page&0xfff) << 1;
    unsigned char bits = (page>>12) & 0x03;

    printf("Writing page %X%X, address %X%X\n", page>>8, page&0xff, adr>>8, adr&0xff);

    for (int off=0; off<512; off++, adr++) {
        flashUnlock();

        // send the command
        FLASH_SETBITS = FLASH_UNRESET | FLASH_WRITEMSB;
        FLASH_WRITE(0xaaa) = 0xa0;        // single word (byte) write

        // write the data
        if (adr & 1) {
            FLASH_SETLATCH(latch) = bits | FLASH_UNRESET | FLASH_WRITELSB;
        } else {
            FLASH_SETLATCH(latch) = bits | FLASH_UNRESET | FLASH_WRITEMSB;
        }
        FLASH_WRITE(adr) = buffer[off];

        // TODO: do we need to wait? the program time ranges from
        // 256uS to 2048uS.. on the TI 256uS is about 80 instructions.
        if (!flashWaitForWrite(page, adr, buffer[off])) {
            return false;
        }
    }

    return true;
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
    FLASH_SETBITS = FLASH_UNRESET | FLASH_WRITEMSB;
    FLASH_WRITE(0xaaa) = 0x80;      // first step

    flashUnlock();
    FLASH_SETLATCH(latch) = bits | FLASH_UNRESET | FLASH_WRITEMSB;
    FLASH_WRITE(0) = 0x30;          // start erase

    if (!flashWaitForWrite(page, 0, 0xff)) {
        return false;
    }
}

// erase the entire chip -- yeah, want to be careful with this one
bool flashChipErase() {
    printf("Erasing flash chip...\n");

    flashUnlock();
    FLASH_SETBITS = FLASH_UNRESET | FLASH_WRITEMSB;
    FLASH_WRITE(0xaaa) = 0x80;      // first step
    
    flashUnlock();
    FLASH_SETBITS = FLASH_UNRESET | FLASH_WRITEMSB;
    FLASH_WRITE(0xaaa) = 0x10;      // second step, operation starts

    // this takes over ten minutes!
    if (!flashWaitForWrite(0, 0, 0xff)) {
        return false;
    }

    return true;
}

//////////////////////////
// CF7 functions
//////////////////////////

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
    cf7Reset();

    CF7_CRU_ON;

        CF7_WRITE(CF7_FEATURES) = 0x81;         // 8-bit mode
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
                    if (x&0x04) {
                        printf("Warning: ECC reported\n");
                    }
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
            if (KSCAN_KEY == ' ') {
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

        printf("Identify...");
        for (int off=0; off<512; ++off) {
            buffer[off] = CF7_READ(CF7_DATA);
        }
        printf(":\n");

    CF7_CRU_OFF;

    // now parse the useful data...
    printf("Size    : 0x%X%X%X%X sectors\n", buffer[14], buffer[15], buffer[16], buffer[17]);
    printf("Capacity: 0x%X%X%X%X sectors\n", buffer[114], buffer[115], buffer[116], buffer[117]);
    printf("LBA     : 0x%X%X%X%X sectors\n", buffer[120], buffer[121], buffer[122], buffer[123]);
    printf("Serial: ");
        for (int idx=20; idx<40; ++idx) { putchar(buffer[idx]); }
        putchar('\n');
    printf("Model: ");
        // note: there are really 40 bytes available here, only reading 32
        for (int idx=46; idx<76; ++idx) { putchar(buffer[idx]); }
        putchar('\n');

    // dump what we read
    for (int idx=0; idx<512; ++idx) {
        if ((buffer[idx]>=' ')&&(buffer[idx]<='z')) {
            putchar(buffer[idx]); 
        } else {
            putchar(' '); 
        } 
    }
    printf("\n");

}

bool cf7ReadSector(unsigned int high, unsigned int low) {
    volatile int idx = 0;

    CF7_CRU_ON;

        cf7SetAddress(high, low);
        
        if (!cf7WaitForReady()) {
            CF7_CRU_OFF;
            return false;
        }

        printf("CF reading 0x%X%X%X%X - ", high>>8, high&0xff, low>>8, low&0xff);
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

        printf("OK...");
        for (int off=0; off<512; ++off) {
            buffer[off] = CF7_READ(CF7_DATA);
        }
        printf("!\n");

    CF7_CRU_OFF;

    return true;
}

// I don't really need a write, but might as well have it somewhere - can
// throw it into libti99 later...
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

//////////////////////////
// main function
//////////////////////////
int main() {
    int cflow=0, cfhigh=0;

	// init the screen
	{
		int x;
        x = set_text_raw();
		charsetlc();
		vdpmemset(gColor, 0x10, 32);
		VDP_SET_REGISTER(VDP_REG_MODE1, x);
		VDP_REG1_KSCAN_MIRROR = x;
		VDP_SET_REGISTER(VDP_REG_COL, 0x17);
	}
	
    flashReset();

	printf("CF7 to Seahorse board programmer\n\n");

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
        printf("  R to put flash in reset\n");
        printf("\n  1 to reset CF7\n");
        printf("  2 to read CF info\n");
        printf("  3 to read CF7\n");
        printf("  4 to write CF7 (destructive!)\n");
        printf("  5 to check CF card error\n");
        while (loop) {
            kscanfast(0);
            switch (KSCAN_KEY) {
                case 'C':   flashReadCfi(); loop=0; break;
                case 'F':   printf("Fast: Page 16, address 512\n"); if (flashWriteFast(16,512)) printf("OK!\n"); else printf("Failed!\n"); loop=0; break;
                case 'S':   printf("Slow: Page 16, address 1024\n"); if (flashWriteFast(16,1024)) printf("OK!\n"); else printf("Failed!\n"); loop=0; break;
                case 'X':   if (flashSectorErase(16)) printf("OK!\n"); else printf("Failed!\n"); loop=0; break;
                case 'E':   if (flashChipErase()) printf("OK!\n"); else printf("Failed!\n"); loop=0; break;
                case 'R':   flashReset(); loop=0; break;

                case '1':   cf7Reset(); loop=0; break;
                case '2':   cf7IdentifyDevice(); loop=0; break;
                case '3':   if (cf7ReadSector(cfhigh, cflow)) {
                                for (int idx=0; idx<512; ++idx) {
                                    if ((buffer[idx]>=' ')&&(buffer[idx]<='z')) {
                                        putchar(buffer[idx]); 
                                    } else {
                                        putchar(' '); 
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
                            if (cf7WriteSector(0, 800)) {
                                printf("OK!\n");
                            } else {
                                printf("Failed!\n"); 
                            }
                            ++cflow; 
                            if (cflow == 0) ++cfhigh; 
                            loop=0; 
                            break;
                case '5':   cf7CardError(); loop=0; break;
            }
        }
        printf("Press a key...\n");
        KSCAN_KEY=0xff;
        while (KSCAN_KEY == 0xff) { kscanfast(0); }
    }

	return 0;
}
