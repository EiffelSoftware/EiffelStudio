#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <dos.h>

#include <stdio.h>

extern char ** shword(char *);
extern shfree(char **);
extern int main (int, char**, char **);

HANDLE ghInstance;

HANDLE eif_coninfile, eif_conoutfile;

APIENTRY WinMain(HANDLE hInstance, HANDLE hPrevInstance, 
    LPSTR lpCmdLine, int nCmdShow)
{
	int ret = 0;

	int argc;
	char **argv, **environ, *t;
	SECURITY_ATTRIBUTES sa;

	FILE *fp;

	ghInstance = hInstance;
	fp = fopen ("C:\\patricek.log", "at");
	fprintf (fp, "Set the instance to %d %d \n", ghInstance, hInstance);
	fclose (fp);

	eif_conoutfile = GetStdHandle (STD_OUTPUT_HANDLE);
	eif_coninfile = GetStdHandle (STD_INPUT_HANDLE);
	ret = AllocConsole ();

	t = GetCommandLine();
	argv = shword (t);	
	for (argc = 0; argv[argc] != (char *) 0; argc++)
		;
	environ = GetEnvironmentStrings();

	ret = main(argc, argv, environ);
    
	FreeEnvironmentStrings (environ);
	shfree (argv);

	return ret;
}

typedef void (* EIF_CLEANUP)();
EIF_CLEANUP eif_fn_table [20];
int eif_fn_count = 0;

void eif_cleanup()
{
	int i;

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

BOOL CtrlHandler(DWORD fdwCtrlType) {
    switch (fdwCtrlType) {

        /* Handle the CTRL+C signal. */

        case CTRL_BREAK_EVENT:
        case CTRL_C_EVENT:
			eio();
            return TRUE;

        /* CTRL+CLOSE: confirm that the user wants to exit. */

        case CTRL_CLOSE_EVENT:

            return TRUE;

        /* Pass other signals to the next handler. */


        case CTRL_LOGOFF_EVENT:

        case CTRL_SHUTDOWN_EVENT:

        default:

            return FALSE;

    }

}

  

 
