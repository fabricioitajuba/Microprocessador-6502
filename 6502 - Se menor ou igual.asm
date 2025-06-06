; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 06/06/2025
;
; Se menor ou igual retorna 1 no acumulador

PRBYTE	.EQU $FDDA	;Imprime um byte em hexadecimal

	.ORG $4000	;Início do programa
	
	LDA #$07	;Carrega acumulador com 07H
	CMP #$07	;Compara com 07H
	BEQ ROT		;Se igual, salta para ROT
	BMI ROT		;Se menor, salta para ROT
	LDA #00		;Caso diferente, carrega o acumulador com 00H
	JMP PRINT	;Salta para a impressão
ROT	LDA #01		;Carrega o acumulador com 01H
PRINT	JSR PRBYTE	;Imprime o resultado
	RTS		;Retorna da sub-rotina

	.END
