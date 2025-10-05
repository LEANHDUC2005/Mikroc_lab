#line 1 "C:/BTVXL/Tuan 3/Baitap1_Tuan3/Baitap1_Tuan3.c"
static unsigned char push_count;
volatile unsigned char temp;
unsigned char seven_LED[10] = {
 0x3F,
 0x06,
 0x5B,
 0x4F,
 0x66,
 0x6D,
 0x7D,
 0x07,
 0x7F,
 0x6F
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
