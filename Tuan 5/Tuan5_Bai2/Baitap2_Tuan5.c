/*
 Nhấn-nhả SW1: tạo xung PWM tại chân CCP1 có tần số xung fPWM
= xKHz ( với
x=số đứng vị trí thứ 3 từ trái qua phải của mssv của sinh viên), chu kỳ nhiệm vụ
D = 30%, fosc = 8MHz, chuông kêu, LCD hiển thị nội dung:
f=xKHz
D=30%

 Nhấn-nhả SW2: tạo xung PWM tại chân CCP1 có tần số xung fPWM
= xKHz như
câu a, chu kỳ nhiệm vụ D = 80%, fosc = 8MHz, chuông kêu, LCD hiển thị nội dung
f=xKHz
D=80%

 Nhấn-nhả SW3: Dừng phát xung PWM, tắt chuông, LCD hiển thị nội dung như
sau(có dấu tiếng Việt):
 Cho nhận xét về âm thanh của chuông ở yêu cầu 1 và 2.
Tên sinh viên
Học tốt nhé!

YÊU CẦU BUỔI HỌC
 Mỗi sinh viên tự vẽ mạch mô phỏng, viết code-> chạy
mô phỏng trên phần mềm Proteus-> nạp mô hình
VXL đúng yêu cầu bài toán:
(hiển thị đầy đủ tần số và dạng sóng của xung PWM):
1.Bài tập 1 : 5đ
2.Bài tập 2 : 5đ
pesudocode:
function main(void):
  IO_init()
  napkitu_LCD()
  LCD_init()
  while(1):
    if ( RB0 == 0 ) trangthai = 1
    if ( RB1 == 0 ) trangthai = 2
    if ( RB2 == 0 ) trangthai = 3
    switch ( trangthai ):
        case 1:
          PWM_init(3KHz, 30%)
          LCD_1()
          break
        case 2:
          PWM_init(3KHz, 80%)
          LCD_2()
          break
        case 3:
          PWM_init(0,0)
          LCD_3()
          break
        default:
          TRISC = 1

function I0_init(void):
  ANSEL = ANSELH = 0;
  TRISB = 0x07;
  TRISC = 0XFF;

function PW1_init(PR2, Duty_REG):
  TRISC2 = 1
  PR2 = PR2;

  TMR2IF = 0
  T2CKPS[1:0] = 0b01
  TMR2ON = 1

  CCP1CON = 0x0C;
  CCPR1L = (Duty_REG >> 2 & 0xFF)
  DC1B1 = (Duty_REG >> 1 & 0x01)
  DC1B0 = (Duty_REG & 0x01)

  while( TMR2IF == 0 )
  TRISC2 = 0

function napkitu_LCD(void):
  char i = 0
  LCD_put_byte(0, 0x40)
  while( kitudacbiet[i] != 0x99 ):
     LCD_put_byte(1, kitudacbiet[i] )
     i++

function LCD_1():
function LCD_2():
function LCD_3():

code:
*/

#define _XTAL_FREQ 8000000
#include "lcd.h"


unsigned char kitudacbiet[] = { 0,0,25,26,4,11,19,0, //%
                       14,17,14,17,31,16,15,0, //ee
                       14,9,9,29,9,9,14,0, //DD
                       4,9,19,18,18,18,12,0, //uws
                       0,14,17,17,17,14,4,0, //oj
                       1,14,18,12,18,18,12,0, //oos
                       2,4,14,17,31,16,15,0, //es
                       0x99};
unsigned char line1b[] = { 0x44, 0x3D, 0x33, 0x30, 0x25 }; //5
unsigned char line2b[] = { 0x44, 0x3D, 0x38, 0x30, 0x25 }; //5
unsigned char line3a[] = { 0x4C, 0x01, 0x20, 0x41, 0x6E, 0x68, 0x20, 0x02, 0x03, 0x63 }; //10
unsigned char line3b[] = { 0x48, 0x04, 0x63, 0x20, 0x74, 0x05, 0x74, 0x20, 0x6E, 0x68, 0x06 }; //11

void IO_init(void)
{
  ANSEL = ANSELH = 0;
  TRISD = 0x07;
  TRISC = 1;
}

void PWM1_init(unsigned int duty_reg)
{
  TRISC2_BIT = 1;

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
unsigned int trangthai_truoc = -1;
unsigned int *select = &PR2;
void main(void)
{
  IO_init();
  lcd_init();
  napkitudacbiet();

  while(1)
  {
    if ( RD0_BIT == 0 )
    {
      delay_ms(50);
      if ( RD0_BIT == 0 ) trangthai = 1;
    }
    if ( RD1_BIT == 0 )
    {
      delay_ms(50);
      if ( RD1_BIT == 0 ) trangthai = 2;
    }
    if ( RD2_BIT == 0 )
    {
      delay_ms(50);
      if ( RD2_BIT == 0 ) trangthai = 3;
    }


    if ( trangthai_truoc != trangthai )
    {
      trangthai_truoc = trangthai;
      switch(trangthai)
      {
      case 1:
        {
          *select = 99;
          PWM1_init(120);
          LCD_1();
          break;
        }
      case 2:
        {
          *select = 99;
          PWM1_init(320);
          LCD_2();
          break;
        }
      case 3:
        {
          PWM1_init(0);
          LCD_3();
          break;
        }
      case 0:
        {
          CCP1CON = 0;
          TMR2ON_BIT = 0;
          TRISC2_BIT = 1;
          lcd_putc('\f');
          break;
        }

      }


    }

  }

}