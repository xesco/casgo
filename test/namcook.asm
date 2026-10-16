; A binary for the CAS tests: BLOAD"CAS:",R loads it from tape and runs it. It
; reads the block after it on the tape, 256 bytes in which byte N is N, through
; a copy of the routine with which one loader builds its tape calls at run time
; (DESIGN.md, Loader cases): the routine writes the low byte of
; a CALL 0000h and makes the call with the BIOS ROM in page 0. It prints
; NAMCO OK when every byte is right, or NAMCO BAD DATA otherwise. Without
; CASGO's change of the call's high byte, the call reaches the ROM's TAPION,
; which waits for a real tape.

CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)
DATA    equ 9C00h

        org 9000h

        call tapion
        jr c,bad
        ld hl,DATA
        ld b,0
.read:
        push bc
        push hl
        call tapin
        pop hl
        pop bc
        jr c,bad
        ld (hl),a
        inc hl
        djnz .read
        call stmotr
        ei
        ld hl,DATA
        ld b,0
.check:
        ld a,l
        cp (hl)
        jr nz,bad
        inc hl
        djnz .check
        ld hl,ok
        jr print
bad:
        ei
        ld hl,wrong
print:
        ld a,(hl)
        or a
        ret z
        call CHPUT
        inc hl
        jr print

; The loader's routine, byte for byte up to the call: one entry for each of
; TAPION, TAPIN and STMOTR, then the code that writes the call's low byte,
; puts the main ROM's slot 0 in page 0 and calls.
tapion:
        push af
        ld a,0E1h
        jr call_tape
tapin:
        push af
        ld a,0E4h
        jr call_tape
stmotr:
        push af
        ld a,0F3h
call_tape:
        ld (.call+1),a
        pop af
        push hl
        push af
        in a,(0A8h)
        push af
        and 0FCh
        out (0A8h),a    ; page 0: slot 0, the BIOS ROM
        pop hl          ; H = the slots before
        pop af
        push hl
.call:
        call 0000h
        pop hl
        push af
        ld a,h
        out (0A8h),a    ; the slots before
        pop af
        pop hl
        ret

ok:
        db "NAMCO OK",13,10,0
wrong:
        db "NAMCO BAD DATA",13,10,0
