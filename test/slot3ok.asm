; A binary for the CAS tests: it prints SLOT3 OK. Its data holds LD A,0FFh /
; OUT (0A8h),A / LD HL,9000h / LD DE,1000h, a copy into page 0 of slot 3 after
; it puts slot 3 in every page, which makes the detector pick R, or M on a
; machine without internal RAM (docs/DESIGN.md, Memory cases). The
; bytes never run.

CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)

        org 9000h

        ld hl,ok
print:
        ld a,(hl)
        or a
        ret z
        call CHPUT
        inc hl
        jr print

ok:
        db "SLOT3 OK",13,10,0
copy:
        db 3Eh, 0FFh, 0D3h, 0A8h, 21h, 00h, 90h, 11h, 00h, 10h
