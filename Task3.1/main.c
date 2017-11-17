#include <xc.h>
#define LEDs	PORTD		/* definitions similar to EQU in assembly */
#include "prologue.c"

main ()
{
    //	declare variables if any required
	unsigned char tmp,tmp1,TMP;		// examples for GPR variables
    unsigned char A,B;
    unsigned char LUT[16] ={0,1,2,3,7,7,7,7,14,15,15,15,21,21,23,23};     
    
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
        
        //Using A and B as 4 bit values, Select the result and display on LEDs
        A << =  2;
        TMP = A|B;                     
        LEDs = LUT[TMP];
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
