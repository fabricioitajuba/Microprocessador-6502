; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 12/06/2025
; Soma em 8bits
; NUM1 - Número 1
; NUM2 - Número 2
; RES - Resultado
; CARRY - (0 - resultado < 8bits / 1 - resultado > 8bits)


NUM1	.EQU $11
NUM2	.EQU $12
RES	.EQU $13
CARRY	.EQU $14

	.ORG $4000

	;7D
	LDA #$7D
	STA NUM1

	;EF
	LDA #$1F
	STA NUM2

	JSR SUM_8b

	RTS

;*********************************
;Soma de 2 números de 8bits
;*********************************
SUM_8b	LDA #$00
	STA RES
	STA CARRY
	LDA NUM1
	CLC
	ADC NUM2
	BCC FIM
	INC CARRY
FIM	STA RES
	RTS

	.END
