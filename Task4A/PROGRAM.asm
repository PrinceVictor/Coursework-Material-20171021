; operating BUILD CONFIGURATIONS drop down menu in the DEBUG toolbar
; FOR SIMULATIONS with MPLAB SIM: select "Debug" this will switch off delays that take thousands of instructions
; HARDWARE: select "Release" all delays will be on

; Provided code - do not edit  
; This include setups up various configuration bits for the microcontroller
; we are using, and importantly reserves space for variables.
; If you need to use more variables, please place them in VAR.INC, which you
; can find under the "Header Files" folder. The variables listed there will be
; placed in the first memory bank.
; This code has been provided for you to simplify your work, but you should be
; aware that you cannot ignore it.
#include	ECH_1.inc
		

; Place your SUBROUTINE(S) (if any) here ...  
;{ 
ISR	retfie	; replace retfie with your ISR if necessary
;} end of your subroutines
TEST
    btfsc   Input,0
    goto    Position0
    btfsc   Input,1
    retlw   B'10100000'
    btfsc   Input,2
    retlw   B'11100000'
    btfsc   Input,3
    retlw   B'10100000'
 
 
Position0
    call    Morse_Dash
    call    Morse_Dash
    call    Morse_Dot
    call    Morse_Dot
    call    Morse_Dot
    goto    Delay


Morse_Dash
    bsf	    LEDs,LD7
    movlw  D'9'
    call   DelWds
    bcf	    LEDs,LD7
    movlw  D'3'
    call   DelWds
    return
    
Morse_Dot
    bsf	    LEDs,LD7
    movlw  D'3'
    call   DelWds
    bcf	    LEDs,LD7
    movlw  D'3'
    call   DelWds
    return
 


; Provided code - do not edit  
Main	nop
#include ECH_INIT.inc

; Place your INITIALISATION code (if any) here ...   
;{ ***		***************************************************
; e.g.,		movwf	Ctr1 ; etc
Input	Res	1

;} 
; end of your initialisation

MLoop	nop

; place your superloop code here ...  
;{	
	clrf	LEDs
	call	Select4
	movwf	Input
	call	TEST
	movwf	LEDs
Delay
	movlw	D'30'
	call	DelWds

;}	
; end of your superloop code

    goto	MLoop

end
