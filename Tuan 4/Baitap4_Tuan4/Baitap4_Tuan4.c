#include "lcd.h"
// Le Anh Duc
// Pulse f=2KHz
// Output : t = 0.5ms = 500us
//          toff = 4ton    ton = 100us   1off = 400us

unsigned char kitudacbiet[] = { 4,17,14,17,31,16,14,0, //e
                                14,9,9,29,9,9,14,0,    //DD
                                2,4,1,19,18,18,12,0,   //uws
                                0x99};
                                
unsigned char line1[] = { 0x4C, 0x00, 0x20, 0x41, 0x6E, 0x68, 0x20, 0x01, 0x02, 0x63 };
unsigned char len_line1 = sizeof(line1)/sizeof(line1[0]);

void delaytimer1_100us(unsigned int n)     // 0.1ms
{
  while(--n)
  {
    TMR1H = 0xFF; // 256
    TMR1L = 0xE7; // 231
    TMR1IF_BIT = 0;
    while(TMR1IF_BIT == 0);   // Cho TMR1IF == 1
  }
}

void delaytimer1_400us()          // 0.4ms
{
  delaytimer1_100us(4);
}

void napkitudacbiet()
{
  char i = 0;
  lcd_put_byte(0, 0x40);
  while( kitudacbiet[i] != 0x99 )
  {
    lcd_put_byte(1, kitudacbiet[i]);
    i++;
  }
  
}

void hienthilcd()
{
  char i;
  lcd_putc('\f');
  lcd_gotoxy(0,0);
  for( i = 0; i < len_line1; i++ )
  {
    lcd_putc( line1[i] );
  }
  lcd_gotoxy(0,1);
  lcd_puts("Pulse f=2KHz");
}
    
void main() 
{
   ANSEL = ANSELH = 0;
   TRISD0_BIT = 0;
   
   TMR1ON_BIT = 1;  // Bat TIMER1
   TMR1CS_BIT = 0;  // Che do TIMER
   T1SYNC_BIT = 1;  // Tat dong bo xung ck
   T1CKPS1_BIT = 0; // Ty le 1:8
   T1CKPS0_BIT = 1;
   GIE_BIT = PEIE_BIT = TMR1IE_BIT = 0;   // Tat interrupt
   
   TMR1IF_BIT = 0;  // Dat co ngat = 0
   
   lcd_init();      // Khoi tao LCD
   napkitudacbiet();
   hienthilcd();
   
   while(1)
   {
     RD0_BIT = 0;
     delaytimer1_100us(1);  // toff
     RD0_BIT = 1;
     delaytimer1_400us();  // ton
   }
   
}