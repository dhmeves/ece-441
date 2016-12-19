*----------------------------------------------------------------------
* Exception Handlers
*----------------------------------------------------------------------
            
*----------------------------------------------------------------------
* BUS ERROR EXCEPTION HANDLER
*----------------------------------------------------------------------
BUSERRHDLR  MOVE.L  A7,A2
            MOVEM.L A0-A7/D0-D7,-(SP) 
            
            LEA     BERR,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     SSW,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #2,A6
            MOVE.W  (A2)+,(A5)
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
            MOVE.L  (A2)+,(A5)
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
            MOVE.W  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVE.L  A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A2)+,SRDATA
            MOVE.L  (A2),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            MOVEM.L (SP)+,A0-A7/D0-D7
            BRA     NEXTCMD
          
*----------------------------------------------------------------------
* ADDRESS ERROR EXCEPTION HANDLER
*----------------------------------------------------------------------  
ADDERRHDLR  MOVE.L  A7,A2
            MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     AERR,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     SSW,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #2,A6
            MOVE.W  (A2)+,(A5)
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
            MOVE.L  (A2)+,(A5)
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
            MOVE.W  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVE.L  A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A2)+,SRDATA
            MOVE.L  (A2),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            MOVEM.L (SP)+,A0-A7/D0-D7
            BRA     NEXTCMD
            
*----------------------------------------------------------------------
* ILLEGAL INSTRUCTION EXCEPTION HANDLER
*----------------------------------------------------------------------
ILLINSTHDLR MOVE.L  A7,A2
            MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     ILL_INST,A1
            MOVE.B  #13,D0
            TRAP    #15
 
            MOVE.W  (A2)+,SRDATA
            MOVE.L  (A2),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            MOVEM.L (SP)+,A0-A7/D0-D7
            BRA     NEXTCMD
         
*----------------------------------------------------------------------
* PRIVILEGE VIOLATION EXCEPTION HANDLER
*----------------------------------------------------------------------
PRIV_VHDLR  MOVE.L  A7,A2
            MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     PRIV_V,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A2)+,SRDATA
            MOVE.L  (A2),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            MOVEM.L (SP)+,A0-A7/D0-D7
            BRA     NEXTCMD
            
*----------------------------------------------------------------------
* DIVIDE BY ZERO EXCEPTION HANDLER
*----------------------------------------------------------------------
DIV_ZHDLR   MOVE.L  A7,A2
            MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     DIV_ZERO,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A2)+,SRDATA
            MOVE.L  (A2),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            *MOVEM.L (SP)+,A0-A7/D0-D7
            BRA     NEXTCMD
            
*----------------------------------------------------------------------
* CHECK INSTRUCTION EXCEPTION HANDLER
*----------------------------------------------------------------------
CHK_IHDLR   MOVE.L  A7,A2
            MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     CHK_INST,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A2)+,SRDATA
            MOVE.L  (A2),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            MOVEM.L (SP)+,A0-A7/D0-D7
            BRA     NEXTCMD
            
*----------------------------------------------------------------------
* LINE A EMULATOR EXCEPTION HANDLER
*----------------------------------------------------------------------
LINE_AHDLR  MOVE.L  A7,A2
            MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     LINE_A,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A2)+,SRDATA
            MOVE.L  (A2),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            *MOVEM.L (SP)+,A0-A7/D0-D7
            BRA     NEXTCMD
            
*----------------------------------------------------------------------
* LINE F EMULATOR EXCEPTION HANDLER
*----------------------------------------------------------------------
LINE_FHDLR  MOVE.L  A7,A2
            MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     LINE_F,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVE.W  (A2)+,SRDATA
            MOVE.L  (A2),PCDATA
            MOVE.L  USP,A3
            MOVE.L  A3,USPDATA
            MOVE.L  SP,SSPDATA2
            JSR     DF
            MOVE.L  SSPDATA,SSPDATA2
            MOVE.W  SRDATA2,SRDATA
            MOVE.L  PCDATA2,PCDATA
            MOVE.L  USPDATA2,USPDATA
            
            MOVEM.L (SP)+,A0-A7/D0-D7
            BRA     NEXTCMD



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
