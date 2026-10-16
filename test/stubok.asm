; A binary for the CAS tests: BLOAD"CAS:",R loads it from tape and runs it. It
; reads the file after it on the tape through a stub built and used with the
; stub loader's own code (DESIGN.md, Loader cases): the same 35 bytes of
; build code, which set the stub's slots to the slot register AND FCh, so that
; each call has slot 0, the BIOS ROM, in page 0. The file is 16384 bytes in
; which byte N is (N + N / 256) mod 256. It prints STUB OK when every byte is
; right, or STUB BAD DATA otherwise. Without CASGO's change of the build code,
; the first call reaches the ROM's TAPION, which waits for a real tape.

CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)
STUB    equ 0FC9Ah      ; where the stub loader builds its stub
SIZE    equ 16384

        org 9000h

        ; The loader's entry: its caller's registers go to the alternate set,
        ; and FC8Eh-FCA5h, where its stack and stub go, onto the stack.
        di
        exx
        push bc
        push de
        push hl
        ld hl,0FCA6h
        ld b,0Ch
.save:
        dec hl
        ld d,(hl)
        dec hl
        ld e,(hl)
        push de
        djnz .save

        ; The build code, byte for byte: 7C 60 68 39 31 A4 FC 11 61 C9 D5 ...
        ; ... ED 60 A4 6F. HL is FC8Eh here.
        ld a,h          ; A = FCh, the mask for page 0
        ld h,b
        ld l,b
        add hl,sp       ; HL = the stack
        ld sp,0FCA4h    ; the stub: OUT (C),L / EXX / CALL 00E1h / EXX /
        ld de,0C961h    ; OUT (C),H / RET, pushed from its end
        push de
        ld de,0EDD9h
        push de
        ld de,00E1h
        push de
        ld de,0CDD9h
        push de
        ld de,069EDh
        push de
        push hl         ; the stack, kept below the stub
        exx
        ld c,0A8h       ; C, H and L stay in the main set for the stub
        in h,(c)
        and h
        ld l,a          ; L = the slots with slot 0 in page 0

        ; The data file: its identification block, then its data block, whose
        ; first 6 bytes are the BSAVE addresses.
        call STUB       ; TAPION
        jr c,bad
        ld a,0E4h
        ld (STUB+4),a   ; the call becomes TAPIN
        ld b,16
.skip1:
        call STUB
        jr c,bad
        djnz .skip1
        ld a,0E1h
        ld (STUB+4),a   ; TAPION
        call STUB
        jr c,bad
        ld a,0E4h
        ld (STUB+4),a
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
        ld (STUB+4),a   ; the call becomes STMOTR
        xor a
        call STUB

        ; The loader's exit: the stack, FC8Eh-FCA5h and the caller's registers
        ; back.
        exx
        pop hl
        ld sp,hl
        ld hl,0FC8Eh
        ld b,0Ch
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
        db "STUB OK",13,10,0
wrong:
        db "STUB BAD DATA",13,10,0
