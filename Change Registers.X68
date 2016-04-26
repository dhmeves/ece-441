*-----------------------------------------------------------
* Change Registers (.D[0-7] .A[0-7])
*-----------------------------------------------------------           
D0          MOVEM.L A0-A7/D1-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGD0DONE
            CMP.B   #1,D4
            BEQ     REGD0DONE
            MOVE.L  (A4),D0
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),0(A2)

REGD0DONE   MOVEM.L (SP)+,A0-A7/D1-D7
            RTS
            
D1          MOVEM.L A0-A7/D0/D2-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGD1DONE
            CMP.B   #1,D4
            BEQ     REGD1DONE
            MOVE.L (A4),D1
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),4(A2)

REGD1DONE   MOVEM.L (SP)+,A0-A7/D0/D2-D7
            RTS

D2          MOVEM.L A0-A7/D0-D1/D3-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGD2DONE
            CMP.B   #1,D4
            BEQ     REGD2DONE
            MOVE.L (A4),D2
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),8(A2)

REGD2DONE   MOVEM.L (SP)+,A0-A7/D0-D1/D3-D7
            RTS

D3          MOVEM.L A0-A7/D0-D2/D4-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGD3DONE
            CMP.B   #1,D4
            BEQ     REGD3DONE
            MOVE.L (A4),D3
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),12(A2)
            
REGD3DONE   MOVEM.L (SP)+,A0-A7/D0-D2/D4-D7
            RTS

D4          MOVEM.L A0-A7/D0-D3/D5-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGD4DONE
            CMP.B   #1,D4
            BEQ     REGD4DONE
            MOVE.L (A4),D4
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),16(A2)

REGD4DONE   MOVEM.L (SP)+,A0-A7/D0-D3/D5-D7
            RTS

D5          MOVEM.L A0-A7/D0-D4/D6-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            MOVE.L  #$7395738F,$68008
            CMP.B   #1,D2
            BEQ     REGD5DONE
            CMP.B   #1,D4
            BEQ     REGD5DONE
            MOVE.L (A4),D5
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),20(A2)

REGD5DONE   MOVEM.L (SP)+,A0-A7/D0-D4/D6-D7
            RTS

D6          MOVEM.L A0-A7/D0-D5/D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGD6DONE
            CMP.B   #1,D4
            BEQ     REGD6DONE
            MOVE.L (A4),D6
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),24(A2)

REGD6DONE   MOVEM.L (SP)+,A0-A7/D0-D5/D7
            RTS

D7          MOVEM.L A0-A7/D0-D6,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGD7DONE
            CMP.B   #1,D4
            BEQ     REGD7DONE
            MOVE.L (A4),D7
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),28(A2)

REGD7DONE   MOVEM.L (SP)+,A0-A7/D0-D6
            RTS

A0          MOVEM.L A1-A7/D0-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGA0DONE
            CMP.B   #1,D4
            BEQ     REGA0DONE
            MOVE.L (A4),A0
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),32(A2)

REGA0DONE   MOVEM.L (SP)+,A1-A7/D0-D7
            RTS

A1          MOVEM.L A0/A2-A7/D0-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGA1DONE
            CMP.B   #1,D4
            BEQ     REGA1DONE
            MOVE.L (A4),A1
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),36(A2)

REGA1DONE   MOVEM.L (SP)+,A0/A2-A7/D0-D7
            RTS

A2          MOVEM.L A0-A1/A3-A7/D0-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGA2DONE
            CMP.B   #1,D4
            BEQ     REGA2DONE
            *MOVE.L (A4),A2
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),40(A2)

REGA2DONE   MOVEM.L (SP)+,A0-A1/A3-A7/D0-D7
            RTS

A3          MOVEM.L A0-A2/A4-A7/D0-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGA3DONE
            CMP.B   #1,D4
            BEQ     REGA3DONE
            MOVE.L (A4),A3
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),44(A2)

REGA3DONE   MOVEM.L (SP)+,A0-A2/A4-A7/D0-D7
            RTS

A4          MOVEM.L A0-A3/A5-A7/D0-D7,-(SP)
    
            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGA4DONE
            CMP.B   #1,D4
            BEQ     REGA4DONE
            *MOVE.L (A4),A4
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),48(A2)

REGA4DONE   MOVEM.L (SP)+,A0-A3/A5-A7/D0-D7
            RTS

A5          MOVEM.L A0-A4/A6-A7/D0-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGA5DONE
            CMP.B   #1,D4
            BEQ     REGA5DONE
            MOVE.L (A4),A5
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),52(A2)

REGA5DONE   MOVEM.L (SP)+,A0-A4/A6-A7/D0-D7
            RTS

A6          MOVEM.L A0-A5/A7/D0-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGA6DONE
            CMP.B   #1,D4
            BEQ     REGA6DONE
            MOVE.L (A4),A6
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),56(A2)

REGA6DONE   MOVEM.L (SP)+,A0-A5/A7/D0-D7
            RTS

A7          MOVEM.L A0-A6/D0-D7,-(SP)

            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGA7DONE
            CMP.B   #1,D4
            BEQ     REGA7DONE
            *MOVE.L (A4),A7
            MOVE.L  SSPDATA,A2
            MOVE.L  (A4),60(A2)

REGA7DONE   MOVEM.L (SP)+,A0-A6/D0-D7
            RTS

SR          MOVEM.L A0-A7/D0-D7,-(SP)
            
            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     REGSRDONE
            CMP.B   #1,D4
            BEQ     REGSRDONE
            ADDA.W  #2,A4
            *MOVE.W  (A4),SR
            MOVE.L  SSPDATA,A2
            MOVE.W  (A4),64(A2)

REGSRDONE   MOVEM.L (SP)+,A0-A7/D0-D7
            RTS






*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
