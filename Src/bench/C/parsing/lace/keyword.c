/* C code produced by gperf version 1.9.1 (modified by Raphael Manfredi) */
/* Command-line: gperf -D -p -t -l -k 1,$ -N in_word_set2 lace.gperf  */


/* Lex will see the function "in_word_set2" which will return a pointer
 * to a token structure. Due to gperf constraints, the structure has to
 * be declared here and in lex and cannot be held in an include file--RAM.
 */
#include "lace_y.h"
struct token {
	char *name;		/* The name is imposed by gperf */
	int yaccval;	/* Value returned to yacc */
};

#define MIN_WORD_LENGTH 0
#define MAX_WORD_LENGTH 10
#define MIN_HASH_VALUE 0
#define MAX_HASH_VALUE 61
/*
   36 keywords
   62 is the maximum key range
*/

static int
hash (str, len)
     register char *str;
     register unsigned int  len;
{
  static unsigned char hash_table[] =
    {
      0, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 30, 61, 30,
     10,  0, 61, 20, 61, 10, 61, 10, 15,  0,
      0, 25,  0, 61,  5, 20, 15,  0, 15, 61,
     61, 20, 61, 61, 61, 61, 61, 61,
    };
  return len + hash_table[str[len - 1]] + hash_table[str[0]];
}

struct token *
in_word_set2 (str, len)
     register char *str;
     register unsigned int len;
{

  static struct token  wordlist[] =
    {
      {"", },
      {"", },
      {"use", 			LAC_USE},
      {"make", 			LAC_MAKE},
      {"ensure", 			LAC_ENSURE},
      {"exclude", 		LAC_EXCLUDE},
      {"executable", 		LAC_EXECUTABLE},
      {"rename", 			LAC_RENAME},
      {"require", 		LAC_REQUIRE},
      {"end", 			LAC_END},
      {"ignore", 			LAC_IGNORE},
      {"include", 		LAC_INCLUDE},
      {"loop", 			LAC_LOOP},
      {"trace", 			LAC_TRACE},
      {"export", 			LAC_EXPORT},
      {"visible", 		LAC_VISIBLE},
      {"external", 		LAC_EXTERNAL},
      {"root", 			LAC_ROOT},
      {"system", 			LAC_SYSTEM},
      {"no", 				LAC_NO},
      {"generate", 		LAC_GENERATE},
      {"option", 			LAC_OPTION},
      {"default", 		LAC_DEFAULT},
      {"optimize", 		LAC_OPTIMIZE},
      {"invariant", 		LAC_INVARIANT},
      {"debug", 			LAC_DEBUG},
      {"creation", 		LAC_CREATION},
      {"assertion", 		LAC_ASSERTION},
      {"cluster", 		LAC_CLUSTER},
      {"yes", 			LAC_YES},
      {"check", 			LAC_CHECK},
      {"object", 			LAC_OBJECT},
      {"all", 			LAC_ALL},
      {"adapt", 			LAC_ADAPT},
      {"as", 				LAC_AS},
      {"c", 				LAC_C},
    };

  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
    {
      register int key = hash (str, len);

      if (key <= MAX_HASH_VALUE && key >= MIN_HASH_VALUE)
        {
          struct token  *resword; 

          switch (key)
            {
            case   0:
              resword = &wordlist[0];
              if (*str == *resword->name && !strcmp (str + 1, resword->name + 1)) return resword;
              resword = &wordlist[1];
              if (*str == *resword->name && !strcmp (str + 1, resword->name + 1)) return resword;
              return 0;
            case   3:
              resword = &wordlist[2]; break;
            case   4:
              resword = &wordlist[3]; break;
            case   6:
              resword = &wordlist[4]; break;
            case   7:
              resword = &wordlist[5]; break;
            case  10:
              resword = &wordlist[6]; break;
            case  11:
              resword = &wordlist[7]; break;
            case  12:
              resword = &wordlist[8]; break;
            case  13:
              resword = &wordlist[9]; break;
            case  16:
              resword = &wordlist[10]; break;
            case  17:
              resword = &wordlist[11]; break;
            case  19:
              resword = &wordlist[12]; break;
            case  20:
              resword = &wordlist[13]; break;
            case  21:
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
            case  31:
              resword = &wordlist[21]; break;
            case  32:
              resword = &wordlist[22]; break;
            case  33:
              resword = &wordlist[23]; break;
            case  34:
              resword = &wordlist[24]; break;
            case  35:
              resword = &wordlist[25]; break;
            case  38:
              resword = &wordlist[26]; break;
            case  39:
              resword = &wordlist[27]; break;
            case  42:
              resword = &wordlist[28]; break;
            case  43:
              resword = &wordlist[29]; break;
            case  45:
              resword = &wordlist[30]; break;
            case  46:
              resword = &wordlist[31]; break;
            case  48:
              resword = &wordlist[32]; break;
            case  50:
              resword = &wordlist[33]; break;
            case  52:
              resword = &wordlist[34]; break;
            case  61:
              resword = &wordlist[35]; break;
            default: return 0;
            }
          if (*str == *resword->name && !strcmp (str + 1, resword->name + 1))
            return resword;
      }
  }
  return 0;
}
