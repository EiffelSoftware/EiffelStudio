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

#define MIN_WORD_LENGTH 2
#define MAX_WORD_LENGTH 9
#define MIN_HASH_VALUE 2
#define MAX_HASH_VALUE 144
/*
   57 keywords
  143 is the maximum key range
*/

static int
hash (register char *str, register unsigned int len)
{
  static unsigned char hash_table[] =
    {
     144, 144, 144, 144, 144, 144, 144, 144, 144, 144,
     144, 144, 144, 144, 144, 144, 144, 144, 144, 144,
     144, 144, 144, 144, 144, 144, 144, 144, 144, 144,
     144, 144, 144, 144, 144, 144, 144, 144, 144, 144,
     144, 144, 144, 144, 144, 144, 144, 144, 144, 144,
     144, 144, 144, 144, 144, 144, 144, 144, 144, 144,
     144, 144, 144, 144, 144, 144, 144, 144, 144, 144,
     144, 144, 144, 144, 144, 144, 144, 144, 144, 144,
     144, 144, 144, 144, 144, 144, 144, 144, 144, 144,
     144, 144, 144, 144, 144, 144, 144,  25,  20,   1,
      35,   0,  30,   5, 144,   0, 144,   5,  45,   5,
      40,  10,  10,   5,  50,   0,  60,  15,  15,   0,
      40,   0,  15, 144, 144, 144, 144, 144,
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
in_word_set (register char *str, register unsigned int len)
{

  static unsigned char lengthtable[] =
    {
      0,  0,  2,  0,  4,  0,  5,  0,  0,  0,  0,  0,  5,  8,
      4,  5,  0,  0,  0,  0,  0,  6,  0,  8,  0,  0,  6,  2,
      8,  0,  0,  0,  2,  8,  0,  5,  6,  0,  3,  0,  0,  0,
      0,  0,  4,  5,  0,  2,  3,  4,  0,  0,  7,  8,  0,  5,
      0,  6,  8,  0,  5,  0,  2,  3,  4,  5,  6,  7,  8,  4,
      0,  0,  7,  3,  8,  0,  6,  7,  8,  0,  0,  6,  7,  3,
      4,  0,  6,  0,  0,  0,  0,  6,  0,  3,  9,  0,  0,  7,
      0,  0,  0,  0,  0,  3,  0,  5,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0,  7,  0,  5,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  6,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  4,
    };


  static struct token  wordlist[] =
    {
      {"",}, {"",}, 
      {"is", 				TE_IS},
      {"",}, 
      {"else", 			TE_ELSE},
      {"",}, 
      {"class", 			TE_CLASS},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"check", 			TE_CHECK},
      {"indexing", 		TE_INDEXING},
      {"once", 			TE_ONCE},
      {"strip", 			TE_STRIP},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"ensure", 			TE_ENSURE},
      {"",}, 
      {"undefine", 		TE_UNDEFINE},
      {"",}, {"",}, 
      {"unique", 			TE_UNIQUE},
      {"as", 				TE_AS},
      {"obsolete", 		TE_OBSOLETE},
      {"",}, {"",}, {"",}, 
      {"if", 				TE_IF},
      {"separate", 		TE_SEPARATE},
      {"",}, 
      {"false", 			TE_FALSE},
      {"elseif", 			TE_ELSEIF},
      {"",}, 
      {"end", 			TE_END},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"from", 			TE_FROM},
      {"infix", 			TE_INFIX},
      {"",}, 
      {"do", 				TE_DO},
      {"old", 			TE_OLD},
      {"like", 			TE_LIKE},
      {"",}, {"",}, 
      {"implies", 		TE_IMPLIES},
      {"external", 		TE_EXTERNAL},
      {"",}, 
      {"alias", 			TE_ALIAS},
      {"",}, 
      {"rescue", 			TE_RESCUE},
      {"redefine", 		TE_REDEFINE},
      {"",}, 
      {"debug", 			TE_DEBUG},
      {"",}, 
      {"or", 				TE_OR},
      {"and", 			TE_AND},
      {"true", 			TE_TRUE},
      {"until", 			TE_UNTIL},
      {"select", 			TE_SELECT},
      {"inherit", 		TE_INHERIT},
      {"expanded", 		TE_EXPANDED},
      {"loop", 			TE_LOOP},
      {"",}, {"",}, 
      {"require", 		TE_REQUIRE},
      {"all", 			TE_ALL},
      {"creation", 		TE_CREATION},
      {"",}, 
      {"export", 			TE_EXPORT},
      {"inspect", 		TE_INSPECT},
      {"deferred", 		TE_DEFERRED},
      {"",}, {"",}, 
      {"rename", 			TE_RENAME},
      {"variant", 		TE_VARIANT},
      {"bit", 			TE_BIT},
      {"when", 			TE_WHEN},
      {"",}, 
      {"prefix", 			TE_PREFIX},
      {"",}, {"",}, {"",}, {"",}, 
      {"frozen", 			TE_FROZEN},
      {"",}, 
      {"xor", 			TE_XOR},
      {"invariant", 		TE_INVARIANT},
      {"",}, {"",}, 
      {"feature", 		TE_FEATURE},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"not", 			TE_NOT},
      {"",}, 
      {"retry", 			TE_RETRY},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"",}, {"",}, {"",}, 
      {"current", 		TE_CURRENT},
      {"",}, 
      {"local", 			TE_LOCAL},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"",}, 
      {"result", 			TE_RESULT},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"",}, {"",}, {"",}, 
      {"then", 			TE_THEN},
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
