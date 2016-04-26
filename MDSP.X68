*-----------------------------------------------------------
* MDSP Print Loop
* A2 = ptr to beginning memory A3 = ptr to ending memory
*-----------------------------------------------------------
MDSPPRINT   MOVEM.L A0-A7/D0-D7,-(SP)

INCREMENT   MOVE.L  A2,(A5)
            ADDA.W  #4,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.W  #8,D1  
            MOVE.B  #1,D0
            TRAP    #15
            LEA     SPACE,A1
            MOVE.B  #14,D0
            TRAP    #15
            MOVE.B  (A2),(A5)
            LEA     BUFFER,A6
            ADDA.W  #1,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.W  #2,D1  
            MOVE.B  #0,D0
            TRAP    #15
            ADDA.W  #1,A2
            CMP.L   A2,A3
            BNE     INCREMENT
            
            MOVEM.L (SP)+,A0-A7/D0-D7
            RTS


*-----------------------------------------------------------
* MDSP (Memory Display) - The MDSP (Memory Display) command
* outputs the address and memory contents from <address1> to
* <address2>. The MDSP (Memory Display) command ALSO outputs
* the address and memory contents from <address1> to <address1 + 16bytes>
*-----------------------------------------------------------
MDSP        MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     INPUTBUFFER,A0
            ADDA.W  #5,A0
MDSPONLY    ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTMDSP
            CMP.B   #SP,(A0)
            BEQ     MDSPONLY
            CMP.B   #NULL,(A0)
            BEQ     MDSPONLY
            BRA     MDSPCONT
            
PRTMDSP     LEA     MDSPMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     MDSPDONE
            
MDSPCONT    JSR     ARGV
            MOVE.L  D2,D6
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            CMP.B   #NULL,(A0)
            BEQ     MDSPERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     MDSPDONE
            CMP.B   #1,D4
            BEQ     MDSPDONE
            MOVE.L  (A4),MDSPBUF
            
            CMPI.B  #2,D6
            BEQ     ARG1
            
            CMPI.B  #3,D6
            BEQ     ARG2
            
ARG1        LEA     ASCIIBUFFER,A0
            MOVEA.L (A0),A2
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            MOVEA.L A2,A3
            ADDA.W  #16,A3
            
            JSR     MDSPPRINT
            
            BRA     MDSPDONE
         
ARG2        LEA     CMDBUFFER,A0
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            CMP.B   #NULL,(A0)
            BEQ     MDSPERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     MDSPDONE
            CMP.B   #1,D4
            BEQ     MDSPDONE
            
            LEA     MDSPBUF,A0
            MOVEA.L (A0),A2
            MOVEA.L (A4),A3
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            
            CMPA.L  A2,A3
            BLE     MDSPERROR
            
            JSR     MDSPPRINT
            BRA     MDSPDONE
            
MDSPERROR   LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15 
            BRA     PRTMDSP
            
MDSPDONE    MOVEM.L (SP)+,A0-A7/D0-D7
            RTS




*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
