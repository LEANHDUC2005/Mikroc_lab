
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;BaitapTongHop.c,9 :: 		void interrupt(void)
;BaitapTongHop.c,11 :: 		if ( RBIF_BIT && RBIE_BIT )
	BTFSS      RBIF_bit+0, BitPos(RBIF_bit+0)
	GOTO       L_interrupt2
	BTFSS      RBIE_bit+0, BitPos(RBIE_bit+0)
	GOTO       L_interrupt2
L__interrupt36:
;BaitapTongHop.c,13 :: 		temp = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _temp+0
;BaitapTongHop.c,14 :: 		RBIF_BIT = 0;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;BaitapTongHop.c,15 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_interrupt3:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt3
;BaitapTongHop.c,16 :: 		if ( !RB5_BIT )
	BTFSC      RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_interrupt4
;BaitapTongHop.c,18 :: 		delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_interrupt5:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt5
	DECFSZ     R12+0, 1
	GOTO       L_interrupt5
	NOP
	NOP
;BaitapTongHop.c,19 :: 		if ( !RB5_BIT ) trangthai = 1;
	BTFSC      RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_interrupt6
	MOVLW      1
	MOVWF      _trangthai+0
L_interrupt6:
;BaitapTongHop.c,20 :: 		}
	GOTO       L_interrupt7
L_interrupt4:
;BaitapTongHop.c,21 :: 		else if ( !RB6_BIT )
	BTFSC      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_interrupt8
;BaitapTongHop.c,23 :: 		delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_interrupt9:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt9
	DECFSZ     R12+0, 1
	GOTO       L_interrupt9
	NOP
	NOP
;BaitapTongHop.c,24 :: 		if ( !RB6_BIT ) trangthai = 2;
	BTFSC      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_interrupt10
	MOVLW      2
	MOVWF      _trangthai+0
L_interrupt10:
;BaitapTongHop.c,25 :: 		}
	GOTO       L_interrupt11
L_interrupt8:
;BaitapTongHop.c,26 :: 		else if ( !RB7_BIT )
	BTFSC      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L_interrupt12
;BaitapTongHop.c,28 :: 		delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_interrupt13:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt13
	DECFSZ     R12+0, 1
	GOTO       L_interrupt13
	NOP
	NOP
;BaitapTongHop.c,29 :: 		if ( !RB7_BIT ) trangthai = 3;
	BTFSC      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L_interrupt14
	MOVLW      3
	MOVWF      _trangthai+0
L_interrupt14:
;BaitapTongHop.c,30 :: 		}
L_interrupt12:
L_interrupt11:
L_interrupt7:
;BaitapTongHop.c,31 :: 		}
L_interrupt2:
;BaitapTongHop.c,32 :: 		}
L_end_interrupt:
L__interrupt38:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_IO_init:

;BaitapTongHop.c,34 :: 		void IO_init(void)
;BaitapTongHop.c,36 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;BaitapTongHop.c,37 :: 		TRISB = 0b11100000;
	MOVLW      224
	MOVWF      TRISB+0
;BaitapTongHop.c,38 :: 		TRISE = 0x03;
	MOVLW      3
	MOVWF      TRISE+0
;BaitapTongHop.c,40 :: 		ANS5_BIT = 1;
	BSF        ANS5_bit+0, BitPos(ANS5_bit+0)
;BaitapTongHop.c,41 :: 		ANS6_BIT = 1;
	BSF        ANS6_bit+0, BitPos(ANS6_bit+0)
;BaitapTongHop.c,43 :: 		TRISD = 0;
	CLRF       TRISD+0
;BaitapTongHop.c,44 :: 		TRISC = 0;
	CLRF       TRISC+0
;BaitapTongHop.c,45 :: 		}
L_end_IO_init:
	RETURN
; end of _IO_init

_ISR_B_init:

;BaitapTongHop.c,47 :: 		void ISR_B_init(void)
;BaitapTongHop.c,49 :: 		GIE_BIT = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;BaitapTongHop.c,50 :: 		PEIE_BIT = 0;
	BCF        PEIE_bit+0, BitPos(PEIE_bit+0)
;BaitapTongHop.c,51 :: 		INTE_BIT = 0;
	BCF        INTE_bit+0, BitPos(INTE_bit+0)
;BaitapTongHop.c,53 :: 		NOT_RBPU_BIT = 0;
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;BaitapTongHop.c,54 :: 		WPUB = 0b11100000;
	MOVLW      224
	MOVWF      WPUB+0
;BaitapTongHop.c,56 :: 		RBIE_BIT = 1;
	BSF        RBIE_bit+0, BitPos(RBIE_bit+0)
;BaitapTongHop.c,57 :: 		RBIF_BIT = 0;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;BaitapTongHop.c,58 :: 		}
L_end_ISR_B_init:
	RETURN
; end of _ISR_B_init

_Timer0_init:

;BaitapTongHop.c,60 :: 		void Timer0_init(void)
;BaitapTongHop.c,62 :: 		TMR0 = 0;
	CLRF       TMR0+0
;BaitapTongHop.c,64 :: 		TMR0IE_BIT = 0;
	BCF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;BaitapTongHop.c,65 :: 		TMR0IF_BIT = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;BaitapTongHop.c,67 :: 		PSA_BIT = 0;
	BCF        PSA_bit+0, BitPos(PSA_bit+0)
;BaitapTongHop.c,68 :: 		PS2_BIT = 0;
	BCF        PS2_bit+0, BitPos(PS2_bit+0)
;BaitapTongHop.c,69 :: 		PS1_BIT = 0;
	BCF        PS1_bit+0, BitPos(PS1_bit+0)
;BaitapTongHop.c,70 :: 		PS0_BIT = 0;
	BCF        PS0_bit+0, BitPos(PS0_bit+0)
;BaitapTongHop.c,71 :: 		}
L_end_Timer0_init:
	RETURN
; end of _Timer0_init

_ADC_init:

;BaitapTongHop.c,72 :: 		void ADC_init(void)
;BaitapTongHop.c,74 :: 		ADCS1_BIT = 1;
	BSF        ADCS1_bit+0, BitPos(ADCS1_bit+0)
;BaitapTongHop.c,75 :: 		ADCS0_BIT = 0;
	BCF        ADCS0_bit+0, BitPos(ADCS0_bit+0)
;BaitapTongHop.c,77 :: 		CHS3_BIT = 0;
	BCF        CHS3_bit+0, BitPos(CHS3_bit+0)
;BaitapTongHop.c,78 :: 		CHS2_BIT = 1;
	BSF        CHS2_bit+0, BitPos(CHS2_bit+0)
;BaitapTongHop.c,79 :: 		CHS1_BIT = 1;
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
;BaitapTongHop.c,80 :: 		CHS0_BIT = 0;
	BCF        CHS0_bit+0, BitPos(CHS0_bit+0)
;BaitapTongHop.c,82 :: 		GO_DONE_BIT = 0;
	BCF        GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
;BaitapTongHop.c,83 :: 		ADON_BIT = 1;
	BSF        ADON_bit+0, BitPos(ADON_bit+0)
;BaitapTongHop.c,85 :: 		ADCON1 = 0x80;
	MOVLW      128
	MOVWF      ADCON1+0
;BaitapTongHop.c,86 :: 		}
L_end_ADC_init:
	RETURN
; end of _ADC_init

_ADC_read:

;BaitapTongHop.c,88 :: 		unsigned int ADC_read(void)
;BaitapTongHop.c,90 :: 		delay_us(50);
	MOVLW      33
	MOVWF      R13+0
L_ADC_read15:
	DECFSZ     R13+0, 1
	GOTO       L_ADC_read15
;BaitapTongHop.c,91 :: 		GO_DONE_BIT = 1;
	BSF        GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
;BaitapTongHop.c,92 :: 		while( GO_DONE_BIT == 1 );
L_ADC_read16:
	BTFSS      GO_DONE_bit+0, BitPos(GO_DONE_bit+0)
	GOTO       L_ADC_read17
	GOTO       L_ADC_read16
L_ADC_read17:
;BaitapTongHop.c,93 :: 		return (unsigned int)(ADRESH << 8 | ADRESL);
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;BaitapTongHop.c,94 :: 		}
L_end_ADC_read:
	RETURN
; end of _ADC_read

_PWM_CCP1_init:

;BaitapTongHop.c,96 :: 		void PWM_CCP1_init(unsigned int pr2)
;BaitapTongHop.c,98 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;BaitapTongHop.c,100 :: 		PR2 = pr2;
;BaitapTongHop.c,102 :: 		T2CKPS1_BIT = 0;
	BCF        T2CKPS1_bit+0, BitPos(T2CKPS1_bit+0)
;BaitapTongHop.c,103 :: 		T2CKPS0_BIT = 1;
	BSF        T2CKPS0_bit+0, BitPos(T2CKPS0_bit+0)
;BaitapTongHop.c,105 :: 		TMR2ON_BIT = 0;
	BCF        TMR2ON_bit+0, BitPos(TMR2ON_bit+0)
;BaitapTongHop.c,106 :: 		TMR2IF_BIT = 0;
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
;BaitapTongHop.c,108 :: 		CCP1CON = 0x0C;
	MOVLW      12
	MOVWF      CCP1CON+0
;BaitapTongHop.c,109 :: 		while( TMR2IF_BIT == 0 )
L_PWM_CCP1_init18:
	BTFSC      TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
	GOTO       L_PWM_CCP1_init19
;BaitapTongHop.c,110 :: 		TRISC2_BIT = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
	GOTO       L_PWM_CCP1_init18
L_PWM_CCP1_init19:
;BaitapTongHop.c,111 :: 		}
L_end_PWM_CCP1_init:
	RETURN
; end of _PWM_CCP1_init

_PWM_CCP1_getduty:

;BaitapTongHop.c,113 :: 		void PWM_CCP1_getduty(unsigned int value)
;BaitapTongHop.c,115 :: 		if ( value > 1023 ) value = 1023;
	MOVF       FARG_PWM_CCP1_getduty_value+1, 0
	SUBLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__PWM_CCP1_getduty46
	MOVF       FARG_PWM_CCP1_getduty_value+0, 0
	SUBLW      255
L__PWM_CCP1_getduty46:
	BTFSC      STATUS+0, 0
	GOTO       L_PWM_CCP1_getduty20
	MOVLW      255
	MOVWF      FARG_PWM_CCP1_getduty_value+0
	MOVLW      3
	MOVWF      FARG_PWM_CCP1_getduty_value+1
L_PWM_CCP1_getduty20:
;BaitapTongHop.c,116 :: 		duty = (unsigned int)( value * ( PR2 + 1 )/ 1023 );
	MOVF       PR2+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       FARG_PWM_CCP1_getduty_value+0, 0
	MOVWF      R4+0
	MOVF       FARG_PWM_CCP1_getduty_value+1, 0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _duty+0
	MOVF       R0+1, 0
	MOVWF      _duty+1
;BaitapTongHop.c,117 :: 		CCPR1L = (unsigned char)(duty << 2);
	MOVF       R0+0, 0
	MOVWF      R2+0
	RLF        R2+0, 1
	BCF        R2+0, 0
	RLF        R2+0, 1
	BCF        R2+0, 0
	MOVF       R2+0, 0
	MOVWF      CCPR1L+0
;BaitapTongHop.c,118 :: 		DC1B0_BIT = (unsigned char)(duty & 0x01);
	MOVLW      1
	ANDWF      R0+0, 0
	MOVWF      R2+0
	BTFSC      R2+0, 0
	GOTO       L__PWM_CCP1_getduty47
	BCF        DC1B0_bit+0, BitPos(DC1B0_bit+0)
	GOTO       L__PWM_CCP1_getduty48
L__PWM_CCP1_getduty47:
	BSF        DC1B0_bit+0, BitPos(DC1B0_bit+0)
L__PWM_CCP1_getduty48:
;BaitapTongHop.c,119 :: 		DC1B1_BIT = (unsigned char)(duty >> 1 & 0x01);
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RRF        R2+1, 1
	RRF        R2+0, 1
	BCF        R2+1, 7
	MOVLW      1
	ANDWF      R2+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__PWM_CCP1_getduty49
	BCF        DC1B1_bit+0, BitPos(DC1B1_bit+0)
	GOTO       L__PWM_CCP1_getduty50
L__PWM_CCP1_getduty49:
	BSF        DC1B1_bit+0, BitPos(DC1B1_bit+0)
L__PWM_CCP1_getduty50:
;BaitapTongHop.c,120 :: 		}
L_end_PWM_CCP1_getduty:
	RETURN
; end of _PWM_CCP1_getduty

_LED_on_SW1:

;BaitapTongHop.c,122 :: 		void LED_on_SW1(unsigned int value)
;BaitapTongHop.c,125 :: 		temperture = (float)( value * 500.0 + 200.0 )/1230.0;
	MOVF       FARG_LED_on_SW1_value+0, 0
	MOVWF      R0+0
	MOVF       FARG_LED_on_SW1_value+1, 0
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
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      25
	MOVWF      R4+2
	MOVLW      137
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _temperture+0
	MOVF       R0+1, 0
	MOVWF      _temperture+1
	MOVF       R0+2, 0
	MOVWF      _temperture+2
	MOVF       R0+3, 0
	MOVWF      _temperture+3
;BaitapTongHop.c,127 :: 		PORTD = (unsigned char)temperture;
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;BaitapTongHop.c,128 :: 		for(i=0; i<4; i++)
	CLRF       LED_on_SW1_i_L0+0
L_LED_on_SW121:
	MOVLW      4
	SUBWF      LED_on_SW1_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LED_on_SW122
;BaitapTongHop.c,130 :: 		PORTB = (unsigned char)(0x01 << i);
	MOVF       LED_on_SW1_i_L0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__LED_on_SW152:
	BTFSC      STATUS+0, 2
	GOTO       L__LED_on_SW153
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__LED_on_SW152
L__LED_on_SW153:
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;BaitapTongHop.c,131 :: 		PORTC = (unsigned char)((int)temperture%10 << 3);
	MOVF       _temperture+0, 0
	MOVWF      R0+0
	MOVF       _temperture+1, 0
	MOVWF      R0+1
	MOVF       _temperture+2, 0
	MOVWF      R0+2
	MOVF       _temperture+3, 0
	MOVWF      R0+3
	CALL       _double2int+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      3
	MOVWF      R3+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R3+0, 0
L__LED_on_SW154:
	BTFSC      STATUS+0, 2
	GOTO       L__LED_on_SW155
	RLF        R2+0, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__LED_on_SW154
L__LED_on_SW155:
	MOVF       R2+0, 0
	MOVWF      PORTC+0
;BaitapTongHop.c,132 :: 		temperture = temperture/10;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _temperture+0, 0
	MOVWF      R0+0
	MOVF       _temperture+1, 0
	MOVWF      R0+1
	MOVF       _temperture+2, 0
	MOVWF      R0+2
	MOVF       _temperture+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _temperture+0
	MOVF       R0+1, 0
	MOVWF      _temperture+1
	MOVF       R0+2, 0
	MOVWF      _temperture+2
	MOVF       R0+3, 0
	MOVWF      _temperture+3
;BaitapTongHop.c,133 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_LED_on_SW124:
	DECFSZ     R13+0, 1
	GOTO       L_LED_on_SW124
	DECFSZ     R12+0, 1
	GOTO       L_LED_on_SW124
	DECFSZ     R11+0, 1
	GOTO       L_LED_on_SW124
	NOP
;BaitapTongHop.c,128 :: 		for(i=0; i<4; i++)
	INCF       LED_on_SW1_i_L0+0, 1
;BaitapTongHop.c,134 :: 		}
	GOTO       L_LED_on_SW121
L_LED_on_SW122:
;BaitapTongHop.c,135 :: 		}
L_end_LED_on_SW1:
	RETURN
; end of _LED_on_SW1

_main:

;BaitapTongHop.c,139 :: 		void main()
;BaitapTongHop.c,141 :: 		IO_init();
	CALL       _IO_init+0
;BaitapTongHop.c,142 :: 		ADC_init();
	CALL       _ADC_init+0
;BaitapTongHop.c,143 :: 		ISR_B_init();
	CALL       _ISR_B_init+0
;BaitapTongHop.c,144 :: 		temp = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _temp+0
;BaitapTongHop.c,145 :: 		while(1)
L_main25:
;BaitapTongHop.c,147 :: 		switch(trangthai)
	GOTO       L_main27
;BaitapTongHop.c,149 :: 		case 1:
L_main29:
;BaitapTongHop.c,151 :: 		value = ADC_read();
	CALL       _ADC_read+0
	MOVF       R0+0, 0
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
;BaitapTongHop.c,152 :: 		LED_on_SW1(value);
	MOVF       R0+0, 0
	MOVWF      FARG_LED_on_SW1_value+0
	MOVF       R0+1, 0
	MOVWF      FARG_LED_on_SW1_value+1
	CALL       _LED_on_SW1+0
;BaitapTongHop.c,153 :: 		break;
	GOTO       L_main28
;BaitapTongHop.c,157 :: 		case 2:
L_main30:
;BaitapTongHop.c,159 :: 		value = ADC_read();
	CALL       _ADC_read+0
	MOVF       R0+0, 0
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
;BaitapTongHop.c,160 :: 		PWM_CCP1_init(249);
	MOVLW      249
	MOVWF      FARG_PWM_CCP1_init_pr2+0
	CLRF       FARG_PWM_CCP1_init_pr2+1
	CALL       _PWM_CCP1_init+0
;BaitapTongHop.c,161 :: 		PWM_CCP1_getduty(value);
	MOVF       _value+0, 0
	MOVWF      FARG_PWM_CCP1_getduty_value+0
	MOVF       _value+1, 0
	MOVWF      FARG_PWM_CCP1_getduty_value+1
	CALL       _PWM_CCP1_getduty+0
;BaitapTongHop.c,162 :: 		break;
	GOTO       L_main28
;BaitapTongHop.c,164 :: 		case 3:
L_main31:
;BaitapTongHop.c,167 :: 		Timer0_init();
	CALL       _Timer0_init+0
;BaitapTongHop.c,168 :: 		if ( TMR0IF_BIT )
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_main32
;BaitapTongHop.c,170 :: 		TMR0IF_BIT = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;BaitapTongHop.c,171 :: 		TMR0 = 0;
	CLRF       TMR0+0
;BaitapTongHop.c,172 :: 		}
L_main32:
;BaitapTongHop.c,173 :: 		for(i=0; i<3; i++)
	CLRF       main_i_L3+0
L_main33:
	MOVLW      3
	SUBWF      main_i_L3+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main34
;BaitapTongHop.c,175 :: 		PORTB = (unsigned char)(0x01 >> i);
	MOVF       main_i_L3+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main57:
	BTFSC      STATUS+0, 2
	GOTO       L__main58
	RRF        R0+0, 1
	BCF        R0+0, 7
	BTFSC      R0+0, 6
	BSF        R0+0, 7
	ADDLW      255
	GOTO       L__main57
L__main58:
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;BaitapTongHop.c,176 :: 		PORTC = (unsigned char)(TMR0%10 << 3);
	MOVLW      10
	MOVWF      R4+0
	MOVF       TMR0+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	MOVWF      PORTC+0
;BaitapTongHop.c,173 :: 		for(i=0; i<3; i++)
	INCF       main_i_L3+0, 1
;BaitapTongHop.c,177 :: 		}
	GOTO       L_main33
L_main34:
;BaitapTongHop.c,178 :: 		break;
	GOTO       L_main28
;BaitapTongHop.c,181 :: 		}
L_main27:
	MOVF       _trangthai+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	MOVF       _trangthai+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main30
	MOVF       _trangthai+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main31
L_main28:
;BaitapTongHop.c,183 :: 		}
	GOTO       L_main25
;BaitapTongHop.c,186 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
