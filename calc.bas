10 ' 計算機
20 ' 初期化
30 CLEAR 200,&HDA00:DEFINT A-Z
40 BLOAD"calc.bin"
50 DEF USR3=&HDA00:DEF USR4=&HDA03:DEF USR5=&HDA06:DEF USR6=&HDA09:DEF USR7=&HDA0C:DEF USR8=&HDA0F
60 SCREEN 5,,0:COLOR 15,4,7:SET PAGE 0,1
70 ' フォントデータの読み込み
80 COPY "font12.dat" TO (0,0):' 12x16フォント(0123456789+-×÷=±ACER. )
90 COPY "font16.dat" TO (0,32):' 16x16フォント(0123456789+-×÷=±ACER. )
100 COPY "font8.dat" TO (0,64):' 8x8フォント(+-×÷ )
110 SET PAGE 0,0
120 ' 画面上のテンキーに対応するキー情報を初期化
130 _TURBO ON
140 DIM K(3,4)
150 X0=-1:Y0=-1:AN$="0":MS$=AN$:PF=0:VC=1:AF=0:CA=-1:MO=0:EQ=0:A=0:UP=1:TS=0:TT=&HDA1E
160 RESTORE 1710
170 FOR Y=0 TO 4
180     FOR X=0 TO 3
190         READ A$
200         IF A$<>"" THEN K(X,Y)=ASC(A$) ELSE K(X,Y)=0
210     NEXT X
220 NEXT Y
230 ' 画面表示
240 FOR Y=27 TO 211 STEP 37
250     FOR X = 0 TO 255 STEP 64
260         LINE (0,Y)-(255,Y)
270         LINE (X,27)-(X, 211)
280         READ A$
290         IF A$="" THEN GOTO 320
300         IF A$="AC" THEN GOSUB 580:GOTO 320
310         GOSUB 630
320     NEXT X
330 NEXT Y
340 ' キー入力&パッド入力
350 IF UP=1 THEN GOSUB 810:UP=0
360 MO=0
370 P=PAD(4)
380 A$=INKEY$
390 IF X0<>-1 AND USR8(TS)>30 THEN GOSUB 680:X0=-1
400 IF P<>0 THEN MO=1
410 IF A$<>"" THEN MO=2
420 IF MO=0 THEN 360
430 IF MO=1 THEN GOSUB 680:X0=PAD(5)/64:Y0=(PAD(6)-27)/37:A$=CHR$(K(X0,Y0)):TS=USR8(0):GOSUB 680
440 IF A$=CHR$(&H1B) THEN A$="c"
450 IF A$=CHR$(13) THEN A$="="
460 IF MO=2 THEN GOSUB 720:GOSUB 680
470 IF A$="" OR A$=CHR$(0) THEN 360
480 IF A$>="0" AND A$<="9" THEN GOSUB 1000:P$=AN$:GOSUB 1100:MS$=P$:UP=1:GOTO 350
490 IF A$="." AND PF=0 THEN PF=1:IF VC=1 THEN AN$="0.":VC=0:MS$=AN$:UP=1:GOTO 350 ELSE AN$=AN$+".":P$=AN$:GOSUB 1100:MS$=P$:UP=1:GOTO 350
500 IF A$="*" OR A$="/" OR A$="+" OR A$="-" THEN EQ=0:IF VC=0 THEN VC=1:GOSUB 1160:GOTO 350 ELSE GOSUB 1360:UP=1:GOTO 350
510 IF A$="c" THEN IF VC=0 THEN AN$="0":PF=0:VC=1:AF=0:MS$=AN$:UP=1:GOTO 350 ELSE AN$="0":PF=0:VC=1:CA=-1:V0#=0:AF=0:MS$=AN$:UP=1:GOTO 350
520 IF A$="=" THEN EQ=1:VC=1:GOSUB 1160:GOTO 350
530 IF A$="!" THEN GOSUB 1440:P$=AN$:GOSUB 1100:MS$=P$:UP=1:GOTO 350
540 IF A$="q" THEN 1680
550 GOTO 350
560 ' "AC"を描画
570 ' x,y:テンキーの座標(4x5)
580 COPY(0,48)-STEP(15,15),1 TO (X+16,Y+10):COPY(16,48)-STEP(15,15),1 TO (X+32,Y+10)
590 RETURN
600 ' テンキーの文字を描画
610 ' x,y:テンキーの座標(4x5)
620 ' a:描画するこのプログラム内での文字コード
630 A=VAL(A$):XX=A*16 MOD 256:Y1=A*16:Y2=Y1/256:YY=Y2*16+32:COPY(XX,YY)-STEP(15,15),1 TO (X+24,Y+10)
640 RETURN
650 ' ボタンの反転描画
660 ' x0,y0:テンキーの座標(4x5)
670 ' x0==-1の時はなにもしない。
680 IF X0=-1 THEN RETURN
690 LINE(X0*64+1,Y0*37+27)-STEP(62,35),15,BF,XOR
700 RETURN
710 ' キーチェック
720 KK=ASC(A$)
730 FOR Y=0 TO 4
740     FOR X=0 TO 3
750         IF K(X,Y)=KK THEN GOSUB 680:X0=X:Y0=Y:TS=USR8(0)
760     NEXT X
770 NEXT Y
780 RETURN
790 ' 値を表示するエリアを再描画
800 ' ms$:描画する文字列
810 L=LEN(MS$)
820 SX=240-L*12:LINE(0,0)-(SX-1,26),4,BF
830 FOR I=1 TO L
840     C=ASC(MID$(MS$,I,1))
850     IF C=&H45 THEN X=216:Y=0:GOTO 920
860     IF C=&H52 THEN X=228:Y=0:GOTO 920                   
870     IF C>=&H30 THEN X=(C-&H30)*12:Y=0:GOTO 920
880     IF C=&H2B THEN X=120:Y=0:GOTO 920
890     IF C=&H2D THEN X=132:Y=0:GOTO 920
900     IF C=&H2E THEN X=240:Y=0:GOTO 920
910     IF C=&H20 THEN X=0:Y=16:GOTO 920
920     COPY(X,Y)-STEP(11,15),1 TO (SX, 4)
930     SX=SX+12
940 NEXT I
950 IF CA=-1 THEN B=32 ELSE B=CA*8
960 COPY(B,64)-STEP(7,7),1 TO (244,12)
970 RETURN
980 ' an$に入力した数値を追加する
990 ' a$:追加する数値or少数点
1000 IF EQ=1 THEN CA=-1:EQ=0
1010 IF VC=1 THEN AN$=A$:AF=1:IF A$="0" THEN VC=1:GOTO 1070 ELSE VC=0:GOTO 1070
1020 LL=LEN(AN$):MM$=MID$(AN$,1,1)
1030 IF LL=14 AND MM$<>"-" THEN 1070
1040 IF LL=15 AND MM$="-" THEN 1070
1050 AN$=AN$+A$
1060 AF=1
1070 RETURN
1080 ' 少数点で始まる場合、前に0を追加する
1090 ' P$:数値の文字列
1100 IF MID$(P$,1,1)=" " THEN P$=MID$(P$,2)
1110 IF MID$(P$,1,1)="-" THEN SP$="-":P$=MID$(P$,2) ELSE SP$=""
1120 IF MID$(P$,1,1)="." THEN P$="0"+P$
1130 P$=SP$+P$:RETURN
1140 ' 演算処理
1150 'IF AF=1 THEN AN#=VAL(AN$)
1160 IF AF=1 THEN POKE TT,0:P=USR3(VARPTR(AN$))
1170 EF=0:' エラーフラグ
1180 'IF CA=-1 THEN V0#=AN# ELSE IF A$<>"=" AND AF=0 THEN GOSUB 1340 ELSE GOSUB 1260
1190 IF CA=-1 THEN P=USR4(1) ELSE IF A$<>"=" AND AF=0 THEN GOSUB 1360 ELSE GOSUB 1340
1200 VC=1:PF=0:AF=0
1210 IF EF=1 THEN MS$="ERR":UP=1:RETURN
1220 IF A$<>"=" THEN GOSUB 1360
1230 'P$=STR$(V0#):GOSUB 1130:AN$=P$:MS$=P$:UP=1
1240 POKE TT,1:P=USR5(VARPTR(P$)):GOSUB 1100:AN$=P$:MS$=P$:UP=1
1250 RETURN
1260 'ON ERROR GOTO 9270
1270 'IF CA=0 THEN V0#=V0#+AN#:GOTO 1310
1280 'IF CA=1 THEN V0#=V0#-AN#:GOTO 1310
1290 'IF CA=2 THEN V0#=V0#*AN#:GOTO 1310
1300 'IF CA=3 THEN V0#=V0#/AN#:GOTO 1310
1310 'ON ERROR GOTO 0
1320 'RETURN
1330 'EF=1:RESUME NEXT
1340 P=USR6(CA):IF P=-1 THEN EF=1
1350 RETURN
1360 IF A$="+" THEN CA=0:RETURN
1370 IF A$="-" THEN CA=1:RETURN
1380 IF A$="*" THEN CA=2:RETURN
1390 IF A$="/" THEN CA=3:RETURN
1400 CA=-1
1410 RETURN
1420 ' 符号反転の処理("!"を押した時)
1430 'IF AF=1 THEN AN#=VAL(AN$)
1440 IF AF=1 THEN POKE TT,0:P=USR3(VARPTR(AN$))
1450 'IF VC=1 THEN V0#=V0#*-1:AN$=STR$(V0#):RETURN
1460 IF VC=1 THEN P=USR7(1):POKE TT,1:P=USR5(VARPTR(AN$)):RETURN
1470 'IF VC=0 THEN AN#=AN#*-1:VC=1:PF=0:AF=0:IF CA=-1 THEN V0#=AN#
1480 IF VC=0 THEN P=USR7(0):VC=1:PF=0:AF=0:IF CA=-1 THEN P=USR4(1)
1490 'IF AN#=0 THEN RETURN
1500 POKE TT,0:P=USR5(VARPTR(BB$)):IF BB$=" 0" THEN RETURN
1510 IF MID$(AN$,1,1)="-" THEN AN$=MID$(AN$,2) ELSE AN$="-"+AN$
1520 RETURN
1530 ' デバッグ用にグラフィック画面に文字を表示
1540 ST=&H1BBF
1550 FOR I=1 TO LEN(P$)
1560     CH=ASC(MID$(P$,I,1))
1570     FOR YY=0 TO 7
1580         P=ST+CH*8+YY
1590         CC=PEEK(P):M=&H80
1600         FOR XX=0 TO 7
1610             IF (CC AND M)=M THEN PSET(X+XX,Y+YY),15 ELSE PSET(X+XX,Y+YY),4
1620             M=M/2
1630         NEXT XX
1640     NEXT YY
1650     X=X+8
1660 NEXT I
1670 RETURN
1680 _TURBO OFF
1690 END
1700 ' キーマッピングのデータ
1710 DATA "c","!","","/"
1720 DATA "7","8","9","*"
1730 DATA "4","5","6","-"
1740 DATA "1","2","3","+"
1750 DATA "0",".","","="
1760 ' テンキー描画文字データ
1770 DATA "AC",15,"",13 :' AC !   /
1780 DATA 7,8,9,12      :'  7 8 9 *
1790 DATA 4,5,6,11      :'  4 5 6 -
1800 DATA 1,2,3,10      :'  1 2 3 +
1810 DATA 0,20,"",14    :'  0 .   =