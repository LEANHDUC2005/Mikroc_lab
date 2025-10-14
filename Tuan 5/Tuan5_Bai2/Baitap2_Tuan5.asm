
_napkitudacbiet:

;Baitap2_Tuan5.c,10 :: 		void napkitudacbiet()
;Baitap2_Tuan5.c,13 :: 		lcd_put_byte(0, 0x40);
	CLRF       FARG_lcd_put_byte_a+0
	MOVLW      64
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap2_Tuan5.c,14 :: 		while( kitudacbiet[i] != 0xFF )
L_napkitudacbiet0:
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      255
	BTFSC      STATUS+0, 2
	GOTO       L_napkitudacbiet1
;Baitap2_Tuan5.c,16 :: 		lcd_put_byte(1, kitudacbiet[i]);
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_a+0
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap2_Tuan5.c,17 :: 		i++;
	INCF       napkitudacbiet_i_L0+0, 1
;Baitap2_Tuan5.c,18 :: 		}
	GOTO       L_napkitudacbiet0
L_napkitudacbiet1:
;Baitap2_Tuan5.c,19 :: 		}
L_end_napkitudacbiet:
	RETURN
; end of _napkitudacbiet

_lcd_sw1:

;Baitap2_Tuan5.c,21 :: 		void lcd_sw1()
;Baitap2_Tuan5.c,24 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap2_Tuan5.c,25 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,26 :: 		lcd_puts(line_1a);
	MOVLW      _line_1a+0
	MOVWF      FARG_lcd_puts_s+0
	MOVLW      hi_addr(_line_1a+0)
	MOVWF      FARG_lcd_puts_s+1
	CALL       _lcd_puts+0
;Baitap2_Tuan5.c,27 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap2_Tuan5.c,28 :: 		for( i = 0; i < 5; i++ ) lcd_putc(line_1b[i]);
	CLRF       lcd_sw1_i_L0+0
L_lcd_sw12:
	MOVLW      5
	SUBWF      lcd_sw1_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_lcd_sw13
	MOVF       lcd_sw1_i_L0+0, 0
	ADDLW      _line_1b+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       lcd_sw1_i_L0+0, 1
	GOTO       L_lcd_sw12
L_lcd_sw13:
;Baitap2_Tuan5.c,29 :: 		}
L_end_lcd_sw1:
	RETURN
; end of _lcd_sw1

_ccp1_sw1_init:

;Baitap2_Tuan5.c,31 :: 		void ccp1_sw1_init() // 3khz, 30$ | PR2: 165 | CCPR1L:CCP1CON<5:4>: 199
;Baitap2_Tuan5.c,33 :: 		TRISC2_BIT = 1; // Cam xuat sung
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,34 :: 		PR2 = 164;
	MOVLW      164
	MOVWF      PR2+0
;Baitap2_Tuan5.c,36 :: 		CCP1CON = 0X0C;
	MOVLW      12
	MOVWF      CCP1CON+0
;Baitap2_Tuan5.c,37 :: 		CCPR1L = 49;
	MOVLW      49
	MOVWF      CCPR1L+0
;Baitap2_Tuan5.c,38 :: 		DC1B1_BIT = 1;
	BSF        DC1B1_bit+0, BitPos(DC1B1_bit+0)
;Baitap2_Tuan5.c,39 :: 		DC1B0_BIT = 1;
	BSF        DC1B0_bit+0, BitPos(DC1B0_bit+0)
;Baitap2_Tuan5.c,41 :: 		TMR2IF_BIT = 0;
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
;Baitap2_Tuan5.c,42 :: 		T2CON = 0X05;
	MOVLW      5
	MOVWF      T2CON+0
;Baitap2_Tuan5.c,43 :: 		while(TMR2IF_BIT == 0);
L_ccp1_sw1_init5:
	BTFSC      TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
	GOTO       L_ccp1_sw1_init6
	GOTO       L_ccp1_sw1_init5
L_ccp1_sw1_init6:
;Baitap2_Tuan5.c,44 :: 		TRISC2_BIT = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,45 :: 		}
L_end_ccp1_sw1_init:
	RETURN
; end of _ccp1_sw1_init

_ccp1_sw2_init:

;Baitap2_Tuan5.c,47 :: 		void ccp1_sw2_init()  // 3khz, 80%  | PR2: 165 | CCPR1L:CCP1CON<5:4>: 532
;Baitap2_Tuan5.c,49 :: 		TRISC2_BIT = 1; // Cam xuat sung
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,50 :: 		PR2 = 164;
	MOVLW      164
	MOVWF      PR2+0
;Baitap2_Tuan5.c,52 :: 		CCP1CON = 0X0C;
	MOVLW      12
	MOVWF      CCP1CON+0
;Baitap2_Tuan5.c,53 :: 		CCPR1L = 133;
	MOVLW      133
	MOVWF      CCPR1L+0
;Baitap2_Tuan5.c,54 :: 		DC1B1_BIT = 0;
	BCF        DC1B1_bit+0, BitPos(DC1B1_bit+0)
;Baitap2_Tuan5.c,55 :: 		DC1B0_BIT = 0;
	BCF        DC1B0_bit+0, BitPos(DC1B0_bit+0)
;Baitap2_Tuan5.c,57 :: 		TMR2IF_BIT = 0;
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
;Baitap2_Tuan5.c,58 :: 		T2CON = 0X05;
	MOVLW      5
	MOVWF      T2CON+0
;Baitap2_Tuan5.c,59 :: 		while(TMR2IF_BIT == 0);
L_ccp1_sw2_init7:
	BTFSC      TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
	GOTO       L_ccp1_sw2_init8
	GOTO       L_ccp1_sw2_init7
L_ccp1_sw2_init8:
;Baitap2_Tuan5.c,60 :: 		TRISC2_BIT = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,61 :: 		}
L_end_ccp1_sw2_init:
	RETURN
; end of _ccp1_sw2_init

_ccp1_sw3_init:

;Baitap2_Tuan5.c,63 :: 		void ccp1_sw3_init() // Dung xung
;Baitap2_Tuan5.c,65 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap2_Tuan5.c,66 :: 		CCP1CON = 0;
	CLRF       CCP1CON+0
;Baitap2_Tuan5.c,67 :: 		}
L_end_ccp1_sw3_init:
	RETURN
; end of _ccp1_sw3_init

_main:

;Baitap2_Tuan5.c,71 :: 		void main()
;Baitap2_Tuan5.c,73 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap2_Tuan5.c,74 :: 		TRISD = 1;
	MOVLW      1
	MOVWF      TRISD+0
;Baitap2_Tuan5.c,75 :: 		while(1)
L_main9:
;Baitap2_Tuan5.c,79 :: 		lcd_sw1();
	CALL       _lcd_sw1+0
;Baitap2_Tuan5.c,80 :: 		ccp1_sw1_init();
	CALL       _ccp1_sw1_init+0
;Baitap2_Tuan5.c,94 :: 		}
L_main12:
;Baitap2_Tuan5.c,95 :: 		}
	GOTO       L_main9
;Baitap2_Tuan5.c,97 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
