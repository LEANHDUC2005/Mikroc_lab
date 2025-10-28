
_IO_init:

;Baitap2_Tuan5.c,105 :: 		void IO_init(void)
;Baitap2_Tuan5.c,107 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap2_Tuan5.c,108 :: 		TRISD = 0x07;
	MOVLW      7
	MOVWF      TRISD+0
;Baitap2_Tuan5.c,109 :: 		TRISC = 1;
	MOVLW      1
	MOVWF      TRISC+0
;Baitap2_Tuan5.c,110 :: 		}
L_end_IO_init:
	RETURN
; end of _IO_init

_PWM1_init:

;Baitap2_Tuan5.c,112 :: 		void PWM1_init(unsigned int duty_reg)
;Baitap2_Tuan5.c,114 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,116 :: 		TMR2IF_BIT = 0;
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
;Baitap2_Tuan5.c,117 :: 		T2CKPS1_BIT = 0;
	BCF        T2CKPS1_bit+0, BitPos(T2CKPS1_bit+0)
;Baitap2_Tuan5.c,118 :: 		T2CKPS0_BIT = 1;
	BSF        T2CKPS0_bit+0, BitPos(T2CKPS0_bit+0)
;Baitap2_Tuan5.c,119 :: 		TMR2ON_BIT = 1;
	BSF        TMR2ON_bit+0, BitPos(TMR2ON_bit+0)
;Baitap2_Tuan5.c,121 :: 		CCP1CON = 0x0C;
	MOVLW      12
	MOVWF      CCP1CON+0
;Baitap2_Tuan5.c,122 :: 		CCPR1L = (unsigned char)(duty_reg >> 2 & 0xFF);
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
;Baitap2_Tuan5.c,123 :: 		DC1B1_BIT = (unsigned char)(duty_reg >> 1 & 0x01);
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
	GOTO       L__PWM1_init39
	BCF        DC1B1_bit+0, BitPos(DC1B1_bit+0)
	GOTO       L__PWM1_init40
L__PWM1_init39:
	BSF        DC1B1_bit+0, BitPos(DC1B1_bit+0)
L__PWM1_init40:
;Baitap2_Tuan5.c,124 :: 		DC1B0_BIT = (unsigned char)(duty_reg & 0x01);
	MOVLW      1
	ANDWF      FARG_PWM1_init_duty_reg+0, 0
	MOVWF      R0+0
	BTFSC      R0+0, 0
	GOTO       L__PWM1_init41
	BCF        DC1B0_bit+0, BitPos(DC1B0_bit+0)
	GOTO       L__PWM1_init42
L__PWM1_init41:
	BSF        DC1B0_bit+0, BitPos(DC1B0_bit+0)
L__PWM1_init42:
;Baitap2_Tuan5.c,126 :: 		while(TMR2IF_BIT == 0);
L_PWM1_init0:
	BTFSC      TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
	GOTO       L_PWM1_init1
	GOTO       L_PWM1_init0
L_PWM1_init1:
;Baitap2_Tuan5.c,127 :: 		TRISC2_BIT = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,129 :: 		}
L_end_PWM1_init:
	RETURN
; end of _PWM1_init

_napkitudacbiet:

;Baitap2_Tuan5.c,131 :: 		void napkitudacbiet(void)
;Baitap2_Tuan5.c,133 :: 		char i = 0;
	CLRF       napkitudacbiet_i_L0+0
;Baitap2_Tuan5.c,134 :: 		lcd_put_byte(0, 0x40);
	CLRF       FARG_lcd_put_byte_a+0
	MOVLW      64
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap2_Tuan5.c,135 :: 		while( kitudacbiet[i] != 0x99 )
L_napkitudacbiet2:
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      153
	BTFSC      STATUS+0, 2
	GOTO       L_napkitudacbiet3
;Baitap2_Tuan5.c,137 :: 		lcd_put_byte(1, kitudacbiet[i]);
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_a+0
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap2_Tuan5.c,138 :: 		i++;
	INCF       napkitudacbiet_i_L0+0, 1
;Baitap2_Tuan5.c,139 :: 		}
	GOTO       L_napkitudacbiet2
L_napkitudacbiet3:
;Baitap2_Tuan5.c,141 :: 		}
L_end_napkitudacbiet:
	RETURN
; end of _napkitudacbiet

_LCD_1:

;Baitap2_Tuan5.c,143 :: 		void LCD_1(void)
;Baitap2_Tuan5.c,146 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,147 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_LCD_14:
	DECFSZ     R13+0, 1
	GOTO       L_LCD_14
;Baitap2_Tuan5.c,148 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,149 :: 		lcd_puts("f=5KHz");
	MOVLW      ?lstr_1_Baitap2_Tuan5+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_1_Baitap2_Tuan5+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap2_Tuan5.c,150 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,151 :: 		for(i = 0; i < 5; i++) lcd_putc( line1b[i] );
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
;Baitap2_Tuan5.c,153 :: 		}
L_end_LCD_1:
	RETURN
; end of _LCD_1

_LCD_2:

;Baitap2_Tuan5.c,155 :: 		void LCD_2(void)
;Baitap2_Tuan5.c,158 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,159 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_LCD_28:
	DECFSZ     R13+0, 1
	GOTO       L_LCD_28
;Baitap2_Tuan5.c,160 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,161 :: 		lcd_puts("f=5KHz");
	MOVLW      ?lstr_2_Baitap2_Tuan5+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_2_Baitap2_Tuan5+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap2_Tuan5.c,162 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,163 :: 		for(i = 0; i < 5; i++) lcd_putc( line2b[i] );
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
;Baitap2_Tuan5.c,165 :: 		}
L_end_LCD_2:
	RETURN
; end of _LCD_2

_LCD_3:

;Baitap2_Tuan5.c,167 :: 		void LCD_3(void)
;Baitap2_Tuan5.c,170 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,171 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_LCD_312:
	DECFSZ     R13+0, 1
	GOTO       L_LCD_312
;Baitap2_Tuan5.c,172 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,173 :: 		for(i = 0; i < 10; i++) lcd_putc( line3a[i] );
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
;Baitap2_Tuan5.c,174 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,175 :: 		for(i = 0; i < 11; i++) lcd_putc( line3b[i] );
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
;Baitap2_Tuan5.c,177 :: 		}
L_end_LCD_3:
	RETURN
; end of _LCD_3

_main:

;Baitap2_Tuan5.c,181 :: 		void main(void)
;Baitap2_Tuan5.c,183 :: 		IO_init();
	CALL       _IO_init+0
;Baitap2_Tuan5.c,184 :: 		lcd_init();
	CALL       _lcd_init+0
;Baitap2_Tuan5.c,185 :: 		napkitudacbiet();
	CALL       _napkitudacbiet+0
;Baitap2_Tuan5.c,187 :: 		while(1)
L_main19:
;Baitap2_Tuan5.c,189 :: 		if ( RD0_BIT == 0 )
	BTFSC      RD0_bit+0, BitPos(RD0_bit+0)
	GOTO       L_main21
;Baitap2_Tuan5.c,191 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main22:
	DECFSZ     R13+0, 1
	GOTO       L_main22
	DECFSZ     R12+0, 1
	GOTO       L_main22
	NOP
	NOP
;Baitap2_Tuan5.c,192 :: 		if ( RD0_BIT == 0 ) trangthai = 1;
	BTFSC      RD0_bit+0, BitPos(RD0_bit+0)
	GOTO       L_main23
	MOVLW      1
	MOVWF      _trangthai+0
	MOVLW      0
	MOVWF      _trangthai+1
L_main23:
;Baitap2_Tuan5.c,193 :: 		}
L_main21:
;Baitap2_Tuan5.c,194 :: 		if ( RD1_BIT == 0 )
	BTFSC      RD1_bit+0, BitPos(RD1_bit+0)
	GOTO       L_main24
;Baitap2_Tuan5.c,196 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	NOP
	NOP
;Baitap2_Tuan5.c,197 :: 		if ( RD1_BIT == 0 ) trangthai = 2;
	BTFSC      RD1_bit+0, BitPos(RD1_bit+0)
	GOTO       L_main26
	MOVLW      2
	MOVWF      _trangthai+0
	MOVLW      0
	MOVWF      _trangthai+1
L_main26:
;Baitap2_Tuan5.c,198 :: 		}
L_main24:
;Baitap2_Tuan5.c,199 :: 		if ( RD2_BIT == 0 )
	BTFSC      RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L_main27
;Baitap2_Tuan5.c,201 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	NOP
	NOP
;Baitap2_Tuan5.c,202 :: 		if ( RD2_BIT == 0 ) trangthai = 3;
	BTFSC      RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L_main29
	MOVLW      3
	MOVWF      _trangthai+0
	MOVLW      0
	MOVWF      _trangthai+1
L_main29:
;Baitap2_Tuan5.c,203 :: 		}
L_main27:
;Baitap2_Tuan5.c,206 :: 		if ( trangthai_truoc != trangthai )
	MOVF       _trangthai_truoc+1, 0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVF       _trangthai+0, 0
	XORWF      _trangthai_truoc+0, 0
L__main48:
	BTFSC      STATUS+0, 2
	GOTO       L_main30
;Baitap2_Tuan5.c,208 :: 		trangthai_truoc = trangthai;
	MOVF       _trangthai+0, 0
	MOVWF      _trangthai_truoc+0
	MOVF       _trangthai+1, 0
	MOVWF      _trangthai_truoc+1
;Baitap2_Tuan5.c,209 :: 		switch(trangthai)
	GOTO       L_main31
;Baitap2_Tuan5.c,211 :: 		case 1:
L_main33:
;Baitap2_Tuan5.c,213 :: 		*select = 99;
	MOVF       _select+0, 0
	MOVWF      FSR
	MOVLW      99
	MOVWF      INDF+0
	MOVLW      0
	INCF       FSR, 1
	MOVWF      INDF+0
;Baitap2_Tuan5.c,214 :: 		PWM1_init(120);
	MOVLW      120
	MOVWF      FARG_PWM1_init_duty_reg+0
	MOVLW      0
	MOVWF      FARG_PWM1_init_duty_reg+1
	CALL       _PWM1_init+0
;Baitap2_Tuan5.c,215 :: 		LCD_1();
	CALL       _LCD_1+0
;Baitap2_Tuan5.c,216 :: 		break;
	GOTO       L_main32
;Baitap2_Tuan5.c,218 :: 		case 2:
L_main34:
;Baitap2_Tuan5.c,220 :: 		*select = 99;
	MOVF       _select+0, 0
	MOVWF      FSR
	MOVLW      99
	MOVWF      INDF+0
	MOVLW      0
	INCF       FSR, 1
	MOVWF      INDF+0
;Baitap2_Tuan5.c,221 :: 		PWM1_init(320);
	MOVLW      64
	MOVWF      FARG_PWM1_init_duty_reg+0
	MOVLW      1
	MOVWF      FARG_PWM1_init_duty_reg+1
	CALL       _PWM1_init+0
;Baitap2_Tuan5.c,222 :: 		LCD_2();
	CALL       _LCD_2+0
;Baitap2_Tuan5.c,223 :: 		break;
	GOTO       L_main32
;Baitap2_Tuan5.c,225 :: 		case 3:
L_main35:
;Baitap2_Tuan5.c,227 :: 		PWM1_init(0);
	CLRF       FARG_PWM1_init_duty_reg+0
	CLRF       FARG_PWM1_init_duty_reg+1
	CALL       _PWM1_init+0
;Baitap2_Tuan5.c,228 :: 		LCD_3();
	CALL       _LCD_3+0
;Baitap2_Tuan5.c,229 :: 		break;
	GOTO       L_main32
;Baitap2_Tuan5.c,231 :: 		case 0:
L_main36:
;Baitap2_Tuan5.c,233 :: 		CCP1CON = 0;
	CLRF       CCP1CON+0
;Baitap2_Tuan5.c,234 :: 		TMR2ON_BIT = 0;
	BCF        TMR2ON_bit+0, BitPos(TMR2ON_bit+0)
;Baitap2_Tuan5.c,235 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,236 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,237 :: 		break;
	GOTO       L_main32
;Baitap2_Tuan5.c,240 :: 		}
L_main31:
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVLW      1
	XORWF      _trangthai+0, 0
L__main49:
	BTFSC      STATUS+0, 2
	GOTO       L_main33
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVLW      2
	XORWF      _trangthai+0, 0
L__main50:
	BTFSC      STATUS+0, 2
	GOTO       L_main34
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVLW      3
	XORWF      _trangthai+0, 0
L__main51:
	BTFSC      STATUS+0, 2
	GOTO       L_main35
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVLW      0
	XORWF      _trangthai+0, 0
L__main52:
	BTFSC      STATUS+0, 2
	GOTO       L_main36
L_main32:
;Baitap2_Tuan5.c,243 :: 		}
L_main30:
;Baitap2_Tuan5.c,245 :: 		}
	GOTO       L_main19
;Baitap2_Tuan5.c,247 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
