/*
	description: "Child spawning and comforting."
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
#include "rt_assert.h"

#include <sys/types.h>
#include "eif_logfile.h"
#include "stream.h"
#include "timehdr.h"
#include "ewbio.h"
#include "ewb_child.h"
#include "select.h"
#include "request.h"	/* for typedef struct{...} Request */

#ifdef EIF_WINDOWS
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include "uu.h"
#endif

#include "rt_dir.h"

#include <signal.h>
#include <setjmp.h>
#include <string.h>
#include <errno.h>
#include <stdio.h>

#ifdef I_SYS_FILE
#include <sys/file.h>
#endif

#ifdef I_FCNTL
#include <fcntl.h>
#endif

#ifdef EIF_VMS
#include "ipcvms.h"
#include <lib$routines.h>
#include <jpidef.h>
#include <ssdef.h>
#endif

/* #define USE_ADD_LOG */

#define PIPE_READ	0		/* File descriptor used for reading */
#define PIPE_WRITE	1		/* File descriptor used for writing */

extern unsigned int TIMEOUT;	/* Time to let the child initialize */
#define dexit(i) return NULL;
#define SPAWN_CHILD_FAILED(i) return NULL;

#ifndef EIF_WINDOWS
/* To fight SIGPIPE signals */
rt_private jmp_buf env;		/* Environment saving for longjmp() */
rt_private Signal_t broken(void);	/* Signal handler for SIGPIPE */
#endif

/* Function declaration */
rt_private int comfort_child(STREAM *sp);	/* Reassure child, make him confident */
#ifndef EIF_WINDOWS
extern char **ipc_shword(char *cmd);			/* Shell word parsing of command string */
rt_private void close_on_exec(int fd);	/* Ensure this file will be closed by exec */
/*
#else
rt_private void create_dummy_window (void);
*/
#endif

#ifdef EIF_WINDOWS
rt_public STREAM *spawn_ecdbgd(char*id, char *ecdbgd_path, HANDLE *child_process_handle)
#else
rt_public STREAM *spawn_ecdbgd(char*id, char *ecdbgd_path, Pid_t *child_pid)
#endif
          			/* The child command process */
                 	/* Where pid of the child is written */
					/* Where ProcessId is written (can be NULL if you don't need it) */
{
	/* Launch the child process 'ecdbgd_path' and return the stream structure which can
	 * be used to communicate with the child. Note that this function only
	 * returns in the parent process.
	 */

#ifdef EIF_WINDOWS
	HANDLE pp2c[2];						/* The opened downwards file descriptors : parent to child */
	HANDLE pc2p[2];						/* The opened upwards file descriptors : child to parent */
	HANDLE child_event_r;				/* Event for signalling readability */
	HANDLE child_event_w;				/* Event for signalling writeability */
	HANDLE pp2c_write_to_dup;
	CHAR   event_str[128];				/* Event name */

	BOOL	fSuccess;					/* Did CreateProcess succeed? */
	PROCESS_INFORMATION	piProcInfo;
	STARTUPINFO		siStartInfo;
	SECURITY_ATTRIBUTES	saAttr;

	HANDLE uu_str [2];		/* Field to UUEncode  */
	char *t_uu;				/* Result of UUEncode */
	int uu_buffer_size;		/* Size of buffer needed for UUEncoding. */

	char *cmdline;			/* Duplicate of command line since we need to add some special arguments. */
	char error_msg[128] = "";								/* Error message displayed when we cannot lauch the program */
#else
	int r;
	int pp2c[2];				/* The opened downwards file descriptors : parent to child */
	int pc2p[2];				/* The opened upwards file descriptors : child to parent */
	int new;					/* Duped file descriptor */
	Pid_t pid;					/* Pid of the child */
	char **argv;				/* Argument vector */
#endif
	STREAM *sp;							/* Stream used for communications with ewb */

#ifdef EIF_WINDOWS
		/* We encode 2 pointers, plus '"?' and '?"' plus a space and a null terminating character. */
	uu_buffer_size = uuencode_buffer_size(2) + 6; /* 6 = "? + space + ?" + \0 */

	cmdline = malloc (strlen (ecdbgd_path) + uu_buffer_size);
	strcpy (cmdline, ecdbgd_path);
#else
	argv = ipc_shword(ecdbgd_path);					/* Split command into words */
#endif

	/* Set up pipes and fork, then exec the workbench. Two pairs of pipes are
	 * opened, one for downwards communications (ised -> ewb) and one for
	 * upwards (ewb -> ised).
	 */

#ifdef EIF_WINDOWS
	/* Standard pipe oeratons for Windows
		DuplicateHandle is called to set correct permisions.
	*/

	saAttr.nLength = sizeof (SECURITY_ATTRIBUTES);
	saAttr.bInheritHandle = TRUE;
	saAttr.lpSecurityDescriptor = NULL;

	if (!CreatePipe (&(pc2p[PIPE_READ]), &(pc2p[PIPE_WRITE]), &saAttr, 0)) {
#else
	if (-1 == pipe(pc2p)) {
#endif
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR: pipe: %m (%e)");
		add_log(2, "ERROR cannot set up upwards pipe");
#endif
		perror("pipe up");
		return NULL;
	}

#ifdef EIF_WINDOWS
	if (!CreatePipe (&(pp2c[PIPE_READ]), &(pp2c_write_to_dup), &saAttr, 0)) {
#else
	if (-1 == pipe(pp2c)) {
#endif
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR: pipe: %m (%e)");
		add_log(2, "ERROR cannot set up downwards pipe");
#endif
		perror("pipe down");
		return NULL;
	}
#ifdef EIF_WINDOWS
#ifdef USE_ADD_LOG
	add_log(12, "opened pipes as pc2p(%d, %d), pp2c(%d, %d)",
		pc2p[PIPE_READ], pc2p[PIPE_WRITE], pp2c[PIPE_READ], pp2c_write_to_dup);
#endif
#else
#ifdef USE_ADD_LOG
	add_log(12, "opened pipes as pc2p(%d, %d), pp2c(%d, %d)",
		pc2p[PIPE_READ], pc2p[PIPE_WRITE], pp2c[PIPE_READ], pp2c[PIPE_WRITE]);
#endif
#endif


#ifdef EIF_WINDOWS
/* NOTA jfiat: we could use SetHandleInformation if we were not supporting win9x
 * SetHandleInformation( pp2c[PIPE_WRITE], HANDLE_FLAG_INHERIT, 0);
 */

	if (!DuplicateHandle (GetCurrentProcess(), pp2c_write_to_dup,
		GetCurrentProcess(), &(pp2c[PIPE_WRITE]), 0,
		FALSE, DUPLICATE_SAME_ACCESS)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot dup pipe %d", GetLastError());
#endif
		perror("duplicate handle");
		SPAWN_CHILD_FAILED(1);
	}

	if (!CloseHandle (pp2c_write_to_dup)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot close dupped pipe %d", GetLastError());
#endif
		perror("close handle");
		SPAWN_CHILD_FAILED(1);
	}
	pp2c_write_to_dup = NULL;

	/* Encode the pipes to start the child */
	/* ... ' \"?' + UUENCODED2POINTERS + '?\"' */

	uu_str [0] = pc2p [PIPE_WRITE];
	uu_str [1] = pp2c [PIPE_READ];
	strcat (cmdline, " \"?");
	t_uu = uuencode_str ((char *) uu_str, 2 * sizeof (HANDLE));
	strcat (cmdline, t_uu);
	free (t_uu);
	strcat (cmdline, "?\"");


#ifdef USE_ADD_LOG
	add_log(20, "Command line: %s", cmdline);
#endif

	/* Set up members of STARTUPINFO structure. */

	siStartInfo.cb = sizeof(STARTUPINFO);
	siStartInfo.lpTitle = NULL;
	siStartInfo.lpReserved = NULL;
	siStartInfo.lpReserved2 = NULL;
	siStartInfo.cbReserved2 = 0;
	siStartInfo.lpDesktop = NULL;
	siStartInfo.dwFlags = STARTF_FORCEONFEEDBACK;

	fSuccess = CreateProcess (
		NULL,				/* Application's name */
		cmdline,			/* Command line */
		NULL,				/* Process security attribute */
		NULL,				/* Primary thread security attributes */
		TRUE,				/* Handles are inherited */
		CREATE_NEW_CONSOLE,	/* Creation flags */
		NULL,				/* Use parent's environment */
		NULL,				/* Use parent's current directory */
		&siStartInfo,		/* STARTUPINFO pointer */
		&piProcInfo);		/* for PROCESS_INFORMATION */

	if (!fSuccess) {
#ifdef USE_ADD_LOG
		add_log(20, "ERROR cannot create process %d", GetLastError());
		add_log(20, "Error code %d", GetLastError());
#endif
		strcat (error_msg, "Cannot Launch the program \"");
		strcat (error_msg, cmdline);
		strcat (error_msg, "\"\nMake sure you have correctly set up your installation.");
		MessageBox (NULL, error_msg, "Execution terminated",
					MB_OK + MB_ICONERROR + MB_TASKMODAL + MB_TOPMOST);
		InvalidateRect (NULL, NULL, FALSE);
	}

#ifdef USE_ADD_LOG
		add_log(20, "After success Error code %d", GetLastError());
#endif
	/*	Required by Windows	*/
	CloseHandle (piProcInfo.hThread);
	piProcInfo.hThread = NULL;

	if (!fSuccess) {
			/* Error */
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR: fork: %m (%e)");
		add_log(2, "ERROR cannot fork, sorry");
#endif
		perror("fork");
		SPAWN_CHILD_FAILED(1);
	} else {	/* Parent process */
				/* Let child initialize or print error */
#ifdef USE_ADD_LOG
		add_log(12, "started process");
#endif
	}

#else	/* (not) EIF_WINDOWS -- UNIX, VMS */

#ifdef EIF_VMS
    /* VMS has no fork(). It does have vfork, which sets up the context	*/
    /* for a subsequent exec call. vfork and exec work together like	*/
    /* setjmp and longjmp. When control returns from vfork the first	*/
    /* time, the return value (child process id) is zero, and the	*/
    /* context is set up for a subsequent exec, but the child process	*/
    /* has not yet been created. After a successful exec call, the	*/
    /* child process is created and control returns (in the parent) to	*/
    /* the statement following the vfork call, with the return value	*/
    /* now set to the child's process id. Therefore, all the setup that	*/
    /* is performed in the default case in the switch statement below	*/
    /* (which is supposed to happen after the child process is created)	*/
    /* must be deferred until after the exec call.			*/
    /*									*/
    /* In the child process, control never returns here, because a new	*/
    /* image is started by the exec call. For VMS, the code in the	*/
    /* child process case of the switch below that closes pipes must be	*/
    /* executed in the IDENTIFY routine.				*/

	pid = vfork();
	/* control returns here after a successful exec[v] call */

#else	/* EIF_VMS */

	    /* The fork and exec stuff: a classic */
	pid = (Pid_t) fork();		/* That's where we fork */

#endif /* EIF_VMS */

	switch (pid) {
	case -1:		/* Error */
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR: fork: %m (%e)");
		add_log(2, "ERROR cannot fork, sorry");
#endif
		perror("fork");
		SPAWN_CHILD_FAILED(1);

	case 0:			/* Child process */
#if defined(USE_ADD_LOG) && !defined(EIF_VMS)
		close_log();					/* Logfile should not cross exec() */
#endif

#ifdef EIF_VMS	/* On VMS, we're still executing in the parent process.	    */
		/* Now we set up file descriptors for the child and ensure  */
		/* that the parent ends of the pipes (pp2c[WRITE] and	    */
		/* pc2p[READ]) remain open and are not implicitly closed by  */
		/* the dup2 fest below, and mark them FD_CLOEXEC.	    */
		/* The required state for spawning the child is:	    */
		/*   EWBOUT == pc2p[WRITE], EWBIN == pp2c[READ]		    */
/*DEBUG*/	ipcvms_fd_dump ("before adjust pipes for child: pc2p[%d,%d], pp2c[%d,%d]", pc2p[0],pc2p[1],pp2c[0],pp2c[1]);
		if (EWBOUT == pp2c[PIPE_WRITE] || EWBOUT == pc2p[PIPE_READ] 
			|| EWBIN == pp2c[PIPE_WRITE] || EWBIN == pc2p[PIPE_READ]) {
		    int new_recv, new_send;
		    new_recv = dup(pc2p[PIPE_READ]);
		    new_send = dup(pp2c[PIPE_WRITE]);
		    close (pc2p[PIPE_READ]);
		    close (pp2c[PIPE_WRITE]);
		    pc2p[PIPE_READ]  = new_recv;
		    pp2c[PIPE_WRITE] = new_send;
		}
		close_on_exec (pc2p[PIPE_READ]);
		close_on_exec (pp2c[PIPE_WRITE]);
/*DEBUG*/	ipcvms_fd_dump ("before dup2 pipes for child: pc2p[%d,%d], pp2c[%d,%d]", pc2p[0],pc2p[1],pp2c[0],pp2c[1]);

#else /* (not) EIF_VMS */
		/* FIXME why is it necessary to close each twice??? -- David_sS */
		r = close(pp2c[PIPE_WRITE]);
		r = close(pc2p[PIPE_READ]);
		r = close(pp2c[PIPE_WRITE]);
		r = close(pc2p[PIPE_READ]);
#endif /* EIF_VMS */

		/* Start duping first allocated pipe, otherwise good luck!--RAM.
		 * Be careful about the case where the pipe you want to dup on is
		 * already used by the other pipe.
		 * (Hint #1: dup2 closes its target fd before duping file)
		 * (Hint #2: pipe() takes the lowest two file descriptors available)
		 */
		if (pp2c[PIPE_READ] != EWBOUT) {
			if (pc2p[PIPE_WRITE] != EWBOUT) {
				dup2(pc2p[PIPE_WRITE], EWBOUT);	/* Child writes to ewbout */
				r = close(pc2p[PIPE_WRITE]);			/* Close dup'ed files before exec */
			}
			if (pp2c[PIPE_READ] != EWBIN) {
				dup2(pp2c[PIPE_READ], EWBIN);	/* Child reads from ewbin */
				r = close(pp2c[PIPE_READ]);			/* (avoid child running out of fd!) */
			}
		} else {
			/* Bad case: pp2c[PIPE_READ] == EWBOUT. We cannot use the code above since
			 * the first dup2 will close EWBOUT, which unfortunately is used by a pipe
			 * end which also need to be kept alive until dup2'ed! Ouch--RAM
			 */
			if (pp2c[PIPE_READ] != EWBIN) {
				dup2(pp2c[PIPE_READ], EWBIN);	/* Child reads from ewbin */
				r = close(pp2c[PIPE_READ]);			/* (avoid child running out of fd!) */
			}
			if (pc2p[PIPE_WRITE] != EWBOUT) {
				dup2(pc2p[PIPE_WRITE], EWBOUT);	/* Child writes to ewbout */
				r = close(pc2p[PIPE_WRITE]);			/* Close dup'ed files before exec */
			}
		}
		/* Now exec command. A successful launch should not return */
		if (argv != (char **) 0) {
#ifdef EIF_VMS
/*DEBUG*/		ipcvms_fd_dump ("before execv (spawn child): pc2p[%d,%d], pp2c[%d,%d]", pc2p[0],pc2p[1],pp2c[0],pp2c[1]);
			execv(argv[0], argv);
#else
			execvp(argv[0], argv);
#endif
			print_err_msg(stderr,"ERROR could not launch '%s'", argv[0]);
#ifdef USE_ADD_LOG
			reopen_log();
			add_log(1, "SYSERR: exec: %m (%e)");
			add_log(2, "ERROR could not launch '%s'", argv[0]);
#endif
		}
#ifdef USE_ADD_LOG
		else
			add_log(2, "ERROR out of memory: cannot exec '%s'", ecdbgd_path);
#endif
		SPAWN_CHILD_FAILED(1);

	default:		/* Parent process */
		sleep(1);	/* Let child initialize or print error */
#ifndef EIF_VMS
		/* on VMS this was done in the case 0: code above when	*/
		/* when the child's pipes were dup2'ed to EWBOUT/EWBIN	*/
		close(pp2c[PIPE_READ]);
		close(pc2p[PIPE_WRITE]);
#endif
		/* Reset those file descriptors to the lowest possible number, just to
		 * remain clean (the pipe() system call allocating two files, multiple
		 * calls to pipe() lead to a messy file allocation table)--RAM.
		 */
		new = dup(pc2p[PIPE_READ]);
		if (new != -1 && new < pc2p[PIPE_READ]) {
			close(pc2p[PIPE_READ]);
			pc2p[PIPE_READ] = new;
		} else if (new != -1) {
			close(new);
		}
		/* Same thing with writing file descriptor. Note that we only keep the
		 * new duped descriptor when it is lower than the current original.
		 */
		new = dup(pp2c[PIPE_WRITE]);
		if (new != -1 && new < pp2c[PIPE_WRITE]) {
			close(pp2c[PIPE_WRITE]);
			pp2c[PIPE_WRITE] = new;
		} else if (new != -1) {
			close(new);
		}
		/* No need to dup2() file descriptors, we do not exec() anybody yet.
		 * However, do make sure those remaining descriptors will be closed
		 * by any further exec.
		 */
		close_on_exec(pc2p[PIPE_READ]);
		close_on_exec(pp2c[PIPE_WRITE]);
	} /* end switch(pid) */
#endif

	/* Create a STREAM structure, which provides the illusion of bidrectional
	 * communication through the pair of pipes. When networking is added, the
	 * interface will remain unchanged.
	 */

#ifdef EIF_WINDOWS
	sprintf (event_str, "eif_event_r%x_%s", (unsigned int) piProcInfo.dwProcessId, id);
	child_event_r = CreateSemaphore (NULL, 0, 32767, event_str);
	sprintf (event_str, "eif_event_w%x_%s", (unsigned int) piProcInfo.dwProcessId, id);
	child_event_w = CreateSemaphore (NULL, 0, 32767, event_str);

#ifdef USE_ADD_LOG
	add_log(12, "Opened Semaphores as %d %d",child_event_r,child_event_w);
#endif

	sp = new_stream(pc2p[PIPE_READ], pp2c[PIPE_WRITE], child_event_r, child_event_w);

	CloseHandle (pc2p[PIPE_WRITE]);
	CloseHandle (pp2c[PIPE_READ]);
	pc2p[PIPE_WRITE] = NULL;
	pp2c[PIPE_READ] = NULL;

#else /* not EIF_WINDOWS */
	sp = new_stream(pc2p[PIPE_READ], pp2c[PIPE_WRITE]);

#ifdef EIF_VMS
	/* now close files that we had to open to set up for child exec */
	close (EWBOUT);
	close (EWBIN);
#if defined(USE_ADD_LOG) 
#define EIF_VMS 10 /* cause duplicate define warning */
	ipcvms_fd_dump ("after spawn child");
#endif
#endif /* EIF_VMS */

#endif /* (not) EIF_WINDOWS */

	/* Makes sure the child started correctly, and let him know we started him
	 * from here, and that it is not a normal user invocation.
	 */

	if (-1 == comfort_child(sp))
	{
#ifdef USE_ADD_LOG
		add_log(12, "could not comfort child");
#endif
		return (STREAM *) 0;		/* Wrong child */
	}

	/* Record child's pid, which may be necessary to ensure it remains alive,
	 * or to send some signals, or whatever...
	 */

#ifdef EIF_WINDOWS
	if (child_process_handle != NULL) {
		*child_process_handle = piProcInfo.hProcess;
	}

	free (cmdline);
#else
	if (child_pid != (Pid_t *) 0)
		*child_pid = pid;
#endif

	return sp;			/* Stream used to speak to child process */
}

rt_private int comfort_child(STREAM *sp)
           		/* Stream used to talk to the child */
{
	/* Tell the child his parent is here, and make sure he responds. The
	 * comforting protocol is the following: parent writes a null byte and
	 * child echoes ^A.
	 */

#ifdef EIF_WINDOWS
	/* See identfy.c for the flip side of this */
	DWORD wait, count;
#else
	struct timeval tm;
	fd_set mask;
#endif
	char c = '\0';

#ifndef EIF_WINDOWS
	Signal_t (*oldpipe)(int);

	FD_ZERO(&mask);
	FD_SET(writefd(sp), &mask);				/* We want to write to child */

	oldpipe = signal(SIGPIPE, (void (*)(int))broken); /* Trap SIGPIPE within this function */

	/* If we get a SIGPIPE signal, come back here */
	if (0 != setjmp(env)) {
		signal(SIGPIPE, oldpipe);
#ifdef USE_ADD_LOG
		add_log(1, "child did not start at all");
#endif
		return -1;
	}

	tm.tv_sec = TIMEOUT;				/* Do not hang on the select */
	tm.tv_usec = 0;
	if (-1 == select(writefd(sp) + 1, (Select_fd_set_t) 0, &mask, (Select_fd_set_t) 0, &tm)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR select: %m (%e)");
#endif
		return -1;
	}

	/* If cannot write to child, there is a problem... */
	if (!FD_ISSET(writefd(sp), &mask)) {
#ifdef USE_ADD_LOG
		add_log(12, "cannot comfort child");
#endif
		signal(SIGPIPE, oldpipe);
		return -1;
	}
#endif /* not EIF_WINDOWS */

#ifdef EIF_WINDOWS
	if (! WriteFile (writefd(sp), &c, 1, &count, NULL)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR write: %m (%e)");
		add_log(12, "%d cannot send identification", GetLastError());
#endif
		return -1;
	}
	ReleaseSemaphore (writeev(sp),1,NULL);
#else /* NOT EIF_WINDOWS */
	if (-1 == write(writefd(sp), &c, 1)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR write: %m (%e)");
		add_log(12, "cannot send identification");
#endif
		signal(SIGPIPE, oldpipe);
		return -1;
	}
	signal(SIGPIPE, oldpipe);			/* Restore previous handler */
#endif /* NOT EIF_WINDOWS */

	/* Now wait for the acknowledgment -- no SIGPIPE to be feared */

#ifdef EIF_WINDOWS
#ifdef USE_ADD_LOG
	add_log(12, "Waiting %d", readev(sp));
#endif

	wait = WaitForSingleObject (readev(sp), TIMEOUT * 1000);	/* Child should answer quickly */
	if (wait == WAIT_FAILED) {
#else /* NOT EIF_WINDOWS */
	FD_ZERO(&mask);
	FD_SET(readfd(sp), &mask);			/* We want to read from child */
	tm.tv_sec = TIMEOUT;				/* Child should answer quickly */
	tm.tv_usec = 0;
	if (-1 == select(readfd(sp) + 1, &mask, (Select_fd_set_t) 0, (Select_fd_set_t) 0, &tm)) {
#endif /* NOT EIF_WINDOWS */
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR select: %m (%e)");
#endif
		return -1;
	}

#ifdef EIF_WINDOWS
	if (wait != WAIT_OBJECT_0) {
#else
 	if (!FD_ISSET(readfd(sp), &mask)) {
#endif
#ifdef USE_ADD_LOG
		add_log(12, "child does not answer");
#endif
		return -1;
	}

#ifdef EIF_WINDOWS
	if (!ReadFile (readfd(sp), &c, 1, &count, NULL)) {
#else
	if (-1 == read(readfd(sp), &c, 1)) {
#endif
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR read: %m (%e)");
		add_log(12, "cannot get child answer");
#endif
		return -1;
	}

	if (c != '\01') {
#ifdef USE_ADD_LOG
		add_log(12, "wrong child, it would seem");
#endif
		return -1;
	}

#ifdef USE_ADD_LOG
	add_log(12, "child started ok");
#endif

	return 0;
}

#ifndef EIF_WINDOWS
rt_private void close_on_exec(int fd)
{
	/* Set the close on exec flag for file descriptor 'fd' */

#ifdef F_SETFD
	if (-1 == (fcntl(fd, F_SETFD, 1))) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR fcntl: %m (%e)");
		add_log(2, "ERROR cannot set close-on-exec flag on fd #%d", fd);
#endif
	}
#ifdef USE_ADD_LOG
	else
		add_log(12, "file #%d will be closed upon next exec()", fd);
#endif
#endif
}

rt_private Signal_t broken(void)
{
#ifdef USE_ADD_LOG
	add_log(20, "SIGPIPE signal handler broken() called in child.c");
#endif
	longjmp(env, 1);			/* SIGPIPE was received */
	/* NOTREACHED */
}
#else /* ifdef EIF_WINDOWS */

/*
LRESULT CALLBACK WndProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	return DefWindowProc (hwnd, message, wParam, lParam);
}

void create_dummy_window (void)
{
	static int registered = 0;
	static int successful = 0;
	HWND dummy_window = NULL;
	extern HANDLE hInst;

	if (!registered) {
		WNDCLASSEX WinClass;

		registered = 1;

		WinClass.cbSize=sizeof(WNDCLASSEX);
		WinClass.hInstance=hInst;
		WinClass.lpszClassName="EiffelStudio Server";
		WinClass.lpfnWndProc=WndProc;
		WinClass.style=CS_HREDRAW | CS_VREDRAW;
		WinClass.hIcon=LoadIcon(NULL, IDI_APPLICATION);
		WinClass.hIconSm=0;
		WinClass.hCursor=LoadCursor(NULL, IDC_ARROW);
		WinClass.lpszMenuName=NULL;
		WinClass.cbClsExtra=0;
		WinClass.cbWndExtra=0;
		WinClass.hbrBackground=(HBRUSH)GetStockObject(WHITE_BRUSH);

		successful = (int) RegisterClassEx(&WinClass);
	}

	if (successful) { 
		dummy_window = CreateWindow("EiffelStudio Server",
								"EiffelStudio Server",
								WS_OVERLAPPEDWINDOW,
								0,
								0,
								0,
								0,
								HWND_DESKTOP,
								NULL,
								hInst,
								NULL);
		if (dummy_window) {
			SetWindowPos (dummy_window, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE);
			DestroyWindow (dummy_window);
			dummy_window = NULL;
		}
	}
}
*/

#endif /* EIF_WINDOWS */



#ifdef EIF_WINDOWS
rt_public int ewb_active_check(STREAM *sp, HANDLE pid)
#else
rt_public int ewb_active_check(STREAM *sp, int pid)
#endif
	/* Communication channel */
	/* Child's pid */
{
	/* Make sure 'pid' is still alive. If the pid checking facility is enabled
	 * in the kernel, we use that. Otherwise, we send a KPALIVE request,
	 * which will be discarded by the child. The idea being that if the child
	 * is dead, then we'll get a SIGPIPE signal (which is trapped by the
	 * sending routine).
	 */
#ifndef EIF_WINDOWS
#ifndef PIDCHECK
	Request rqst;
#endif
#endif

	if (pid == 0) {				/* No application recorded */
		return 0;				/* Nothing to check */
	}

#ifdef EIF_WINDOWS
	if (WaitForSingleObject (pid, 0) == WAIT_OBJECT_0) {
  		return 1;
	}
#elif defined EIF_VMS
	/* VMS does has PIDCHECK, but only on V7.0 or later, and	*/
	/* only when the _POSIX_EXIT feature test macro is set.		*/
	{
	    VMS_STS st; int schstate;
	    /* just check to see if process is still alive. Use a datum kept in PCB */
	    /* (in nonpaged pool) for minimum overhead */
	    st = lib$getjpi(&JPI$_STATE, &pid, 0, &schstate, 0,0);
	    if (st == SS$_SUSPENDED) st = 1;
	    if (!VMS_SUCCESS (st)) {
#ifdef USE_ADD_LOG
		if (st != SS$_NONEXPR) {
		    vaxc$errno = st;
		    add_log(2,"Trouble getting info for process (%d): %d (%s)",
			pid, st, strerror(EVMSERR, st));
		}
#endif /* USE_ADD_LOG */
		    (void) rem_input(sp);	/* Remove its input */
		    return 1;
	    }
	}

#else /* not EIF_VMS */
#ifdef PIDCHECK
	if (-1 == kill(pid, 0)) {			/* If kill fails, the pid is gone */
		(void) rem_input(sp);	/* Remove its input */
		return 1;
	}
#else
	rqst.rq_type = KPALIVE;
	ewb_send_packet(sp, &rqst);	/* Send dummy request */
	if (!has_input(sp))			/* Failure, could not send request */
		return 1;						/* Child is dead */
	}
#endif /* PIDCHECK */
#endif /* (platform) */
	return 0;		/* Ok, child still alive */
}

