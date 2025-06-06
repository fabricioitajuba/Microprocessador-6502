; Teste com o microprocessador 6502
; Lê o teclado e mostra na tela.
; Sai quando RETURN (ENTER) é pressionada

SCAN1	.EQU $F043	;Verifica 1 vez o teclado
COUT	.EQU $FDED	;Imprime um caracter
WAIT	.EQU $FCA8	;Gera um delay
PRBYTE	.EQU $FDDA	;Imprime um byte em hexadecimal
CROUT	.EQU $FD8E	;Pula linha e retorna na primeira posição

	.ORG $4000

LOOP	JSR SCAN1
	BCC LOOP
	CMP #$8D
	BEQ SAIR
	;JSR PRBYTE
	JSR COUT
	JSR BOUNCE
	JMP LOOP

SAIR	RTS

BOUNCE	PHA
	LDA #$FF
	JSR WAIT
	PLA
	RTS

	.END
