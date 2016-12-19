*-----------------------------------------------------------
* GO (Execute Program) - The GO command is used to start execution from a given address.
*
*
*
*-----------------------------------------------------------
GO          MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     INPUTBUFFER,A0
            ADDA.W  #3,A0
GOONLY      ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTGO
            CMP.B   #SP,(A0)
            BEQ     GOONLY
            CMP.B   #NULL,(A0)
            BEQ     GOONLY
            BRA     GOCONT
            
PRTGO       LEA     GOMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     GODONE

GOCONT      JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            CMP.B   #NULL,(A0)
            BEQ     GOERROR
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     GODONE
            CMP.B   #1,D4
            BEQ     GODONE
            MOVEA.L (A4),A1
            
            JSR     (A1)
            BRA     GODONE
            
GOERROR     LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15 
            BRA     PRTGO          
        
GODONE      MOVEM.L (SP)+,A0-A7/D0-D7
            RTS


*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
