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
Side_Side_Strobe
	btfsc	Direction,1
	goto	Direction2
	btfsc	Direction,0
	goto	Direction1
Direction2
	rlf	LEDs
Direction1
	btfsc	STATUS,C
	bsf	LEDs,SideBit
	
LFSR_Shifted
	banksel LFSR
	btfsc	LFSR,0
	goto	Output1
	goto	Output0
Output1
	bcf	STATUS,C
	rrf	LFSR,f
	movf	LFSR,w
	xorlw	B'10111000'
	movwf	LFSR
	goto	Display
Output0	
	bcf	STATUS,C
	rrf	LFSR,f
	goto	Display
Display
	movf	LFSR,w
	movwf	LEDs
	return
	
ISR
	movwf	W_Save              ; Save context
	swapf	STATUS,W
	movwf	STATUS_Save
	
	goto	ExitISR

ExitISR
	movf	STATUS_Save,w       ; Restore context
	movwf	STATUS
	swapf	W_Save,f            ; swapf doesn't affect Status bits, but MOVF would
	swapf	W_Save,w
	retfie	; replace retfie with your ISR if necessary

Main	nop
#include ECH_INIT.inc

; Place your INITIALISATION code (if any) here ...   
;{ ***		***************************************************
; e.g.,		movwf	Ctr1 ; etc
ModeSelect_Init
	banksel	CM2CON1
	movlw	B'00010000'
	movwf	CM2CON1
	movlw	B'10010100'
	movwf	CM1CON0
	movlw	B'10010100'
	movwf	CM2CON0
	banksel	VRCON
	movlw	B'10000010'
	movwf	VRCON
PWM_Init
	banksel	PR2
	movlw	B'00001111'
	movwf	PR2
	banksel	CCP1CON
	movlw	B'01001100'
	movwf	CCP1CON
	movlw	B'00001100'
	movwf	CCPR1L
	movlw	B'00000100'
	movwf	T2CON
Timer_Init
	movlw	B'00010001'
	movwf	T1CON
	movlw	B'00001011'
	movwf	CCP2CON
	movf	Speed_High,w
	movwf	CCPR2H
	movlw	B'11000000'
	movwf	CCP2CON
	banksel	PIE2
	movlw	B'00000001'
	movwf	PIE2
	
LFSR_Init
	banksel LFSR
	movlw	B'00110100'
	movwf	LFSR
	
	;} 
; end of your initialisation

MLoop	nop

; place your superloop code here ...  
;{


;}	
; end of your superloop code

    goto	MLoop

end
