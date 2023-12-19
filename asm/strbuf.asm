; べーしっ君と通常のBASICとの間で文字列をやり取るするためのバッファ
            org 0xdd00

            SECTION code_user

VALTYP:     equ 0xf663

            jp USR0
            jp USR1
            jp USR2
;;;;;
; 整数値(n:0〜3)を指定してバッファを選択する
;
; 形式
; p=USR0(n)
;
;       バッファを選択する。バッファは256バイトで
;       最初の1バイトが文字数で2バイト目から文字列を
;       格納するエリアになる。そのバッファを4個用意してある。
; 戻り値
;       バッファのアドレス
;;;;;;
; バッファにコピーされた文字列のサイズ取得
;
; p=USR0(-1)
;
;       選択しているバッファの文字列の文字数を取得する。
;
; 戻り値
;       文字数
USR0:
        cp 2
        jp nz, ERR_RET0

        inc hl
        inc hl
        push hl
        ld a,(hl)
        inc hl
        ld d,(hl)
        and d
        xor 0xff
        pop hl
        jp z,GET_SIZE       ; -1なら、サイズを返す

        push hl
        inc hl
        ld a,(hl)
        or a
        pop hl
        jp nz,ERR_RET1        ; 上位バイトが0以外なら終了

        ld a,(hl)
        and 0xfc
        jp nz,ERR_RET1          ; 下位バイトが4以上なら終了
        
        ld a,(hl)
        ld (BUF_NUM),a      ; バッファ番号を保存
        ;
        push hl

        call GET_ADDR

        ex de,hl            ; バッファのアドレスを帰す。
        pop hl
        ld (hl),e
        inc hl
        ld (hl),d
        ret

GET_SIZE:
        push hl
        call GET_ADDR
        ld a,(hl)
        pop hl
        ld (hl),a
        inc hl
        ld (hl),0
        ret


; バッファのアドレスを帰す。
;
; 戻り値
; hl:バッファの先頭アドレス
GET_ADDR:
        push af
        push de
        ld hl,STR_BUF0
        ld a,(BUF_NUM)
        ld d,a
        ld e,0
        add hl,de
        pop de
        pop af
        ret

ERR_RET0:
        inc hl
        inc hl
ERR_RET1:
        ld a,2
        ld (VALTYP),a
        ld a,0xff
        ld (hl),a
        inc hl
        ld (hl),a
        ret

OK_RET:
        ld a,2
        ld (VALTYP),a
        xor a
        ld (hl),a
        inc hl
        ld (hl),a
        ret


;;;;;
; 文字列をバッファにコピー(通常BASIC専用)
;
; 形式
; p$=USR1(a$)
;
;       指定した文字列変数に格納されている文字列を文字列バッファにコピーする。
;
; 戻り値
;       なし
;
;;;;;
; 文字列をバッファにコピー(べーしっ君専用)
;
; 形式
; p=USR1(varptr(a$))
;
;       指定した文字列変数に格納されている文字列を文字列バッファにコピーする。
;
; 戻り値
;       なし
;
USR1:
        cp 2
        jp z,ARG_INT1
        cp 3
        jp z,ARG_STR1
        ret

ARG_INT1:
        inc hl
        inc hl
        push hl
        ld e,(hl)
        inc hl
        ld d,(hl)       ; deには文字列の文字数部分のアドレス

        ex hl,de
        ld b,0
        ld c,(hl)       ; 文字数を取得(bcにいれる)
        inc hl          ; hlはコピー元の文字列の先頭アドレス
        push hl
        ; コピー先のバッファのアドレスを算出
STR_COPY1:
        call GET_ADDR

        ; バッファの先頭に文字数を書き込む
        ld (hl),c
        inc hl          ; hlはコピー先の文字列の先頭アドレスになる
        ; 文字列をコピーする。
        ex de,hl        ; deがコピー先のアドレス
        pop hl          ; hlがコピー元のアドレス
        ldir
        pop hl
        call OK_RET
        ret

ARG_STR1:
        inc hl
        inc hl
        push hl

        ex de,hl
        ld b,0
        ld c,(hl)
        inc hl
        ld e,(hl)
        inc hl
        ld d,(hl)       ; de:コピー元の文字列の先頭アドレス
        ex de,hl
        push hl
        jp STR_COPY1

;;;;;
; バッファから文字列にコピー(通常BASIC専用)
;
; 形式
; p=USR1(a$)
;
;       バッファ中の文字列を指定した文字列変数にコピーする。
;       文字列変数にはバッファに格納されている文字数以上の
;       文字列が代入されている必要がある。そこに上書き
;       コピーされる。サイズチェックは行わない
;
; 戻り値
;       なし
;
;;;;;
; バッファから文字列にコピー(べーしっ君専用)
;
; 形式
; p=USR1(varptr(a$))
;
;       バッファ中の文字列を文字列変数にコピーする。
;
; 戻り値
;       なし
;
USR2:
        cp 2
        jp z,ARG_INT2
        cp 3
        jp z,ARG_STR2
        ret

ARG_INT2:        
        inc hl
        inc hl
        push hl

        ld e,(hl)
        inc hl
        ld d,(hl)       ; deにはコピー先の文字列の文字数部分のアドレス
        
        call GET_ADDR
                        ;de:コピー先、hl:コピー元
        ld a,(hl)
        ld (de),a
        ld b,0
        ld c,a
        inc hl
        inc de
        ldir

        pop hl
        call OK_RET
        ret

ARG_STR2:
        inc hl
        inc hl
        push hl

        ex de,hl
        inc hl
        ld e,(hl)
        inc hl
        ld d,(hl)

        call GET_ADDR

        ld b, 0
        ld c,(hl)
        inc hl
        ldir
        
        pop hl
        call OK_RET
        ret

BUF_NUM:
        db 0        ; 使用するバッファ番号を格納する
STR_BUF0:
        db 0
