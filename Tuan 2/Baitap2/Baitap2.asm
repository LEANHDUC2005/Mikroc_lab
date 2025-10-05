
_strlen:

;Baitap2.c,13 :: 		int strlen(const char a[])
;Baitap2.c,15 :: 		return sizeof(a)/sizeof(a[0])  - 1;
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
;Baitap2.c,16 :: 		}
L_end_strlen:
	RETURN
; end of _strlen

_napkitudacbiet:

;Baitap2.c,17 :: 		void napkitudacbiet()
;Baitap2.c,19 :: 		char j = 0;
	CLRF       napkitudacbiet_j_L0+0
;Baitap2.c,20 :: 		lcd_put_byte(0, 0x40);
	CLRF       FARG_lcd_put_byte_a+0
	MOVLW      64
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap2.c,21 :: 		while( customchar[j] != 0x99 )
L_napkitudacbiet0:
	MOVF       napkitudacbiet_j_L0+0, 0
	ADDLW      _customchar+0
	MOVWF      R0+0
	MOVLW      hi_addr(_customchar+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      153
	BTFSC      STATUS+0, 2
	GOTO       L_napkitudacbiet1
;Baitap2.c,23 :: 		lcd_put_byte(1, customchar[j]);
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_a+0
	MOVF       napkitudacbiet_j_L0+0, 0
	ADDLW      _customchar+0
	MOVWF      R0+0
	MOVLW      hi_addr(_customchar+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap2.c,24 :: 		j++;
	INCF       napkitudacbiet_j_L0+0, 1
;Baitap2.c,25 :: 		}
	GOTO       L_napkitudacbiet0
L_napkitudacbiet1:
;Baitap2.c,26 :: 		}
L_end_napkitudacbiet:
	RETURN
; end of _napkitudacbiet

_main:

;Baitap2.c,44 :: 		void main()
;Baitap2.c,47 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap2.c,48 :: 		lcd_init();
	CALL       _lcd_init+0
;Baitap2.c,49 :: 		napkitudacbiet();
	CALL       _napkitudacbiet+0
;Baitap2.c,50 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2.c,52 :: 		while(1){
L_main2:
;Baitap2.c,54 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2.c,56 :: 		for( i = 0 ; i < 15 ; i++ )
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main4:
	MOVLW      0
	SUBWF      main_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main22
	MOVLW      15
	SUBWF      main_i_L0+0, 0
L__main22:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
;Baitap2.c,57 :: 		lcd_putc(line00[i]);
	MOVF       main_i_L0+0, 0
	ADDLW      _line00+0
	MOVWF      R0+0
	MOVLW      hi_addr(_line00+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_i_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2.c,56 :: 		for( i = 0 ; i < 15 ; i++ )
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;Baitap2.c,57 :: 		lcd_putc(line00[i]);
	GOTO       L_main4
L_main5:
;Baitap2.c,60 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2.c,61 :: 		lcd_puts(line01);
	MOVLW      _line01+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(_line01+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap2.c,63 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
;Baitap2.c,64 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2.c,67 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2.c,68 :: 		for( i = 0; i <= 3 ; i++ )
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main8:
	MOVF       main_i_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main23
	MOVF       main_i_L0+0, 0
	SUBLW      3
L__main23:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
;Baitap2.c,69 :: 		lcd_putc(line10_a[i]);
	MOVF       main_i_L0+0, 0
	ADDLW      _line10_a+0
	MOVWF      R0+0
	MOVLW      hi_addr(_line10_a+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_i_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2.c,68 :: 		for( i = 0; i <= 3 ; i++ )
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;Baitap2.c,69 :: 		lcd_putc(line10_a[i]);
	GOTO       L_main8
L_main9:
;Baitap2.c,72 :: 		lcd_gotoxy(5,0);
	MOVLW      5
	MOVWF      FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2.c,73 :: 		lcd_puts(line10_b);
	MOVLW      _line10_b+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(_line10_b+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap2.c,75 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2.c,76 :: 		for( i = 0; i <= 16 ; i++ )
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main11:
	MOVF       main_i_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main24
	MOVF       main_i_L0+0, 0
	SUBLW      16
L__main24:
	BTFSS      STATUS+0, 0
	GOTO       L_main12
;Baitap2.c,77 :: 		lcd_putc(line11[i]);
	MOVF       main_i_L0+0, 0
	ADDLW      _line11+0
	MOVWF      R0+0
	MOVLW      hi_addr(_line11+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_i_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2.c,76 :: 		for( i = 0; i <= 16 ; i++ )
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;Baitap2.c,77 :: 		lcd_putc(line11[i]);
	GOTO       L_main11
L_main12:
;Baitap2.c,80 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	DECFSZ     R11+0, 1
	GOTO       L_main14
	NOP
;Baitap2.c,81 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2.c,85 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2.c,86 :: 		lcd_puts(line20);
	MOVLW      _line20+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(_line20+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap2.c,88 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2.c,90 :: 		for ( i = 0 ; i <= 3 ; i++ )
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main15:
	MOVF       main_i_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main25
	MOVF       main_i_L0+0, 0
	SUBLW      3
L__main25:
	BTFSS      STATUS+0, 0
	GOTO       L_main16
;Baitap2.c,91 :: 		lcd_putc(line21[i]);
	MOVF       main_i_L0+0, 0
	ADDLW      _line21+0
	MOVWF      R0+0
	MOVLW      hi_addr(_line21+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_i_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2.c,90 :: 		for ( i = 0 ; i <= 3 ; i++ )
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;Baitap2.c,91 :: 		lcd_putc(line21[i]);
	GOTO       L_main15
L_main16:
;Baitap2.c,93 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
	NOP
;Baitap2.c,94 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2.c,95 :: 		}
	GOTO       L_main2
;Baitap2.c,97 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
