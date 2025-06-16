; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 16/06/2025
; Conversão Hexadecimal para Decimal
;

DIG1	.EQU $10	;Digito 1
DIG2	.EQU $11	;Digito 2
DIG3	.EQU $12	;Digito 3


	.ORG $4000

	LDA #$FF

	PHA
	LDA #$00
	STA DIG1
	STA DIG2
	STA DIG3
	PLA

	TAX

ROT	CPX #$00
	BEQ FIM
	DEX
	INC DIG1
	LDA DIG1
	CMP #$0A
	BEQ DIG2X
	JMP ROT

DIG2X	LDA #$00
	STA DIG1
	INC DIG2
	LDA DIG2
	CMP #$0A
	BEQ DIG3X
	JMP ROT

DIG3X	LDA #$00
	STA DIG2
	INC DIG3
	JMP ROT

FIM	RTS

	.END
