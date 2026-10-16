; A binary for the CAS tests: it prints SYDNEY OK. Its data holds the start of
; the Sydney engine's search for RAM for page 1, IN A,(0A8h) / AND 0F3h /
; PUSH AF / AND 30h / LD B,A / POP AF / SUB 04h, which makes the detector pick
; the mapper case, M, on any machine (docs/DESIGN.md, Memory cases).
; The bytes never run.

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
        db "SYDNEY OK",13,10,0
search:
        db 0DBh, 0A8h, 0E6h, 0F3h, 0F5h, 0E6h, 30h, 47h, 0F1h, 0D6h, 04h
