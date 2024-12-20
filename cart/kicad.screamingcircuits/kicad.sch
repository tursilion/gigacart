EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:68k
LIBS:ad
LIBS:alliance
LIBS:amiga
LIBS:atarist
LIBS:cfcard
LIBS:csx-clk
LIBS:digilent
LIBS:ftdi
LIBS:issi
LIBS:maxim
LIBS:mcp
LIBS:micrel
LIBS:nxp
LIBS:spansion
LIBS:st
LIBS:wdc
LIBS:xilinx-cplds
LIBS:xtal-generic
LIBS:kicad-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Bus_TI994A_Cart J1
U 1 1 5AAF74C1
P 2500 3000
F 0 "J1" H 2500 4675 50  0000 C CNN
F 1 "Bus_TI994A_Cart" H 2550 2575 50  0000 C CNN
F 2 "Oddities:BUS_TI99_CART" H 2500 3000 50  0001 C CNN
F 3 "" H 2500 3000 50  0001 C CNN
	1    2500 3000
	1    0    0    -1  
$EndComp
$Comp
L MCP1700-3302E_SOT23 U1
U 1 1 5AAF783A
P 4950 850
F 0 "U1" H 4800 725 50  0000 C CNN
F 1 "MCP1700-3302E_SOT23" H 5450 600 50  0000 C TNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 4950 650 50  0001 C CIN
F 3 "" H 4950 850 50  0001 C CNN
	1    4950 850 
	1    0    0    1   
$EndComp
$Comp
L GND #PWR01
U 1 1 5AAF789D
P 4950 1250
F 0 "#PWR01" H 4950 1000 50  0001 C CNN
F 1 "GND" H 4950 1100 50  0001 C CNN
F 2 "" H 4950 1250 50  0001 C CNN
F 3 "" H 4950 1250 50  0001 C CNN
	1    4950 1250
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR02
U 1 1 5AAF78B5
P 4350 850
F 0 "#PWR02" H 4350 700 50  0001 C CNN
F 1 "+5V" H 4350 990 50  0000 C CNN
F 2 "" H 4350 850 50  0001 C CNN
F 3 "" H 4350 850 50  0001 C CNN
	1    4350 850 
	1    0    0    -1  
$EndComp
$Comp
L C C14
U 1 1 5AAF7D99
P 5350 1000
F 0 "C14" H 5375 1100 50  0000 L CNN
F 1 "1uF" H 5375 900 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 5388 850 50  0001 C CNN
F 3 "" H 5350 1000 50  0001 C CNN
	1    5350 1000
	1    0    0    -1  
$EndComp
$Comp
L C C15
U 1 1 5AAF7E10
P 4550 1000
F 0 "C15" H 4575 1100 50  0000 L CNN
F 1 "1uF" H 4575 900 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 4588 850 50  0001 C CNN
F 3 "" H 4550 1000 50  0001 C CNN
	1    4550 1000
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR04
U 1 1 5AAF80F7
P 4000 2300
F 0 "#PWR04" H 4000 2150 50  0001 C CNN
F 1 "+5V" H 4000 2440 50  0000 C CNN
F 2 "" H 4000 2300 50  0001 C CNN
F 3 "" H 4000 2300 50  0001 C CNN
	1    4000 2300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 5AAF811B
P 1500 3200
F 0 "#PWR05" H 1500 2950 50  0001 C CNN
F 1 "GND" H 1500 3050 50  0000 C CNN
F 2 "" H 1500 3200 50  0001 C CNN
F 3 "" H 1500 3200 50  0001 C CNN
	1    1500 3200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 5AAF813A
P 3600 1500
F 0 "#PWR06" H 3600 1250 50  0001 C CNN
F 1 "GND" H 3600 1350 50  0000 C CNN
F 2 "" H 3600 1500 50  0001 C CNN
F 3 "" H 3600 1500 50  0001 C CNN
	1    3600 1500
	1    0    0    -1  
$EndComp
Text GLabel 1100 1700 0    60   Input ~ 0
TI_WE
Text GLabel 1500 1800 0    60   Input ~ 0
TI_A4
Text GLabel 1500 1900 0    60   Input ~ 0
TI_A5
Text GLabel 1500 2000 0    60   Input ~ 0
TI_A6
Text GLabel 1500 2100 0    60   Input ~ 0
TI_A3
Text GLabel 1500 2200 0    60   Input ~ 0
TI_A7
Text GLabel 1500 2300 0    60   Input ~ 0
TI_A8
Text GLabel 1500 2400 0    60   Input ~ 0
TI_A9
Text GLabel 1500 2500 0    60   Input ~ 0
TI_A10
Text GLabel 1500 2600 0    60   Input ~ 0
TI_A11
Text GLabel 1500 2700 0    60   Input ~ 0
TI_A12
Text GLabel 1500 2800 0    60   Input ~ 0
TI_A13
Text GLabel 1500 2900 0    60   Input ~ 0
TI_A15
Text GLabel 3500 2100 2    60   Input ~ 0
TI_A14
$Comp
L R R1
U 1 1 5AAF8450
P 1350 1700
F 0 "R1" V 1350 1700 50  0000 L CNN
F 1 "47^" V 1350 1700 39  0000 R CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1280 1700 50  0001 C CNN
F 3 "" H 1350 1700 50  0001 C CNN
	1    1350 1700
	0    1    1    0   
$EndComp
Text GLabel 1500 1600 0    60   Input ~ 0
TI_ROM
$Comp
L GigaCart_CPLD_LC4064 U3
U 1 1 5AAFE010
P 5900 3850
F 0 "U3" H 4750 6050 50  0000 L BNN
F 1 "GigaCart_CPLD_LC4064" H 6400 1500 50  0000 L BNN
F 2 "Housings_QFP:TQFP-100_14x14mm_Pitch0.5mm" H 5900 3850 50  0001 C CIN
F 3 "" H 5900 3850 50  0001 C CNN
	1    5900 3850
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR07
U 1 1 5AB35855
P 6000 1450
F 0 "#PWR07" H 6000 1300 50  0001 C CNN
F 1 "+3.3V" H 6000 1590 50  0000 C CNN
F 2 "" H 6000 1450 50  0001 C CNN
F 3 "" H 6000 1450 50  0001 C CNN
	1    6000 1450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 5AB3698F
P 5600 6400
F 0 "#PWR08" H 5600 6150 50  0001 C CNN
F 1 "GND" H 5600 6250 50  0000 C CNN
F 2 "" H 5600 6400 50  0001 C CNN
F 3 "" H 5600 6400 50  0001 C CNN
	1    5600 6400
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x06 J2
U 1 1 5AB3731A
P 4050 1500
F 0 "J2" H 4050 1800 50  0000 C CNN
F 1 "Conn_01x06" H 4050 1100 50  0000 C CNN
F 2 "Connectors:PINHEAD1-6" H 4050 1500 50  0001 C CNN
F 3 "" H 4050 1500 50  0001 C CNN
	1    4050 1500
	-1   0    0    1   
$EndComp
$Comp
L +3.3V #PWR09
U 1 1 5AB373F8
P 4350 1200
F 0 "#PWR09" H 4350 1050 50  0001 C CNN
F 1 "+3.3V" H 4350 1340 50  0001 C CNN
F 2 "" H 4350 1200 50  0001 C CNN
F 3 "" H 4350 1200 50  0001 C CNN
	1    4350 1200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR010
U 1 1 5AB3741C
P 4350 1700
F 0 "#PWR010" H 4350 1450 50  0001 C CNN
F 1 "GND" H 4350 1550 50  0001 C CNN
F 2 "" H 4350 1700 50  0001 C CNN
F 3 "" H 4350 1700 50  0001 C CNN
	1    4350 1700
	1    0    0    -1  
$EndComp
Text GLabel 4500 3450 0    60   Input ~ 0
TI_A15
Text GLabel 4500 3550 0    60   Input ~ 0
TI_A14
Text GLabel 4500 3650 0    60   Input ~ 0
TI_A13
Text GLabel 4500 3750 0    60   Input ~ 0
TI_A12
Text GLabel 4500 3850 0    60   Input ~ 0
TI_A11
Text GLabel 4500 3950 0    60   Input ~ 0
TI_A10
Text GLabel 4500 4050 0    60   Input ~ 0
TI_A9
Text GLabel 4500 4150 0    60   Input ~ 0
TI_A8
Text GLabel 4500 4250 0    60   Input ~ 0
TI_A7
Text GLabel 4500 4350 0    60   Input ~ 0
TI_A6
Text GLabel 4500 4450 0    60   Input ~ 0
TI_A5
Text GLabel 4500 4550 0    60   Input ~ 0
TI_A4
Text GLabel 4500 4650 0    60   Input ~ 0
TI_A3
Text GLabel 4500 4950 0    60   Input ~ 0
TI_ROM
Text GLabel 4500 5050 0    60   Input ~ 0
TI_WE
Text Notes 7400 7500 0    60   ~ 0
Gigacart by Tursi
$Comp
L Conn_01x01 J3
U 1 1 5AB3CCA4
P 7600 5600
F 0 "J3" H 7650 5600 50  0000 L CNN
F 1 "." H 7600 5500 50  0000 R CNN
F 2 "Connectors:1pin" H 7600 5600 20  0001 C CNN
F 3 "" H 7600 5600 50  0001 C CNN
	1    7600 5600
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J4
U 1 1 5AB3CD0B
P 7600 5700
F 0 "J4" H 7700 5700 50  0000 C CNN
F 1 "." H 7600 5600 50  0000 C CNN
F 2 "Connectors:1pin" H 7600 5700 20  0001 C CNN
F 3 "" H 7600 5700 50  0001 C CNN
	1    7600 5700
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J5
U 1 1 5AB3CD4E
P 7600 5800
F 0 "J5" H 7700 5800 50  0000 C CNN
F 1 "." H 7600 5700 50  0000 C CNN
F 2 "Connectors:1pin" H 7600 5800 20  0001 C CNN
F 3 "" H 7600 5800 50  0001 C CNN
	1    7600 5800
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J6
U 1 1 5AB3CD79
P 7600 5900
F 0 "J6" H 7700 5900 50  0000 C CNN
F 1 "." H 7600 5800 50  0000 C CNN
F 2 "Connectors:1pin" H 7600 5900 20  0001 C CNN
F 3 "" H 7600 5900 50  0001 C CNN
	1    7600 5900
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J7
U 1 1 5AB3CDA6
P 7600 6000
F 0 "J7" H 7700 6000 50  0000 C CNN
F 1 "." H 7600 5900 50  0000 C CNN
F 2 "Connectors:1pin" H 7600 6000 20  0001 C CNN
F 3 "" H 7600 6000 50  0001 C CNN
	1    7600 6000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 5AB3F18C
P 10050 4750
F 0 "#PWR012" H 10050 4500 50  0001 C CNN
F 1 "GND" H 10050 4600 50  0000 C CNN
F 2 "" H 10050 4750 50  0001 C CNN
F 3 "" H 10050 4750 50  0001 C CNN
	1    10050 4750
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR014
U 1 1 5AB43A29
P 10050 1350
F 0 "#PWR014" H 10050 1200 50  0001 C CNN
F 1 "+3.3V" H 10050 1490 50  0000 C CNN
F 2 "" H 10050 1350 50  0001 C CNN
F 3 "" H 10050 1350 50  0001 C CNN
	1    10050 1350
	1    0    0    -1  
$EndComp
Text GLabel 7550 2700 2    60   Input ~ 0
OA0
Text GLabel 7550 2550 2    60   Input ~ 0
OD7
Text GLabel 7550 2450 2    60   Input ~ 0
OD6
Text GLabel 7550 2350 2    60   Input ~ 0
OD5
Text GLabel 7550 2250 2    60   Input ~ 0
OD4
Text GLabel 7550 2150 2    60   Input ~ 0
OD3
Text GLabel 7550 2050 2    60   Input ~ 0
OD2
Text GLabel 7550 1950 2    60   Input ~ 0
OD1
Text GLabel 7550 1850 2    60   Input ~ 0
OD0
Text GLabel 10800 1900 2    60   Input ~ 0
OD0
Text GLabel 10800 2000 2    60   Input ~ 0
OD1
Text GLabel 10800 2100 2    60   Input ~ 0
OD2
Text GLabel 10800 2200 2    60   Input ~ 0
OD3
Text GLabel 10800 2300 2    60   Input ~ 0
OD4
Text GLabel 10800 2400 2    60   Input ~ 0
OD5
Text GLabel 10800 2500 2    60   Input ~ 0
OD6
Text GLabel 10800 2600 2    60   Input ~ 0
OD7
Text GLabel 10800 3400 2    60   Input ~ 0
OA0
Text Notes 3200 4800 2    60   ~ 0
Power Decoupling for CPLD
$Comp
L C C5
U 1 1 5AB511CD
P 2400 5350
F 0 "C5" H 2425 5450 50  0000 L CNN
F 1 "1nF" H 2425 5250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 2438 5200 50  0001 C CNN
F 3 "" H 2400 5350 50  0001 C CNN
	1    2400 5350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR015
U 1 1 5AB5131B
P 2400 5700
F 0 "#PWR015" H 2400 5450 50  0001 C CNN
F 1 "GND" H 2400 5550 50  0000 C CNN
F 2 "" H 2400 5700 50  0001 C CNN
F 3 "" H 2400 5700 50  0001 C CNN
	1    2400 5700
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR016
U 1 1 5AB51321
P 2400 5050
F 0 "#PWR016" H 2400 4900 50  0001 C CNN
F 1 "+3.3V" H 2400 5190 50  0000 C CNN
F 2 "" H 2400 5050 50  0001 C CNN
F 3 "" H 2400 5050 50  0001 C CNN
	1    2400 5050
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 5AB51327
P 2150 5350
F 0 "C4" H 2175 5450 50  0000 L CNN
F 1 "1nF" H 2175 5250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 2188 5200 50  0001 C CNN
F 3 "" H 2150 5350 50  0001 C CNN
	1    2150 5350
	1    0    0    -1  
$EndComp
$Comp
L C C6
U 1 1 5AB5149A
P 2650 5350
F 0 "C6" H 2675 5450 50  0000 L CNN
F 1 "1nF" H 2675 5250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 2688 5200 50  0001 C CNN
F 3 "" H 2650 5350 50  0001 C CNN
	1    2650 5350
	1    0    0    -1  
$EndComp
$Comp
L C C7
U 1 1 5AB514DF
P 2900 5350
F 0 "C7" H 2925 5450 50  0000 L CNN
F 1 "1nF" H 2925 5250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 2938 5200 50  0001 C CNN
F 3 "" H 2900 5350 50  0001 C CNN
	1    2900 5350
	1    0    0    -1  
$EndComp
$Comp
L C C8
U 1 1 5AB51516
P 3150 5350
F 0 "C8" H 3175 5450 50  0000 L CNN
F 1 "1nF" H 3175 5250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 3188 5200 50  0001 C CNN
F 3 "" H 3150 5350 50  0001 C CNN
	1    3150 5350
	1    0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 5AB5154F
P 1900 5350
F 0 "C3" H 1925 5450 50  0000 L CNN
F 1 "1nF" H 1925 5250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 1938 5200 50  0001 C CNN
F 3 "" H 1900 5350 50  0001 C CNN
	1    1900 5350
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 5AB5158C
P 1650 5350
F 0 "C2" H 1675 5450 50  0000 L CNN
F 1 "1nF" H 1675 5250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 1688 5200 50  0001 C CNN
F 3 "" H 1650 5350 50  0001 C CNN
	1    1650 5350
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 5AB515CB
P 1400 5350
F 0 "C1" H 1425 5450 50  0000 L CNN
F 1 "1nF" H 1425 5250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 1438 5200 50  0001 C CNN
F 3 "" H 1400 5350 50  0001 C CNN
	1    1400 5350
	1    0    0    -1  
$EndComp
$Comp
L C C9
U 1 1 5AB5160A
P 3400 5350
F 0 "C9" H 3425 5450 50  0000 L CNN
F 1 "1nF" H 3425 5250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 3438 5200 50  0001 C CNN
F 3 "" H 3400 5350 50  0001 C CNN
	1    3400 5350
	1    0    0    -1  
$EndComp
$Comp
L C C10
U 1 1 5AB5164B
P 3650 5350
F 0 "C10" H 3675 5450 50  0000 L CNN
F 1 "1nF" H 3675 5250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 3688 5200 50  0001 C CNN
F 3 "" H 3650 5350 50  0001 C CNN
	1    3650 5350
	1    0    0    -1  
$EndComp
$Comp
L C C11
U 1 1 5AB54142
P 10350 1400
F 0 "C11" H 10375 1500 50  0000 L CNN
F 1 "1nF" H 10375 1300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 10388 1250 50  0001 C CNN
F 3 "" H 10350 1400 50  0001 C CNN
	1    10350 1400
	0    1    1    0   
$EndComp
$Comp
L GND #PWR017
U 1 1 5AB54195
P 10650 1400
F 0 "#PWR017" H 10650 1150 50  0001 C CNN
F 1 "GND" H 10650 1250 50  0000 C CNN
F 2 "" H 10650 1400 50  0001 C CNN
F 3 "" H 10650 1400 50  0001 C CNN
	1    10650 1400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR018
U 1 1 5AB56F31
P 1450 4450
F 0 "#PWR018" H 1450 4200 50  0001 C CNN
F 1 "GND" H 1450 4300 50  0000 C CNN
F 2 "" H 1450 4450 50  0001 C CNN
F 3 "" H 1450 4450 50  0001 C CNN
	1    1450 4450
	1    0    0    -1  
$EndComp
$Comp
L C C13
U 1 1 5AB56F75
P 1450 4200
F 0 "C13" H 1475 4300 50  0000 L CNN
F 1 "1nF" H 1475 4100 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 1488 4050 50  0001 C CNN
F 3 "" H 1450 4200 50  0001 C CNN
	1    1450 4200
	1    0    0    -1  
$EndComp
Text GLabel 1450 3900 0    60   Input ~ 0
TI_WE
Text Notes 1000 3750 0    60   ~ 0
write line filter
$Comp
L C C12
U 1 1 5AB5AEE7
P 9650 1400
F 0 "C12" H 9675 1500 50  0000 L CNN
F 1 "1nF" H 9675 1300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 9688 1250 50  0001 C CNN
F 3 "" H 9650 1400 50  0001 C CNN
	1    9650 1400
	0    1    1    0   
$EndComp
$Comp
L GND #PWR019
U 1 1 5AB5AF3A
P 9350 1400
F 0 "#PWR019" H 9350 1150 50  0001 C CNN
F 1 "GND" H 9350 1250 50  0000 C CNN
F 2 "" H 9350 1400 50  0001 C CNN
F 3 "" H 9350 1400 50  0001 C CNN
	1    9350 1400
	1    0    0    -1  
$EndComp
Text GLabel 3500 2400 2    60   Input ~ 0
TI_D0
Text GLabel 3500 2500 2    60   Input ~ 0
TI_D1
Text GLabel 3500 2600 2    60   Input ~ 0
TI_D2
Text GLabel 3500 2700 2    60   Input ~ 0
TI_D3
Text GLabel 3500 2800 2    60   Input ~ 0
TI_D4
Text GLabel 3500 2900 2    60   Input ~ 0
TI_D5
Text GLabel 3500 3000 2    60   Input ~ 0
TI_D6
Text GLabel 3500 3100 2    60   Input ~ 0
TI_D7
Text GLabel 4500 2400 0    60   Input ~ 0
TI_D7
Text GLabel 4500 2500 0    60   Input ~ 0
TI_D6
Text GLabel 4500 2600 0    60   Input ~ 0
TI_D5
Text GLabel 4500 2700 0    60   Input ~ 0
TI_D4
Text GLabel 4500 2800 0    60   Input ~ 0
TI_D3
Text GLabel 4500 2900 0    60   Input ~ 0
TI_D2
Text GLabel 4500 3000 0    60   Input ~ 0
TI_D1
Text GLabel 4500 3100 0    60   Input ~ 0
TI_D0
NoConn ~ 3400 3200
NoConn ~ 3400 2000
NoConn ~ 3400 1800
NoConn ~ 3400 1700
NoConn ~ 3400 1600
NoConn ~ 1600 1500
NoConn ~ 1600 3000
NoConn ~ 1600 3100
NoConn ~ 10700 2700
NoConn ~ 10700 2800
NoConn ~ 10700 2900
NoConn ~ 10700 3000
NoConn ~ 10700 3100
NoConn ~ 10700 3200
NoConn ~ 10700 3300
NoConn ~ 10700 4050
Text GLabel 3500 1900 2    60   Input ~ 0
TI_GCLK
Text GLabel 3500 2200 2    60   Input ~ 0
TI_GSEL
Text GLabel 4500 5300 0    60   Input ~ 0
TI_GSEL
Text GLabel 4500 5400 0    60   Input ~ 0
TI_GCLK
$Comp
L GND #PWR011
U 1 1 5AB3E1B2
P 10950 4350
F 0 "#PWR011" H 10950 4100 50  0001 C CNN
F 1 "GND" H 10950 4200 50  0000 C CNN
F 2 "" H 10950 4350 50  0001 C CNN
F 3 "" H 10950 4350 50  0001 C CNN
	1    10950 4350
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR03
U 1 1 5AAF78CF
P 5550 850
F 0 "#PWR03" H 5550 700 50  0001 C CNN
F 1 "+3.3V" H 5550 990 50  0000 C CNN
F 2 "" H 5550 850 50  0001 C CNN
F 3 "" H 5550 850 50  0001 C CNN
	1    5550 850 
	1    0    0    -1  
$EndComp
$Comp
L S29GL01G-128MB-Flash U2
U 1 1 5AB35630
P 10000 3000
F 0 "U2" H 10150 4200 50  0000 L CNN
F 1 "S29GL01G-128MB-Flash" H 8900 4250 50  0000 L CNN
F 2 "tsop:TSOP-56" H 10000 3000 50  0001 C CNN
F 3 "" H 10000 3000 50  0001 C CNN
	1    10000 3000
	1    0    0    -1  
$EndComp
NoConn ~ 10700 3950
$Comp
L GND #PWR?
U 1 1 5D2D3DD6
P 5050 1450
F 0 "#PWR?" H 5050 1200 50  0001 C CNN
F 1 "GND" H 5050 1300 50  0001 C CNN
F 2 "" H 5050 1450 50  0001 C CNN
F 3 "" H 5050 1450 50  0001 C CNN
	1    5050 1450
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5D2D5036
P 4850 1450
F 0 "R2" V 4930 1450 50  0000 C CNN
F 1 "4.7k" V 4850 1450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 4780 1450 50  0001 C CNN
F 3 "" H 4850 1450 50  0001 C CNN
	1    4850 1450
	0    1    1    0   
$EndComp
Wire Wire Line
	5600 6250 5600 6400
Connection ~ 5200 6250
Connection ~ 5300 6250
Connection ~ 5400 6250
Connection ~ 5500 6250
Connection ~ 5600 6250
Connection ~ 5700 6250
Connection ~ 5800 6250
Connection ~ 5900 6250
Connection ~ 6000 6250
Connection ~ 6100 6250
Wire Wire Line
	5100 6250 6200 6250
Wire Wire Line
	6000 1550 6000 1450
Connection ~ 6300 1550
Connection ~ 6200 1550
Connection ~ 6100 1550
Connection ~ 6000 1550
Connection ~ 5900 1550
Connection ~ 5800 1550
Connection ~ 5700 1550
Connection ~ 5600 1550
Wire Wire Line
	5500 1550 6400 1550
Wire Wire Line
	1500 2900 1600 2900
Wire Wire Line
	1600 2800 1500 2800
Wire Wire Line
	1500 2700 1600 2700
Wire Wire Line
	1600 2600 1500 2600
Wire Wire Line
	1500 2500 1600 2500
Wire Wire Line
	1600 2400 1500 2400
Wire Wire Line
	1500 2300 1600 2300
Wire Wire Line
	1600 2200 1500 2200
Wire Wire Line
	1500 2100 1600 2100
Wire Wire Line
	1500 2000 1600 2000
Wire Wire Line
	1600 1900 1500 1900
Wire Wire Line
	1500 1800 1600 1800
Wire Wire Line
	1200 1700 1100 1700
Wire Wire Line
	1600 1700 1500 1700
Wire Wire Line
	1500 1600 1600 1600
Wire Wire Line
	3400 2100 3500 2100
Wire Wire Line
	1500 3200 1600 3200
Wire Wire Line
	3400 1500 3600 1500
Wire Wire Line
	3400 2300 4000 2300
Connection ~ 5350 850 
Wire Wire Line
	5250 850  5550 850 
Connection ~ 4550 850 
Wire Wire Line
	4350 850  4650 850 
Connection ~ 4950 1150
Wire Wire Line
	4550 1150 5350 1150
Wire Wire Line
	4950 1150 4950 1250
Wire Wire Line
	4500 3450 4600 3450
Wire Wire Line
	4500 3550 4600 3550
Wire Wire Line
	4500 3650 4600 3650
Wire Wire Line
	4500 3750 4600 3750
Wire Wire Line
	4500 3850 4600 3850
Wire Wire Line
	4500 3950 4600 3950
Wire Wire Line
	4500 4050 4600 4050
Wire Wire Line
	4500 4150 4600 4150
Wire Wire Line
	4500 4250 4600 4250
Wire Wire Line
	4500 4350 4600 4350
Wire Wire Line
	4500 4450 4600 4450
Wire Wire Line
	4500 4550 4600 4550
Wire Wire Line
	4500 4950 4600 4950
Wire Wire Line
	4500 5050 4600 5050
Wire Wire Line
	4500 4650 4600 4650
Wire Wire Line
	7200 5600 7400 5600
Wire Wire Line
	7200 5700 7400 5700
Wire Wire Line
	7200 5800 7400 5800
Wire Wire Line
	7200 5900 7400 5900
Wire Wire Line
	10950 4150 10700 4150
Wire Wire Line
	9950 4650 10050 4650
Wire Wire Line
	10050 4650 10050 4750
Connection ~ 10050 4650
Wire Wire Line
	10050 1350 10050 1700
Connection ~ 10050 1700
Wire Wire Line
	7200 2800 7900 2800
Wire Wire Line
	7900 2800 7900 1900
Wire Wire Line
	7900 1900 9300 1900
Wire Wire Line
	7200 2900 7950 2900
Wire Wire Line
	7950 2900 7950 2000
Wire Wire Line
	7950 2000 9300 2000
Wire Wire Line
	7200 3000 8000 3000
Wire Wire Line
	8000 3000 8000 2100
Wire Wire Line
	8000 2100 9300 2100
Wire Wire Line
	7200 3100 8050 3100
Wire Wire Line
	8050 3100 8050 2200
Wire Wire Line
	8050 2200 9300 2200
Wire Wire Line
	7200 3200 8100 3200
Wire Wire Line
	8100 3200 8100 2300
Wire Wire Line
	8100 2300 9300 2300
Wire Wire Line
	7200 3300 8150 3300
Wire Wire Line
	8150 3300 8150 2400
Wire Wire Line
	8150 2400 9300 2400
Wire Wire Line
	7200 3400 8200 3400
Wire Wire Line
	8200 3400 8200 2500
Wire Wire Line
	8200 2500 9300 2500
Wire Wire Line
	7200 3500 8250 3500
Wire Wire Line
	8250 3500 8250 2600
Wire Wire Line
	8250 2600 9300 2600
Wire Wire Line
	7200 3600 8300 3600
Wire Wire Line
	8300 3600 8300 2700
Wire Wire Line
	8300 2700 9300 2700
Wire Wire Line
	7200 3700 8350 3700
Wire Wire Line
	8350 3700 8350 2800
Wire Wire Line
	8350 2800 9300 2800
Wire Wire Line
	7200 3800 8400 3800
Wire Wire Line
	8400 3800 8400 2900
Wire Wire Line
	8400 2900 9300 2900
Wire Wire Line
	7200 3900 8450 3900
Wire Wire Line
	8450 3900 8450 3000
Wire Wire Line
	8450 3000 9300 3000
Wire Wire Line
	7200 4000 8500 4000
Wire Wire Line
	8500 4000 8500 3100
Wire Wire Line
	8500 3100 9300 3100
Wire Wire Line
	7200 4100 8550 4100
Wire Wire Line
	8550 4100 8550 3200
Wire Wire Line
	8550 3200 9300 3200
Wire Wire Line
	7200 4200 8600 4200
Wire Wire Line
	8600 4200 8600 3300
Wire Wire Line
	8600 3300 9300 3300
Wire Wire Line
	7200 4300 8650 4300
Wire Wire Line
	8650 4300 8650 3400
Wire Wire Line
	8650 3400 9300 3400
Wire Wire Line
	7200 4400 8700 4400
Wire Wire Line
	8700 4400 8700 3500
Wire Wire Line
	8700 3500 9300 3500
Wire Wire Line
	7200 4500 8750 4500
Wire Wire Line
	8750 4500 8750 3600
Wire Wire Line
	8750 3600 9300 3600
Wire Wire Line
	7200 4600 8800 4600
Wire Wire Line
	8800 4600 8800 3700
Wire Wire Line
	8800 3700 9300 3700
Wire Wire Line
	7200 4700 8850 4700
Wire Wire Line
	8850 4700 8850 3800
Wire Wire Line
	8850 3800 9300 3800
Wire Wire Line
	7200 4800 8900 4800
Wire Wire Line
	8900 4800 8900 3900
Wire Wire Line
	8900 3900 9300 3900
Wire Wire Line
	7200 4900 8950 4900
Wire Wire Line
	8950 4900 8950 4000
Wire Wire Line
	8950 4000 9300 4000
Wire Wire Line
	7200 5000 9000 5000
Wire Wire Line
	9000 5000 9000 4100
Wire Wire Line
	9000 4100 9300 4100
Wire Wire Line
	7200 5100 9050 5100
Wire Wire Line
	9050 5100 9050 4200
Wire Wire Line
	9050 4200 9300 4200
Wire Wire Line
	7200 5200 9100 5200
Wire Wire Line
	9100 5200 9100 4300
Wire Wire Line
	9100 4300 9300 4300
Wire Wire Line
	7200 5300 9150 5300
Wire Wire Line
	9150 5300 9150 4400
Wire Wire Line
	9150 4400 9300 4400
Wire Wire Line
	7200 1850 7550 1850
Wire Wire Line
	7200 1950 7550 1950
Wire Wire Line
	7200 2050 7550 2050
Wire Wire Line
	7200 2150 7550 2150
Wire Wire Line
	7200 2250 7550 2250
Wire Wire Line
	7200 2350 7550 2350
Wire Wire Line
	7200 2450 7550 2450
Wire Wire Line
	7200 2550 7550 2550
Wire Wire Line
	7200 2700 7550 2700
Wire Wire Line
	10800 1900 10700 1900
Wire Wire Line
	10700 2000 10800 2000
Wire Wire Line
	10800 2100 10700 2100
Wire Wire Line
	10700 2200 10800 2200
Wire Wire Line
	10800 2300 10700 2300
Wire Wire Line
	10700 2400 10800 2400
Wire Wire Line
	10800 2500 10700 2500
Wire Wire Line
	10700 2600 10800 2600
Wire Wire Line
	10800 3400 10700 3400
Wire Wire Line
	1400 5200 3650 5200
Connection ~ 3400 5200
Connection ~ 3150 5200
Connection ~ 2900 5200
Connection ~ 2650 5200
Connection ~ 2400 5200
Connection ~ 2150 5200
Connection ~ 1900 5200
Connection ~ 1650 5200
Wire Wire Line
	1400 5500 3650 5500
Connection ~ 3400 5500
Connection ~ 3150 5500
Connection ~ 2900 5500
Connection ~ 2650 5500
Connection ~ 2400 5500
Connection ~ 2150 5500
Connection ~ 1900 5500
Connection ~ 1650 5500
Wire Wire Line
	9800 1400 10200 1400
Connection ~ 10050 1400
Wire Wire Line
	10500 1400 10650 1400
Wire Wire Line
	1450 3900 1450 4050
Wire Wire Line
	1450 4350 1450 4450
Wire Wire Line
	9950 1700 9950 1400
Connection ~ 9950 1400
Wire Wire Line
	9500 1400 9350 1400
Wire Wire Line
	2400 5200 2400 5050
Wire Wire Line
	2400 5500 2400 5700
Wire Wire Line
	3400 2400 3500 2400
Wire Wire Line
	3400 2500 3500 2500
Wire Wire Line
	3400 2600 3500 2600
Wire Wire Line
	3400 2700 3500 2700
Wire Wire Line
	3400 2800 3500 2800
Wire Wire Line
	3400 2900 3500 2900
Wire Wire Line
	3400 3000 3500 3000
Wire Wire Line
	3400 3100 3500 3100
Wire Wire Line
	4500 2400 4600 2400
Wire Wire Line
	4600 2500 4500 2500
Wire Wire Line
	4500 2600 4600 2600
Wire Wire Line
	4600 2700 4500 2700
Wire Wire Line
	4500 2800 4600 2800
Wire Wire Line
	4600 2900 4500 2900
Wire Wire Line
	4500 3000 4600 3000
Wire Wire Line
	4600 3100 4500 3100
Wire Wire Line
	3400 1900 3500 1900
Wire Wire Line
	3400 2200 3500 2200
Wire Wire Line
	4500 5300 4600 5300
Wire Wire Line
	4500 5400 4600 5400
Wire Wire Line
	10700 3850 11050 3850
Wire Wire Line
	11050 3850 11050 5500
Wire Wire Line
	11050 5500 7200 5500
Wire Wire Line
	7200 6000 7400 6000
Connection ~ 7400 6000
Connection ~ 7300 5900
Wire Wire Line
	7300 5900 7300 6200
Wire Wire Line
	7300 6200 11150 6200
Wire Wire Line
	11150 6200 11150 3750
Wire Wire Line
	11150 3750 10700 3750
Wire Wire Line
	10700 4350 10700 6150
Wire Wire Line
	10700 6150 7400 6150
Wire Wire Line
	7400 6150 7400 6000
Connection ~ 7400 5600
Connection ~ 7300 5700
Connection ~ 8050 3300
Connection ~ 7400 2050
Connection ~ 7300 2150
Wire Wire Line
	7400 5600 7400 2050
Wire Wire Line
	7300 5700 7300 2150
Wire Wire Line
	10950 4150 10950 4350
Wire Wire Line
	4250 1200 4350 1200
Wire Wire Line
	4600 1850 4600 1300
Wire Wire Line
	4600 1300 4250 1300
Wire Wire Line
	4600 1950 4550 1950
Wire Wire Line
	4550 1950 4550 1400
Wire Wire Line
	4550 1400 4250 1400
Wire Wire Line
	4600 2050 4500 2050
Wire Wire Line
	4500 2050 4500 1500
Wire Wire Line
	4500 1500 4250 1500
Wire Wire Line
	4600 2150 4450 2150
Wire Wire Line
	4450 2150 4450 1600
Wire Wire Line
	4450 1600 4250 1600
Wire Wire Line
	4250 1700 4350 1700
Wire Wire Line
	5000 1450 5050 1450
Wire Wire Line
	4700 1450 4550 1450
Connection ~ 4550 1450
Wire Wire Line
	7350 5800 10800 5800
Wire Wire Line
	10800 5800 10800 4250
Wire Wire Line
	10800 4250 10700 4250
Connection ~ 7350 5800
$EndSCHEMATC
