#include <xc.h>
#define LEDs	PORTD		/* definitions similar to EQU in assembly */
#include "prologue.c"
void Comparator_Init();
void ADC_Init();
int i = -1;
void interrupt ISR(){
    if(C1IF){
        C1IF = 0;
        LEDs = (C1OUT << 6);
        ADCON0 = 0b00000011;
        i++;
}
    
       if(ADIF)
       {
        ADIF = 0;
        if(i)  {
            LEDs = ADRESH ;
            PIE2bits.C1IE = 0;}
        
        ADCON0 = 0b00000010;

}

}
main ()
{
    //	declare variables if any required
	//unsigned char tmp,tmp1;		// examples for GPR variables

    #include "init.c"
    //*** your code for initialisation if required
    Comparator_Init();
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
void Comparator_Init(){
    INTCON = 0b11000000;
    PIE2  = 0b00100000;
    VRCON = 0b10100010;
    CM1CON0 = 0b10000100;
    
    

}

void ADC_Init(){
    ADCON1 = 0b00000000;
    INTCON = 0b11000000;
    PIE1   = 0b01000000;
    ADCON0 = 0b01000000;

}