
_sangduoi:

;Baitap3.c,19 :: 		void sangduoi()
;Baitap3.c,21 :: 		for( dem = 0; dem < 8; dem ++ )
	CLRF       _dem+0
L_sangduoi0:
	MOVLW      8
	SUBWF      _dem+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_sangduoi1
;Baitap3.c,23 :: 		PORTD = (unsigned char)( 0x80 >> dem);
	MOVF       _dem+0, 0
	MOVWF      R1+0
	MOVLW      128
	MOVWF      R0+0
	MOVF       R1+0, 0
L__sangduoi25:
	BTFSC      STATUS+0, 2
	GOTO       L__sangduoi26
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__sangduoi25
L__sangduoi26:
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;Baitap3.c,24 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_sangduoi3:
	DECFSZ     R13+0, 1
	GOTO       L_sangduoi3
	DECFSZ     R12+0, 1
	GOTO       L_sangduoi3
	DECFSZ     R11+0, 1
	GOTO       L_sangduoi3
	NOP
	NOP
;Baitap3.c,21 :: 		for( dem = 0; dem < 8; dem ++ )
	INCF       _dem+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _dem+0
;Baitap3.c,26 :: 		}
	GOTO       L_sangduoi0
L_sangduoi1:
;Baitap3.c,27 :: 		}
L_end_sangduoi:
	RETURN
; end of _sangduoi

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Baitap3.c,28 :: 		void interrupt()
;Baitap3.c,31 :: 		RBIF_BIT = 0;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;Baitap3.c,32 :: 		temp = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _temp+0
;Baitap3.c,33 :: 		if ( !RB6_BIT )
	BTFSC      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_interrupt4
;Baitap3.c,35 :: 		while(!RB6_BIT);
L_interrupt5:
	BTFSC      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_interrupt6
	GOTO       L_interrupt5
L_interrupt6:
;Baitap3.c,36 :: 		if ( RB6_BIT == 1)
	BTFSS      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_interrupt7
;Baitap3.c,37 :: 		sangduoi();
	CALL       _sangduoi+0
L_interrupt7:
;Baitap3.c,39 :: 		}
L_interrupt4:
;Baitap3.c,40 :: 		if ( !RB7_BIT )
	BTFSC      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L_interrupt8
;Baitap3.c,42 :: 		while(!RB7_BIT);
L_interrupt9:
	BTFSC      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L_interrupt10
	GOTO       L_interrupt9
L_interrupt10:
;Baitap3.c,43 :: 		if ( RB7_BIT == 1);
	BTFSS      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L_interrupt11
L_interrupt11:
;Baitap3.c,44 :: 		sangduoi();
	CALL       _sangduoi+0
;Baitap3.c,46 :: 		}
L_interrupt8:
;Baitap3.c,48 :: 		}
L_end_interrupt:
L__interrupt28:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_napkitudacbiet:

;Baitap3.c,51 :: 		void napkitudacbiet()
;Baitap3.c,53 :: 		char i = 0;
	CLRF       napkitudacbiet_i_L0+0
;Baitap3.c,54 :: 		lcd_put_byte(0, 0x40);
	CLRF       FARG_lcd_put_byte_a+0
	MOVLW      64
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap3.c,56 :: 		while( kitudacbiet[i] != 0x99 )
L_napkitudacbiet12:
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      153
	BTFSC      STATUS+0, 2
	GOTO       L_napkitudacbiet13
;Baitap3.c,58 :: 		lcd_put_byte(1, kitudacbiet[i]);
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_a+0
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap3.c,59 :: 		i++;
	INCF       napkitudacbiet_i_L0+0, 1
;Baitap3.c,60 :: 		}
	GOTO       L_napkitudacbiet12
L_napkitudacbiet13:
;Baitap3.c,62 :: 		}
L_end_napkitudacbiet:
	RETURN
; end of _napkitudacbiet

_hienthilcd:

;Baitap3.c,64 :: 		void hienthilcd()
;Baitap3.c,67 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap3.c,68 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap3.c,69 :: 		for(i = 0; i < len1; i++) lcd_putc(line1[i]);
	CLRF       hienthilcd_i_L0+0
L_hienthilcd14:
	MOVF       _len1+0, 0
	SUBWF      hienthilcd_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_hienthilcd15
	MOVF       hienthilcd_i_L0+0, 0
	ADDLW      _line1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       hienthilcd_i_L0+0, 1
	GOTO       L_hienthilcd14
L_hienthilcd15:
;Baitap3.c,71 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap3.c,72 :: 		for(i = 0; i< len2 ; i++) lcd_putc(line2[i]);
	CLRF       hienthilcd_i_L0+0
L_hienthilcd17:
	MOVF       _len2+0, 0
	SUBWF      hienthilcd_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_hienthilcd18
	MOVF       hienthilcd_i_L0+0, 0
	ADDLW      _line2+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       hienthilcd_i_L0+0, 1
	GOTO       L_hienthilcd17
L_hienthilcd18:
;Baitap3.c,74 :: 		delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_hienthilcd20:
	DECFSZ     R13+0, 1
	GOTO       L_hienthilcd20
	DECFSZ     R12+0, 1
	GOTO       L_hienthilcd20
	DECFSZ     R11+0, 1
	GOTO       L_hienthilcd20
;Baitap3.c,75 :: 		}
L_end_hienthilcd:
	RETURN
; end of _hienthilcd

_main:

;Baitap3.c,77 :: 		void main() {
;Baitap3.c,78 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap3.c,79 :: 		TRISB = 0xC0;
	MOVLW      192
	MOVWF      TRISB+0
;Baitap3.c,80 :: 		TRISD = 0;
	CLRF       TRISD+0
;Baitap3.c,82 :: 		GIE_BIT = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Baitap3.c,83 :: 		RBIE_BIT = 1;
	BSF        RBIE_bit+0, BitPos(RBIE_bit+0)
;Baitap3.c,84 :: 		RBIF_BIT = 0;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;Baitap3.c,86 :: 		NOT_RBPU_BIT = 0;
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;Baitap3.c,87 :: 		WPUB = 0xC0;
	MOVLW      192
	MOVWF      WPUB+0
;Baitap3.c,88 :: 		IOCB = 0xC0;
	MOVLW      192
	MOVWF      IOCB+0
;Baitap3.c,90 :: 		lcd_init();
	CALL       _lcd_init+0
;Baitap3.c,91 :: 		napkitudacbiet();
	CALL       _napkitudacbiet+0
;Baitap3.c,92 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;Baitap3.c,93 :: 		temp = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _temp+0
;Baitap3.c,95 :: 		while(1)
L_main21:
;Baitap3.c,97 :: 		hienthilcd();
	CALL       _hienthilcd+0
;Baitap3.c,98 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	DECFSZ     R11+0, 1
	GOTO       L_main23
	NOP
	NOP
;Baitap3.c,99 :: 		}
	GOTO       L_main21
;Baitap3.c,100 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
