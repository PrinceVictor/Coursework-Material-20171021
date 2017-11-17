#include <xc.h>
#define LEDs	PORTD		/* definitions similar to EQU in assembly */
#include "prologue.c"
void Dispaly(unsigned char );
void Morse_code();
void Morse_dash();
void Morse_dot();
// My Student Number is 2125957
const unsigned char Student_Number[4] = {7, 5, 9, 5};

main ()
{
    //	declare variables if any required
	unsigned char tmp,tmp1;		// examples for GPR variables
    unsigned char Input_nub;
    
    #include "init.c"
    //*** your code for initialisation if required

    //*** end of your initialisation

    //***  your code for the superloop
	while (1) {
        Input_nub = Select4();
        Dispaly(Input_nub);
     
	
    //*** end of the superloop
}  // end main
}
void Dispaly(unsigned char Postion){

    switch(Postion){
        case 1:    Morse_code();            break;
        case 2:    LEDs = 0b10100000;       break;
        case 4:    LEDs = 0b11100000;       break;
        case 8:    LEDs = 0b10100000;       break;
    }
    __delay_ms(1000);
    __delay_ms(1000);
    __delay_ms(1000);
    LEDs = 0b00000000;
}

void Morse_code(){

       Morse_dash();
       Morse_dash();
       Morse_dot();
       Morse_dot();
       Morse_dot();
}

void Morse_dash(){
     LEDs = 0b10000000;
    __delay_ms(900);
    LEDs = 0b00000000;
    __delay_ms(300);
}

void Morse_dot(){
    
    LEDs = 0b10000000;
    __delay_ms(300);
    LEDs = 0b00000000;
    __delay_ms(300);

}
//{
// An example for masking several bits 
//		ctr |= 0b00010010; // sets RB1 and RB4 only leaving the other bits unchanged
//		ctr &= 0b11110011; // clears RB3 and RB2 only leaving the other bits unchanged
//		ctr ^= 0b00100001; // inverts RB5 and RB1 only leaving the other bits unchanged 	
//}
