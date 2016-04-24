*-----------------------------------------------------------
*Command Interpreter
*-----------------------------------------------------------
INTERPRETER     MOVEM.L A0-A7/D0-D7,-(SP)  ; save registers to stack 
                
                LEA     INPUTBUFFER,A1      ; initialize pointer to command input
                MOVEA.L A1,A0               ; copy pointer to A0
                ADDA.L  D1,A1               ; add length of input in D1 to A1, initialize pointer to end of command input
                CLR.L   D2                      
                CLR.L   D3                  ; character counter
                 
                LEA     HELPPTR,A4          ; initialize pointer to string table
                LEA     HELPHDLR,A5         ; initialize pointer to jump table
NEXT            LEA     INPUTBUFFER,A3      ; initialize pointer to command input
                JSR     COMPARESTRING       ; jump to comparestring subroutine
                
                CMPI.B  #1,D4               ; check if strings match flag in D4
                BEQ     HDLRJMP             ; if strings match, jump to handler
                ADDA.W  #4,A5               ; increment jump table pointer to next handler
                CMP.W   #NOCMD,A5           ; check if at end of jump table
                BEQ     ERROR               ; branch to error message 
                BRA     NEXT                ; branch to next command in string table
                
HDLRJMP         MOVE.L  (A5),A6             ; move address in jump table to A6
                JSR     (A6)                ; jump to command subroutine located at memory address specified by A6
                   
                MOVEM.L (SP)+,A0-A7/D0-D7   ; restore registers from stack

                RTS                         ; return from subroutine
                
ERROR           LEA     ERRORMSG,A1         ; load error message into A1
                MOVE.B  #14,D0              ; trap task #14 in D0, Display the NULL terminated string at (A1) without CR, LF.
                TRAP    #15                 ; execute trap #15
                BRA     NEXTCMD             ; branch to NEXTCMD in MAIN program




*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
