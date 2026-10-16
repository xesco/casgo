; A binary for the CAS tests: it prints MODULE OK. Its data holds the end of the
; slot module's copy of ENASLT, LD B,A / POP AF / AND A / RET, followed by
; CALL 0138h, which makes the detector pick the mapper case, M, on any machine
; (docs/DESIGN.md, Memory cases). The bytes never
; run.

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
        db "MODULE OK",13,10,0
module:
        db 47h, 0F1h, 0A7h, 0C9h, 0CDh, 38h, 01h
