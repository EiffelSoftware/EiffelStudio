/*

  ####   #    #     #    #       #####            ####
 #    #  #    #     #    #       #    #          #    #
 #       ######     #    #       #    #          #
 #       #    #     #    #       #    #   ###    #
 #    #  #    #     #    #       #    #   ###    #    #
  ####   #    #     #    ######  #####    ###     ####

	Child spawning and comforting.
*/

#include "eif_config.h"
#ifdef __VMS	/* must come before eif_portable here */
#include "ipcvms.h"
#endif
#include "eif_portable.h"

#include "eif_err_msg.h"

#include <sys/types.h>
#include "eif_logfile.h"
#include "stream.h"
#include "timehdr.h"
#include "ewbio.h"
#include "child.h"

#ifdef EIF_WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include "uu.h"
#endif

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

/* #define USE_ADD_LOG */

#define PIPE_READ	0		/* File descriptor used for reading */
#define PIPE_WRITE	1		/* File descriptor used for writing */

extern unsigned TIMEOUT;	/* Time to let the child initialize */
extern void dexit (int);

/* To fight SIGPIPE signals */
rt_private jmp_buf env;		/* Environment saving for longjmp() */
#ifndef EIF_WIN32
rt_private Signal_t broken(void);	/* Signal handler for SIGPIPE */
#endif

/* Function declaration */
rt_private int comfort_child(STREAM *sp);	/* Reassure child, make him confident */
extern char **shword(char *cmd);			/* Shell word parsing of command string */
#ifndef EIF_WIN32
rt_private void close_on_exec(int fd);	/* Ensure this file will be closed by exec */
#else
rt_private void create_dummy_window (void);
#endif

#ifdef EIF_WIN32
rt_public STREAM *spawn_child(char *cmd, char *cwd, int handle_meltpath, HANDLE *child_process_handle, DWORD *child_process_id)
#else
rt_public STREAM *spawn_child(char *cmd, char *cwd, int handle_meltpath, Pid_t *child_pid)
#endif
          			/* The child command process */
                 	/* Where pid of the child is writtten */
					/* Where ProcessId is written (can be NULL if you don't need it) */
{
	/* Launch the child process 'cmd' and return the stream structure which can
	 * be used to communicate with the child. Note that this function only
	 * returns in the parent process.
	 */

#ifdef EIF_WIN32
	HANDLE pdn[2];						/* The opened downwards file descriptors */
	HANDLE pup[2];						/* The opened upwards file descriptors */
	HANDLE child_event_r;				/* Event for signalling readability */
	HANDLE child_event_w;				/* Event for signalling writeability */
	HANDLE pipe_to_dup;
	CHAR   event_str[20];				/* Event name */
	STREAM *sp;							/* Stream used for communications with ewb */

	BOOL	fSuccess;					/* Did CreateProcess succeed? */
	PROCESS_INFORMATION	piProcInfo;
	STARTUPINFO		siStartInfo;
	SECURITY_ATTRIBUTES	saAttr;

	HANDLE uu_str [2];		/* Field to UUEncode  */
	char *t_uu;				/* Result of UUEncode */

	char *startpath, *dotplace, *cmdline, *cmd2;	/* Paths for directory to start in */
	char error_msg[128] = "";								/* Error message displayed when we cannot lauch the program */
#else
	int pdn[2];					/* The opened downwards file descriptors */
	int pup[2];					/* The opened upwards file descriptors */
	int new;					/* Duped file descriptor */
	Pid_t pid;					/* Pid of the child */
	STREAM *sp;					/* Stream used for communications with ewb */
	char **argv;				/* Argument vector for exec() */
#endif

	char *meltpath, *appname, *envstring;	/* set MELT_PATH */

	/* Set up pipes and fork, then exec the workbench. Two pairs of pipes are
	 * opened, one for downwards communications (ised -> ewb) and one for
	 * upwards (ewb -> ised).
	 */

#ifdef EIF_WIN32
	/* Standard pipe oeratons for Windows
		DuplicateHandle is called to set correct permisions.
	*/

	saAttr.nLength = sizeof (SECURITY_ATTRIBUTES);
	saAttr.bInheritHandle = TRUE;
	saAttr.lpSecurityDescriptor = NULL;

	if (!CreatePipe (&(pup[PIPE_READ]), &(pup[PIPE_WRITE]), &saAttr, 0)) {
#else
	if (-1 == pipe(pup)) {
#endif
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR: pipe: %m (%e)");
		add_log(2, "ERROR cannot set up upwards pipe");
#endif
		perror("pipe up");
		dexit(1);
	}

#ifdef EIF_WIN32
	if (!CreatePipe (&(pdn[PIPE_READ]), &(pipe_to_dup), &saAttr, 0)) {
#else
	if (-1 == pipe(pdn)) {
#endif
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR: pipe: %m (%e)");
		add_log(2, "ERROR cannot set up downwards pipe");
#endif
		perror("pipe down");
		dexit(1);
	}
#ifdef EIF_WIN32
#ifdef USE_ADD_LOG
	add_log(12, "opened pipes as pup(%d, %d), pdn(%d, %d)",
		pup[PIPE_READ], pup[PIPE_WRITE], pdn[PIPE_READ], pipe_to_dup);
#endif
#else
#ifdef USE_ADD_LOG
	add_log(12, "opened pipes as pup(%d, %d), pdn(%d, %d)",
		pup[PIPE_READ], pup[PIPE_WRITE], pdn[PIPE_READ], pdn[PIPE_WRITE]);
#endif
#endif


#ifdef EIF_WIN32
	if (!DuplicateHandle (GetCurrentProcess(), pipe_to_dup,
		GetCurrentProcess(), &(pdn[PIPE_WRITE]), 0,
		FALSE, DUPLICATE_SAME_ACCESS)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot dup pipe %d", GetLastError());
#endif
		perror("duplicate handle");
		dexit (1);
	}

	if (!CloseHandle (pipe_to_dup)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot close dupped pipe %d", GetLastError());
#endif
		perror("close handle");
		dexit (1);
	}
	pipe_to_dup = NULL;

	cmd2 = strdup(cmd);
	/* Find the name of the command and place it in cmd2 */
	/* Find the args and place them in cmdline */
	/* Set the starting  path to be the path of the executable io start_path */
	for (dotplace = strchr (cmd2, '.');
		dotplace && strnicmp (dotplace, ".exe", 4) != 0;
		dotplace = strchr (dotplace+1 , '.') )
		;
	if (!dotplace) {
		printf ("Error no .exe in executable");
		dexit(1);
	}
	*(dotplace + 4) = '\0';
	if (strchr (cmd2, ' ') != NULL) {
		cmdline = malloc (strlen (cmd) + 3 + 18);
		memset  (cmdline, 0, strlen(cmd) + 3);
		strcpy (cmdline , "\"");
		strcat (cmdline, cmd2);
		strcat (cmdline, "\" ");
		if (strlen (cmd2) != strlen (cmd))
			strcat (cmdline, dotplace + 5);
	} else {
		cmdline = malloc (strlen (cmd) + 18);
		strcpy (cmdline, cmd);
	}

		/* Working directory */
	if (cwd)
		startpath = strdup (cwd);
	else {
		startpath = strdup (cmd2);
		*(strrchr (startpath, '\\')) = '\0';
	}

		/* Set MELT_PATH */
	if (handle_meltpath) {
		meltpath = strdup (cmd2);
		if (meltpath == (char *)0){
			dexit (1);
		}

		appname = rindex (meltpath, '\\');
		if (appname)
			*appname = 0;
		else
			strcpy (meltpath, ".");

		envstring = (char *)malloc (strlen (meltpath) + strlen ("MELT_PATH=") + 1);
		if (!envstring){
			dexit (1);
		}
		sprintf (envstring, "MELT_PATH=%s", meltpath);
		putenv (envstring);
	}

	/* Encode the pipes to start the child */

	uu_str [0] = pup [PIPE_WRITE];
	uu_str [1] = pdn [PIPE_READ];
	strcat (cmdline, " \"?");
	t_uu = uuencode_str ((char *) uu_str, 2 * sizeof (HANDLE));
	strcat (cmdline, t_uu);
	free (t_uu);
	strcat (cmdline, "?\"");


#ifdef USE_ADD_LOG
		add_log(20, "Command line: %s %s", cmd2, cmdline);
#endif

	/* Set up members of STARTUPINFO structure. */

	siStartInfo.cb = sizeof(STARTUPINFO);
	siStartInfo.lpTitle = NULL;
	siStartInfo.lpReserved = NULL;
	siStartInfo.lpReserved2 = NULL;
	siStartInfo.cbReserved2 = 0;
	siStartInfo.lpDesktop = NULL;
	siStartInfo.dwFlags = STARTF_USESTDHANDLES | STARTF_FORCEONFEEDBACK;
	siStartInfo.hStdOutput = pup[PIPE_WRITE];
	siStartInfo.hStdInput =  pdn[PIPE_READ];
	siStartInfo.hStdError = GetStdHandle (STD_ERROR_HANDLE);

		/* FIXME or HACK: To enable the launched application to be in foreground */
	create_dummy_window();

	fSuccess = CreateProcess (cmd2,	/* Command 	*/
		cmdline,			/* Command line */
		NULL,				/* Process security attribute */
		NULL,				/* Primary thread security attributes */
		TRUE,				/* Handles are inherited */
		DETACHED_PROCESS ,	/* Creation flags */
		NULL,				/* Use parent's environment */
		startpath,			/* Use cmd's current directory */
		&siStartInfo,		/* STARTUPINFO pointer */
		&piProcInfo);		/* for PROCESS_INFORMATION */

	if (!fSuccess) {
#ifdef USE_ADD_LOG
		add_log(20, "ERROR cannot create process %d", GetLastError());
		add_log(20, "Error code %d", GetLastError());
#endif
		strcat (error_msg, "Cannot Launch the program \"");
		strcat (error_msg, cmd2);
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
		dexit(1);
	} else {	/* Parent process */
				/* Let child initialize or print error */
#ifdef USE_ADD_LOG
		add_log(12, "started process");
#endif
	}

#else	/* #ifdef EIF_WIN32 */

#ifdef EIF_VMS
    /* VMS has no fork(). It does have vfork, which sets up the context	*/
    /* for a subsequent exec call. vfork and exec work together like	*/
    /* setjmp and longjmp. When control returns from vfork the first	*/
    /* time, the return value (child process id) is zero, and the	*/
    /* context is set up for a subsequent vfork, but the child process	*/
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

#else	/* (not) EIF_VMS */

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
		dexit(1);

	case 0:			/* Child process */
#ifdef USE_ADD_LOG
		close_log();					/* Logfile should not cross exec() */
#endif

#ifndef EIF_VMS	/* can't do this on VMS, child not created yet (not till exec) */
		close(pdn[PIPE_WRITE]);
		close(pup[PIPE_READ]);
		close(pdn[PIPE_WRITE]);
		close(pup[PIPE_READ]);
#endif
		/* Start duping first allocated pipe, otherwise good luck!--RAM.
		 * Be careful about the case where the pipe you want to dup on is
		 * already used by the other pipe.
		 * (Hint #1: dup2 closes its target fd before duping file)
		 * (Hint #2: pipe() takes the lowest two file descriptors available)
		 */
		if (pdn[PIPE_READ] != EWBOUT) {
			if (pup[PIPE_WRITE] != EWBOUT) {
				dup2(pup[PIPE_WRITE], EWBOUT);	/* Child writes to ewbout */
				close(pup[PIPE_WRITE]);			/* Close dup'ed files before exec */
			}
			if (pdn[PIPE_READ] != EWBIN) {
				dup2(pdn[PIPE_READ], EWBIN);	/* Child reads from ewbin */
				close(pdn[PIPE_READ]);			/* (avoid child running out of fd!) */
			}
		} else {
			/* Bad case: pdn[PIPE_READ] == EWBOUT. We cannot use the code above since
			 * the first dup2 will close EWBOUT, which unfortunately is used by a pipe
			 * end which also need to be kept alive until dup2'ed! Ouch--RAM
			 */
			if (pdn[PIPE_READ] != EWBIN) {
				dup2(pdn[PIPE_READ], EWBIN);	/* Child reads from ewbin */
				close(pdn[PIPE_READ]);			/* (avoid child running out of fd!) */
			}
			if (pup[PIPE_WRITE] != EWBOUT) {
				dup2(pup[PIPE_WRITE], EWBOUT);	/* Child writes to ewbout */
				close(pup[PIPE_WRITE]);			/* Close dup'ed files before exec */
			}
		}
		/* Now exec command. A successful launch should not return */
		argv = shword(cmd);					/* Split command into words */
		if (argv != (char **) 0) {

				/* Working directory */
			if (cwd) {
				chdir (cwd);
			}

			if (handle_meltpath) {
				meltpath = (char *) (strdup (argv [0]));
				if (meltpath == (char *)0){
					dexit (1);
				}

#ifdef EIF_VMS
				appname = rindex (meltpath, ']');
				if (appname) 
					*(++appname) = 0;
				else
					strcpy (meltpath, "[]");
#else
				appname = rindex (meltpath, '/');
				if (appname)
					*appname = 0;
				else
					strcpy (meltpath, ".");
#endif /* EIF_VMS */

				envstring = (char *)malloc (strlen (meltpath) + strlen ("MELT_PATH=") + 1);
				if (!envstring){
					dexit (1);
				}
				sprintf (envstring, "MELT_PATH=%s", meltpath);
				putenv (envstring);
			}
#ifdef EIF_VMS
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
			add_log(2, "ERROR out of memory: cannot exec '%s'", cmd);
#endif
		dexit(1);
	default:		/* Parent process */
#ifndef EIF_VMS
		sleep(1);	/* Let child initialize or print error */
#endif
		close(pdn[PIPE_READ]);
		close(pup[PIPE_WRITE]);
		/* Reset those file descriptors to the lowest possible number, just to
		 * remain clean (the pipe() system call allocating two files, multiple
		 * calls to pipe() lead to a messy file allocation table)--RAM.
		 */
		new = dup(pup[PIPE_READ]);
		if (new != -1 && new < pup[PIPE_READ]) {
			close(pup[PIPE_READ]);
			pup[PIPE_READ] = new;
		} else if (new != -1)
			close(new);
		/* Same thing with writing file descriptor. Note that we only keep the
		 * new duped descriptor when it is lower than the current original.
		 */
		new = dup(pdn[PIPE_WRITE]);
		if (new != -1 && new < pdn[PIPE_WRITE]) {
			close(pdn[PIPE_WRITE]);
			pdn[PIPE_WRITE] = new;
		} else if (new != -1)
			close(new);
		/* No need to dup2() file descriptors, we do not exec() anybody yet.
		 * However, do make sure those remaining descriptors will be closed
		 * by any further exec.
		 */
		close_on_exec(pup[PIPE_READ]);
		close_on_exec(pdn[PIPE_WRITE]);
	}
#endif

	/* Create a STREAM structure, which provides the illusion of bidrectional
	 * communication through the pair of pipes. When networking is added, the
	 * interface will remain unchanged.
	 */

#ifdef EIF_WIN32
	sprintf (event_str, "eif_event_r%x", piProcInfo.dwProcessId);
	child_event_r = CreateSemaphore (NULL, 0, 32767, event_str);
	sprintf (event_str, "eif_event_w%x", piProcInfo.dwProcessId);
	child_event_w = CreateSemaphore (NULL, 0, 32767, event_str);
#ifdef USE_ADD_LOG
	add_log(12, "Opened Semaphores as %d %d",child_event_r,child_event_w);
#endif

	sp = new_stream(pup[PIPE_READ], pdn[PIPE_WRITE], child_event_r, child_event_w);

	CloseHandle (pup[PIPE_WRITE]);
	CloseHandle (pdn[PIPE_READ]);
	pup[PIPE_WRITE] = NULL;
	pdn[PIPE_READ] = NULL;
#else
	sp = new_stream(pup[PIPE_READ], pdn[PIPE_WRITE]);
#endif

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

#ifdef EIF_WIN32
	if (child_process_handle != NULL) {
		*child_process_handle = piProcInfo.hProcess;
		if (child_process_id!=NULL)
			*child_process_id = piProcInfo.dwProcessId;
	}

	free (startpath);
	free (cmdline);
	free (cmd2);
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

#ifdef EIF_WIN32
	/* See identfy.c for the flip side of this */
	DWORD wait, count;
#else
	struct timeval tm;
	fd_set mask;
#endif
	char c = '\0';

#ifndef EIF_WIN32
	Signal_t (*oldpipe)();

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
	if (-1 == select(32, (Select_fd_set_t) 0, &mask, (Select_fd_set_t) 0, &tm)) {
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
#endif

#ifdef EIF_WIN32
	if (! WriteFile (writefd(sp), &c, 1, &count, NULL)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR write: %m (%e)");
		add_log(12, "%d cannot send identification", GetLastError());
#endif
		return -1;
	}
	ReleaseSemaphore (writeev(sp),1,NULL);
#else
	if (-1 == write(writefd(sp), &c, 1)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR write: %m (%e)");
		add_log(12, "cannot send identification");
#endif
		signal(SIGPIPE, oldpipe);
		return -1;
	}
	signal(SIGPIPE, oldpipe);			/* Restore previous handler */
#endif

	/* Now wait for the acknowledgment -- no SIGPIPE to be feared */

#ifdef EIF_WIN32
#ifdef USE_ADD_LOG
	add_log(12, "Waiting %d", readev(sp));
#endif

	wait = WaitForSingleObject (readev(sp), TIMEOUT * 1000);	/* Child should answer quickly */
	if (wait == WAIT_FAILED) {
#else
	FD_ZERO(&mask);
	FD_SET(readfd(sp), &mask);			/* We want to read from child */
	tm.tv_sec = TIMEOUT;				/* Child should answer quickly */
	tm.tv_usec = 0;
	if (-1 == select(32, &mask, (Select_fd_set_t) 0, (Select_fd_set_t) 0, &tm)) {
#endif
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR select: %m (%e)");
#endif
		return -1;
	}

#ifdef EIF_WIN32
	if (wait != WAIT_OBJECT_0) {
#else
 	if (!FD_ISSET(readfd(sp), &mask)) {
#endif
#ifdef USE_ADD_LOG
		add_log(12, "child does not answer");
#endif
		return -1;
	}

#ifdef EIF_WIN32
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

#ifndef EIF_WIN32
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
	longjmp(env, 1);			/* SIGPIPE was received */
	/* NOTREACHED */
}
#else
LRESULT CALLBACK WndProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	return DefWindowProc (hwnd, message, wParam, lParam);
}

void create_dummy_window (void)
{
	static int registred = 0;
	static int successful = 0;
	HWND dummy_window = NULL;
	extern HANDLE hInst;

	if (!registred) {
		WNDCLASSEX WinClass;

		registred = 1;

		WinClass.cbSize=sizeof(WNDCLASSEX);
		WinClass.hInstance=hInst;
		WinClass.lpszClassName="EiffelBench Server";
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
		dummy_window = CreateWindow("EiffelBench Server",
								"EiffelBench Server",
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

#endif
