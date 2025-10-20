#line 1 "D:/mikroC PRO for PIC/Examples/LAB_MikroC/Tuan 5/Tuan5_Bai1/Baitap1_Tuan5.c"
#line 12 "D:/mikroC PRO for PIC/Examples/LAB_MikroC/Tuan 5/Tuan5_Bai1/Baitap1_Tuan5.c"
void IO_init(void)
{
 ANSEL = ANSELH = 0;
}

void PWM1_init(void)
{
 TRISC2_BIT = 1;
 PR2 = 124;


 TMR2IF_BIT = 0;
 T2CKPS0_BIT = 1;
 T2CKPS1_BIT = 0;
 TMR2ON_BIT = 1;

 CCP1CON = 0x0C;
 CCPR1L = (unsigned char)( 375 >> 2 & 0xFF );
 DC1B0_BIT = ( 375 & 0x01 );
 DC1B1_BIT = ( 375 >> 1 & 0x01 );

 while( TMR2IF_BIT == 0 );
 TRISC2_BIT = 0;

}

void PWM2_init(void)
{
 TRISC1_BIT = 1;
 PR2 = 124;

 TMR2IF_BIT = 0;
 T2CKPS0_BIT = 1;
 T2CKPS1_BIT = 0;
 TMR2ON_BIT = 1;

 CCP2CON = 0x0C;
 CCPR2L = (unsigned char)( 125 >> 2 & 0xFF );
 DC2B0_BIT = ( 125 & 0x01 );
 DC2B1_BIT = ( 125 >> 1 & 0x01 );

 while( TMR2IF_BIT == 0 );
 TRISC1_BIT = 0;

}

void main(void)
{
 IO_init();
 PWM1_init();
 PWM2_init();
}
