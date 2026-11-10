#include "io/joypad.h"
#include "graphics/ppu.h"

void main() {
	unsigned char plr_top[] = {0x1F, 0x04, 0x07, 0x1A};
	unsigned char plr_bottom[] = {0x27, 0x14, 0x07, 0x1A};

	ppuLoadSprite(&plr_top, 1);	
	ppuLoadSprite(&plr_bottom, 2);

	while (1) {
		ppuWaitNmi();
	}
}
