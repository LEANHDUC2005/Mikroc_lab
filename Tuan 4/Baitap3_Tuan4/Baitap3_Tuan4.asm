
_napkitudacbiet:

;Baitap3_Tuan4.c,20 :: 		void napkitudacbiet()
;Baitap3_Tuan4.c,22 :: 		char i = 0;
	CLRF       napkitudacbiet_i_L0+0
;Baitap3_Tuan4.c,23 :: 		lcd_put_byte(0, 0x40);
	CLRF       FARG_lcd_put_byte_a+0
	MOVLW      64
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap3_Tuan4.c,24 :: 		while( kytudacbiet[i] != 0x99 )
L_napkitudacbiet0:
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kytudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      153
	BTFSC      STATUS+0, 2
	GOTO       L_napkitudacbiet1
;Baitap3_Tuan4.c,26 :: 		lcd_put_byte(1 , kytudacbiet[i]);
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_a+0
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kytudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap3_Tuan4.c,27 :: 		i++;
	INCF       napkitudacbiet_i_L0+0, 1
;Baitap3_Tuan4.c,28 :: 		}
	GOTO       L_napkitudacbiet0
L_napkitudacbiet1:
;Baitap3_Tuan4.c,29 :: 		}
L_end_napkitudacbiet:
	RETURN
; end of _napkitudacbiet

_delaytimer1_100us:

;Baitap3_Tuan4.c,32 :: 		void delaytimer1_100us(unsigned int n)   // delay_us(100)
;Baitap3_Tuan4.c,34 :: 		while(--n)
L_delaytimer1_100us2:
	MOVLW      1
	SUBWF      FARG_delaytimer1_100us_n+0, 1
	BTFSS      STATUS+0, 0
	DECF       FARG_delaytimer1_100us_n+1, 1
	MOVF       FARG_delaytimer1_100us_n+0, 0
	IORWF      FARG_delaytimer1_100us_n+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_delaytimer1_100us3
;Baitap3_Tuan4.c,36 :: 		TMR0 = 231;
	MOVLW      231
	MOVWF      TMR0+0
;Baitap3_Tuan4.c,37 :: 		TMR0IF_BIT = 0; // Che do TIMER
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;Baitap3_Tuan4.c,38 :: 		GIE_BIT = PEIE_BIT = TMR1IE_BIT = 0;  // Tat interrupt
	BCF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
	BTFSC      TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
	GOTO       L__delaytimer1_100us31
	BCF        PEIE_bit+0, BitPos(PEIE_bit+0)
	GOTO       L__delaytimer1_100us32
L__delaytimer1_100us31:
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
L__delaytimer1_100us32:
	BTFSC      PEIE_bit+0, BitPos(PEIE_bit+0)
	GOTO       L__delaytimer1_100us33
	BCF        GIE_bit+0, BitPos(GIE_bit+0)
	GOTO       L__delaytimer1_100us34
L__delaytimer1_100us33:
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
L__delaytimer1_100us34:
;Baitap3_Tuan4.c,39 :: 		T0CS_BIT = 0;
	BCF        T0CS_bit+0, BitPos(T0CS_bit+0)
;Baitap3_Tuan4.c,40 :: 		PSA_BIT = 0;
	BCF        PSA_bit+0, BitPos(PSA_bit+0)
;Baitap3_Tuan4.c,41 :: 		PS2_BIT = 0;
	BCF        PS2_bit+0, BitPos(PS2_bit+0)
;Baitap3_Tuan4.c,42 :: 		PS1_BIT = 1;
	BSF        PS1_bit+0, BitPos(PS1_bit+0)
;Baitap3_Tuan4.c,43 :: 		PS0_BIT = 0;
	BCF        PS0_bit+0, BitPos(PS0_bit+0)
;Baitap3_Tuan4.c,44 :: 		while(TMR0IF_BIT == 0);  // Cho TMR1IF = 1
L_delaytimer1_100us4:
	BTFSC      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_delaytimer1_100us5
	GOTO       L_delaytimer1_100us4
L_delaytimer1_100us5:
;Baitap3_Tuan4.c,45 :: 		}
	GOTO       L_delaytimer1_100us2
L_delaytimer1_100us3:
;Baitap3_Tuan4.c,46 :: 		}
L_end_delaytimer1_100us:
	RETURN
; end of _delaytimer1_100us

_delaytimer1_500ms:

;Baitap3_Tuan4.c,48 :: 		void delaytimer1_500ms()    //10000s
;Baitap3_Tuan4.c,50 :: 		delaytimer1_100us(5000);
	MOVLW      136
	MOVWF      FARG_delaytimer1_100us_n+0
	MOVLW      19
	MOVWF      FARG_delaytimer1_100us_n+1
	CALL       _delaytimer1_100us+0
;Baitap3_Tuan4.c,51 :: 		}
L_end_delaytimer1_500ms:
	RETURN
; end of _delaytimer1_500ms

_hienthilcd:

;Baitap3_Tuan4.c,53 :: 		void hienthilcd()
;Baitap3_Tuan4.c,56 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap3_Tuan4.c,57 :: 		lcd_gotoxy(0,0);    // in dong 1
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap3_Tuan4.c,58 :: 		for( i = 0; i < len_line1; i++ ) lcd_putc( line1[i] );
	CLRF       hienthilcd_i_L0+0
L_hienthilcd6:
	MOVF       _len_line1+0, 0
	SUBWF      hienthilcd_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_hienthilcd7
	MOVF       hienthilcd_i_L0+0, 0
	ADDLW      _line1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       hienthilcd_i_L0+0, 1
	GOTO       L_hienthilcd6
L_hienthilcd7:
;Baitap3_Tuan4.c,59 :: 		lcd_gotoxy(0,1);    // in dong 2
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap3_Tuan4.c,60 :: 		for( i = 0; i < len_line2; i++ ) lcd_putc( line2[i] );
	CLRF       hienthilcd_i_L0+0
L_hienthilcd9:
	MOVF       _len_line2+0, 0
	SUBWF      hienthilcd_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_hienthilcd10
	MOVF       hienthilcd_i_L0+0, 0
	ADDLW      _line2+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       hienthilcd_i_L0+0, 1
	GOTO       L_hienthilcd9
L_hienthilcd10:
;Baitap3_Tuan4.c,61 :: 		}
L_end_hienthilcd:
	RETURN
; end of _hienthilcd

_main:

;Baitap3_Tuan4.c,62 :: 		void main()
;Baitap3_Tuan4.c,64 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap3_Tuan4.c,65 :: 		lcd_init();
	CALL       _lcd_init+0
;Baitap3_Tuan4.c,66 :: 		napkitudacbiet();
	CALL       _napkitudacbiet+0
;Baitap3_Tuan4.c,68 :: 		while(1)
L_main12:
;Baitap3_Tuan4.c,71 :: 		for( i = 0 ; i < 3; i++ )
	CLRF       main_i_L1+0
L_main14:
	MOVLW      3
	SUBWF      main_i_L1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main15
;Baitap3_Tuan4.c,73 :: 		hienthilcd();
	CALL       _hienthilcd+0
;Baitap3_Tuan4.c,74 :: 		delaytimer1_500ms();
	CALL       _delaytimer1_500ms+0
;Baitap3_Tuan4.c,71 :: 		for( i = 0 ; i < 3; i++ )
	INCF       main_i_L1+0, 1
;Baitap3_Tuan4.c,75 :: 		}
	GOTO       L_main14
L_main15:
;Baitap3_Tuan4.c,76 :: 		for( i = 0 ; i < 2; i++ )
	CLRF       main_i_L1+0
L_main17:
	MOVLW      2
	SUBWF      main_i_L1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main18
;Baitap3_Tuan4.c,78 :: 		hienthilcd();
	CALL       _hienthilcd+0
;Baitap3_Tuan4.c,79 :: 		for(i = 0; i < 16; i++)
	CLRF       main_i_L1+0
L_main20:
	MOVLW      16
	SUBWF      main_i_L1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;Baitap3_Tuan4.c,81 :: 		lcd_ShiftRight();
	CALL       _lcd_ShiftRight+0
;Baitap3_Tuan4.c,82 :: 		delaytimer1_500ms();
	CALL       _delaytimer1_500ms+0
;Baitap3_Tuan4.c,79 :: 		for(i = 0; i < 16; i++)
	INCF       main_i_L1+0, 1
;Baitap3_Tuan4.c,83 :: 		}
	GOTO       L_main20
L_main21:
;Baitap3_Tuan4.c,76 :: 		for( i = 0 ; i < 2; i++ )
	INCF       main_i_L1+0, 1
;Baitap3_Tuan4.c,84 :: 		}
	GOTO       L_main17
L_main18:
;Baitap3_Tuan4.c,86 :: 		for( i = 0 ; i < 2; i++ )
	CLRF       main_i_L1+0
L_main23:
	MOVLW      2
	SUBWF      main_i_L1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main24
;Baitap3_Tuan4.c,88 :: 		hienthilcd();
	CALL       _hienthilcd+0
;Baitap3_Tuan4.c,89 :: 		for(i = 0; i < 16; i++)
	CLRF       main_i_L1+0
L_main26:
	MOVLW      16
	SUBWF      main_i_L1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main27
;Baitap3_Tuan4.c,91 :: 		lcd_ShiftLeft();
	CALL       _lcd_ShiftLeft+0
;Baitap3_Tuan4.c,92 :: 		delaytimer1_500ms();
	CALL       _delaytimer1_500ms+0
;Baitap3_Tuan4.c,89 :: 		for(i = 0; i < 16; i++)
	INCF       main_i_L1+0, 1
;Baitap3_Tuan4.c,93 :: 		}
	GOTO       L_main26
L_main27:
;Baitap3_Tuan4.c,86 :: 		for( i = 0 ; i < 2; i++ )
	INCF       main_i_L1+0, 1
;Baitap3_Tuan4.c,94 :: 		}
	GOTO       L_main23
L_main24:
;Baitap3_Tuan4.c,95 :: 		}
	GOTO       L_main12
;Baitap3_Tuan4.c,97 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
