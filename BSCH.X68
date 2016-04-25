*-----------------------------------------------------------
* BSCH (Block Search) - The BSCH (Block Search) command is used to search a literal string in a 
* memory block starting at <address1> through <address2> both inclusive. In BSCH command, if search
* finds matching data, the data and address(es) must be displayed.
*
*-----------------------------------------------------------
BSCH        MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     INPUTBUFFER,A0
            ADDA.W  #5,A0
BSCHONLY    ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTBSCH
            CMP.B   #SP,(A0)
            BEQ     BSCHONLY
            CMP.B   #NULL,(A0)
            BEQ     BSCHONLY
            BRA     BSCHCONT
            
PRTBSCH     LEA     BSCHMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     BSCHDONE

BSCHCONT    JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            CMP.B   #NULL,(A0)
            BEQ     BSCHERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BSCHDONE
            MOVEA.L (A4),A1
            
            LEA     CMDBUFFER,A0
            MOVE.L  #$73812983,$68004
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            CMP.B   #NULL,(A0)
            BEQ     BSCHERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BSCHDONE
            MOVEA.L (A4),A2
            
            CMPA.L  A1,A2
            BLE     BSCHERROR
            
            LEA     CMDBUFFER,A0
            MOVE.B  #3,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            CMP.B   #NULL,(A0)
            BEQ     BSCHERROR
            
            CLR.L   D4  
            BRA     CHKLOOP
 
QUOTECHK0   SUBA.W  #1,A0

CHKLOOP     CMP.B   #SINGLEQUOTE,(A1)
            BEQ     QUOTECHK1
            
            CMP.B   #DOUBLEQUOTE,(A1)
            BEQ     QUOTECHK1
            
            BRA     QUOTECHK2
            
QUOTECHK1   MOVE.B  #NULL,(A1)
            ADDA.W  #1,A1

QUOTECHK2   CMP.B   #SINGLEQUOTE,(A0)
            BEQ     QUOTECHK3
            
            CMP.B   #DOUBLEQUOTE,(A0)
            BEQ     QUOTECHK3
            
            BRA     STRINGCONT
            
QUOTECHK3   MOVE.B  #NULL,(A0)
            ADDA.W  #1,A0

STRINGCONT  CMPM.B  (A0)+,(A1)+
            BEQ     MATCHFOUND
            
            CMP.L   A1,A2
            BEQ     NOSTRING
         
            BRA     QUOTECHK0
            
MATCHFOUND  ADD.B   #1,D4                           ; string length counter
            CMP.B   #SINGLEQUOTE,(A0)
            BEQ     CHECKNULL
            
            CMP.B   #DOUBLEQUOTE,(A0)
            BEQ     CHECKNULL
            
CHKQUOTE2   CMP.B   #SINGLEQUOTE,(A1)
            BEQ     CHECKNULL2
            
            CMP.B   #DOUBLEQUOTE,(A1)
            BEQ     CHECKNULL2
            
            BRA     NOADD1
            
CHECKNULL   MOVE.B  #NULL,(A0)
            BRA     CHKQUOTE2
            
CHECKNULL2  MOVE.B  #NULL,(A1)

NOADD1      CMP.B   #NULL,(A0)
            BEQ     STRINGFOUND           
            BRA     CHKLOOP
            
NOSTRING    LEA     NOSTRINGFOUND,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     BSCHDONE   
 
STRINGFOUND MOVEA.L A1,A3

            SUB.L   D4,A3
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADD.L   #4,A6
            MOVEA.L A0,A2
            SUB.L   D4,A2
            
            LEA     STRINGFOUNDMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            
STRPRTLOOP  MOVE.L  A3,(A5)
          
            JSR     HEX2ASCII
            MOVE.L  A4,A1
            MOVE.B  #14,D0
            TRAP    #15   

            LEA     SPACE,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            MOVE.B  (A2),D1
            MOVE.B  #6,D0
            TRAP    #15
            
            MOVE.B  #CR,D1
            MOVE.B  #6,D0
            TRAP    #15
            
            MOVE.B  #LF,D1
            MOVE.B  #6,D0
            TRAP    #15
            
            ADDA.W  #1,A3
            ADDA.W  #1,A2
            
            CMP.L   A2,A0
            BNE     STRPRTLOOP
            BRA     BSCHDONE
            
BSCHERROR   LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15 
            BRA     PRTBSCH
            
BSCHDONE    MOVEM.L (SP)+,A0-A7/D0-D7
            RTS




*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
