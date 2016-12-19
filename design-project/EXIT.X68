*-----------------------------------------------------------
* EXIT (Exit Monitor Program) - The EXIT command terminates/exits your Monitor program.
*
*
*
*-----------------------------------------------------------
EXIT        MOVEM.L A0-A7/D0-D7,-(SP)

*            LEA     INPUTBUFFER,A0
*            ADDA.W  #5,A0
*EXITONLY    ADDA.W  #1,A0 
*            ADD.B   #1,D4
*            CMP.B   #3,D4
*            BGE     PRTEXIT
*            CMP.B   #SP,(A0)
*            BEQ     EXITONLY
*            CMP.B   #NULL,(A0)
*            BEQ     EXITONLY
*            BRA     EXITCONT
            
*PRTEXIT     LEA     EXITMSG,A1
*            MOVE.B  #14,D0
*            TRAP    #15
*            BRA     EXITDONE

*EXITCONT    
            MOVE.B  #9,D0
            TRAP    #15
        
EXITDONE    MOVEM.L (SP)+,A0-A7/D0-D7
            RTS
*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
