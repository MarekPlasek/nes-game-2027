	.import nmi, start, irq

.segment "VECTORS"
.word nmi		; $fffa - Will run when a VBlank NMI interrupt is sent
.word start		; $fffc - Will run on startup and when the "RESET" button is pressed.
.word irq		; $fffe - irq/brk
