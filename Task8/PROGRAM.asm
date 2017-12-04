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

ISR
	movwf	W_Save              ; Save context
	swapf	STATUS,W
	movwf	STATUS_Save
	banksel	PIR2
	btfsc	PIR2,CCP2IF
	goto	TIM1
	goto	ExitISR
	
TIM1
	bcf	PIR2,CCP2IF
	banksel	Runing
	bsf	Runing,0
	goto	ExitISR
	
ExitISR
	movf	STATUS_Save,w       ; Restore context
	movwf	STATUS
	swapf	W_Save,f            ; swapf doesn't affect Status bits, but MOVF would
	swapf	W_Save,w
	retfie	; replace retfie with your ISR if necessary

; Place your SUBROUTINE(S) (if any) here ...
Modle_Select
;	banksel	Runing
;	btfss	Runing,0
;	goto	Back
	
	banksel	CM2CON0
	btfsc	CM2CON0,C2OUT
	goto	LFSR_Shifted
	btfsc	CM1CON0,C1OUT
	goto	Side_Side_Strobe
	goto	Variable_PWM
Back
	return
;	
Side_Side_Strobe
	banksel	T2CON
	btfsc	T2CON,TMR2ON
	bcf	T2CON,TMR2ON
	banksel	LEDs
	bcf	LEDs,2
	bcf	LEDs,0
	bsf	LEDs,1
	
	banksel LFSR_data
	movlw	B'10111101'
	movwf	LFSR_data
	
	goto	Back
;	btfsc	Direction,1
;	goto	Direction2
;	btfsc	Direction,0
;	goto	Direction1
;Direction2
;	rlf	LEDs
;	return
;Direction1
;	btfsc	STATUS,C
;	bsf	LEDs,1
	
Variable_PWM
	banksel	T2CON
	btfss	T2CON,TMR2ON
	bsf	T2CON,TMR2ON
	
	banksel LFSR_data
	movlw	B'10111101'
	movwf	LFSR_data

	banksel	Frist_Brightness
	movf	Frist_Brightness,W
	
	banksel	PR2
	xorwf	PR2,W
	btfss	STATUS,Z
	goto	Value_Change1
	goto	Value_Change2

Value_Change1	
	banksel	Frist_Brightness
	movf	Frist_Brightness,w
	banksel	PR2
	movwf	PR2
	goto	Clear_Flag
Value_Change2
	banksel	Secon_Brightness
	movf	Secon_Brightness,w
	banksel	PR2
	movwf	PR2
	goto	Clear_Flag

Clear_Flag
	
	goto	Back

LFSR_Shifted
	banksel	T2CON
	btfsc	T2CON,TMR2ON
	bcf	T2CON,TMR2ON
	
	
	banksel LFSR_data
	rrf	LFSR_data,f
	btfss	STATUS,C
	goto	Display
	goto	Output1
Output1
	banksel LFSR_data
	movf	LFSR_data,W
	xorlw	B'10111000'
	movwf	LFSR_data
	goto	Display
Display
	movf	LFSR_data,W
	banksel	LEDs
	bsf	LEDs,6
	movwf	LEDs
	goto	Clear_Flag
	
	
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
	movlw	B'10001000'
	movwf	VRCON

PWM_Init
	banksel	Frist_Brightness
	movlw	Brightness4
	movwf	Frist_Brightness
	banksel	Secon_Brightness
	movlw	Brightness1
	movwf	Secon_Brightness
	banksel	PR2
	movwf	PR2
	banksel	CCP1CON
	movlw	B'01001100'
	movwf	CCP1CON
	movlw	B'00000100'
	movwf	CCPR1L
	clrf	T2CON
	
;Timer_Init
;	banksel	Speed
;	movlw	Speed3
;	movwf	Speed
;	banksel T1CON
;	movlw	B'00001011'
;	movwf	CCP2CON
;	movf	Speed,W
;	movwf	CCPR2H
;	movlw	B'00110001'
;	movwf	T1CON
;	banksel	PIE2
;	bsf	PIE2,CCP2IE
;	banksel INTCON
;	movlw	B'11010000'
;	movwf	INTCON
	
LFSR_Init
	banksel LFSR_data
	movlw	B'10111101'
	movwf	LFSR_data
	
	;} 
; end of your initialisation

MLoop	nop

; place your superloop code here ...  
;{
	call	Modle_Select	
	banksel	D_Ctr2
	movlw	Speed4
	movwf	D_Ctr2
	call	DelWms
	banksel	LEDs
	clrf	LEDs
;}	
; end of your superloop code

	goto	MLoop

end
