*-----------------------------------------------------------
* HELP (Help) - The Help command must display all available
* commands and usage descriptions.
*
*
*-----------------------------------------------------------
MANHELP         MOVEM.L A0-A7/D0-D7,-(SP)

                LEA     HELPPTR,A4          ; pointer to string table
                LEA     HELPSTR,A5          ; pointer to jump table
NEXTPAGEMAN     LEA     INPUTBUFFER,A3
                ADDA.W  #4,A3
                CMPI.B  #NULL,(A3)+
                BNE     CMPSTR1
                CMPI.B  #NULL,(A3)
                BEQ     HELPONLY
CMPSTR1         SUBA.W  #1,A3
                JSR     COMPARESTRING
                
                CMPI.B  #1,D4
                BEQ     MANPAGEJMP
                ADDA.W  #4,A5
                CMP.W   #NOHELP,A5
                BEQ     HELPONLY
                BRA     NEXTPAGEMAN

HELP            MOVEM.L A0-A7/D0-D7,-(SP)

                LEA     HELPPTR,A4          ; pointer to string table
                LEA     HELPSTR,A5          ; pointer to jump table
NEXTPAGE        LEA     INPUTBUFFER,A3
                ADDA.W  #5,A3
                CMPI.B  #NULL,(A3)+
                BNE     CMPSTR2
                CMPI.B  #NULL,(A3)
                BEQ     HELPONLY
CMPSTR2         SUBA.W  #1,A3
                JSR     COMPARESTRING
                
CHECK           CMPI.B  #1,D4
                BEQ     MANPAGEJMP
                ADDA.W  #4,A5
                CMP.W   #NOHELP,A5
                BEQ     HELPONLY
                BRA     NEXTPAGE
                
MANPAGEJMP      MOVE.L  (A5),A6
                JSR     (A6)
                BRA     ENDHELP

HELPOUT         MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     HELPMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
MDSPOUT         MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     MDSPMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
SORTWOUT        MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     SORTWMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
MMOUT           MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     MMMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
MSOUT           MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     MSMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
BFOUT           MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     BFMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
BMOVOUT         MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     BMOVMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS

BTSTOUT         MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     BTSTMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
BSCHOUT         MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     BSCHMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
GOOUT           MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     GOMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
DFOUT           MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     DFMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
EXITOUT         MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     EXITMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
MANOUT          MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     MANMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
CHGREGOUT       MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     CHGREGMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
HISTOUT         MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     HISTMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
CLEAROUT        MOVEM.L A0-A7/D0-D7,-(SP)
                LEA     CLEARMANPAGE,A1
                MOVE.B  #14,D0
                TRAP    #15
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
HELPONLY        LEA     CMDMSG,A1
                MOVE.B  #14,D0
                TRAP    #15

                LEA     HELPMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     MDSPMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     SORTWMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     MMMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     MSMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     BFMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     BMOVMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     BTSTMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     BSCHMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     GOMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     DFMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     EXITMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     CHGREGMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     HISTMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                LEA     CMDMSG2,A1
                MOVE.B  #14,D0
                TRAP    #15
                
ENDHELP         MOVEM.L (SP)+,A0-A7/D0-D7
                RTS




*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
