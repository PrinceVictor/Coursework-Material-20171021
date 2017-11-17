#include <xc.h>
#define LEDs	PORTD		/* definitions similar to EQU in assembly */
#include "prologue.c"
void PortBint_Init();

unsigned char Counters =0;

void interrupt ISR(){
    if(RBIF){
        RBIF =0;
        Counters ++;
    
        while(PORTB == 0);
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
    INTCON = 0b10001000;
    IOCB   = 0b00000001;
    
}