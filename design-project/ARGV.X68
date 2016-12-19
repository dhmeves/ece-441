*-----------------------------------------------------------
* ARGV Command Line Parsing Subroutine
* Stores Commands separated by INDEX (12) in memory starting at CMDBUFFER
* D2 = # of Arguments
*-----------------------------------------------------------

ARGV        MOVEM.L A0-A7/D0-D1/D3-D7,-(SP)         ; save registers to stack, except D2 = number of arguments returned from subroutine

            LEA     INPUTBUFFER,A0                  ; load effective address of INPUTBUFFER into A0
            LEA     CMDBUFFER,A1                    ; load effective address of CMDBUFFER into A1
            LEA     CMDBUFFER,A2                    ; load effective address of CMDBUFFER into A2
            CLR.L   D2                              ; clear long word D2
            CLR.L   D3                              ; clear long word D3
CHECKLOOP   MOVE.B  (A0),(A1)+                      ; move byte from INPUTBUFFER (A0) to CMDBUFFER (A1), post increment A1 by 1
            CMP.B   #SINGLEQUOTE,(A0)               ; compare byte immediate SINGLEQUOTE to byte at A0
            BEQ     QUOTEFOUND                      ; branch if equal to QUOTEFOUND
            CMP.B   #DOUBLEQUOTE,(A0)               ; compare byte immediate DOUBLEQUOTE to byte at A0
            BEQ     QUOTEFOUND                      ; branch if equal to QUOTEFOUND
FLAGCHK     CMP.B   #1,D3                           ; compare byte immediate 1 to D3, check if quote flag is 1 (used in identifying open and closed quotes)
            BEQ     NULLCHK                         ; branch if equal to NULLCHK
            CMPI.B  #SP,(A0)                        ; compare byte immediate SPACE (SP) to byte at A0
            BEQ     SPFOUND                         ; branch if equal to SPFOUND
NULLCHK     CMPI.B  #NULL,(A0)+                     ; compare byte immediate NULL character to byte at A0, post increment A0 by 1
            BEQ     NULLFOUND                       ; branch if equal to NULLFOUND
            BRA     CHECKLOOP                       ; branch always to CHECKLOOP
            
QUOTEFOUND  ADD.L   #1,D3                           ; add long word immediate 1 to D3
            ANDI.B  #1,D3                           ; and byte immediate 1 with D3, toggles D3 between 1 and 0 depending on how many quotes found
                                                    ; even # of quotes = closed quote = treat as 1 argument in BF command
                                                    ; odd # of quotes = open quote = treat as separate arguments in BF command
            BRA     FLAGCHK                         ; branch always to FLAGCHK
         
SPFOUND     SUBA.W  #1,A1                           ; subtract word immediate 1 from address register A1, undo last post increment 
            MOVE.B  #NULL,(A1)                      ; move byte immediate NULL character to byte at A1
            ADDA.W  #1,A1                           ; add word immediate 1 to address register A1, increment beyond NULL character
            ADDA.W  #1,A0                           ; add word immediate 1 to address register A0, increment A0 if space found
            ADDI.B  #1,D2                           ; add byte immediate 1 to D2, track number of arguments in command
            ADDA.W  #INDEX,A2                       ; add word immediate INDEX (12) to A2, pointer to storing location in CMDBUFFER
            MOVEA.L A2,A1                           ; copy A2 to A1, A1 now points to next storage location in CMDBUFFER
            BRA     CHECKLOOP                       ; branch always to CHECKLOOP
    
NULLFOUND   ADDI.B  #1,D2                           ; add byte immediate 1 to D2, track number of arguments in command
            MOVEM.L (SP)+,A0-A7/D0-D1/D3-D7         ; restore registers from stack, except D2 = number of arguments returned from subroutine
            RTS                                     ; return from subroutine

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
