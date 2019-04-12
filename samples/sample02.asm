; Sample 6809 program from 'Language Of The Dragon - 6809 Assembler'
; written by Mike James and published by Sigma Technical Press in 1983
; Corrected by Tony Smith, 2019
@START      ORG     $7000
            BSR     @UPDATE
            LBSR    @UPBAT
            LBSR    @BBOUNCE
            LDA     #$80
            STA     @CHAR
            BSR     @DRAW
            BSR     @DBAT
            BSR     @DELAY
            LDA     #$8F
            STA     @CHAR
            BSR     @DRAW
            BSR     @DBAT
            BRA     @START

@XCORD      FCB     0
@YCORD      FCB     0
@XVEL       FCB     1
@YVEL       FCB     1
@CHAR       FCB     0
@SCREEN     FDB     0
@ADDRESS    FDB     0
@XBAT       FCB     12
@UPDATE     LDA     @XCORD
            ADDA    @XVEL
            STA     @XCORD
            BNE     @SKIP1
            NEG     @XVEL
@SKIP1      CMPA    #31
            BNE     @SKIP2
            NEG     @XVEL
@SKIP2      LDA     @YCORD
            ADDA    @YVEL
            STA     @YCORD
            BNE     @SKIP3
            NEG     @YVEL
@SKIP3      CMPA    #15
            BNE     @SKIP4
            NEG     @YVEL
@SKIP4      RTS

@DRAW       LDB     @YCORD
            CLRA
            ASLB
            ASLB
            ASLB
            ASLB
            ASLB
            ROLA
            ADDB    @XCORD
            ADCA    #$00
            ADDD    #$0400
            STD     @SCREEN
            LDX     @SCREEN
            LDA     @CHAR
            STA     ,X
            RTS

@DELAY      LDD     @TIME
@DLOOP      SUBD    #1
            BNE @DLOOP
            RTS

@TIME       FDB     $1000
@DBAT       LDB     @XBAT
            CLRA
            ADDD    #$05C0
            STD     @ADDRESS
            LDX     @ADDRESS
            LDA     @CHAR
            STA     ,X
            LDD     @ADDRESS
            ADDD    #1
            STD     @ADDRESS
            LDX     @ADDRESS
            LDA     @CHAR
            STA     ,X
            LDD     @ADDRESS
            ADDD    #1
            STD     @ADDRESS
            LDX     @ADDRESS
            LDA     @CHAR
            STA     ,X
            RTS

@UPBAT      JSR     @KEYB
            BEQ     @REPKEY
            CMPA    #$08
            BNE     @RARR
            LDB     @XBAT
            BEQ     @REPKEY
            DEC     @XBAT
@RARR       CMPA    #$09
            BNE     @REPKEY
            LDB     @XBAT
            CMPB    #29
            BEQ     @REPKEY
            INC     @XBAT
@REPKEY     LDA     #$FF
            STA     @ROLL
            STA     @ROLL2
            STA     @ROLL3
            RTS

@ROLL       EQU     $151
@ROLL2      EQU     $157
@ROLL3      EQU     $158
@KEYB       EQU     $8006

@BBOUNCE    LDA     @YCORD
            CMPA    #13
            BNE     @NBOUNCE
            LDA     @XCORD
            SUBA    @XBAT
            BMI     @NBOUNCE
            CMPA    #2
            BGT     @NBOUNCE
            NEG     @YVEL
@NBOUNCE    RTS
