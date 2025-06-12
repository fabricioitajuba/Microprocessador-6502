; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 12/06/2025
; Move blocos
; Endereço inicial REG1
; Endereço inicial do bloco REG2
; Número de bytes - NBYTES 

REG1L	.EQU $11
REG1H	.EQU $12
REG2L	.EQU $13
REG2H	.EQU $14
NBYTES	.EQU $15

	.ORG $4000

	;4000H
	LDA #$40
	STA REG1H
	LDA #$00
	STA REG1L

	;5000H
	LDA #$50
	STA REG2H
	LDA #$00
	STA REG2L

	;05H BYTES
	LDA #$05
	STA NBYTES

	JSR MOV_BLK

	RTS

MOV_BLK	LDX NBYTES
	LDY #$00
CP_ROT	CPX #$00
	BEQ END_CMD_CP
	LDA (REG1L),Y
	STA (REG2L),Y
	INY
	DEX
	JMP CP_ROT

END_CMD_CP
	RTS

	.END