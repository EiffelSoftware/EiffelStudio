/* C code produced by gperf version 1.9.1 (modified by Raphael Manfredi) */
/* Command-line: gperf -a -l -N std_infix infix.gperf  */



#define MIN_WORD_LENGTH 1
#define MAX_WORD_LENGTH 8
#define MIN_HASH_VALUE 1
#define MAX_HASH_VALUE 31
/*
   16 keywords
   31 is the maximum key range
*/

static int
hash (register const char *str, register int len)
{
  static unsigned char hash_table[] =
    {
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     31, 31,  9, 15, 31,  4, 31,  0, 31, 31,
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     10,  5,  3, 31, 31, 31, 31, 31, 31, 31,
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     31, 31, 31, 31,  5, 31, 31,  0, 31, 31,
     10,  5, 31, 31, 31,  9, 31, 31, 31, 31,
      0, 10, 31, 31,  0,  0, 31, 31, 31, 31,
      0, 31, 31, 31, 31, 31, 31, 31,
    };
  return len + hash_table[str[len - 1]] + hash_table[str[0]];
}

char *
std_infix (register const char *str, register int len)
{

  static unsigned char lengthtable[] =
    {
      0,  1,  2,  3,  0,  0,  0,  1,  8,  1,  2,  1,  2,  3,
      0,  0,  7,  2,  0,  1,  0,  1,  7,  0,  0,  0,  0,  0,
      0,  0,  0,  1,
    };


  static char * wordlist[] =
    {
      "", 
      "/", 
      "//", 
      "xor", 
      "", "", "", 
      ">", 
      "and then", 
      "-", 
      ">=", 
      "^", 
      "or", 
      "and", 
      "", "", 
      "implies", 
      "<=", 
      "", 
      "*", 
      "", 
      "<", 
      "or else", 
      "", "", "", "", "", "", "", "", 
      "+", 
    };

  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
    {
      register int key = hash (str, len);

      if (key <= MAX_HASH_VALUE && key >= MIN_HASH_VALUE)
        {
          register char *s = wordlist[key];

          if (len == lengthtable[key]
              && *s == *str && !strcmp (str + 1, s + 1))
            return s;
        }
    }
  return 0;
}
