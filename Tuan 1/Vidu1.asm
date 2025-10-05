
_Vidu1_sangduoi:

;Vidu1.c,2 :: 		void Vidu1_sangduoi(unsigned char start)
;Vidu1.c,5 :: 		PORTD = start;
	MOVF       FARG_Vidu1_sangduoi_start+0, 0
	MOVWF      PORTD+0
;Vidu1.c,6 :: 		delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_Vidu1_sangduoi0:
	DECFSZ     R13+0, 1
	GOTO       L_Vidu1_sangduoi0
	DECFSZ     R12+0, 1
	GOTO       L_Vidu1_sangduoi0
	DECFSZ     R11+0, 1
	GOTO       L_Vidu1_sangduoi0
;Vidu1.c,8 :: 		for ( i = 0; i < 8; i++ )
	CLRF       R4+0
L_Vidu1_sangduoi1:
	MOVLW      8
	SUBWF      R4+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Vidu1_sangduoi2
;Vidu1.c,10 :: 		PORTD = (unsigned char)( (PORTD >> 1) | ((PORTD & 0x01) << 7) );
	MOVF       PORTD+0, 0
	MOVWF      R3+0
	RRF        R3+0, 1
	BCF        R3+0, 7
	MOVLW      1
	ANDWF      PORTD+0, 0
	MOVWF      R2+0
	MOVLW      7
	MOVWF      R1+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Vidu1_sangduoi8:
	BTFSC      STATUS+0, 2
	GOTO       L__Vidu1_sangduoi9
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Vidu1_sangduoi8
L__Vidu1_sangduoi9:
	MOVF       R0+0, 0
	IORWF      R3+0, 0
	MOVWF      PORTD+0
;Vidu1.c,11 :: 		delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_Vidu1_sangduoi4:
	DECFSZ     R13+0, 1
	GOTO       L_Vidu1_sangduoi4
	DECFSZ     R12+0, 1
	GOTO       L_Vidu1_sangduoi4
	DECFSZ     R11+0, 1
	GOTO       L_Vidu1_sangduoi4
;Vidu1.c,8 :: 		for ( i = 0; i < 8; i++ )
	INCF       R4+0, 1
;Vidu1.c,12 :: 		}
	GOTO       L_Vidu1_sangduoi1
L_Vidu1_sangduoi2:
;Vidu1.c,14 :: 		}
L_end_Vidu1_sangduoi:
	RETURN
; end of _Vidu1_sangduoi

_main:

;Vidu1.c,15 :: 		void main() {
;Vidu1.c,16 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Vidu1.c,17 :: 		TRISD = 0;
	CLRF       TRISD+0
;Vidu1.c,19 :: 		while(1)
L_main5:
;Vidu1.c,21 :: 		Vidu1_sangduoi(0x80);
	MOVLW      128
	MOVWF      FARG_Vidu1_sangduoi_start+0
	CALL       _Vidu1_sangduoi+0
;Vidu1.c,22 :: 		}
	GOTO       L_main5
;Vidu1.c,25 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
