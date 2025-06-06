; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 05/06/2025
; Interpreta comandos
; Carregar o arquivo. 6502-cmd.obj no TK2000

OFFSET	.EQU $10
REG1L	.EQU $11
REG1H	.EQU $12
REG2L	.EQU $13
REG2H	.EQU $14
AUX	.EQU $15

CH	.EQU $0024	;Coluna (0-39)
CV	.EQU $0025	;Linha (0-23)

SCAN1	.EQU $F043	;Verifica 1 vez o teclado
CLRSCR	.EQU $F832 	;Limpa a tela
COUT	.EQU $FDED	;Imprime um caracter
WAIT	.EQU $FCA8	;Gera um delay
CROUT	.EQU $FD8E	;Pula linha e retorna na primeira posição
CARAC	.EQU $FDED 	;Imprime um caracter
PRERR	.EQU $FF2D	;Imprime erro com beep

	.ORG $4000

	JSR BOUNCE
CMD	LDA #$00		;Zera a posição
	STA OFFSET		;de offset
	LDA #$A4		;Cursor
	JSR COUT		;"$"

LOOP	JSR SCAN1
	BCC LOOP
	CMP #$8D
	BEQ ENTER

	LDX OFFSET		;Armazena a 
	STA BUFFER,X		;tecla pressionada
	INX			;no buffer
	STX OFFSET		;e incrementa o offset

	JSR COUT
	JSR BOUNCE
	JMP LOOP

ENTER	JSR BOUNCE
	LDA #$00		;Adiciona
	LDX OFFSET		;00H na última
	STA BUFFER,X		;posição da
	JSR CROUT		;string

	;Interpreta comandos
	LDA #BUFFER & $FF	;Armazena o
	STA REG1L		;endereço do
	LDA #BUFFER >> 8	;Buffer do teclado
	STA REG1H		;em REG1L e REG1H

	;Comando CLEAR
_CMD1	LDA #CMD1 & $FF		;Armazena o
	STA REG2L		;endereço do
	LDA #CMD1 >> 8		;da string do
	STA REG2H		;comando CLEAR
	JSR STR_CMP		;Compara as strings
	CMP #$01		;Se for igual, executa o
	BNE _CMD2		;comando. Caso diferente
	JSR CMD_CLEAR		;passa para o próximo comando
	JMP EXIT

	;Comando EXIT
_CMD2	LDA #CMD2 & $FF		;Armazena o
	STA REG2L		;endereço do
	LDA #CMD2 >> 8		;da string do
	STA REG2H		;comando EXIT
	JSR STR_CMP		;Compara as strings
	CMP #$01		;Se for igual, executa o
	BNE ERRO		;comando. Caso diferente
	JMP CMD_EXIT		;passa para o próximo comando
	JMP EXIT

ERRO	LDA #MSG_ERR & $FF	;Imprime
	STA REG2L		;menssagem
	LDA #MSG_ERR >> 8	;de
	STA REG2H		;erro
	JSR PRINTF
	JSR CROUT

EXIT	JMP CMD


;*************************************
; Comando CLEAR, limpa a tela e coloca
; o cursor na primeira posição
;*************************************
CMD_CLEAR
	JSR CLRSCR		;Limpa a tela
	LDA #$00		;Coloca o
	STA CH			;Cursor na
	STA CV			;Primeira posição
	RTS

;*************************************
; Comando EXIT, sai do programa
; e retorna ao monitor
;*************************************
CMD_EXIT
	RTS

;*************************************
;Gera um atraso
;*************************************
BOUNCE	PHA
	LDA #$FF
	JSR WAIT
	PLA
	RTS

;*************************************
;Imprime uma menssagem na tela
;REG2 - Ponteiro da menssagem
;*************************************
PRINTF	LDY #$00
LOOP3	LDA (REG2L),Y
	CMP #$00
	BEQ FIM_F
	JSR CARAC
	INY
	JMP LOOP3
FIM_F	RTS

;*************************************
; Compara Strings
; A=00H - Iguais
; A=01H - Diferentes
;*************************************
STR_CMP	LDY #$0
LOOP1	LDA (REG1L),Y
	CMP #$00
	BEQ IGUAL1
	CMP (REG2L),Y
	BNE DIF
	INY
	JMP LOOP1

IGUAL1	LDY #$0
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

;*************************************
; Strigs dos comandos
;*************************************
MSG_ERR	.byte $C5, $D2, $D2, $CF, $A1, 0	;ERRO
CMD1	.byte $C3, $CC, $C5, $C1, $D2, 0	;CLEAR
CMD2	.byte $C5, $D8, $C9, $D4, 0		;EXIT

	;Buffer do teclado
BUFFER	.block 20	;Buffer com 20 posições

	.END
