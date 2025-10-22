#line 1 "C:/BTVXL/Tuan 6/Baitap2_Tuan6/Baitap2_Tuan6.c"

unsigned int value = 0;
unsigned char temperture = 0;

void IO_init()
{
 ANSEL = ANSELH = 0;
 TRISD = 0;
 TRISE1_BIT = 1;
 ANS6_BIT = 1;
}

void ADC_init()
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

unsigned int ADC_Read(void)
{
 delay_us(50);
 GO_DONE_BIT = 1;
 while(GO_DONE_BIT == 1);
 return (unsigned int)(ADRESH << 8| ADRESL);

}

void LED_init(unsigned int value)
{
 if ( value > 1023 ) value = 1023;
 temperture = (float)(value * 500.0 + 511.0)/1023.0;
 PORTD = (unsigned char)temperture;
}
void main() {
 IO_init();
 ADC_init();

 while(1)
 {
 value = ADC_Read();
 LED_init(value);

 }

}
