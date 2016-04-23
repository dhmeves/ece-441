*-----------------------------------------------------------
* DF (Display Formatted Registers) - The Display Formatted Registers (DF) command is used
* to display the MC68000 processor registers. This command should display current PC, SR, US,
* SS and D, A registers. Note that since your program will be using D and A registers, those 
* changed values should not be shown to the user. Thus, you must save all D and A register
* values before any of your subroutines.
*-----------------------------------------------------------
DF          MOVEM.L A0-A7/D0-D7,-(SP)
            *MOVE.L  SP,SPDATA
            *MOVE.L  SP,A2
PCLABEL     MOVE.L  #PCLABEL,PCDATA
            MOVE    SR,SRDATA
            MOVE    USP,A3

*            LEA     INPUTBUFFER,A0
*            ADDA.W  #3,A0
*DFONLY      ADDA.W  #1,A0
*            ADD.B   #1,D4
*            CMP.B   #3,D4
*            BGE     PRTDF
*            CMP.B   #SP,(A0)
*            BEQ     MDSPONLY
*            CMP.B   #NULL,(A0)
*            BEQ     DFONLY
*            BRA     DFCONT
            
*PRTDF       LEA     DFMSG,A1
*            MOVE.B  #14,D0
*            TRAP    #15
*            BRA     DFDONE

*DFCONT
            LEA     REGD0,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  SPDATA,A2
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGD1,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGD2,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGD3,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGD4,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGD5,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGD6,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGD7,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGA0,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGA1,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGA2,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGA3,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGA4,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGA5,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGA6,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGA7,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  #4,A6
            MOVE.L  (A2)+,(A5)
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGSR,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     SRDATA,A5
            LEA     SRDATA,A6
            ADDA.W  #2,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGUSP,A1
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
            
            LEA     REGSSP,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     SPDATA,A5
            LEA     SPDATA,A6
            ADDA.W  #4,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     REGPC,A1
            MOVE.B  #14,D0
            TRAP    #15
            LEA     PCDATA,A5
            LEA     PCDATA,A6
            ADDA.W  #4,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
DFDONE      MOVEM.L (SP)+,A0-A7/D0-D7
            RTS

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
