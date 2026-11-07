	.export nmi

.segment "CODE"

nmi:
	; OAM copy
	lda #$00
	sta $2003 ; OAMADDR
	lda #$02
	sta $4014 ; OAMDMA
	rti
