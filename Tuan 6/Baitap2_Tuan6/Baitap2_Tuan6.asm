
_IO_init:

;Baitap2_Tuan6.c,5 :: 		void IO_init()
;Baitap2_Tuan6.c,7 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap2_Tuan6.c,8 :: 		TRISD = 0;
	CLRF       TRISD+0
;Baitap2_Tuan6.c,9 :: 		TRISE1_BIT = 1;
	BSF        TRISE1_bit+0, BitPos(TRISE1_bit+0)
;Baitap2_Tuan6.c,10 :: 		ANS6_BIT = 1;
	BSF        ANS6_bit+0, BitPos(ANS6_bit+0)
;Baitap2_Tuan6.c,11 :: 		}
L_end_IO_init:
	RETURN
; end of _IO_init

_ADC_init:

;Baitap2_Tuan6.c,13 :: 		void ADC_init()
;Baitap2_Tuan6.c,15 :: 		ADCS1_BIT = 1;
	BSF        ADCS1_bit+0, BitPos(ADCS1_bit+0)
;Baitap2_Tuan6.c,16 :: 		ADCS0_BIT = 0;
	BCF        ADCS0_bit+0, BitPos(ADCS0_bit+0)
;Baitap2_Tuan6.c,18 :: 		CHS3_BIT = 0;
	BCF        CHS3_bit+0, BitPos(CHS3_bit+0)
;Baitap2_Tuan6.c,19 :: 		CHS2_BIT = 1;
	BSF        CHS2_bit+0, BitPos(CHS2_bit+0)
;Baitap2_Tuan6.c,20 :: 		CHS1_BIT = 1;
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
;Baitap2_Tuan6.c,21 :: 		CHS0_BIT = 0;
	BCF        CHS0_bit+0, BitPos(CHS0_bit+0)
;Baitap2_Tuan6.c,23 :: 		GO_DONE_BIT = 0;
	BCF        GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
;Baitap2_Tuan6.c,24 :: 		ADON_BIT = 1;
	BSF        ADON_bit+0, BitPos(ADON_bit+0)
;Baitap2_Tuan6.c,26 :: 		ADCON1 = 0x80;
	MOVLW      128
	MOVWF      ADCON1+0
;Baitap2_Tuan6.c,27 :: 		}
L_end_ADC_init:
	RETURN
; end of _ADC_init

_ADC_Read:

;Baitap2_Tuan6.c,29 :: 		unsigned int ADC_Read(void)
;Baitap2_Tuan6.c,31 :: 		delay_us(50);
	MOVLW      33
	MOVWF      R13+0
L_ADC_Read0:
	DECFSZ     R13+0, 1
	GOTO       L_ADC_Read0
;Baitap2_Tuan6.c,32 :: 		GO_DONE_BIT = 1;
	BSF        GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
;Baitap2_Tuan6.c,33 :: 		while(GO_DONE_BIT == 1);
L_ADC_Read1:
	BTFSS      GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
	GOTO       L_ADC_Read2
	GOTO       L_ADC_Read1
L_ADC_Read2:
;Baitap2_Tuan6.c,34 :: 		return (unsigned int)(ADRESH << 8| ADRESL);
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;Baitap2_Tuan6.c,36 :: 		}
L_end_ADC_Read:
	RETURN
; end of _ADC_Read

_LED_init:

;Baitap2_Tuan6.c,38 :: 		void LED_init(unsigned int value)
;Baitap2_Tuan6.c,40 :: 		if ( value > 1023 ) value = 1023;
	MOVF       FARG_LED_init_value+1, 0
	SUBLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__LED_init10
	MOVF       FARG_LED_init_value+0, 0
	SUBLW      255
L__LED_init10:
	BTFSC      STATUS+0, 0
	GOTO       L_LED_init3
	MOVLW      255
	MOVWF      FARG_LED_init_value+0
	MOVLW      3
	MOVWF      FARG_LED_init_value+1
L_LED_init3:
;Baitap2_Tuan6.c,41 :: 		temperture = (float)(value * 500.0 + 511.0)/1023.0;
	MOVF       FARG_LED_init_value+0, 0
	MOVWF      R0+0
	MOVF       FARG_LED_init_value+1, 0
	MOVWF      R0+1
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      122
	MOVWF      R4+2
	MOVLW      135
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      128
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      135
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      _temperture+0
;Baitap2_Tuan6.c,42 :: 		PORTD = (unsigned char)temperture;
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;Baitap2_Tuan6.c,43 :: 		}
L_end_LED_init:
	RETURN
; end of _LED_init

_main:

;Baitap2_Tuan6.c,44 :: 		void main() {
;Baitap2_Tuan6.c,45 :: 		IO_init();
	CALL       _IO_init+0
;Baitap2_Tuan6.c,46 :: 		ADC_init();
	CALL       _ADC_init+0
;Baitap2_Tuan6.c,48 :: 		while(1)
L_main4:
;Baitap2_Tuan6.c,50 :: 		value = ADC_Read();
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
;Baitap2_Tuan6.c,51 :: 		LED_init(value);
	MOVF       R0+0, 0
	MOVWF      FARG_LED_init_value+0
	MOVF       R0+1, 0
	MOVWF      FARG_LED_init_value+1
	CALL       _LED_init+0
;Baitap2_Tuan6.c,53 :: 		}
	GOTO       L_main4
;Baitap2_Tuan6.c,55 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
