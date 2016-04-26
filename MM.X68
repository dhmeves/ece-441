*-----------------------------------------------------------
* MM Print Loop
* A2 = ptr to beginning memory A3 = ptr to ending memory
* D2 = SIZE OF MEMORY OUTPUT D4 = LENGTH OF OUTPUT
*-----------------------------------------------------------
MMPRINT     MOVEM.L A0-A7/D0-D7,-(SP)

INCREMENT2  MOVE.L  A2,(A5)
            ADDA.W  #4,A6
            JSR     HEX2ASCII
            
            MOVEA.L A4,A1
            MOVE.B  #8,D1
            MOVE.B  #1,D0
            TRAP    #15
            
            LEA     SPACE,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            CMP.B   #1,D2
            BEQ     BYTEPRINT
            
            CMP.B   #2,D2
            BEQ     WORDPRINT
            
            CMP.B   #4,D2
            BEQ     LONGPRINT
            
BYTEPRINT   MOVE.B  (A2),(A5)
            LEA     BUFFER,A6
            ADDA.W  D2,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.L  D6,D1  
            MOVE.B  #1,D0
            TRAP    #15
            
            LEA     SPACE,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            LEA     BUFFER,A1
            MOVE.B  #2,D0
            TRAP    #15
            
            CMPI.B  #'.',(A1)
            BEQ     MMPRINTDN
            
            CMP.B   #0,D1
            BEQ     BYTECONT

            CMP.B   D6,D1
            BNE     MMERROR
            
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  D6,A6
            JSR     ASCII2HEX
            ADDA.W  #3,A4
            MOVE.B  (A4),(A2)
            
BYTECONT    ADDA.W  D2,A2
            BRA     INCREMENT2
            
WORDPRINT   MOVE.W  (A2),(A5)
            LEA     BUFFER,A6
            ADDA.W  D2,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.L  D6,D1  
            MOVE.B  #1,D0
            TRAP    #15
            
            LEA     SPACE,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            LEA     BUFFER,A1
            MOVE.B  #2,D0
            TRAP    #15
            
            CMPI.B  #'.',(A1)
            BEQ     MMPRINTDN

            CMP.B   #0,D1
            BEQ     WORDCONT    

            CMP.B   D6,D1
            BNE     MMERROR
            
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  D6,A6
            JSR     ASCII2HEX
            ADDA.W  #2,A4
            MOVE.W (A4),(A2)
            
WORDCONT    ADDA.W  D2,A2
            BRA     INCREMENT2
            
LONGPRINT   MOVE.L  (A2),(A5)
            LEA     BUFFER,A6
            ADDA.W  D2,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.L  D6,D1  
            MOVE.B  #1,D0
            TRAP    #15
            
            LEA     SPACE,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            LEA     BUFFER,A1
            MOVE.B  #2,D0
            TRAP    #15
            
            CMPI.B  #'.',(A1)
            BEQ     MMPRINTDN
            
            CMP.B   #0,D1
            BEQ     LONGCONT
        
            CMP.B   D6,D1
            BNE     MMERROR
            
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  D6,A6
            JSR     ASCII2HEX
            MOVE.L  (A4),(A2)
            
LONGCONT    ADDA.W  D2,A2
            BRA     INCREMENT2

MMERROR     LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15    
            
MMPRINTDN   MOVEM.L (SP)+,A0-A7/D0-D7
            RTS


*-----------------------------------------------------------
* MM (Memory Modify) - MM (Memory Modify) command is used to display memory and,
* as required, modify data or enter new data. The size (bye, word, long word) controls
* the number of bytes displayed for each address.
*
*-----------------------------------------------------------
MM          MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     INPUTBUFFER,A0
            ADDA.W  #3,A0
MMONLY      ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTMM
            CMP.B   #SP,(A0)
            BEQ     MMONLY
            CMP.B   #NULL,(A0)
            BEQ     MMONLY
            BRA     MMCONT
            
PRTMM       LEA     MMMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     MMDONE

MMCONT      JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            CMP.B   #NULL,(A0)
            BEQ     MMERROR2
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     MMDONE
            CMP.B   #1,D4
            BEQ     MMDONE
            MOVE.L  #$716B857B,$68000
            MOVEA.L (A4),A1
            
            LEA     CMDBUFFER,A2
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A2
            
            CMP.B   #NULL,(A2)
            BEQ     MMERROR2
            
            CMP.B   #'B',(A2)
            BEQ     BYTE
            
            CMP.B   #'W',(A2)
            BEQ     WORD
            
            CMP.B   #'L',(A2)
            BEQ     LONG
            
MMERROR2    LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     PRTMM
            
BYTE        MOVE.L  #1,D2
            MOVE.L  #2,D6
            MOVEA.L A1,A2
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            JSR     MMPRINT
            BRA     MMDONE
            
WORD        *MOVE.L  A1,D0
            *DIVU    #2,D0
            *SWAP    D0
            *TST.W   D0
            *BNE     ODDADDRMM
            
            MOVE.L  #2,D2
            MOVE.L  #4,D6
            MOVEA.L A1,A2
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            JSR     MMPRINT
            BRA     MMDONE
            
LONG        *MOVE.L  A1,D0
            *DIVU    #2,D0
            *SWAP    D0
            *TST.W   D0
            *BNE     ODDADDRMM

            MOVE.L  #4,D2
            MOVE.L  #8,D6
            MOVEA.L A1,A2
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            JSR     MMPRINT
            BRA     MMDONE
            
ODDADDRMM   LEA     ODDADDRMSG1,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     PRTMM

MMDONE      MOVEM.L (SP)+,A0-A7/D0-D7
            RTS





*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
