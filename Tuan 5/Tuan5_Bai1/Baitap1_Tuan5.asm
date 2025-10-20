
_IO_init:

;Baitap1_Tuan5.c,12 :: 		void IO_init(void)
;Baitap1_Tuan5.c,14 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap1_Tuan5.c,15 :: 		}
L_end_IO_init:
	RETURN
; end of _IO_init

_PWM1_init:

;Baitap1_Tuan5.c,17 :: 		void PWM1_init(void)
;Baitap1_Tuan5.c,19 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap1_Tuan5.c,20 :: 		PR2 = 124;
	MOVLW      124
	MOVWF      PR2+0
;Baitap1_Tuan5.c,23 :: 		TMR2IF_BIT = 0;
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
;Baitap1_Tuan5.c,24 :: 		T2CKPS0_BIT = 1;
	BSF        T2CKPS0_bit+0, BitPos(T2CKPS0_bit+0)
;Baitap1_Tuan5.c,25 :: 		T2CKPS1_BIT = 0;
	BCF        T2CKPS1_bit+0, BitPos(T2CKPS1_bit+0)
;Baitap1_Tuan5.c,26 :: 		TMR2ON_BIT = 1;
	BSF        TMR2ON_bit+0, BitPos(TMR2ON_bit+0)
;Baitap1_Tuan5.c,28 :: 		CCP1CON = 0x0C;
	MOVLW      12
	MOVWF      CCP1CON+0
;Baitap1_Tuan5.c,29 :: 		CCPR1L = (unsigned char)( 375 >> 2 & 0xFF );
	MOVLW      93
	MOVWF      CCPR1L+0
;Baitap1_Tuan5.c,30 :: 		DC1B0_BIT = ( 375 & 0x01 );
	BSF        DC1B0_bit+0, BitPos(DC1B0_bit+0)
;Baitap1_Tuan5.c,31 :: 		DC1B1_BIT = ( 375 >> 1 & 0x01 );
	BSF        DC1B1_bit+0, BitPos(DC1B1_bit+0)
;Baitap1_Tuan5.c,33 :: 		while( TMR2IF_BIT == 0 );
L_PWM1_init0:
	BTFSC      TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
	GOTO       L_PWM1_init1
	GOTO       L_PWM1_init0
L_PWM1_init1:
;Baitap1_Tuan5.c,34 :: 		TRISC2_BIT = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap1_Tuan5.c,36 :: 		}
L_end_PWM1_init:
	RETURN
; end of _PWM1_init

_PWM2_init:

;Baitap1_Tuan5.c,38 :: 		void PWM2_init(void)
;Baitap1_Tuan5.c,40 :: 		TRISC1_BIT = 1;
	BSF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
;Baitap1_Tuan5.c,41 :: 		PR2 = 124;
	MOVLW      124
	MOVWF      PR2+0
;Baitap1_Tuan5.c,43 :: 		TMR2IF_BIT = 0;
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
;Baitap1_Tuan5.c,44 :: 		T2CKPS0_BIT = 1;
	BSF        T2CKPS0_bit+0, BitPos(T2CKPS0_bit+0)
;Baitap1_Tuan5.c,45 :: 		T2CKPS1_BIT = 0;
	BCF        T2CKPS1_bit+0, BitPos(T2CKPS1_bit+0)
;Baitap1_Tuan5.c,46 :: 		TMR2ON_BIT = 1;
	BSF        TMR2ON_bit+0, BitPos(TMR2ON_bit+0)
;Baitap1_Tuan5.c,48 :: 		CCP2CON = 0x0C;
	MOVLW      12
	MOVWF      CCP2CON+0
;Baitap1_Tuan5.c,49 :: 		CCPR2L = (unsigned char)( 125 >> 2 & 0xFF );
	MOVLW      31
	MOVWF      CCPR2L+0
;Baitap1_Tuan5.c,50 :: 		DC2B0_BIT = ( 125 & 0x01 );
	BSF        DC2B0_bit+0, BitPos(DC2B0_bit+0)
;Baitap1_Tuan5.c,51 :: 		DC2B1_BIT = ( 125 >> 1 & 0x01 );
	BCF        DC2B1_bit+0, BitPos(DC2B1_bit+0)
;Baitap1_Tuan5.c,53 :: 		while( TMR2IF_BIT == 0 );
L_PWM2_init2:
	BTFSC      TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
	GOTO       L_PWM2_init3
	GOTO       L_PWM2_init2
L_PWM2_init3:
;Baitap1_Tuan5.c,54 :: 		TRISC1_BIT = 0;
	BCF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
;Baitap1_Tuan5.c,56 :: 		}
L_end_PWM2_init:
	RETURN
; end of _PWM2_init

_main:

;Baitap1_Tuan5.c,58 :: 		void main(void)
;Baitap1_Tuan5.c,60 :: 		IO_init();
	CALL       _IO_init+0
;Baitap1_Tuan5.c,61 :: 		PWM1_init();
	CALL       _PWM1_init+0
;Baitap1_Tuan5.c,62 :: 		PWM2_init();
	CALL       _PWM2_init+0
;Baitap1_Tuan5.c,63 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
