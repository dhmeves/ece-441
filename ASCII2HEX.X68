*-----------------------------------------------------------
*ASCII TO HEX CONVERSION SUBROUTINE
* A5 = ptr to beginning address A6 = ptr to ending address
* D3 = output D4 = 0 - HEX VALUE, 1 - NON HEX VALUE 
* D5 - LENGTH OF STRING  A4 = ptr to output
*-----------------------------------------------------------
ASCII2HEX   MOVEM.L A0-A3/A5-A7/D0-D2/D6-D7,-(SP)           ; save registers to stack, except A4, D3, D4, D5
            
            MOVEA.L #ASCIIBUFFER,A4                         ; move long word address immediate of ASCIIBUFFER to A4
            CLR.L   D3                                      ; clear long word D3    
            CLR.L   D5                                      ; clear long word D5
ASCIILOOP   CLR.L   D2                                      ; clear long word D2
            CMP.L   A5,A6                                   ; compare A5 (ptr to beginning address) to A6 (ptr to ending address)
            BEQ     ASCIIDONE                               ; branch if equal to ASCIIDONE
            ADD.B   #1,D5                                   ; add byte immediate 1 to D5
            MOVE.B  (A5)+,D2                                ; move byte from memory location specified by A5 to D2, post increment A5
            CMPI.B  #'0',D2                                 
            BLT     ASCIIRANGE
            CMPI.B  #'F',D2
            BGT     ASCIIRANGE
            CMPI.B  #'9',D2
            BLE     ASCIINUMBER
            CMPI.B  #'A',D2
            BGE     ASCIILETTER
            BRA     ASCIIRANGE
ASCIILETTER SUBI.B  #$37,D2
            OR.B    D2,D3
            ROL.L   #4,D3
            BRA     ASCIILOOP
ASCIINUMBER SUBI.B  #$30,D2
            OR.B    D2,D3
            ROL.L   #4,D3
            BRA     ASCIILOOP
ASCIIRANGE  MOVE.L  #1,D4
            LEA     ASCIIERROR,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     ASCIIFIN       
ASCIIDONE   MOVE.L  #0,D4
            ROR.L   #4,D3
            MOVE.L  D3,(A4)
            
ASCIIFIN    MOVEM.L (SP)+,A0-A3/A5-A7/D0-D2/D6-D7
            RTS

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
