	.psize 0			; don't page

# code for scratchpad - r1 is return value
# arguments are normally R1,R2,R3

	def cf7ReadSectorLoop
	def flashWriteFastLoop
	def flashVerifyLoop
	def setupScratchpad
	ref buffer

cf7ReadSectorLoop	equ xcf7ReadSectorLoop-scr_start+0x8320
flashWriteFastLoop	equ xflashWriteFastLoop-scr_start+0x8320
flashVerifyLoop		equ xflashVerifyLoop-scr_start+0x8320

	pseg
	even

scr_start

#__attribute__((naked)) void cf7ReadSectorLoop() {
#	for (int off=0; off<512; ++off) {
#		buffer[off] = CF7_READ(CF7_DATA);
#	}
xcf7ReadSectorLoop
		LWPI 0x83e0			; use gplws
		li r0,buffer		; destination
		li r1,0x5E01		; source
		li r2,128			; number of loops, unrolled to 4
rsllp	movb *r1,*r0+		; read four bytes
		movb *r1,*r0+
		movb *r1,*r0+
		movb *r1,*r0+
		dec r2				; count down
		jne rsllp			; until done
		lwpi 0x8300			; back to original
		b *r11
	
#__attribute__((naked)) void flashWriteFastLoop(unsigned int off, unsigned int adr) {
#	for (unsigned int idx=off; idx<off+STEPSIZE; idx+=2) {
#		unsigned int data = *((unsigned int*)(&buffer[idx]));
#		unsigned int outadr = 0xe000 + (adr+idx);
#		*((volatile unsigned int*)(outadr)) = data;
#	}
# off in R1 is a starting index from 0-512. We are assuming a fixed
# STEPSIZE of 256, so really it should be only 0 or 256
xflashWriteFastLoop
		LWPI 0x83e0			; use gplws
		li r0,0xE000		; destination
		a  @0x8302,r0		; add in the starting off (old R1)
		a  @0x8304,r0		; add in the starting adr (old R2)
		li r1,buffer		; source
		a  @0x8302,r1		; add in the starting off (old R1)
		li r2,32			; number of loops, unrolled to 4
fwllp	mov *r1+,*r0+		; read four bytes - full words
		mov *r1+,*r0+
		mov *r1+,*r0+
		mov *r1+,*r0+
		dec r2				; count down
		jne fwllp			; until done
		lwpi 0x8300			; back to original
		b *r11
		
#__attribute__((naked)) unsigned int flashVerifyLoop(unsigned int adr) {
#    for (int off=0; off<512; off+=2, adr+=2) {
#        // FLASH_WRITE is only 8 bit, so we need a 16-bit version
#        unsigned int data = *((unsigned int*)(&buffer[off]));
#        unsigned int inadr = 0x6000 + adr;
#        unsigned int cart = *((unsigned int*)(inadr));
#        if (cart != data) {
#            ret = false;
#            break;
#        }
#    }
# 0xffff on success, 0 on failure
# read failure address from 0x83E0
#
# verify 512 bytes at adr against buffer
xflashVerifyLoop
		LWPI 0x83e0			; use gplws
		li r0,0x6000		; cart
		a  @0x8302,r0		; add in the starting adr (old R1)
		li r1,buffer		; buffer
		li r2,128			; number of loops (slight unroll)
fvllp	c *r1+,*r0+			; compare full words
		jne fvfail			; jump out on error
		c *r1+,*r0+			; compare full words
		jne fvfail			; jump out on error
		dec r2				; count down
		jne fvllp			; until done
		lwpi 0x8300			; back to original
		seto r1				; success
		b *r11				; done
fvfail	lwpi 0x8300			; back to original
		clr r1				; failure
		b *r11

scr_end

#__attribute__((naked)) void setupScratchpad() {
# copies the above code into scratchpad for use
# we need to fit between 0x831f and 0x83E0
setupScratchpad
		lwpi 0x83e0			; use gplws
		li r0,scr_start		; source
		li r1,0x8320		; target
ssplp	mov *r0+,*r1+		; copy
		ci r0,scr_end
		jl ssplp			; keep going
		lwpi 0x8300
		b *r11
		
		