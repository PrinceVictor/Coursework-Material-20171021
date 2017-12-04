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
    
Brightness1	EQU	B'00000100'
Brightness2	EQU	B'00001000'
Brightness3	EQU	B'00010000'
Brightness4	EQU	B'00100000'
	
Speed1		EQU	B'00010000'
Speed2		EQU	B'00100000'
Speed3		EQU	B'00110000'
Speed4		EQU	B'11110000'
		
LFSR_N		EQU	B'10111000'
LFSR_data	RES	1
Direction	RES	1