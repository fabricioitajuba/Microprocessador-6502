; Teste com o microprocessador 6502
; Retorna no acumulador o número de bytes de uma string

PRBYTE	.EQU $FDDA	;Imprime um byte em hexadecimal

	.ORG $4000
	JSR STR_LEN
	JSR PRBYTE
	RTS

STR_LEN	LDY #$00
LOOP	LDX String1,Y
	CPX #$00
	BEQ FIM
	INY
	JMP LOOP
FIM	TYA
	RTS

String1	.text "String1"
	.byte 0

	.END
