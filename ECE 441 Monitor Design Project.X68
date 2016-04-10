*-----------------------------------------------------------
* Title      : ECE 441 Monitor Design Project
* Written by : Daniel H. Meves
* Date       : 03/21/2016 - 04/27/2016
* Description: 
*-----------------------------------------------------------

*---------------------------
**********CONSTANTS*********
BUF     EQU     $900
TUTOR   EQU     228
OUT1CR  EQU     227
PORTIN1 EQU     241
OUTPUT  EQU     243
INDEX   EQU     20
TESTVAL1    EQU     $AA
TESTVAL2    EQU     $55
SINGLEQUOTE EQU     $27
DOUBLEQUOTE EQU     $22
 
BS  EQU  $08   ; Backspace
HT  EQU  $09   ; Tab (horizontal 5 characters)
LF  EQU  $0A   ; New line (line feed)
VT  EQU  $0B   ; Vertical tab (4 lines)
FF  EQU  $0C   ; Form Feed (Always end printing with a Form Feed.)
CR  EQU  $0D   ; Carriage Return
SP  EQU  $20   ; Space
HEX EQU  $24
HASH    EQU     $23
NULL    EQU     $00
*---------------------------
    ORG    $1000
    
PROMPT      DC.B    'MONITOR441>',0
    ORG     $1010
INPUTBUFFER     DS.B    80
    ORG     $1060
CMDBUFFER       DS.B    80
    ORG     $1110
ASCIIBUFFER     DS.B    20
HEXBUFFER       DS.B    20
BUFFER          DS.B    20
ERRORMSG        DC.B    'AN ERROR OCCURRED!',CR,LF,0
ADDRERROR       DC.B    'INVALID ADDRESS!',CR,LF,0
ASCIIERROR      DC.B    'NOT AN HEXADECIMAL VALUE!',CR,LF,0
HEXERROR        DC.B    'NOT A ASCII VALUE!',CR,LF,0
STOREDATA       DC.B    'STORING DATA AS ASCII.',CR,LF,0
ODDADDRMSG1     DC.B    'ADDRESS 1 IS NOT AN EVEN ADDRESS!',CR,LF,0
ODDADDRMSG2     DC.B    'ADDRESS 2 IS NOT AN EVEN ADDRESS!',CR,LF,0
DATALONGMSG     DC.B    'DATA ENTERED TOO LARGE, PLEASE ENTER WORD SIZE OR SMALLER!',CR,LF,0
MEMERROR        DC.B    'MEMORY ERROR AT ADDRESS: ',0
MEMSUCCESS      DC.B    'NO MEMORY ERROR DETECTED AT ADDRESS: ',0
DATASTORED      DC.B    'DATA STORED: ',0
DATAREAD        DC.B    'DATA READ: ',0
SPACE           DC.B    ' - ',0
CMDMSG          DC.B    CR,LF,'*****ALL MONITOR441 COMMANDS*****',CR,LF,LF,0
HELPMSG         DC.B    CR,LF,'   HELP: Displays this message',CR,LF,LF,0
                
MDSPMSG         DC.B    CR,LF,'   MDSP: Outputs Address And Memory Contents',CR,LF
                DC.B    '   MDSP <address1> <address2> eg: MDSP $908 $90A<CR>',CR,LF,LF,0
                
SORTWMSG        DC.B    CR,LF,'   SORTW: Sorts A Block Of Memory',CR,LF
                DC.B    '   Default: Descending Order',CR,LF
                DC.B    '   ;A: Ascending Order',CR,LF
                DC.B    '   ;D: Descending Order',CR,LF
                DC.B    '   SORTW <address1> <address2> [;order] eg: SORTW $904 $90E ;A<CR>',CR,LF,LF,0
                
MMMSG           DC.B    CR,LF,'   MM: Modifies Data In Memory',CR,LF
                DC.B    '   Default: Displays One Byte',CR,LF
                DC.B    '   ;W: Displays One Word',CR,LF
                DC.B    '   ;L: Displays One Long Word',CR,LF
                DC.B    '   MM <address>[;size] eg: MM $904;W<CR>',CR,LF,LF,0
                
MSMSG           DC.B    CR,LF,'   MS - Memory Set.',CR,LF
                DC.B    '   MS <address> [data] eg: MS $904 $FFFF<CR>',CR,LF,LF,0
                
BFMSG           DC.B    CR,LF,'   BF: Fills A Block Of Memory',CR,LF
                DC.B    '   BF <address1> <address2> <word> eg: BF $904 $908 475A<CR>',CR,LF,LF,0
                
BMOVMSG         DC.B    CR,LF,'   BMOV: Moves A Block of Memory To Another Area',CR,LF
                DC.B    '   BMOV <address1> <address2> <address3> eg: BMOV $908 $90B $909<CR>',CR,LF,LF,0
                
BTSTMSG         DC.B    CR,LF,'   BTST - Block Test.',CR,LF,LF,0
                
BSCHMSG         DC.B    CR,LF,'   BSCH: Searches A Literal String In The Memory',CR,LF
                DC.B    '   BSCH <address1> <address2> "literal string" eg: BSCH $900 $910 "MATCH"<CR>',CR,LF,LF,0
                
GOMSG           DC.B    CR,LF,'   GO: Starts Execution From Given Address',CR,LF
                DC.B    '   GO <address> eg: GO $900<CR>',CR,LF,LF,0
                
DFMSG           DC.B    CR,LF,'   DF - Display Formatted Registers.',CR,LF,LF,0
                
EXITMSG         DC.B    CR,LF,'   EXIT - Exit the monitor program eg: EXIT<CR>',CR,LF,LF,0
                
CMDMSG2         DC.B    CR,LF,'*****Try HELP <command> or MAN <command> to view man page.*****',CR,LF,LF,0

*--------------------------
*MAN PAGES
*--------------------------
    ORG     $5000
HELPMANPAGE     DC.B    CR,LF,'HELP(1)                       MC68000/SANPER-1 ELU                       HELP(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   HELP - Help.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   HELP',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   The Help command must display all available commands and usage descriptions.',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   MDSP(1), SORTW(1), MM(1), MS(1), BF(1), BMOV(1), BTST(1), BSCH(1), GO(1), DF(1), EXIT(1), MAN(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        HELP(1)',CR,LF,LF,0
                
MDSPMANPAGE     DC.B    CR,LF,'MDSP(1)                       MC68000/SANPER-1 ELU                       MDSP(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   MDSP - Memory Display.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   MDSP <address1> <address2>',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   The MDSP (Memory Display) command outputs the address and memory contents from',CR,LF
                DC.B    '   <address1> to <address2>. The MDSP (Memory Display) command ALSO outputs the',CR,LF
                DC.B    '   address and memory contents from <address1> to <address1 + 16bytes>.',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   HELP(1), SORTW(1), MM(1), MS(1), BF(1), BMOV(1), BTST(1), BSCH(1), GO(1), DF(1), EXIT(1), MAN(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        MDSP(1)',CR,LF,LF,0
                
SORTWMANPAGE    DC.B    CR,LF,'SORTW(1)                       MC68000/SANPER-1 ELU                       SORTW(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   SORTW - Sort.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   SORTW <address1> <address2> [;order]',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   The SORT command sorts a block of memory. The starting address <address1> and the',CR,LF
                DC.B    '   ending address <address2> of the memory block are specified in the command. The order',CR,LF
                DC.B    '   (A or D) specifies whether the list is sorted in Ascending or Descending order. (The size of',CR,LF
                DC.B    '   the data to be sorted is a word)',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   HELP(1), MDSP(1), MM(1), MS(1), BF(1), BMOV(1), BTST(1), BSCH(1), GO(1), DF(1), EXIT(1), MAN(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        SORTW(1)',CR,LF,LF,0
                
MMMANPAGE       DC.B    CR,LF,'MM(1)                       MC68000/SANPER-1 ELU                       MM(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   MM - Memory Modify.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   MM <address> [;size]',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   MM (Memory Modify) command is used to display memory and, as required, modify data',CR,LF
                DC.B    '   or enter new data. The size (byte, word, long word) controls the number of bytes displayed',CR,LF
                DC.B    '   for each address.',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   HELP(1), MDSP(1), SORTW(1), MS(1), BF(1), BMOV(1), BTST(1), BSCH(1), GO(1), DF(1), EXIT(1), MAN(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        MM(1)',CR,LF,LF,0
                
MSMANPAGE       DC.B    CR,LF,'MS(1)                       MC68000/SANPER-1 ELU                       MS(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   MS - Memory Set.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   MS <address> [data]',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   The Memory Set (MS) command alters memory by setting data into the address specified. The',CR,LF
                DC.B    '   data can take the form of ASCII string or hexadecimal data.',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   HELP(1), MDSP(1), SORTW(1), MM(1), BF(1), BMOV(1), BTST(1), BSCH(1), GO(1), DF(1), EXIT(1), MAN(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        MS(1)',CR,LF,LF,0
                
BFMANPAGE       DC.B    CR,LF,'BF(1)                       MC68000/SANPER-1 ELU                       BF(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   BF - Block Fill.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   BF <address1> <address2> <word>',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   The Block Fill (BF) command fills memory starting with the word boundary <address1> through',CR,LF
                DC.B    '   <address2>. Both <address1> and <address2> must be even addresses. This command only',CR,LF
                DC.B    '   fills with a word-size (2 bytes) data pattern. If an entire word-size data pattern is not entered,',CR,LF
                DC.B    '   the pattern is right justified and leading zeros are inserted.',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   HELP(1), MDSP(1), SORTW(1), MM(1), MS(1), BMOV(1), BTST(1), BSCH(1), GO(1), DF(1), EXIT(1), MAN(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        BF(1)',CR,LF,LF,0
                
BMOVMANPAGE     DC.B    CR,LF,'BMOV(1)                       MC68000/SANPER-1 ELU                       BMOV(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   BMOV - Block Move.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   BMOV <address1> <address2> <address3>',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   The Block Move (BMOV) command is used to move (duplicate) blocks of memory from one area to another.',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   HELP(1), MDSP(1), SORTW(1), MM(1), MS(1), BF(1), BTST(1), BSCH(1), GO(1), DF(1), EXIT(1), MAN(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        BMOV(1)',CR,LF,LF,0
                
BTSTMANPAGE     DC.B    CR,LF,'BTST(1)                       MC68000/SANPER-1 ELU                       BTST(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   BTST - Block Test.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   BTST <address1> <address2>',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   The Block Test (BT) command is a destructive test of a block of memory beginning at <address1>',CR,LF
                DC.B    '   through <address2>. If this test runs to completion without detecting errors, and display a',CR,LF
                DC.B    '   message that no error was detected. If memory problems are found, a message is displayed',CR,LF
                DC.B    '   indicating the address, the data stored, and the data read of the failing memory.',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   HELP(1), MDSP(1), SORTW(1), MM(1), MS(1), BF(1), BMOV(1), BSCH(1), GO(1), DF(1), EXIT(1), MAN(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        BTST(1)',CR,LF,LF,0

BSCHMANPAGE     DC.B    CR,LF,'BSCH(1)                       MC68000/SANPER-1 ELU                       BSCH(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   BSCH - Block Search.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   BSCH <address1> <address2> "StringLiteral"',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   The BSCH (Block Search) command is used to search a literal string in a memory block starting',CR,LF
                DC.B    '   at <address1> through <address2> both inclusive. In BSCH command, if search finds matching data,',CR,LF 
                DC.B    '   the data and address(es) must be displayed.',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   HELP(1), MDSP(1), SORTW(1), MM(1), MS(1), BF(1), BMOV(1), BTST(1), GO(1), DF(1), EXIT(1), MAN(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        BSCH(1)',CR,LF,LF,0
                
GOMANPAGE       DC.B    CR,LF,'GO(1)                       MC68000/SANPER-1 ELU                       GO(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   GO - Execute Program.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   GO <address>',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   The GO command is used to start execution from a given address.',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   HELP(1), MDSP(1), SORTW(1), MM(1), MS(1), BF(1), BMOV(1), BTST(1), BSCH(1), DF(1), EXIT(1), MAN(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        GO(1)',CR,LF,LF,0
                
DFMANPAGE       DC.B    CR,LF,'DF(1)                       MC68000/SANPER-1 ELU                       DF(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   DF - Display Formatted Registers.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   DF',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   The Display Formatted Registers (DF) command is used to display the MC68000 processor registers.',CR,LF 
                DC.B    '   This command should display current PC, SR, US, SS and D, A registers.',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   HELP(1), MDSP(1), SORTW(1), MM(1), MS(1), BF(1), BMOV(1), BTST(1), BSCH(1), GO(1), EXIT(1), MAN(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        DF(1)',CR,LF,LF,0
                
EXITMANPAGE     DC.B    CR,LF,'EXIT(1)                       MC68000/SANPER-1 ELU                       EXIT(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   EXIT - Exit Monitor Program.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   EXIT',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   The EXIT command terminates/exits your Monitor program.',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   HELP(1), MDSP(1), SORTW(1), MM(1), MS(1), BF(1), BMOV(1), BTST(1), BSCH(1), GO(1), DF(1), MAN(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        EXIT(1)',CR,LF,LF,0
                
MANMANPAGE      DC.B    CR,LF,'MAN(1)                       MC68000/SANPER-1 ELU                       MAN(1)',CR,LF,LF
                
                DC.B    'NAME',CR,LF
                DC.B    '   MAN - An interface to the on-line reference manuals.',CR,LF,LF
                
                DC.B    'SYNOPSYS',CR,LF
                DC.B    '   MAN [command]',CR,LF,LF
                
                DC.B    'DESCRIPTION',CR,LF
                DC.B    '   MAN is the systems manual pager.',CR,LF,LF
                
                *DC.B    'OPTIONS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'NOTES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'FILES',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'ENVIRONMENT',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'DIAGNOSTICS',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                *DC.B    'BUGS',CR,LF
                *DC.B    '   none known atm',CR,LF,LF
                
                DC.B    'AUTHOR',CR,LF
                DC.B    '   Daniel H. Meves',CR,LF,LF
                
                *DC.B    'HISTORY',CR,LF
                *DC.B    '   none',CR,LF,LF
                
                DC.B    'SEE ALSO',CR,LF
                DC.B    '   HELP(1), MDSP(1), SORTW(1), MM(1), MS(1), BF(1), BMOV(1), BTST(1), BSCH(1), GO(1), DF(1), EXIT(1)',CR,LF,LF
                
                DC.B    'Daniel H. Meves                    27 April 2016                        MAN(1)',CR,LF,LF,0
                
    ORG     $3000
HELPPTR    DC.B    'HELP',0
MDSPPTR    DC.B    'MDSP',0
SORTWPTR   DC.B    'SORTW',0
MMPTR      DC.B    'MM',0
MSPTR      DC.B    'MS',0
BFPTR      DC.B    'BF',0
BMOVPTR    DC.B    'BMOV',0
BTSTPTR    DC.B    'BTST',0
BSCHPTR    DC.B    'BSCH',0
GOPTR      DC.B    'GO',0
DFPTR      DC.B    'DF',0
EXITPTR    DC.B    'EXIT',0
MANPTR     DC.B    'MAN',0

    ORG     $4000
HELPHDLR    DC.L   HELP
MDSPHDLR    DC.L   MDSP
SORTWHDLR   DC.L   SORTW
MMHDLR      DC.L   MM
MSHDLR      DC.L   MS
BFHDLR      DC.L   BF
BMOVHDLR    DC.L   BMOV
BTSTHDLR    DC.L   BTST
BSCHHDLR    DC.L   BSCH
GOHDLR      DC.L   GO
DFHDLR      DC.L   DF
EXITHDLR    DC.L   EXIT
MANHDLR     DC.L   MANHELP

    ORG     $4800
HELPSTR     DC.L    HELPOUT
MDSPSTR     DC.L    MDSPOUT
SORTWSTR    DC.L    SORTWOUT
MMSTR       DC.L    MMOUT
MSSTR       DC.L    MSOUT
BFSTR       DC.L    BFOUT
BMOVSTR     DC.L    BMOVOUT
BTSTSTR     DC.L    BTSTOUT
BSCHSTR     DC.L    BSCHOUT
GOSTR       DC.L    GOOUT
DFSTR       DC.L    DFOUT
EXITSTR     DC.L    EXITOUT
MANSTR      DC.L    MANOUT   
    
*-----------------------------------------------------------
* Main Program
*-----------------------------------------------------------
    ORG     $2000
START:                  ; first instruction of program
                LEA     PROMPT,A1
                MOVE.B  #14,D0
                TRAP    #15
        
                LEA     INPUTBUFFER,A2
                MOVE.L  #79,D2
CLRINBUF        CLR.B   (A2)+
                DBRA    D2,CLRINBUF

                LEA     CMDBUFFER,A3
                MOVE.L  #79,D3
CLRCMDBUF       CLR.B   (A3)+
                DBRA    D3,CLRCMDBUF  
        
                LEA     INPUTBUFFER,A1
                MOVE.B  #2,D0
                TRAP    #15
                
                JSR     INTERPRETER
                BRA     START   
    
*-----------------------------------------------------------
*Command Interpreter
*-----------------------------------------------------------
INTERPRETER     MOVEM.L A0-A7/D0-D7,-(SP)
 
                LEA     INPUTBUFFER,A1      ; pointer to command input
                MOVEA.L A1,A0
                ADDA.L  D1,A1               ; pointer to end of command input
                CLR.L   D2
                CLR.L   D3                  ; character counter
                 
                LEA     HELPPTR,A4          ; pointer to string table
                LEA     HELPHDLR,A5         ; pointer to jump table
NEXT            LEA     INPUTBUFFER,A3
                JSR     COMPARESTRING
                
                CMPI.B  #1,D4
                BEQ     HDLRJMP
                ADDA.W  #4,A5
                CMP.W  #$4034,A5
                BEQ     ERROR
                BRA     NEXT
                
HDLRJMP         MOVE.L  (A5),A6
                JSR     (A6)
                   
                MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
ERROR           LEA     ERRORMSG,A1
                MOVE.B  #14,D0
                TRAP    #15
                BRA     START

*-----------------------------------------------------------
* Compare Strings
* INPUT: (A3) = STRING 1, (A4) = STRING 2
* OUTPUT: D4=1 IF STRINGS MATCH, ELSE D4=0
*-----------------------------------------------------------
COMPARESTRING   MOVEM.L A0-A2/A5-A7/D0-D3/D5-D7,-(SP)
                CLR.L   D4
                
                CMP.B   #NULL,(A3)
                BEQ     START
                
COMPARELOOP     CMPI.B  #SP,(A3)
                BEQ     COMPARELIST
                
                CMPI.B  #CR,(A3)
                BEQ     COMPARELIST
                
                CMPI.B  #NULL,(A3)
                BEQ     COMPARELIST
                
                CMPM.B  (A3)+,(A4)+
                BEQ     COMPARELOOP
                
                JSR     NULLJMP
                MOVE.B  #0,D4
                MOVEM.L (SP)+,A0-A2/A5-A7/D0-D3/D5-D7
                RTS     
                
COMPARELIST     CMPI.B  #NULL,(A4)+
                BEQ     MATCH
                
                MOVE.B  #0,D4
                BRA     RETURN
                
MATCH           MOVE.B  #1,D4
                
RETURN          MOVEM.L (SP)+,A0-A2/A5-A7/D0-D3/D5-D7
                RTS

NULLJMP         MOVEM.L A0-A3/A5-A7/D0-D7,-(SP)
NULLLOOP        CMPI.B  #NULL,(A4)+
                BNE     NULLLOOP
                MOVEM.L (SP)+,A0-A3/A5-A7/D0-D7
                RTS
                
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
                CMP.W  #$4834,A5
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
                CMP.W  #$4834,A5
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
                
                LEA     CMDMSG2,A1
                MOVE.B  #14,D0
                TRAP    #15
                
ENDHELP         MOVEM.L (SP)+,A0-A7/D0-D7
                RTS
                
*-----------------------------------------------------------
* Check for Dollarsign and Convert Argument to Hex
* A0 = ptr to command buffer, incremented by INDEX
* D3 = output               A4 = ptr to output
* D2 = 1 - INVALID ADDRESS, 0 - VALID ADDRESS
* D4 = 0 - HEX VALUE, 1 - NON HEX VALUE
* D5 - LENGTH OF STRING
*-----------------------------------------------------------
CHKDOLLAR   MOVEM.L A0-A3/A5-A7/D0-D1/D6-D7,-(SP)
            CLR.L   D2
            CLR.L   D3
            
            CMPI.B  #HEX,(A0)
            BEQ     DOLLARSIGN
            BRA     ARGPTR
DOLLARSIGN  ADDA.W  #1,A0         
ARGPTR      MOVEA.L A0,A5

CMPNULL     ADDI.B  #1,D3
            CMPI.B  #NULL,(A0)+
            BEQ     ENDPTR
            BRA     CMPNULL
ENDPTR      SUBI.B  #1,D3
            SUBA.W  #1,A0
            MOVEA.L A0,A6
            CMPI.B  #8,D3
            BLE     SAFE
            MOVE.L  #1,D2
            JSR     ASCII2HEX
            LEA     ADDRERROR,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     INVALIDADDR
                 
SAFE        MOVE.L  #0,D2
            JSR     ASCII2HEX

INVALIDADDR MOVEM.L (SP)+,A0-A3/A5-A7/D0-D1/D6-D7
            RTS

*-----------------------------------------------------------
* MDSP Print Loop
* A2 = ptr to beginning memory A3 = ptr to ending memory
*-----------------------------------------------------------
MDSPPRINT   MOVEM.L A0-A7/D0-D7,-(SP)

INCREMENT   MOVE.L  A2,(A5)
            ADDA.W  #4,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.W  #8,D1  
            MOVE.B  #1,D0
            TRAP    #15
            LEA     SPACE,A1
            MOVE.B  #14,D0
            TRAP    #15
            MOVE.B  (A2),(A5)
            LEA     BUFFER,A6
            ADDA.W  #1,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.W  #2,D1  
            MOVE.B  #0,D0
            TRAP    #15
            ADDA.W  #1,A2
            CMP.L   A2,A3
            BNE     INCREMENT
            
            MOVEM.L (SP)+,A0-A7/D0-D7
            RTS


*-----------------------------------------------------------
* MDSP (Memory Display) - The MDSP (Memory Display) command
* outputs the address and memory contents from <address1> to
* <address2>. The MDSP (Memory Display) command ALSO outputs
* the address and memory contents from <address1> to <address1 + 16bytes>
*-----------------------------------------------------------
MDSP        MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     INPUTBUFFER,A0
            ADDA.W  #5,A0
MDSPONLY    ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTMDSP
            CMP.B   #SP,(A0)
            BEQ     MDSPONLY
            CMP.B   #NULL,(A0)
            BEQ     MDSPONLY
            BRA     MDSPCONT
            
PRTMDSP     LEA     MDSPMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     MDSPDONE
            
MDSPCONT    CLR.L   D3
            JSR     ARGV
            MOVE.L  D2,D6
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            
            MOVE.L  (A4),$1100
            
            CMPI.B  #2,D6
            BEQ     ARG1
            
            CMPI.B  #3,D6
            BEQ     ARG2
            
ARG1        LEA     ASCIIBUFFER,A0
            MOVEA.L (A0),A2
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            MOVEA.L A2,A3
            ADDA.W  #16,A3
            
            JSR     MDSPPRINT
            
            BRA     MDSPDONE
         
ARG2        LEA     CMDBUFFER,A0
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            JSR     CHKDOLLAR
            
            LEA     $1100,A0
            LEA     ASCIIBUFFER,A1
            MOVEA.L (A0),A2
            MOVEA.L (A1),A3
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            
            JSR     MDSPPRINT
            
MDSPDONE    MOVEM.L (SP)+,A0-A7/D0-D7
            RTS

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
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     SORTWDONE
            MOVEA.L (A4),A1
            
            LEA     CMDBUFFER,A0
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     SORTWDONE
            MOVEA.L A1,A0
            MOVEA.L (A4),A1
            
            LEA     CMDBUFFER,A2
            MOVE.B  #3,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A2
            
            CMP.B   #'A',(A2)
            BEQ     ASCENDING
            
            CMP.B   #'D',(A2)
            BEQ     DESCENDING
            
            LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     SORTWDONE
            
ASCENDING   MOVE.L  #1,D1
            BRA     BSORT
            
DESCENDING  MOVE.L  #0,D1
            
BSORT       JSR     BUBBLESORT
        
SORTWDONE   MOVEM.L (SP)+,A0-A7/D0-D7
            RTS

*-----------------------------------------------------------
* MM Print Loop
* A2 = ptr to beginning memory A3 = ptr to ending memory
* D2 = SIZE OF MEMORY OUTPUT D4 = LENGTH OF OUTPUT
*-----------------------------------------------------------
MMPRINT     MOVEM.L A0-A7/D0-D7,-(SP)

INCREMENT2  MOVE.L  A2,(A5)
            ADDA.W  #4,A6
            JSR     HEX2ASCII
            
            MOVEA.L A4,A1
            MOVE.B  #8,D1
            MOVE.B  #1,D0
            TRAP    #15
            
            LEA     SPACE,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            CMP.B   #1,D2
            BEQ     BYTEPRINT
            
            CMP.B   #2,D2
            BEQ     WORDPRINT
            
            CMP.B   #4,D2
            BEQ     LONGPRINT
            
BYTEPRINT   MOVE.B  (A2),(A5)
            LEA     BUFFER,A6
            ADDA.W  D2,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.L  D6,D1  
            MOVE.B  #1,D0
            TRAP    #15
            
            LEA     SPACE,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            LEA     BUFFER,A1
            MOVE.B  #2,D0
            TRAP    #15
            
            CMPI.B  #'.',(A1)
            BEQ     MMPRINTDN
            
            CMP.B   #0,D1
            BEQ     BYTECONT

            CMP.B   D6,D1
            BNE     MMERROR
            
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  D6,A6
            JSR     ASCII2HEX
            ADDA.W  #3,A4
            MOVE.B  (A4),(A2)
            
BYTECONT    ADDA.W  D2,A2
            BRA     INCREMENT2
            
WORDPRINT   MOVE.W  (A2),(A5)
            LEA     BUFFER,A6
            ADDA.W  D2,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.L  D6,D1  
            MOVE.B  #1,D0
            TRAP    #15
            
            LEA     SPACE,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            LEA     BUFFER,A1
            MOVE.B  #2,D0
            TRAP    #15
            
            CMPI.B  #'.',(A1)
            BEQ     MMPRINTDN

            CMP.B   #0,D1
            BEQ     WORDCONT    

            CMP.B   D6,D1
            BNE     MMERROR
            
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  D6,A6
            JSR     ASCII2HEX
            ADDA.W  #2,A4
            MOVE.W (A4),(A2)
            
WORDCONT    ADDA.W  D2,A2
            BRA     INCREMENT2
            
LONGPRINT   MOVE.L  (A2),(A5)
            LEA     BUFFER,A6
            ADDA.W  D2,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.L  D6,D1  
            MOVE.B  #1,D0
            TRAP    #15
            
            LEA     SPACE,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            LEA     BUFFER,A1
            MOVE.B  #2,D0
            TRAP    #15
            
            CMPI.B  #'.',(A1)
            BEQ     MMPRINTDN
            
            CMP.B   #0,D1
            BEQ     LONGCONT
        
            CMP.B   D6,D1
            BNE     MMERROR
            
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            ADDA.W  D6,A6
            JSR     ASCII2HEX
            MOVE.L  (A4),(A2)
            
LONGCONT    ADDA.W  D2,A2
            BRA     INCREMENT2

MMERROR     LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15    
            
MMPRINTDN   MOVEM.L (SP)+,A0-A7/D0-D7
            RTS


*-----------------------------------------------------------
* MM (Memory Modify) - MM (Memory Modify) command is used to display memory and,
* as required, modify data or enter new data. The size (bye, word, long word) controls
* the number of bytes displayed for each address.
*
*-----------------------------------------------------------
MM          MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     INPUTBUFFER,A0
            ADDA.W  #3,A0
MMONLY      ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTMM
            CMP.B   #SP,(A0)
            BEQ     MMONLY
            CMP.B   #NULL,(A0)
            BEQ     MMONLY
            BRA     MMCONT
            
PRTMM       LEA     MMMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     MMDONE

MMCONT      JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     MMDONE
            MOVEA.L (A4),A1
            
            LEA     CMDBUFFER,A2
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A2
            
            CMP.B   #'B',(A2)
            BEQ     BYTE
            
            CMP.B   #'W',(A2)
            BEQ     WORD
            
            CMP.B   #'L',(A2)
            BEQ     LONG
            
            LEA     ERRORMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     MMDONE
            
BYTE        MOVE.L  #1,D2
            MOVE.L  #2,D6
            MOVEA.L A1,A2
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            JSR     MMPRINT
            BRA     MMDONE
            
WORD        MOVE.L  #2,D2
            MOVE.L  #4,D6
            MOVEA.L A1,A2
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            JSR     MMPRINT
            BRA     MMDONE
            
LONG        MOVE.L  #4,D2
            MOVE.L  #8,D6
            MOVEA.L A1,A2
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            JSR     MMPRINT

MMDONE      MOVEM.L (SP)+,A0-A7/D0-D7
            RTS

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
            SUBA.W  #1,A4
            MOVE.L  (A4),(A2)
            
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

*-----------------------------------------------------------
* BF (Block Fill) - The Block Fill (BF) command fills memory starting with the word
* boundary <address1> through <address2>. Both <address1> and <address2> must be even
* addresses. This command only fills with a word-size (2 bytes) data pattern. If an entire
* word-size data pattern is not entered, the pattern is right justified and leading zeros are inserted.
*-----------------------------------------------------------
BF          MOVEM.L A0-A7/D0-D7,-(SP)
            
            LEA     INPUTBUFFER,A0
            ADDA.W  #3,A0
BFONLY      ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTBF
            CMP.B   #SP,(A0)
            BEQ     BFONLY
            CMP.B   #NULL,(A0)
            BEQ     BFONLY
            BRA     BFCONT
            
PRTBF       LEA     BFMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     BFDONE

BFCONT      CLR.L   D6
            JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BFDONE
            MOVEA.L (A4),A1
            
            MOVE.L  A1,D2
            DIVU    #2,D2
            SWAP    D2
            CMP.W   #0,D2
            BNE     ODDADDR1
            
CHKADDR2    LEA     CMDBUFFER,A0
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BFDONE
            MOVEA.L (A4),A2
            
            MOVE.L  A2,D2
            DIVU    #2,D2
            SWAP    D2
            CMP.W   #0,D2
            BNE     ODDADDR2
            
            CMP.B   #1,D6
            BEQ     BFDONE
            
            LEA     CMDBUFFER,A0
            MOVE.B  #3,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BFDONE
            MOVEA.L (A4),A3
            
            CMP.B   #4,D5
            BEQ     FILLLOOP
            BGT     DATALONG
        
FILLLOOP    MOVE.W  A3,(A1)+
            CMP.L   A1,A2
            BNE     FILLLOOP
            BRA     BFDONE
            
DATALONG    LEA     DATALONGMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     BFDONE

ODDADDR1    MOVE.L  #1,D6
            LEA     ODDADDRMSG1,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     CHKADDR2
            
ODDADDR2    LEA     ODDADDRMSG2,A1
            MOVE.B  #14,D0
            TRAP    #15           
                
BFDONE      MOVEM.L (SP)+,A0-A7/D0-D7
            RTS

*-----------------------------------------------------------
* BMOV (Block Move) - The Block Move (BMOV) command is used to move (duplicate) blocks
* of memory from one area to another.
*
*
*-----------------------------------------------------------
BMOV        MOVEM.L A0-A7/D0-D7,-(SP)

            LEA     INPUTBUFFER,A0
            ADDA.W  #5,A0
BMOVONLY    ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTBMOV
            CMP.B   #SP,(A0)
            BEQ     BMOVONLY    
            CMP.B   #NULL,(A0)
            BEQ     BMOVONLY
            BRA     BMOVCONT
            
PRTBMOV     LEA     BMOVMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     BMOVDONE

BMOVCONT    JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BMOVDONE
            MOVEA.L (A4),A1
            
            LEA     CMDBUFFER,A0
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BMOVDONE
            MOVEA.L (A4),A2
            
            LEA     CMDBUFFER,A0
            MOVE.B  #3,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BMOVDONE
            MOVEA.L (A4),A3
            
BMOVLOOP    MOVE.B  (A1)+,(A3)+
            CMP.L   A1,A2
            BNE     BMOVLOOP
        
BMOVDONE    MOVEM.L (SP)+,A0-A7/D0-D7
            RTS

*-----------------------------------------------------------
* BTST (Block Test) - The Block Test (BT) command is a destructive test of a block of memory
* beginning at <address1> through <address2>. If this test runs to completion without detecting
* errors, and display a message that no error was detected. If memory problems are found, a message
* is displayed indicating the address, the data stored, and the data read of the failing memory.
*-----------------------------------------------------------
BTST        MOVEM.L A0-A7/D0-D7,-(SP)
        
            LEA     INPUTBUFFER,A0
            ADDA.W  #5,A0
BTSTONLY    ADDA.W  #1,A0
            ADD.B   #1,D4
            CMP.B   #3,D4
            BGE     PRTBTST
            CMP.B   #SP,(A0)
            BEQ     BTSTONLY
            CMP.B   #NULL,(A0)
            BEQ     BTSTONLY
            BRA     BTSTCONT
            
PRTBTST     LEA     BTSTMSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     BTSTDONE

BTSTCONT    JSR     ARGV
            LEA     CMDBUFFER,A0
            ADDA.W  #INDEX,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BMOVDONE
            MOVEA.L (A4),A1
            MOVEA.L (A4),A3
            
            LEA     CMDBUFFER,A0
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BMOVDONE
            MOVEA.L (A4),A2
            
BTSTLOOP    MOVE.B  #TESTVAL1,(A1)+
            CMP.L   A1,A2
            BNE     BTSTLOOP
            
MEMCHKLP    CMP.B   #TESTVAL1,(A3)
            BNE     ERRORDETECT
         
            LEA     MEMSUCCESS,A1
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
            
            ADDA.W  #1,A3
            CMP.L   A3,A2
            BNE     MEMCHKLP
            BRA     BTSTDONE
            
ERRORDETECT LEA     MEMERROR,A1
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
            
            LEA     DATASTORED,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            MOVE.B  #TESTVAL1,(A5)
            ADDA.W  #1,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     DATAREAD,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            LEA     BUFFER,A5
            LEA     BUFFER,A6
            MOVE.B  (A3),(A5)
            ADDA.W  #1,A6
            JSR     HEX2ASCII
            MOVEA.L A4,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            ADDA.L  #1,A3
            CMP.L   A3,A2
            BNE     MEMCHKLP
        
BTSTDONE    MOVEM.L (SP)+,A0-A7/D0-D7
            RTS

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
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BSCHDONE
            MOVEA.L (A4),A1
            
            LEA     CMDBUFFER,A0
            MOVE.B  #2,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            
            JSR     CHKDOLLAR
            CMP.B   #1,D2
            BEQ     BSCHDONE
            MOVEA.L (A4),A2
            
            LEA     CMDBUFFER,A0
            MOVE.B  #3,D0
            MOVE.B  #INDEX,D1
            MULU    D0,D1
            ADDA.W  D1,A0
            CMP.B   #SINGLEQUOTE,(A0)
            BEQ     ADD1
            CMP.B   #DOUBLEQUOTE,(A0)
            BEQ     ADD1
            BRA     STRINGCONT
ADD1        ADDA.W  #1,A0

STRINGCONT  MOVEA.L A0,A3
            CMP.B   (A1)+,(A3)+

        
BSCHDONE    MOVEM.L (SP)+,A0-A7/D0-D7
            RTS

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

GOCONT
        
GODONE      MOVEM.L (SP)+,A0-A7/D0-D7
            RTS

*-----------------------------------------------------------
* DF (Display Formatted Registers) - The Display Formatted Registers (DF) command is used
* to display the MC68000 processor registers. This command should display current PC, SR, US,
* SS and D, A registers. Note that since your program will be using D and A registers, those 
* changed values should not be shown to the user. Thus, you must save all D and A register
* values before any of your subroutines.
*-----------------------------------------------------------
DF          MOVEM.L A0-A7/D0-D7,-(SP)

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
        
DFDONE      MOVEM.L (SP)+,A0-A7/D0-D7
            RTS

*-----------------------------------------------------------
* EXIT (Exit Monitor Program) - The EXIT command terminates/exits your Monitor program.
*
*
*
*-----------------------------------------------------------
EXIT        MOVEM.L A0-A7/D0-D7,-(SP)

*            LEA     INPUTBUFFER,A0
*            ADDA.W  #5,A0
*EXITONLY    ADDA.W  #1,A0 
*            ADD.B   #1,D4
*            CMP.B   #3,D4
*            BGE     PRTEXIT
*            CMP.B   #SP,(A0)
*            BEQ     EXITONLY
*            CMP.B   #NULL,(A0)
*            BEQ     EXITONLY
*            BRA     EXITCONT
            
*PRTEXIT     LEA     EXITMSG,A1
*            MOVE.B  #14,D0
*            TRAP    #15
*            BRA     EXITDONE

*EXITCONT    
            MOVE.B  #9,D0
            TRAP    #15
        
EXITDONE    MOVEM.L (SP)+,A0-A7/D0-D7
            RTS
        
*-----------------------------------------------------------
* ARGV Command Line Parsing Subroutine
* Stores Commands separated by INDEX (12) in memory starting at CMDBUFFER
* D2 = # of Arguments
*-----------------------------------------------------------

ARGV        MOVEM.L A0-A7/D0-D1/D3-D7,-(SP)

            LEA     INPUTBUFFER,A0
            LEA     CMDBUFFER,A1
            LEA     CMDBUFFER,A2
            CLR.L   D2
CHECKLOOP   MOVE.B  (A0),(A1)+
            CMPI.B  #SP,(A0)
            BEQ     SPFOUND
            CMPI.B  #NULL,(A0)+
            BEQ     NULLFOUND
            BRA     CHECKLOOP
                     
SPFOUND     SUBA.W  #1,A1
            MOVE.B  #NULL,(A1)
            ADDA.W  #1,A1
            ADDA.W  #1,A0
            ADDI.B  #1,D2
            ADDA.W  #INDEX,A2
            MOVEA.L A2,A1
            BRA     CHECKLOOP
    
NULLFOUND   ADDI.B  #1,D2
            MOVEM.L (SP)+,A0-A7/D0-D1/D3-D7
            RTS
        
*-----------------------------------------------------------
*ASCII TO HEX CONVERSION SUBROUTINE
* A5 = ptr to beginning address A6 = ptr to ending address
* D3 = output D4 = 0 - HEX VALUE, 1 - NON HEX VALUE 
* D5 - LENGTH OF STRING  A4 = ptr to output
*-----------------------------------------------------------
ASCII2HEX   MOVEM.L A0-A3/A5-A7/D0-D2/D6-D7,-(SP)
            
            MOVEA.L #ASCIIBUFFER,A4
            CLR.L   D3
            CLR.L   D5            
ASCIILOOP   CLR.L   D2      
            CMP.L   A5,A6
            BEQ     ASCIIDONE
            ADD.B   #1,D5
            MOVE.B  (A5)+,D2
            CMPI.B  #'0',D2
            BLT     ASCIIRANGE
            CMPI.B  #'F',D2
            BGT     ASCIIRANGE
            CMPI.B  #'9',D2
            BLE     ASCIINUMBER
            CMPI.B  #'A',D2
            BGE     ASCIILETTER
            BRA     ASCIIRANGE
ASCIILETTER SUBI.B  #$37,D2
            OR.B    D2,D3
            ROL.L   #4,D3
            BRA     ASCIILOOP
ASCIINUMBER SUBI.B  #$30,D2
            OR.B    D2,D3
            ROL.L   #4,D3
            BRA     ASCIILOOP
ASCIIRANGE  MOVE.L  #1,D4
            LEA     ASCIIERROR,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     ASCIIFIN       
ASCIIDONE   MOVE.L  #0,D4
            ROR.L   #4,D3
            MOVE.L  D3,(A4)
            
ASCIIFIN    MOVEM.L (SP)+,A0-A3/A5-A7/D0-D2/D6-D7
            RTS

*-----------------------------------------------------------
*HEX TO ASCII CONVERSION SUBROUTINE
* A5 = ptr to beginning address A6 = ptr to ending address
* D3 = output                   A4 = ptr to output
*-----------------------------------------------------------
HEX2ASCII   MOVEM.L A0-A3/A5-A7/D0-D2/D4-D7,-(SP)

            CLR.L   D2
            CLR.L   D3
            LEA     HEXBUFFER,A4
            MOVE.B  #NULL,(A4)
NEXTHEX     CLR.L   D4
            MOVE.B  #1,D4
            CMP.L   A5,A6
            BEQ     HEXDONE
            MOVE.B  -(A6),D2
            MOVE.B  D2,D3
HEXLOOP     MOVE.B  D3,D2
            AND.L   #$0000000F,D2
            CMPI.B  #$0,D2
            BLT     HEXRANGE
            CMPI.B  #$F,D2
            BGT     HEXRANGE
            CMPI.B  #$9,D2
            BLE     HEXNUMBER
            CMPI.B  #$A,D2
            BGE     HEXLETTER
            BRA     HEXRANGE
HEXLETTER   ADDI.B  #$37,D2
            MOVE.B  D2,-(A4)
            ROR.L   #4,D3
            DBRA    D4,HEXLOOP
            BRA     NEXTHEX
HEXNUMBER   ADDI.B  #$30,D2
            MOVE.B  D2,-(A4)
            ROR.L   #4,D3
            DBRA    D4,HEXLOOP
            BRA     NEXTHEX
HEXRANGE    LEA     HEXERROR,A1
            MOVE.B  #14,D0
            TRAP    #15

HEXDONE     MOVEM.L (SP)+,A0-A3/A5-A7/D0-D2/D4-D7
            RTS
           
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source










*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
