
_printline1:

;Baitap2_Tuan4_1_.c,16 :: 		void printline1()
;Baitap2_Tuan4_1_.c,18 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan4_1_.c,19 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan4_1_.c,20 :: 		lcd_puts("DUC Counter 1");
	MOVLW      ?lstr_1_Baitap2_Tuan4_1_+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_1_Baitap2_Tuan4_1_+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap2_Tuan4_1_.c,21 :: 		}
L_end_printline1:
	RETURN
; end of _printline1

_printline2:

;Baitap2_Tuan4_1_.c,22 :: 		void printline2()
;Baitap2_Tuan4_1_.c,24 :: 		lcd_gotoxy(6,1);
	MOVLW      6
	MOVWF      FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan4_1_.c,25 :: 		lcd_putc(lcdDigits[count/10]);
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
;Baitap2_Tuan4_1_.c,26 :: 		lcd_putc(lcdDigits[count%10]);
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
;Baitap2_Tuan4_1_.c,27 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_printline20:
	DECFSZ     R13+0, 1
	GOTO       L_printline20
	DECFSZ     R12+0, 1
	GOTO       L_printline20
	DECFSZ     R11+0, 1
	GOTO       L_printline20
	NOP
	NOP
;Baitap2_Tuan4_1_.c,28 :: 		}
L_end_printline2:
	RETURN
; end of _printline2

_main:

;Baitap2_Tuan4_1_.c,31 :: 		void main()
;Baitap2_Tuan4_1_.c,33 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap2_Tuan4_1_.c,34 :: 		TRISC0_BIT = 1;  // T1CKI  = RC0 | Input
	BSF        TRISC0_bit+0, BitPos(TRISC0_bit+0)
;Baitap2_Tuan4_1_.c,35 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;Baitap2_Tuan4_1_.c,38 :: 		TMR1ON_BIT = 1;  // Bat TIMER1
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;Baitap2_Tuan4_1_.c,39 :: 		TMR1CS_BIT = 1;  // Che do counter
	BSF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;Baitap2_Tuan4_1_.c,40 :: 		T1SYNC_BIT = 0;  // Dong bo xung ck
	BCF        T1SYNC_bit+0, BitPos(T1SYNC_bit+0)
;Baitap2_Tuan4_1_.c,41 :: 		T1CKPS0_BIT = 0; // Ty le 1:1
	BCF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;Baitap2_Tuan4_1_.c,42 :: 		T1CKPS1_BIT = 0;
	BCF        T1CKPS1_bit+0, BitPos(T1CKPS1_bit+0)
;Baitap2_Tuan4_1_.c,43 :: 		T1OSCEN_BIT = 0; // Tat Bo dao dong phu : 32.768Hz
	BCF        T1OSCEN_bit+0, BitPos(T1OSCEN_bit+0)
;Baitap2_Tuan4_1_.c,45 :: 		GIE_BIT = PEIE_BIT = TMR1IE_BIT = 0;       // Tat interrupt
	BCF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
	BTFSC      TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
	GOTO       L__main8
	BCF        PEIE_bit+0, BitPos(PEIE_bit+0)
	GOTO       L__main9
L__main8:
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
L__main9:
	BTFSC      PEIE_bit+0, BitPos(PEIE_bit+0)
	GOTO       L__main10
	BCF        GIE_bit+0, BitPos(GIE_bit+0)
	GOTO       L__main11
L__main10:
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
L__main11:
;Baitap2_Tuan4_1_.c,48 :: 		TMR1H = 0x00;
	CLRF       TMR1H+0
;Baitap2_Tuan4_1_.c,49 :: 		TMR1L = 0x00;
	CLRF       TMR1L+0
;Baitap2_Tuan4_1_.c,50 :: 		TMR1IF_BIT = 0;
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;Baitap2_Tuan4_1_.c,52 :: 		RC0_BIT = 1;
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
;Baitap2_Tuan4_1_.c,55 :: 		lcd_init();
	CALL       _lcd_init+0
;Baitap2_Tuan4_1_.c,56 :: 		printline1();
	CALL       _printline1+0
;Baitap2_Tuan4_1_.c,58 :: 		while(1)
L_main1:
;Baitap2_Tuan4_1_.c,60 :: 		if ( !RC0_BIT )   // Kiem tra SW nhan
	BTFSC      RC0_bit+0, BitPos(RC0_bit+0)
	GOTO       L_main3
;Baitap2_Tuan4_1_.c,62 :: 		count = (int)(TMR1L);
	MOVF       TMR1L+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	MOVF       R1+0, 0
	MOVWF      _count+0
	MOVF       R1+1, 0
	MOVWF      _count+1
;Baitap2_Tuan4_1_.c,63 :: 		if ( count > 12 )
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main12
	MOVF       R1+0, 0
	SUBLW      12
L__main12:
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;Baitap2_Tuan4_1_.c,65 :: 		TMR1L = 0x00;
	CLRF       TMR1L+0
;Baitap2_Tuan4_1_.c,66 :: 		count = 0;
	CLRF       _count+0
	CLRF       _count+1
;Baitap2_Tuan4_1_.c,67 :: 		}
L_main4:
;Baitap2_Tuan4_1_.c,68 :: 		printline2();
	CALL       _printline2+0
;Baitap2_Tuan4_1_.c,69 :: 		}
L_main3:
;Baitap2_Tuan4_1_.c,70 :: 		}
	GOTO       L_main1
;Baitap2_Tuan4_1_.c,72 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
