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
	btfss	PIR2,C2IF
	btfsc	PIR2,C1IF
	goto	Test
	btfsc	PIR2,CCP2IF
	goto	TIM1
	goto	ExitISR
	
Test
	bcf	PIR2,C2IF
	bcf	PIR2,C1IF
	banksel	CM2CON0
	btfsc	CM2CON0,C2OUT
	goto	Change3
	btfsc	CM1CON0,C1OUT
	goto	Change2
	goto	Change1
TestBack
	movwf	CCPR2H
	goto	ExitISR
Change1
	banksel	Speed1
	movfw	Speed1	
	goto	TestBack
Change2
	banksel	Speed2
	movfw	Speed2
	goto	TestBack
Change3
	banksel	Speed3
	movfw	Speed3
	goto	TestBack
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
Config_Mode
	banksel	PIE2
	bcf	PIE2,CCP2IE
	bcf	PIE2,C1IE
	bcf	PIE2,C2IE
	
	banksel	T2CON
	btfsc	T2CON,TMR2ON
	bcf	T2CON,TMR2ON

	banksel	CCP1CON
	clrf	CCP1CON
	
	banksel	LEDs
	clrf	LEDs
	
	banksel	Mode
	btfsc	Mode,2
	goto	Mode3
	btfsc	Mode,1
	goto	Mode2
	btfsc	Mode,0
	goto	Mode1
	goto	Back_Display
	
Back_Display
	banksel	PIE2	
	bsf	PIE2,CCP2IE
	bsf	PIE2,C1IE
	bsf	PIE2,C2IE
	return
	
Mode1
	bsf	LEDs,LD6
	call	Select4
	call	Option_Judge1
	movwf	Speed1
	movwf	CCPR2H
	call	Select4
	call	Option_Judge1
	movwf	Frist_Brightness
	call	Select4
	call	Option_Judge1
	movwf	Secon_Brightness
	goto	Back_Display
	
Mode2
	bsf	LEDs,LD7
	call	Select4
	call	Option_Judge1
	movwf	Speed2
	movwf	CCPR2H
	call	Select4
	call	Option_Judge2
	xorlw	B'00000001'
	btfsc	STATUS,Z
	bsf	Direction,0
	btfss	STATUS,Z
	bcf	Direction,0
	goto	Back_Display
Mode3
	bsf	LEDs,LD6
	bsf	LEDs,LD7
	call	Select4
	call	Option_Judge1
	movwf	Speed3
	movwf	CCPR2H
	goto	Back_Display

Option_Judge1
	addwf	PCL,f
	retlw   Brightness1
        retlw   Brightness2
	retlw   Brightness3
        retlw   Brightness4

Option_Judge2
	addwf	PCL,f
	retlw  B'00000000'
        retlw  B'00000001'
	retlw  B'00000001'
	retlw  B'00000001'
	
Setting2
	btfss	Direction,1
	andwf	Direction,f
	xorlw	B'00000001'
	btfsc	STATUS,Z
	bcf	Direction,0
	goto	Back_Display
	
Modle_Select
	banksel	CM2CON0
	btfsc	CM2CON0,C2OUT
	goto	LFSR_Shifted
	btfsc	CM1CON0,C1OUT
	goto	Side_Side_Strobe
	goto	Variable_PWM
Back	
	banksel	Runing
	bcf	Runing,0
	return

Variable_PWM
	banksel	T2CON
	btfss	T2CON,TMR2ON
	bsf	T2CON,TMR2ON
	
	banksel	CCP1CON
	movlw	B'01001100'
	movwf	CCP1CON
	
	banksel	LEDs
	clrf	LEDs
	
	banksel	Mode
	movlw	B'00000001'
	movwf	Mode
	
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
	
Side_Side_Strobe
	banksel	T2CON
	btfsc	T2CON,TMR2ON
	bcf	T2CON,TMR2ON

	banksel	CCP1CON
	clrf	CCP1CON
	
	banksel	LEDs
	clrf	LEDs
	
	banksel	Mode
	movlw	B'00000010'
	movwf	Mode
	
	bcf	STATUS,C
	
	banksel	Direction
	btfss	Direction,0
	goto	Direction_1
	goto	Direction_2

Direction_1
	banksel	LEDs_Data
	btfsc	LEDs_Data,LD0
	bsf	STATUS,C
	rrf	LEDs_Data,f
	goto	Display1
Direction_2
	banksel	LEDs_Data
	btfsc	LEDs_Data,LD7
	bsf	Direction,1
	btfsc	LEDs_Data,LD0
	bcf	Direction,1
	btfsc	Direction,1
	goto	Move_Back
	goto	Move_Forth
	
Move_Back
	rrf	LEDs_Data,f
	goto	Display1
Move_Forth
	rlf	LEDs_Data,f	
	goto	Display1
Display1
	movf	LEDs_Data,W
	movwf	LEDs
	goto	Back
	
LFSR_Shifted
	banksel	T2CON
	btfsc	T2CON,TMR2ON
	bcf	T2CON,TMR2ON
	
	banksel	CCP1CON
	clrf	CCP1CON
	
	banksel	LEDs
	clrf	LEDs
	
	banksel	Mode
	movlw	B'00000100'
	movwf	Mode
	
	banksel LFSR_data
	rrf	LFSR_data,f
	btfss	STATUS,C
	goto	Display2
	goto	Output1
Output1
	banksel LFSR_data
	movf	LFSR_data,W
	xorlw	B'10111000'
	movwf	LFSR_data
	goto	Display2
Display2
	movf	LFSR_data,W
	movwf	LEDs
	goto	Clear_Flag
	
Clear_Flag
	bcf	STATUS,C
	goto	Back
	
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
	movlw	B'10001110'
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
	
Timer_Init
	banksel	Speed1
	movlw	Brightness1
	movwf	Speed1
	movwf	Speed2
	movwf	Speed3
	banksel T1CON
	movlw	B'00001011'
	movwf	CCP2CON
	movlw	Brightness4
	movwf	CCPR2H
	movlw	B'00110001'
	movwf	T1CON
	banksel	PIE2
	bsf	PIE2,CCP2IE
	bsf	PIE2,C1IE
	bsf	PIE2,C2IE
	banksel INTCON
	movlw	B'11000000'
	movwf	INTCON
	
SideToSide_Init
	banksel Direction
	bcf	Direction,0
	banksel	LEDs_Data
	movlw	B'00000001'
	movwf	LEDs_Data
	
LFSR_Init
	banksel LFSR_data
	movlw	B'10111101'
	movwf	LFSR_data
	
; end of your initialisation
MLoop	nop
; place your superloop code here ...  
;{	
	skipPre
	goto	Loop1
Loop2	skipRel
	goto	Loop2
	call	Config_Mode
Loop1	
	banksel	Runing
	btfsc	Runing,0
	call	Modle_Select
;}	
; end of your superloop code
	goto	MLoop
end
