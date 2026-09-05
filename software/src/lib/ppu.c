#include "ppu.h"

void ppu_stabilize() {
	while (!(PPU_STATUS & PPU_VBLANK)) {
		continue;
	}

	while (!(PPU_STATUS & PPU_VBLANK)) {
		continue;
	}

	return;
}
