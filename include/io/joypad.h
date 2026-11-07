#ifndef _JOYPAD_H
	#define _JOYPAD_H
	
	#define JOYPAD_ONE (*(volatile unsigned char*)0x4016)

	// Button masks
	#define JOYPAD_A 0x80
	#define JOYPAD_B 0x40
	#define JOYPAD_SELECT 0x20
	#define JOYPAD_START 0x10

	#define JOYPAD_UP 0x08
	#define JOYPAD_DOWN 0x04
	#define JOYPAD_LEFT 0x02
	#define JOYPAD_RIGHT 0x01

	unsigned char readJoypadOne();

#endif
