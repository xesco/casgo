; A binary for the CAS tests: it prints DOWN OK. Its data holds a search for RAM
; for page 0 from slot 3 down, LD A,03h / LD (nn),A / LD E,A / LD D,00h /
; LD HL,0FCC1h / ADD HL,DE / BIT 7,(HL), which makes the detector pick R when the
; internal RAM's slot is above the mapper's, and I when it is below
; (docs/DESIGN.md, Memory cases). The bytes never run.

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
        db "DOWN OK",13,10,0
search:
        db 3Eh, 03h, 32h, 00h, 0A0h, 5Fh, 16h, 00h, 21h, 0C1h, 0FCh, 19h, 0CBh, 7Eh
