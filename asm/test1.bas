10 clear 200,&hdd00:defint a-z
20 bload "strbuf.bin"
30 def usr0=&hdd00:def usr1=&hdd03:def usr2=&hdd06
40 p=usr0(0):print hex$(p)
50 p=usr0(1):print hex$(p)
60 p=usr0(2):print hex$(p)
70 p=usr0(3):print hex$(p)
80 p=usr0(4):print hex$(p)
90 p=usr0(2):poke p,23:p=usr0(-1):print p
100 a$="123":p=usr0(a$):print p
110 p=usr0(2):p=usr1(a$):print peek(p);":";hex$(peek(p+1));":";hex$(peek(p+2));":";hex$(peek(p+3))
120 _turbo on
130 a$="4567":p=usr0(3):p1=usr1(varptr(a$))
140 print peek(p);":";hex$(peek(p+1));":";hex$(peek(p+2));":";hex$(peek(p+3));":"hex$(peek(p+4))
150 _turbo off
160 a$="67890":p=USR0(0):p=usr1(a$)
170 _turbo on
180 p=usr2(varptr(b$)):print b$
190 b$="1234567890":p=usr1(varptr(b$))
200 _turbo off
210 l=usr0(-1):c$=space$(l):p=usr2(c$):print chr$(34);c$;chr$(34)