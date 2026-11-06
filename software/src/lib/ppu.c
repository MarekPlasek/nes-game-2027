#include "ppu.h"

void waitvsync() {
	while (!(PPU_STATUS & PPU_VBLANK)) {
		continue;
	}

	return;
}
