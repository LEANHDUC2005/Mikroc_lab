#include "lcd.h"
char kitudacbiet[] = {0,0,25,26,4,11,19,0,0xFF};

const char line_1a[] = "f=3KHz";
char line_1b[] = { 0x44, 0x3D, 0x33, 0x30, 0x00 };

const char line_2a[] = "f=3Khz";
char line1_b[] = { 0x44, 0x3D, 0x33, 0x80, 0x00 };

void napkitudacbiet()
{
  char i;
  lcd_put_byte(0, 0x40);
  while( kitudacbiet[i] != 0xFF )
  {
    lcd_put_byte(1, kitudacbiet[i]);
    i++;
   }
}

void lcd_sw1()
{
  char i;
  lcd_putc('\f');
  lcd_gotoxy(0,0);
  lcd_puts(line_1a);
  lcd_gotoxy(0,1);
  for( i = 0; i < 5; i++ ) lcd_putc(line_1b[i]);
}

void ccp1_sw1_init() // 3khz, 30$ | PR2: 165 | CCPR1L:CCP1CON<5:4>: 199
{
  TRISC2_BIT = 1; // Cam xuat sung
  PR2 = 164;
  
  CCP1CON = 0X0C;
  CCPR1L = 49;
  DC1B1_BIT = 1;
  DC1B0_BIT = 1;
  
  TMR2IF_BIT = 0;
  T2CON = 0X05;
  while(TMR2IF_BIT == 0);
  TRISC2_BIT = 0;
}

void ccp1_sw2_init()  // 3khz, 80%  | PR2: 165 | CCPR1L:CCP1CON<5:4>: 532
{
  TRISC2_BIT = 1; // Cam xuat sung
  PR2 = 164;

  CCP1CON = 0X0C;
  CCPR1L = 133;
  DC1B1_BIT = 0;
  DC1B0_BIT = 0;

  TMR2IF_BIT = 0;
  T2CON = 0X05;
  while(TMR2IF_BIT == 0);
  TRISC2_BIT = 0;
}

void ccp1_sw3_init() // Dung xung
{
  TRISC2_BIT = 1;
  CCP1CON = 0;
}



void main() 
{
  ANSEL = ANSELH = 0;
  TRISD = 1;
  while(1)
  {
    if ( RD0 == 0 )
    {
      lcd_sw1();
      ccp1_sw1_init();
      //while( RD0 == 0 );
    }
    else if ( RD1 == 0 )
    {
      //lcd_sw2();
      ccp1_sw2_init();
      //while( RD1 == 0 );
    }
    else if ( RD2 == 0 )
    {
      //lcd_sw3();
      ccp1_sw3_init();
      //1while( RD2 == 0 );
     }
  }

}