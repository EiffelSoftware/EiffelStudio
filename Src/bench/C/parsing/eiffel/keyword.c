/* C code produced by gperf version 1.9.1 (modified by Raphael Manfredi) */
/* Command-line: gperf -a -p -t -l -k 1,\$,3 eiffel.gperf  */


/* Lex will see the function "in_word_set" which will return a pointer
 * to a token structure. Due to gperf constraints, the structure has to
 * be declared here and in lex and cannot be held in an include file--RAM.
 */
#include "eif_macros.h"
#include "parser.h"
struct token {
	char *name;		/* The name is imposed by gperf */
	int yaccval;	/* Value returned to yacc */
};

#define MIN_WORD_LENGTH 2
#define MAX_WORD_LENGTH 9
#define MIN_HASH_VALUE 2
#define MAX_HASH_VALUE 184
/*
   58 keywords
  183 is the maximum key range
*/

static int
hash (register const char *str, register int len)
{
  static unsigned char hash_table[] =
    {
     184, 184, 184, 184, 184, 184, 184, 184, 184, 184,
     184, 184, 184, 184, 184, 184, 184, 184, 184, 184,
     184, 184, 184, 184, 184, 184, 184, 184, 184, 184,
     184, 184, 184, 184, 184, 184, 184, 184, 184, 184,
     184, 184, 184, 184, 184, 184, 184, 184, 184, 184,
     184, 184, 184, 184, 184, 184, 184, 184, 184, 184,
     184, 184, 184, 184, 184, 184, 184, 184, 184, 184,
     184, 184, 184, 184, 184, 184, 184, 184, 184, 184,
     184, 184, 184, 184, 184, 184, 184, 184, 184, 184,
     184, 184, 184, 184, 184, 184, 184,  47,  30,  41,
      60,   0,  56,  35,   5,   0, 184,   5,   5,   0,
       5,  22,  30,   0,  20,   0,   6,  37,  35,   0,
      40,   5, 184, 184, 184, 184, 184, 184,
    };
  register int hval = len ;

  switch (hval)
    {
      default:
      case 3:
        hval += hash_table[str[2]];
      case 2:
      case 1:
        hval += hash_table[str[0]];
    }
  return hval + hash_table[str[len - 1]] ;
}

struct token *
in_word_set (register const char *str, register int len)
{

  static unsigned char lengthtable[] =
    {
      0,  0,  2,  0,  4,  0,  6,  0,  0,  4,  0,  0,  0,  7,
      4,  4,  0,  6,  7,  8,  3,  0,  0,  0,  0,  0,  6,  7,
      0,  0,  8,  6,  6,  0,  0,  0,  5,  7,  8,  0,  0,  0,
      6,  6,  2,  3,  0,  4,  0,  2,  9,  5,  5,  5,  8,  5,
      5,  0,  2,  9,  3,  4,  6,  0,  0,  0,  5,  4,  7,  0,
      0,  0,  0,  0,  7,  0,  6,  0,  0,  0,  0,  0,  4,  3,
      2,  0,  0,  0,  8,  6,  0,  0,  0,  5,  0,  0,  0,  0,
      8,  0,  0,  5,  0,  8,  0,  8,  0,  0,  0,  0,  7,  0,
      0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  3,  0,  0,
      0,  0,  0,  0,  5,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  3,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  3,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  8,
    };


  static struct token  wordlist[] =
    {
      {"",}, {"",}, 
      {"is", 				TE_IS},
      {"",}, 
      {"else", 			TE_ELSE},
      {"",}, 
      {"ensure", 			TE_ENSURE},
      {"",}, {"",}, 
      {"when", 			TE_WHEN},
      {"",}, {"",}, {"",}, 
      {"inspect", 		TE_INSPECT},
      {"like", 			TE_LIKE},
      {"then", 			TE_THEN},
      {"",}, 
      {"select", 			TE_SELECT},
      {"inherit", 		TE_INHERIT},
      {"external", 		TE_EXTERNAL},
      {"not", 			TE_NOT},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"rescue", 			TE_RESCUE},
      {"require", 		TE_REQUIRE},
      {"",}, {"",}, 
      {"obsolete", 		TE_OBSOLETE},
      {"rename", 			TE_RENAME},
      {"result", 			TE_RESULT},
      {"",}, {"",}, {"",}, 
      {"retry", 			TE_RETRY},
      {"implies", 		TE_IMPLIES},
      {"separate", 		TE_SEPARATE},
      {"",}, {"",}, {"",}, 
      {"export", 			TE_EXPORT},
      {"unique", 			TE_UNIQUE},
      {"or", 				TE_OR},
      {"bit", 			TE_BIT},
      {"",}, 
      {"true", 			TE_TRUE},
      {"",}, 
      {"as", 				TE_AS},
      {"invariant", 		TE_INVARIANT},
      {"check", 			TE_CHECK},
      {"alias", 			TE_ALIAS},
      {"until", 			TE_UNTIL},
      {"creation", 		TE_CREATION},
      {"strip", 			TE_STRIP},
      {"local", 			TE_LOCAL},
      {"",}, 
      {"if", 				TE_IF},
      {"precursor", 		TE_PRECURSOR},
      {"all", 			TE_ALL},
      {"loop", 			TE_LOOP},
      {"elseif", 			TE_ELSEIF},
      {"",}, {"",}, {"",}, 
      {"false", 			TE_FALSE},
      {"once", 			TE_ONCE},
      {"variant", 		TE_VARIANT},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"current", 		TE_CURRENT},
      {"",}, 
      {"prefix", 			TE_PREFIX},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"from", 			TE_FROM},
      {"xor", 			TE_XOR},
      {"do", 				TE_DO},
      {"",}, {"",}, {"",}, 
      {"redefine", 		TE_REDEFINE},
      {"frozen", 			TE_FROZEN},
      {"",}, {"",}, {"",}, 
      {"class", 			TE_CLASS},
      {"",}, {"",}, {"",}, {"",}, 
      {"expanded", 		TE_EXPANDED},
      {"",}, {"",}, 
      {"infix", 			TE_INFIX},
      {"",}, 
      {"indexing", 		TE_INDEXING},
      {"",}, 
      {"undefine", 		TE_UNDEFINE},
      {"",}, {"",}, {"",}, {"",}, 
      {"feature", 		TE_FEATURE},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"",}, {"",}, {"",}, 
      {"end", 			TE_END},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"debug", 			TE_DEBUG},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"old", 			TE_OLD},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"and", 			TE_AND},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"",}, {"",}, {"",}, {"",}, 
      {"deferred", 		TE_DEFERRED},
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
