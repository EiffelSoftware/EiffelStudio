/* C code produced by gperf version 1.9.1 (modified by Raphael Manfredi) */
/* Command-line: gperf -l -k 1,2,$ -N std_infix infix.gperf  */



#define MIN_WORD_LENGTH 1
#define MAX_WORD_LENGTH 8
#define MIN_HASH_VALUE 1
#define MAX_HASH_VALUE 31
/*
   16 keywords
   31 is the maximum key range
*/

static int hash (register char *str, register unsigned int len)
{
  static unsigned char hash_table[] =
    {
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     31, 31,  9, 15, 31, 14, 31,  0, 31, 31,
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     10,  0,  4, 31, 31, 31, 31, 31, 31, 31,
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
     31, 31, 31, 31,  5, 31, 31,  0, 31, 31,
     10,  5, 31, 31, 31,  0, 31, 31, 31,  0,
      0, 15, 31, 31,  0,  0, 31, 31, 31, 31,
      0, 31, 31, 31, 31, 31, 31, 31,
    };
  register int hval = len ;

  switch (hval)
    {
      default:
      case 2:
        hval += hash_table[str[1]];
      case 1:
        hval += hash_table[str[0]];
    }
  return hval + hash_table[str[len - 1]] ;
}

char * std_infix (register char *str, register unsigned int len)
{

  static unsigned char lengthtable[] =
    {
      0,  1,  2,  0,  0,  0,  2,  7,  8,  1,  0,  1,  2,  3,
      0,  0,  0,  2,  3,  1,  0,  1,  0,  0,  0,  0,  0,  7,
      0,  1,  0,  1,
    };


  static char * wordlist[] =
    {
      "", 
      "/", 
      "//", 
      "", "", "", 
      ">=", 
      "implies", 
      "and then", 
      ">", 
      "", 
      "^", 
      "<=", 
      "and", 
      "", "", "", 
      "or", 
      "xor", 
      "*", 
      "", 
      "<", 
      "", "", "", "", "", 
      "or else", 
      "", 
      "-", 
      "", 
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
