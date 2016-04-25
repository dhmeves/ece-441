*-----------------------------------------------------------
* BTST (Block Test) - The Block Test (BT) command is a destructive test of a block of memory
* beginning at <address1> through <address2>. If this test runs to completion without detecting
* errors, and display a message that no error was detected. If memory problems are found, a message
* is displayed indicating the address, the data stored, and the data read of the failing memory.
*-----------------------------------------------------------
BTST        MOVEM.L A0-A7/D0-D7,-(SP)
        
            LEA     INPUTBUFFER,A0
            ADDA.W  #5,A0
BTSTONLY    ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTBTST
            CMP.B   #SP,(A0)
            BEQ     BTSTONLY
            CMP.B   #NULL,(A0)
            BEQ     BTSTONLY
            BRA     BTSTCONT
            
PRTBTST     LEA     BTSTMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     BTSTDONE

BTSTCONT    JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            CMP.B   #NULL,(A0)
            BEQ     BTSTERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BMOVDONE
            MOVEA.L (A4),A1
            MOVEA.L (A4),A3
            
            LEA     CMDBUFFER,A0
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            CMP.B   #NULL,(A0)
            BEQ     BTSTERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BMOVDONE
            MOVEA.L (A4),A2
            
            CMPA.L  A1,A2
            BLE     BTSTERROR
            
BTSTLOOP    MOVE.B  #TESTVAL1,(A1)+
            CMP.L   A1,A2
            BNE     BTSTLOOP
            
MEMCHKLP    CMP.B   #TESTVAL1,(A3)
            BNE     ERRORDETECT
         
            LEA     MEMSUCCESS,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            MOVE.L  A3,(A5)
            ADDA.W  #4,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            ADDA.W  #1,A3
            CMP.L   A3,A2
            BNE     MEMCHKLP
            BRA     BTSTDONE
            
ERRORDETECT LEA     MEMERROR,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            MOVE.L  A3,(A5)
            ADDA.W  #4,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     DATASTORED,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            MOVE.B  #TESTVAL1,(A5)
            ADDA.W  #1,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     DATAREAD,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            MOVE.B  (A3),(A5)
            ADDA.W  #1,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            ADDA.L  #1,A3
            CMP.L   A3,A2
            BNE     MEMCHKLP
            BRA     BTSTDONE
            
BTSTERROR   LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15 
            BRA     PRTBTST
        
BTSTDONE    MOVEM.L (SP)+,A0-A7/D0-D7
            RTS



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
