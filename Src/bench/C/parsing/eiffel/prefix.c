/* C code produced by gperf version 1.9.1 (modified by Raphael Manfredi) */
/* Command-line: gperf -a -l -N std_prefix prefix.gperf  */



#define MIN_WORD_LENGTH 1
#define MAX_WORD_LENGTH 3
#define MIN_HASH_VALUE 1
#define MAX_HASH_VALUE 5
/*
    3 keywords
    5 is the maximum key range
*/

static int
hash (register const char *str, register int len)
{
  static unsigned char hash_table[] =
    {
     5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
     5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
     5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
     5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
     5, 5, 5, 2, 5, 0, 5, 5, 5, 5,
     5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
     5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
     5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
     5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
     5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
     5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
     0, 5, 5, 5, 5, 5, 0, 5, 5, 5,
     5, 5, 5, 5, 5, 5, 5, 5,
    };
  return len + hash_table[str[len - 1]] + hash_table[str[0]];
}

char *
std_prefix (register const char *str, register int len)
{

  static unsigned char lengthtable[] =
    {
      0,  1,  0,  3,  0,  1,
    };


  static char * wordlist[] =
    {
      "", 
      "-", 
      "", 
      "not", 
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
