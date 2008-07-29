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
#include "child.h"

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
#endif

/* #define USE_ADD_LOG */

#define PIPE_READ	0		/* File descriptor used for reading */
#define PIPE_WRITE	1		/* File descriptor used for writing */


rt_public unsigned int TIMEOUT;		/* Time out for interprocess communications */

extern void dexit (int);
#define SPAWN_CHILD_FAILED(i) dexit(i);

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
#else
rt_private void create_dummy_window (void);
#endif

#ifndef EIF_WINDOWS

rt_private char** envstr_to_envp (char* aenvir)
{
	char** res;
	int i, n, len;
	char* p;
	n = 0;
	for (p = aenvir; *p; p++) {
		while (*p) { 
			p++; 
		}
		n = n + 1;
	}
	res = (char**) malloc ((1+n) * sizeof(char*));
	p = aenvir;
	for (i = 0; i < n; i++) {
		res[i] = (char*) p;
		len = strlen (res[i]);
		p = p + len + 1;
	}
	res[n] = (char*) 0;
	return res;

}
#endif

rt_private char* safe_unquoted_path (char* a_path) 
{
	char* res = NULL;
	int n = (int) strlen(a_path);
	if (a_path[0] == '"' && a_path[n - 1] == '"') {
		res = (char*) malloc (n - 1);
		strncpy (res, a_path + 1, n - 2);
		res[n - 2] = '\0';
	} else if (a_path[0] == '"') {
		res = (char*)malloc (n - 0);
		strncpy (res, a_path + 1, n - 1);
		res[n - 1] = '\0';
	} else if (a_path[n - 1] == '"') {
		res = (char*)malloc (n - 0);
		strncpy (res, a_path, n - 1);
		res[n - 1] = '\0';
	} else {
		res = (char*)malloc (n + 1);
		strcpy (res, a_path);
		res[n] = '\0';
	}
	return res;
}

rt_private char* safe_quoted_path (char* a_path) 
{
	char* res = NULL;
	int n = (int) strlen(a_path);
	if (a_path[0] == '"' && a_path[n - 1] == '"') {
		res = (char*) malloc (n + 1);
		strcpy (res, a_path);
		res[n] = '\0';
	} else if (a_path[0] == '"') {
		res = (char*) malloc (n + 3);
		strcpy (res, a_path);
		strcat (res, "\"");
		res[n + 2] = '\0';
	} else if (a_path[n - 1] == '"') {
		res = (char*) malloc (n + 3);
		strcpy (res, "\"");
		strcat (res, a_path);
		res[n + 2] = '\0';
	} else {
		res = (char*) malloc (n + 4);
		strcpy (res, "\"");
		strcat (res, a_path);
		strcat (res, "\"");
		res[n + 3] = '\0';
	}
	return res;
}

rt_private void set_meltpath_environment (char* exe_path) 
{
		char *meltpath, *appname;
		static char *envstring = NULL;	/* set MELT_PATH */
#ifdef EIF_VMS
		size_t dirname_size;
#endif

		meltpath = safe_unquoted_path (exe_path);

		if (meltpath == (char *)0){
			SPAWN_CHILD_FAILED(1);
		}

#if defined(EIF_VMS_V6_ONLY)
		appname = strrchr (meltpath, ']');
		if (appname) {
			*(++appname) = 0;
		} else {
			strcpy (meltpath, "[]");
		}
#elif defined(EIF_VMS)
		dirname_size = eifrt_vms_dirname_len (meltpath);
		if (dirname_size)  {
			meltpath[--dirname_size] = '\0';
		} else {
			strcpy (meltpath, "[]");
		}
#elif defined(EIF_WINDOWS)
		appname = strrchr (meltpath, '\\');
		if (appname) {
			*appname = 0;
		} else {
			strcpy (meltpath, ".");
		}
#else
		appname = strrchr (meltpath, '/');
		if (appname) {
			*appname = 0;
		} else {
			strcpy (meltpath, ".");
		}
#endif /* platform */

		if (!envstring) {
			envstring = (char *) malloc (strlen (meltpath) + strlen ("MELT_PATH=") + 1);
		} else {
			envstring = (char *) realloc (envstring, strlen (meltpath) + strlen("MELT_PATH=") + 1);
		}
		if (!envstring){
			SPAWN_CHILD_FAILED(1);
		}
		sprintf (envstring, "MELT_PATH=%s", meltpath);
		putenv (envstring);
	
//			/* Set working directory to where project is located. We look
//			 * 17 characters before the end of `meltpath' to ensure there
//			 * is only one occurrence of EIFGENs in `meltpath'. */
//		/* FIXME JOCELYN new EIFGENs/target/W_code... 17 ??? */
//		CHECK("Valid melted path", strlen (meltpath) >= 17);
//					
//		appname = strstr (meltpath + strlen (meltpath) - 17, "EIFGENs");
//		if (appname) {
//			*(appname - 1) = (char) 0;
//		}
		free (meltpath);
}

#ifdef EIF_WINDOWS
rt_public STREAM *spawn_child(char* id, int is_new_console_requested, char *a_exe_path, char* exe_args, char *cwd, char *envir, int handle_meltpath, HANDLE *child_process_handle, DWORD *child_process_id)
#else
rt_public STREAM *spawn_child(char* id, char *a_exe_path, char* exe_args, char *cwd, char *envir, int handle_meltpath, Pid_t *child_pid)
#endif
          			/* The child command process */
                 	/* Where pid of the child is written */
					/* Where ProcessId is written (can be NULL if you don't need it) */
{
	/* Launch the child process 'exe_path' and return the stream structure which can
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
	DWORD l_startup_flags;

	HANDLE uu_str [2];		/* Field to UUEncode  */
	char *t_uu;				/* Result of UUEncode */
	int uu_buffer_size;		/* Size of buffer needed for UUEncoding. */

	char *startpath = NULL;	/* Paths for directory to start in */
	char error_msg[128] = "";								/* Error message displayed when we cannot lauch the program */
#else
	int pp2c[2];				/* The opened downwards file descriptors : parent to child */
	int pc2p[2];				/* The opened upwards file descriptors : child to parent */
	int new;					/* Duped file descriptor */
	Pid_t pid;					/* Pid of the child */
	char **argv;				/* Argument vector */
	char** envp=NULL;
#endif
	STREAM *sp;							/* Stream used for communications with ewb */
	char* quoted_exe_path;
	char* exe_path, *cmdline;;

	exe_path = safe_unquoted_path (a_exe_path);
	quoted_exe_path = safe_quoted_path (exe_path);

#ifdef EIF_WINDOWS
		/* We encode 2 pointers, plus '"?' and '?"' plus a space and a null terminating character. */
	uu_buffer_size = uuencode_buffer_size(2) + 6; /* 6 = "? + space + ?" + \0 */
	if ((exe_args != NULL) && strlen(exe_args) > 0) {
		cmdline = malloc (strlen (quoted_exe_path) + 1 + strlen (exe_args) + uu_buffer_size);
		strcpy (cmdline, quoted_exe_path);
		strcat (cmdline, " ");
		strcat (cmdline, exe_args);
	} else {
		cmdline = malloc (strlen (quoted_exe_path) + uu_buffer_size);
		strcpy (cmdline, quoted_exe_path);
	}

#else
	if ((exe_args != NULL) && strlen(exe_args) > 0) {
		cmdline = malloc (strlen (quoted_exe_path) + 1 + strlen (exe_args) + 1);
		strcpy (cmdline, quoted_exe_path);
		strcat (cmdline, " ");
		strcat (cmdline, exe_args);
	} else {
		cmdline = malloc (strlen (quoted_exe_path) + 1);
		strcpy (cmdline, quoted_exe_path);
	}
	argv = ipc_shword(cmdline);					/* Split command into words */

	CHECK("Valid argv[0] = exe_path", strncmp (quoted_exe_path, argv[0], strlen(quoted_exe_path)) == 0);
#endif

		/* Set MELT_PATH */
	if (handle_meltpath) {
		set_meltpath_environment (exe_path);
	}

	/* Set up pipes and fork, then exec the workbench. Two pairs of pipes are
	 * opened, one for downwards communications (ised -> ewb) and one for
	 * upwards (ewb -> ised).
	 */

#ifdef EIF_WINDOWS
	/* Standard pipe operatons for Windows
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
		SPAWN_CHILD_FAILED(1);
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
		SPAWN_CHILD_FAILED(1);
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

		/* Working directory */
	if (cwd) {
		chdir (cwd);
		free (startpath);
		startpath = getcwd (NULL, PATH_MAX);
	} else if (!handle_meltpath) {
		startpath = malloc (strlen (exe_path) + 1);
		strcpy (startpath, exe_path);
		*(strrchr (startpath, '\\')) = '\0';
	}

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
		add_log(20, "Command line: %s %s", exe_path, cmdline);
#endif

	/* Set up members of STARTUPINFO structure. */

	siStartInfo.cb = sizeof(STARTUPINFO);
	siStartInfo.lpTitle = NULL;
	siStartInfo.lpReserved = NULL;
	siStartInfo.lpReserved2 = NULL;
	siStartInfo.cbReserved2 = 0;
	siStartInfo.lpDesktop = NULL;
	siStartInfo.dwFlags = STARTF_FORCEONFEEDBACK;

		/* FIXME or HACK: To enable the launched application to be in foreground */
	create_dummy_window();

		/* If we are launching the graphical version of the Eiffel compiler,
		 * we use DETACHED_PROCESS since we do not want its DOS console
		 * to appear. */
	if (is_new_console_requested == 1) {
		l_startup_flags = DETACHED_PROCESS;
	} else {
		l_startup_flags = CREATE_NEW_CONSOLE;
	}
	/* if ever we pass Unicode envir: l_startup_flags = l_startup_flags | CREATE_UNICODE_ENVIRONMENT; */
	fSuccess = CreateProcess (
			exe_path,			/* Command 	*/
			cmdline,			/* Command line */
			NULL,				/* Process security attribute */
			NULL,				/* Primary thread security attributes */
			TRUE,				/* Handles are inherited */
			l_startup_flags,	/* Creation flags */
			envir,				/* Use parent's environment */
			startpath,			/* Use cmd's current directory */
			&siStartInfo,		/* STARTUPINFO pointer */
			&piProcInfo			/* for PROCESS_INFORMATION */
		);

	if (!fSuccess) {
#ifdef USE_ADD_LOG
		add_log(20, "ERROR cannot create process %d", GetLastError());
		add_log(20, "Error code %d", GetLastError());
#endif
		strcat (error_msg, "Cannot Launch the program [");
		strcat (error_msg, exe_path);
		strcat (error_msg, "]\nMake sure you have correctly set up your installation.");
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
		/*   DBGOUT == pc2p[WRITE], DBGIN == pp2c[READ]		    */
/*DEBUG*/	ipcvms_fd_dump ("before adjust pipes for child: pc2p[%d,%d], pp2c[%d,%d]", pc2p[0],pc2p[1],pp2c[0],pp2c[1]);
		if (DBGOUT == pp2c[PIPE_WRITE] || DBGOUT == pc2p[PIPE_READ] 
			|| DBGIN == pp2c[PIPE_WRITE] || DBGIN == pc2p[PIPE_READ]) {
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
		close(pp2c[PIPE_WRITE]);
		close(pc2p[PIPE_READ]);
		close(pp2c[PIPE_WRITE]);
		close(pc2p[PIPE_READ]);
#endif /* EIF_VMS */

		/* Start duping first allocated pipe, otherwise good luck!--RAM.
		 * Be careful about the case where the pipe you want to dup on is
		 * already used by the other pipe.
		 * (Hint #1: dup2 closes its target fd before duping file)
		 * (Hint #2: pipe() takes the lowest two file descriptors available)
		 */
		if (pp2c[PIPE_READ] != DBGOUT) {
			if (pc2p[PIPE_WRITE] != DBGOUT) {
				dup2(pc2p[PIPE_WRITE], DBGOUT);	/* Child writes to ewbout */
				close(pc2p[PIPE_WRITE]);			/* Close dup'ed files before exec */
			}
			if (pp2c[PIPE_READ] != DBGIN) {
				dup2(pp2c[PIPE_READ], DBGIN);	/* Child reads from ewbin */
				close(pp2c[PIPE_READ]);			/* (avoid child running out of fd!) */
			}
		} else {
			/* Bad case: pp2c[PIPE_READ] == DBGOUT. We cannot use the code above since
			 * the first dup2 will close DBGOUT, which unfortunately is used by a pipe
			 * end which also need to be kept alive until dup2'ed! Ouch--RAM
			 */
			if (pp2c[PIPE_READ] != DBGIN) {
				dup2(pp2c[PIPE_READ], DBGIN);	/* Child reads from ewbin */
				close(pp2c[PIPE_READ]);			/* (avoid child running out of fd!) */
			}
			if (pc2p[PIPE_WRITE] != DBGOUT) {
				dup2(pc2p[PIPE_WRITE], DBGOUT);	/* Child writes to ewbout */
				close(pc2p[PIPE_WRITE]);			/* Close dup'ed files before exec */
			}
		}
		/* Now exec command. A successful launch should not return */
		if (argv != (char **) 0) {

				/* Working directory */
			if (cwd) {
				chdir (cwd);
			}
			if (envir == NULL) {
				envp = NULL;
			} else {
				envp = (char**) envstr_to_envp (envir);
			}

#ifdef EIF_VMS
/*DEBUG*/		ipcvms_fd_dump ("before execv (spawn child): pc2p[%d,%d], pp2c[%d,%d]", pc2p[0],pc2p[1],pp2c[0],pp2c[1]);

			if (envp == NULL) {
				execv(exe_path, argv);
			} else {
				execve(exe_path, argv, envp);
			}
#else
			
			
			if (envp == NULL) {
				execvp(exe_path, argv);
			} else {
				execve(exe_path, argv, envp);
			}
#endif

			print_err_msg(stderr,"ERROR could not launch '%s'", exe_path);
			if (envp != NULL) {
				free(envp);
				envp = NULL;
			}

#ifdef USE_ADD_LOG
			reopen_log();
			add_log(1, "SYSERR: exec: %m (%e)");
			add_log(2, "ERROR could not launch '%s'", exe_path);
#endif
		}
#ifdef USE_ADD_LOG
		else {
			add_log(2, "ERROR out of memory: cannot exec '%s'", cmd);
		}
#endif
		SPAWN_CHILD_FAILED(1);

	default:		/* Parent process */
		sleep(1);	/* Let child initialize or print error */
#ifndef EIF_VMS
		/* on VMS this was done in the case 0: code above when	*/
		/* when the child's pipes were dup2'ed to DBGOUT/DBGIN	*/
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
		} else if (new != -1)
			close(new);
		/* Same thing with writing file descriptor. Note that we only keep the
		 * new duped descriptor when it is lower than the current original.
		 */
		new = dup(pp2c[PIPE_WRITE]);
		if (new != -1 && new < pp2c[PIPE_WRITE]) {
			close(pp2c[PIPE_WRITE]);
			pp2c[PIPE_WRITE] = new;
		} else if (new != -1)
			close(new);
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
	close (DBGOUT);
	close (DBGIN);
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
		if (child_process_id!=NULL)
			*child_process_id = piProcInfo.dwProcessId;
	}

	free (cmdline);
	free (exe_path);
	free (quoted_exe_path);
	free (startpath);
#else
	if (child_pid != (Pid_t *) 0)
		*child_pid = pid;
	if (envp != NULL) {
		free(envp);
	}
	free (cmdline);
	free (exe_path);
	free (quoted_exe_path);
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

#endif /* EIF_WINDOWS */
