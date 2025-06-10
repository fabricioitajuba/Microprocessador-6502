; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 05/06/2025
; Interpreta comandos com argumentos
; Carregar o arquivo. 6502-cmd.obj no TK2000

;Constantes
MAXCOL	.EQU $14	;Máxima coluna do vídeo

;Variáveis do sistema
OFFSET	.EQU $10
REG1L	.EQU $11
REG1H	.EQU $12
REG2L	.EQU $13
REG2H	.EQU $14
AUX	.EQU $15

;Variáveis do programa monitor
CH	.EQU $0024	;Coluna (0-39)
CV	.EQU $0025	;Linha (0-23)

;Rotinas do programa monitor
SCAN1	.EQU $F043	;Verifica 1 vez o teclado
CLRSCR	.EQU $F832 	;Limpa a tela
COUT	.EQU $FDED	;Imprime um caracter
WAIT	.EQU $FCA8	;Gera um delay
CROUT	.EQU $FD8E	;Pula linha e retorna na primeira posição
CARAC	.EQU $FDED 	;Imprime um caracter
PRERR	.EQU $FF2D	;Imprime erro com beep
BELL1	.EQU $FBDD	;Beep de curta duração
SETINV	.EQU $FE80	;Converte vídeo para o modo inverso
SETNORM	.EQU $FE84	;Retorna o vídeo para o modo normal

	.ORG $4000

	JSR BOUNCE

	LDA #MSG_OS & $FF	;Imprime
	STA REG2L		;menssagem
	LDA #MSG_OS >> 8	;de
	STA REG2H		;entrada no
	JSR PRINTF		;sistema operacional
	JSR CROUT		;Pula linha e retorna posição 1
	JSR BELL1		;Beep

CMD	LDA #$00		;Zera a posição
	STA OFFSET		;de offset
	LDA #$A3		;Cursor
	JSR COUT		;"#"

LOOP	JSR SCAN1		;Lê o teclado e se nenhuma tecla
	BCC LOOP		;foi pressionada, volta a ler

	CMP #$8D		;Verifica se a tecla ENTER
	BEQ ENTER		;Foi pressionada

	CMP #$88		;Verifica se a tecla BACKSPACE ou SETA ESQUERDA
	BEQ BCKSPC		;Foi pressionada

	CMP #$95		;Verifica se a tecla SETA DIREITA
	BEQ SDIR		;Foi pressionada

	LDX OFFSET		;Armazena a tecla
	STA BUFFER,X		;pressionada no buffer
	INX			;Incrementa offset

	CPX #MAXCOL+1		;
	BNE P4
	DEX
	DEC CH

P4	STX OFFSET		;guarda seu valor

	JSR COUT		;Mostra a tecla pressionada no vídeo
	JSR BOUNCE		;Trata o bounce da tecla
	JMP LOOP		;Volta a ler uma tecla

	;Trata tecla BACKSPACE ou SETA ESQUERDA
BCKSPC	JSR BOUNCE		;Trata bounce do teclado

	DEC CH			;Retorna 1 posição do cursor na horizontal
	LDA CH			;Limita o
	CMP #$00		;cursor
	BNE P1			;na segunda
	INC CH			;coluna

P1	LDA #$A0		;Limpa a A0
	JSR CARAC		;posição
	DEC CH			;Retorna 1 posição do cursor na horizontal

	DEC OFFSET		;Decrementa a posição de OFFSET
	LDA OFFSET		;Limita 
	CMP #$FF		;OFFSET
	BNE P2			;em
	INC OFFSET		;00H

P2	JMP LOOP		;Volta a ler uma tecla

	;Trata tecla SETA DIREITA
SDIR	JSR BOUNCE		;Trata bounce do teclado

	LDX OFFSET
	LDA #$00
	STA BUFFER,X

	LDA #$A0		;Imprime espaço
	JSR CARAC		;posição

	INC OFFSET		;Incrementa a posição de OFFSET
	LDA OFFSET
	CMP #MAXCOL+1
	BNE P3
	DEC OFFSET
	DEC CH

P3	JMP LOOP		;Volta a ler uma tecla

	;Trata tecla ENTER
ENTER	JSR BOUNCE		;Trata bounce do teclado
	LDA #$00		;# Adiciona
	LDX OFFSET		;# 00H na última
	STA BUFFER,X		;# posição da		
	JSR CROUT		;Pula uma linha e retorna o cursor

	;Copia o comando do buffer de teclado para o buffer de comando
	LDX #$00		;Zera offset
LOOPC	LDA BUFFER,X		;Carrega o caracter em BUFFER
	CMP #$00		;Compara com #$00
	BEQ BCOM		;Se igual, salta para BCON
	CMP #$A0		;Compara com #$A0 "Espaço"
	BEQ BCOM		;Se igual, salta para BCON
	STA BCOMAND,X		;Caso não seja #$00 ou #$A0, guarda em BCOMAND
	INX			;Incrementa offset
	JMP LOOPC		;Volta a ler buffer

	;Interpreta comandos
BCOM	LDA #$00		;Coloca #$00
	STA BCOMAND,X		;depois do último caracter

	LDA #BCOMAND & $FF	;Armazena o
	STA REG1L		;endereço do
	LDA #BCOMAND >> 8	;Buffer de comando
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
	JSR CROUT		;Pula linha e retorna posição 1
	JSR BELL1		;Beep

EXIT	;RTS			;################################### TESTE
	JMP CMD			;Retorna para ler outro comando


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
	JSR BELL1		;Beep
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
MSG_OS	.byte $D4, $CB, $CF, $D3, $AD, $D6, $B0, $AE, $B1, $A0, $AD, $A0, $B1, $B9, $B8, $B5, $AD, $B2, $B0, $B2, $B5, 0
MSG_ERR	.byte $C5, $D2, $D2, $CF, $A1, 0	;ERRO
CMD1	.byte $C3, $CC, $C5, $C1, $D2, 0	;CLEAR
CMD2	.byte $C5, $D8, $C9, $D4, 0		;EXIT

	;Buffer do teclado
BUFFER	.block 20	;Buffer com 20 posições
	;Buffer de comando
BCOMAND	.block 10	;Buffer para comando

	.END
