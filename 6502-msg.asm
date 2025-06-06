; Teste com o microprocessador 6502
; Escreve uma menssagem na tela

CH	.EQU $0024	;Coluna (0-39)
CV	.EQU $0025	;Linha (0-23)

CARAC	.EQU $FDED 	;Imprime um caracter
CLRSCR	.EQU $F832 	;Limpa a tela


	.ORG $4000

	JSR CLRSCR	;Limpa a tela

	LDA #$00	;Coloca o
	STA CH		;Cursor na
	STA CV		;Primeira posição

	;Imprime uma menssagem na tela
	LDX #$00
INICIO	LDA MSG1,X
	CMP #$00
	BEQ FIM
	JSR CARAC
	INX
	JMP INICIO
FIM	RTS

MSG1	.byte $D4,$C5,$D3,$D4,$C5,0	;TESTE
MSG2	.text "TESTE"
	.byte 0

	.END
