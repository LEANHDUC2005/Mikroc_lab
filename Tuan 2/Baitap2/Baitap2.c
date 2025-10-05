#include "lcd.h"
 /* Viet chuong trình cho PIC 16F887 hien thi LCD 16x2 len
luoyt 3 noi dung sau (tieng Viet có dau), moi noi dung hien thi
cách nhau 2s, lap lai lien tuc */
const char customchar[] = {0x00, 0x00, 0x0e, 0x11, 0x11, 0x0e, 0x00, 0x04, //oj
                   0x0e, 0x11, 0x0e, 0x11, 0x1f, 0x10, 0x0f, 0x00, // ee
                   0x08, 0x04, 0x0e, 0x01, 0x0f, 0x11, 0x0f, 0x00, //af
                   0x02, 0x01, 0x0e, 0x11, 0x11, 0x11, 0x0e, 0x00, //ow
                   0x04, 0x02, 0x04, 0x0c, 0x04, 0x04, 0x0e, 0x00,  //ir
                   0x02, 0x05, 0x0e, 0x11, 0x11, 0x11, 0x0e, 0x00,  //ows
                   0x99};
                   
int strlen(const char a[])
{
  return sizeof(a)/sizeof(a[0])  - 1;
}
void napkitudacbiet()
{
  char j = 0;
  lcd_put_byte(0, 0x40);
  while( customchar[j] != 0x99 )
  {
    lcd_put_byte(1, customchar[j]);
    j++;
  }
}

// Ho. và tên sinh viên
// MSSV:
const char line00[] = { 0x48, 0x00, 0x76, 0x02, 0x74, 0x01, 0x6E, 0x73, 0x69, 0x6E, 0x68, 0x76, 0x69, 0x01, 0x6E };
const char line01[] = "MSSV:";

// Ngày sinh : mm/yy
// Noi sinh :T?nh (TP)
const char line10_a[] = { 0x4E, 0x67, 0x02, 0x79 };
const char line10_b[] = "sinh :mm/yy";
const char line11[] = { 0x4E, 0x03, 0x69, 0x73, 0x69, 0x6E, 0x68, 0x3A, 0x54, 0x04, 0x6E, 0x68, 0x28, 0x54, 0x50, 0x29};

// HKTT:
// L?p:
const char line20[] = "HKTT:";
const char line21[] = { 0x4C, 0x05, 0x70, 0x3A };

void main() 
{
  unsigned int i;
  ANSEL = ANSELH = 0;
  lcd_init();
  napkitudacbiet();
  lcd_putc('\f');

  while(1){
  // Line 0
  lcd_gotoxy(0,0);
  
  for( i = 0 ; i < 15 ; i++ )
    lcd_putc(line00[i]);

  
  lcd_gotoxy(0,1);
  lcd_puts(line01);
  
  delay_ms(2000);
  lcd_putc('\f');

  // Line 1
  lcd_gotoxy(0,0);
  for( i = 0; i <= 3 ; i++ )
    lcd_putc(line10_a[i]);
    
    
  lcd_gotoxy(5,0);
  lcd_puts(line10_b);

  lcd_gotoxy(0,1);
  for( i = 0; i <= 16 ; i++ )
    lcd_putc(line11[i]);


  delay_ms(2000);
  lcd_putc('\f');

  // Line 2
  
  lcd_gotoxy(0,0);
  lcd_puts(line20);
  
  lcd_gotoxy(0,1);
  
  for ( i = 0 ; i <= 3 ; i++ )
    lcd_putc(line21[i]);
  
  delay_ms(2000);
  lcd_putc('\f');
  }

}