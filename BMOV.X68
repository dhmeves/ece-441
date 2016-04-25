*-----------------------------------------------------------
* BMOV (Block Move) - The Block Move (BMOV) command is used to move (duplicate) blocks
* of memory from one area to another.
*
*
*-----------------------------------------------------------
BMOV        MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     INPUTBUFFER,A0
            ADDA.W  #5,A0
BMOVONLY    ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTBMOV
            CMP.B   #SP,(A0)
            BEQ     BMOVONLY    
            CMP.B   #NULL,(A0)
            BEQ     BMOVONLY
            BRA     BMOVCONT
            
PRTBMOV     LEA     BMOVMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     BMOVDONE

BMOVCONT    JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            CMP.B   #NULL,(A0)
            BEQ     BMOVERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BMOVDONE
            MOVEA.L (A4),A1
            
            LEA     CMDBUFFER,A0
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            CMP.B   #NULL,(A0)
            BEQ     BMOVERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BMOVDONE
            MOVEA.L (A4),A2
            
            CMPA.L  A1,A2
            BLE     BMOVERROR
            
            LEA     CMDBUFFER,A0
            MOVE.B  #3,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            CMP.B   #NULL,(A0)
            BEQ     BMOVERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BMOVDONE
            MOVEA.L (A4),A3
            
BMOVLOOP    MOVE.B  (A1)+,(A3)+
            CMP.L   A1,A2
            BNE     BMOVLOOP
            BRA     BMOVDONE
            
BMOVERROR   LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     PRTBMOV
        
BMOVDONE    MOVEM.L (SP)+,A0-A7/D0-D7
            RTS


*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
