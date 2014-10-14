/*
	description: "Protocol handling. Wait for requests and dispatch them."
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
#include "eif_file.h"
#define print_err_msg fprintf
#else
#define USE_SIGNAL
#include "rt_err_msg.h"
#endif


#include <sys/types.h>

#ifndef EIF_WINDOWS
#include <unistd.h>
#include <sys/wait.h>
#endif

#include "dbg_proto.h"
#include "select.h"
#include "com.h"
#include "stream.h"
#include "eif_network.h"
#include "transfer.h"		/* for swallow() */
#include "eif_logfile.h"
#include "rqst_idrs.h"
#include "child.h"
#include "ecdbgd.h"
#include <stdio.h>		/* For BUFSIZ */
#include <string.h>
#include <signal.h>
#include <stdlib.h>
#include "rt_dir.h"
#include "rt_assert.h"
#include "rt_native_string.h" /* Macro to manipulate EIF_NATIVE_CHAR * */


#ifdef EIF_VMS
#include <starlet.h>	/* for SYS$FORCEX */
#include <ssdef.h>	/* for SS$_ABORT */
#include "ipcvms.h"	/* for IPCVMS_WAKE_EWB */
#endif /* EIF_VMS */

/*
 * Declarations 
 */

extern unsigned int TIMEOUT;		/* Time out for interprocess communications */

#define OTHER(x) ((x) == daemon_data.d_cs ? daemon_data.d_as : daemon_data.d_cs)

#define INTERRUPT_APPLICATION	1
#define UPDATE_BREAKPOINTS_RQST	2
rt_private void write_application_interruption_flag(unsigned char value); 	/* write `value' in the interruption flag
																			 * inside application memory space */

rt_public void dbg_send_packet(EIF_PSTREAM sp, Request *dans);				/* Send an asnwer to client */
rt_private void dprocess_request(EIF_PSTREAM sp, Request *rqst);			/* General processing of requests */
rt_private void transfer(EIF_PSTREAM sp, Request *rqst);					/* Handle transfer requests */
rt_private void commute(EIF_PSTREAM from, EIF_PSTREAM to, size_t size);		/* Commute data from one file to another */
rt_private void set_ipc_ewb_pid(int pid);						/* Set IPC ewb pid value */
rt_private void set_ipc_timeout(unsigned int t);				/* Set IPC TIMEOUT value */
rt_private void start_app(EIF_PSTREAM sp);						/* Start Eiffel application */
rt_private void attach_app(EIF_PSTREAM sp);						/* Attach Eiffel application */
rt_private void get_application_cwd (EIF_PSTREAM sp);			/* Get application cwd */
rt_private void get_application_env (EIF_PSTREAM sp);			/* Get application env */
rt_public void drqsthandle(EIF_PSTREAM);							/* General request processor */
#ifdef EIF_WINDOWS
rt_public int dbg_recv_packet(EIF_PSTREAM sp, Request *rqst, BOOL reset);	/* Request reception */
rt_private LPVOID get_interrupt_flag(EIF_PSTREAM sp, Request *rqst);	/* retrieve the address of the interrupt flag */
#else
rt_public int dbg_recv_packet(EIF_PSTREAM sp, Request *rqst);			/* Request reception */
#endif

rt_private void kill_app(EIF_PSTREAM sp);		/* Kill Eiffel application brutally*/
rt_private void detach_app(void);	/* Detach Eiffel application */
rt_private IDRF dbg_idrf;			/* IDR filters used for serializing */
rt_private char dbg_idrf_initialized = (char) 0;	/* IDR filter already initialized ? */
rt_private int interrupted;			/* Has application been asked to be interrupted */
rt_private EIF_NATIVE_CHAR *current_directory = NULL;	/* Directory where application is launched */
rt_private EIF_NATIVE_CHAR *current_app_env = NULL;	/* Environment in which application is launched */

/*
 * IDR protocol initialization.
 */

rt_public void dbg_prt_init(void)
{
	if (!dbg_idrf_initialized) {
		if (-1 == idrf_create(&dbg_idrf, IDRF_SIZE)) {
			print_err_msg(stderr, "cannot initialize streams\n");
			exit(1);
		}
		dbg_idrf_initialized = (char) 1;
	}
}

#ifdef EIF_WINDOWS
rt_public void dbg_prt_destroy (void)
{
	idrf_destroy (&dbg_idrf);
}
#endif

rt_public void drqsthandle(EIF_PSTREAM sp)
{
	/* Given a connected socket, wait for a request and process it */
	Request rqst;			/* The request we are waiting for */
	Request_Clean (rqst);	/* recognized as non initialized -- Didier */

#ifdef EIF_WINDOWS
	if (-1 == dbg_recv_packet(sp, &rqst, FALSE))		/* Get request */
#else
	if (-1 == dbg_recv_packet(sp, &rqst))		/* Get request */
#endif
		return;

	dprocess_request(sp, &rqst);		/* Process the received request */
}

rt_private void dprocess_request(EIF_PSTREAM sp, Request *rqst)
							/* The connected socket */
							/* The received request to be processed */
{
	/* Process the received request. Most of the time, we simply pass along
	 * the request to the other process we are connected to, whoever spoke
	 * first. Some control requests have special meaning though and require
	 * appropriate processing.
	 */

#ifdef USE_ADD_LOG
	add_log(8, "processing request type %d", rqst->rq_type);
#endif

#ifdef WINDEBUG
		printf ("In dprocess_request %d\n", rqst->rq_type);
#endif

	switch (rqst->rq_type) {
	case CLOSE_DBG:
		daemon_exit(0);
		break;
	case KPALIVE:			/* Dummy request for connection checks */
		break;
	case SET_IPC_PARAM:		/* set IPC parameters */
		set_ipc_ewb_pid ((int) rqst->rq_opaque.op_1);	
		set_ipc_timeout ((unsigned int) rqst->rq_opaque.op_2);	
		break;
	case TRANSFER:			/* Data transfer via daemon */
		transfer(sp, rqst);
		break;
	case APPLICATION_CWD:	/* Current directory where application will be launched */
		get_application_cwd(sp);	
		break;
	case APPLICATION_ENV:	/* Current environment in which application will be launched */
		get_application_env(sp);	
		break;
	case APPLICATION:		/* Start application */
		interrupted = FALSE;
		start_app(sp);
		break;
	case ATTACH:		/* Attach application */
		interrupted = FALSE;
		attach_app(sp);
		break;
	case KILL:				/* Kill application asynchronously */
		kill_app(OTHER(sp));
		break;
#ifdef EIF_WINDOWS
	case APP_INTERRUPT_FLAG:	/* Get the address of the interrupt flag within application space */
		daemon_data.d_interrupt_flag = get_interrupt_flag(sp, rqst);
		break;
#endif	/* EIF_WINDOWS */
	case EWB_INTERRUPT:
			/* Debugger asking to interrupt application */
		interrupted = TRUE;
	case EWB_UPDBREAKPOINTS:
			/* Estudio signals the user has added new breakpoints */
#ifdef EIF_WINDOWS
		switch(rqst->rq_type) {
			case EWB_UPDBREAKPOINTS:
				write_application_interruption_flag(UPDATE_BREAKPOINTS_RQST);
				break;
			case EWB_INTERRUPT:
				write_application_interruption_flag(INTERRUPT_APPLICATION);
				break;
		}
#else	/* EIF_WINDOWS */
#ifdef USE_SIGNAL
#ifdef USE_ADD_LOG
		add_log(20, "sending interrupt request/signal to process %d\n", daemon_data.d_app);
#endif
		if (daemon_data.d_app != 0)
			/* If we send the signal too early, d_app is not initialized, 
			 * and in this case kill sends the signal to estudio, which kills it */
		{
			switch(rqst->rq_type) {
				case EWB_UPDBREAKPOINTS:
					write_application_interruption_flag(UPDATE_BREAKPOINTS_RQST);
					break;
				case EWB_INTERRUPT:
					write_application_interruption_flag(INTERRUPT_APPLICATION);
					break;
			}
			kill(daemon_data.d_app, SIGTRAP);	/* send a SIGTRAP signal to the application */
		}
#endif 	/* USE_SIGNAL */
#endif	/* EIF_WINDOWS */
		break;
	case APP_INTERRUPT:		/* Application wondering if it has to stop */
		if (interrupted)
			send_info(daemon_data.d_as, INTERRUPT_OK);
		else
			send_info(daemon_data.d_as, INTERRUPT_NO);
		interrupted = FALSE;
		break;

#if defined(EIF_VMS) && defined(IPCVMS_WAKE_EWB)  	/* this is probably no longer necessary */
	case STOPPED:	/* application is stopped at a brkpoint */
		/*printf ("File: %s line: %d: IPCVMS_WAKE_EWB\n", __FILE__, __LINE__); */
		dbg_send_packet(OTHER(sp), rqst);
		IPCVMS_WAKE_EWB(writefd(OTHER(sp)));
		break;
#endif /* EIF_VMS && IPCVMS_WAKE_EWB */

	case DETACH:			/* Detach application asynchronously */
		interrupted = FALSE;
		dbg_send_packet(OTHER(sp), rqst);
		detach_app();
		break;
	case RESUME:			/* Debugger asking to resume application */
		interrupted = FALSE;
		/* Fall through */	/* i.e. send the request to application */
	default:
		dbg_send_packet(OTHER(sp), rqst);
		break;
	}
}

rt_private void write_application_interruption_flag(unsigned char value)
	{
	/* write the given value for the interrupt flag into 
	 *	- the memory of the application (WIN32)
	 *	- the file called /tmp/estudioXXXX where XXXX is the PID of the application (UNIX)
	 */
#ifdef EIF_WINDOWS
	/* retrieve the handle of the Application (opened for writing) */
	/* we can't use the handle we get from CreateProcess because it's not open for writing -- ARNAUD */
	HANDLE 			hProcess;
	unsigned char	interrupt_flag = value;
	SIZE_T 			written = 0;
	LPVOID 			addr_flag = daemon_data.d_interrupt_flag;
	BOOL 			bResult;

	/* Why don't we use daemon_data.d_app ? Only to get write access? */
	hProcess = OpenProcess(PROCESS_VM_OPERATION | PROCESS_VM_WRITE, FALSE, daemon_data.d_app_id); 
	if (hProcess==NULL) {
		return;
	}

	bResult = WriteProcessMemory(hProcess, addr_flag, &interrupt_flag, sizeof(unsigned char), &written); 

	CloseHandle(hProcess);
	hProcess = NULL;
#else
	unsigned char 	interrupt_flag = value;
	int 			pid = daemon_data.d_app; /* application's PID */
	FILE			*file = NULL;
	char			filename[50];

	filename[0]='0';
	sprintf(filename,"/tmp/estudio%d",pid);

	file = fopen(filename,"wb");
	if (file != NULL) {
			/* If it fails to `write' then there is nothing we can do, User might just need to try
			 * again */
		(void) fwrite(&interrupt_flag, sizeof(unsigned char), 1, file);
		fclose(file);
	}	
#endif
	}
	
#ifdef EIF_WINDOWS
rt_private LPVOID get_interrupt_flag(EIF_PSTREAM sp, Request *rqst)
{
	LPVOID pFlagAddress;

	net_recv(sp, (char *)&pFlagAddress, sizeof(LPVOID), TRUE);
	
	return pFlagAddress;
}
#endif

/*
 * Sending/receiving packets.
 */

rt_public int dbg_recv_packet(EIF_PSTREAM sp, Request *rqst
#ifdef EIF_WINDOWS
		, BOOL reset
#endif
		)
				/* The connected socket */
				/* The request received */
 {
#ifdef USE_ADD_LOG
	add_log (9, "In dbg_recv_packet: sp=%d", sp);
#endif

#ifdef WINDEBUG
	printf ("In recv packet\n");
#endif
 	/* Receive packet from socket. For now, we only receive from a local pipe,
	 * which is also a socket in good English. Provision is made for network
	 * support though, simply add a few XDR calls here or there--RAM.
	 */

	/* If we cannot receive data, then the connection is surely broken */
 	if (-1 == net_recv(sp, idrs_buf(&dbg_idrf.i_decode), IDRF_SIZE
#ifdef EIF_WINDOWS
		, reset
#endif
		)) {
#ifdef USE_ADD_LOG
		add_log(9, "SYSERR recv: %m (%e)");
		add_log(12, "connection broken on fd #%d", sp);
		if ((void (*)()) 0 == rem_input(sp))
			add_log(4, "ERROR rem_input: %s (%s)", s_strerror(), s_strname());
#else
		(void) rem_input(sp);
#endif
		return -1;
	}

	dbg_rqstcnt++;			/* One more request */
	idrf_reset_pos(&dbg_idrf);	/* Reposition IDR streams */

	/* Deserialize request */
	if (!idr_Request(&dbg_idrf.i_decode, rqst)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot deserialize request #%d", dbg_rqstcnt);
#endif
		return -1;
	}

#ifdef DEBUG
	trace_request("got", rqst);
#endif

	return 0;
}

rt_public void dbg_send_packet(EIF_PSTREAM sp, Request *dans)
				/* The connected socket */
				/* The answer to send back */
{

#ifdef WINDEBUG
		printf ("In send packet %d\n", dans->rq_type);
#endif
 	/* Send and answer on the socket. For now, we only send on a local pipe,
	 * which is also a socket in good English. Provision is make for network
	 * support though, simply add a few XDR calls here or there--RAM.
	 */

	dbg_rqstsent++;			/* Keep track of the messages sent */
	idrf_reset_pos(&dbg_idrf);	/* Reposition IDR streams */

	/* Serialize the request */
	if (!idr_Request(&dbg_idrf.i_encode, dans)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR unable to serialize request %d", dans->rq_type);
#endif
		return;
	}

	/* Send the answer. Note that it is a fatal error if we cannot talk to the
	 * workbench. If we try to write to the application, simply remove input
	 * selection. That will trigger a DEAD request later on when we get back
	 * to wide_listen().
	 */
	if (-1 == net_send(sp, idrs_buf(&dbg_idrf.i_encode), IDRF_SIZE)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR send: %m (%e)");
		add_log(2, "ERROR while sending answer %d", dans->rq_type);
#endif
		if (sp == daemon_data.d_cs)	/* Talking to the workbench? */
		{
			daemon_exit(1);					/* Can't allow this stream to break */
		}
		(void) rem_input(sp);	/* Stop listening to that channel */
	}

#ifdef DEBUG
	trace_request("sent", dans);
#endif
}

/*
 * Protocol handling.
 */

rt_private void transfer(EIF_PSTREAM sp, Request *rqst)
				/* The connected socket */
				/* The request received */
{
	/* Deal with the TRANSFER request, which is used when one of the children
	 * want to send data to the other child.
	 */

	STREAM *o_sp;			/* Stream used to talk to the other child */


	/* It might happen that the other child is not connected any longer,
	 * mainly because he just die and the writing process has not been
	 * notified yet. In that case, we simply discard the message.
	 * Note that the packet negotation is weak and one of the processes
	 * could hang forever, waiting for data which will never come--RAM.
	 */

	o_sp = OTHER(sp);				/* Get stream connected to other child */
	if (o_sp == (STREAM *) 0) {
#ifdef USE_ADD_LOG
		add_log(12, "discarding %d bytes from #%d", rqst->rq_ack.ak_type, sp);
#endif
		swallow(sp, rqst->rq_ack.ak_type);
		return;
	}

	/* Okay, there seems to be a process out there. Send him the original
	 * TRANSFER request which contains the number of upcoming bytes, and
	 * then simply commute the first.
	 */

	dbg_send_packet(o_sp, rqst);
	commute(sp, o_sp, rqst->rq_ack.ak_type);
}

rt_private void commute(EIF_PSTREAM from, EIF_PSTREAM to, size_t size)
				/* Source file descriptor */
				/* Target file descriptor */
				/* Amount of bytes to be commuted */
{
	/* Commute 'size' bytes from source to target */

	char *buf = (char *) malloc((size > 0 ? size : 1) * sizeof(char));

	if (!buf) {
		daemon_exit (1);
	} else {
#ifdef USE_ADD_LOG
		add_log(12, "commuting %d bytes from #%d to #%d", size, from, to);
#endif

		buf[0] = (char) 0;

#ifdef EIF_WINDOWS
		if (-1 == net_recv(from, buf, size, TRUE)) {
#else
		if (-1 == net_recv(from, buf, size))  {
#endif
			free (buf);
		} else if (-1 == net_send(to, buf, size)) {	/* Cannot send any more */
			free (buf);
		} else {
			free (buf);
		}
	}
}

rt_private void get_application_cwd (EIF_PSTREAM sp)
{
	current_directory = (EIF_NATIVE_CHAR *) recv_natstr(sp, NULL);		/* Get command */

	if (current_directory) {
			/* If current directory is `.' we reset the value to NULL,
			 * meaning that we won't look at the value of `current_directory' */
#ifdef EIF_WINDOWS		
		if ((rt_nstrlen (current_directory) == 1) && (current_directory[0] == L'.')) {
#else
		if ((rt_nstrlen (current_directory) == 1) && (current_directory[0] == '.')) {
#endif
			free(current_directory);
			current_directory = NULL;
		}
	}
}

rt_private void get_application_env (EIF_PSTREAM sp)
{
	current_app_env = (EIF_NATIVE_CHAR *) recv_natstr(sp, NULL);		/* Get command */
		/* If current app env is '' we reset the value to NULL,
		 * meaning that we won't look at the value of `current_app_env' */
	if (current_app_env && (rt_nstrlen (current_app_env) == 0)) {
		free(current_app_env);
		current_app_env = NULL;
	}
}

rt_private void set_ipc_ewb_pid(int pid)
{
#ifdef EIF_WINDOWS
	daemon_data.d_ewb = (HANDLE) OpenProcess (SYNCHRONIZE, 0, (DWORD) pid);
#else
	daemon_data.d_ewb = (int) pid;			/* And keep track of the child pid */
#endif
}

rt_private void set_ipc_timeout(unsigned int t)
{
	/* Set IPC TIMEOUT value */
	if (t != 0) {
		TIMEOUT = t;
	};
}

rt_private void start_app(EIF_PSTREAM sp)
{
	/* Start Eiffel application, setting up the necessary communication stream.
	 * A positive acknowledgment is sent back if the process starts correctly.
	 */

	EIF_NATIVE_CHAR *exe_path;			/* Application to be run */
	EIF_NATIVE_CHAR *exe_args;			/* Arguments to use for application execution */
	STREAM *cp;			/* Child stream */
#ifdef EIF_WINDOWS
	HANDLE process_handle;	/* Child process handle */
	DWORD process_id;		/* Child process id */
#else
	Pid_t pid;			/* Child pid */
#endif

	/* Get Application executable path */
	exe_path = (EIF_NATIVE_CHAR *) recv_natstr(sp, NULL);		

	/* Get Application arguments */
	exe_args = (EIF_NATIVE_CHAR *) recv_natstr(sp, NULL);

#ifdef USE_ADD_LOG
	add_log(12, "starting app \n");
#endif

#ifdef EIF_WINDOWS
		/* First argument is 0 because we are not launching the compiler, but
		 * an application being debugged by the Eiffel debugger. */
	cp = spawn_child("app", exe_path, exe_args, current_directory, current_app_env, 1, &process_id, &process_handle, 0);	/* Start up children */
#else
	cp = spawn_child("app", exe_path, exe_args, current_directory, current_app_env, 1, &pid);	/* Start up children */
#endif

	free(exe_path);
	exe_path = NULL;
	free(exe_args);
	exe_args = NULL;
	if (current_directory) {
		free(current_directory);
		current_directory = NULL;
	}
	if (current_app_env) {
		free(current_app_env);
		current_app_env = NULL;
	}
	

#ifdef EIF_WINDOWS
	if (cp != (STREAM *) 0) {
		daemon_data.d_app = process_handle;			/* Record its process handle */
		daemon_data.d_app_id = process_id;			/* Record its process id */
		daemon_data.d_as = cp;					/* Set-up stream to talk to child */

		if (-1 == add_input(cp, (STREAM_FN) drqsthandle)) {
#ifdef USE_ADD_LOG
			add_log(4, "add_input: %s (%s)", s_strerror(), s_strname());
#endif
			send_ack(sp, AK_ERROR);	/* Cannot record input */
		} else {
#ifdef USE_ADD_LOG
			add_log(100, "sending ak_ok");
#endif
			send_ack(sp, AK_OK);		/* Application started ok */
			/* Send the process id to ewb */
			twrite(sp, &(daemon_data.d_app_id), sizeof(int));
		}
	} else {
#ifdef USE_ADD_LOG
		add_log(12, "stream from spawn invalid\n");
#endif
		send_ack(sp, AK_ERROR);	/* Could not start application */

#else /* #ifdef EIF_WINDOWS */
	if (cp != (STREAM *) 0) {
		daemon_data.d_app = (int) pid;			/* Record its pid */
		daemon_data.d_as = cp;					/* Set-up stream to talk to child */

		if (-1 == add_input(cp, drqsthandle)) {
#ifdef USE_ADD_LOG
			add_log(4, "add_input: %s (%s)", s_strerror(), s_strname());
#endif
			send_ack(sp, AK_ERROR);	/* Cannot record input */
		} else {
#ifdef USE_ADD_LOG
			add_log(100, "sending ak_ok");
#endif
			send_ack(sp, AK_OK);		/* Application started ok */
			/* Send the process id to ewb */
			twrite(sp, &(daemon_data.d_app), sizeof(int));
		}
	} else {
#ifdef USE_ADD_LOG
		add_log(12, "stream from spawn invalid\n");
#endif
		send_ack(sp, AK_ERROR);	/* Could not start application */
#endif
	}
}

rt_private void attach_app(EIF_PSTREAM sp)
{
	/* Attach Eiffel application, setting up the necessary communication stream.
	 * A positive acknowledgment is sent back if the process starts correctly.
	 */

	EIF_NATIVE_CHAR *exe_path;			/* Application to be run */
	unsigned int exe_port_number;	/* Port number to use to attach application */
	STREAM *cp;				/* Child stream */
	unsigned int debuggee_pid; /* debuggee's process id */
#ifdef EIF_WINDOWS
	HANDLE process_handle;	/* Child process handle */
	DWORD process_id;		/* Child process id */
#endif

	/* Get Application executable path */
	exe_path = (EIF_NATIVE_CHAR *) recv_natstr(sp, NULL);		

	/* Get port number */
	exe_port_number = (unsigned int) atoi((char *)recv_str(sp, NULL));
	if (exe_port_number <= 0) {
		send_ack(sp, AK_ERROR);	/* invalid port number */		
		return;
	}
#ifdef USE_ADD_LOG
	add_log(9, "Attaching [%s] on port [%i]\n", exe_path, exe_port_number);
#endif

	cp = new_stream_on_debuggee(exe_port_number, &debuggee_pid);

	free(exe_path);
	exe_path = NULL;
	exe_port_number = 0;

#ifdef EIF_WINDOWS
	if (cp != (STREAM *) 0) {
		process_id = (DWORD) debuggee_pid;
		process_handle = OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFORMATION | PROCESS_VM_READ | PROCESS_VM_WRITE | PROCESS_TERMINATE, FALSE, process_id);
		/* Note: 
		 * 		SYNCHRONIZE : to be able to do WaitForSingleObject in listen.c 
		 * 		PROCESS_TERMINATE : to be able to kill the application
		 */

		daemon_data.d_app = process_handle;			 /* Record its process handle */
		daemon_data.d_app_id = process_id; /* Record its process id */
		daemon_data.d_as = cp;					/* Set-up stream to talk to child */

		if (-1 == add_input(cp, (STREAM_FN) drqsthandle)) {
#ifdef USE_ADD_LOG
			add_log(4, "add_input: %s (%s)", s_strerror(), s_strname());
#endif
			send_ack(sp, AK_ERROR);	/* Cannot record input */
		} else {
#ifdef USE_ADD_LOG
			add_log(100, "sending ak_ok");
#endif
			send_ack(sp, AK_OK);		/* Application attached ok */
			/* Send the process id to ewb */
			twrite(sp, &(daemon_data.d_app_id), sizeof(int));
		}
	} else {
#ifdef USE_ADD_LOG
		add_log(12, "stream from attach invalid\n");
#endif
		send_ack(sp, AK_ERROR);	/* Could not attach application */

#else /* #ifdef EIF_WINDOWS */
	if (cp != (STREAM *) 0) {
		daemon_data.d_app = (int) debuggee_pid;	/* Record its pid */
		daemon_data.d_as = cp;					/* Set-up stream to talk to child */

		if (-1 == add_input(cp, drqsthandle)) {
#ifdef USE_ADD_LOG
			add_log(4, "add_input: %s (%s)", s_strerror(), s_strname());
#endif
			send_ack(sp, AK_ERROR);	/* Cannot record input */
		} else {
#ifdef USE_ADD_LOG
			add_log(100, "sending ak_ok");
#endif
			send_ack(sp, AK_OK);		/* Application attached ok */
			/* Send the process id to ewb */
			twrite(sp, &(daemon_data.d_app), sizeof(int));
		}
	} else {
#ifdef USE_ADD_LOG
		add_log(12, "stream from attach invalid\n");
#endif
		send_ack(sp, AK_ERROR);	/* Could not attach application */
#endif
	}
}

rt_private void kill_app (EIF_PSTREAM sp)
{
	/* Kill the application brutally */
	Request rqst;					/* Request to send */

	if (daemon_data.d_app != 0)		/* Check the application is still running */

#ifdef USE_ADD_LOG
		add_log(8, "Ask the application to quit itself");
#endif
		rqst.rq_type = QUIT;		/* ask the Application to exit */
		dbg_send_packet(sp, &rqst);	/* send to debuggee workbench */

#ifdef EIF_WINDOWS
		Sleep(100);
#else
#ifdef HAS_USLEEP
		usleep(100000);
#else
		sleep(1);
#endif
#endif


#ifdef USE_ADD_LOG
		add_log(8, "killing application process %d", daemon_data.d_app);
#endif

#ifdef EIF_WINDOWS
	{
		if (TerminateProcess (daemon_data.d_app, 0)) {
#ifdef USE_ADD_LOG
			add_log(8, "ERROR: KILL TerminateProcess return False");
#endif
		};
		rem_input (daemon_data.d_as);
	}
#elif defined(EIF_VMS)
	{
		VMS_STS sts;
		unsigned int pid = daemon_data.d_app;
		sts = SYS$FORCEX (&pid, 0, SS$_ABORT);
	}
#else
		kill((Pid_t) daemon_data.d_app, SIGKILL);
#endif
}

rt_public void dead_app(void)
{
	/* Signal ewb that the application is dead. This is why each transaction
	 * has to be acknowledged, so that ewb does not remain hung waiting for
	 * a reply which will never come. Setting a timeout would also be an
	 * option--RAM.
	 */

	Request rqst;					/* Request to send */
#ifndef EIF_WINDOWS
	int status;						/* Exit status of the application */
#endif

#ifdef USE_ADD_LOG
	add_log(12, "Daemon: app is dead");
#endif

	/* Eliminate the <defunct> process of the just terminated
	 * application to avoid the process table to go out of range.
	 * (Wait only for the application process, which should be
	 * already terminated. WNOHANG prevent the calling process
	 * of `waitpid' to be suspended if the child process is still
	 * running (just in case!)).
	 */
#if !defined (EIF_WINDOWS) && !defined (EIF_VMS) && !defined(VXWORKS)
		/* Ignore error if any, we only wait to get rid of defunct process. */
	(void) waitpid((Pid_t) daemon_data.d_app, &status, WNOHANG);
#endif

	rqst.rq_type = DEAD;						/* Application is dead */
	dbg_send_packet(daemon_data.d_cs, &rqst);	/* Notify workbench */
}

rt_private void detach_app (void)
{
	/* Detach the application brutally */

	if (daemon_data.d_app != 0)	{		/* Check the application is still running */
#ifdef USE_ADD_LOG
	add_log(8, "Detaching application process %d", daemon_data.d_app);
#endif

#ifdef EIF_WINDOWS
		rem_input (daemon_data.d_as);
#endif
	}
}
