; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 16/06/2025
; Conversão Hexadecimal para Decimal de 16 bits
;
; NLSB - LSB 16 bits
; NMSB - MSB 16 bits

NLSB	.EQU $10	;LSB do número
NMSB	.EQU $11	;MSB do número

DIG1	.EQU $12	;Digito 1
DIG2	.EQU $13	;Digito 2
DIG3	.EQU $14	;Digito 3
DIG4	.EQU $15	;Digito 4
DIG5	.EQU $16	;Digito 5

	.ORG $4000

	LDA #$FF
	STA NLSB
	LDA #$FF
	STA NMSB
	JSR HEXA_DEC16b
	RTS

HEXA_DEC16b
	LDA #$00	;Carrega acumulador 00H
	STA DIG1	;Zera o digito 1
	STA DIG2	;Zera o digito 2
	STA DIG3	;Zera o digito 3
	STA DIG4	;Zera o digito 4
	STA DIG5	;Zera o digito 5

TSTLSB	LDA NLSB
	CMP #$00
	BEQ TSTMSB

	JMP ROT

TSTMSB	LDA NMSB
	CMP #$00
	BEQ FIM

ROT	DEC NLSB
	LDA NLSB
	CMP #$FF
	BNE INCX
	DEC NMSB

INCX	INC DIG1
	LDA DIG1
	CMP #$0A
	BEQ DIG2X
	JMP TSTLSB

DIG2X	LDA #$00
	STA DIG1
	INC DIG2
	LDA DIG2
	CMP #$0A
	BEQ DIG3X
	JMP TSTLSB

DIG3X	LDA #$00
	STA DIG2
	INC DIG3
	LDA DIG3
	CMP #$0A
	BEQ DIG4X
	JMP TSTLSB

DIG4X	LDA #$00
	STA DIG3
	INC DIG4
	LDA DIG4
	CMP #$0A
	BEQ DIG5X
	JMP TSTLSB

DIG5X	LDA #$00
	STA DIG4
	INC DIG5
	JMP TSTLSB

FIM	RTS

	.END
