#line 1 "D:/mikroC PRO for PIC/Examples/LAB_MikroC/Tuan 4/Baitap2_Tuan4/Baitap2_Tuan4.c"
#line 1 "d:/mikroc pro for pic/examples/lab_mikroc/tuan 4/baitap2_tuan4/lcd.h"
#line 51 "d:/mikroc pro for pic/examples/lab_mikroc/tuan 4/baitap2_tuan4/lcd.h"
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
#line 2 "D:/mikroC PRO for PIC/Examples/LAB_MikroC/Tuan 4/Baitap2_Tuan4/Baitap2_Tuan4.c"
unsigned char lcdDigits[10] = {
 0x30,
 0x31,
 0x32,
 0x33,
 0x34,
 0x35,
 0x36,
 0x37,
 0x38,
 0x39
};
unsigned int count = 0;
void printline1()
{
 lcd_putc('\f');
 lcd_gotoxy(0,0);
 lcd_puts("DUC Counter 1");
}
void printline2()
{
 lcd_gotoxy(6,1);
 lcd_putc(lcdDigits[count/10]);
 lcd_putc(lcdDigits[count%10]);
}

unsigned char prev_state = 1;
unsigned char curr_state;

void main()
{
 ANSEL = ANSELH = 0;
 TRISC = 0x01;
 TRISD = 0x00;


 TMR1ON_BIT = 1;
 TMR1CS_BIT = 1;
 T1SYNC_BIT = 1;
 T1CKPS0_BIT = 0;
 T1CKPS1_BIT = 0;
 T1OSCEN_BIT = 1;


 TMR1H = 0x00;
 TMR1L = 0x00;


 lcd_init();
 printline1();



 while(1)
 {
 if ( !RC0_BIT )
 {
 count = (int)(TMR1L);
 if ( count > 12 )
 {
 TMR1L = 0x00;
 count = 0;
 }
 printline2();
 }
 }

}
