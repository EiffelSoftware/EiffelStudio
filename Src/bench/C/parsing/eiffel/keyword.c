/* C code produced by gperf version 1.9.1 (modified by Raphael Manfredi) */
/* Command-line: gperf -p -t -l -k 1,$,4 eiffel.gperf  */


/* Lex will see the function "in_word_set" which will return a pointer
 * to a token structure. Due to gperf constraints, the structure has to
 * be declared here and in lex and cannot be held in an include file--RAM.
 */
#include "macros.h"
#include "parser.h"
struct token {
	char *name;		/* The name is imposed by gperf */
	int yaccval;	/* Value returned to yacc */
};

#define MIN_WORD_LENGTH 0
#define MAX_WORD_LENGTH 9
#define MIN_HASH_VALUE 0
#define MAX_HASH_VALUE 135
/*
   58 keywords
  136 is the maximum key range
*/

static int
hash (str, len)
     register char *str;
     register unsigned int  len;
{
  static unsigned char hash_table[] =
    {
     135, 135, 135, 135,  20, 135, 135, 135, 135, 135,
     135, 135,   0, 135, 135, 135, 135, 135, 135, 135,
     135, 135, 135, 135, 135, 135, 135, 135, 135, 135,
     135, 135, 135, 135, 135, 135, 135, 135, 135, 135,
     135, 135, 135, 135, 135, 135, 135, 135, 135, 135,
     135, 135, 135, 135, 135, 135, 135, 135, 135, 135,
     135, 135, 135, 135, 135, 135, 135, 135, 135, 135,
     135, 135, 135, 135, 135, 135, 135, 135, 135, 135,
     135, 135, 135, 135, 135, 135, 135, 135, 135, 135,
     135, 135, 135, 135, 135, 135, 135,  20,  10,  39,
      30,   0,  45,  30, 135,   0, 135,  10,  55,   0,
      20,  10,  10,  25,  57,   0,  23,  17,   5,  10,
       0,   0,  15, 135, 135, 135, 135, 135,
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

struct token *
in_word_set (str, len)
     register char *str;
     register unsigned int len;
{

  static unsigned char lengthtable[] =
    {
      0,  0,  2,  0,  4,  5,  0,  0,  0,  0,  0,  0,  0,  0,
      4,  5,  0,  0,  0,  0,  0,  0,  2,  6,  0,  8,  0,  4,
      8,  6,  7,  0,  0,  3,  0,  7,  3,  0,  8,  6,  7,  0,
      2,  3,  5,  5,  3,  2,  6,  4,  5,  6,  9,  3,  4,  0,
      0,  0,  8,  4,  3,  6,  7,  8,  0,  8,  0,  4,  8,  2,
      0,  0,  0,  0,  0,  7,  0,  5,  3,  4,  0,  7,  5,  6,
      0,  0,  6,  8,  0,  0,  0,  0,  0,  5,  0,  0,  0,  0,
      0,  0,  0,  0,  6,  6,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0,  0,  5,  0,  0,  0,  0,  0,  0,
      7,  0,  0,  0,  0,  0,  0,  0,  0,  5,
    };


  static struct token  wordlist[] =
    {
      {"", },
      {"",}, 
      {"is", 				TE_IS},
      {"",}, 
      {"else", 			TE_ELSE},
      {"infix", 			TE_INFIX},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"once", 			TE_ONCE},
      {"strip", 			TE_STRIP},
      {"",}, {"",}, {"",}, {"",}, 
      {"", },
      {"",}, 
      {"as", 				TE_AS},
      {"ensure", 			TE_ENSURE},
      {"",}, 
      {"undefine", 		TE_UNDEFINE},
      {"",}, 
      {"true", 			TE_TRUE},
      {"obsolete", 		TE_OBSOLETE},
      {"select", 			TE_SELECT},
      {"inherit", 		TE_INHERIT},
      {"",}, {"",}, 
      {"end", 			TE_END},
      {"",}, 
      {"variant", 		TE_VARIANT},
      {"bit", 			TE_BIT},
      {"",}, 
      {"indexing", 		TE_INDEXING},
      {"export", 			TE_EXPORT},
      {"inspect", 		TE_INSPECT},
      {"",}, 
      {"do", 				TE_DO},
      {"old", 			TE_OLD},
      {"class", 			TE_CLASS},
      {"alias", 			TE_ALIAS},
      {"not", 			TE_NOT},
      {"if", 				TE_IF},
      {"unique", 			TE_UNIQUE},
      {"from", 			TE_FROM},
      {"false", 			TE_FALSE},
      {"elseif", 			TE_ELSEIF},
      {"invariant", 		TE_INVARIANT},
      {"and", 			TE_AND},
      {"when", 			TE_WHEN},
      {"",}, {"",}, {"",}, 
      {"expanded", 		TE_EXPANDED},
      {"like", 			TE_LIKE},
      {"xor", 			TE_XOR},
      {"prefix", 			TE_PREFIX},
      {"implies", 		TE_IMPLIES},
      {"external", 		TE_EXTERNAL},
      {"",}, 
      {"redefine", 		TE_REDEFINE},
      {"",}, 
      {"then", 			TE_THEN},
      {"deferred", 		TE_DEFERRED},
      {"or", 				TE_OR},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"feature", 		TE_FEATURE},
      {"",}, 
      {"until", 			TE_UNTIL},
      {"all", 			TE_ALL},
      {"loop", 			TE_LOOP},
      {"",}, 
      {"require", 		TE_REQUIRE},
      {"debug", 			TE_DEBUG},
      {"rename", 			TE_RENAME},
      {"",}, {"",}, 
      {"frozen", 			TE_FROZEN},
      {"creation", 		TE_CREATION},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"check", 			TE_CHECK},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"rescue", 			TE_RESCUE},
      {"result", 			TE_RESULT},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"retry", 			TE_RETRY},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"current", 		TE_CURRENT},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"local", 			TE_LOCAL},
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
