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
MULT	    nop
	    decf	 MULT2
MultLoop    addwf	 MULT1
	    decfsz	 MULT2	
	    goto	 MultLoop
	    
	    movf	 MULT1,W
	
	return
	
;} end of your subroutines


; Provided code - do not edit  
Main	nop
#include ECH_INIT.inc

; Place your INITIALISATION code (if any) here ...   
;{ ***		***************************************************
; e.g.,		movwf	Ctr1 ; etc


;} 
; end of your initialisation

MLoop	nop

; place your superloop code here ...  
;{
	bsf	LEDs,LD7
	call	SelectB
	movwf	A
	
	bcf	LEDs,LD7
	bsf	LEDs,LD6
	call	SelectB
	movwf	Bop
	
	movlw	D'7'       ; w = 7
	movwf	MULT2	   ; MULT2 = w -> MULT2 = 7
	movf	A, W	   ; w = A 
	movwf	MULT1	   ; MULT1 = w -> MULT1 = A
	call	MULT       ; W = MULT1 * MULT2 -> W = A * 7
	iorwf  Bop, W	   ; W = W|Bop -> W = ( A*7 )| Bop
	
	movwf	LEDs
	bsf	LEDs,LD7
	bsf	LEDs,LD6

	;make sure that it stop and run another time after press button	
Stop1	skipPre
	goto	Stop1
	bcf	LEDs,LD6
	bcf	LEDs,LD7
Stop2	skipRel
	goto  Stop2
	

;}	
; end of your superloop code

    goto	MLoop

end
