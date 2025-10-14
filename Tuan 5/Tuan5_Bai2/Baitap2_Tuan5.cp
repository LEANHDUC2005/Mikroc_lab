#line 1 "C:/BTVXL/Tuan 5/Tuan5_Bai2/Baitap2_Tuan5.c"
#line 1 "c:/btvxl/tuan 5/tuan5_bai2/lcd.h"
#line 51 "c:/btvxl/tuan 5/tuan5_bai2/lcd.h"
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
#line 2 "C:/BTVXL/Tuan 5/Tuan5_Bai2/Baitap2_Tuan5.c"
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

void ccp1_sw1_init()
{
 TRISC2_BIT = 1;
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

void ccp1_sw2_init()
{
 TRISC2_BIT = 1;
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

void ccp1_sw3_init()
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

 }
 else if ( RD1 == 0 )
 {

 ccp1_sw2_init();

 }
 else if ( RD2 == 0 )
 {

 ccp1_sw3_init();

 }
 }

}
