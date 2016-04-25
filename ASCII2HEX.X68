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
            MOVE.B  (A5)+,D2                                ; move byte from memory location specified by A5 to D2, post increment A5 by 1 byte
            CMPI.B  #'0',D2                                 ; compare byte immediate ASCII 0 to D2
            BLT     ASCIIRANGE                              ; branch less than to ASCIIRANGE
            CMPI.B  #'F',D2                                 ; compare byte immediate ASCII F to D2
            BGT     ASCIIRANGE                              ; branch greater than to ASCIIRANGE
            CMPI.B  #'9',D2                                 ; compare byte immediate ASCII 9 to D2
            BLE     ASCIINUMBER                             ; branch less than or equal to ASCIINUMBER
            CMPI.B  #'A',D2                                 ; compare byte immediate ASCII A to D2
            BGE     ASCIILETTER                             ; branch greater than or equal to ASCIILETTER
            BRA     ASCIIRANGE                              ; branch always to ASCIIRANGE
ASCIILETTER SUBI.B  #$37,D2                                 ; subtract byte immediate $37 from D2, convert ASCII letter to HEX
            OR.B    D2,D3                                   ; OR byte in D2 with D3 (output register)
            ROL.L   #4,D3                                   ; rotate left long word by 4 bits D3
            BRA     ASCIILOOP                               ; branch always to ASCIILOOP
ASCIINUMBER SUBI.B  #$30,D2                                 ; subtract byte immediate $30 from D2, convert ASCII number to HEX
            OR.B    D2,D3                                   ; OR byte in D2 with D3 (output register)
            ROL.L   #4,D3                                   ; rotate left long word by 4 bits D3
            BRA     ASCIILOOP                               ; branch always ASCIILOOP
ASCIIRANGE  MOVE.L  #1,D4                                   ; move long word immediate 1 into D4, flag set to non HEX value
            LEA     ASCIIERROR,A1                           ; load effective address of ASCIIERROR into A1
            MOVE.B  #14,D0                                  ; trap task #14 in D0, Display the NULL terminated string at (A1) without CR, LF.
            TRAP    #15                                     ; execute trap #15
            BRA     ASCIIFIN                                ; branch always ASCIIFIN
ASCIIDONE   MOVE.L  #0,D4                                   ; move long word immediate 0 into D4, flag clear to HEX value
            ROR.L   #4,D3                                   ; rotate right long word by 4 bits D3
            MOVE.L  D3,(A4)                                 ; move long word from D3 to memory address specified by A4 (ASCIIBUFFER)
            
ASCIIFIN    MOVEM.L (SP)+,A0-A3/A5-A7/D0-D2/D6-D7           ; restore registers from stack, except A4, D3, D4, D5
            RTS                                             ; return from subroutine


*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
