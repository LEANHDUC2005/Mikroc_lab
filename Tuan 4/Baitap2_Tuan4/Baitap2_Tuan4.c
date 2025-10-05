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
unsigned int count = 0;
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
}

unsigned char prev_state = 1;
unsigned char curr_state;

void main()
{
   ANSEL = ANSELH = 0;
   TRISC = 0x01;
   TRISD = 0x00;
   
   // T1CON OPTION
   TMR1ON_BIT = 1;
   TMR1CS_BIT = 1;
   T1SYNC_BIT = 1;
   T1CKPS0_BIT = 0; // Ty le 1:1
   T1CKPS1_BIT = 0;
   T1OSCEN_BIT = 1; // Bo dao dong phu : 32.768Hz
   
   // TIMER1 SETTING
   TMR1H = 0x00;
   TMR1L = 0x00;
   // TMR1IF_BIT = 0;
   
   lcd_init();
   printline1();
   
   // prev_state = 1;
   // curr_state;
   while(1)
   {
     if ( !RC0_BIT )
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