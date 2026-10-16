; A binary for the CAS tests (test/slotsok.bas): it restores pages 0 and 1 as
; Capitan Sevilla's and Freddy Hardest's loaders do, with its own ENASLT and
; LD A,(nn) / LD HL,0000h / CALL enaslt / LD HL,4000h / CALL enaslt, which
; gives the second call the A that the first left: the slot register. On a
; cassette machine page 0 holds the ROM in slot 0, and that A puts slot 0 in
; page 1 too. Under CASGO page 0 holds T0, and without CASGO's change of the
; second call page 1 gets T0's slot instead of the BASIC ROM, and BASIC
; crashes on the return (DESIGN.md, Loader cases).

PSLOT   equ 0A8h        ; primary slot register (Red Book ch. 1)
EXPTBL  equ 0FCC1h      ; which slots are expanded (Red Book ch. 6)
SLTTBL  equ 0FCC5h      ; each slot's subslot register (Red Book ch. 6)

        org 9000h

        di
        ; page0 = page 0's slot, as ENASLT takes it: F000SSPP
        in a,(PSLOT)
        and 03h
        ld c,a
        ld b,0
        ld hl,EXPTBL
        add hl,bc
        ld a,(hl)
        and 80h
        jr z,.plain
        or c
        ld e,a
        ld hl,SLTTBL
        add hl,bc
        ld a,(hl)
        and 03h         ; page 0's subslot
        rlca
        rlca
        or e
        ld c,a
.plain:
        ld a,c
        ld (page0),a

        ld a,(page0)
        ld hl,0000h
        call enaslt
        ld hl,4000h
        call enaslt     ; A is the slot register that the first call left
        ei
        ret

; Puts slot A, F000SSPP, in the page of address H, as the BIOS's ENASLT does,
; and returns the slot register in A, as the loaders' copies of it do. Keeps
; no register; uses no stack while page 3 shows another slot.
enaslt:
        ld b,a          ; B = the slot
        ld a,h
        rlca
        rlca
        and 03h
        ld e,a          ; E = the page
        ld a,b
        rrca
        rrca
        and 03h
        ld l,a          ; L = the subslot
        ld a,b
        and 03h
        ld d,a          ; D = the primary slot
        ld h,03h        ; H = the page's two bits
        ld a,e
        or a
        jr z,.shifted
.shift:
        sla h
        sla h
        sla l
        sla l
        sla d
        sla d
        dec e
        jr nz,.shift
.shifted:
        bit 7,b
        jr z,.primary
        in a,(PSLOT)
        ld e,a          ; E = the slot register
        ld a,b
        rrca
        rrca
        and 0C0h
        ld c,a
        ld a,e
        and 3Fh
        or c
        out (PSLOT),a   ; page 3: the slot, whose subslot register is FFFFh
        ld a,(0FFFFh)
        cpl
        ld c,a
        ld a,h
        cpl
        and c
        or l
        ld (0FFFFh),a
        ld a,e
        out (PSLOT),a   ; page 3 as it was
.primary:
        in a,(PSLOT)
        ld c,a
        ld a,h
        cpl
        and c
        or d
        out (PSLOT),a
        ret

page0:  db 0
