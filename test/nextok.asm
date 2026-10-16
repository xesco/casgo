; A binary for the CAS tests: BLOAD"CAS:",R loads it from tape and runs it. It
; reads the block after it on the tape, a headerless block of 256 bytes, to
; NEXTB and runs it (test/nextb.asm). That block puts the BIOS ROM in page 0 and
; calls read, below, to read one more block, as Moonwalker's loader does: the
; tape calls are in this block, and the OUT (0A8h),A that makes them need the
; rewrite is in the next (docs/DESIGN.md, Loader cases). Without the rewrite,
; read's TAPION reaches the ROM's, which waits for a real tape.

TAPION  equ 00E1h       ; BIOS: find the next tape header (Red Book ch. 4)
TAPIN   equ 00E4h       ; BIOS: read a byte from tape (Red Book ch. 4)
TAPIOF  equ 00E7h       ; BIOS: stop reading the tape (Red Book ch. 4)
CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)
NEXTB   equ 9800h       ; where the next block runs

        org 9000h

        jr start

; Reads the next headerless block, BC bytes, to HL. Returns carry on a tape
; error. At 9002h, which test/nextb.asm calls. Keeps HL and BC across the tape
; calls, as test/im2ok.asm does.
read:
        push hl
        push bc
        call TAPION
        pop bc
        pop hl
        ret c
.loop:
        push hl
        push bc
        call TAPIN
        pop bc
        pop hl
        ret c
        ld (hl),a
        inc hl
        dec bc
        ld a,b
        or c
        jr nz,.loop
        call TAPIOF     ; enables interrupts
        or a            ; carry clear: read
        ret

start:
        ld hl,NEXTB
        ld bc,256
        call read
        jp nc,NEXTB
        ld hl,wrong
.print:
        ld a,(hl)
        or a
        ret z
        call CHPUT
        inc hl
        jr .print

wrong:
        db "NEXT BAD TAPE",13,10,0
