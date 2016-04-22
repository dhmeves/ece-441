*-----------------------------------------------------------
* Main Program
*-----------------------------------------------------------
START:                  ; first instruction of program
                MOVEM.L A0-A7/D0-D7,-(SP)
                MOVE    SR,-(SP)
                MOVE.L  SP,A2
                LEA     PROMPT,A1
                MOVE.B  #14,D0
                TRAP    #15
        
                LEA     INPUTBUFFER,A2
                MOVE.L  #79,D2
CLRINBUF        CLR.B   (A2)+
                DBRA    D2,CLRINBUF

                LEA     CMDBUFFER,A3
                MOVE.L  #79,D3
CLRCMDBUF       CLR.B   (A3)+
                DBRA    D3,CLRCMDBUF  
        
                LEA     INPUTBUFFER,A1
                MOVE.B  #2,D0
                TRAP    #15
                
                MOVE    (SP)+,SR
                MOVEM.L (SP)+,A0-A7/D0-D7
                JSR     INTERPRETER
                
                BRA     START

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
