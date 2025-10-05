
void Vidu1_sangdan(unsigned char start)
{
  unsigned char i;
  delay_ms(400);

  for ( i = 0; i < 8; i++ )
  {
    PORTD = (unsigned char)( PORTD | start >> i );
    delay_ms(400);
  }

}
void main() {
   ANSEL = ANSELH = 0;
   TRISD = 0;

   while(1)
   {
     Vidu1_sangdan(0x80);
   }

   return;
