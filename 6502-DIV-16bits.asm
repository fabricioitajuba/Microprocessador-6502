; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 12/06/2025
; Divisão de um número de 16bits por um de 8bits
; Dividendo/Divisor = Quociente e Resto
; REG1/REG2 = REG4 e REG3
;
; Status: Não concluído

COMP	.EQU $10 ;Resultado da comparação

	.ORG $4000

	;Dividendo FFFFH
	LDA #$FF
	STA REG1H
	LDA #$FF
	STA REG1L

	;Divisor 000FH
	LDA #$00
	STA REG2H
	LDA #$0F
	STA REG2L

	JSR DIV_16b

	RTS

;*********************************
;Divisão de 2 números de 16bits
;*********************************
DIV_16b	JSR SUB_16b	;Subtrai o divisor do Dividendo
	JSR SUM_16b	;Soma 1 no Quociente
	JSR CMP_16b	;Compara o Resto com o Divisor
	CMP #$01	;Se o Resto for menor que o Divisor,
	BEQ EXIT	;Sai da sub-rotina

	LDA REG3H	;Transfere
	STA REG1H	;o resto para
	LDA REG3L	;para o
	STA REG1L	;dividendo

	JMP DIV_16b	;Executa novamente todo o processo
	
EXIT	RTS

;*********************************
; Comparação de 2 números de 16bits
; REG3 E REG2
; Retorna no Acumulador o resultado da operação:
;
; Retorna 0 se o primeiro número é igual ao segundo
; Retorna 1 se o primeiro número é menor que o segundo
; Retorna 2 se o primeiro número é maior que o segundo
;*********************************
	;Compara se igual
CMP_16b	LDA REG3H
	CMP REG2H
	BEQ LB0
	JMP LB2
LB0	LDA REG3L
	CMP REG2L
	BEQ LB1
	JMP LB2
LB1	LDA #$00
	JMP FIM_CMP

	;Compara se menor
LB2	LDA REG3H
	CMP REG2H
	BEQ LB3
	LDA REG3H
	SEC
	CMP REG2H
	BCC LB4
	JMP MAIOR
LB3	LDA REG3L
	SEC
	CMP REG2L
	BCC LB4
	JMP MAIOR	
LB4	LDA #$01
	JMP FIM_CMP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Compara se maior
MAIOR	LDA #$02

FIM_CMP	RTS

;*********************************
; Subtração de 2 números de 16bits
; REG1 - Primeiro número
; REG2 - Segundo número
; REG3 - Resultado
;*********************************
SUB_16b
	LDA REG1H
	STA REG3H

	LDA REG1L
	STA REG3L

	LDA REG1L
	CMP REG2L

	BCC LB9

	SEC
	SBC REG2L
	STA REG3L
	JMP LB11

LB9	LDA REG2L
	SEC
	SBC REG1L
	STA REG3L
	LDA #$FF
	SEC
	SBC REG3L
	STA REG3L
	INC REG3L
	JMP LB10

	CLC
	SBC REG2L
	STA REG3L
LB10	DEC REG3H

LB11	LDA REG3H	
	SEC
	SBC REG2H
	STA REG3H

	RTS

;*********************************
;Soma de 2 números de 16bits
;*********************************
SUM_16b	LDA REG4L
	CLC
	ADC REG5L
	BCC LB12
	INC REG6H
LB12	STA REG6L
	LDA REG6H
	CLC
	ADC REG5H
	BCC LB13
	INC CARRY
LB13	CLC
	ADC REG4H	
	BCC LB14
 	INC CARRY
LB14	STA REG6H

	LDA REG6H
	STA REG4H

	LDA REG6L
	STA REG4L

	RTS

	;Variáveis do sistema
REG1L	.BYTE $00 ;Dividendo
REG1H	.BYTE $00 ;

REG2L	.BYTE $00 ;Divisor
REG2H	.BYTE $00 ;

REG3L	.BYTE $00 ;Resto
REG3H	.BYTE $00 ;

REG4L	.BYTE $00 ;Quociente
REG4H	.BYTE $00 ;

REG5L	.BYTE $01 ;Soma
REG5H	.BYTE $00 ;

REG6L	.BYTE $00 ;Soma
REG6H	.BYTE $00 ;

CARRY	.BYTE $00 ;

	.END
