EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Access control"
Date "2021-07-31"
Rev "3"
Comp "Adrian Kennard Andrews & Arnold Ltd"
Comment1 "@TheRealRevK"
Comment2 "www.me.uk"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:USB_C_Receptacle_USB2.0 J1
U 1 1 60436927
P 4125 1450
F 0 "J1" H 4232 2317 50  0000 C CNN
F 1 "USB-C" H 4232 2226 50  0000 C CNN
F 2 "RevK:USC16-TR-Round" H 4275 1450 50  0001 C CNN
F 3 "https://www.usb.org/sites/default/files/documents/usb_type-c.zip" H 4275 1450 50  0001 C CNN
	1    4125 1450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 6043A8AD
P 4975 1050
F 0 "R9" V 5182 1050 50  0000 C CNN
F 1 "5K1" V 5091 1050 50  0000 C CNN
F 2 "RevK:R_0603" V 4905 1050 50  0001 C CNN
F 3 "~" H 4975 1050 50  0001 C CNN
	1    4975 1050
	0    -1   -1   0   
$EndComp
Text GLabel 2450 1575 2    50   Input ~ 0
I
Text GLabel 750  1275 0    50   Input ~ 0
EN
Text GLabel 5875 1350 2    50   Input ~ 0
D-
Text GLabel 5875 1550 2    50   Input ~ 0
D+
Wire Wire Line
	3825 2350 4125 2350
Connection ~ 4125 2350
Wire Wire Line
	4725 1650 4725 1550
Connection ~ 4725 1550
Wire Wire Line
	4725 1450 4725 1350
Connection ~ 4725 1350
Wire Wire Line
	4725 850  5325 850 
Wire Wire Line
	750  1275 1250 1275
Wire Wire Line
	4725 1050 4825 1050
Wire Wire Line
	4725 1150 4825 1150
Wire Wire Line
	5125 1050 5125 1100
Wire Wire Line
	5325 1100 5125 1100
Connection ~ 5125 1100
Wire Wire Line
	5125 1100 5125 1150
NoConn ~ 1250 2475
NoConn ~ 1250 2575
NoConn ~ 1250 2675
NoConn ~ 1250 2775
NoConn ~ 1250 2875
NoConn ~ 1250 2975
$Comp
L Device:R R10
U 1 1 6049A32B
P 4975 1150
F 0 "R10" V 5075 1150 50  0000 C CNN
F 1 "5K1" V 5175 1150 50  0000 C CNN
F 2 "RevK:R_0603" V 4905 1150 50  0001 C CNN
F 3 "~" H 4975 1150 50  0001 C CNN
	1    4975 1150
	0    1    1    0   
$EndComp
NoConn ~ 4725 1950
NoConn ~ 4725 2050
$Comp
L power:VBUS #PWR035
U 1 1 610F4D6A
P 5325 850
F 0 "#PWR035" H 5325 700 50  0001 C CNN
F 1 "VBUS" H 5340 1023 50  0000 C CNN
F 2 "" H 5325 850 50  0001 C CNN
F 3 "" H 5325 850 50  0001 C CNN
	1    5325 850 
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR04
U 1 1 610F4D6B
P 2850 1075
F 0 "#PWR04" H 2850 925 50  0001 C CNN
F 1 "+3.3V" H 2865 1248 50  0000 C CNN
F 2 "" H 2850 1075 50  0001 C CNN
F 3 "" H 2850 1075 50  0001 C CNN
	1    2850 1075
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR036
U 1 1 610F4D6C
P 5325 1100
F 0 "#PWR036" H 5325 850 50  0001 C CNN
F 1 "GND" H 5330 927 50  0000 C CNN
F 2 "" H 5325 1100 50  0001 C CNN
F 3 "" H 5325 1100 50  0001 C CNN
	1    5325 1100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR037
U 1 1 6046DFEC
P 5375 2350
F 0 "#PWR037" H 5375 2100 50  0001 C CNN
F 1 "GND" H 5380 2177 50  0000 C CNN
F 2 "" H 5375 2350 50  0001 C CNN
F 3 "" H 5375 2350 50  0001 C CNN
	1    5375 2350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 6046FB14
P 2900 3875
F 0 "#PWR05" H 2900 3625 50  0001 C CNN
F 1 "GND" H 2905 3702 50  0000 C CNN
F 2 "" H 2900 3875 50  0001 C CNN
F 3 "" H 2900 3875 50  0001 C CNN
	1    2900 3875
	1    0    0    -1  
$EndComp
Text GLabel 2450 1375 2    50   Input ~ 0
O
Text GLabel 2450 1275 2    50   Input ~ 0
BOOT
Wire Wire Line
	1850 1075 1850 1175
Wire Wire Line
	4125 2350 5375 2350
Wire Wire Line
	4725 1350 5475 1350
Wire Wire Line
	10400 1475 10400 1175
Wire Wire Line
	1850 1075 2850 1075
Wire Wire Line
	4725 1550 5475 1550
$Comp
L RevK:AJK AJK1
U 1 1 60629B22
P 10250 6875
F 0 "AJK1" H 10250 6975 50  0001 C CNN
F 1 "AJK" H 10500 6875 50  0000 L CNN
F 2 "RevK:AJK" H 10250 6775 50  0001 C CNN
F 3 "" H 10250 6775 50  0001 C CNN
	1    10250 6875
	1    0    0    -1  
$EndComp
Connection ~ 1850 1075
$Comp
L RF_Module:ESP32-WROOM-32 U1
U 1 1 6043326C
P 1850 2475
F 0 "U1" H 1850 4056 50  0000 C CNN
F 1 "ESP32-WROOM-32" H 1850 3965 50  0000 C CNN
F 2 "RevK:ESP32-WROOM-32" H 1850 975 50  0001 C CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32_datasheet_en.pdf" H 1550 2525 50  0001 C CNN
	1    1850 2475
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 3875 2900 3875
Text GLabel 2450 1775 2    50   Input ~ 0
IN1
Text GLabel 2450 2475 2    50   Input ~ 0
IN2
Text GLabel 2450 2575 2    50   Input ~ 0
IN3
Text GLabel 2450 2375 2    50   Input ~ 0
RFTX
Text GLabel 2450 2275 2    50   Input ~ 0
RFRX
NoConn ~ 2450 3475
NoConn ~ 2450 3575
Text GLabel 2450 2175 2    50   Input ~ 0
OUT1
$Comp
L Connector_Generic:Conn_01x04 J2
U 1 1 60739FA0
P 5425 3050
F 0 "J2" H 5505 3042 50  0000 L CNN
F 1 "RFID" H 5505 2951 50  0000 L CNN
F 2 "RevK:Molex_MiniSPOX_H4RA" H 5425 3050 50  0001 C CNN
F 3 "~" H 5425 3050 50  0001 C CNN
	1    5425 3050
	1    0    0    -1  
$EndComp
$Comp
L RevK:PowerIn J5
U 1 1 6074263F
P 8150 900
F 0 "J5" H 8230 892 50  0000 L CNN
F 1 "POWER" H 8230 801 50  0000 L CNN
F 2 "RevK:Molex_MiniSPOX_H2RA" H 8150 900 50  0001 C CNN
F 3 "~" H 8150 900 50  0001 C CNN
	1    8150 900 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR027
U 1 1 60743D17
P 5225 2950
F 0 "#PWR027" H 5225 2700 50  0001 C CNN
F 1 "GND" V 5230 2822 50  0000 R CNN
F 2 "" H 5225 2950 50  0001 C CNN
F 3 "" H 5225 2950 50  0001 C CNN
	1    5225 2950
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR042
U 1 1 607450BB
P 7950 900
F 0 "#PWR042" H 7950 650 50  0001 C CNN
F 1 "GND" V 7955 772 50  0000 R CNN
F 2 "" H 7950 900 50  0001 C CNN
F 3 "" H 7950 900 50  0001 C CNN
	1    7950 900 
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR028
U 1 1 607622A0
P 5225 3050
F 0 "#PWR028" H 5225 2900 50  0001 C CNN
F 1 "+5V" V 5240 3178 50  0000 L CNN
F 2 "" H 5225 3050 50  0001 C CNN
F 3 "" H 5225 3050 50  0001 C CNN
	1    5225 3050
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR038
U 1 1 6076D038
P 6600 1975
F 0 "#PWR038" H 6600 1725 50  0001 C CNN
F 1 "GND" V 6605 1847 50  0000 R CNN
F 2 "" H 6600 1975 50  0001 C CNN
F 3 "" H 6600 1975 50  0001 C CNN
	1    6600 1975
	0    1    1    0   
$EndComp
$Comp
L Device:R R13
U 1 1 6076ECA1
P 6450 1775
F 0 "R13" V 6243 1775 50  0000 C CNN
F 1 "1K" V 6334 1775 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 6380 1775 50  0001 C CNN
F 3 "~" H 6450 1775 50  0001 C CNN
	1    6450 1775
	0    1    1    0   
$EndComp
Text GLabel 6300 1775 0    50   Input ~ 0
OUT1
Text GLabel 4025 3250 0    50   Input ~ 0
RFTX
Text GLabel 4025 3150 0    50   Input ~ 0
RFRX
$Comp
L power:GND #PWR046
U 1 1 60776D64
P 8850 3475
F 0 "#PWR046" H 8850 3225 50  0001 C CNN
F 1 "GND" H 8855 3302 50  0000 C CNN
F 2 "" H 8850 3475 50  0001 C CNN
F 3 "" H 8850 3475 50  0001 C CNN
	1    8850 3475
	1    0    0    -1  
$EndComp
Text GLabel 2450 1675 2    50   Input ~ 0
SHDN
Text GLabel 8550 3275 0    50   Input ~ 0
SHDN
$Comp
L Interface_USB:FT231XQ U2
U 1 1 6084108B
P 2350 6325
F 0 "U2" H 2350 7406 50  0000 C CNN
F 1 "FT231XQ" H 2350 7315 50  0000 C CNN
F 2 "RevK:QFN-20-1EP_4x4mm_P0.5mm_EP2.5x2.5mm" H 3700 5525 50  0001 C CNN
F 3 "https://www.ftdichip.com/Support/Documents/DataSheets/ICs/DS_FT231X.pdf" H 2350 6325 50  0001 C CNN
	1    2350 6325
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 5425 2250 5425
Connection ~ 2250 5425
Text GLabel 1650 6025 0    50   Input ~ 0
D-
Text GLabel 1650 6125 0    50   Input ~ 0
D+
Wire Wire Line
	1650 6325 1300 6325
Wire Wire Line
	1300 6325 1300 5725
Wire Wire Line
	1300 5725 1650 5725
Connection ~ 1300 5725
Wire Wire Line
	1300 5725 1300 5425
Wire Wire Line
	1300 5425 2250 5425
Wire Wire Line
	2250 7225 2350 7225
Wire Wire Line
	2350 7225 2450 7225
Connection ~ 2350 7225
$Comp
L power:GND #PWR03
U 1 1 6085BF74
P 2350 7225
F 0 "#PWR03" H 2350 6975 50  0001 C CNN
F 1 "GND" H 2355 7052 50  0000 C CNN
F 2 "" H 2350 7225 50  0001 C CNN
F 3 "" H 2350 7225 50  0001 C CNN
	1    2350 7225
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR01
U 1 1 6085C74E
P 1300 5425
F 0 "#PWR01" H 1300 5275 50  0001 C CNN
F 1 "+3.3V" H 1315 5598 50  0000 C CNN
F 2 "" H 1300 5425 50  0001 C CNN
F 3 "" H 1300 5425 50  0001 C CNN
	1    1300 5425
	1    0    0    -1  
$EndComp
Connection ~ 1300 5425
$Comp
L power:GND #PWR06
U 1 1 6085CF95
P 3050 6025
F 0 "#PWR06" H 3050 5775 50  0001 C CNN
F 1 "GND" V 3055 5897 50  0000 R CNN
F 2 "" H 3050 6025 50  0001 C CNN
F 3 "" H 3050 6025 50  0001 C CNN
	1    3050 6025
	0    -1   -1   0   
$EndComp
Text GLabel 3050 6125 2    50   Input ~ 0
BOOT
Text GLabel 3050 5725 2    50   Input ~ 0
I
Text GLabel 3050 5825 2    50   Input ~ 0
O
Text GLabel 3050 5925 2    50   Input ~ 0
EN
NoConn ~ 3050 6625
NoConn ~ 3050 6725
NoConn ~ 3050 6825
NoConn ~ 3050 6925
$Comp
L power:GND #PWR07
U 1 1 6087F33E
P 3050 6225
F 0 "#PWR07" H 3050 5975 50  0001 C CNN
F 1 "GND" V 3055 6097 50  0000 R CNN
F 2 "" H 3050 6225 50  0001 C CNN
F 3 "" H 3050 6225 50  0001 C CNN
	1    3050 6225
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR08
U 1 1 6087FBAE
P 3050 6325
F 0 "#PWR08" H 3050 6075 50  0001 C CNN
F 1 "GND" V 3055 6197 50  0000 R CNN
F 2 "" H 3050 6325 50  0001 C CNN
F 3 "" H 3050 6325 50  0001 C CNN
	1    3050 6325
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR09
U 1 1 608803BE
P 3050 6425
F 0 "#PWR09" H 3050 6175 50  0001 C CNN
F 1 "GND" V 3055 6297 50  0000 R CNN
F 2 "" H 3050 6425 50  0001 C CNN
F 3 "" H 3050 6425 50  0001 C CNN
	1    3050 6425
	0    -1   -1   0   
$EndComp
$Comp
L RevK:G3VM-41GR8 U3
U 1 1 608BF21E
P 6900 1875
F 0 "U3" H 6900 2200 50  0000 C CNN
F 1 "G3VM-41GR8" H 6900 2109 50  0000 C CNN
F 2 "RevK:Special-SOP-4-3.7x4.55" H 6900 1575 50  0001 C CNN
F 3 "https://toshiba.semicon-storage.com/info/docget.jsp?did=1284&prodName=TLP3542" H 6900 1875 50  0001 C CNN
	1    6900 1875
	1    0    0    -1  
$EndComp
$Comp
L RevK:QR U7
U 1 1 608F5575
P 10750 6875
F 0 "U7" H 10750 6750 50  0001 C CNN
F 1 "QR" H 10750 6750 50  0001 C CNN
F 2 "RevK:QR-SS" H 10725 6850 50  0001 C CNN
F 3 "" H 10725 6850 50  0001 C CNN
	1    10750 6875
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x03 J6
U 1 1 608CB396
P 8150 1475
F 0 "J6" H 8230 1517 50  0000 L CNN
F 1 "DOOR" H 8230 1426 50  0000 L CNN
F 2 "RevK:Molex_MiniSPOX_H3RA" H 8150 1475 50  0001 C CNN
F 3 "~" H 8150 1475 50  0001 C CNN
	1    8150 1475
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x06 J3
U 1 1 608CF414
P 5800 5650
F 0 "J3" H 5880 5642 50  0000 L CNN
F 1 "INPUTS" H 5880 5551 50  0000 L CNN
F 2 "RevK:Molex_MiniSPOX_H6RA" H 5800 5650 50  0001 C CNN
F 3 "~" H 5800 5650 50  0001 C CNN
	1    5800 5650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR044
U 1 1 608E5346
P 7950 1375
F 0 "#PWR044" H 7950 1125 50  0001 C CNN
F 1 "GND" V 7955 1247 50  0000 R CNN
F 2 "" H 7950 1375 50  0001 C CNN
F 3 "" H 7950 1375 50  0001 C CNN
	1    7950 1375
	0    1    1    0   
$EndComp
$Comp
L Device:Jumper_NO_Small JP1
U 1 1 608E5B1F
P 7150 1475
F 0 "JP1" H 7150 1660 50  0000 C CNN
F 1 "12V" H 7150 1569 50  0000 C CNN
F 2 "Connector_PinHeader_1.27mm:PinHeader_1x02_P1.27mm_Vertical" H 7150 1475 50  0001 C CNN
F 3 "~" H 7150 1475 50  0001 C CNN
	1    7150 1475
	1    0    0    -1  
$EndComp
Wire Wire Line
	7200 1775 7450 1775
Wire Wire Line
	7450 1775 7450 1475
Wire Wire Line
	7450 1475 7250 1475
NoConn ~ 2450 1475
NoConn ~ 2450 2075
NoConn ~ 2450 3275
NoConn ~ 2450 3375
NoConn ~ 7150 1475
NoConn ~ 9400 9850
Wire Wire Line
	7950 1575 7950 1975
$Comp
L Device:R R11
U 1 1 608C473E
P 5625 1350
F 0 "R11" V 5418 1350 50  0000 C CNN
F 1 "27R" V 5509 1350 50  0000 C CNN
F 2 "RevK:R_0603" V 5555 1350 50  0001 C CNN
F 3 "~" H 5625 1350 50  0001 C CNN
	1    5625 1350
	0    1    1    0   
$EndComp
Wire Wire Line
	5775 1350 5875 1350
$Comp
L Device:R R12
U 1 1 608C572B
P 5625 1550
F 0 "R12" V 5875 1550 50  0000 C CNN
F 1 "27R" V 5775 1550 50  0000 C CNN
F 2 "RevK:R_0603" V 5555 1550 50  0001 C CNN
F 3 "~" H 5625 1550 50  0001 C CNN
	1    5625 1550
	0    1    1    0   
$EndComp
Wire Wire Line
	5775 1550 5875 1550
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 608D1452
P 10250 6125
F 0 "H1" H 10350 6171 50  0000 L CNN
F 1 "MountingHole" H 10350 6080 50  0000 L CNN
F 2 "RevK:ISO7380-M3-Pad" H 10250 6125 50  0001 C CNN
F 3 "~" H 10250 6125 50  0001 C CNN
	1    10250 6125
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR055
U 1 1 608DE2B1
P 10250 6225
F 0 "#PWR055" H 10250 5975 50  0001 C CNN
F 1 "GND" H 10255 6052 50  0000 C CNN
F 2 "" H 10250 6225 50  0001 C CNN
F 3 "" H 10250 6225 50  0001 C CNN
	1    10250 6225
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR043
U 1 1 608D441F
P 7950 1000
F 0 "#PWR043" H 7950 850 50  0001 C CNN
F 1 "+12V" V 7965 1128 50  0000 L CNN
F 2 "" H 7950 1000 50  0001 C CNN
F 3 "" H 7950 1000 50  0001 C CNN
	1    7950 1000
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR056
U 1 1 608D6235
P 10400 1175
F 0 "#PWR056" H 10400 1025 50  0001 C CNN
F 1 "+12V" H 10415 1348 50  0000 C CNN
F 2 "" H 10400 1175 50  0001 C CNN
F 3 "" H 10400 1175 50  0001 C CNN
	1    10400 1175
	1    0    0    -1  
$EndComp
$Comp
L Device:D D6
U 1 1 608D7F70
P 10250 1475
F 0 "D6" H 10250 1258 50  0000 C CNN
F 1 "D" H 10250 1349 50  0000 C CNN
F 2 "Diode_SMD:D_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 10250 1475 50  0001 C CNN
F 3 "~" H 10250 1475 50  0001 C CNN
	1    10250 1475
	-1   0    0    1   
$EndComp
Wire Wire Line
	10100 1475 10100 1175
$Comp
L power:VBUS #PWR054
U 1 1 608DB037
P 10100 1175
F 0 "#PWR054" H 10100 1025 50  0001 C CNN
F 1 "VBUS" H 10115 1348 50  0000 C CNN
F 2 "" H 10100 1175 50  0001 C CNN
F 3 "" H 10100 1175 50  0001 C CNN
	1    10100 1175
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR040
U 1 1 608D570F
P 7050 1475
F 0 "#PWR040" H 7050 1325 50  0001 C CNN
F 1 "+12V" V 7065 1603 50  0000 L CNN
F 2 "" H 7050 1475 50  0001 C CNN
F 3 "" H 7050 1475 50  0001 C CNN
	1    7050 1475
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R17
U 1 1 609872B4
P 8850 2925
F 0 "R17" V 8643 2925 50  0000 C CNN
F 1 "100K" V 8734 2925 50  0000 C CNN
F 2 "RevK:R_0603" V 8780 2925 50  0001 C CNN
F 3 "~" H 8850 2925 50  0001 C CNN
	1    8850 2925
	-1   0    0    1   
$EndComp
$Comp
L power:+12V #PWR045
U 1 1 6098D6E9
P 8850 2775
F 0 "#PWR045" H 8850 2625 50  0001 C CNN
F 1 "+12V" V 8865 2903 50  0000 L CNN
F 2 "" H 8850 2775 50  0001 C CNN
F 3 "" H 8850 2775 50  0001 C CNN
	1    8850 2775
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR049
U 1 1 608FD8A1
P 9850 2125
F 0 "#PWR049" H 9850 1875 50  0001 C CNN
F 1 "GND" V 9855 1997 50  0000 R CNN
F 2 "" H 9850 2125 50  0001 C CNN
F 3 "" H 9850 2125 50  0001 C CNN
	1    9850 2125
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR050
U 1 1 608FE15A
P 9850 2225
F 0 "#PWR050" H 9850 2075 50  0001 C CNN
F 1 "+3.3V" V 9865 2353 50  0000 L CNN
F 2 "" H 9850 2225 50  0001 C CNN
F 3 "" H 9850 2225 50  0001 C CNN
	1    9850 2225
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR047
U 1 1 60913ECD
P 9850 1925
F 0 "#PWR047" H 9850 1775 50  0001 C CNN
F 1 "+12V" V 9865 2053 50  0000 L CNN
F 2 "" H 9850 1925 50  0001 C CNN
F 3 "" H 9850 1925 50  0001 C CNN
	1    9850 1925
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR048
U 1 1 60914FE1
P 9850 2025
F 0 "#PWR048" H 9850 1875 50  0001 C CNN
F 1 "+12V" V 9865 2153 50  0000 L CNN
F 2 "" H 9850 2025 50  0001 C CNN
F 3 "" H 9850 2025 50  0001 C CNN
	1    9850 2025
	0    -1   -1   0   
$EndComp
$Comp
L power:+12V #PWR051
U 1 1 60919863
P 9900 3175
F 0 "#PWR051" H 9900 3025 50  0001 C CNN
F 1 "+12V" V 9915 3303 50  0000 L CNN
F 2 "" H 9900 3175 50  0001 C CNN
F 3 "" H 9900 3175 50  0001 C CNN
	1    9900 3175
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR052
U 1 1 6091A03A
P 9900 3275
F 0 "#PWR052" H 9900 3025 50  0001 C CNN
F 1 "GND" V 9905 3147 50  0000 R CNN
F 2 "" H 9900 3275 50  0001 C CNN
F 3 "" H 9900 3275 50  0001 C CNN
	1    9900 3275
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR053
U 1 1 6091A941
P 9900 3375
F 0 "#PWR053" H 9900 3225 50  0001 C CNN
F 1 "+5V" V 9915 3503 50  0000 L CNN
F 2 "" H 9900 3375 50  0001 C CNN
F 3 "" H 9900 3375 50  0001 C CNN
	1    9900 3375
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7450 1475 7950 1475
Connection ~ 7450 1475
Wire Wire Line
	7200 1975 7950 1975
NoConn ~ 1250 1475
NoConn ~ 1250 1575
$Comp
L Device:C C1
U 1 1 60910A6C
P 1300 6475
F 0 "C1" H 1415 6521 50  0000 L CNN
F 1 "0.1uF" H 1415 6430 50  0000 L CNN
F 2 "RevK:C_0603" H 1338 6325 50  0001 C CNN
F 3 "~" H 1300 6475 50  0001 C CNN
	1    1300 6475
	1    0    0    -1  
$EndComp
Connection ~ 1300 6325
$Comp
L power:GND #PWR02
U 1 1 6091181E
P 1300 6625
F 0 "#PWR02" H 1300 6375 50  0001 C CNN
F 1 "GND" H 1305 6452 50  0000 C CNN
F 2 "" H 1300 6625 50  0001 C CNN
F 3 "" H 1300 6625 50  0001 C CNN
	1    1300 6625
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR039
U 1 1 6095334D
P 7025 4400
F 0 "#PWR039" H 7025 4150 50  0001 C CNN
F 1 "GND" V 7030 4272 50  0000 R CNN
F 2 "" H 7025 4400 50  0001 C CNN
F 3 "" H 7025 4400 50  0001 C CNN
	1    7025 4400
	0    1    1    0   
$EndComp
Text GLabel 7425 4400 2    50   Input ~ 0
TAMPER
Text GLabel 2450 1975 2    50   Input ~ 0
TAMPER
$Comp
L Switch:SW_Push SW1
U 1 1 6093BE97
P 7225 4400
F 0 "SW1" H 7225 4685 50  0000 C CNN
F 1 "Tamper" H 7225 4594 50  0000 C CNN
F 2 "RevK:SW_PUSH_6mm_SMD" H 7225 4600 50  0001 C CNN
F 3 "~" H 7225 4600 50  0001 C CNN
	1    7225 4400
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 6094F3AD
P 7175 4700
F 0 "J4" V 7047 4512 50  0000 R CNN
F 1 "ExtTamper" V 7138 4512 50  0000 R CNN
F 2 "TestPoint:TestPoint_2Pads_Pitch5.08mm_Drill1.3mm" H 7175 4700 50  0001 C CNN
F 3 "~" H 7175 4700 50  0001 C CNN
	1    7175 4700
	0    -1   1    0   
$EndComp
Wire Wire Line
	7025 4400 7025 4500
Connection ~ 7025 4400
Wire Wire Line
	7025 4500 7175 4500
Wire Wire Line
	7425 4400 7425 4500
Wire Wire Line
	7275 4500 7425 4500
$Comp
L Device:R R2
U 1 1 6098E6BE
P 4625 3250
F 0 "R2" V 4725 3250 50  0000 C CNN
F 1 "100R" V 4825 3250 50  0000 C CNN
F 2 "RevK:R_0603" V 4555 3250 50  0001 C CNN
F 3 "~" H 4625 3250 50  0001 C CNN
	1    4625 3250
	0    1    1    0   
$EndComp
$Comp
L Device:R R1
U 1 1 6098F76B
P 4625 3150
F 0 "R1" V 4525 3150 50  0000 C CNN
F 1 "100R" V 4425 3150 50  0000 C CNN
F 2 "RevK:R_0603" V 4555 3150 50  0001 C CNN
F 3 "~" H 4625 3150 50  0001 C CNN
	1    4625 3150
	0    1    1    0   
$EndComp
$Comp
L Diode:BAV99S D1
U 1 1 6099FC70
P 4175 2950
F 0 "D1" H 4175 3167 50  0000 C CNN
F 1 "BAV99S" H 4175 3076 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 4175 2450 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 4175 2950 50  0001 C CNN
	1    4175 2950
	1    0    0    -1  
$EndComp
$Comp
L Diode:BAV99S D1
U 2 1 60A017E2
P 4175 3450
F 0 "D1" H 4175 3667 50  0000 C CNN
F 1 "BAV99S" H 4175 3576 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 4175 2950 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 4175 3450 50  0001 C CNN
	2    4175 3450
	1    0    0    1   
$EndComp
Wire Wire Line
	4025 3150 4075 3150
Wire Wire Line
	4025 3250 4175 3250
Connection ~ 4175 3150
Wire Wire Line
	4175 3150 4475 3150
Wire Wire Line
	4175 3250 4475 3250
Connection ~ 4175 3250
Wire Wire Line
	4775 3150 5225 3150
Wire Wire Line
	4775 3250 5225 3250
$Comp
L power:+3.3V #PWR019
U 1 1 60A1DD31
P 4475 2950
F 0 "#PWR019" H 4475 2800 50  0001 C CNN
F 1 "+3.3V" H 4490 3123 50  0000 C CNN
F 2 "" H 4475 2950 50  0001 C CNN
F 3 "" H 4475 2950 50  0001 C CNN
	1    4475 2950
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR020
U 1 1 60A1E596
P 4475 3450
F 0 "#PWR020" H 4475 3300 50  0001 C CNN
F 1 "+3.3V" H 4490 3623 50  0000 C CNN
F 2 "" H 4475 3450 50  0001 C CNN
F 3 "" H 4475 3450 50  0001 C CNN
	1    4475 3450
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR012
U 1 1 60A1EFD2
P 3875 3450
F 0 "#PWR012" H 3875 3200 50  0001 C CNN
F 1 "GND" H 3880 3277 50  0000 C CNN
F 2 "" H 3875 3450 50  0001 C CNN
F 3 "" H 3875 3450 50  0001 C CNN
	1    3875 3450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR011
U 1 1 60A1F837
P 3875 2950
F 0 "#PWR011" H 3875 2700 50  0001 C CNN
F 1 "GND" H 3880 2777 50  0000 C CNN
F 2 "" H 3875 2950 50  0001 C CNN
F 3 "" H 3875 2950 50  0001 C CNN
	1    3875 2950
	-1   0    0    1   
$EndComp
Text GLabel 4025 4225 0    50   Input ~ 0
IN1
$Comp
L Device:R R3
U 1 1 609F92AA
P 4625 4225
F 0 "R3" V 4525 4225 50  0000 C CNN
F 1 "100R" V 4425 4225 50  0000 C CNN
F 2 "RevK:R_0603" V 4555 4225 50  0001 C CNN
F 3 "~" H 4625 4225 50  0001 C CNN
	1    4625 4225
	0    1    1    0   
$EndComp
$Comp
L Diode:BAV99S D2
U 1 1 609F92B0
P 4175 4025
F 0 "D2" H 4175 4242 50  0000 C CNN
F 1 "BAV99S" H 4175 4151 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 4175 3525 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 4175 4025 50  0001 C CNN
	1    4175 4025
	1    0    0    -1  
$EndComp
Wire Wire Line
	4025 4225 4175 4225
Connection ~ 4175 4225
Wire Wire Line
	4175 4225 4475 4225
$Comp
L power:+3.3V #PWR021
U 1 1 609F92C2
P 4475 4025
F 0 "#PWR021" H 4475 3875 50  0001 C CNN
F 1 "+3.3V" H 4490 4198 50  0000 C CNN
F 2 "" H 4475 4025 50  0001 C CNN
F 3 "" H 4475 4025 50  0001 C CNN
	1    4475 4025
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 610F4D71
P 3875 4025
F 0 "#PWR013" H 3875 3775 50  0001 C CNN
F 1 "GND" H 3880 3852 50  0000 C CNN
F 2 "" H 3875 4025 50  0001 C CNN
F 3 "" H 3875 4025 50  0001 C CNN
	1    3875 4025
	-1   0    0    1   
$EndComp
Text GLabel 4025 4825 0    50   Input ~ 0
IN2
$Comp
L Device:R R4
U 1 1 60A012EA
P 4625 4825
F 0 "R4" V 4525 4825 50  0000 C CNN
F 1 "100R" V 4425 4825 50  0000 C CNN
F 2 "RevK:R_0603" V 4555 4825 50  0001 C CNN
F 3 "~" H 4625 4825 50  0001 C CNN
	1    4625 4825
	0    1    1    0   
$EndComp
$Comp
L Diode:BAV99S D2
U 2 1 60A012F0
P 4175 4625
F 0 "D2" H 4175 4842 50  0000 C CNN
F 1 "BAV99S" H 4175 4751 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 4175 4125 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 4175 4625 50  0001 C CNN
	2    4175 4625
	1    0    0    -1  
$EndComp
Wire Wire Line
	4025 4825 4175 4825
Connection ~ 4175 4825
Wire Wire Line
	4175 4825 4475 4825
$Comp
L power:+3.3V #PWR022
U 1 1 60A012F9
P 4475 4625
F 0 "#PWR022" H 4475 4475 50  0001 C CNN
F 1 "+3.3V" H 4490 4798 50  0000 C CNN
F 2 "" H 4475 4625 50  0001 C CNN
F 3 "" H 4475 4625 50  0001 C CNN
	1    4475 4625
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR014
U 1 1 60A012FF
P 3875 4625
F 0 "#PWR014" H 3875 4375 50  0001 C CNN
F 1 "GND" H 3880 4452 50  0000 C CNN
F 2 "" H 3875 4625 50  0001 C CNN
F 3 "" H 3875 4625 50  0001 C CNN
	1    3875 4625
	-1   0    0    1   
$EndComp
$Comp
L RevK:AA U6
U 1 1 60A37FFE
P 10350 6875
F 0 "U6" H 10400 6925 50  0001 C CNN
F 1 "AA" H 10375 6875 50  0000 L CNN
F 2 "RevK:AA" H 10350 6875 50  0001 C CNN
F 3 "" H 10350 6875 50  0001 C CNN
	1    10350 6875
	1    0    0    -1  
$EndComp
Text GLabel 4025 5425 0    50   Input ~ 0
IN3
$Comp
L Device:R R5
U 1 1 60B25E85
P 4625 5425
F 0 "R5" V 4525 5425 50  0000 C CNN
F 1 "100R" V 4425 5425 50  0000 C CNN
F 2 "RevK:R_0603" V 4555 5425 50  0001 C CNN
F 3 "~" H 4625 5425 50  0001 C CNN
	1    4625 5425
	0    1    1    0   
$EndComp
$Comp
L Diode:BAV99S D3
U 1 1 60B25E8B
P 4175 5225
F 0 "D3" H 4175 5442 50  0000 C CNN
F 1 "BAV99S" H 4175 5351 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 4175 4725 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 4175 5225 50  0001 C CNN
	1    4175 5225
	1    0    0    -1  
$EndComp
Wire Wire Line
	4025 5425 4175 5425
Connection ~ 4175 5425
Wire Wire Line
	4175 5425 4475 5425
$Comp
L power:+3.3V #PWR023
U 1 1 60B25E94
P 4475 5225
F 0 "#PWR023" H 4475 5075 50  0001 C CNN
F 1 "+3.3V" H 4490 5398 50  0000 C CNN
F 2 "" H 4475 5225 50  0001 C CNN
F 3 "" H 4475 5225 50  0001 C CNN
	1    4475 5225
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR015
U 1 1 60B25E9A
P 3875 5225
F 0 "#PWR015" H 3875 4975 50  0001 C CNN
F 1 "GND" H 3880 5052 50  0000 C CNN
F 2 "" H 3875 5225 50  0001 C CNN
F 3 "" H 3875 5225 50  0001 C CNN
	1    3875 5225
	-1   0    0    1   
$EndComp
Text GLabel 4025 6025 0    50   Input ~ 0
IN4
$Comp
L Device:R R6
U 1 1 60B25EA1
P 4625 6025
F 0 "R6" V 4525 6025 50  0000 C CNN
F 1 "100R" V 4425 6025 50  0000 C CNN
F 2 "RevK:R_0603" V 4555 6025 50  0001 C CNN
F 3 "~" H 4625 6025 50  0001 C CNN
	1    4625 6025
	0    1    1    0   
$EndComp
$Comp
L Diode:BAV99S D3
U 2 1 60B25EA7
P 4175 5825
F 0 "D3" H 4175 6042 50  0000 C CNN
F 1 "BAV99S" H 4175 5951 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 4175 5325 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 4175 5825 50  0001 C CNN
	2    4175 5825
	1    0    0    -1  
$EndComp
Wire Wire Line
	4025 6025 4175 6025
Connection ~ 4175 6025
Wire Wire Line
	4175 6025 4475 6025
$Comp
L power:+3.3V #PWR024
U 1 1 60B25EB0
P 4475 5825
F 0 "#PWR024" H 4475 5675 50  0001 C CNN
F 1 "+3.3V" H 4490 5998 50  0000 C CNN
F 2 "" H 4475 5825 50  0001 C CNN
F 3 "" H 4475 5825 50  0001 C CNN
	1    4475 5825
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 60B25EB6
P 3875 5825
F 0 "#PWR016" H 3875 5575 50  0001 C CNN
F 1 "GND" H 3880 5652 50  0000 C CNN
F 2 "" H 3875 5825 50  0001 C CNN
F 3 "" H 3875 5825 50  0001 C CNN
	1    3875 5825
	-1   0    0    1   
$EndComp
Text GLabel 4050 6625 0    50   Input ~ 0
IN5
$Comp
L Device:R R7
U 1 1 60B2E63F
P 4650 6625
F 0 "R7" V 4550 6625 50  0000 C CNN
F 1 "100R" V 4450 6625 50  0000 C CNN
F 2 "RevK:R_0603" V 4580 6625 50  0001 C CNN
F 3 "~" H 4650 6625 50  0001 C CNN
	1    4650 6625
	0    1    1    0   
$EndComp
$Comp
L Diode:BAV99S D4
U 1 1 60B2E645
P 4200 6425
F 0 "D4" H 4200 6642 50  0000 C CNN
F 1 "BAV99S" H 4200 6551 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 4200 5925 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 4200 6425 50  0001 C CNN
	1    4200 6425
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 6625 4200 6625
Connection ~ 4200 6625
Wire Wire Line
	4200 6625 4500 6625
$Comp
L power:+3.3V #PWR025
U 1 1 60B2E64E
P 4500 6425
F 0 "#PWR025" H 4500 6275 50  0001 C CNN
F 1 "+3.3V" H 4515 6598 50  0000 C CNN
F 2 "" H 4500 6425 50  0001 C CNN
F 3 "" H 4500 6425 50  0001 C CNN
	1    4500 6425
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR017
U 1 1 60B2E654
P 3900 6425
F 0 "#PWR017" H 3900 6175 50  0001 C CNN
F 1 "GND" H 3905 6252 50  0000 C CNN
F 2 "" H 3900 6425 50  0001 C CNN
F 3 "" H 3900 6425 50  0001 C CNN
	1    3900 6425
	-1   0    0    1   
$EndComp
Text GLabel 4050 7225 0    50   Input ~ 0
IN6
$Comp
L Device:R R8
U 1 1 60B2E65B
P 4650 7225
F 0 "R8" V 4550 7225 50  0000 C CNN
F 1 "100R" V 4450 7225 50  0000 C CNN
F 2 "RevK:R_0603" V 4580 7225 50  0001 C CNN
F 3 "~" H 4650 7225 50  0001 C CNN
	1    4650 7225
	0    1    1    0   
$EndComp
$Comp
L Diode:BAV99S D4
U 2 1 60B2E661
P 4200 7025
F 0 "D4" H 4200 7242 50  0000 C CNN
F 1 "BAV99S" H 4200 7151 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 4200 6525 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 4200 7025 50  0001 C CNN
	2    4200 7025
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 7225 4200 7225
Connection ~ 4200 7225
Wire Wire Line
	4200 7225 4500 7225
$Comp
L power:+3.3V #PWR026
U 1 1 60B2E66A
P 4500 7025
F 0 "#PWR026" H 4500 6875 50  0001 C CNN
F 1 "+3.3V" H 4515 7198 50  0000 C CNN
F 2 "" H 4500 7025 50  0001 C CNN
F 3 "" H 4500 7025 50  0001 C CNN
	1    4500 7025
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR018
U 1 1 60B2E670
P 3900 7025
F 0 "#PWR018" H 3900 6775 50  0001 C CNN
F 1 "GND" H 3905 6852 50  0000 C CNN
F 2 "" H 3900 7025 50  0001 C CNN
F 3 "" H 3900 7025 50  0001 C CNN
	1    3900 7025
	-1   0    0    1   
$EndComp
Wire Wire Line
	5500 5450 5600 5450
Wire Wire Line
	5450 5550 5600 5550
Wire Wire Line
	5400 5425 5400 5650
Wire Wire Line
	5400 5650 5600 5650
Wire Wire Line
	5400 6025 5400 5750
Wire Wire Line
	5400 5750 5600 5750
Wire Wire Line
	5450 6625 5450 5850
Wire Wire Line
	5450 5850 5600 5850
Wire Wire Line
	5500 7225 5500 5950
Wire Wire Line
	5500 5950 5600 5950
Text GLabel 2450 2875 2    50   Input ~ 0
IN6
Text GLabel 2450 2775 2    50   Input ~ 0
IN5
Text GLabel 2450 2675 2    50   Input ~ 0
IN4
$Comp
L Device:C C3
U 1 1 60B0D680
P 5075 4375
F 0 "C3" H 5190 4421 50  0000 L CNN
F 1 "33pF" H 5190 4330 50  0000 L CNN
F 2 "RevK:C_0603" H 5113 4225 50  0001 C CNN
F 3 "~" H 5075 4375 50  0001 C CNN
	1    5075 4375
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR029
U 1 1 60B0E922
P 5225 4375
F 0 "#PWR029" H 5225 4125 50  0001 C CNN
F 1 "GND" H 5230 4202 50  0000 C CNN
F 2 "" H 5225 4375 50  0001 C CNN
F 3 "" H 5225 4375 50  0001 C CNN
	1    5225 4375
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4775 4225 5500 4225
Wire Wire Line
	4775 4825 5450 4825
Wire Wire Line
	4775 5425 5400 5425
Wire Wire Line
	4775 6025 5400 6025
Wire Wire Line
	4800 6625 5450 6625
Wire Wire Line
	4800 7225 5500 7225
Wire Wire Line
	4175 4325 4825 4325
Wire Wire Line
	4825 4325 4825 4375
Wire Wire Line
	4825 4375 4925 4375
$Comp
L Device:C C4
U 1 1 60B855F6
P 5075 4975
F 0 "C4" H 5190 5021 50  0000 L CNN
F 1 "33pF" H 5190 4930 50  0000 L CNN
F 2 "RevK:C_0603" H 5113 4825 50  0001 C CNN
F 3 "~" H 5075 4975 50  0001 C CNN
	1    5075 4975
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR030
U 1 1 60B855FC
P 5225 4975
F 0 "#PWR030" H 5225 4725 50  0001 C CNN
F 1 "GND" H 5230 4802 50  0000 C CNN
F 2 "" H 5225 4975 50  0001 C CNN
F 3 "" H 5225 4975 50  0001 C CNN
	1    5225 4975
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4175 4925 4825 4925
Wire Wire Line
	4825 4925 4825 4975
$Comp
L Device:C C5
U 1 1 60B89ADF
P 5075 5575
F 0 "C5" H 5190 5621 50  0000 L CNN
F 1 "33pF" H 5190 5530 50  0000 L CNN
F 2 "RevK:C_0603" H 5113 5425 50  0001 C CNN
F 3 "~" H 5075 5575 50  0001 C CNN
	1    5075 5575
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR031
U 1 1 60B89AE5
P 5225 5575
F 0 "#PWR031" H 5225 5325 50  0001 C CNN
F 1 "GND" H 5230 5402 50  0000 C CNN
F 2 "" H 5225 5575 50  0001 C CNN
F 3 "" H 5225 5575 50  0001 C CNN
	1    5225 5575
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4175 5525 4825 5525
Wire Wire Line
	4825 5525 4825 5575
Wire Wire Line
	4825 5575 4925 5575
$Comp
L Device:C C6
U 1 1 60B8D84E
P 5075 6175
F 0 "C6" H 5190 6221 50  0000 L CNN
F 1 "33pF" H 5190 6130 50  0000 L CNN
F 2 "RevK:C_0603" H 5113 6025 50  0001 C CNN
F 3 "~" H 5075 6175 50  0001 C CNN
	1    5075 6175
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR032
U 1 1 60B8D854
P 5225 6175
F 0 "#PWR032" H 5225 5925 50  0001 C CNN
F 1 "GND" H 5230 6002 50  0000 C CNN
F 2 "" H 5225 6175 50  0001 C CNN
F 3 "" H 5225 6175 50  0001 C CNN
	1    5225 6175
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4175 6125 4825 6125
Wire Wire Line
	4825 6125 4825 6175
Wire Wire Line
	4825 6175 4925 6175
$Comp
L Device:C C7
U 1 1 60B91572
P 5100 6775
F 0 "C7" H 5215 6821 50  0000 L CNN
F 1 "33pF" H 5215 6730 50  0000 L CNN
F 2 "RevK:C_0603" H 5138 6625 50  0001 C CNN
F 3 "~" H 5100 6775 50  0001 C CNN
	1    5100 6775
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR033
U 1 1 60B91578
P 5250 6775
F 0 "#PWR033" H 5250 6525 50  0001 C CNN
F 1 "GND" H 5255 6602 50  0000 C CNN
F 2 "" H 5250 6775 50  0001 C CNN
F 3 "" H 5250 6775 50  0001 C CNN
	1    5250 6775
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4200 6725 4850 6725
Wire Wire Line
	4850 6725 4850 6775
Wire Wire Line
	4850 6775 4950 6775
$Comp
L Device:C C8
U 1 1 60B96051
P 5100 7375
F 0 "C8" H 5215 7421 50  0000 L CNN
F 1 "33pF" H 5215 7330 50  0000 L CNN
F 2 "RevK:C_0603" H 5138 7225 50  0001 C CNN
F 3 "~" H 5100 7375 50  0001 C CNN
	1    5100 7375
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR034
U 1 1 60B96057
P 5250 7375
F 0 "#PWR034" H 5250 7125 50  0001 C CNN
F 1 "GND" H 5255 7202 50  0000 C CNN
F 2 "" H 5250 7375 50  0001 C CNN
F 3 "" H 5250 7375 50  0001 C CNN
	1    5250 7375
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4200 7325 4850 7325
Wire Wire Line
	4850 7325 4850 7375
Wire Wire Line
	4850 7375 4950 7375
Wire Wire Line
	4175 4225 4175 4325
Wire Wire Line
	4175 4825 4175 4925
Wire Wire Line
	4175 5425 4175 5525
Wire Wire Line
	4175 6025 4175 6125
Wire Wire Line
	4200 6625 4200 6725
Wire Wire Line
	4200 7225 4200 7325
Wire Wire Line
	4825 4975 4925 4975
Wire Wire Line
	5500 4225 5500 5450
Wire Wire Line
	5450 4825 5450 5550
$Comp
L Device:C C2
U 1 1 60C0DB55
P 3550 3050
F 0 "C2" H 3665 3096 50  0000 L CNN
F 1 "33pF" H 3665 3005 50  0000 L CNN
F 2 "RevK:C_0603" H 3588 2900 50  0001 C CNN
F 3 "~" H 3550 3050 50  0001 C CNN
	1    3550 3050
	0    1    -1   0   
$EndComp
$Comp
L power:GND #PWR010
U 1 1 60C0DB5B
P 3400 3050
F 0 "#PWR010" H 3400 2800 50  0001 C CNN
F 1 "GND" H 3405 2877 50  0000 C CNN
F 2 "" H 3400 3050 50  0001 C CNN
F 3 "" H 3400 3050 50  0001 C CNN
	1    3400 3050
	0    1    1    0   
$EndComp
Wire Wire Line
	3700 3050 4075 3050
Wire Wire Line
	4075 3050 4075 3150
Connection ~ 4075 3150
Wire Wire Line
	4075 3150 4175 3150
$Comp
L Device:Q_NMOS_GSD Q1
U 1 1 6105B478
P 8750 3275
F 0 "Q1" H 8955 3321 50  0000 L CNN
F 1 "NX7002AK" H 8955 3230 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 8950 3375 50  0001 C CNN
F 3 "https://www.mouser.co.uk/datasheet/2/916/NX7002AK-1360313.pdf" H 8750 3275 50  0001 C CNN
F 4 "Nexperia" H 8750 3275 50  0001 C CNN "Manufacturer"
F 5 "NX7002AK" H 8750 3275 50  0001 C CNN "Part No"
	1    8750 3275
	1    0    0    -1  
$EndComp
Connection ~ 8850 3075
$Comp
L Device:R R16
U 1 1 60A436C8
P 6975 3400
F 0 "R16" V 7050 3400 50  0000 C CNN
F 1 "324R" V 6975 3400 50  0000 C CNN
F 2 "RevK:R_0603" V 6905 3400 50  0001 C CNN
F 3 "~" H 6975 3400 50  0001 C CNN
	1    6975 3400
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR041
U 1 1 60A44FE5
P 7525 3200
F 0 "#PWR041" H 7525 3050 50  0001 C CNN
F 1 "+3.3V" V 7540 3328 50  0000 L CNN
F 2 "" H 7525 3200 50  0001 C CNN
F 3 "" H 7525 3200 50  0001 C CNN
	1    7525 3200
	0    1    1    0   
$EndComp
$Comp
L Device:LED_ARGB D5
U 1 1 60CF36BC
P 7325 3200
F 0 "D5" H 7325 3697 50  0000 C CNN
F 1 "RGB" H 7325 3606 50  0000 C CNN
F 2 "RevK:LED-RGB-1.6x1.6" H 7325 3150 50  0001 C CNN
F 3 "https://www.mouser.co.uk/datasheet/2/216/APTF1616LSEEZGKQBKC-786442.pdf" H 7325 3150 50  0001 C CNN
F 4 "Kingbright" H 7325 3200 50  0001 C CNN "Manufacturer"
F 5 "APTF1616LSEEZGKQBKC" H 7325 3200 50  0001 C CNN "Part No"
	1    7325 3200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R14
U 1 1 60CF9E4D
P 6975 3000
F 0 "R14" V 7050 3000 50  0000 C CNN
F 1 "732R" V 6975 3000 50  0000 C CNN
F 2 "RevK:R_0603" V 6905 3000 50  0001 C CNN
F 3 "~" H 6975 3000 50  0001 C CNN
	1    6975 3000
	0    1    1    0   
$EndComp
$Comp
L Device:R R15
U 1 1 60CFBFAF
P 6975 3200
F 0 "R15" V 7050 3200 50  0000 C CNN
F 1 "2K" V 6975 3200 50  0000 C CNN
F 2 "RevK:R_0603" V 6905 3200 50  0001 C CNN
F 3 "~" H 6975 3200 50  0001 C CNN
	1    6975 3200
	0    1    1    0   
$EndComp
Text GLabel 6825 3000 0    50   Input ~ 0
R
Text GLabel 6825 3200 0    50   Input ~ 0
G
Text GLabel 6825 3400 0    50   Input ~ 0
B
NoConn ~ -7400 375 
Text GLabel 2450 3175 2    50   Input ~ 0
R
Text GLabel 2450 3075 2    50   Input ~ 0
G
Text GLabel 2450 2975 2    50   Input ~ 0
B
NoConn ~ 2450 1875
$Comp
L RevK:LMR16006YQ3 U4
U 1 1 612D7C57
P 9850 1925
F 0 "U4" H 10350 2025 50  0000 L CNN
F 1 "LMR16006YQ3" H 9850 1525 50  0000 L CNN
F 2 "RevK:RegulatorBlock" H 10300 2025 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/lmr16006y-q1.pdf" H 10300 2025 50  0001 C CNN
F 4 "TI" H 9850 1925 50  0001 C CNN "Manufacturer"
F 5 "LMR16006YQ3" H 9850 1925 50  0001 C CNN "Part No"
F 6 "" H 9850 1925 50  0001 C CNN "Note"
	1    9850 1925
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden C9
U 1 1 612D7C58
P 10450 1925
F 0 "C9" H 10425 1925 50  0000 L CNN
F 1 "0.1uF" H 10975 1925 50  0000 R CNN
F 2 "RevK:Hidden" H 10450 1925 50  0001 C CNN
F 3 "" H 10450 1925 50  0001 C CNN
F 4 "X7R or X5R 0603" H 10450 1925 50  0001 C CNN "Note"
	1    10450 1925
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden C10
U 1 1 612D7C59
P 10450 2000
F 0 "C10" H 10425 2000 50  0000 L CNN
F 1 "2.2uF" H 10975 2000 50  0000 R CNN
F 2 "RevK:Hidden" H 10450 2000 50  0001 C CNN
F 3 "" H 10450 2000 50  0001 C CNN
F 4 "0603 or 0805" H 10450 2000 50  0001 C CNN "Note"
	1    10450 2000
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden C11
U 1 1 612D7C5A
P 10450 2075
F 0 "C11" H 10425 2075 50  0000 L CNN
F 1 "10uF" H 10975 2075 50  0000 R CNN
F 2 "RevK:Hidden" H 10450 2075 50  0001 C CNN
F 3 "" H 10450 2075 50  0001 C CNN
F 4 "0603 or 0805" H 10450 2075 50  0001 C CNN "Note"
	1    10450 2075
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden L1
U 1 1 612D7C5B
P 10450 2150
F 0 "L1" H 10425 2150 50  0000 L CNN
F 1 "6.8uH" H 10975 2150 50  0000 R CNN
F 2 "RevK:Hidden" H 10450 2150 50  0001 C CNN
F 3 "https://www.mouser.co.uk/datasheet/2/987/Laird_Performance_TYA4020_series__Rev_A_-1877538.pdf" H 10450 2150 50  0001 C CNN
F 4 "Laird" H 10450 2150 50  0001 C CNN "Manufacturer"
F 5 "TYA4020" H 10450 2150 50  0001 C CNN "Part No"
	1    10450 2150
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden D7
U 1 1 612D7C5C
P 10450 2225
F 0 "D7" H 10425 2225 50  0000 L CNN
F 1 "Schottky" H 10975 2225 50  0000 R CNN
F 2 "RevK:Hidden" H 10450 2225 50  0001 C CNN
F 3 "https://www.mouser.co.uk/datasheet/2/54/CD1206-B220_B2100-777245.pdf" H 10450 2225 50  0001 C CNN
F 4 "Bourns" H 10450 2225 50  0001 C CNN "Manufacturer"
F 5 "CD1206-B2100" H 10450 2225 50  0001 C CNN "Part No"
	1    10450 2225
	1    0    0    -1  
$EndComp
$Comp
L RevK:LMR16006YQ3 U5
U 1 1 610EE400
P 9900 3075
F 0 "U5" H 10400 3175 50  0000 L CNN
F 1 "LMR16006YQ3/Q5" H 9900 2675 50  0000 L CNN
F 2 "RevK:RegulatorBlock" H 10350 3175 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/lmr16006y-q1.pdf" H 10350 3175 50  0001 C CNN
F 4 "TI" H 9900 3075 50  0001 C CNN "Manufacturer"
F 5 "LMR16006YQ3" H 9900 3075 50  0001 C CNN "Part No"
F 6 "" H 9900 3075 50  0001 C CNN "Note"
	1    9900 3075
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden C12
U 1 1 610F9B88
P 10500 3075
F 0 "C12" H 10475 3075 50  0000 L CNN
F 1 "0.1uF" H 11025 3075 50  0000 R CNN
F 2 "RevK:Hidden" H 10500 3075 50  0001 C CNN
F 3 "" H 10500 3075 50  0001 C CNN
F 4 "X7R or X5R 0603" H 10500 3075 50  0001 C CNN "Note"
	1    10500 3075
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden C13
U 1 1 610FD0EF
P 10500 3150
F 0 "C13" H 10475 3150 50  0000 L CNN
F 1 "2.2uF" H 11025 3150 50  0000 R CNN
F 2 "RevK:Hidden" H 10500 3150 50  0001 C CNN
F 3 "" H 10500 3150 50  0001 C CNN
F 4 "0603 or 0805" H 10500 3150 50  0001 C CNN "Note"
	1    10500 3150
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden C14
U 1 1 610FD80E
P 10500 3225
F 0 "C14" H 10475 3225 50  0000 L CNN
F 1 "10uF" H 11025 3225 50  0000 R CNN
F 2 "RevK:Hidden" H 10500 3225 50  0001 C CNN
F 3 "" H 10500 3225 50  0001 C CNN
F 4 "0603 or 0805" H 10500 3225 50  0001 C CNN "Note"
	1    10500 3225
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden L2
U 1 1 610FE01A
P 10500 3300
F 0 "L2" H 10475 3300 50  0000 L CNN
F 1 "6.8uH" H 11025 3300 50  0000 R CNN
F 2 "RevK:Hidden" H 10500 3300 50  0001 C CNN
F 3 "https://www.mouser.co.uk/datasheet/2/987/Laird_Performance_TYA4020_series__Rev_A_-1877538.pdf" H 10500 3300 50  0001 C CNN
F 4 "Laird" H 10500 3300 50  0001 C CNN "Manufacturer"
F 5 "TYA4020" H 10500 3300 50  0001 C CNN "Part No"
	1    10500 3300
	1    0    0    -1  
$EndComp
$Comp
L RevK:Hidden D8
U 1 1 610FE5D2
P 10500 3375
F 0 "D8" H 10475 3375 50  0000 L CNN
F 1 "Schottky" H 11025 3375 50  0000 R CNN
F 2 "RevK:Hidden" H 10500 3375 50  0001 C CNN
F 3 "https://www.mouser.co.uk/datasheet/2/54/CD1206-B220_B2100-777245.pdf" H 10500 3375 50  0001 C CNN
F 4 "Bourns" H 10500 3375 50  0001 C CNN "Manufacturer"
F 5 "CD1206-B2100" H 10500 3375 50  0001 C CNN "Part No"
	1    10500 3375
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 3075 9900 3075
$EndSCHEMATC
