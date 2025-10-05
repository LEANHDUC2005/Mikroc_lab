
void Vidu1_sangduoi(unsigned char start)
{
  unsigned char i;
  PORTD = start;
  delay_ms(400);
  
  for ( i = 0; i < 8; i++ )
  {
    PORTD = (unsigned char)( (PORTD >> 1) | ((PORTD & 0x01) << 7) );
    delay_ms(400);
  }
  
}
void main() {
   ANSEL = ANSELH = 0;
   TRISD = 0;
   
   while(1)
   {
     Vidu1_sangduoi(0x80);
   }
   
   return;
}