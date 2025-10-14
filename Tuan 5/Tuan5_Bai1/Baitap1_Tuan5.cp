#line 1 "C:/BTVXL/Tuan 5/Tuan5_Bai1/Baitap1_Tuan5.c"
#line 9 "C:/BTVXL/Tuan 5/Tuan5_Bai1/Baitap1_Tuan5.c"
void ccp1_init()
{
 TRISC2_BIT = 1;
 PR2 = 99;
 CCPR1L = 75;
 CCP1CON = 0x0C;

 DC1B1_BIT = 0;
 DC1B0_BIT = 0;

 TMR2IF_BIT = 0;

 TMR2ON_BIT = 1;
 T2CKPS1_BIT = 0;
 T2CKPS0_BIT = 1;

 while(TMR2IF_BIT == 0);
 TRISC2_BIT = 0;
}

void ccp2_init()
{
 TRISC1_BIT = 1;
 PR2 = 99;
 CCPR2L = 25;
 CCP2CON = 0x0C;

 DC2B1_BIT = 0;
 DC2B0_BIT = 0;

 TMR2IF_BIT = 0;
 TMR2ON_BIT = 1;
 T2CKPS1_BIT = 0;
 T2CKPS0_BIT = 1;

 while(TMR2IF_BIT == 0);
 TRISC1_BIT = 0;
}

void main()
{
 ANSEL = ANSELH = 0;
 ccp1_init();
 ccp2_init();
 while(1);
}
