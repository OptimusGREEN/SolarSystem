EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "bell box control"
Date "2021-07-20"
Rev "2"
Comp "Adrian Kennard Andrews & Arnold Ltd"
Comment1 "@TheRealRevK"
Comment2 "www.me.uk"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:USB_C_Receptacle_USB2.0 J1
U 1 1 60436927
P 4375 1475
F 0 "J1" H 4482 2342 50  0000 C CNN
F 1 "USB-C" H 4482 2251 50  0000 C CNN
F 2 "RevK:USC16-TR-Round" H 4525 1475 50  0001 C CNN
F 3 "https://www.usb.org/sites/default/files/documents/usb_type-c.zip" H 4525 1475 50  0001 C CNN
	1    4375 1475
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 6043A8AD
P 5225 1075
F 0 "R2" V 5432 1075 50  0000 C CNN
F 1 "5K1" V 5341 1075 50  0000 C CNN
F 2 "RevK:R_0603" V 5155 1075 50  0001 C CNN
F 3 "~" H 5225 1075 50  0001 C CNN
	1    5225 1075
	0    -1   -1   0   
$EndComp
Text GLabel 2700 1600 2    50   Input ~ 0
I
Text GLabel 1000 1300 0    50   Input ~ 0
EN
Text GLabel 5825 1375 2    50   Input ~ 0
D-
Text GLabel 5825 1575 2    50   Input ~ 0
D+
Wire Wire Line
	4075 2375 4375 2375
Connection ~ 4375 2375
Wire Wire Line
	4975 1675 4975 1575
Connection ~ 4975 1575
Wire Wire Line
	4975 1475 4975 1375
Connection ~ 4975 1375
Wire Wire Line
	4975 875  5575 875 
Wire Wire Line
	1000 1300 1500 1300
Wire Wire Line
	4975 1075 5075 1075
Wire Wire Line
	4975 1175 5075 1175
Wire Wire Line
	5375 1075 5375 1125
Wire Wire Line
	5575 1125 5375 1125
Connection ~ 5375 1125
Wire Wire Line
	5375 1125 5375 1175
NoConn ~ 1500 2500
NoConn ~ 1500 2600
NoConn ~ 1500 2700
NoConn ~ 1500 2800
NoConn ~ 1500 2900
NoConn ~ 1500 3000
$Comp
L Device:R R3
U 1 1 6049A32B
P 5225 1175
F 0 "R3" V 5325 1175 50  0000 C CNN
F 1 "5K1" V 5425 1175 50  0000 C CNN
F 2 "RevK:R_0603" V 5155 1175 50  0001 C CNN
F 3 "~" H 5225 1175 50  0001 C CNN
	1    5225 1175
	0    1    1    0   
$EndComp
NoConn ~ 4975 1975
NoConn ~ 4975 2075
$Comp
L power:VBUS #PWR015
U 1 1 60464020
P 5575 875
F 0 "#PWR015" H 5575 725 50  0001 C CNN
F 1 "VBUS" H 5590 1048 50  0000 C CNN
F 2 "" H 5575 875 50  0001 C CNN
F 3 "" H 5575 875 50  0001 C CNN
	1    5575 875 
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR04
U 1 1 6046533F
P 3100 1100
F 0 "#PWR04" H 3100 950 50  0001 C CNN
F 1 "+3.3V" H 3115 1273 50  0000 C CNN
F 2 "" H 3100 1100 50  0001 C CNN
F 3 "" H 3100 1100 50  0001 C CNN
	1    3100 1100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 6046CDD6
P 5575 1125
F 0 "#PWR016" H 5575 875 50  0001 C CNN
F 1 "GND" H 5580 952 50  0000 C CNN
F 2 "" H 5575 1125 50  0001 C CNN
F 3 "" H 5575 1125 50  0001 C CNN
	1    5575 1125
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR017
U 1 1 6046DFEC
P 5625 2375
F 0 "#PWR017" H 5625 2125 50  0001 C CNN
F 1 "GND" H 5630 2202 50  0000 C CNN
F 2 "" H 5625 2375 50  0001 C CNN
F 3 "" H 5625 2375 50  0001 C CNN
	1    5625 2375
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 6046FB14
P 3150 3900
F 0 "#PWR05" H 3150 3650 50  0001 C CNN
F 1 "GND" H 3155 3727 50  0000 C CNN
F 2 "" H 3150 3900 50  0001 C CNN
F 3 "" H 3150 3900 50  0001 C CNN
	1    3150 3900
	1    0    0    -1  
$EndComp
Text GLabel 2700 1400 2    50   Input ~ 0
O
Text GLabel 2700 1300 2    50   Input ~ 0
BOOT
Wire Wire Line
	2100 1100 2100 1200
Wire Wire Line
	4375 2375 5625 2375
Wire Wire Line
	8075 1850 8075 1550
Wire Wire Line
	2100 1100 3100 1100
$Comp
L RevK:AJK AJK1
U 1 1 60629B22
P 10500 6900
F 0 "AJK1" H 10500 7000 50  0001 C CNN
F 1 "AJK" H 10750 6900 50  0000 L CNN
F 2 "RevK:AJK" H 10500 6800 50  0001 C CNN
F 3 "" H 10500 6800 50  0001 C CNN
	1    10500 6900
	1    0    0    -1  
$EndComp
Connection ~ 2100 1100
$Comp
L RF_Module:ESP32-WROOM-32 U1
U 1 1 6043326C
P 2100 2500
F 0 "U1" H 2100 4081 50  0000 C CNN
F 1 "ESP32-WROOM-32" H 2100 3990 50  0000 C CNN
F 2 "RevK:ESP32-WROOM-32" H 2100 1000 50  0001 C CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32_datasheet_en.pdf" H 1800 2550 50  0001 C CNN
	1    2100 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 3900 3150 3900
NoConn ~ 2700 3500
NoConn ~ 2700 3600
$Comp
L power:GND #PWR027
U 1 1 607450BB
P 7750 950
F 0 "#PWR027" H 7750 700 50  0001 C CNN
F 1 "GND" V 7755 822 50  0000 R CNN
F 2 "" H 7750 950 50  0001 C CNN
F 3 "" H 7750 950 50  0001 C CNN
	1    7750 950 
	0    1    1    0   
$EndComp
NoConn ~ 2700 2200
$Comp
L Device:R R7
U 1 1 60819C12
P 7550 4125
F 0 "R7" V 7450 4125 50  0000 C CNN
F 1 "324R" V 7550 4125 50  0000 C CNN
F 2 "RevK:R_0603" V 7480 4125 50  0001 C CNN
F 3 "~" H 7550 4125 50  0001 C CNN
	1    7550 4125
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR031
U 1 1 6081C3D8
P 8100 3925
F 0 "#PWR031" H 8100 3775 50  0001 C CNN
F 1 "+3.3V" V 8115 4053 50  0000 L CNN
F 2 "" H 8100 3925 50  0001 C CNN
F 3 "" H 8100 3925 50  0001 C CNN
	1    8100 3925
	0    1    1    0   
$EndComp
$Comp
L Interface_USB:FT231XQ U2
U 1 1 6084108B
P 2600 6350
F 0 "U2" H 2600 7431 50  0000 C CNN
F 1 "FT231XQ" H 2600 7340 50  0000 C CNN
F 2 "RevK:QFN-20-1EP_4x4mm_P0.5mm_EP2.5x2.5mm" H 3950 5550 50  0001 C CNN
F 3 "https://www.ftdichip.com/Support/Documents/DataSheets/ICs/DS_FT231X.pdf" H 2600 6350 50  0001 C CNN
	1    2600 6350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 5450 2500 5450
Connection ~ 2500 5450
Text GLabel 1900 6050 0    50   Input ~ 0
D-
Text GLabel 1900 6150 0    50   Input ~ 0
D+
Wire Wire Line
	1900 6350 1550 6350
Wire Wire Line
	1550 6350 1550 5750
Wire Wire Line
	1550 5750 1900 5750
Connection ~ 1550 5750
Wire Wire Line
	1550 5750 1550 5450
Wire Wire Line
	1550 5450 2500 5450
Wire Wire Line
	2500 7250 2600 7250
Wire Wire Line
	2600 7250 2700 7250
Connection ~ 2600 7250
$Comp
L power:GND #PWR03
U 1 1 6085BF74
P 2600 7250
F 0 "#PWR03" H 2600 7000 50  0001 C CNN
F 1 "GND" H 2605 7077 50  0000 C CNN
F 2 "" H 2600 7250 50  0001 C CNN
F 3 "" H 2600 7250 50  0001 C CNN
	1    2600 7250
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR01
U 1 1 6085C74E
P 1550 5450
F 0 "#PWR01" H 1550 5300 50  0001 C CNN
F 1 "+3.3V" H 1565 5623 50  0000 C CNN
F 2 "" H 1550 5450 50  0001 C CNN
F 3 "" H 1550 5450 50  0001 C CNN
	1    1550 5450
	1    0    0    -1  
$EndComp
Connection ~ 1550 5450
$Comp
L power:GND #PWR06
U 1 1 6085CF95
P 3300 6050
F 0 "#PWR06" H 3300 5800 50  0001 C CNN
F 1 "GND" V 3305 5922 50  0000 R CNN
F 2 "" H 3300 6050 50  0001 C CNN
F 3 "" H 3300 6050 50  0001 C CNN
	1    3300 6050
	0    -1   -1   0   
$EndComp
Text GLabel 3300 6150 2    50   Input ~ 0
BOOT
Text GLabel 3300 5750 2    50   Input ~ 0
I
Text GLabel 3300 5850 2    50   Input ~ 0
O
Text GLabel 3300 5950 2    50   Input ~ 0
EN
NoConn ~ 3300 6650
NoConn ~ 3300 6750
NoConn ~ 3300 6850
NoConn ~ 3300 6950
$Comp
L power:GND #PWR07
U 1 1 6087F33E
P 3300 6250
F 0 "#PWR07" H 3300 6000 50  0001 C CNN
F 1 "GND" V 3305 6122 50  0000 R CNN
F 2 "" H 3300 6250 50  0001 C CNN
F 3 "" H 3300 6250 50  0001 C CNN
	1    3300 6250
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR08
U 1 1 6087FBAE
P 3300 6350
F 0 "#PWR08" H 3300 6100 50  0001 C CNN
F 1 "GND" V 3305 6222 50  0000 R CNN
F 2 "" H 3300 6350 50  0001 C CNN
F 3 "" H 3300 6350 50  0001 C CNN
	1    3300 6350
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR09
U 1 1 608803BE
P 3300 6450
F 0 "#PWR09" H 3300 6200 50  0001 C CNN
F 1 "GND" V 3305 6322 50  0000 R CNN
F 2 "" H 3300 6450 50  0001 C CNN
F 3 "" H 3300 6450 50  0001 C CNN
	1    3300 6450
	0    -1   -1   0   
$EndComp
NoConn ~ 2700 1500
NoConn ~ 2700 1900
NoConn ~ 2700 2300
NoConn ~ 2700 3300
NoConn ~ 2700 3400
NoConn ~ 9400 9850
$Comp
L power:+12V #PWR028
U 1 1 608D441F
P 7750 1050
F 0 "#PWR028" H 7750 900 50  0001 C CNN
F 1 "+12V" V 7765 1178 50  0000 L CNN
F 2 "" H 7750 1050 50  0001 C CNN
F 3 "" H 7750 1050 50  0001 C CNN
	1    7750 1050
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR030
U 1 1 608D6235
P 8075 1550
F 0 "#PWR030" H 8075 1400 50  0001 C CNN
F 1 "+12V" H 8090 1723 50  0000 C CNN
F 2 "" H 8075 1550 50  0001 C CNN
F 3 "" H 8075 1550 50  0001 C CNN
	1    8075 1550
	1    0    0    -1  
$EndComp
$Comp
L Device:D D3
U 1 1 608D7F70
P 7925 1850
F 0 "D3" H 7925 1633 50  0000 C CNN
F 1 "D" H 7925 1724 50  0000 C CNN
F 2 "Diode_SMD:D_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 7925 1850 50  0001 C CNN
F 3 "~" H 7925 1850 50  0001 C CNN
	1    7925 1850
	-1   0    0    1   
$EndComp
Wire Wire Line
	7775 1850 7775 1550
$Comp
L power:VBUS #PWR029
U 1 1 608DB037
P 7775 1550
F 0 "#PWR029" H 7775 1400 50  0001 C CNN
F 1 "VBUS" H 7790 1723 50  0000 C CNN
F 2 "" H 7775 1550 50  0001 C CNN
F 3 "" H 7775 1550 50  0001 C CNN
	1    7775 1550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR025
U 1 1 608FD8A1
P 7525 2500
F 0 "#PWR025" H 7525 2250 50  0001 C CNN
F 1 "GND" V 7530 2372 50  0000 R CNN
F 2 "" H 7525 2500 50  0001 C CNN
F 3 "" H 7525 2500 50  0001 C CNN
	1    7525 2500
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR026
U 1 1 608FE15A
P 7525 2600
F 0 "#PWR026" H 7525 2450 50  0001 C CNN
F 1 "+3.3V" V 7540 2728 50  0000 L CNN
F 2 "" H 7525 2600 50  0001 C CNN
F 3 "" H 7525 2600 50  0001 C CNN
	1    7525 2600
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR023
U 1 1 60913ECD
P 7525 2300
F 0 "#PWR023" H 7525 2150 50  0001 C CNN
F 1 "+12V" V 7540 2428 50  0000 L CNN
F 2 "" H 7525 2300 50  0001 C CNN
F 3 "" H 7525 2300 50  0001 C CNN
	1    7525 2300
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR024
U 1 1 60914FE1
P 7525 2400
F 0 "#PWR024" H 7525 2250 50  0001 C CNN
F 1 "+12V" V 7540 2528 50  0000 L CNN
F 2 "" H 7525 2400 50  0001 C CNN
F 3 "" H 7525 2400 50  0001 C CNN
	1    7525 2400
	0    -1   -1   0   
$EndComp
NoConn ~ 1500 1500
NoConn ~ 1500 1600
$Comp
L Device:C C1
U 1 1 60910A6C
P 1550 6500
F 0 "C1" H 1665 6546 50  0000 L CNN
F 1 "0.1uF" H 1665 6455 50  0000 L CNN
F 2 "RevK:C_0603" H 1588 6350 50  0001 C CNN
F 3 "~" H 1550 6500 50  0001 C CNN
	1    1550 6500
	1    0    0    -1  
$EndComp
Connection ~ 1550 6350
$Comp
L power:GND #PWR02
U 1 1 6091181E
P 1550 6650
F 0 "#PWR02" H 1550 6400 50  0001 C CNN
F 1 "GND" H 1555 6477 50  0000 C CNN
F 2 "" H 1550 6650 50  0001 C CNN
F 3 "" H 1550 6650 50  0001 C CNN
	1    1550 6650
	1    0    0    -1  
$EndComp
Text GLabel 2700 2000 2    50   Input ~ 0
IN2
$Comp
L RevK:AA U6
U 1 1 60A37FFE
P 10600 6900
F 0 "U6" H 10650 6950 50  0001 C CNN
F 1 "AA" H 10625 6900 50  0000 L CNN
F 2 "RevK:AA" H 10600 6900 50  0001 C CNN
F 3 "" H 10600 6900 50  0001 C CNN
	1    10600 6900
	1    0    0    -1  
$EndComp
Text GLabel 4300 6475 0    50   Input ~ 0
IN1
$Comp
L Device:R R1
U 1 1 60B2E65B
P 4900 6475
F 0 "R1" V 5000 6475 50  0000 C CNN
F 1 "100R" V 5075 6475 50  0000 C CNN
F 2 "RevK:R_0603" V 4830 6475 50  0001 C CNN
F 3 "~" H 4900 6475 50  0001 C CNN
	1    4900 6475
	0    1    1    0   
$EndComp
Wire Wire Line
	4300 6475 4450 6475
Connection ~ 4450 6475
Wire Wire Line
	4450 6475 4750 6475
$Comp
L power:+3.3V #PWR014
U 1 1 60B2E66A
P 4750 6275
F 0 "#PWR014" H 4750 6125 50  0001 C CNN
F 1 "+3.3V" H 4765 6448 50  0000 C CNN
F 2 "" H 4750 6275 50  0001 C CNN
F 3 "" H 4750 6275 50  0001 C CNN
	1    4750 6275
	0    1    1    0   
$EndComp
$Comp
L Device:C C2
U 1 1 60B96051
P 4450 6725
F 0 "C2" H 4565 6771 50  0000 L CNN
F 1 "33pF" H 4565 6680 50  0000 L CNN
F 2 "RevK:C_0603" H 4488 6575 50  0001 C CNN
F 3 "~" H 4450 6725 50  0001 C CNN
	1    4450 6725
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR011
U 1 1 60B96057
P 4450 6875
F 0 "#PWR011" H 4450 6625 50  0001 C CNN
F 1 "GND" H 4455 6702 50  0000 C CNN
F 2 "" H 4450 6875 50  0001 C CNN
F 3 "" H 4450 6875 50  0001 C CNN
	1    4450 6875
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 6475 4450 6575
$Comp
L power:GND #PWR013
U 1 1 60C6ACE9
P 4475 3875
F 0 "#PWR013" H 4475 3625 50  0001 C CNN
F 1 "GND" H 4480 3702 50  0000 C CNN
F 2 "" H 4475 3875 50  0001 C CNN
F 3 "" H 4475 3875 50  0001 C CNN
	1    4475 3875
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR012
U 1 1 60C6B639
P 4475 3075
F 0 "#PWR012" H 4475 2925 50  0001 C CNN
F 1 "+12V" H 4490 3248 50  0000 C CNN
F 2 "" H 4475 3075 50  0001 C CNN
F 3 "" H 4475 3075 50  0001 C CNN
	1    4475 3075
	1    0    0    -1  
$EndComp
Text GLabel 5675 3375 0    50   Input ~ 0
OUT4
$Comp
L power:GND #PWR021
U 1 1 60CD900E
P 6075 3875
F 0 "#PWR021" H 6075 3625 50  0001 C CNN
F 1 "GND" H 6080 3702 50  0000 C CNN
F 2 "" H 6075 3875 50  0001 C CNN
F 3 "" H 6075 3875 50  0001 C CNN
	1    6075 3875
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR020
U 1 1 60CD9014
P 6075 3075
F 0 "#PWR020" H 6075 2925 50  0001 C CNN
F 1 "+12V" H 6090 3248 50  0000 C CNN
F 2 "" H 6075 3075 50  0001 C CNN
F 3 "" H 6075 3075 50  0001 C CNN
	1    6075 3075
	1    0    0    -1  
$EndComp
Text GLabel 5675 3575 0    50   Input ~ 0
OUT3
Text GLabel 4075 3375 0    50   Input ~ 0
OUT2
Text GLabel 4075 3575 0    50   Input ~ 0
OUT1
Text GLabel 2700 2600 2    50   Input ~ 0
OUT1
Text GLabel 2700 2700 2    50   Input ~ 0
OUT2
Text GLabel 2700 2800 2    50   Input ~ 0
OUT3
Text GLabel 2700 2900 2    50   Input ~ 0
OUT4
NoConn ~ 2700 1700
NoConn ~ 2700 1800
NoConn ~ 2700 2500
NoConn ~ 2700 2400
$Comp
L power:GND #PWR010
U 1 1 60B2E670
P 4150 6275
F 0 "#PWR010" H 4150 6025 50  0001 C CNN
F 1 "GND" H 4155 6102 50  0000 C CNN
F 2 "" H 4150 6275 50  0001 C CNN
F 3 "" H 4150 6275 50  0001 C CNN
	1    4150 6275
	0    1    1    0   
$EndComp
$Comp
L RevK:PowerIn J2
U 1 1 6074263F
P 7950 950
F 0 "J2" H 8030 942 50  0000 L CNN
F 1 "POWER" H 8030 851 50  0000 L CNN
F 2 "RevK:Molex_MiniSPOX_H2RA" H 7950 950 50  0001 C CNN
F 3 "~" H 7950 950 50  0001 C CNN
	1    7950 950 
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x10 J3
U 1 1 60C4EB7A
P 9300 5325
F 0 "J3" H 9218 4600 50  0000 C CNN
F 1 "Conn_01x10" H 9218 4691 50  0000 C CNN
F 2 "RevK:Molex_MiniSPOX_H10RA" H 9300 5325 50  0001 C CNN
F 3 "~" H 9300 5325 50  0001 C CNN
	1    9300 5325
	-1   0    0    1   
$EndComp
$Comp
L Diode:BAV99S D1
U 1 1 60C53FE8
P 4450 6275
F 0 "D1" H 4450 6492 50  0000 C CNN
F 1 "BAV99S" H 4450 6401 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 4450 5775 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 4450 6275 50  0001 C CNN
	1    4450 6275
	1    0    0    -1  
$EndComp
Text GLabel 5825 6425 0    50   Input ~ 0
IN2
$Comp
L Device:R R4
U 1 1 60C635AF
P 6425 6425
F 0 "R4" V 6525 6425 50  0000 C CNN
F 1 "100R" V 6600 6425 50  0000 C CNN
F 2 "RevK:R_0603" V 6355 6425 50  0001 C CNN
F 3 "~" H 6425 6425 50  0001 C CNN
	1    6425 6425
	0    1    1    0   
$EndComp
Wire Wire Line
	5825 6425 5975 6425
Connection ~ 5975 6425
Wire Wire Line
	5975 6425 6275 6425
$Comp
L power:+3.3V #PWR022
U 1 1 60C635B8
P 6275 6225
F 0 "#PWR022" H 6275 6075 50  0001 C CNN
F 1 "+3.3V" H 6290 6398 50  0000 C CNN
F 2 "" H 6275 6225 50  0001 C CNN
F 3 "" H 6275 6225 50  0001 C CNN
	1    6275 6225
	0    1    1    0   
$EndComp
$Comp
L Device:C C3
U 1 1 60C635BE
P 5975 6675
F 0 "C3" H 6090 6721 50  0000 L CNN
F 1 "33pF" H 6090 6630 50  0000 L CNN
F 2 "RevK:C_0603" H 6013 6525 50  0001 C CNN
F 3 "~" H 5975 6675 50  0001 C CNN
	1    5975 6675
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR019
U 1 1 60C635C4
P 5975 6825
F 0 "#PWR019" H 5975 6575 50  0001 C CNN
F 1 "GND" H 5980 6652 50  0000 C CNN
F 2 "" H 5975 6825 50  0001 C CNN
F 3 "" H 5975 6825 50  0001 C CNN
	1    5975 6825
	1    0    0    -1  
$EndComp
Wire Wire Line
	5975 6425 5975 6525
$Comp
L power:GND #PWR018
U 1 1 60C635CB
P 5675 6225
F 0 "#PWR018" H 5675 5975 50  0001 C CNN
F 1 "GND" H 5680 6052 50  0000 C CNN
F 2 "" H 5675 6225 50  0001 C CNN
F 3 "" H 5675 6225 50  0001 C CNN
	1    5675 6225
	0    1    1    0   
$EndComp
$Comp
L Diode:BAV99S D1
U 2 1 60C635D1
P 5975 6225
F 0 "D1" H 5975 6442 50  0000 C CNN
F 1 "BAV99S" H 5975 6351 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 5975 5725 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 5975 6225 50  0001 C CNN
	2    5975 6225
	1    0    0    -1  
$EndComp
Text GLabel 2700 2100 2    50   Input ~ 0
IN1
Text GLabel 6475 3375 2    50   Input ~ 0
~BACKLIGHT
Text GLabel 4875 3575 2    50   Input ~ 0
BELL
Text GLabel 4875 3375 2    50   Input ~ 0
STB
Text GLabel 6475 3575 2    50   Input ~ 0
ENGHOLD
Text GLabel 5050 6475 2    50   Input ~ 0
T
Text GLabel 6575 6425 2    50   Input ~ 0
FAULT
$Comp
L power:GND #PWR035
U 1 1 60C69A9A
P 9500 5725
F 0 "#PWR035" H 9500 5475 50  0001 C CNN
F 1 "GND" V 9505 5597 50  0000 R CNN
F 2 "" H 9500 5725 50  0001 C CNN
F 3 "" H 9500 5725 50  0001 C CNN
	1    9500 5725
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR034
U 1 1 60C6A585
P 9500 5625
F 0 "#PWR034" H 9500 5475 50  0001 C CNN
F 1 "+12V" V 9515 5753 50  0000 L CNN
F 2 "" H 9500 5625 50  0001 C CNN
F 3 "" H 9500 5625 50  0001 C CNN
	1    9500 5625
	0    1    1    0   
$EndComp
Text GLabel 9500 5525 2    50   Input ~ 0
BELL
Text GLabel 9500 5425 2    50   Input ~ 0
STB
Text GLabel 9500 5325 2    50   Input ~ 0
ENGHOLD
Text GLabel 9500 5125 2    50   Input ~ 0
FAULT
$Comp
L power:GND #PWR033
U 1 1 60C6CE6D
P 9500 5225
F 0 "#PWR033" H 9500 4975 50  0001 C CNN
F 1 "GND" V 9505 5097 50  0000 R CNN
F 2 "" H 9500 5225 50  0001 C CNN
F 3 "" H 9500 5225 50  0001 C CNN
	1    9500 5225
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR032
U 1 1 60C6D7F1
P 9500 5025
F 0 "#PWR032" H 9500 4775 50  0001 C CNN
F 1 "GND" V 9505 4897 50  0000 R CNN
F 2 "" H 9500 5025 50  0001 C CNN
F 3 "" H 9500 5025 50  0001 C CNN
	1    9500 5025
	0    -1   -1   0   
$EndComp
Text GLabel 9500 4925 2    50   Input ~ 0
T
Text GLabel 9500 4825 2    50   Input ~ 0
~BACKLIGHT
Text Notes 9100 4500 0    50   ~ 0
Pinout matches\nPyronix Deltabell
Wire Wire Line
	4975 1375 5825 1375
Wire Wire Line
	4975 1575 5825 1575
$Comp
L RevK:QR U7
U 1 1 60C86935
P 11050 6900
F 0 "U7" H 11050 6775 50  0001 C CNN
F 1 "QR" H 11050 6775 50  0001 C CNN
F 2 "RevK:QR-SS" H 11025 6875 50  0001 C CNN
F 3 "" H 11025 6875 50  0001 C CNN
	1    11050 6900
	1    0    0    -1  
$EndComp
$Comp
L Driver_FET:EL7202CN U3
U 1 1 60CE050A
P 4475 3475
F 0 "U3" H 4475 4056 50  0000 C CNN
F 1 "ISL89410" H 4475 3965 50  0000 C CNN
F 2 "Package_SO:SO-8_3.9x4.9mm_P1.27mm" H 4475 3175 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/Intersil/documents/el72/el7202-12-22.pdf" H 4475 3175 50  0001 C CNN
	1    4475 3475
	1    0    0    -1  
$EndComp
$Comp
L Driver_FET:EL7202CN U4
U 1 1 60CE10CC
P 6075 3475
F 0 "U4" H 6075 4056 50  0000 C CNN
F 1 "ISL89410" H 6075 3965 50  0000 C CNN
F 2 "Package_SO:SO-8_3.9x4.9mm_P1.27mm" H 6075 3175 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/Intersil/documents/el72/el7202-12-22.pdf" H 6075 3175 50  0001 C CNN
	1    6075 3475
	1    0    0    -1  
$EndComp
$Comp
L Device:LED_ARGB D2
U 1 1 60CE13C1
P 7900 3925
F 0 "D2" H 7900 4422 50  0000 C CNN
F 1 "LED_RGBA" H 7900 4331 50  0000 C CNN
F 2 "RevK:LED-RGB-1.6x1.6" H 7900 3875 50  0001 C CNN
F 3 "~" H 7900 3875 50  0001 C CNN
	1    7900 3925
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 60CE4750
P 7550 3925
F 0 "R6" V 7450 3925 50  0000 C CNN
F 1 "2K" V 7550 3925 50  0000 C CNN
F 2 "RevK:R_0603" V 7480 3925 50  0001 C CNN
F 3 "~" H 7550 3925 50  0001 C CNN
	1    7550 3925
	0    1    1    0   
$EndComp
$Comp
L Device:R R5
U 1 1 60CE4FE8
P 7550 3725
F 0 "R5" V 7450 3725 50  0000 C CNN
F 1 "732R" V 7550 3725 50  0000 C CNN
F 2 "RevK:R_0603" V 7480 3725 50  0001 C CNN
F 3 "~" H 7550 3725 50  0001 C CNN
	1    7550 3725
	0    1    1    0   
$EndComp
Text GLabel 7400 3725 0    50   Input ~ 0
R
Text GLabel 7400 3925 0    50   Input ~ 0
G
Text GLabel 7400 4125 0    50   Input ~ 0
B
Text GLabel 2700 3000 2    50   Input ~ 0
B
Text GLabel 2700 3200 2    50   Input ~ 0
G
Text GLabel 2700 3100 2    50   Input ~ 0
R
Text Notes 4100 4300 0    50   ~ 0
ISL89411 or ISL89412 would work as s/w is configurable for polarity.
$Comp
L RevK:LMR16006YQ3 U5
U 1 1 610EE400
P 7525 2300
F 0 "U5" H 8025 2400 50  0000 L CNN
F 1 "LMR16006YQ3" H 7525 1900 50  0000 L CNN
F 2 "RevK:RegulatorBlock" H 7975 2400 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/lmr16006y-q1.pdf" H 7975 2400 50  0001 C CNN
F 4 "TI" H 7525 2300 50  0001 C CNN "Manufacturer"
F 5 "LMR16006YQ3" H 7525 2300 50  0001 C CNN "Part No"
F 6 "" H 7525 2300 50  0001 C CNN "Note"
	1    7525 2300
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden C4
U 1 1 610F9B88
P 8125 2300
F 0 "C4" H 8100 2300 50  0000 L CNN
F 1 "0.1uF" H 8650 2300 50  0000 R CNN
F 2 "RevK:Hidden" H 8125 2300 50  0001 C CNN
F 3 "" H 8125 2300 50  0001 C CNN
F 4 "X7R or X5R 0603" H 8125 2300 50  0001 C CNN "Note"
	1    8125 2300
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden C5
U 1 1 610FD0EF
P 8125 2375
F 0 "C5" H 8100 2375 50  0000 L CNN
F 1 "2.2uF" H 8650 2375 50  0000 R CNN
F 2 "RevK:Hidden" H 8125 2375 50  0001 C CNN
F 3 "" H 8125 2375 50  0001 C CNN
F 4 "0603 or 0805" H 8125 2375 50  0001 C CNN "Note"
	1    8125 2375
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden C6
U 1 1 610FD80E
P 8125 2450
F 0 "C6" H 8100 2450 50  0000 L CNN
F 1 "10uF" H 8650 2450 50  0000 R CNN
F 2 "RevK:Hidden" H 8125 2450 50  0001 C CNN
F 3 "" H 8125 2450 50  0001 C CNN
F 4 "0603 or 0805" H 8125 2450 50  0001 C CNN "Note"
	1    8125 2450
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden L1
U 1 1 610FE01A
P 8125 2525
F 0 "L1" H 8100 2525 50  0000 L CNN
F 1 "6.8uH" H 8650 2525 50  0000 R CNN
F 2 "RevK:Hidden" H 8125 2525 50  0001 C CNN
F 3 "https://www.mouser.co.uk/datasheet/2/987/Laird_Performance_TYA4020_series__Rev_A_-1877538.pdf" H 8125 2525 50  0001 C CNN
F 4 "Laird" H 8125 2525 50  0001 C CNN "Manufacturer"
F 5 "TYA4020" H 8125 2525 50  0001 C CNN "Part No"
	1    8125 2525
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden D4
U 1 1 610FE5D2
P 8125 2600
F 0 "D4" H 8100 2600 50  0000 L CNN
F 1 "Schottky" H 8650 2600 50  0000 R CNN
F 2 "RevK:Hidden" H 8125 2600 50  0001 C CNN
F 3 "https://www.mouser.co.uk/datasheet/2/54/CD1206-B220_B2100-777245.pdf" H 8125 2600 50  0001 C CNN
F 4 "Bourns" H 8125 2600 50  0001 C CNN "Manufacturer"
F 5 "CD1206-B2100" H 8125 2600 50  0001 C CNN "Part No"
	1    8125 2600
	1    0    0    -1  
$EndComp
$EndSCHEMATC
