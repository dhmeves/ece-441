*-------------------------------------------------------------------------
* CLEAR SCREEN
*-------------------------------------------------------------------------
CLEAR       MOVEM.L A0-A7/D0-D7,-(SP)

            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15            
            
            MOVEM.L (SP)+,A0-A7/D0-D7
            RTS
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
