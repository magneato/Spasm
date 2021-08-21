*
* This is a sample program
* NOTE all comments go after a semi-colon
*

tab_len     EQU $FF             ; Table length
object      EQU $EE01           ; Object address
entlen      EQU $08             ; Table entry length
search      LDB #tab_len
            BEQ exit            ; Exit if the table length is zero
            LDY #object
            LDX #store
loop        PSHS B              ; start loop
            LDA #$2
nextch      LDB A,Y
            CMPA B,X
            LEAX 3,X
            CMPA $2A,Y
            BNE nexten          ; break out of loop
            DECB
            BPL nextch
            PULS B
            LDA #$FF
            RTS
nexten      PULS B
            DECB
            BEQ exit
            LEAX entlen,X       ; Interesting problem: this could add 0, 1 or 2
                                ; bytes depending on the value of entlen, which
                                ; might not have been specified on the first pass
exit        CLRA
store       RMB entlen
            RTS                 ; return
