%{
/*

 ######     #    ######  ######  ######  #               #
 #          #    #       #       #       #               #
 #####      #    #####   #####   #####   #               #
 #          #    #       #       #       #        ###    #
 #          #    #       #       #       #        ###    #
 ######     #    #       #       ######  ######   ###    ######

			Eiffel Lex analyzer description

Copyright (C) 1992, 1993, 1994, 1995, Interactive Software Engineering Inc.
All rights reserved. Duplication and distribution prohibited without
prior agreement with Interactive Software Engineering.

270 Storke Road, Suite 7, Goleta, CA 93117 USA
Telephone 805-685-1006
Fax 805-685-6869
Electronic mail <info@eiffel.com>
Customer support e-mail <support@eiffel.com>

Web server: http://www.eiffel.com
Ftp server: ftp.eiffel.com

*/

#include <ctype.h>

#include "eif_rtlimits.h" 	
#include "eif_macros.h"
#include "parser.h"
#include "yacc.h"

#ifdef EIF_WIN32
#include <io.h>
#endif

#define MAX_CHAR	256			/* Ascii limit */

/*
 * Static declarations
 */

static int get_string();		/* Read a string (after a double quote) */
static int get_char();			/* Read a char (after a single quote) */
static int eif_char(char);		/* Eiffel character value */

static int	process(int);			/* Update position marks */
static int 	process_name(int);		/* Update position marks for ids */
static int 	process_int();		/* Remove underscores from integer values */
static int 	process_bit();		/* Process bit value */
static int 	process_tilde(int);		/* Process number of tildes */

/*
 * Extern declarations
 */

extern int inherit_context;		/* Flag for context sensitivity of
								 * token TE_END */
extern struct location *current_location;		/* Position marks */

extern char token_str[];		/* Buffer for ids and strings */

struct token {					/* For gperf */
	char *name;					/* This is the keyword value */
	int yaccval;				/* Value to be returned to yacc */
};

extern struct token *in_word_set();		/* Pointer to static data */


/* defined in eif_err.c */
extern void yyerror (char *);	/* Raise a syntax error */

/*
 * Macros for lexical analyzer input 
 */

#ifndef FLEX_SCANNER

#undef input
#define input()	(((yytchar=yysptr>yysbuf?U(*--yysptr):getc(yyin))==10?(yylineno++,yytchar):yytchar)==EOF?\
						(inherit_context ? '\001': 0): \
						yytchar)
#endif

%}

D		[0-9]
O		[0-7]	
E		(((e|E)[+-]?{D}+)?)
A		([a-z]|[A-Z])
X		([a-z]|[A-Z]|[0-9]|_)
W		[ \t\n\r]
T		[0-9][0-9][0-9]
U		([0-9]|[0-9][0-9]|[0-9][0-9][0-9])

%%
--.*						{	current_location->start_position = current_location->end_position;
								current_location->end_position += yyleng;
								current_location->line_number = yylineno;}
[ \t\n\r]+					{	current_location->start_position = current_location->end_position;
								current_location->end_position += yyleng;
								current_location->line_number = yylineno;}
{D}+/".."					{return process_name(TE_INTEGER);}
";"							{return process(TE_SEMICOLON);}
":"							{return process(TE_COLON);}
","							{return process(TE_COMMA);}
".."						{return process(TE_DOTDOT);}
"."							{return process(TE_DOT);}
"}.."						{return process(TE_CURLYDOTDOT);}
"$"							{return process(TE_ADDRESS);}
":="						{return process(TE_ASSIGN);}
"?="						{return process(TE_ACCEPT);}
"="							{return process(TE_EQ);}
"<"							{return process(TE_LT);}
">"							{return process(TE_GT);}
"<="						{return process(TE_LE);}
">="						{return process(TE_GE);}
"/="						{return process(TE_NE);}
"("							{return process(TE_LPARAN);}
")"							{return process(TE_RPARAN);}
"{"							{return process(TE_LCURLY);}
"}"							{return process(TE_RCURLY);}
"["							{return process(TE_LSQURE);}
"]"							{return process(TE_RSQURE);}
"+"							{return process(TE_PLUS);}
"-"							{return process(TE_MINUS);}
"*"							{return process(TE_STAR);}
"/"							{return process(TE_SLASH);}
"^"							{return process(TE_POWER);}
"->"  						{return process(TE_CONSTRAIN);}
"!"							{return process(TE_BANG);}
"<<"						{return process(TE_LARRAY);}
">>"						{return process(TE_RARRAY);}
(@|#|\||&)[@#0-9a-zA-Z_!\"\$&\'\(\)\*\+\,\-\./:;<>=\?\[\\\]\^\`\{\}\|\~%]*	{return process_name(TE_FREE);}
"//"						{return process(TE_DIV);}
"\\\\"						{return process(TE_MOD);}
{A}{X}*						{return process_name(TE_ID);}
[0-1]+[bB]					{return process_bit();}
({U}(_{D}{D}{D})*)|{D}+		{return process_int();}
({D}*\.{D}+{E})|({D}+\.{D}*{E})|({U}(_{T})*)?\.(({T}_)*{U})?{E}|{U}(_{T})*\.((({T}_)*{U})?{E}) {return process_name(TE_REAL); }
\"							{return get_string();}
\'							{return get_char();}
<<EOF>>						{
								/* This rule has to be removed when compiling with `lex'.
								 * and the extra rule: \1	{return process(TE_END);} has to be added
								 */

								if (inherit_context) {
									inherit_context = 0;
									return process(TE_END);
								} else
									yyterminate();
							}
.							{	current_location->start_position = current_location->end_position;
								current_location->end_position += yyleng;
								current_location->line_number = yylineno;
								yyerror ((char *) 0);}
%%

/*
 * Managing `start_position' and `end_position'
 */

static int process(int token_code)
{
	/* Process a token updating global variables `start_position' and
	 * `end_position'.
	 */
	inherit_context = 0;
	current_location->start_position = current_location->end_position;
	current_location->end_position += yyleng;
	current_location->line_number = yylineno;
	return token_code;
}

static int process_name(int token_code)
{
	/* Process an identifier. */

	int i, length;
	char c;
	struct token *key;
	
	/* truncation of identifiers */
	length= yyleng;
	
	if (length >= IDLENGTH)
		return EIF_ERROR7;

	/* Copy into `token_str' */
	strncpy(token_str,yytext,length);
	token_str[length]= '\0';

	/* Conversion into lower case characters */
	for (i=0; i<=length; i++) {
		c = token_str[i];
		if (isupper(c))
			token_str[i] = tolower(c);
	}

	/* Check for a keyword */
	key = in_word_set(token_str, length);
	if (key)
		return process(key->yaccval);	/* Was a keyword */
	else
		return process(token_code);		/* Normal identifier */
}
	
static int process_int()
{
	/* Process integer value */

	int i;
	char c;
	char *s;

	for(s = token_str, i=0; i<=yyleng; i++) {
		c = yytext[i];
		if (c != '_')
			*s++ = c;
	}
	*s = '\0';

	return process(TE_INTEGER);
}
			
static int process_bit()
{
	/* Process bit value; get rid of the suffix */

	int length;

	length = yyleng;

	if (length >= IDLENGTH)
		return EIF_ERROR7;

	strncpy(token_str,yytext,length - 1);
	token_str[length-1] = '\0';

	return process(TE_A_BIT);
}

/*
 * Getting characters and strings
 */

static int get_char()
{
	/* Try to recognize an eiffel character */

	char *s, c;
	int	char_value;

	s = token_str;		/* Statically allocated buffer */
	inherit_context = 0;
	current_location->start_position = current_location->end_position;
	current_location->end_position++;
	current_location->line_number = yylineno;

	c = input(); current_location->end_position++;
	if (c == 0 || c == (char) EOF)
		/* Flex and lex don't return the same value on EOF */
		/* Bad character: no more input */
		return EIF_ERROR5;
	else {
		char_value = eif_char(c);
		if (-1 == char_value)
			/* Bad character: no more input or unvalid character */
			return EIF_ERROR5;
		else {
			*s++ = (int) char_value;
			c = input(); current_location->end_position++;
			if (c == '\'') {
				/* Recognition successfull */
				*s = '\0';
				return TE_CHAR;
			} else
				/* Bad character: no more input */
				return EIF_ERROR5;
		}
	}
}

static int get_string()
{
	/* Return an Eiffel string in token_str. */

	char	*s;
	char	c, cc;
	int		extension, n=0, char_value;

	s = token_str;			/* Statically allocated buffer */
	inherit_context = 0;
	current_location->start_position = current_location->end_position;
	current_location->end_position++;
	current_location->line_number = yylineno;

	while ((c = input()) != 0 && c != (char) EOF && c != '"' && n < STRINGLENGTH && c != '\n') {
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
					return EIF_ERROR3;
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
					return EIF_ERROR3;
				else
					current_location->end_position++;
			}
		} else {
			*s++ = c; n++;
		}
	}
	if (n >= STRINGLENGTH) {
			/* String too long */
		return EIF_ERROR2;
	} else if (c != '"') {
			/* No final double-quote */
		return EIF_ERROR4;
	} else {
		current_location->end_position++;
		*s= '\0';
		if (s == token_str)
				/* empty string (it is allowed only in some
					manifest strings) */
			return EIF_ERROR6;
		else
			return TE_STRING;
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
		case 'B': return (int) '\b';
		case 'C': return (int) '^';
		case 'D': return (int) '$';
		case 'F': return (int) '\f';
		case 'H': return (int) '\\';
		case 'L': return (int) '~';
		case 'N': return (int) '\n';
		case 'Q': return (int) '`';
		case 'R': return (int) '\r';
		case 'S': return (int) '#';
		case 'T': return (int) '\t';
		case 'U': return (int) '\0';
		case 'V': return (int) '|';
		case '%': return (int) '%';
		case '\'': return (int) '\'';
		case '"': return (int) '"';
		case '(': return (int) '[';
		case ')': return (int) ']';
		case '<': return (int) '{';
		case '>': return (int) '}';
		case '\000': return -1;
		case '/':
            c = input();
			current_location->end_position++;
			for (i=1; i<4 && c != '/'; i++) {
				if (c && (c >= '0' && c <= '9'))
					dec_value =  dec_value * 10 + ((int) (c - '0')) ;
				else
					return -1;
				c = input(); current_location->end_position++;
			}
			return (((c == '/') && (i > 1) &&  (dec_value < MAX_CHAR)) ? dec_value : -1);
		default: return -1;
		}
		/* NOTREACHED */
	}
}

void reset_eiffel_lex_parser()
{
#ifdef FLEX_SCANNER
	yyrestart (yyin);
#else
	/* Reset lex buffer: no more lookahead tokens */
	yysptr = yysbuf;
#endif
}
