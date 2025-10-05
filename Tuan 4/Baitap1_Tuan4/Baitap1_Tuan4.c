#include "lcd.h"
// Ten hien thi : DUC Counter 0
// xx : gia tri bien dem ( 00 - 14 )
unsigned char chuso[10] = {
    '0',  // 0x30
    '1',  // 0x31
    '2',  // 0x32
    '3',  // 0x33
    '4',  // 0x34
    '5',  // 0x35
    '6',  // 0x36
    '7',  // 0x37
    '8',  // 0x38
    '9'   // 0x39
};

unsigned int count = 0;
void inline1()
{
   lcd_putc('\f');
   lcd_gotoxy(0,0);
   lcd_puts("DUC Counter 0");
}
void inline2()
{
   lcd_gotoxy(6,1);
   lcd_putc(chuso[count/10]);
   lcd_putc(chuso[count%10]);
}

void main() 
{
   ANSEL = ANSELH = 0;
   TRISA4_BIT = 1;
   TRISD = 0x00;

   T0CS_BIT = 1;
   T0SE_BIT = 1;
   
   PSA_BIT = 1;
   
   TMR0 = 0x00;
   
   lcd_init();
   
   inline1();
   
   while(1)
   {
     count = (int)(TMR0);
     if ( count > 14 )
     {
       TMR0 = 0x00;
       count = 0;
     }
     else
     {
       inline2();
     }
   }
}
   
   
   
   
   
   
   
   
   


