#include <xc.h>
#define LEDs	PORTD		/* definitions similar to EQU in assembly */
#include "prologue.c"
void Inter_Init();
unsigned char Counter[3] ={0};

void interrupt ISR(){
     if((!GO)&ADIF){
    ADIF = 0;
    Counter[0] ++ ;
  
    }
    
    if(TMR1IF){
        TMR1IF =0;
        Counter[1] ++;
    }
      if(INTF){
        INTF = 0 ;
        Counter[2] ++;
        
    }

    
}
main ()
{
    //	declare variables if any required
	// examples for GPR variables

    #include "init.c"
    //*** your code for initialisation if required
    unsigned char temp;
    unsigned int i =0;
    Inter_Init();
    //*** end of your initialisation

    //***  your code for the superloop
	while (1) {
        ReadADC();
        if(PORTB & 0b00000001){
            switch(Select4()){
                case 1:  temp = 0;  break;
                case 2:  temp = 1;  break;
                case 4:  temp = 2;  break;
                case 8:  temp = 2; break;
                default: break;
            }
        }
        else{
            LEDs = Counter[temp];
        }

	}
	
    //*** end of the superloop
}  // end main

void Inter_Init(){
    OPTION_REGbits.INTEDG = 1;
    PIE1   = 0b01000001;
    TMR1H = 0b11110100;
    TMR1L = 0b00100100;
    T1CON = 0b00110001;
    INTCON = 0b11010000;

}
//{
// An example for masking several bits 
//		ctr |= 0b00010010; // sets RB1 and RB4 only leaving the other bits unchanged
//		ctr &= 0b11110011; // clears RB3 and RB2 only leaving the other bits unchanged
//		ctr ^= 0b00100001; // inverts RB5 and RB1 only leaving the other bits unchanged 	
//}
