; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 05/06/2025
; Ajuste decimal no acumulador DAA através do comando SED
;
;http://www.6502.org/tutorials/decimal_mode.html
;
; Sem SED: 01H+09H=0AH
; Com SED: 01H+09H=10D

RES	.EQU $10

	.ORG $4000

	LDA #$00
	STA RES

	SED
	LDA #$09
	ADC #$01

	STA RES
	RTS

	.END
