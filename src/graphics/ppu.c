#include "graphics/ppu.h"

void __fastcall__ waitvsync() {
	while (!(PPU_STATUS & PPU_VBLANK)) {
		continue;
	}

	return;
}
