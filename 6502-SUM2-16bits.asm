; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 12/06/2025
; Soma em 16bits
; NUM1 - REG1
; NUM2 - REG2
; RES - REG3 - Resultado
; CARRY - (0 - resultado < 16bits / 1 - resultado > 16bits)
;
;   REG1H REG1L
; + REG2H REG2L
;--------------
;   REG3H REG3L
;Ex:
;   7DEF
; + 1CDE
;--------
;   9ACD

REG1L	.EQU $11	;Primeiro
REG1H	.EQU $12	;Número

REG2L	.EQU $13	;Segundo
REG2H	.EQU $14	;Número

REG3L	.EQU $15	;Resultado
REG3H	.EQU $16	;da soma

CARRY	.EQU $17	;0 ou 1

	.ORG $4000

	;7DEFH
	LDA #$00
	STA REG1H
	LDA #$FF
	STA REG1L

	;1CDEH
	LDA #$00
	STA REG2H
	LDA #$01
	STA REG2L

	JSR SUM_16b

	RTS

;*********************************
;Soma de 2 números de 16bits
;*********************************
SUM_16b	LDA #$00
	STA REG3L
	STA REG3H
	STA CARRY
	LDA REG1L
	CLC
	ADC REG2L
	BCC SUM2
	INC REG3H
SUM2	STA REG3L
	LDA REG3H
	CLC
	ADC REG2H
	BCC COND1
	INC CARRY
COND1	CLC
	ADC REG1H	
	BCC FIM
 	INC CARRY
FIM	STA REG3H
	RTS

	.END
