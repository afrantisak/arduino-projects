unsigned long int reg;

const int buzzerPin = 9;

void setup() 
{
  pinMode(buzzerPin, OUTPUT);

  // Arbitrary inital value; must not be zero
  reg = 0x55aa55aaL; //The seed for the bitstream. It can be anything except 0.
}

void loop() 
{
  int i, duration;
  
    for (float f = 1.0; f < 2000.0; f *= 1.03)
    {
      my_tone(int(f), 5);
    }

  while(true){}
}

void my_tone(int frequency, int duration)
{
    for (int t = 0; t < duration; t++)
    {
      generateNoise(frequency);
    }
}

void generateNoise(int frequency) {
  unsigned long int newr;
  unsigned char lobit;
  unsigned char b31, b29, b25, b24;
   
  // Extract four chosen bits from the 32-bit register
  b31 = (reg & (1L << 31)) >> 31;
  b29 = (reg & (1L << 29)) >> 29;
  b25 = (reg & (1L << 25)) >> 25;
  b24 = (reg & (1L << 24)) >> 24;

  // EXOR the four bits together
  lobit = b31 ^ b29 ^ b25 ^ b24;
  
  // Shift and incorporate new bit at bit position 0
  newr = (reg << 1) | lobit;
  
  // Replace register with new value
  reg = newr;
  
  // Drive speaker pin from bit 0 of 'reg'
  digitalWrite(buzzerPin, reg & 1);
  
  // Delay (50) corresponds to 20kHz, but the actual frequency of updates
  // will be lower, due to computation time and loop overhead
  delayMicroseconds(frequency);    // Changing this value changes the frequency.
}
