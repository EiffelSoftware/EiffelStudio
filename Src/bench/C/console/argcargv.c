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

#include "argcargv.h"
#include "except.h"		/* For `eraise' */

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

APIENTRY WinMain(HANDLE hInstance, HANDLE hPrevInstance, 
    LPSTR lpCmdLine, int nCmdShow)
{
	int ret = 0;

	int argc, tl;
	char **environ;

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
	environ = (char **) GetEnvironmentStrings();

	main(argc, argv, environ);
    
	FreeEnvironmentStrings ((LPTSTR) environ);

	return ret;
}

void eif_cleanup()
/*
	Call each cleanup function that has been registered
*/
{
	int i;

	if (argv != NULL)
		shfree (argv);
	if (t != NULL)
		free (t);

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
		eraise ("Cleanup table overflow");

	eif_fn_table [eif_fn_count] = f;
	eif_fn_count++;
}

