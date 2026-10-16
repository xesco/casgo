; A binary for the CAS tests: it reads the slot register and shifts the value
; right four times with SRA A, as Level 9's loader does to move the slots of
; pages 2 and 3 to pages 0 and 1, then writes the register back unchanged and
; prints SHIFT OK. The shifts make the detector pick R, where an OUT (0A8h),A
; without a read of EXPTBL alone would make it pick I
; (DESIGN.md, Memory cases).

CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)

        org 9000h

        di
        in a,(0A8h)
        ld c,a
        sra a
        sra a
        sra a
        sra a
        ld a,c
        out (0A8h),a    ; the slot register as it was
        ei
        ld hl,ok
print:
        ld a,(hl)
        or a
        ret z
        call CHPUT
        inc hl
        jr print

ok:
        db "SHIFT OK",13,10,0
