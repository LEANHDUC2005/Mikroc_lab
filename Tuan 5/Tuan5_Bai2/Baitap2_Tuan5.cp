#line 1 "D:/mikroC PRO for PIC/Examples/LAB_MikroC/Tuan 5/Tuan5_Bai2/Baitap2_Tuan5.c"
#line 1 "d:/mikroc pro for pic/examples/lab_mikroc/tuan 5/tuan5_bai2/lcd.h"
#line 51 "d:/mikroc pro for pic/examples/lab_mikroc/tuan 5/tuan5_bai2/lcd.h"
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
#line 5 "C:/BTVXL/Tuan 5/Tuan5_Bai2/Baitap2_Tuan5.c"
unsigned char kitudacbiet[] = { 0,0,25,26,4,11,19,0,
 14,17,14,17,31,16,15,0,
 14,9,9,29,9,9,14,0,
 4,9,19,18,18,18,12,0,
 0,14,17,17,17,14,4,0,
 1,14,18,12,18,18,12,0,
 2,4,14,17,31,16,15,0,
 0x99};
unsigned char line1b[] = { 0x44, 0x3D, 0x33, 0x30, 0x25 };
unsigned char line2b[] = { 0x44, 0x3D, 0x38, 0x30, 0x25 };
unsigned char line3a[] = { 0x4C, 0x01, 0x20, 0x41, 0x6E, 0x68, 0x20, 0x02, 0x03, 0x63 };
unsigned char line3b[] = { 0x48, 0x04, 0x63, 0x20, 0x74, 0x05, 0x74, 0x20, 0x6E, 0x68, 0x06 };

void IO_init(void)
{
 ANSEL = ANSELH = 0;
 TRISD = 0x07;
 TRISC = 1;
}

void PWM1_init(unsigned int pr2, unsigned int duty_reg)
{
 TRISC2_BIT = 1;
 PR2 = pr2;

 TMR2IF_BIT = 0;
 T2CKPS1_BIT = 0;
 T2CKPS0_BIT = 1;
 TMR2ON_BIT = 1;

 CCP1CON = 0x0C;
 CCPR1L = (unsigned char)(duty_reg >> 2 & 0xFF);
 DC1B1_BIT = (unsigned char)(duty_reg >> 1 & 0x01);
 DC1B0_BIT = (unsigned char)(duty_reg & 0x01);

 while(TMR2IF_BIT == 0);
 TRISC2_BIT = 0;

}

void napkitudacbiet(void)
{
 char i = 0;
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
 lcd_putc('\f');
 delay_us(20);
 lcd_gotoxy(0,0);
 lcd_puts("f=5KHz");
 lcd_gotoxy(0,1);
 for(i = 0; i < 5; i++) lcd_putc( line1b[i] );

}

void LCD_2(void)
{
 char i;
 lcd_putc('\f');
 delay_us(20);
 lcd_gotoxy(0,0);
 lcd_puts("f=5KHz");
 lcd_gotoxy(0,1);
 for(i = 0; i < 5; i++) lcd_putc( line2b[i] );

}

void LCD_3(void)
{
 char i;
 lcd_putc('\f');
 delay_us(20);
 lcd_gotoxy(0,0);
 for(i = 0; i < 10; i++) lcd_putc( line3a[i] );
 lcd_gotoxy(0,1);
 for(i = 0; i < 11; i++) lcd_putc( line3b[i] );

}
unsigned int trangthai = 0;
void main(void)
{
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
 if ( RD1_BIT == 0 )
 {
 delay_ms(10);
 if ( RD1_BIT == 0 ) trangthai = 2;
 }
 if ( RD2_BIT == 0 )
 {
 delay_ms(10);
 if ( RD2_BIT == 0 ) trangthai = 3;
 }

 if ( trangthai == 1 )
 {
 PWM1_init(99,120);
 LCD_1();
 }
 else if( trangthai == 2 )
 {
 PWM1_init(99, 320);
 LCD_2();
 }
 else if( trangthai == 3 )
 {
 PWM1_init(0,0);
 LCD_3();
 }
 else
 {
 CCP1CON = 0;
 TMR2ON_BIT = 0;
 TRISC2_BIT = 1;
 lcd_putc('\f');
 }

 }
 delay_ms(20);
 }
 }

}
