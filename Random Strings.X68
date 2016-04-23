PROMPT          DC.B    'MONITOR441>',0
INPUTBUFFER     DS.B    80
CMDBUFFER       DS.B    80
ASCIIBUFFER     DS.B    20
HEXBUFFER       DS.B    20
BUFFER          DS.B    20
ERRORMSG        DC.B    'AN ERROR OCCURRED!',CR,LF,0
ADDRERROR       DC.B    'INVALID ADDRESS!',CR,LF,0
ASCIIERROR      DC.B    'NOT A HEXADECIMAL VALUE!',CR,LF,0
HEXERROR        DC.B    'NOT AN ASCII VALUE!',CR,LF,0
STOREDATA       DC.B    'STORING DATA AS ASCII.',CR,LF,0
ODDADDRMSG1     DC.B    'ADDRESS 1 IS NOT AN EVEN ADDRESS!',CR,LF,0
ODDADDRMSG2     DC.B    'ADDRESS 2 IS NOT AN EVEN ADDRESS!',CR,LF,0
DATALONGMSG     DC.B    'DATA ENTERED TOO LARGE, PLEASE ENTER WORD SIZE OR SMALLER!',CR,LF,0
MEMERROR        DC.B    'MEMORY ERROR AT ADDRESS: ',0
MEMSUCCESS      DC.B    'NO MEMORY ERROR DETECTED AT ADDRESS: ',0
DATASTORED      DC.B    'DATA STORED: ',0
DATAREAD        DC.B    'DATA READ: ',0
SPACE           DC.B    ' - ',0
NOSTRINGFOUND   DC.B    'NO MATCHING STRING FOUND!',CR,LF,0
STRINGFOUNDMSG  DC.B    'STRING FOUND!',CR,LF,0
REGD0           DC.B    'D0 - ',0
REGD1           DC.B    'D1 - ',0
REGD2           DC.B    'D2 - ',0
REGD3           DC.B    'D3 - ',0
REGD4           DC.B    'D4 - ',0
REGD5           DC.B    'D5 - ',0
REGD6           DC.B    'D6 - ',0
REGD7           DC.B    'D7 - ',0
REGA0           DC.B    'A0 - ',0
REGA1           DC.B    'A1 - ',0
REGA2           DC.B    'A2 - ',0
REGA3           DC.B    'A3 - ',0
REGA4           DC.B    'A4 - ',0
REGA5           DC.B    'A5 - ',0
REGA6           DC.B    'A6 - ',0
REGA7           DC.B    'A7 - ',0
REGSR           DC.B    'SR - ',0
REGSSP          DC.B    'SSP - ',0
REGUSP          DC.B    'USP - ',0
REGPC           DC.B    'PC - ',0
PCDATA          DS.L    1
PCDATA2         DS.L    1
SRDATA          DS.W    1
SRDATA2         DS.W    1
SSPDATA         DS.L    1
SSPDATA2        DS.L    1
USPDATA         DS.L    1
USPDATA2        DS.L    1
BERR            DC.B    'A BUS ERROR JUST OCCURRED!',0
AERR            DC.B    'AN ADDRESS ERROR JUST OCCURRED!',0
ILL_INST        DC.B    'AN ILLEGAL INSTRUCTION WAS EXECUTED!',0
PRIV_V          DC.B    'A PRIVILEGE VIOLATION JUST OCCURRED!',0
DIV_ZERO        DC.B    'A DIVIDE BY ZERO EXCEPTION JUST OCCURRED!',0
CHK_INST        DC.B    'A CHECK INSTRUCTION EXCEPTION JUST OCCURRED!',0
LINE_A          DC.B    'A LINE A EMULATOR EXCEPTION JUST OCCURRED!',0
LINE_F          DC.B    'A LINE F EMULATOR EXCEPTION JUST OCCURRED!',0
SSW             DC.B    'SSW - ',0
BA              DC.B    'BA - ',0
IR              DC.B    'IR - ',0
*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
