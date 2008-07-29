/*
	description: "[
			Connection initialization.
			For Windows:
				Once connection is established call tpipe to set stream that will
				be used elsewhere.
			]"
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
#include <sys/types.h>
#include "eif_logfile.h"
#include "stream.h"
#include "ewbio.h"
#include "ewb_child.h"
#include "ewb_proto.h"
#include "ewb_transfer.h"
#include <string.h>
#include <signal.h>

#ifndef EIF_WINDOWS
/* for pid related functions */
#include <unistd.h>
#include <sys/wait.h>
#endif

/* Data declaration */

extern unsigned int TIMEOUT;		/* Time out for interprocess communications */
rt_public struct ewb_flags ewb_data = {	/* Internal ewb's flags */
	(unsigned int) 0,	/* d_rqst */
	(unsigned int) 0,	/* d_sent */
	(STREAM *) 0,		/* d_cs */
};

/* Extern function declaration */
#include "rqst_const.h"
extern void send_rqst_0 (long int code);


#ifdef EIF_WINDOWS
#	ifndef USE_ADD_LOG
rt_public char progname[30];	/* Otherwise defined in logfile.c */
#	endif
#else
#	ifndef USE_ADD_LOG
rt_public char *progname;	/* Otherwise defined in logfile.c */
#	endif
#endif

/* Function declaration */
rt_public void ewb_exit(int code);			/* Daemon's exit */
rt_public void clean_connection(void);	/* Clean connection with ecdbgd */
rt_private Signal_t handler(int sig);	/* Signal handler */
rt_private void init_signals (void);
rt_private char init_signals_done = (char) 0;	/* is init_signals already called ? */

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
	ewb_exit(0);
}


rt_public void ewb_exit(int code)
{
#ifdef USE_ADD_LOG
	add_log(12, "exiting with status %d", code);
#endif
	clean_connection();
	exit(code);
}

rt_public int is_ecdbgd_alive (void) 
{
	if (ewb_data.d_ecdbgd == 0 || ewb_data.d_cs == (STREAM *) 0) {
		return 0;
	};
	return (ewb_active_check(ewb_data.d_cs, ewb_data.d_ecdbgd) == 0);
}

rt_public int launch_ecdbgd (char* progn, char* cmd, int eif_timeout) 
{
	STREAM *sp;			/* Stream used to talk to the child "ecdbgd" */
#ifdef EIF_WINDOWS
	HANDLE pid;			/* Pid of the spawned child */
#else
	Pid_t pid;			/* Pid of the spawned child */
#endif

	/* Check if the user wants to override the default timeout value
	 * required by the children processes to launch and initialize
	 * themselves. This new value is specified in the ISE_TIMEOUT
	 * environment variable
	 */
	
	TIMEOUT = (unsigned int) eif_timeout;

	/* Compute program name, removing any leading path to keep only the name
	 * of the executable file.
	 */

#ifdef USE_ADD_LOG
	progpid = getpid();					/* Program's PID */
	progname = egc_system_name;					/* Computed by Eiffel run-time */

	/* Open a logfile in /tmp */

#	ifdef EIF_WINDOWS
	/* Open a logfile in /tmp */
		(void) open_log("\\tmp\\ised.log");
#	else
#		ifdef EIF_VMS
			(void) open_log("sys$scratch:ebench.log");
#		else
	/* Open a logfile in /tmp */
			(void) open_log("/tmp/ised.log");
#		endif
#	endif /* platform */
	set_loglvl(LOGGING_LEVEL);			/* Set debug level */
#endif /* USE_ADD_LOG */


	init_signals();						/* Set up signal handler */

	sp = spawn_ecdbgd ("dbg", cmd, &pid);	/* Bring "ecdbgd" to life */

	if (sp == (STREAM *) 0) {
		return -1;
	}

	ewb_data.d_cs = sp; /* Record ecdbgd stream */
#ifdef EIF_WINDOWS
	ewb_data.d_ecdbgd = (HANDLE) pid;		/* And keep track of the child pid */
#else
	ewb_data.d_ecdbgd = (int) pid;			/* And keep track of the child pid */
#endif
	
	return 1;
}

rt_public int close_ecdbgd (int eif_timeout) 
{
#ifndef EIF_WINDOWS
	pid_t child_pid, wpid;
	int status;
#endif
	send_rqst_0 (CLOSE_DBG);
#ifdef EIF_WINDOWS
	return 0;
#else
	child_pid = (pid_t) ewb_data.d_ecdbgd;
	if (child_pid > 0) {
		wpid = waitpid(child_pid, &status, WNOHANG | WUNTRACED
#ifdef WCONTINUED       /* Not all implementations support this */
			| WCONTINUED
#endif
	        );	
		return wpid;
	} else {
		return 0;
	}
#endif
}

rt_private void init_signals (void)
{
	/* Initialize signals handlers once */
	if (init_signals_done != (char) 1) {
		set_signal();						/* Set up signal handler */
		signal (SIGABRT ,exit);
#ifdef EIF_WINDOWS
#ifdef SIGQUIT
		signal (SIGQUIT, exit);
#endif
#else
		signal (SIGQUIT, exit);
#endif
		init_signals_done = (char) 1;
	}
}

rt_public void init_connection(int* err)
{
	STREAM *sp;		/* Stream used for communications with ised */

#ifdef USE_ADD_LOG
	progname = egc_system_name;					/* Computed by Eiffel run-time */

	/* Open a logfile in /tmp */
	(void) open_log("\\tmp\\ewb.log");
	set_loglvl(20);			/* Set debug level */
#endif

	/* Create a stream, which associates the two ends of the pair of pipes
	 * opened with the parent. The STREAM provides a bidrectional abstraction.
	 */

	sp = ewb_data.d_cs;

	if (sp == (STREAM *) 0) {
		*err = -1;
		return ;
	}

	ewb_prt_init();				/* Initialize IDR filters */
	ewb_tpipe(sp);				/* Initialize transfers with application */

#ifdef USE_ADD_LOG
	progpid = getpid();					/* Program's PID */
	progname = egc_system_name;					/* Computed by Eiffel run-time */

	/* Open a logfile in /tmp */
	(void) open_log("/tmp/ised.log");
	set_loglvl(LOGGING_LEVEL);			/* Set debug level */
#endif
}

rt_public void clean_connection(void)
{
    ewb_tpipe(NULL);    /* Clear PIPE between ewb and ecdgbd */
    if (ewb_data.d_cs) {
        close_stream (ewb_data.d_cs);
        free (ewb_data.d_cs);
        ewb_data.d_cs = NULL;
    }
#ifdef EIF_WINDOWS
    if (ewb_data.d_ecdbgd != 0) {
        CloseHandle (ewb_data.d_ecdbgd);
    }
#endif
}

#ifdef EIF_WINDOWS
/* C routines for the communications of debugged application and debugger. */


typedef void (* EVENT_CALLBACK)(EIF_REFERENCE);
EVENT_CALLBACK event_callback;
EIF_OBJECT event_object;
EIF_INTEGER delay;
UINT_PTR event_id;

void CALLBACK ioh_timer(HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime);

void win_ioh_make_client(EIF_POINTER a, EIF_OBJECT o, EIF_INTEGER a_delay)
{
	event_callback = (EVENT_CALLBACK) a;
	event_object = eif_adopt (o);
	delay = a_delay; 
}

void CALLBACK ioh_timer(HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime)
{
	/* KillTimer */
	if (WaitForSingleObject (readev(ewb_sp), 0) == WAIT_OBJECT_0) {
		(event_callback)(eif_access(event_object));
	}
}

void start_timer (void)
{
	/* Start the timer event to check for communications 
	   between ewb and the ecdbgd */
	event_id = SetTimer (NULL, 0, delay, (TIMERPROC) ioh_timer);
}

void stop_timer (void)
{
	/* Kill the timer event */
	KillTimer (NULL, event_id);
}

void win_ioh_clean_client(void)
{
	stop_timer();
	event_callback = NULL;
	eif_wean (event_object);
	delay = 0; 
}

DWORD ewb_current_process_id() 
{
	return GetCurrentProcessId();
}
#else

int ewb_current_process_id() 
{
	return getpid();
}

int ewb_pipe_read_fd () {
	return readfd(ewb_sp);
}

#endif
