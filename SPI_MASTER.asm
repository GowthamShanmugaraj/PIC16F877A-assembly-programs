;spi/microwire master 
;transmits value in wreg 
;by Gowtham_shanmugaraj

list p=16F877a
include p16F877a.inc

		org 00	                           ;start at 00
start	bcf STATUS,6			;select bank 1
		bsf STATUS,5
		movlw	B'10000000'		;SD0,SCK  as output. SDI controled by MSSP so leave
		movwf	TRISC
		bcf STATUS,5              	;select bank 0
		movlw B'00000000'		;SMP=0, CKE=0
		movwf SSPSTAT		
		movlw B'00110000'        ; Enable SPI mode, clock Fosc/4 , master 
		movwf SSPCON 
transmit		movlw	B'11110000'       ;Transmit value to slave 
			movwf SSPBUF                
			call		delay			;delay to avoid over write of sspbuf
			goto transmit                 ; Repeat the process
delay		movlw	0X4F			;	0X4F * 4 Us Delay
			movwf 0x20			;0x20 is a general purpose register
del1		nop
			decfsz	0x20,1
			goto	del1
			return
			end
