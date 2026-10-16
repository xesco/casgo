; A binary for the CAS tests: BLOAD"CAS:",R loads it from tape and runs it. It
; reads the file after it on the tape through a stub built as Space Harrier
; II's loader builds it (DESIGN.md, Loader cases): with LD HL,nn / PUSH HL,
; and with the slots for each call computed by IN A,(0A8h) / LD H,A / AND 0FCh /
; LD L,A, which put slot 0, the BIOS ROM, in page 0. The file is 16384 bytes
; in which byte N is (N + N / 256) mod 256. It prints STUB HL OK when every
; byte is right, or STUB HL BAD DATA otherwise. Without CASGO's change of the
; AND 0FCh, the first call reaches the ROM's TAPION, which waits for a real
; tape.

CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)
STUB    equ 0FC98h      ; where this loader builds its stub
CALL_LO equ STUB+6      ; the low byte of the stub's CALL
KEEP_SP equ 0FC96h      ; where the loader keeps its stack pointer
SIZE    equ 16384

        org 9000h

        ; The loader's entry: its caller's registers go to the alternate set,
        ; and FC8Ch-FCA5h, where its stub goes, onto the stack.
        di
        exx
        push bc
        push de
        push hl
        ld hl,0FCA6h
        ld b,0Dh
.save:
        dec hl
        ld d,(hl)
        dec hl
        ld e,(hl)
        push de
        djnz .save

        ; The build code: the stub LD C,0A8h / OUT (C),L / EXX / CALL 00E1h /
        ; EXX / OUT (C),H / RET, pushed from its end.
        ld (KEEP_SP),sp
        ld sp,0FCA4h
        ld hl,0C961h
        push hl
        ld hl,0EDD9h
        push hl
        ld hl,00E1h
        push hl
        ld hl,0CDD9h
        push hl
        ld hl,069EDh
        push hl
        ld hl,0A80Eh
        push hl
        dec sp
        dec sp
        exx
        in a,(0A8h)
        ld h,a
        and 0FCh
        ld l,a          ; L = the slots with slot 0 in page 0

        ; The data file: its identification block, then its data block, whose
        ; first 6 bytes are the BSAVE addresses.
        call STUB       ; TAPION
        jr c,bad
        ld a,0E4h
        ld (CALL_LO),a  ; the call becomes TAPIN
        ld b,16
.skip1:
        call STUB
        jr c,bad
        djnz .skip1
        ld a,0E1h
        ld (CALL_LO),a  ; TAPION
        call STUB
        jr c,bad
        ld a,0E4h
        ld (CALL_LO),a
        ld b,6
.skip2:
        call STUB
        jr c,bad
        djnz .skip2

        ld de,0         ; DE = the byte's number
.read:
        call STUB
        jr c,bad
        sub e
        sub d           ; 0 when the byte is (E + D) mod 256
        jr nz,bad
        inc de
        ld a,d
        cp SIZE >> 8
        jr nz,.read
        ld de,ok
        jr done
bad:
        ld de,wrong
done:
        ld (message),de
        ld a,0F3h
        ld (CALL_LO),a  ; the call becomes STMOTR
        xor a
        call STUB

        ; The loader's exit: the stack, FC8Ch-FCA5h and the caller's registers
        ; back.
        exx
        ld sp,(KEEP_SP)
        ld hl,0FC8Ch
        ld b,0Dh
.restore:
        pop de
        ld (hl),e
        inc hl
        ld (hl),d
        inc hl
        djnz .restore
        pop hl
        pop de
        pop bc
        exx
        ei
        ld hl,(message)
.print:
        ld a,(hl)
        or a
        ret z
        call CHPUT
        inc hl
        jr .print

message:
        dw 0
ok:
        db "STUB HL OK",13,10,0
wrong:
        db "STUB HL BAD DATA",13,10,0
