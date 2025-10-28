#include "lcd.h"
#define _XTAL_FREQ 8000000
// Le Anh Duc: 23701131
/*
SW1: Lê Anh Đức
     Kỹ Thuật VXL
SW2: Pulse CCP1
     f=(x+1)KHz D=80%   4Khz 
SW3: Một ngày vui nhé
     Lê Anh Đức
*/
unsigned char kitudacbiet[] = { 
                       14,17,14,17,31,16,15,0, //ee
                       14,9,9,29,9,9,14,0, //DD
                       4,9,19,18,18,18,12,0, //uws
                       5,10,17,17,15,1,14,0, //yx
                       14,17,14,17,31,17,4,0, //aaj
                       14,17,14,17,17,14,4,0, //ooj
                       8,4,14,1,15,17,15,0, //af
                       2,4,14,17,31,16,15,0, //es

                       0x99};
unsigned char line_SW1a[] = { 0x4C, 0x00, 0x20, 0b01000001, 0x6E, 0b01101000, 0x20, 0x01, 0x02, 0b01100011}; //10
unsigned char line_SW1b[] = { 0x4B, 0x03, 0x20, 0x54, 0x48, 0x75, 0x04, 0x74, 0x20, 0x56, 0x58, 0x4C}; //12

unsigned char line_SW3a[] = { 0x4D, 0x05, 0x74, 0x20, 0x6E, 0x67, 0x06, 0x79, 0x20, 0x76, 0x75, 0x69, 0x20, 0x6E, 0x68, 0x07 };
unsigned char line_SW3b[] = { 0x01, 0x02, 0b01100011 }; // 3

void IO_init(void)
{
        ANSEL = ANSELH = 0;
        TRISD = 0x07;
        // Here

}

void PWM_CCP1_init(unsigned int duty) // PR2 + 1 = 125
{
        TRISC2_BIT = 1;


        CCPR1L = (unsigned char)(duty >> 2 & 0xFF);
        DC1B0_BIT = (unsigned char)(duty & 0x01);
        DC1B1_BIT = (unsigned char)(duty >> 1 & 0x01);

        T2CKPS1_BIT = 0;
        T2CKPS0_BIT = 1;

        TMR2ON_BIT = 1;
        TMR2IF_BIT = 0;
        CCP1CON = 0x0C;

        while(TMR2IF_BIT);
        TRISC2_BIT = 0;
}
void napkitudacbiet(void)
{
        char i=0;
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
    delay_us(10);
    lcd_putc('\f');
    lcd_gotoxy(3,0);
    for(i=0; i<10; i++) lcd_putc(line_SW1a[i]);
    lcd_gotoxy(2,1);
    for(i=0; i<12; i++) lcd_putc(line_SW1b[i]);
}

void LCD_2(void)
{
	delay_us(10);
	lcd_putc('\f');
	lcd_gotoxy(0,0);
	lcd_puts("Pulse CCP1");
	lcd_gotoxy(0,1);
	lcd_puts("f=(3+1)KHz D=80%");
}

void LCD_3(void)
{
	char i;
	delay_us(10);
	lcd_putc('\f');
	lcd_gotoxy(0,0);
	for(i=0; i<16; i++) lcd_putc(line_SW3a[i]);
	lcd_gotoxy(6,1);
    for(i=0; i<3; i++) lcd_putc(line_SW3b[i]);
}
unsigned int *PR2_select = &PR2;
unsigned int trangthai = 0;
unsigned int trangthai_truoc = -1;

void main() {
        IO_init();
        lcd_init();
        napkitudacbiet();
        while(1)
        {
                if ( RD0_BIT == 0 )
                {
                        delay_ms(10);
                        if ( RD0_BIT == 0 ) trangthai = 1;
                }
                else if ( RD1_BIT == 0 )
                {
                        delay_ms(10);
                        if ( RD1_BIT == 0 ) trangthai = 2;
                }
                else if ( RD2_BIT == 0 )
                {
                        delay_ms(10);
                        if ( RD2_BIT == 0 ) trangthai = 3;
                }

                if ( trangthai_truoc != trangthai )
                {
                        trangthai_truoc = trangthai;
                        if ( trangthai == 1 )
                        {
                                CCP1CON = 0x00;
                                TRISC2_BIT = 1;
                                LCD_1();
                        }
                        else if ( trangthai == 2 )
                        {
                        	*PR2_select = 124;
                        	PWM_CCP1_init(400); // 80% = 400/4*(125+1)
                        	LCD_2();
                        }
                        else if ( trangthai ==  3 )
                        {
                        	CCP1CON = 0x00;
                        	TRISC2_BIT = 1;
                        	LCD_3();
                        }
                }
        }

}