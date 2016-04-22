*-----------------------------------------------------------
* MS (Memory Set) - The Memory Set (MS) command alters memory by setting data into
* the address specified. The data can take the form of ASCII string or hexadecimal
* data.
*
*-----------------------------------------------------------
MS          MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     INPUTBUFFER,A0
            ADDA.W  #3,A0
MSONLY      ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTMS
            CMP.B   #SP,(A0)
            BEQ     MSONLY
            CMP.B   #NULL,(A0)
            BEQ     MSONLY
            BRA     MSCONT
            
PRTMS       LEA     MSMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     MSDONE

MSCONT      JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D4
            BEQ     MSERROR
            CMP.B   #1,D2
            BEQ     MSDONE
            MOVEA.L (A4),A2
            
            LEA     CMDBUFFER,A0
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D4
            BEQ     ASCIIDATA
            CMP.B   #1,D2
            BEQ     MSDONE
            MOVEA.L A1,A0
INCPTR      CMP.B   #NULL,(A4)+
            BEQ     INCPTR
            LEA     ASCIIBUFFER,A3
            ADDA.W  #4,A3
            SUBA.W  #1,A4
COPYLOOP    MOVE.B  (A4)+,(A2)+
            CMP.L   A4,A3
            BNE     COPYLOOP
            
            BRA     MSDONE
            
ASCIIDATA   LEA     STOREDATA,A1
            MOVE.B  #14,D0
            TRAP    #15

DATALOOP    CMP.B   #NULL,(A0)
            BEQ     MSDONE
            MOVE.B  (A0)+,(A2)+
            BRA     DATALOOP
            
            BRA     MSDONE
            
MSERROR     LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
        
MSDONE      MOVEM.L (SP)+,A0-A7/D0-D7
            RTS
*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
