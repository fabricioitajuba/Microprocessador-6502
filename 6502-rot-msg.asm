; Teste com o microprocessador 6502
; Rotina para escrita de menssagens
; A página 0 (00H-FFH) é usada também como ponteiro

LSB	.EQU $10
MSB	.EQU $11

CH	.EQU $0024	;Coluna (0-39)
CV	.EQU $0025	;Linha (0-23)

CARAC	.EQU $FDED 	;Imprime um caracter
CLRSCR	.EQU $F832 	;Limpa a tela

OUT	.EQU $4028

	.ORG $4000

	JSR CLRSCR	;Limpa a tela

	LDA #$00	;Coloca o
	STA CH		;Cursor na
	STA CV		;Primeira posição

	LDA #MSG_1 & $FF ;Byte LSB de MSG_1
	STA LSB
	LDA #MSG_1 >> 8	 ;Byte MSB de MSG_1
	STA MSB
	JSR PRINTF

	LDA #MSG_2 & $FF ;Byte LSB de MSG_2
	STA LSB
	LDA #MSG_2 >> 8	 ;Byte MSB de MSG_2
	STA MSB
	JSR PRINTF

	RTS

	;Imprime uma menssagem na tela
PRINTF	LDY #$00
INICIO	LDA (LSB),Y
	CMP #$00
	BEQ FIM
	JSR CARAC
	INY
	JMP INICIO
FIM	RTS

MSG_1	.byte $C1,$C2,0	;Igual
MSG_2	.byte $C3,$C4,0	;Diferente

	.END
