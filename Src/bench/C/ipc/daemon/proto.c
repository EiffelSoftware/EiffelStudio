/*

 #####   #####    ####    #####   ####            ####
 #    #  #    #  #    #     #    #    #          #    #
 #    #  #    #  #    #     #    #    #          #
 #####   #####   #    #     #    #    #   ###    #
 #       #   #   #    #     #    #    #   ###    #    #
 #       #    #   ####      #     ####    ###     ####

	Protocol handling. Wait for requests and dispatch them,
*/

#include "eif_config.h"
#include "eif_portable.h"

#ifdef EIF_WIN32
#include "eif_file.h"
#define print_err_msg fprintf
#else
#include "eif_err_msg.h"
#endif

#include <sys/types.h>

#ifndef EIF_WIN32
#include <sys/wait.h>
#endif

#include "proto.h"
#include "select.h"
#include "com.h"
#include "stream.h"
#include "transfer.h"		/* for swallow() */
#include "eif_logfile.h"
#include "idrf.h"
#include "rqst_idrs.h"
#include <stdio.h>		/* For BUFSIZ */
#include <string.h>
#include <signal.h>
#include <stdlib.h>

#ifdef EIF_VMS
#include "ipcvms.h"
#endif

#ifdef EIF_WIN32
#define OTHER(x) ((x) == daemon_data.d_cs ? daemon_data.d_as : daemon_data.d_cs)
#else
#define OTHER(x) ((x) == readfd(daemon_data.d_cs) ? daemon_data.d_as : daemon_data.d_cs)
#endif

#ifdef EIF_WIN32
rt_public void drqsthandle(EIF_LPSTREAM);							/* General request processor */
rt_public void send_packet(STREAM *s, Request *dans);				/* Send an asnwer to client */
rt_public int recv_packet(STREAM *s, Request *rqst, BOOL reset);	/* Request reception */
rt_private void dprocess_request(STREAM *s, Request *rqst);			/* General processing of requests */
rt_private void transfer(STREAM *s, Request *rqst);					/* Handle transfer requests */
rt_private void commute(STREAM *from, STREAM *to, int size);		/* Commute data from one file to another */
rt_private void run_command(STREAM *sp);							/* Run specified command */
rt_private void run_asynchronous(STREAM *sp, Request *rqst);		/* Run command in background */
rt_private void start_app(STREAM *sp);								/* Start Eiffel application */
#else

rt_public void drqsthandle(int s);							/* General request processor */
rt_public void send_packet(int s, Request *dans);			/* Send an asnwer to client */
rt_public int recv_packet(int s, Request *rqst);			/* Request reception */
rt_private void dprocess_request(int s, Request *rqst);		/* General processing of requests */
rt_private void transfer(int s, Request *rqst);				/* Handle transfer requests */
rt_private void commute(int from, int to, int size);		/* Commute data from one file to another */
rt_private void run_command(int s);							/* Run specified command */
rt_private void run_asynchronous(int s, Request *rqst);		/* Run command in background */
rt_private void start_app(int s);							/* Start Eiffel application */
#endif

rt_private void kill_app(void);		/* Kill Eiffel application brutally*/
rt_private IDRF idrf;				/* IDR filters used for serializing */
rt_private int interrupted;			/* Has application been asked to be interrupted */

extern void dexit(int code);				/* Daemon exiting procedure */
#ifdef EIF_WIN32
extern STREAM *spawn_child(char *cmd, HANDLE *child_pid);		/* Start up child with ipc link */
#else
extern STREAM *spawn_child(char *cmd, Pid_t *child_pid);		/* Start up child with ipc link */
extern int errno;												/* System call error number */
#endif


/*
 * IDR protocol initialization.
 */

rt_public void prt_init(void)
{
	if (-1 == idrf_create(&idrf, IDRF_SIZE)) {
		print_err_msg(stderr, "cannot initialize streams\n");
		exit(1);
	}
}

#ifdef EIF_WIN32
rt_public void prt_destroy (void)
{
	idrf_destroy (&idrf);
}
#endif

#ifdef EIF_WIN32
rt_public void drqsthandle(STREAM *s)
#else
rt_public void drqsthandle(int s)
#endif
{
	/* Given a connected socket, wait for a request and process it */

	Request rqst;		/* The request we are waiting for */

	Request_Clean (rqst); /* recognized as non initialized -- Didier */

#ifdef EIF_WIN32
	if (-1 == recv_packet(s, &rqst, FALSE))		/* Get request */
#else
	if (-1 == recv_packet(s, &rqst))		/* Get request */
#endif
		return;

	dprocess_request(s, &rqst);		/* Process the received request */
}

#ifdef EIF_WIN32
rt_private void dprocess_request(STREAM *s, Request *rqst)
#else
rt_private void dprocess_request(int s, Request *rqst)
#endif
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
	case TRANSFER:			/* Data transfer via daemon */
		transfer(s, rqst);
		break;
	case CMD:				/* Run a forthcoming command */
		run_command(s);
		break;
	case ASYNCMD:			/* Run a command asynchronously */
		run_asynchronous(s, rqst);
		break;
	case APPLICATION:		/* Start application */
		interrupted = FALSE;
		start_app(s);
		break;
	case KILL:				/* Kill application asynchronously */
		kill_app();
		break;
	case EWB_INTERRUPT:		/* Debugger asking to interrupt application */
		interrupted = TRUE;
		break;
	case APP_INTERRUPT:		/* Application wondering if it has to stop */
		if (interrupted)
#ifdef EIF_WIN32
			send_info(daemon_data.d_as, INTERRUPT_OK);
#else
			send_info(writefd(daemon_data.d_as), INTERRUPT_OK);
#endif
		else
#ifdef EIF_WIN32
			send_info(daemon_data.d_as, INTERRUPT_NO);
#else
			send_info(writefd(daemon_data.d_as), INTERRUPT_NO);
#endif
		interrupted = FALSE;
		break;

#ifdef EIF_VMS	/* this is probably no longer necessary */
	case STOPPED:	/* application is stopped at a brkpoint */
		send_packet(writefd(OTHER(s)), rqst);
		IPCVMS_WAKE_EWB(writefd(OTHER(s)));
		break;
#endif

	case RESUME:			/* Debugger asking to resume application */
		interrupted = FALSE;
		/* Fall through */	/* i.e. send the request to application */
	default:
#ifdef EIF_WIN32
		send_packet(OTHER(s), rqst);
#else
		send_packet(writefd(OTHER(s)), rqst);
#endif
		break;
	}
}

/*
 * Sending/receiving packets.
 */

#ifdef EIF_WIN32
rt_public int recv_packet(STREAM *s, Request *rqst, BOOL reset)
#else
rt_public int recv_packet(int s, Request *rqst)
#endif
				/* The connected socket */
              	/* The request received */
{
#ifdef WINDEBUG
	printf ("In recv packet\n");
#endif
 	/* Receive packet from socket. For now, we only receive from a local pipe,
	 * which is also a socket in good English. Provision is made for network
	 * support though, simply add a few XDR calls here or there--RAM.
	 */

	/* If we cannot receive data, then the connection is surely broken */
#ifdef EIF_WIN32
 	if (-1 == net_recv(s, idrs_buf(&idrf.i_decode), IDRF_SIZE, reset)) {
#else
	if (-1 == net_recv(s, idrs_buf(&idrf.i_decode), IDRF_SIZE)) {
#endif
#ifdef USE_ADD_LOG
		add_log(9, "SYSERR recv: %m (%e)");
		add_log(12, "connection broken on fd #%d", s);
		if ((void (*)()) 0 == rem_input(s))
			add_log(4, "ERROR rem_input: %s (%s)", s_strerror(), s_strname());
#else
		(void) rem_input(s);
#endif
		return -1;
	}

	rqstcnt++;			/* One more request */
	idrf_pos(&idrf);	/* Reposition IDR streams */

	/* Deserialize request */
	if (!idr_Request(&idrf.i_decode, rqst)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot deserialize request #%d", rqstcnt);
#endif
		return -1;
	}

#ifdef DEBUG
	trace_request("got", rqst);
#endif

	return 0;
}

#ifdef EIF_WIN32
rt_public void send_packet(STREAM *s, Request *dans)
#else
rt_public void send_packet(int s, Request *dans)
#endif
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

#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[s];
#endif

	rqstsent++;			/* Keep track of the messages sent */
	idrf_pos(&idrf);	/* Reposition IDR streams */

	/* Serialize the request */
	if (!idr_Request(&idrf.i_encode, dans)) {
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
	if (-1 == net_send(s, idrs_buf(&idrf.i_encode), IDRF_SIZE)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR send: %m (%e)");
		add_log(2, "ERROR while sending answer %d", dans->rq_type);
#endif
#ifdef EIF_WIN32
		if (s == daemon_data.d_cs)	/* Talking to the workbench? */
#else
		if (s == writefd(daemon_data.d_cs))	/* Talking to the workbench? */
#endif
			dexit(1);					/* Can't allow this stream to break */
#ifdef EIF_WIN32
		(void) rem_input(s);	/* Stop listening to that channel */
#else
		(void) rem_input(readfd(sp));	/* Stop listening to that channel */
#endif
	}

#ifdef DEBUG
	trace_request("sent", dans);
#endif
}

/*
 * Protocol handling.
 */

#ifdef EIF_WIN32
rt_private void transfer(STREAM *s, Request *rqst)
#else
rt_private void transfer(int s, Request *rqst)
#endif
      			/* The connected socket */
              	/* The request received */
{
	/* Deal with the TRANSFER request, which is used when one of the children
	 * want to send data to the other child.
	 */

	STREAM *sp;			/* Stream used to talk to the other child */


	/* It might happen that the other child is not connected any longer,
	 * mainly because he just die and the writing process has not been
	 * notified yet. In that case, we simply discard the message.
	 * Note that the packet negotation is weak and one of the processes
	 * could hang forever, waiting for data which will never come--RAM.
	 */

	sp = OTHER(s);				/* Get stream connected to other child */
	if (sp == (STREAM *) 0) {
#ifdef USE_ADD_LOG
		add_log(12, "discarding %d bytes from #%d", rqst->rq_ack.ak_type, s);
#endif
		swallow(s, rqst->rq_ack.ak_type);
		return;
	}

	/* Okay, there seems to be a process out there. Send him the original
	 * TRANSFER request which contains the number of upcoming bytes, and
	 * then simply commute the first.
	 */

#ifdef EIF_WIN32
	send_packet(sp, rqst);
	commute(s, sp, rqst->rq_ack.ak_type);
#else
	send_packet(writefd(sp), rqst);
	commute(s, writefd(sp), rqst->rq_ack.ak_type);
#endif
}

#ifdef EIF_WIN32
rt_private void commute(STREAM *from, STREAM *to, int size)
#else
rt_private void commute(int from, int to, int size)
#endif
         		/* Source file descriptor */
       			/* Target file descriptor */
         		/* Amount of bytes to be commuted */
{
	/* Commute 'size' bytes from source to target */

	int amount = 0;				/* Amount of bytes to be read */
	char buf[BUFSIZ];

#ifdef USE_ADD_LOG
	add_log(12, "commuting %d bytes from #%d to #%d", size, from, to);
#endif

#ifdef EIF_WIN32
	if (size == 0)
		{
		amount = 0;
		if (-1 == net_recv(from, buf, amount, TRUE))
			return;
		if (-1 == net_send(to, buf, amount)) {	/* Cannot send any more */
#ifdef USE_ADD_LOG
			add_log(12, "discarding %d bytes from #%d", size, from);
#endif
			swallow(from, size - amount);		/* Discard further data */
			return;
			}
		}
#endif

	while (size > 0) {
		amount = size;
		if (amount > BUFSIZ)	/* Do not write more than standard size */
			amount = BUFSIZ;
#ifdef EIF_WIN32
		if (-1 == net_recv(from, buf, amount, TRUE))
#else
		if (-1 == net_recv(from, buf, amount))
#endif
			return;
		if (-1 == net_send(to, buf, amount)) {	/* Cannot send any more */
#ifdef USE_ADD_LOG
			add_log(12, "discarding %d bytes from #%d", size, from);
#endif
			swallow(from, size - amount);		/* Discard further data */
			return;
		}
		size -= amount;
	}
}

#ifdef EIF_WIN32
rt_private void run_command(STREAM *sp)
#else
rt_private void run_command(int s)
#endif
{
	/* Run a command, which is sent to us as a string, which should be passed
	 * unparsed to "/bin/sh -c" for execution.
	 */

	char *cmd;			/* Command to be run */
	int status;			/* Command status, as returned by system() */
    char *meltpath, *appname, *envstring;   /* set MELT_PATH */
#ifdef  EIF_WIN32
	STARTUPINFO				siStartInfo;
	PROCESS_INFORMATION		procinfo;
	char 					*current_dir;
#else
	STREAM *sp;			/* Stream to be used for communications */

	sp = stream_by_fd[s];				/* Fetch associated stream */
#endif

	cmd = recv_str(sp, (int *) 0);		/* Get command */
    meltpath = (char *) (strdup (cmd));
    if (meltpath == (char *)0){
#ifdef USE_ADD_LOG
 	    add_log(2, "ERROR out of memory: cannot exec '%s'", cmd);
#endif
  	   dexit (1);
     }

#ifdef __VMS
     appname = rindex (meltpath, ']');
     if (appname = rindex (meltpath, ']')) *appname = 0;
     else strcpy (meltpath, "[]");
#else
     appname = rindex (meltpath, '/');
     if (appname = rindex (meltpath, '/')) *appname = 0;
     else strcpy (meltpath, ".");
#endif
     envstring = (char *)malloc (strlen (meltpath)
   		 + strlen ("MELT_PATH=") + 1);
     if (!envstring){
#ifdef USE_ADD_LOG
   		 add_log(2, "ERROR out of memory: cannot exec '%s'", cmd);
#endif
    	 dexit (1);
	 }
     sprintf (envstring, "MELT_PATH=%s", meltpath);
     putenv (envstring);
#if defined (BSD) || defined (EIF_VMS)
	signal (SIGCHLD, SIG_DFL);
#elif defined (SIGCLD)
	signal (SIGCLD, SIG_DFL);
#endif

#ifdef EIF_WIN32
	current_dir = (char *) getcwd(NULL, PATH_MAX);

	memset (&siStartInfo, 0, sizeof(STARTUPINFO));
	siStartInfo.cb = sizeof(STARTUPINFO);
	siStartInfo.lpTitle = NULL;
	siStartInfo.lpReserved = NULL;
	siStartInfo.lpReserved2 = NULL;
	siStartInfo.cbReserved2 = 0;
	siStartInfo.lpDesktop = NULL;
	siStartInfo.dwFlags = 0;
	siStartInfo.hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
	siStartInfo.hStdInput =  GetStdHandle (STD_INPUT_HANDLE);
	siStartInfo.hStdError = GetStdHandle (STD_ERROR_HANDLE);

	status = -1;
	if (CreateProcess (NULL,
		cmd,
		NULL,
		NULL,
		TRUE,
		DETACHED_PROCESS,
		NULL,
		current_dir,
		&siStartInfo,
		&procinfo)) {
		CloseHandle (procinfo.hProcess);
		CloseHandle (procinfo.hThread);
		status = 0;
	}
	chdir(current_dir);
	free(current_dir);
#else
	status = system(cmd);				/* Run command via /bin/sh */
#endif

#if defined (BSD) || defined (EIF_VMS)
    signal (SIGCHLD, SIG_IGN);
#elif defined (SIGCLD)
    signal (SIGCLD, SIG_IGN);
#endif

#ifdef EIF_WIN32
	if (status == 0)
		send_ack(sp, AK_OK);		/* Command completed sucessfully */
	else
		send_ack(sp, AK_ERROR);	/* Comamnd failed */
#else
	if (status == 0)
		send_ack(writefd(sp), AK_OK);		/* Command completed sucessfully */
	else
		send_ack(writefd(sp), AK_ERROR);	/* Comamnd failed */
#endif
}

#ifdef EIF_WIN32
rt_private void run_asynchronous(STREAM *sp, Request *rqst)
#else
rt_private void run_asynchronous(int s, Request *rqst)
#endif
{
	/* Run a command asynchronously, that is to say in background. The command
	 * is identified by the client via a "job number", which is inserted in
	 * the request itself.
	 * The daemon forks a copy of itself which will be in charge of running
	 * the command and sending the acknowledgment back, tagged with the command
	 * number.
	 */

	char *cmd;			/* Command to be run */
	int status;			/* Command status, as returned by system() */
	int jobnum;			/* Job number assigned to comamnd */
	Request dans;		/* Answer (status of comamnd) */
#ifdef  EIF_WIN32
	STARTUPINFO				siStartInfo;
	PROCESS_INFORMATION		procinfo;
	char 					*current_dir;
#else
    char *meltpath, *appname, *envstring;   /* set MELT_PATH */
	STREAM *sp;			/* Stream to be used for communications */

	sp = stream_by_fd[s];				/* Fetch associated stream */
#endif

	cmd = recv_str(sp, (int *) 0);		/* Get command */

	dans.rq_type = ASYNACK;				/* Initialize the answer type */
	jobnum = rqst->rq_opaque.op_first;	/* Job number assigned by client */
	dans.rq_opaque.op_first = jobnum;	/* Anwser is tagged with job number */

#ifdef EIF_WIN32
	current_dir = (char *) getcwd(NULL, PATH_MAX);

	memset (&siStartInfo, 0, sizeof(STARTUPINFO));
	siStartInfo.cb = sizeof(STARTUPINFO);
	siStartInfo.lpTitle = NULL;
	siStartInfo.lpReserved = NULL;
	siStartInfo.lpReserved2 = NULL;
	siStartInfo.cbReserved2 = 0;
	siStartInfo.lpDesktop = NULL;
	siStartInfo.dwFlags = 0;
	siStartInfo.hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
	siStartInfo.hStdInput =  GetStdHandle (STD_INPUT_HANDLE);
	siStartInfo.hStdError = GetStdHandle (STD_ERROR_HANDLE);

	status = -1;
	if (CreateProcess (
		NULL,
		cmd,
		NULL,
		NULL,
		TRUE,
		DETACHED_PROCESS,
		NULL,
		current_dir,
		&siStartInfo,
		&procinfo))
	{
		CloseHandle (procinfo.hProcess);
		CloseHandle (procinfo.hThread);
		status = 0;
	}
	chdir(current_dir);
	free(current_dir);

#else

#ifndef EIF_VMS	/* VMS needs a higher level abstraction for async system() */
	switch (fork()) {
	case -1:				/* Cannot fork */
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR fork: %m (%e)");
		add_log(2, "ERROR cannot run asynchronous command");
#endif
		dans.rq_opaque.op_second = AK_ERROR;
/*
 * Asynchronous commands do not send acknowledgment back anymore
 * -- FRED
		send_packet(writefd(sp), &dans);
*/
		break;
	case 0:					/* Child is performing the command */
#ifdef USE_ADD_LOG
		progpid = getpid();
		close_log();		/* Closing and reopening to avoid share of file */
		reopen_log();
#endif
		break;
	default:
		return;				/* Parent returns immediately */
	}
#endif /* not VMS (skip fork/parent code if VMS) */

/* child */
    meltpath = (char *) (strdup (cmd));
    if (meltpath == (char *)0){
#ifdef USE_ADD_LOG
            add_log(2, "ERROR out of memory: cannot exec '%s'", cmd);
#endif
           dexit (1);
     }

#ifdef EIF_VMS
     if (appname = rindex (meltpath, ']')) *appname = 0;
     else strcpy (meltpath, "[]");
#else
     appname = rindex (meltpath, '/');
     if (appname = rindex (meltpath, '/')) *appname = 0;
     else strcpy (meltpath, ".");
#endif
     envstring = (char *)malloc (strlen (meltpath)
                 + strlen ("MELT_PATH=") + 1);
     if (!envstring){
#ifdef USE_ADD_LOG
                 add_log(2, "ERROR out of memory: cannot exec '%s'", cmd);
#endif
         dexit (1);
         }
     sprintf (envstring, "MELT_PATH=%s", meltpath);
     putenv (envstring);
#if defined (BSD) || defined (__VMS)
        signal (SIGCHLD, SIG_DFL);
#else
        signal (SIGCLD, SIG_DFL);
#endif

#ifndef EIF_VMS
	status = system(cmd);				/* Run command via /bin/sh */
#else	/* VMS */
	status = ipcvms_spawn(cmd, 1);
#endif	/* EIF_VMS */

	if (status == 0)
		dans.rq_opaque.op_second = AK_OK;	/* Command completed sucessfully */
	else
		dans.rq_opaque.op_second = AK_ERROR;	/* Comamnd failed */

#ifdef EIF_VMS
	if (status) {  /* command failed */
	    char *pgmname = ipcvms_get_progname(NULL);
	    fprintf (stderr, "%s: %s: \n-- error from system() call: %d\n"
	    "-- failed cmd: \"%s\" -- %s\n", 
	    pgmname, __FILE__, errno, cmd, strerror(errno));
	}
	return;	    /* skip send ack packet, Fred says not done anymore */
#else /* not VMS */

/*
 * Asynchronous commands do not send command status back anymore
 *
 * -- FRED
	send_packet(writefd(sp), &dans);
*/
#ifdef USE_ADD_LOG
	add_log(12, "child exiting");
#endif
	exit(0);							/* Child is exiting properly */
#endif /* EIF_VMS */
#endif /* EIF_WIN32 */
	/* NOTREACHED */
}

#ifdef EIF_WIN32
rt_private void start_app(STREAM *sp)
#else
rt_private void start_app(int s)
#endif
{
	/* Start Eiffel application, setting up the necessary communication stream.
	 * A positive acknowledgment is sent back if the process starts correctly.
	 */

	char *cmd;			/* Aplication to be run */
	STREAM *cp;			/* Child stream */
#ifdef EIF_WIN32
	HANDLE pid;			/* Child pid */
#else
	Pid_t pid;			/* Child pid */
	STREAM *sp;			/* Stream to be used for communications */

	sp = stream_by_fd[s];				/* Fetch associated stream */
#endif

	cmd = recv_str(sp, (int *) 0);		/* Get command */
#ifdef USE_ADD_LOG
	add_log(12, "starting app  \n");
#endif

	cp = spawn_child(cmd, &pid);			/* Start up children */

#ifdef EIF_WIN32
	if (cp != (STREAM *) 0) {
		daemon_data.d_app = (HANDLE) pid;			/* Record its pid */
		daemon_data.d_as = cp;					/* Set-up stream to talk to child */

		if (-1 == add_input(cp, (HANDLE_FN) drqsthandle)) {
#ifdef USE_ADD_LOG
			add_log(4, "add_input: %s (%s)", s_strerror(), s_strname());
#endif
			send_ack(sp, AK_ERROR);	/* Cannot record input */
		} else {
#ifdef USE_ADD_LOG
			add_log(100, "sending ak_ok");
#endif
			send_ack(sp, AK_OK);		/* Application started ok */
		}
	} else {
#ifdef USE_ADD_LOG
		add_log(12, "stream from spawn invalid\n");
#endif
		send_ack(sp, AK_ERROR);	/* Could not start application */

#else /* #ifdef EIF_WIN32 */
	if (cp != (STREAM *) 0) {
		daemon_data.d_app = (int) pid;			/* Record its pid */
		daemon_data.d_as = cp;					/* Set-up stream to talk to child */

		if (-1 == add_input(readfd(cp), drqsthandle)) {
#ifdef USE_ADD_LOG
			add_log(4, "add_input: %s (%s)", s_strerror(), s_strname());
#endif
			send_ack(writefd(sp), AK_ERROR);	/* Cannot record input */
		} else {
#ifdef USE_ADD_LOG
			add_log(100, "sending ak_ok");
#endif
			send_ack(writefd(sp), AK_OK);		/* Application started ok */
		}
	} else {
#ifdef USE_ADD_LOG
		add_log(12, "stream from spawn invalid\n");
#endif
		send_ack(writefd(sp), AK_ERROR);	/* Could not start application */
#endif
	}
}

rt_private void kill_app (void)
{
	/* Kill the application brutally */

	if (daemon_data.d_app != 0)		/* Check the application is still running */
#ifdef EIF_WIN32
	{
		TerminateProcess (daemon_data.d_app, 0);
		rem_input (daemon_data.d_as);
	}
#else
		kill((Pid_t) daemon_data.d_app, SIGKILL);
#endif
}

rt_public void dead_app(void)
{
	/* Signal ewb that the application is dead. This is why each transaction
	 * has to be acknowledged, so that ewb does not remain hung waiting for
	 * a reply which will never come. Settting a timeout would also be an
	 * option--RAM.
	 */

	Request rqst;					/* Request to send */
#ifndef EIF_WIN32
	int status;						/* Exit status of the application */
	Pid_t child_pid;				/* pid of the dead application */
#endif

#ifdef USE_ADD_LOG
	add_log(12, "app is dead");
#endif

	/* Eliminate the <defunct> process of the just terminated
	 * application to avoid the process table to go out of range.
	 * (Wait only for the application process, which should be
	 * already terminated. WNOHANG prevent the calling process
	 * of `waitpid' to be suspended if the child process is still
	 * running (just in case!)).
	 */
#if !defined (EIF_WIN32) && !defined (EIF_VMS)
	child_pid = waitpid((Pid_t) daemon_data.d_app, &status, WNOHANG);
#endif

	rqst.rq_type = DEAD;			/* Application is dead */
#ifdef EIF_WIN32
	send_packet(daemon_data.d_cs, &rqst);			/* Notify workbench */
#else
	send_packet(writefd(daemon_data.d_cs), &rqst);			/* Notify workbench */
#endif
}
