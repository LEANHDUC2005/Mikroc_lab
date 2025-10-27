#define _XTAL_FREQ 8000000
unsigned int value = 0;
unsigned char temperture = 0;
unsigned char seg7_CC[10] = {
  0x3F, //0
  0x06, //1
  0x5B, //2
  0x4F, //3
  0x66, //4
  0x6D, //5
  0x7D, //6
  0x07, //7
  0x7F, //8
  0x6F  //9
};

void IO_init()
{
        ANSEL = ANSELH = 0;
        TRISD = 0;
        TRISC = 0;
        TRISB = 0;
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
        char i;
        if ( value > 1023 ) value = 1023;
        // 511mV = 0.5V : Giam sai so tai Vin <= 5V
        temperture = (float)(value * 500.0 + 200.0)/1023.0;


        PORTD = (unsigned char)temperture;

        for(i=0; i<4; i++)
        {
                PORTB = (unsigned char)(0x01 << i);
                PORTC = (unsigned char)(seg7_CC[temperture%10]);
                temperture = temperture/10;
                delay_ms(200);
        }
        
        
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