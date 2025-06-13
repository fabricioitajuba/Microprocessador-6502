; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 12/06/2025
; Subtração de números de 8 bits com sinal
;

NUM1	.EQU $10	;Número 1
NUM2	.EQU $11	;Número 2
RES	.EQU $15	;Resultado
SIN	.EQU $16	;Sinal 0 - positivo / 1 - negativo

	.ORG $4000

	LDA #$77
	STA NUM1

	LDA #$33
	STA NUM2

	JSR SUB_8b

	RTS

SUB_8b	LDA NUM1
	CMP NUM2

	BCC MENOR

	LDA NUM1
	SEC
	SBC NUM2
	STA RES

	LDA #$00
	STA SIN

	JMP FIM

MENOR	LDA NUM2
	SEC
	SBC NUM1
	STA RES
	LDA #$FF
	SEC
	SBC RES
	STA RES
	INC RES

	LDA #$01
	STA SIN

FIM	RTS

	.END
