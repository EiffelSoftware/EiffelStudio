/*
	ECONSOLE.C - a console for Win32.

	The default console in Win32 will not provide any details such as how the
	window was started or anything for a graphical application.

	This console will run with either a graphical application or a console
	application.

	More testing needs to be done for a console application being passed large strings.
*/

#include <stdio.h>
#include <windows.h>
#include "eif_argcargv.h"
#include "eif_err_msg.h"
#include "eif_econsole.h"
#include "eif_error.h"
#include "rt_threads.h"
#include "rt_main.h"
#include <io.h>
#include <fcntl.h>

#ifdef WORKBENCH
#include "server.h"	/* For `debug_mode' */
#endif

static HANDLE eif_conin, eif_conout, eif_conerr;
static BOOL eif_console_allocated = FALSE;

#ifdef EIF_THREADS
rt_private EIF_MUTEX_TYPE *eif_exception_trace_mutex = (EIF_MUTEX_TYPE *) 0;
#endif

rt_public void eif_show_console(void);					/* Show the DOS console if needed */

int print_err_msg (FILE *err, char *StrFmt, ...)
{
	va_list ap;
	int r;
	FILE *exception_saved;
	char saved_cwd [PATH_MAX + 1];

	eif_show_console ();

		/* Write error to `err'. */
	va_start (ap, StrFmt);
	r = vfprintf (err, StrFmt, ap);
	va_end (ap);

		/* Now try to write error into `exception_trace.log' file */
#ifdef EIF_THREADS
	if (!eif_exception_trace_mutex)
		EIF_MUTEX_CREATE(eif_exception_trace_mutex,
			"Could not create mutex for saving the exception trace in a file\n");

	EIF_MUTEX_LOCK(eif_exception_trace_mutex,
		"Could not lock mutex for saving the exception trace in a file\n");
#endif

	getcwd(saved_cwd, PATH_MAX);
	chdir (starting_working_directory);

		/* If we are not allowed to write the exception, we don't do it */
	if ((exception_saved = fopen( "exception_trace.log", "at" )) != NULL) {
		va_start (ap, StrFmt);
		r = vfprintf (exception_saved, StrFmt, ap);
		va_end (ap);
		fclose (exception_saved);
	}
	chdir (saved_cwd);

#ifdef EIF_THREADS
	EIF_MUTEX_UNLOCK(eif_exception_trace_mutex,
		"Could not unlock mutex for saving the exception trace in a file\n");
#endif
	return r;
}

void eif_console_cleanup (EIF_BOOLEAN crashed)
	/* Free the DOS console */
	/* If crashed = EIF_TRUE then a message is shown to the user so that he
	 * can see what has been the problem after a crash of his system */
{
	BOOL b;

	if (eif_console_allocated) {
#ifdef EIF_THREADS
		if (eif_thr_is_root())
#endif
		{
#ifdef WORKBENCH
			if (debug_mode) {
				EIF_CHARACTER c;
				printf ("\nPress Return to finish the execution...");
				scanf ("%c", &c);
			}
#endif
			b = FreeConsole ();
		}
		eif_console_allocated = FALSE;
	}  
}

rt_public void eif_show_console(void)
	/* Create a new DOS console if needed (i.e. in case of a Windows application. */
{
	if (!eif_console_allocated) {
		CONSOLE_SCREEN_BUFFER_INFO csbi;
		BOOL bLaunched;
		BOOL bSuccess;
		int hCrt;
		FILE *hf;

		bSuccess = AllocConsole();

			/* Get all Std handles and raise an IO exception
			 * if we fail getting one. */
		eif_conout = GetStdHandle(STD_OUTPUT_HANDLE);
		if (eif_conout == INVALID_HANDLE_VALUE)
			eio();

		eif_conerr = GetStdHandle (STD_ERROR_HANDLE);
		if (eif_conerr == INVALID_HANDLE_VALUE)
			eio();

		eif_conin = GetStdHandle (STD_INPUT_HANDLE);
		if (eif_conin == INVALID_HANDLE_VALUE)
			eio();

		if (bSuccess) {
				/* Console was manually created, we are most likely in
				 * a Windows application that tries to output something.
				 * Therefore we need to correctly associated all standard
				 * handles `stdin', `stdout' and `stderr' to the new
				 * created console.
				 * Code was taken from http://codeguru.earthweb.com/console/Console.html
				 */
			hCrt = _open_osfhandle ((long) eif_conout, _O_TEXT);
			hf = _fdopen (hCrt, "w");
			*stdout = *hf;

			hCrt = _open_osfhandle ((long) eif_conerr, _O_TEXT);
			hf = _fdopen (hCrt, "w");
			*stderr = *hf;

			hCrt = _open_osfhandle ((long) eif_conin, _O_RDONLY);
			hf = _fdopen (hCrt, "r");
			*stdin = *hf;
		}

			/* We are computing the cursor position to figure out, if the application
			* has been launched from a DOS console or from the Windows Shell
			*/
		GetConsoleScreenBufferInfo(eif_conout, &csbi);
		bLaunched = ((csbi.dwCursorPosition.X == 0) && (csbi.dwCursorPosition.Y == 0));
		if ((csbi.dwSize.X <= 0) || (csbi.dwSize.Y <= 0))
			bLaunched = FALSE;

		if (bLaunched == TRUE)
			eif_register_cleanup (eif_console_cleanup);

		eif_console_allocated = TRUE;
	}
}
