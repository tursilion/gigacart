	pseg
	even

	def	flashReset
flashReset
	clr  r1
	movb r1, @>6000
	b    *r11
	.size	flashReset, .-flashReset
	even

	def	flashUnlock
flashUnlock
	li   r1, >1800
	movb r1, @>6000
	li   r1, >AA55
	movb r1, @>E0AA
	swpb r1
	movb r1, @>E554
	b    *r11
	.size	flashUnlock, .-flashUnlock
	even

	def	cf7Reset
cf7Reset
	dect r10
* Begin inline assembler code
* 415 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r1, >400
	movb r1, @>5F1D
	clr  *r10
	mov  *r10, r1
	ci   r1, >1F3
	jgt  L6
L9
	mov  *r10, *r10
	mov  *r10, r1
	inc  r1
	mov  r1, *r10
	mov  *r10, r1
	ci   r1, >1F3
	jlt  L9
	jeq  L9
L6
	clr  r1
	movb r1, @>5F1D
* Begin inline assembler code
* 423 "main.c" 1
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
	dect r10
* Begin inline assembler code
* 415 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r1, >400
	movb r1, @>5F1D
	clr  *r10
	mov  *r10, r1
	ci   r1, >1F3
	jgt  L13
L16
	mov  *r10, *r10
	mov  *r10, r1
	inc  r1
	mov  r1, *r10
	mov  *r10, r1
	ci   r1, >1F3
	jlt  L16
	jeq  L16
L13
	clr  r1
	movb r1, @>5F1D
* Begin inline assembler code
* 423 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* 429 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r2, >81EF
	movb r2, @>5F03
	swpb r2
	movb r2, @>5F0F
* Begin inline assembler code
* 434 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	inct r10
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
L32
	movb @>5E0F, r9
	jlt  L22
	srl  r9, 8
	mov  r9, r1
	andi r1, >50
	jeq  L23
	ai   r1, >FFB0
	jne  JMP_0
	b    @L24
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
L23
	mov  r9, r14
	andi r14, >20
	jne  L34
	andi r9, >1
	ci   r9, 0
	jne  L35
L22
	inc  r13
	ci   r13, >63
	jlt  L32
	jeq  L32
	clr  r1
	li   r2, kscanfast
	bl   *r2
	movb @>8375, r1
	li   r2, >2000
	cb   r1, r2
	jeq  L36
	clr  r13
	jmp  L32
L36
	li   r1, LC4
	bl   @puts
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L37
L34
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
	jmp  L37
L35
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
	jmp  L37
L24
	andi r9, >4
	ci   r9, 0
	jne  L25
	li   r1, >1
L38
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L37
L25
	li   r1, LC1
	bl   @puts
	li   r1, >1
	jmp  L38
L37
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
* 450 "main.c" 1
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
	b    @L40
JMP_1
* Begin inline assembler code
* 455 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	b    @L63
L40
	dect r10
	li   r2, LC5
	mov  r2, *r10
	li   r13, printf
	bl   *r13
	inct r10
	ci   r9, >3FFF
	jh  JMP_2
	b    @L62
JMP_2
	srl  r9, 8
L42
	ai   r10, >FFFC
	li   r1, LC21
	mov  r1, *r10
	mov  r9, @>2(r10)
	bl   *r13
	ai   r10, >4
L59
* Begin inline assembler code
* 492 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	b    @L63
L62
	srl  r9, 8
	mov  r9, r1
	a    r9, r1
	mov  @L58(r1), r2
	b    *r2
	even
L58
		data		L43
		data		L44
		data		L42
		data		L45
		data		L42
		data		L46
		data		L42
		data		L42
		data		L42
		data		L47
		data		L42
		data		L42
		data		L48
		data		L42
		data		L42
		data		L42
		data		L49
		data		L50
		data		L42
		data		L42
		data		L49
		data		L42
		data		L42
		data		L42
		data		L51
		data		L42
		data		L42
		data		L42
		data		L42
		data		L42
		data		L42
		data		L52
		data		L53
		data		L54
		data		L42
		data		L42
		data		L42
		data		L42
		data		L42
		data		L42
		data		L42
		data		L42
		data		L42
		data		L42
		data		L42
		data		L42
		data		L42
		data		L55
		data		L46
		data		L46
		data		L46
		data		L46
		data		L46
		data		L56
		data		L56
		data		L46
		data		L48
		data		L42
		data		L57
		data		L48
		data		L48
		data		L42
		data		L46
		data		L48
L57
	li   r1, LC17
	bl   @puts
	b    @L59
L56
	li   r1, LC12
	bl   @puts
	b    @L59
L55
	li   r1, LC11
	bl   @puts
	b    @L59
L54
	li   r1, LC10
	bl   @puts
	b    @L59
L53
	li   r1, LC9
	bl   @puts
	b    @L59
L52
	li   r1, LC18
	bl   @puts
	b    @L59
L51
	li   r1, LC14
	bl   @puts
	b    @L59
L50
	li   r1, LC13
	bl   @puts
	b    @L59
L49
	li   r1, LC16
	bl   @puts
	b    @L59
L48
	li   r1, LC19
	bl   @puts
	b    @L59
L47
	li   r1, LC8
	bl   @puts
	b    @L59
L46
	li   r1, LC15
	bl   @puts
	b    @L59
L45
	li   r1, LC20
	bl   @puts
	b    @L59
L44
	li   r1, LC7
	bl   @puts
	b    @L59
L43
	li   r1, LC6
	bl   @puts
	b    @L59
L63
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
* 634 "main.c" 1
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
	b    @L65
JMP_3
* Begin inline assembler code
* 639 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
L66
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L77
L65
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
	jgt  L67
L74
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	mov  @>A(r10), r1
	ci   r1, >63
	jlt  L74
	jeq  L74
L67
	bl   *r14
	ci   r1, 0
	jne  JMP_4
	b    @L78
JMP_4
	movb @>5E0F, r9
	srl  r9, 8
	andi r9, >8
	ci   r9, 0
	jne  JMP_5
	b    @L79
JMP_5
	li   r1, >2E
	bl   @putchar
	li   r1, buffer
L71
	movb *r1+, @>5F01
	ci   r1, buffer+512
	jne  L71
	dect r10
	li   r1, LC24
	mov  r1, *r10
	bl   *r13
	inct r10
	bl   *r14
	ci   r1, 0
	jeq  JMP_6
	b    @L72
JMP_6
* Begin inline assembler code
* 669 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    @L66
L79
* Begin inline assembler code
* 657 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, LC23
	bl   @puts
	mov  r9, r1
	b    @L66
L78
* Begin inline assembler code
* 652 "main.c" 1
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
	b    @L77
L72
	li   r1, LC25
	bl   @puts
* Begin inline assembler code
* 675 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, >1
	b    @L66
L77
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
* 590 "main.c" 1
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
	b    @L81
JMP_7
* Begin inline assembler code
* 595 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
L82
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L88
L81
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
	b    @L89
JMP_8
	movb @>5E0F, r9
	srl  r9, 8
	andi r9, >8
	ci   r9, 0
	jne  JMP_9
	b    @L90
JMP_9
	dect r10
	li   r1, LC27
	mov  r1, *r10
	bl   *r13
	li   r1, buffer
	inct r10
L85
	movb @>5E01, *r1+
	ci   r1, buffer+512
	jne  L85
	li   r1, LC28
	bl   @puts
* Begin inline assembler code
* 624 "main.c" 1
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
	b    @L88
L90
* Begin inline assembler code
* 613 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, LC23
	bl   @puts
	mov  r9, r1
	b    @L82
L89
* Begin inline assembler code
* 608 "main.c" 1
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
L88
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
	ai   r10, >FFF6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
* Begin inline assembler code
* 535 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r9, cf7WaitForReady
	bl   *r9
	ci   r1, 0
	jeq  JMP_10
	b    @L92
JMP_10
* Begin inline assembler code
* 538 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	b    @L107
L92
	li   r1, >EC00
	movb r1, @>5F0F
	bl   *r9
	ci   r1, 0
	jne  JMP_11
	b    @L108
JMP_11
	movb @>5E0F, r1
	srl  r1, 8
	andi r1, >8
	ci   r1, 0
	jne  JMP_12
	b    @L109
JMP_12
	dect r10
	li   r1, LC29
	mov  r1, *r10
	li   r15, printf
	bl   *r15
	li   r9, buffer
	mov  r9, r13
	inct r10
L96
	movb @>5E01, *r13+
	ci   r13, buffer+512
	jne  L96
	li   r1, LC30
	bl   @puts
* Begin inline assembler code
* 561 "main.c" 1
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
	bl   *r15
	li   r1, LC32
	mov  r1, *r10
	movb @buffer+114, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	movb @buffer+115, r1
	srl  r1, 8
	mov  r1, @>4(r10)
	movb @buffer+116, r1
	srl  r1, 8
	mov  r1, @>6(r10)
	movb @buffer+117, r1
	srl  r1, 8
	mov  r1, @>8(r10)
	bl   *r15
	li   r2, LC33
	mov  r2, *r10
	movb @buffer+120, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	movb @buffer+121, r1
	srl  r1, 8
	mov  r1, @>4(r10)
	movb @buffer+122, r1
	srl  r1, 8
	mov  r1, @>6(r10)
	movb @buffer+123, r1
	srl  r1, 8
	mov  r1, @>8(r10)
	bl   *r15
	ai   r10, >8
	li   r1, LC34
	mov  r1, *r10
	bl   *r15
	ai   r13, >FE14
	inct r10
	li   r14, putchar
L97
	movb *r13+, r1
	srl  r1, 8
	bl   *r14
	ci   r13, buffer+40
	jne  L97
	li   r1, >A
	bl   @putchar
	dect r10
	li   r2, LC35
	mov  r2, *r10
	bl   *r15
	ai   r13, >6
	inct r10
L98
	movb *r13+, r1
	srl  r1, 8
	bl   *r14
	ci   r13, buffer+76
	jne  L98
	li   r1, >A
	bl   @putchar
	li   r13, >5A00
	jmp  L101
L111
	srl  r1, 8
	bl   *r14
	inc  r9
	ci   r9, buffer+512
	jeq  L110
L101
	movb *r9, r1
	movb r1, r2
	ai   r2, >E000
	cb   r2, r13
	jle  L111
	li   r1, >20
	bl   *r14
	inc  r9
	ci   r9, buffer+512
	jne  L101
L110
	li   r1, >A
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @putchar
L109
* Begin inline assembler code
* 550 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, LC23
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @puts
L108
* Begin inline assembler code
* 545 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L107
	.size	cf7IdentifyDevice, .-cf7IdentifyDevice
LC36
	text 'Waiting...'
	byte 0
LC37
	byte 13
	text 'Ok.       '
	byte 0
LC38
	byte 10
	text 'Write operation reports failed'
	byte 0
LC39
	byte 13
	text 'Waiting... %ds'
	byte 0
LC40
	byte 10
	text '-- Aborted by keypress'
	byte 0
	even

	def	flashWaitForWrite
flashWaitForWrite
	ai   r10, >FFF2
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
	ai   r2, >6000
	srl  r1, >4
	andi r1, >300
	ori  r1, >1000
	movb r1, *r2
	dect r10
	li   r1, LC36
	mov  r1, *r10
	li   r2, printf
	bl   *r2
	ai   r13, >6000
	clr  r15
	inct r10
	li   r4, kscanfast
	li   r3, >2000
L118
	clr  r2
L123
	movb *r13, r9
	cb   r9, r14
	jeq  L124
	srl  r9, 8
	andi r9, >2
	ci   r9, 0
	jne  L125
	movb @>8802, r1
	jgt  L123
	jeq  L123
	inc  r2
	ci   r2, >3C
	jne  L123
	inc  r15
	ai   r10, >FFFC
	li   r2, LC39
	mov  r2, *r10
	mov  r15, @>2(r10)
	mov  r3, @>10(r10)
	mov  r4, @>E(r10)
	li   r2, printf
	bl   *r2
	ai   r10, >4
	mov  r9, r1
	mov  @>A(r10), r4
	bl   *r4
	movb @>8375, r1
	mov  @>C(r10), r3
	mov  @>A(r10), r4
	cb   r1, r3
	jne  L118
	li   r1, LC40
	bl   @puts
	mov  r9, r1
	jmp  L114
L124
	li   r1, LC37
	bl   @puts
	li   r1, >1
L114
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	jmp  L126
L125
	movb *r13, r1
	cb   r1, r14
	jne  L116
	li   r1, >1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	jmp  L126
L116
	li   r1, LC38
	bl   @puts
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
L126
	.size	flashWaitForWrite, .-flashWaitForWrite
LC41
	text 'Erasing flash chip...'
	byte 0
	even

	def	flashChipErase
flashChipErase
	dect r10
	mov  r11, *r10
	li   r1, LC41
	bl   @puts
	li   r7, >18AA
	movb r7, @>6000
	swpb r7
	movb r7, @>E0AA
	li   r6, >5518
	movb r6, @>E554
	swpb r6
	movb r6, @>6000
	li   r5, >8018
	movb r5, @>EAAA
	swpb r5
	movb r5, @>6000
	li   r4, >AA55
	movb r4, @>E0AA
	swpb r4
	movb r4, @>E554
	li   r3, >1810
	movb r3, @>6000
	swpb r3
	movb r3, @>EAAA
	clr  r1
	mov  r1, r2
	seto r3
	bl   @flashWaitForWrite
	ci   r1, 0
	jeq  L128
	li   r1, >1
L128
	mov  *r10+, r11
	b    *r11
	.size	flashChipErase, .-flashChipErase
LC42
	text 'Sector erase page %d is not 128k aligned'
	byte 10
	byte 0
LC43
	text 'Erasing sector %d'
	byte 10
	byte 0
	even

	def	flashSectorErase
flashSectorErase
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r1, r9
	mov  r1, r13
	andi r13, >F
	jne  L134
	ai   r10, >FFFC
	li   r1, LC43
	mov  r1, *r10
	mov  r9, @>2(r10)
	bl   @printf
	li   r2, >1800
	movb r2, @>6000
	li   r12, >AA55
	movb r12, @>E0AA
	swpb r12
	movb r12, @>E554
	li   r1, >1800
	movb r1, @>6000
	li   r2, >8000
	movb r2, @>EAAA
	movb r1, @>6000
	li   r8, >AA55
	movb r8, @>E0AA
	swpb r8
	movb r8, @>E554
	mov  r9, r1
	andi r1, >FFF
	a    r1, r1
	ai   r1, >6000
	mov  r9, r3
	srl  r3, >4
	andi r3, >300
	ori  r3, >1800
	movb r3, *r1
	li   r1, >3000
	movb r1, @>E000
	ai   r10, >4
	mov  r9, r1
	mov  r13, r2
	seto r3
	bl   @flashWaitForWrite
	ci   r1, 0
	jeq  L132
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	jmp  L135
L134
	ai   r10, >FFFC
	li   r2, LC42
	mov  r2, *r10
	mov  r9, @>2(r10)
	bl   @printf
	ai   r10, >4
L132
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
L135
	.size	flashSectorErase, .-flashSectorErase
LC44
	text 'Writing page %X%X, address %X%X'
	byte 10
	byte 0
	even

	def	flashWriteSlow
flashWriteSlow
	ai   r10, >FFF2
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r1, r15
	mov  r2, r9
	mov  r1, r14
	andi r14, >FFF
	a    r14, r14
	mov  r15, r2
	srl  r2, >4
	andi r2, >300
	ai   r10, >FFF6
	li   r4, LC44
	mov  r4, *r10
	mov  r15, r1
	srl  r1, >8
	mov  r1, @>2(r10)
	mov  r15, r1
	andi r1, >FF
	mov  r1, @>4(r10)
	mov  r9, r1
	srl  r1, >8
	mov  r1, @>6(r10)
	mov  r9, r4
	andi r4, >FF
	mov  r4, @>8(r10)
	mov  r2, @>16(r10)
	bl   @printf
	li   r13, buffer
	ai   r10, >A
	ai   r14, >6000
	mov  @>C(r10), r2
	movb r2, r3
	ori  r3, >1800
	movb r3, @>A(r10)
	ori  r2, >1400
	movb r2, @>B(r10)
	jmp  L142
L145
	movb @>B(r10), *r14
	mov  r9, r2
	ai   r2, >E000
	movb *r13, *r2
	mov  r15, r1
	mov  r9, r2
	movb *r13, r3
	li   r4, flashWaitForWrite
	bl   *r4
	ci   r1, 0
	jeq  L141
L146
	inc  r13
	ci   r13, buffer+512
	jeq  L144
	inc  r9
L142
	li   r4, >1800
	movb r4, @>6000
	li   r0, >AA55
	movb r0, @>E0AA
	swpb r0
	movb r0, @>E554
	movb r4, @>6000
	li   r4, >A000
	movb r4, @>EAAA
	mov  r9, r2
	andi r2, >1
	jne  L145
	movb @>A(r10), *r14
	mov  r9, r2
	ai   r2, >E000
	movb *r13, *r2
	mov  r15, r1
	mov  r9, r2
	movb *r13, r3
	li   r4, flashWaitForWrite
	bl   *r4
	ci   r1, 0
	jne  L146
L141
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	jmp  L147
L144
	li   r1, >1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
L147
	.size	flashWriteSlow, .-flashWriteSlow
LC45
	text '* Can''t write to unaligned address: %X%X'
	byte 10
	byte 0
LC46
	text 'WRITING page %X%X, address %X%X'
	byte 10
	byte 0
	even

	def	flashWriteFast
flashWriteFast
	ai   r10, >FFF0
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r1, @>A(r10)
	mov  r2, r9
	mov  r2, r14
	andi r14, >1F
	jeq  JMP_13
	b    @L157
JMP_13
	mov  @>A(r10), r15
	srl  r15, >4
	andi r15, >300
	ai   r10, >FFF6
	li   r2, LC46
	mov  r2, *r10
	mov  @>14(r10), r1
	srl  r1, >8
	mov  r1, @>2(r10)
	mov  @>14(r10), r4
	andi r4, >FF
	mov  r4, @>4(r10)
	mov  r9, r1
	srl  r1, >8
	mov  r1, @>6(r10)
	mov  r9, r2
	andi r2, >FF
	mov  r2, @>8(r10)
	bl   @printf
	mov  @>14(r10), r13
	andi r13, >FFF
	a    r13, r13
	ai   r13, >6000
	movb r15, r7
	ori  r7, >1800
	ori  r15, >1C00
	movb r15, @>16(r10)
	mov  r9, r2
	ai   r2, >E000
	mov  r2, r15
	ai   r10, >A
L154
	li   r4, >1800
	movb r4, @>6000
	li   r3, >AA55
	movb r3, @>E0AA
	swpb r3
	movb r3, @>E554
	movb r7, *r13
	li   r1, >251F
	movb r1, *r2
	swpb r1
	movb r1, *r2
	movb @>C(r10), *r13
	mov  r14, r3
	ai   r3, buffer
	mov  r15, r5
	clr  r4
L151
	movb @>1(r3), *r5
	inct r4
	inct r3
	inct r5
	ci   r4, >20
	jne  L151
	movb r7, *r13
	li   r4, >2900
	movb r4, *r2
	mov  @>A(r10), r1
	mov  r9, r2
	ai   r2, >1F
	movb @buffer+31, r3
	mov  r7, @>E(r10)
	li   r4, flashWaitForWrite
	bl   *r4
	mov  @>E(r10), r7
	ci   r1, 0
	jeq  L150
	ai   r14, >20
	ai   r15, >40
	ci   r14, >200
	jeq  L158
	ai   r9, >20
	mov  r9, r2
	ai   r2, >E000
	jmp  L154
L157
	ai   r10, >FFFA
	li   r2, LC45
	mov  r2, *r10
	mov  r9, r1
	srl  r1, >8
	mov  r1, @>2(r10)
	andi r9, >FF
	mov  r9, @>4(r10)
	bl   @printf
	clr  r1
	ai   r10, >6
L150
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >8
	b    *r11
	jmp  L159
L158
	li   r1, >1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >8
	b    *r11
L159
	.size	flashWriteFast, .-flashWriteFast
LC47
	text 'Flash CFI information:'
	byte 0
LC48
	text 'Did NOT get QRY string: %c%c%c'
	byte 10
	byte 0
LC49
	text 'Device size: 2^%d bytes'
	byte 0
LC50
	text ' [small]'
	byte 0
LC51
	text 'Device reports 16-bit only!'
	byte 0
LC52
	text 'Vcc Min/Max: %d.%d / %d.%d V'
	byte 10
	byte 0
LC53
	text 'Timeout: Word write: %d uS'
	byte 10
	byte 0
LC54
	text '         Chip erase: 2^%d mS'
	byte 10
	byte 0
LC55
	text 'Max multi-byte write size: %d bytes'
	byte 10
	byte 0
LC56
	text 'Did NOT get PRI or not at 0x40: %c%c%c'
	byte 10
	byte 0
LC57
	text 'CFI version 1.%d'
	byte 10
	byte 0
LC58
	text 'Process: '
	byte 0
LC59
	text '.23um floating'
	byte 0
LC60
	text '.17us floating'
	byte 0
LC61
	text '.23um MirrorBit'
	byte 0
LC62
	text '.13um floating'
	byte 0
LC63
	text '.11um MirrorBit'
	byte 0
LC64
	text '.09um MirrorBit'
	byte 0
LC65
	text '.09um floating'
	byte 0
LC66
	text '.065um MirrorBit Ec'
	byte 0
LC67
	text '.065um MirrorBit'
	byte 0
LC68
	text '0.045um MirrorBit'
	byte 0
LC69
	text 'unknown: %d'
	byte 10
	byte 0
LC70
	text 'WP# pin: '
	byte 0
LC71
	text 'none'
	byte 0
LC72
	text '64kb dual boot'
	byte 0
LC73
	text 'bottom boot'
	byte 0
LC74
	text 'top boot'
	byte 0
LC75
	text 'uniform bottom boot'
	byte 0
LC76
	text 'uniform top boot'
	byte 0
LC77
	text 'all sectors'
	byte 0
LC78
	text 'uniform dual'
	byte 0
LC79
	text 'un'
	byte 0
LC80
	byte 0
LC81
	text 'Customer OTP area: 2^%d (%slocked)'
	byte 10
	byte 0
LC82
	text 'Page size = %d bytes'
	byte 10
	byte 0
LC83
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
	li   r1, LC47
	bl   *r14
	li   r1, >1800
	movb r1, @>6000
	li   r4, >9810
	movb r4, @>E0AA
	swpb r4
	movb r4, @>6000
	clr  r1
L161
	mov  r1, r2
	ai   r2, >6000
	movb *r2, @buffer(r1)
	inc  r1
	ci   r1, >100
	jne  L161
	movb @buffer+32, r2
	li   r1, >5100
	cb   r2, r1
	jne  JMP_14
	b    @L162
JMP_14
	movb @buffer+34, r1
	movb @buffer+36, r3
L163
	ai   r10, >FFF8
	li   r4, LC48
	mov  r4, *r10
	srl  r2, 8
	mov  r2, @>2(r10)
	srl  r1, 8
	mov  r1, @>4(r10)
	srl  r3, 8
	mov  r3, @>6(r10)
	li   r9, printf
	bl   *r9
	li   r15, >1
	ai   r10, >8
L165
	ai   r10, >FFFC
	li   r1, LC49
	mov  r1, *r10
	movb @buffer+78, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   *r9
	ai   r10, >4
	li   r1, >1B00
	cb   @buffer+78, r1
	jeq  L166
	dect r10
	li   r2, LC50
	mov  r2, *r10
	bl   @printf
	inct r10
L166
	li   r13, putchar
	li   r1, >A
	bl   *r13
	li   r1, >100
	cb   @buffer+80, r1
	jne  JMP_15
	b    @L220
JMP_15
L167
	movb @buffer+54, r2
	movb @buffer+56, r1
	ai   r10, >FFF6
	li   r3, LC52
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
	jne  JMP_16
	b    @L221
JMP_16
	clr  r2
	li   r1, >1
L170
	a    r1, r1
	inc  r2
	c    r2, r3
	jlt  L170
L169
	ai   r10, >FFFC
	li   r3, LC53
	mov  r3, *r10
	mov  r1, @>2(r10)
	bl   *r9
	li   r4, LC54
	mov  r4, *r10
	movb @buffer+68, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   *r9
	movb @buffer+84, r3
	srl  r3, 8
	ai   r10, >4
	ci   r3, 0
	jne  JMP_17
	b    @L222
JMP_17
	clr  r2
	li   r1, >1
L173
	a    r1, r1
	inc  r2
	c    r3, r2
	jgt  L173
L172
	ai   r10, >FFFC
	li   r2, LC55
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	ai   r10, >4
	li   r1, >4000
	cb   @buffer+42, r1
	jne  JMP_18
	b    @L174
JMP_18
	movb @buffer+128, r1
	movb @buffer+130, r3
	movb @buffer+132, r2
L175
	ai   r10, >FFF8
	li   r4, LC56
	mov  r4, *r10
	srl  r1, 8
	mov  r1, @>2(r10)
	srl  r3, 8
	mov  r3, @>4(r10)
	srl  r2, 8
	mov  r2, @>6(r10)
	bl   *r9
	ai   r10, >8
L178
	ai   r10, >FFFC
	li   r1, LC57
	mov  r1, *r10
	movb @buffer+136, r1
	srl  r1, 8
	andi r1, >F
	mov  r1, @>2(r10)
	bl   *r9
	inct r10
	li   r3, LC58
	mov  r3, *r10
	bl   *r9
	movb @buffer+138, r1
	srl  r1, >2
	srl  r1, 8
	andi r1, >F
	inct r10
	ci   r1, >9
	jh  JMP_19
	b    @L223
JMP_19
	ai   r10, >FFFC
	li   r3, LC69
	mov  r3, *r10
	mov  r1, @>2(r10)
	bl   @printf
	ai   r10, >4
L191
	dect r10
	li   r4, LC70
	mov  r4, *r10
	bl   *r9
	movb @buffer+158, r1
	inct r10
	ci   r1, >7FF
	jh  JMP_20
	b    @L224
JMP_20
	ai   r10, >FFFC
	li   r3, LC69
	mov  r3, *r10
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   @printf
	ai   r10, >4
L202
	li   r1, >3400
	cb   @buffer+136, r1
	jh  JMP_21
	b    @L203
JMP_21
	movb @buffer+164, r2
	movb @buffer+6, r1
	srl  r1, 8
	andi r1, >40
	ci   r1, 0
	jeq  JMP_22
	b    @L204
JMP_22
	li   r3, LC79
L205
	ai   r10, >FFFA
	li   r1, LC81
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
	jne  JMP_23
	b    @L225
JMP_23
	clr  r2
	li   r1, >1
L208
	a    r1, r1
	inc  r2
	c    r3, r2
	jgt  L208
L207
	ai   r10, >FFFC
	li   r2, LC82
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	ai   r10, >4
L209
	ci   r15, 0
	jne  JMP_24
	b    @L214
JMP_24
	li   r9, buffer
	li   r14, >5A00
	jmp  L213
L227
	srl  r1, 8
	bl   *r13
	inc  r9
	ci   r9, buffer+512
	jeq  L226
L213
	movb *r9, r1
	movb r1, r2
	ai   r2, >E000
	cb   r2, r14
	jle  L227
	li   r1, >20
	bl   *r13
	inc  r9
	ci   r9, buffer+512
	jne  L213
L226
	li   r1, >A
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @putchar
L224
	srl  r1, 8
	a    r1, r1
	mov  @L201(r1), r2
	b    *r2
	even
L201
		data		L193
		data		L194
		data		L195
		data		L196
		data		L197
		data		L198
		data		L199
		data		L200
L223
	a    r1, r1
	mov  @L190(r1), r2
	b    *r2
	even
L190
		data		L180
		data		L181
		data		L182
		data		L183
		data		L184
		data		L185
		data		L186
		data		L187
		data		L188
		data		L189
L204
	li   r3, LC80
	b    @L205
L162
	movb @buffer+34, r1
	li   r3, >5200
	cb   r1, r3
	jne  JMP_25
	b    @L164
JMP_25
	movb @buffer+36, r3
	b    @L163
L174
	movb @buffer+128, r1
	li   r2, >5000
	cb   r1, r2
	jne  JMP_26
	b    @L176
JMP_26
	movb @buffer+130, r3
	movb @buffer+132, r2
	b    @L175
L214
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L203
	li   r1, LC83
	bl   *r14
	b    @L209
L199
	li   r1, LC77
	bl   *r14
	b    @L202
L200
	li   r1, LC78
	bl   *r14
	b    @L202
L193
	li   r1, LC71
	bl   *r14
	b    @L202
L194
	li   r1, LC72
	bl   *r14
	b    @L202
L195
	li   r1, LC73
	bl   *r14
	b    @L202
L196
	li   r1, LC74
	bl   *r14
	b    @L202
L197
	li   r1, LC75
	bl   *r14
	b    @L202
L198
	li   r1, LC76
	bl   *r14
	b    @L202
L189
	li   r1, LC68
	bl   *r14
	b    @L191
L188
	li   r1, LC67
	bl   *r14
	b    @L191
L180
	li   r1, LC59
	bl   *r14
	b    @L191
L181
	li   r1, LC60
	bl   *r14
	b    @L191
L182
	li   r1, LC61
	bl   *r14
	b    @L191
L183
	li   r1, LC62
	bl   *r14
	b    @L191
L184
	li   r1, LC63
	bl   *r14
	b    @L191
L185
	li   r1, LC64
	bl   *r14
	b    @L191
L186
	li   r1, LC65
	bl   *r14
	b    @L191
L187
	li   r1, LC66
	bl   *r14
	b    @L191
L220
	li   r1, LC51
	bl   *r14
	b    @L167
L176
	movb @buffer+130, r3
	li   r2, >5200
	cb   r3, r2
	jeq  L177
	movb @buffer+132, r2
	b    @L175
L164
	movb @buffer+36, r3
	li   r4, >5900
	cb   r3, r4
	jeq  JMP_27
	b    @L163
JMP_27
	clr  r15
	li   r9, printf
	b    @L165
L221
	li   r1, >1
	b    @L169
L222
	li   r1, >1
	b    @L172
L225
	li   r1, >1
	b    @L207
L177
	movb @buffer+132, r2
	li   r4, >4900
	cb   r2, r4
	jeq  JMP_28
	b    @L175
JMP_28
	b    @L178
	.size	flashReadCfi, .-flashReadCfi
LC84
	text 'CF7 to Seahorse board programmer'
	byte 10
	byte 0
LC85
	byte 10
	text 'Press:'
	byte 0
LC86
	text '  C to read flash CFI'
	byte 0
LC87
	text '  F to test flash fast write'
	byte 0
LC88
	text '  S to test flash slow write'
	byte 0
LC89
	text '  X to test sector erase'
	byte 0
LC90
	text '  E to test flash erase'
	byte 0
LC91
	text '  R to put flash in reset'
	byte 0
LC92
	byte 10
	text '  1 to reset CF7'
	byte 0
LC93
	text '  2 to read CF info'
	byte 0
LC94
	text '  3 to read CF7'
	byte 0
LC95
	text '  4 to write CF7 (destructive!)'
	byte 0
LC96
	text '  5 to check CF card error'
	byte 0
LC97
	text 'Fast: Page 16, address 512'
	byte 0
LC98
	text 'Failed!'
	byte 0
LC99
	text 'Slow: Page 16, address 1024'
	byte 0
LC100
	text 'Press a key...'
	byte 0
	even

	def	main
main
	ai   r10, >FFF2
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	bl   @set_text_raw
	mov  r1, r9
	bl   @charsetlc
	mov  @gColor, r1
	li   r2, >10
	li   r3, >20
	bl   @vdpmemset
	mov  r9, r1
	swpb r1
	movb r1, @>8C02
	li   r2, >8100
	movb r2, @>8C02
	movb r1, @>83D4
	li   r3, >1700
	movb r3, @>8C02
	li   r5, >8700
	movb r5, @>8C02
	swpb r5
	movb r5, @>6000
	li   r15, puts
	li   r1, LC84
	bl   *r15
	clr  r1
L229
	mov  r1, r2
	swpb r2
	movb r2, @buffer(r1)
	inc  r1
	ci   r1, >200
	jne  L229
	clr  r3
	mov  r3, @>C(r10)
	li   r13, putchar
	li   r14, >5A00
L273
	li   r1, LC85
	bl   *r15
	li   r1, LC86
	bl   *r15
	li   r1, LC87
	bl   *r15
	li   r1, LC88
	bl   *r15
	li   r1, LC89
	bl   *r15
	li   r1, LC90
	bl   *r15
	li   r1, LC91
	bl   *r15
	li   r1, LC92
	bl   *r15
	li   r1, LC93
	bl   *r15
	li   r1, LC94
	bl   *r15
	li   r1, LC95
	bl   *r15
	li   r1, LC96
	bl   *r15
L272
	clr  r1
	li   r2, kscanfast
	bl   *r2
	movb @>8375, r1
	ai   r1, >CF00
	ci   r1, >27FF
	jh  L272
	srl  r1, 8
	a    r1, r1
	mov  @L242(r1), r2
	b    *r2
	even
L242
		data		L231
		data		L232
		data		L233
		data		L234
		data		L235
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L236
		data		L272
		data		L237
		data		L238
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L272
		data		L239
		data		L240
		data		L272
		data		L272
		data		L272
		data		L272
		data		L241
L241
	li   r1, >10
	li   r2, flashSectorErase
	bl   *r2
	ci   r1, 0
	jne  L274
L247
	li   r1, LC98
	bl   *r15
L243
	li   r1, LC100
	bl   *r15
	seto r3
	movb r3, @>8375
	movb @>8375, r1
	cb   r1, r3
	jeq  JMP_29
	b    @L273
JMP_29
L263
	clr  r1
	li   r2, kscanfast
	bl   *r2
	movb @>8375, r1
	seto r3
	cb   r1, r3
	jeq  JMP_30
	b    @L273
JMP_30
	jmp  L263
L237
	li   r3, flashChipErase
	bl   *r3
	ci   r1, 0
	jeq  L247
L274
	li   r1, LC25
	bl   *r15
	jmp  L243
L240
	li   r9, puts
	li   r1, LC99
	bl   *r15
	li   r1, >10
	li   r2, >400
	li   r3, flashWriteFast
	bl   *r3
	ci   r1, 0
	jeq  L245
L275
	li   r1, LC25
	bl   *r9
	jmp  L243
L238
	li   r9, puts
	li   r1, LC97
	bl   *r15
	li   r1, >10
	li   r2, >200
	li   r3, flashWriteFast
	bl   *r3
	ci   r1, 0
	jne  L275
L245
	li   r1, LC98
	bl   *r9
	jmp  L243
L239
	clr  r1
	movb r1, @>6000
	jmp  L243
L236
	li   r3, flashReadCfi
	bl   *r3
	b    @L243
L235
	li   r2, cf7CardError
	bl   *r2
	b    @L243
L234
	clr  r3
L255
	mov  r3, r1
	swpb r1
	movb r1, @buffer(r3)
	inc  r3
	ci   r3, >200
	jne  L255
	clr  r1
	li   r2, >320
	li   r3, cf7WriteSector
	bl   *r3
	ci   r1, 0
	jne  JMP_31
	b    @L256
JMP_31
	li   r1, LC25
	bl   *r15
	mov  @>C(r10), r1
	inc  r1
	mov  r1, @>C(r10)
	b    @L243
L233
	clr  r1
	mov  @>C(r10), r2
	li   r3, cf7ReadSector
	bl   *r3
	ci   r1, 0
	jne  JMP_32
	b    @L256
JMP_32
	li   r9, buffer
	jmp  L253
L277
	srl  r1, 8
	bl   *r13
	inc  r9
	ci   r9, buffer+512
	jeq  L276
L253
	movb *r9, r1
	movb r1, r2
	ai   r2, >E000
	cb   r2, r14
	jle  L277
	li   r1, >20
	bl   *r13
	inc  r9
	ci   r9, buffer+512
	jne  L253
L276
	li   r1, >A
	bl   *r13
	mov  @>C(r10), r1
	inc  r1
	mov  r1, @>C(r10)
	b    @L243
L232
	li   r1, cf7IdentifyDevice
	bl   *r1
	b    @L243
L231
* Begin inline assembler code
* 415 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r2, >400
	movb r2, @>5F1D
	clr  @>A(r10)
	mov  @>A(r10), r1
	ci   r1, >1F3
	jgt  L248
L264
	mov  @>A(r10), @>A(r10)
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	mov  @>A(r10), r1
	ci   r1, >1F3
	jlt  L264
	jeq  L264
L248
	clr  r3
	movb r3, @>5F1D
* Begin inline assembler code
* 423 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    @L243
L256
	li   r1, LC98
	bl   *r15
	mov  @>C(r10), r1
	inc  r1
	mov  r1, @>C(r10)
	b    @L243
	.size	main, .-main
	cseg

	even
	def buffer
buffer
	bss 512

	ref	puts

	ref	kscanfast

	ref	putchar

	ref	vdpmemset

	ref	gColor

	ref	charsetlc

	ref	set_text_raw

	ref	printf

	ref	putchar
