/* C code produced by gperf version 1.9.1 (modified by Raphael Manfredi) */
/* Command-line: gperf -D -p -t -l -k 1,$,4 -N in_word_set2 lace.gperf  */


#include "eif_eiffel.h"
#include "lace_y.h"
struct token {
	char *name;
	int yaccval;
};

#define MIN_WORD_LENGTH 1
#define MAX_WORD_LENGTH 13
#define MIN_HASH_VALUE 1
#define MAX_HASH_VALUE 92
/*
   37 keywords
   92 is the maximum key range
*/

static int hash (register char *str, register unsigned int  len)
{
  static unsigned char hash_table[] =
    {
     92, 92, 92, 92, 92, 92, 92, 92, 92, 92,
     92, 92, 92, 92, 92, 92, 92, 92, 92, 92,
     92, 92, 92, 92, 92, 92, 92, 92, 92, 92,
     92, 92, 92, 92, 92, 92, 92, 92, 92, 92,
     92, 92, 92, 92, 92, 92, 92, 92, 92, 92,
     92, 92, 92, 92, 92, 92, 92, 92, 92, 92,
     92, 92, 92, 92, 92, 92, 92, 92, 92, 92,
     92, 92, 92, 92, 92, 92, 92, 92, 92, 92,
     92, 92, 92, 92, 92, 92, 92, 92, 92, 92,
     92, 92, 92, 92, 92, 92, 92,  0, 92,  0,
     25,  0, 92, 15,  0, 10, 92, 10,  0, 20,
     25,  0, 25, 92, 40,  0,  0, 45, 20, 92,
     92, 10, 92, 92, 92, 92, 92, 92,
    };
  register int hval = len ;

  switch (hval)
    {
      default:
      case 4:
        hval += hash_table[str[3]];
      case 3:
      case 2:
      case 1:
        hval += hash_table[str[0]];
    }
  return hval + hash_table[str[len - 1]] ;
}

struct token * in_word_set2 (register char *str, register unsigned int len)
{

  static struct token  wordlist[] =
    {
      {"c", 				LAC_C},
      {"as", 				LAC_AS},
      {"all", 			LAC_ALL},
      {"trace", 			LAC_TRACE},
      {"export", 			LAC_EXPORT},
      {"object", 			LAC_OBJECT},
      {"exclude", 		LAC_EXCLUDE},
      {"external", 		LAC_EXTERNAL},
      {"executable", 		LAC_EXECUTABLE},
      {"yes", 			LAC_YES},
      {"check", 			LAC_CHECK},
      {"ignore", 			LAC_IGNORE},
      {"include", 		LAC_INCLUDE},
      {"optimize", 		LAC_OPTIMIZE},
      {"invariant", 		LAC_INVARIANT},
      {"include_path", 	LAC_INCLUDE_PATH},
      {"generate", 		LAC_GENERATE},
      {"make", 			LAC_MAKE},
      {"system", 			LAC_SYSTEM},
      {"no", 				LAC_NO},
      {"end", 			LAC_END},
      {"adapt", 			LAC_ADAPT},
      {"default", 		LAC_DEFAULT},
      {"creation", 		LAC_CREATION},
      {"assertion", 		LAC_ASSERTION},
      {"visible", 		LAC_VISIBLE},
      {"option", 			LAC_OPTION},
      {"root", 			LAC_ROOT},
      {"rename", 			LAC_RENAME},
      {"cluster", 		LAC_CLUSTER},
      {"use", 			LAC_USE},
      {"ensure", 			LAC_ENSURE},
      {"loop", 			LAC_LOOP},
      {"multithreaded", 		LAC_MULTITHREADED},
      {"precompiled", 	LAC_PRECOMPILED},
      {"debug", 			LAC_DEBUG},
      {"require", 		LAC_REQUIRE},
    };

  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
    {
      register int key = hash (str, len);

      if (key <= MAX_HASH_VALUE && key >= MIN_HASH_VALUE)
        {
          struct token  *resword; 

          switch (key)
            {
            case   1:
              resword = &wordlist[0]; break;
            case   2:
              resword = &wordlist[1]; break;
            case   3:
              resword = &wordlist[2]; break;
            case   5:
              resword = &wordlist[3]; break;
            case   6:
              resword = &wordlist[4];
              if (*str == *resword->name && !strcmp (str + 1, resword->name + 1)) return resword;
              resword = &wordlist[5];
              if (*str == *resword->name && !strcmp (str + 1, resword->name + 1)) return resword;
              return 0;
            case   7:
              resword = &wordlist[6]; break;
            case   8:
              resword = &wordlist[7]; break;
            case  10:
              resword = &wordlist[8]; break;
            case  13:
              resword = &wordlist[9]; break;
            case  15:
              resword = &wordlist[10]; break;
            case  16:
              resword = &wordlist[11]; break;
            case  17:
              resword = &wordlist[12]; break;
            case  18:
              resword = &wordlist[13]; break;
            case  19:
              resword = &wordlist[14]; break;
            case  22:
              resword = &wordlist[15]; break;
            case  23:
              resword = &wordlist[16]; break;
            case  24:
              resword = &wordlist[17]; break;
            case  26:
              resword = &wordlist[18]; break;
            case  27:
              resword = &wordlist[19]; break;
            case  28:
              resword = &wordlist[20]; break;
            case  30:
              resword = &wordlist[21]; break;
            case  32:
              resword = &wordlist[22]; break;
            case  33:
              resword = &wordlist[23]; break;
            case  34:
              resword = &wordlist[24]; break;
            case  37:
              resword = &wordlist[25]; break;
            case  41:
              resword = &wordlist[26]; break;
            case  44:
              resword = &wordlist[27]; break;
            case  46:
              resword = &wordlist[28]; break;
            case  47:
              resword = &wordlist[29]; break;
            case  48:
              resword = &wordlist[30]; break;
            case  51:
              resword = &wordlist[31]; break;
            case  54:
              resword = &wordlist[32]; break;
            case  58:
              resword = &wordlist[33]; break;
            case  61:
              resword = &wordlist[34]; break;
            case  90:
              resword = &wordlist[35]; break;
            case  92:
              resword = &wordlist[36]; break;
            default: return 0;
            }
          if (*str == *resword->name && !strcmp (str + 1, resword->name + 1))
            return resword;
      }
  }
  return 0;
}
