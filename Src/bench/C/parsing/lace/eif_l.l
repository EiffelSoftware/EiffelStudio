%{
/*

 ######  #  ######         #            #
 #       #  #              #            #
 #####   #  #####          #            #
 #       #  #              #        ### #
 #       #  #              #        ### #
 ######  #  #     #######  ######   ### ######

	Lace lexical parsing, looking for classes inside file.
*/

#include "eif_config.h"
#include "eif_portable.h"
#include "eif_macros.h"

#include "lace_y.h"
#include "eif_rtlimits.h"
#include <ctype.h>

/* private functions for lex */
static int get_string();
static int eif_char(char);

%}

%p 3400
%start CLASS INIT

A		([a-z]|[A-Z])
X		([A-Z]|[a-z]|[0-9]|_)
W		[ \t\n\r]
c		[cC]
l		[lL]
a		[aA]
s		[sS]

%%
<INIT,CLASS>--.*			{/* Delete comments first */}
<INIT,CLASS>{W}+			{/* Ignore white space */}
<INIT,CLASS>\"				{ get_string (); }
<INIT>{c}{l}{a}{s}{s}		BEGIN CLASS ;
<CLASS>{A}{X}*				{	BEGIN INIT; return 1;}
.|\n						;
%%

rt_public int zzwrap()
{
	return 1;
}

rt_public int init_lace()
{
	/* This function must be called prior any invocation of the lexical
	 * analyzer. Its purpose is to put the automaton in the known INIT
	 * state. I could have used the undocumented INITIAL state, but this
	 * is not supported everywhere (which is why it's undocumented)--RAM.
	 */

	BEGIN INIT;
}


static int get_string()
{
	char	c, cc;
	int		extension;

	while ((c = input()) != 0 && c != (char) EOF && c != '"') {
		if (c == '%') {
			extension = 0;
			while ((cc = input()) == ' ' || cc == '\t' || cc == '\n' || cc == '\r') {
				extension = 1;
			}
			if (0 == extension) {
				/* It is not an extension: unput read character and try
				 * to recognize an Eiffel character. */
				unput(cc);
				if (-1 == eif_char(c))
					return -1;
			} else {
				/* It is a string extension: blanks, tabs and newlines are
				 * already skipped. */
				c = cc;
				if (c != '%')
					/* Bad extension */
					return -1;
			}
		}
	}
	if (c != '"') {
			/* No final double-quote */
		return -1;
	} else {
		return 0;
	}
}

static int eif_char(char c)
{
	int i;
	int dec_value = 0;

	if (c != '%')
		return (isprint(c) ? (int) c : -1);
	else {
		c = input();
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
				c = input();
				if (c && (c >= '0' && c <= '9'))
					dec_value += ((int) (c - '0')) *
						(100 * (i == 1) + 10 * (i == 2) + (i == 3));
				else
					return -1;
			}
			c = input();
			return (((c == '/') && dec_value < 256) ? dec_value : -1);
		default: return -1;
		}
		/* NOTREACHED */
	}
}

void reset_class_name_parser()
{
#ifdef FLEX_SCANNER
    zzrestart (zzin);
#else
    /* Reset lex parser */
    zzsptr = zzsbuf;
#endif
}

char  *c_clname(FILE *file_pointer)
{
	/* Parse Eiffel source file `file_pointer'. It assumes that the file
	 * has been correctly opened in reading mode.
	 * Return TRUE is it is an Eiffel source file
	 */

	int result;				/* Parsing result */

	zzin = file_pointer;

	/* Parsing */
	init_lace();
	reset_class_name_parser();
	result = zzlex();

	return result ? RTMS(zztext): (char *) 0;
}

