#line 1 "C:/BTVXL/Tuan 2/Baitap1/Baitap1.c"
#line 1 "c:/btvxl/tuan 2/baitap1/lcd.h"
#line 51 "c:/btvxl/tuan 2/baitap1/lcd.h"
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
#line 3 "C:/BTVXL/Tuan 2/Baitap1/Baitap1.c"
void Baitap1()
{
 lcd_gotoxy(0,0);
 lcd_puts("Hovatensinhvien");
 lcd_gotoxy(0,1);
 lcd_puts("MSSV:");

 delay_ms(2000);
 lcd_putc('\f');



 lcd_gotoxy(0,0);
 lcd_puts("Ngay sinh:mm/yy");
 lcd_gotoxy(0,1);
 lcd_puts("Noisinh:Tinh(TP)");

 delay_ms(2000);
 lcd_putc('\f');



 lcd_gotoxy(0,0);
 lcd_puts("HKTT:");
 lcd_gotoxy(0,1);
 lcd_puts("Lop:");

 delay_ms(2000);
 lcd_putc('\f');

}
void main() {
 ANSEL = ANSELH = 0;
 lcd_init();

 lcd_putc('\f');
 while(1)
 {
 Baitap1();
 }
}
