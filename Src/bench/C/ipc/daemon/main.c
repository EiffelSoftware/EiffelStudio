/*

 #    #    ##       #    #    #           ####
 ##  ##   #  #      #    ##   #          #    #
 # ## #  #    #     #    # #  #          #
 #    #  ######     #    #  # #   ###    #
 #    #  #    #     #    #   ##   ###    #    #
 #    #  #    #     #    #    #   ###     ####

	The main entry point.
*/

#include "eif_config.h"
#include "eif_portable.h"

#ifdef EIF_WIN32
#define print_err_msg fprintf
#else
#include "eif_err_msg.h"
#endif

#include <sys/types.h>
#include <stdio.h>
#include "proto.h"
#include "listen.h"

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#include <signal.h>
#include "eif_logfile.h"
#include "stream.h"
#include <stdlib.h>

#ifdef EIF_WIN32
#include <windows.h>
#include "shword.h"
#define EWB		"\\bin\\es4.exe -bench"	/* Ewb process within Eiffel dir */
#elif defined EIF_VMS
#include "ipcvms.h"	/* for ipcvms_get_progname() */
/* #define EIFFEL4		"EIFFEL4:"		/* Default installation directory */
#define EWB		".bin]es4 -bench"	/* Ewb process within Eiffel dir */
#else
#define EIFFEL4	"/usr/lib/Eiffel4"	/* Default installation directory */
#define EWB		"/bin/es4 -bench"	/* Ewb process within Eiffel dir */
#endif

/* Function declaration */
rt_public void dexit(int code);		/* Daemon's exit */
rt_private void die(void);		/* A termination signal was trapped */
rt_private Signal_t handler(int sig);	/* Signal handler */
rt_private void set_signal(void);	/* Set up the signal handler */
rt_private void process_name (char *);	/* Compute the name of Eiffel Compiler */

#ifdef EIF_WIN32
extern  STREAM *spawn_child(char *cmd, HANDLE *child_pid);	/* Start up child with ipc link */
extern char *win_eif_getenv(char *k, char *app);	/* Get environment variable value */
#else
extern STREAM *spawn_child(char *cmd, Pid_t *child_pid);	/* Start up child with ipc link */
extern char *getenv(const char *);			/* Get environment variable value */
#endif

extern Malloc_t malloc(register unsigned int nbytes);		/* Memory allocation */
rt_public unsigned TIMEOUT;		/* Time out for interprocess communications */

rt_public struct d_flags daemon_data = {	/* Internal daemon's flags */
	(unsigned int) 0,	/* d_rqst */
	(unsigned int) 0,	/* d_sent */
	(STREAM *) 0,		/* d_cs */
	(STREAM *) 0,		/* d_as */
};

#ifdef EIF_WIN32
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
#ifdef EIF_WIN32
	HANDLE pid;			/* Pid of the spawned child */
#else
	Pid_t pid;			/* Pid of the spawned child */
#endif
	char *ewb_path;		/* Path leading to the ewb executable */
	char *eiffel4;		/* Eiffel 4 installation directory */
	char *platform;
	char *eif_timeout;	/* Timeout specified in environment variable */

	/* Check if the user wants to override the default timeout value
	 * required by the children processes to launch and initialize
	 * themselves. This new value is specified in the EIF_TIMEOUT
	 * environment variable
	 */

#ifdef EIF_WIN32
	eif_timeout = win_eif_getenv ("EIF_TIMEOUT", "es4");
#else
	eif_timeout = getenv ("EIF_TIMEOUT");
#endif

	if (eif_timeout != (char *) 0)			/* Environment variable set */
		TIMEOUT = (unsigned) atoi(eif_timeout);
	else
		TIMEOUT = 120;

	/* Compute program name, removing any leading path to keep only the name
	 * of the executable file.
	 */
#ifdef EIF_WIN32
/*	progname = rindex(argv[0], '\\');	/* Only last name if '\' found */
/*	if (progname++ == (char *) 0)		/* There were no '\' */
/*	strcpy (progname,"ebench.exe");		/* This must be the filename then */
#else
	progname = rindex(argv[0], '/');	/* Only last name if '/' found */
	if (progname++ == (char *) 0)		/* There were no '/' */
		progname = argv[0];				/* This must be the filename then */
#endif

#ifdef USE_ADD_LOG

#ifdef EIF_WIN32
  	/* Open a logfile in /tmp */
	(void) open_log("\\tmp\\ised.log");
/*	set_loglvl(LOGGING_LEVEL);			/* Set debug level */
#else
	progpid = getpid();					/* Program's PID */

	/* Open a logfile in /tmp */
	(void) open_log("/tmp/ised.log");
	set_loglvl(LOGGING_LEVEL);			/* Set debug level */
#endif
#endif

	set_signal();						/* Set up signal handler */
	signal (SIGABRT ,exit);
#ifdef EIF_WIN32
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
	 * variable EIFFEL4 to get the path to the Eiffel 3.0 directory. Then the
	 * ewb process is in the bin/ subdirectory. In the name of standardization,
	 * the /usr/lib/Eiffel4 path is used when the EIFFEL4 variable is not set.
	 */

#ifdef EIF_WIN32
	eiffel4 = win_eif_getenv("EIFFEL4", "es4");		/* Installation directory */
	if ((eiffel4 == (char *) 0) || (strlen (eiffel4) == 0)) {	/* Environment variable not set */
		MessageBox (NULL, "The ISE EIFFEL4 registry key is not set.\nYou should probably reinstall the software.",
						  "Execution terminated", MB_OK + MB_ICONERROR + MB_TASKMODAL + MB_TOPMOST);
		InvalidateRect (NULL, NULL, FALSE);
		exit (1);
	}
#else
	eiffel4 = getenv("EIFFEL4");		/* Installation directory */
	if (eiffel4 == (char *) 0) {		/* Environment variable not set */
		print_err_msg (stderr, "The environment variable EIFFEL4 is not set\n");
		exit (1);
	}
#endif

	ewb_path = (char *) malloc(2048);
	if (ewb_path == (char *) 0) {
		print_err_msg(stderr, "%s: out of memory\n", progname);
		exit(1);
	}

#ifdef EIF_VMS
	strcpy(ewb_path, "EIFFEL4:[bench.spec.");	/* VMS system will translate base name */
#else
	strcpy(ewb_path, eiffel4);			/* Base name */
#if defined EIF_WIN32
	strcat(ewb_path, "\\bench\\spec\\");
#else
	strcat(ewb_path, "/bench/spec/");
#endif /* (not) EIF_WIN32 */
#endif /* (not) EIF_VMS */

#ifdef EIF_WIN32
	platform = win_eif_getenv ("PLATFORM", "es4");
	if ((platform == (char *) 0) || (strlen(platform) == 0)){		/* Environment variable not set */
		MessageBox (NULL, "The ISE PLATFORM registry key is not set.\nYou should probably reinstall the software.",
						  "Execution terminated", MB_OK + MB_ICONERROR + MB_TASKMODAL + MB_TOPMOST);
		InvalidateRect (NULL, NULL, FALSE);
		exit (1);
	}
#else
	platform = getenv ("PLATFORM");
	if (platform == (char *) 0) {		/* Environment variable not set */
		print_err_msg(stderr, "The environment variable PLATFORM is not set\n");
		exit (1);
	}
#endif

	strcat(ewb_path, platform);
	process_name (ewb_path);

	if (argc == 2) {
			/* It means that we give as an extra parameter the project file to open
			 * with EiffelBench */
		strcat (ewb_path, " -project ");
		strcat (ewb_path, argv [1]);
	}
	if ((argc == 3) && strcmp (argv[1], "-create") == 0) {
			/* It means that we try to create a project from the command line or from
			 * ebench or with EiffelBench */
		strcat (ewb_path, " -create ");
		strcat (ewb_path, argv [2]);
	}

/* FIXME: check that es4 exists */

	sp = spawn_child(ewb_path, &pid);	/* Bring workbench to life */
	if (sp == (STREAM *) 0)	{			/* Could not do it */
#ifdef EIF_WIN32
		MessageBox (NULL, "The program es4.exe cannot be launched",
						  "Execution terminated", MB_OK + MB_ICONERROR + MB_TASKMODAL + MB_TOPMOST);
		InvalidateRect (NULL, NULL, FALSE);
#else
		print_err_msg(stderr, "%s: could not launch %s\n", progname, ewb_path);
#endif
		exit(1);
	}

	daemon_data.d_cs = sp;				/* Record workbench stream */
#ifdef EIF_WIN32
	daemon_data.d_ewb = (HANDLE) pid;		/* And keep track of the child pid */
#else
	daemon_data.d_ewb = (int) pid;			/* And keep track of the child pid */
#endif
	prt_init();						/* Initialize IDR filters */

#ifdef EIF_WIN32
	free (ewb_path);
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
#ifdef BSD
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

rt_private void die(void)
{
#ifdef USE_ADD_LOG
	add_log(9, "going down on termination signal");
#endif
	dexit(0);
}

rt_public void dexit(int code)
{
#ifdef USE_ADD_LOG
	add_log(12, "exiting with status %d", code);
#endif
#ifdef EIF_WIN32
	if (daemon_data.d_as) {
		close_stream (daemon_data.d_as);
		free (daemon_data.d_as);
	}

	if (daemon_data.d_cs) {
		close_stream (daemon_data.d_cs);
		free (daemon_data.d_cs);
	}

	if (daemon_data.d_ewb != 0)
		CloseHandle (daemon_data.d_ewb);

	prt_destroy();
#endif
	exit(code);
}

/* Create the name of the executable from the macro EWB (always on Windows) */
/* or from the environment variable ES4_NAME (only on Unix/VMS) */

rt_private void process_name (char *ewb_path)
{
#ifdef EIF_WIN32
	strcat (ewb_path, EWB);
#else
	char *es4_name;
	char *local;

	es4_name = getenv("ES4_NAME");		/* Installation directory */

	if (es4_name == (char *) 0)			/* Environment variable set */
		strcat (ewb_path, EWB);
	else {
#ifdef EIF_VMS
			/* for VMS, es4_name is the full path to the es4 executable */
			strcpy (ewb_path, es4_name);	    /* replace bench/spec/platform */
			strcat (ewb_path, " -bench");
#else
			/* else its the name in the bench ewb bin/ directory */
			local = (char *) malloc (50 * sizeof (char));
			strcpy (local, "/bin/");
			strcat (local, es4_name);
			strcat (local, " -bench");
			strcat (ewb_path, local);
#endif
		}
#endif
}

#ifndef HAS_STRDUP
#if defined(EIF_VMS) || defined(__STDC__)
rt_public char *strdup (const char* s)
#else
rt_public char *strdup (char *s)
#endif
{
	char *new;
	int l = strlen (s) + 1;

	if (new = (char *) malloc (l))
		strncpy (new, s, l);
	else
		return (char *) 0;

	return new;
}
#endif  /* HAS_STRDUP */


#ifdef EIF_WIN32
	//extern char **_argv;		/* External declaration for command-line argumnents */

char szAppName [] = "ebench";		/* Window class name for temporary ebench window */
HANDLE hInst;				/* Application main instance			 */
HWND hwnd;				/* Handle of temporary ebench window 	*/

char slogan1 [] = "Inquire about our hands-on Eiffel sessions in Santa Barbara\nthe ideal way to learn from the experts.\n<info@eiffel.com>, 805-685-1006.";
char slogan2 [] = "\"Object-Oriented Software Construction\": the definitive\nreference on object technology. Order from your\nbookstore or directly from ISE for immediate delivery";
char slogan3 [] = "SPECIAL MAINTENANCE DEAL covering all releases for one year.\nGet the new, exciting Eiffel developments as\nthey come out. <info@eiffel.com>, 805-685-1006.";
char slogan4 [] = "For the latest on ISE Eiffel, Eiffel projects, on-line\ndocumentation, new products: come back often to\nhttp://www.eiffel.com - 4-star McKinley award-winning site.";
char slogan5 [] = "Windows Tech Journal about ISE Eiffel, December 1996:\n\"Eiffel may be the most thoroughly object-oriented\nlanguage that's commercially available\".";
char slogan6 [] = "Object Magazine, Editor's Choice, December 96: ISE Eiffel.\n\"My favorite testing tool is the Eiffel language. Eiffel\nprevents bugs by facilitation good software engineering.\"";
char slogan7 [] = "Windows Tech Journal on ISE Eiffel, December 96:\"Tired of\ndevelopment environments that only pretend to be O-O?\nISE Eiffel will have you marching to a different drummmer\"";
char slogan8 [] = "GUI building: are you aware of the Eiffel Resource Bench?\nFREE for a limited time only with purchase of\nISE Eiffel 4. <info@eiffel.com>, 805-685-1006.";
char slogan9 [] = "Tell us about your project! Let us study with you how\nISE Eiffel 4 can help you gain the competitive edge.\nWrite to <info@eiffel.com>.";
char slogan10 [] = "Do you know about Eiffel on other platforms? The most\nportable environment in the industry also runs on\nUnix, Linux, OpenVMS, and more.";
char slogan11 [] = "How to build quality reusable component libraries?\nRead the definitive reference:\"Reusable Software\",\nPrentice Hall. See http://www.eiffel.com/doc/books/reusable.html";
char slogan12 [] = "Does your manager understand objects? Be kind: get him\nor her a copy of \"Object Success: A Manager's Guide to Object Technologie\"\nSee http://www.eiffel.com/doc/books/success.html";
char slogan13 [] = "Addison-Wesley has a whole book series devoted to\nEiffel:\"Eiffel in Practice\".\n See http://www.awl.com/cp/eiffel.html";
char slogan14 [] = "Interested in the CORBA-Eiffel interface?\n Contact ISE <info@eiffel.com> for pricing.";
char slogan15 [] = "Lots of Eiffel books are available.\n See http://www.eiffel.com/doc/documentation.html.";
char slogan16 [] = "Eiffel spells reuse!\nThe Eiffel Shelf wants your libraries.";
char slogan17 [] = "High-level consulting: have\nISE's world-class experts review your architecture.";
char slogan18 [] = "Get published! Many magazines are eager to publish Eiffel\nexperience reports. Contact ISE and we'll help you\nsubmit your article to the right publication";

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
	else *lpiNumColors = 0;  // No palette needed for 24 BPP DIB

	if (*lpiNumColors)
	{
		hLogPal = GlobalAlloc (GHND, sizeof (LOGPALETTE) +
				sizeof (PALETTEENTRY) * (*lpiNumColors));
		lpPal = (LPLOGPALETTE) GlobalLock (hLogPal);
		lpPal->palVersion	 = 0x300;
		lpPal->palNumEntries = *lpiNumColors;

		for (i = 0;  i < *lpiNumColors;  i++)
		{
			lpPal->palPalEntry[i].peRed   = lpbmi->bmiColors[i].rgbRed;
			lpPal->palPalEntry[i].peGreen = lpbmi->bmiColors[i].rgbGreen;
			lpPal->palPalEntry[i].peBlue  = lpbmi->bmiColors[i].rgbBlue;
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
    HRSRC  hRsrc;
	HGLOBAL hGlobal;
    HBITMAP hBitmapFinal = NULL;
    LPBITMAPINFOHEADER  lpbi;
    HDC hdc;
    int iNumColors;

    if (hRsrc = FindResource(hInstance, lpString, RT_BITMAP))
	{
		hGlobal = LoadResource(hInstance, hRsrc);
		lpbi = (LPBITMAPINFOHEADER)LockResource(hGlobal);

		hdc = GetDC(NULL);
		*lphPalette =  CreateDIBPalette ((LPBITMAPINFO)lpbi, &iNumColors);
		if (*lphPalette)
		{
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
		UnlockResource(hGlobal);
		FreeResource(hGlobal);
	}
    return (hBitmapFinal);
}

void display_splash()
{
    HDC dc, MemDC;
    HBITMAP Bitmap, OldBitmap;
    BITMAP bm;
    RECT sr;
    HPALETTE palette;

	int i,lines,random;
	size_t j;
	CHAR *slogan;
	CHAR st[100];
	SIZE size;

    dc = CreateDC ("DISPLAY", NULL, NULL, NULL);
    Bitmap = LoadResourceBitmap (hInst, MAKEINTRESOURCE (1024),  &palette);

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

    SelectObject (dc, GetStockObject (SYSTEM_FIXED_FONT));
    memset (st, 0, sizeof (st));
    i=0;
    j=0;
    lines=0;
    random = GetTickCount () % 19;
    switch (random)
    {
	case 0: slogan = slogan1;
		break;
	case 1: slogan = slogan2;
		break;
	case 2: slogan = slogan3;
		break;
	case 3: slogan = slogan4;
		break;
	case 4: slogan = slogan5;
		break;
	case 5: slogan = slogan6;
		break;
	case 6: slogan = slogan7;
		break;
	case 7: slogan = slogan8;
		break;
	case 8: slogan = slogan9;
		break;
	case 9: slogan = slogan10;
		break;
	case 10: slogan = slogan11;
		break;
	case 11: slogan = slogan11;
		break;
	case 12: slogan = slogan12;
		break;
	case 13: slogan = slogan13;
		break;
	case 14: slogan = slogan14;
		break;
	case 15: slogan = slogan15;
		break;
	case 16: slogan = slogan16;
		break;
	case 17: slogan = slogan17;
		break;
	case 18: slogan = slogan18;
		break;
    }

    while (j<strlen(slogan))
    {
		st [i++] = slogan[j++];
		if (slogan[j]=='\n')
		{
			GetTextExtentPoint32 (dc, st, strlen (st), &size);
			TextOut (dc, sr.left + 5 + ((600 - size.cx) / 2),
				370 + sr.top + lines * 20, st, strlen (st));
			memset (st, 0, sizeof (st));
			i=0;
			lines++;
			j++;
		}
    }
	GetTextExtentPoint32 (dc, st, strlen (st), &size);

	TextOut (dc, sr.left + 5 + ((600 - size.cx) / 2), 370 + sr.top + lines * 20, st, strlen (st));

    DeleteObject (SelectObject (MemDC, OldBitmap));
    DeleteDC (MemDC);
    DeleteDC (dc);
}

/*** Callback for the temporary ebench window ***/
LRESULT CALLBACK WndProc (HWND hwnd, UINT message, LONG wParam, LONG lParam)
{
	return DefWindowProc (hwnd, message, wParam, lParam);
}

int WINAPI WinMain (HANDLE hInstance, HANDLE hPrevInstance, LPSTR lpszCmdLine, int nCmdShow)
{
/* Initialize Ebench, launch es4 and establish communications */

	int argc;
	char **argv;
	char *tmp = strdup (GetCommandLine());	/* Cannot use lpszCmdLine since we need the
											   application name */

	display_splash ();

	argv = shword (tmp);	/* Create from the string returned by GetCommandLine,
							   an array of string */

		/* Count the number of elements in argv */
	for (argc = 0; argv[argc] != (char *) 0; (argc)++)
		;

	init_bench (argc, argv);
	return 0L;
}

#else  /* (not) EIF_WIN32 */

rt_public int main (int argc, char **argv)
{
	/* This is the main entry point for the ISE daemon */
	init_bench (argc, argv);
	return 0L;
}
#endif
