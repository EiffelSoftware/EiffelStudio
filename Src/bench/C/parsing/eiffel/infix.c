/* C code produced by gperf version 1.9.1 (modified by Raphael Manfredi) */
/* Command-line: gperf -l -k 1,2,$ -N std_infix infix.gperf  */



#define MIN_WORD_LENGTH 0
#define MAX_WORD_LENGTH 8
#define MIN_HASH_VALUE 0
#define MAX_HASH_VALUE 61
/*
   18 keywords
   62 is the maximum key range
*/

static int
hash (str, len)
     register char *str;
     register unsigned int  len;
{
  static unsigned char hash_table[] =
    {
     61, 61, 61, 61,  0, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 20, 10, 61, 30, 61,  0, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     15,  0, 25, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61,  5, 61, 61,  0, 61, 61,
     15,  5, 61, 61, 61,  0, 61, 61, 61,  0,
      0, 10, 61, 61,  0,  0, 10, 61, 61, 61,
      0, 61, 61, 61, 61, 61, 61, 61,
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

char *
std_infix (str, len)
     register char *str;
     register unsigned int len;
{

  static unsigned char lengthtable[] =
    {
      0,  1,  2,  0,  0,  0,  0,  7,  8,  0,  0,  1,  2,  3,
      0,  0,  0,  2,  3,  0,  0,  1,  7,  3,  0,  0,  0,  2,
      0,  0,  0,  1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1,
      0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  1,
    };


  static char * wordlist[] =
    {
      "", 
      "/", 
      "//", 
      "", "", "", "", 
      "implies", 
      "and then", 
      "", "", 
      "^", 
      "or", 
      "xor", 
      "", "", "", 
      "<=", 
      "and", 
      "", "", 
      "+", 
      "or else", 
      "not", 
      "", "", "", 
      ">=", 
      "", "", "", 
      "<", 
      "", "", "", "", "", "", "", "", "", 
      "*", 
      "", "", "", "", "", "", "", "", "", 
      ">", 
      "", "", "", "", "", "", "", "", "", 
      "-", 
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
