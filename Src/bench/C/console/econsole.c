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

#define BUFFER_SIZE 128

static HANDLE eif_coninfile, eif_conoutfile;
static char eif_console_buffer [BUFFER_SIZE];

int dummy_length;

static int eif_console_eof_value = 0;
static BOOL eif_console_allocated = FALSE;

void eif_console_putint (long l);
void eif_console_putchar (EIF_CHARACTER c);
void eif_console_putstring (EIF_POINTER s, long length);
void eif_show_console();

EIF_INTEGER eif_console_readint()
{
	EIF_GET_CONTEXT
	long lastint;
	DWORD buffer_length = (DWORD) 0;

	eif_show_console();

	if (!ReadConsole(eif_coninfile, eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
		eio();

	if (0 >= sscanf (eif_console_buffer, "%ld", &lastint))
		eio();

	return lastint;
	EIF_END_GET_CONTEXT
}

EIF_REAL eif_console_readreal()
{
	EIF_GET_CONTEXT
	float lastreal;
	DWORD buffer_length = (DWORD) 0;

	eif_show_console();

	if (!ReadConsole(eif_coninfile,eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
		eio();

	if (0 > sscanf (eif_console_buffer, "%f", &lastreal))
		eio();

	return lastreal;
	EIF_END_GET_CONTEXT
}

EIF_CHARACTER eif_console_readchar()
{
	EIF_GET_CONTEXT
	DWORD buffer_length = (DWORD) 0;

	eif_show_console();

	if (!ReadConsole(eif_coninfile, eif_console_buffer, 1, &buffer_length, NULL))
		eio();

	return eif_console_buffer [0];
	EIF_END_GET_CONTEXT
}

double eif_console_readdouble()
{
	EIF_GET_CONTEXT
	double lastdouble;
	DWORD buffer_length = (DWORD) 0;

	eif_show_console();

	if (!ReadConsole(eif_coninfile,eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
		eio();

	if (0 > sscanf (eif_console_buffer, "%lf", &lastdouble))
		eio();

	return lastdouble;
	EIF_END_GET_CONTEXT
}

long eif_console_readline(char *s,long bound,long start)
{
	EIF_GET_CONTEXT
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
		if (!ReadConsole(eif_coninfile, eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
			eio();
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

	EIF_END_GET_CONTEXT
}

long eif_console_readstream(char *s, long bound)
       		/* Target buffer where read characters are written */
       		/* Size of the target buffer */
{
	/* Read min (bound, remaining bytes in file) characters into `s' and
	 * return the number of characters read.
	 */

	EIF_GET_CONTEXT
	EIF_INTEGER amount = bound;	/* Number of characters to be read */
	int c;					/* Last char read */
	long i = 0;					/* Counter */
	DWORD buffer_length = (DWORD) 0;
	
	if (!ReadConsole(eif_coninfile, eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
		eio();

	while (amount-- > 0) {
		c = eif_console_buffer [i];
		if (i++ == (long) buffer_length)
			break;
		*s++ = c;
	}

	return bound - amount - 1;	/* Number of characters read */
	EIF_END_GET_CONTEXT
}

long eif_console_readword(char *s, long bound, long start)
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

	EIF_GET_CONTEXT
	EIF_INTEGER amount;	/* Amount of bytes to be read */
	int c;   /* Last char read */
	long i = 0;   /* Counter */
	static DWORD buffer_length = (DWORD) 0;

	eif_show_console();

	amount = bound - start;		/* Characters to be read */
	s += start;					/* Where read characters are written */
	i = start;
	errno = 0;					/* No error, a priori */

	if (start == 0)	{			/* First call */
		if (!ReadConsole(eif_coninfile, eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
			eio();

		while (i < (long) buffer_length)
			if (!isspace(c = eif_console_buffer [i++]))
				break;

		if (isspace(eif_console_buffer [i]) && (i == (long) buffer_length))
			return (EIF_INTEGER) 0;				/* Reached EOF before word */
		else
			i--;
	}

	while (amount-- > 0) {
		c = eif_console_buffer [i++];
		if (i == (long) buffer_length)
			break;
		if (isspace(c))
			break;
		*s++ = c;
	}
		
		/* If we managed to get the whole string, return the number of characters
		 * read. Otherwise, return (bound - start + 1) to indicate an error
		 * condition.
		 */
		
	if ((i == (long) buffer_length) || isspace(c))
		return bound - start - amount - 1;	/* Number of characters read */

	return bound - start + 1;			/* Error condition */
	EIF_END_GET_CONTEXT
}

void eif_console_putint (long l)
{
	EIF_GET_CONTEXT
	int t = 0;
	char transfer_buffer [BUFFER_SIZE];

	eif_show_console();

	t = sprintf (transfer_buffer, "%ld", l);
	WriteFile(eif_conoutfile,transfer_buffer, t, &dummy_length, NULL);
	EIF_END_GET_CONTEXT
}

void eif_console_putchar (EIF_CHARACTER c)
{
	EIF_GET_CONTEXT
	char transfer_buffer [1];

	eif_show_console();

	transfer_buffer[0] = c;
	WriteFile(eif_conoutfile,transfer_buffer,1, &dummy_length, NULL);
	EIF_END_GET_CONTEXT
}

void eif_console_putstring (EIF_POINTER s, long length)
{
	EIF_GET_CONTEXT
	eif_show_console();
	WriteFile(eif_conoutfile,s, length, &dummy_length, NULL);
	EIF_END_GET_CONTEXT
}

void eif_console_putreal (double r)
{
	EIF_GET_CONTEXT
	char transfer_buffer [BUFFER_SIZE];
	int t = 0;

	eif_show_console();

	t = sprintf (transfer_buffer, "%g", (float) r);
	WriteFile(eif_conoutfile,transfer_buffer, t, &dummy_length, NULL);
	EIF_END_GET_CONTEXT
}

void eif_console_putdouble (double d)
{
	EIF_GET_CONTEXT
	char transfer_buffer [BUFFER_SIZE];
	int t = 0;

	eif_show_console();

	t = sprintf (transfer_buffer, "%.17g", d);
	WriteFile(eif_conoutfile,transfer_buffer, t, &dummy_length, NULL);
	EIF_END_GET_CONTEXT
}

EIF_BOOLEAN eif_console_eof ()
{
	EIF_GET_CONTEXT
	return (eif_console_eof_value == 1 ? '\01' : '\00');
	EIF_END_GET_CONTEXT
}

void eif_console_next_line()
/* Doing nothing here because the next call to a read function will reset the buffer */
{
}

int print_err_msg (FILE *err, char *StrFmt, ...)
{
	EIF_GET_CONTEXT
	va_list ap;
	int r;
	char s[2038];
	FILE *exception_saved;
	char saved_cwd [MAX_PATH];

	va_start (ap, StrFmt);
	r = vsprintf (s,StrFmt, ap);
	va_end (ap);

	getcwd(saved_cwd, MAX_PATH);
	chdir (starting_working_directory);

	if ((exception_saved = fopen( "exception_trace.log", "a" )) != NULL) {
		fprintf (exception_saved, "%s", s);
		fclose (exception_saved);
	}
	chdir (saved_cwd);

	eif_console_putstring (s, strlen(s));
	return r;
	EIF_END_GET_CONTEXT
}

void eif_console_cleanup (void)
{
	EIF_GET_CONTEXT
	BOOL b;
	DWORD buffer_length = (DWORD) 0;

	if (eif_console_allocated) {
#ifdef EIF_THREADS
		if (eif_thr_is_root())
#endif
		{
			eif_console_putstring("\nPress Return to finish the execution...\0", 40);
			if (!ReadConsole(eif_coninfile, eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
				eio ();

			CloseHandle (eif_coninfile);
			CloseHandle (eif_conoutfile);
			b = FreeConsole ();
		}
		eif_console_allocated = FALSE;
	}  
	EIF_END_GET_CONTEXT
}

void eif_show_console()
{
	EIF_GET_CONTEXT
	if (!eif_console_allocated) {
		BOOL bSuccess;

		bSuccess = AllocConsole();

		if (bSuccess) {
			SECURITY_ATTRIBUTES sa;

			sa.nLength = sizeof (sa);
			sa.lpSecurityDescriptor = NULL;
			sa.bInheritHandle = TRUE;

			eif_conoutfile = CreateFile ("CONOUT$", GENERIC_WRITE | GENERIC_READ,
				FILE_SHARE_READ | FILE_SHARE_WRITE, &sa, OPEN_EXISTING, 0, 0);

			if (eif_conoutfile == INVALID_HANDLE_VALUE)
				eio();

			eif_coninfile = CreateFile ("CONIN$", GENERIC_READ | GENERIC_WRITE,
				FILE_SHARE_READ | FILE_SHARE_WRITE, &sa, OPEN_EXISTING, 0, 0);

			if (eif_coninfile == INVALID_HANDLE_VALUE)
				eio();

		} else {
			eif_conoutfile = GetStdHandle (STD_OUTPUT_HANDLE);

			if (eif_conoutfile == INVALID_HANDLE_VALUE)
				eio();

			eif_coninfile = GetStdHandle (STD_INPUT_HANDLE);

			if (eif_coninfile == INVALID_HANDLE_VALUE)
				eio();
		}

		eif_register_cleanup (eif_console_cleanup);
		eif_console_allocated = TRUE;
	}
	EIF_END_GET_CONTEXT
}
