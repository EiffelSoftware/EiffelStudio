%{
/*

 #         ##     ####   ######          #               #
 #        #  #   #    #  #               #               #
 #       #    #  #       #####           #               #
 #       ######  #       #               #        ###    #
 #       #    #  #    #  #               #        ###    #
 ######  #    #   ####   ###### #######  ######   ###    ######

	Lace lex analyzer description
*/

#include "eif_config.h"
#include "lace_y.h"
#include "eif_rtlimits.h"
#include "eif_err_msg.h"
#include <ctype.h>
#include "yacc.h"

#ifdef EIF_WIN32
#include <io.h>
#endif

/* private functions for lex */
static int process();
static int process_name();
static int get_string();
static int eif_char(char);

/* Global variables */
extern struct location *current_location;   /* Record the position of the first, and the 
											 * last character in last token 
											 * Record also the line number of the token */
extern char token_str[];

/* For gperf */
struct token {
	char *name;
	int yaccval;
};

extern struct token *in_word_set2();

%}

%%
[ \t\n\r]+								{	current_location->start_position = current_location->end_position;
											current_location->end_position += xxleng;}
:										return process(LAC_COLUMN);
","										return process(LAC_COMMA);
--.*									{	current_location->start_position = current_location->end_position;
											current_location->end_position += xxleng;}
"("										return process(LAC_LEFT_PARAM);
")"										return process(LAC_RIGHT_PARAM);
";"										return process(LAC_SEMICOLON);
\"										return get_string();
([a-z]|[A-Z])([a-z]|_|[A-Z]|[0-9])*		return process_name(LAC_IDENTIFIER);
.										{	/* Unknown character */
											current_location->start_position = current_location->end_position;
											current_location->end_position += xxleng;
											xxerror ((char *) 0);}

%%

static int process(int token_code)
{
	/* Process a token updating global variables `start_position' and
	 * `end_position'.
	 */
	current_location->start_position = current_location->end_position;
	current_location->end_position += xxleng;
	return token_code;
}

static int process_name(int token_code)
{
	/* Process an identifier. */
	
	int i, length;
	char c;
	struct token *key;
	
	/* truncation of identifiers */
	length= xxleng;

	if (length >= IDLENGTH)
		return LAC_ERROR7;

	/* Copy into `token_str' */
	strncpy(token_str,xxtext,length);
	token_str[length]= '\0';

	/* Conversion into lower case characters */
	for (i=0; i<=length; i++) {
		c = token_str[i];
		if (isupper(c))
			token_str[i] = tolower(c);
	}
#ifdef GETDEBUG
	print_err_msg(stderr,"Name = %s\n", token_str);
#endif

	/* Check for a keyword */
	key = in_word_set2(token_str, length);
	if (key)
		return process(key->yaccval);		/* Was a keyword */
	else
		return process(token_code);			/* Normal identifier */
}
	

/*
 * Getting strings
 */

static int get_string()
{
	/* Return an Eiffel string in token_str. */

	char	*s;
	char	c, cc;
	int		extension, n=0, char_value;

	s = token_str;			/* Statically allocated buffer */
	current_location->start_position = current_location->end_position;
	current_location->end_position++;

	while ((c = input()) != 0 && c != (char) EOF && c != '"' && n < STRINGLENGTH) {
		current_location->end_position++;
		if (c == '%') {
			extension = 0;
			while ((cc = input()) == ' ' || cc == '\t' || cc == '\n' || cc == '\r') {
				extension = 1;
				current_location->end_position++;
			}
			if (0 == extension) {
				/* It is not an extension: unput read character and try
				 * to recognize an Eiffel character. */
				unput(cc);
				char_value = eif_char(c);
				if (-1 == char_value)
					return LAC_ERROR3;
				else {
					/* Recognized one character */
					*s++ = (char) char_value; n++;
				}
			} else {
				/* It is a string extension: blanks, tabs and newlines are
				 * already skipped. */
				c = cc;
				if (c != '%')
					/* Bad extension */
					return LAC_ERROR3;
				else
					current_location->end_position++;
			}
		} else {
			*s++ = c; n++;
		}
	}
	if (n >= STRINGLENGTH) {
			/* String too long */
		return LAC_ERROR2;
	} else if (c != '"') {
			/* No final double-quote */
		return LAC_ERROR4;
	} else {
		*s= '\0';
		if (s == token_str)
			return LAC_ERROR6;
		else
			current_location->end_position++;
			return LAC_STRING;
	}
}

static int eif_char(char c)
{
	int i;
	int dec_value = 0;

	if (c != '%')
		return (isprint(c) ? (int) c : -1);
	else {
		c = input(); current_location->end_position++;
		switch (c) {
		case 'A': return (int) '@';
		case 'B': return (int) '\t';
		case 'C': return (int) '^';
		case 'D': return (int) '$';
		case 'F': return (int) '\014';
		case 'H': return (int) '\134';
		case 'L': return (int) '\176';
		case 'N': return (int) '\012';
		case 'Q': return (int) '\140';
		case 'R': return (int) '\015';
		case 'S': return (int) '\043';
		case 'T': return (int) '\011';
		case 'U': return (int) '\000';
		case 'V': return (int) '|';
		case '%': return (int) '%';
		case '\047': return (int) '\047';
		case '"': return (int) '"';
		case '(': return (int) '[';
		case ')': return (int) ']';
		case '<': return (int) '{';
		case '>': return (int) '}';
		case '\000': return -1;
		case '/':
			for (i=1; i<4; i++) {
				c = input(); current_location->end_position++;
				if (c && (c >= '0' && c <= '9'))
					dec_value += ((int) (c - '0')) *
						(100 * (i == 1) + 10 * (i == 2) + (i == 3));
				else
					return -1;
			}
			c = input(); current_location->end_position++;
			return (((c == '/') && dec_value < 256) ? dec_value : -1);
		default: return -1;
		}
		/* NOTREACHED */
	}
}

void reset_lace_lex_parser()
{
#ifdef FLEX_SCANNER
	xxrestart (xxin);
#else
	/* Reset lex parser */
	xxsptr = xxsbuf;
#endif
}
