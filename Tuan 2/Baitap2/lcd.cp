#line 1 "C:/BTVXL/Tuan 2/Baitap2/lcd.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdlib.h"







 typedef struct divstruct {
 int quot;
 int rem;
 } div_t;

 typedef struct ldivstruct {
 long quot;
 long rem;
 } ldiv_t;

 typedef struct uldivstruct {
 unsigned long quot;
 unsigned long rem;
 } uldiv_t;

int abs(int a);
float atof(char * s);
int atoi(char * s);
long atol(char * s);
div_t div(int number, int denom);
ldiv_t ldiv(long number, long denom);
uldiv_t uldiv(unsigned long number, unsigned long denom);
long labs(long x);
int max(int a, int b);
int min(int a, int b);
void srand(unsigned x);
int rand();
int xtoi(char * s);
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/ctype.h"





unsigned short islower(char character);
unsigned short isupper(char character);
unsigned short isalpha(char character);
unsigned short iscntrl(char character);
unsigned short isdigit(char character);
unsigned short isalnum(char character);
unsigned short isspace(char character);
unsigned short ispunct(char character);
unsigned short isgraph(char character);
unsigned short isxdigit(char character);
unsigned short tolower(char character);
unsigned short toupper(char character);
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
#line 18 "C:/BTVXL/Tuan 2/Baitap2/lcd.c"
unsigned char lcd_busy()
{

unsigned char busy;


  TRISB0_bit  = 1;
  TRISB1_bit  = 1;
  TRISB2_bit  = 1;
  TRISB3_bit  = 1;


  RB4_bit  = 0;
 delay_us(20);
  RB5_bit  = 1;
 delay_us(20);

 busy =  RB3_bit ;

  RB5_bit  = 0;
 delay_us(20);
  RB5_bit  = 1;
 delay_us(20);
  RB5_bit  = 0;

 return busy;
}








unsigned char lcd_get_byte(unsigned char rs)
{

 BYTE_VAL b;


  TRISB0_bit  = 1;
  TRISB1_bit  = 1;
  TRISB2_bit  = 1;
  TRISB3_bit  = 1;



 if(rs)
  RB4_bit  = 1;
 else
  RB4_bit  = 0;
 delay_us(20);

  RB5_bit  = 1;
 delay_us(20);

 b.bits.b7 =  RB3_bit ;
 b.bits.b6 =  RB2_bit ;
 b.bits.b5 =  RB1_bit ;
 b.bits.b4 =  RB0_bit ;

  RB5_bit  = 0;
 delay_us(20);

  RB5_bit  = 1;
 delay_us(20);

 b.bits.b3 =  RB3_bit ;
 b.bits.b2 =  RB2_bit ;
 b.bits.b1 =  RB1_bit ;
 b.bits.b0 =  RB0_bit ;

  RB5_bit  = 0;
 delay_us(20);

 return b.Val;
}







void lcd_put_nibble(unsigned char b)
{

 BYTE_VAL temp;


  TRISB0_bit  = 0;
  TRISB1_bit  = 0;
  TRISB2_bit  = 0;
  TRISB3_bit  = 0;

 temp.Val = b;

  RB0_bit  = temp.bits.b0;
  RB1_bit  = temp.bits.b1;
  RB2_bit  = temp.bits.b2;
  RB3_bit  = temp.bits.b3;

 delay_us(20);
  RB5_bit  = 1;
 delay_us(20);
  RB5_bit  = 0;
}








void lcd_put_byte(unsigned char rs, unsigned char b)
{



  TRISB0_bit  = 0;
  TRISB1_bit  = 0;
  TRISB2_bit  = 0;
  TRISB3_bit  = 0;

 if(rs)
  RB4_bit  = 1;
 else
  RB4_bit  = 0;
 delay_us(20);


 delay_us(20);

  RB5_bit  = 0;

 lcd_put_nibble(b >> 4);

 lcd_put_nibble(b & 0xf);
}








void lcd_gotoxy(unsigned char col, unsigned char row)
{

 unsigned char address;


 if(row!=0)
 address=0x40;
 else
 address=0;

 address += col;

 lcd_put_byte(0,0x80|address);

}







void lcd_putc(char c)
{



 switch(c)
 {
 case '\f':
 lcd_put_byte(0,1);
 delay_ms(5);
 break;
 case '\n':
 lcd_gotoxy(0,1);
 break;
 case '\b':
 lcd_put_byte(0,0x10);
 delay_ms(5);
 break;
 default:

 {
 lcd_put_byte(1,c);
 delay_ms(5);
 }

 }
}







void lcd_puts(const char* s)
{



 while(*s)
 {
 lcd_putc(*s++);
 }
}







void lcd_init()
{

unsigned char i;


  TRISB5_bit  = 0;
  TRISB4_bit  = 0;

  TRISB0_bit  = 0;
  TRISB1_bit  = 0;
  TRISB2_bit  = 0;
  TRISB3_bit  = 0;

 delay_ms(15);

  RB4_bit  = 0;

  RB5_bit  = 0;

 lcd_put_nibble(3);
 delay_ms(10);
 lcd_put_nibble(3);
 delay_ms(10);
 lcd_put_nibble(3);
 delay_ms(10);

 lcd_put_nibble(2);
 delay_ms(1);

 lcd_put_byte(0, 0b00101100  &  0b00111000 );
 delay_ms(1);

 lcd_put_byte(0, 0b00001111  &  0b00001101  &  0b00001110 );
 delay_ms(1);

 lcd_put_byte(0,0x01);
 delay_ms(1);

 lcd_put_byte(0, 0b00000110 );
 delay_ms(1);
}







void lcd_ShiftLeft(void)
{



 lcd_put_byte(0,0x18);
}







void lcd_ShiftRight(void)
{



 lcd_put_byte(0,0x1C);
}







void lcd_MoveRight(unsigned char p)
{

unsigned char i;


 for(i=0;i<p;i++)
 {
 lcd_ShiftRight();
 delay_ms(100);
 }
}







void lcd_MoveLeft(unsigned char p)
{

unsigned char i;


 for(i=0;i<p;i++)
 {
 lcd_ShiftLeft();
 delay_ms(100);
 }
}







void lcd_String_Delay(unsigned char*s)
 {



 while(*s!=0)
 {
 lcd_putc(*s++);
 delay_ms(1);
 }
}





void putch(char c)
{
 lcd_putc(c);
}
