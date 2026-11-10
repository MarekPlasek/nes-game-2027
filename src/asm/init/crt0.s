; Startup code for CC65 and the NES
; 
; based on code from nesdoug <dougfraker@gmail.com>, Greopaz/Hitmen <greopaz@gmx.net>, Ullrich von Bassewitz <uz@cc65.org>

	.export _exit,__STARTUP__:absolute=1,start
	.import push0,popa,popax,_main,zerobss,copydata,_ppuWaitVsync,irq
	.import fallbackPalettes
	.exportzp oamshadow

; Linker generated symbols
	.import         __RAM_START__, __RAM_SIZE__
	.import         __ARG_STACK_START__, __ARG_STACK_SIZE__
	.import         __ROM0_START__, __ROM0_SIZE__
	.import         __CODE_LOAD__,__CODE_RUN__, __CODE_SIZE__
	.import         __RODATA_LOAD__,__RODATA_RUN__, __RODATA_SIZE__

	.importzp _PAD_STATE, _PAD_STATET
	.include "zeropage.inc"

PPU_CTRL=$2000
PPU_MASK=$2001
PPU_STATUS=$2002
PPU_OAM_ADDR=$2003
PPU_ADDR=$2006
PPU_DATA=$2007
DMC_FREQ=$4010
APU_CTRL2=$4017

.segment "ZEROPAGE"
oamshadow: .res 2

.segment "STARTUP"

start:
_exit: ; In case some motherfucker decides to call exit() on a platform that has no OS
	sei
	cld
	ldx #$40
	stx APU_CTRL2			; APU Frame IRQ
	
	ldx #$ff
	txs						; Set stack pointer to $01ff

	inx						; X = 0
	stx PPU_CTRL			; disable NMI
	stx PPU_MASK			; disable rendering
	stx DMC_FREQ			; disable IRQs

initPPU:
	bit PPU_MASK ; Clear VBlank flag
	jsr _ppuWaitVsync
	jsr _ppuWaitVsync
	
	lda #$00
	sta PPU_OAM_ADDR ; Prepare OAMADDR for the easiest copying of sprite data you'll ever see 8)

clearVRAM:
	ldy #$00

	@loop:
		stx PPU_ADDR
		sty PPU_ADDR
		sta PPU_DATA
	
		iny
		bne @loop

		inx
		bne @loop

initPalette:
	ldx #$3F
	@loop:	
		stx PPU_ADDR
		sty PPU_ADDR
		lda fallbackPalettes,y
		sta PPU_DATA
		iny

		cpy #$20 ; Does X and Y form $3F20?
		bne @loop

clearRAM:
	ldx #$00
	lda #$00
	@1:
		sta $00,x
		sta $100,x
		sta $200,x
		sta $300,x
		sta $400,x
		sta $500,x
		sta $600,x
		sta $700,x
		inx
		bne @1

	;|-------------------------------
	;| ✨ Funky C shit ✨
	;|
	;| I'm still of the opinion that while it would've been a bigger hurdle
	;| the first few months, development would be faster purely with assembly.

setOamShadow:
	ldx #$00
	stx oamshadow
	ldy #$06
	sty oamshadow+1	

clearBSS:
	; Clearing BSS segment.
	jsr zerobss
	jsr copydata

setupCStack:
	; C argument stack pointer initialization
    lda #<(__ARG_STACK_START__+__ARG_STACK_SIZE__)
    ldx	#>(__ARG_STACK_START__+__ARG_STACK_SIZE__)
    sta	c_sp
    stx	c_sp+1
	;| -----------------------------

enableRendering:
	lda #$80
	sta PPU_CTRL
	lda #$1E
	sta PPU_MASK

letsRoll:
	jmp _main

; The MIT License (MIT)
; Copyright (c) 2018 Doug Fraker
; www.nesdoug.com
; 
; Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
; 
; The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
; 
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
