; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 12/06/2025
; Subtração em 16bits
; NUM1 - REG1 - Maior número
; NUM2 - REG2 - Menor número
; RES - REG3 - Resultado
;
;   REG1H REG1L
; - REG2H REG2L
;--------------
;   REG3H REG3L
;Ex:
;   E3B7
; - C3F2
;--------
;   1FC5

REG1L	.EQU $11
REG1H	.EQU $12
REG2L	.EQU $13
REG2H	.EQU $14
REG3L	.EQU $15
REG3H	.EQU $16

	.ORG $4000

	;E3B7H
	LDA #$E3
	STA REG1H
	LDA #$B7
	STA REG1L

	;C3F2H
	LDA #$C3
	STA REG2H
	LDA #$F2
	STA REG2L

	JSR SUB_16b

	RTS

;*********************************
;Subtração de 2 números de 16bits
;*********************************
SUB_16b
	LDA REG1H
	STA REG3H

	LDA REG1L
	STA REG3L

	LDA REG1L
	CMP REG2L

	BCC MENOR

MAIOR_IGUAL
	SEC
	SBC REG2L
	STA REG3L
	JMP FIM

MENOR	LDA REG2L
	SEC
	SBC REG1L
	STA REG3L
	LDA #$FF
	SEC
	SBC REG3L
	STA REG3L
	INC REG3L
	JMP FIM1

SUB	CLC
	SBC REG2L
	STA REG3L
FIM1	DEC REG3H

FIM	LDA REG3H	
	SEC
	SBC REG2H
	STA REG3H

	RTS

	.END
