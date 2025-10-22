#define _XTAL_FREQ 8000000
unsigned char seg7[10] =  {
  0x3F, // '0'
  0x06, // '1'
  0x5B, // '2'
  0x4F, // '3'
  0x66, // '4'
  0x6D, // '5'
  0x7D, // '6'
  0x07, // '7'
  0x7F, // '8'
  0x6F  // '9'
};
unsigned char digit[4] = { 0, 0 ,0 ,0 };

void IO_init(void)
{
	ANSEL = 0;
	ANS10_BIT = 1;
	TRISA = 0;

	TRISB1_BIT = 1;
	TRISD = 0;
}

void ADC_init(void)
{
	//ADCON0
	CHS3_BIT = 1;
	CHS2_BIT = 0;
	CHS1_BIT = 1;
	CHS0_BIT = 0;

	ADCS0_BIT = 0;
	ADCS1_BIT = 0;

	nGO/DONE_BIT = 0;
	ADON = 1;

	//ADCON1
	ADCON1 = 0x80;

}

uint16_t ADC_read(void)
{
	delay_ms(20);
	nGO/DONE_BIT = 1;
	while(nGO/DONE_BIT == 1);
	return (uint16_t)(ADRESH << 8 | ADRESL);
}

void LED_init(unsigned int value)
{
 char i;
	voltage = value * 5 / 1023;

 digit[3] = voltage/10/10/10%10;
 digit[2] = voltage/10/10%10;
 digit[1] = voltage/10%10;
 digit[0] = voltage%10!


 for(i = 0; i < 4; i++)
 {
   PORTA = (unsigned char)(0x80 >> i);
   PORTD = digit[i];
   delay_us(20);
 }
 
   


}
void main() {
  IO_init();
  ADC_init();
  while(1)
  {
   value = ADC_read();
   LED_init(value);
  }

}