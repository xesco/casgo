; A binary for the CAS tests (test/hookok.bas): it puts RET in every hook, as
; Don Quijote's loader does, H.PARD among them, then puts the ROM in pages 0
; and 1 with IN A,(0A8h) / AND 0F0h / OUT (0A8h),A, as Don Quijote's SCREEN
; file does. BASIC's next BLOAD then reads the tape with the ROM in page 0,
; unless CASGO's change of that sequence puts T0 there
; (DESIGN.md, Loader cases).

HOOKS   equ 0FD9Ah      ; the hooks, FD9Ah-FFC9h (Red Book ch. 6)

        org 9000h

        di
        ld hl,HOOKS
        ld de,HOOKS+1
        ld bc,0FFCAh-HOOKS-1
        ld (hl),0C9h
        ldir
        in a,(0A8h)
        and 0F0h
        out (0A8h),a    ; pages 0 and 1: slot 0, the main ROM
        ei
        ret
