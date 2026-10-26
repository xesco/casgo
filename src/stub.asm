; The stub case: a loader, used by many Erbe, Dro and Topo tapes, that calls the
; tape through a stub it builds in page 3, with the slot register AND FCh, which
; puts the ROM in page 0. Stage 1 changes two bytes of the loader, so that the
; stub puts T0 in page 0 instead.

; At the D5h or E5h byte at HL: notes a stub build sequence ending there.
; Changes AF, BC and DE.
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

; At a build note: when IN A,(0A8h) / LD H,A / AND 0FCh / LD L,A follows within
; 40 bytes, AND 0FCh becomes OR T0's slot. Otherwise, when the build code is the
; loader family's 35 bytes, LD A,H becomes LD A,(HL), which reads T0's slot at
; FC8Eh, and AND H becomes OR H.
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
        IF MEM_R
        call stub_call_case
        jr nc,.slots_value
        ld a,c
        add a,3                 ; AND 0FCh / LD L,A becomes CALL stub_l
        ld hl,stub_l
        jp stub_call
.slots_value:
        ENDIF
        call stub_value
        push af
        ld a,0F6h               ; AND 0FCh becomes OR T0's slot
        jr nc,.or_n
        ld a,0EEh               ; or XOR stub_value's value
.or_n:
        ld (pt_value),a
        ld a,c
        add a,3
        push bc
        call pt_write_x
        pop bc
        pop af
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
        IF MEM_R
        call stub_call_case
        jr nc,.family_value
        xor a                   ; LD L,A becomes NOP
        ld (pt_value),a
        ld a,34
        call pt_write_x
        ld a,31                 ; IN H,(C) / AND H becomes CALL stub_hl
        ld hl,stub_hl
        jp stub_call
.family_value:
        ENDIF
        ld a,7Eh                ; LD A,H becomes LD A,(HL), (FC8Eh)
        ld (pt_value),a
        xor a
        call pt_write_x
        call stub_value
        ld a,0B4h               ; AND H becomes OR H
        jr nc,.or_h
        ld a,0ACh               ; or XOR H
.or_h:
        ld (pt_value),a
        ld a,33
        jp pt_write_x

; Returns in A the value that the stub's slot code combines with the slot
; register for the stub's page 0, with carry when that combination is an XOR
; and no carry when it is an OR: T0's slot, or in R stub_value_r's value
; (iram.asm).
stub_value:
        IF T0_IRAM
        ld a,(iram_slot)        ; T0 is in the internal RAM
        or a
        ret
        ELSEIF MEM_R
        jp stub_value_r
        ELSE
        ld a,(RAMAD0)
        and 03h
        ret
        ENDIF

        IF MEM_R
; Returns carry when the loader must call stub_l or stub_hl (entries.asm) for
; its stub's page 0: in R, when the internal RAM's slot is below T0's, the
; mapper's, and the CAS file holds no search from slot 0 up. Page 0 then shows
; the ROM or the internal RAM when the loader builds its stub, and neither an OR
; nor an XOR with one value gives T0's slot for both. Keeps BC and HL.
stub_call_case:
        ld a,(stub_up)
        or a
        ret nz                  ; no carry: stub_value's XOR
        ld a,(RAMAD0)
        and 03h
        push bc
        ld b,a
        ld a,(iram_slot)
        cp b                    ; carry when the internal RAM's slot is below
        pop bc
        ret

; Writes CALL HL over the 3 bytes A places after pt_off, and notes in
; stub_called that stage 2 keeps the routine.
stub_call:
        push hl
        ld b,a
        ld a,1
        ld (stub_called),a
        ld a,b
        ld a,0CDh               ; CALL
        ld (pt_value),a
        ld a,b
        push bc
        call pt_write_x
        pop bc
        pop hl
        ld a,l
        ld (pt_value),a
        inc b
        ld a,b
        push bc
        push hl
        call pt_write_x
        pop hl
        pop bc
        ld a,h
        ld (pt_value),a
        inc b
        ld a,b
        jp pt_write_x

; At the 7Eh of a BIT 7,(HL) at HL: sets stub_up when the search for RAM from
; slot 0 up ends there (search_up_bytes, patterns.asm). Changes AF, BC and DE.
up_check:
        ld de,search_up_bytes
        ld b,(search_up_bytes_end-search_up_bytes)/2
.byte:
        push hl
        ld a,(de)               ; the byte's place before HL
        inc de
        ld c,a
        ld a,l
        sub c
        ld l,a
        ld a,h
        sbc a,0
        ld h,a
        ld a,(de)               ; its value
        inc de
        cp (hl)
        pop hl
        ret nz
        djnz .byte
        ld a,1
        ld (stub_up),a
        ret
        ENDIF

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
