
_IO_init:

;Baitap2_Tuan5.c,18 :: 		void IO_init(void)
;Baitap2_Tuan5.c,20 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap2_Tuan5.c,21 :: 		TRISD = 0x07;
	MOVLW      7
	MOVWF      TRISD+0
;Baitap2_Tuan5.c,22 :: 		TRISC = 1;
	MOVLW      1
	MOVWF      TRISC+0
;Baitap2_Tuan5.c,23 :: 		}
L_end_IO_init:
	RETURN
; end of _IO_init

_PWM1_init:

;Baitap2_Tuan5.c,25 :: 		void PWM1_init(unsigned int pr2, unsigned int duty_reg)
;Baitap2_Tuan5.c,27 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,28 :: 		PR2 = pr2;
;Baitap2_Tuan5.c,30 :: 		TMR2IF_BIT = 0;
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
;Baitap2_Tuan5.c,31 :: 		T2CKPS1_BIT = 0;
	BCF        T2CKPS1_bit+0, BitPos(T2CKPS1_bit+0)
;Baitap2_Tuan5.c,32 :: 		T2CKPS0_BIT = 1;
	BSF        T2CKPS0_bit+0, BitPos(T2CKPS0_bit+0)
;Baitap2_Tuan5.c,33 :: 		TMR2ON_BIT = 1;
	BSF        TMR2ON_bit+0, BitPos(TMR2ON_bit+0)
;Baitap2_Tuan5.c,35 :: 		CCP1CON = 0x0C;
	MOVLW      12
	MOVWF      CCP1CON+0
;Baitap2_Tuan5.c,36 :: 		CCPR1L = (unsigned char)(duty_reg >> 2 & 0xFF);
	MOVF       FARG_PWM1_init_duty_reg+0, 0
	MOVWF      R0+0
	MOVF       FARG_PWM1_init_duty_reg+1, 0
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
;Baitap2_Tuan5.c,37 :: 		DC1B1_BIT = (unsigned char)(duty_reg >> 1 & 0x01);
	MOVF       FARG_PWM1_init_duty_reg+0, 0
	MOVWF      R0+0
	MOVF       FARG_PWM1_init_duty_reg+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	MOVLW      1
	ANDWF      R0+0, 1
	BTFSC      R0+0, 0
	GOTO       L__PWM1_init38
	BCF        DC1B1_bit+0, BitPos(DC1B1_bit+0)
	GOTO       L__PWM1_init39
L__PWM1_init38:
	BSF        DC1B1_bit+0, BitPos(DC1B1_bit+0)
L__PWM1_init39:
;Baitap2_Tuan5.c,38 :: 		DC1B0_BIT = (unsigned char)(duty_reg & 0x01);
	MOVLW      1
	ANDWF      FARG_PWM1_init_duty_reg+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__PWM1_init40
	BCF        DC1B0_bit+0, BitPos(DC1B0_bit+0)
	GOTO       L__PWM1_init41
L__PWM1_init40:
	BSF        DC1B0_bit+0, BitPos(DC1B0_bit+0)
L__PWM1_init41:
;Baitap2_Tuan5.c,40 :: 		while(TMR2IF_BIT == 0);
L_PWM1_init0:
	BTFSC      TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
	GOTO       L_PWM1_init1
	GOTO       L_PWM1_init0
L_PWM1_init1:
;Baitap2_Tuan5.c,41 :: 		TRISC2_BIT = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,43 :: 		}
L_end_PWM1_init:
	RETURN
; end of _PWM1_init

_napkitudacbiet:

;Baitap2_Tuan5.c,45 :: 		void napkitudacbiet(void)
;Baitap2_Tuan5.c,47 :: 		char i = 0;
	CLRF       napkitudacbiet_i_L0+0
;Baitap2_Tuan5.c,48 :: 		lcd_put_byte(0, 0x40);
	CLRF       FARG_lcd_put_byte_a+0
	MOVLW      64
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap2_Tuan5.c,49 :: 		while( kitudacbiet[i] != 0x99 )
L_napkitudacbiet2:
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      153
	BTFSC      STATUS+0, 2
	GOTO       L_napkitudacbiet3
;Baitap2_Tuan5.c,51 :: 		lcd_put_byte(1, kitudacbiet[i]);
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_a+0
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap2_Tuan5.c,52 :: 		i++;
	INCF       napkitudacbiet_i_L0+0, 1
;Baitap2_Tuan5.c,53 :: 		}
	GOTO       L_napkitudacbiet2
L_napkitudacbiet3:
;Baitap2_Tuan5.c,55 :: 		}
L_end_napkitudacbiet:
	RETURN
; end of _napkitudacbiet

_LCD_1:

;Baitap2_Tuan5.c,57 :: 		void LCD_1(void)
;Baitap2_Tuan5.c,60 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,61 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_LCD_14:
	DECFSZ     R13+0, 1
	GOTO       L_LCD_14
;Baitap2_Tuan5.c,62 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,63 :: 		lcd_puts("f=5KHz");
	MOVLW      ?lstr_1_Baitap2_Tuan5+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_1_Baitap2_Tuan5+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap2_Tuan5.c,64 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,65 :: 		for(i = 0; i < 5; i++) lcd_putc( line1b[i] );
	CLRF       LCD_1_i_L0+0
L_LCD_15:
	MOVLW      5
	SUBWF      LCD_1_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LCD_16
	MOVF       LCD_1_i_L0+0, 0
	ADDLW      _line1b+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       LCD_1_i_L0+0, 1
	GOTO       L_LCD_15
L_LCD_16:
;Baitap2_Tuan5.c,67 :: 		}
L_end_LCD_1:
	RETURN
; end of _LCD_1

_LCD_2:

;Baitap2_Tuan5.c,69 :: 		void LCD_2(void)
;Baitap2_Tuan5.c,72 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,73 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_LCD_28:
	DECFSZ     R13+0, 1
	GOTO       L_LCD_28
;Baitap2_Tuan5.c,74 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,75 :: 		lcd_puts("f=5KHz");
	MOVLW      ?lstr_2_Baitap2_Tuan5+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_2_Baitap2_Tuan5+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap2_Tuan5.c,76 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,77 :: 		for(i = 0; i < 5; i++) lcd_putc( line2b[i] );
	CLRF       LCD_2_i_L0+0
L_LCD_29:
	MOVLW      5
	SUBWF      LCD_2_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LCD_210
	MOVF       LCD_2_i_L0+0, 0
	ADDLW      _line2b+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       LCD_2_i_L0+0, 1
	GOTO       L_LCD_29
L_LCD_210:
;Baitap2_Tuan5.c,79 :: 		}
L_end_LCD_2:
	RETURN
; end of _LCD_2

_LCD_3:

;Baitap2_Tuan5.c,81 :: 		void LCD_3(void)
;Baitap2_Tuan5.c,84 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,85 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_LCD_312:
	DECFSZ     R13+0, 1
	GOTO       L_LCD_312
;Baitap2_Tuan5.c,86 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,87 :: 		for(i = 0; i < 10; i++) lcd_putc( line3a[i] );
	CLRF       LCD_3_i_L0+0
L_LCD_313:
	MOVLW      10
	SUBWF      LCD_3_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LCD_314
	MOVF       LCD_3_i_L0+0, 0
	ADDLW      _line3a+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       LCD_3_i_L0+0, 1
	GOTO       L_LCD_313
L_LCD_314:
;Baitap2_Tuan5.c,88 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,89 :: 		for(i = 0; i < 11; i++) lcd_putc( line3b[i] );
	CLRF       LCD_3_i_L0+0
L_LCD_316:
	MOVLW      11
	SUBWF      LCD_3_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LCD_317
	MOVF       LCD_3_i_L0+0, 0
	ADDLW      _line3b+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       LCD_3_i_L0+0, 1
	GOTO       L_LCD_316
L_LCD_317:
;Baitap2_Tuan5.c,91 :: 		}
L_end_LCD_3:
	RETURN
; end of _LCD_3

_main:

;Baitap2_Tuan5.c,93 :: 		void main(void)
;Baitap2_Tuan5.c,95 :: 		IO_init();
	CALL       _IO_init+0
;Baitap2_Tuan5.c,96 :: 		lcd_init();
	CALL       _lcd_init+0
;Baitap2_Tuan5.c,97 :: 		napkitudacbiet();
	CALL       _napkitudacbiet+0
;Baitap2_Tuan5.c,99 :: 		while(1)
L_main19:
;Baitap2_Tuan5.c,102 :: 		if ( RD0_BIT == 0 )
	BTFSC      RD0_bit+0, BitPos(RD0_bit+0)
	GOTO       L_main21
;Baitap2_Tuan5.c,104 :: 		delay_ms(10);
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
;Baitap2_Tuan5.c,105 :: 		if ( RD0_BIT == 0 ) trangthai = 1;
	BTFSC      RD0_bit+0, BitPos(RD0_bit+0)
	GOTO       L_main23
	MOVLW      1
	MOVWF      _trangthai+0
	MOVLW      0
	MOVWF      _trangthai+1
L_main23:
;Baitap2_Tuan5.c,106 :: 		}
L_main21:
;Baitap2_Tuan5.c,107 :: 		if ( RD1_BIT == 0 )
	BTFSC      RD1_bit+0, BitPos(RD1_bit+0)
	GOTO       L_main24
;Baitap2_Tuan5.c,109 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	NOP
;Baitap2_Tuan5.c,110 :: 		if ( RD1_BIT == 0 ) trangthai = 2;
	BTFSC      RD1_bit+0, BitPos(RD1_bit+0)
	GOTO       L_main26
	MOVLW      2
	MOVWF      _trangthai+0
	MOVLW      0
	MOVWF      _trangthai+1
L_main26:
;Baitap2_Tuan5.c,111 :: 		}
L_main24:
;Baitap2_Tuan5.c,112 :: 		if ( RD2_BIT == 0 )
	BTFSC      RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L_main27
;Baitap2_Tuan5.c,114 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	NOP
;Baitap2_Tuan5.c,115 :: 		if ( RD2_BIT == 0 ) trangthai = 3;
	BTFSC      RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L_main29
	MOVLW      3
	MOVWF      _trangthai+0
	MOVLW      0
	MOVWF      _trangthai+1
L_main29:
;Baitap2_Tuan5.c,116 :: 		}
L_main27:
;Baitap2_Tuan5.c,118 :: 		if ( trangthai == 1 )
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main47
	MOVLW      1
	XORWF      _trangthai+0, 0
L__main47:
	BTFSS      STATUS+0, 2
	GOTO       L_main30
;Baitap2_Tuan5.c,120 :: 		PWM1_init(99,120);
	MOVLW      99
	MOVWF      FARG_PWM1_init_pr2+0
	MOVLW      0
	MOVWF      FARG_PWM1_init_pr2+1
	MOVLW      120
	MOVWF      FARG_PWM1_init_duty_reg+0
	MOVLW      0
	MOVWF      FARG_PWM1_init_duty_reg+1
	CALL       _PWM1_init+0
;Baitap2_Tuan5.c,121 :: 		LCD_1();
	CALL       _LCD_1+0
;Baitap2_Tuan5.c,122 :: 		}
	GOTO       L_main31
L_main30:
;Baitap2_Tuan5.c,123 :: 		else if( trangthai == 2 )
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVLW      2
	XORWF      _trangthai+0, 0
L__main48:
	BTFSS      STATUS+0, 2
	GOTO       L_main32
;Baitap2_Tuan5.c,125 :: 		PWM1_init(99, 320);
	MOVLW      99
	MOVWF      FARG_PWM1_init_pr2+0
	MOVLW      0
	MOVWF      FARG_PWM1_init_pr2+1
	MOVLW      64
	MOVWF      FARG_PWM1_init_duty_reg+0
	MOVLW      1
	MOVWF      FARG_PWM1_init_duty_reg+1
	CALL       _PWM1_init+0
;Baitap2_Tuan5.c,126 :: 		LCD_2();
	CALL       _LCD_2+0
;Baitap2_Tuan5.c,127 :: 		}
	GOTO       L_main33
L_main32:
;Baitap2_Tuan5.c,128 :: 		else if( trangthai == 3 )
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVLW      3
	XORWF      _trangthai+0, 0
L__main49:
	BTFSS      STATUS+0, 2
	GOTO       L_main34
;Baitap2_Tuan5.c,130 :: 		PWM1_init(0,0);
	CLRF       FARG_PWM1_init_pr2+0
	CLRF       FARG_PWM1_init_pr2+1
	CLRF       FARG_PWM1_init_duty_reg+0
	CLRF       FARG_PWM1_init_duty_reg+1
	CALL       _PWM1_init+0
;Baitap2_Tuan5.c,131 :: 		LCD_3();
	CALL       _LCD_3+0
;Baitap2_Tuan5.c,132 :: 		}
	GOTO       L_main35
L_main34:
;Baitap2_Tuan5.c,135 :: 		CCP1CON = 0;
	CLRF       CCP1CON+0
;Baitap2_Tuan5.c,136 :: 		TMR2ON_BIT = 0;
	BCF        TMR2ON_bit+0, BitPos(TMR2ON_bit+0)
;Baitap2_Tuan5.c,137 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,138 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,139 :: 		}
L_main35:
L_main33:
L_main31:
;Baitap2_Tuan5.c,141 :: 		}
	GOTO       L_main19
;Baitap2_Tuan5.c,143 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
