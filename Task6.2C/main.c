#include <xc.h>
#define LEDs	PORTD		/* definitions similar to EQU in assembly */
#include "prologue.c"
void PWM_init();


main ()
{
    //	declare variables if any required
		// examples for GPR variables

    #include "init.c"
    //*** your code for initialisation if required
    PWM_init();
    //*** end of your initialisation

    //***  your code for the superloop
	while (1) {
		
	}
	
    //*** end of the superloop
}  // end main


//{
// An example for masking several bits 
//		ctr |= 0b00010010; // sets RB1 and RB4 only leaving the other bits unchanged
//		ctr &= 0b11110011; // clears RB3 and RB2 only leaving the other bits unchanged
//		ctr ^= 0b00100001; // inverts RB5 and RB1 only leaving the other bits unchanged 	
//}

void PWM_init(){
    PR2     = 0x13;           //0x13 = 0b10011 
    CCP1CON = 0b01111100;     //bit7-6 01 for P1D modulated, bit5-4 10  two Low of duty cycle
    CCPR1L  = 0b00000101;      //eight high duty cycle 
    T2CON   = 0b00000100;     //bit2 Timer2 is on, bit1-0 1:1 Prescaler
    // period = (PR2+1)*4*Tosc*Prescaler = (19+1) * 4 * (1 /4 )us * 1  = 20us = 50khz
    // duty cycle (0b10111 = 23 )/(4*20) = 28
    LEDs   |= 0b00001111;     //Switch on Led3,2,1,0
}