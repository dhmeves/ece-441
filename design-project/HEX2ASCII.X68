*-----------------------------------------------------------
*HEX TO ASCII CONVERSION SUBROUTINE
* A5 = ptr to beginning address A6 = ptr to ending address
* D3 = output                   A4 = ptr to output
*-----------------------------------------------------------
HEX2ASCII   MOVEM.L A0-A3/A5-A7/D0-D2/D4-D7,-(SP)

            CLR.L   D2
            CLR.L   D3
            LEA     HEXBUFFER,A4
            MOVE.B  #NULL,(A4)
NEXTHEX     CLR.L   D4
            MOVE.B  #1,D4
            CMP.L   A5,A6
            BEQ     HEXDONE
            MOVE.B  -(A6),D2
            MOVE.B  D2,D3
HEXLOOP     MOVE.B  D3,D2
            AND.L   #$0000000F,D2
            CMPI.B  #$0,D2
            BLT     HEXRANGE
            CMPI.B  #$F,D2
            BGT     HEXRANGE
            CMPI.B  #$9,D2
            BLE     HEXNUMBER
            CMPI.B  #$A,D2
            BGE     HEXLETTER
            BRA     HEXRANGE
HEXLETTER   ADDI.B  #$37,D2
            MOVE.B  D2,-(A4)
            ROR.L   #4,D3
            DBRA    D4,HEXLOOP
            BRA     NEXTHEX
HEXNUMBER   ADDI.B  #$30,D2
            MOVE.B  D2,-(A4)
            ROR.L   #4,D3
            DBRA    D4,HEXLOOP
            BRA     NEXTHEX
HEXRANGE    LEA     HEXERROR,A1
            MOVE.B  #14,D0
            TRAP    #15

HEXDONE     MOVEM.L (SP)+,A0-A3/A5-A7/D0-D2/D4-D7
            RTS
*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
