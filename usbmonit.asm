;ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
;บ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ บ
;บ Û               ÜÜÜÜÜÜÜÜÜÜ Û DATA: 26/12/2007 Û   AUTOR: ANAXAGORAS  Û บ
;บ Û    FINDNET    TECNOLOGIA Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ
;บ Û               ฿฿฿฿฿฿฿฿฿฿ Û       Terminal de Texto FindCar         Û บ
;บ ฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ บ
;ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ


WMCON				equ	96h

Val_FimDeMensagem		equ	'['

Val_FimTabela			equ	0F0h
Val_IndiceRamDecimal		equ	0F2h
Val_IndiceRam			equ	0F3h	; Envia o Byte considerando que ele eh BCD compactado
Val_IndiceHexaRam		equ	0F4h	; Envia o Byte sem fazer nenhum tratamento
Val_ComandoLcd			equ	0F5h
Val_DadoLcd			equ	0F8h
Val_Acknowledge			equ	0FAh
Val_IndiceFlag			equ	0FBh
Val_IndiceHexaDallas		equ	0FCh


Val_MaskLsb			equ	11110000b
Val_MaskMsb			equ	00001111b
Val_NumeroStart			equ	2
Val_PiscaCursor			equ	0Fh

;Comandos para o Lcd Serial

Tamanho_Lcd			equ	16
Val_IdentificacaoRtc		equ	11010000b
Val_IdentificacaoEeprom		equ     10100000b

;------------------------------------------------------------------------
;- -------------------------------------------------------------------- -
;- -		    Pinagem Externa (Dispositivos de I/O)  	      -	-
;- -------------------------------------------------------------------- -
;------------------------------------------------------------------------


; ------------------------ Pinos de Entrada

Pin_GreenIN		reg		p1.0
Pin_YelowIN		reg     p1.1
Pin_RedIN		reg     p1.2
Pin_SensorPorta	reg     p1.3

; ------------------------ Interfaces serial 485 (FindCar)

Pin_TxRx		reg	p3.3
Pin_RxSD		reg	p3.2 ;    R0
Pin_TxSD		reg	p3.4 ;    DI

; ------------------------ Buzzer

Pin_Buzzer		reg     p3.6 ;sck

; ------------------------ Interface com o sensor de temperatura

Pin_DadoTemperatura	reg	p3.7

Pin_LedGreen	reg p2.0	;L๓gica invertida
Pin_LedYelow	reg	p2.1    ;L๓gica invertida
Pin_LedRed		reg	p2.2 
Pin_LedFalha	reg	p2.3
Pin_Led0		reg	p2.4


;------------------------------------------------------------------------
;- -------------------------------------------------------------------- -
;- -		    DECLARACAO DE VARIAVEIS BYTES          	      -	-
;- -------------------------------------------------------------------- -
;------------------------------------------------------------------------


End_BufferRtc			equ	0000h
End_UltimaMensagem		equ	10h
End_BufferRelogio		equ	30h

Segundos			equ	30h	;| CH | , , , | , , , |  -> (00 - 59)
Minutos				equ	31h	;| 0 | , , , | , , , | -> (00 - 59)
Horas				equ	32h	;| 0 | 12/24 | 10H/AMPM , | , , , |
DiaDaSemana			equ	33h     ;(01 - 07) Dom=01
Dia				equ	34h     ;(01 - 31)
Mes				equ	35h     ;(01 - 12)
Ano				equ	36h     ;(00 - 99)
Reg_Controle			equ	37h     ;| OUT | 0 | 0 | SQWE | 0 | 0 | RS1 | RS0 |

Prs_10ms			equ	38h
Prs_250ms			equ	39h
Prs_MeioSegundo			equ	3Ah
Prs_Segundo			equ	3Bh
Time_Out			equ	3Ch
End_TabelaLow			equ	3Dh
End_TabelaHi			equ	3Eh
Tecla				equ	3Fh
Tempo_Bip			equ	40h
Contador			equ	41h
Pnt_BufferNMEA			equ	42h
Pnt_BufferSerial		equ	43h
Contador_Preambulo		equ	44h
Cnt_TimeOutSerial		equ	45h
Cnt_TimeOut			equ	46h
Tempo_Tarefa			equ	47h
Cursor				equ	48h
Ponteiro_Tela			equ	49h
Ponteiro_Buffer			equ	4Ah
Dispositivo_I2C			equ	4Bh
TamanhoDoBloco			equ	4Ch
Unidade				equ	4Dh
Dezena				equ	4Eh
Centena				equ	4Fh
Resultado			equ	50h
Tempo_Mensagem			equ	51h
Prs_Minuto			equ	52h
Pnt_LimiteHi			equ	53h
Pnt_LimiteLo			equ	54h
Pnt_UltimaMensagemHi		equ	55h
Pnt_UltimaMensagemLo		equ	56h
TimeOut_BipBip			equ	57h
Contador_Byte			equ	58h

Status_Semaforo			equ	59h
Status_Anterior			equ	60h					


; ------------------------ Buffer de Memoria

End_InicioBufferGPRMC			equ	0B0h
End_InicioBufferTecladoPC		equ	80h
End_InicioBufferMensagemRemota		equ	80h
End_BufferTemporario			equ	60h

End_WayPoint				equ	60h
Latitude_WayPoint			equ	60h
Longitude_WayPoint			equ	6Ah
Angulo_WayPoint				equ	75h

;Tab_WayPoint
;		;0123456789ABCDEF0123456789ABCD
;	db	'0344.6468,03829.7241,214.3'
;
;B               C               D               E               F
;0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef012345678
;$GPRMC,104934.000,A,0344.6468,S,03829.7241,W,70.1,120.0,290508,0.0,W,A;12<CR><LF>

; ------------------------ Banco de Registradores

;------------------------------------------------------------------------
;- -------------------------------------------------------------------- -
;- -		    DECLARACAO DE VARIAVEIS BITS           	      -	-
;- -------------------------------------------------------------------- -
;------------------------------------------------------------------------

Flg_1ms				equ	7Fh
Flg_10ms			equ	7Eh
Flg_100ms			equ	7Dh
Flg_250ms			equ	7Ch
Flg_MeioSegundo			equ	7Bh
Flg_Segundo			equ	7Ah
Flg_TimeOut			equ	79h

Flg_EnviaTelaMemoryCard		equ	78h
Flg_EnviaTelaSerial		equ	77h
Flg_Escape			equ	76h
Flg_TecladoPresente		equ	75h
Flg_Proximo			equ	74h
Flg_Anterior			equ	73h
Flg_BackSpace			equ	72h
Flg_Enter			equ	71h
Flg_TeclaEspecial		equ	70h
Flg_Deleta			equ	6Fh
Flg_ErroTeclado			equ	6Eh
Flg_TeclaOk			equ	6Dh
Flg_TeclaSolta			equ	6Ch
Flg_VerificaTeclado		equ	6Bh
Flg_FuncaoTeclado		equ	6Ah
Flg_ProximaLinha		equ	69h
Flg_LinhaAnterior		equ	68h
Flg_ProximoCaracter		equ	67h
Flg_CaracterAnterior		equ	66h
Flg_PulaEsperaLcd		equ	65h
Flg_Centena			equ	64h
Flg_RecebendoMensagem		equ	63h
Flg_EsperandoCoordenadas	equ	62h
Flg_MensagemTeclado		equ	61h
Flg_MensagemSerial		equ	60h
Flg_PacoteNMEA			equ	5Fh
Flg_ProximaTarefa		equ	5Eh
Flg_RecepcaoSerial		equ	5Dh
Flg_Ok				equ	5Ch
Flg_ComandoLcd			equ	5Bh
Flg_SendNible			equ	5Ah
Flg_VarreTeclado		equ	59h
Flg_BouncerOk			equ	58h
Flg_EditandoMensagemLocal	equ	57h
Flg_MostrandoMensagemRemota	equ	56h
Flg_LatitudeProxima		equ	55h
Flg_LongitudeProxima		equ	54h
Flg_PreambuloOk			equ	53h
Flg_ComparaNibbles		equ	52h
Flg_MemoriaDePograma		equ	51h
Flg_Bloco0MaiorQueBloco1	equ	50h
Flg_Bloco0MenorQueBloco1	equ	4Fh
Flg_MemoriaDePrograma		equ	4Eh
Flg_ControleManual		equ	4Dh
Flg_ErroBus			equ	4Ch
Flg_UltimaLeitura		equ	4Bh
Flg_NoAck			equ	4Ah
Flg_RecebendoGPRMC		equ	49h
Flg_Empresta1			equ	48h
Flg_Empresta2			equ	47h
Flg_LatitudePerto		equ	46h
Flg_LongitudePerto		equ	45h
Flg_BipBip			equ	44h
Flg_MostraTelaNavegacao		equ	43h
Flg_EnviaMensagem485		equ	42h
Flg_MensagemFormatada		equ	41h
Flg_EstouroBCD			equ	40h
Flg_Buzzer			equ	3Fh
Flg_EnviandoWP			equ	3Eh
Flg_BuzzerOn			equ	3Dh

Fg_AkOk					equ 3Ch 

Fg_ByteCompleto			equ	3Bh
Fg_StatusVerde			equ 3Ah
Fg_StatusAmarelo		equ 39h
Fg_StatusVermelho		equ 38h

;------------------------------------------------------------------------
;- -------------------------------------------------------------------- -
;- -		         DECLARACAO DE CONSTANTES          	      -	-
;- -------------------------------------------------------------------- -
;------------------------------------------------------------------------

Val_1ms					equ	2
Val_10ms				equ	20
Val_250ms				equ	25
Val_MeioSegundo			equ	2
Val_Segundo				equ	2 

Ct_AsciiNumero	equ	30h
Ct_AsciiLetra	equ	37h
Ct_MaskMsb		equ	00001111b
Ct_MaskLsb		equ	11110000b
Ct_NumeroStart	equ	3


;------------------------------------------------------------------------
;- -------------------------------------------------------------------- -
;- -		          Vetores de Interrupcao           	      -	-
;- -------------------------------------------------------------------- -
;------------------------------------------------------------------------

; ------------------------ Reset

.org 0000h

	jmp	Case_Reset

; ------------------------ Interrupcao Externa 0

.org 0003h

;	setb	Flg_VerificaTeclado
	reti

;	jmp	Int_Externa0

; ------------------------ Interrupcao Timer 0

.org 000Bh

	jmp	Int_Timer0

Case_SemInt0:

	reti


; ------------------------ Interrupcao Externa 1

.org 0013h

	reti
;	jmp	Int_Externa1

; ------------------------ Interrupcao Timer 1

.org 001Bh

	reti
;	jmp	Int_Timer1

; ------------------------ Interrupcao Serial

.org 0023h

	jmp	Int_Serial

; ------------------------ Interrupcao Timer 2

.org 002Bh

	reti
;	jmp	Int_Timer2


;*ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป*
;*บ Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ*
;*บ Û		               INICIALIZACAO    	               Û บ*
;*บ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ บ*
;*ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ*

Case_Reset:

	clr		Flg_BipBip

	clr		Pin_TxRx
	call	Configura_8051
	call	Configura_Sistema
	call	Bip_Curto
	jnb		Flg_Segundo , $
	clr		Flg_Segundo
	SETB	TI
	
	setb	Pin_LedGreen
	setb	Pin_LedYelow
	clr		Pin_LedRed
	clr		Pin_LedFalha
	mov		Status_Semaforo, #00
	mov		Status_Anterior, #00
	clr		Fg_StatusVerde
	clr		Fg_StatusAmarelo
	clr		Fg_StatusVermelho

	
	mov		acc, #'M'
	call	Envia_ByteSerial
	mov		acc, #'o'
	call	Envia_ByteSerial
	mov		acc, #'n'
	call	Envia_ByteSerial
	mov		acc, #'i'
	call	Envia_ByteSerial
	mov		acc, #'t'
	call	Envia_ByteSerial
	mov		acc, #'o'
	call	Envia_ByteSerial
	mov		acc, #'r'
	call	Envia_ByteSerial
	mov		acc, #' '
	call	Envia_ByteSerial
	mov		acc, #'d'
	call	Envia_ByteSerial
	mov		acc, #'e'
	call	Envia_ByteSerial
	mov		acc, #' '
	call	Envia_ByteSerial
	
	mov		acc, #'S'
	call	Envia_ByteSerial
	mov		acc, #'e'
	call	Envia_ByteSerial
	mov		acc, #'m'
	call	Envia_ByteSerial
	mov		acc, #'a'
	call	Envia_ByteSerial
	mov		acc, #'f'
	call	Envia_ByteSerial
	mov		acc, #'o'
	call	Envia_ByteSerial
	mov		acc, #'r'
	call	Envia_ByteSerial
	mov		acc, #'o'
	call	Envia_ByteSerial
	mov		acc, #0Ah
	call	Envia_ByteSerial
	mov		acc, #0Dh
	call	Envia_ByteSerial

    mov	Time_Out, #50		; aproximadamente 3s
    mov	b, #20
    
Volta:
	jbc		Flg_TimeOut, PiscaLed 

;   mov		acc, #10
;	call	Delay_Acc10ms

	jnb		Pin_GreenIN, Case_SinalVerdeOn
	jnb		Pin_YelowIN, Case_SinalAmareloOn
	jnb		Pin_RedIN, Case_SinalVermelhoOn
	
;	jmp		Case_TudoApagado

Retorna:
	jmp	Volta
	
PiscaLed:
	mov		Time_Out, #150      ; aproximadamente 3s
	cpl		Pin_LedFalha
	jmp		Volta
	
Case_SinalVerdeOn:
	jb		Fg_StatusVerde,Retorna 
	
	clr		Pin_LedGreen
	setb	Pin_LedYelow
	clr		Pin_LedRed	
	
	setb	Fg_StatusVerde
	clr		Fg_StatusAmarelo
	clr		Fg_StatusVermelho
	
	mov		acc, #'S'
	call	Envia_ByteSerial
	mov		acc, #'1'
	call	Envia_ByteSerial
	mov		acc, #'0'
	call	Envia_ByteSerial
	mov		acc, #'0'
	call	Envia_ByteSerial 
	mov		acc, #0Ah
	call	Envia_ByteSerial
	mov		acc, #0Dh
	call	Envia_ByteSerial
	
	jmp		Retorna

Case_SinalAmareloOn:
	jb		Fg_StatusAmarelo, Retorna
	
	setb	Pin_LedGreen
	clr		Pin_LedYelow
	clr		Pin_LedRed	
	
	clr		Fg_StatusVerde
	setb	Fg_StatusAmarelo
	clr		Fg_StatusVermelho
	
	
	mov		acc, #'S'
	call	Envia_ByteSerial
	mov		acc, #'0'
	call	Envia_ByteSerial
	mov		acc, #'1'
	call	Envia_ByteSerial
	mov		acc, #'0'
	call	Envia_ByteSerial 
	mov		acc, #0Ah
	call	Envia_ByteSerial
	mov		acc, #0Dh
	call	Envia_ByteSerial
	
	jmp		Retorna

Case_SinalVermelhoOn:
	jb		Fg_StatusVermelho, Retorna
	
	setb	Pin_LedGreen
	setb	Pin_LedYelow
	setb	Pin_LedRed	
	
	clr		Fg_StatusVerde
	clr		Fg_StatusAmarelo
	setb	Fg_StatusVermelho

	mov		acc, #'S'
	call	Envia_ByteSerial
	mov		acc, #'0'
	call	Envia_ByteSerial
	mov		acc, #'0'
	call	Envia_ByteSerial
	mov		acc, #'1'
	call	Envia_ByteSerial 
	mov		acc, #0Ah
	call	Envia_ByteSerial
	mov		acc, #0Dh
	call	Envia_ByteSerial
	
	jmp		Retorna
	
Case_TudoApagado:
	
	setb	Pin_LedGreen
	setb	Pin_LedYelow
	clr		Pin_LedRed	
	
	clr		Fg_StatusVerde
	clr		Fg_StatusAmarelo
	clr		Fg_StatusVermelho
	
	mov		acc, #'S'
	call	Envia_ByteSerial
	mov		acc, #'0'
	call	Envia_ByteSerial
	mov		acc, #'0'
	call	Envia_ByteSerial
	mov		acc, #'0'
	call	Envia_ByteSerial 
	mov		acc, #0Ah
	call	Envia_ByteSerial
	mov		acc, #0Dh
	call	Envia_ByteSerial
	
	jmp		Retorna
	
;*************************************************************************
;*				Delay_Acc10ms				*
;*************************************************************************

; Esta rotina causa um atraso de "acc" milisegundos

Delay_Acc10ms:

	clr	Flg_10ms

Delay_Mensagem

	jnb	Flg_10ms , $
	clr	Flg_10ms
	djnz	acc , Delay_Mensagem

	ret


;*ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป*
;*บ Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ*
;*บ Û		               Envia_Byte485    	               Û บ*
;*บ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ บ*
;*ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ*

Val_9600bps		equ	99

Envia_Byte485:

	setb	Pin_TxRx
	mov	Contador_Byte , #8		;Send 8 bits
	clr	Pin_TxSD			;start bit
	mov	Contador , #(Val_9600bps/2)
	djnz	Contador , $                    ;meio bit
	mov	Contador , #(Val_9600bps/2)
	djnz	Contador , $

Case_ProximoBitTxSD:

	rrc	a				;lsb primeiro
	mov	Pin_TxSD , c
	mov	Contador , #(Val_9600bps/2)
	djnz	Contador , $
	mov	Contador , #(Val_9600bps/2)
	djnz	Contador , $
 	djnz	Contador_Byte , Case_ProximoBitTxSD
	setb	Pin_TxSD
	rrc	a				;restaura acc
	mov	Contador , #(Val_9600bps/2)	;stop bit (1/2)
	djnz	Contador , $
;	mov	Contador , #(Val_2400bps/2)
;	djnz	Contador , $
	clr	Pin_TxRx
	ret

;*ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป*
;*บ Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ*
;*บ Û		               Recebe_Byte485   	               Û บ*
;*บ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ บ*
;*ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ*

Recebe_Byte485:

	mov	Contador_Byte , #9
	jnb	Pin_RxSD , $				;garante comeco de bit
	jb	Pin_RxSD , $     			;espera star bit
	mov	Contador , #Val_9600bps/2
	djnz	Contador , $
	jb	Pin_RxSD , Case_FimRecebeByte		;Ruido?

Case_ProximoBitRxSD:

	mov	c , Pin_RxSD			;Read bit
	rrc	a				;Shift it into ACC
	mov	Contador , #Val_9600bps/2
	djnz	Contador , $
	mov	Contador , #Val_9600bps/2
	djnz	Contador , $
	cpl	Pin_Buzzer
	djnz	Contador_Byte , Case_ProximoBitRxSD	;read 8 bits
	jnb	Pin_RxSD , $
	jnb	ti , $
	clr	ti
	mov	sbuf , a
;	jmp	Recebe_Byte485

Case_FimRecebeByte:

	ret					;go home

;ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป;
;บ Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ;
;บ Û		            Envia_ByteSerial        		      Û	บ;
;บ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ บ;
;ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ;

Envia_ByteSerial:

	mov     sbuf , a      ; dado a ser enviado no Acc.
	clr	ti
	jnb	ti , $
	clr	ti

	ret

;ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป;
;บ Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ;
;บ Û		            Recebe_ByteSerial        		      Û	บ;
;บ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ บ;
;ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ;

Recebe_ByteSerial:

	jnb	RI , $
	clr	RI
	mov	a , sbuf

	ret 

;*ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป*
;*บ Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ*
;*บ Û		   	   EnviaAcc_Serial			      Û	บ*
;*บ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ บ*
;*ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ*

EnviaAcc_Serial:

	push	acc
	anl	acc , #Ct_MaskLsb
	swap	acc

Case_PreparaNibleSerial

	cjne	acc , #10 , $+3
	jc	Case_NumeroSerial

Case_LetraSerial

	add	acc , #Ct_AsciiLetra
	sjmp	Case_EnviaNibleSerial

Case_NumeroSerial

	add	acc , #Ct_AsciiNumero

Case_EnviaNibleSerial

	call	Envia_ByteSerial
	jbc	Fg_ByteCompleto , Case_FimEnviaAccSerial
	pop	acc
	anl	acc , #Ct_MaskMsb
	setb	Fg_ByteCompleto
	sjmp	Case_PreparaNibleSerial

Case_FimEnviaAccSerial

	ret



;ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป;
;บ Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ;
;บ Û		                Bip_Curto        		      Û	บ;
;บ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ บ;
;ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ;

Bip_Curto:

	setb	Flg_BuzzerOn
	mov	Tempo_Bip , #10
	ret

;ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป;
;บ Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ;
;บ Û		                Bip_Longo        		      Û	บ;
;บ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ บ;
;ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ;

Bip_Longo:

	Setb	Flg_BuzzerOn
	mov	Tempo_Bip , #120
	jb	Flg_BuzzerOn , $
	ret


;ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป;
;บ Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ;
;บ Û		          Reseta_Temporizadores        		      Û	บ;
;บ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ บ;
;ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ;

Reseta_Temporizadores:


	mov	Prs_10ms , #Val_10ms
	clr	Flg_10ms

	mov	Prs_250ms , #Val_250ms
	clr	Flg_250ms

	mov	Prs_MeioSegundo , #Val_MeioSegundo
	clr	Flg_MeioSegundo

	mov	Prs_Segundo , #Val_Segundo
	clr	Flg_Segundo

	mov	Prs_Minuto , #60

;	mov	Cnt_TimeOut , Time_Out
;	clr	Flg_TimeOut

	ret

;*ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป*
;*บ Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ*
;*บ Û		              Configura_8051    	               Û บ*
;*บ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ บ*
;*ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ*


Configura_8051:

	mov 	TMOD , #Val_ConfiguracaoTimers
	mov 	TCON , #Val_ControleTimers
	mov 	PCON , #Val_PowerControl
	mov 	SCON , #Val_ConfiguracaoSerial
	mov	WMCON , #11101010b
;	mov	T2CON , #00001001b

	ret

Val_ConfiguracaoSerial	equ	01010000b	; SM0 | SM1 | SM2 | REN
						; TB8 | RB8 | TI  | RI

Val_PowerControl	equ	10000000b	; SMOD | -   | -  | -
						; GF1  | GF0 | PD | IDL

Val_ControleTimers	equ	00000101b	; TF1 | TR1 | TF0 | TR0
						; IE0 | IT1 | IE0 | IT0

Val_ConfiguracaoTimers	equ	00100001b	; GATE | C/T | M1 | M0 (T1)
						; GATE | C/T | M1 | M0 (T0)

;*ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป*
;*บ Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ*
;*บ Û		               Configura_Sistema    	               Û บ*
;*บ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ บ*
;*ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ*

Configura_Sistema:

	mov	IE , #10010010b             ;EA - - ES ET1 EX1 ET0 EX0
	mov	IP , #00000010b	            ; - - - -  -  PX1  -  PX0
	mov	TH1 , #243		; 9600bps -> 24MHz , SMOD=1
	setb	TR0
	setb	TR1
	clr	TI
	clr	RI

	call	Reseta_Temporizadores
	call	Bip_Curto


	mov	Tempo_Bip , #00
	ret


;ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป;
;บ Û฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿Û บ;
;บ Û		        SERVICOS DE INTERRUPCAO        		      Û	บ;
;บ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ บ;
;ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ;


;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ Interrupcao Externa 0 ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

Int_Externa0:

;	setb	Flg_VerificaTeclado
	reti

;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ Interrupcao Timer 1 ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ


Int_Timer1:

;	reti

;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ Interrupcao Externa 1 ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

Int_Externa1:

;	reti

;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ Interrupcao Timer 0 ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

Int_Timer0:

	mov	tl0 , #34h;67h
	mov	th0 , #0F8h;0FCh
	push	psw
	push	acc

	jnb	Flg_BuzzerOn , Case_Silencio
	cpl	Pin_Buzzer
	jmp	Case_VerificaTemporizadores

Case_Silencio:

	setb	Pin_Buzzer

Case_VerificaTemporizadores:

	setb	Flg_1ms

	djnz	Tempo_Bip , Case_10ms?
	clr	Flg_BuzzerOn


Case_10ms?:

	djnz	Prs_10ms , Case_FimTimer0
	mov	Prs_10ms , #Val_10ms			; = 20
	setb	Flg_10ms

	djnz	Time_Out , Case_250ms?
	setb	Flg_TimeOut

Case_250ms?:

	djnz	Prs_250ms , Case_FimTimer0
        mov	Prs_250ms , #Val_250ms			; = 25
	setb	Flg_250ms

Case_MeioSegundo?:

        djnz    Prs_MeioSegundo , Case_FimTimer0
	mov	Prs_MeioSegundo , #Val_MeioSegundo	; = 2
	setb	Flg_MeioSegundo
	jnb	Flg_BipBip , Case_Segundo?
	setb	Flg_Buzzer
	mov	Tempo_Bip , #100

;------ area de atualizacao com T = 1/2s ----------------

Case_Segundo?:

	djnz	Prs_Segundo , Case_FimTimer0
	mov	Prs_Segundo , #Val_Segundo		; = 2
	setb	Flg_Segundo
	djnz	TimeOut_BipBip , Case_Minuto?
	clr	Flg_BipBip

Case_Minuto?:

	djnz	Prs_Minuto , Case_VerificaTempoTarefa
	mov	Prs_Minuto , #60
	inc	Tempo_Mensagem

Case_VerificaTempoTarefa:

;------ area de atualizacao com T = 1s ----------------

	djnz	Tempo_Tarefa , Case_VerificaTimeOut
	setb	Flg_ProximaTarefa

Case_VerificaTimeOut:

	djnz	Cnt_TimeOut , Case_FimTimer0

Case_FimTimer0:

	pop	acc
	pop	psw
	reti

;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ Interrupcao Serial ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ


Int_Serial:

	jb    ri , Case_Recepcao             ; eh recepcao?
;	Recebe_ByteSerial

Case_Transmissao:

	reti

Case_Recepcao:

	push	acc
	push	psw
	PUSH	R0
	push	r1
	clr	ri                              ; habilita nova recepcao

	mov	acc , sbuf
	
	cjne	acc , #'K' , Case_FimSerial
	
	setb	Fg_AkOk
	
	call	Envia_ByteSerial

Case_FimSerial
    
    pop	r1
    pop	r0    
    pop	psw
	pop	acc

	reti

;-------------------------------------------------------------------------------------------------------------------------
;- 	$GPRMC,POS_UTC,POS_STAT,LAT,LAT_REF,LON,LON_REF,SPD,HDG,DATE,MAG_VAR,MAG_REF*CC<cr><lf>				 -
;- 	$GPGLL,LAT,LAT_REF,LONG,LONG_REF,POS_UTC,POS_STAT*CC<cr><lf>							 -
;- 	$GPGGA,POS_UTC,LAT,LAT_REF,LONG,LONG_REF,FIX_MODE,SAT_USED,HDOP,ALT,ALT_UNIT,GEO,G_UNIT,D_AGE,D_REF*CC<cr><lf>	 -
;- 															 -
;- 	  POS_UTC  - UTC of position. Hours, minutes and seconds [fraction (opt.)]. (hhmmss[.fff])			 -
;- 	  POS_STAT - Position status. (A = Data valid, V = Data invalid)						 -
;- 	  LAT      - Latitude (llll.ll)											 -
;- 	  LAT_REF  - Latitude direction. (N = North, S = South)								 -
;- 	  LON      - Longitude (yyyyy.yy)										 -
;- 	  LON_REF  - Longitude direction (E = East, W = West)								 -
;- 	  SPD      - Speed over ground. (knots) (x.x)									 -
;- 	  HDG      - Heading/track made good (degrees True) (x.x)							 -
;- 	  DATE     - Date (ddmmyy)											 -
;- 	  MAG_VAR  - Magnetic variation (degrees) (x.x)									 -
;-  	  MAG_REF  - Magnetic variation (E = East, W = West)								 -
;- 	  FIX_MODE - Position Fix Mode ( 0 = Invalid, >0 = Valid)							 -
;- 	  SAT_USED - Number Satellites used in solution									 -
;- 	  HDOP     - Horizontal Dilution of Precision									 -
;- 	  ALT      - Antenna Altitude											 -
;- 	  ALT_UNIT - Altitude Units (Metres/Feet)									 -
;- 	  GEO      - Geoid/Elipsoid separation										 -
;- 	  G_UNIT   - Geoid units (M/F)											 -
;- 	  D_AGE    - Age of last DGPS Fix										 -
;- 	  D_REF    - Reference ID of DGPS station									 -
;- 	  CC       - Checksum (optional)										 -
;- 	  <cr><lf> - Sentence terminator.										 -
;- 															 -
;-------------------------------------------------------------------------------------------------------------------------

; ------------------------ Interrupcao Timer 2

Int_Timer2:

;	reti



;--------------------------- Copia_BlocoMemoria ----------------------------

Copia_BlocoMemoria:

	jbc	Flg_MemoriaDePrograma , Case_CopiaRomParaRam

Case_CopiaRamParaRam:

	mov	a , @r1
	mov	@r0 , a
	inc	r0
	inc	r1
	djnz	TamanhoDoBloco , Case_CopiaRamParaRam
	ret

Case_CopiaRomParaRam:

	clr	a
	movc	a , @a+dptr
	mov	@r0 , a
	inc	dptr
	inc	r0
	djnz	TamanhoDoBloco , Case_CopiaRomParaRam
	ret

;--------------------------- Compara_BlocoMemoria ----------------------------

Compara_BlocoMemoria:

	jbc	Flg_MemoriaDePrograma , Case_ComparaRomRam

Case_ComparaRamRam:

	mov	a , @r1
	mov	b , a
	mov	a , @r0
	jnb	Flg_ComparaNibbles , Case_ComparaBytesRamRam
	call	Compara_Nibbles
	jc	Case_BytesIguaisRamRam
	clr	Flg_ComparaNibbles
	ret

Case_ComparaBytesRamRam:

	cjne	a , b , Case_BlocosDiferentes

Case_BytesIguaisRamRam:

	inc	r1
	inc	r0
	djnz	TamanhoDoBloco , Case_ComparaRamRam
	sjmp	Case_BlocosIguais

Case_ComparaRomRam:

	clr	a
	movc	a , @a+dptr
	mov	b , a
	mov	a , @r0
	jnb	Flg_ComparaNibbles , Case_ComparaBytesRomRam
	call	Compara_Nibbles
	jc	Case_BytesIguaisRomRam
	clr	Flg_ComparaNibbles
	ret

Case_ComparaBytesRomRam:

	cjne	a , b , Case_BlocosDiferentes

Case_BytesIguaisRomRam:

	inc	dptr
	inc	r0
	djnz	TamanhoDoBloco , Case_ComparaRomRam

Case_BlocosIguais:

	setb	c
	clr	Flg_ComparaNibbles
	ret

Case_BlocosDiferentes:

	mov	Flg_Bloco0MenorQueBloco1 , c
	clr	c
	clr	Flg_ComparaNibbles
	ret

;--------------------------- Compara_Nibbles ----------------------------

Compara_Nibbles:

	push	acc
	xrl	a , #11111111b
	jnz	Case_TestaCoringaHi
	pop	acc

Case_NibblesIguais:

	setb	c
	ret

Case_TestaCoringaHi:

	pop	acc
	push	acc
	anl	a , #11110000b
	xrl	a , #11110000b
	jnz	Case_TestaCoringaLow
	mov	a , b
	orl	a , #11110000b
	mov	b , a

Case_ComparaNibbles:

	pop	acc
	cjne	a , b , Case_NibblesDiferentes
	sjmp	Case_NibblesIguais

Case_TestaCoringaLow:

	pop	acc
	push	acc
	anl	a , #00001111b
	xrl	a , #00001111b
	jnz	Case_ComparaNibbles
	mov	a , b
	orl	a , #00001111b
	mov	b , a
	sjmp	Case_ComparaNibbles

Case_NibblesDiferentes:

	mov	Flg_Bloco0MenorQueBloco1 , c
	clr	c
	ret

;--------------------------- Preenche_BlocoMemoria ----------------------------

Preenche_BlocoMemoria:

	mov	@r0 , a
	inc	r0
	djnz	TamanhoDoBloco , Preenche_BlocoMemoria
	ret

;--------------------------- Escreve_ByteEeprom ----------------------------

Escreve_ByteEeprom:

	mov	WMCON , #11111010b
	movx	@dptr , a

Case_EsperaEscritaByte:

	mov	a , WMCON
	jnb	acc.1 , Case_EsperaEscritaByte
	mov	WMCON , #11101010b
	ret

;--------------------------- Escreve_BlocoEeprom ----------------------------

Escreve_BlocoEeprom:

	mov	a , @r0
	call	Escreve_ByteEeprom
	inc	dptr
	inc	r0
	djnz	TamanhoDoBloco , Escreve_BlocoEeprom
	setb	c

	ret

;--------------------------- Le_BlocoEeprom ----------------------------

Le_BlocoEeprom:

	movx	a , @dptr
	mov	@r0 , a
	inc	dptr
	inc	r0
	djnz	TamanhoDoBloco , Le_BlocoEeprom
	setb	c

	ret

	end


