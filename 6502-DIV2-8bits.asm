; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 20/06/2025
; Divisão de 2 números de 8 bits
; Dividendo/Divisor = Quociente e Resto
;
; Subtrai o divisor do dividendo até que o 
; resto seja menor que o divisor

DIVIDENDO	.EQU $10	;Número 1
DIVISOR		.EQU $11 	;Número 2
QUOCIENTE	.EQU $12	;Resultado	
RESTO		.EQU $13 	;Resto da divisão

PRERR		.EQU $FF2D	;Mensagem de Erro caso tenha
				;divisão por zero

	.ORG $4000

	LDA #$FF
	STA DIVIDENDO

	LDA #$0F
	STA DIVISOR

	JSR DIV_16b

	RTS

;********************************************************
; Divisão de 2 números de 8bits
; Divide o Dividendo pelo Divisor dando o resultado no
; no Quociente e Resto. 
;********************************************************
DIV_16b	LDA DIVIDENDO
	PHA

	LDA #$00
	STA QUOCIENTE
	STA RESTO

	LDA DIVISOR
	CMP #$00
	BNE ROT
	JSR PRERR
	JMP FIM

ROT	JSR SUB_8b
	JSR SUM_8b
	JSR CMP_8b
	
	CMP #$01
	BEQ FIM

	LDA RESTO
	STA DIVIDENDO

	JMP ROT

FIM	PLA
	STA DIVIDENDO
	RTS

;********************************************************
; Comparação de 2 números de 8bits
; Compara 2 números de 8 bits e retorna no
; Acumulador o resultado da operação:
;
; Retorna 00H se o primeiro número é igual ao segundo
; Retorna 01H se o primeiro número é menor que o segundo
; Retorna 02H se o primeiro número é maior que o segundo
;********************************************************
	;Compara se igual
CMP_8b	LDA RESTO
	CMP DIVISOR
	BNE CMP_8b_LB1
	LDA #$00
	JMP FIM_CMP

	;Compara se menor
CMP_8b_LB1	
	SEC
	CMP DIVISOR
	BCS CMP_8b_LB2
	LDA #$01
	JMP FIM_CMP
	
	;Compara se maior
CMP_8b_LB2
	LDA #$02

FIM_CMP	RTS

;********************************************************
; Subtração de 2 números de 8bits
;********************************************************
SUB_8b	LDA DIVIDENDO
	CMP DIVISOR

	BCC MENOR

	LDA DIVIDENDO
	SEC
	SBC DIVISOR
	STA RESTO

	JMP FIM_SUB

MENOR	LDA DIVISOR
	SEC
	SBC DIVIDENDO
	STA RESTO
	LDA #$FF
	SEC
	SBC RESTO
	STA RESTO
	INC RESTO

FIM_SUB	RTS

;*********************************
;Soma de 2 números de 8bits
;*********************************
SUM_8b	LDA QUOCIENTE
	CLC
	ADC #$01
	STA QUOCIENTE
	RTS

	.END
