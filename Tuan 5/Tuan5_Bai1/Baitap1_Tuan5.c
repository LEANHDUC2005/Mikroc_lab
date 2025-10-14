/*Vi?t chuong trình di?u khi?n t?o 2 xung PWM có :
f
PWM = xKHz, D1 = 75% t?i chân CCP1 và D2 = 25%
t?i chân CCP2. S? d?ng modul CCP ? ch? d? PWM d?
t?o xung.
Bi?t r?ng: fosc = 8MHz
x= s? th? 4 c?a MSSV t? trái qua ph?i
*/
void ccp1_init()   // 75%
{
  TRISC2_BIT = 1;
  PR2 =  99;
  CCPR1L =  75;
  CCP1CON = 0x0C;
  
  DC1B1_BIT = 0;
  DC1B0_BIT = 0;

  TMR2IF_BIT = 0;
  
  TMR2ON_BIT = 1;
  T2CKPS1_BIT = 0;
  T2CKPS0_BIT = 1;
  
  while(TMR2IF_BIT == 0);
  TRISC2_BIT = 0;
}

void ccp2_init()  // 25%
{
  TRISC1_BIT = 1;
  PR2 = 99;
  CCPR2L = 25;
  CCP2CON = 0x0C;

  DC2B1_BIT = 0;
  DC2B0_BIT = 0;

  TMR2IF_BIT = 0;
  TMR2ON_BIT = 1;
  T2CKPS1_BIT = 0;
  T2CKPS0_BIT = 1;

  while(TMR2IF_BIT == 0);
  TRISC1_BIT = 0;
}

void main() 
{
   ANSEL = ANSELH = 0;
   ccp1_init();
   ccp2_init();
   while(1);
}