
_printline1:

;Baitap2_Tuan4.c,15 :: 		void printline1()
;Baitap2_Tuan4.c,17 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan4.c,18 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan4.c,19 :: 		lcd_puts("DUC Counter 1");
	MOVLW      ?lstr_1_Baitap2_Tuan4+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_1_Baitap2_Tuan4+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap2_Tuan4.c,20 :: 		}
L_end_printline1:
	RETURN
; end of _printline1

_printline2:

;Baitap2_Tuan4.c,21 :: 		void printline2()
;Baitap2_Tuan4.c,23 :: 		lcd_gotoxy(6,1);
	MOVLW      6
	MOVWF      FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan4.c,24 :: 		lcd_putc(lcdDigits[count/10]);
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
	ADDLW      _lcdDigits+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan4.c,25 :: 		lcd_putc(lcdDigits[count%10]);
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
	ADDLW      _lcdDigits+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan4.c,26 :: 		}
L_end_printline2:
	RETURN
; end of _printline2

_main:

;Baitap2_Tuan4.c,31 :: 		void main()
;Baitap2_Tuan4.c,33 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap2_Tuan4.c,34 :: 		TRISC = 0x01;
	MOVLW      1
	MOVWF      TRISC+0
;Baitap2_Tuan4.c,35 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;Baitap2_Tuan4.c,38 :: 		TMR1ON_BIT = 1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;Baitap2_Tuan4.c,39 :: 		TMR1CS_BIT = 1;
	BSF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;Baitap2_Tuan4.c,40 :: 		T1SYNC_BIT = 1;
	BSF        T1SYNC_bit+0, BitPos(T1SYNC_bit+0)
;Baitap2_Tuan4.c,41 :: 		T1CKPS0_BIT = 0; // Ty le 1:1
	BCF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;Baitap2_Tuan4.c,42 :: 		T1CKPS1_BIT = 0;
	BCF        T1CKPS1_bit+0, BitPos(T1CKPS1_bit+0)
;Baitap2_Tuan4.c,43 :: 		T1OSCEN_BIT = 1; // Bo dao dong phu : 32.768Hz
	BSF        T1OSCEN_bit+0, BitPos(T1OSCEN_bit+0)
;Baitap2_Tuan4.c,46 :: 		TMR1H = 0x00;
	CLRF       TMR1H+0
;Baitap2_Tuan4.c,47 :: 		TMR1L = 0x00;
	CLRF       TMR1L+0
;Baitap2_Tuan4.c,50 :: 		lcd_init();
	CALL       _lcd_init+0
;Baitap2_Tuan4.c,51 :: 		printline1();
	CALL       _printline1+0
;Baitap2_Tuan4.c,55 :: 		while(1)
L_main0:
;Baitap2_Tuan4.c,57 :: 		if ( !RC0_BIT )
	BTFSC      RC0_bit+0, BitPos(RC0_bit+0)
	GOTO       L_main2
;Baitap2_Tuan4.c,59 :: 		count = (int)(TMR1L);
	MOVF       TMR1L+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	MOVF       R1+0, 0
	MOVWF      _count+0
	MOVF       R1+1, 0
	MOVWF      _count+1
;Baitap2_Tuan4.c,60 :: 		if ( count > 12 )
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main7
	MOVF       R1+0, 0
	SUBLW      12
L__main7:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;Baitap2_Tuan4.c,62 :: 		TMR1L = 0x00;
	CLRF       TMR1L+0
;Baitap2_Tuan4.c,63 :: 		count = 0;
	CLRF       _count+0
	CLRF       _count+1
;Baitap2_Tuan4.c,64 :: 		}
L_main3:
;Baitap2_Tuan4.c,65 :: 		printline2();
	CALL       _printline2+0
;Baitap2_Tuan4.c,66 :: 		}
L_main2:
;Baitap2_Tuan4.c,67 :: 		}
	GOTO       L_main0
;Baitap2_Tuan4.c,69 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
