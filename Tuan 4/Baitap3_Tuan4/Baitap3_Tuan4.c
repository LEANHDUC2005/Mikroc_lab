
#include "lcd.h"
//Bai tap TIMER0
//Le Anh Duc
#define _XTAL_FREQ 8000000UL
unsigned char kytudacbiet[] =  { 8,4,14,1,15,17,15,0, //aaf
                           14,17,14,1,15,17,15,4, //aaj
                           14,17,14,17,31,16,15,0, //ee
                           14,9,9,29,9,9,14,0, //DD
                           2,4,1,19,18,18,12,0,
                           0x99}; // uwc
unsigned char line1[] = { 0x42, 0x00, 0x69, 0x20, 0x74, 0x01, 0x70, 0x20, 0x54, 0x49, 0x4D, 0x45, 0x52, 0x30 };
unsigned char line2[] = { 0x4C, 0x02, 0x20, 0x41, 0x6E, 0x68, 0x20, 0x03, 0x04, 0x63 };
// Phan ben tren AE tu customs

// Chieu dai 2 doan LCD
unsigned char len_line1 = sizeof(line1)/sizeof(line1[0]);
unsigned char len_line2 = sizeof(line2)/sizeof(line2[0]);

void napkitudacbiet()
{
   char i = 0;
   lcd_put_byte(0, 0x40);
   while( kytudacbiet[i] != 0x99 )
   {
      lcd_put_byte(1 , kytudacbiet[i]);
      i++;
   }
}


void delaytimer1_100us(unsigned int n)   // delay_us(100)
{
  while(--n)
  {
    TMR0 = 231;
    TMR0IF_BIT = 0; // Che do TIMER
    GIE_BIT = PEIE_BIT = TMR1IE_BIT = 0;  // Tat interrupt
    T0CS_BIT = 0;
    PSA_BIT = 0;
    PS2_BIT = 0;
    PS1_BIT = 1;
    PS0_BIT = 0;
    while(TMR0IF_BIT == 0);  // Cho TMR1IF = 1
  }
}

void delaytimer1_500ms()    //10000s
{
  delaytimer1_100us(5000);
}

void hienthilcd()
{
   char i;
   lcd_putc('\f');
   lcd_gotoxy(0,0);    // in dong 1
   for( i = 0; i < len_line1; i++ ) lcd_putc( line1[i] );
   lcd_gotoxy(0,1);    // in dong 2
   for( i = 0; i < len_line2; i++ ) lcd_putc( line2[i] );
}
void main() 
{
  ANSEL = ANSELH = 0;
  lcd_init();
  napkitudacbiet();
  
  while(1)
  {
    char i;
    for( i = 0 ; i < 3; i++ )
    {
      hienthilcd();
      delaytimer1_500ms();
    }
    for( i = 0 ; i < 2; i++ )
    {
      hienthilcd();
      for(i = 0; i < 16; i++)
      {
         lcd_ShiftRight();
         delaytimer1_500ms();
      }
    }

    for( i = 0 ; i < 2; i++ )
    {
      hienthilcd();
      for(i = 0; i < 16; i++)
      {
         lcd_ShiftLeft();
         delaytimer1_500ms();
      }
    }
  }

}

