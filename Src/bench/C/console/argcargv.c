#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <dos.h>

#include <stdio.h>

extern char ** shword(char *);
extern shfree(char **);
extern int eif_wmain (int, char**, char **);

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
	environ = GetEnvironmentStrings();

	main(argc, argv, environ);
    
	FreeEnvironmentStrings (environ);

	return ret;
}

typedef void (* EIF_CLEANUP)();
EIF_CLEANUP eif_fn_table [20];
int eif_fn_count = 0;

void eif_cleanup()
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
{
	eif_fn_table [eif_fn_count] = f;
	eif_fn_count ++;
}

 
