; Teste com o microprocessador 6502
; Compara duas strings retornando no acumulador
; 00H - Iguais
; 01H - Diferentes

PRBYTE	.EQU $FDDA	;Imprime um byte em hexadecimal

	.ORG $4000

	JSR STR_CMP
	JSR PRBYTE
	RTS

	;Compara as String1 com String2
STR_CMP	LDX #$0
	LDY #$0
LOOP1	LDA String1,X
	CMP #$00
	BEQ IGUAL1
	CMP String2,Y
	BNE DIF
	INX
	INY
	JMP LOOP1

	;Compara as String2 com String1
IGUAL1	LDX #$0
	LDY #$0
LOOP2	LDA String2,X
	CMP #$00
	BEQ IGUAL2
	CMP String1,Y
	BNE DIF
	INX
	INY
	JMP LOOP2

IGUAL2	LDA #$00
	RTS

DIF	LDA #$01
	RTS

String1	.text "String 1"
	.byte 0

String2	.text "String 1X"
	.byte 0

	.END
