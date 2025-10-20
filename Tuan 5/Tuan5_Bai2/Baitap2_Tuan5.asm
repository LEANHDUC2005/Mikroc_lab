
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

;Baitap2_Tuan5.c,112 :: 		void PWM1_init(unsigned int PR2_, unsigned int duty_reg)
;Baitap2_Tuan5.c,114 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,115 :: 		PR2 = PR2_;
	MOVF       FARG_PWM1_init_PR2_+0, 0
	MOVWF      PR2+0
;Baitap2_Tuan5.c,117 :: 		TMR2IF_BIT = 0;
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
;Baitap2_Tuan5.c,118 :: 		T2CKPS1_BIT = 0;
	BCF        T2CKPS1_bit+0, BitPos(T2CKPS1_bit+0)
;Baitap2_Tuan5.c,119 :: 		T2CKPS0_BIT = 1;
	BSF        T2CKPS0_bit+0, BitPos(T2CKPS0_bit+0)
;Baitap2_Tuan5.c,120 :: 		TMR2ON_BIT = 1;
	BSF        TMR2ON_bit+0, BitPos(TMR2ON_bit+0)
;Baitap2_Tuan5.c,122 :: 		CCP1CON = 0x0C;
	MOVLW      12
	MOVWF      CCP1CON+0
;Baitap2_Tuan5.c,123 :: 		CCPR1L = (unsigned char)(duty_reg >> 2 & 0xFF);
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
;Baitap2_Tuan5.c,124 :: 		DC1B1_BIT = (unsigned char)(duty_reg >> 1 & 0x01);
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
;Baitap2_Tuan5.c,125 :: 		DC1B0_BIT = (unsigned char)(duty_reg & 0x01);
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
;Baitap2_Tuan5.c,127 :: 		while(TMR2IF_BIT == 0);
L_PWM1_init0:
	BTFSC      TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
	GOTO       L_PWM1_init1
	GOTO       L_PWM1_init0
L_PWM1_init1:
;Baitap2_Tuan5.c,128 :: 		TRISC2_BIT = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,130 :: 		}
L_end_PWM1_init:
	RETURN
; end of _PWM1_init

_napkitudacbiet:

;Baitap2_Tuan5.c,132 :: 		void napkitudacbiet(void)
;Baitap2_Tuan5.c,134 :: 		char i = 0;
	CLRF       napkitudacbiet_i_L0+0
;Baitap2_Tuan5.c,135 :: 		lcd_put_byte(0, 0x40);
	CLRF       FARG_lcd_put_byte_a+0
	MOVLW      64
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap2_Tuan5.c,136 :: 		while( kitudacbiet[i] != 0x99 )
L_napkitudacbiet2:
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      153
	BTFSC      STATUS+0, 2
	GOTO       L_napkitudacbiet3
;Baitap2_Tuan5.c,138 :: 		lcd_put_byte(1, kitudacbiet[i]);
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_a+0
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap2_Tuan5.c,139 :: 		i++;
	INCF       napkitudacbiet_i_L0+0, 1
;Baitap2_Tuan5.c,140 :: 		}
	GOTO       L_napkitudacbiet2
L_napkitudacbiet3:
;Baitap2_Tuan5.c,142 :: 		}
L_end_napkitudacbiet:
	RETURN
; end of _napkitudacbiet

_LCD_1:

;Baitap2_Tuan5.c,144 :: 		void LCD_1(void)
;Baitap2_Tuan5.c,147 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,148 :: 		delay_us(2);
	NOP
	NOP
	NOP
	NOP
;Baitap2_Tuan5.c,149 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,150 :: 		lcd_puts("f=5KHz");
	MOVLW      ?lstr_1_Baitap2_Tuan5+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_1_Baitap2_Tuan5+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap2_Tuan5.c,151 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,152 :: 		for(i = 0; i < 5; i++) lcd_putc( line1b[i] );
	CLRF       LCD_1_i_L0+0
L_LCD_14:
	MOVLW      5
	SUBWF      LCD_1_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LCD_15
	MOVF       LCD_1_i_L0+0, 0
	ADDLW      _line1b+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       LCD_1_i_L0+0, 1
	GOTO       L_LCD_14
L_LCD_15:
;Baitap2_Tuan5.c,154 :: 		}
L_end_LCD_1:
	RETURN
; end of _LCD_1

_LCD_2:

;Baitap2_Tuan5.c,156 :: 		void LCD_2(void)
;Baitap2_Tuan5.c,159 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,160 :: 		delay_us(2);
	NOP
	NOP
	NOP
	NOP
;Baitap2_Tuan5.c,161 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,162 :: 		lcd_puts("f=5KHz");
	MOVLW      ?lstr_2_Baitap2_Tuan5+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_2_Baitap2_Tuan5+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap2_Tuan5.c,163 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,164 :: 		for(i = 0; i < 5; i++) lcd_putc( line2b[i] );
	CLRF       LCD_2_i_L0+0
L_LCD_27:
	MOVLW      5
	SUBWF      LCD_2_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LCD_28
	MOVF       LCD_2_i_L0+0, 0
	ADDLW      _line2b+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       LCD_2_i_L0+0, 1
	GOTO       L_LCD_27
L_LCD_28:
;Baitap2_Tuan5.c,166 :: 		}
L_end_LCD_2:
	RETURN
; end of _LCD_2

_LCD_3:

;Baitap2_Tuan5.c,168 :: 		void LCD_3(void)
;Baitap2_Tuan5.c,171 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,172 :: 		delay_us(2);
	NOP
	NOP
	NOP
	NOP
;Baitap2_Tuan5.c,173 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,174 :: 		for(i = 0; i < 10; i++) lcd_putc( line3a[i] );
	CLRF       LCD_3_i_L0+0
L_LCD_310:
	MOVLW      10
	SUBWF      LCD_3_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LCD_311
	MOVF       LCD_3_i_L0+0, 0
	ADDLW      _line3a+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       LCD_3_i_L0+0, 1
	GOTO       L_LCD_310
L_LCD_311:
;Baitap2_Tuan5.c,175 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,176 :: 		for(i = 0; i < 11; i++) lcd_putc( line3b[i] );
	CLRF       LCD_3_i_L0+0
L_LCD_313:
	MOVLW      11
	SUBWF      LCD_3_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_LCD_314
	MOVF       LCD_3_i_L0+0, 0
	ADDLW      _line3b+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       LCD_3_i_L0+0, 1
	GOTO       L_LCD_313
L_LCD_314:
;Baitap2_Tuan5.c,178 :: 		}
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
L_main16:
;Baitap2_Tuan5.c,189 :: 		if ( RD0_BIT == 0 )
	BTFSC      RD0_bit+0, BitPos(RD0_bit+0)
	GOTO       L_main18
;Baitap2_Tuan5.c,191 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	NOP
;Baitap2_Tuan5.c,192 :: 		if ( RD0_BIT == 0 ) trangthai = 1;
	BTFSC      RD0_bit+0, BitPos(RD0_bit+0)
	GOTO       L_main20
	MOVLW      1
	MOVWF      _trangthai+0
	MOVLW      0
	MOVWF      _trangthai+1
L_main20:
;Baitap2_Tuan5.c,193 :: 		}
	GOTO       L_main21
L_main18:
;Baitap2_Tuan5.c,194 :: 		else if ( RD1_BIT == 0 )
	BTFSC      RD1_bit+0, BitPos(RD1_bit+0)
	GOTO       L_main22
;Baitap2_Tuan5.c,196 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	NOP
;Baitap2_Tuan5.c,197 :: 		if ( RD1_BIT == 0 ) trangthai = 2;
	BTFSC      RD1_bit+0, BitPos(RD1_bit+0)
	GOTO       L_main24
	MOVLW      2
	MOVWF      _trangthai+0
	MOVLW      0
	MOVWF      _trangthai+1
L_main24:
;Baitap2_Tuan5.c,198 :: 		}
	GOTO       L_main25
L_main22:
;Baitap2_Tuan5.c,199 :: 		else if ( RD2_BIT == 0 )
	BTFSC      RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L_main26
;Baitap2_Tuan5.c,201 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main27:
	DECFSZ     R13+0, 1
	GOTO       L_main27
	DECFSZ     R12+0, 1
	GOTO       L_main27
	NOP
;Baitap2_Tuan5.c,202 :: 		if ( RD2_BIT == 0 ) trangthai = 3;
	BTFSC      RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L_main28
	MOVLW      3
	MOVWF      _trangthai+0
	MOVLW      0
	MOVWF      _trangthai+1
L_main28:
;Baitap2_Tuan5.c,203 :: 		}
L_main26:
L_main25:
L_main21:
;Baitap2_Tuan5.c,205 :: 		if ( trangthai != trangthai_cu )
	MOVF       _trangthai+1, 0
	XORWF      _trangthai_cu+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVF       _trangthai_cu+0, 0
	XORWF      _trangthai+0, 0
L__main48:
	BTFSC      STATUS+0, 2
	GOTO       L_main29
;Baitap2_Tuan5.c,207 :: 		trangthai_cu = trangthai;
	MOVF       _trangthai+0, 0
	MOVWF      _trangthai_cu+0
	MOVF       _trangthai+1, 0
	MOVWF      _trangthai_cu+1
;Baitap2_Tuan5.c,209 :: 		switch(trangthai)
	GOTO       L_main30
;Baitap2_Tuan5.c,211 :: 		case 1:
L_main32:
;Baitap2_Tuan5.c,213 :: 		PWM1_init(99,120);
	MOVLW      99
	MOVWF      FARG_PWM1_init_PR2_+0
	MOVLW      0
	MOVWF      FARG_PWM1_init_PR2_+1
	MOVLW      120
	MOVWF      FARG_PWM1_init_duty_reg+0
	MOVLW      0
	MOVWF      FARG_PWM1_init_duty_reg+1
	CALL       _PWM1_init+0
;Baitap2_Tuan5.c,214 :: 		LCD_1();
	CALL       _LCD_1+0
;Baitap2_Tuan5.c,215 :: 		break;
	GOTO       L_main31
;Baitap2_Tuan5.c,218 :: 		case 2:
L_main33:
;Baitap2_Tuan5.c,220 :: 		PWM1_init(99,320);
	MOVLW      99
	MOVWF      FARG_PWM1_init_PR2_+0
	MOVLW      0
	MOVWF      FARG_PWM1_init_PR2_+1
	MOVLW      64
	MOVWF      FARG_PWM1_init_duty_reg+0
	MOVLW      1
	MOVWF      FARG_PWM1_init_duty_reg+1
	CALL       _PWM1_init+0
;Baitap2_Tuan5.c,221 :: 		LCD_2();
	CALL       _LCD_2+0
;Baitap2_Tuan5.c,222 :: 		break;
	GOTO       L_main31
;Baitap2_Tuan5.c,225 :: 		case 3:
L_main34:
;Baitap2_Tuan5.c,227 :: 		PWM1_init(99,0);
	MOVLW      99
	MOVWF      FARG_PWM1_init_PR2_+0
	MOVLW      0
	MOVWF      FARG_PWM1_init_PR2_+1
	CLRF       FARG_PWM1_init_duty_reg+0
	CLRF       FARG_PWM1_init_duty_reg+1
	CALL       _PWM1_init+0
;Baitap2_Tuan5.c,228 :: 		LCD_3();
	CALL       _LCD_3+0
;Baitap2_Tuan5.c,229 :: 		break;
	GOTO       L_main31
;Baitap2_Tuan5.c,232 :: 		default:
L_main35:
;Baitap2_Tuan5.c,234 :: 		CCP1CON = 0;
	CLRF       CCP1CON+0
;Baitap2_Tuan5.c,235 :: 		TMR2ON_BIT = 0;
	BCF        TMR2ON_bit+0, BitPos(TMR2ON_bit+0)
;Baitap2_Tuan5.c,236 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,237 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,238 :: 		break;
	GOTO       L_main31
;Baitap2_Tuan5.c,241 :: 		}
L_main30:
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVLW      1
	XORWF      _trangthai+0, 0
L__main49:
	BTFSC      STATUS+0, 2
	GOTO       L_main32
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVLW      2
	XORWF      _trangthai+0, 0
L__main50:
	BTFSC      STATUS+0, 2
	GOTO       L_main33
	MOVLW      0
	XORWF      _trangthai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVLW      3
	XORWF      _trangthai+0, 0
L__main51:
	BTFSC      STATUS+0, 2
	GOTO       L_main34
	GOTO       L_main35
L_main31:
;Baitap2_Tuan5.c,242 :: 		delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main36:
	DECFSZ     R13+0, 1
	GOTO       L_main36
	DECFSZ     R12+0, 1
	GOTO       L_main36
	NOP
	NOP
;Baitap2_Tuan5.c,243 :: 		}
L_main29:
;Baitap2_Tuan5.c,244 :: 		}
	GOTO       L_main16
;Baitap2_Tuan5.c,246 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
