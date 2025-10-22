#define _XTAL_FREQ 8000000

// Mã hi?n th? cho LED 7 do?n Cathode chung (CC)
unsigned char seg7_CC[10] = {
  0x3F, // 0
  0x06, // 1
  0x5B, // 2
  0x4F, // 3
  0x66, // 4
  0x6D, // 5
  0x7D, // 6
  0x07, // 7
  0x7F, // 8
  0x6F  // 9
};


unsigned char digit[4];
unsigned int value = 0;
unsigned long voltage = 0;

void IO_init(void)
{
        ANSEL = 0;
        ANSELH = 0b00000100;

        TRISA = 0;

        TRISB1_BIT = 1;
        TRISD = 0;
}

void ADC_init(void)
{
        //ADCON0
        ADCS0_BIT = 0;
        ADCS1_BIT = 1;

        CHS3_BIT = 1;
        CHS2_BIT = 0;
        CHS1_BIT = 1;
        CHS0_BIT = 0;


        GO_DONE_BIT = 0;
        ADON_BIT = 1;

        //ADCON1
        ADCON1 = 0x80;

}

unsigned int ADC_read(void)
{
        delay_us(50);
        GO_DONE_BIT = 1;
        while(GO_DONE_BIT == 1);
        return (unsigned int)(ADRESH << 8 | ADRESL);
}

void LED_init(unsigned int value)
{
 char i;
 voltage = (unsigned long)( (value * 5000UL) / 1023);

 digit[3] = voltage/1000;
 digit[2] = voltage/100%10;
 digit[1] = voltage/10%10;
 digit[0] = voltage%10;


 for(i = 0; i < 4; i++)
 {
   PORTD = seg7_CC[digit[i]];
   PORTA = (unsigned char)((0x01 << i));
   delay_ms(100);
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