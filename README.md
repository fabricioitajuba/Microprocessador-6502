# Microprocessador-6502
Exemplo de programas utilizando o Microprocessador 6502 com o TK2000

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
