
_IO_init:

;Baitap2_Tuan6.c,17 :: 		void IO_init()
;Baitap2_Tuan6.c,19 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap2_Tuan6.c,20 :: 		TRISD = 0;
	CLRF       TRISD+0
;Baitap2_Tuan6.c,21 :: 		TRISC = 0;
	CLRF       TRISC+0
;Baitap2_Tuan6.c,22 :: 		TRISB = 0;
	CLRF       TRISB+0
;Baitap2_Tuan6.c,23 :: 		TRISE1_BIT = 1;
	BSF        TRISE1_bit+0, BitPos(TRISE1_bit+0)
;Baitap2_Tuan6.c,24 :: 		ANS6_BIT = 1;
	BSF        ANS6_bit+0, BitPos(ANS6_bit+0)
;Baitap2_Tuan6.c,25 :: 		}
L_end_IO_init:
	RETURN
; end of _IO_init

_ADC_init:

;Baitap2_Tuan6.c,27 :: 		void ADC_init()
;Baitap2_Tuan6.c,30 :: 		ADCS1_BIT = 1;
	BSF        ADCS1_bit+0, BitPos(ADCS1_bit+0)
;Baitap2_Tuan6.c,31 :: 		ADCS0_BIT = 0;
	BCF        ADCS0_bit+0, BitPos(ADCS0_bit+0)
;Baitap2_Tuan6.c,33 :: 		CHS3_BIT = 0;
	BCF        CHS3_bit+0, BitPos(CHS3_bit+0)
;Baitap2_Tuan6.c,34 :: 		CHS2_BIT = 1;
	BSF        CHS2_bit+0, BitPos(CHS2_bit+0)
;Baitap2_Tuan6.c,35 :: 		CHS1_BIT = 1;
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
;Baitap2_Tuan6.c,36 :: 		CHS0_BIT = 0;
	BCF        CHS0_bit+0, BitPos(CHS0_bit+0)
;Baitap2_Tuan6.c,38 :: 		GO_DONE_BIT = 0;
	BCF        GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
;Baitap2_Tuan6.c,39 :: 		ADON_BIT = 1;
	BSF        ADON_bit+0, BitPos(ADON_bit+0)
;Baitap2_Tuan6.c,41 :: 		ADCON1 = 0x80;
	MOVLW      128
	MOVWF      ADCON1+0
;Baitap2_Tuan6.c,42 :: 		}
L_end_ADC_init:
	RETURN
; end of _ADC_init

_ADC_Read:

;Baitap2_Tuan6.c,44 :: 		unsigned int ADC_Read(void)
;Baitap2_Tuan6.c,46 :: 		delay_us(50);
	MOVLW      33
	MOVWF      R13+0
L_ADC_Read0:
	DECFSZ     R13+0, 1
	GOTO       L_ADC_Read0
;Baitap2_Tuan6.c,47 :: 		GO_DONE_BIT = 1;
	BSF        GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
;Baitap2_Tuan6.c,48 :: 		while(GO_DONE_BIT == 1);
L_ADC_Read1:
	BTFSS      GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
	GOTO       L_ADC_Read2
	GOTO       L_ADC_Read1
L_ADC_Read2:
;Baitap2_Tuan6.c,49 :: 		return (unsigned int)(ADRESH << 8| ADRESL);
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;Baitap2_Tuan6.c,51 :: 		}
L_end_ADC_Read:
	RETURN
; end of _ADC_Read

_LED_init:

;Baitap2_Tuan6.c,53 :: 		void LED_init(unsigned int value)
;Baitap2_Tuan6.c,56 :: 		if ( value > 1023 ) value = 1023;
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
;Baitap2_Tuan6.c,60 :: 		temperture = (float)(value * 511.0)/1023.0;
	MOVF       FARG_LED_init_value+0, 0
	MOVWF      R0+0
	MOVF       FARG_LED_init_value+1, 0
	MOVWF      R0+1
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      128
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      135
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
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
;Baitap2_Tuan6.c,62 :: 		PORTD = (unsigned char)(int)temperture;
	MOVLW      0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;Baitap2_Tuan6.c,64 :: 		}
L_end_LED_init:
	RETURN
; end of _LED_init

_main:

;Baitap2_Tuan6.c,65 :: 		void main() {
;Baitap2_Tuan6.c,66 :: 		IO_init();
	CALL       _IO_init+0
;Baitap2_Tuan6.c,67 :: 		ADC_init();
	CALL       _ADC_init+0
;Baitap2_Tuan6.c,69 :: 		while(1)
L_main4:
;Baitap2_Tuan6.c,71 :: 		value = ADC_Read();
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
;Baitap2_Tuan6.c,72 :: 		LED_init(value);
	MOVF       R0+0, 0
	MOVWF      FARG_LED_init_value+0
	MOVF       R0+1, 0
	MOVWF      FARG_LED_init_value+1
	CALL       _LED_init+0
;Baitap2_Tuan6.c,74 :: 		}
	GOTO       L_main4
;Baitap2_Tuan6.c,76 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
