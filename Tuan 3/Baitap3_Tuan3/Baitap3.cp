#line 1 "C:/BTVXL/Tuan 3/Baitap3_Tuan3/Baitap3.c"
#line 1 "c:/btvxl/tuan 3/baitap3_tuan3/lcd.h"
#line 51 "c:/btvxl/tuan 3/baitap3_tuan3/lcd.h"
typedef union _BYTE_VAL
 {
 unsigned char Val;
 struct
 {
 unsigned char b0:1;
 unsigned char b1:1;
 unsigned char b2:1;
 unsigned char b3:1;
 unsigned char b4:1;
 unsigned char b5:1;
 unsigned char b6:1;
 unsigned char b7:1;
 } bits;
 } BYTE_VAL;


 void lcd_init(void);
 unsigned char lcd_busy(void);
 unsigned char lcd_get_byte(unsigned char rs);
 void lcd_put_byte(unsigned char a,unsigned char b);
 void lcd_gotoxy(unsigned char col, unsigned char row);
 void lcd_putc(char c);
 void lcd_puts(const char* s);

 void lcd_ShiftLeft(void);
 void lcd_ShiftRight(void);
 void lcd_MoveRight(unsigned char p);
 void lcd_MoveLeft(unsigned char p);
 void lcd_String_Delay(unsigned char*s,unsigned int dly);
#line 4 "C:/BTVXL/Tuan 3/Baitap3_Tuan3/Baitap3.c"
unsigned char kitudacbiet[] = { 0x08, 0x04, 0x0e, 0x01, 0x0f, 0x11, 0x0f, 0x00,
 14,17,14,1,15,17,15,4,
 0x02, 0x15, 0x0e, 0x01, 0x0f, 0x11, 0x0f, 0x00,
 0x02, 0x04, 0x09, 0x13, 0x12, 0x12, 0x1f, 0x00,
 14,17,14,17,31,16,15,0,
 0x0e, 0x09, 0x09, 0x1d, 0x09, 0x09, 0x0e, 0x00,
 0x99 };

unsigned char line1[] = {0x42, 0x00, 0x69, 0x20, 0x54, 0x01, 0x70, 0x20, 0x4E, 0x67, 0x02, 0x74};
unsigned char line2[] = {0x4C, 0x04, 0x20, 0x41, 0x6E, 0x68, 0x20, 0x05, 0x03, 0x63};
unsigned short len1 = sizeof(line1)/sizeof(line1[0]);
unsigned short len2 = sizeof(line2)/sizeof(line2[0]);
volatile unsigned char dem;

volatile unsigned char temp;
void sangduoi()
{
 for( dem = 0; dem < 8; dem ++ )
 {
 PORTD = (unsigned char)( 0x80 >> dem);
 delay_ms(500);

 }
}
void interrupt()
{

 RBIF_BIT = 0;
 temp = PORTB;
 if ( !RB6_BIT )
 {
 while(!RB6_BIT);
 if ( RB6_BIT == 1)
 sangduoi();

 }
 if ( !RB7_BIT )
 {
 while(!RB7_BIT);
 if ( RB7_BIT == 1);
 sangduoi();

 }

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
 for(i = 0; i < len1; i++) lcd_putc(line1[i]);

 lcd_gotoxy(0,1);
 for(i = 0; i< len2 ; i++) lcd_putc(line2[i]);

 delay_ms(400);
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
 delay_ms(500);
 }
}
