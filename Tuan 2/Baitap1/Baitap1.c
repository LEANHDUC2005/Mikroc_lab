#include "lcd.h"

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