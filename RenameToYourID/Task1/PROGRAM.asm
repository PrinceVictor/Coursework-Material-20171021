; *** SOME INFORMATION AND INITIALISATION HERE ***   ;{

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

LUT     ;addwf   PCL,F 
        retlw   B'00000000' 
        retlw   B'00000001' 
	retlw   B'00000010' 
        retlw   B'00000011'
	retlw   B'00000111' 
        retlw   B'00000111' 
        retlw   B'00000111' 
        retlw   B'00000111' 
        retlw   B'00001110' 
        retlw   B'00001111' 
        retlw   B'00001111' 
        retlw   B'00001111' 
        retlw   B'00010101' 
        retlw   B'00010101' 
        retlw   B'00010111' 
        retlw   B'00010111' 

;}
; end of your subroutines

; Provided code - do not edit  
Main	nop
	
; This include contains code that runs each time your board is turned on, such 
; as configuring the pins, peripherals and flashing the LEDs. Read it to
; understand what is going on.
#include ECH_INIT.inc

; Place your INITIALISATION code (if any) here ...   
;{ ***		***************************************************
; e.g.,		movwf	Ctr1 ; etc


;} 
; end of your initialisation


MLoop	nop

; place your superloop code here ...  
;{

	;	enter A
	bsf	LEDs,LD7
	call	SelectB
	movwf	A

	; Place your code to read a value for B. A variable 'Bop' is 
	; available for you to use. Don't forget to set the LEDs
	; appropriately (LD7 off, LD6 on)

	bcf	LEDs,LD7
	bsf	LEDs,LD6
	call	SelectB
	movwf	Bop
	; Place your code here to combine A and B together as follows:
	; [0 0 0 0  A_MSB A_LSB B_MSB B_LSB]

	rlf	A, F	    ;A = A<<1;
	rlf	A, W	    ;W = A<<1 -> W = A<<2
	addwf	Bop, W	    ;W = W | Bop; -> W = B + (A<<2);
	
	;call the look up table and display result on the LEDs
	call	LUT
	movwf	LEDs
	bsf	LEDs,LD7
	bsf	LEDs,LD6
	
	;make sure that it stop and run another time after press button
Stop1	skipPre
	goto  Stop1
	bcf	LEDs,LD6
	bcf	LEDs,LD7
Stop2	skipRel
	goto  Stop2


;}	
; end of your superloop code

	goto	MLoop

end
