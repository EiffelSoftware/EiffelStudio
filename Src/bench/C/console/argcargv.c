/*
	ARGCAGRV.C - processing for the startup of the application
		allows for an application started under the debugger
		and adjusts the command line and argument count appropriately.

	An application under the debugger has 2 extra arguments the in and out pipes
	in uuencoded form for passing as strings.

	Also the cleanup processing is held in this file.
*/
#include <dos.h>
#include <stdio.h>
#include <windows.h>

#include "eif_argcargv.h"
#include "eif_except.h"		/* For `eraise' */

extern int main();		/* Main entry point */
extern int eif_wmain (int, char**, char **);

#define EIF_CLEANUP_TABLE_SIZE 20		/* Clean up table size */

EIF_CLEANUP eif_fn_table [EIF_CLEANUP_TABLE_SIZE];
int eif_fn_count = 0;

HANDLE ghInstance;
HINSTANCE eif_hInstance;
HINSTANCE eif_hPrevInstance;
LPSTR     eif_lpCmdLine;
int       eif_nCmdShow;

static char **argv = NULL, *t = NULL;

APIENTRY WinMain(HANDLE hInstance, HANDLE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
	int ret = 0;

	int argc, tl;
	char **eif_environ;

	ghInstance = hInstance;
	eif_hInstance = hInstance;
	eif_hPrevInstance = hPrevInstance;
	eif_lpCmdLine = lpCmdLine;
	eif_nCmdShow = nCmdShow;

	t = strdup (GetCommandLine());

	tl = strlen (t);
	if ((tl > 16) && (t[tl-1] == '"') && (t[tl-2] == '?') &&
		(t[tl-16] == '"') && (t[tl-15] == '?') && (t[tl-17] == ' '))
		{
		t[tl-17] = '\0';
		eif_lpCmdLine = t;
		}

	argv = shword (t);
	for (argc = 0; argv[argc] != (char *) 0; argc++)
		;
	eif_environ = (char **) GetEnvironmentStrings();

	main(argc, argv, eif_environ);

	FreeEnvironmentStrings ((LPTSTR) eif_environ);

	return ret;
}

void eif_cleanup()
/*
	Call each cleanup function that has been registered
*/
{
	int i;

	if (argv != NULL)
		shfree ();	/* %%manu removed `argv' as argument, shfree needs no argument */
	if (t != NULL){
#ifdef EIF_THREADS
		if (eif_thr_is_root ())
#endif
			free (t);
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

