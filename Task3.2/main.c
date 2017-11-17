#include <xc.h>
#define LEDs	PORTD		/* definitions similar to EQU in assembly */
#include "prologue.c"

main ()
{
    //	declare variables if any required
	unsigned char tmp,tmp1,TMP;		// examples for GPR variables
    unsigned char A,B;
    unsigned char LUT[16] ={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};     
    
    #include "init.c"
    //*** your code for initialisation if required

    //*** end of your initialisation

    //***  your code for the superloop
	while (1) {
        
        //Switch on LED7, Call SelectB to input a 2bit value for A
        LEDs = 0b10000000;
        A = SelectB(); 
        
        //Switch on LED6 and Switch off LED7, Call SelectB to input a 2bit value for B
        LEDs = 0b01000000;
        B = SelectB();
        
        //Using A and B as 2 bit values, calculate the result and display on LEDs
        TMP = (7*A)|B;                     
        LEDs = TMP;
        LEDs |= 0b11000000;
        
        //Stop and press button to run next time
        while(0 == ReadSw());
        __delay_ms(400);
        while(1 == ReadSw());
        __delay_ms(400);
        
	}
	
    //*** end of the superloop
}  // end main


//{
// An example for masking several bits 
//		ctr |= 0b00010010; // sets RB1 and RB4 only leaving the other bits unchanged
//		ctr &= 0b11110011; // clears RB3 and RB2 only leaving the other bits unchanged
//		ctr ^= 0b00100001; // inverts RB5 and RB1 only leaving the other bits unchanged 	
//}
