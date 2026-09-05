#include <nes.h>
#include "apu.h"
#include "joypad.h"
#include "ppu.h"

void main() {
	unsigned char pad;
	unsigned char music = 1;

	ppu_stabilize();
	apu_init();
	
	APU_SQR_ONE_PER_LO = 0x17;
	APU_SQR_ONE_PER_HI = 0x01;

	while (1) {
		waitvsync();
		pad = readJoypadOne();
		

		if (pad & JOYPAD_A) {
			if (music != 1) {	
				APU_SQR_ONE_PER_LO = 0x17;
				APU_SQR_ONE_PER_HI = 0x01;
				APU_SQR_ONE_DV = 0xBF;
				music = 1;
			}
		} else {
			APU_SQR_ONE_PER_LO = 0x00;
			APU_SQR_ONE_PER_HI = 0x00;
			APU_SQR_ONE_DV = 0x30;
			music = 0;
		}
	}
}
