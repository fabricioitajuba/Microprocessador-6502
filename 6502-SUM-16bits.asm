; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 12/06/2025
; Soma em 16bits
; NUM1
; NUM2
; RES 
;
;   NUM1H NUM1L
; + NUM2H NUM2L
;--------------
;   RESH RESL
;Ex:
;   7DEF
; + 1CDE
;--------
;   9ACD

NUM1L	.EQU $11	;Primeiro
NUM1H	.EQU $12	;Número

NUM2L	.EQU $13	;Segundo
NUM2H	.EQU $14	;Número

RESL	.EQU $15	;Resultado
RESH	.EQU $16	;da soma


	.ORG $4000

	;7DEFH
	LDA #$7D
	STA NUM1H
	LDA #$EF
	STA NUM1L

	;1CDEH
	LDA #$1C
	STA NUM2H
	LDA #$DE
	STA NUM2L

	JSR SUM_16b

	RTS

;*********************************
;Soma de 2 números de 16bits
;*********************************
SUM_16b	CLD
	LDA NUM1L
	CLC
	ADC NUM2L
	STA RESL
	LDA NUM1H
	ADC NUM2H
	STA RESH
	LDA RESH

	RTS

	.END
