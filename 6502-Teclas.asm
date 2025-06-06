; Teste com o microprocessador 6502
; Faz a leitura das teclas "setas" e mostra na tela
; a tecla pressionada

CH	.EQU $0024
CV	.EQU $0025

CARAC	.EQU $FDED ;Imprime um caracter
DELAY	.EQU $FCA8 ;Gera um delay
CLRSCR	.EQU $F832 ;Limpa a tela

	.ORG $0300

	JSR CLRSCR	;Limpa a tela

	LDA #$00	;Coloca o
	STA CH		;Cursor na
	STA CV		;Primeira posição

	LDA #$AA	;Imprime
	JSR CARAC	; *

	LDA #$00	;Coloca o
	STA CH		;Cursor na
	STA CV		;Primeira posição


INICIO	LDA #$04	;tecla
	STA $C000	;espaço
	LDA $C010
	AND #$01
	CMP #$01
	BEQ TCS

LEFT	LDA #$08	;tecla
	STA $C000	;left
	LDA $C010
	AND #$01
	CMP #$01
	BEQ TCL

RIGHT	LDA #$10	;tecla
	STA $C000	;right
	LDA $C010
	AND #$01
	CMP #$01
	BEQ TCR

DOWN	LDA #$20	;tecla
	STA $C000	;down
	LDA $C010
	AND #$01
	CMP #$01
	BEQ $TCD

UP	LDA #$40	;tecla
	STA $C000	;up
	LDA $C010
	AND #$01
	CMP #$01
	BEQ TCU
	JMP INICIO

TCS	LDA #$D3	;Tecla espaço
	JSR CARAC	;sai do
	RTS		;programa

TCL	JSR ANT_B
	LDA #$CC	;Seta
	JSR CARAC	;esquerda
	JMP INICIO

TCR	JSR ANT_B
	LDA #$D2	;Seta
	JSR CARAC	;direita
	JMP INICIO

TCD	JSR ANT_B
	LDA #$C4	;Seta
	JSR CARAC	;baixo
	JMP INICIO

TCU	JSR ANT_B
	LDA #$D5	;Seta
	JSR CARAC	;cima
	JMP INICIO

	;Ant-bounce
ANT_B	PHA
	LDA #$FF
	JSR DELAY
	PLA
	RTS

	.END
