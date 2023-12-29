; calc.basでべーしっ君用のコードで倍精度実数演算ができないので
; それを補うためのサブルーチンたち
;
; 倍精度実数を保存するエリアとしてVAR_ANとVAR_v0を用意している。
; それらのエリアを変数をこのコード内の説明では呼ぶことにする。

RSLREG:     equ 0x0138
ENASLT:     equ 0x0024
CALBAS:     equ 0x0159
;
VALTYP:     equ 0xf663
EXPTBL:     equ 0xfcc1
SLTTBL:     equ 0xfcc5
HERRO:      equ 0xffb1
JIFFY:      equ 0xfc9e
; Math-pack
FIN:		equ 0x3299	; 文字列を実数に変換してDACに代入する。
FOUT:       equ 0x3425
DECADD:     equ 0x269a
DECSUB:     equ 0x268c
DECMUL:     equ 0x27e6
DECDIV:     equ 0x289f
DAC:        equ 0xf7f6
ARG:        equ 0xf847
FRCDBL:		equ 0x303a	; DACを倍精度実数に変換する。

            org 0xda00

            SECTION code_user

            ; ジャンプテーブル
            jp USR3
            jp USR4
            jp USR5
            jp USR6
            jp USR7
			jp USR8
			ret
			ds 2
			ret
			ds 2
			ret
			ds 2
			ret
			ds 2
TARGET:     db 0            ; VAR_AN:0、VAR_V0
ERRNO:      db 0
VAR_AN:     ds 8            ; AN#変数のかわり
VAR_V0:     ds 8            ; V0#変数のかわり
CALC_TBL:   dw DECADD
            dw DECSUB
            dw DECMUL
            dw DECDIV
BK_HERRO:   ds 5

; 文字列で表した実数を変数に代入(べーしっ君専用)
;
; 形式
;       p=USR3(varptr(a$))
;       
;       文字列で表した実数を倍精度実数に変換して変数に代入する。
;       TARGETに0を指定するとVAR_AN、1を指定するとVAR_V0に代入する。
;
; 戻り値
;       0:成功、-1:失敗
;
USR3:
		cp 2
		jp nz,ERR_RET0

		; 現在のページ1のスロット情報を取得
		call GET_PAGE1_SLOT
		push af
		; ページ1をMAIN ROMに切り替える
		push hl
		ld a,(EXPTBL)
		ld hl,0x4000
		call ENASLT
		pop hl

		inc hl
		inc hl
		push hl
		ld e,(hl)
		inc hl
		ld d,(hl)       ; deには文字列の文字数部分のアドレス

		ex hl,de
		ld b,0
		ld c,(hl)       ; 文字数を取得(bcにいれる)
		inc hl          ; hlは字列の先頭アドレス
		push hl

		add hl,bc
		ld (hl),0
		pop hl

		ld ix,FIN
		call CALBAS

		ld ix,FRCDBL
		call CALBAS

		ld a,(TARGET)
		call GET_TARGET_ADDR
		ex de,hl

		ld hl,DAC
		ld bc,8
		ldir

		pop hl
		call OK_RET

		; ページ1のスロットを元に戻す
		pop af
		ld hl,0x4000
		call ENASLT

		ret


; 変数間の値のコピー
;
; 形式
;       p=USR4(v)
;
;       vは整数値で0のとき、VAR_V0の値をVAR_ANにコピーする。
;       1のとき、VAR_ANの値をVAR_V0にコピーする。
;       ※vの値チェックは正確に行っていないので注意
; 戻り値
;       0:成功、-1:失敗
USR4:
		cp 2
		jp nz,ERR_RET0

		inc hl
		inc hl
		push hl
		ld a,(hl)       ; aに引数の値を取得

		or a

		ld hl,VAR_V0
		ld de,VAR_AN

		jr z,VAR_COPY

		ex de,hl
VAR_COPY:
		ld bc,8
		ldir

		pop hl

		jp OK_RET

; 変数値を文字列に変換して代入(べーしっ君専用)
;
; 形式
;       p=USR5(varptr(a$))
;
;       TARGETで指定した変数の値を文字列に変換して文字列変数にコピーする。
;       TARGETに0を指定するとVAR_ANの値、1を指定するとVAR_V0の値を変換する。
;
; 戻り値
;       0:成功、-1:失敗
USR5:
		cp 2
		jp nz,ERR_RET0

		; 現在のページ1のスロット情報を取得
		call GET_PAGE1_SLOT
		push af

		push hl
		inc hl
		inc hl
		ld e,(hl)
		inc hl
		ld d,(hl)
		push de

		; ページ1をMAIN ROMに切り替える
		ld a,(EXPTBL)
		ld hl,0x4000
		call ENASLT

		ld a,(TARGET)
		call GET_TARGET_ADDR

		ld de,DAC
		ld bc,8
		ldir

		ld a,8
		ld (VALTYP),a
		ld ix,FOUT
		call CALBAS

		pop de
		push de
		inc de
		ld c,0
LOOP:   ld a,(hl)
		ld (de),a
		inc hl
		inc de
		inc c
		or a
		jr nz,LOOP
		pop hl

		dec c
		ld (hl),c

		pop hl
		call OK_RET

		; ページ1のスロットを元に戻す
		pop af
		ld hl,0x4000
		call ENASLT

		ret

; VAR_V0=VAR_V0 ? VAR_ANを実行する。
;
; 形式
;       p=USR6(c)
;
;       VAR_V0=VAR_V0 ? VAR_ANを実行する。
;       ?は引数cで演算方法を指定する。(0:+、1:-、2:*、3:/)
; 戻り値
;       0:成功、0以外:エラー番号
USR6:
		cp 2
		jp nz,ERR_RET0

		; 現在のページ1のスロット情報を取得
		call GET_PAGE1_SLOT
		push af

		push hl
		inc hl
		inc hl
		ld e,(hl)
		inc hl
		ld d,(hl)
		push de

		; ページ1をMAIN ROMに切り替える
		ld a,(EXPTBL)
		ld hl,0x4000
		call ENASLT

		ld hl,VAR_V0
		ld de,DAC
		ld bc,8
		ldir

		ld hl,VAR_AN
		ld de,ARG
		ld bc,8
		ldir

		ld a,8
		ld (VALTYP),a

		pop de

		rlc e
		ld hl,CALC_TBL
		add hl,de
		ld e,(hl)
		inc hl
		ld d,(hl)
		push de

		xor a
		ld (ERRNO),a
		call HOOK_ERR
		pop ix
		call CALBAS
		call UNHOOK_ERR

		ld a,(ERRNO)
		or a
		jp nz,USR6_ERR_RET

		ld hl,DAC
		ld de,VAR_V0
		ld bc,8
		ldir

		pop hl
		call OK_RET

USR6_RET:
		; ページ1のスロットを元に戻す
		pop af
		ld hl,0x4000
		call ENASLT

		ret

USR6_ERR_RET:
		pop hl
		call ERR_RET0
		jr USR6_RET

HOOK_ERR:
		ld hl,HERRO
		ld de,BK_HERRO
		ld bc,5
		ldir

		ld a,0xc3
		ld (HERRO),a

		ld hl,ERR_FUNC
		ld (HERRO+1),hl

		ret
UNHOOK_ERR:
		ld hl,BK_HERRO
		ld de,HERRO
		ld bc,5
		ldir
		ret

ERR_FUNC:
		ld a,e
		ld (ERRNO),a
		pop hl
		ret
; 符号反転
;
; 形式
;       p=USR7(v)
;
;       vは整数値で0のとき、VAR_V0の値をVAR_ANを対象に符号反転を
;       行う。
;       ※vの値チェックは正確に行っていないので注意
; 戻り値
;       0:成功、-1:失敗
USR7:
		cp 2
		jp nz,ERR_RET0

		inc hl
		inc hl
		push hl

		ld a,(hl)
		call GET_TARGET_ADDR

		ld a,(hl)
		or a
		jp z,USR7_RET

		xor 0x80
		ld (hl),a

USR7_RET:
		pop hl
		jp OK_RET

; 現在のページ1のスロット情報の取得
GET_PAGE1_SLOT:
		push hl
		push bc
		push de
		; 現在のページ1の基本スロット番号を取り出す
		call RSLREG
		rrca
		rrca
		and 0x03
		ld c,a          ;cレジスタに基本スロット番号を待避

		; 取得した基本スロット番号のスロットが拡張されているか調べる
		ld hl,EXPTBL
		add a,l
		ld l,a
		ld a,(hl)
		and 0x80        ; aレジスタにスロットが拡張されているかどうかのフラグがセットされる
		ld b,a          ; bレジスタにスロット拡張情報を待避

		; ページ1の拡張スロット番号を取り出す。
		ld a,c
		ld hl,SLTTBL
		add a,l
		ld l,a
		ld a,(hl)
		and 0x0c
		
		; スロット切り換えで使うデータを生成する。
		add a,c
		add a,b

		pop de
		pop bc
		pop hl

		ret
; JIFFY値との差分を返す.
;
; 形式
;		p=USR8(v)
;
;		JIFFY-vの値を返す。
; 戻り値
;		JIFFYとの差分値
USR8:
		cp 2
		jp nz,ERR_RET0

		inc hl
		inc hl
		push hl
		ld e,(hl)
		inc hl
		ld d,(hl)

		ld hl,(JIFFY)
		xor a
		sbc hl,de
		ex de,hl
		
		pop hl
		jr RET_DE

ERR_RET1:
		ld de,0xffff
		jr RET_DE
OK_RET:
		ld de,0
		jr RET_DE
ERR_RET0:
		ld de,0xffff
		inc hl
		inc hl
RET_DE:
		ld (hl),e
		inc hl
		ld (hl),d
		
		ld a,2
		ld (VALTYP),a
		ret

; TARGETで指定された変数のアドレスを取得
;
;		a:変数の番号(0:VAR_AN,1:VAR_V0)
;
; 戻り値
;		hl:変数のアドレス
GET_TARGET_ADDR:
		push af
		push de
		rlca
		rlca
		rlca
		ld hl,VAR_AN
		ld d,0
		ld e,a
		add hl,de
		pop de
		pop af
		ret