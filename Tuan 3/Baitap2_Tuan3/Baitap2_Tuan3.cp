#line 1 "C:/BTVXL/Tuan 3/Baitap2_Tuan3/Baitap2_Tuan3.c"
volatile unsigned char push_count_LED1 = 0;
volatile unsigned char push_count_LED2 = 0;
volatile unsigned char push_count_LED3 = 0;
volatile unsigned char push_count;
volatile unsigned char temp;
unsigned char segment7_LED[10] = {
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
 if ( RBIF_BIT )
 temp = PORTB;
 RBIF_BIT = 0;
 delay_ms(50);

 if ( !RB0_BIT )
 {
 push_count = push_count_LED1;
 push_count_LED1++;
 PORTA = 0x01;

 }

 else if ( !RB1_BIT )
 {
 push_count = push_count_LED2;
 push_count_LED2++;
 PORTA = 0x02;

 }

 else if ( !RB2_BIT )
 {
 push_count = push_count_LED3;
 push_count_LED3++;
 PORTA = 0x04;

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
