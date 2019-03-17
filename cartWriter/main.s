	pseg
	even

	def	cf7Reset
cf7Reset
	dect r10
* Begin inline assembler code
* 506 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r1, >400
	movb r1, @>5F1D
	clr  *r10
	mov  *r10, r1
	ci   r1, >1F3
	jgt  L2
L5
	mov  *r10, *r10
	mov  *r10, r1
	inc  r1
	mov  r1, *r10
	mov  *r10, r1
	ci   r1, >1F3
	jlt  L5
	jeq  L5
L2
	clr  r1
	movb r1, @>5F1D
* Begin inline assembler code
* 514 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	inct r10
	b    *r11
	.size	cf7Reset, .-cf7Reset
	even

	def	cf7Init
cf7Init
* Begin inline assembler code
* 518 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r1, >100
	movb r1, @>5F03
	clr  r1
	movb r1, @>5F05
	movb r1, @>5F0D
	li   r1, >EF00
	movb r1, @>5F0F
* Begin inline assembler code
* 525 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    *r11
	.size	cf7Init, .-cf7Init
	even

	def	cf7SetAddress
cf7SetAddress
	mov  r1, r3
	srl  r3, >8
	andi r3, >F
	ai   r3, >E0
	swpb r3
	movb r3, @>5F0D
	swpb r1
	movb r1, @>5F0B
	mov  r2, r1
	movb r1, @>5F09
	swpb r2
	movb r2, @>5F07
	li   r1, >100
	movb r1, @>5F05
	b    *r11
	.size	cf7SetAddress, .-cf7SetAddress
LC0
	text 'RDY=%d, DSC=%d'
	byte 10
	byte 0
LC1
	text 'Warning: ECC reported'
	byte 0
LC2
	text '* CF Write fault'
	byte 0
LC3
	text ' * CF error occurred'
	byte 0
LC4
	byte 10
	text '-- CF aborted by keypress'
	byte 0
	even

	def	cf7WaitForReady
cf7WaitForReady
	ai   r10, >FFF6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	clr  r13
	li   r15, printf
L24
	movb @>5E0F, r9
	jlt  L14
	srl  r9, 8
	mov  r9, r1
	andi r1, >50
	jeq  L15
	ai   r1, >FFB0
	jne  JMP_0
	b    @L16
JMP_0
	ai   r10, >FFFA
	li   r1, LC0
	mov  r1, *r10
	mov  r9, r2
	andi r2, >28
	mov  r2, @>2(r10)
	mov  r9, r2
	andi r2, >8
	mov  r2, @>4(r10)
	bl   *r15
	ai   r10, >6
L15
	mov  r9, r14
	andi r14, >20
	jne  L26
	andi r9, >1
	ci   r9, 0
	jne  L27
L14
	inc  r13
	ci   r13, >63
	jlt  L24
	jeq  L24
	clr  r1
	li   r2, kscanfast
	bl   *r2
	movb @>8375, r1
	li   r2, >2000
	cb   r1, r2
	jeq  L28
	clr  r13
	jmp  L24
L28
	li   r1, LC4
	bl   @puts
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L29
L26
	li   r1, LC2
	bl   @puts
	bl   @cf7CardError
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L29
L27
	li   r1, LC3
	bl   @puts
	bl   @cf7CardError
	mov  r14, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L29
L16
	andi r9, >4
	ci   r9, 0
	jne  L17
	li   r1, >1
L30
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L29
L17
	li   r1, LC1
	bl   @puts
	li   r1, >1
	jmp  L30
L29
	.size	cf7WaitForReady, .-cf7WaitForReady
LC5
	text 'Error: '
	byte 0
LC6
	text 'No error'
	byte 0
LC7
	text 'Self test OK'
	byte 0
LC8
	text 'Miscellaneous error'
	byte 0
LC9
	text 'Invalid command'
	byte 0
LC10
	text 'Invalid address'
	byte 0
LC11
	text 'Address overflow'
	byte 0
LC12
	text 'Voltage out of tolerance'
	byte 0
LC13
	text 'Uncorrectable ECC'
	byte 0
LC14
	text 'Corrected ECC'
	byte 0
LC15
	text 'Diagnostic failed.'
	byte 0
LC16
	text 'ID not found'
	byte 0
LC17
	text 'Spare sectors exhausted.'
	byte 0
LC18
	text 'Data transfer aborted'
	byte 0
LC19
	text 'Corrupted media'
	byte 0
LC20
	text 'Write/erase failed.'
	byte 0
LC21
	text 'Unknown (0x%X)'
	byte 10
	byte 0
	even

	def	cf7CardError
cf7CardError
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
* Begin inline assembler code
* 541 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r1, >300
	movb r1, @>5F0F
	movb @>5E03, r9
	bl   @cf7WaitForReady
	ci   r1, 0
	jeq  JMP_1
	b    @L32
JMP_1
* Begin inline assembler code
* 546 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	b    @L55
L32
	dect r10
	li   r2, LC5
	mov  r2, *r10
	li   r13, printf
	bl   *r13
	inct r10
	ci   r9, >3FFF
	jh  JMP_2
	b    @L54
JMP_2
	srl  r9, 8
L34
	ai   r10, >FFFC
	li   r1, LC21
	mov  r1, *r10
	mov  r9, @>2(r10)
	bl   *r13
	ai   r10, >4
L51
* Begin inline assembler code
* 583 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	b    @L55
L54
	srl  r9, 8
	mov  r9, r1
	a    r9, r1
	mov  @L50(r1), r2
	b    *r2
	even
L50
		data		L35
		data		L36
		data		L34
		data		L37
		data		L34
		data		L38
		data		L34
		data		L34
		data		L34
		data		L39
		data		L34
		data		L34
		data		L40
		data		L34
		data		L34
		data		L34
		data		L41
		data		L42
		data		L34
		data		L34
		data		L41
		data		L34
		data		L34
		data		L34
		data		L43
		data		L34
		data		L34
		data		L34
		data		L34
		data		L34
		data		L34
		data		L44
		data		L45
		data		L46
		data		L34
		data		L34
		data		L34
		data		L34
		data		L34
		data		L34
		data		L34
		data		L34
		data		L34
		data		L34
		data		L34
		data		L34
		data		L34
		data		L47
		data		L38
		data		L38
		data		L38
		data		L38
		data		L38
		data		L48
		data		L48
		data		L38
		data		L40
		data		L34
		data		L49
		data		L40
		data		L40
		data		L34
		data		L38
		data		L40
L49
	li   r1, LC17
	bl   @puts
	b    @L51
L48
	li   r1, LC12
	bl   @puts
	b    @L51
L47
	li   r1, LC11
	bl   @puts
	b    @L51
L46
	li   r1, LC10
	bl   @puts
	b    @L51
L45
	li   r1, LC9
	bl   @puts
	b    @L51
L44
	li   r1, LC18
	bl   @puts
	b    @L51
L43
	li   r1, LC14
	bl   @puts
	b    @L51
L42
	li   r1, LC13
	bl   @puts
	b    @L51
L41
	li   r1, LC16
	bl   @puts
	b    @L51
L40
	li   r1, LC19
	bl   @puts
	b    @L51
L39
	li   r1, LC8
	bl   @puts
	b    @L51
L38
	li   r1, LC15
	bl   @puts
	b    @L51
L37
	li   r1, LC20
	bl   @puts
	b    @L51
L36
	li   r1, LC7
	bl   @puts
	b    @L51
L35
	li   r1, LC6
	bl   @puts
	b    @L51
L55
	.size	cf7CardError, .-cf7CardError
LC22
	text 'CF writing 0x%X%X%X%X - '
	byte 0
LC23
	text 'No data!'
	byte 0
LC24
	text '..'
	byte 0
LC25
	text 'OK!'
	byte 0
	even

	def	cf7WriteSector
cf7WriteSector
	ai   r10, >FFF2
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r1, r13
	mov  r2, r9
	clr  @>A(r10)
* Begin inline assembler code
* 732 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	mov  r1, r2
	srl  r2, >8
	mov  r2, r3
	andi r3, >F
	ai   r3, >E0
	swpb r3
	movb r3, @>5F0D
	mov  r13, r1
	swpb r1
	movb r1, @>5F0B
	mov  r9, r15
	srl  r15, >8
	mov  r15, r1
	swpb r1
	movb r1, @>5F09
	mov  r9, r1
	swpb r1
	movb r1, @>5F07
	li   r1, >100
	movb r1, @>5F05
	li   r14, cf7WaitForReady
	mov  r2, @>C(r10)
	bl   *r14
	mov  @>C(r10), r2
	ci   r1, 0
	jeq  JMP_3
	b    @L57
JMP_3
* Begin inline assembler code
* 737 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
L58
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L69
L57
	ai   r10, >FFF6
	li   r1, LC22
	mov  r1, *r10
	mov  r2, @>2(r10)
	andi r13, >FF
	mov  r13, @>4(r10)
	mov  r15, @>6(r10)
	andi r9, >FF
	mov  r9, @>8(r10)
	li   r13, printf
	bl   *r13
	li   r1, >3000
	movb r1, @>5F0F
	clr  @>14(r10)
	mov  @>14(r10), r1
	ai   r10, >A
	ci   r1, >63
	jgt  L59
L66
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	mov  @>A(r10), r1
	ci   r1, >63
	jlt  L66
	jeq  L66
L59
	bl   *r14
	ci   r1, 0
	jne  JMP_4
	b    @L70
JMP_4
	movb @>5E0F, r9
	srl  r9, 8
	andi r9, >8
	ci   r9, 0
	jne  JMP_5
	b    @L71
JMP_5
	li   r1, >2E
	bl   @putchar
	li   r1, buffer
L63
	movb *r1+, @>5F01
	ci   r1, buffer+512
	jne  L63
	dect r10
	li   r1, LC24
	mov  r1, *r10
	bl   *r13
	inct r10
	bl   *r14
	ci   r1, 0
	jeq  JMP_6
	b    @L64
JMP_6
* Begin inline assembler code
* 767 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    @L58
L71
* Begin inline assembler code
* 755 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, LC23
	bl   @puts
	mov  r9, r1
	b    @L58
L70
* Begin inline assembler code
* 750 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L69
L64
	li   r1, LC25
	bl   @puts
* Begin inline assembler code
* 773 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, >1
	b    @L58
L69
	.size	cf7WriteSector, .-cf7WriteSector
LC26
	text 'CF reading 0x%X%X%X%X - '
	byte 0
LC27
	text 'OK...'
	byte 0
LC28
	text '!'
	byte 0
	even

	def	cf7ReadSector
cf7ReadSector
	ai   r10, >FFF2
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r1, r13
	mov  r2, r9
	clr  @>A(r10)
* Begin inline assembler code
* 687 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	mov  r1, r2
	srl  r2, >8
	mov  r2, r3
	andi r3, >F
	ai   r3, >E0
	swpb r3
	movb r3, @>5F0D
	mov  r13, r1
	swpb r1
	movb r1, @>5F0B
	mov  r9, r15
	srl  r15, >8
	mov  r15, r1
	swpb r1
	movb r1, @>5F09
	mov  r9, r1
	swpb r1
	movb r1, @>5F07
	li   r1, >100
	movb r1, @>5F05
	li   r14, cf7WaitForReady
	mov  r2, @>C(r10)
	bl   *r14
	mov  @>C(r10), r2
	ci   r1, 0
	jeq  JMP_7
	b    @L73
JMP_7
* Begin inline assembler code
* 692 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
L74
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L80
L73
	ai   r10, >FFF6
	li   r1, LC26
	mov  r1, *r10
	mov  r2, @>2(r10)
	andi r13, >FF
	mov  r13, @>4(r10)
	mov  r15, @>6(r10)
	andi r9, >FF
	mov  r9, @>8(r10)
	li   r13, printf
	bl   *r13
	li   r1, >2000
	movb r1, @>5F0F
	ai   r10, >A
	bl   *r14
	ci   r1, 0
	jne  JMP_8
	b    @L81
JMP_8
	movb @>5E0F, r9
	srl  r9, 8
	andi r9, >8
	ci   r9, 0
	jne  JMP_9
	b    @L82
JMP_9
	dect r10
	li   r1, LC27
	mov  r1, *r10
	bl   *r13
	li   r1, buffer
	inct r10
L77
	movb @>5E01, *r1+
	ci   r1, buffer+512
	jne  L77
	li   r1, LC28
	bl   @puts
* Begin inline assembler code
* 721 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, >1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L80
L82
* Begin inline assembler code
* 710 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, LC23
	bl   @puts
	mov  r9, r1
	b    @L74
L81
* Begin inline assembler code
* 705 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
L80
	.size	cf7ReadSector, .-cf7ReadSector
LC29
	text 'Identify...'
	byte 0
LC30
	text ':'
	byte 0
LC31
	text 'Size    : 0x%X%X%X%X sectors'
	byte 10
	byte 0
LC32
	text 'Capacity: 0x%X%X%X%X sectors'
	byte 10
	byte 0
LC33
	text 'LBA     : 0x%X%X%X%X sectors'
	byte 10
	byte 0
LC34
	text 'Serial: '
	byte 0
LC35
	text 'Model: '
	byte 0
	even

	def	cf7IdentifyDevice
cf7IdentifyDevice
	ai   r10, >FFF8
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
* Begin inline assembler code
* 626 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r9, cf7WaitForReady
	bl   *r9
	ci   r1, 0
	jeq  JMP_10
	b    @L84
JMP_10
* Begin inline assembler code
* 629 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    *r11
	b    @L99
L84
	li   r1, >EC00
	movb r1, @>5F0F
	bl   *r9
	ci   r1, 0
	jne  JMP_11
	b    @L100
JMP_11
	movb @>5E0F, r1
	srl  r1, 8
	andi r1, >8
	ci   r1, 0
	jne  JMP_12
	b    @L101
JMP_12
	dect r10
	li   r1, LC29
	mov  r1, *r10
	li   r14, printf
	bl   *r14
	li   r9, buffer+1
	inct r10
L88
	movb @>5E01, *r9
	movb @>5E01, @>FFFF(r9)
	inct r9
	ci   r9, buffer+513
	jne  L88
	li   r1, LC30
	bl   @puts
* Begin inline assembler code
* 654 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	ai   r10, >FFF6
	li   r2, LC31
	mov  r2, *r10
	movb @buffer+14, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	movb @buffer+15, r1
	srl  r1, 8
	mov  r1, @>4(r10)
	movb @buffer+16, r1
	srl  r1, 8
	mov  r1, @>6(r10)
	movb @buffer+17, r1
	srl  r1, 8
	mov  r1, @>8(r10)
	bl   *r14
	li   r1, LC32
	mov  r1, *r10
	movb @buffer+116, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	movb @buffer+117, r1
	srl  r1, 8
	mov  r1, @>4(r10)
	movb @buffer+114, r1
	srl  r1, 8
	mov  r1, @>6(r10)
	movb @buffer+115, r1
	srl  r1, 8
	mov  r1, @>8(r10)
	bl   *r14
	li   r2, LC33
	mov  r2, *r10
	movb @buffer+122, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	movb @buffer+123, r1
	srl  r1, 8
	mov  r1, @>4(r10)
	movb @buffer+120, r1
	srl  r1, 8
	mov  r1, @>6(r10)
	movb @buffer+121, r1
	srl  r1, 8
	mov  r1, @>8(r10)
	bl   *r14
	ai   r10, >8
	li   r1, LC34
	mov  r1, *r10
	bl   *r14
	ai   r9, >FE13
	inct r10
	li   r13, putchar
L89
	movb *r9+, r1
	srl  r1, 8
	bl   *r13
	ci   r9, buffer+40
	jne  L89
	li   r1, >A
	bl   @putchar
	dect r10
	li   r2, LC35
	mov  r2, *r10
	bl   *r14
	ai   r9, >6
	inct r10
L90
	movb *r9+, r1
	srl  r1, 8
	bl   *r13
	ci   r9, buffer+76
	jne  L90
	li   r1, >A
	bl   @putchar
	li   r9, buffer
	li   r14, >5A00
	jmp  L93
L103
	srl  r1, 8
	bl   *r13
	inc  r9
	ci   r9, buffer+512
	jeq  L102
L93
	movb *r9, r1
	movb r1, r2
	ai   r2, >E000
	cb   r2, r14
	jle  L103
	li   r1, >20
	bl   *r13
	inc  r9
	ci   r9, buffer+512
	jne  L93
L102
	li   r1, >A
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    @putchar
L101
* Begin inline assembler code
* 641 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, LC23
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    @puts
L100
* Begin inline assembler code
* 636 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    *r11
L99
	.size	cf7IdentifyDevice, .-cf7IdentifyDevice
LC36
	text '%s - latch >6000 = >%X'
	byte 10
	byte 0
LC37
	text '%s - write >%X%X = >%X'
	byte 10
	byte 0
LC38
	text 'Status word read: >%X%X'
	byte 10
	byte 0
LC39
	text 'Ready          : yes'
	byte 0
LC40
	text 'no'
	byte 0
LC41
	text 'yes'
	byte 0
LC42
	text 'Erase suspend  : %s'
	byte 10
	byte 0
LC43
	text 'ok'
	byte 0
LC44
	text 'fail'
	byte 0
LC45
	text 'Erase status   : %s'
	byte 10
	byte 0
LC46
	text 'Program status : %s'
	byte 10
	byte 0
LC47
	text 'Write Buf Abort: %s'
	byte 10
	byte 0
LC48
	text 'Program suspend: %s'
	byte 10
	byte 0
LC49
	text 'Sector locked  : %s'
	byte 10
	byte 0
LC50
	text 'Continuity     : %s'
	byte 10
	byte 0
LC51
	text 'Ready          : no'
	byte 0
	even

	def	flashReadStatus
flashReadStatus
	ai   r10, >FFF8
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	li   r1, >1800
	movb r1, @verify
	movb @verify, @>6000
	ai   r10, >FFFA
	li   r2, LC36
	mov  r2, *r10
	li   r1, __FUNCTION__.1497
	mov  r1, @>2(r10)
	li   r2, >18
	mov  r2, @>4(r10)
	li   r9, printf
	bl   *r9
	li   r1, >AAA
	mov  r1, @verifylatch
	li   r2, >7000
	movb r2, @verify
	movb @verify, @>EAAA
	ai   r10, >FFFC
	li   r1, LC37
	mov  r1, *r10
	li   r2, __FUNCTION__.1497
	mov  r2, @>2(r10)
	li   r1, >EA
	mov  r1, @>4(r10)
	li   r2, >AA
	mov  r2, @>6(r10)
	li   r1, >70
	mov  r1, @>8(r10)
	bl   *r9
	li   r2, >1000
	movb r2, @verify
	movb @verify, @>6000
	ai   r10, >4
	li   r1, LC36
	mov  r1, *r10
	li   r2, __FUNCTION__.1497
	mov  r2, @>2(r10)
	li   r1, >10
	mov  r1, @>4(r10)
	bl   *r9
	mov  @>6000, r13
	li   r2, LC38
	mov  r2, *r10
	mov  r13, r1
	srl  r1, >8
	mov  r1, @>2(r10)
	mov  r13, r1
	andi r1, >FF
	mov  r1, @>4(r10)
	bl   *r9
	swpb r13
	ai   r10, >6
	jeq  0
	cb  r13, @$-1
	jlt  L118
	li   r1, LC51
	bl   @puts
L115
	li   r1, >1800
	movb r1, @verify
	movb @verify, @>6000
	ai   r10, >FFFA
	li   r2, LC36
	mov  r2, *r10
	li   r1, __FUNCTION__.1497
	mov  r1, @>2(r10)
	li   r2, >18
	mov  r2, @>4(r10)
	bl   *r9
	li   r1, >AAA
	mov  r1, @verifylatch
	li   r2, >7100
	movb r2, @verify
	movb @verify, @>EAAA
	ai   r10, >FFFC
	li   r1, LC37
	mov  r1, *r10
	li   r2, __FUNCTION__.1497
	mov  r2, @>2(r10)
	li   r1, >EA
	mov  r1, @>4(r10)
	li   r2, >AA
	mov  r2, @>6(r10)
	li   r1, >71
	mov  r1, @>8(r10)
	bl   *r9
	li   r2, >1000
	movb r2, @verify
	movb @verify, @>6000
	ai   r10, >4
	li   r1, LC36
	mov  r1, *r10
	li   r2, __FUNCTION__.1497
	mov  r2, @>2(r10)
	li   r1, >10
	mov  r1, @>4(r10)
	bl   *r9
	ai   r10, >6
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    *r11
L118
	li   r1, LC39
	bl   @puts
	srl  r13, 8
	mov  r13, r1
	andi r1, >40
	jeq  JMP_13
	b    @L106
JMP_13
	li   r1, LC40
	ai   r10, >FFFC
	li   r2, LC42
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	mov  r13, r1
	andi r1, >20
	ai   r10, >4
	ci   r1, 0
	jeq  JMP_14
	b    @L108
JMP_14
L119
	li   r1, LC43
	ai   r10, >FFFC
	li   r2, LC45
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	mov  r13, r1
	andi r1, >10
	ai   r10, >4
	ci   r1, 0
	jeq  JMP_15
	b    @L110
JMP_15
L120
	li   r1, LC43
	ai   r10, >FFFC
	li   r2, LC46
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	mov  r13, r1
	andi r1, >8
	ai   r10, >4
	ci   r1, 0
	jeq  JMP_16
	b    @L112
JMP_16
L121
	li   r1, LC40
	ai   r10, >FFFC
	li   r2, LC47
	mov  r2, *r10
	mov  r1, @>2(r10)
	li   r14, printf
	bl   *r9
	andi r13, >4
	ai   r10, >4
	ci   r13, 0
	jne  JMP_17
	b    @L114
JMP_17
L122
	ai   r10, >FFFC
	li   r2, LC48
	mov  r2, *r10
	li   r1, LC41
	mov  r1, @>2(r10)
	bl   *r14
	li   r2, LC49
	mov  r2, *r10
	li   r1, LC41
	mov  r1, @>2(r10)
	bl   *r14
	li   r1, LC43
	ai   r10, >4
L116
	ai   r10, >FFFC
	li   r2, LC50
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	ai   r10, >4
	b    @L115
L106
	li   r1, LC41
	ai   r10, >FFFC
	li   r2, LC42
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	mov  r13, r1
	andi r1, >20
	ai   r10, >4
	ci   r1, 0
	jne  JMP_18
	b    @L119
JMP_18
L108
	li   r1, LC44
	ai   r10, >FFFC
	li   r2, LC45
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	mov  r13, r1
	andi r1, >10
	ai   r10, >4
	ci   r1, 0
	jne  JMP_19
	b    @L120
JMP_19
L110
	li   r1, LC44
	ai   r10, >FFFC
	li   r2, LC46
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	mov  r13, r1
	andi r1, >8
	ai   r10, >4
	ci   r1, 0
	jne  JMP_20
	b    @L121
JMP_20
L112
	li   r1, LC41
	ai   r10, >FFFC
	li   r2, LC47
	mov  r2, *r10
	mov  r1, @>2(r10)
	li   r14, printf
	bl   *r9
	andi r13, >4
	ai   r10, >4
	ci   r13, 0
	jeq  JMP_21
	b    @L122
JMP_21
L114
	ai   r10, >FFFC
	li   r2, LC48
	mov  r2, *r10
	li   r1, LC40
	mov  r1, @>2(r10)
	bl   *r14
	li   r2, LC49
	mov  r2, *r10
	li   r1, LC40
	mov  r1, @>2(r10)
	bl   *r14
	li   r1, LC40
	ai   r10, >4
	b    @L116
	.size	flashReadStatus, .-flashReadStatus
LC52
	text '%s - latch >%X%X = >%X'
	byte 10
	byte 0
LC53
	text 'Waiting...'
	byte 0
LC54
	text '>%X'
	byte 10
	byte 0
LC55
	text 'Erase operation reports failed'
	byte 0
LC56
	text 'Write operation reports failed'
	byte 0
LC57
	byte 13
	text 'Waiting... >%X != >%X - %ds'
	byte 0
LC58
	byte 10
	text '-- Aborted by keypress'
	byte 0
	even

	def	flashWaitForWrite
flashWaitForWrite
	ai   r10, >FFEE
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r2, r13
	movb r3, r14
	mov  r1, r2
	andi r2, >FFF
	a    r2, r2
	mov  r2, @verifylatch
	ai   r2, >6000
	srl  r1, >4
	andi r1, >300
	ori  r1, >1000
	movb r1, @verify
	movb @verify, *r2
	ai   r10, >FFF6
	li   r3, LC52
	mov  r3, *r10
	li   r4, __FUNCTION__.1556
	mov  r4, @>2(r10)
	mov  r2, r3
	sra  r3, >8
	mov  r3, @>4(r10)
	andi r2, >FF
	mov  r2, @>6(r10)
	srl  r1, 8
	mov  r1, @>8(r10)
	li   r15, printf
	bl   *r15
	ai   r10, >8
	li   r4, LC53
	mov  r4, *r10
	bl   *r15
	ai   r13, >6000
	clr  r3
	inct r10
	movb r14, r7
	srl  r7, 8
	li   r6, kscanfast
	li   r5, >2000
L131
	clr  r2
L136
	movb *r13, r1
	cb   r1, r14
	jeq  L137
	srl  r1, 8
	mov  r1, r9
	andi r9, >20
	jne  L138
	movb @>8802, r4
	jgt  L136
	jeq  L136
	inc  r2
	ci   r2, >3C
	jne  L136
	inc  r3
	ai   r10, >FFF8
	li   r4, LC57
	mov  r4, *r10
	mov  r1, @>2(r10)
	mov  r7, @>4(r10)
	mov  r3, @>6(r10)
	mov  r3, @>12(r10)
	mov  r5, @>18(r10)
	mov  r6, @>16(r10)
	mov  r7, @>14(r10)
	bl   *r15
	ai   r10, >8
	mov  r9, r1
	mov  @>E(r10), r6
	bl   *r6
	movb @>8375, r1
	mov  @>10(r10), r5
	mov  @>A(r10), r3
	mov  @>E(r10), r6
	mov  @>C(r10), r7
	cb   r1, r5
	jne  L131
	li   r1, LC58
	bl   @puts
	mov  r9, r1
	jmp  L125
L137
	li   r1, >A
	bl   @putchar
	li   r1, >1
L125
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >A
	b    *r11
	jmp  L139
L138
	movb *r13, r1
	cb   r1, r14
	jeq  L140
	movb r1, r9
	srl  r9, 8
	ai   r10, >FFFC
	li   r1, LC54
	mov  r1, *r10
	mov  r9, @>2(r10)
	bl   *r15
	andi r9, >8
	ai   r10, >4
	ci   r9, 0
	jeq  L128
	li   r1, LC55
	bl   @puts
	bl   @flashReadStatus
	clr  r1
L141
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >A
	b    *r11
	jmp  L139
L128
	li   r1, LC56
	bl   @puts
	bl   @flashReadStatus
	clr  r1
	jmp  L141
L140
	li   r1, >1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >A
	b    *r11
L139
	.size	flashWaitForWrite, .-flashWaitForWrite
LC59
	text 'Flash CFI information:'
	byte 0
LC60
	text 'Did NOT get QRY string: %c%c%c'
	byte 10
	byte 0
LC61
	text 'Device size: 2^%d bytes'
	byte 0
LC62
	text ' [small]'
	byte 0
LC63
	text 'Device reports 16-bit only!'
	byte 0
LC64
	text 'Vcc Min/Max: %d.%d / %d.%d V'
	byte 10
	byte 0
LC65
	text 'Timeout: Word write: %d uS'
	byte 10
	byte 0
LC66
	text '         Chip erase: 2^%d mS'
	byte 10
	byte 0
LC67
	text 'Max multi-byte write size: %d bytes'
	byte 10
	byte 0
LC68
	text 'Did NOT get PRI or not at 0x40: %c%c%c'
	byte 10
	byte 0
LC69
	text 'CFI version 1.%d'
	byte 10
	byte 0
LC70
	text 'Process: '
	byte 0
LC71
	text '.23um floating'
	byte 0
LC72
	text '.17us floating'
	byte 0
LC73
	text '.23um MirrorBit'
	byte 0
LC74
	text '.13um floating'
	byte 0
LC75
	text '.11um MirrorBit'
	byte 0
LC76
	text '.09um MirrorBit'
	byte 0
LC77
	text '.09um floating'
	byte 0
LC78
	text '.065um MirrorBit Ec'
	byte 0
LC79
	text '.065um MirrorBit'
	byte 0
LC80
	text '0.045um MirrorBit'
	byte 0
LC81
	text 'unknown: %d'
	byte 10
	byte 0
LC82
	text 'WP# pin: '
	byte 0
LC83
	text 'none'
	byte 0
LC84
	text '64kb dual boot'
	byte 0
LC85
	text 'bottom boot'
	byte 0
LC86
	text 'top boot'
	byte 0
LC87
	text 'uniform bottom boot'
	byte 0
LC88
	text 'uniform top boot'
	byte 0
LC89
	text 'all sectors'
	byte 0
LC90
	text 'uniform dual'
	byte 0
LC91
	text 'un'
	byte 0
LC92
	byte 0
LC93
	text 'Customer OTP area: 2^%d (%slocked)'
	byte 10
	byte 0
LC94
	text 'Page size = %d bytes'
	byte 10
	byte 0
LC95
	text 'Page size not available pre 1.5'
	byte 0
	even

	def	flashReadCfi
flashReadCfi
	ai   r10, >FFF6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	li   r14, puts
	li   r1, LC59
	bl   *r14
	li   r1, >1800
	movb r1, @verify
	movb @verify, @>6000
	ai   r10, >FFFA
	li   r2, LC36
	mov  r2, *r10
	li   r3, __FUNCTION__.1362
	mov  r3, @>2(r10)
	li   r4, >18
	mov  r4, @>4(r10)
	li   r9, printf
	bl   *r9
	li   r1, >AA
	mov  r1, @verifylatch
	li   r2, >9800
	movb r2, @verify
	movb @verify, @>E0AA
	ai   r10, >FFFC
	li   r3, LC37
	mov  r3, *r10
	li   r4, __FUNCTION__.1362
	mov  r4, @>2(r10)
	li   r1, >E0
	mov  r1, @>4(r10)
	li   r2, >AA
	mov  r2, @>6(r10)
	li   r3, >98
	mov  r3, @>8(r10)
	bl   *r9
	li   r4, >1000
	movb r4, @verify
	movb @verify, @>6000
	ai   r10, >4
	li   r1, LC36
	mov  r1, *r10
	li   r2, __FUNCTION__.1362
	mov  r2, @>2(r10)
	li   r3, >10
	mov  r3, @>4(r10)
	bl   *r9
	clr  r1
	ai   r10, >6
L143
	mov  r1, r2
	ai   r2, >6000
	movb *r2, @buffer(r1)
	inc  r1
	ci   r1, >200
	jne  L143
	li   r4, >1800
	movb r4, @verify
	movb @verify, @>6000
	ai   r10, >FFFA
	li   r1, LC36
	mov  r1, *r10
	li   r2, __FUNCTION__.1362
	mov  r2, @>2(r10)
	li   r3, >18
	mov  r3, @>4(r10)
	bl   *r9
	li   r4, >AA
	mov  r4, @verifylatch
	li   r1, >F000
	movb r1, @verify
	movb @verify, @>E0AA
	ai   r10, >FFFC
	li   r2, LC37
	mov  r2, *r10
	li   r3, __FUNCTION__.1362
	mov  r3, @>2(r10)
	li   r4, >E0
	mov  r4, @>4(r10)
	li   r1, >AA
	mov  r1, @>6(r10)
	li   r2, >F0
	mov  r2, @>8(r10)
	bl   *r9
	li   r3, >1000
	movb r3, @verify
	movb @verify, @>6000
	ai   r10, >4
	li   r4, LC36
	mov  r4, *r10
	li   r1, __FUNCTION__.1362
	mov  r1, @>2(r10)
	li   r2, >10
	mov  r2, @>4(r10)
	bl   *r9
	movb @buffer+32, r2
	ai   r10, >6
	li   r1, >5100
	cb   r2, r1
	jne  JMP_22
	b    @L144
JMP_22
	movb @buffer+34, r1
	movb @buffer+36, r3
L145
	ai   r10, >FFF8
	li   r4, LC60
	mov  r4, *r10
	srl  r2, 8
	mov  r2, @>2(r10)
	srl  r1, 8
	mov  r1, @>4(r10)
	srl  r3, 8
	mov  r3, @>6(r10)
	bl   *r9
	li   r15, >1
	ai   r10, >8
L147
	ai   r10, >FFFC
	li   r1, LC61
	mov  r1, *r10
	movb @buffer+78, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   *r9
	ai   r10, >4
	li   r1, >1B00
	cb   @buffer+78, r1
	jeq  L148
	dect r10
	li   r2, LC62
	mov  r2, *r10
	bl   @printf
	inct r10
L148
	li   r13, putchar
	li   r1, >A
	bl   *r13
	li   r1, >100
	cb   @buffer+80, r1
	jne  JMP_23
	b    @L202
JMP_23
L149
	movb @buffer+54, r2
	movb @buffer+56, r1
	ai   r10, >FFF6
	li   r3, LC64
	mov  r3, *r10
	movb r2, r3
	srl  r3, >4
	srl  r3, 8
	mov  r3, @>2(r10)
	srl  r2, 8
	andi r2, >F
	mov  r2, @>4(r10)
	movb r1, r2
	srl  r2, >4
	srl  r2, 8
	mov  r2, @>6(r10)
	srl  r1, 8
	andi r1, >F
	mov  r1, @>8(r10)
	bl   *r9
	movb @buffer+62, r3
	srl  r3, 8
	ai   r10, >A
	ci   r3, 0
	jne  JMP_24
	b    @L203
JMP_24
	clr  r2
	li   r1, >1
L152
	a    r1, r1
	inc  r2
	c    r2, r3
	jlt  L152
L151
	ai   r10, >FFFC
	li   r3, LC65
	mov  r3, *r10
	mov  r1, @>2(r10)
	bl   *r9
	li   r4, LC66
	mov  r4, *r10
	movb @buffer+68, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   *r9
	movb @buffer+84, r3
	srl  r3, 8
	ai   r10, >4
	ci   r3, 0
	jne  JMP_25
	b    @L204
JMP_25
	clr  r2
	li   r1, >1
L155
	a    r1, r1
	inc  r2
	c    r2, r3
	jlt  L155
L154
	ai   r10, >FFFC
	li   r2, LC67
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	ai   r10, >4
	li   r1, >4000
	cb   @buffer+42, r1
	jne  JMP_26
	b    @L156
JMP_26
	movb @buffer+128, r1
	movb @buffer+130, r3
	movb @buffer+132, r2
L157
	ai   r10, >FFF8
	li   r4, LC68
	mov  r4, *r10
	srl  r1, 8
	mov  r1, @>2(r10)
	srl  r3, 8
	mov  r3, @>4(r10)
	srl  r2, 8
	mov  r2, @>6(r10)
	bl   *r9
	ai   r10, >8
L160
	ai   r10, >FFFC
	li   r1, LC69
	mov  r1, *r10
	movb @buffer+136, r1
	srl  r1, 8
	andi r1, >F
	mov  r1, @>2(r10)
	bl   *r9
	inct r10
	li   r3, LC70
	mov  r3, *r10
	bl   *r9
	movb @buffer+138, r1
	srl  r1, >2
	srl  r1, 8
	andi r1, >F
	inct r10
	ci   r1, >9
	jh  JMP_27
	b    @L205
JMP_27
	ai   r10, >FFFC
	li   r3, LC81
	mov  r3, *r10
	mov  r1, @>2(r10)
	bl   @printf
	ai   r10, >4
L173
	dect r10
	li   r4, LC82
	mov  r4, *r10
	bl   *r9
	movb @buffer+158, r1
	inct r10
	ci   r1, >7FF
	jh  JMP_28
	b    @L206
JMP_28
	ai   r10, >FFFC
	li   r3, LC81
	mov  r3, *r10
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   @printf
	ai   r10, >4
L184
	li   r1, >3400
	cb   @buffer+136, r1
	jh  JMP_29
	b    @L185
JMP_29
	movb @buffer+164, r2
	movb @buffer+6, r1
	srl  r1, 8
	andi r1, >40
	ci   r1, 0
	jeq  JMP_30
	b    @L186
JMP_30
	li   r3, LC91
L187
	ai   r10, >FFFA
	li   r1, LC93
	mov  r1, *r10
	movb r2, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	mov  r3, @>4(r10)
	bl   *r9
	movb @buffer+168, r3
	srl  r3, 8
	ai   r10, >6
	ci   r3, 0
	jne  JMP_31
	b    @L207
JMP_31
	li   r1, >1
	clr  r2
L190
	a    r1, r1
	inc  r2
	c    r2, r3
	jlt  L190
L189
	ai   r10, >FFFC
	li   r2, LC94
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	ai   r10, >4
L191
	ci   r15, 0
	jne  JMP_32
	b    @L196
JMP_32
	li   r9, buffer
	li   r14, >5A00
	jmp  L195
L209
	srl  r1, 8
	bl   *r13
	inc  r9
	ci   r9, buffer+512
	jeq  L208
L195
	movb *r9, r1
	movb r1, r2
	ai   r2, >E000
	cb   r2, r14
	jle  L209
	li   r1, >20
	bl   *r13
	inc  r9
	ci   r9, buffer+512
	jne  L195
L208
	li   r1, >A
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @putchar
L206
	srl  r1, 8
	a    r1, r1
	mov  @L183(r1), r2
	b    *r2
	even
L183
		data		L175
		data		L176
		data		L177
		data		L178
		data		L179
		data		L180
		data		L181
		data		L182
L205
	a    r1, r1
	mov  @L172(r1), r2
	b    *r2
	even
L172
		data		L162
		data		L163
		data		L164
		data		L165
		data		L166
		data		L167
		data		L168
		data		L169
		data		L170
		data		L171
L186
	li   r3, LC92
	b    @L187
L144
	movb @buffer+34, r1
	li   r3, >5200
	cb   r1, r3
	jne  JMP_33
	b    @L146
JMP_33
	movb @buffer+36, r3
	b    @L145
L156
	movb @buffer+128, r1
	li   r2, >5000
	cb   r1, r2
	jne  JMP_34
	b    @L158
JMP_34
	movb @buffer+130, r3
	movb @buffer+132, r2
	b    @L157
L196
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L185
	li   r1, LC95
	bl   *r14
	b    @L191
L181
	li   r1, LC89
	bl   *r14
	b    @L184
L182
	li   r1, LC90
	bl   *r14
	b    @L184
L175
	li   r1, LC83
	bl   *r14
	b    @L184
L176
	li   r1, LC84
	bl   *r14
	b    @L184
L177
	li   r1, LC85
	bl   *r14
	b    @L184
L178
	li   r1, LC86
	bl   *r14
	b    @L184
L179
	li   r1, LC87
	bl   *r14
	b    @L184
L180
	li   r1, LC88
	bl   *r14
	b    @L184
L171
	li   r1, LC80
	bl   *r14
	b    @L173
L170
	li   r1, LC79
	bl   *r14
	b    @L173
L162
	li   r1, LC71
	bl   *r14
	b    @L173
L163
	li   r1, LC72
	bl   *r14
	b    @L173
L164
	li   r1, LC73
	bl   *r14
	b    @L173
L165
	li   r1, LC74
	bl   *r14
	b    @L173
L166
	li   r1, LC75
	bl   *r14
	b    @L173
L167
	li   r1, LC76
	bl   *r14
	b    @L173
L168
	li   r1, LC77
	bl   *r14
	b    @L173
L169
	li   r1, LC78
	bl   *r14
	b    @L173
L202
	li   r1, LC63
	bl   *r14
	b    @L149
L158
	movb @buffer+130, r3
	li   r2, >5200
	cb   r3, r2
	jeq  L159
	movb @buffer+132, r2
	b    @L157
L146
	movb @buffer+36, r3
	li   r4, >5900
	cb   r3, r4
	jeq  JMP_35
	b    @L145
JMP_35
	clr  r15
	b    @L147
L203
	li   r1, >1
	b    @L151
L204
	li   r1, >1
	b    @L154
L207
	li   r1, >1
	b    @L189
L159
	movb @buffer+132, r2
	li   r4, >4900
	cb   r2, r4
	jeq  JMP_36
	b    @L157
JMP_36
	b    @L160
	.size	flashReadCfi, .-flashReadCfi
	even

	def	flashUnlock
flashUnlock
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	li   r1, >1800
	movb r1, @verify
	movb @verify, r1
	li   r13, >6000
	movb r1, *r13
	ai   r10, >FFFA
	li   r1, LC36
	mov  r1, *r10
	li   r1, __FUNCTION__.1351
	mov  r1, @>2(r10)
	li   r1, >18
	mov  r1, @>4(r10)
	li   r9, printf
	bl   *r9
	li   r1, >AAA
	mov  r1, @verifylatch
	li   r1, >AA00
	movb r1, @verify
	movb @verify, @>EAAA
	ai   r10, >FFFC
	li   r1, LC37
	mov  r1, *r10
	li   r1, __FUNCTION__.1351
	mov  r1, @>2(r10)
	li   r1, >EA
	mov  r1, @>4(r10)
	li   r1, >AA
	mov  r1, @>6(r10)
	mov  r1, @>8(r10)
	bl   *r9
	li   r1, >1400
	movb r1, @verify
	movb @verify, *r13
	ai   r10, >4
	li   r1, LC36
	mov  r1, *r10
	li   r1, __FUNCTION__.1351
	mov  r1, @>2(r10)
	li   r1, >14
	mov  r1, @>4(r10)
	bl   *r9
	li   r1, >555
	mov  r1, @verifylatch
	li   r1, >5500
	movb r1, @verify
	movb @verify, @>E555
	ai   r10, >FFFC
	li   r1, LC37
	mov  r1, *r10
	li   r1, __FUNCTION__.1351
	mov  r1, @>2(r10)
	li   r1, >E5
	mov  r1, @>4(r10)
	li   r1, >55
	mov  r1, @>6(r10)
	mov  r1, @>8(r10)
	bl   *r9
	ai   r10, >A
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	.size	flashUnlock, .-flashUnlock
LC96
	text 'Erasing flash chip...'
	byte 0
	even

	def	flashChipErase
flashChipErase
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	li   r1, LC96
	bl   @puts
	li   r13, flashUnlock
	bl   *r13
	li   r1, >1800
	movb r1, @verify
	movb @verify, @>6000
	ai   r10, >FFFA
	li   r1, LC36
	mov  r1, *r10
	li   r1, __FUNCTION__.1746
	mov  r1, @>2(r10)
	li   r1, >18
	mov  r1, @>4(r10)
	li   r9, printf
	bl   *r9
	li   r1, >AAA
	mov  r1, @verifylatch
	li   r1, >8000
	movb r1, @verify
	movb @verify, @>EAAA
	ai   r10, >FFFC
	li   r1, LC37
	mov  r1, *r10
	li   r1, __FUNCTION__.1746
	mov  r1, @>2(r10)
	li   r1, >EA
	mov  r1, @>4(r10)
	li   r1, >AA
	mov  r1, @>6(r10)
	li   r1, >80
	mov  r1, @>8(r10)
	bl   *r9
	ai   r10, >A
	bl   *r13
	li   r1, >1800
	movb r1, @verify
	movb @verify, @>6000
	ai   r10, >FFFA
	li   r1, LC36
	mov  r1, *r10
	li   r1, __FUNCTION__.1746
	mov  r1, @>2(r10)
	li   r1, >18
	mov  r1, @>4(r10)
	bl   *r9
	li   r1, >AAA
	mov  r1, @verifylatch
	li   r1, >1000
	movb r1, @verify
	movb @verify, @>EAAA
	ai   r10, >FFFC
	li   r1, LC37
	mov  r1, *r10
	li   r1, __FUNCTION__.1746
	mov  r1, @>2(r10)
	li   r1, >EA
	mov  r1, @>4(r10)
	li   r1, >AA
	mov  r1, @>6(r10)
	li   r1, >10
	mov  r1, @>8(r10)
	bl   *r9
	ai   r10, >A
	clr  r1
	mov  r1, r2
	seto r3
	bl   @flashWaitForWrite
	ci   r1, 0
	jeq  L213
	li   r1, >1
L213
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	.size	flashChipErase, .-flashChipErase
LC97
	text 'Sector erase page %d is not 128k aligned'
	byte 10
	byte 0
LC98
	text 'Erasing sector %d'
	byte 10
	byte 0
	even

	def	flashSectorErase
flashSectorErase
	ai   r10, >FFF4
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r1, r9
	mov  r1, r13
	andi r13, >F
	jeq  JMP_37
	b    @L219
JMP_37
	mov  r9, r15
	andi r15, >FFF
	a    r15, r15
	ai   r10, >FFFC
	li   r2, LC98
	mov  r2, *r10
	mov  r9, @>2(r10)
	li   r14, printf
	bl   *r14
	ai   r10, >4
	li   r2, flashUnlock
	mov  r2, @>A(r10)
	bl   *r2
	li   r1, >1800
	movb r1, @verify
	movb @verify, @>6000
	ai   r10, >FFFA
	li   r1, LC36
	mov  r1, *r10
	li   r1, __FUNCTION__.1718
	mov  r1, @>2(r10)
	li   r1, >18
	mov  r1, @>4(r10)
	bl   *r14
	li   r1, >AAA
	mov  r1, @verifylatch
	li   r1, >8000
	movb r1, @verify
	movb @verify, @>EAAA
	ai   r10, >FFFC
	li   r1, LC37
	mov  r1, *r10
	li   r1, __FUNCTION__.1718
	mov  r1, @>2(r10)
	li   r1, >EA
	mov  r1, @>4(r10)
	li   r1, >AA
	mov  r1, @>6(r10)
	li   r1, >80
	mov  r1, @>8(r10)
	bl   *r14
	ai   r10, >A
	mov  @>A(r10), r2
	bl   *r2
	mov  r15, @verifylatch
	ai   r15, >6000
	mov  r9, r1
	srl  r1, >4
	andi r1, >300
	ori  r1, >1800
	movb r1, @verify
	movb @verify, *r15
	ai   r10, >FFF6
	li   r2, LC52
	mov  r2, *r10
	li   r2, __FUNCTION__.1718
	mov  r2, @>2(r10)
	mov  r15, r2
	sra  r2, >8
	mov  r2, @>4(r10)
	andi r15, >FF
	mov  r15, @>6(r10)
	srl  r1, 8
	mov  r1, @>8(r10)
	bl   *r14
	mov  r13, @verifylatch
	li   r1, >3000
	movb r1, @verify
	movb @verify, @>E000
	li   r2, LC37
	mov  r2, *r10
	li   r1, __FUNCTION__.1718
	mov  r1, @>2(r10)
	li   r2, >E0
	mov  r2, @>4(r10)
	mov  r13, @>6(r10)
	li   r1, >30
	mov  r1, @>8(r10)
	bl   *r14
	ai   r10, >A
	mov  r9, r1
	mov  r13, r2
	seto r3
	bl   @flashWaitForWrite
	ci   r1, 0
	jeq  L217
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	inct r10
	b    *r11
	jmp  L220
L219
	ai   r10, >FFFC
	li   r2, LC97
	mov  r2, *r10
	mov  r9, @>2(r10)
	bl   @printf
	ai   r10, >4
L217
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	inct r10
	b    *r11
L220
	.size	flashSectorErase, .-flashSectorErase
LC99
	text 'Writing page 0x%d, address 0x%X%X'
	byte 10
	byte 0
	even

	def	flashWriteSlow
flashWriteSlow
	ai   r10, >FFE6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r1, @>C(r10)
	mov  r2, r14
	andi r1, >FFF
	a    r1, r1
	mov  r1, @>A(r10)
	mov  @>C(r10), r9
	srl  r9, >4
	andi r9, >300
	ai   r10, >FFF8
	li   r4, LC99
	mov  r4, *r10
	mov  @>14(r10), @>2(r10)
	mov  r14, r3
	srl  r3, >8
	mov  r3, @>4(r10)
	mov  r14, r1
	andi r1, >FF
	mov  r1, @>6(r10)
	li   r3, printf
	bl   *r3
	mov  @>12(r10), r4
	ai   r4, >6000
	mov  r4, @>16(r10)
	mov  r4, r2
	sra  r2, >8
	li   r13, buffer
	mov  r14, r15
	ai   r15, >E000
	ai   r10, >8
	movb r9, r1
	ori  r1, >1800
	movb r1, @>12(r10)
	andi r4, >FF
	mov  r4, @>10(r10)
	movb r1, r4
	srl  r4, 8
	mov  r4, @>14(r10)
	ori  r9, >1400
	movb r9, r1
	srl  r1, 8
	mov  r1, @>16(r10)
	movb r9, @>18(r10)
	mov  r2, r9
	jmp  L227
L230
	mov  @>A(r10), @verifylatch
	movb @>18(r10), @verify
	movb @verify, r3
	mov  @>E(r10), r4
	movb r3, *r4
	ai   r10, >FFF6
	li   r1, LC52
	mov  r1, *r10
	li   r2, __FUNCTION__.1670
	mov  r2, @>2(r10)
	mov  r9, @>4(r10)
	mov  @>1A(r10), @>6(r10)
	mov  @>20(r10), @>8(r10)
	li   r3, printf
	bl   *r3
	ai   r10, >A
L223
	mov  r14, @verifylatch
	movb *r13, @verify
	movb @verify, *r15
	ai   r10, >FFF6
	li   r3, LC37
	mov  r3, *r10
	li   r4, __FUNCTION__.1670
	mov  r4, @>2(r10)
	mov  r15, r3
	srl  r3, >8
	mov  r3, @>4(r10)
	mov  r15, r1
	andi r1, >FF
	mov  r1, @>6(r10)
	movb *r13, r3
	srl  r3, 8
	mov  r3, @>8(r10)
	li   r3, printf
	bl   *r3
	ai   r10, >A
	mov  @>C(r10), r1
	mov  r14, r2
	movb *r13, r3
	li   r4, flashWaitForWrite
	bl   *r4
	ci   r1, 0
	jne  JMP_38
	b    @L226
JMP_38
	inc  r13
	inc  r15
	ci   r13, buffer+512
	jeq  L229
	inc  r14
L227
	li   r4, flashUnlock
	bl   *r4
	li   r1, >1800
	movb r1, @verify
	movb @verify, @>6000
	ai   r10, >FFFA
	li   r2, LC36
	mov  r2, *r10
	li   r3, __FUNCTION__.1670
	mov  r3, @>2(r10)
	li   r4, >18
	mov  r4, @>4(r10)
	li   r2, printf
	bl   *r2
	li   r3, >AAA
	mov  r3, @verifylatch
	li   r4, >A000
	movb r4, @verify
	movb @verify, @>EAAA
	ai   r10, >FFFC
	li   r1, LC37
	mov  r1, *r10
	li   r2, __FUNCTION__.1670
	mov  r2, @>2(r10)
	li   r3, >EA
	mov  r3, @>4(r10)
	li   r4, >AA
	mov  r4, @>6(r10)
	li   r1, >A0
	mov  r1, @>8(r10)
	li   r2, printf
	bl   *r2
	mov  r14, r3
	andi r3, >1
	ai   r10, >A
	ci   r3, 0
	jeq  JMP_39
	b    @L230
JMP_39
	mov  @>A(r10), @verifylatch
	movb @>12(r10), @verify
	movb @verify, r3
	mov  @>E(r10), r2
	movb r3, *r2
	ai   r10, >FFF6
	li   r3, LC52
	mov  r3, *r10
	li   r4, __FUNCTION__.1670
	mov  r4, @>2(r10)
	mov  r9, @>4(r10)
	mov  @>1A(r10), @>6(r10)
	mov  @>1E(r10), @>8(r10)
	li   r2, printf
	bl   *r2
	ai   r10, >A
	b    @L223
L229
	li   r1, >1
L226
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >12
	b    *r11
	.size	flashWriteSlow, .-flashWriteSlow
LC100
	text '* Can''t write to unaligned address: %X%X'
	byte 10
	byte 0
LC101
	text 'WRITING page %d, address 0x%X%X'
	byte 10
	byte 0
LC102
	text '%s - write >%X%X = >%X%X'
	byte 10
	byte 0
	even

	def	flashWriteFast
flashWriteFast
	ai   r10, >FFD8
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r1, @>1E(r10)
	mov  r2, r14
	mov  r2, r15
	andi r15, >1F
	jeq  JMP_40
	b    @L241
JMP_40
	mov  @>1E(r10), r4
	andi r4, >FFF
	a    r4, r4
	mov  r4, @>A(r10)
	mov  @>1E(r10), r9
	srl  r9, >4
	andi r9, >300
	mov  r14, r13
	andi r13, >1000
	mov  r13, r4
	ai   r4, >555
	mov  r4, @>18(r10)
	ai   r10, >FFF8
	li   r1, LC101
	mov  r1, *r10
	mov  @>26(r10), @>2(r10)
	mov  r14, r3
	srl  r3, >8
	mov  r3, @>4(r10)
	mov  r14, r2
	andi r2, >FF
	mov  r2, @>6(r10)
	li   r4, printf
	bl   *r4
	mov  @>12(r10), r1
	ai   r1, >6000
	mov  r1, @>16(r10)
	movb r9, r2
	ori  r2, >1400
	movb r2, @>22(r10)
	sra  r1, >8
	mov  r1, @>1E(r10)
	mov  @>16(r10), r3
	andi r3, >FF
	mov  r3, @>18(r10)
	movb r2, r1
	srl  r1, 8
	mov  r1, @>24(r10)
	ai   r13, >E555
	mov  r13, @>14(r10)
	mov  r13, r2
	srl  r2, >8
	mov  r2, @>1A(r10)
	mov  r13, r3
	andi r3, >FF
	mov  r3, @>1C(r10)
	ori  r9, >1C00
	movb r9, @>28(r10)
	movb r9, r1
	srl  r1, 8
	mov  r1, @>2C(r10)
	mov  r14, r2
	ai   r2, >1E
	mov  r2, @>2A(r10)
	ai   r10, >8
	ai   r14, >DFE0
	mov  r14, @>26(r10)
L237
	li   r3, flashUnlock
	bl   *r3
	mov  @>A(r10), @verifylatch
	movb @>1A(r10), @verify
	movb @verify, r3
	mov  @>E(r10), r2
	movb r3, *r2
	ai   r10, >FFF6
	li   r3, LC52
	mov  r3, *r10
	li   r4, __FUNCTION__.1608
	mov  r4, @>2(r10)
	mov  @>20(r10), @>4(r10)
	mov  @>1A(r10), @>6(r10)
	mov  @>26(r10), @>8(r10)
	li   r2, printf
	bl   *r2
	mov  @>22(r10), @verifylatch
	li   r3, >2500
	movb r3, @verify
	movb @verify, r3
	mov  @>16(r10), r4
	movb r3, *r4
	li   r1, LC37
	mov  r1, *r10
	li   r2, __FUNCTION__.1608
	mov  r2, @>2(r10)
	mov  @>1C(r10), @>4(r10)
	mov  @>1E(r10), @>6(r10)
	li   r3, >25
	mov  r3, @>8(r10)
	li   r4, printf
	bl   *r4
	mov  @>22(r10), @verifylatch
	li   r1, >1F00
	movb r1, @verify
	movb @verify, r3
	mov  @>16(r10), r2
	movb r3, *r2
	li   r3, LC37
	mov  r3, *r10
	li   r4, __FUNCTION__.1608
	mov  r4, @>2(r10)
	mov  @>1C(r10), @>4(r10)
	mov  @>1E(r10), @>6(r10)
	li   r1, >1F
	mov  r1, @>8(r10)
	li   r2, printf
	bl   *r2
	mov  @>14(r10), @verifylatch
	movb @>2A(r10), @verify
	movb @verify, r3
	mov  @>18(r10), r4
	movb r3, *r4
	li   r1, LC52
	mov  r1, *r10
	li   r2, __FUNCTION__.1608
	mov  r2, @>2(r10)
	mov  @>20(r10), @>4(r10)
	mov  @>1A(r10), @>6(r10)
	mov  @>2E(r10), @>8(r10)
	li   r3, printf
	bl   *r3
	mov  r15, r13
	ai   r15, >20
	ai   r10, >A
	c    r13, r15
	jhe  L234
	mov  r15, r14
	ai   r14, buffer-32
	mov  @>26(r10), r9
	a    r15, r9
L235
	mov  *r14+, r2
	mov  r2, *r9
	ai   r10, >FFF4
	li   r4, LC102
	mov  r4, *r10
	li   r1, __FUNCTION__.1608
	mov  r1, @>2(r10)
	mov  r9, r1
	srl  r1, >8
	mov  r1, @>4(r10)
	mov  r9, r3
	andi r3, >FF
	mov  r3, @>6(r10)
	mov  r2, r1
	srl  r1, >8
	mov  r1, @>8(r10)
	andi r2, >FF
	mov  r2, @>A(r10)
	li   r2, printf
	bl   *r2
	inct r13
	inct r9
	ai   r10, >C
	c    r15, r13
	jh  L235
L234
	mov  @>A(r10), @verifylatch
	movb @>1A(r10), @verify
	movb @verify, r3
	mov  @>E(r10), r1
	movb r3, *r1
	ai   r10, >FFF6
	li   r2, LC52
	mov  r2, *r10
	li   r3, __FUNCTION__.1608
	mov  r3, @>2(r10)
	mov  @>20(r10), @>4(r10)
	mov  @>1A(r10), @>6(r10)
	mov  @>26(r10), @>8(r10)
	li   r4, printf
	bl   *r4
	mov  @>22(r10), @verifylatch
	li   r1, >2900
	movb r1, @verify
	movb @verify, r3
	mov  @>16(r10), r2
	movb r3, *r2
	li   r3, LC37
	mov  r3, *r10
	li   r4, __FUNCTION__.1608
	mov  r4, @>2(r10)
	mov  @>1C(r10), @>4(r10)
	mov  @>1E(r10), @>6(r10)
	li   r1, >29
	mov  r1, @>8(r10)
	li   r2, printf
	bl   *r2
	ai   r10, >A
	mov  @>1E(r10), r1
	mov  @>22(r10), r2
	movb @buffer+30, r3
	li   r4, flashWaitForWrite
	bl   *r4
	ci   r1, 0
	jeq  L233
	ci   r15, >200
	jeq  JMP_41
	b    @L237
JMP_41
	li   r1, >1
L233
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >20
	b    *r11
	jmp  L242
L241
	ai   r10, >FFFA
	li   r2, LC100
	mov  r2, *r10
	mov  r14, r1
	srl  r1, >8
	mov  r1, @>2(r10)
	andi r14, >FF
	mov  r14, @>4(r10)
	bl   @printf
	clr  r1
	ai   r10, >6
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >20
	b    *r11
L242
	.size	flashWriteFast, .-flashWriteFast
	even

	def	flashReset
flashReset
	ai   r10, >FFF8
	mov  r11, @>6(r10)
	clr  r1
	movb r1, @verify
	movb @verify, @>6000
	li   r1, LC36
	mov  r1, *r10
	li   r1, __FUNCTION__.1346
	mov  r1, @>2(r10)
	clr  @>4(r10)
	bl   @printf
	ai   r10, >6
	mov  *r10+, r11
	b    *r11
	.size	flashReset, .-flashReset
LC103
	text 'CF7 to Seahorse board programmer'
	byte 10
	byte 0
LC104
	byte 10
	text 'Press:'
	byte 0
LC105
	text '  C to read flash CFI'
	byte 0
LC106
	text '  F to test flash fast write'
	byte 0
LC107
	text '  S to test flash slow write'
	byte 0
LC108
	text '  X to test sector erase'
	byte 0
LC109
	text '  E to test flash erase'
	byte 0
LC110
	text '  I for flash status info'
	byte 0
LC111
	text '  R to put flash in reset'
	byte 0
LC112
	byte 10
	text '  1 to reset CF7'
	byte 0
LC113
	text '  2 to read CF info'
	byte 0
LC114
	text '  3 to read CF7'
	byte 0
LC115
	text '  4 to write CF7 (destructive!)'
	byte 0
LC116
	text '  5 to check CF card error'
	byte 0
LC117
	byte 10
	text '  Q to quit'
	byte 0
LC118
	text 'Fast: Page 16, address 512'
	byte 0
LC119
	text 'Failed!'
	byte 0
LC120
	text 'Slow: Page 16, address 1024'
	byte 0
LC121
	text 'Mike was here'
	byte 0
LC122
	text 'Press a key...'
	byte 0
	even

	def	main
main
	ai   r10, >FFF4
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	bl   @set_text_raw
	mov  r1, r9
	bl   @charsetlc
	mov  r9, r1
	swpb r1
	movb r1, @>8C02
	li   r2, >8100
	movb r2, @>8C02
	movb r1, @>83D4
	li   r1, >1787
	movb r1, @>8C02
	swpb r1
	movb r1, @>8C02
	li   r2, fast_scrn_scroll
	mov  r2, @scrn_scroll
	li   r4, flashReset
	bl   *r4
* Begin inline assembler code
* 518 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r1, >100
	movb r1, @>5F03
	clr  r2
	movb r2, @>5F05
	movb r2, @>5F0D
	li   r4, >EF00
	movb r4, @>5F0F
* Begin inline assembler code
* 525 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r14, puts
	li   r1, LC103
	bl   *r14
	clr  r1
L246
	mov  r1, r2
	swpb r2
	movb r2, @buffer(r1)
	inc  r1
	ci   r1, >200
	jne  L246
	clr  r1
	mov  r1, @>A(r10)
	li   r15, >5A00
L291
	li   r1, LC104
	bl   *r14
	li   r1, LC105
	bl   *r14
	li   r1, LC106
	bl   *r14
	li   r1, LC107
	bl   *r14
	li   r1, LC108
	bl   *r14
	li   r1, LC109
	bl   *r14
	li   r1, LC110
	bl   *r14
	li   r1, LC111
	bl   *r14
	li   r1, LC112
	bl   *r14
	li   r1, LC113
	bl   *r14
	li   r1, LC114
	bl   *r14
	li   r1, LC115
	bl   *r14
	li   r1, LC116
	bl   *r14
	li   r1, LC117
	bl   *r14
L290
	clr  r1
	li   r2, kscanfast
	bl   *r2
	movb @>8375, r1
	ai   r1, >CF00
	ci   r1, >27FF
	jh  L290
	srl  r1, 8
	a    r1, r1
	mov  @L261(r1), r2
	b    *r2
	even
L261
		data		L248
		data		L249
		data		L250
		data		L251
		data		L252
		data		L290
		data		L290
		data		L290
		data		L290
		data		L290
		data		L290
		data		L290
		data		L290
		data		L290
		data		L290
		data		L290
		data		L290
		data		L290
		data		L253
		data		L290
		data		L254
		data		L255
		data		L290
		data		L290
		data		L256
		data		L290
		data		L290
		data		L290
		data		L290
		data		L290
		data		L290
		data		L290
		data		L257
		data		L258
		data		L259
		data		L290
		data		L290
		data		L290
		data		L290
		data		L260
L260
	li   r1, >10
	bl   @flashSectorErase
	ci   r1, 0
	jne  L292
L275
	li   r1, LC119
	bl   *r14
L262
	li   r1, LC122
	bl   *r14
	seto r2
	movb r2, @>8375
	movb @>8375, r1
	cb   r1, r2
	jeq  JMP_42
	b    @L291
JMP_42
L281
	clr  r1
	li   r4, kscanfast
	bl   *r4
	movb @>8375, r1
	seto r2
	cb   r1, r2
	jeq  JMP_43
	b    @L291
JMP_43
	jmp  L281
L251
	clr  r1
L274
	mov  r1, r3
	swpb r3
	movb r3, @buffer(r1)
	inc  r1
	ci   r1, >200
	jne  L274
	li   r1, buffer
	li   r2, LC121
	li   r3, >E
	li   r4, memcpy
	bl   *r4
	clr  r1
	li   r2, >5
	bl   @cf7WriteSector
	ci   r1, 0
	jeq  L275
L292
	li   r1, LC25
	bl   *r14
	jmp  L262
L259
	li   r1, LC120
	bl   *r14
	clr  r1
L265
	mov  r1, r3
	swpb r3
	movb r3, @buffer(r1)
	inc  r1
	ci   r1, >200
	jne  L265
	li   r1, >10
	li   r2, >400
	bl   @flashWriteSlow
	ci   r1, 0
	jeq  L275
	li   r1, LC25
	bl   *r14
	jmp  L262
L258
	li   r4, flashReset
	bl   *r4
	b    @L262
L257
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	inct r10
	b    *r11
L256
	bl   @flashReadStatus
	b    @L262
L255
	li   r1, LC118
	bl   *r14
	clr  r2
L263
	mov  r2, r1
	swpb r1
	movb r1, @buffer(r2)
	inc  r2
	ci   r2, >200
	jne  L263
	li   r1, >10
	bl   @flashWriteFast
	ci   r1, 0
	jne  JMP_44
	b    @L275
JMP_44
	li   r1, LC25
	bl   *r14
	b    @L262
L254
	bl   @flashChipErase
	ci   r1, 0
	jne  JMP_45
	b    @L275
JMP_45
	li   r1, LC25
	bl   *r14
	b    @L262
L253
	bl   @flashReadCfi
	b    @L262
L252
	li   r1, cf7CardError
	bl   *r1
	b    @L262
L250
	clr  r1
	mov  @>A(r10), r2
	bl   @cf7ReadSector
	ci   r1, 0
	jne  JMP_46
	b    @L269
JMP_46
	li   r9, buffer
	li   r13, putchar
	jmp  L272
L294
	srl  r1, 8
	bl   *r13
	inc  r9
	ci   r9, buffer+512
	jeq  L293
L272
	movb *r9, r1
	movb r1, r3
	ai   r3, >E000
	cb   r3, r15
	jle  L294
	li   r1, >20
	bl   *r13
	inc  r9
	ci   r9, buffer+512
	jne  L272
L293
	li   r1, >A
	bl   *r13
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	b    @L262
L249
	bl   @cf7IdentifyDevice
	b    @L262
L248
* Begin inline assembler code
* 518 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r1, >100
	movb r1, @>5F03
	clr  r2
	movb r2, @>5F05
	movb r2, @>5F0D
	li   r4, >EF00
	movb r4, @>5F0F
* Begin inline assembler code
* 525 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    @L262
L269
	li   r1, LC119
	bl   *r14
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	b    @L262
	.size	main, .-main
	.type	__FUNCTION__.1746, @object
	.size	__FUNCTION__.1746, 15
__FUNCTION__.1746
	text 'flashChipErase'
	byte 0
	.type	__FUNCTION__.1718, @object
	.size	__FUNCTION__.1718, 17
__FUNCTION__.1718
	text 'flashSectorErase'
	byte 0
	.type	__FUNCTION__.1670, @object
	.size	__FUNCTION__.1670, 15
__FUNCTION__.1670
	text 'flashWriteSlow'
	byte 0
	.type	__FUNCTION__.1608, @object
	.size	__FUNCTION__.1608, 15
__FUNCTION__.1608
	text 'flashWriteFast'
	byte 0
	.type	__FUNCTION__.1556, @object
	.size	__FUNCTION__.1556, 18
__FUNCTION__.1556
	text 'flashWaitForWrite'
	byte 0
	.type	__FUNCTION__.1497, @object
	.size	__FUNCTION__.1497, 16
__FUNCTION__.1497
	text 'flashReadStatus'
	byte 0
	.type	__FUNCTION__.1362, @object
	.size	__FUNCTION__.1362, 13
__FUNCTION__.1362
	text 'flashReadCfi'
	byte 0
	.type	__FUNCTION__.1351, @object
	.size	__FUNCTION__.1351, 12
__FUNCTION__.1351
	text 'flashUnlock'
	byte 0
	.type	__FUNCTION__.1346, @object
	.size	__FUNCTION__.1346, 11
__FUNCTION__.1346
	text 'flashReset'
	byte 0
	cseg

	even
	def buffer
buffer
	bss 512

	even
	def verify
verify
	bss 1

	even
	def verifylatch
verifylatch
	bss 2

	ref	putchar

	ref	memcpy

	ref	kscanfast

	ref	puts

	ref	scrn_scroll

	ref	fast_scrn_scroll

	ref	charsetlc

	ref	set_text_raw

	ref	printf

	ref	putchar
