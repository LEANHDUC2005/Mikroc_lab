
_IO_init:

;LeAnhDuc_23701131.c,29 :: 		void IO_init(void)
;LeAnhDuc_23701131.c,31 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;LeAnhDuc_23701131.c,32 :: 		TRISD = 0x07;
	MOVLW      7
	MOVWF      TRISD+0
;LeAnhDuc_23701131.c,35 :: 		}
L_end_IO_init:
	RETURN
; end of _IO_init

_PWM_CCP1_init:

;LeAnhDuc_23701131.c,37 :: 		void PWM_CCP1_init(unsigned int duty) // PR2 + 1 = 125
;LeAnhDuc_23701131.c,39 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;LeAnhDuc_23701131.c,42 :: 		CCPR1L = (unsigned char)(duty >> 2 & 0xFF);
	MOVF       FARG_PWM_CCP1_init_duty+0, 0
	MOVWF      R0+0
	MOVF       FARG_PWM_CCP1_init_duty+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	MOVLW      255
	ANDWF      R0+0, 0
	MOVWF      CCPR1L+0
;LeAnhDuc_23701131.c,43 :: 		DC1B0_BIT = (unsigned char)(duty & 0x01);
	MOVLW      1
	ANDWF      FARG_PWM_CCP1_init_duty+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__PWM_CCP1_init40
	BCF        DC1B0_bit+0, BitPos(DC1B0_bit+0)
	GOTO       L__PWM_CCP1_init41
L__PWM_CCP1_init40:
	BSF        DC1B0_bit+0, BitPos(DC1B0_bit+0)
L__PWM_CCP1_init41:
;LeAnhDuc_23701131.c,44 :: 		DC1B1_BIT = (unsigned char)(duty >> 1 & 0x01);
	MOVF       FARG_PWM_CCP1_init_duty+0, 0
	MOVWF      R0+0
	MOVF       FARG_PWM_CCP1_init_duty+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	MOVLW      1
	ANDWF      R0+0, 1
	BTFSC      R0+0, 0
	GOTO       L__PWM_CCP1_init42
	BCF        DC1B1_bit+0, BitPos(DC1B1_bit+0)
	GOTO       L__PWM_CCP1_init43
L__PWM_CCP1_init42:
	BSF        DC1B1_bit+0, BitPos(DC1B1_bit+0)
L__PWM_CCP1_init43:
;LeAnhDuc_23701131.c,46 :: 		T2CKPS1_BIT = 0;
	BCF        T2CKPS1_bit+0, BitPos(T2CKPS1_bit+0)
;LeAnhDuc_23701131.c,47 :: 		T2CKPS0_BIT = 1;
	BSF        T2CKPS0_bit+0, BitPos(T2CKPS0_bit+0)
;LeAnhDuc_23701131.c,49 :: 		TMR2ON_BIT = 1;
	BSF        TMR2ON_bit+0, BitPos(TMR2ON_bit+0)
;LeAnhDuc_23701131.c,50 :: 		TMR2IF_BIT = 0;
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
;LeAnhDuc_23701131.c,51 :: 		CCP1CON = 0x0C;
	MOVLW      12
	MOVWF      CCP1CON+0
;LeAnhDuc_23701131.c,53 :: 		while(TMR2IF_BIT);
L_PWM_CCP1_init0:
	BTFSS      TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
	GOTO       L_PWM_CCP1_init1
	GOTO       L_PWM_CCP1_init0
L_PWM_CCP1_init1:
;LeAnhDuc_23701131.c,54 :: 		TRISC2_BIT = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;LeAnhDuc_23701131.c,55 :: 		}
L_end_PWM_CCP1_init:
	RETURN
; end of _PWM_CCP1_init

_napkitudacbiet:

;LeAnhDuc_23701131.c,56 :: 		void napkitudacbiet(void)
;LeAnhDuc_23701131.c,58 :: 		char i=0;
	CLRF       napkitudacbiet_i_L0+0
;LeAnhDuc_23701131.c,59 :: 		lcd_put_byte(0, 0x40);
	CLRF       FARG_lcd_put_byte_a+0
	MOVLW      64
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;LeAnhDuc_23701131.c,60 :: 		while( kitudacbiet[i] != 0x99 )
L_napkitudacbiet2:
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      153
	BTFSC      STATUS+0, 2
	GOTO       L_napkitudacbiet3
;LeAnhDuc_23701131.c,62 :: 		lcd_put_byte(1, kitudacbiet[i]);
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_a+0
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;LeAnhDuc_23701131.c,63 :: 		i++;
	INCF       napkitudacbiet_i_L0+0, 1
;LeAnhDuc_23701131.c,65 :: 		}
	GOTO       L_napkitudacbiet2
L_napkitudacbiet3:
;LeAnhDuc_23701131.c,66 :: 		}
L_end_napkitudacbiet:
	RETURN
; end of _napkitudacbiet

_LCD_1:

;LeAnhDuc_23701131.c,68 :: 		void LCD_1(void)
;LeAnhDuc_23701131.c,71 :: 		delay_us(10);
	MOVLW      6
	MOVWF      R13+0
L_LCD_14:
	DECFSZ     R13+0, 1
	GOTO       L_LCD_14
	NOP
;LeAnhDuc_23701131.c,72 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;LeAnhDuc_23701131.c,73 :: 		lcd_gotoxy(3,0);
	MOVLW      3
	MOVWF      FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;LeAnhDuc_23701131.c,74 :: 		for(i=0; i<10; i++) lcd_putc(line_SW1a[i]);
	CLRF       LCD_1_i_L0+0
L_LCD_15:
	MOVLW      10
	SUBWF      LCD_1_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LCD_16
	MOVF       LCD_1_i_L0+0, 0
	ADDLW      _line_SW1a+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       LCD_1_i_L0+0, 1
	GOTO       L_LCD_15
L_LCD_16:
;LeAnhDuc_23701131.c,75 :: 		lcd_gotoxy(2,1);
	MOVLW      2
	MOVWF      FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;LeAnhDuc_23701131.c,76 :: 		for(i=0; i<12; i++) lcd_putc(line_SW1b[i]);
	CLRF       LCD_1_i_L0+0
L_LCD_18:
	MOVLW      12
	SUBWF      LCD_1_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LCD_19
	MOVF       LCD_1_i_L0+0, 0
	ADDLW      _line_SW1b+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       LCD_1_i_L0+0, 1
	GOTO       L_LCD_18
L_LCD_19:
;LeAnhDuc_23701131.c,77 :: 		}
L_end_LCD_1:
	RETURN
; end of _LCD_1

_LCD_2:

;LeAnhDuc_23701131.c,79 :: 		void LCD_2(void)
;LeAnhDuc_23701131.c,81 :: 		delay_us(10);
	MOVLW      6
	MOVWF      R13+0
L_LCD_211:
	DECFSZ     R13+0, 1
	GOTO       L_LCD_211
	NOP
;LeAnhDuc_23701131.c,82 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;LeAnhDuc_23701131.c,83 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;LeAnhDuc_23701131.c,84 :: 		lcd_puts("Pulse CCP1");
	MOVLW      ?lstr_1_LeAnhDuc_23701131+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_1_LeAnhDuc_23701131+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;LeAnhDuc_23701131.c,85 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;LeAnhDuc_23701131.c,86 :: 		lcd_puts("f=(3+1)KHz D=80%");
	MOVLW      ?lstr_2_LeAnhDuc_23701131+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_2_LeAnhDuc_23701131+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;LeAnhDuc_23701131.c,87 :: 		}
L_end_LCD_2:
	RETURN
; end of _LCD_2

_LCD_3:

;LeAnhDuc_23701131.c,89 :: 		void LCD_3(void)
;LeAnhDuc_23701131.c,92 :: 		delay_us(10);
	MOVLW      6
	MOVWF      R13+0
L_LCD_312:
	DECFSZ     R13+0, 1
	GOTO       L_LCD_312
	NOP
;LeAnhDuc_23701131.c,93 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;LeAnhDuc_23701131.c,94 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;LeAnhDuc_23701131.c,95 :: 		for(i=0; i<16; i++) lcd_putc(line_SW3a[i]);
	CLRF       LCD_3_i_L0+0
L_LCD_313:
	MOVLW      16
	SUBWF      LCD_3_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LCD_314
	MOVF       LCD_3_i_L0+0, 0
	ADDLW      _line_SW3a+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       LCD_3_i_L0+0, 1
	GOTO       L_LCD_313
L_LCD_314:
;LeAnhDuc_23701131.c,96 :: 		lcd_gotoxy(6,1);
	MOVLW      6
	MOVWF      FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;LeAnhDuc_23701131.c,97 :: 		for(i=0; i<3; i++) lcd_putc(line_SW3b[i]);
	CLRF       LCD_3_i_L0+0
L_LCD_316:
	MOVLW      3
	SUBWF      LCD_3_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LCD_317
	MOVF       LCD_3_i_L0+0, 0
	ADDLW      _line_SW3b+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       LCD_3_i_L0+0, 1
	GOTO       L_LCD_316
L_LCD_317:
;LeAnhDuc_23701131.c,98 :: 		}
L_end_LCD_3:
	RETURN
; end of _LCD_3

_main:

;LeAnhDuc_23701131.c,103 :: 		void main() {
;LeAnhDuc_23701131.c,104 :: 		IO_init();
	CALL       _IO_init+0
;LeAnhDuc_23701131.c,105 :: 		lcd_init();
	CALL       _lcd_init+0
;LeAnhDuc_23701131.c,106 :: 		napkitudacbiet();
	CALL       _napkitudacbiet+0
;LeAnhDuc_23701131.c,107 :: 		while(1)
L_main19:
;LeAnhDuc_23701131.c,109 :: 		if ( RD0_BIT == 0 )
	BTFSC      RD0_bit+0, BitPos(RD0_bit+0)
	GOTO       L_main21
;LeAnhDuc_23701131.c,111 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main22:
	DECFSZ     R13+0, 1
	GOTO       L_main22
	DECFSZ     R12+0, 1
	GOTO       L_main22
	NOP
;LeAnhDuc_23701131.c,112 :: 		if ( RD0_BIT == 0 ) trangthai = 1;
	BTFSC      RD0_bit+0, BitPos(RD0_bit+0)
	GOTO       L_main23
	MOVLW      1
	MOVWF      _trangthai+0
	MOVLW      0
	MOVWF      _trangthai+1
L_main23:
;LeAnhDuc_23701131.c,113 :: 		}
	GOTO       L_main24
L_main21:
;LeAnhDuc_23701131.c,114 :: 		else if ( RD1_BIT == 0 )
	BTFSC      RD1_bit+0, BitPos(RD1_bit+0)
	GOTO       L_main25
;LeAnhDuc_23701131.c,116 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main26:
	DECFSZ     R13+0, 1
	GOTO       L_main26
	DECFSZ     R12+0, 1
	GOTO       L_main26
	NOP
;LeAnhDuc_23701131.c,117 :: 		if ( RD1_BIT == 0 ) trangthai = 2;
	BTFSC      RD1_bit+0, BitPos(RD1_bit+0)
	GOTO       L_main27
	MOVLW      2
	MOVWF      _trangthai+0
	MOVLW      0
	MOVWF      _trangthai+1
L_main27:
;LeAnhDuc_23701131.c,118 :: 		}
	GOTO       L_main28
L_main25:
;LeAnhDuc_23701131.c,119 :: 		else if ( RD2_BIT == 0 )
	BTFSC      RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L_main29
;LeAnhDuc_23701131.c,121 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main30:
	DECFSZ     R13+0, 1
	GOTO       L_main30
	DECFSZ     R12+0, 1
	GOTO       L_main30
	NOP
;LeAnhDuc_23701131.c,122 :: 		if ( RD2_BIT == 0 ) trangthai = 3;
	BTFSC      RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L_main31
	MOVLW      3
	MOVWF      _trangthai+0
	MOVLW      0
	MOVWF      _trangthai+1
L_main31:
;LeAnhDuc_23701131.c,123 :: 		}
L_main29:
L_main28:
L_main24:
;LeAnhDuc_23701131.c,125 :: 		if ( trangthai_truoc != trangthai )
	MOVF       _trangthai_truoc+1, 0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVF       _trangthai+0, 0
	XORWF      _trangthai_truoc+0, 0
L__main49:
	BTFSC      STATUS+0, 2
	GOTO       L_main32
;LeAnhDuc_23701131.c,127 :: 		trangthai_truoc = trangthai;
	MOVF       _trangthai+0, 0
	MOVWF      _trangthai_truoc+0
	MOVF       _trangthai+1, 0
	MOVWF      _trangthai_truoc+1
;LeAnhDuc_23701131.c,128 :: 		if ( trangthai == 1 )
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVLW      1
	XORWF      _trangthai+0, 0
L__main50:
	BTFSS      STATUS+0, 2
	GOTO       L_main33
;LeAnhDuc_23701131.c,130 :: 		CCP1CON = 0x00;
	CLRF       CCP1CON+0
;LeAnhDuc_23701131.c,131 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;LeAnhDuc_23701131.c,132 :: 		LCD_1();
	CALL       _LCD_1+0
;LeAnhDuc_23701131.c,133 :: 		}
	GOTO       L_main34
L_main33:
;LeAnhDuc_23701131.c,134 :: 		else if ( trangthai == 2 )
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVLW      2
	XORWF      _trangthai+0, 0
L__main51:
	BTFSS      STATUS+0, 2
	GOTO       L_main35
;LeAnhDuc_23701131.c,136 :: 		*PR2_select = 124;
	MOVF       _PR2_select+0, 0
	MOVWF      FSR
	MOVLW      124
	MOVWF      INDF+0
	MOVLW      0
	INCF       FSR, 1
	MOVWF      INDF+0
;LeAnhDuc_23701131.c,137 :: 		PWM_CCP1_init(400);
	MOVLW      144
	MOVWF      FARG_PWM_CCP1_init_duty+0
	MOVLW      1
	MOVWF      FARG_PWM_CCP1_init_duty+1
	CALL       _PWM_CCP1_init+0
;LeAnhDuc_23701131.c,138 :: 		LCD_2();
	CALL       _LCD_2+0
;LeAnhDuc_23701131.c,139 :: 		}
	GOTO       L_main36
L_main35:
;LeAnhDuc_23701131.c,140 :: 		else if ( trangthai ==  3 )
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVLW      3
	XORWF      _trangthai+0, 0
L__main52:
	BTFSS      STATUS+0, 2
	GOTO       L_main37
;LeAnhDuc_23701131.c,142 :: 		CCP1CON = 0x00;
	CLRF       CCP1CON+0
;LeAnhDuc_23701131.c,143 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;LeAnhDuc_23701131.c,144 :: 		LCD_3();
	CALL       _LCD_3+0
;LeAnhDuc_23701131.c,145 :: 		}
L_main37:
L_main36:
L_main34:
;LeAnhDuc_23701131.c,146 :: 		}
L_main32:
;LeAnhDuc_23701131.c,147 :: 		}
	GOTO       L_main19
;LeAnhDuc_23701131.c,149 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
