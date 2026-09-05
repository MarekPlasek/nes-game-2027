#include "joypad.h"

unsigned char readJoypadOne() {	
	unsigned char buttonSnapshot = 0x00;	
	unsigned char buffer = 0x00;
	unsigned char i = 8;

	JOYPAD_ONE = 0x01;
	__asm__ ("nop");
	__asm__ ("nop");
	JOYPAD_ONE = 0x00; // Sends a strobe-like signal, because apparently two bytes was too many to use for controller input ._.
	
	while (i > 0) {	
		buffer = JOYPAD_ONE & 0x01; // mask out the rest of the bits
		buttonSnapshot = (buttonSnapshot << 1) | buffer;
        i--;
	}
	
	return buttonSnapshot;	
}
