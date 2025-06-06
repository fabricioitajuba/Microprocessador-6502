; Teste com o microprocessador 6502
; Compara duas strings retornando no acumulador
; 01H - Iguais
; 00H - Diferentes

REG1L	.EQU $11
REG1H	.EQU $12
REG2L	.EQU $13
REG2H	.EQU $14

PRBYTE	.EQU $FDDA	;Imprime um byte em hexadecimal

	.ORG $4000

	LDA #String1 & $FF
	STA REG1L
	LDA #String1 >> 8
	STA REG1H

	LDA #String2 & $FF
	STA REG2L
	LDA #String2 >> 8
	STA REG2H

	JSR STR_CMP
	JSR PRBYTE
	RTS

	;Compara as String1 com String2
STR_CMP	LDY #$00
LOOP1	LDA (REG1L),Y
	CMP #$00
	BEQ IGUAL1
	CMP (REG2L),Y
	BNE DIF
	INY
	JMP LOOP1

	;Compara as String2 com String1
IGUAL1	LDY #$00
LOOP2	LDA (REG2L),Y
	CMP #$00
	BEQ IGUAL2
	CMP (REG1L),Y
	BNE DIF
	INY
	JMP LOOP2

IGUAL2	LDA #$01
	RTS

DIF	LDA #$00
	RTS

String1	.text "String 1"
	.byte 0

String2	.text "String 1"
	.byte 0

	.END