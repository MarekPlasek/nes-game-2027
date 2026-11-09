#include "io/joypad.h"
#include "graphics/ppu.h"
#include "famistudio_cc65.h"

void main() {
	extern unsigned char music_data_tornus_extas_soundtrack[]; 
	unsigned char plr_top[] = {0x1F, 0x04, 0x07, 0x1A};
	// unsigned char plr_bottom[] = {0x27, 0x14, 0x07, 0x1A};

	loadSprite(&plr_top, 1);	
	// loadSprite(&plr_bottom, 2);

	famistudio_init(FAMISTUDIO_PLATFORM_PAL, music_data_tornus_extas_soundtrack);
	famistudio_music_play(0);

	while (1) {
		ppuWaitNmi();
		famistudio_update();
	}
}
