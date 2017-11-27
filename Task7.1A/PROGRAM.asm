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
#include  ECH_1.inc
		

; Place your SUBROUTINE(S) (if any) here ...  
;{ 
ISR	
	banksel INTCON
	btfsc  INTCON,INTF  ;check whether external int occured
	bsf	LEDs,LD0
	retfie	; replace retfie with your ISR if necessary
;} end of your subroutines


; Provided code - do not edit  
Main	nop
#include  ECH_INIT.inc

; Place your INITIALISATION code (if any) here ...   
;{ ***		***************************************************
; e.g.,		movwf	Ctr1 ; etc
	
	banksel INTCON
	movlw	B'10010000'    ; bit7 Enable GLobal Interrupt, bit4 Enable External Interrupt	
	movwf	INTCON
	banksel OPTION_REG
	bcf	OPTION_REG,INTEDG  ;clear INTEDG to enable falling edge of INT pin
  

;} 
; end of your initialisation

MLoop	nop

; place your superloop code here ...  
;{


;}	
; end of your superloop code

    goto	MLoop

end
