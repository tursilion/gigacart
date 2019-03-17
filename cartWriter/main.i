# 1 "main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "main.c"
# 33 "main.c"
# 1 "/mnt/d/work/ti/libti99/vdp.h" 1
# 28 "/mnt/d/work/ti/libti99/vdp.h"
inline void VDP_SET_ADDRESS(unsigned int x) { *((volatile unsigned char*)0x8C02)=((x)&0xff); *((volatile unsigned char*)0x8C02)=((x)>>8); }


inline void VDP_SET_ADDRESS_WRITE(unsigned int x) { *((volatile unsigned char*)0x8C02)=((x)&0xff); *((volatile unsigned char*)0x8C02)=(((x)>>8)|0x40); }


inline void VDP_SET_REGISTER(unsigned char r, unsigned char v) { *((volatile unsigned char*)0x8C02)=(v); *((volatile unsigned char*)0x8C02)=(0x80|(r)); }


inline int VDP_SCREEN_POS(unsigned int r, unsigned int c) { return (((r)<<5)+(c)); }


inline int VDP_SCREEN_TEXT(unsigned int r, unsigned int c) { return (((r)<<5)+((r)<<3)+(c)); }


inline int VDP_SCREEN_TEXT80(unsigned int r, unsigned int c) { return (((r)<<6)+((r)<<4)+(c)); }


inline int VDP_SCREEN_TEXT64(unsigned int r, unsigned int c) { return (((r)<<6)+(c)); }
# 173 "/mnt/d/work/ti/libti99/vdp.h"
int set_graphics_raw(int sprite_mode);

void set_graphics(int sprite_mode);





int set_text_raw();

void set_text();





int set_text80_raw();

void set_text80();







int set_text80_color_raw();

void set_text80_color();





void set_text64_color();







int set_multicolor_raw(int sprite_mode);

void set_multicolor(int sprite_mode);





int set_bitmap_raw(int sprite_mode);

void set_bitmap(int sprite_mode);




void writestring(int row, int col, char *pStr);



void vdpmemset(int pAddr, int ch, int cnt);



void vdpmemcpy(int pAddr, const unsigned char *pSrc, int cnt);



void vdpmemread(int pAddr, unsigned char *pDest, int cnt);





void vdpwriteinc(int pAddr, int nStart, int cnt);




extern void (*vdpchar)(int pAddr, int ch);
void vdpchar_default(int pAddr, int ch);




unsigned char vdpreadchar(int pAddr);



void vdpwritescreeninc(int pAddr, int nStart, int cnt);



void vdpscreenchar(int pAddr, int ch);



void vdpwaitvint();







int putchar(int x);







void putstring(char *s);



int puts(char *s);






int printf(char *str, ...);


void hexprint(unsigned char x);



void fast_hexprint(unsigned char x);



void faster_hexprint(unsigned char x);



void scrn_scroll_default();
extern void (*scrn_scroll)();


void fast_scrn_scroll();




void hchar(int r, int c, int ch, int cnt);




void vchar(int r, int c, int ch, int cnt);




unsigned char gchar(int r, int c);






void sprite(int n, int ch, int col, int r, int c);



void delsprite(int n);



void charset();




void charsetlc();
# 361 "/mnt/d/work/ti/libti99/vdp.h"
void gplvdp(int vect, int adr, int cnt);


void bm_setforeground(int c);


void bm_setbackground(int c);



void bm_clearscreen();




void bm_setpixel(unsigned int x, unsigned int y);




void bm_clearpixel(unsigned int x, unsigned int y);


void bm_drawline(int x0, int y0, int x1, int y1);







void bm_drawlinefast(int x0, int y0, int x1, int y1, int mode);



void bm_sethlinefast(unsigned int x0, unsigned int y0, unsigned int x1);


void bm_clearhlinefast(unsigned int x0, unsigned int y0, unsigned int x1);




void bm_consolefont();




void bm_putc(int c, int r, unsigned char alphanum);





void bm_puts(int c, int r, unsigned char* str);




void bm_placetile(int c, int r, const unsigned char* pattern);






extern unsigned char gBitmapColor;





extern unsigned char* gBmFont;




extern unsigned int gImage;
extern unsigned int gColor;
extern unsigned int gPattern;
extern unsigned int gSprite;
extern unsigned int gSpritePat;


extern int nTextRow,nTextEnd;
extern int nTextPos;

extern unsigned char gSaveIntCnt;


extern const unsigned int byte2hex[256];



void unlock_f18a();


void lock_f18a();
# 34 "main.c" 2
# 1 "/mnt/d/work/ti/libti99/kscan.h" 1
# 54 "/mnt/d/work/ti/libti99/kscan.h"
unsigned char kscan(unsigned char mode);





void kscanfast(int mode);



void joystfast(int unit);
# 35 "main.c" 2
# 1 "/mnt/d/work/ti/libti99/string.h" 1







int strlen(const char *s);



int atoi(char *s);


char *strcpy(char *d, const char *s);


void *memcpy(void *dest, const void *src, int cnt);



char *uint2str(unsigned int x);



char *int2str(int x);



char* uint2hex(unsigned int x);




void gets(char *buf, int maxlen);
# 36 "main.c" 2
# 50 "main.c"
void flashReset() ;
void flashUnlock() ;
void flashReadCfi() ;
int flashWaitForWrite(unsigned int page, unsigned int adr, unsigned char val) ;
int flashWriteFast(unsigned int page, unsigned int adr) ;
int flashWriteSlow(unsigned int page, unsigned int adr) ;
int flashSectorErase(unsigned int page) ;
int flashChipErase() ;
# 69 "main.c"
void cf7Reset() ;
void cf7Init() ;
void cf7SetAddress(unsigned int high, unsigned int low) ;
void cf7CardError() ;
int cf7WaitForReady() ;
void cf7IdentifyDevice() ;
int cf7ReadSector(unsigned int high, unsigned int low) ;
int cf7WriteSector(unsigned int high, unsigned int low) ;


unsigned char buffer[512];


volatile unsigned char verify;
volatile unsigned int verifylatch;
# 136 "main.c"
void flashReset() {
    *((volatile unsigned char*)0x6000)=verify=(0); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0));;
}


void flashUnlock() {
    *((volatile unsigned char*)0x6000)=verify=(0x10 | 0x08); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10 | 0x08));;
    verifylatch=(0xaaa); *((volatile unsigned char*)(0xE000+(0xaaa)))=verify=(0xaa); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(0xaaa))>>8, (0xe000+(0xaaa))&0xff, (0xaa));;
    *((volatile unsigned char*)0x6000)=verify=(0x10 | 0x04); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10 | 0x04));;
    verifylatch=(0x555); *((volatile unsigned char*)(0xE000+(0x555)))=verify=(0x55); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(0x555))>>8, (0xe000+(0x555))&0xff, (0x55));;
}


void flashReadCfi() {


    int fail = 0;

    printf("Flash CFI information:\n");



    *((volatile unsigned char*)0x6000)=verify=(0x10 | 0x08); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10 | 0x08));;
    verifylatch=(0xaa); *((volatile unsigned char*)(0xE000+(0xaa)))=verify=(0x98); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(0xaa))>>8, (0xe000+(0xaa))&0xff, (0x98));;
    *((volatile unsigned char*)0x6000)=verify=(0x10); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10));;




    for (int idx=0; idx<512; ++idx) {
        buffer[idx] = *((volatile unsigned char*)(0x6000+(idx)));
    }


    *((volatile unsigned char*)0x6000)=verify=(0x10 | 0x08); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10 | 0x08));;
    verifylatch=(0xaa); *((volatile unsigned char*)(0xE000+(0xaa)))=verify=(0xf0); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(0xaa))>>8, (0xe000+(0xaa))&0xff, (0xf0));;
    *((volatile unsigned char*)0x6000)=verify=(0x10); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10));;


    if ((buffer[0x20]!='Q') || (buffer[0x22]!='R') || (buffer[0x24]!='Y')) {
        printf("Did NOT get QRY string: %c%c%c\n", buffer[0x20], buffer[0x22], buffer[0x24]);
        fail=1;
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




void flashReadStatus() {

    *((volatile unsigned char*)0x6000)=verify=(0x10 | 0x08); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10 | 0x08));;
    verifylatch=(0xaaa); *((volatile unsigned char*)(0xE000+(0xaaa)))=verify=(0x70); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(0xaaa))>>8, (0xe000+(0xaaa))&0xff, (0x70));;
    *((volatile unsigned char*)0x6000)=verify=(0x10); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10));;




    unsigned int tmp = *((volatile unsigned int*)0x6000);


    printf("Status word read: >%X%X\n", tmp>>8, tmp&0xff);


    unsigned char x = tmp&0xff;

    if (x&0x80) {

        printf("Ready          : yes\n");
        printf("Erase suspend  : %s\n", (x&0x40)?"yes":"no");
        printf("Erase status   : %s\n", (x&0x20)?"fail":"ok");
        printf("Program status : %s\n", (x&0x10)?"fail":"ok");
        printf("Write Buf Abort: %s\n", (x&0x08)?"yes":"no");
        printf("Program suspend: %s\n", (x&0x04)?"yes":"no");
        printf("Sector locked  : %s\n", (x&0x04)?"yes":"no");
        printf("Continuity     : %s\n", (x&0x04)?"ok":"no");
    } else {

        printf("Ready          : no\n");
    }


    *((volatile unsigned char*)0x6000)=verify=(0x10 | 0x08); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10 | 0x08));;
    verifylatch=(0xaaa); *((volatile unsigned char*)(0xE000+(0xaaa)))=verify=(0x71); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(0xaaa))>>8, (0xe000+(0xaaa))&0xff, (0x71));;
    *((volatile unsigned char*)0x6000)=verify=(0x10); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10));;

}



int flashWaitForWrite(unsigned int page, unsigned int adr, unsigned char val) {
    int latch = (page&0xfff) << 1;
    unsigned char bits = (page>>12) & 0x03;
    verifylatch=(latch); *((volatile unsigned char*)(0x6000+(latch)))=verify=(bits | 0x10); printf("%s - latch >%X%X = >%X\n", __FUNCTION__, (0x6000+(latch))>>8, (0x6000+(latch))&0xff, (bits | 0x10));;

    int time = 0;
    int cycles = 0;

    printf("Waiting...");

    for (;;) {
        unsigned char x = *((volatile unsigned char*)(0x6000+(adr)));
        if (x == val) {
            printf("\n");
            return 1;
        }
        if (x & 0x20) {


            x = *((volatile unsigned char*)(0x6000+(adr)));
            if (x == val) {
                return 1;
            }
            printf(">%X\n", x);
            if (x & 0x08) {
                printf("Erase operation reports failed\n");
            } else {
                printf("Write operation reports failed\n");
            }
            flashReadStatus();
            return 0;
        }


        if (*((volatile unsigned char*)0x8802) & 0x80) {
            ++cycles;
            if (cycles >= 60) {
                ++time;
                cycles=0;
                printf("\rWaiting... >%X != >%X - %ds", x, val, time);
                kscanfast(0);
                if (*((volatile unsigned char*)0x8375) == ' ') {
                    printf("\n-- Aborted by keypress\n");
                    return 0;
                }
            }
        }
    }
}





int flashWriteFast(unsigned int page, unsigned int adr) {
    int latch = (page&0xfff) << 1;
    unsigned char bits = (page>>12) & 0x03;
# 367 "main.c"
    unsigned int sa = (adr&0x1000)+0x555;

    if (adr%32) {
        printf("* Can't write to unaligned address: %X%X\n", (adr>>8), (adr&0xff));
        return 0;
    }

    printf("WRITING page %d, address 0x%X%X\n", page, adr>>8, adr&0xff);

    for (int off=0; off<512; off+=32) {
        flashUnlock();
        verifylatch=(latch); *((volatile unsigned char*)(0x6000+(latch)))=verify=(bits | 0x10 | 0x04); printf("%s - latch >%X%X = >%X\n", __FUNCTION__, (0x6000+(latch))>>8, (0x6000+(latch))&0xff, (bits | 0x10 | 0x04));;

        verifylatch=(sa); *((volatile unsigned char*)(0xE000+(sa)))=verify=(0x25); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(sa))>>8, (0xe000+(sa))&0xff, (0x25));;
        verifylatch=(sa); *((volatile unsigned char*)(0xE000+(sa)))=verify=(31); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(sa))>>8, (0xe000+(sa))&0xff, (31));;



        verifylatch=(latch); *((volatile unsigned char*)(0x6000+(latch)))=verify=(bits | 0x10 | 0x08 | 0x04); printf("%s - latch >%X%X = >%X\n", __FUNCTION__, (0x6000+(latch))>>8, (0x6000+(latch))&0xff, (bits | 0x10 | 0x08 | 0x04));;


        for (unsigned int idx=off; idx<off+32; idx+=2) {

            unsigned int data = *((unsigned int*)(&buffer[idx]));
            unsigned int outadr = 0xe000 + (adr+idx);
            *((volatile unsigned int*)(outadr)) = data;

            printf("%s - write >%X%X = >%X%X\n", __FUNCTION__, outadr>>8, outadr&0xff, data>>8, data&0xff);

        }


        verifylatch=(latch); *((volatile unsigned char*)(0x6000+(latch)))=verify=(bits | 0x10 | 0x04); printf("%s - latch >%X%X = >%X\n", __FUNCTION__, (0x6000+(latch))>>8, (0x6000+(latch))&0xff, (bits | 0x10 | 0x04));;
        verifylatch=(sa); *((volatile unsigned char*)(0xE000+(sa)))=verify=(0x29); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(sa))>>8, (0xe000+(sa))&0xff, (0x29));;




        if (!flashWaitForWrite(page, adr+30, buffer[30])) {
            return 0;
        }
    }

    return 1;
}






int flashWriteSlow(unsigned int page, unsigned int adr) {
    int latch = (page&0xfff) << 1;
    unsigned char bits = (page>>12) & 0x03;

    printf("Writing page 0x%d, address 0x%X%X\n", page, adr>>8, adr&0xff);

    for (int off=0; off<512; off++, adr++) {
        flashUnlock();


        *((volatile unsigned char*)0x6000)=verify=(0x10 | 0x08); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10 | 0x08));;
        verifylatch=(0xaaa); *((volatile unsigned char*)(0xE000+(0xaaa)))=verify=(0xa0); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(0xaaa))>>8, (0xe000+(0xaaa))&0xff, (0xa0));;


        if (adr & 1) {
            verifylatch=(latch); *((volatile unsigned char*)(0x6000+(latch)))=verify=(bits | 0x10 | 0x04); printf("%s - latch >%X%X = >%X\n", __FUNCTION__, (0x6000+(latch))>>8, (0x6000+(latch))&0xff, (bits | 0x10 | 0x04));;
        } else {
            verifylatch=(latch); *((volatile unsigned char*)(0x6000+(latch)))=verify=(bits | 0x10 | 0x08); printf("%s - latch >%X%X = >%X\n", __FUNCTION__, (0x6000+(latch))>>8, (0x6000+(latch))&0xff, (bits | 0x10 | 0x08));;
        }
        verifylatch=(adr); *((volatile unsigned char*)(0xE000+(adr)))=verify=(buffer[off]); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(adr))>>8, (0xe000+(adr))&0xff, (buffer[off]));;



        if (!flashWaitForWrite(page, adr, buffer[off])) {
            return 0;
        }
    }

    return 1;
}




int flashSectorErase(unsigned int page) {
    int latch = (page&0xfff) << 1;
    unsigned char bits = (page>>12) & 0x03;

    if (page % 16) {
        printf("Sector erase page %d is not 128k aligned\n", page);
        return 0;
    }

    printf("Erasing sector %d\n", page);


    flashUnlock();
    *((volatile unsigned char*)0x6000)=verify=(0x10 | 0x08); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10 | 0x08));;
    verifylatch=(0xaaa); *((volatile unsigned char*)(0xE000+(0xaaa)))=verify=(0x80); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(0xaaa))>>8, (0xe000+(0xaaa))&0xff, (0x80));;

    flashUnlock();
    verifylatch=(latch); *((volatile unsigned char*)(0x6000+(latch)))=verify=(bits | 0x10 | 0x08); printf("%s - latch >%X%X = >%X\n", __FUNCTION__, (0x6000+(latch))>>8, (0x6000+(latch))&0xff, (bits | 0x10 | 0x08));;
    verifylatch=(0); *((volatile unsigned char*)(0xE000+(0)))=verify=(0x30); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(0))>>8, (0xe000+(0))&0xff, (0x30));;

    if (!flashWaitForWrite(page, 0, 0xff)) {
        return 0;
    }
}


int flashChipErase() {
    printf("Erasing flash chip...\n");

    flashUnlock();
    *((volatile unsigned char*)0x6000)=verify=(0x10 | 0x08); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10 | 0x08));;
    verifylatch=(0xaaa); *((volatile unsigned char*)(0xE000+(0xaaa)))=verify=(0x80); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(0xaaa))>>8, (0xe000+(0xaaa))&0xff, (0x80));;

    flashUnlock();
    *((volatile unsigned char*)0x6000)=verify=(0x10 | 0x08); printf("%s - latch >6000 = >%X\n", __FUNCTION__, (0x10 | 0x08));;
    verifylatch=(0xaaa); *((volatile unsigned char*)(0xE000+(0xaaa)))=verify=(0x10); printf("%s - write >%X%X = >%X\n", __FUNCTION__, (0xe000+(0xaaa))>>8, (0xe000+(0xaaa))&0xff, (0x10));;


    if (!flashWaitForWrite(0, 0, 0xff)) {
        return 0;
    }

    return 1;
}







void cf7Reset() {
    volatile int idx;

    __asm__( "li r12,>1100\n\tsbo 0" : : : "r12" );;

        *((volatile unsigned char*)(0x5f00+(0x1d))) = 0x04;
        for (idx=0; idx<500; ++idx) {
            idx = idx;
        }
        *((volatile unsigned char*)(0x5f00+(0x1d))) = 0;

    __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
}

void cf7Init() {
    __asm__( "li r12,>1100\n\tsbo 0" : : : "r12" );;

        *((volatile unsigned char*)(0x5f00+(3))) = 0x01;
        *((volatile unsigned char*)(0x5f00+(5))) = 0;
        *((volatile unsigned char*)(0x5f00+(0xd))) = 0;
        *((volatile unsigned char*)(0x5f00+(0xf))) = 0xef;

    __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
}



void cf7SetAddress(unsigned int high, unsigned int low) {
    *((volatile unsigned char*)(0x5f00+(0xd))) = 0xe0 + ((high>>8)&0x0f);
    *((volatile unsigned char*)(0x5f00+(0xb))) = high&0xff;
    *((volatile unsigned char*)(0x5f00+(9))) = low>>8;
    *((volatile unsigned char*)(0x5f00+(7))) = low&0xff;
    *((volatile unsigned char*)(0x5f00+(5))) = 1;
}


void cf7CardError() {

    __asm__( "li r12,>1100\n\tsbo 0" : : : "r12" );;
        *((volatile unsigned char*)(0x5f00+(0xf))) = 0x03;
        int err = *((volatile unsigned char*)(0x5e00+(3)));

        if (!cf7WaitForReady()) {
            __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
            return;
        }

        printf("Error: ");
        switch (err) {
            case 0: printf("No error\n"); break;
            case 1: printf("Self test OK\n"); break;
            case 9: printf("Miscellaneous error\n"); break;
            case 0x20: printf("Invalid command\n"); break;
            case 0x21: printf("Invalid address\n"); break;
            case 0x2f: printf("Address overflow\n"); break;
            case 0x35:
            case 0x36: printf("Voltage out of tolerance\n"); break;
            case 0x11: printf("Uncorrectable ECC\n"); break;
            case 0x18: printf("Corrected ECC\n"); break;
            case 0x05:
            case 0x30:
            case 0x31:
            case 0x32:
            case 0x33:
            case 0x34:
            case 0x37:
            case 0x3e: printf("Diagnostic failed.\n"); break;
            case 0x10:
            case 0x14: printf("ID not found\n"); break;
            case 0x3a: printf("Spare sectors exhausted.\n"); break;
            case 0x1f: printf("Data transfer aborted\n"); break;
            case 0x0c:
            case 0x38:
            case 0x3b:
            case 0x3c:
            case 0x3f: printf("Corrupted media\n"); break;
            case 0x03: printf("Write/erase failed.\n"); break;
            default: printf("Unknown (0x%X)\n", (unsigned char)(err&0xff));
        }

    __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
}



int cf7WaitForReady() {
    int cnt = 0;
    for (;;) {
        unsigned char x = *((volatile unsigned char*)(0x5e00+(0xf)));
        if (!(x&0x80)) {
            if (x&0x50) {
                if ((x&0x50) != 0x50) {
                    printf("RDY=%d, DSC=%d\n", (int)(x&40), (int)(x&010));
                } else {
                    if (x&0x04) {
                        printf("Warning: ECC reported\n");
                    }
                    return 1;
                }
            }
            if (x&0x20) {
                printf("* CF Write fault\n");
                cf7CardError();
                return 0;
            }
            if (x&0x01) {
                printf(" * CF error occurred\n");
                cf7CardError();
                return 0;
            }
        }
        if (++cnt >= 100) {
            cnt = 0;
            kscanfast(0);
            if (*((volatile unsigned char*)0x8375) == ' ') {
                printf("\n-- CF aborted by keypress\n");
                return 0;
            }
        }
    }
}

void cf7IdentifyDevice() {
    __asm__( "li r12,>1100\n\tsbo 0" : : : "r12" );;

        if (!cf7WaitForReady()) {
            __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
            return;
        }

        *((volatile unsigned char*)(0x5f00+(0xf))) = 0xec;

        if (!cf7WaitForReady()) {
            __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
            return;
        }

        if (!(*((volatile unsigned char*)(0x5e00+(0xf))) & 0x08)) {
            __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
            printf("No data!\n");
            return;
        }

        printf("Identify...");

        for (int off=0; off<512; off+=2) {
            buffer[off+1] = *((volatile unsigned char*)(0x5e00+(1)));
            buffer[off] = *((volatile unsigned char*)(0x5e00+(1)));
        }
        printf(":\n");

    __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;



    printf("Size    : 0x%X%X%X%X sectors\n", buffer[14], buffer[15], buffer[16], buffer[17]);

    printf("Capacity: 0x%X%X%X%X sectors\n", buffer[116], buffer[117], buffer[114], buffer[115]);
    printf("LBA     : 0x%X%X%X%X sectors\n", buffer[122], buffer[123], buffer[120], buffer[121]);
    printf("Serial: ");
        for (int idx=20; idx<40; ++idx) { putchar(buffer[idx]); }
        putchar('\n');
    printf("Model: ");

        for (int idx=46; idx<76; ++idx) { putchar(buffer[idx]); }
        putchar('\n');



    for (int idx=0; idx<512; ++idx) {
        if ((buffer[idx]>=' ')&&(buffer[idx]<='z')) {
            putchar(buffer[idx]);
        } else {
            putchar(' ');
        }
    }
    printf("\n");


}

int cf7ReadSector(unsigned int high, unsigned int low) {
    volatile int idx = 0;

    __asm__( "li r12,>1100\n\tsbo 0" : : : "r12" );;

        cf7SetAddress(high, low);

        if (!cf7WaitForReady()) {
            __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
            return 0;
        }

        printf("CF reading 0x%X%X%X%X - ", high>>8, high&0xff, low>>8, low&0xff);
        *((volatile unsigned char*)(0x5f00+(0xf))) = 0x20;






        if (!cf7WaitForReady()) {
            __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
            return 0;
        }

        if (!(*((volatile unsigned char*)(0x5e00+(0xf))) & 0x08)) {
            __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
            printf("No data!\n");
            return 0;
        }

        printf("OK...");
        for (int off=0; off<512; ++off) {
            buffer[off] = *((volatile unsigned char*)(0x5e00+(1)));
        }
        printf("!\n");

    __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;

    return 1;
}




int cf7WriteSector(unsigned int high, unsigned int low) {
    volatile int idx = 0;

    __asm__( "li r12,>1100\n\tsbo 0" : : : "r12" );;

        cf7SetAddress(high, low);

        if (!cf7WaitForReady()) {
            __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
            return 0;
        }

        printf("CF writing 0x%X%X%X%X - ", high>>8, high&0xff, low>>8, low&0xff);
        *((volatile unsigned char*)(0x5f00+(0xf))) = 0x30;




        for (idx = 0; idx<100; ++idx) { }

        if (!cf7WaitForReady()) {
            __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
            return 0;
        }

        if (!(*((volatile unsigned char*)(0x5e00+(0xf))) & 0x08)) {
            __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
            printf("No data!\n");
            return 0;
        }

        printf(".");
        for (int off=0; off<512; ++off) {
            *((volatile unsigned char*)(0x5f00+(1))) = buffer[off];
        }
        printf("..");

        if (!cf7WaitForReady()) {
            __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;
            return 0;
        }

        printf("OK!\n");

    __asm__( "li r12,>1100\n\tsbz 0" : : : "r12" );;

    return 1;
}




int main() {
    int cflow=0, cfhigh=0;


 {
  int x;
        x = set_text_raw();
  charsetlc();
  VDP_SET_REGISTER(0x01, x);
  *((volatile unsigned char*)0x83d4) = x;
  VDP_SET_REGISTER(0x07, 0x17);
        scrn_scroll = fast_scrn_scroll;
 }

    flashReset();
    cf7Init();

 printf("CF7 to Seahorse board programmer\n\n");


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
        printf("  I for flash status info\n");
        printf("  R to put flash in reset\n");
        printf("\n  1 to reset CF7\n");
        printf("  2 to read CF info\n");
        printf("  3 to read CF7\n");
        printf("  4 to write CF7 (destructive!)\n");
        printf("  5 to check CF card error\n");
        printf("\n  Q to quit\n");
        while (loop) {
            kscanfast(0);
            switch (*((volatile unsigned char*)0x8375)) {
                case 'Q': return 0;
                case 'C': flashReadCfi();
                            loop=0;
                            break;

                case 'F': printf("Fast: Page 16, address 512\n");
                            for (int idx=0; idx<512; ++idx) {
                                buffer[idx]=(idx&0xff);
                            }
                            if (flashWriteFast(16,512)) {
                                printf("OK!\n");
                            } else {
                                printf("Failed!\n");
                            }
                            loop=0;
                            break;

                case 'S': printf("Slow: Page 16, address 1024\n");
                            for (int idx=0; idx<512; ++idx) {
                                buffer[idx]=(idx&0xff);
                            }
                            if (flashWriteSlow(16,1024)) {
                                printf("OK!\n");
                            } else {
                                printf("Failed!\n");
                            }
                            loop=0;
                            break;

                case 'X': if (flashSectorErase(16)) {
                                printf("OK!\n");
                            } else {
                                printf("Failed!\n");
                            }
                            loop=0;
                            break;

                case 'E': if (flashChipErase()) {
                                printf("OK!\n");
                            } else {
                                printf("Failed!\n");
                            }
                            loop=0;
                            break;

                case 'I': flashReadStatus();
                            loop=0;
                            break;

                case 'R': flashReset();
                            loop=0;
                            break;

                case '1': cf7Init();
                            loop=0;
                            break;

                case '2': cf7IdentifyDevice();
                            loop=0;
                            break;

                case '3': if (cf7ReadSector(cfhigh, cflow)) {
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

                case '4': for (int idx=0; idx<512; ++idx) {
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

                case '5': cf7CardError();
                            loop=0;
                            break;
            }
        }
        printf("Press a key...\n");
        *((volatile unsigned char*)0x8375)=0xff;
        while (*((volatile unsigned char*)0x8375) == 0xff) { kscanfast(0); }
    }

 return 0;
}
