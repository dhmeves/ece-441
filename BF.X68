*-----------------------------------------------------------
* BF (Block Fill) - The Block Fill (BF) command fills memory starting with the word
* boundary <address1> through <address2>. Both <address1> and <address2> must be even
* addresses. This command only fills with a word-size (2 bytes) data pattern. If an entire
* word-size data pattern is not entered, the pattern is right justified and leading zeros are inserted.
*-----------------------------------------------------------
BF          MOVEM.L A0-A7/D0-D7,-(SP)               ; save registers on stack
            
            LEA     INPUTBUFFER,A0                  ; load effective addresss of INPUTBUFFER into A0
            ADDA.W  #3,A0                           
BFONLY      ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTBF
            CMP.B   #SP,(A0)
            BEQ     BFONLY
            CMP.B   #NULL,(A0)
            BEQ     BFONLY
            BRA     BFCONT
            
PRTBF       LEA     BFMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     BFDONE

BFCONT      CLR.L   D6
            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            CMP.B   #NULL,(A0)
            BEQ     BFERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BFDONE
            MOVEA.L (A4),A1
            
            MOVE.L  A1,D2
            DIVU    #2,D2
            SWAP    D2
            TST.W   D2
            BNE     ODDADDR1
            
CHKADDR2    LEA     CMDBUFFER,A0
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            CMP.B   #NULL,(A0)
            BEQ     BFERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BFDONE
            MOVEA.L (A4),A2
            
            MOVE.L  A2,D2
            DIVU    #2,D2
            SWAP    D2
            TST.W   D2
            BNE     ODDADDR2
            
            CMPA.L  A1,A2
            BLE     BFERROR
            
            CMP.B   #1,D6
            BEQ     BFDONE
            
            LEA     CMDBUFFER,A0
            MOVE.B  #3,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            CMP.B   #NULL,(A0)
            BEQ     BFERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BFDONE
            MOVEA.L (A4),A3
            
            CMP.B   #4,D5
            BEQ     FILLLOOP
            BGT     DATALONG
        
FILLLOOP    MOVE.W  A3,(A1)+
            CMP.L   A1,A2
            BNE     FILLLOOP
            BRA     BFDONE
            
DATALONG    LEA     DATALONGMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     BFDONE

ODDADDR1    MOVE.L  #1,D6
            LEA     ODDADDRMSG1,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     CHKADDR2
            
ODDADDR2    LEA     ODDADDRMSG2,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     BFDONE

BFERROR     LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15 
            BRA     PRTBF          
                
BFDONE      MOVEM.L (SP)+,A0-A7/D0-D7
            RTS



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
