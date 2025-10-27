#line 1 "D:/mikroC PRO for PIC/Examples/LAB_MikroC/Tong_hop/BaitapTongHop.c"

float temperture = 0.0;
volatile unsigned char trangthai = 0;
volatile unsigned char trangthai_truoc = 0;
unsigned int duty = 0;
unsigned int value = 0;

volatile unsigned char temp;
void interrupt(void)
{
 if ( RBIF_BIT && RBIE_BIT )
 {
 temp = PORTB;
 RBIF_BIT = 0;
 delay_us(20);
 if ( !RB5_BIT )
 {
 delay_ms(20);
 if ( !RB5_BIT ) trangthai = 1;
 }
 else if ( !RB6_BIT )
 {
 delay_ms(20);
 if ( !RB6_BIT ) trangthai = 2;
 }
 else if ( !RB7_BIT )
 {
 delay_ms(20);
 if ( !RB7_BIT ) trangthai = 3;
 }
 }
}

void IO_init(void)
{
 ANSEL = ANSELH = 0;
 TRISB = 0b11100000;
 TRISE = 0x03;

 ANS5_BIT = 1;
 ANS6_BIT = 1;

 TRISD = 0;
 TRISC = 0;
}

void ISR_B_init(void)
{
 GIE_BIT = 1;
 PEIE_BIT = 0;
 INTE_BIT = 0;

 NOT_RBPU_BIT = 0;
 WPUB = 0b11100000;

 RBIE_BIT = 1;
 RBIF_BIT = 0;
}

void Timer0_init(void)
{
 TMR0 = 0;

 TMR0IE_BIT = 0;
 TMR0IF_BIT = 0;

 PSA_BIT = 0;
 PS2_BIT = 0;
 PS1_BIT = 0;
 PS0_BIT = 0;
}
void ADC_init(void)
{
 ADCS1_BIT = 1;
 ADCS0_BIT = 0;

 CHS3_BIT = 0;
 CHS2_BIT = 1;
 CHS1_BIT = 1;
 CHS0_BIT = 0;

 GO_DONE_BIT = 0;
 ADON_BIT = 1;

 ADCON1 = 0x80;
}

unsigned int ADC_read(void)
{
 delay_us(50);
 GO_DONE_BIT = 1;
 while( GO_DONE_BIT == 1 );
 return (unsigned int)(ADRESH << 8 | ADRESL);
}

void PWM_CCP1_init(unsigned int pr2)
{
 TRISC2_BIT = 1;

 PR2 = pr2;

 T2CKPS1_BIT = 0;
 T2CKPS0_BIT = 1;

 TMR2ON_BIT = 0;
 TMR2IF_BIT = 0;

 CCP1CON = 0x0C;
 while( TMR2IF_BIT == 0 )
 TRISC2_BIT = 0;
}

void PWM_CCP1_getduty(unsigned int value)
{
 if ( value > 1023 ) value = 1023;
 duty = (unsigned int)( value * ( PR2 + 1 )/ 1023 );
 CCPR1L = (unsigned char)(duty << 2);
 DC1B0_BIT = (unsigned char)(duty & 0x01);
 DC1B1_BIT = (unsigned char)(duty >> 1 & 0x01);
}

void LED_on_SW1(unsigned int value)
{
 char i;
 temperture = (float)( value * 500.0 + 200.0 )/1230.0;

 PORTD = (unsigned char)temperture;
 for(i=0; i<4; i++)
 {
 PORTB = (unsigned char)(0x01 << i);
 PORTC = (unsigned char)((int)temperture%10 << 3);
 temperture = temperture/10;
 delay_ms(100);
 }
}



void main()
{
 IO_init();
 ADC_init();
 ISR_B_init();
 temp = PORTB;
 while(1)
 {
 switch(trangthai)
 {
 case 1:
 {
 value = ADC_read();
 LED_on_SW1(value);
 break;

 }

 case 2:
 {
 value = ADC_read();
 PWM_CCP1_init(249);
 PWM_CCP1_getduty(value);
 break;
 }
 case 3:
 {
 char i;
 Timer0_init();
 if ( TMR0IF_BIT )
 {
 TMR0IF_BIT = 0;
 TMR0 = 0;
 }
 for(i=0; i<3; i++)
 {
 PORTB = (unsigned char)(0x01 >> i);
 PORTC = (unsigned char)(TMR0%10 << 3);
 }
 break;

 }
 }

 }
 return;

}
