*-----------------------------------------------------------
*Command Interpreter
*-----------------------------------------------------------
INTERPRETER     MOVEM.L A0-A7/D0-D7,-(SP)  ; commented out to allow .D and .A command passthrough

                *MOVE.L  SP,A2 
                
                LEA     INPUTBUFFER,A1      ; pointer to command input
                MOVEA.L A1,A0
                ADDA.L  D1,A1               ; pointer to end of command input
                CLR.L   D2
                CLR.L   D3                  ; character counter
                 
                LEA     HELPPTR,A4          ; pointer to string table
                LEA     HELPHDLR,A5         ; pointer to jump table
NEXT            LEA     INPUTBUFFER,A3
                JSR     COMPARESTRING
                
                CMPI.B  #1,D4
                BEQ     HDLRJMP
                ADDA.W  #4,A5
                CMP.W   #NOCMD,A5
                BEQ     ERROR
                BRA     NEXT
                
HDLRJMP         MOVE.L  (A5),A6
                JSR     (A6)
                   
                MOVEM.L (SP)+,A0-A7/D0-D7  ; commented out to allow .D and .A command passthrough

                RTS
                
ERROR           LEA     ERRORMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                BRA     NEXTCMD



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
