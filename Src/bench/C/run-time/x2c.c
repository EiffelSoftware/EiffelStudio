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

#include "eif_portable.h"
#include "x2c.h"
#ifdef EIF_WINDOWS
#define print_err_msg fprintf
#else
#include "eif_err_msg.h"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define NON_RECURSIVE	'0'
#define RECURSIVE		'1'

extern long chroff(char recursive_call);
extern long i16off(char recursive_call);
extern long lngoff(char recursive_call);
extern long fltoff(char recursive_call);
extern long ptroff(char recursive_call);
extern long dbloff(char recursive_call);
extern long objsiz(char recursive_call);
extern long i64off(char recursive_call);
extern long bitoff(char recursive_call);

extern long refacs (char recursive_call);
extern long chracs (char recursive_call);
extern long i16acs (char recursive_call);
extern long lngacs (char recursive_call);
extern long fltacs (char recursive_call);
extern long dblacs (char recursive_call);
extern long i64acs (char recursive_call);
extern long ptracs (char recursive_call);

extern long remainder(long int x);
extern long padding(long int x, long int y);

extern long nextarg(void);
extern void getarg(int n, char *name);

long a[8];		/* Parameters array */

#define first_argument		a[0]
#define second_argument		a[1]
#define third_argument		a[2]
#define fourth_argument		a[3]
#define fifth_argument		a[4]
#define sixth_argument		a[5]
#define	seventh_argument	a[6]
#define eigth_argument		a[7]

#define nb_ref	a[0]
#define nb_char	a[1]
#define nb_i16	a[2]
#define nb_int	a[3]
#define nb_flt	a[4]
#define nb_ptr	a[5]
#define nb_i64	a[6]
#define nb_dbl	a[7]

#define MAXLEN	6		/* Each macro keyword is 6 characters */

struct parse {
	char *c_macro;		/* Macro name */
	int c_args;			/* Number of arguments */
	long (*c_off)(char);	/* Function to compute value */
} parser[] = {
	{ "REFACS", 1, refacs },
	{ "CHRACS", 1, chracs },
	{ "LNGACS", 1, lngacs },
	{ "FLTACS", 1, fltacs },
	{ "PTRACS", 1, ptracs },
	{ "DBLACS", 1, dblacs },
	{ "CHROFF", 2, chroff },
	{ "I16OFF", 3, i16off },
	{ "LNGOFF", 4, lngoff },
	{ "FLTOFF", 5, fltoff },
	{ "PTROFF", 6, ptroff },
	{ "I64OFF", 7, i64off },
	{ "DBLOFF", 8, dbloff },
	{ "OBJSIZ", 8, objsiz },
	{ "BITOFF", 1, bitoff },
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
	int pos = 0;
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
		print_err_msg(stdout, "x2c: wrong number of arguments.\n");
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
		print_err_msg(stdout, "x2c: cannot open input file %s\n",
			xfilename);
		exit (1);
		}
	if ((output_file = fopen (cfilename, "w")) == (FILE *)0){
		print_err_msg(stdout,"x2c: cannot open output file %s\n",
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
			print_err_msg(stdout, "x2c: impossible state.\n");
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
				fprintf(output_file, "%ld", (ps->c_off)(NON_RECURSIVE));
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
			print_err_msg(stdout,
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
			sscanf(buf, "%ld", &val);
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

long chroff(char recursive_call)
{
	long to_add = nb_ref * REFSIZ;
	if (recursive_call == RECURSIVE)
		return to_add + padding(to_add, (long) CHRSIZ);
	else
		return to_add + padding(to_add, (long) CHRSIZ) + CHRACS(second_argument);
}

long i16off(char recursive_call)
{
	long to_add = chroff(RECURSIVE) + nb_char *CHRSIZ;
	if (recursive_call == RECURSIVE)
		return to_add + padding(to_add,(long)  I16SIZ);
	else
		return to_add + padding(to_add,(long)  I16SIZ) + I16ACS(third_argument);
}

long lngoff(char recursive_call)
{
	long to_add = i16off(RECURSIVE) + nb_i16 *I16SIZ;
	if (recursive_call == RECURSIVE)
		return to_add + padding(to_add,(long)  LNGSIZ);
	else
		return to_add + padding(to_add,(long)  LNGSIZ) + LNGACS(fourth_argument);
}

long fltoff(char recursive_call)
{
	long to_add = lngoff(RECURSIVE) + nb_int * LNGSIZ;
	if (recursive_call == RECURSIVE)
		return to_add + padding(to_add, (long) FLTSIZ);
	else
		return to_add + padding(to_add, (long) FLTSIZ) + FLTACS(fifth_argument);
}

long ptroff(char recursive_call)
{
	long to_add = fltoff(RECURSIVE) + nb_flt * FLTSIZ;
	if (recursive_call == RECURSIVE)
		return to_add + padding(to_add, (long) PTRSIZ);
	else
		return to_add + padding(to_add, (long) PTRSIZ) + PTRACS(sixth_argument);
}

long i64off(char recursive_call)
{
	long to_add = ptroff(RECURSIVE) + nb_ptr * PTRSIZ;
	if (recursive_call == RECURSIVE)
		return to_add + padding(to_add, (long) I64SIZ);
	else
		return to_add + padding(to_add, (long) I64SIZ) + I64ACS(seventh_argument);
}

long dbloff(char recursive_call)
{
	long to_add = i64off(RECURSIVE) + nb_i64 * PTRSIZ;
	if (recursive_call == RECURSIVE)
		return to_add + padding(to_add, (long) DBLSIZ);
	else
		return to_add + padding(to_add, (long) DBLSIZ) + DBLACS(eigth_argument);
}

long objsiz(char recursive_call)
{
	long to_add = dbloff(RECURSIVE) + nb_dbl * DBLSIZ;
	return to_add + remainder(to_add);
}

long bitoff (char recursive_call) { return BITOFF(first_argument); }
long refacs (char recursive_call) { return REFACS(first_argument); } 
long chracs (char recursive_call) { return CHRACS(first_argument); }
long i16acs (char recursive_call) { return I16ACS(first_argument); }
long lngacs (char recursive_call) { return LNGACS(first_argument); }
long fltacs (char recursive_call) { return FLTACS(first_argument); }
long dblacs (char recursive_call) { return DBLACS(first_argument); }
long i64acs (char recursive_call) { return I64ACS(first_argument); }
long ptracs (char recursive_call) { return PTRACS(first_argument); }

/*
 * Private functions definitions
 */

long remainder(long int x) { return ((x % ALIGN) ? (ALIGN -(x % ALIGN)) : 0); }
long padding(long int x, long int y) { return remainder(x) % y; }

