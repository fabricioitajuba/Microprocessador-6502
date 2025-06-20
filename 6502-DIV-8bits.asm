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
	
ROT	LDA DIVIDENDO
	SEC
	SBC DIVISOR
	STA RESTO

	INC QUOCIENTE

	LDA RESTO
	CLC
	CMP DIVISOR		
	BCC EXIT

	LDA RESTO
	STA DIVIDENDO
	
	JMP ROT

EXIT	PLA
	STA DIVIDENDO
	RTS

	.END
