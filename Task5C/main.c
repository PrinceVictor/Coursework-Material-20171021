#include <xc.h>
#define LEDs	PORTD
#include "prologue.c"
unsigned char button_released(void) {  	// no debouncing but quick - use for this task only
	return PORTB & 0b00000001;			//   rez=ReadSw(); // with debouncing
} 

main () {
	unsigned char Temp, X;	
#include "init.c"

//***  code for the superloop
	while (1) {

		if ( button_released() )	{	// quick check whether the button is released
			Temp = Select4();
			// after this line analyse the tmp value and set X as required
            switch(Temp){
                case 1:  X = 1;  break;
                case 2:  X = 5;  break;
                case 4:  X = 9;  break;
                case 8:  X = 12; break;
            }

		}
		// after this line switch the LEDs  
		// after this line put the loop , use a 100us delay.
        while(!button_released()){
        LEDs  = 0b00000010;
		for(int i = 28; i> 0; i--){
            if(X == i){
                LEDs |= 0b00000001; 
            }
            __delay_us(100);
        }
        
	}
    
	
//*** end of the superloop


}  // end main - a remark
}