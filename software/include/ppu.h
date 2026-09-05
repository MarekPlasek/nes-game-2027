#ifndef _PPU_H
	#define _PPU_H

	#define PPU_CTRL (*(volatile unsigned char*)0x2000)
	#define PPU_MASK (*(volatile unsigned char*)0x2001)
	#define PPU_STATUS (*(volatile unsigned char*)0x2002)
	#define PPU_SCROLL 

	// Masks
	#define PPU_VBLANK 0x80

	void ppu_stabilize();
#endif
