#line 1 "C:/BTVXL/Baikiemtracuoi/LeAnhDuc_23701131.c"
#line 1 "c:/btvxl/baikiemtracuoi/lcd.h"
#line 51 "c:/btvxl/baikiemtracuoi/lcd.h"
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
#line 12 "C:/BTVXL/Baikiemtracuoi/LeAnhDuc_23701131.c"
unsigned char kitudacbiet[] = {
 14,17,14,17,31,16,15,0,
 14,9,9,29,9,9,14,0,
 4,9,19,18,18,18,12,0,
 5,10,17,17,15,1,14,0,
 14,17,14,17,31,17,4,0,
 14,17,14,17,17,14,4,0,
 8,4,14,1,15,17,15,0,
 2,4,14,17,31,16,15,0,

 0x99};
unsigned char line_SW1a[] = { 0x4C, 0x00, 0x20, 0b01000001, 0x6E, 0b01101000, 0x20, 0x01, 0x02, 0b01100011};
unsigned char line_SW1b[] = { 0x4B, 0x03, 0x20, 0x54, 0x48, 0x75, 0x04, 0x74, 0x20, 0x56, 0x58, 0x4C};

unsigned char line_SW3a[] = { 0x4D, 0x05, 0x74, 0x20, 0x6E, 0x67, 0x06, 0x79, 0x20, 0x76, 0x75, 0x69, 0x20, 0x6E, 0x68, 0x07 };
unsigned char line_SW3b[] = { 0x01, 0x02, 0b01100011 };

void IO_init(void)
{
 ANSEL = ANSELH = 0;
 TRISD = 0x07;


}

void PWM_CCP1_init(unsigned int duty)
{
 TRISC2_BIT = 1;


 CCPR1L = (unsigned char)(duty >> 2 & 0xFF);
 DC1B0_BIT = (unsigned char)(duty & 0x01);
 DC1B1_BIT = (unsigned char)(duty >> 1 & 0x01);

 T2CKPS1_BIT = 0;
 T2CKPS0_BIT = 1;

 TMR2ON_BIT = 1;
 TMR2IF_BIT = 0;
 CCP1CON = 0x0C;

 while(TMR2IF_BIT);
 TRISC2_BIT = 0;
}
void napkitudacbiet(void)
{
 char i=0;
 lcd_put_byte(0, 0x40);
 while( kitudacbiet[i] != 0x99 )
 {
 lcd_put_byte(1, kitudacbiet[i]);
 i++;

 }
}

void LCD_1(void)
{
 char i;
 delay_us(10);
 lcd_putc('\f');
 lcd_gotoxy(3,0);
 for(i=0; i<10; i++) lcd_putc(line_SW1a[i]);
 lcd_gotoxy(2,1);
 for(i=0; i<12; i++) lcd_putc(line_SW1b[i]);
}

void LCD_2(void)
{
 delay_us(10);
 lcd_putc('\f');
 lcd_gotoxy(0,0);
 lcd_puts("Pulse CCP1");
 lcd_gotoxy(0,1);
 lcd_puts("f=(3+1)KHz D=80%");
}

void LCD_3(void)
{
 char i;
 delay_us(10);
 lcd_putc('\f');
 lcd_gotoxy(0,0);
 for(i=0; i<16; i++) lcd_putc(line_SW3a[i]);
 lcd_gotoxy(6,1);
 for(i=0; i<3; i++) lcd_putc(line_SW3b[i]);
}
unsigned int *PR2_select = &PR2;
unsigned int trangthai = 0;
unsigned int trangthai_truoc = -1;

void main() {
 IO_init();
 lcd_init();
 napkitudacbiet();
 while(1)
 {
 if ( RD0_BIT == 0 )
 {
 delay_ms(10);
 if ( RD0_BIT == 0 ) trangthai = 1;
 }
 else if ( RD1_BIT == 0 )
 {
 delay_ms(10);
 if ( RD1_BIT == 0 ) trangthai = 2;
 }
 else if ( RD2_BIT == 0 )
 {
 delay_ms(10);
 if ( RD2_BIT == 0 ) trangthai = 3;
 }

 if ( trangthai_truoc != trangthai )
 {
 trangthai_truoc = trangthai;
 if ( trangthai == 1 )
 {
 CCP1CON = 0x00;
 TRISC2_BIT = 1;
 LCD_1();
 }
 else if ( trangthai == 2 )
 {
 *PR2_select = 124;
 PWM_CCP1_init(400);
 LCD_2();
 }
 else if ( trangthai == 3 )
 {
 CCP1CON = 0x00;
 TRISC2_BIT = 1;
 LCD_3();
 }
 }
 }

}
