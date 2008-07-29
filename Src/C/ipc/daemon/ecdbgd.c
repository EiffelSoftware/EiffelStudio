/*
	description: "Main entry point for `ecdbgd'."
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

#include "rt_err_msg.h"


#include <sys/types.h>
#include <stdio.h>
#include "dbg_proto.h"
#include "listen.h"

#include <string.h>
#if defined(EIF_SGI) || defined(EIF_SOLARIS)
#include <strings.h> /* for index and rindex. */
#endif

#include <signal.h>
#include "eif_logfile.h"
#include "stream.h"
#include "ewbio.h"
#include "identify.h"
#include "com.h"
#include "dbg_proto.h"
#include "child.h"

#include <stdlib.h>

#ifdef EIF_WINDOWS
#include <windows.h>
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

#ifdef EIF_WINDOWS
extern char *win_eif_getenv(char *k, char *app);	/* Get environment variable value */
#else
extern char *getenv(const char *);			/* Get environment variable value */
#endif

rt_public struct d_flags daemon_data = {	/* Internal daemon's flags */
	(unsigned int) 0,	/* d_rqst */
	(unsigned int) 0,	/* d_sent */
	(STREAM *) 0,		/* d_cs */
	(STREAM *) 0,		/* d_as */
};

/* Function */

rt_private void init_dbg(int argc, char **argv)
{
	STREAM *s;		/* Stream used for communications with ised */
	char *eif_timeout;	/* Timeout specified in environment variable */
#ifdef EIF_WINDOWS
	/* HANDLE pid = 0; */
	HANDLE *p_ewbin, *p_ewbout, *p_event_r, *p_event_w;
#else
	/* int pid = 0; */
	int fd_in, fd_out;
#endif

#ifdef EIF_WINDOWS
	eif_timeout = win_eif_getenv ("ISE_TIMEOUT", "ec");
#else
	eif_timeout = getenv ("ISE_TIMEOUT");
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

	if (eif_timeout != (char *) 0)			/* Environment variable set */
		TIMEOUT = (unsigned int) atoi(eif_timeout);
	else
		TIMEOUT = 30;

	set_signal();						/* Set up signal handler */
	signal (SIGABRT, exit);
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

#ifdef EIF_WINDOWS
	p_ewbin   = (HANDLE*) malloc(sizeof(HANDLE));
	p_ewbout  = (HANDLE*) malloc(sizeof(HANDLE));
	p_event_r = (HANDLE*) malloc(sizeof(HANDLE));
	p_event_w = (HANDLE*) malloc(sizeof(HANDLE));
	if (-1 == identify("dbg", p_ewbin, p_ewbout, p_event_r, p_event_w))				/* Make sure "ec" started us */
#else
	fd_in  = EWBIN;
	fd_out = EWBOUT;
	if (-1 == identify("dbg", fd_in, fd_out))				/* Make sure "ec" started us */
#endif
	{
		exit(1);
	}

	/* Create a stream, which associates the two ends of the pair of pipes
	 * opened with the parent. The STREAM provides a bidrectional abstraction.
	 */

#ifdef EIF_WINDOWS
	s = new_stream(*p_ewbin, *p_ewbout, *p_event_r, *p_event_w);
	free(p_ewbin);
	free(p_ewbout);
	free(p_event_r);
	free(p_event_w);
#else
	s = new_stream(fd_in, fd_out);
#endif

	if (s == (STREAM *) 0)
		exit(1);


	if (daemon_data.d_cs != NULL) { unregister_packet_functions (daemon_data.d_cs); }
	daemon_data.d_cs = s;				/* Record workbench stream */
	register_packet_functions (daemon_data.d_cs, &dbg_send_packet, &dbg_recv_packet);

	/* Since ecdgbd is launched by ewb, it doesn't have the process id of ewb
	 * it will be passed throught the IPC later 
	 * and set the daemon_data.d_ewb variable */

	dbg_prt_init();				/* Initialize IDR filters */
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
	/* FIXME jfiat [2006/11/23] : may be we should kill the app if it is still alive */
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

	dbg_prt_destroy();
#endif
	exit(code);
}

#ifdef EIF_ASSERTIONS
#if defined(EIF_WINDOWS) && defined(_DEBUG)
/* Uncomment the code below if you want to trap some runtime errors detected at runtime.
   If you don't, then the application usually exits without a chance of debugging.
*/
/*
void __cdecl report_failure(int code, void * unused)
{
	char s[512];
	if (code == _SECERR_BUFFER_OVERRUN) {
		printf("Buffer overrun detected! Program will end.\n");
		scanf("Press a key\n%s", s);
	}
}
*/
#endif
#endif

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

/*
	_set_security_error_handler(report_failure);
*/
#endif
#endif

	init_dbg (argc, argv);
	return 0L;
}


#ifdef EIF_WINDOWS

char szAppName [] = "ecdbgd";		/* Window class name for temporary estudio window */
HANDLE hInst;				/* Application main instance			 */
HWND hwnd;				/* Handle of temporary estudio window 	*/

rt_private void ecdbgd_shword(char *cmd, int *argc, char ***argvp)
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


	ecdbgd_shword (tmp, &argc, &argv);	/* Create from the string returned by GetCommandLine,
								an array of string */

		/* Count the number of elements in argv */
	for (argc = 0; argv[argc] != (char *) 0; (argc)++)
		;
	return_value = main (argc,argv);

	free (argv);
	return return_value;
}

#endif

