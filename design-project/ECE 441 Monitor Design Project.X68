*-----------------------------------------------------------
* Title      : ECE 441 Monitor Design Project
* Written by : Daniel H. Meves
* Date       : 03/21/2016 - 04/27/2016
* Description: Command driven interpreter/shell
*-----------------------------------------------------------
    
    ORG $08
    DC.L    BUSERRHDLR
    ORG $0C
    DC.L    ADDERRHDLR
    ORG $10
    DC.L    ILLINSTHDLR
    ORG $20
    DC.L    PRIV_VHDLR
    ORG $14
    DC.L    DIV_ZHDLR
    ORG $18
    DC.L    CHK_IHDLR
    ORG $28
    DC.L    LINE_AHDLR
    ORG $2C
    DC.L    LINE_FHDLR

    ORG    $1000
    
    INCLUDE "Constants.X68"
    
    INCLUDE "Random Strings.X68"
                                
    INCLUDE "Jump Tables.X68"
    
    INCLUDE "MAIN.X68"   
    
    INCLUDE "Command Interpreter.X68"

    INCLUDE "Compare Strings.X68"
                
    INCLUDE "HELP.X68"            
                
    INCLUDE "CHKDOLLAR.X68"

    INCLUDE "MDSP.X68"

    INCLUDE "SORTW.X68"

    INCLUDE "MM.X68"
    
    INCLUDE "MS.X68"

    INCLUDE "BF.X68"

    INCLUDE "BMOV.X68"

    INCLUDE "BTST.X68"

    INCLUDE "BSCH.X68"

    INCLUDE "GO.X68"

    INCLUDE "DF.X68"

    INCLUDE "EXIT.X68"

    INCLUDE "Change Registers.X68"
    
    INCLUDE "CLEAR.X68"
    
    INCLUDE "Command History.X68"
    
    INCLUDE "ARGV.X68"
        
    INCLUDE "ASCII2HEX.X68"

    INCLUDE "HEX2ASCII.X68"
    
    INCLUDE "Exception Handlers.X68"
    
    INCLUDE "Man Pages.X68"
           
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source



















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
