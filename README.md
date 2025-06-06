# Microprocessador-6502
Exemplo de programas utilizando o Microprocessador 6502 com o TK2000
```
Os exemplos foram executados através de um emulador do TK2000 que pode ser baixado:
https://datassette.org/softwares/br-brasil-aplicativos-tk-2000-mpf-ii-apple-softwares/00-emulador-tk2000

Toda documentação do TK2000 pode ser baixada no seguinte link:
https://datassette.org/softwares/tk-2000-mpf-ii

Os programas foram compilados através do TASM:
https://www.ticalc.org/archives/files/fileinfo/250/25051.html

Para compilar:
tasm -65 -x -b programa.asm

Será gerado 2 arquivos:
.lst - com informações da compilação
.obj - binário que poderá ser carregado no emulador do TK2000

O arquivo .obj pode ser carregado diretamente no emulador do TK2000
Memória->Importa (digite o "endereço base do programa" em "inteiro")

## Memória do TK2000: 

65536 posições dividida em páginas de 256 bytes = 256 páginas

RAM: 192 páginas - 0000H-BFFFH
I/O:   1 página  - C000H-C0FFH
ROM: 63 páginas  - C100H-FFFFH

Página - RAM
       0h - 0000H-00FFH - Variáveis do sistema
       1h - 0100H-01FFH - Stack Pointer
       2h - 0200H-02FFH - Buffer do teclado
       3h - 0300H-03FFH - Periféricos/Sistema.
                          0300-03EF - Uso geral
 4h a 7h  - 0400H-07FFH - Monitor/Sistema/Periféricos
 8h a 1Fh - 0800H-1FFFH - Uso geral/Basic a partir da página 8
20h a 3Fh - 2000H-3FFFH - Primeira página de vídeo texto baixa/alta resolução
40h a 9Fh - 4000H-9FFFH - Uso geral
A0h a BFh - A000H-BFFFH - Segunda página de vídeo texto baixa/alta resolução

C192H - Mini-assembler
FF61H - comando MD (entrando no monitor)


## I/O
C000H - Coluna do teclado (escrita)
C010H - Linha do teclado (leitura)
C020H - Saída de gravador
C030H - Som
C050H - Vídeo colorido
C051H - Video branco/preto
C052H - MotorA/Desligado
C053H - MotorA/Ligado
C054H - Primeira página de vídeo
C055H - Segunda página de vídeo
C056H - MotorB/Desligado
C057H - MotorB/Ligado
C058H - Strobe de impressora baixo
C059H - Strobe de impressora alto
C05AH - Selecionador de ROM
C05BH - Selecionador de RAM
C05EH - Linha que seleciona a tecla Ctrl (baixo)
C05FH - Linha que seleciona a tecla Ctrl (alto)

- Entrar no monitor:
>LM

- Sair do monitor:
@<Ctrl+C> <ENTER>

Examinar posições:
@0400 <ENTER>

Examinar várias posições:
@0400.040C <ENTER>

Editar programas (no final deve ter RTS):
@0400:A9 C1 20 ED FD 18 69 01 C9 DB D0 F6 60 <ENTER>

Executar programas:
@0400G <ENTER>

Disassembler:
@0400L
0400	A9 C1		LDA #$C1
0402	20 ED FD	JSR $FDED
0405	18		CLC
0406	69 01		ADC #$01
0408	C9 DB		CMP #$DB
040A	D0 F6		BNE $0402
040C	60		RTS

- teste:
@0410:A9 FA 20 4A FF 60

<Ctrl+E> <ENTER> "Podemos ver o conteúdo do acumulador alterado"

	A=00 X=00 Y=00 P=A0 S=F2

@0410L

0410	A9 FA		LDA #$FA
0412	20 4A FF	JSR $FF4A
0415	60		RTS

@0410G

<Ctrl+E> <ENTER> "Podemos ver o conteúdo do acumulador alterado"

	A=FA X=00 Y=00 P=A0 S=F2

### Mini-Assembler (PÁGINA 18)
Para entrar do monitor: C192G <ENTER>
Para sair do monitor: FF61G <ENTER>

Programa:

!0410:LDA #$FA
! JSR $FF4A
! RTS

Executar
!$0410G

Algumas sub-rotinas:
- FF4AH - Atualializa as posições de memória referente ao registradores

<Ctrl+E> <ENTER> "Podemos ver o conteúdo do acumulador alterado"

- F043H - SCAN1 - Faz a Leitura do teclado 1 vez e seta o bit de carry
                  quando uma tecla foi pressionada colocando seu valor
                  ASCII no acumulador.
- F832H - CLRSCR - Limpa a tela inteira de baixa resolução
- F59DH - TABASC - Tabela ASCCI
- FB02H - Leitura do teclado (SEM ANTBOUNCE)
- FCA8H - WAIT - Atraso = (26+27*A+5*A^2) [us]
- FDEDH - COUT - Mostra o caracter presente no acumulador de acordo 
                 com o código
- FF2DH - PRERR - Imprime a menssagem "ERR" seguido de um "BEEP"
- FF4AH - IOSAVE - Salva todos os registradores nas posições:
	A : 7F0H
	X : 7F1H
	Y : 7F2H
	P : 7F3H
	S : 7F4H

- Teclado

C000H - Escrita - Seleciona uma linha
C010H - Leitura - Lê a coluna
```
