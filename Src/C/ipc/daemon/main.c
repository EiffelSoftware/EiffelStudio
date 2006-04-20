/*
	description: "Main entry point for `estudio'."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "eif_config.h"
#include "eif_portable.h"

#ifdef EIF_WINDOWS
#define print_err_msg fprintf
#else
#include "rt_err_msg.h"
#endif

#include <sys/types.h>
#include <stdio.h>
#include "proto.h"
#include "listen.h"

#include <string.h>
#if defined(EIF_SGI) || defined(EIF_SOLARIS)
#include <strings.h> /* for index and rindex. */
#endif

#include <signal.h>
#include "eif_logfile.h"
#include "stream.h"
#include "child.h"
#include <stdlib.h>

#ifdef EIF_WINDOWS
#include <windows.h>
#define EWB		"\\bin\\ec.exe -bench"	/* Ewb process within Eiffel dir */
#elif defined EIF_VMS
#define EWB		".bin]ec -bench"	/* Ewb process within Eiffel dir */
#else
#define ISE_EIFFEL	"/usr/lib/Eiffel4"	/* Default installation directory */
#define EWB		"/bin/ec -bench"	/* Ewb process within Eiffel dir */
#endif

#ifdef EIF_ASSERTIONS
#include <stdarg.h>
#if defined(EIF_WINDOWS) && defined (_DEBUG)
#include <crtdbg.h>
#endif
#endif

/* Function declaration */
rt_public void dexit(int code);		/* Daemon's exit */
rt_private Signal_t handler(int sig);	/* Signal handler */
rt_private void set_signal(void);	/* Set up the signal handler */
rt_private void process_name (char *);	/* Compute the name of Eiffel Compiler */

#ifdef EIF_WINDOWS
extern char *win_eif_getenv(char *k, char *app);	/* Get environment variable value */
rt_private void display_splash(void);
#else
extern char *getenv(const char *);			/* Get environment variable value */
#endif

rt_public unsigned TIMEOUT;		/* Time out for interprocess communications */

rt_public struct d_flags daemon_data = {	/* Internal daemon's flags */
	(unsigned int) 0,	/* d_rqst */
	(unsigned int) 0,	/* d_sent */
	(STREAM *) 0,		/* d_cs */
	(STREAM *) 0,		/* d_as */
};

#ifdef EIF_WINDOWS
#ifndef USE_ADD_LOG
rt_public char progname[30];	/* Otherwise defined in logfile.c */
#endif
#else
#ifndef USE_ADD_LOG
rt_public char *progname;	/* Otherwise defined in logfile.c */
#endif
#endif

rt_public void init_bench(int argc, char **argv)
{
	STREAM *sp;			/* Stream used to talk to the child */
#ifdef EIF_WINDOWS
	HANDLE pid;			/* Pid of the spawned child */
#else
	Pid_t pid;			/* Pid of the spawned child */
#endif
	char *ewb_path;		/* Path leading to the ewb executable */
	char *eiffel5;		/* Eiffel 4 installation directory */
	char *platform;
	char *eif_timeout;	/* Timeout specified in environment variable */

	/* Check if the user wants to override the default timeout value
	 * required by the children processes to launch and initialize
	 * themselves. This new value is specified in the ISE_TIMEOUT
	 * environment variable
	 */
	
#ifdef EIF_WINDOWS
	eif_timeout = win_eif_getenv ("ISE_TIMEOUT", "ec");
#else
	eif_timeout = getenv ("ISE_TIMEOUT");
#endif

	if (eif_timeout != (char *) 0)			/* Environment variable set */
		TIMEOUT = (unsigned) atoi(eif_timeout);
	else
		TIMEOUT = 30;

	/* Compute program name, removing any leading path to keep only the name
	 * of the executable file.
	 */
#ifdef EIF_WINDOWS
/*	progname = rindex(argv[0], '\\');	*//* Only last name if '\' found */
/*	if (progname++ == (char *) 0)		*//* There were no '\' */
/*	strcpy (progname,"estudio.exe");		*//* This must be the filename then */
#elif defined(EIF_VMS)
	progname = (char*)eifrt_vms_get_progname (NULL,0);
#else
	progname = rindex(argv[0], '/');	/* Only last name if '/' found */
	if (progname++ == (char *) 0)		/* There were no '/' */
		progname = argv[0];				/* This must be the filename then */
#endif

#ifdef USE_ADD_LOG

#ifdef EIF_WINDOWS
	/* Open a logfile in /tmp */
	(void) open_log("\\tmp\\ised.log");
/*	set_loglvl(LOGGING_LEVEL);			*//* Set debug level */
#else
	progpid = getpid();					/* Program's PID */

#ifdef EIF_VMS
	(void) open_log("sys$scratch:ebench.log");
#else
	/* Open a logfile in /tmp */
	(void) open_log("/tmp/ised.log");
#endif
	set_loglvl(LOGGING_LEVEL);			/* Set debug level */
#endif /* platform */
#endif /* USE_ADD_LOG */

	set_signal();						/* Set up signal handler */
	signal (SIGABRT ,exit);
#ifdef EIF_WINDOWS
#ifdef SIGQUIT
	signal (SIGQUIT, exit);
#endif
#else
	signal (SIGQUIT, exit);
#endif

#ifdef USE_ADD_LOG
	add_log(20, "ised process started");
#endif

	/* To find out where the ewb process is located, we use the environment
	 * variable ISE_EIFFEL to get the path to the Eiffel 3.0 directory. Then the
	 * ewb process is in the bin/ subdirectory. In the name of standardization,
	 * the /usr/lib/Eiffel4 path is used when the ISE_EIFFEL variable is not set.
	 */

#ifdef EIF_WINDOWS
	eiffel5 = win_eif_getenv("ISE_EIFFEL", "ec");		/* Installation directory */
	if ((eiffel5 == (char *) 0) || (strlen (eiffel5) == 0)) {	/* Environment variable not set */
		MessageBox (NULL, "The ISE_EIFFEL registry key is not set.\nYou should probably reinstall the software.",
							"Execution terminated", MB_OK + MB_ICONERROR + MB_TASKMODAL + MB_TOPMOST);
		InvalidateRect (NULL, NULL, FALSE);
		exit (1);
	}
#else
	eiffel5 = getenv("ISE_EIFFEL");		/* Installation directory */
	if (eiffel5 == (char *) 0) {		/* Environment variable not set */
		print_err_msg (stderr, "The environment variable ISE_EIFFEL is not set\n");
		exit (1);
	}
#endif

	ewb_path = (char *) malloc(2048);
	if (ewb_path == (char *) 0) {
		print_err_msg(stderr, "%s: out of memory\n", progname);
		exit(1);
	}

#ifdef EIF_VMS
	strcpy(ewb_path, "ISE_EIFFEL:[studio.spec.");	/* VMS system will translate base name */
#else
	strcpy(ewb_path, eiffel5);			/* Base name */
#if defined EIF_WINDOWS
	strcat(ewb_path, "\\studio\\spec\\");
#else
	strcat(ewb_path, "/studio/spec/");
#endif /* (not) EIF_WINDOWS */
#endif /* (not) EIF_VMS */

#ifdef EIF_WINDOWS
	platform = win_eif_getenv ("ISE_PLATFORM", "ec");
	if ((platform == (char *) 0) || (strlen(platform) == 0)){		/* Environment variable not set */
		MessageBox (NULL, "The ISE_PLATFORM registry key is not set.\nYou should probably reinstall the software.",
							"Execution terminated", MB_OK + MB_ICONERROR + MB_TASKMODAL + MB_TOPMOST);
		InvalidateRect (NULL, NULL, FALSE);
		exit (1);
	}
#else
	platform = getenv ("ISE_PLATFORM");
	if (platform == (char *) 0) {		/* Environment variable not set */
		print_err_msg(stderr, "The environment variable ISE_PLATFORM is not set\n");
		exit (1);
	}
#endif

	strcat(ewb_path, platform);
	process_name (ewb_path);

	if (argc == 2) {
			/* It means that we give as an extra parameter the project file to open
			 * with EiffelBench */
		strcat (ewb_path, " -project \"");
		strcat (ewb_path, argv [1]);
		strcat (ewb_path, "\"");
	}
	if ((argc >= 5) && (strcmp (argv[1], "-create")==0) && (strcmp (argv[3], "-ace")==0)) {
			/* It means that we try to create a project from the command line or from
			 * estudio or with EiffelBench */
		strcat (ewb_path, " -create \"");
		strcat (ewb_path, argv [2]);
		strcat (ewb_path, "\" -ace \"");
		strcat (ewb_path, argv [4]);
		strcat (ewb_path, "\"");
	}
	if ((argc >= 6) && strcmp (argv[5], "-compile") == 0) {
			/* It means that we try to compile a project from the command line or from
			 * estudio or with EiffelBench */
		strcat (ewb_path, " -compile");
	}

#ifdef EIF_WINDOWS
		/* First argument is 1 because we are launching the Eiffel compiler here. */
	sp = spawn_child(1, ewb_path, NULL, 0, &pid, NULL);	/* Bring workbench to life */
#else
	sp = spawn_child(ewb_path, NULL, 0, &pid);	/* Bring workbench to life */
#endif

	if (sp == (STREAM *) 0)	{			/* Could not do it */
#ifdef EIF_WINDOWS
		MessageBox (NULL, "The program ec.exe cannot be launched",
							"Execution terminated", MB_OK + MB_ICONERROR + MB_TASKMODAL + MB_TOPMOST);
		InvalidateRect (NULL, NULL, FALSE);
#else
		print_err_msg(stderr, "%s: could not launch %s\n", progname, ewb_path);
#endif
		free(sp);
		exit(1);
	}

	daemon_data.d_cs = sp;				/* Record workbench stream */
#ifdef EIF_WINDOWS
	daemon_data.d_ewb = (HANDLE) pid;		/* And keep track of the child pid */
#else
	daemon_data.d_ewb = (int) pid;			/* And keep track of the child pid */
#endif
	prt_init();						/* Initialize IDR filters */

	free (ewb_path);

#ifdef EIF_WINDOWS
	InvalidateRect (NULL, NULL, FALSE);
#endif

	dwide_listen();					/* Enter server mode... */

	dexit(0);		/* Workbench died, so do we */
}

rt_private void set_signal(void)
{
	/* Set up the signal handler */

#ifdef SIGHUP
	signal(SIGHUP, handler);
#endif
#ifdef SIGINT
	signal(SIGINT, handler);
#endif
#ifdef SIGQUIT
	signal(SIGQUIT, handler);
#endif
#ifdef SIGTERM
	signal(SIGTERM, handler);
#endif
#ifdef SIGCHLD
	signal (SIGCHLD, SIG_IGN);
#elif defined (SIGCLD)
	signal (SIGCLD, SIG_IGN);
#endif
}

rt_private Signal_t handler(int sig)
{
	/* A signal was caught */

#ifndef SIGNALS_KEPT
	signal(sig, handler);
#endif

#ifdef USE_ADD_LOG
	add_log(12, "caught signal #%d", sig);
#endif
	dexit(0);
}

rt_public void dexit(int code)
{
#ifdef USE_ADD_LOG
	add_log(12, "exiting with status %d", code);
#endif
#ifdef EIF_WINDOWS
	if (daemon_data.d_as) {
		close_stream (daemon_data.d_as);
		free (daemon_data.d_as);
		daemon_data.d_as = NULL;
	}

	if (daemon_data.d_cs) {
		close_stream (daemon_data.d_cs);
		free (daemon_data.d_cs);
		daemon_data.d_cs = NULL;
	}

	if (daemon_data.d_ewb != 0)
		CloseHandle (daemon_data.d_ewb);

	prt_destroy();
#endif
	exit(code);
}

/* Create the name of the executable from the macro EWB */
/* or from the environment variable EC_NAME */

rt_private void process_name (char *ewb_path)
{
	char *ec_name;
	char *local;

	ec_name = getenv("EC_NAME");		/* Installation directory */

	if (ec_name == (char *) 0)			/* Environment variable set */
		strcat (ewb_path, EWB);
	else {
#ifdef EIF_VMS
			/* for VMS, ec_name is the full path to the ec executable */
			strcpy (ewb_path, ec_name);		/* replace bench/spec/platform */
			strcat (ewb_path, " -bench");
#else
			/* else its the name in the bench ewb bin/ directory */
			local = (char *) malloc (50 * sizeof (char));
#ifndef EIF_WINDOWS
			strcpy (local, "/bin/");
			strcat (local, ec_name);
			strcat (local, " -bench");
			strcat (ewb_path, local);
#else
			strcpy (local, "\\bin\\");
			strcat (local, ec_name);
			strcat (local, " -bench");
			strcat (ewb_path, local);
#endif
			free(local);
#endif
		}
}

rt_public int main (int argc, char **argv)
{
	/* This is the main entry point for the ISE daemon */
#ifdef EIF_ASSERTIONS
#if defined(EIF_WINDOWS) && defined(_DEBUG)
	int tmpDbgFlag = 0;
	_CrtSetReportMode(_CRT_WARN, _CRTDBG_MODE_FILE);
	_CrtSetReportFile(_CRT_WARN, _CRTDBG_FILE_STDOUT);
	_CrtSetReportMode(_CRT_ERROR, _CRTDBG_MODE_FILE);
	_CrtSetReportFile(_CRT_ERROR, _CRTDBG_FILE_STDOUT);
	_CrtSetReportMode(_CRT_ASSERT, _CRTDBG_MODE_FILE);
	_CrtSetReportFile(_CRT_ASSERT, _CRTDBG_FILE_STDOUT);

	tmpDbgFlag = _CrtSetDbgFlag(_CRTDBG_REPORT_FLAG);
	tmpDbgFlag |= _CRTDBG_DELAY_FREE_MEM_DF;
	tmpDbgFlag |= _CRTDBG_LEAK_CHECK_DF;
	tmpDbgFlag |= _CRTDBG_CHECK_ALWAYS_DF;

	_CrtSetDbgFlag(tmpDbgFlag);
#endif
#endif

	init_bench (argc, argv);
	return 0L;
}

#ifdef EIF_WINDOWS

char szAppName [] = "estudio";		/* Window class name for temporary estudio window */
HANDLE hInst;				/* Application main instance			 */
HWND hwnd;				/* Handle of temporary estudio window 	*/

/*----------------------------------------------------------------*/
/* Display a splash window while loading ise4.exe */
/*----------------------------------------------------------------*/

HPALETTE CreateDIBPalette (LPBITMAPINFO lpbmi, LPINT lpiNumColors)
{
	LPBITMAPINFOHEADER	lpbi;
	LPLOGPALETTE		lpPal;
	HANDLE				hLogPal;
	HPALETTE			hPal = NULL;
	int 				i;

	lpbi = (LPBITMAPINFOHEADER)lpbmi;
	if (lpbi->biBitCount <= 8) *lpiNumColors = (1 << lpbi->biBitCount);
	else *lpiNumColors = 0;	/* No palette needed for 24 BPP DIB */

	if (*lpiNumColors)
	{
		hLogPal = GlobalAlloc (GHND, sizeof (LOGPALETTE) +
				sizeof (PALETTEENTRY) * (*lpiNumColors));
		lpPal = (LPLOGPALETTE) GlobalLock (hLogPal);
		lpPal->palVersion	 = (WORD) 0x300;
		lpPal->palNumEntries = (WORD) *lpiNumColors;

		for (i = 0; i < *lpiNumColors; i++)
		{
			lpPal->palPalEntry[i].peRed = lpbmi->bmiColors[i].rgbRed;
			lpPal->palPalEntry[i].peGreen = lpbmi->bmiColors[i].rgbGreen;
			lpPal->palPalEntry[i].peBlue = lpbmi->bmiColors[i].rgbBlue;
			lpPal->palPalEntry[i].peFlags = 0;
		}
		hPal = CreatePalette (lpPal);
		GlobalUnlock (hLogPal);
		GlobalFree	 (hLogPal);
	}
	return hPal;
}

HBITMAP LoadResourceBitmap(HINSTANCE hInstance, LPSTR lpString, HPALETTE FAR* lphPalette)
{
	HRSRC hRsrc;
	HGLOBAL hGlobal;
	HBITMAP hBitmapFinal = NULL;
	LPBITMAPINFOHEADER lpbi;
	HDC hdc;
	int iNumColors;

	hRsrc = FindResource(hInstance, lpString, RT_BITMAP);
	if (hRsrc) {
		hGlobal = LoadResource(hInstance, hRsrc);
		lpbi = (LPBITMAPINFOHEADER)LockResource(hGlobal);

		hdc = GetDC(NULL);
		*lphPalette = CreateDIBPalette ((LPBITMAPINFO)lpbi, &iNumColors);
		if (*lphPalette) {
			SelectPalette(hdc,*lphPalette,FALSE);
			RealizePalette(hdc);
		}
		hBitmapFinal = CreateDIBitmap(hdc,
			(LPBITMAPINFOHEADER)lpbi,
			(LONG)CBM_INIT,
			(LPSTR)lpbi + lpbi->biSize + iNumColors * sizeof(RGBQUAD),
			(LPBITMAPINFO)lpbi,
			DIB_RGB_COLORS );

		ReleaseDC(NULL,hdc);
		FreeResource(hGlobal);
	}
	return (hBitmapFinal);
}

void display_splash(void)
{
	HDC dc, MemDC;
	HBITMAP Bitmap, OldBitmap;
	BITMAP bm;
	RECT sr;
	HPALETTE palette;

	dc = CreateDC ("DISPLAY", NULL, NULL, NULL);
	Bitmap = LoadResourceBitmap (hInst, MAKEINTRESOURCE (1024), &palette);

	MemDC = CreateCompatibleDC (dc);
	OldBitmap = SelectObject (MemDC, Bitmap);
	GetObject (Bitmap, sizeof (BITMAP), &bm);
	sr.left = (GetSystemMetrics (SM_CXSCREEN) - bm.bmWidth) / 2;
	sr.top = (GetSystemMetrics (SM_CYSCREEN) - bm.bmHeight) / 2;
	sr.right = sr.left + bm.bmWidth;
	sr.bottom = sr.top + bm.bmHeight;
	SelectPalette (dc, palette, 1);
	RealizePalette (dc);
	BitBlt (dc, sr.left, sr.top, bm.bmWidth, bm.bmHeight, MemDC, 0, 0, SRCCOPY);
	DeleteObject (SelectObject (MemDC, OldBitmap));
	DeleteDC (MemDC);
	DeleteDC (dc);
}

rt_private void shword(char *cmd, int *argc, char ***argvp)
{
	/* Break the shell command held in 'cmd', putting each shell word
	 * in a separate array entry, hence building an argument
	 * suitable for the execvp() system call.
	 */

	int quoted = 0;	/* parsing inside a quoted string? */
	int nbs;		/* number of backspaces */
	int i;
	char *p = NULL, *pe = NULL;	/* pointers in `cmd' */
	char *qb = NULL, *q = NULL;	/* pointers in arguments */

	/* Remove leading and trailing white spaces */
	for (p = cmd; *p == ' ' || *p == '\t'; p++)
		; /* empty */
	for (pe = p + strlen(p) - 1; pe >= p && (*pe == ' ' || *pe == '\t'); pe--)
		; /* empty */

	if (p <= pe) {

		*argc = *argc + 1;	/* at least one argument */

		qb = q = malloc(pe - p + 2);
		if (!qb)
			return;

		do {
			switch(*p) {
				case ' ':
				case '\t':
					if (quoted)
						do {
							*q++ = *p++; 
						} while(*p == ' ' || *p == '\t');
					else {
						do {
							p++;
						} while(*p == ' ' || *p == '\t');
						*q++ = '\0';
						*argc = *argc + 1;
					}
					break;
				case '\"':
					quoted = ! quoted;
					p++;
					break;
				case '\\':
					for (nbs = 0; *p == '\\'; nbs++)
						*q++ = *p++;
					if (*p == '\"') {
						if (nbs % 2) {	/* odd number of backslashes */
							q -= (nbs + 1) / 2;
							*q++ = *p++;
						}
						else {			/* even number of backslashes */
							quoted = ! quoted;
							q -= nbs / 2;
							p++;
						}
					}
					break;
				default:
					*q++ = *p++;
			}
		} while (p <= pe);
		*q++ = '\0';
	}

	if (!argvp) {
		free(qb);
		return;
	}

	*argvp = (char **) malloc ((*argc + 1) * sizeof(char *));
	if (!(*argvp)) {
		free(qb);
		return;
	}

	for (i = 0; i < *argc; i++) {
		(*argvp)[i] = qb;
		qb += strlen(qb) + 1;
	}
	(*argvp)[i] = (char *)0;

}

int WINAPI WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpszCmdLine, int nCmdShow)
{
/* Initialize Estudio, launch ec and establish communications */

	int argc = 0;
	char **argv = NULL;
	char *tmp = strdup (GetCommandLine());	/* Cannot use lpszCmdLine since we need the
												application name */
	int return_value = 0;

	hInst = hInstance;
	display_splash ();

	shword (tmp, &argc, &argv);	/* Create from the string returned by GetCommandLine,
								an array of string */

		/* Count the number of elements in argv */
	for (argc = 0; argv[argc] != (char *) 0; (argc)++)
		;

	return_value = main (argc,argv);

	free (argv);
	return return_value;
}
#endif


