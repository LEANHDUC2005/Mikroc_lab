
_delaytimer1_50us:

;Baitap4_Tuan4.c,12 :: 		void delaytimer1_50us(unsigned int n)
;Baitap4_Tuan4.c,14 :: 		while(--n)
L_delaytimer1_50us0:
	MOVLW      1
	SUBWF      FARG_delaytimer1_50us_n+0, 1
	BTFSS      STATUS+0, 0
	DECF       FARG_delaytimer1_50us_n+1, 1
	MOVF       FARG_delaytimer1_50us_n+0, 0
	IORWF      FARG_delaytimer1_50us_n+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_delaytimer1_50us1
;Baitap4_Tuan4.c,16 :: 		TMR1H = 0xFF;
	MOVLW      255
	MOVWF      TMR1H+0
;Baitap4_Tuan4.c,17 :: 		TMR1L = 0xE7;
	MOVLW      231
	MOVWF      TMR1L+0
;Baitap4_Tuan4.c,18 :: 		TMR1IF_BIT = 0;
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;Baitap4_Tuan4.c,19 :: 		while(TMR1IF_BIT);
L_delaytimer1_50us2:
	BTFSS      TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	GOTO       L_delaytimer1_50us3
	GOTO       L_delaytimer1_50us2
L_delaytimer1_50us3:
;Baitap4_Tuan4.c,20 :: 		}
	GOTO       L_delaytimer1_50us0
L_delaytimer1_50us1:
;Baitap4_Tuan4.c,21 :: 		}
L_end_delaytimer1_50us:
	RETURN
; end of _delaytimer1_50us

_delaytimer1_150us:

;Baitap4_Tuan4.c,23 :: 		void delaytimer1_150us()
;Baitap4_Tuan4.c,25 :: 		delaytimer1_50us(3);
	MOVLW      3
	MOVWF      FARG_delaytimer1_50us_n+0
	MOVLW      0
	MOVWF      FARG_delaytimer1_50us_n+1
	CALL       _delaytimer1_50us+0
;Baitap4_Tuan4.c,26 :: 		}
L_end_delaytimer1_150us:
	RETURN
; end of _delaytimer1_150us

_delaytimer1_350us:

;Baitap4_Tuan4.c,28 :: 		void delaytimer1_350us()
;Baitap4_Tuan4.c,30 :: 		delaytimer1_50us(7);
	MOVLW      7
	MOVWF      FARG_delaytimer1_50us_n+0
	MOVLW      0
	MOVWF      FARG_delaytimer1_50us_n+1
	CALL       _delaytimer1_50us+0
;Baitap4_Tuan4.c,31 :: 		}
L_end_delaytimer1_350us:
	RETURN
; end of _delaytimer1_350us

_napkitudacbiet:

;Baitap4_Tuan4.c,33 :: 		void napkitudacbiet()
;Baitap4_Tuan4.c,36 :: 		lcd_put_byte(0, 0x40);
	CLRF       FARG_lcd_put_byte_a+0
	MOVLW      64
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap4_Tuan4.c,37 :: 		while( kitudacbiet[i] != 0x99 )
L_napkitudacbiet4:
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      153
	BTFSC      STATUS+0, 2
	GOTO       L_napkitudacbiet5
;Baitap4_Tuan4.c,39 :: 		lcd_put_byte(1, kitudacbiet[i]);
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_a+0
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap4_Tuan4.c,40 :: 		i++;
	INCF       napkitudacbiet_i_L0+0, 1
;Baitap4_Tuan4.c,41 :: 		}
	GOTO       L_napkitudacbiet4
L_napkitudacbiet5:
;Baitap4_Tuan4.c,43 :: 		}
L_end_napkitudacbiet:
	RETURN
; end of _napkitudacbiet

_hienthilcd:

;Baitap4_Tuan4.c,45 :: 		void hienthilcd()
;Baitap4_Tuan4.c,48 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap4_Tuan4.c,49 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap4_Tuan4.c,50 :: 		for( i = 0; i < len_line1; i++ )
	CLRF       hienthilcd_i_L0+0
L_hienthilcd6:
	MOVF       _len_line1+0, 0
	SUBWF      hienthilcd_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_hienthilcd7
;Baitap4_Tuan4.c,52 :: 		lcd_putc( line1[i] );
	MOVF       hienthilcd_i_L0+0, 0
	ADDLW      _line1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap4_Tuan4.c,50 :: 		for( i = 0; i < len_line1; i++ )
	INCF       hienthilcd_i_L0+0, 1
;Baitap4_Tuan4.c,53 :: 		}
	GOTO       L_hienthilcd6
L_hienthilcd7:
;Baitap4_Tuan4.c,54 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap4_Tuan4.c,55 :: 		lcd_puts("Pulse f=2KHz");
	MOVLW      ?lstr_1_Baitap4_Tuan4+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_1_Baitap4_Tuan4+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap4_Tuan4.c,56 :: 		}
L_end_hienthilcd:
	RETURN
; end of _hienthilcd

_main:

;Baitap4_Tuan4.c,58 :: 		void main()
;Baitap4_Tuan4.c,60 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap4_Tuan4.c,61 :: 		TRISD0_BIT = 0;
	BCF        TRISD0_bit+0, BitPos(TRISD0_bit+0)
;Baitap4_Tuan4.c,63 :: 		TMR1ON_BIT = 1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;Baitap4_Tuan4.c,64 :: 		TMR1CS_BIT = 1;
	BSF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;Baitap4_Tuan4.c,65 :: 		T1SYNC_BIT = 1;
	BSF        T1SYNC_bit+0, BitPos(T1SYNC_bit+0)
;Baitap4_Tuan4.c,66 :: 		T1CKPS1_BIT = 1;
	BSF        T1CKPS1_bit+0, BitPos(T1CKPS1_bit+0)
;Baitap4_Tuan4.c,67 :: 		T1CKPS0_BIT = 0;
	BCF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;Baitap4_Tuan4.c,68 :: 		GIE_BIT = PEIE_BIT = TMR1IE_BIT = 0;
	BCF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
	BTFSC      TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
	GOTO       L__main17
	BCF        PEIE_bit+0, BitPos(PEIE_bit+0)
	GOTO       L__main18
L__main17:
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
L__main18:
	BTFSC      PEIE_bit+0, BitPos(PEIE_bit+0)
	GOTO       L__main19
	BCF        GIE_bit+0, BitPos(GIE_bit+0)
	GOTO       L__main20
L__main19:
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
L__main20:
;Baitap4_Tuan4.c,70 :: 		TMR1IF_BIT = 0;
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;Baitap4_Tuan4.c,72 :: 		lcd_init();
	CALL       _lcd_init+0
;Baitap4_Tuan4.c,73 :: 		napkitudacbiet();
	CALL       _napkitudacbiet+0
;Baitap4_Tuan4.c,74 :: 		hienthilcd();
	CALL       _hienthilcd+0
;Baitap4_Tuan4.c,75 :: 		while(1)
L_main9:
;Baitap4_Tuan4.c,77 :: 		RD0_BIT = 0;
	BCF        RD0_bit+0, BitPos(RD0_bit+0)
;Baitap4_Tuan4.c,78 :: 		delaytimer1_350us();
	CALL       _delaytimer1_350us+0
;Baitap4_Tuan4.c,79 :: 		RD0_BIT = 1;
	BSF        RD0_bit+0, BitPos(RD0_bit+0)
;Baitap4_Tuan4.c,80 :: 		delaytimer1_150us();
	CALL       _delaytimer1_150us+0
;Baitap4_Tuan4.c,81 :: 		}
	GOTO       L_main9
;Baitap4_Tuan4.c,83 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
