	.import popa
	.importzp c_sp
	.export _waitvsync, _loadSprite

.segment "ZEROPAGE"
spriteptr: .res 2

.segment "CODE"
_waitvsync:
	@1:	
		bit $2002
		bpl @1
	rts

_loadSprite:
	ldy #2
	lda (c_sp),y
	sta spriteptr+1
	dey
	lda (c_sp),y
	sta spriteptr
	dey
	lda (c_sp),y

	asl a
	asl a ; multiply index by 4
	tax

	ldy #$0
	
	@copy:
		lda (spriteptr),y
		sta $0200,x
		iny
		inx
		cpy #4
		bne @copy

	clc
	lda c_sp
	adc #3
	sta c_sp
	bcc @done
	inc c_sp+1
	@done:
		rts	
