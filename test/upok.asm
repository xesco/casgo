; A binary for the CAS tests: it prints UP OK. Its data holds an OUT (0A8h),A
; and a search for RAM for page 0 from slot 0 up, XOR A / LD (nn),A / LD E,A /
; LD D,00h / LD HL,0FCC1h / ADD HL,DE / BIT 7,(HL). The OUT makes the detector
; pick I when the internal RAM's slot is above the mapper's, and the search makes
; it pick R when it is below (docs/DESIGN.md, Memory cases). The bytes never run.

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
        db "UP OK",13,10,0
search:
        db 0D3h, 0A8h
        db 0AFh, 32h, 00h, 0A0h, 5Fh, 16h, 00h, 21h, 0C1h, 0FCh, 19h, 0CBh, 7Eh
