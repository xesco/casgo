; A binary for the CAS tests: it prints LEVEL9 OK. Its data holds Level 9's
; search for RAM, IN A,(0A8h) / AND E / LD B,A / LD A,D / AND (HL) / OR B /
; OUT (0A8h),A, which makes the detector pick T on a machine with RAM in the
; internal RAM's page 0, and M elsewhere (DESIGN.md, Memory cases).
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
        db "LEVEL9 OK",13,10,0
search:
        db 0DBh, 0A8h, 0A3h, 47h, 7Ah, 0A6h, 0B0h, 0D3h, 0A8h
