; list names of your variables one in a row below
; each of them will be allocated a GPR
; and can be referenced by name in your code
; (the assembler will place actual address automatically)
; examples:
;Ctr1	RES	1	; your vaiable, e.g., for counter 1
;Ctr2	RES	1
Temp		Res	1	; this is used by the examples
A		Res	1
Bop		Res	1
		
		
W_Save		RES	1
STATUS_Save	RES	1

Runing		RES	1
Speed		RES	1
Frist_Brightness    RES	    1	
Secon_Brightness    RES	    1
    
Brightness1	EQU	B'00011100'
Brightness2	EQU	B'00111000'
Brightness3	EQU	B'01110000'
Brightness4	EQU	B'11100000'
	
Speed1		RES	1
Speed2		RES	1
Speed3		RES	1
Speed4		RES	1
		
Direction1	EQU	B'00000001'
Direction2	EQU	B'00000000'
		
LFSR_N		EQU	B'10111000'
LFSR_data	RES	1
LEDs_Data	RES	1
Direction	RES	1
Mode		RES	1
Options		RES	1