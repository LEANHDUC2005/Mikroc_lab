volatile unsigned char push_count_LED1 = 0;
volatile unsigned char push_count_LED2 = 0;
volatile unsigned char push_count_LED3 = 0;
volatile unsigned char push_count;
volatile unsigned char temp;
unsigned char segment7_LED[10] = {
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
void interrupt()
{
 if ( RBIF_BIT )
 temp = PORTB;
 RBIF_BIT = 0;
 delay_ms(50);
 
    if ( !RB0_BIT )
    {
      push_count = push_count_LED1;
      push_count_LED1++;
      PORTA = 0x01;
      //PORTD = segment7_LED[push_count_LED1];
    }
    
    else if ( !RB1_BIT )
    {  
      push_count = push_count_LED2;
      push_count_LED2++;
      PORTA = 0x02;
      //PORTD = segment7_LED[push_count_LED2];
    }
    
    else if ( !RB2_BIT )
    {
      push_count = push_count_LED3;
      push_count_LED3++;
      PORTA = 0x04;
      //PORTD = segment7_LED[push_count_LED3];
    }
}

void main() {
  ANSEL = ANSELH = 0;
  TRISA = 0x00;
  TRISD = 0x00;
  TRISB = 0x07;
  
  GIE_BIT = 1;
  RBIE_BIT = 1;
  RBIF_BIT = 0;
  
  NOT_RBPU_BIT = 0;
  WPUB = 0x07;
  IOCB = 0x07;
  INTEDG_BIT = 1;
  

  PORTA = 0x00;
  temp = PORTB;
  
  while(1)
  {
    PORTD = segment7_LED[push_count%10];
  }
}