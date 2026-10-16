; A binary for the CAS tests (test/pardok.bas): it puts the main ROM in page 0
; and returns to BASIC, as A-Team's loader does. BASIC's next BLOAD then reads
; the tape with the ROM in page 0, unless CASGO's hook H.PARD puts T0 back
; (docs/DESIGN.md, Loader cases).

EXPTBL  equ 0FCC1h      ; the main ROM's slot (Red Book ch. 6)

        org 9000h

        di
        in a,(0A8h)
        and 0FCh
        ld b,a
        ld a,(EXPTBL)
        and 03h
        or b
        out (0A8h),a    ; page 0: the main ROM's primary slot
        ei
        ret
