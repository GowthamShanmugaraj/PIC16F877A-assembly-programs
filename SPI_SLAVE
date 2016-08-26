;spi/microwire slave code
;receives from master and the value is reflected in port B
;by Gowtham_shanmugaraj


list p=16F877a
include p16F877a.inc
org	00		;start at 00
		goto	start
org 04
		goto	interrupt_sub_routine
start	bcf	STATUS,6		;SELECT MEMORY BANK 1
		bsf	STATUS,5
		movlw B'00011000'	;SCK IN,SDI IN ( automatically set),SDO OUT
		movwf	TRISC
		movlw	B'00000000';PORT B all output
		movwf	TRISB
		bcf	STATUS,6		;SELECT MEMORY BANK 0
		bcf	STATUS,5
;interrupt stuff		
		bsf INTCON,GIE      ;global interrupt enable
		bsf	INTCON,PEIE    ;pheripheral interrupt enable 
		bcf	STATUS,6		;SELECT MEMORY BANK 1
		bsf	STATUS,5
		bsf PIE1, SSPIE 	;mssp interrupt
		bcf	STATUS,6		;SELECT MEMORY BANK 0
		bcf	STATUS,5
		
;start main program here
loop	goto	loop		;loop infinetly & wait for interrupt from mssp
;interrupt sub routine starts here
interrupt_sub_routine	movf SSPBUF, W ;ssbbuf to wreg
						movwf	PORTB    ;port d now reflect masters w reg
						retfie                     ;return from interrupt
						end
