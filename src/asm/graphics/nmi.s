	.export nmi
	.exportzp nmiflags

.segment "ZEROPAGE"
intera:		.res 1
interx:		.res 1
intery:		.res 1
procstatus:	.res 1
nmiflags:	.res 2

.segment "CODE"

nmi:
	; Backup CPU registers
	sta intera
	stx interx
	sty intery
	
	php
	pla
	sta procstatus

	lda #$01
	sta nmiflags ; Mark NMI as running

	; OAM copy
	lda nmiflags+1 ; 0
	sta $2003 ; OAMADDR
	lda #$06
	sta $4014 ; OAMDMA
	
	; Restore CPU registers
	lda intera
	ldx interx
	ldy intery

	lda procstatus
	pha
	plp

	rti
