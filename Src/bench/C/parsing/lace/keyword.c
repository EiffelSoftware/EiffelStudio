/* C code produced by gperf version 1.9.1 (modified by Raphael Manfredi) */
/* Command-line: gperf -a -p -t -l -N in_word_set2 lace.gperf  */


#include "eif_eiffel.h"
#include "lace_y.h"
struct token {
	char *name;
	int yaccval;
};

#define MIN_WORD_LENGTH 1
#define MAX_WORD_LENGTH 12
#define MIN_HASH_VALUE 3
#define MAX_HASH_VALUE 61
/*
   36 keywords
   59 is the maximum key range
*/

static int
hash (register const char *str, register int len)
{
  static unsigned char hash_table[] =
    {
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 61, 61, 61,
     61, 61, 61, 61, 61, 61, 61, 30, 61, 30,
     10,  0, 61, 20,  0, 10, 61, 10, 15, 15,
      0, 35, 10, 61,  5, 25, 15,  0, 20, 61,
     61,  5, 61, 61, 61, 61, 61, 61,
    };
  return len + hash_table[str[len - 1]] + hash_table[str[0]];
}

struct token *
in_word_set2 (register const char *str, register int len)
{

  static unsigned char lengthtable[] =
    {
      0,  0,  0,  3,  0,  0,  6,  7,  0,  0, 10,  6,  7,  3,
      0,  0,  6,  7,  0,  4,  5,  6, 12,  8,  4,  0,  0,  7,
      8,  4,  0, 11,  7,  3,  9,  5,  0,  2,  8,  9,  0,  6,
      7,  8,  0,  5,  6,  0,  3,  0,  5,  0,  0,  0,  0,  0,
      6,  2,  0,  0,  0,  1,
    };


  static struct token  wordlist[] =
    {
      {"",}, {"",}, {"",}, 
      {"use", 			LAC_USE},
      {"",}, {"",}, 
      {"ensure", 			LAC_ENSURE},
      {"exclude", 		LAC_EXCLUDE},
      {"",}, {"",}, 
      {"executable", 		LAC_EXECUTABLE},
      {"rename", 			LAC_RENAME},
      {"require", 		LAC_REQUIRE},
      {"end", 			LAC_END},
      {"",}, {"",}, 
      {"ignore", 			LAC_IGNORE},
      {"include", 		LAC_INCLUDE},
      {"",}, 
      {"make", 			LAC_MAKE},
      {"trace", 			LAC_TRACE},
      {"export", 			LAC_EXPORT},
      {"include_path", 	LAC_INCLUDE_PATH},
      {"external", 		LAC_EXTERNAL},
      {"root", 			LAC_ROOT},
      {"",}, {"",}, 
      {"visible", 		LAC_VISIBLE},
      {"generate", 		LAC_GENERATE},
      {"loop", 			LAC_LOOP},
      {"",}, 
      {"precompiled", 	LAC_PRECOMPILED},
      {"default", 		LAC_DEFAULT},
      {"yes", 			LAC_YES},
      {"invariant", 		LAC_INVARIANT},
      {"debug", 			LAC_DEBUG},
      {"",}, 
      {"no", 				LAC_NO},
      {"creation", 		LAC_CREATION},
      {"assertion", 		LAC_ASSERTION},
      {"",}, 
      {"option", 			LAC_OPTION},
      {"cluster", 		LAC_CLUSTER},
      {"optimize", 		LAC_OPTIMIZE},
      {"",}, 
      {"check", 			LAC_CHECK},
      {"system", 			LAC_SYSTEM},
      {"",}, 
      {"all", 			LAC_ALL},
      {"",}, 
      {"adapt", 			LAC_ADAPT},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"object", 			LAC_OBJECT},
      {"as", 				LAC_AS},
      {"",}, {"",}, {"",}, 
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
