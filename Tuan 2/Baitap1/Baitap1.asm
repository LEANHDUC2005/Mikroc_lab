
_Baitap1:

;Baitap1.c,3 :: 		void Baitap1()
;Baitap1.c,5 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap1.c,6 :: 		lcd_puts("Hovatensinhvien");
	MOVLW      ?lstr_1_Baitap1+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_1_Baitap1+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap1.c,7 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap1.c,8 :: 		lcd_puts("MSSV:");
	MOVLW      ?lstr_2_Baitap1+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_2_Baitap1+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap1.c,10 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_Baitap10:
	DECFSZ     R13+0, 1
	GOTO       L_Baitap10
	DECFSZ     R12+0, 1
	GOTO       L_Baitap10
	DECFSZ     R11+0, 1
	GOTO       L_Baitap10
	NOP
;Baitap1.c,11 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap1.c,15 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap1.c,16 :: 		lcd_puts("Ngay sinh:mm/yy");
	MOVLW      ?lstr_3_Baitap1+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_3_Baitap1+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap1.c,17 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap1.c,18 :: 		lcd_puts("Noisinh:Tinh(TP)");
	MOVLW      ?lstr_4_Baitap1+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_4_Baitap1+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap1.c,20 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_Baitap11:
	DECFSZ     R13+0, 1
	GOTO       L_Baitap11
	DECFSZ     R12+0, 1
	GOTO       L_Baitap11
	DECFSZ     R11+0, 1
	GOTO       L_Baitap11
	NOP
;Baitap1.c,21 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap1.c,25 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap1.c,26 :: 		lcd_puts("HKTT:");
	MOVLW      ?lstr_5_Baitap1+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_5_Baitap1+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap1.c,27 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap1.c,28 :: 		lcd_puts("Lop:");
	MOVLW      ?lstr_6_Baitap1+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_6_Baitap1+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap1.c,30 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_Baitap12:
	DECFSZ     R13+0, 1
	GOTO       L_Baitap12
	DECFSZ     R12+0, 1
	GOTO       L_Baitap12
	DECFSZ     R11+0, 1
	GOTO       L_Baitap12
	NOP
;Baitap1.c,31 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap1.c,33 :: 		}
L_end_Baitap1:
	RETURN
; end of _Baitap1

_main:

;Baitap1.c,34 :: 		void main() {
;Baitap1.c,35 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap1.c,36 :: 		lcd_init();
	CALL       _lcd_init+0
;Baitap1.c,38 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap1.c,39 :: 		while(1)
L_main3:
;Baitap1.c,41 :: 		Baitap1();
	CALL       _Baitap1+0
;Baitap1.c,42 :: 		}
	GOTO       L_main3
;Baitap1.c,43 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
