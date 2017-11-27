#include <xc.h>
#define LEDs	PORTD		/* definitions similar to EQU in assembly */
#include "prologue.c"
void ADC_Init();

void interrupt ISR(void){
    
       if(ADIF)
       {
           ADIF = 0; //software clear ADC interrupt flag
        LEDs = (ADRESH << 2 )+ (ADRESL >> 6);
        //LEDs = ADRESH << 2;
     //   LEDs = ADRESL >> 6;
        ADCON0bits.GO = 1; // run again
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
    ADCON1 = 0b00000000; //clear bit7 A/D conversion for left justified 
    INTCON = 0b11000000; //bit7 enable Global Interrupt, bit6 enable peripheral interrupt
    PIE1   = 0b01000000; //bit6 enable ADC interrupt
    ADCON0 = 0b00111111; //bit5-2 for Fixed Ref, set bit1 for begin ADC working, set bit0 enable ADC

}