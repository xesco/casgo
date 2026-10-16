; A binary for the CAS tests: BLOAD"CAS:",R loads it from tape and runs it. In
; interrupt mode 2, with its table in page 3, it reads the file that follows it
; on the tape, 16384 bytes in which byte N is (N + N / 256) mod 256, and prints
; IM2 OK when every byte is right, or IM2 BAD DATA otherwise.
;
; TAPIN leaves interrupts off, so the frame interrupts wait for the next refill,
; where DOS enables them: there they test the DOS gate's interrupt table
; (docs/DESIGN.md, A load, step by step). A pause after each byte makes each
; refill come at least one frame after the one before, so an interrupt waits for
; each.

CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)
TAPION  equ 00E1h       ; BIOS: find the next tape header (Red Book ch. 4)
TAPIN   equ 00E4h       ; BIOS: read a byte from tape (Red Book ch. 4)
TAPIOF  equ 00E7h       ; BIOS: stop reading the tape (Red Book ch. 4)

TABLE   equ 0D000h      ; the mode 2 table: 257 bytes of D1h, so every vector
JUMP    equ 0D1D1h      ; is D1D1h, where a jump leads to the BIOS's handler
SIZE    equ 16384

        org 9000h

        di
        ld hl,TABLE
        ld (hl),JUMP & 0FFh
        ld de,TABLE+1
        ld bc,256
        ldir
        ld a,0C3h       ; JP
        ld (JUMP),a
        ld hl,0038h
        ld (JUMP+1),hl
        ld a,TABLE >> 8
        ld i,a
        im 2

        ; The data file: its identification block, then its data block, whose
        ; first 6 bytes are the BSAVE addresses.
        call TAPION
        jr c,bad
        ld b,16
        call skip
        jr c,bad
        call TAPION
        jr c,bad
        ld b,6
        call skip
        jr c,bad

        ld de,0         ; DE = the byte's number
.read:
        push de
        call TAPIN      ; changes BC and DE (Red Book 1ABCh)
        pop de
        jr c,bad
        ld c,a
        ld a,e
        add a,d
        cp c
        jr nz,bad
        ld b,25         ; the pause: about 330 cycles
.pause:
        djnz .pause
        inc de
        ld a,d
        cp SIZE >> 8
        jr nz,.read
        ld hl,ok
        jr done
bad:
        ld hl,wrong
done:
        di
        im 1
        call TAPIOF     ; enables interrupts
.print:
        ld a,(hl)
        or a
        ret z
        call CHPUT
        inc hl
        jr .print

; Reads and drops B bytes. Returns carry set at the end of the file.
skip:
        push bc
        call TAPIN
        pop bc
        ret c
        djnz skip
        ret

ok:
        db "IM2 OK",13,10,0
wrong:
        db "IM2 BAD DATA",13,10,0
