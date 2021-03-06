#include <xc.h>
#define LEDs	PORTD		/* definitions similar to EQU in assembly */
#include "prologue.c"
void PortBint_Init();

unsigned char Counters =0,data;

void interrupt ISR(){
    if(RBIF){   // check portB change flag  
         data = PORTB; 
         RBIF =0; // software clear portB change flag
         Counters = Counters +1; 


    }
}
main ()
{
    //	declare variables if any required
			// examples for GPR variables

    #include "init.c"
    //*** your code for initialisation if required
    PortBint_Init();
    //*** end of your initialisation

    //***  your code for the superloop
	while (1) {
            LEDs = Counters;
	}
	
    //*** end of the superloop
}  // end main


//{
// An example for masking several bits 
//		ctr |= 0b00010010; // sets RB1 and RB4 only leaving the other bits unchanged
//		ctr &= 0b11110011; // clears RB3 and RB2 only leaving the other bits unchanged
//		ctr ^= 0b00100001; // inverts RB5 and RB1 only leaving the other bits unchanged 	
//}
void PortBint_Init(){
    IOCB   = 0b00000001;  //enable interrupt on change on portB0
    INTCON = 0b10001000;  //bit7 for enable Global Interrupt, bit3 for enable portB change interrupt  
    
}