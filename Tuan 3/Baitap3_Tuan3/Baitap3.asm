
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Baitap3.c,21 :: 		void interrupt()
;Baitap3.c,23 :: 		if ( RBIF_BIT )
	BTFSS      RBIF_bit+0, BitPos(RBIF_bit+0)
	GOTO       L_interrupt0
;Baitap3.c,25 :: 		temp = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _temp+0
;Baitap3.c,26 :: 		RBIF_BIT = 0;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;Baitap3.c,27 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_interrupt1:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt1
	DECFSZ     R12+0, 1
	GOTO       L_interrupt1
	NOP
	NOP
;Baitap3.c,29 :: 		if ( !RB6_BIT || !RB7_BIT )
	BTFSS      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L__interrupt20
	BTFSS      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L__interrupt20
	GOTO       L_interrupt4
L__interrupt20:
;Baitap3.c,31 :: 		for(dem = 0; dem < 8 ; dem++)
	CLRF       _dem+0
L_interrupt5:
	MOVLW      8
	SUBWF      _dem+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt6
;Baitap3.c,33 :: 		PORTD = (unsigned char)( 0x80 >> dem );
	MOVF       _dem+0, 0
	MOVWF      R1+0
	MOVLW      128
	MOVWF      R0+0
	MOVF       R1+0, 0
L__interrupt23:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt24
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__interrupt23
L__interrupt24:
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;Baitap3.c,34 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_interrupt8:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt8
	DECFSZ     R12+0, 1
	GOTO       L_interrupt8
	DECFSZ     R11+0, 1
	GOTO       L_interrupt8
	NOP
;Baitap3.c,31 :: 		for(dem = 0; dem < 8 ; dem++)
	INCF       _dem+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _dem+0
;Baitap3.c,35 :: 		}
	GOTO       L_interrupt5
L_interrupt6:
;Baitap3.c,37 :: 		}
L_interrupt4:
;Baitap3.c,41 :: 		}
L_interrupt0:
;Baitap3.c,43 :: 		}
L_end_interrupt:
L__interrupt22:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_napkitudacbiet:

;Baitap3.c,59 :: 		void napkitudacbiet()
;Baitap3.c,61 :: 		char i = 0;
	CLRF       napkitudacbiet_i_L0+0
;Baitap3.c,62 :: 		lcd_put_byte(0, 0x40);
	CLRF       FARG_lcd_put_byte_a+0
	MOVLW      64
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap3.c,64 :: 		while( kitudacbiet[i] != 0x99 )
L_napkitudacbiet9:
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      153
	BTFSC      STATUS+0, 2
	GOTO       L_napkitudacbiet10
;Baitap3.c,66 :: 		lcd_put_byte(1, kitudacbiet[i]);
	MOVLW      1
	MOVWF      FARG_lcd_put_byte_a+0
	MOVF       napkitudacbiet_i_L0+0, 0
	ADDLW      _kitudacbiet+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_put_byte_b+0
	CALL       _lcd_put_byte+0
;Baitap3.c,67 :: 		i++;
	INCF       napkitudacbiet_i_L0+0, 1
;Baitap3.c,68 :: 		}
	GOTO       L_napkitudacbiet9
L_napkitudacbiet10:
;Baitap3.c,70 :: 		}
L_end_napkitudacbiet:
	RETURN
; end of _napkitudacbiet

_hienthilcd:

;Baitap3.c,72 :: 		void hienthilcd()
;Baitap3.c,75 :: 		lcd_gotoxy(0,0);
	CLRF       FARG_lcd_gotoxy_col+0
	CLRF       FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap3.c,76 :: 		for(i = 0; i < len1; i++) lcd_putc(line1[i]);
	CLRF       hienthilcd_i_L0+0
L_hienthilcd11:
	MOVF       _len1+0, 0
	SUBWF      hienthilcd_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_hienthilcd12
	MOVF       hienthilcd_i_L0+0, 0
	ADDLW      _line1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       hienthilcd_i_L0+0, 1
	GOTO       L_hienthilcd11
L_hienthilcd12:
;Baitap3.c,78 :: 		lcd_gotoxy(0,1);
	CLRF       FARG_lcd_gotoxy_col+0
	MOVLW      1
	MOVWF      FARG_lcd_gotoxy_row+0
	CALL       _lcd_gotoxy+0
;Baitap3.c,79 :: 		for(i = 0; i< len2 ; i++) lcd_putc(line2[i]);
	CLRF       hienthilcd_i_L0+0
L_hienthilcd14:
	MOVF       _len2+0, 0
	SUBWF      hienthilcd_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_hienthilcd15
	MOVF       hienthilcd_i_L0+0, 0
	ADDLW      _line2+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
	INCF       hienthilcd_i_L0+0, 1
	GOTO       L_hienthilcd14
L_hienthilcd15:
;Baitap3.c,81 :: 		delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_hienthilcd17:
	DECFSZ     R13+0, 1
	GOTO       L_hienthilcd17
	DECFSZ     R12+0, 1
	GOTO       L_hienthilcd17
	DECFSZ     R11+0, 1
	GOTO       L_hienthilcd17
;Baitap3.c,82 :: 		lcd_putc('\f');
	MOVLW      12
	MOVWF      FARG_lcd_putc_c+0
	CALL       _lcd_putc+0
;Baitap3.c,83 :: 		}
L_end_hienthilcd:
	RETURN
; end of _hienthilcd

_main:

;Baitap3.c,85 :: 		void main() {
;Baitap3.c,86 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap3.c,87 :: 		TRISB = 0xC0;
	MOVLW      192
	MOVWF      TRISB+0
;Baitap3.c,88 :: 		TRISD = 0;
	CLRF       TRISD+0
;Baitap3.c,90 :: 		GIE_BIT = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Baitap3.c,91 :: 		RBIE_BIT = 1;
	BSF        RBIE_bit+0, BitPos(RBIE_bit+0)
;Baitap3.c,92 :: 		RBIF_BIT = 0;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;Baitap3.c,94 :: 		NOT_RBPU_BIT = 0;
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;Baitap3.c,95 :: 		WPUB = 0xC0;
	MOVLW      192
	MOVWF      WPUB+0
;Baitap3.c,96 :: 		IOCB = 0xC0;
	MOVLW      192
	MOVWF      IOCB+0
;Baitap3.c,98 :: 		lcd_init();
	CALL       _lcd_init+0
;Baitap3.c,99 :: 		napkitudacbiet();
	CALL       _napkitudacbiet+0
;Baitap3.c,100 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;Baitap3.c,101 :: 		temp = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _temp+0
;Baitap3.c,103 :: 		while(1)
L_main18:
;Baitap3.c,105 :: 		hienthilcd();
	CALL       _hienthilcd+0
;Baitap3.c,106 :: 		}
	GOTO       L_main18
;Baitap3.c,107 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
