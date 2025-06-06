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
