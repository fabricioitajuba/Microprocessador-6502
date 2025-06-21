; Teste com o microprocessador 6502
; Autor: Eng. Fabrício Ribeiro
; Data: 20/06/2025
; Divisão de dois números de 16bits
; Dividendo/Divisor = Quociente e Resto
; EX:
; FFFFH/000FH = 1111H
; 4A3BH/2C1DH = 0001H + 1E1EH

	;Variáveis do sistema
HIDIVIDENDOL	.EQU $10 ;Dividendo HI
HIDIVIDENDOH	.EQU $11 ;

LODIVIDENDOL	.EQU $12 ;Dividendo LO
LODIVIDENDOH	.EQU $13 ;

DIVISORL	.EQU $14 ;Divisor
DIVISORH	.EQU $15 ;

QUOCIENTEL	.EQU $16 ;Quociente ****
QUOCIENTEH	.EQU $17 ;

RESTOL		.EQU $18 ;Resto ****
RESTOH		.EQU $19 ;

N		.EQU $1A ;Contador

	.ORG $4000

	;Dividendo 0000FFFFH
	LDA #$00
	STA HIDIVIDENDOH
	LDA #$00
	STA HIDIVIDENDOL
	LDA #$FF
	STA LODIVIDENDOH
	LDA #$FF
	STA LODIVIDENDOL

	;Divisor 000FH
	LDA #$00
	STA DIVISORH
	LDA #$01
	STA DIVISORL

	JSR DIV_16b

	RTS

;*********************************
;Divisão de 2 números de 16bits
;*********************************
DIV_16b	LDA LODIVIDENDOH
	PHA
	LDA LODIVIDENDOL
	PHA
	LDA HIDIVIDENDOH
	PHA
	LDA HIDIVIDENDOL
	PHA

START:  LDA LODIVIDENDOL
        LDY HIDIVIDENDOL
        STY LODIVIDENDOL
        ASL A
        STA HIDIVIDENDOL
        LDA LODIVIDENDOH
        LDY HIDIVIDENDOH
        STY LODIVIDENDOH
        ROL A
        STA HIDIVIDENDOH
        LDA #$10
        STA N

loop:   ROL LODIVIDENDOL
        ROL LODIVIDENDOH
        SEC
        LDA LODIVIDENDOL
        SBC DIVISORL
        TAY
        LDA LODIVIDENDOH
        SBC DIVISORH
        BCC skip
        STY LODIVIDENDOL
        STA LODIVIDENDOH
skip:   ROL HIDIVIDENDOL
        ROL HIDIVIDENDOH

        DEC N
        BNE loop

	LDA HIDIVIDENDOH
	STA QUOCIENTEH
	LDA HIDIVIDENDOL
	STA QUOCIENTEL
	LDA LODIVIDENDOH
	STA RESTOH
	LDA LODIVIDENDOL
	STA RESTOL

	PLA
	STA HIDIVIDENDOL
	PLA
	STA HIDIVIDENDOH
	PLA
	STA LODIVIDENDOL
	PLA
	STA LODIVIDENDOH

	RTS

	.END
