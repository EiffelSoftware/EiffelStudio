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
#include <commdlg.h>
#include "eif_argcargv.h"
#include "eif_err_msg.h"
#include "eif_econsole.h"
#include "eif_error.h"
#include "rt_threads.h"
#include "rt_main.h"
#include <ctype.h>

#ifdef WORKBENCH
#include "server.h"	/* For `debug_mode' */
#endif

#define BUFFER_SIZE 2056
#define KEY_CR (EIF_CHARACTER) 13
#define KEY_LF (EIF_CHARACTER) 10

static HANDLE eif_coninfile, eif_conoutfile;
static char *eif_console_buffer;
static EIF_BOOLEAN eif_is_console_clean_for_input = EIF_TRUE;	/* Do we need to flush input for CR or LD */
static BOOL eif_console_allocated = FALSE;

#ifdef EIF_THREADS
rt_private EIF_MUTEX_TYPE *eif_exception_trace_mutex = (EIF_MUTEX_TYPE *) 0;
#endif

rt_private void eif_show_console(void);					/* Show the DOS console if needed */
rt_private void safe_readconsole (char **buffer, DWORD *size);	/* Read console entry and remove all nasty characters such as KEY_CR and KEY_LF */

rt_private void readconsole (HANDLE hFile, LPVOID lpBuffer, DWORD nNumberOfBytesToRead, LPDWORD lpNumberOfBytesRead, LPVOID lpOverlapped); /* Call ReadConsole, if no success call ReadFile */

rt_private void writeconsole(HANDLE hConsoleOutput, CONST VOID *lpBuffer, DWORD nNumberOfCharsToWrite, LPDWORD lpNumberOfCharsWritten, LPVOID lpOverlapped); /* Call WriteConsole and if it does not succeed call WriteFile */

EIF_INTEGER eif_console_readint()
{
	long lastint;
	DWORD buffer_length = (DWORD) 0;

	eif_show_console();

	safe_readconsole (&eif_console_buffer, &buffer_length);

	if (0 >= sscanf (eif_console_buffer, "%ld", &lastint))
		eise_io("Not an INTEGER.");

	return lastint;
}

EIF_REAL eif_console_readreal()
{
	EIF_REAL lastreal;
	DWORD buffer_length = (DWORD) 0;

	eif_show_console();

	safe_readconsole (&eif_console_buffer, &buffer_length);

	if (0 > sscanf (eif_console_buffer, "%f", &lastreal))
		eise_io("Not a REAL.");

	return lastreal;
}

EIF_DOUBLE eif_console_readdouble()
{
	EIF_DOUBLE lastdouble;
	DWORD buffer_length = (DWORD) 0;

	eif_show_console();

	safe_readconsole (&eif_console_buffer, &buffer_length);

	if (0 > sscanf (eif_console_buffer, "%lf", &lastdouble))
		eise_io("Not a DOUBLE.");

	return lastdouble;
}

EIF_CHARACTER eif_console_readchar(void)
{
	DWORD buffer_length = (DWORD) 0;

	eif_show_console();

	readconsole(eif_coninfile, eif_console_buffer, 1, &buffer_length, NULL);

	eif_is_console_clean_for_input = EIF_FALSE;
	return eif_console_buffer [0];
}

EIF_INTEGER eif_console_readline(EIF_CHARACTER *s, EIF_INTEGER bound, EIF_INTEGER start)
{
	long amount, read;
	static char *c = NULL;	/* declared as static: the value of `c' will be stored for the next call */
	static BOOL done = FALSE;					    
	DWORD buffer_length = (DWORD) 0;

	eif_show_console();

	read = 0;

	if (!done) {
		c = NULL;	  /* useless? */
		done = TRUE;
	}
	if (c == NULL) {
		readconsole(eif_coninfile, eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL);
		c = eif_console_buffer;
	}

	amount = bound - start;
	s += start;

	while (amount-- > 0) {
		if (*c == '\n')
			break;
		if (*c != '\r') {
			*s++ = *c++;
			read ++;
		}
		else
			c++;
	}

	if (*c == '\n') {
		c = NULL;
		return read;
	}

	if (amount == -1)
		return (read + 1);

	return bound - start + 1;

}

EIF_INTEGER eif_console_readstream (EIF_CHARACTER *s, EIF_INTEGER bound)
       		/* Target buffer where read characters are written */
       		/* Size of the target buffer */
{
	/* Read min (bound, remaining bytes in file) characters into `s' and
	 * return the number of characters read.
	 */

	EIF_INTEGER amount = bound;	/* Number of characters to be read */
	char c;						/* Last char read */
	long i = 0;					/* Counter */
	long to_be_read;		/* Number of characters that will be read by `readconsole' */
	long read;				/* Number of characters remainings for `readconsole' */
	DWORD buffer_length = (DWORD) 0;
	char done = (char) 0;
	
	eif_show_console();

	to_be_read = min (bound, BUFFER_SIZE);
	read = bound - to_be_read;
	readconsole(eif_coninfile, eif_console_buffer, to_be_read, &buffer_length, NULL);

	if ((long) buffer_length < to_be_read)
		read = 0;	/* It seems that the request to read `bound' characters was too big
					   We need to stop any calls to `readconsole' to avoid a
					   blocking situation where we are waiting for more characters */

	while ((amount-- > 0) && (done == (char) 0)) {
		c = eif_console_buffer [i];
		if (i++ == (long) (buffer_length - 1)) {
			if (read == 0)
				done = (char) 1;	/* No more reading requested, we can stop now, we have
									   read so far bound - amount ­ 1 characters */
			else {
				to_be_read = min (read, BUFFER_SIZE);
				read = read - to_be_read;
				readconsole(eif_coninfile, eif_console_buffer,
							to_be_read, &buffer_length, NULL);
	
				if ((long) buffer_length < to_be_read)
					read = 0;	/* It seems that the request to read `bound' characters
								   was too big. We need to stop any calls to `readconsole'
								   to avoid a blocking situation where we are waiting
								   for more characters */
				i = 0;
			}
		}
		*s++ = c;
	}

	return bound - amount - 1;	/* Number of characters read */
}

EIF_INTEGER eif_console_readword(EIF_CHARACTER *s, EIF_INTEGER bound, EIF_INTEGER start)
/*
    s		Target buffer where read characters are written
	bound   Size of the target buffer
	start  Amount of characters already held in buffer
*/
{
	/* Get a word and fill it into `s' (at most `bound' characters),
	 * with `start' being the amount of bytes already stored within s. This
	 * means we really have to read (bound - start) characters. Any leading
	 * spaces are skipped.
	 */

	/* When we read the KEY_CR, we skip the sequence KEY_CR, KEY_LF and do like they
	 * did not exist.
	 */

	EIF_INTEGER amount;	/* Amount of bytes to be read */
	EIF_CHARACTER c = (EIF_CHARACTER) 0;   /* Last char read */
	int finished = (int) 1;

	eif_show_console();

	amount = bound - start;		/* Characters to be read */
	s += start;					/* Where read characters are written */
	errno = 0;					/* No error, a priori */

	if (start == 0)	{			/* First call */
		while (finished) {
			c = eif_console_readchar();
			if (c == KEY_CR) {
				c = eif_console_readchar ();	/* We read KEY_LF */
				c = eif_console_readchar ();	/* We read next character */
			}
			if (!isspace(c)) {
				*s++ = c;
				finished = 0;
			}
		}
	}

	while (amount-- > 0) {
		c = eif_console_readchar();
		if (isspace(c)) {
			if (c == KEY_CR) {
				c = eif_console_readchar ();	/* We read KEY_LF */
				eif_is_console_clean_for_input = EIF_TRUE;
			}
			else
				eif_is_console_clean_for_input = EIF_FALSE;
			break;
		}
		*s++ = c;
	}
	

		/* If we managed to get the whole string, return the number of characters
		 * read. Otherwise, return (bound - start + 1) to indicate an error
		 * condition.
		 */
		
	if (isspace(c))
		return bound - start - amount;	/* Number of characters read */

	return bound - start + 1;			/* Error condition */
}

void eif_console_putint (EIF_INTEGER l)
{
	int t;
	DWORD dummy_length = (DWORD) 0;

	eif_show_console();

	t = sprintf (eif_console_buffer, "%ld", l);
	writeconsole(eif_conoutfile, eif_console_buffer, t, &dummy_length, NULL);
}

void eif_console_putchar (EIF_CHARACTER c)
{
	DWORD dummy_length = (DWORD) 0;

	eif_show_console();
	writeconsole(eif_conoutfile, &c,1, &dummy_length, NULL);
}

void eif_console_putstring (EIF_CHARACTER *s, EIF_INTEGER length)
{
	DWORD dummy_length = (DWORD) 0;

	eif_show_console();
	writeconsole(eif_conoutfile,s, length, &dummy_length, NULL);
}

void eif_console_putreal (EIF_REAL r)
{
	int t;
	DWORD dummy_length = (DWORD) 0;

	eif_show_console();

	t = sprintf (eif_console_buffer, "%g", r);
	writeconsole(eif_conoutfile, eif_console_buffer, t, &dummy_length, NULL);
}

void eif_console_putdouble (EIF_DOUBLE d)
{
	int t;
	DWORD dummy_length = (DWORD) 0;

	eif_show_console();

	t = sprintf (eif_console_buffer, "%.17g", d);
	writeconsole(eif_conoutfile, eif_console_buffer, t, &dummy_length, NULL);
}

EIF_BOOLEAN eif_console_eof ()
	/* There is no EOF in a Windows DOS console */
{
	return EIF_FALSE;
}

void eif_console_next_line()
{
	if (!eif_is_console_clean_for_input) {
		EIF_BOOLEAN done = (EIF_BOOLEAN) 0;

			/* We read until we reach the sequence KEY_CR, KEY_LF or just KEY_LF. */
		while (!done) {
			switch (eif_console_readchar()) {
				case KEY_CR:
					done = (EIF_BOOLEAN) (eif_console_readchar() == KEY_LF);
					break;
				case KEY_LF:
					done = EIF_TRUE;
					break;
			}
		}
	}
}

int print_err_msg (FILE *err, char *StrFmt, ...)
{
	va_list ap;
	int r;
	char s[2038];
	FILE *exception_saved;
	char saved_cwd [PATH_MAX + 1];

	va_start (ap, StrFmt);
	r = vsprintf (s,StrFmt, ap);
	va_end (ap);


#ifdef EIF_THREADS
	if (!eif_exception_trace_mutex)
		EIF_MUTEX_CREATE(eif_exception_trace_mutex, "Could not create mutex for saving the exception trace in a file\n");

	EIF_MUTEX_LOCK(eif_exception_trace_mutex, "Could not lock mutex for saving the exception trace in a file\n");
#endif

	getcwd(saved_cwd, PATH_MAX);
	chdir (starting_working_directory);

		/* If we are not allowed to write the exception, we don't do it */
	if ((exception_saved = fopen( "exception_trace.log", "a" )) != NULL) {
		fprintf (exception_saved, "%s", s);
		fclose (exception_saved);
	}
	chdir (saved_cwd);

#ifdef EIF_THREADS
	EIF_MUTEX_UNLOCK(eif_exception_trace_mutex, "Could not unlock mutex for saving the exception trace in a file\n");
#endif

	eif_console_putstring ((EIF_CHARACTER *) s, strlen(s));
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
				eif_console_putstring((EIF_CHARACTER *) "\nPress Return to finish the execution...\0", 40);
				c = eif_console_readchar ();
			}
#endif
			CloseHandle (eif_coninfile);
			CloseHandle (eif_conoutfile);
			b = FreeConsole ();
		}
		free (eif_console_buffer);
		eif_console_allocated = FALSE;
	}  
}

rt_private void eif_show_console(void)
{
	if (!eif_console_allocated) {
		CONSOLE_SCREEN_BUFFER_INFO csbi;
		BOOL bLaunched;
		BOOL bSuccess;

		bSuccess = AllocConsole();
	
		if (bSuccess) {
			eif_conoutfile = CreateFile ("CONOUT$", GENERIC_WRITE | GENERIC_READ,
				FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, 0);

			if (eif_conoutfile == INVALID_HANDLE_VALUE)
				eio();

			eif_coninfile = CreateFile ("CONIN$", GENERIC_READ | GENERIC_WRITE,
				FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, 0);

			if (eif_coninfile == INVALID_HANDLE_VALUE)
				eio();

			eif_register_cleanup (eif_console_cleanup);
		} else {
			eif_conoutfile = GetStdHandle (STD_OUTPUT_HANDLE);

			if (eif_conoutfile == INVALID_HANDLE_VALUE)
				eio();

			eif_coninfile = GetStdHandle (STD_INPUT_HANDLE);

			if (eif_coninfile == INVALID_HANDLE_VALUE)
				eio();
		}

			/* We are computing the cursor position to figure out, if the application
			* has been launched from a DOS console or from the Windows Shell
			*/
		GetConsoleScreenBufferInfo(eif_conoutfile, &csbi);
		bLaunched = ((csbi.dwCursorPosition.X == 0) && (csbi.dwCursorPosition.Y == 0));
		if ((csbi.dwSize.X <= 0) || (csbi.dwSize.Y <= 0))
			bLaunched = FALSE;

		if (bLaunched == TRUE)
			eif_register_cleanup (eif_console_cleanup);

		eif_console_allocated = TRUE;

			/* Allocate the C console buffer */
		eif_console_buffer = (char *) malloc (BUFFER_SIZE * sizeof(char));
	}
}

rt_private void safe_readconsole (char **buffer, DWORD *size)
	/* Clean the input buffer of KEY_CR and KEY_LF */
{
	int done = 0;

	while (!done) {
		readconsole(eif_coninfile, *buffer, BUFFER_SIZE, size, NULL);
	
		switch (*size) {
			case 1:
				done = !((**buffer == KEY_CR) || (**buffer == KEY_LF));
				break;
			case 2:
				done = !((**buffer == KEY_CR) || (*(*buffer + 1) == KEY_LF));
				break;
			default:
				done = (int) 1;
				break;
		}
	}
}

rt_private void readconsole (HANDLE hFile, LPVOID lpBuffer, DWORD nNumberOfBytesToRead, LPDWORD lpNumberOfBytesRead, LPVOID lpOverlapped)
	/* Call ReadConsole and if it does not succeed call ReadFile */
{
	if (!ReadConsole(hFile, lpBuffer, nNumberOfBytesToRead, lpNumberOfBytesRead, lpOverlapped))
		if (!ReadFile(hFile, lpBuffer, nNumberOfBytesToRead, lpNumberOfBytesRead, (LPOVERLAPPED) lpOverlapped))
			eio();
}

rt_private void writeconsole(HANDLE hConsoleOutput, CONST VOID *lpBuffer, DWORD nNumberOfCharsToWrite, LPDWORD lpNumberOfCharsWritten, LPVOID lpOverlapped)
	/* Call WriteConsole and if it does not succeed call WriteFile */
{
	if (!WriteConsole(hConsoleOutput, lpBuffer, nNumberOfCharsToWrite, lpNumberOfCharsWritten, lpOverlapped))
		if (!WriteFile(hConsoleOutput, lpBuffer, nNumberOfCharsToWrite, lpNumberOfCharsWritten, (LPOVERLAPPED) lpOverlapped))
			eio ();
}
 

