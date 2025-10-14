
_delaytimer1_100us:

;Baitap4_Tuan4.c,15 :: 		void delaytimer1_100us(unsigned int n)     // 0.1ms
;Baitap4_Tuan4.c,17 :: 		while(--n)
L_delaytimer1_100us0:
	MOVLW      1
	SUBWF      FARG_delaytimer1_100us_n+0, 1
	BTFSS      STATUS+0, 0
	DECF       FARG_delaytimer1_100us_n+1, 1
	MOVF       FARG_delaytimer1_100us_n+0, 0
	IORWF      FARG_delaytimer1_100us_n+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_delaytimer1_100us1
;Baitap4_Tuan4.c,19 :: 		TMR1H = 0xFF; // 256
	MOVLW      255
	MOVWF      TMR1H+0
;Baitap4_Tuan4.c,20 :: 		TMR1L = 0xE7; // 231
	MOVLW      231
	MOVWF      TMR1L+0
;Baitap4_Tuan4.c,21 :: 		TMR1IF_BIT = 0;
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;Baitap4_Tuan4.c,22 :: 		while(TMR1IF_BIT == 0);   // Cho TMR1IF == 1
L_delaytimer1_100us2:
	BTFSC      TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	GOTO       L_delaytimer1_100us3
	GOTO       L_delaytimer1_100us2
L_delaytimer1_100us3:
;Baitap4_Tuan4.c,23 :: 		}
	GOTO       L_delaytimer1_100us0
L_delaytimer1_100us1:
;Baitap4_Tuan4.c,24 :: 		}
L_end_delaytimer1_100us:
	RETURN
; end of _delaytimer1_100us

_delaytimer1_400us:

;Baitap4_Tuan4.c,26 :: 		void delaytimer1_400us()          // 0.4ms
;Baitap4_Tuan4.c,28 :: 		delaytimer1_100us(4);
	MOVLW      4
	MOVWF      FARG_delaytimer1_100us_n+0
	MOVLW      0
	MOVWF      FARG_delaytimer1_100us_n+1
	CALL       _delaytimer1_100us+0
;Baitap4_Tuan4.c,29 :: 		}
L_end_delaytimer1_400us:
	RETURN
; end of _delaytimer1_400us

_napkitudacbiet:

;Baitap4_Tuan4.c,31 :: 		void napkitudacbiet()
;Baitap4_Tuan4.c,33 :: 		char i = 0;
	CLRF       napkitudacbiet_i_L0+0
;Baitap4_Tuan4.c,34 :: 		lcd_put_byte(0, 0x40);
	CLRF       FARG_lcd_put_byte_a+0
	MOVLW      64
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap4_Tuan4.c,35 :: 		while( kitudacbiet[i] != 0x99 )
L_napkitudacbiet4:
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      153
	BTFSC      STATUS+0, 2
	GOTO       L_napkitudacbiet5
;Baitap4_Tuan4.c,37 :: 		lcd_put_byte(1, kitudacbiet[i]);
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_a+0
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap4_Tuan4.c,38 :: 		i++;
	INCF       napkitudacbiet_i_L0+0, 1
;Baitap4_Tuan4.c,39 :: 		}
	GOTO       L_napkitudacbiet4
L_napkitudacbiet5:
;Baitap4_Tuan4.c,41 :: 		}
L_end_napkitudacbiet:
	RETURN
; end of _napkitudacbiet

_hienthilcd:

;Baitap4_Tuan4.c,43 :: 		void hienthilcd()
;Baitap4_Tuan4.c,46 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap4_Tuan4.c,47 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap4_Tuan4.c,48 :: 		for( i = 0; i < len_line1; i++ )
	CLRF       hienthilcd_i_L0+0
L_hienthilcd6:
	MOVF       _len_line1+0, 0
	SUBWF      hienthilcd_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_hienthilcd7
;Baitap4_Tuan4.c,50 :: 		lcd_putc( line1[i] );
	MOVF       hienthilcd_i_L0+0, 0
	ADDLW      _line1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap4_Tuan4.c,48 :: 		for( i = 0; i < len_line1; i++ )
	INCF       hienthilcd_i_L0+0, 1
;Baitap4_Tuan4.c,51 :: 		}
	GOTO       L_hienthilcd6
L_hienthilcd7:
;Baitap4_Tuan4.c,52 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap4_Tuan4.c,53 :: 		lcd_puts("Pulse f=2KHz");
	MOVLW      ?lstr_1_Baitap4_Tuan4+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(?lstr_1_Baitap4_Tuan4+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap4_Tuan4.c,54 :: 		}
L_end_hienthilcd:
	RETURN
; end of _hienthilcd

_main:

;Baitap4_Tuan4.c,56 :: 		void main()
;Baitap4_Tuan4.c,58 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap4_Tuan4.c,59 :: 		TRISD0_BIT = 0;
	BCF        TRISD0_bit+0, BitPos(TRISD0_bit+0)
;Baitap4_Tuan4.c,61 :: 		TMR1ON_BIT = 1;  // Bat TIMER1
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;Baitap4_Tuan4.c,62 :: 		TMR1CS_BIT = 0;  // Che do TIMER
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;Baitap4_Tuan4.c,63 :: 		T1SYNC_BIT = 1;  // Tat dong bo xung ck
	BSF        T1SYNC_bit+0, BitPos(T1SYNC_bit+0)
;Baitap4_Tuan4.c,64 :: 		T1CKPS1_BIT = 0; // Ty le 1:8
	BCF        T1CKPS1_bit+0, BitPos(T1CKPS1_bit+0)
;Baitap4_Tuan4.c,65 :: 		T1CKPS0_BIT = 1;
	BSF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;Baitap4_Tuan4.c,66 :: 		GIE_BIT = PEIE_BIT = TMR1IE_BIT = 0;   // Tat interrupt
	BCF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
	BTFSC      TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
	GOTO       L__main16
	BCF        PEIE_bit+0, BitPos(PEIE_bit+0)
	GOTO       L__main17
L__main16:
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
L__main17:
	BTFSC      PEIE_bit+0, BitPos(PEIE_bit+0)
	GOTO       L__main18
	BCF        GIE_bit+0, BitPos(GIE_bit+0)
	GOTO       L__main19
L__main18:
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
L__main19:
;Baitap4_Tuan4.c,68 :: 		TMR1IF_BIT = 0;  // Dat co ngat = 0
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;Baitap4_Tuan4.c,70 :: 		lcd_init();      // Khoi tao LCD
	CALL       _lcd_init+0
;Baitap4_Tuan4.c,71 :: 		napkitudacbiet();
	CALL       _napkitudacbiet+0
;Baitap4_Tuan4.c,72 :: 		hienthilcd();
	CALL       _hienthilcd+0
;Baitap4_Tuan4.c,74 :: 		while(1)
L_main9:
;Baitap4_Tuan4.c,76 :: 		RD0_BIT = 0;
	BCF        RD0_bit+0, BitPos(RD0_bit+0)
;Baitap4_Tuan4.c,77 :: 		delaytimer1_100us(1);  // toff
	MOVLW      1
	MOVWF      FARG_delaytimer1_100us_n+0
	MOVLW      0
	MOVWF      FARG_delaytimer1_100us_n+1
	CALL       _delaytimer1_100us+0
;Baitap4_Tuan4.c,78 :: 		RD0_BIT = 1;
	BSF        RD0_bit+0, BitPos(RD0_bit+0)
;Baitap4_Tuan4.c,79 :: 		delaytimer1_400us();  // ton
	CALL       _delaytimer1_400us+0
;Baitap4_Tuan4.c,80 :: 		}
	GOTO       L_main9
;Baitap4_Tuan4.c,82 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
