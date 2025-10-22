
_IO_init:

;Baitap1_Tuan6.c,22 :: 		void IO_init(void)
;Baitap1_Tuan6.c,24 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;Baitap1_Tuan6.c,25 :: 		ANSELH = 0b00000100;
	MOVLW      4
	MOVWF      ANSELH+0
;Baitap1_Tuan6.c,27 :: 		TRISA = 0;
	CLRF       TRISA+0
;Baitap1_Tuan6.c,29 :: 		TRISB1_BIT = 1;
	BSF        TRISB1_bit+0, BitPos(TRISB1_bit+0)
;Baitap1_Tuan6.c,30 :: 		TRISD = 0;
	CLRF       TRISD+0
;Baitap1_Tuan6.c,31 :: 		}
L_end_IO_init:
	RETURN
; end of _IO_init

_ADC_init:

;Baitap1_Tuan6.c,33 :: 		void ADC_init(void)
;Baitap1_Tuan6.c,36 :: 		ADCS0_BIT = 0;
	BCF        ADCS0_bit+0, BitPos(ADCS0_bit+0)
;Baitap1_Tuan6.c,37 :: 		ADCS1_BIT = 1;
	BSF        ADCS1_bit+0, BitPos(ADCS1_bit+0)
;Baitap1_Tuan6.c,39 :: 		CHS3_BIT = 1;
	BSF        CHS3_bit+0, BitPos(CHS3_bit+0)
;Baitap1_Tuan6.c,40 :: 		CHS2_BIT = 0;
	BCF        CHS2_bit+0, BitPos(CHS2_bit+0)
;Baitap1_Tuan6.c,41 :: 		CHS1_BIT = 1;
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
;Baitap1_Tuan6.c,42 :: 		CHS0_BIT = 0;
	BCF        CHS0_bit+0, BitPos(CHS0_bit+0)
;Baitap1_Tuan6.c,45 :: 		GO_DONE_BIT = 0;
	BCF        GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
;Baitap1_Tuan6.c,46 :: 		ADON_BIT = 1;
	BSF        ADON_bit+0, BitPos(ADON_bit+0)
;Baitap1_Tuan6.c,49 :: 		ADCON1 = 0x80;
	MOVLW      128
	MOVWF      ADCON1+0
;Baitap1_Tuan6.c,51 :: 		}
L_end_ADC_init:
	RETURN
; end of _ADC_init

_ADC_read:

;Baitap1_Tuan6.c,53 :: 		unsigned int ADC_read(void)
;Baitap1_Tuan6.c,55 :: 		delay_us(50);
	MOVLW      33
	MOVWF      R13+0
L_ADC_read0:
	DECFSZ     R13+0, 1
	GOTO       L_ADC_read0
;Baitap1_Tuan6.c,56 :: 		GO_DONE_BIT = 1;
	BSF        GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
;Baitap1_Tuan6.c,57 :: 		while(GO_DONE_BIT == 1);
L_ADC_read1:
	BTFSS      GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
	GOTO       L_ADC_read2
	GOTO       L_ADC_read1
L_ADC_read2:
;Baitap1_Tuan6.c,58 :: 		return (unsigned int)(ADRESH << 8 | ADRESL);
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;Baitap1_Tuan6.c,59 :: 		}
L_end_ADC_read:
	RETURN
; end of _ADC_read

_LED_init:

;Baitap1_Tuan6.c,61 :: 		void LED_init(unsigned int value)
;Baitap1_Tuan6.c,64 :: 		voltage = (unsigned long)( (value * 5000UL) / 1023);
	MOVF       FARG_LED_init_value+0, 0
	MOVWF      R0+0
	MOVF       FARG_LED_init_value+1, 0
	MOVWF      R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVLW      136
	MOVWF      R4+0
	MOVLW      19
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__LED_init+0
	MOVF       R0+1, 0
	MOVWF      FLOC__LED_init+1
	MOVF       R0+2, 0
	MOVWF      FLOC__LED_init+2
	MOVF       R0+3, 0
	MOVWF      FLOC__LED_init+3
	MOVF       FLOC__LED_init+0, 0
	MOVWF      _voltage+0
	MOVF       FLOC__LED_init+1, 0
	MOVWF      _voltage+1
	MOVF       FLOC__LED_init+2, 0
	MOVWF      _voltage+2
	MOVF       FLOC__LED_init+3, 0
	MOVWF      _voltage+3
;Baitap1_Tuan6.c,66 :: 		digit[3] = voltage/1000;
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__LED_init+0, 0
	MOVWF      R0+0
	MOVF       FLOC__LED_init+1, 0
	MOVWF      R0+1
	MOVF       FLOC__LED_init+2, 0
	MOVWF      R0+2
	MOVF       FLOC__LED_init+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _digit+3
;Baitap1_Tuan6.c,67 :: 		digit[2] = voltage/100%10;
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__LED_init+0, 0
	MOVWF      R0+0
	MOVF       FLOC__LED_init+1, 0
	MOVWF      R0+1
	MOVF       FLOC__LED_init+2, 0
	MOVWF      R0+2
	MOVF       FLOC__LED_init+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _digit+2
;Baitap1_Tuan6.c,68 :: 		digit[1] = voltage/10%10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__LED_init+0, 0
	MOVWF      R0+0
	MOVF       FLOC__LED_init+1, 0
	MOVWF      R0+1
	MOVF       FLOC__LED_init+2, 0
	MOVWF      R0+2
	MOVF       FLOC__LED_init+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _digit+1
;Baitap1_Tuan6.c,69 :: 		digit[0] = voltage%10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__LED_init+0, 0
	MOVWF      R0+0
	MOVF       FLOC__LED_init+1, 0
	MOVWF      R0+1
	MOVF       FLOC__LED_init+2, 0
	MOVWF      R0+2
	MOVF       FLOC__LED_init+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _digit+0
;Baitap1_Tuan6.c,72 :: 		for(i = 0; i < 4; i++)
	CLRF       LED_init_i_L0+0
L_LED_init3:
	MOVLW      4
	SUBWF      LED_init_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LED_init4
;Baitap1_Tuan6.c,74 :: 		PORTD = seg7_CC[digit[i]];
	MOVF       LED_init_i_L0+0, 0
	ADDLW      _digit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDLW      _seg7_CC+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;Baitap1_Tuan6.c,75 :: 		PORTA = (unsigned char)((0x01 << i));
	MOVF       LED_init_i_L0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__LED_init13:
	BTFSC      STATUS+0, 2
	GOTO       L__LED_init14
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__LED_init13
L__LED_init14:
	MOVF       R0+0, 0
	MOVWF      PORTA+0
;Baitap1_Tuan6.c,76 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_LED_init6:
	DECFSZ     R13+0, 1
	GOTO       L_LED_init6
	DECFSZ     R12+0, 1
	GOTO       L_LED_init6
	DECFSZ     R11+0, 1
	GOTO       L_LED_init6
	NOP
;Baitap1_Tuan6.c,72 :: 		for(i = 0; i < 4; i++)
	INCF       LED_init_i_L0+0, 1
;Baitap1_Tuan6.c,77 :: 		}
	GOTO       L_LED_init3
L_LED_init4:
;Baitap1_Tuan6.c,78 :: 		}
L_end_LED_init:
	RETURN
; end of _LED_init

_main:

;Baitap1_Tuan6.c,79 :: 		void main() {
;Baitap1_Tuan6.c,80 :: 		IO_init();
	CALL       _IO_init+0
;Baitap1_Tuan6.c,81 :: 		ADC_init();
	CALL       _ADC_init+0
;Baitap1_Tuan6.c,82 :: 		while(1)
L_main7:
;Baitap1_Tuan6.c,84 :: 		value = ADC_read();
	CALL       _ADC_read+0
	MOVF       R0+0, 0
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
;Baitap1_Tuan6.c,85 :: 		LED_init(value);
	MOVF       R0+0, 0
	MOVWF      FARG_LED_init_value+0
	MOVF       R0+1, 0
	MOVWF      FARG_LED_init_value+1
	CALL       _LED_init+0
;Baitap1_Tuan6.c,86 :: 		}
	GOTO       L_main7
;Baitap1_Tuan6.c,88 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
