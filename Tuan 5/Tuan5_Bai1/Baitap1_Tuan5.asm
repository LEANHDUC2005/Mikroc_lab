
_ccp1_init:

;Baitap1_Tuan5.c,9 :: 		void ccp1_init()   // 75%
;Baitap1_Tuan5.c,11 :: 		TRISC2_BIT = 1;
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap1_Tuan5.c,12 :: 		PR2 =  99;
	MOVLW      99
	MOVWF      PR2+0
;Baitap1_Tuan5.c,13 :: 		CCPR1L =  75;
	MOVLW      75
	MOVWF      CCPR1L+0
;Baitap1_Tuan5.c,14 :: 		CCP1CON = 0x0C;
	MOVLW      12
	MOVWF      CCP1CON+0
;Baitap1_Tuan5.c,16 :: 		DC1B1_BIT = 0;
	BCF        DC1B1_bit+0, BitPos(DC1B1_bit+0)
;Baitap1_Tuan5.c,17 :: 		DC1B0_BIT = 0;
	BCF        DC1B0_bit+0, BitPos(DC1B0_bit+0)
;Baitap1_Tuan5.c,19 :: 		TMR2IF_BIT = 0;
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
;Baitap1_Tuan5.c,21 :: 		TMR2ON_BIT = 1;
	BSF        TMR2ON_bit+0, BitPos(TMR2ON_bit+0)
;Baitap1_Tuan5.c,22 :: 		T2CKPS1_BIT = 0;
	BCF        T2CKPS1_bit+0, BitPos(T2CKPS1_bit+0)
;Baitap1_Tuan5.c,23 :: 		T2CKPS0_BIT = 1;
	BSF        T2CKPS0_bit+0, BitPos(T2CKPS0_bit+0)
;Baitap1_Tuan5.c,25 :: 		while(TMR2IF_BIT == 0);
L_ccp1_init0:
	BTFSC      TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
	GOTO       L_ccp1_init1
	GOTO       L_ccp1_init0
L_ccp1_init1:
;Baitap1_Tuan5.c,26 :: 		TRISC2_BIT = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Baitap1_Tuan5.c,27 :: 		}
L_end_ccp1_init:
	RETURN
; end of _ccp1_init

_ccp2_init:

;Baitap1_Tuan5.c,29 :: 		void ccp2_init()  // 25%
;Baitap1_Tuan5.c,31 :: 		TRISC1_BIT = 1;
	BSF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
;Baitap1_Tuan5.c,32 :: 		PR2 = 99;
	MOVLW      99
	MOVWF      PR2+0
;Baitap1_Tuan5.c,33 :: 		CCPR2L = 25;
	MOVLW      25
	MOVWF      CCPR2L+0
;Baitap1_Tuan5.c,34 :: 		CCP2CON = 0x0C;
	MOVLW      12
	MOVWF      CCP2CON+0
;Baitap1_Tuan5.c,36 :: 		DC2B1_BIT = 0;
	BCF        DC2B1_bit+0, BitPos(DC2B1_bit+0)
;Baitap1_Tuan5.c,37 :: 		DC2B0_BIT = 0;
	BCF        DC2B0_bit+0, BitPos(DC2B0_bit+0)
;Baitap1_Tuan5.c,39 :: 		TMR2IF_BIT = 0;
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
;Baitap1_Tuan5.c,40 :: 		TMR2ON_BIT = 1;
	BSF        TMR2ON_bit+0, BitPos(TMR2ON_bit+0)
;Baitap1_Tuan5.c,41 :: 		T2CKPS1_BIT = 0;
	BCF        T2CKPS1_bit+0, BitPos(T2CKPS1_bit+0)
;Baitap1_Tuan5.c,42 :: 		T2CKPS0_BIT = 1;
	BSF        T2CKPS0_bit+0, BitPos(T2CKPS0_bit+0)
;Baitap1_Tuan5.c,44 :: 		while(TMR2IF_BIT == 0);
L_ccp2_init2:
	BTFSC      TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
	GOTO       L_ccp2_init3
	GOTO       L_ccp2_init2
L_ccp2_init3:
;Baitap1_Tuan5.c,45 :: 		TRISC1_BIT = 0;
	BCF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
;Baitap1_Tuan5.c,46 :: 		}
L_end_ccp2_init:
	RETURN
; end of _ccp2_init

_main:

;Baitap1_Tuan5.c,48 :: 		void main()
;Baitap1_Tuan5.c,50 :: 		ANSEL = ANSELH = 0;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;Baitap1_Tuan5.c,51 :: 		ccp1_init();
	CALL       _ccp1_init+0
;Baitap1_Tuan5.c,52 :: 		ccp2_init();
	CALL       _ccp2_init+0
;Baitap1_Tuan5.c,53 :: 		while(1);
L_main4:
	GOTO       L_main4
;Baitap1_Tuan5.c,54 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
