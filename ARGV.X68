*-----------------------------------------------------------
* ARGV Command Line Parsing Subroutine
* Stores Commands separated by INDEX (12) in memory starting at CMDBUFFER
* D2 = # of Arguments
*-----------------------------------------------------------

ARGV        MOVEM.L A0-A7/D0-D1/D3-D7,-(SP)

            LEA     INPUTBUFFER,A0
            LEA     CMDBUFFER,A1
            LEA     CMDBUFFER,A2
            CLR.L   D2
            CLR.L   D3
CHECKLOOP   MOVE.B  (A0),(A1)+
            CMP.B   #SINGLEQUOTE,(A0)
            BEQ     QUOTEFOUND
            CMP.B   #DOUBLEQUOTE,(A0)
            BEQ     QUOTEFOUND
FLAGCHK     CMP.B   #1,D3
            BEQ     NULLCHK
            CMPI.B  #SP,(A0)
            BEQ     SPFOUND
NULLCHK     CMPI.B  #NULL,(A0)+
            BEQ     NULLFOUND
            BRA     CHECKLOOP
            
QUOTEFOUND  ADD.L   #1,D3
            ANDI.B  #1,D3
            BRA     FLAGCHK
         
SPFOUND     SUBA.W  #1,A1
            MOVE.B  #NULL,(A1)
            ADDA.W  #1,A1
            ADDA.W  #1,A0
            ADDI.B  #1,D2
            ADDA.W  #INDEX,A2
            MOVEA.L A2,A1
            BRA     CHECKLOOP
    
NULLFOUND   ADDI.B  #1,D2
            MOVEM.L (SP)+,A0-A7/D0-D1/D3-D7
            RTS
*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
