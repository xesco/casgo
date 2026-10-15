; The stub case (docs/CASES.md, Stub loaders): one loader calls the tape
; through a stub that it builds in page 3, with the slots for the call computed
; as the slot register AND FCh, which puts the ROM in page 0. Stage 1 changes
; two bytes of the loader's code, so that the stub puts T0 in page 0.

; At the D5h or E5h byte at HL: notes the build sequence that ends there, the
; one of TAPION or of TAPOON, or the one with HL. Changes AF, BC and DE.
stub_check:
        ld de,stub_build
        call scan_compare
        jr z,.build
        ld de,stub_build_ea
        call scan_compare
        jr z,.build
        ld de,stub_build_hl
        call scan_compare
        ret nz
.build:
        ld bc,-7
        add hl,bc
        ld a,NOTE_BUILD
        jp pl_note

; At a build note: when IN A,(0A8h) / LD H,A / AND 0FCh / LD L,A follows the
; build sequence within 40 bytes, AND 0FCh becomes OR with T0's slot. Else,
; when the build code around it is the 35 bytes of the loader's family, LD A,H
; becomes LD A,(HL), which reads T0's slot at FC8Eh, and AND H becomes OR H.
stub_patch:
        ld c,8          ; C = the place to look at, after the build sequence
.find:
        push bc
        ld a,c
        ld hl,slots_code
        ld b,slots_code_size
        call pt_match
        pop bc
        jr z,.slots
        inc c
        ld a,c
        cp 40
        jr nz,.find
        jr .family
.slots:
        ld a,0F6h               ; AND 0FCh becomes OR T0's slot
        ld (pt_value),a
        ld a,c
        add a,3
        push bc
        call pt_write_x
        pop bc
        IF T0_IRAM
        ld a,(iram_slot)        ; T0 is in the internal RAM
        ELSE
        ld a,(RAMAD0)
        and 03h
        ENDIF
        ld (pt_value),a
        ld a,c
        add a,4
        jp pt_write_x
.family:
        ld hl,(pt_off)          ; the build code starts 15 bytes before
        ld de,15
        or a
        sbc hl,de
        ld a,(pt_off+2)
        sbc a,0
        ret c
        ld (pt_off),hl
        ld (pt_off+2),a
        ld hl,build_head
        xor a
        ld b,build_head_size
        call pt_match
        ret nz
        ld hl,build_tail        ; after the entry's low byte, E1h or EAh
        ld a,17
        ld b,build_tail_size
        call pt_match
        ret nz
        ld a,7Eh                ; LD A,H becomes LD A,(HL), (FC8Eh)
        ld (pt_value),a
        xor a
        call pt_write_x
        ld a,0B4h               ; AND H becomes OR H
        ld (pt_value),a
        ld a,33
        jp pt_write_x

; The loader's build code, 35 bytes from LD A,H to LD L,A, but for the entry's
; low byte at its 17th byte; and the slot code that other loaders use instead,
; IN A,(0A8h) / LD H,A / AND 0FCh / LD L,A.
build_head:
        db 7Ch, 60h, 68h, 39h, 31h, 0A4h, 0FCh, 11h, 61h, 0C9h, 0D5h, 11h
        db 0D9h, 0EDh, 0D5h, 11h
build_head_size equ $-build_head
build_tail:
        db 00h, 0D5h, 11h, 0D9h, 0CDh, 0D5h, 11h, 0EDh, 69h, 0D5h, 0E5h, 0D9h
        db 0Eh, 0A8h, 0EDh, 60h, 0A4h, 6Fh
build_tail_size equ $-build_tail
slots_code:
        db 0DBh, 0A8h, 67h, 0E6h, 0FCh, 6Fh
slots_code_size equ $-slots_code
