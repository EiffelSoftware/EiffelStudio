/*
	description: "Pre-computes offsets in generated C code to avoid cpp indigestion."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="x2c.c" version="$Id$" summary="Convert .x file into compilable .c files">
*/

#include "eif_eiffel.h"

#ifdef EIF_WINDOWS
#define print_err_msg fprintf
#else
#include "rt_err_msg.h"
#endif

#include "eif_offset.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

rt_private size_t chroff();
rt_private size_t i16off();
rt_private size_t lngoff();
rt_private size_t r32off();
rt_private size_t ptroff();
rt_private size_t r64off();
rt_private size_t objsiz();
rt_private size_t i64off();
rt_private size_t bitoff();

rt_private size_t refacs ();
rt_private size_t chracs ();
rt_private size_t i16acs ();
rt_private size_t lngacs ();
rt_private size_t r32acs ();
rt_private size_t r64acs ();
rt_private size_t i64acs ();
rt_private size_t ptracs ();

rt_private size_t nextarg(void);
rt_private void getarg(int n, char *name);

size_t a[8];		/* Parameters array */

#define nb_ref	a[0]
#define nb_char	a[1]
#define nb_i16	a[2]
#define nb_i32	a[3]
#define nb_r32	a[4]
#define nb_ptr	a[5]
#define nb_i64	a[6]
#define nb_r64	a[7]

#define MAXLEN	6		/* Each macro keyword is 6 characters */

struct parse {
	char *c_macro;		/* Macro name */
	int c_args;			/* Number of arguments */
	size_t (*c_off)();	/* Function to compute value */
} parser[] = {
	{ "REFACS", 1, refacs },
	{ "CHRACS", 1, chracs },
	{ "I16ACS", 1, i16acs },
	{ "LNGACS", 1, lngacs },
	{ "R32ACS", 1, r32acs },
	{ "PTRACS", 1, ptracs },
	{ "R64ACS", 1, r64acs },
	{ "I64ACS", 1, i64acs },
	{ "CHROFF", 2, chroff },
	{ "I16OFF", 3, i16off },
	{ "LNGOFF", 4, lngoff },
	{ "R32OFF", 5, r32off },
	{ "PTROFF", 6, ptroff },
	{ "I64OFF", 7, i64off },
	{ "R64OFF", 8, r64off },
	{ "OBJSIZ", 8, objsiz },
	{ "BITOFF", 1, bitoff },
/* Fixme: to remove when bootstrap done */
	{ "DBLOFF", 8, r64off },
	{ "DBLACS", 1, r64acs },
	{ "FLTOFF", 5, r32off },
	{ "FLTACS", 1, r32acs },
};

rt_private struct parse *locate (char *name);
rt_private void print_usage (void);
rt_private FILE *input_file, *output_file;

int main(int argc, char **argv)
{
	/* Pre-process input (stdin) and outputs new form with resolved offset
	 * macros (introduced by '@') on stdout. C strings and C chars are skipped
	 * since any '@' in them has to stand for itself.
	 */

	int c;
	int in_word = 0;
	int in_string = 0;
	int in_char = 0;
	int in_single_comment = 0;
	int in_multi_comment = 0;
	int last_was_slash = 0;
	int last_was_star = 0;
	int last_was_backslash = 0;
	char buf[MAXLEN + 2];				/* Allow for '\0' and overflow */
	struct parse *ps;
	int pos = 0;
	char xfilename[255];
	char cfilename[255];
	char * suffix;

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
		if (!in_string && !in_char && !in_single_comment && !in_multi_comment) {
			if (!last_was_backslash) {	/* Skip comments and C strings and C chars */
				switch (c) {
				case '"':
					in_string = 1;
					break;
				case '\'':
					in_char = 1;
					break;
				case '/':
					in_single_comment = last_was_slash;
					break;
				case '*':
					in_multi_comment = last_was_slash;
					break;
				}
				if (in_string || in_char || in_single_comment || in_multi_comment) {
					last_was_slash = 0;
					last_was_backslash = 0;
					putc(c, output_file);
					continue;
				}
			}
			last_was_slash = c == '/';
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
		} else if (in_single_comment) {
			if (c == '\n')
				in_single_comment = 0;
			putc(c, output_file);
			continue;
		} else if (in_multi_comment) {
			if (last_was_star && c=='/')
				in_multi_comment = 0;
			last_was_star = c == '*';
			putc(c, output_file);
			continue;
		} else {
			print_err_msg(stdout, "x2c: impossible state.\n");
			exit(1);
		}
		if (!in_word) {
			if (c != '@') {
#ifdef EIF_VMS
				if (c != '\r')		/* VMS: skip <cr> */
#endif
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
				fprintf(output_file, "%ld", (ps->c_off)());
				continue;
			}
			buf[pos++] = (char) c;
		}
	}
	fclose (input_file);
	fclose (output_file);
	exit(0);
	return 0;
}

rt_private void print_usage(void) {
	printf("Usage:    x2c    xfile   [cfile]\n");
	printf("    where        xfile is an input X file (.x suffix is optional)\n");
	printf("    and          cfile is optional output C file.\n");
	printf("    Default suffix for xfile is .x, default suffix for cfile is .c\n");
}	/* print usage */

rt_private struct parse *locate(char *name)
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

#define INVALID_VALUE ((size_t) -1)
rt_private void getarg(int n, char *name)
      				/* Expected number of arguments */
           			/* Macro name (used only for error message) */
{
	/* Extract all the arguments of the macro into tha a[] array, whose items
	 * are #define'd to arguments for offset-calculation routines. Not pretty
	 * but really useful for such a small program--RAM.
	 */

	int i;
	int c;
	size_t val;

	for (i = 0; i < n; i++) {
		val = nextarg();
		if (val == INVALID_VALUE) {
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

rt_private size_t nextarg(void)
{
	/* Extract the next argument from the macro. Arguments are separated by
	 * a ',' and the argument list ends with a ')'. The numerical value of
	 * each (positive) argument is returned, or INVALID_VALUE if no more arguments.
	 */

	int c;
	int pos = 0;
	char buf[BUFSIZ];
	size_t val;

	buf[pos] = '\0';

	while ((c = getc(input_file)) != EOF) {
		if (isspace(c))
			continue;
		if (c == ')')
			ungetc(c, input_file);
		if (c == ',' || c == ')') {
			if (pos == 0)
				return INVALID_VALUE;
			buf[pos] = '\0';
			sscanf(buf, "%ld", &val);
			return val;
		}
		buf[pos++] = (char) c;
		if (pos >= BUFSIZ)
			return INVALID_VALUE;
	}

	return INVALID_VALUE;		/* Not found */
}

/*
 * Offset-calculation routines (take their arguments from a[] array via the `nb_xx' macros).
 */

rt_private size_t chroff() { return eif_chroff(nb_ref) + CHRACS(nb_char); }
rt_private size_t i16off() { return eif_i16off(nb_ref, nb_char) + I16ACS(nb_i16); }
rt_private size_t lngoff() { return eif_lngoff(nb_ref, nb_char, nb_i16) + LNGACS(nb_i32); }
rt_private size_t r32off() { return eif_r32off(nb_ref, nb_char, nb_i16, nb_i32) + R32ACS(nb_r32); }
rt_private size_t ptroff() { return eif_ptroff(nb_ref, nb_char, nb_i16, nb_i32, nb_r32) + PTRACS(nb_ptr); }
rt_private size_t i64off() { return eif_i64off(nb_ref, nb_char, nb_i16, nb_i32, nb_r32, nb_ptr) + I64ACS(nb_i64); }
rt_private size_t r64off() { return eif_r64off(nb_ref, nb_char, nb_i16, nb_i32, nb_r32, nb_ptr, nb_i64) + R64ACS(nb_r64); }
rt_private size_t objsiz() { return eif_objsiz(nb_ref, nb_char, nb_i16, nb_i32, nb_r32, nb_ptr, nb_i64, nb_r64); }

rt_private size_t bitoff () { return BITOFF(a[0]); }
rt_private size_t refacs () { return REFACS(a[0]); } 
rt_private size_t chracs () { return CHRACS(a[0]); }
rt_private size_t i16acs () { return I16ACS(a[0]); }
rt_private size_t lngacs () { return LNGACS(a[0]); }
rt_private size_t r32acs () { return R32ACS(a[0]); }
rt_private size_t r64acs () { return R64ACS(a[0]); }
rt_private size_t i64acs () { return I64ACS(a[0]); }
rt_private size_t ptracs () { return PTRACS(a[0]); }

/*
doc:</file>
*/
