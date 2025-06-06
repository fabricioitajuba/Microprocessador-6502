; Teste com o microprocessador 6502

CARAC	.EQU $FDED
DELAY	.EQU $FCA8

	.ORG	$0300

INICIO	LDA #$04	;tecla
	STA $C000	;espaço
	LDA $C010
	AND #$01
	CMP #$01
	BEQ TCS
	JMP INICIO

TCS	LDA #$D3
	JSR CARAC
	RTS

	.END
