5 ' 16x16フォントファイルを生成する
10 SCREEN 5,,0:COLOR 15,4,7:SET PAGE 0,0:CLS:DEFINT A-Z
12 I=0:SX=16:SY=16:W=INT(256/SX)*SX
15 _TURBO ON(I,SX,SY,W)
16 DEFINT A-Z
17 XX=0:YY=0
20 FOR Y=0 TO SY-1
30     READ A$
35     IF A$="END" THEN 990
40     FOR X=0 TO SX-1
50         IF MID$(A$,X+1,1)="1" THEN PSET(XX+X,YY+Y)
60     NEXT X
70 NEXT Y
80 I=I+1:XX=I*SX MOD W:Y1=I*SX:Y0=Y1/W:YY=Y0*SY
90 GOTO 20
990 IF INKEY$="" THEN 990
991 _TURBO OFF
992 I=I-1:Y1=I*SX:Y0=Y1/W:YY=Y0*SY
993 COPY(0,0)-(W-1,YY+SY-1) TO "font16.dat"
999 END
1000 ' 0
1010 DATA 0000000000000000
1020 DATA 0000111111100000
1030 DATA 0001000000010000
1040 DATA 0010000000001000
1050 DATA 0010000000001000
1060 DATA 0010000000001000
1070 DATA 0010000000001000
1080 DATA 0010000000001000
1090 DATA 0010000000001000
1100 DATA 0010000000001000
1110 DATA 0010000000001000
1120 DATA 0010000000001000
1130 DATA 0001000000010000
1140 DATA 0000111111100000
1150 DATA 0000000000000000
1160 DATA 0000000000000000
1200 ' 1
1210 DATA 0000000000000000
1220 DATA 0000000100000000
1230 DATA 0000001100000000
1240 DATA 0000010100000000
1250 DATA 0000000100000000
1260 DATA 0000000100000000
1270 DATA 0000000100000000
1280 DATA 0000000100000000
1290 DATA 0000000100000000
1300 DATA 0000000100000000
1310 DATA 0000000100000000
1320 DATA 0000000100000000
1330 DATA 0000000100000000
1340 DATA 0000000100000000
1350 DATA 0000000000000000
1360 DATA 0000000000000000
1400 ' 2
1410 DATA 0000000000000000
1420 DATA 0000111111100000
1430 DATA 0001000000010000
1440 DATA 0010000000001000
1450 DATA 0010000000001000
1460 DATA 0000000000001000
1470 DATA 0000000000010000
1480 DATA 0000000001100000
1490 DATA 0000000110000000
1500 DATA 0000001000000000
1510 DATA 0000010000000000
1520 DATA 0000100000000000
1530 DATA 0001000000000000
1540 DATA 0011111111111000
1550 DATA 0000000000000000
1560 DATA 0000000000000000
1600 ' 3
1610 DATA 0000000000000000
1620 DATA 0000111111100000
1630 DATA 0001000000010000
1640 DATA 0010000000001000
1650 DATA 0010000000001000
1660 DATA 0000000000001000
1670 DATA 0000000000010000
1680 DATA 0000011111100000
1690 DATA 0000000000010000
1700 DATA 0000000000001000
1710 DATA 0010000000001000
1720 DATA 0010000000001000
1730 DATA 0001000000010000
1740 DATA 0000111111100000
1750 DATA 0000000000000000
1760 DATA 0000000000000000
1800 ' 4
1810 DATA 0000000000000000
1820 DATA 0000000010000000
1830 DATA 0000000110000000
1840 DATA 0000001010000000
1850 DATA 0000001010000000
1860 DATA 0000010010000000
1870 DATA 0000010010000000
1880 DATA 0000100010000000
1890 DATA 0000100010000000
1900 DATA 0001000010000000
1910 DATA 0011111111111000
1920 DATA 0000000010000000
1930 DATA 0000000010000000
1940 DATA 0000000010000000
1950 DATA 0000000000000000
1960 DATA 0000000000000000
2000 ' 5
2010 DATA 0000000000000000
2020 DATA 0011111111111000
2030 DATA 0010000000000000
2040 DATA 0010000000000000
2050 DATA 0010000000000000
2060 DATA 0010000000000000
2070 DATA 0010000000000000
2080 DATA 0011111111100000
2090 DATA 0000000000010000
2100 DATA 0000000000001000
2110 DATA 0010000000001000
2120 DATA 0010000000001000
2130 DATA 0001000000010000
2140 DATA 0000111111100000
2150 DATA 0000000000000000
2160 DATA 0000000000000000
2200 ' 6
2210 DATA 0000000000000000
2220 DATA 0000111111100000
2230 DATA 0001000000000000
2240 DATA 0010000000000000
2250 DATA 0010000000000000
2260 DATA 0010000000000000
2270 DATA 0010000000000000
2280 DATA 0011111111100000
2290 DATA 0010000000010000
2300 DATA 0010000000001000
2310 DATA 0010000000001000
2320 DATA 0010000000001000
2330 DATA 0001000000010000
2340 DATA 0000111111100000
2350 DATA 0000000000000000
2360 DATA 0000000000000000
2400 ' 7
2410 DATA 0000000000000000
2420 DATA 0011111111111000
2430 DATA 0000000000010000
2440 DATA 0000000000100000
2450 DATA 0000000001000000
2460 DATA 0000000010000000
2470 DATA 0000000100000000
2480 DATA 0000000100000000
2490 DATA 0000000100000000
2500 DATA 0000000100000000
2510 DATA 0000000100000000
2520 DATA 0000000100000000
2530 DATA 0000000100000000
2540 DATA 0000000100000000
2550 DATA 0000000000000000
2560 DATA 0000000000000000
2600 ' 8
2610 DATA 0000000000000000
2620 DATA 0000111111100000
2630 DATA 0001000000010000
2640 DATA 0010000000001000
2650 DATA 0010000000001000
2660 DATA 0010000000001000
2670 DATA 0001000000010000
2680 DATA 0000111111100000
2690 DATA 0001000000010000
2700 DATA 0010000000001000
2710 DATA 0010000000001000
2720 DATA 0010000000001000
2730 DATA 0001000000010000
2740 DATA 0000111111100000
2750 DATA 0000000000000000
2760 DATA 0000000000000000
2800 ' 9
2810 DATA 0000000000000000
2820 DATA 0000111111100000
2830 DATA 0001000000010000
2840 DATA 0010000000001000
2850 DATA 0010000000001000
2860 DATA 0010000000001000
2870 DATA 0001000000001000
2880 DATA 0000111111111000
2890 DATA 0000000000001000
2900 DATA 0000000000001000
2910 DATA 0000000000001000
2920 DATA 0000000000001000
2930 DATA 0000000000010000
2940 DATA 0000111111100000
2950 DATA 0000000000000000
2960 DATA 0000000000000000
3000 ' +
3010 DATA 0000000000000000
3020 DATA 0000000000000000
3030 DATA 0000000100000000
3040 DATA 0000000100000000
3050 DATA 0000000100000000
3060 DATA 0000000100000000
3070 DATA 0000000100000000
3080 DATA 0011111111111000
3090 DATA 0000000100000000
3100 DATA 0000000100000000
3110 DATA 0000000100000000
3120 DATA 0000000100000000
3130 DATA 0000000100000000
3140 DATA 0000000000000000
3150 DATA 0000000000000000
3160 DATA 0000000000000000
3200 ' -
3210 DATA 0000000000000000
3220 DATA 0000000000000000
3230 DATA 0000000000000000
3240 DATA 0000000000000000
3250 DATA 0000000000000000
3260 DATA 0000000000000000
3270 DATA 0000000000000000
3280 DATA 0011111111111000
3290 DATA 0000000000000000
3300 DATA 0000000000000000
3310 DATA 0000000000000000
3320 DATA 0000000000000000
3330 DATA 0000000000000000
3340 DATA 0000000000000000
3350 DATA 0000000000000000
3360 DATA 0000000000000000
3400 ' ×
3410 DATA 0000000000000000
3420 DATA 0000000000000000
3430 DATA 0010000000001000
3440 DATA 0001000000010000
3450 DATA 0000100000100000
3460 DATA 0000010001000000
3470 DATA 0000001010000000
3480 DATA 0000000100000000
3490 DATA 0000001010000000
3500 DATA 0000010001000000
3510 DATA 0000100000100000
3520 DATA 0001000000010000
3530 DATA 0010000000001000
3540 DATA 0000000000000000
3550 DATA 0000000000000000
3560 DATA 0000000000000000
3600 ' ÷
3610 DATA 0000000000000000
3620 DATA 0000000000000000
3630 DATA 0000000100000000
3640 DATA 0000001110000000
3650 DATA 0000000100000000
3660 DATA 0000000000000000
3670 DATA 0000000000000000
3680 DATA 0111111111111100
3690 DATA 0000000000000000
3700 DATA 0000000000000000
3710 DATA 0000000100000000
3720 DATA 0000001110000000
3730 DATA 0000000100000000
3740 DATA 0000000000000000
3750 DATA 0000000000000000
3760 DATA 0000000000000000
3800 ' -
3810 DATA 0000000000000000
3820 DATA 0000000000000000
3830 DATA 0000000000000000
3840 DATA 0000000000000000
3850 DATA 0000000000000000
3860 DATA 0111111111111100
3870 DATA 0000000000000000
3880 DATA 0000000000000000
3890 DATA 0000000000000000
3900 DATA 0111111111111100
3910 DATA 0000000000000000
3920 DATA 0000000000000000
3930 DATA 0000000000000000
3940 DATA 0000000000000000
3950 DATA 0000000000000000
3960 DATA 0000000000000000
4000 ' +/-
4010 DATA 0000000000000000
4020 DATA 0000000000000100
4030 DATA 0001000000001000
4040 DATA 0001000000010000
4050 DATA 0111110000100000
4060 DATA 0001000001000000
4070 DATA 0001000010000000
4080 DATA 0000000100000000
4090 DATA 0000001000000000
4100 DATA 0000010000000000
4110 DATA 0000100001111100
4120 DATA 0001000000000000
4130 DATA 0010000000000000
4140 DATA 0100000000000000
4150 DATA 0000000000000000
4160 DATA 0000000000000000
4200 ' A
4210 DATA 0000000000000000
4220 DATA 0000000100000000
4230 DATA 0000001010000000
4240 DATA 0000010001000000
4250 DATA 0000100000100000
4260 DATA 0001000000010000
4270 DATA 0010000000001000
4280 DATA 0100000000000100
4290 DATA 0111111111111100
4300 DATA 0100000000000100
4310 DATA 0100000000000100
4320 DATA 0100000000000100
4330 DATA 0100000000000100
4340 DATA 0100000000000100
4350 DATA 0000000000000000
4360 DATA 0000000000000000
4400 ' C
4410 DATA 0000000000000000
4420 DATA 0001111111110000
4430 DATA 0010000000001000
4440 DATA 0100000000000100
4450 DATA 0100000000000000
4460 DATA 0100000000000000
4470 DATA 0100000000000000
4480 DATA 0100000000000000
4490 DATA 0100000000000000
4500 DATA 0100000000000000
4510 DATA 0100000000000000
4520 DATA 0100000000000100
4530 DATA 0010000000001000
4540 DATA 0001111111110000
4550 DATA 0000000000000000
4560 DATA 0000000000000000
9000 ' E
9010 DATA 0000000000000000
9020 DATA 0111111111111100
9030 DATA 0100000000000000
9040 DATA 0100000000000000
9050 DATA 0100000000000000
9060 DATA 0100000000000000
9070 DATA 0100000000000000
9080 DATA 0111111111110000
9090 DATA 0100000000000000
9100 DATA 0100000000000000
9110 DATA 0100000000000000
9120 DATA 0100000000000000
9130 DATA 0100000000000000
9140 DATA 0111111111111100
9150 DATA 0000000000000000
9160 DATA 0000000000000000
9200 ' R
9210 DATA 0000000000000000
9220 DATA 0111111111110000
9230 DATA 0100000000001000
9240 DATA 0100000000000100
9250 DATA 0100000000000100
9260 DATA 0100000000000100
9270 DATA 0100000000001000
9280 DATA 0111111111110000
9290 DATA 0100001000000000
9300 DATA 0100000100000000
9310 DATA 0100000010000000
9320 DATA 0100000001100000
9330 DATA 0100000000010000
9340 DATA 0100000000001100
9350 DATA 0000000000000000
9360 DATA 0000000000000000
9400 ' .
9410 DATA 0000000000000000
9420 DATA 0000000000000000
9430 DATA 0000000000000000
9440 DATA 0000000000000000
9450 DATA 0000000000000000
9460 DATA 0000000000000000
9470 DATA 0000000000000000
9480 DATA 0000000000000000
9490 DATA 0000000000000000
9500 DATA 0000000000000000
9510 DATA 0000000000000000
9520 DATA 0000000100000000
9530 DATA 0000001110000000
9540 DATA 0000000100000000
9550 DATA 0000000000000000
9560 DATA 0000000000000000
9600 ' (スペース)
9610 DATA 0000000000000000
9620 DATA 0000000000000000
9630 DATA 0000000000000000
9640 DATA 0000000000000000
9650 DATA 0000000000000000
9660 DATA 0000000000000000
9670 DATA 0000000000000000
9680 DATA 0000000000000000
9690 DATA 0000000000000000
9700 DATA 0000000000000000
9710 DATA 0000000000000000
9720 DATA 0000000000000000
9730 DATA 0000000000000000
9740 DATA 0000000000000000
9750 DATA 0000000000000000
9760 DATA 0000000000000000
9999 DATA END