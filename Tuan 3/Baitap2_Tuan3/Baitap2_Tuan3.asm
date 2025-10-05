
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Baitap2_Tuan3.c,18 :: 		void interrupt()
;Baitap2_Tuan3.c,20 :: 		if ( RBIF_BIT )
	BTFSS      RBIF_bit+0, BitPos(RBIF_bit+0)
	GOTO       L_interrupt0
;Baitap2_Tuan3.c,21 :: 		temp = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _temp+0
L_interrupt0:
;Baitap2_Tuan3.c,22 :: 		RBIF_BIT = 0;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;Baitap2_Tuan3.c,23 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_interrupt1:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt1
	DECFSZ     R12+0, 1
	GOTO       L_interrupt1
	NOP
	NOP
;Baitap2_Tuan3.c,25 :: 		if ( !RB0_BIT )
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_interrupt2
;Baitap2_Tuan3.c,27 :: 		push_count = push_count_LED1;
	MOVF       _push_count_LED1+0, 0
	MOVWF      _push_count+0
;Baitap2_Tuan3.c,28 :: 		push_count_LED1++;
	INCF       _push_count_LED1+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _push_count_LED1+0
;Baitap2_Tuan3.c,29 :: 		PORTA = 0x01;
	MOVLW      1
	MOVWF      PORTA+0
;Baitap2_Tuan3.c,31 :: 		}
	GOTO       L_interrupt3
L_interrupt2:
;Baitap2_Tuan3.c,33 :: 		else if ( !RB1_BIT )
	BTFSC      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_interrupt4
;Baitap2_Tuan3.c,35 :: 		push_count = push_count_LED2;
	MOVF       _push_count_LED2+0, 0
	MOVWF      _push_count+0
;Baitap2_Tuan3.c,36 :: 		push_count_LED2++;
	INCF       _push_count_LED2+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _push_count_LED2+0
;Baitap2_Tuan3.c,37 :: 		PORTA = 0x02;
	MOVLW      2
	MOVWF      PORTA+0
;Baitap2_Tuan3.c,39 :: 		}
	GOTO       L_interrupt5
L_interrupt4:
;Baitap2_Tuan3.c,41 :: 		else if ( !RB2_BIT )
	BTFSC      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_interrupt6
;Baitap2_Tuan3.c,43 :: 		push_count = push_count_LED3;
	MOVF       _push_count_LED3+0, 0
	MOVWF      _push_count+0
;Baitap2_Tuan3.c,44 :: 		push_count_LED3++;
	INCF       _push_count_LED3+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _push_count_LED3+0
;Baitap2_Tuan3.c,45 :: 		PORTA = 0x04;
	MOVLW      4
	MOVWF      PORTA+0
;Baitap2_Tuan3.c,47 :: 		}
L_interrupt6:
L_interrupt5:
L_interrupt3:
;Baitap2_Tuan3.c,48 :: 		}
L_end_interrupt:
L__interrupt10:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Baitap2_Tuan3.c,50 :: 		void main() {
;Baitap2_Tuan3.c,51 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap2_Tuan3.c,52 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;Baitap2_Tuan3.c,53 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;Baitap2_Tuan3.c,54 :: 		TRISB = 0x07;
	MOVLW      7
	MOVWF      TRISB+0
;Baitap2_Tuan3.c,56 :: 		GIE_BIT = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Baitap2_Tuan3.c,57 :: 		RBIE_BIT = 1;
	BSF        RBIE_bit+0, BitPos(RBIE_bit+0)
;Baitap2_Tuan3.c,58 :: 		RBIF_BIT = 0;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;Baitap2_Tuan3.c,60 :: 		NOT_RBPU_BIT = 0;
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;Baitap2_Tuan3.c,61 :: 		WPUB = 0x07;
	MOVLW      7
	MOVWF      WPUB+0
;Baitap2_Tuan3.c,62 :: 		IOCB = 0x07;
	MOVLW      7
	MOVWF      IOCB+0
;Baitap2_Tuan3.c,63 :: 		INTEDG_BIT = 1;
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;Baitap2_Tuan3.c,66 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;Baitap2_Tuan3.c,67 :: 		temp = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _temp+0
;Baitap2_Tuan3.c,69 :: 		while(1)
L_main7:
;Baitap2_Tuan3.c,71 :: 		PORTD = segment7_LED[push_count%10];
	MOVLW      10
	MOVWF      R4+0
	MOVF       _push_count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDLW      _segment7_LED+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;Baitap2_Tuan3.c,72 :: 		}
	GOTO       L_main7
;Baitap2_Tuan3.c,73 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
