; Startup code for CC65 and the NES
; 
; based on code from nesdoug <dougfraker@gmail.com>, Greopaz/Hitmen <greopaz@gmx.net>, Ullrich von Bassewitz <uz@cc65.org>

	.export _exit,__STARTUP__:absolute=1
	.import push0,popa,popax,_main,zerobss,copydata


; Linker generated symbols
	.import         __RAM_START__, __RAM_SIZE__
	.import         __ARG_STACK_START__, __ARG_STACK_SIZE__
	.import         __ROM0_START__, __ROM0_SIZE__
	.import         __CODE_LOAD__,__CODE_RUN__, __CODE_SIZE__
	.import         __RODATA_LOAD__,__RODATA_RUN__, __RODATA_SIZE__

	.import			NES_MAPPER, NES_PRG_BANKS, NES_CHR_BANKS, NES_MIRRORING

	.importzp _PAD_STATE, _PAD_STATET
	.include "zeropage.inc"

PPU_CTRL=$2000
PPU_MASK=$2001
PPU_STATUS=$2002
DMC_FREQ=$4010
APU_CTRL2=$4017

.segment "HEADER"

.byte "N","E","S",$1a 
.byte <NES_PRG_BANKS
.byte <NES_CHR_BANKS
.byte %00000001 
.byte <NES_MAPPER&$f0

; Padding (technically not padding but it's stuff we don't need,
; see: https://www.nesdev.org/wiki/NES_2.0#Header)
.byte $00, $00, $00, $00

.byte $01 ; PAL designation

; More padding
.byte $00, $00, $00

.segment "ZEROPAGE"


.segment "STARTUP"

start:
_exit:
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

	@1:
		bit PPU_STATUS
		bpl @1
	@2:
		bit PPU_STATUS
		bpl @2

clearRAM:
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
	

	; Clearing BSS segment.
	jsr zerobss
	jsr copydata

	; C argument stack pointer initialization
    lda #<(__ARG_STACK_START__+__ARG_STACK_SIZE__)
    ldx	#>(__ARG_STACK_START__+__ARG_STACK_SIZE__)
    sta	c_sp
    stx	c_sp+1
	;| -----------------------------

@enableNMI:
	lda #$80
	sta PPU_CTRL
	lda #$06
	sta PPU_MASK

	jmp _main


nmi:
	rti

irq:
	rti

.segment "RODATA"

.segment "CHARS"
.res 8192 ; Placeholder for actual CHR data

.segment "VECTORS"
.word nmi		; $fffa - Will run when a VBlank NMI interrupt is sent
.word start		; $fffc - Will run on startup and when the "RESET" button is pressed.
.word irq		; $fffe - irq/brk


; The MIT License (MIT)
; Copyright (c) 2018 Doug Fraker
; www.nesdoug.com
; 
; Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
; 
; The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
; 
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
