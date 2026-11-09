	.import popa
	.importzp c_sp
	.export _waitvsync, _loadSprite

.segment "ZEROPAGE"
spriteptr: .res 2
spriteindex: .res 1

.segment "CODE"
_waitvsync:
	@1:	
		bit $2002
		bpl @1
	rts

_loadSprite:
	@saveArgs:
		ldx c_sp
		stx spriteptr
	
		ldx #1
		ldy c_sp,x
		sty spriteptr,x

		ldy spriteptr,x	
		ldx spriteptr

		asl a
		asl a ; multiply index by 4
		
		sta spriteindex

	@copy:
		; A = 04, X = F6; Y = 07
		lda 


	@returnStackPointer:
		clc
		lda c_sp
		adc #3
		sta c_sp
		bcc @done
		inc c_sp+1
	@done:
		rts

