; Startup code for CC65 and the NES
; 
; based on code from nesdoug <dougfraker@gmail.com>, Greopaz/Hitmen <greopaz@gmx.net>, Ullrich von Bassewitz <uz@cc65.org>

	.export _exit,__STARTUP__:absolute=1
	.import push0,popa,popax,_main,zerobss,copydata


; Linker generated symbols
	.import         __RAM_START__, __RAM_SIZE__
	.import         __STACK_START__, __STACK_SIZE__
	.import         __ROM0_START__, __ROM0_SIZE__
	.import         __STARTUP_LOAD__,__STARTUP_RUN__, __STARTUP_SIZE__
	.import         __CODE_LOAD__,__CODE_RUN__, __CODE_SIZE__
	.import         __RODATA_LOAD__,__RODATA_RUN__, __RODATA_SIZE__

	.import			NES_MAPPER, NES_PRG_BANKS, NES_CHR_BANKS, NES_MIRRORING

	.importzp _PAD_STATE, _PAD_STATET
	.include "zeropage.inc"

.segment "HEADER"

.byte "N","E","S",$1a 
.byte <NES_PRG_BANKS
.byte <NES_CHR_BANKS
.byte <NES_MIRRORING|(<NES_MAPPER<<4)
.byte <NES_MAPPER&$f0

; Padding (technically not padding but it's stuff we don't need,
; see: https://www.nesdev.org/wiki/NES_2.0#Header)
.byte $00, $00, $00, $00
.byte $00, $00, $00, $00


.segment "ZEROPAGE"


.segment "STARTUP"

start:
_exit:
	sei
	cld
	ldx #$40
	stx $4017	; APU Frame IRQ
	
	ldx #$ff
	txs			; Set stack pointer to $01ff

	inx			; X = 0
	stx $2000	; disable NMI
	stx $2001	; disable rendering
	stx $4010	; disable IRQs

initPPU:
	bit $2002
	@1:
		bit $2002
		bpl @1
	@2:
		bit $2002
		bpl @2

clearRAM:
	txa
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


	jsr zerobss
	jsr copydata

    lda #<(__STACK_START__+__STACK_SIZE__)
    ldx	#>(__STACK_START__+__STACK_SIZE__)
    sta	sp
    sta	sp+1            ; Set argument stack ptr

@enableNMI:
	lda #%10000000
	sta $2000
	lda #%00000110
	sta $2001

	jmp _main


nmi:
	rti

irq:
	rti

.segment "RODATA"

.segment "SAMPLES"

.segment "CHARS"

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
