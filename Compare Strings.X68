*-----------------------------------------------------------
* Compare Strings
* INPUT: (A3) = STRING 1, (A4) = STRING 2
* OUTPUT: D4=1 IF STRINGS MATCH, ELSE D4=0
*-----------------------------------------------------------
COMPARESTRING   MOVEM.L A0-A2/A5-A7/D0-D3/D5-D7,-(SP)
                CLR.L   D4
                
                CMP.B   #NULL,(A3)
                BEQ     START
                
COMPARELOOP     CMPI.B  #SP,(A3)
                BEQ     COMPARELIST
                
                CMPI.B  #CR,(A3)
                BEQ     COMPARELIST
                
                CMPI.B  #NULL,(A3)
                BEQ     COMPARELIST
                
                CMPM.B  (A3)+,(A4)+
                BEQ     COMPARELOOP
                
                JSR     NULLJMP
                MOVE.B  #0,D4
                MOVEM.L (SP)+,A0-A2/A5-A7/D0-D3/D5-D7
                RTS     
                
COMPARELIST     CMPI.B  #NULL,(A4)+
                BEQ     MATCH
                
                MOVE.B  #0,D4
                BRA     RETURN
                
MATCH           MOVE.B  #1,D4
                
RETURN          MOVEM.L (SP)+,A0-A2/A5-A7/D0-D3/D5-D7
                RTS

NULLJMP         MOVEM.L A0-A3/A5-A7/D0-D7,-(SP)
NULLLOOP        CMPI.B  #NULL,(A4)+
                BNE     NULLLOOP
                MOVEM.L (SP)+,A0-A3/A5-A7/D0-D7
                RTS
*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
