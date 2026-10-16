; A binary for the CAS tests: it prints PAGE21 OK. Its data holds code that puts page 2's slot in page 1, IN A,(0A8h) /
; LD C,A / SRL A / SRL A / AND 0Ch / OR C,
; which makes the detector pick T on a machine with RAM in the internal RAM's
; page 0, and M elsewhere (docs/DESIGN.md, Memory cases). The
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
        db "PAGE21 OK",13,10,0
code:
        db 0DBh, 0A8h, 4Fh, 0CBh, 3Fh, 0CBh, 3Fh, 0E6h, 0Ch, 0B1h
