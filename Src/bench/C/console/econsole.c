#include <stdio.h>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <commdlg.h>
#define EIF_WINDOWS
#include "..\..\..\run-time\err_msg.h"

#define BUFFER_SIZE 255

static HANDLE eif_coninfile, eif_conoutfile;
static char eif_console_buffer [BUFFER_SIZE];
static char transfer_buffer [30];
static DWORD buffer_length = 0;
static int buffer_place = 0;

int dummy_length;

static int eif_console_eof_value = 0;
static BOOL eif_console_allocated = FALSE;

static int console_in_x = 10, console_in_y = 30;

BOOL windowed_application = TRUE;

extern HANDLE eif_coninfile, eif_conoutfile;
extern HINSTANCE eif_hInstance;

void eif_console_putint (long l);
void eif_console_putchar (char c);
void eif_console_putstring (BYTE *s, long length);
void eif_make_console();
void eif_GetWindowedInput();
HWND eif_conout_window;
LRESULT CALLBACK eif_console_wndproc (HWND hwnd, UINT wMsg, WPARAM wParam, LONG lParam);
void eif_PutWindowedOutput(char *s, int l);
static HWND hEdit;

long eif_console_readint()
{
	long lastint;

	if (!eif_console_allocated)
		eif_make_console();

	if (buffer_place >= buffer_length)
		{
		if (windowed_application)
			eif_GetWindowedInput();
		else    
			if (!ReadConsole(eif_coninfile,eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
				eio();
		buffer_place = 0;
		}

	
	if (0 >= sscanf (eif_console_buffer+buffer_place, "%i", &lastint))
		eio();

	while ((buffer_place < buffer_length) && (!isspace(eif_console_buffer[buffer_place])))
		buffer_place++;

	if ((buffer_place < buffer_length) && 
		((eif_console_buffer [buffer_place] == '\r') || (eif_console_buffer [buffer_place] == '\n')) )
		buffer_place = buffer_length;
	return lastint;
}

float eif_console_readreal()
{
	float lastreal;

	if (!eif_console_allocated)
		eif_make_console();

	if (buffer_place >= buffer_length)
		{
		if (windowed_application)
			eif_GetWindowedInput();
		else
			if (!ReadConsole(eif_coninfile,eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
				eio();
		buffer_place = 0;
		}

	if (0 > sscanf (eif_console_buffer+buffer_place, "%f", &lastreal))
		eio();

	while ((buffer_place < buffer_length) && (!isspace(eif_console_buffer[buffer_place])))
		buffer_place++;
	if ((buffer_place < buffer_length) && 
		((eif_console_buffer [buffer_place] == '\r') || (eif_console_buffer [buffer_place] == '\n')) )
		buffer_place = buffer_length;

	return lastreal;
}

char eif_console_readchar()
{
	if (!eif_console_allocated)
		eif_make_console();

	if ((buffer_place >= buffer_length) ||
	    (eif_console_buffer [buffer_place] == '\r') ||
	    (eif_console_buffer [buffer_place] == '\n'))
		{
		if (windowed_application)
			eif_GetWindowedInput();
		else
			if (!ReadConsole(eif_coninfile, eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
				eio();
		buffer_place = 0;
		}
	if ((buffer_length == 0) || 
	    (eif_console_buffer [buffer_place] == '\r') ||
	    (eif_console_buffer [buffer_place] == '\n'))
		return EOF;
	else
		return eif_console_buffer [buffer_place++];
}

double eif_console_readdouble()
	{
	double lastdouble;

	if (!eif_console_allocated)
		eif_make_console();

	if (buffer_place >= buffer_length)
		{
		if (windowed_application)
			eif_GetWindowedInput();
		else
			if (!ReadConsole(eif_coninfile,eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
				eio();
		buffer_place = 0;
		}

	if (0 > sscanf (eif_console_buffer+buffer_place, "%lf", &lastdouble))
		eio();

	while ((buffer_place < buffer_length) && (!isspace(eif_console_buffer[buffer_place])))
		buffer_place++;
	if ((buffer_place < buffer_length) && 
		((eif_console_buffer [buffer_place] == '\r') || (eif_console_buffer [buffer_place] == '\n')) )
		buffer_place = buffer_length;

	return lastdouble;
	}

long eif_console_readline(char *s,long bound,long start)
	{
	long amount, read;
	static char *c = NULL;
	static BOOL done = FALSE;
	BOOL result;
	
	if (!eif_console_allocated)
		eif_make_console();

	read = 0;

	if (!done)
		{       
		c = NULL;
		done = TRUE;
		}
	if (c == NULL)  
		{
		if (windowed_application)
			{
			eif_GetWindowedInput();
			strcat (eif_console_buffer, "\r\n");
			buffer_length += 2;
			}
		else    
			result = ReadConsole(eif_coninfile, eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL);
		c = eif_console_buffer;
		}

	if (buffer_length == 0)
		{
		eif_console_eof_value = 1;
		return 0;
		}

	amount = bound - start;
	s += start;
	
	while (amount-- > 0) 
		{
		if (*c == '\n')
			break;
		if (*c != '\r')
			{
			*s++ = *c++;
			read ++;
			}
		else
			c++;
		}

	buffer_place = buffer_length;
	if (*c == '\n')
		{
		c = NULL;
		return read;
		}

	if (amount == -1)
		return (read + 1);

	return bound - start + 1;
	}

long eif_console_readstream(char *s, long bound)
	{
	long amount = bound;
	BOOL result;

	if (!eif_console_allocated)
		eif_make_console();

	if (!ReadConsole(eif_coninfile, s, bound, &amount, NULL))
		 {
		 eif_console_eof_value = 1;
		 return bound - amount - 1;
		 }
	return bound - amount - 1;
	}


long eif_console_readword(char *s, long bound, long start)
/*
s               target buffer
bound   target buffer size
start   number of characters already in target buffer
*/
	{
		/* Get a word and fill it into `s' (at most `bound' characters),
		 * with `start' being the amount of bytes already stored within s. This
	 * means we really have to read (bound - start) characters. Any leading
	 * spaces are skipped.
	 */

	long amount;    /* Amount of bytes to be read */
	static int c;   /* Last char read */

	if (!eif_console_allocated)
		eif_make_console();

	amount = bound - start;         /* Characters to be read */
	s += start;                                     /* Where read characters are written */

	if (start == 0) {                       /* First call */
		while (c = eif_console_readchar())
			if (!isspace(c))
				break;
		if (c == EOF)
			{
			eif_console_eof_value = 1;
			return 0;                               /* Reached EOF before word */
			}
	}

	while (amount-- > 0) {
		*s++ = c;
		if (buffer_place >= buffer_length)
			break;
		c = eif_console_readchar();
		if (isspace(c))
			break;
	}
	
	/* If we managed to get the whole string, return the number of characters
	 * read. Otherwise, return (bound - start + 1) to indicate an error
	 * condition.
	 */

	if ((buffer_place >= buffer_length) || isspace(c))
		return bound - start - amount;  /* Number of characters read */

	return bound - start + 1;                       /* Error condition */
	}

void eif_console_putint (long l)
	{
	int t = 0;

	if (!eif_console_allocated)
		eif_make_console();

	t = sprintf (transfer_buffer, "%i", l);
	if (windowed_application)
		eif_PutWindowedOutput (transfer_buffer, t);
	else
		WriteConsole(eif_conoutfile,transfer_buffer, t, &dummy_length, NULL);
	}

void eif_console_putchar (char c)
	{
	if (!eif_console_allocated)
		eif_make_console();

	transfer_buffer[0] = c;
	if (windowed_application)
		eif_PutWindowedOutput (transfer_buffer, 1);
	else
		WriteConsole(eif_conoutfile,transfer_buffer,1, &dummy_length, NULL);
	}

void eif_console_putstring (BYTE *s, long length)
	{
	if (!eif_console_allocated)
		eif_make_console();
	if (windowed_application)
		eif_PutWindowedOutput (s, length);
	else
		WriteConsole(eif_conoutfile,s, length, &dummy_length, NULL);
	}

void eif_console_putreal (double r)
	{
	int t = 0;

	if (!eif_console_allocated)
		eif_make_console();

	t = sprintf (transfer_buffer, "%g", (float) r);
	if (windowed_application)
		eif_PutWindowedOutput (transfer_buffer, t);
	else
		WriteConsole(eif_conoutfile,transfer_buffer, t, &dummy_length, NULL);
	}

void eif_console_putdouble (double d)
	{
	int t = 0;

	if (!eif_console_allocated)
		eif_make_console();

	t = sprintf (transfer_buffer, "%.17g", d);
	if (windowed_application)
		eif_PutWindowedOutput (transfer_buffer, t);
	else
		WriteConsole(eif_conoutfile,transfer_buffer, t, &dummy_length, NULL);
	}


char eif_console_eof ()
{
	return (eif_console_eof_value == 1 ? '\01' : '\00');
}

void eif_console_next_line()
{
	buffer_place = buffer_length;
}

int print_err_msg (FILE *err, char *StrFmt, ...)
{
	va_list ap;
	int r;
	char s[1024], *c, *sc;

	va_start (ap, StrFmt);
	r = vsprintf (s,StrFmt, ap);
	va_end (ap);

	if (save_exception_trace)
		{
		for (c=exception_trace_string+strlen(exception_trace_string), sc = s; *sc; sc++, c++)
			if (*sc != '\n')
				*c = *sc;
			else
				{
				*c++ = '\r';
				*c = '\n';
				}
		*c = '\0';
		}
	eif_console_putstring (s, strlen(s));

	return r;
}
BOOL CALLBACK exception_trace_dialog (HWND hwnd, UINT umsg, WPARAM wparam, LPARAM lparam)
{
	OPENFILENAME ofn;
	FILE *f;
	long i;
	static char *szFilter [] = {    "Log Files (*.LOG)", "*.LOG",
					"All Files (*.*)", "*.*",
					"" };
	char szFile[MAX_PATH];

	switch (umsg)
		{
		case WM_INITDIALOG:
			SendDlgItemMessage (hwnd, 1000, WM_SETTEXT, 0, (LPARAM) exception_trace_string);
			SendDlgItemMessage (hwnd, 1000, WM_SETFONT, (WPARAM) GetStockObject (ANSI_FIXED_FONT), 0L);
			return 1;
		case WM_COMMAND:
			switch LOWORD (wparam)
				{
				case IDCANCEL:
					EndDialog (hwnd, 0);
					return 1;
				case IDOK:
					ofn.lStructSize = sizeof(OPENFILENAME);
					ofn.hwndOwner = hwnd;
					ofn.hInstance = NULL;
					ofn.lpstrFilter = szFilter [0];
					ofn.lpstrCustomFilter = NULL;
					ofn.nMaxCustFilter = 0;
					ofn.nFilterIndex = 0;
					strcpy (szFile, "exception_trace.log");
					ofn.lpstrFile = szFile;
					ofn.nMaxFile = MAX_PATH;
					ofn.lpstrFileTitle = NULL;
					ofn.nMaxFileTitle = MAX_PATH;
					ofn.lpstrInitialDir = NULL;
					ofn.lpstrTitle = NULL;
					ofn.Flags = OFN_OVERWRITEPROMPT;
					ofn.nFileOffset = 0;
					ofn.nFileExtension = 0;
					ofn.lpstrDefExt = "log";
					ofn.lCustData = 0L;
					ofn.lpfnHook = NULL;
					ofn.lpTemplateName = NULL;
					if (GetSaveFileName (&ofn))
						{
						f = fopen (ofn.lpstrFile, "wb");
						if (f != NULL)
							{
							fputs (exception_trace_string, f);
							fclose (f);
							}
						}
				}
			return 1;
		default:
			return 0;       
		}
}

void eif_console_cleanup ()
{
	if (windowed_application)
		DestroyWindow (eif_conout_window);
	else
		{
		CloseHandle (eif_coninfile);
		CloseHandle (eif_conoutfile);
		}
}

void show_trace()
{
	if (exception_trace_string != NULL)
		{
		(void) DialogBox (eif_hInstance, "EIF_EXCEPTION_TRACE", NULL, exception_trace_dialog);
		//free (exception_trace_string);
		*exception_trace_string = '\0';
		}
}

void eif_make_console()
{
	BOOL b;
	SECURITY_ATTRIBUTES sa;

	if (windowed_application)
		{
		WNDCLASS wc;
			
		wc.style         = CS_VREDRAW | CS_HREDRAW;
		wc.lpfnWndProc   = (LPVOID) eif_console_wndproc;
		wc.cbClsExtra    = 0;
		wc.cbWndExtra    = 0;
		wc.hInstance     = eif_hInstance;
		
		wc.hIcon         = NULL;
		wc.hCursor       = NULL;
		wc.hbrBackground = (HBRUSH) (COLOR_WINDOW + 1);
		wc.lpszMenuName  = NULL;
		wc.lpszClassName = "EiffelConsole";
			
		if (!RegisterClass (&wc))
			return;

		eif_conout_window = CreateWindow ("EiffelConsole", "Log", 
			WS_VISIBLE | WS_THICKFRAME | WS_OVERLAPPED | WS_MINIMIZEBOX | WS_MAXIMIZEBOX, CW_USEDEFAULT, CW_USEDEFAULT, 400, 200, 
			NULL,0, eif_hInstance, NULL);
		ShowWindow (eif_conout_window, SW_SHOW);
		SetWindowPos (eif_conout_window, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE);
		}
	else
		{
		b = AllocConsole();
	
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
		}

	eif_register_cleanup (eif_console_cleanup);
	eif_console_allocated = TRUE;
		
}

BOOL CALLBACK get_input_dialog (HWND hwnd, UINT umsg, WPARAM wparam, LPARAM lparam)
{
	DWORD size;

	switch (umsg)
		{
		case WM_INITDIALOG:
			SetFocus (GetDlgItem(hwnd, 1001));
			SetWindowPos (hwnd, HWND_TOPMOST, console_in_x-5, console_in_y-24, 0, 0, SWP_NOSIZE);
			size = SendMessage (hEdit, WM_GETTEXTLENGTH, 0, 0);
			SendMessage (hEdit, EM_SETSEL, size, size);
			SendMessage (hEdit, EM_SCROLLCARET, 0, 0);
			return 0;
		case WM_MOVE:
			console_in_x = LOWORD(lparam);
			console_in_y = HIWORD(lparam);
			return 0;
		case WM_COMMAND:
			switch LOWORD (wparam)
				{
				case IDOK:
				case IDCANCEL:
					buffer_length = GetDlgItemText (hwnd, 1001, eif_console_buffer, BUFFER_SIZE);
					EndDialog (hwnd, LOWORD(wparam));
					return 1;
				}
			return 1;
		default:
			return 0;       
		}
}


void eif_GetWindowedInput()
{
	if (DialogBox (eif_hInstance, "EIF_GET_INPUT", NULL, get_input_dialog) == IDCANCEL)
		eio();
	else
		{
		eif_console_putstring (eif_console_buffer, strlen(eif_console_buffer));
		eif_console_putchar ('\n');
		}
}

LRESULT CALLBACK eif_console_wndproc (HWND hwnd, UINT wMsg, WPARAM wParam, LONG lParam)
{
	LPCREATESTRUCT lpcs;
	
	switch (wMsg)
		{
		case WM_CREATE:
			lpcs = (LPCREATESTRUCT) lParam;
			hEdit = CreateWindow ("edit", NULL,  WS_CHILD | ES_MULTILINE | ES_READONLY | WS_VSCROLL | WS_HSCROLL | WS_VISIBLE,
				0,0, lpcs->cx, lpcs->cy, hwnd, NULL, eif_hInstance, NULL);
			SendMessage (hEdit, WM_SETTEXT, 0, (LPARAM) "");
			SendMessage (hEdit, WM_SETFONT, (WPARAM) GetStockObject (ANSI_FIXED_FONT), MAKELPARAM (0,0));
			return 0;
		case WM_SIZE:
			SetWindowPos (hEdit, HWND_TOP, 0, 0, LOWORD(lParam), HIWORD(lParam), SWP_NOMOVE | SWP_NOZORDER);
			return 0;
		}
	return DefWindowProc (hwnd, wMsg, wParam, lParam);
}

void eif_PutWindowedOutput(char *s, int l)
{
#define BUFSIZE 16000
	char *buffer, *sp, *bp, *ss = s;
	MSG msg;
	int size, t, lv = l, newlines = 0;
	BOOL update = FALSE;

	if ((buffer = calloc (BUFSIZE+1,1)) == NULL) return;

	while (PeekMessage (&msg, (HWND) eif_conout_window, 0L, 0L, PM_REMOVE))
		{
		TranslateMessage (&msg);
		DispatchMessage (&msg);
		}

	size = SendMessage (hEdit, WM_GETTEXT, BUFSIZE, (LPARAM) buffer);

	// Count the number of newlines

	for (sp = ss, lv = l; lv; lv --, sp++)
		if (*sp == '\n')
			newlines ++;
	update = newlines > 0;

	// Can we fit the current string?

	if (BUFSIZE - size > l + newlines)
		{
		// Yes it fits just append it
		for (sp = ss, bp = buffer + size; l; l--, sp++, bp++)
			{
			if (*sp == '\n')
				{
				*bp = '\r';
				bp++;
				}
			*bp = *sp;
			}
		}
	else // No it doesn't fit
		// Will the string fit in the buffer?
		{
		if (l + newlines < BUFSIZE)
			{
			// Yes
			}
		else	// String won't fit in buffer at all
			{
			ss = ss + l + newlines - BUFSIZE + 1;
			}
		memset (buffer, 0, BUFSIZE);
		for (sp = ss, bp = buffer; *sp; sp++, bp++)
			{
			if (*sp == '\n')
				{
				*bp = '\r';
				bp++;
				}
			*bp = *sp;
			}
		}
	SendMessage (hEdit, WM_SETTEXT, 0, (LPARAM) buffer);
	if (update)
		{
		SetWindowPos (eif_conout_window, HWND_TOP, 0,0,0,0, SWP_NOMOVE | SWP_NOSIZE | SWP_NOACTIVATE);
		SendMessage (hEdit, EM_SETSEL, size, size);
		SendMessage (hEdit, EM_SCROLLCARET, 0, 0);
		}
	free (buffer);
}
