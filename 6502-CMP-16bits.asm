; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 18/06/2025
; Divisão compara 2 números de 16 bits e retorna no
; Acumulador o resultado da operação:
;
; Retorna 0 se o primeiro número é igual ao segundo
; Retorna 1 se o primeiro número é menor que o segundo
; Retorna 2 se o primeiro número é maior que o segundo

REG1L	.EQU $11 ;Primeiro
REG1H	.EQU $12 ;número

REG2L	.EQU $13 ;Segundo
REG2H	.EQU $14 ;número

AUX	.EQU $15

	.ORG $4000

	;Dividendo FFFFH
	LDA #$00
	STA REG1H
	LDA #$FF
	STA REG1L

	;Divisor 0000H
	LDA #$FF
	STA REG2H
	LDA #$00
	STA REG2L

	JSR CMP_16b
	STA AUX

	RTS

;*********************************
;Comparação de 2 números de 16bits
;*********************************
	;Compara se igual
CMP_16b	LDA REG1H
	CMP REG2H
	BEQ IGUAL1
	JMP MENOR1
IGUAL1	LDA REG1L
	CMP REG2L
	BEQ IGUAL2
	JMP MENOR
IGUAL2	LDA #$00
	JMP FIM_CMP

	;Compara se menor
MENOR	LDA REG1H
	SEC
	CMP REG2H
	BCS MENOR1
	LDA #$01
	JMP FIM_CMP
MENOR1	LDA REG1L
	SEC
	CMP REG2L
	BCC MENOR2
	JMP MAIOR
MENOR2	LDA #$01
	JMP FIM_CMP

	;Compara se maior
MAIOR	LDA REG1H
	SEC
	CMP REG2H
	BCS MAIOR1
	LDA #$01
	JMP FIM_CMP
MAIOR1	LDA REG1L
	SEC
	CMP REG2L
	BCS MAIOR2
	LDA #$01
	JMP FIM_CMP
MAIOR2	LDA #$02

FIM_CMP	RTS

	.END
