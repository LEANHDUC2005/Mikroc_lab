#include "lcd.h"
unsigned char lcdDigits[10] = {
    0x30, // '0'
    0x31, // '1'
    0x32, // '2'
    0x33, // '3'
    0x34, // '4'
    0x35, // '5'
    0x36, // '6'
    0x37, // '7'
    0x38, // '8'
    0x39  // '9'
};
unsigned int count = 0;  // bien dem

void printline1()
{
   lcd_putc('\f');
   lcd_gotoxy(0,0);
   lcd_puts("DUC Counter 1");
}
void printline2()
{
   lcd_gotoxy(6,1);
   lcd_putc(lcdDigits[count/10]);
   lcd_putc(lcdDigits[count%10]);
   delay_ms(500);
}


void main()
{
   ANSEL = ANSELH = 0;
   TRISC0_BIT = 1;  // T1CKI  = RC0 | Input
   TRISD = 0x00;

   // T1CON OPTION
   TMR1ON_BIT = 1;  // Bat TIMER1
   TMR1CS_BIT = 1;  // Che do counter
   T1SYNC_BIT = 0;  // Dong bo xung ck
   T1CKPS0_BIT = 0; // Ty le 1:1
   T1CKPS1_BIT = 0;
   T1OSCEN_BIT = 0; // Tat Bo dao dong phu : 32.768Hz

   GIE_BIT = PEIE_BIT = TMR1IE_BIT = 0;       // Tat interrupt

   // TIMER1 SETTING
   TMR1H = 0x00;
   TMR1L = 0x00;
   TMR1IF_BIT = 0;

   RC0_BIT = 1;
   
   // In dong 1
   lcd_init();
   printline1();

   while(1)
   {
     if ( !RC0_BIT )   // Kiem tra SW nhan
     {
          count = (int)(TMR1L);
          if ( count > 12 )
          {
            TMR1L = 0x00;
            count = 0;
          }
          printline2();
     }
   }

}