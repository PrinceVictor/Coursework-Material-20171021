#include <xc.h>
#define LEDs	PORTD		/* definitions similar to EQU in assembly */
#include "prologue.c"
void ADC_Init();

void interrupt ISR(void){
    
       if(ADIF)
       {
           ADIF = 0;
        LEDs = ADRESH;
        ADCON0 = 0b00000001;
        ADCON0bits.GO = 1;
    

}
}
main ()
{
    //	declare variables if any required
			// examples for GPR variables

    #include "init.c"
    //*** your code for initialisation if required
    ADC_Init();

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
void ADC_Init(){
    ADCON1 = 0b00000000;
    INTCON = 0b11000000;
    PIE1   = 0b01000000;
    ADCON0 = 0b00000011;

}