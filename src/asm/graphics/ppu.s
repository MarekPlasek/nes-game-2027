	.import popa
	.importzp c_sp, nmiflags
	.export _waitVsync, _loadSprite, _ppuWaitNmi

.segment "ZEROPAGE"
spriteptr: .res 2
spriteindex: .res 1
spritedest: .res 2

.segment "CODE"
_waitVsync:
	; NEVER USE THIS FUNCTION OUTSIDE OF STARTUP.
	; READING PPU_STATUS FOR VBLANK IS UNRELIABLE!
	; https://www.nesdev.org/wiki/PPU_registers#Vblank_flag
	;
	; Use ppuWaitNmi() instead.
	@1:
		bit $2002
		bpl @1
	rts

_ppuWaitNmi:
	lda nmiflags
	cmp nmiflags+1
	beq _ppuWaitNmi

	lda #0
	sta nmiflags
	rts

_loadSprite:
	@saveArgs:
		asl a
		asl a ; multiply A by 4
		sta spriteindex

		ldx c_sp
		ldy c_sp+1
		stx spriteptr
		sty spriteptr+1
		
		ldx #$00
		stx spritedest
		ldy #$06
		sty spritedest+1	
	@calculateFinalDestination:
		cmp spritedest
		beq @copy
		inc spritedest
		jmp @calculateFinalDestination

	ldy #0
	@copy:
		lda (spriteptr),y
		sta (spritedest),y
		iny
		cpy #$04
		bcc @copy	

	@returnStackPointer:
		clc
		lda c_sp
		adc #3
		sta c_sp
		bcc @done
		inc c_sp+1
	@done:
		rts

