/*
	ARGCAGRV.C - processing for the startup of the application
		allows for an application started under the debugger
		and adjusts the command line and argument count appropriately.

	An application under the debugger has 2 extra arguments the in and out pipes
	in uuencoded form for passing as strings.

	Also the cleanup processing is held in this file.
*/
#include <windows.h>

#include "eif_argcargv.h"
#include "eif_econsole.h"
#include "eif_lmalloc.h"
#include "eif_except.h"		/* For `eraise' */

#define EIF_CLEANUP_TABLE_SIZE 20		/* Clean up table size */

EIF_CLEANUP eif_fn_table [EIF_CLEANUP_TABLE_SIZE];
int eif_fn_count = 0;

rt_public HANDLE ghInstance;
rt_public HINSTANCE eif_hInstance;
rt_public HINSTANCE eif_hPrevInstance;
rt_public LPSTR eif_lpCmdLine;
rt_public int eif_nCmdShow;

static char *temp = NULL;
rt_private void shword(char *cmd, int *argc, char ***argvp);

rt_public void get_argcargv (int *argc, char ***argv)
{
	int tl;
	temp = strdup (GetCommandLine());

		/* Only for Application that are launched from EiffelBench:
		* Add a `\0' just before the string which contains the "pipes" that
		* have been uuencoded, so that we are only giving the command line arguments
		* that the program needs.
		*/
	tl = strlen (temp);
	if ((tl > 16) && (temp[tl-1] == '"') && (temp[tl-2] == '?') &&
			(temp[tl-16] == '"') && (temp[tl-15] == '?') && (temp[tl-17] == ' ')) {
		temp[tl-17] = '\0';
	}
	
	*argc = 0;
	shword (temp, argc, argv);
}

rt_public void free_argv(char ***argv)
{
	eif_free((*argv)[0]);
	eif_free(*argv);
	*argv = NULL;
}

rt_private void shword(char *cmd, int *argc, char ***argvp)
{
	/* Break the shell command held in 'cmd', putting each shell word
	 * in a separate array entry, hence building an argument
	 * suitable for the execvp() system call.
	 */

	int quoted = 0;	/* parsing inside a quoted string? */
	int nbs;		/* number of backspaces */
	int i;
	char *p = NULL, *pe = NULL;	/* pointers in `cmd' */
	char *qb = NULL, *q = NULL;	/* pointers in arguments */

	/* Remove leading and trailing white spaces */
	for (p = cmd; *p == ' ' || *p == '\t'; p++)
		; /* empty */
	for (pe = p + strlen(p) - 1; pe >= p && (*pe == ' ' || *pe == '\t'); pe--)
		; /* empty */

	if (p <= pe) {

		*argc = *argc + 1;	/* at least one argument */

		qb = q = eif_malloc(pe - p + 2);
		if (!qb)
			return;

		do {
			switch(*p) {
				case ' ':
				case '\t':
					if (quoted)
						do {
							*q++ = *p++; 
						} while(*p == ' ' || *p == '\t');
					else {
						do {
							p++;
						} while(*p == ' ' || *p == '\t');
						*q++ = '\0';
						*argc = *argc + 1;
					}
					break;
				case '\"':
					quoted = ! quoted;
					p++;
					break;
				case '\\':
					for (nbs = 0; *p == '\\'; nbs++)
						*q++ = *p++;
					if (*p == '\"') {
						if (nbs % 2) {	/* odd number of backslashes */
							q -= (nbs + 1) / 2;
							*q++ = *p++;
						}
						else {			/* even number of backslashes */
							quoted = ! quoted;
							q -= nbs / 2;
							p++;
						}
					}
					break;
				default:
					*q++ = *p++;
			}
		} while (p <= pe);
		*q++ = '\0';
	}

	if (!argvp) {
		free(qb);
		return;
	}

	*argvp = (char **) eif_malloc ((*argc + 1) * sizeof(char *));
	if (!(*argvp)) {
		free(qb);
		return;
	}

	for (i = 0; i < *argc; i++) {
		(*argvp)[i] = qb;
		qb += strlen(qb) + 1;
	}
	(*argvp)[i] = (char *)0;

}
void eif_cleanup(void)
/*
	Call each cleanup function that has been registered
*/
{
	int i;

	if (temp != NULL){
#ifdef EIF_THREADS
		if (eif_thr_is_root ())
#endif
			free (temp);
	}

	for (i = 0; i < eif_fn_count; i ++)
		if (eif_fn_table[i] != NULL)
			{
			eif_fn_table[i](EIF_FALSE);
			eif_fn_table[i] = NULL;
			}
}

void eif_register_cleanup(EIF_CLEANUP f)
/*
	Register a cleanup function
*/
{
	if (eif_fn_count == EIF_CLEANUP_TABLE_SIZE)
		eraise ("Cleanup table overflow",0);	/* %%zs added ',0' - 2 args needed, see run-time/except.c function eraise() */

	eif_fn_table [eif_fn_count] = f;
	eif_fn_count++;
}

