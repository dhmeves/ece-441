*----------------------------------------------------------------------
* Exception Handlers
*----------------------------------------------------------------------
            
*----------------------------------------------------------------------
* BUS ERROR EXCEPTION HANDLER
*----------------------------------------------------------------------
BUSERRHDLR  LEA     BERR,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     SSW,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #2,A6
            MOVE.W  (A7)+,(A5)
            JSR     HEX2ASCII
            MOVE.L  A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     BA,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A7)+,(A5)
            JSR     HEX2ASCII
            MOVE.L  A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     IR,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #2,A6
            MOVE.W  (A7)+,(A5)
            JSR     HEX2ASCII
            MOVE.L  A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A7)+,SRDATA
            MOVE.L  (A7),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            BRA     NEXTCMD
          
*----------------------------------------------------------------------
* ADDRESS ERROR EXCEPTION HANDLER
*----------------------------------------------------------------------  
ADDERRHDLR  LEA     AERR,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     SSW,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #2,A6
            MOVE.W  (A7)+,(A5)
            JSR     HEX2ASCII
            MOVE.L  A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     BA,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A7)+,(A5)
            JSR     HEX2ASCII
            MOVE.L  A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     IR,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #2,A6
            MOVE.W  (A7)+,(A5)
            JSR     HEX2ASCII
            MOVE.L  A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A7)+,SRDATA
            MOVE.L  (A7),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            BRA     NEXTCMD
            
*----------------------------------------------------------------------
* ILLEGAL INSTRUCTION EXCEPTION HANDLER
*----------------------------------------------------------------------
ILLINSTHDLR LEA     ILL_INST,A1
            MOVE.B  #13,D0
            TRAP    #15
 
            MOVE.W  (A7)+,SRDATA
            MOVE.L  (A7),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            BRA     NEXTCMD
         
*----------------------------------------------------------------------
* PRIVILEGE VIOLATION EXCEPTION HANDLER
*----------------------------------------------------------------------
PRIV_VHDLR  LEA     PRIV_V,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A7)+,SRDATA
            MOVE.L  (A7),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            BRA     NEXTCMD
            
*----------------------------------------------------------------------
* DIVIDE BY ZERO EXCEPTION HANDLER
*----------------------------------------------------------------------
DIV_ZHDLR   LEA     DIV_ZERO,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A7)+,SRDATA
            MOVE.L  (A7),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            BRA     NEXTCMD
            
*----------------------------------------------------------------------
* CHECK INSTRUCTION EXCEPTION HANDLER
*----------------------------------------------------------------------
CHK_IHDLR   LEA     CHK_INST,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A7)+,SRDATA
            MOVE.L  (A7),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            BRA     NEXTCMD
            
*----------------------------------------------------------------------
* LINE A EMULATOR EXCEPTION HANDLER
*----------------------------------------------------------------------
LINE_AHDLR  LEA     LINE_A,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A7)+,SRDATA
            MOVE.L  (A7),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            BRA     NEXTCMD
            
*----------------------------------------------------------------------
* LINE F EMULATOR EXCEPTION HANDLER
*----------------------------------------------------------------------
LINE_FHDLR  LEA     LINE_F,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A7)+,SRDATA
            MOVE.L  (A7),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            BRA     NEXTCMD
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
