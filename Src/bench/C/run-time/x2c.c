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

#include "eif_config.h"
#include "eif_size.h"
#ifdef EIF_WINDOWS
#define print_err_msg fprintf		/* %%zs modified - was 'printf' before... (incorrect because trying print_err_msg(stderr,"..."); line 96 and others ! */
#else
#include "eif_err_msg.h"
#endif
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif


long chroff(void), lngoff(void), fltoff(void), ptroff(void), dbloff(void), remainder(long int x), padding(long int x, long int y);
long objsiz(void), nextarg(void);
void getarg(int n, char *name);

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

struct parse *locate(char *name);

void	print_usage(void);

FILE *input_file, *output_file;

int main(int argc, char **argv)	/* DEC C will complain if declared as type void */


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
	char xfilename[255];
	char cfilename[255];
	char * suffix;

/* 950405/TomH	modified run string argument processing
 *	Usage:	x2c	file.x	[file.c]
 *		Second file name and suffixes are now optional.
 *		If file.c is not supplied, default is to strip .x from
 *		first file and add .c suffix.
 *		Default suffix for first file is ".x"
 *		If incorrect run string, usage is displayed to user.
 */

	if (( argc < 2 ) || ( argc > 3 )){
		print_err_msg(stderr, "x2c: wrong number of arguments.\n");
		print_usage();
		exit (1);
	}
	strcpy(xfilename,argv[1]);
	suffix = strrchr(xfilename,'.');
	if (suffix == NULL) {
		/* add .x if no suffix present */
		strcat(xfilename,".x");
	}
	if (argc == 2) {
		/* argc=2 means no C file name in run string */
		strcpy(cfilename,xfilename);
		suffix = strrchr(cfilename,'.');
		if (suffix != NULL) {
			/* convert .x suffix to .c */
			*suffix = '\0';
			strcat(cfilename,".c");
		}
	}
	else	{ /* argc=3 */
		strcpy(cfilename,argv[2]);
	}
	suffix = strrchr(cfilename,'.');
	if (suffix == NULL) {
		strcat(cfilename,".c");
	}	/* didn't find . */

	if ((input_file = fopen (xfilename, "r")) == (FILE *)0){
		print_err_msg(stderr, "x2c: cannot open input file %s\n",
			xfilename);
		exit (1);
		}
	if ((output_file = fopen (cfilename, "w")) == (FILE *)0){
		print_err_msg(stderr,"x2c: cannot open output file %s\n",
			cfilename);
		exit (1);
		}

	while ((c = getc(input_file)) != EOF) {
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
					putc(c, output_file);
					continue;
				}
			}
			last_was_backslash = c == '\\' && !last_was_backslash;
		} else if (in_string) {
			if (c == '"' && !last_was_backslash)
				in_string = 0;
			last_was_backslash = c == '\\' && !last_was_backslash;
			putc(c, output_file);
			continue;
		} else if (in_char) {
			if (c == '\'' && !last_was_backslash)
				in_char = 0;
			last_was_backslash = c == '\\' && !last_was_backslash;
			putc(c, output_file);
			continue;
		} else {
			print_err_msg(stderr, "x2c: impossible state.\n");
			exit(1);
		}
		if (!in_word) {
			if (c != '@') {
				putc(c, output_file);
				continue;
			}
			in_word = 1;
			pos = 0;
			buf[pos] = '\0';
			continue;
		} else {
			if (c == '@') {				/* Hmm..., got another '@' !? */
				buf[pos] = '\0';
				fprintf(output_file, "@%s", buf);		/* Print what we got so far */
				pos = 0;				/* And restart with new word */
				buf[pos] = '\0';
				continue;
			}
			if (c == '(' || pos > MAXLEN) {
				in_word = 0;
				buf[pos] = '\0';
				if (pos > MAXLEN || 0 == (ps = locate(buf))) {
					fprintf(output_file, "@%s%c", buf, c);
					continue;
				}
				getarg(ps->c_args, buf);
				fprintf(output_file, "%d", (ps->c_off)());
				continue;
			}
			buf[pos++] = c;
		}
	}
	fclose (input_file);
	fclose (output_file);
	exit(0);
}

void print_usage(void) {
	printf("Usage:    x2c    xfile   [cfile]\n");
	printf("    where        xfile is an input X file (.x suffix is optional)\n");
	printf("    and          cfile is optional output C file.\n");
	printf("    Default suffix for xfile is .x, default suffix for cfile is .c\n");
}	/* print usage */

struct parse *locate(char *name)
{
	/* Locate macro in parsing array and return the structure corresponding
	 * to that macro. If the macro is not recognized, return a null pointer.
	 */

	int i;
	static const int sz_ratio = sizeof (parser) / sizeof(struct parse);

	for (i = 0; i < sz_ratio; i++) {
		if (0 == strcmp(parser[i].c_macro, name))
			return &parser[i];
	}

	return (struct parse *) 0;
}

void getarg(int n, char *name)
      				/* Expected number of arguments */
           			/* Macro name (used only for error message) */
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
			print_err_msg(stderr,
				"x2c: warning: macro %s has %d argument%s, expected %d\n",
				name, i, i == 1 ? "" : "s", n);
			for (; i < n; i++)
				a[i] = 0;
			break;
		}
		a[i] = val;
	}

	c = getc(input_file);
	if (c != ')' && c != EOF)
		ungetc(c, input_file);
}

long nextarg(void)
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

	while ((c = getc(input_file)) != EOF) {
		if (isspace(c))
			continue;
		if (c == ')')
			ungetc(c, input_file);
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

long chroff(void)
{
	long to_add = nb_ref * REFSIZ;
	return to_add + padding(to_add, (long) CHRSIZ);
}

long lngoff(void)
{
	long to_add = chroff() + nb_char *CHRSIZ;
	return to_add + padding(to_add,(long)  LNGSIZ);
}

long fltoff(void)
{
	long to_add = lngoff() + nb_int * LNGSIZ;
	return to_add + padding(to_add, (long) FLTSIZ);
}

long ptroff(void)
{
	long to_add = fltoff() + nb_flt * FLTSIZ;
	return to_add + padding(to_add, (long) PTRSIZ);
}

long dbloff(void)
{
	long to_add = ptroff() + nb_ptr * PTRSIZ;
	return to_add + padding(to_add, (long) DBLSIZ);
}

long objsiz(void)
{
	long to_add = dbloff() + nb_dbl * DBLSIZ;
	return to_add + remainder(to_add);
}

/*
 * Private functions definitions
 */

long remainder(long int x)
{
	return ((x % ALIGN) ? (ALIGN -(x % ALIGN)) : 0);
}

long padding(long int x, long int y)
{
	return remainder(x) % y;
}

