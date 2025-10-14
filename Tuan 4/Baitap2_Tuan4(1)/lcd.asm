
_lcd_busy:

;lcd.c,18 :: 		unsigned char lcd_busy()
;lcd.c,24 :: 		LCD_DATA4_TRIS = 1;                // Cau hinh cac chan ket noi LCD.
	BSF        TRISB0_bit+0, BitPos(TRISB0_bit+0)
;lcd.c,25 :: 		LCD_DATA5_TRIS = 1;
	BSF        TRISB1_bit+0, BitPos(TRISB1_bit+0)
;lcd.c,26 :: 		LCD_DATA6_TRIS = 1;
	BSF        TRISB2_bit+0, BitPos(TRISB2_bit+0)
;lcd.c,27 :: 		LCD_DATA7_TRIS = 1;
	BSF        TRISB3_bit+0, BitPos(TRISB3_bit+0)
;lcd.c,30 :: 		LCD_RS = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;lcd.c,31 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_busy0:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_busy0
;lcd.c,32 :: 		LCD_EN = 1;
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
;lcd.c,33 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_busy1:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_busy1
;lcd.c,35 :: 		busy = LCD_DATA7;        // Doc bit bao ban.
	MOVLW      0
	BTFSC      RB3_bit+0, BitPos(RB3_bit+0)
	MOVLW      1
	MOVWF      R1+0
;lcd.c,37 :: 		LCD_EN = 0;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;lcd.c,38 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_busy2:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_busy2
;lcd.c,39 :: 		LCD_EN = 1;
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
;lcd.c,40 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_busy3:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_busy3
;lcd.c,41 :: 		LCD_EN = 0;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;lcd.c,43 :: 		return busy;        // Tra ve ket qua.
	MOVF       R1+0, 0
	MOVWF      R0+0
;lcd.c,44 :: 		}
L_end_lcd_busy:
	RETURN
; end of _lcd_busy

_lcd_get_byte:

;lcd.c,53 :: 		unsigned char lcd_get_byte(unsigned char rs)
;lcd.c,59 :: 		LCD_DATA4_TRIS = 1;                // Cau hinh cac chan ket noi LCD.
	BSF        TRISB0_bit+0, BitPos(TRISB0_bit+0)
;lcd.c,60 :: 		LCD_DATA5_TRIS = 1;
	BSF        TRISB1_bit+0, BitPos(TRISB1_bit+0)
;lcd.c,61 :: 		LCD_DATA6_TRIS = 1;
	BSF        TRISB2_bit+0, BitPos(TRISB2_bit+0)
;lcd.c,62 :: 		LCD_DATA7_TRIS = 1;
	BSF        TRISB3_bit+0, BitPos(TRISB3_bit+0)
;lcd.c,66 :: 		if(rs)
	MOVF       FARG_lcd_get_byte_rs+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_get_byte4
;lcd.c,67 :: 		LCD_RS = 1;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L_lcd_get_byte5
L_lcd_get_byte4:
;lcd.c,69 :: 		LCD_RS = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
L_lcd_get_byte5:
;lcd.c,70 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_get_byte6:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_get_byte6
;lcd.c,72 :: 		LCD_EN = 1;
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
;lcd.c,73 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_get_byte7:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_get_byte7
;lcd.c,75 :: 		b.bits.b7 = LCD_DATA7;        // Doc 4 bit cao.
	BTFSC      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L__lcd_get_byte52
	BCF        R1+0, 7
	GOTO       L__lcd_get_byte53
L__lcd_get_byte52:
	BSF        R1+0, 7
L__lcd_get_byte53:
;lcd.c,76 :: 		b.bits.b6 = LCD_DATA6;
	BTFSC      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L__lcd_get_byte54
	BCF        R1+0, 6
	GOTO       L__lcd_get_byte55
L__lcd_get_byte54:
	BSF        R1+0, 6
L__lcd_get_byte55:
;lcd.c,77 :: 		b.bits.b5 = LCD_DATA5;
	BTFSC      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L__lcd_get_byte56
	BCF        R1+0, 5
	GOTO       L__lcd_get_byte57
L__lcd_get_byte56:
	BSF        R1+0, 5
L__lcd_get_byte57:
;lcd.c,78 :: 		b.bits.b4 = LCD_DATA4;
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L__lcd_get_byte58
	BCF        R1+0, 4
	GOTO       L__lcd_get_byte59
L__lcd_get_byte58:
	BSF        R1+0, 4
L__lcd_get_byte59:
;lcd.c,80 :: 		LCD_EN = 0;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;lcd.c,81 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_get_byte8:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_get_byte8
;lcd.c,83 :: 		LCD_EN = 1;
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
;lcd.c,84 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_get_byte9:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_get_byte9
;lcd.c,86 :: 		b.bits.b3 = LCD_DATA7;        // Doc 4 bit thap.
	BTFSC      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L__lcd_get_byte60
	BCF        R1+0, 3
	GOTO       L__lcd_get_byte61
L__lcd_get_byte60:
	BSF        R1+0, 3
L__lcd_get_byte61:
;lcd.c,87 :: 		b.bits.b2 = LCD_DATA6;
	BTFSC      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L__lcd_get_byte62
	BCF        R1+0, 2
	GOTO       L__lcd_get_byte63
L__lcd_get_byte62:
	BSF        R1+0, 2
L__lcd_get_byte63:
;lcd.c,88 :: 		b.bits.b1 = LCD_DATA5;
	BTFSC      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L__lcd_get_byte64
	BCF        R1+0, 1
	GOTO       L__lcd_get_byte65
L__lcd_get_byte64:
	BSF        R1+0, 1
L__lcd_get_byte65:
;lcd.c,89 :: 		b.bits.b0 = LCD_DATA4;
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L__lcd_get_byte66
	BCF        R1+0, 0
	GOTO       L__lcd_get_byte67
L__lcd_get_byte66:
	BSF        R1+0, 0
L__lcd_get_byte67:
;lcd.c,91 :: 		LCD_EN = 0;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;lcd.c,92 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_get_byte10:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_get_byte10
;lcd.c,94 :: 		return b.Val;        // Tra ve ket qua doc duoc.
	MOVF       R1+0, 0
	MOVWF      R0+0
;lcd.c,95 :: 		}
L_end_lcd_get_byte:
	RETURN
; end of _lcd_get_byte

_lcd_put_nibble:

;lcd.c,103 :: 		void lcd_put_nibble(unsigned char b)
;lcd.c,109 :: 		LCD_DATA4_TRIS = 0;                // Cau hinh cac chan ket noi LCD.
	BCF        TRISB0_bit+0, BitPos(TRISB0_bit+0)
;lcd.c,110 :: 		LCD_DATA5_TRIS = 0;
	BCF        TRISB1_bit+0, BitPos(TRISB1_bit+0)
;lcd.c,111 :: 		LCD_DATA6_TRIS = 0;
	BCF        TRISB2_bit+0, BitPos(TRISB2_bit+0)
;lcd.c,112 :: 		LCD_DATA7_TRIS = 0;
	BCF        TRISB3_bit+0, BitPos(TRISB3_bit+0)
;lcd.c,114 :: 		temp.Val = b;
	MOVF       FARG_lcd_put_nibble_b+0, 0
	MOVWF      R0+0
;lcd.c,116 :: 		LCD_DATA4 = temp.bits.b0;        // Gui 4 bit thap.
	BTFSC      R0+0, 0
	GOTO       L__lcd_put_nibble69
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L__lcd_put_nibble70
L__lcd_put_nibble69:
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
L__lcd_put_nibble70:
;lcd.c,117 :: 		LCD_DATA5 = temp.bits.b1;
	BTFSC      R0+0, 1
	GOTO       L__lcd_put_nibble71
	BCF        RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L__lcd_put_nibble72
L__lcd_put_nibble71:
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
L__lcd_put_nibble72:
;lcd.c,118 :: 		LCD_DATA6 = temp.bits.b2;
	BTFSC      R0+0, 2
	GOTO       L__lcd_put_nibble73
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L__lcd_put_nibble74
L__lcd_put_nibble73:
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
L__lcd_put_nibble74:
;lcd.c,119 :: 		LCD_DATA7 = temp.bits.b3;
	BTFSC      R0+0, 3
	GOTO       L__lcd_put_nibble75
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L__lcd_put_nibble76
L__lcd_put_nibble75:
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
L__lcd_put_nibble76:
;lcd.c,121 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_put_nibble11:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_put_nibble11
;lcd.c,122 :: 		LCD_EN =  1;
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
;lcd.c,123 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_put_nibble12:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_put_nibble12
;lcd.c,124 :: 		LCD_EN = 0;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;lcd.c,125 :: 		}
L_end_lcd_put_nibble:
	RETURN
; end of _lcd_put_nibble

_lcd_put_byte:

;lcd.c,134 :: 		void lcd_put_byte(unsigned char rs, unsigned char b)
;lcd.c,139 :: 		LCD_DATA4_TRIS = 0;                // Cau hinh cac chan ket noi LCD.
	BCF        TRISB0_bit+0, BitPos(TRISB0_bit+0)
;lcd.c,140 :: 		LCD_DATA5_TRIS = 0;
	BCF        TRISB1_bit+0, BitPos(TRISB1_bit+0)
;lcd.c,141 :: 		LCD_DATA6_TRIS = 0;
	BCF        TRISB2_bit+0, BitPos(TRISB2_bit+0)
;lcd.c,142 :: 		LCD_DATA7_TRIS = 0;
	BCF        TRISB3_bit+0, BitPos(TRISB3_bit+0)
;lcd.c,144 :: 		if(rs)
	MOVF       FARG_lcd_put_byte_rs+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_put_byte13
;lcd.c,145 :: 		LCD_RS = 1;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L_lcd_put_byte14
L_lcd_put_byte13:
;lcd.c,147 :: 		LCD_RS = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
L_lcd_put_byte14:
;lcd.c,148 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_put_byte15:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_put_byte15
;lcd.c,151 :: 		delay_us(20);
	MOVLW      13
	MOVWF      R13+0
L_lcd_put_byte16:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_put_byte16
;lcd.c,153 :: 		LCD_EN = 0;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;lcd.c,155 :: 		lcd_put_nibble(b >> 4);                // Gui 4 bit cao.
	MOVF       FARG_lcd_put_byte_b+0, 0
	MOVWF      FARG_lcd_put_nibble_b+0
	RRF        FARG_lcd_put_nibble_b+0, 1
	BCF        FARG_lcd_put_nibble_b+0, 7
	RRF        FARG_lcd_put_nibble_b+0, 1
	BCF        FARG_lcd_put_nibble_b+0, 7
	RRF        FARG_lcd_put_nibble_b+0, 1
	BCF        FARG_lcd_put_nibble_b+0, 7
	RRF        FARG_lcd_put_nibble_b+0, 1
	BCF        FARG_lcd_put_nibble_b+0, 7
	CALL       _lcd_put_nibble+0
;lcd.c,157 :: 		lcd_put_nibble(b & 0xf);        // Gui 4 bit thap.
	MOVLW      15
	ANDWF      FARG_lcd_put_byte_b+0, 0
	MOVWF      FARG_lcd_put_nibble_b+0
	CALL       _lcd_put_nibble+0
;lcd.c,158 :: 		}
L_end_lcd_put_byte:
	RETURN
; end of _lcd_put_byte

_lcd_gotoxy:

;lcd.c,167 :: 		void lcd_gotoxy(unsigned char col, unsigned char row)
;lcd.c,173 :: 		if(row!=0)                // Xac dinh ma qui dinh dia chi dong.
	MOVF       FARG_lcd_gotoxy_row+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_gotoxy17
;lcd.c,174 :: 		address=0x40;        // Dong duoi.
	MOVLW      64
	MOVWF      lcd_gotoxy_address_L0+0
	GOTO       L_lcd_gotoxy18
L_lcd_gotoxy17:
;lcd.c,176 :: 		address=0;                // Dong tren.
	CLRF       lcd_gotoxy_address_L0+0
L_lcd_gotoxy18:
;lcd.c,178 :: 		address += col;
	MOVF       FARG_lcd_gotoxy_col+0, 0
	ADDWF      lcd_gotoxy_address_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      lcd_gotoxy_address_L0+0
;lcd.c,180 :: 		lcd_put_byte(0,0x80|address);        // Gui lenh dieu khien sang LCD.
	CLRF       FARG_lcd_put_byte_rs+0
	MOVLW      128
	IORWF      R0+0, 0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;lcd.c,182 :: 		}
L_end_lcd_gotoxy:
	RETURN
; end of _lcd_gotoxy

_lcd_putc:

;lcd.c,190 :: 		void lcd_putc(char c)
;lcd.c,195 :: 		switch(c)
	GOTO       L_lcd_putc19
;lcd.c,197 :: 		case '\f':                        // Xoa man hinh.
L_lcd_putc21:
;lcd.c,198 :: 		lcd_put_byte(0,1);
	CLRF       FARG_lcd_put_byte_rs+0
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;lcd.c,199 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_lcd_putc22:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_putc22
	DECFSZ     R12+0, 1
	GOTO       L_lcd_putc22
	NOP
	NOP
;lcd.c,200 :: 		break;
	GOTO       L_lcd_putc20
;lcd.c,201 :: 		case '\n':                        // Xuong dong va dua con tro ve dau dong.
L_lcd_putc23:
;lcd.c,202 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;lcd.c,203 :: 		break;
	GOTO       L_lcd_putc20
;lcd.c,204 :: 		case '\b':
L_lcd_putc24:
;lcd.c,205 :: 		lcd_put_byte(0,0x10);
	CLRF       FARG_lcd_put_byte_rs+0
	MOVLW      16
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;lcd.c,206 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_lcd_putc25:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_putc25
	DECFSZ     R12+0, 1
	GOTO       L_lcd_putc25
	NOP
	NOP
;lcd.c,207 :: 		break;
	GOTO       L_lcd_putc20
;lcd.c,208 :: 		default:        // Hien thi tat ca ky tu mac dinh trong LCD (c: dia chi HEX cua ky tu)
L_lcd_putc26:
;lcd.c,211 :: 		lcd_put_byte(1,c);
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_rs+0
	MOVF       FARG_lcd_putc_c+0, 0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;lcd.c,212 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_lcd_putc27:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_putc27
	DECFSZ     R12+0, 1
	GOTO       L_lcd_putc27
	NOP
	NOP
;lcd.c,215 :: 		}
	GOTO       L_lcd_putc20
L_lcd_putc19:
	MOVF       FARG_lcd_putc_c+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_putc21
	MOVF       FARG_lcd_putc_c+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_putc23
	MOVF       FARG_lcd_putc_c+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_putc24
	GOTO       L_lcd_putc26
L_lcd_putc20:
;lcd.c,216 :: 		}
L_end_lcd_putc:
	RETURN
; end of _lcd_putc

_lcd_puts:

;lcd.c,224 :: 		void lcd_puts(const char* s)
;lcd.c,229 :: 		while(*s)
L_lcd_puts28:
	MOVF       FARG_lcd_puts_s+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_lcd_puts_s+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_puts29
;lcd.c,231 :: 		lcd_putc(*s++);
	MOVF       FARG_lcd_puts_s+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_lcd_puts_s+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       FARG_lcd_puts_s+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_lcd_puts_s+1, 1
;lcd.c,232 :: 		}
	GOTO       L_lcd_puts28
L_lcd_puts29:
;lcd.c,233 :: 		}
L_end_lcd_puts:
	RETURN
; end of _lcd_puts

_lcd_init:

;lcd.c,241 :: 		void lcd_init()
;lcd.c,247 :: 		LCD_EN_TRIS = 0;                // Cau hinh cac chan ket noi LCD.
	BCF        TRISB5_bit+0, BitPos(TRISB5_bit+0)
;lcd.c,248 :: 		LCD_RS_TRIS = 0;
	BCF        TRISB4_bit+0, BitPos(TRISB4_bit+0)
;lcd.c,250 :: 		LCD_DATA4_TRIS = 0;
	BCF        TRISB0_bit+0, BitPos(TRISB0_bit+0)
;lcd.c,251 :: 		LCD_DATA5_TRIS = 0;
	BCF        TRISB1_bit+0, BitPos(TRISB1_bit+0)
;lcd.c,252 :: 		LCD_DATA6_TRIS = 0;
	BCF        TRISB2_bit+0, BitPos(TRISB2_bit+0)
;lcd.c,253 :: 		LCD_DATA7_TRIS = 0;
	BCF        TRISB3_bit+0, BitPos(TRISB3_bit+0)
;lcd.c,255 :: 		delay_ms(15);                // Tao tre cho cap nguon LCD on dinh.
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_lcd_init30:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_init30
	DECFSZ     R12+0, 1
	GOTO       L_lcd_init30
;lcd.c,257 :: 		LCD_RS = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;lcd.c,259 :: 		LCD_EN = 0;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;lcd.c,261 :: 		lcd_put_nibble(3);        // Reset LCD
	MOVLW      3
	MOVWF      FARG_lcd_put_nibble_b+0
	CALL       _lcd_put_nibble+0
;lcd.c,262 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_lcd_init31:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_init31
	DECFSZ     R12+0, 1
	GOTO       L_lcd_init31
	NOP
;lcd.c,263 :: 		lcd_put_nibble(3);
	MOVLW      3
	MOVWF      FARG_lcd_put_nibble_b+0
	CALL       _lcd_put_nibble+0
;lcd.c,264 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_lcd_init32:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_init32
	DECFSZ     R12+0, 1
	GOTO       L_lcd_init32
	NOP
;lcd.c,265 :: 		lcd_put_nibble(3);
	MOVLW      3
	MOVWF      FARG_lcd_put_nibble_b+0
	CALL       _lcd_put_nibble+0
;lcd.c,266 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_lcd_init33:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_init33
	DECFSZ     R12+0, 1
	GOTO       L_lcd_init33
	NOP
;lcd.c,268 :: 		lcd_put_nibble(2);
	MOVLW      2
	MOVWF      FARG_lcd_put_nibble_b+0
	CALL       _lcd_put_nibble+0
;lcd.c,269 :: 		delay_ms(1);//while(lcd_busy());
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_lcd_init34:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_init34
	DECFSZ     R12+0, 1
	GOTO       L_lcd_init34
	NOP
	NOP
;lcd.c,271 :: 		lcd_put_byte(0,FOUR_BIT & LINES_5X7);                // Loai LCD.
	CLRF       FARG_lcd_put_byte_rs+0
	MOVLW      40
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;lcd.c,272 :: 		delay_ms(1);//while(lcd_busy());
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_lcd_init35:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_init35
	DECFSZ     R12+0, 1
	GOTO       L_lcd_init35
	NOP
	NOP
;lcd.c,274 :: 		lcd_put_byte(0,DON & CURSOR_OFF & BLINK_OFF);        // Bat hien thi, tat con tro, tat chop tat con tro.
	CLRF       FARG_lcd_put_byte_rs+0
	MOVLW      12
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;lcd.c,275 :: 		delay_ms(1);//while(lcd_busy());
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_lcd_init36:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_init36
	DECFSZ     R12+0, 1
	GOTO       L_lcd_init36
	NOP
	NOP
;lcd.c,277 :: 		lcd_put_byte(0,0x01);                                 // Xoa man hinh va dua con tro ve dau dong.
	CLRF       FARG_lcd_put_byte_rs+0
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;lcd.c,278 :: 		delay_ms(1);//while(lcd_busy());
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_lcd_init37:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_init37
	DECFSZ     R12+0, 1
	GOTO       L_lcd_init37
	NOP
	NOP
;lcd.c,280 :: 		lcd_put_byte(0,SHIFT_DISP_LEFT);                        // Che do dich chuyen con tro.
	CLRF       FARG_lcd_put_byte_rs+0
	MOVLW      6
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;lcd.c,281 :: 		delay_ms(1);//while(lcd_busy());
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_lcd_init38:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_init38
	DECFSZ     R12+0, 1
	GOTO       L_lcd_init38
	NOP
	NOP
;lcd.c,282 :: 		}
L_end_lcd_init:
	RETURN
; end of _lcd_init

_lcd_ShiftLeft:

;lcd.c,290 :: 		void lcd_ShiftLeft(void)
;lcd.c,295 :: 		lcd_put_byte(0,0x18);
	CLRF       FARG_lcd_put_byte_rs+0
	MOVLW      24
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;lcd.c,296 :: 		}
L_end_lcd_ShiftLeft:
	RETURN
; end of _lcd_ShiftLeft

_lcd_ShiftRight:

;lcd.c,304 :: 		void lcd_ShiftRight(void)
;lcd.c,309 :: 		lcd_put_byte(0,0x1C);
	CLRF       FARG_lcd_put_byte_rs+0
	MOVLW      28
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;lcd.c,310 :: 		}
L_end_lcd_ShiftRight:
	RETURN
; end of _lcd_ShiftRight

_lcd_MoveRight:

;lcd.c,318 :: 		void lcd_MoveRight(unsigned char p)
;lcd.c,324 :: 		for(i=0;i<p;i++)
	CLRF       lcd_MoveRight_i_L0+0
L_lcd_MoveRight39:
	MOVF       FARG_lcd_MoveRight_p+0, 0
	SUBWF      lcd_MoveRight_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_lcd_MoveRight40
;lcd.c,326 :: 		lcd_ShiftRight();
	CALL       _lcd_ShiftRight+0
;lcd.c,327 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_lcd_MoveRight42:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_MoveRight42
	DECFSZ     R12+0, 1
	GOTO       L_lcd_MoveRight42
	DECFSZ     R11+0, 1
	GOTO       L_lcd_MoveRight42
	NOP
;lcd.c,324 :: 		for(i=0;i<p;i++)
	INCF       lcd_MoveRight_i_L0+0, 1
;lcd.c,328 :: 		}
	GOTO       L_lcd_MoveRight39
L_lcd_MoveRight40:
;lcd.c,329 :: 		}
L_end_lcd_MoveRight:
	RETURN
; end of _lcd_MoveRight

_lcd_MoveLeft:

;lcd.c,337 :: 		void lcd_MoveLeft(unsigned char p)
;lcd.c,343 :: 		for(i=0;i<p;i++)
	CLRF       lcd_MoveLeft_i_L0+0
L_lcd_MoveLeft43:
	MOVF       FARG_lcd_MoveLeft_p+0, 0
	SUBWF      lcd_MoveLeft_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_lcd_MoveLeft44
;lcd.c,345 :: 		lcd_ShiftLeft();
	CALL       _lcd_ShiftLeft+0
;lcd.c,346 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_lcd_MoveLeft46:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_MoveLeft46
	DECFSZ     R12+0, 1
	GOTO       L_lcd_MoveLeft46
	DECFSZ     R11+0, 1
	GOTO       L_lcd_MoveLeft46
	NOP
;lcd.c,343 :: 		for(i=0;i<p;i++)
	INCF       lcd_MoveLeft_i_L0+0, 1
;lcd.c,347 :: 		}
	GOTO       L_lcd_MoveLeft43
L_lcd_MoveLeft44:
;lcd.c,348 :: 		}
L_end_lcd_MoveLeft:
	RETURN
; end of _lcd_MoveLeft

_lcd_String_Delay:

;lcd.c,356 :: 		void lcd_String_Delay(unsigned char*s)
;lcd.c,361 :: 		while(*s!=0)
L_lcd_String_Delay47:
	MOVF       FARG_lcd_String_Delay_s+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_String_Delay48
;lcd.c,363 :: 		lcd_putc(*s++);
	MOVF       FARG_lcd_String_Delay_s+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       FARG_lcd_String_Delay_s+0, 1
;lcd.c,364 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_lcd_String_Delay49:
	DECFSZ     R13+0, 1
	GOTO       L_lcd_String_Delay49
	DECFSZ     R12+0, 1
	GOTO       L_lcd_String_Delay49
	NOP
	NOP
;lcd.c,365 :: 		}
	GOTO       L_lcd_String_Delay47
L_lcd_String_Delay48:
;lcd.c,366 :: 		}
L_end_lcd_String_Delay:
	RETURN
; end of _lcd_String_Delay

_putch:

;lcd.c,372 :: 		void putch(char c)
;lcd.c,374 :: 		lcd_putc(c);
	MOVF       FARG_putch_c+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;lcd.c,375 :: 		}
L_end_putch:
	RETURN
; end of _putch
