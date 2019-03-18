	pseg
	even

	def	flashReset
flashReset
	clr  r1
	movb r1, @>6000
	b    *r11
	.size	flashReset, .-flashReset
	even

	def	flashSoftResetAll
flashSoftResetAll
	li   r2, >6000
	li   r1, >1800
	movb r1, *r2
	li   r1, >EAAA
	li   r5, >F018
	movb r5, *r1
	swpb r5
	movb r5, *r2
	li   r4, >AA14
	movb r4, *r1
	swpb r4
	movb r4, *r2
	li   r3, >5518
	movb r3, @>E555
	swpb r3
	movb r3, *r2
	li   r2, >F071
	movb r2, *r1
	swpb r2
	movb r2, *r1
	b    *r11
	.size	flashSoftResetAll, .-flashSoftResetAll
	even

	def	flashUnlock
flashUnlock
	li   r1, >6000
	li   r7, >18AA
	movb r7, *r1
	swpb r7
	movb r7, @>EAAA
	li   r6, >1455
	movb r6, *r1
	swpb r6
	movb r6, @>E555
	b    *r11
	.size	flashUnlock, .-flashUnlock
	even

	def	cf7Reset
cf7Reset
	dect r10
	mov  @CF7Classic99, r2
	jne  JMP_0
	b    @L8
JMP_0
* Begin inline assembler code
* 699 "main.c" 1
	li r12,>1000
	sbo 0
* 0 "" 2
* End of inline assembler code
L9
	li   r1, >400
	movb r1, @>5F1D
	clr  *r10
	mov  *r10, r1
	ci   r1, >1F3
	jgt  L10
L15
	mov  *r10, *r10
	mov  *r10, r1
	inc  r1
	mov  r1, *r10
	mov  *r10, r1
	ci   r1, >1F3
	jlt  L15
	jeq  L15
L10
	clr  r1
	movb r1, @>5F1D
	ci   r2, 0
	jeq  JMP_1
	b    @L18
JMP_1
* Begin inline assembler code
* 707 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	inct r10
	b    *r11
	b    @L19
L8
* Begin inline assembler code
* 699 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	b    @L9
L18
* Begin inline assembler code
* 707 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	inct r10
	b    *r11
L19
	.size	cf7Reset, .-cf7Reset
	even

	def	cf7Init
cf7Init
	mov  @CF7Classic99, r1
	jne  JMP_2
	b    @L21
JMP_2
* Begin inline assembler code
* 711 "main.c" 1
	li r12,>1000
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
* 718 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    *r11
	b    @L24
L21
* Begin inline assembler code
* 711 "main.c" 1
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
* 718 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    *r11
L24
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
	even

	def	flashToggle
flashToggle
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	li   r13, kscanfast
	li   r9, >2000
L28
	li   r8, >1814
	movb r8, @>6000
	swpb r8
	movb r8, @>6000
	clr  r1
	bl   *r13
	movb @>8375, r1
	cb   r1, r9
	jne  L28
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	.size	flashToggle, .-flashToggle
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
L43
	movb @>5E0F, r9
	jlt  L33
	srl  r9, 8
	mov  r9, r1
	andi r1, >50
	jeq  L34
	ai   r1, >FFB0
	jne  JMP_3
	b    @L35
JMP_3
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
L34
	mov  r9, r14
	andi r14, >20
	jne  L45
	andi r9, >1
	ci   r9, 0
	jne  L46
L33
	inc  r13
	ci   r13, >63
	jlt  L43
	jeq  L43
	clr  r1
	li   r2, kscanfast
	bl   *r2
	movb @>8375, r1
	li   r2, >2000
	cb   r1, r2
	jeq  L47
	clr  r13
	jmp  L43
L47
	li   r1, LC4
	bl   @puts
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L48
L45
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
	jmp  L48
L46
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
	jmp  L48
L35
	andi r9, >4
	ci   r9, 0
	jne  L36
	li   r1, >1
L49
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L48
L36
	li   r1, LC1
	bl   @puts
	li   r1, >1
	jmp  L49
L48
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
	mov  @CF7Classic99, r1
	jne  JMP_4
	b    @L51
JMP_4
* Begin inline assembler code
* 734 "main.c" 1
	li r12,>1000
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r1, >300
	movb r1, @>5F0F
	movb @>5E03, r9
	bl   @cf7WaitForReady
	ci   r1, 0
	jeq  JMP_5
	b    @L53
JMP_5
L79
	mov  @CF7Classic99, r1
	jne  JMP_6
	b    @L54
JMP_6
* Begin inline assembler code
* 739 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	b    @L78
L51
* Begin inline assembler code
* 734 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r1, >300
	movb r1, @>5F0F
	movb @>5E03, r9
	bl   @cf7WaitForReady
	ci   r1, 0
	jne  JMP_7
	b    @L79
JMP_7
L53
	dect r10
	li   r2, LC5
	mov  r2, *r10
	li   r13, printf
	bl   *r13
	inct r10
	ci   r9, >3FFF
	jh  JMP_8
	b    @L77
JMP_8
	srl  r9, 8
L56
	ai   r10, >FFFC
	li   r1, LC21
	mov  r1, *r10
	mov  r9, @>2(r10)
	bl   *r13
	ai   r10, >4
L73
	mov  @CF7Classic99, r1
	jeq  JMP_9
	b    @L80
JMP_9
* Begin inline assembler code
* 776 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	b    @L78
L54
* Begin inline assembler code
* 739 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	b    @L78
L77
	srl  r9, 8
	mov  r9, r1
	a    r9, r1
	mov  @L72(r1), r2
	b    *r2
	even
L72
		data		L57
		data		L58
		data		L56
		data		L59
		data		L56
		data		L60
		data		L56
		data		L56
		data		L56
		data		L61
		data		L56
		data		L56
		data		L62
		data		L56
		data		L56
		data		L56
		data		L63
		data		L64
		data		L56
		data		L56
		data		L63
		data		L56
		data		L56
		data		L56
		data		L65
		data		L56
		data		L56
		data		L56
		data		L56
		data		L56
		data		L56
		data		L66
		data		L67
		data		L68
		data		L56
		data		L56
		data		L56
		data		L56
		data		L56
		data		L56
		data		L56
		data		L56
		data		L56
		data		L56
		data		L56
		data		L56
		data		L56
		data		L69
		data		L60
		data		L60
		data		L60
		data		L60
		data		L60
		data		L70
		data		L70
		data		L60
		data		L62
		data		L56
		data		L71
		data		L62
		data		L62
		data		L56
		data		L60
		data		L62
L80
* Begin inline assembler code
* 776 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	b    @L78
L71
	li   r1, LC17
	bl   @puts
	b    @L73
L70
	li   r1, LC12
	bl   @puts
	b    @L73
L69
	li   r1, LC11
	bl   @puts
	b    @L73
L68
	li   r1, LC10
	bl   @puts
	b    @L73
L67
	li   r1, LC9
	bl   @puts
	b    @L73
L66
	li   r1, LC18
	bl   @puts
	b    @L73
L65
	li   r1, LC14
	bl   @puts
	b    @L73
L64
	li   r1, LC13
	bl   @puts
	b    @L73
L63
	li   r1, LC16
	bl   @puts
	b    @L73
L62
	li   r1, LC19
	bl   @puts
	b    @L73
L61
	li   r1, LC8
	bl   @puts
	b    @L73
L60
	li   r1, LC15
	bl   @puts
	b    @L73
L59
	li   r1, LC20
	bl   @puts
	b    @L73
L58
	li   r1, LC7
	bl   @puts
	b    @L73
L57
	li   r1, LC6
	bl   @puts
	b    @L73
L78
	.size	cf7CardError, .-cf7CardError
LC22
	text 'No data!'
	byte 0
	even

	def	cf7ReadSector
cf7ReadSector
	ai   r10, >FFFA
	mov  r11, *r10
	mov  r9, @>2(r10)
	clr  @>4(r10)
	mov  @CF7Classic99, r3
	jne  JMP_10
	b    @L82
JMP_10
* Begin inline assembler code
* 880 "main.c" 1
	li r12,>1000
	sbo 0
* 0 "" 2
* End of inline assembler code
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
	li   r9, cf7WaitForReady
	bl   *r9
	ci   r1, 0
	jeq  JMP_11
	b    @L84
JMP_11
L97
	mov  @CF7Classic99, r2
	jne  JMP_12
	b    @L85
JMP_12
* Begin inline assembler code
* 885 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	inct r10
	b    *r11
	b    @L96
L82
* Begin inline assembler code
* 880 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
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
	li   r9, cf7WaitForReady
	bl   *r9
	ci   r1, 0
	jne  JMP_13
	b    @L97
JMP_13
L84
	li   r2, >2000
	movb r2, @>5F0F
	bl   *r9
	ci   r1, 0
	jeq  JMP_14
	b    @L87
JMP_14
	mov  @CF7Classic99, r2
	jne  JMP_15
	b    @L88
JMP_15
* Begin inline assembler code
* 899 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	inct r10
	b    *r11
	b    @L96
L85
* Begin inline assembler code
* 885 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  r2, r1
	mov  *r10+, r11
	mov  *r10+, r9
	inct r10
	b    *r11
	b    @L96
L87
	movb @>5E0F, r1
	srl  r1, 8
	andi r1, >8
	ci   r1, 0
	jeq  JMP_16
	b    @L89
JMP_16
	mov  @CF7Classic99, r1
	jne  JMP_17
	b    @L90
JMP_17
* Begin inline assembler code
* 904 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, LC22
	bl   @puts
	clr  r1
L99
	mov  *r10+, r11
	mov  *r10+, r9
	inct r10
	b    *r11
	b    @L96
L89
	li   r1, buffer
L92
	movb @>5E01, *r1+
	ci   r1, buffer+512
	jne  L92
	mov  @CF7Classic99, r1
	jeq  JMP_18
	b    @L98
JMP_18
* Begin inline assembler code
* 919 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, >1
	mov  *r10+, r11
	mov  *r10+, r9
	inct r10
	b    *r11
	b    @L96
L88
* Begin inline assembler code
* 899 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  r2, r1
	mov  *r10+, r11
	mov  *r10+, r9
	inct r10
	b    *r11
	b    @L96
L90
* Begin inline assembler code
* 904 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, LC22
	bl   @puts
	clr  r1
	b    @L99
L98
* Begin inline assembler code
* 919 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, >1
	mov  *r10+, r11
	mov  *r10+, r9
	inct r10
	b    *r11
L96
	.size	cf7ReadSector, .-cf7ReadSector
LC23
	text 'CF writing 0x%X%X%X%X - '
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
	mov  @CF7Classic99, r1
	jne  JMP_19
	b    @L101
JMP_19
* Begin inline assembler code
* 930 "main.c" 1
	li r12,>1000
	sbo 0
* 0 "" 2
* End of inline assembler code
	mov  r13, r2
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
	jeq  JMP_20
	b    @L103
JMP_20
L123
	mov  @CF7Classic99, r2
	jeq  JMP_21
	b    @L121
JMP_21
* Begin inline assembler code
* 935 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  r2, r1
L105
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L122
L101
* Begin inline assembler code
* 930 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	mov  r13, r2
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
	jne  JMP_22
	b    @L123
JMP_22
L103
	ai   r10, >FFF6
	li   r1, LC23
	mov  r1, *r10
	mov  r2, @>2(r10)
	andi r13, >FF
	mov  r13, @>4(r10)
	mov  r15, @>6(r10)
	andi r9, >FF
	mov  r9, @>8(r10)
	li   r9, printf
	bl   *r9
	li   r2, >3000
	movb r2, @>5F0F
	clr  @>14(r10)
	mov  @>14(r10), r1
	ai   r10, >A
	ci   r1, >63
	jgt  L106
L118
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	mov  @>A(r10), r1
	ci   r1, >63
	jlt  L118
	jeq  L118
L106
	bl   *r14
	ci   r1, 0
	jne  JMP_23
	b    @L124
JMP_23
	movb @>5E0F, r1
	srl  r1, 8
	andi r1, >8
	ci   r1, 0
	jeq  JMP_24
	b    @L110
JMP_24
	mov  @CF7Classic99, r1
	jne  JMP_25
	b    @L111
JMP_25
* Begin inline assembler code
* 953 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, LC22
	bl   @puts
	clr  r1
L125
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L122
L121
* Begin inline assembler code
* 935 "main.c" 1
	li r12,>1000
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
	b    @L122
L124
	mov  @CF7Classic99, r2
	jne  JMP_26
	b    @L109
JMP_26
* Begin inline assembler code
* 948 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    @L105
L109
* Begin inline assembler code
* 948 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  r2, r1
	b    @L105
L111
* Begin inline assembler code
* 953 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, LC22
	bl   @puts
	clr  r1
	b    @L125
L110
	li   r1, >2E
	bl   @putchar
	li   r1, buffer
L113
	movb *r1+, @>5F01
	ci   r1, buffer+512
	jne  L113
	dect r10
	li   r1, LC24
	mov  r1, *r10
	bl   *r9
	inct r10
	bl   *r14
	ci   r1, 0
	jeq  JMP_27
	b    @L114
JMP_27
	mov  @CF7Classic99, r2
	jne  JMP_28
	b    @L115
JMP_28
* Begin inline assembler code
* 965 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    @L105
L115
* Begin inline assembler code
* 965 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  r2, r1
	b    @L105
L114
	li   r1, LC25
	bl   @puts
	mov  @CF7Classic99, r1
	jeq  JMP_29
	b    @L126
JMP_29
* Begin inline assembler code
* 971 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, >1
	b    @L105
L126
* Begin inline assembler code
* 971 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, >1
	b    @L105
L122
	.size	cf7WriteSector, .-cf7WriteSector
LC26
	text 'Page %d >%X%X, cart >%X%X != >%X%X'
	byte 10
	byte 0
	even

	def	flashVerify
flashVerify
	dect r10
	mov  r11, *r10
	mov  r1, r3
	andi r3, >FFF
	a    r3, r3
	ai   r3, >6000
	mov  r1, r4
	srl  r4, >4
	andi r4, >300
	ori  r4, >1000
	movb r4, *r3
	ai   r2, >6000
	li   r3, buffer
	jmp  L130
L128
	inct r2
	inct r3
	ci   r3, buffer+512
	jeq  L133
L130
	mov  *r3, r4
	mov  *r2, r5
	c    r5, r4
	jeq  L128
	ai   r10, >FFF0
	li   r3, LC26
	mov  r3, *r10
	mov  r1, @>2(r10)
	mov  r2, r1
	srl  r1, >8
	mov  r1, @>4(r10)
	andi r2, >FF
	mov  r2, @>6(r10)
	mov  r5, r1
	srl  r1, >8
	mov  r1, @>8(r10)
	andi r5, >FF
	mov  r5, @>A(r10)
	mov  r4, r1
	srl  r1, >8
	mov  r1, @>C(r10)
	andi r4, >FF
	mov  r4, @>E(r10)
	bl   @printf
	clr  r1
	ai   r10, >10
	mov  *r10+, r11
	b    *r11
	jmp  L134
L133
	li   r1, >1
	mov  *r10+, r11
	b    *r11
L134
	.size	flashVerify, .-flashVerify
LC27
	text 'Ready          : yes'
	byte 0
LC28
	text 'no'
	byte 0
LC29
	text 'yes'
	byte 0
LC30
	text 'Erase suspend  : %s'
	byte 10
	byte 0
LC31
	text 'ok'
	byte 0
LC32
	text 'fail'
	byte 0
LC33
	text 'Erase status   : %s'
	byte 10
	byte 0
LC34
	text 'Program status : %s'
	byte 10
	byte 0
LC35
	text 'Write Buf Abort: %s'
	byte 10
	byte 0
LC36
	text 'Program suspend: %s'
	byte 10
	byte 0
LC37
	text 'Sector locked  : %s'
	byte 10
	byte 0
LC38
	text 'Continuity     : %s'
	byte 10
	byte 0
LC39
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
	movb r1, @>6000
	li   r0, >7010
	movb r0, @>EAAA
	swpb r0
	movb r0, @>6000
	mov  @>6000, r13
	swpb r13
	jeq  0
	cb  r13, @$-1
	jlt  L149
	li   r1, LC39
	bl   @puts
	li   r1, >1800
	movb r1, @>6000
	li   r12, >7110
	movb r12, @>EAAA
	swpb r12
	movb r12, @>6000
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    *r11
	b    @L150
L149
	li   r1, LC27
	bl   @puts
	srl  r13, 8
	mov  r13, r1
	andi r1, >40
	jeq  JMP_30
	b    @L137
JMP_30
	li   r1, LC28
	ai   r10, >FFFC
	li   r2, LC30
	mov  r2, *r10
	mov  r1, @>2(r10)
	li   r9, printf
	bl   *r9
	mov  r13, r1
	andi r1, >20
	ai   r10, >4
	ci   r1, 0
	jeq  JMP_31
	b    @L139
JMP_31
L151
	li   r1, LC31
	ai   r10, >FFFC
	li   r2, LC33
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	mov  r13, r1
	andi r1, >10
	ai   r10, >4
	ci   r1, 0
	jeq  JMP_32
	b    @L141
JMP_32
L152
	li   r1, LC31
	ai   r10, >FFFC
	li   r2, LC34
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	mov  r13, r1
	andi r1, >8
	ai   r10, >4
	ci   r1, 0
	jeq  JMP_33
	b    @L143
JMP_33
L153
	li   r1, LC28
	ai   r10, >FFFC
	li   r2, LC35
	mov  r2, *r10
	mov  r1, @>2(r10)
	li   r14, printf
	bl   *r9
	andi r13, >4
	ai   r10, >4
	ci   r13, 0
	jne  JMP_34
	b    @L145
JMP_34
L154
	ai   r10, >FFFC
	li   r2, LC36
	mov  r2, *r10
	li   r1, LC29
	mov  r1, @>2(r10)
	bl   *r14
	li   r2, LC37
	mov  r2, *r10
	li   r1, LC29
	mov  r1, @>2(r10)
	bl   *r14
	li   r1, LC31
	ai   r10, >4
L147
	ai   r10, >FFFC
	li   r2, LC38
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	ai   r10, >4
	li   r1, >1800
	movb r1, @>6000
	li   r12, >7110
	movb r12, @>EAAA
	swpb r12
	movb r12, @>6000
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    *r11
	b    @L150
L137
	li   r1, LC29
	ai   r10, >FFFC
	li   r2, LC30
	mov  r2, *r10
	mov  r1, @>2(r10)
	li   r9, printf
	bl   *r9
	mov  r13, r1
	andi r1, >20
	ai   r10, >4
	ci   r1, 0
	jne  JMP_35
	b    @L151
JMP_35
L139
	li   r1, LC32
	ai   r10, >FFFC
	li   r2, LC33
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	mov  r13, r1
	andi r1, >10
	ai   r10, >4
	ci   r1, 0
	jne  JMP_36
	b    @L152
JMP_36
L141
	li   r1, LC32
	ai   r10, >FFFC
	li   r2, LC34
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r9
	mov  r13, r1
	andi r1, >8
	ai   r10, >4
	ci   r1, 0
	jne  JMP_37
	b    @L153
JMP_37
L143
	li   r1, LC29
	ai   r10, >FFFC
	li   r2, LC35
	mov  r2, *r10
	mov  r1, @>2(r10)
	li   r14, printf
	bl   *r9
	andi r13, >4
	ai   r10, >4
	ci   r13, 0
	jeq  JMP_38
	b    @L154
JMP_38
L145
	ai   r10, >FFFC
	li   r2, LC36
	mov  r2, *r10
	li   r1, LC28
	mov  r1, @>2(r10)
	bl   *r14
	li   r2, LC37
	mov  r2, *r10
	li   r1, LC28
	mov  r1, @>2(r10)
	bl   *r14
	li   r1, LC28
	ai   r10, >4
	b    @L147
L150
	.size	flashReadStatus, .-flashReadStatus
LC40
	text '>%X: '
	byte 0
LC41
	text 'failed'
	byte 0
LC42
	text 'aborted'
	byte 0
LC43
	text 'Erase operation reports %s'
	byte 10
	byte 0
LC44
	text 'Write operation reports %s'
	byte 10
	byte 0
LC45
	byte 13
	text 'Waiting... >%X != >%X - %ds'
	byte 0
LC46
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
	movb r3, r13
	mov  r1, r3
	andi r3, >FFF
	a    r3, r3
	ai   r3, >6000
	srl  r1, >4
	andi r1, >300
	ori  r1, >1000
	movb r1, *r3
	mov  r2, r14
	ai   r14, >6000
	clr  r15
	movb r13, r7
	srl  r7, 8
	li   r6, printf
	li   r5, kscanfast
	li   r3, >2000
L167
	clr  r2
L172
	movb *r14, r1
	cb   r1, r13
	jeq  L173
	srl  r1, 8
	mov  r1, r9
	andi r9, >22
	jne  L174
	movb @>8802, r4
	jgt  L172
	jeq  L172
	inc  r2
	ci   r2, >3C
	jne  L172
	inc  r15
	ai   r10, >FFF8
	li   r4, LC45
	mov  r4, *r10
	mov  r1, @>2(r10)
	mov  r7, @>4(r10)
	mov  r15, @>6(r10)
	mov  r3, @>18(r10)
	mov  r5, @>16(r10)
	mov  r6, @>14(r10)
	mov  r7, @>12(r10)
	bl   *r6
	ai   r10, >8
	mov  r9, r1
	mov  @>E(r10), r5
	bl   *r5
	movb @>8375, r1
	mov  @>10(r10), r3
	mov  @>E(r10), r5
	mov  @>C(r10), r6
	mov  @>A(r10), r7
	cb   r1, r3
	jne  L167
	li   r1, LC46
	bl   @puts
	mov  r9, r1
	jmp  L158
L173
	ci   r15, 0
	jeq  L157
	li   r1, >A
	bl   @putchar
	li   r1, >1
L158
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >A
	b    *r11
	b    @L175
L174
	movb *r14, r9
	cb   r9, r13
	jeq  L157
	srl  r9, 8
	ai   r10, >FFFC
	li   r1, LC40
	mov  r1, *r10
	mov  r9, @>2(r10)
	li   r13, printf
	bl   *r13
	mov  r9, r1
	andi r1, >8
	ai   r10, >4
	ci   r1, 0
	jeq  L160
	andi r9, >2
	ci   r9, 0
	jne  L161
	li   r1, LC41
L162
	ai   r10, >FFFC
	li   r2, LC43
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r13
	ai   r10, >4
	bl   @flashReadStatus
	clr  r1
L176
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >A
	b    *r11
	jmp  L175
L157
	li   r1, >1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >A
	b    *r11
	jmp  L175
L160
	andi r9, >2
	ci   r9, 0
	jne  L164
	li   r1, LC41
L165
	ai   r10, >FFFC
	li   r2, LC44
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r13
	ai   r10, >4
	bl   @flashReadStatus
	clr  r1
	jmp  L176
L164
	li   r1, LC42
	jmp  L165
L161
	li   r1, LC42
	jmp  L162
L175
	.size	flashWaitForWrite, .-flashWaitForWrite
LC47
	text 'Resetting flash chip...'
	byte 0
LC48
	text 'Erasing flash chip...'
	byte 0
LC49
	text 'Erase failed to start, failing.'
	byte 0
LC50
	text 'Status >%X - assuming erase start.'
	byte 10
	byte 0
LC51
	text 'Erase completed'
	byte 0
	even

	def	flashChipErase
flashChipErase
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	li   r1, >1800
	movb r1, @>6000
	li   r2, >F000
	movb r2, @>EAAA
	movb r1, @>6000
	li   r6, >AA14
	movb r6, @>EAAA
	swpb r6
	movb r6, @>6000
	li   r5, >5518
	movb r5, @>E555
	swpb r5
	movb r5, @>6000
	li   r4, >F071
	movb r4, @>EAAA
	swpb r4
	movb r4, @>EAAA
	li   r9, puts
	li   r1, LC47
	bl   *r9
	li   r1, LC48
	bl   *r9
	li   r3, >18AA
	movb r3, @>6000
	swpb r3
	movb r3, @>EAAA
	li   r2, >1455
	movb r2, @>6000
	swpb r2
	movb r2, @>E555
	li   r1, >1800
	movb r1, @>6000
	li   r2, >8000
	movb r2, @>EAAA
	movb r1, @>6000
	li   r1, >AA14
	movb r1, @>EAAA
	swpb r1
	movb r1, @>6000
	li   r13, >5518
	movb r13, @>E555
	swpb r13
	movb r13, @>6000
	li   r1, >1000
	movb r1, @>EAAA
	movb r1, @>6020
	movb @>6000, r1
	seto r13
	cb   r1, r13
	jeq  L182
	ai   r10, >FFFC
	li   r2, LC50
	mov  r2, *r10
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   @printf
	ai   r10, >4
	li   r1, >10
	clr  r2
	movb r13, r3
	bl   @flashWaitForWrite
	ci   r1, 0
	jne  L183
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	jmp  L184
L183
	li   r1, LC51
	bl   *r9
	li   r1, >1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	jmp  L184
L182
	li   r1, LC49
	bl   *r9
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
L184
	.size	flashChipErase, .-flashChipErase
LC52
	text 'Writing page 0x%d, address 0x%X%X'
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
	li   r4, >1800
	movb r4, @>6000
	li   r1, >F000
	movb r1, @>EAAA
	movb r4, @>6000
	li   r1, >AA14
	movb r1, @>EAAA
	swpb r1
	movb r1, @>6000
	li   r13, >5518
	movb r13, @>E555
	swpb r13
	movb r13, @>6000
	li   r0, >F071
	movb r0, @>EAAA
	swpb r0
	movb r0, @>EAAA
	ai   r10, >FFF8
	li   r3, LC52
	mov  r3, *r10
	mov  r15, @>2(r10)
	mov  r9, r1
	srl  r1, >8
	mov  r1, @>4(r10)
	mov  r9, r4
	andi r4, >FF
	mov  r4, @>6(r10)
	mov  r2, @>14(r10)
	bl   @printf
	li   r13, buffer
	ai   r10, >8
	ai   r14, >6000
	mov  @>C(r10), r2
	movb r2, r3
	ori  r3, >1800
	movb r3, @>A(r10)
	ori  r2, >1400
	movb r2, @>B(r10)
	jmp  L191
L194
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
	jeq  L190
L195
	inc  r13
	ci   r13, buffer+512
	jeq  L193
	inc  r9
L191
	li   r12, >18AA
	movb r12, @>6000
	swpb r12
	movb r12, @>EAAA
	li   r8, >1455
	movb r8, @>6000
	swpb r8
	movb r8, @>E555
	li   r7, >18A0
	movb r7, @>6000
	swpb r7
	movb r7, @>EAAA
	mov  r9, r2
	andi r2, >1
	jne  L194
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
	jne  L195
L190
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	jmp  L196
L193
	li   r1, >1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
L196
	.size	flashWriteSlow, .-flashWriteSlow
LC53
	text '* Can''t write to unaligned address: %X%X'
	byte 10
	byte 0
	even

	def	flashWriteFast
flashWriteFast
	ai   r10, >FFEE
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r1, r8
	mov  r2, r9
	andi r9, >FF
	jeq  JMP_39
	b    @L207
JMP_39
	mov  r8, r1
	srl  r1, >4
	andi r1, >300
	li   r3, >1800
	movb r3, @>6000
	li   r4, >F000
	movb r4, @>EAAA
	movb r3, @>6000
	li   r7, >AA14
	movb r7, @>EAAA
	swpb r7
	movb r7, @>6000
	li   r6, >5518
	movb r6, @>E555
	swpb r6
	movb r6, @>6000
	li   r5, >F071
	movb r5, @>EAAA
	swpb r5
	movb r5, @>EAAA
	mov  r8, r13
	andi r13, >FF0
	a    r13, r13
	ai   r13, >6000
	movb r1, r12
	ori  r12, >1800
	mov  r8, r7
	andi r7, >FFF
	a    r7, r7
	ai   r7, >6000
	ori  r1, >1C00
	movb r1, @>A(r10)
	li   r15, buffer
	mov  r2, r14
	ai   r14, >FE
L203
	li   r4, >18AA
	movb r4, @>6000
	swpb r4
	movb r4, @>EAAA
	li   r3, >1455
	movb r3, @>6000
	swpb r3
	movb r3, @>E555
	movb r12, *r13
	li   r2, >25FF
	movb r2, @>E000
	swpb r2
	movb r2, @>E000
	movb @>A(r10), *r7
	mov  r9, r3
	ai   r9, >100
	c    r3, r9
	jhe  L200
	mov  r14, r5
	ai   r5, >DF02
	mov  r15, r4
L201
	mov  *r4+, *r5+
	inct r3
	c    r3, r9
	jl  L201
L200
	movb r12, *r13
	li   r3, >2900
	movb r3, @>E000
	mov  r8, r1
	mov  r14, r2
	movb @>FE(r15), r3
	mov  r7, @>C(r10)
	mov  r8, @>10(r10)
	mov  r12, @>E(r10)
	li   r4, flashWaitForWrite
	bl   *r4
	mov  @>C(r10), r7
	mov  @>10(r10), r8
	mov  @>E(r10), r12
	ci   r1, 0
	jeq  L199
	ai   r15, >100
	ai   r14, >100
	ci   r9, >200
	jne  L203
	li   r1, >1
L199
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >A
	b    *r11
	jmp  L208
L207
	ai   r10, >FFFA
	li   r3, LC53
	mov  r3, *r10
	srl  r2, >8
	mov  r2, @>2(r10)
	mov  r9, @>4(r10)
	bl   @printf
	clr  r1
	ai   r10, >6
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >A
	b    *r11
L208
	.size	flashWriteFast, .-flashWriteFast
LC54
	text 'Checking if erase is needed...'
	byte 0
LC55
	text '%d%%...'
	byte 0
LC56
	text 'Yes, '
	byte 0
LC57
	text 'Programming...'
	byte 0
LC58
	byte 10
	text 'Failed at CF Sector >%X%X%X%X'
	byte 10
	byte 0
LC59
	byte 10
	byte 10
	text '** DONE **'
	byte 0
	even

	def	program
program
	ai   r10, >FFF0
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	li   r1, LC54
	li   r2, puts
	bl   *r2
	li   r2, >20
	clr  r9
	li   r4, >10
	li   r13, printf
L236
	mov  r2, r1
	ai   r1, >6000
	mov  r4, r3
	swpb r3
	movb r3, *r1
	li   r1, >6000
	jmp  L211
L238
	inct r1
	ci   r1, >8002
	jne  JMP_40
	b    @L237
JMP_40
L211
	seto r3
	c    *r1, r3
	jeq  L238
	li   r1, >A
	bl   @putchar
	dect r10
	li   r1, LC56
	mov  r1, *r10
	bl   @printf
	inct r10
	bl   @flashChipErase
	ci   r1, 0
	jne  JMP_41
	b    @L216
JMP_41
L215
	li   r1, LC57
	li   r2, puts
	bl   *r2
	mov  @gImage, r1
	li   r2, >20
	li   r3, >28
	li   r4, vdpmemset
	bl   *r4
	li   r13, >740
	clr  r14
	li   r1, >10
	mov  r1, @>A(r10)
	mov  r14, r15
	mov  r14, @>C(r10)
	mov  r14, @>E(r10)
	li   r9, >1
L234
	mov  r14, r1
	mov  r13, r2
	li   r3, cf7ReadSector
	bl   *r3
	ci   r1, 0
	jne  JMP_42
	b    @L222
JMP_42
L240
	mov  @>A(r10), r1
	mov  r15, r2
	li   r4, flashWriteFast
	bl   *r4
	ci   r1, 0
	jne  JMP_43
	b    @L222
JMP_43
	mov  @>A(r10), r1
	mov  r15, r2
	li   r3, flashVerify
	bl   *r3
	ci   r1, 0
	jeq  L222
	ai   r15, >200
	ci   r15, >1FFF
	jle  L223
	mov  @>A(r10), r4
	inc  r4
	mov  r4, @>A(r10)
	clr  r15
L223
	inc  r13
	jne  L224
	inc  r14
L224
	ci   r14, >4
	jle  JMP_44
	b    @L225
JMP_44
	ci   r14, >4
	jne  JMP_45
	b    @L239
JMP_45
L226
	inc  r9
	ci   r9, >443
	jlt  L234
	jeq  L234
	mov  @>C(r10), r4
	inc  r4
	mov  r4, @>C(r10)
	ci   r4, >5
	jgt  JMP_46
	b    @L218
JMP_46
	mov  @>E(r10), r1
	inc  r1
	mov  r1, @>E(r10)
	mov  @gImage, r1
	li   r2, >20
	li   r3, >28
	li   r4, vdpmemset
	bl   *r4
	li   r9, >80
	clr  r1
	mov  r1, @>C(r10)
L219
	mov  @gImage, r1
	li   r2, >85
	mov  @>E(r10), r3
	dec  r3
	li   r4, vdpmemset
	bl   *r4
L221
	mov  @>E(r10), r1
	a    @gImage, r1
	mov  r9, r2
	mov  @vdpchar, r3
	bl   *r3
	clr  r9
	mov  r14, r1
	mov  r13, r2
	li   r3, cf7ReadSector
	bl   *r3
	ci   r1, 0
	jeq  JMP_47
	b    @L240
JMP_47
L222
	ci   r13, >73F
	jh  JMP_48
	b    @L241
JMP_48
	ai   r13, >F8C0
L228
	ai   r10, >FFF6
	li   r1, LC58
	mov  r1, *r10
	mov  r14, r1
	srl  r1, >8
	mov  r1, @>2(r10)
	andi r14, >FF
	mov  r14, @>4(r10)
	mov  r13, r1
	srl  r1, >8
	mov  r1, @>6(r10)
	andi r13, >FF
	mov  r13, @>8(r10)
	bl   @printf
	clr  r1
	ai   r10, >A
L216
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >8
	b    *r11
L237
	inct r2
	ci   r2, >1FFF
	jh  JMP_49
	b    @L236
JMP_49
	inc  r9
	ci   r9, >3
	jh  L213
	ai   r10, >FFFC
	li   r4, LC55
	mov  r4, *r10
	mov  r9, r1
	a    r9, r1
	a    r9, r1
	sla  r1, >3
	a    r9, r1
	mov  r1, @>2(r10)
	bl   *r13
	clr  r2
	ai   r10, >4
	mov  r9, r4
	ori  r4, >10
	b    @L236
L239
	ci   r13, >63F
	jh  JMP_50
	b    @L226
JMP_50
L225
	li   r1, LC59
	li   r4, puts
	bl   *r4
	li   r1, >1
	jmp  L216
L218
	mov  @gImage, r1
	li   r2, >20
	li   r3, >28
	li   r4, vdpmemset
	bl   *r4
	mov  @>E(r10), r1
	jne  L220
	mov  @>C(r10), r9
	ai   r9, >80
	b    @L221
L241
	dec  r14
	ai   r13, >F8C0
	b    @L228
L213
	li   r1, >A
	bl   @putchar
	b    @L215
L220
	mov  @>C(r10), r9
	ai   r9, >80
	b    @L219
	.size	program, .-program
LC60
	text 'Identify...'
	byte 0
LC61
	text ':'
	byte 0
LC62
	text 'Size    : 0x%X%X%X%X sectors'
	byte 10
	byte 0
LC63
	text 'Capacity: 0x%X%X%X%X sectors'
	byte 10
	byte 0
LC64
	text 'LBA     : 0x%X%X%X%X sectors'
	byte 10
	byte 0
LC65
	text 'Serial: '
	byte 0
LC66
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
	mov  @CF7Classic99, r1
	jne  JMP_51
	b    @L243
JMP_51
* Begin inline assembler code
* 819 "main.c" 1
	li r12,>1000
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r9, cf7WaitForReady
	bl   *r9
	ci   r1, 0
	jeq  JMP_52
	b    @L245
JMP_52
L263
	mov  @CF7Classic99, r1
	jne  JMP_53
	b    @L246
JMP_53
* Begin inline assembler code
* 822 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    *r11
	b    @L262
L243
* Begin inline assembler code
* 819 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r9, cf7WaitForReady
	bl   *r9
	ci   r1, 0
	jne  JMP_54
	b    @L263
JMP_54
L245
	li   r1, >EC00
	movb r1, @>5F0F
	bl   *r9
	ci   r1, 0
	jne  JMP_55
	b    @L264
JMP_55
	movb @>5E0F, r1
	srl  r1, 8
	andi r1, >8
	ci   r1, 0
	jeq  JMP_56
	b    @L250
JMP_56
	mov  @CF7Classic99, r1
	jne  JMP_57
	b    @L251
JMP_57
* Begin inline assembler code
* 834 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
L252
	li   r1, LC22
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    @puts
L246
* Begin inline assembler code
* 822 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    *r11
	b    @L262
L264
	mov  @CF7Classic99, r1
	jne  JMP_58
	b    @L249
JMP_58
* Begin inline assembler code
* 829 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    *r11
	b    @L262
L249
* Begin inline assembler code
* 829 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    *r11
	b    @L262
L251
* Begin inline assembler code
* 834 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    @L252
L250
	dect r10
	li   r1, LC60
	mov  r1, *r10
	li   r14, printf
	bl   *r14
	li   r1, buffer+1
	inct r10
L253
	movb @>5E01, *r1
	movb @>5E01, @>FFFF(r1)
	inct r1
	ci   r1, buffer+513
	jne  L253
	li   r1, LC61
	bl   @puts
	mov  @CF7Classic99, r1
	jne  JMP_59
	b    @L254
JMP_59
* Begin inline assembler code
* 847 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
L255
	ai   r10, >FFF6
	li   r2, LC62
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
	li   r1, LC63
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
	li   r2, LC64
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
	li   r1, LC65
	mov  r1, *r10
	bl   *r14
	li   r9, buffer+20
	inct r10
	li   r13, putchar
L256
	movb *r9+, r1
	srl  r1, 8
	bl   *r13
	ci   r9, buffer+40
	jne  L256
	li   r1, >A
	bl   @putchar
	dect r10
	li   r2, LC66
	mov  r2, *r10
	bl   *r14
	ai   r9, >6
	inct r10
L257
	movb *r9+, r1
	srl  r1, 8
	bl   *r13
	ci   r9, buffer+76
	jne  L257
	li   r1, >A
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    @putchar
L254
* Begin inline assembler code
* 847 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    @L255
L262
	.size	cf7IdentifyDevice, .-cf7IdentifyDevice
LC67
	text 'Flash CFI information:'
	byte 0
LC68
	text 'Did NOT get QRY string: %c%c%c'
	byte 10
	byte 0
LC69
	text 'Device size: 2^%d bytes'
	byte 0
LC70
	text ' [small]'
	byte 0
LC71
	text 'Device reports 16-bit only!'
	byte 0
LC72
	text 'Vcc Min/Max: %d.%d / %d.%d V'
	byte 10
	byte 0
LC73
	text 'Timeout: Word write: %d uS'
	byte 10
	byte 0
LC74
	text '         Chip erase: 2^%d mS'
	byte 10
	byte 0
LC75
	text 'Max multi-byte write size: %d bytes'
	byte 10
	byte 0
LC76
	text 'Did NOT get PRI or not at 0x40: %c%c%c'
	byte 10
	byte 0
LC77
	text 'CFI version 1.%d'
	byte 10
	byte 0
LC78
	text 'Process: '
	byte 0
LC79
	text '.23um floating'
	byte 0
LC80
	text '.17us floating'
	byte 0
LC81
	text '.23um MirrorBit'
	byte 0
LC82
	text '.13um floating'
	byte 0
LC83
	text '.11um MirrorBit'
	byte 0
LC84
	text '.09um MirrorBit'
	byte 0
LC85
	text '.09um floating'
	byte 0
LC86
	text '.065um MirrorBit Ec'
	byte 0
LC87
	text '.065um MirrorBit'
	byte 0
LC88
	text '0.045um MirrorBit'
	byte 0
LC89
	text 'unknown: %d'
	byte 10
	byte 0
LC90
	text 'Unlock is not address sensitive.'
	byte 0
LC91
	text 'WP# pin: '
	byte 0
LC92
	text 'none'
	byte 0
LC93
	text '64kb dual boot'
	byte 0
LC94
	text 'bottom boot'
	byte 0
LC95
	text 'top boot'
	byte 0
LC96
	text 'uniform bottom boot'
	byte 0
LC97
	text 'uniform top boot'
	byte 0
LC98
	text 'all sectors'
	byte 0
LC99
	text 'uniform dual'
	byte 0
LC100
	text 'un'
	byte 0
LC101
	byte 0
LC102
	text 'Customer OTP area: 2^%d (%slocked)'
	byte 10
	byte 0
LC103
	text 'Page size = %d bytes'
	byte 10
	byte 0
LC104
	text 'Page size not available pre 1.5'
	byte 0
	even

	def	flashReadCfi
flashReadCfi
	ai   r10, >FFF8
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	li   r9, puts
	li   r1, LC67
	bl   *r9
	li   r1, >1800
	movb r1, @>6000
	li   r12, >9810
	movb r12, @>E0AA
	swpb r12
	movb r12, @>6000
	clr  r1
L266
	mov  r1, r2
	ai   r2, >6000
	mov  *r2, @buffer(r1)
	inct r1
	ci   r1, >F4
	jne  L266
	li   r4, >1800
	movb r4, @>6000
	li   r8, >F010
	movb r8, @>E0AA
	swpb r8
	movb r8, @>6000
	movb @buffer+32, r2
	li   r1, >5100
	cb   r2, r1
	jne  JMP_60
	b    @L267
JMP_60
	movb @buffer+34, r1
	movb @buffer+36, r3
L268
	ai   r10, >FFF8
	li   r4, LC68
	mov  r4, *r10
	srl  r2, 8
	mov  r2, @>2(r10)
	srl  r1, 8
	mov  r1, @>4(r10)
	srl  r3, 8
	mov  r3, @>6(r10)
	li   r13, printf
	bl   *r13
	li   r14, >1
	ai   r10, >8
L271
	li   r1, >4000
	cb   @buffer+42, r1
	jeq  L280
	movb @buffer+128, r1
	movb @buffer+130, r3
	movb @buffer+132, r2
L281
	ai   r10, >FFF8
	li   r4, LC76
	mov  r4, *r10
	srl  r1, 8
	mov  r1, @>2(r10)
	srl  r3, 8
	mov  r3, @>4(r10)
	srl  r2, 8
	mov  r2, @>6(r10)
	bl   *r13
	ai   r10, >8
L285
	ci   r14, 0
	jeq  L320
	li   r9, buffer
	li   r14, putchar
	li   r13, >5A00
	jmp  L319
L326
	srl  r1, 8
	bl   *r14
	inc  r9
	ci   r9, buffer+512
	jeq  L325
L319
	movb *r9, r1
	movb r1, r2
	ai   r2, >E000
	cb   r2, r13
	jle  L326
	li   r1, >20
	bl   *r14
	inc  r9
	ci   r9, buffer+512
	jne  L319
L325
	li   r1, >A
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    @putchar
L267
	movb @buffer+34, r1
	li   r3, >5200
	cb   r1, r3
	jeq  L269
	movb @buffer+36, r3
	b    @L268
L280
	movb @buffer+128, r1
	li   r2, >5000
	cb   r1, r2
	jne  JMP_61
	b    @L282
JMP_61
	movb @buffer+130, r3
	movb @buffer+132, r2
	b    @L281
L320
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    *r11
L269
	movb @buffer+36, r3
	li   r4, >5900
	cb   r3, r4
	jeq  JMP_62
	b    @L268
JMP_62
	ai   r10, >FFFC
	li   r1, LC69
	mov  r1, *r10
	movb @buffer+78, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	li   r13, printf
	bl   *r13
	ai   r10, >4
	li   r1, >1B00
	cb   @buffer+78, r1
	jeq  L272
	dect r10
	li   r2, LC70
	mov  r2, *r10
	bl   *r13
	inct r10
L272
	li   r1, >A
	bl   @putchar
	li   r1, >100
	cb   @buffer+80, r1
	jne  JMP_63
	b    @L327
JMP_63
L273
	movb @buffer+54, r2
	movb @buffer+56, r1
	ai   r10, >FFF6
	li   r3, LC72
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
	bl   *r13
	movb @buffer+62, r3
	srl  r3, 8
	ai   r10, >A
	ci   r3, 0
	jne  JMP_64
	b    @L328
JMP_64
	clr  r2
	li   r1, >1
L276
	a    r1, r1
	inc  r2
	c    r2, r3
	jlt  L276
L275
	ai   r10, >FFFC
	li   r3, LC73
	mov  r3, *r10
	mov  r1, @>2(r10)
	bl   *r13
	li   r4, LC74
	mov  r4, *r10
	movb @buffer+68, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   *r13
	movb @buffer+84, r3
	srl  r3, 8
	ai   r10, >4
	ci   r3, 0
	jne  JMP_65
	b    @L329
JMP_65
	clr  r2
	li   r1, >1
L279
	a    r1, r1
	inc  r2
	c    r3, r2
	jgt  L279
L278
	ai   r10, >FFFC
	li   r2, LC75
	mov  r2, *r10
	mov  r1, @>2(r10)
	bl   *r13
	clr  r14
	ai   r10, >4
	b    @L271
L282
	movb @buffer+130, r3
	li   r2, >5200
	cb   r3, r2
	jeq  L283
	movb @buffer+132, r2
	b    @L281
L283
	movb @buffer+132, r2
	li   r4, >4900
	cb   r2, r4
	jeq  JMP_66
	b    @L281
JMP_66
	ai   r10, >FFFC
	li   r1, LC77
	mov  r1, *r10
	movb @buffer+136, r1
	srl  r1, 8
	andi r1, >F
	mov  r1, @>2(r10)
	bl   *r13
	inct r10
	li   r3, LC78
	mov  r3, *r10
	bl   *r13
	movb @buffer+138, r1
	srl  r1, >2
	srl  r1, 8
	andi r1, >F
	inct r10
	ci   r1, >9
	jh  JMP_67
	b    @L330
JMP_67
	ai   r10, >FFFC
	li   r3, LC89
	mov  r3, *r10
	mov  r1, @>2(r10)
	bl   @printf
	ai   r10, >4
L298
	movb @buffer+138, r1
	srl  r1, 8
	andi r1, >3
	ci   r1, 0
	jeq  JMP_68
	b    @L331
JMP_68
L299
	dect r10
	li   r1, LC91
	mov  r1, *r10
	bl   *r13
	movb @buffer+158, r1
	inct r10
	ci   r1, >7FF
	jle  L332
	ai   r10, >FFFC
	li   r3, LC89
	mov  r3, *r10
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   @printf
	ai   r10, >4
L310
	li   r1, >3400
	cb   @buffer+136, r1
	jh  JMP_69
	b    @L311
JMP_69
	movb @buffer+164, r2
	movb @buffer+6, r1
	srl  r1, 8
	andi r1, >40
	ci   r1, 0
	jeq  JMP_70
	b    @L312
JMP_70
	li   r1, LC100
L313
	ai   r10, >FFFA
	li   r3, LC102
	mov  r3, *r10
	srl  r2, 8
	mov  r2, @>2(r10)
	mov  r1, @>4(r10)
	bl   *r13
	movb @buffer+168, r3
	srl  r3, 8
	clr  r2
	li   r1, >1
	ai   r10, >6
	jmp  L314
L315
	a    r1, r1
	inc  r2
L314
	c    r2, r3
	jlt  L315
	ai   r10, >FFFC
	li   r4, LC103
	mov  r4, *r10
	mov  r1, @>2(r10)
	bl   *r13
	ai   r10, >4
	b    @L285
L330
	a    r1, r1
	mov  @L297(r1), r2
	b    *r2
	even
L297
		data		L287
		data		L288
		data		L289
		data		L290
		data		L291
		data		L292
		data		L293
		data		L294
		data		L295
		data		L296
L332
	srl  r1, 8
	a    r1, r1
	mov  @L309(r1), r2
	b    *r2
	even
L309
		data		L301
		data		L302
		data		L303
		data		L304
		data		L305
		data		L306
		data		L307
		data		L308
L331
	li   r1, LC90
	bl   *r9
	b    @L299
L307
	li   r1, LC98
	bl   *r9
	b    @L310
L306
	li   r1, LC97
	bl   *r9
	b    @L310
L305
	li   r1, LC96
	bl   *r9
	b    @L310
L304
	li   r1, LC95
	bl   *r9
	b    @L310
L303
	li   r1, LC94
	bl   *r9
	b    @L310
L302
	li   r1, LC93
	bl   *r9
	b    @L310
L301
	li   r1, LC92
	bl   *r9
	b    @L310
L308
	li   r1, LC99
	bl   *r9
	b    @L310
L329
	li   r1, >1
	b    @L278
L328
	li   r1, >1
	b    @L275
L327
	li   r1, LC71
	bl   *r9
	b    @L273
L312
	li   r1, LC101
	b    @L313
L311
	li   r1, LC104
	bl   *r9
	b    @L285
L295
	li   r1, LC87
	bl   *r9
	b    @L298
L294
	li   r1, LC86
	bl   *r9
	b    @L298
L293
	li   r1, LC85
	bl   *r9
	b    @L298
L292
	li   r1, LC84
	bl   *r9
	b    @L298
L291
	li   r1, LC83
	bl   *r9
	b    @L298
L290
	li   r1, LC82
	bl   *r9
	b    @L298
L289
	li   r1, LC81
	bl   *r9
	b    @L298
L288
	li   r1, LC80
	bl   *r9
	b    @L298
L287
	li   r1, LC79
	bl   *r9
	b    @L298
L296
	li   r1, LC88
	bl   *r9
	b    @L298
	.size	flashReadCfi, .-flashReadCfi
LC105
	text 'CF7+'
	byte 0
LC106
	text 'CF7 detected on Classic99 base >1000'
	byte 0
LC107
	text 'CF7 not detected at >1100 or >1000'
	byte 0
	even

	def	cf7DetectClassic99
cf7DetectClassic99
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
* Begin inline assembler code
* 978 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r9, >4000
	li   r13, memcmp
	jmp  L336
L334
	inc  r9
	ci   r9, >4100
	jne  JMP_71
	b    @L342
JMP_71
L336
	mov  r9, r1
	li   r2, LC105
	li   r3, >4
	bl   *r13
	ci   r1, 0
	jne  L334
* Begin inline assembler code
* 981 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	mov  r1, @CF7Classic99
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
L342
* Begin inline assembler code
* 986 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* 988 "main.c" 1
	li r12,>1000
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r9, >4000
	jmp  L338
L337
	inc  r9
	ci   r9, >4100
	jne  JMP_72
	b    @L343
JMP_72
L338
	mov  r9, r1
	li   r2, LC105
	li   r3, >4
	bl   *r13
	ci   r1, 0
	jne  L337
* Begin inline assembler code
* 991 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, >1
	mov  r1, @CF7Classic99
	li   r1, LC106
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @puts
L343
* Begin inline assembler code
* 997 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	li   r1, LC107
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @puts
	.size	cf7DetectClassic99, .-cf7DetectClassic99
LC108
	text 'Sector erase page %d is not 128k aligned'
	byte 10
	byte 0
LC109
	text 'Erasing sector %d'
	byte 10
	byte 0
LC110
	text 'Verifying...'
	byte 0
LC111
	text 'Failed'
	byte 0
LC112
	text 'Index %d on page %d is not erased.'
	byte 10
	byte 0
	even

	def	flashSectorErase
flashSectorErase
	ai   r10, >FFF6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r1, r13
	mov  r1, r14
	andi r14, >F
	jeq  JMP_73
	b    @L352
JMP_73
	li   r1, >1800
	movb r1, @>6000
	li   r2, >F000
	movb r2, @>EAAA
	movb r1, @>6000
	li   r3, >AA14
	movb r3, @>EAAA
	swpb r3
	movb r3, @>6000
	li   r2, >5518
	movb r2, @>E555
	swpb r2
	movb r2, @>6000
	li   r1, >F071
	movb r1, @>EAAA
	swpb r1
	movb r1, @>EAAA
	ai   r10, >FFFC
	li   r1, LC109
	mov  r1, *r10
	mov  r13, @>2(r10)
	li   r2, printf
	bl   *r2
	li   r15, >18AA
	movb r15, @>6000
	swpb r15
	movb r15, @>EAAA
	li   r9, >1455
	movb r9, @>6000
	swpb r9
	movb r9, @>E555
	li   r1, >1800
	movb r1, @>6000
	li   r2, >8000
	movb r2, @>EAAA
	movb r1, @>6000
	li   r1, >AA00
	movb r1, @>EAAA
	li   r0, >1455
	movb r0, @>6000
	swpb r0
	movb r0, @>E555
	mov  r13, r1
	andi r1, >FFF
	a    r1, r1
	ai   r1, >6000
	mov  r13, r3
	srl  r3, >4
	andi r3, >300
	ori  r3, >1800
	movb r3, *r1
	li   r1, >3000
	movb r1, @>E000
	ai   r10, >4
	mov  r13, r1
	mov  r14, r2
	seto r3
	bl   @flashWaitForWrite
	ci   r1, 0
	jne  L353
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L354
L353
	dect r10
	li   r2, LC110
	mov  r2, *r10
	li   r2, printf
	bl   *r2
	inct r10
	li   r1, buffer
	li   r2, >FF
	li   r3, >200
	bl   @memset
	mov  r14, r9
	li   r15, flashVerify
	jmp  L349
L347
	ai   r9, >200
	ci   r9, >1FFF
	jle  L348
	inc  r13
	clr  r9
L348
	inc  r14
	ci   r14, >100
	jeq  L355
L349
	mov  r13, r1
	mov  r9, r2
	bl   *r15
	ci   r1, 0
	jne  L347
	li   r1, LC111
	bl   @puts
	ai   r10, >FFFA
	li   r1, LC112
	mov  r1, *r10
	mov  r14, @>2(r10)
	mov  r13, @>4(r10)
	li   r2, printf
	bl   *r2
	ai   r10, >6
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L354
L352
	ai   r10, >FFFC
	li   r2, LC108
	mov  r2, *r10
	mov  r13, @>2(r10)
	bl   @printf
	ai   r10, >4
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L354
L355
	li   r1, LC25
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @puts
L354
	.size	flashSectorErase, .-flashSectorErase
LC113
	byte 10
	text 'Press:'
	byte 0
LC114
	text '  C to read flash CFI'
	byte 0
LC115
	text '  F to test flash fast write'
	byte 0
LC116
	text '  S to test flash slow write'
	byte 0
LC117
	text '  X to test sector erase'
	byte 0
LC118
	text '  E to test flash erase'
	byte 0
LC119
	text '  I for flash status info (broken)'
	byte 0
LC120
	text '  T to toggle flash select lines'
	byte 0
LC121
	text '  R to put flash in reset'
	byte 0
LC122
	byte 10
	text '  1 to reset CF7'
	byte 0
LC123
	text '  2 to read CF info'
	byte 0
LC124
	text '  3 to read CF7'
	byte 0
LC125
	text '  4 to write CF7 (destructive!)'
	byte 0
LC126
	text '  5 to check CF card error'
	byte 0
LC127
	byte 10
	text '  Q to quit'
	byte 0
LC128
	text 'Space to exit...'
	byte 0
LC129
	text 'Fast: Page 16, address 512'
	byte 0
LC130
	text 'Verify failed!'
	byte 0
LC131
	text 'Failed!'
	byte 0
LC132
	text 'Slow: Page 16, address 1024'
	byte 0
LC133
	text 'Mike was here'
	byte 0
LC134
	text 'Press a key...'
	byte 0
	even

	def	testapp
testapp
	ai   r10, >FFF4
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	clr  r1
L357
	mov  r1, r2
	swpb r2
	movb r2, @buffer(r1)
	inc  r1
	ci   r1, >200
	jne  L357
	clr  r1
	mov  r1, @>A(r10)
	li   r14, puts
	li   r15, >5A00
L402
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
	li   r1, LC118
	bl   *r14
	li   r1, LC119
	bl   *r14
	li   r1, LC120
	bl   *r14
	li   r1, LC121
	bl   *r14
	li   r1, LC122
	bl   *r14
	li   r1, LC123
	bl   *r14
	li   r1, LC124
	bl   *r14
	li   r1, LC125
	bl   *r14
	li   r1, LC126
	bl   *r14
	li   r1, LC127
	bl   *r14
L401
	clr  r1
	li   r2, kscanfast
	bl   *r2
	movb @>8375, r1
	ai   r1, >CF00
	ci   r1, >27FF
	jh  L401
	srl  r1, 8
	a    r1, r1
	mov  @L373(r1), r2
	b    *r2
	even
L373
		data		L359
		data		L360
		data		L361
		data		L362
		data		L363
		data		L401
		data		L401
		data		L401
		data		L401
		data		L401
		data		L401
		data		L401
		data		L401
		data		L401
		data		L401
		data		L401
		data		L401
		data		L401
		data		L364
		data		L401
		data		L365
		data		L366
		data		L401
		data		L401
		data		L367
		data		L401
		data		L401
		data		L401
		data		L401
		data		L401
		data		L401
		data		L401
		data		L368
		data		L369
		data		L370
		data		L371
		data		L401
		data		L401
		data		L401
		data		L372
L372
	li   r1, >10
	bl   @flashSectorErase
	ci   r1, 0
	jne  JMP_74
	b    @L386
JMP_74
L374
	li   r1, LC134
	bl   *r14
	seto r2
	movb r2, @>8375
	movb @>8375, r1
	cb   r1, r2
	jeq  JMP_75
	b    @L402
JMP_75
L392
	clr  r1
	li   r4, kscanfast
	bl   *r4
	movb @>8375, r1
	seto r2
	cb   r1, r2
	jeq  JMP_76
	b    @L402
JMP_76
	jmp  L392
L371
	li   r1, LC128
	bl   *r14
	bl   @flashToggle
	jmp  L374
L370
	li   r1, LC132
	bl   *r14
	clr  r1
L377
	mov  r1, r3
	swpb r3
	movb r3, @buffer(r1)
	inc  r1
	ci   r1, >200
	jne  L377
	li   r1, >10
	li   r2, >400
	bl   @flashWriteSlow
	ci   r1, 0
	jeq  L386
	li   r1, LC25
	bl   *r14
	li   r1, >10
	li   r2, >400
	bl   @flashVerify
	ci   r1, 0
	jne  L374
	li   r1, LC130
	bl   @puts
	jmp  L374
L369
	clr  r4
	movb r4, @>6000
	jmp  L374
L368
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	inct r10
	b    *r11
L367
	bl   @flashReadStatus
	b    @L374
L366
	li   r1, LC129
	bl   *r14
	clr  r9
L375
	mov  r9, r1
	swpb r1
	movb r1, @buffer(r9)
	inc  r9
	ci   r9, >200
	jne  L375
	li   r1, >10
	mov  r9, r2
	bl   @flashWriteFast
	ci   r1, 0
	jeq  L386
	li   r1, LC25
	bl   *r14
	li   r1, >10
	mov  r9, r2
	bl   @flashVerify
	ci   r1, 0
	jeq  JMP_77
	b    @L374
JMP_77
	li   r1, LC130
	bl   @puts
	b    @L374
L365
	bl   @flashChipErase
	ci   r1, 0
	jeq  JMP_78
	b    @L374
JMP_78
L386
	li   r1, LC131
	bl   *r14
	b    @L374
L364
	bl   @flashReadCfi
	b    @L374
L363
	li   r1, cf7CardError
	bl   *r1
	b    @L374
L362
	clr  r1
L385
	mov  r1, r3
	swpb r3
	movb r3, @buffer(r1)
	inc  r1
	ci   r1, >200
	jne  L385
	li   r1, buffer
	li   r2, LC133
	li   r3, >E
	li   r4, memcpy
	bl   *r4
	clr  r1
	li   r2, >5
	bl   @cf7WriteSector
	ci   r1, 0
	jeq  L386
	li   r1, LC25
	bl   *r14
	b    @L374
L361
	clr  r1
	mov  @>A(r10), r2
	bl   @cf7ReadSector
	ci   r1, 0
	jne  JMP_79
	b    @L380
JMP_79
	li   r9, buffer
	li   r13, putchar
	jmp  L383
L405
	srl  r1, 8
	bl   *r13
	inc  r9
	ci   r9, buffer+512
	jeq  L404
L383
	movb *r9, r1
	movb r1, r3
	ai   r3, >E000
	cb   r3, r15
	jle  L405
	li   r1, >20
	bl   *r13
	inc  r9
	ci   r9, buffer+512
	jne  L383
L404
	li   r1, >A
	bl   *r13
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	b    @L374
L360
	bl   @cf7IdentifyDevice
	b    @L374
L359
	mov  @CF7Classic99, r1
	jne  JMP_80
	b    @L379
JMP_80
* Begin inline assembler code
* 711 "main.c" 1
	li r12,>1000
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
* 718 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    @L374
L379
* Begin inline assembler code
* 711 "main.c" 1
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
* 718 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    @L374
L380
	li   r1, LC131
	bl   *r14
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	b    @L374
	.size	testapp, .-testapp
LC135
	text 'CF7 to Seahorse board programmer'
	byte 10
	byte 0
LC136
	text 'Press ''T'' for test or ''P'' to proceed.'
	byte 0
LC137
	text 'Press ''Q'' to quit.'
	byte 0
LC138
	text 'Press any key...'
	byte 0
	even

	def	main
main
	ai   r10, >FFF6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	bl   @set_text_raw
	mov  r1, r9
	bl   @charsetlc
	mov  @gPattern, r1
	ai   r1, >400
	li   r2, bargraph
	li   r3, >30
	bl   @vdpmemcpy
	mov  r9, r1
	swpb r1
	movb r1, @>8C02
	li   r2, >8100
	movb r2, @>8C02
	movb r1, @>83D4
	li   r4, >1787
	movb r4, @>8C02
	swpb r4
	movb r4, @>8C02
	li   r1, my_fast_scrn_scroll
	mov  r1, @scrn_scroll
	bl   @cf7DetectClassic99
	li   r13, puts
	li   r9, kscanfast
	li   r15, >5100
	seto r14
L417
	li   r1, LC135
	bl   *r13
	clr  r2
	movb r2, @>6000
	mov  @CF7Classic99, r1
	jne  JMP_81
	b    @L407
JMP_81
L418
* Begin inline assembler code
* 711 "main.c" 1
	li r12,>1000
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r1, >100
	movb r1, @>5F03
	movb r2, @>5F05
	movb r2, @>5F0D
	li   r1, >EF00
	movb r1, @>5F0F
* Begin inline assembler code
* 718 "main.c" 1
	li r12,>1000
	sbz 0
* 0 "" 2
* End of inline assembler code
L408
	li   r1, flashReadCfi
	bl   *r1
	li   r1, >A
	li   r2, putchar
	bl   *r2
	li   r1, cf7IdentifyDevice
	bl   *r1
	li   r1, LC136
	bl   *r13
	li   r1, LC137
	bl   *r13
L409
	clr  r1
	bl   *r9
	movb @>8375, r1
	cb   r1, r15
	jne  JMP_82
	b    @L411
JMP_82
	li   r2, >5400
	cb   r1, r2
	jne  JMP_83
	b    @L412
JMP_83
	li   r2, >5000
	cb   r1, r2
	jne  L409
	bl   @program
	li   r1, LC138
	bl   *r13
L414
	clr  r1
	bl   *r9
	movb @>8375, r1
	cb   r1, r14
	jeq  L414
	li   r1, LC135
	bl   *r13
	clr  r2
	movb r2, @>6000
	mov  @CF7Classic99, r1
	jeq  JMP_84
	b    @L418
JMP_84
L407
* Begin inline assembler code
* 711 "main.c" 1
	li r12,>1100
	sbo 0
* 0 "" 2
* End of inline assembler code
	li   r2, >100
	movb r2, @>5F03
	clr  r1
	movb r1, @>5F05
	movb r1, @>5F0D
	li   r2, >EF00
	movb r2, @>5F0F
* Begin inline assembler code
* 718 "main.c" 1
	li r12,>1100
	sbz 0
* 0 "" 2
* End of inline assembler code
	b    @L408
L412
	bl   @testapp
	b    @L417
L411
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	.size	main, .-main
	even

	def	my_fast_scrn_scroll
my_fast_scrn_scroll
	ai   r10, >FFF6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  @nTextEnd, r15
	mov  r15, r14
	inc  r14
	s    @nTextRow, r14
	mov  @gImage, r1
	a    r1, r15
	mov  r14, r9
	a    r14, r9
	a    r1, r9
	mov  r9, r1
	ai   r1, >100
	c    r15, r1
	jlt  L420
	jeq  L420
L424
	mov  r9, r13
	mov  r1, r9
	mov  r13, r1
	li   r2, vdp_bigbuf
	li   r3, >100
	li   r4, vdpmemread
	bl   *r4
	mov  r13, r1
	s    r14, r1
	li   r2, vdp_bigbuf
	li   r3, >100
	li   r4, vdpmemcpy
	bl   *r4
	mov  r9, r1
	ai   r1, >100
	c    r15, r1
	jgt  L424
L420
	c    r9, r15
	jgt  L422
	inc  r15
	s    r9, r15
	mov  r9, r1
	li   r2, vdp_bigbuf
	mov  r15, r3
	bl   @vdpmemread
	mov  r9, r1
	s    r14, r1
	li   r2, vdp_bigbuf
	mov  r15, r3
	bl   @vdpmemcpy
L422
	mov  @nTextRow, r1
	li   r2, >20
	mov  r14, r3
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @vdpmemset
	.size	my_fast_scrn_scroll, .-my_fast_scrn_scroll

	def	CF7Classic99

	even
	cseg
	even
	.type	CF7Classic99, @object
	.size	CF7Classic99, 2
CF7Classic99
	bss 2

	def	bargraph
	pseg
	.type	bargraph, @object
	.size	bargraph, 48
bargraph
	byte	-128
	byte	-128
	byte	-128
	byte	-128
	byte	-128
	byte	-128
	byte	-128
	byte	-128
	byte	-64
	byte	-64
	byte	-64
	byte	-64
	byte	-64
	byte	-64
	byte	-64
	byte	-64
	byte	-32
	byte	-32
	byte	-32
	byte	-32
	byte	-32
	byte	-32
	byte	-32
	byte	-32
	byte	-16
	byte	-16
	byte	-16
	byte	-16
	byte	-16
	byte	-16
	byte	-16
	byte	-16
	byte	-15
	byte	-15
	byte	-15
	byte	-15
	byte	-15
	byte	-15
	byte	-15
	byte	-15
	byte	-14
	byte	-14
	byte	-14
	byte	-14
	byte	-14
	byte	-14
	byte	-14
	byte	-14
	cseg

	even
	def buffer
buffer
	bss 512

	ref	vdpmemset

	ref	nTextRow

	ref	vdpmemcpy

	ref	vdp_bigbuf

	ref	vdpmemread

	ref	gImage

	ref	nTextEnd

	ref	putchar

	ref	kscanfast

	ref	puts

	ref	scrn_scroll

	ref	gPattern

	ref	charsetlc

	ref	set_text_raw

	ref	putchar

	ref	memcpy

	ref	printf

	ref	memset

	ref	memcmp

	ref	vdpchar
