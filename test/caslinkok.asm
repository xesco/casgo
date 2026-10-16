; A binary for the CAS tests, laid out as a part of a CasLink3 tape: JP 9030h,
; the start of the ROM image at 9007h, and the image's start through a reset,
; LDIR / POP AF / AND 0FCh / OUT (0A8h),A / RST 30h and five 0 bytes. CASGO
; changes the reset into CALL 006Fh and a jump to the start (docs/DESIGN.md,
; Loader cases), which prints CASLINK OK; the reset would boot the machine
; again.

CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)

        org 9000h

        jp part
        dw 0, 0
        dw start        ; 9007h: the start of the ROM image

        ds 9030h-$
part:
        in a,(0A8h)
        push af
        ld hl,scratch
        ld de,scratch
        ld bc,1         ; LDIR copies one byte onto itself
        ldir
        pop af
        and 0FCh
        out (0A8h),a
        rst 30h
        db 0, 0, 0, 0, 0

start:
        ld hl,ok
print:
        ld a,(hl)
        or a
        ret z
        call CHPUT
        inc hl
        jr print

ok:
        db "CASLINK OK",13,10,0
scratch:
        db 0
