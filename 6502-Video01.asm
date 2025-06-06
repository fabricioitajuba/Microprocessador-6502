; Teste com o microprocessador 6502
; Plota um caracter na tela

#define	TORG $FFF0

CH	.EQU $0024
CV	.EQU $0025

VIDEO1	.EQU $2000
VIDEO2	.EQU $2000+$100

CARAC	.EQU $FDED ;Imprime um caracter
DELAY	.EQU $FCA8 ;Gera um delay
CLRSCR	.EQU $F832 ;Limpa a tela
COLOR	.EQU $F864

	.ORG $0300

	JSR CLRSCR	;Limpa a tela

	LDA #$00	;Coloca o
	STA CH		;Cursor na
	STA CV		;Primeira posição

	LDA #04
	JSR COLOR

	LDA #$FF
	STA VIDEO1
	LDA #$FF
	STA VIDEO1+$400
	LDA #$FF
	STA VIDEO1+$800
	LDA #$FF
	STA VIDEO1+$C00
	LDA #$FF
	STA VIDEO1+$1000
	LDA #$FF
	STA VIDEO1+$1400
	LDA #$FF
	STA VIDEO1+$1800
	LDA #$FF
	STA VIDEO1+$1C00

	LDA #$FF
	STA VIDEO2
	LDA #$FF
	STA VIDEO2+$400
	LDA #$FF
	STA VIDEO2+$800
	LDA #$FF
	STA VIDEO2+$C00
	LDA #$FF
	STA VIDEO2+$1000
	LDA #$FF
	STA VIDEO2+$1400
	LDA #$FF
	STA VIDEO2+$1800
	LDA #$FF
	STA VIDEO2+$1C00

INICIO	LDA #$04	;tecla
	STA $C000	;espaço
	LDA $C010
	AND #$01
	CMP #$01
	BEQ TCS
	JMP INICIO

TCS	RTS

	LDA #'F'

tst	.byte $03
	.byte $FA

MSG1	.text "FABRICIO"
	.byte 0

	.org $FFF8
MON	.word $FF5D
NMI	.word NMI
RESET	.word $FA62
IRQ	.word $FA40

	.END
