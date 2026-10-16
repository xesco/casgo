; A binary for the CAS tests: it prints PAGE1 OK. Its data holds the start of a search for RAM for page 1 alone, LD A,B /
; AND 30h / LD B,A / IN A,(0A8h) / AND 0F3h / SUB 04h,
; which makes the detector pick T on a machine with RAM in the internal RAM's
; page 0, and M elsewhere (DESIGN.md, Memory cases). The
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
        db "PAGE1 OK",13,10,0
code:
        db 78h, 0E6h, 30h, 47h, 0DBh, 0A8h, 0E6h, 0F3h, 0D6h, 04h
