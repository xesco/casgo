; A tokenized BASIC program for the CAS tests, as CSAVE writes it (Red Book
; ch. 5): each line is a link to the next line, the line number, the tokens and
; a zero; a zero link ends the program. It is assembled for 8001h, the start of
; BASIC's program text, so that the link is right; CLOAD loads it there.
;
;   10 PRINT"BAS OK"

PRINT   equ 91h         ; the PRINT token (Red Book ch. 5)

        org 8001h

line10:
        dw end_of_program
        dw 10
        db PRINT,34,"BAS OK",34,0
end_of_program:
        dw 0
