*-----------------------------------------------------------
* Bubble Sort
* A0 - ptr to beginning memory A1 = ptr to ending memory
* D1 = 1 - Ascending, 0 - Descending 
*-----------------------------------------------------------
BUBBLESORT  MOVEM.L A0-A7/D0-D7,-(SP)
            
            MOVE.L  A0,A2
BUBBLELOOP  MOVE.L  A2,A0

BUBBLECMP   CMPI.B  #1,D1
            BEQ     DESCEND
            CMP.W   (A0)+,(A0)+
            BHI.S   BUBBLESWAP
            BRA     SORT
      
DESCEND     CMP.W   (A0)+,(A0)+
            BLO.S   BUBBLESWAP
            
SORT        SUBQ.L  #2,A0
            CMP.L   A0,A1
            BNE     BUBBLECMP
            BRA     BUBBLEDN
BUBBLESWAP  MOVE.L  -(A0),D0
            SWAP.W  D0
            MOVE.L  D0,(A0)
            BRA     BUBBLELOOP

BUBBLEDN    MOVEM.L (SP)+,A0-A7/D0-D7
            RTS

*-----------------------------------------------------------
* SORTW (Sort) - The SORT command sorts a block of memory. The starting
* address <address1> and the ending address <address2> of the memory block
* are specified in the command. The order (A or D) specifies whether the list is 
* sorted in Ascending or Descending order. (The size of the data to be sorted is a word)
*-----------------------------------------------------------
SORTW       MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     INPUTBUFFER,A0
            ADDA.W  #6,A0
SORTWONLY   ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTSORTW
            CMP.B   #SP,(A0)
            BEQ     SORTWONLY
            CMP.B   #NULL,(A0)
            BEQ     SORTWONLY
            BRA     SORTWCONT
            
PRTSORTW    LEA     SORTWMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     SORTWDONE

SORTWCONT   JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            CMP.B   #NULL,(A0)
            BEQ     SORTWERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     SORTWDONE
            MOVEA.L (A4),A1
            
            LEA     CMDBUFFER,A0
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            CMP.B   #NULL,(A0)
            BEQ     SORTWERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     SORTWDONE
            MOVEA.L A1,A0
            MOVEA.L (A4),A1
            
            CMPA.L  A0,A1
            BLE     SORTWERROR
            
            LEA     CMDBUFFER,A2
            MOVE.B  #3,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A2
            
            CMP.B   #NULL,(A2)
            BEQ     SORTWERROR
            
            CMP.B   #'A',(A2)
            BEQ     ASCENDING
            
            CMP.B   #'D',(A2)
            BEQ     DESCENDING
            
SORTWERROR  LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     PRTSORTW
            
ASCENDING   MOVE.L  #1,D1
            BRA     BSORT
            
DESCENDING  MOVE.L  #0,D1
            
BSORT       JSR     BUBBLESORT
        
SORTWDONE   MOVEM.L (SP)+,A0-A7/D0-D7
            RTS



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
