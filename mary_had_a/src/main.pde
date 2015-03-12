#include "toneAC.h"

unsigned long timestamp = 0; // Stores when the next time the routine is set to run.

void setup() {}

void loop() {
  while (true)
    {
      char* notes = "4E 4D 4C 4D 4E 4E 4E    "
                    "4D 4D 4D    "
                    "4E 4G 4G    "
                    "4E 4D 4C 4D 4E 4E 4E "
                    "4E 4D 4D 4E 4D 4C    ";
      int lengths[] = {500, 500, 500, 500, 500, 500, 500, 500, 
                       500, 500, 500, 500, 
                       500, 500, 500, 500,
                       500, 500, 500, 500, 500, 500, 500, 
                       500, 500, 500, 500, 500, 1000, 2000};

      for (int index = 0; index < (sizeof(lengths) / sizeof(int)); index++)
        {
          play_note_name(&notes[index * 3], 1, lengths[index]);
        }
    }
}

struct note_name_entry
{
  char name;
  int index;
};

int note_name_to_num(const char* note_name)
{
  // a0 is the bottom A on an 88-key keyboard
  // c1 is the lowest C
  // c8 is the highest C 
  struct note_name_entry note_map[7] = { {'C', 3}, {'D', 5}, {'E', 7}, {'F', 8}, {'G', 10}, {'A', 0}, {'B', 2} };

  int octave = note_name[0] - '0';
  int note = 0;
  for (int entry = 0; entry < 7; entry++)
    {
      if (note_name[1] == note_map[entry].name)
        {
          note = note_map[entry].index;
          break;
        }
    }
  int sharp = 0;
  if (note_name[2] == '#') sharp = 1;
  if (note_name[2] == 'b') sharp = -1;
  int note_num = (octave * 12) + note + sharp;
  return note_num;
}

int note_num_to_frequency(int val)
{
  // 0 is the bottom A on an 88-key keyboard
  // 87 is the top C on an 88-key keyboard
  return 27.5 * pow(2.0, val/12.0) + 2;
}

void play_key_num(int num, int vol, int len)
{
  toneAC(note_num_to_frequency(num), vol, len, false);
}

void play_note_name(char* note_name, int vol, int len)
{
  if (note_name[0] == ' ')
    {
      // todo delay here
      toneAC(1, 5, len);
      return;
    }
  int note_num = note_name_to_num(note_name);
  int frequency = note_num_to_frequency(note_num);
  toneAC(frequency, vol, len);
}

