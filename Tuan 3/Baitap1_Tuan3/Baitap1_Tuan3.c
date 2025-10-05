static unsigned char push_count;
volatile unsigned char temp;
unsigned char seven_LED[10] = {
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
   if( INTF_BIT )
   {
     temp = PORTB;
     push_count++;
     INTF_BIT = 0;
   }
}
void main () 
{
  ANSEL = ANSELH = 0;
  TRISD = 0;
  TRISA = 0;
  PORTA = 0x01;
  
  TRISB = 0x01;
  NOT_RBPU_BIT = 0;
  WPUB = 0x01;

  GIE_BIT = 1;
  INTE_BIT = 1;
  
  INTF_BIT = 0;
  INTEDG_BIT = 1;

  push_count = 0;
  temp = PORTB;
  while(1)
  {
    PORTD = seven_LED[push_count%10];
  }
}