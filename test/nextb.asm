; The block that test/nextok.asm reads and runs, 256 bytes, with no header of its
; own. It puts the main ROM in page 0 with OUT (0A8h),A and calls nextok's read
; to read the block after it: 256 bytes in which byte N is N. Then it puts the
; slots back and prints NEXT OK when every byte is right, or NEXT BAD DATA
; otherwise. It holds no tape call of its own, so only the rule that counts the
; block after a tape call's block makes CASGO rewrite nextok's calls.

CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)
EXPTBL  equ 0FCC1h      ; the main ROM's slot (Red Book ch. 6)
READ    equ 9002h       ; nextok's read
DATA    equ 9C00h

        org 9800h

        di
        in a,(0A8h)
        ld (saved),a
        and 0FCh
        ld b,a
        ld a,(EXPTBL)
        and 03h
        or b
        out (0A8h),a    ; page 0: the main ROM's primary slot
        ld hl,DATA
        ld bc,256
        call READ
        push af
        ld a,(saved)
        out (0A8h),a    ; the slots as they were
        pop af
        ld hl,wrong
        jr c,print
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
        ld hl,wrong
print:
        ld a,(hl)
        or a
        ret z
        call CHPUT
        inc hl
        jr print

saved:  db 0
ok:
        db "NEXT OK",13,10,0
wrong:
        db "NEXT BAD DATA",13,10,0

        ds 256 - ($ - 9800h), 0
