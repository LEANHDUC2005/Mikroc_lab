
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Baitap1_Tuan3.c,17 :: 		void interrupt()
;Baitap1_Tuan3.c,19 :: 		if( INTF_BIT )
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;Baitap1_Tuan3.c,21 :: 		temp = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _temp+0
;Baitap1_Tuan3.c,22 :: 		push_count++;
	INCF       Baitap1_Tuan3_push_count+0, 1
;Baitap1_Tuan3.c,23 :: 		INTF_BIT = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;Baitap1_Tuan3.c,24 :: 		}
L_interrupt0:
;Baitap1_Tuan3.c,25 :: 		}
L_end_interrupt:
L__interrupt4:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Baitap1_Tuan3.c,26 :: 		void main ()
;Baitap1_Tuan3.c,28 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap1_Tuan3.c,29 :: 		TRISD = 0;
	CLRF       TRISD+0
;Baitap1_Tuan3.c,30 :: 		TRISA = 0;
	CLRF       TRISA+0
;Baitap1_Tuan3.c,31 :: 		PORTA = 0x01;
	MOVLW      1
	MOVWF      PORTA+0
;Baitap1_Tuan3.c,33 :: 		TRISB = 0x01;
	MOVLW      1
	MOVWF      TRISB+0
;Baitap1_Tuan3.c,34 :: 		NOT_RBPU_BIT = 0;
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;Baitap1_Tuan3.c,35 :: 		WPUB = 0x01;
	MOVLW      1
	MOVWF      WPUB+0
;Baitap1_Tuan3.c,37 :: 		GIE_BIT = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Baitap1_Tuan3.c,38 :: 		INTE_BIT = 1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;Baitap1_Tuan3.c,40 :: 		INTF_BIT = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;Baitap1_Tuan3.c,41 :: 		INTEDG_BIT = 1;
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;Baitap1_Tuan3.c,43 :: 		push_count = 0;
	CLRF       Baitap1_Tuan3_push_count+0
;Baitap1_Tuan3.c,44 :: 		temp = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _temp+0
;Baitap1_Tuan3.c,45 :: 		while(1)
L_main1:
;Baitap1_Tuan3.c,47 :: 		PORTD = seven_LED[push_count%10];
	MOVLW      10
	MOVWF      R4+0
	MOVF       Baitap1_Tuan3_push_count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDLW      _seven_LED+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;Baitap1_Tuan3.c,48 :: 		}
	GOTO       L_main1
;Baitap1_Tuan3.c,49 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
