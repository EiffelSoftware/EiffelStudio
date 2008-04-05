/*
	description: "Network handling of debugging requests, when application is stopped."
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
#include "app_proto.h"
#include "ewbio.h"
#include "stream.h"
#include "com.h"
#include "identify.h"
#include "app_transfer.h"
#include "listen.h"
#include "eif_logfile.h"
#include <signal.h>
#include "rqst_const.h"
#include "server.h"
#include "rt_debug.h"
#include "rt_main.h" /* For debug_mode. */
#include "rt_macros.h" /* For catcall detection mode macros. */

#ifndef EIF_WINDOWS
#include <unistd.h>
#endif

#ifdef WORKBENCH
rt_public unsigned char interrupt_flag = 0;	/* 1=interrupt asked by user, 2=new breakpoint added while runnning */
#endif

extern STREAM *app_sp;
#ifndef EIF_WINDOWS
/* The USE_SIGNAL definition should be the same here and in /ipc/daemon/proto.c 
 * Otherwise a TRAP signal is sent to the application which cannot handle it and dies. */
#define USE_SIGNAL
#endif

rt_shared void dserver(void)
{
	/* This routine is called by the debugger once the program context has
	 * been saved. The application enters in a server mode, after having
	 * sent a stop notification to the remote workbench.
	 */

	if (!debug_mode)		/* If not in debugging mode */
		return;				/* Resume execution immediately */

#ifdef USE_ADD_LOG
	add_log(9, "STOPPED");
#endif

	stop_rqst(app_sp);		/* Notify workbench we stopped */
							/* was ifdef NEVER */

	wide_listen();			/* Listen on the socket, waiting for requests */

	/* Exiting from this routine resumes control to the debugger */
}

#ifdef WORKBENCH
#ifndef EIF_WINDOWS
#ifdef USE_SIGNAL
void sigtrap_handler (int sig)
	{
	int 	pid = getpid();	/* get current PID */
	FILE	*file = NULL;
	char	filename[50];
	
	if (sig==SIGTRAP)
		{
		/* Read the interrupt flag value from the file /tmp/estudioXXXX */
		/* where XXXX is the PID of the application */
		filename[0]='0';
		sprintf(filename,"/tmp/estudio%d",pid);

		file = fopen(filename,"rb");
		if (file != NULL)
			{
			fread(&interrupt_flag, sizeof(unsigned char), 1, file);
			fclose(file);
			}
		}
	}
#endif	/* USE_SIGNAL */
#endif	/* EIF_WINDOWS */
#endif	/* WORKBENCH */

rt_shared char dinterrupt(void)
{
	/* Send a request asking the daemon if the application has been
	 * interrupted by the debugger.
	 * 
	 * 0 stand for FALSE
	 * 1 stand for TRUE
	 *
	 * Note: when dinterrupt is called, the app is already inside DBGMTX_LOCK ...
	 */
	char result = 0;
#if defined(EIF_WINDOWS) || defined(USE_SIGNAL)
	unsigned char l_flag;
#endif
		
	if (!debug_mode)		/* If not in debugging mode */
		return result;			/* Resume execution immediately */
	
#ifdef WORKBENCH
#if !defined(EIF_WINDOWS) && !defined(USE_SIGNAL)
	send_info(app_sp, APP_INTERRUPT);
	wide_listen();			/* Listen on the socket, waiting for the answer */
	result = 1;
#else

	if (interrupt_flag!=0) {
		l_flag = interrupt_flag;
		interrupt_flag = 0;	/* reset the flag for further use */
		switch (l_flag)
			{
			case 1: /* interrupt requested by the user */
				safe_dbreak(PG_INTERRUPT);
				result = 1;
				break;
			case 2: /* new breakpoint added while running */
				safe_dbreak(PG_NEWBREAKPOINT);
				result = 1;
				break;
			default:
				/* wrong value, do nothing */
				break;
			}
		}
#endif
#endif	/* WORKBENCH */
	return result;
}

rt_shared void winit(void)
{
	/* Initialize the workbench process, by checking whether it has been
	 * started under debugger control or not. This routine is called early
	 * in the process execution by main().
	 */

#ifdef EIF_WINDOWS
	HANDLE *p_ewbin, *p_ewbout, *p_event_r, *p_event_w;
	LPVOID pFlagAddress;
#else	/* EIF_WINDOWS */
	int fd_in, fd_out;
#ifdef USE_SIGNAL
	sigset_t	mask_set;
	struct sigaction new_action;
#endif
#endif	/* EIF_WINDOWS */

	STREAM *sp;					/* Stream used to talk to ised */

#ifdef USE_ADD_LOG
#ifndef EIF_WINDOWS
	progpid = getpid();					/* Program's PID */
#endif
	progname = egc_system_name;					/* Computed by Eiffel run-time */

	/* Open a logfile in /tmp */
#ifdef EIF_WINDOWS
	(void) open_log("\\tmp\\ised.log");
#else
	(void) open_log("/tmp/ised.log");
#endif

	set_loglvl(LOGGING_LEVEL);			/* Set debug level */
	add_log(7, "identifying...");
#endif

#ifdef EIF_WINDOWS
	p_ewbin   = (HANDLE*) malloc(sizeof(HANDLE));
	p_ewbout  = (HANDLE*) malloc(sizeof(HANDLE));
	p_event_r = (HANDLE*) malloc(sizeof(HANDLE));
	p_event_w = (HANDLE*) malloc(sizeof(HANDLE));
	if (-1 == identify("app", p_ewbin, p_ewbout, p_event_r, p_event_w))
#else
	fd_in  = DBGIN;
	fd_out = DBGOUT;

	if (-1 == identify("app", fd_in, fd_out))
#endif
		/* Did ised start us? */
	{
#ifdef EIF_WINDOWS
		free(p_ewbin);
		free(p_ewbout);
		free(p_event_r);
		free(p_event_w);
#endif
		/* No, then debugging is not allowed */
		return;		
	}
	
	debug_mode = 1;					/* Debugging is allowed */
	set_catcall_detection_console(1); /* catcall detection in console */
	set_catcall_detection_debugger(1); /* catcall detection in debugger is enabled */


	/* Create a stream, which associates the two ends of the pair of pipes
	 * opened with the parent. The STREAM provides a bidrectional abstraction.
	 * (A pipe is only a one-way communication channel, but a pair of pipes is
	 * a two-way stream, unlike a socket which is already a two-way stream).
	 */

#ifdef EIF_WINDOWS
	sp = new_stream(*p_ewbin, *p_ewbout, *p_event_r, *p_event_w);
	free(p_ewbin);
	free(p_ewbout);
	free(p_event_r);
	free(p_event_w);
#else
	sp = new_stream(fd_in, fd_out);
#endif

	if (sp == (STREAM *) 0)
	{
		enomem();				/* A run-time critical exception */
	}

	app_tpipe(sp);					/* Initialize tread/twrite transfer pipe app_sp */
	app_prt_init();					/* Initialize IDR filters */

#ifdef USE_ADD_LOG
	add_log(7, "application started in debug mode");
#endif

#ifdef EIF_WINDOWS
	/* send the address of the flag */
	pFlagAddress = (LPVOID) (&interrupt_flag);
	send_info(sp, APP_INTERRUPT_FLAG);
	net_send(sp, (char *)&pFlagAddress, sizeof(LPVOID));
#else	/* EIF_WINDOWS */
#ifdef USE_SIGNAL
	/* install the new handler for SIGTRAP */
	sigemptyset(&mask_set);
	new_action.sa_mask = mask_set;
#ifndef SA_RESTART
#define SA_RESTART 0
#endif
	new_action.sa_flags = SA_RESTART;
	new_action.sa_handler = &sigtrap_handler;
	
	sigaction(SIGTRAP, &new_action, NULL);
#endif	/* USE_SIGNAL */
#endif	/* EIF_WINDOWS */

	wide_listen();				/* Listen to incoming request from ewb */
}

