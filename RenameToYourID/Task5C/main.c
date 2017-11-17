#include <xc.h>
#define LEDs	PORTD
#include "prologue.c"
unsigned char button_released(void) {  	// no debouncing but quick - use for this task only
	return PORTB & 0b00000001;			//   rez=ReadSw(); // with debouncing
} 

main () {
	unsigned char Temp;	
#include "init.c"

//***  code for the superloop
	while (1) {

		if ( button_released() )	{	// quick check whether the button is released
			Temp = Select4();
			// after this line analyse the tmp value and set X as required

		}
		// after this line switch the LEDs

		// after this line put the loop , use a 100us delay.
		
	}
	
//*** end of the superloop


}  // end main - a remark
