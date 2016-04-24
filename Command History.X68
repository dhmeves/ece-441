*--------------------------------------------------------------------------
* Command History
*--------------------------------------------------------------------------
HISTORY         MOVEM.L A0-A7/D0-D7,-(SP)

                JSR     ARGV
                LEA     CMDBUFFER,A0
                ADDA.W  #INDEX,A0
                
                JSR     CHKDOLLAR
                CMP.B   #1,D2
                BEQ     HISTORYDONE
                MOVE.L  (A4),D3

                LEA     HISTORYBUFFER,A1
                CLR.L   D4
                
NEXTHISTORY     ADD.B   #1,D4
                MOVE.B  #13,D0
                TRAP    #15
                
                CMP.B   D3,D4
                BEQ     HISTORYDONE
                
                CMP.B   #NULL,(A1)
                BNE     INCPOINTER
                BRA     HISTORYDONE
                
INCPOINTER      CMP.B   #NULL,(A1)+
                BEQ     NEXTHISTORY
                BRA     INCPOINTER         

HISTORYDONE     MOVEM.L (SP)+,A0-A7/D0-D7
                RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
