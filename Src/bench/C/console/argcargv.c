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
#include "shword.h"
#include "eif_except.h"		/* For `eraise' */

#define EIF_CLEANUP_TABLE_SIZE 20		/* Clean up table size */

EIF_CLEANUP eif_fn_table [EIF_CLEANUP_TABLE_SIZE];
int eif_fn_count = 0;

HANDLE ghInstance;
HINSTANCE eif_hInstance;
HINSTANCE eif_hPrevInstance;
LPSTR eif_lpCmdLine;
int eif_nCmdShow;

static char **local_argv = NULL, *temp = NULL;

void get_argcargv (int *argc, char ***argv)
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

	local_argv = shword (temp);
	*argv = local_argv;

	for (*argc = 0; local_argv[*argc] != (char *) 0; (*argc)++)
		;
}


void eif_cleanup()
/*
	Call each cleanup function that has been registered
*/
{
	int i;

	if (local_argv != NULL)
		shfree ();	/* %%manu removed `local_argv' as argument, shfree needs no argument */
	if (temp != NULL){
#ifdef EIF_THREADS
		if (eif_thr_is_root ())
#endif
			free (temp);
	}

	for (i = 0; i < eif_fn_count; i ++)
		if (eif_fn_table[i] != NULL)
			{
			eif_fn_table[i]();
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

