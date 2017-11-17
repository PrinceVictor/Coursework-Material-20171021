; Provided code - do not edit  
#include	ECH_1.inc

; Place your SUBROUTINE(S) (if any) here ...  
;{ 
ISR	retfie	; replace retfie with your ISR if necessary

; end of your subroutines

; Provided code - do not edit  
Main	nop
#include ECH_INIT.inc

; Place your INITIALISATION code (if any) here ...   
;{ ***		***************************************************
; e.g.,		movwf	Ctr1 ; etc


;} 
; end of your initialisation

;}
;

MLoop	nop

; place your superloop code here ...  
;{


;	example 0 - heart beat - blink the LED - code needs to be fixed
;   (try to fix yourself; the fixed code is in the example 1)
	    movlw	B'1000001'
	    movwf	PORTD		; or LEDs instead of PORTB
	    movlw	D'5'		
	    call	DelWds		; hold for 0.5 s
	    clrf	LEDs

;}	
; end of your superloop code

	    goto	MLoop

end
