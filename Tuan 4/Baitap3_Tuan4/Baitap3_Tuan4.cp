#line 1 "C:/BTVXL/Tuan 4/Baitap3_Tuan4/Baitap3_Tuan4.c"
#line 1 "c:/btvxl/tuan 4/baitap3_tuan4/lcd.h"
#line 51 "c:/btvxl/tuan 4/baitap3_tuan4/lcd.h"
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
#line 6 "C:/BTVXL/Tuan 4/Baitap3_Tuan4/Baitap3_Tuan4.c"
unsigned char kytudacbiet[] = { 8,4,14,1,15,17,15,0,
 14,17,14,1,15,17,15,4,
 14,17,14,17,31,16,15,0,
 14,9,9,29,9,9,14,0,
 2,4,1,19,18,18,12,0,
 0x99};
unsigned char line1[] = { 0x42, 0x00, 0x69, 0x20, 0x74, 0x01, 0x70, 0x20, 0x54, 0x49, 0x4D, 0x45, 0x52, 0x30 };
unsigned char line2[] = { 0x4C, 0x02, 0x20, 0x41, 0x6E, 0x68, 0x20, 0x03, 0x04, 0x63 };



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


void delaytimer1_100us(unsigned int n)
{
 while(--n)
 {
 TMR0 = 231;
 TMR0IF_BIT = 0;
 GIE_BIT = PEIE_BIT = TMR1IE_BIT = 0;
 T0CS_BIT = 0;
 PSA_BIT = 0;
 PS2_BIT = 0;
 PS1_BIT = 1;
 PS0_BIT = 0;
 while(TMR0IF_BIT == 0);
 }
}

void delaytimer1_500ms()
{
 delaytimer1_100us(5000);
}

void hienthilcd()
{
 char i;
 lcd_putc('\f');
 lcd_gotoxy(0,0);
 for( i = 0; i < len_line1; i++ ) lcd_putc( line1[i] );
 lcd_gotoxy(0,1);
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
