; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 18/06/2025
; Compara 2 números de 8 bits e retorna no
; Acumulador o resultado da operação:
;
; Retorna 00H se o primeiro número é igual ao segundo
; Retorna 01H se o primeiro número é menor que o segundo
; Retorna 02H se o primeiro número é maior que o segundo

NUM1	.EQU $10 ;Primeiro número
NUM2	.EQU $11 ;Segundo número
RES	.EQU $12 ;Resultado da comparação

	.ORG $4000

	LDA #$07
	STA NUM1

	LDA #$07
	STA NUM2

	JSR CMP_8b
	STA RES

	RTS

;*********************************
;Comparação de 2 números de 8bits
;*********************************
	;Compara se igual
CMP_8b	LDA NUM1
	CMP NUM2
	BNE MENOR
	LDA #$00
	JMP FIM

	;Compara se menor
MENOR	SEC
	CMP NUM2
	BCS MAIOR
	LDA #$01
	JMP FIM
	
	;Compara se maior
MAIOR	LDA #$02

FIM	RTS

	.END
