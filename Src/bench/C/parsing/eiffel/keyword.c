/* C code produced by gperf version 2.5 (GNU C++ version) */
/* Command-line: gperf -p -t -l -k 1,$,3 eiffel.gperf  */
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

#define TOTAL_KEYWORDS 59
#define MIN_WORD_LENGTH 2
#define MAX_WORD_LENGTH 9
#define MIN_HASH_VALUE 2
#define MAX_HASH_VALUE 173
/* maximum key range = 172, duplicates = 0 */

static unsigned int
hash (str, len)
     register char *str;
     register int unsigned len;
{
  static unsigned char asso_values[] =
    {
     174, 174, 174, 174, 174, 174, 174, 174, 174, 174,
     174, 174, 174, 174, 174, 174, 174, 174, 174, 174,
     174, 174, 174, 174, 174, 174, 174, 174, 174, 174,
     174, 174, 174, 174, 174, 174, 174, 174, 174, 174,
     174, 174, 174, 174, 174, 174, 174, 174, 174, 174,
     174, 174, 174, 174, 174, 174, 174, 174, 174, 174,
     174, 174, 174, 174, 174, 174, 174, 174, 174, 174,
     174, 174, 174, 174, 174, 174, 174, 174, 174, 174,
     174, 174, 174, 174, 174, 174, 174, 174, 174, 174,
     174, 174, 174, 174, 174, 174, 174,  45,  60,  25,
      55,   0,  15,  20,  15,   0, 174,   5,   5,   5,
      40,  25,  62,   0,  30,   0,  55,  35,   0,   0,
      40,   0, 174, 174, 174, 174, 174, 174,
    };
  register int hval = len;

  switch (hval)
    {
      default:
      case 3:
        hval += asso_values[str[2]];
      case 2:
      case 1:
        hval += asso_values[str[0]];
        break;
    }
  return hval + asso_values[str[len - 1]];
}

struct token *
in_word_set (str, len)
     register char *str;
     register unsigned int len;
{

  static unsigned char lengthtable[] =
    {
      0,  0,  2,  0,  4,  0,  6,  0,  0,  0,  0,  0,  0,  0,
      4,  0,  0,  2,  0,  0,  0,  6,  0,  0,  0,  5,  0,  0,
      0,  0,  0,  6,  0,  8,  0,  5,  6,  7,  0,  0,  5,  6,
      0,  0,  4,  0,  0,  2,  0,  4,  5,  0,  0,  0,  4,  0,
      0,  2,  3,  0,  5,  0,  7,  0,  9,  0,  6,  7,  8,  7,
      8,  0,  0,  8,  0,  5,  6,  7,  0,  0,  0,  0,  2,  8,
      0,  0,  6,  0,  0,  0,  5,  6,  7,  8,  4,  0,  4,  5,
      8,  4,  5,  9,  0,  3,  0,  0,  0,  0,  6,  0,  0,  0,
      0,  3,  0,  0,  0,  7,  0,  0,  0,  0,  0,  6,  0,  8,
      0,  0,  0,  0,  0,  0,  0,  8,  0,  0,  0,  0,  3,  0,
      5,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  3,
      0,  0,  0,  0,  3,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  3,
    };
  static struct token wordlist[] =
    {
      {"",}, {"",}, 
      {"is", 				TE_IS},
      {"",}, 
      {"else", 			TE_ELSE},
      {"",}, 
      {"ensure", 			TE_ENSURE},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"like", 			TE_LIKE},
      {"",}, {"",}, 
      {"if", 				TE_IF},
      {"",}, {"",}, {"",}, 
      {"elseif", 			TE_ELSEIF},
      {"",}, {"",}, {"",}, 
      {"false", 			TE_FALSE},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"create", 			TE_CREATION},
      {"",}, 
      {"obsolete", 		TE_OBSOLETE},
      {"",}, 
      {"check", 			TE_CHECK},
      {"rescue", 			TE_RESCUE},
      {"require", 		TE_REQUIRE},
      {"",}, {"",}, 
      {"local", 			TE_LOCAL},
      {"unique", 			TE_UNIQUE},
      {"",}, {"",}, 
      {"when", 			TE_WHEN},
      {"",}, {"",}, 
      {"as", 				TE_AS},
      {"",}, 
      {"from", 			TE_FROM},
      {"alias", 			TE_ALIAS},
      {"",}, {"",}, {"",}, 
      {"once", 			TE_ONCE},
      {"",}, {"",}, 
      {"or", 				TE_OR},
      {"all", 			TE_ALL},
      {"",}, 
      {"infix", 			TE_INFIX},
      {"",}, 
      {"inspect", 		TE_INSPECT},
      {"",}, 
      {"invariant", 		TE_INVARIANT},
      {"",}, 
      {"select", 			TE_SELECT},
      {"feature", 		TE_FEATURE},
      {"external", 		TE_EXTERNAL},
      {"implies", 		TE_IMPLIES},
      {"separate", 		TE_SEPARATE},
      {"",}, {"",}, 
      {"creation", 		TE_CREATION},
      {"",}, 
      {"class", 			TE_CLASS},
      {"rename", 			TE_RENAME},
      {"inherit", 		TE_INHERIT},
      {"",}, {"",}, {"",}, {"",}, 
      {"do", 				TE_DO},
      {"indexing", 		TE_INDEXING},
      {"",}, {"",}, 
      {"frozen", 			TE_FROZEN},
      {"",}, {"",}, {"",}, 
      {"retry", 			TE_RETRY},
      {"result", 			TE_RESULT},
      {"variant", 		TE_VARIANT},
      {"redefine", 		TE_REDEFINE},
      {"true", 			TE_TRUE},
      {"",}, 
      {"loop", 			TE_LOOP},
      {"strip", 			TE_STRIP},
      {"undefine", 		TE_UNDEFINE},
      {"then", 			TE_THEN},
      {"until", 			TE_UNTIL},
      {"precursor", 		TE_PRECURSOR},
      {"",}, 
      {"xor", 			TE_XOR},
      {"",}, {"",}, {"",}, {"",}, 
      {"prefix", 			TE_PREFIX},
      {"",}, {"",}, {"",}, {"",}, 
      {"end", 			TE_END},
      {"",}, {"",}, {"",}, 
      {"current", 		TE_CURRENT},
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"export", 			TE_EXPORT},
      {"",}, 
      {"expanded", 		TE_EXPANDED},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"deferred", 		TE_DEFERRED},
      {"",}, {"",}, {"",}, {"",}, 
      {"old", 			TE_OLD},
      {"",}, 
      {"debug", 			TE_DEBUG},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"",}, {"",}, {"",}, 
      {"not", 			TE_NOT},
      {"",}, {"",}, {"",}, {"",}, 
      {"and", 			TE_AND},
      {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"",}, {"",}, {"",}, {"",}, {"",}, 
      {"bit", 			TE_BIT},
    };

  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
    {
      register int key = hash (str, len);

      if (key <= MAX_HASH_VALUE && key >= 0)
        {
          register char *s = wordlist[key].name;

          if (len == lengthtable[key]
              && *s == *str && !strcmp (str + 1, s + 1))
            return &wordlist[key];
        }
    }
  return 0;
}
