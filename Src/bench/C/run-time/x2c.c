/*
         #####
 #    # #     #   ####            ####
  #  #        #  #    #          #    #
   ##    #####   #               #
   ##   #        #        ###    #
  #  #  #        #    #   ###    #    #
 #    # #######   ####    ###     ####

	Pre-computes offsets in generated C code to avoid cpp indigestion.
*/

#include "config.h"
#include "size.h"
#include <stdio.h>
#include <ctype.h>

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

long chroff(), lngoff(), fltoff(), ptroff(), dbloff(), remainder(), padding();
long objsiz(), nextarg();
void getarg();

long a[6];		/* Parameters array */

#define nb_ref	a[0]
#define nb_char	a[1]
#define nb_int	a[2]
#define nb_flt	a[3]
#define nb_ptr	a[4]
#define nb_dbl	a[5]

#define MAXLEN	6		/* Each macro keyword is 6 characters */

struct parse {
	char *c_macro;		/* Macro name */
	int c_args;			/* Number of arguments */
	long (*c_off)();	/* Function to compute value */
} parser[] = {
	{ "CHROFF", 1, chroff },
	{ "LNGOFF", 2, lngoff },
	{ "FLTOFF", 3, fltoff },
	{ "PTROFF", 4, ptroff },
	{ "DBLOFF", 5, dbloff },
	{ "OBJSIZ", 6, objsiz },
};

struct parse *locate();

void main()
{
	/* Pre-process input (stdin) and outputs new form with resolved offset
	 * macros (introduced by '@') on stdout. C strings and C chars are skipped
	 * since any '@' in them has to stand for itself.
	 */

	int c;
	int in_word = 0;
	int in_string = 0;
	int in_char = 0;
	int last_was_backslash = 0;
	char buf[MAXLEN + 2];				/* Allow for '\0' and overflow */
	struct parse *ps;
	int pos;

	while ((c = getchar()) != EOF) {
		if (!in_string && !in_char) {
			if (!last_was_backslash) {	/* Skip C strings and C chars */
				switch (c) {
				case '"':
					in_string = 1;
					break;
				case '\'':
					in_char = 1;
					break;
				}
				if (in_string || in_char) {
					putchar(c);
					continue;
				}
			}
			last_was_backslash = c == '\\' && !last_was_backslash;
		} else if (in_string) {
			if (c == '"' && !last_was_backslash)
				in_string = 0;
			last_was_backslash = c == '\\' && !last_was_backslash;
			putchar(c);
			continue;
		} else if (in_char) {
			if (c == '\'' && !last_was_backslash)
				in_char = 0;
			last_was_backslash = c == '\\' && !last_was_backslash;
			putchar(c);
			continue;
		} else {
			fprintf(stderr, "x2c: impossible state.\n");
			exit(1);
		}
		if (!in_word) {
			if (c != '@') {
				putchar(c);
				continue;
			}
			in_word = 1;
			pos = 0;
			buf[pos] = '\0';
			continue;
		} else {
			if (c == '@') {				/* Hmm..., got another '@' !? */
				buf[pos] = '\0';
				printf("@%s", buf);		/* Print what we got so far */
				pos = 0;				/* And restart with new word */
				buf[pos] = '\0';
				continue;
			}
			if (c == '(' || pos > MAXLEN) {
				in_word = 0;
				buf[pos] = '\0';
				if (pos > MAXLEN || 0 == (ps = locate(buf))) {
					printf("@%s%c", buf, c);
					continue;
				}
				getarg(ps->c_args, buf);
				printf("%d", (ps->c_off)());
				continue;
			}
			buf[pos++] = c;
		}
	}
	exit(0);
}

struct parse *locate(name)
char *name;
{
	/* Locate macro in parsing array and return the structure corresponding
	 * to that macro. If the macro is not recognized, return a null pointer.
	 */

	int i;

	for (i = 0; i < sizeof(parser) / sizeof(struct parse); i++) {
		if (0 == strcmp(parser[i].c_macro, name))
			return &parser[i];
	}

	return (struct parse *) 0;
}

void getarg(n, name)
int n;				/* Expected number of arguments */
char *name;			/* Macro name (used only for error message) */
{
	/* Extract all the arguments of the macro into tha a[] array, whose items
	 * are #define'd to arguments for offset-calculation routines. Not pretty
	 * but really useful for such a small program--RAM.
	 */

	int i;
	int c;
	int val;

	for (i = 0; i < n; i++) {
		val = nextarg();
		if (val == -1) {
			fprintf(stderr,
				"x2c: warning: macro %s has %d argument%s, expected %d\n",
				name, i, i == 1 ? "" : "s", n);
			for (; i < n; i++)
				a[i] = 0;
			break;
		} 
		a[i] = val;
	}

	c = getchar();
	if (c != ')' && c != EOF)
		ungetc(c, stdin);
}

long nextarg()
{
	/* Extract the next argument from the macro. Arguments are separated by
	 * a ',' and the argument list ends with a ')'. The numerical value of
	 * each (positive) argument is returned, or -1 if no more arguments.
	 */

	int c;
	int pos = 0;
	char buf[BUFSIZ];
	long val;

	buf[pos] = '\0';

	while ((c = getchar()) != EOF) {
		if (isspace(c))
			continue;
		if (c == ')')
			ungetc(c, stdin);
		if (c == ',' || c == ')') {
			if (pos == 0)
				return -1;
			buf[pos] = '\0';
			sscanf(buf, "%d", &val);
			return val;
		}
		buf[pos++] = c;
		if (pos >= BUFSIZ)
			return -1;
	}

	return -1;		/* Not found */
}

/*
 * Offset-calculation routines (take their arguments from a[] arary).
 */

long chroff()
{
	long to_add = nb_ref * REFSIZ;
	return to_add + padding(to_add, (long) CHRSIZ);
}

long lngoff()
{
	long to_add = chroff() + nb_char *CHRSIZ;
	return to_add + padding(to_add,(long)  LNGSIZ);
}

long fltoff()
{
	long to_add = lngoff() + nb_int * LNGSIZ;
	return to_add + padding(to_add, (long) FLTSIZ);
}

long ptroff()
{
	long to_add = fltoff() + nb_flt * FLTSIZ;
	return to_add + padding(to_add, (long) PTRSIZ);
}

long dbloff()
{
	long to_add = ptroff() + nb_ptr * PTRSIZ;
	return to_add + padding(to_add, (long) DBLSIZ);
}

long objsiz()
{
	long to_add = dbloff() + nb_dbl * DBLSIZ;
	return to_add + remainder(to_add);
}

/*
 * Private functions definitions
 */

long remainder(x)
long x;
{
	return ((x % ALIGN) ? (ALIGN -(x % ALIGN)) : 0);
}

long padding(x,y)
long x,y;
{
	return remainder(x) % y;
}

