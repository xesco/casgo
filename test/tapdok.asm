; A binary for the CAS tests: BLOAD"CAS:",R loads it from tape and runs it. It
; reads the 256-byte block after it on the tape through TAPIN and checks, after
; each call, that D holds the byte as A does: the BIOS's TAPIN builds the byte in
; D, and Hydlide's loader compares its checksum with D (DESIGN.md, A load, step by step).
; It prints TAPIN D OK, or TAPIN D WRONG when D differs.

TAPION  equ 00E1h       ; BIOS: find the next tape header (Red Book ch. 4)
TAPIN   equ 00E4h       ; BIOS: read a byte from tape (Red Book ch. 4)
TAPIOF  equ 00E7h       ; BIOS: stop reading the tape (Red Book ch. 4)
CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)

        org 9000h

        call TAPION
        jr c,wrong
        ld b,0          ; 256 bytes
.read:
        push bc
        ld d,0FFh       ; not the byte: TAPIN must set D
        call TAPIN
        pop bc
        jr c,wrong
        cp d
        jr nz,wrong
        djnz .read
        call TAPIOF
        ld hl,ok
        jr print
wrong:
        call TAPIOF
        ld hl,bad
print:
        ld a,(hl)
        or a
        ret z
        call CHPUT
        inc hl
        jr print

ok:
        db "TAPIN D OK",13,10,0
bad:
        db "TAPIN D WRONG",13,10,0
