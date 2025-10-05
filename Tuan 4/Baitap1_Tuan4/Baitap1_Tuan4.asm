
_inline1:

;Baitap1_Tuan4.c,18 :: 		void inline1()
;Baitap1_Tuan4.c,20 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap1_Tuan4.c,21 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap1_Tuan4.c,22 :: 		lcd_puts("DUC Counter 0");
	MOVLW      ?lstr_1_Baitap1_Tuan4+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_1_Baitap1_Tuan4+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap1_Tuan4.c,23 :: 		}
L_end_inline1:
	RETURN
; end of _inline1

_inline2:

;Baitap1_Tuan4.c,24 :: 		void inline2()
;Baitap1_Tuan4.c,26 :: 		lcd_gotoxy(6,1);
	MOVLW      6
	MOVWF      FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap1_Tuan4.c,27 :: 		lcd_putc(chuso[count/10]);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _count+0, 0
	MOVWF      R0+0
	MOVF       _count+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	ADDLW      _chuso+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap1_Tuan4.c,28 :: 		lcd_putc(chuso[count%10]);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _count+0, 0
	MOVWF      R0+0
	MOVF       _count+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      _chuso+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap1_Tuan4.c,29 :: 		}
L_end_inline2:
	RETURN
; end of _inline2

_main:

;Baitap1_Tuan4.c,31 :: 		void main()
;Baitap1_Tuan4.c,33 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap1_Tuan4.c,34 :: 		TRISA4_BIT = 1;
	BSF        TRISA4_bit+0, BitPos(TRISA4_bit+0)
;Baitap1_Tuan4.c,35 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;Baitap1_Tuan4.c,37 :: 		T0CS_BIT = 1;
	BSF        T0CS_bit+0, BitPos(T0CS_bit+0)
;Baitap1_Tuan4.c,38 :: 		T0SE_BIT = 1;
	BSF        T0SE_bit+0, BitPos(T0SE_bit+0)
;Baitap1_Tuan4.c,40 :: 		PSA_BIT = 1;
	BSF        PSA_bit+0, BitPos(PSA_bit+0)
;Baitap1_Tuan4.c,42 :: 		TMR0 = 0x00;
	CLRF       TMR0+0
;Baitap1_Tuan4.c,44 :: 		lcd_init();
	CALL       _lcd_init+0
;Baitap1_Tuan4.c,46 :: 		inline1();
	CALL       _inline1+0
;Baitap1_Tuan4.c,48 :: 		while(1)
L_main0:
;Baitap1_Tuan4.c,50 :: 		count = (int)(TMR0);
	MOVF       TMR0+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	MOVF       R1+0, 0
	MOVWF      _count+0
	MOVF       R1+1, 0
	MOVWF      _count+1
;Baitap1_Tuan4.c,51 :: 		if ( count > 14 )
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main7
	MOVF       R1+0, 0
	SUBLW      14
L__main7:
	BTFSC      STATUS+0, 0
	GOTO       L_main2
;Baitap1_Tuan4.c,53 :: 		TMR0 = 0x00;
	CLRF       TMR0+0
;Baitap1_Tuan4.c,54 :: 		count = 0;
	CLRF       _count+0
	CLRF       _count+1
;Baitap1_Tuan4.c,55 :: 		}
	GOTO       L_main3
L_main2:
;Baitap1_Tuan4.c,58 :: 		inline2();
	CALL       _inline2+0
;Baitap1_Tuan4.c,59 :: 		}
L_main3:
;Baitap1_Tuan4.c,60 :: 		}
	GOTO       L_main0
;Baitap1_Tuan4.c,61 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
