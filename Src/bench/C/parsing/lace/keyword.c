/* C code produced by gperf version 1.9.1 (modified by Raphael Manfredi) */
/* Command-line: gperf -p -t -l -k 1,$ -N in_word_set2 lace.gperf  */


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
#define MAX_WORD_LENGTH 9
#define MIN_HASH_VALUE 0
#define MAX_HASH_VALUE 61
/*
   35 keywords
   62 is the maximum key range
*/

static int
hash (str, len)
     register char *str;
     register unsigned int  len;
{
  static unsigned char hash_table[] =
    {
     61, 61, 61, 61, 10, 61, 61, 61, 61, 61,
     61, 61,  0, 61, 61, 61, 61, 61, 61, 61,
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

  static unsigned char lengthtable[] =
    {
      0,  0,  0,  3,  4,  0,  6,  7,  0,  0,  0,  6,  7,  3,
      0,  0,  6,  7,  0,  4,  5,  6,  7,  8,  4,  0,  6,  2,
      8,  0,  0,  6,  7,  8,  9,  5,  0,  0,  8,  9,  0,  0,
      7,  3,  0,  5,  6,  0,  3,  0,  5,  0,  2,  0,  0,  0,
      0,  0,  0,  0,  0,  1,
    };


  static struct token  wordlist[] =
    {
      {"", },
      {"",}, {"",}, 
      {"use", 			LAC_USE},
      {"make", 			LAC_MAKE},
      {"",}, 
      {"ensure", 			LAC_ENSURE},
      {"exclude", 		LAC_EXCLUDE},
      {"",}, {"",}, 
      {"", },
      {"rename", 			LAC_RENAME},
      {"require", 		LAC_REQUIRE},
      {"end", 			LAC_END},
      {"",}, {"",}, 
      {"ignore", 			LAC_IGNORE},
      {"include", 		LAC_INCLUDE},
      {"",}, 
      {"loop", 			LAC_LOOP},
      {"trace", 			LAC_TRACE},
      {"export", 			LAC_EXPORT},
      {"visible", 		LAC_VISIBLE},
      {"external", 		LAC_EXTERNAL},
      {"root", 			LAC_ROOT},
      {"",}, 
      {"system", 			LAC_SYSTEM},
      {"no", 				LAC_NO},
      {"generate", 		LAC_GENERATE},
      {"",}, {"",}, 
      {"option", 			LAC_OPTION},
      {"default", 		LAC_DEFAULT},
      {"optimize", 		LAC_OPTIMIZE},
      {"invariant", 		LAC_INVARIANT},
      {"debug", 			LAC_DEBUG},
      {"",}, {"",}, 
      {"creation", 		LAC_CREATION},
      {"assertion", 		LAC_ASSERTION},
      {"",}, {"",}, 
      {"cluster", 		LAC_CLUSTER},
      {"yes", 			LAC_YES},
      {"",}, 
      {"check", 			LAC_CHECK},
      {"object", 			LAC_OBJECT},
      {"",}, 
      {"all", 			LAC_ALL},
      {"",}, 
      {"adapt", 			LAC_ADAPT},
      {"",}, 
      {"as", 				LAC_AS},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"c", 				LAC_C},
    };

  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
    {
      register int key = hash (str, len);

      if (key <= MAX_HASH_VALUE && key >= MIN_HASH_VALUE)
        {
          register char *s = wordlist[key].name;

          if (len == lengthtable[key]
              && *s == *str && !strcmp (str + 1, s + 1))
            return &wordlist[key];
        }
    }
  return 0;
}
