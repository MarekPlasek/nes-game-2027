#include "io/joypad.h"
#include "graphics/ppu.h"

void main() {
	unsigned char pad;

	while (1) {
		waitvsync();
		pad = readJoypadOne();

	}
}
