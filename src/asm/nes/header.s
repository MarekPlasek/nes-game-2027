.segment "HEADER"

.byte "N","E","S",$1a 
.byte $02 ; PRG-ROM 16 KiB bank count
.byte $04 ; CHR-ROM 8 KiB bank count
.byte %00110000 ; Mapper LSB, no alt nambetables, no 512 byte trainer, no battery, mapper-controlled nametable layout 
.byte %00001000 ; Mapper middle SB, NES 2.0 identifier, console type
.byte %00000000 ; Submapper number, mapper MSB
.byte $00 ; PRG/CHR-ROM size MSB (irrelevant)
.byte $00 ; PRG-RAM size (irrelevant)
.byte $00 ; CHR-RAM size (irrelevant)
.byte %00000001 ; PAL Game region
.byte $00, $00 ; the TRULY irrelevant
.byte %00000001 ; Standard controller
