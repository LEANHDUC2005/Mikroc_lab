#line 1 "D:/mikroC PRO for PIC/Examples/LAB_MikroC/Tuan 4/Baitap4_Tuan4/Baitap4_Tuan4.c"
#line 1 "d:/mikroc pro for pic/examples/lab_mikroc/tuan 4/baitap4_tuan4/lcd.h"
#line 51 "d:/mikroc pro for pic/examples/lab_mikroc/tuan 4/baitap4_tuan4/lcd.h"
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
#line 4 "D:/mikroC PRO for PIC/Examples/LAB_MikroC/Tuan 4/Baitap4_Tuan4/Baitap4_Tuan4.c"
unsigned char kitudacbiet[] = { 4,17,14,17,31,16,14,0,
 14,9,9,29,9,9,14,0,
 2,4,1,19,18,18,12,0,
 0x99};

unsigned char line1[] = { 0x4C, 0x00, 0x20, 0x41, 0x6E, 0x68, 0x20, 0x01, 0x02, 0x63 };
unsigned char len_line1 = sizeof(line1)/sizeof(line1[0]);

void delaytimer1_50us(unsigned int n)
{
 while(--n)
 {
 TMR1H = 0xFF;
 TMR1L = 0xE7;
 TMR1IF_BIT = 0;
 while(TMR1IF_BIT);
 }
}

void delaytimer1_150us()
{
 delaytimer1_50us(3);
}

void delaytimer1_350us()
{
 delaytimer1_50us(7);
}

void napkitudacbiet()
{
 char i;
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
 for( i = 0; i < len_line1; i++ )
 {
 lcd_putc( line1[i] );
 }
 lcd_gotoxy(0,1);
 lcd_puts("Pulse f=2KHz");
}

void main()
{
 ANSEL = ANSELH = 0;
 TRISD0_BIT = 0;

 TMR1ON_BIT = 1;
 TMR1CS_BIT = 1;
 T1SYNC_BIT = 1;
 T1CKPS1_BIT = 1;
 T1CKPS0_BIT = 0;
 GIE_BIT = PEIE_BIT = TMR1IE_BIT = 0;

 TMR1IF_BIT = 0;

 lcd_init();
 napkitudacbiet();
 hienthilcd();
 while(1)
 {
 RD0_BIT = 0;
 delaytimer1_350us();
 RD0_BIT = 1;
 delaytimer1_150us();
 }

}
