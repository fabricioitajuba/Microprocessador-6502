; Teste com o microprocessador 6502

CARAC	.EQU $FDED
DELAY	.EQU $FCA8

	.ORG	$0300

INICIO	LDA #$04	;tecla
	STA $C000	;espaço
TCS	LDA #01
	AND $C010
	BEQ TCS

	LDA #$D3
	JSR CARAC
	RTS

	.END
