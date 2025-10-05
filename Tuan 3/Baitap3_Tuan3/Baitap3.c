#include "lcd.h"
// Bài tập ngắt
// Lê Anh Đức
unsigned char kitudacbiet[] = { 0x08, 0x04, 0x0e, 0x01, 0x0f, 0x11, 0x0f, 0x00, // af� 0x00
                                14,17,14,1,15,17,15,4, // aaj  0x01
                                0x02, 0x15, 0x0e, 0x01, 0x0f, 0x11, 0x0f, 0x00, // aws 0x02
                                0x02, 0x04, 0x09, 0x13, 0x12, 0x12, 0x1f, 0x00, // uws 0x03
                                14,17,14,17,31,16,15,0, // ee 0x04
                                0x0e, 0x09, 0x09, 0x1d, 0x09, 0x09, 0x0e, 0x00, // DD 0x05
                                0x99 };

unsigned char line1[] = {0x42, 0x00, 0x69, 0x20, 0x54, 0x01, 0x70, 0x20, 0x4E, 0x67, 0x02, 0x74};
unsigned char line2[] = {0x4C, 0x04, 0x20, 0x41, 0x6E, 0x68, 0x20, 0x05, 0x03, 0x63};
unsigned short len1 = sizeof(line1)/sizeof(line1[0]);
unsigned short len2 = sizeof(line2)/sizeof(line2[0]);
volatile unsigned char dem;

volatile unsigned char temp;
//volatile unsigned char ISR_count = 0;

void interrupt()
{
    if ( RBIF_BIT )
    {
        temp = PORTB;
        RBIF_BIT = 0;                                                                                               1
        delay_ms(50);
        {
            if ( !RB6_BIT || !RB7_BIT )
            {
               for(dem = 0; dem < 8 ; dem++)
               {
                 PORTD = (unsigned char)( 0x80 >> dem );
                 delay_ms(100);
               }
               
            }
            
        }
        
    }
    
}


/*
void sangduoi()
{
  unsigned char start = 0x80;
  char i;
  for(i = 0; i < 8; i++)
  {
    PORTD = (unsigned char)(start >> i);
    delay_ms(100);
  }
}
*/

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
    lcd_gotoxy(0,0);
    for(i = 0; i < len1; i++) lcd_putc(line1[i]);
    
    lcd_gotoxy(0,1);
    for(i = 0; i< len2 ; i++) lcd_putc(line2[i]);
    
    delay_ms(400);
    lcd_putc('\f');
}

void main() {
    ANSEL = ANSELH = 0;
    TRISB = 0xC0;
    TRISD = 0;

    GIE_BIT = 1;
    RBIE_BIT = 1;
    RBIF_BIT = 0;

    NOT_RBPU_BIT = 0;
    WPUB = 0xC0;
    IOCB = 0xC0;  

    lcd_init();
    napkitudacbiet();
    PORTD = 0x00;
    temp = PORTB;
    
    while(1)
    {
        hienthilcd();
    }
}