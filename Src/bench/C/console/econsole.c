/*
	ECONSOLE.C - a console for Win32.

	The default console in Win32 will not provide any details such as how the
	window was started or anything for a graphical application.

	This console will run with either a graphical application or a console
	application.

	Changing the value of windowed_application will set the console to be a
	windowed application or a console application.

	More testing needs to be done for a console application being passed large strings.
*/

#include <stdio.h>
#include <windows.h>
#include <commdlg.h>
#define EIF_WINDOWS							/* Used to trick err_msg.h */
#include "argcargv.h"
#include "..\..\..\run-time\error.h"		/* Needs relative path here... */
#include "err_msg.h"
#include "eif_cons.h"

#define BUFFER_SIZE 128
#define BUFFER_LINES 4000

static char *pBuffer = NULL ;
static int line_max;
static int cxBuffer;
char szAppName[] = "console";

static HANDLE eif_coninfile, eif_conoutfile;
static char eif_console_buffer [BUFFER_SIZE];

static int xCaret, yCaret;
static int cxChar, cyChar, cxClient, cyClient;
static int iVscrollPos, iVscrollMax, iVscrollInc;
static int line_height;
static HDC client_dc;

int dummy_length;

static int eif_console_eof_value = 0;
static BOOL eif_console_allocated = FALSE;

BOOL windowed_application = TRUE;
BOOL Reading = FALSE;

extern HANDLE eif_coninfile, eif_conoutfile;
extern HINSTANCE eif_hInstance;

void eif_console_putint (long l);
void eif_console_putchar (EIF_CHARACTER c);
void eif_console_putstring (BYTE *s, long length);
void eif_make_console();
void eif_GetWindowedInput();

HWND eif_conout_window;
LRESULT CALLBACK eif_console_wndproc (HWND hwnd, UINT wMsg, WPARAM wParam, LONG lParam);
void eif_PutWindowedOutput(char *s, int l);
static HWND hEdit;

char *BUFFER_STRING(int x,int y)
{
	int yy;
	yy = y % BUFFER_LINES;
	return (pBuffer + yy * cxBuffer + x);
}

char BUFFER_CHAR(int x,int y)
{
	int yy;
	yy = y % BUFFER_LINES;
	return *(pBuffer + yy * cxBuffer + x);
}

void SET_BUFFER(int x, int y, char c)
{
	int yy;
	yy = y % BUFFER_LINES;
	*(pBuffer + yy * cxBuffer + x) = c;
}

char *all_buffer ()
{
	char *temp;
	int i;

	temp = malloc (BUFFER_LINES * (BUFFER_SIZE + 2));
	memset (temp, 0, sizeof (temp));
	for (i=0; i< min (line_max + 1, BUFFER_LINES); i++)
	{
		strncat (temp, BUFFER_STRING (0, i), BUFFER_SIZE);
		strcat (temp, "\r\n");
	}
	return temp;
}

EIF_INTEGER eif_console_readint()
{
	long lastint;

	if (!eif_console_allocated)
		eif_make_console();

	if (windowed_application)
		eif_GetWindowedInput();
	else {}
		//if (!ReadConsole(eif_coninfile,eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
		//	eio();

	if (0 >= sscanf (eif_console_buffer, "%i", &lastint))
		eio();

	return lastint;
}

EIF_REAL eif_console_readreal()
{
	float lastreal;

	if (!eif_console_allocated)
		eif_make_console();

	if (windowed_application)
		eif_GetWindowedInput();
	else {}
		//if (!ReadConsole(eif_coninfile,eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
		//	eio();

	if (0 > sscanf (eif_console_buffer, "%f", &lastreal))
		eio();

	return lastreal;
}

EIF_CHARACTER eif_console_readchar()
{
	if (!eif_console_allocated)
		eif_make_console();

	if (windowed_application)
		eif_GetWindowedInput();
	else {}
		//if (!ReadConsole(eif_coninfile, eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
		//	eio();

	return eif_console_buffer [0];
}

double eif_console_readdouble()
{
	double lastdouble;

	if (!eif_console_allocated)
		eif_make_console();

	if (windowed_application)
		eif_GetWindowedInput();
	else {}
		//if (!ReadConsole(eif_coninfile,eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL))
		//		eio();

	if (0 > sscanf (eif_console_buffer, "%lf", &lastdouble))
		eio();

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
		}
		else {}
			//result = ReadConsole(eif_coninfile, eif_console_buffer, BUFFER_SIZE, &buffer_length, NULL);
		c = eif_console_buffer;
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
}


long eif_console_readword(char *s, long bound, long start)
/*
	s       target buffer
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
	s += start;                     /* Where read characters are written */

	c = eif_console_readchar ();
	*s = c;
	return 1;
}

void eif_console_putint (long l)
{
	int t = 0;
	char transfer_buffer [BUFFER_SIZE];

	if (!eif_console_allocated)
		eif_make_console();

	t = sprintf (transfer_buffer, "%i", l);
	if (windowed_application)
		eif_PutWindowedOutput (transfer_buffer, t);
	else
		WriteConsole(eif_conoutfile,transfer_buffer, t, &dummy_length, NULL);
}

void eif_console_putchar (EIF_CHARACTER c)
{
	char transfer_buffer [BUFFER_SIZE];

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
	char transfer_buffer [BUFFER_SIZE];
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
	char transfer_buffer [BUFFER_SIZE];
	int t = 0;

	if (!eif_console_allocated)
		eif_make_console();

	t = sprintf (transfer_buffer, "%.17g", d);
	if (windowed_application)
		eif_PutWindowedOutput (transfer_buffer, t);
	else
		WriteConsole(eif_conoutfile,transfer_buffer, t, &dummy_length, NULL);
}

EIF_BOOLEAN eif_console_eof ()
{
	return (eif_console_eof_value == 1 ? '\01' : '\00');
}

void eif_console_next_line()
{
	eif_PutWindowedOutput ("\n", 1);
}

int print_err_msg (FILE *err, char *StrFmt, ...)
{
	EIF_GET_CONTEXT
	va_list ap;
	int r;
	char s[1024], *c, *sc;

	va_start (ap, StrFmt);
	r = vsprintf (s,StrFmt, ap);
	va_end (ap);

	if (exception_trace_string)
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
	EIF_END_GET_CONTEXT
}

BOOL CALLBACK exception_trace_dialog (HWND hwnd, UINT umsg, WPARAM wparam, LPARAM lparam)
/*
	Display a dialog when an exception trace occurs.
*/
{
	EIF_GET_CONTEXT
	OPENFILENAME ofn;
	FILE *f;
	static char *szFilter [] = {    "Log Files (*.LOG)", "*.LOG",
					"All Files (*.*)", "*.*",
					"" };
	char szFile[MAX_PATH];

	switch (umsg) {
		case WM_INITDIALOG:
			SendDlgItemMessage (hwnd, 1000, WM_SETTEXT, 0, (LPARAM) exception_trace_string);
			SendDlgItemMessage (hwnd, 1000, WM_SETFONT, (WPARAM) GetStockObject (ANSI_FIXED_FONT), 0L);
			return 1;
		case WM_COMMAND:
			switch LOWORD (wparam) {
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
					if (GetSaveFileName (&ofn)) {
						f = fopen (ofn.lpstrFile, "wb");
						if (f != NULL) {
							fputs (exception_trace_string, f);
							fclose (f);
						}
					}
			}
			return 1;
		default:
			return 0;
	}
	EIF_END_GET_CONTEXT
}

void eif_console_cleanup ()
{
	if (windowed_application)
	{
		MessageBox (NULL, "Execution terminated.\nClick OK to close Execution Tool", "Execution terminated", MB_OK);
		DestroyWindow (eif_conout_window);
	}
	else
	{
		CloseHandle (eif_coninfile);
		CloseHandle (eif_conoutfile);
	}
}

void show_trace()
/*
	Show the trace of an exception by displaying the string
	that is the exception trace in a dialog

	Reset the string in case we have another PANIC or problem
	in the reclaim.
*/
{
	EIF_GET_CONTEXT
	if (exception_trace_string != NULL)
		{
		(void) DialogBox (eif_hInstance, "EIF_EXCEPTION_TRACE", NULL, exception_trace_dialog);
		//free (exception_trace_string);
		*exception_trace_string = '\0';
		}
	EIF_END_GET_CONTEXT
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
		wc.hbrBackground = (HBRUSH) GetStockObject (BLACK_BRUSH);
		wc.lpszMenuName  = szAppName;
		wc.lpszClassName = szAppName;

		if (!RegisterClass (&wc))
			return;

		eif_conout_window = CreateWindow (szAppName, "Eiffel Console",
			WS_VISIBLE | WS_CLIPSIBLINGS | WS_BORDER | WS_DLGFRAME | WS_THICKFRAME | WS_GROUP | 40 | WS_VSCROLL,
			CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, NULL, NULL, eif_hInstance, NULL) ;

		ShowWindow (eif_conout_window, SW_SHOW);
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

void eif_GetWindowedInput()
{
	MSG msg;

	yCaret = line_max - iVscrollMax;
    SetCaretPos (xCaret * cxChar, yCaret * cyChar) ;
	ShowCaret (eif_conout_window) ;
	Reading = TRUE;
	while (Reading == TRUE)
	{
		if (PeekMessage (&msg, (HWND) eif_conout_window, 0L, 0L, PM_REMOVE))
		{
			TranslateMessage (&msg);
			DispatchMessage (&msg);
		}
	}
}

LRESULT CALLBACK eif_console_wndproc (HWND hwnd, UINT wMsg, WPARAM wParam, LONG lParam)
{
	LPCREATESTRUCT lpcs;
	HDC hdc;
	HMENU hMenu;
	static int first_line, iMaxWidth;
	static int buffer_start_pos, buffer_length, buffer_on;

	int  x, y, i ;
	PAINTSTRUCT ps ;
	TEXTMETRIC  tm ;

	OPENFILENAME ofn;
	FILE *f;
	static char *szFilter [] = {"Console Files (*.txt)", "*.txt","All Files (*.*)", "*.*",""};
	char szFile[MAX_PATH];

	switch (wMsg)
		{
		case WM_CREATE :
			client_dc = GetDC (hwnd) ;
			SelectObject (client_dc, GetStockObject (SYSTEM_FIXED_FONT)) ;
			GetTextMetrics (client_dc, &tm) ;
			cxChar = tm.tmAveCharWidth ;
			cyChar = tm.tmHeight ;


			iMaxWidth = BUFFER_SIZE;
            cxBuffer = BUFFER_SIZE;
			line_max = 0;
			iVscrollPos = 0;
			buffer_on = FALSE;

				// allocate memory for buffer and clear it

			if (pBuffer != NULL) free (pBuffer) ;
			if ((pBuffer = (char *) malloc (cxBuffer * BUFFER_LINES)) == NULL)
			{
				MessageBox (hwnd, "Window too large.  Cannot "
					"allocate enough memory.", "Eiffel Console",
					MB_ICONEXCLAMATION | MB_OK);
			}
			else
			{
				for (y = 0 ; y < BUFFER_LINES ; y++)
					for (x = 0 ; x < cxBuffer ; x++)
						SET_BUFFER(x,y, ' ');
			}

				// set caret to upper left corner
			xCaret = 0;
			yCaret = 0;

			return 0 ;

		case WM_COMMAND:
			hMenu = GetMenu (hwnd);
			switch (LOWORD (wParam))
				{
					case 1: //CMD_SAVE_AS
							ofn.lStructSize = sizeof(OPENFILENAME);
							ofn.hwndOwner = hwnd;
							ofn.hInstance = NULL;
							ofn.lpstrFilter = szFilter [0];
							ofn.lpstrCustomFilter = NULL;
							ofn.nMaxCustFilter = 0;
							ofn.nFilterIndex = 0;
							strcpy (szFile, "console.txt");
							ofn.lpstrFile = szFile;
							ofn.nMaxFile = MAX_PATH;
							ofn.lpstrFileTitle = NULL;
							ofn.nMaxFileTitle = MAX_PATH;
							ofn.lpstrInitialDir = NULL;
							ofn.lpstrTitle = NULL;
							ofn.Flags = OFN_OVERWRITEPROMPT;
							ofn.nFileOffset = 0;
							ofn.nFileExtension = 0;
							ofn.lpstrDefExt = "txt";
							ofn.lCustData = 0L;
							ofn.lpfnHook = NULL;
							ofn.lpTemplateName = NULL;
							if (GetSaveFileName (&ofn)) {
								f = fopen (ofn.lpstrFile, "wb");
								if (f != NULL) {
									fputs (all_buffer(), f);
									fclose (f);
								}
							}
							return 0;

					case 2: //CMD_EXIT
							MessageBox (hwnd, "Exit not implemented", szAppName, MB_OK);
							return 0;
				}
			break;

		case WM_SIZE:
				// obtain window size in pixels
			cxClient = LOWORD (lParam);
			cyClient = HIWORD (lParam);
			line_height = cyClient / cyChar;

			iVscrollMax = max (0, line_max + 2 - cyClient / cyChar);
			iVscrollPos = min (iVscrollPos, iVscrollMax);
			if (iVscrollMax > 0)
			{
				if (line_max > BUFFER_LINES)
					SetScrollRange (hwnd, SB_VERT, iVscrollMax - BUFFER_LINES, iVscrollMax,TRUE) ;
				else
					SetScrollRange (hwnd, SB_VERT, 0, iVscrollMax,TRUE) ;
				SetScrollPos   (hwnd, SB_VERT, iVscrollPos, TRUE);
			}

			return 0 ;

		case WM_VSCROLL :

			switch (LOWORD (wParam))
				{
				case SB_TOP :
					iVscrollInc = -iVscrollPos ;
					break ;

				case SB_BOTTOM :
    				iVscrollInc = iVscrollMax - iVscrollPos ;
    				break ;

				case SB_LINEUP :
					iVscrollInc = -1 ;
					break ;

				case SB_LINEDOWN :
					iVscrollInc = 1 ;
					break ;

				case SB_PAGEUP :
					iVscrollInc = min (-1, -cyClient / cyChar) ;
					break ;

				case SB_PAGEDOWN :
					iVscrollInc = max (1, cyClient / cyChar) ;
					break ;

				case SB_THUMBTRACK :
					iVscrollInc = HIWORD (wParam) - iVscrollPos ;
					break ;

				default :
					iVscrollInc = 0 ;
				}
			iVscrollInc = max (-iVscrollPos, min (iVscrollInc, iVscrollMax - iVscrollPos));

			if (iVscrollInc != 0)
			{
				iVscrollPos += iVscrollInc ;
				SetScrollPos (hwnd, SB_VERT, iVscrollPos, TRUE) ;
				InvalidateRect (hwnd, NULL, 1);
			}

			if (Reading)
			{
				yCaret = line_max;
                SetCaretPos (xCaret * cxChar, yCaret * cyChar) ;
			}

			return 0 ;

		case WM_SETFOCUS :
			// create and show the caret

			CreateCaret (hwnd, NULL, cxChar, cyChar);
			yCaret = line_max - iVscrollMax;
			SetCaretPos (xCaret * cxChar, yCaret * cyChar) ;
			return 0 ;

		case WM_KILLFOCUS :
			// hide and destroy the caret

			HideCaret (hwnd) ;
			DestroyCaret () ;
			return 0 ;

		case WM_KEYDOWN :
			switch (wParam)
			{

				case VK_DELETE :
					for (x = xCaret ; x < cxBuffer - 1 ; x++)
						SET_BUFFER (x, yCaret, BUFFER_CHAR (x + 1, yCaret));

					SET_BUFFER (cxBuffer - 1, yCaret,' ');

					HideCaret (hwnd) ;
					hdc = GetDC (hwnd) ;

					SelectObject (hdc,GetStockObject (SYSTEM_FIXED_FONT)) ;
					SetTextColor (hdc, RGB (175, 175, 175));
					SetBkColor (hdc, RGB (0, 0, 0));
					SetBkMode (hdc, OPAQUE);

					TextOut (hdc, xCaret * cxChar, yCaret * cyChar,
							BUFFER_STRING (xCaret, yCaret),
							cxBuffer - xCaret) ;

					ShowCaret (hwnd) ;
					ReleaseDC (hwnd, hdc) ;
					break ;
			}
			if (Reading)
			{
				yCaret = line_max - iVscrollMax;
				SetCaretPos (xCaret * cxChar, yCaret * cyChar) ;
			}
			return 0 ;

		case WM_CHAR :
			if (Reading)
			{
				if (!buffer_on)
				{
					buffer_on = TRUE;
					buffer_start_pos = xCaret;
				}
				yCaret = line_max - iVscrollMax;
                SetCaretPos (xCaret * cxChar, yCaret * cyChar) ;
				ShowCaret (hwnd) ;
				for (i = 0 ; i < (int) LOWORD (lParam) ; i++)
                	{
                    	switch (wParam)
						{
						case '\b' :                    // backspace
							if ((xCaret > 0) && (xCaret > buffer_start_pos))
								{
								xCaret-- ;
								SendMessage (hwnd, WM_KEYDOWN,VK_DELETE, 1L) ;
								}
							break ;

						case '\t' :                    // tab
							do
								{
								SendMessage (hwnd, WM_CHAR, ' ', 1L) ;
								}
							while (xCaret % 8 != 0) ;
							break ;

						case '\n' :                    // line feed
							break ;

						case '\r' :                    // carriage return

							Reading = FALSE;
							buffer_on = FALSE;
							memset (eif_console_buffer, 0, BUFFER_SIZE);
							for (i=0; i< (xCaret - buffer_start_pos); i++)
							{
								eif_console_buffer [i] = BUFFER_CHAR (buffer_start_pos + i, line_max);
                            }
							line_max++;

							iVscrollMax = max (0, line_max + 2 - cyClient / cyChar);
							//iVscrollMax = min (line_max, BUFFER_LINES);
							iVscrollPos = iVscrollMax;

							if (iVscrollMax > 0)
							{
								SetScrollRange (hwnd, SB_VERT, 0, iVscrollMax, FALSE);
								SetScrollPos   (hwnd, SB_VERT, iVscrollMax, TRUE);
							}

							xCaret = 0 ;
							HideCaret (hwnd) ;
							InvalidateRect (eif_conout_window, NULL, 1);

							break ;

						default :						// character codes
							SET_BUFFER (xCaret, line_max, (char) wParam);

							HideCaret (hwnd) ;

							SelectObject (client_dc,GetStockObject (SYSTEM_FIXED_FONT)) ;
							SetTextColor (client_dc, RGB (175, 175, 175));
							SetBkMode (client_dc, TRANSPARENT);

							TextOut (client_dc, xCaret * cxChar, yCaret * cyChar,
								BUFFER_STRING (xCaret, line_max), 1) ;

							ShowCaret (hwnd) ;

							if (xCaret < cxBuffer)
							{
								xCaret++;
							}
							break ;
						}
					yCaret = line_max - iVscrollMax;
                 	SetCaretPos (xCaret * cxChar, yCaret * cyChar) ;
					}
			}
			return 0 ;

		case WM_PAINT:

			hdc = BeginPaint (hwnd, &ps);
			SetTextColor (hdc, RGB (175, 175, 175));
			SetBkMode (hdc, TRANSPARENT);

			SelectObject (hdc, GetStockObject (SYSTEM_FIXED_FONT));
			for (y = 0 ; y < line_max - iVscrollPos + 1; y++)
				TextOut (hdc, 0, y * cyChar, BUFFER_STRING(0,(y + iVscrollPos)), cxBuffer);
			EndPaint (hwnd, &ps);
			return 0;
		}

	return DefWindowProc (hwnd, wMsg, wParam, lParam);
}

void output_all ()
{
	int y;
	SetTextColor (client_dc, RGB (175, 175, 175));
	SelectObject (client_dc, GetStockObject (BLACK_BRUSH));
	SetBkMode (client_dc, TRANSPARENT);
	Rectangle (client_dc, 0, 0, 1200, 1000);
	for (y = 0 ; y < line_max - iVscrollPos + 1; y++)
	{
		TextOut (client_dc, 0, y * cyChar, BUFFER_STRING(0,(y + iVscrollPos)), cxBuffer);
	}
}

void eif_PutWindowedOutput(char *s, int l)
{
	int i, ix;
	static int old_time=0;
	static int new_time;
	int next_line = FALSE;
	int start = xCaret;
	int stop = l + start;
	BOOLEAN refresh;

	new_time = GetTickCount ();
	if ((new_time - old_time) > 1000)
	{
		refresh = TRUE;
		old_time = new_time;
	}
	else
		refresh = FALSE;

	ix = start;
	for (i=start; i < stop; i++)
	{

		switch (s[i - start])
			{
				case 13:
					break;

				case 10:
					next_line = TRUE;
					xCaret = 0;
					ix = 0;
					line_max ++;
					break;

				case '\t':
					if (xCaret < cxBuffer - 8)
					{
						xCaret = xCaret + 8;
						ix += 8;
					}
					break;

				default:
					SET_BUFFER (ix, line_max, s[i - start]);
					if (xCaret < cxBuffer)
					{
						xCaret ++;
						ix ++;
					}
					break;
			}
	}
	if (next_line)
	{
		iVscrollMax = max (0, line_max + 2 - line_height);
		//iVscrollMax = min (line_max, BUFFER_LINES);
		iVscrollPos = iVscrollMax;
		if (iVscrollMax > 0)
		{
			if (line_max > BUFFER_LINES)
				SetScrollRange (eif_conout_window, SB_VERT, iVscrollMax - BUFFER_LINES, iVscrollMax,TRUE) ;
			else
				SetScrollRange (eif_conout_window, SB_VERT, 0, iVscrollMax,TRUE) ;
			SetScrollPos   (eif_conout_window, SB_VERT, iVscrollMax, TRUE);
		}
	}
	InvalidateRect (eif_conout_window, NULL, 1);
	if (refresh)
		output_all ();
}

