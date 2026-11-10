	.import popa
	.importzp c_sp, nmiflags, oamshadow
	.export _waitVsync, _loadSprite, _ppuWaitNmi

.segment "ZEROPAGE"
spriteptr: .res 2
spriteindex: .res 1

.segment "CODE"
_resetOAMShadowOffset:
	lda #0
	sta oamshadow
	rts

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
	asl a
	asl a ; multiply A by 4

	@calculateFinalDestination:
		cmp oamshadow
		beq @calculated
		inc oamshadow
		jmp @calculateFinalDestination

	@calculated:
	ldy #0

	@copyArrayPointer:
	lda (c_sp),y
	sta spriteptr,y
	iny
	cpy #2
	bne @copyArrayPointer

	@copy:
		ldy #0
		@1:
			lda (spriteptr),y
			sta (oamshadow),y
			iny
			cpy #$04
			bcc @1

	jsr _resetOAMShadowOffset

	@returnStackPointer:
		clc
		lda c_sp
		adc #2
		sta c_sp
		bcc @done
		inc c_sp+1
	@done:
		rts

