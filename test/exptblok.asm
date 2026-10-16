; A binary for the CAS tests (test/exptblok.bas): its data holds the restore of
; pages 1 and 0 that Satan's loader runs, LD H,40h / LD A,(0FCC2h) / CALL nn /
; LD H,00h / LD A,(0FCC1h), which reads EXPTBL's byte for slot 1 where it means
; the main ROM's slot. It prints EXPTBL OK when CASGO's BASIC case changed the
; first load to LD A,(0FCC1h), and EXPTBL NOT CHANGED otherwise
; (docs/DESIGN.md, Loader cases). The data never runs, and an OUT (0A8h),A
; in it makes the detector pick the BASIC case.

CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)

        org 9000h

        ld hl,ok
        ld a,(restore+3)        ; the low byte of the first load's address
        cp 0C1h
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
        db "EXPTBL OK",13,10,0
wrong:
        db "EXPTBL NOT CHANGED",13,10,0
restore:
        ld h,40h
        ld a,(0FCC2h)
        call enaslt
        ld h,00h
        ld a,(0FCC1h)
enaslt:
        out (0A8h),a
        ret
