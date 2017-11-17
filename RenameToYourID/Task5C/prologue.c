// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// 
// 			This file is for your information only
//
// 					DO NOT EDIT
//
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


//; the options used must be selected from the pic16f887.h file from INCLUDE directory of Hi-Tech compiler
//; setting the CONFIG1 configuration bits - required, explained at the end of the lecture course
__CONFIG (FOSC_INTRC_NOCLKOUT & WDTE_OFF & PWRTE_ON & MCLRE_ON & CP_OFF & CPD_OFF & BOREN_OFF & IESO_OFF & FCMEN_OFF & LVP_OFF & DEBUG_ON & WRT_OFF & BOR4V_BOR21V);
//; CONFIG1
//; FOSC_INTRC_NOCLKOUT - use internal 4 MHz oscillator, RA6 and RA7 pins are used for I/O
//; WDTE_OFF - the watchdog timer is DISABLED and can be enabled by SWDTEN bit of the WDTCON register
//; PWRTE_ON - power up timer - ENABLED
//; MCLRE_ON - master clear pin function - ENABLED
//; CP_OFF - program memory protection - DISABLED
//; CPD_OFF - EEPROM protection - DISABLED
//; BOREN_OFF - brown out reset - DISABLED
//; IESO_OFF - internal external oscillator switchover - DISABLED
//; FCMEN_OFF - fail safe clock monitor - DISABLED
//; LVP_OFF - low voltage programming - DISABLED
//; DEBUG_ON - in circuit debugger - ENABLED, pins RB6 and RB7 are used by it
//; ! the best practice is to ALWAYS specify all the bits in the code
//; CONFIG2
//; BOR4V_BOR21V - Brown-out Reset set to 2.1V
//; WRT_OFF - program memory self write protection - DISABLED


/* to make __delay functions available with right timing*/
#define _XTAL_FREQ 4000000

unsigned char ReadADC (void) {
	ADCON0 |= 0b00000010;
	while ( (ADCON0 & 0b00000010) );
	return ADRESH;
}


unsigned char ReadSw (void)	{
	unsigned char tmp;
	do {
		tmp = PORTB & 0b00000001;
		__delay_ms(20);
	} while ( tmp != (PORTB & 0b00000001) );
	return tmp;
}

unsigned char Select4 (void)	{	
	unsigned char tmp, oldLEDs, result;
	oldLEDs=LEDs;
	LEDs=0b00010000;
	
	do	{
		tmp = ReadADC();
		tmp >>= 6;
		switch (tmp)	{
			case 0:	result=1; break;
			case 1:	result=2; break;
			case 2: result=4; break;
			case 3: result=8;
		}
		LEDs = result | 0b00010000 | (oldLEDs & 0b11000000);
	} while ( ReadSw() );
	
	LEDs=0;			__delay_ms(300);
	LEDs=result;	__delay_ms(400);
	LEDs=0;			__delay_ms(300);
	
	LEDs=oldLEDs;
	return result;
}
		
unsigned char SelectB (void)	{	
	unsigned char oldLEDs, result;
	oldLEDs=LEDs;
	LEDs=0b00010000;
	
	do	{
		result = ReadADC();
		result >>= 6;
		LEDs = result | 0b00010000 | (oldLEDs & 0b11000000);
	} while ( ReadSw() );
	
	LEDs=0;			__delay_ms(300);
	LEDs=result;	__delay_ms(400);
	LEDs=0;			__delay_ms(300);
	
	LEDs=oldLEDs;
	return result;
}



	