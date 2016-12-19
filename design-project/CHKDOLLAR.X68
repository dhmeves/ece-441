*-----------------------------------------------------------
* Check for Dollarsign and Convert Argument to Hex
* A0 = ptr to command buffer, incremented by INDEX
* D3 = output               A4 = ptr to output
* D2 = 1 - INVALID ADDRESS, 0 - VALID ADDRESS
* D4 = 0 - HEX VALUE, 1 - NON HEX VALUE
* D5 - LENGTH OF STRING
*-----------------------------------------------------------
CHKDOLLAR   MOVEM.L A0-A3/A5-A7/D0-D1/D6-D7,-(SP)
            CLR.L   D2
            CLR.L   D3
            
            CMPI.B  #HEX,(A0)
            BEQ     DOLLARSIGN
            BRA     ARGPTR
DOLLARSIGN  ADDA.W  #1,A0         
ARGPTR      MOVEA.L A0,A5

CMPNULL     ADDI.B  #1,D3
            CMPI.B  #NULL,(A0)+
            BEQ     ENDPTR
            BRA     CMPNULL
ENDPTR      SUBI.B  #1,D3
            SUBA.W  #1,A0
            MOVEA.L A0,A6
            CMPI.B  #8,D3
            BLE     SAFE
            MOVE.L  #1,D2
            JSR     ASCII2HEX
            LEA     ADDRERROR,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     INVALIDADDR
                 
SAFE        MOVE.L  #0,D2
            JSR     ASCII2HEX

INVALIDADDR MOVEM.L (SP)+,A0-A3/A5-A7/D0-D1/D6-D7
            RTS
*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
