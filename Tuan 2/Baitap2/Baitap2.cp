#line 1 "C:/BTVXL/Tuan 2/Baitap2/Baitap2.c"
#line 1 "c:/btvxl/tuan 2/baitap2/lcd.h"
#line 51 "c:/btvxl/tuan 2/baitap2/lcd.h"
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
#line 5 "C:/BTVXL/Tuan 2/Baitap2/Baitap2.c"
const char customchar[] = {0x00, 0x00, 0x0e, 0x11, 0x11, 0x0e, 0x00, 0x04,
 0x0e, 0x11, 0x0e, 0x11, 0x1f, 0x10, 0x0f, 0x00,
 0x08, 0x04, 0x0e, 0x01, 0x0f, 0x11, 0x0f, 0x00,
 0x02, 0x01, 0x0e, 0x11, 0x11, 0x11, 0x0e, 0x00,
 0x04, 0x02, 0x04, 0x0c, 0x04, 0x04, 0x0e, 0x00,
 0x02, 0x05, 0x0e, 0x11, 0x11, 0x11, 0x0e, 0x00,
 0x99};

int strlen(const char a[])
{
 return sizeof(a)/sizeof(a[0]) - 1;
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



const char line00[] = { 0x48, 0x00, 0x76, 0x02, 0x74, 0x01, 0x6E, 0x73, 0x69, 0x6E, 0x68, 0x76, 0x69, 0x01, 0x6E };
const char line01[] = "MSSV:";



const char line10_a[] = { 0x4E, 0x67, 0x02, 0x79 };
const char line10_b[] = "sinh :mm/yy";
const char line11[] = { 0x4E, 0x03, 0x69, 0x73, 0x69, 0x6E, 0x68, 0x3A, 0x54, 0x04, 0x6E, 0x68, 0x28, 0x54, 0x50, 0x29};



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

 lcd_gotoxy(0,0);

 for( i = 0 ; i < 15 ; i++ )
 lcd_putc(line00[i]);


 lcd_gotoxy(0,1);
 lcd_puts(line01);

 delay_ms(2000);
 lcd_putc('\f');


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



 lcd_gotoxy(0,0);
 lcd_puts(line20);

 lcd_gotoxy(0,1);

 for ( i = 0 ; i <= 3 ; i++ )
 lcd_putc(line21[i]);

 delay_ms(2000);
 lcd_putc('\f');
 }

}
