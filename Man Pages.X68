        ORG     $4000
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



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
