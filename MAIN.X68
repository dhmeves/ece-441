*-----------------------------------------------------------
* Main Program
*-----------------------------------------------------------
START:                  ; first instruction of program
                MOVE    SR,-(SP)
                MOVEM.L A0-A7/D0-D7,-(SP)
                MOVE.L  SP,SSPDATA
                MOVE.L  SP,SSPDATA2
                MOVE.L  SP,A2
                MOVE.W  64(A2),SRDATA
                MOVE.W  64(A2),SRDATA2
PCLABEL         MOVE.L  #PCLABEL,PCDATA
                MOVE.L  #PCLABEL,PCDATA2
                MOVE    USP,A3
                MOVE.L  A3,USPDATA
                MOVE    USP,A3
                MOVE.L  A3,USPDATA2
                
                *MOVE.L $005001,A1            ;ADDRESS ERROR
                *MOVE.W  #$AA,(A1)
                
                *MOVE.W  #$4000,SR           ;PRIVILEGE VIOLATION
                
                *MOVE.L  #0,D1               ;DIVIDE BY ZERO
                *DIVU    D1,D0
                
NEXTCMD         LEA     PROMPT,A1
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
                
                *MOVEM.L (SP)+,A0-A7/D0-D7
                *MOVE    (SP)+,SR
                JSR     INTERPRETER
                
                BRA     NEXTCMD






*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
