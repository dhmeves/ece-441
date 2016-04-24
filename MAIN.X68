*-----------------------------------------------------------
* Main Program
*-----------------------------------------------------------
START:                  ; first instruction of program
                MOVE    SR,-(SP)                ; save status register to stack for DF and change registers command, global state
                MOVEM.L A0-A7/D0-D7,-(SP)       ; save registers to stack for DF and change registers command, global state
                MOVE.L  SP,SSPDATA              ; initialize SSPDATA with stack pointer (supervisor)   
                MOVE.L  SP,SSPDATA2             ; initialize SSPDATA2 with stack pointer (supervisor)
                MOVE.L  SP,A2                   ; copy stack pointer to A2
                MOVE.W  64(A2),SRDATA           ; move status register on stack to SRDATA
                MOVE.W  64(A2),SRDATA2          ; move status register on stack to SRDATA2
PCLABEL         MOVE.L  #PCLABEL,PCDATA         ; store program counter location in PCDATA
                MOVE.L  #PCLABEL,PCDATA2        ; store program counter location in PCDATA2
                MOVE    USP,A3                  ; move user stack pointer to A3
                MOVE.L  A3,USPDATA              ; move user stack pointer (A3) to USPDATA
                MOVE.L  A3,USPDATA2             ; move user stack pointer (A3) to USPDATA2
                
                LEA     HISTORYBUFFER,A4        ; load effective address of HISTORYBUFFER into A4
                MOVE.L  #499,D4                 ; initialize loop counter D4 with 499 for 500 loop
CLRHISTBUF      CLR.L   (A4)+                   ; clear long address specified by HISTORYBUFFER pointer, postincrement A4 by 4
                DBRA    D4,CLRHISTBUF           ; test condition, decrement, and branch to CLRHISTBUF if D4 not equal to -1
                
                LEA     HISTORYBUFFER,A5
                                
                *MOVE.L $005001,A1              ;ADDRESS ERROR EXCEPTION
                *MOVE.W  #$AA,(A1)
                
                *MOVE.W  #$4000,SR              ;PRIVILEGE VIOLATION EXCEPTION
                
                *MOVE.L  #0,D1                  ;DIVIDE BY ZERO EXCEPTION
                *DIVU    D1,D0
                
                *MOVE.L  #$3000,D6              ;CHECK INSTRUCTION EXCEPTION
                *MOVE.L  #$3010,D7
                *CHK.W   D6,D7
                
NEXTCMD         LEA     PROMPT,A1               ; load monitor prompt into A1
                MOVE.B  #14,D0                  ; trap task #14 in D0, Display the NULL terminated string at (A1) without CR, LF.
                TRAP    #15                     ; execute trap #15
        
                LEA     INPUTBUFFER,A2          ; load effective address of INPUTBUFFER into A2
                MOVE.L  #79,D2                  ; initialize loop counter D2 with 79 for 80 loop
CLRINBUF        CLR.B   (A2)+                   ; clear byte address specified by INPUTBUFFER pointer, postincrement A2 by 1
                DBRA    D2,CLRINBUF             ; test condition, decrement, and branch to CLRINBUF if D2 not equal to -1

                LEA     CMDBUFFER,A3            ; load effective address of CMDBUFFER into A3
                MOVE.L  #79,D3                  ; initialize loop counter D3 with 79 for 80 loop
CLRCMDBUF       CLR.B   (A3)+                   ; clear byte address specified by CMDBUFFER pointer, postincrement A3 by 1
                DBRA    D3,CLRCMDBUF            ; test condition, decrement, and branch to CLRCMDBUF if D2 not equal to -1

                LEA     INPUTBUFFER,A1          ; load effective address of INPUTBUFFER into A1
                MOVE.B  #2,D0                   ; trap task #2 in D0, Read string from keyboard and store at (A1), NULL terminated, length returned in D1.W (max 80)
                TRAP    #15                     ; execute trap #15

MOVEHISTORY     MOVE.B  (A1)+,(A5)+             ; move byte from INPUTBUFFER to HISTORYBUFFER, post increment A1 and A5 by 1
                CMP.B   #NULL,(A1)              ; compare NULL character to byte stored at A1
                BEQ     COPYDONE                ; branch if equal to COPYDONE
                BRA     MOVEHISTORY             ; branch always to MOVEHISTORY
                
                *MOVEM.L (SP)+,A0-A7/D0-D7      ; restore registers from stack, not needed because DF and change registers use stack
                *MOVE    (SP)+,SR               ; restore status register from stack, not needed because DF and change registers use stack
                
COPYDONE        ADDA.W  #1,A5                   ; increment A5 by 1, NULL character separates command strings in HISTORYBUFFER
                MOVE.L  A5,HISTORYPTR           ; copy A5 to HISTORYPTR
                JSR     INTERPRETER             ; jump to command interpreter subroutine
                
                BRA     NEXTCMD                 ; branch always to NEXTCMD











*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
