; A binary for the CAS tests: BLOAD"CAS:",R loads it from tape and runs it. It
; prints BIN OK when HIMEM is F380h, the top of memory of a machine without disk
; that CASGO's CLEAR sets, and BIN HIMEM WRONG otherwise.

CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)
HIMEM   equ 0FC4Ah      ; the top of BASIC's memory (Red Book ch. 6)

        org 9000h

        ld hl,(HIMEM)
        ld de,0F380h
        or a
        sbc hl,de
        ld hl,ok
        jr z,print
        ld hl,wrong
print:
        ld a,(hl)
        or a
        ret z
        call CHPUT
        inc hl
        jr print

ok:
        db "BIN OK",13,10,0
wrong:
        db "BIN HIMEM WRONG",13,10,0
