#line 1 "D:/mikroC PRO for PIC/Examples/LAB_MikroC/Tuan 4/Baitap1_Tuan4/Baitap1_Tuan4.c"
#line 1 "d:/mikroc pro for pic/examples/lab_mikroc/tuan 4/baitap1_tuan4/lcd.h"
#line 51 "d:/mikroc pro for pic/examples/lab_mikroc/tuan 4/baitap1_tuan4/lcd.h"
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
#line 4 "D:/mikroC PRO for PIC/Examples/LAB_MikroC/Tuan 4/Baitap1_Tuan4/Baitap1_Tuan4.c"
unsigned char chuso[10] = {
 '0',
 '1',
 '2',
 '3',
 '4',
 '5',
 '6',
 '7',
 '8',
 '9'
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
