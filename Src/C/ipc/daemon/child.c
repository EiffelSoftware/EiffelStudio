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
#include "rt_native_string.h" /* Macro to manipulate EIF_NATIVE_CHAR * */

#include <sys/types.h>
#include "eif_logfile.h"
#include "stream.h"
#include "timehdr.h"
#include "ewbio.h"
#include "ecdbgd.h"
#include "child.h"
#include "shared.h" /* for C2P_IPC_NAMED_PIPE_PID_APP_TPL and P2C_.. */

#ifdef EIF_WINDOWS
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <aclapi.h> /* for socket IPC іnitialization */
#include "uu.h"
#else /* non EIF_WINDOWS */
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/wait.h>
#include <signal.h>
#include "limits.h"
#include <ctype.h>
#include <fcntl.h>
#define MAX_PATH PATH_MAX
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

#ifdef VXWORKS
#include <stdlib.h>
#include <envLib.h>
#include <selectLib.h>
#ifdef I_TIME
#include <time.h>
#endif
#endif

/* #define USE_ADD_LOG */

#define PIPE_READ	0		/* File descriptor used for reading */
#define PIPE_WRITE	1		/* File descriptor used for writing */

/*
 * Attach using socket declaration.
 */

#define DEBUGGEE_IP_ADDR "127.0.0.1"  /* FIXME: future enhancement, we should let the debugger provide the IP, 
									   * so later we might use something else than pipe for IPC 
									   * but for now, this is same machine only
									   */
#ifdef EIF_WINDOWS
rt_private unsigned int attach_debuggee(unsigned int port_number, HANDLE* pc2p, HANDLE* pp2c, HANDLE* p_event_r, HANDLE* p_event_w);
#else
rt_private unsigned int attach_debuggee(unsigned int port_number, int* pc2p, int* pp2c);
#endif

/*
 * Declarations
 */

rt_public unsigned int TIMEOUT;		/* Time out for interprocess communications */

#define SPAWN_CHILD_FAILED(i) daemon_exit(i);

#ifndef EIF_WINDOWS
/* To fight SIGPIPE signals */
rt_private jmp_buf env;		/* Environment saving for longjmp() */
rt_private Signal_t broken(int sig);	/* Signal handler for SIGPIPE */
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
	char** res = NULL;
	if (aenvir) {
		size_t i, n, len;
		char* p;
		n = 0;
			/* Calculate the number of environment variables. */
		for (p = aenvir; *p; p++) {
			while (*p) { 
				p++; 
			}
			n = n + 1;
		}
		res = (char**) malloc ((1+n) * sizeof(char*));
		if (res) {
			for (p = aenvir, i = 0; i < n; i++) {
				res[i] = p;
				len = strlen (p);
				p = p + len + 1;
			}
			res[n] = (char*) 0;
		}
	}
	return res;
}
#endif

rt_private EIF_NATIVE_CHAR* safe_unquoted_path (EIF_NATIVE_CHAR* a_path) 
{
	EIF_NATIVE_CHAR* res = NULL;
	if (a_path) {
		size_t n = rt_nstrlen(a_path);
		if (a_path[0] == '"' && a_path[n - 1] == '"') {
			res = (EIF_NATIVE_CHAR*) malloc ((n - 1) * sizeof (EIF_NATIVE_CHAR));
			if (res) {
				rt_nstrncpy (res, a_path + 1, n - 2);
				res[n - 2] = '\0';
			}
		} else if (a_path[0] == '"') {
			res = (EIF_NATIVE_CHAR*) malloc ((n - 0) * sizeof (EIF_NATIVE_CHAR));
			if (res) {
				rt_nstrncpy (res, a_path + 1, n - 1);
				res[n - 1] = '\0';
			}
		} else if (a_path[n - 1] == '"') {
			res = (EIF_NATIVE_CHAR*) malloc ((n - 0) * sizeof (EIF_NATIVE_CHAR));
			if (res) {
				rt_nstrncpy (res, a_path, n - 1);
				res[n - 1] = '\0';
			}
		} else {
			res = (EIF_NATIVE_CHAR*) malloc ((n + 1) * sizeof (EIF_NATIVE_CHAR));
			if (res) {
				rt_nstrncpy (res, a_path, n);
				res[n] = '\0';
			}
		}
	}
	return res;
}

rt_private EIF_NATIVE_CHAR* safe_quoted_path (EIF_NATIVE_CHAR* a_path) 
{
	EIF_NATIVE_CHAR* res = NULL;
	if (a_path) {
		size_t n = rt_nstrlen(a_path);
		if (a_path[0] == '"' && a_path[n - 1] == '"') {
			res = (EIF_NATIVE_CHAR*) malloc ((n + 1) * sizeof (EIF_NATIVE_CHAR));
			if (res) {
				rt_nstrcpy (res, a_path);
				res[n] = '\0';
			}
		} else if (a_path[0] == '"') {
			res = (EIF_NATIVE_CHAR*) malloc ((n + 3) * sizeof (EIF_NATIVE_CHAR));
			if (res) {
				rt_nstrcpy (res, a_path);
				rt_nstrcat (res, rt_nmakestr("\""));
				res[n + 2] = '\0';
			}
		} else if (a_path[n - 1] == '"') {
			res = (EIF_NATIVE_CHAR*) malloc ((n + 3) * sizeof (EIF_NATIVE_CHAR));
			if (res) {
				rt_nstrcpy (res, rt_nmakestr("\""));
				rt_nstrcat (res, a_path);
				res[n + 2] = '\0';
			}
		} else {
			res = (EIF_NATIVE_CHAR*) malloc ((n + 4) * sizeof (EIF_NATIVE_CHAR));
			if (res) {
				rt_nstrcpy (res, rt_nmakestr("\""));
				rt_nstrcat (res, a_path);
				rt_nstrcat (res, rt_nmakestr("\""));
				res[n + 3] = '\0';
			}
		}
	}
	return res;
}

rt_private void set_meltpath_environment (EIF_NATIVE_CHAR* exe_path) 
{
	EIF_NATIVE_CHAR *meltpath, *appname;
	static EIF_NATIVE_CHAR *envstring = NULL;	/* set MELT_PATH */
#ifdef EIF_VMS
	size_t dirname_size;
#endif

	meltpath = safe_unquoted_path (exe_path);

	if (!meltpath){
		SPAWN_CHILD_FAILED(1);
	} else {

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
		appname = wcsrchr (meltpath, (wchar_t) '\\');
		if (appname) {
			*appname = 0;
		} else {
			wcscpy (meltpath, L".");
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
			envstring = (EIF_NATIVE_CHAR *) malloc ((rt_nstrlen (meltpath) + rt_nstrlen (rt_nmakestr("MELT_PATH=")) + 1) * sizeof (EIF_NATIVE_CHAR));
		} else {
			envstring = (EIF_NATIVE_CHAR *) realloc (envstring, (rt_nstrlen (meltpath) + rt_nstrlen(rt_nmakestr("MELT_PATH=")) + 1) * sizeof (EIF_NATIVE_CHAR));
		}
		if (!envstring){
			SPAWN_CHILD_FAILED(1);
		} else {
#ifdef EIF_WINDOWS			
			swprintf (envstring, rt_nstrlen (meltpath) + rt_nstrlen (rt_nmakestr("MELT_PATH=")) + 1, rt_nmakestr("MELT_PATH=%s"), meltpath);
			_wputenv (envstring);
#else
			sprintf (envstring, "MELT_PATH=%s", meltpath);
			putenv (envstring);
#endif
		}
	
			/* Set working directory to where project is located. We look
			 * 17 characters before the end of `meltpath' to ensure there
			 * is only one occurrence of EIFGENs in `meltpath'. */
/* FIXME JOCELYN new EIFGENs/target/W_code... 17 ???
		CHECK("Valid melted path", strlen (meltpath) >= 17);
				
		appname = rt_nstrstr (meltpath + rt_nstrlen (meltpath) - 17, rt_nmakestr("EIFGENs"));
		if (appname) {
			*(appname - 1) = (EIF_NATIVE_CHAR) 0;
		}
*/
		free (meltpath);
	}
}

#ifdef EIF_WINDOWS
rt_public STREAM *spawn_child(char* id, EIF_NATIVE_CHAR *a_exe_path, EIF_NATIVE_CHAR* exe_args, EIF_NATIVE_CHAR *cwd, EIF_NATIVE_CHAR *envir, int handle_meltpath,
		DWORD *child_process_id, HANDLE *child_process_handle, int is_new_console_requested)
#else
rt_public STREAM *spawn_child(char* id, EIF_NATIVE_CHAR *a_exe_path, EIF_NATIVE_CHAR* exe_args, EIF_NATIVE_CHAR *cwd, EIF_NATIVE_CHAR *envir, int handle_meltpath,
		Pid_t *child_pid)
#endif
          			/* The child command process */
                 	/* Where pid of the child is written */
					/* Where ProcessId is written (can be NULL if you don't need it) */
					/* Note: a_exe_path, exe_args, cwd, and envir are utf-8 encoded string */
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
	STARTUPINFOW		siStartInfo;
	SECURITY_ATTRIBUTES	saAttr;
	DWORD l_startup_flags;

	HANDLE uu_str [2];		/* Field to UUEncode  */
	char *t_uu;				/* Result of UUEncode */
	int i;					/* local variable for loop index */
	size_t t_uu_len, cmdline_len;				/* local vars to store length of processed string */
	int uu_buffer_size;		/* Size of buffer needed for UUEncoding. */

	wchar_t *startpath = NULL;	/* Paths for directory to start in */
	wchar_t *error_msg = NULL;	/* Error message displayed when we cannot launch the program */
#else
	int pp2c[2];				/* The opened downwards file descriptors : parent to child */
	int pc2p[2];				/* The opened upwards file descriptors : child to parent */
	int new;					/* Duped file descriptor */
	Pid_t pid;					/* Pid of the child */
	char **argv;				/* Argument vector */
	char **envp=NULL;
#endif
	STREAM *sp;							/* Stream used for communications with ewb */
	EIF_NATIVE_CHAR* quoted_exe_path;
	EIF_NATIVE_CHAR* exe_path, *cmdline;

	exe_path = safe_unquoted_path (a_exe_path);
	if (!exe_path) {
		SPAWN_CHILD_FAILED(1);
	}
	quoted_exe_path = safe_quoted_path (exe_path);
	if (!quoted_exe_path) {
		SPAWN_CHILD_FAILED(1);
	}

#ifdef EIF_WINDOWS
		/* We encode 2 pointers, plus '"?' and '?"' plus a space and a null terminating character. */
	uu_buffer_size = uuencode_buffer_size(2) + 6; /* 6 = "? + space + ?" + \0 */
	if ((exe_args != NULL) && wcslen(exe_args) > 0) {
		cmdline = (EIF_NATIVE_CHAR *) malloc ((wcslen (quoted_exe_path) + 1 + wcslen (exe_args) + uu_buffer_size) * sizeof (EIF_NATIVE_CHAR));
		if (!cmdline) {
			SPAWN_CHILD_FAILED(1);
		} else {
			wcscpy (cmdline, quoted_exe_path);
			wcscat (cmdline, L" ");
			wcscat (cmdline, exe_args);
		}
	} else {
		cmdline = (EIF_NATIVE_CHAR *) malloc ((wcslen (quoted_exe_path) + uu_buffer_size) * sizeof (EIF_NATIVE_CHAR));
		if (!cmdline) {
			SPAWN_CHILD_FAILED(1);
		} else {
			wcscpy (cmdline, quoted_exe_path);
		}
	}
#else
	if ((exe_args != NULL) && strlen(exe_args) > 0) {
		cmdline = (EIF_NATIVE_CHAR*) malloc (strlen (quoted_exe_path) + 1 + strlen (exe_args) + 1);
		if (!cmdline) {
			SPAWN_CHILD_FAILED(1);
		} else {
			strcpy (cmdline, quoted_exe_path);
			strcat (cmdline, " ");
			strcat (cmdline, exe_args);
		}
	} else {
		cmdline = (EIF_NATIVE_CHAR*) malloc (strlen (quoted_exe_path) + 1);
		if (!cmdline) {
			SPAWN_CHILD_FAILED(1);
		} else {
			strcpy (cmdline, quoted_exe_path);
		}
	}
	argv = ipc_shword(cmdline);					/* Split command into words */
	CHECK("Valid argv[0] = exe_path", argv && strncmp (quoted_exe_path, argv[0], strlen(quoted_exe_path)) == 0);
#endif

		/* Set MELT_PATH */
	if (handle_meltpath) {
		set_meltpath_environment (exe_path);
	}

	/* Set up pipes and fork, then exec the workbench. Two pairs of pipes are
	 * opened, one for downwards communications (ecdbgd -> ewb) and one for
	 * upwards (ewb -> ecdbgd).
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
	memset(pc2p, 0, 2*sizeof(int));
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
	memset(pp2c, 0, 2*sizeof(int));
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
		(void) _wchdir (cwd);
		free (startpath);
		startpath = _wgetcwd (NULL, PATH_MAX);
	} else if (!handle_meltpath) {
		startpath = (EIF_NATIVE_CHAR *) malloc ((wcslen (exe_path) + 1) * sizeof (EIF_NATIVE_CHAR));
		wcscpy (startpath, exe_path);
		*(wcsrchr (startpath, '\\')) = '\0';
	}

	/* Encode the pipes to start the child */
	/* ... ' \"?' + UUENCODED2POINTERS + '?\"' */

	uu_str [0] = pc2p [PIPE_WRITE];
	uu_str [1] = pp2c [PIPE_READ];
	wcscat (cmdline, L" \"?");
	t_uu = uuencode_str ((char *) uu_str, 2 * sizeof (HANDLE));
	t_uu_len = strlen (t_uu);
	cmdline_len = wcslen (cmdline);
	for (i = 0; i <= t_uu_len; i++) {
		cmdline[cmdline_len + i] = (EIF_NATIVE_CHAR) t_uu[i];
	}
	free (t_uu);
	wcscat (cmdline, L"?\"");


#ifdef USE_ADD_LOG
		add_log(20, "Command line: %s %s", exe_path, cmdline);
#endif

	/* Set up members of STARTUPINFOW structure. */

	siStartInfo.cb = sizeof(STARTUPINFOW);
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

	l_startup_flags = l_startup_flags | CREATE_UNICODE_ENVIRONMENT;

	fSuccess = CreateProcessW (
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
		error_msg = (EIF_NATIVE_CHAR*) malloc ((wcslen (exe_path) + wcslen (cmdline) + wcslen (startpath) + 128) * sizeof(EIF_NATIVE_CHAR));
		error_msg[0] = (wchar_t) 0;
		wcscat (error_msg, L"Cannot Launch the program \n\n");
		wcscat (error_msg, exe_path);
		wcscat (error_msg, L"\n\nMake sure you have correctly set up your installation.\n");
		wcscat (error_msg, cmdline);
		wcscat (error_msg, L"\n\n");
		wcscat (error_msg, startpath);

		MessageBoxW (NULL, error_msg,   L"Execution terminated",
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
					/* Child writes to ewbout */
				if (-1 == dup2(pc2p[PIPE_WRITE], DBGOUT)) {
					SPAWN_CHILD_FAILED(1);
				} else {
					close(pc2p[PIPE_WRITE]);			/* Close dup'ed files before exec */
				}
			}
			if (pp2c[PIPE_READ] != DBGIN) {
					/* Child reads from ewbin */
				if (-1 == dup2(pp2c[PIPE_READ], DBGIN)) {
					SPAWN_CHILD_FAILED(1);
				} else {
					close(pp2c[PIPE_READ]);			/* (avoid child running out of fd!) */
				}
			}
		} else {
			/* Bad case: pp2c[PIPE_READ] == DBGOUT. We cannot use the code above since
			 * the first dup2 will close DBGOUT, which unfortunately is used by a pipe
			 * end which also need to be kept alive until dup2'ed! Ouch--RAM
			 */
			if (pp2c[PIPE_READ] != DBGIN) {
					/* Child reads from ewbin */
				if (-1 == dup2(pp2c[PIPE_READ], DBGIN)) {
					SPAWN_CHILD_FAILED(1);
				} else {
					close(pp2c[PIPE_READ]);			/* (avoid child running out of fd!) */
				}
			}
			if (pc2p[PIPE_WRITE] != DBGOUT) {
					/* Child writes to ewbout */
				if (-1 == dup2(pc2p[PIPE_WRITE], DBGOUT)) {
					SPAWN_CHILD_FAILED(1);
				} else {
					close(pc2p[PIPE_WRITE]);			/* Close dup'ed files before exec */
				}
			}
		}
		/* Now exec command. A successful launch should not return */
		if (argv != (char **) 0) {

				/* Working directory */
			if (cwd) {
				(void) chdir (cwd);
			}
			envp = envstr_to_envp (envir);

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
			add_log(2, "ERROR out of memory: cannot exec '%s'", exe_path);
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

	/* Create a STREAM structure, which provides the illusion of bidirectional
	 * communication through the pair of pipes. When networking is added, the
	 * interface will remain unchanged.
	 */

#ifdef EIF_WINDOWS
	/* note: 2^15 + 1 = 32767 */
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

	if ((!sp) || (-1 == comfort_child(sp))) {
#ifdef USE_ADD_LOG
		add_log(12, "Daemon: could not comfort child");
#endif
		return (STREAM *) 0;		/* Wrong child */
#ifdef USE_ADD_LOG
    } else {
        add_log(12, "Daemon: child comforted successfully");
#endif
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

	free (startpath);
#else
	if (child_pid != (Pid_t *) 0) {
		*child_pid = pid;
	}
	if (envp) {
		free(envp);
	}
#endif
	if (cmdline) {
		free (cmdline);
	}
	if (exe_path) {
		free (exe_path);
	}
	if (quoted_exe_path) {
		free (quoted_exe_path);
	}
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

	oldpipe = signal(SIGPIPE, broken); /* Trap SIGPIPE within this function */

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
		add_log(12, "Daemon: child does not answer");
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
		add_log(12, "Daemon: wrong child, it would seem");
#endif
		return -1;
#ifdef USE_ADD_LOG
	} else {
		add_log(12, "Daemon: Ok, received \\01");
#endif
	}

#ifdef USE_ADD_LOG
	add_log(12, "Deamon: child started ok");
#endif

	return 0;
}

#ifndef EIF_WINDOWS
rt_private void close_on_exec(int fd)
{
	/* Set the close on exec flag for file descriptor 'fd' */

#ifdef F_SETFD
#ifndef USE_ADD_LOG
	(void) fcntl(fd, F_SETFD, 1);
#else
	int res = fcntl(fd, F_SETFD, 1);
	if (res == -1) {
		add_log(1, "SYSERR fcntl: %m (%e)");
		add_log(2, "ERROR cannot set close-on-exec flag on fd #%d", fd);
	} else {
		add_log(12, "file #%d will be closed upon next exec()", fd);
	}
#endif
#endif
}

rt_private Signal_t broken(int sig)
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

#ifdef EIF_WINDOWS
/* IPC Socket functions */

PSECURITY_DESCRIPTOR newSecurityDescriptor()
{
	DWORD dwRes;
	PSID pEveryoneSID;
	PSECURITY_DESCRIPTOR pSD;
	SID_IDENTIFIER_AUTHORITY SIDAuthWorld = SECURITY_WORLD_SID_AUTHORITY;
	EXPLICIT_ACCESS ea;
	PACL pACL;

	pEveryoneSID = NULL;
	pSD = NULL;
	pACL = NULL;

	/* Create a well-known SID for the Everyone group. */
	if(!AllocateAndInitializeSid(&SIDAuthWorld, 1,
					 SECURITY_WORLD_RID,
					 0, 0, 0, 0, 0, 0, 0,
					 &pEveryoneSID))
	{
#ifdef USE_ADD_LOG
		add_log(3, "AllocateAndInitializeSid Error %u\n", GetLastError());
#endif
		goto Cleanup;
	}

	/* Initialize an EXPLICIT_ACCESS structure for an ACE.
	 * The ACE will allow Everyone read access to the key. */
	ZeroMemory(&ea, sizeof(EXPLICIT_ACCESS));
	ea.grfAccessPermissions = STANDARD_RIGHTS_ALL | SPECIFIC_RIGHTS_ALL;
	ea.grfAccessMode = SET_ACCESS;
	ea.grfInheritance= NO_INHERITANCE;
	ea.Trustee.TrusteeForm = TRUSTEE_IS_SID;
	ea.Trustee.TrusteeType = TRUSTEE_IS_WELL_KNOWN_GROUP;
	ea.Trustee.ptstrName  = (LPTSTR) pEveryoneSID;

	/* Create a new ACL that contains the new ACE. */
	dwRes = SetEntriesInAcl(1, &ea, NULL, &pACL);
	if (ERROR_SUCCESS != dwRes) {
		goto Cleanup;
	}

	/* Initialize a security descriptor. */
	pSD = (PSECURITY_DESCRIPTOR) LocalAlloc(LPTR, SECURITY_DESCRIPTOR_MIN_LENGTH); 	
	if (NULL == pSD) { 
#ifdef USE_ADD_LOG
		add_log(3, "LocalAlloc Error %u", GetLastError());
#endif
		goto Cleanup;
	} 
 
	if (!InitializeSecurityDescriptor(pSD, SECURITY_DESCRIPTOR_REVISION)) {  
#ifdef USE_ADD_LOG
		add_log(3, "InitializeSecurityDescriptor Error %u", GetLastError());
#endif
		goto Cleanup;
	} 

	/* Add the ACL to the security descriptor. */
	if (!SetSecurityDescriptorDacl(pSD, 
			TRUE,     /* bDaclPresent flag    */
			pACL, 
			FALSE))   /* not a default DACL  */
	{  
#ifdef USE_ADD_LOG
		add_log(3, "SetSecurityDescriptorDacl Error %u", GetLastError());
#endif
		goto Cleanup;
	} 
	goto end;

Cleanup:
#ifdef USE_ADD_LOG
	add_log(3, "Cleanup newSecurityDescriptor ...");
#endif
	pSD = NULL;
end:
	return pSD;
}
#endif /* not EIF_WINDOWS */


rt_public STREAM *new_stream_on_debuggee (unsigned int port_number, unsigned int* p_debuggee_pid)
{
#ifdef EIF_WINDOWS
	HANDLE pp2c[2];					/* The opened downwards file descriptors : parent to child */
	HANDLE pc2p[2];					/* The opened upwards file descriptors : child to parent */
	HANDLE *p_event_r, *p_event_w;	/* Event for signalling readability/writability */
#else
	int pp2c[2];					/* The opened downwards file descriptors : parent to child */
	int pc2p[2];					/* The opened upwards file descriptors : child to parent */
#endif

	STREAM *sp;						/* Stream used for communications with ewb */
	unsigned int debuggee_pid;

	/* Attach */
#ifdef EIF_WINDOWS
	pc2p[PIPE_READ] = NULL; pc2p[PIPE_WRITE] = NULL;
	pp2c[PIPE_READ] = NULL; pp2c[PIPE_WRITE] = NULL;
#else
	pc2p[PIPE_READ] = 0; pc2p[PIPE_WRITE] = 0;
	pp2c[PIPE_READ] = 0; pp2c[PIPE_WRITE] = 0;
#endif

#ifdef EIF_WINDOWS
	p_event_r = (HANDLE*) malloc(sizeof(HANDLE));
	p_event_w = (HANDLE*) malloc(sizeof(HANDLE));
	debuggee_pid = attach_debuggee(port_number, pc2p, pp2c, p_event_r, p_event_w);
#else
	debuggee_pid = attach_debuggee(port_number, pc2p, pp2c);
#endif
	if (debuggee_pid > 0){
#ifdef USE_ADD_LOG
		add_log(3, "Daemon: Debuggee attached [%d][%x]\n", debuggee_pid, debuggee_pid);
#endif
	} else {
#ifdef USE_ADD_LOG
		add_log(3, "Daemon: error cannot attach debuggee %d\n", GetLastError());
#endif
		return (STREAM *) 0;
	}
#ifdef EIF_WINDOWS
	/* no need to close them, since they are not opened when attaching them
	CloseHandle (pc2p[PIPE_WRITE]); 
	CloseHandle (pp2c[PIPE_READ]);
	*/
	pc2p[PIPE_WRITE] = NULL;
	pp2c[PIPE_READ] = NULL;
#else
	/* no need to close them, since they are not opened when attaching them
	close(pc2p[PIPE_WRITE]); 
	close(pp2c[PIPE_READ]);
	*/
	pc2p[PIPE_WRITE] = 0;
	pp2c[PIPE_READ] = 0;
#endif

#ifdef EIF_WINDOWS
	sp = new_stream(pc2p[PIPE_READ], pp2c[PIPE_WRITE], *p_event_r, *p_event_w);
#else /* non EIF_WINDOWS */
	sp = new_stream(pc2p[PIPE_READ], pp2c[PIPE_WRITE]);
#endif
#ifdef USE_ADD_LOG
	add_log(3, "Daemon: IPC pipes: writefd(sp)=%d readfd(sp)=%d\n", writefd(sp), readfd(sp));
#endif

	/* Comfort child */
#ifdef USE_ADD_LOG
	add_log (3, "Try to comfort debuggee");
#endif
	/* Wait a little bit ... */
#ifdef EIF_WINDOWS
	Sleep(500);
#else
#ifdef HAS_USLEEP
		usleep(500000);
#else
		sleep(1);
#endif
#endif
	if ((!sp) || (-1 == comfort_child (sp))) {
#ifdef USE_ADD_LOG
		add_log (1, "Daemon: error, could not comfort child");
#endif 
		return (STREAM *) 0;
#ifdef USE_ADD_LOG
	} else {
		add_log (3, "Daemon: child comforted OK");
#endif
	}
	*p_debuggee_pid = debuggee_pid;
	return sp;
}


#ifdef EIF_WINDOWS
rt_private unsigned int attach_debuggee(unsigned int port_number, HANDLE* pc2p, HANDLE* pp2c, HANDLE *p_event_r, HANDLE* p_event_w)
#else
rt_private unsigned int attach_debuggee(unsigned int port_number, int* pc2p, int* pp2c) /* pc2p = fd_in; pp2c = fd_out */
#endif
{
	/* attach debuggee using socket communication on port_number at localhost
	 * port_number is likely to be a dynamic and/or private ports: between 49152 to 65535
	 *          see http://www.iana.org/assignments/port-numbers
	 */

#ifdef EIF_WINDOWS
	WORD wVersionRequested = MAKEWORD(1,1);	/* Stuff for WSA functions */
	WSADATA wsaData;						/* Stuff for WSA functions */
	SOCKET socketfd;        				/* Client socket descriptor */
	struct sockaddr_in server_addr;     	/* Server Internet address */
	SECURITY_ATTRIBUTES saAttr;
#else /* non EIF_WINDOWS */
	int socketfd = -1;  		/* Client socket descriptor */
	struct addrinfo hints, *servinfo, *p;
	char str_port_number[5]; /* INET6_ADDRSTRLEN ; max is 65535, see http://www.iana.org/assignments/port-numbers  */
#endif
	char out_buf[4096];	/* Output buffer for data */
	char in_buf[4096];	/* Input buffer for data */
	int retcode;		/* Return code */
	int i;
	unsigned int debuggee_pid;
	char pipe_c2p_name[MAX_PATH];
	char pipe_p2c_name[MAX_PATH];


#ifdef EIF_WINDOWS
	WSAStartup(wVersionRequested, &wsaData);

	/* Create a client socket
	 *   - AF_INET is Address Family Internet and SOCK_STREAM is streams
	 */
	socketfd = socket(AF_INET, SOCK_STREAM, 0);
	if (socketfd < 0) {
#ifdef USE_ADD_LOG
		add_log(1, "Daemon: ERROR - socket() failed");
#endif
		return 0;
	}

	/* Fill-in the server's address information and do a connect with the
	 * listening server using the client socket - the connect() will block.
	 */
	server_addr.sin_family = AF_INET;                 /* Address family to use */
	server_addr.sin_port = htons((u_short)port_number);           /* Port num to use */
	server_addr.sin_addr.s_addr = inet_addr(DEBUGGEE_IP_ADDR); /* IP address to use */
	retcode = -1;
	for (i = 0; (retcode < 0) && (i < 10); i++) {
		retcode = connect(socketfd, (struct sockaddr *)&server_addr, sizeof(server_addr));
		if (retcode < 0) {
			Sleep(500);
		}
	}
	if (retcode < 0) {
#ifdef USE_ADD_LOG
		add_log(1, "Daemon: ERROR - connect() failed");
#endif
		return 0;
	}
#else /* non EIF_WINDOWS */
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;

	sprintf (str_port_number, "%d", port_number);
    retcode = getaddrinfo(DEBUGGEE_IP_ADDR, str_port_number, &hints, &servinfo);
    if (retcode != 0) {
#ifdef USE_ADD_LOG
        add_log(1, "getaddrinfo: %s", gai_strerror(retcode));
#endif
        return 0;
    }
    /* loop through all the results and connect to the first we can */
    for(p = servinfo; p != NULL; p = p->ai_next) {
        if ((socketfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) == -1) {
#ifdef DEBUG
            perror("client: socket");
#endif
            continue;
        }
		retcode = -1;
		for (i = 0; (retcode < 0) && (i < 10); i++) {
        	retcode = connect(socketfd, p->ai_addr, p->ai_addrlen);
			if (retcode < 0) {
#ifdef USE_ADD_LOG
				add_log(2, "client: try connect: failed -> sleep 3 seconds ...");
#endif
				sleep(3);
			}
		}
		if (retcode < 0) {
			close(socketfd);
#ifdef DEBUG
			perror("client: connect \n");
#endif
			continue;
		}
        break;
    }

    if (p == NULL) {
#ifdef USE_ADD_LOG
        add_log(2, "client: failed to connect");
#endif
		
        return 0;
#ifdef USE_ADD_LOG
	} else {
		add_log(2, "client connected");
#endif
    }
#endif

#ifdef USE_ADD_LOG
	add_log(2, "Wait message from debuggee: sizeof(in_buf) %d ", (int) sizeof(in_buf));
#endif
	/* Receive from the server using the client socket */
	if (recv(socketfd, in_buf, sizeof(in_buf), 0) < 0)
	{
#ifdef USE_ADD_LOG
		add_log(1, "Daemon: ERROR - recv() failed");
#endif
		return 0;
	}

	/* Output the received message */
#ifdef USE_ADD_LOG
	add_log(2, "Received from debuggee: %s", in_buf);
#endif
	debuggee_pid = (unsigned int) atoi(in_buf);

	/* *************************************** */
	/* Create a STREAM structure, which provides the illusion of bidirectional
	 * communication through the pair of pipes. When networking is added, the
	 * interface will remain unchanged.
	 */
#ifdef EIF_WINDOWS
#define BUFSIZE 4096	
	saAttr.nLength = sizeof (SECURITY_ATTRIBUTES);
	saAttr.bInheritHandle = TRUE;
	saAttr.lpSecurityDescriptor = NULL;

	sprintf (pipe_c2p_name, C2P_IPC_NAMED_PIPE_PID_APP_TPL, debuggee_pid, "app");
#ifdef USE_ADD_LOG
	add_log(2, "Creation c2p pipe: %s", pipe_c2p_name);
#endif
	pc2p[PIPE_READ] = CreateNamedPipe(pipe_c2p_name,
						PIPE_ACCESS_INBOUND | 
						FILE_FLAG_OVERLAPPED,
						PIPE_TYPE_MESSAGE | 
						PIPE_READMODE_MESSAGE | 
 						PIPE_WAIT, 
						1,	/* one instance max */
						BUFSIZE, /* output buf size */
						BUFSIZE, /* input buf size */
						0, /* client timeout */
						&saAttr);
	if (pc2p[PIPE_READ] == INVALID_HANDLE_VALUE) {
#ifdef USE_ADD_LOG
		add_log(1, "Daemon: Cannot set up UPWARD pipe...");
#endif
		return 0;
	}

	sprintf (pipe_p2c_name, P2C_IPC_NAMED_PIPE_PID_APP_TPL, debuggee_pid, "app");
#ifdef USE_ADD_LOG
	add_log(2, "Creation p2c pipe: %s", pipe_p2c_name);
#endif
	pp2c[PIPE_WRITE] = CreateNamedPipe(pipe_p2c_name,
						PIPE_ACCESS_OUTBOUND |  
						FILE_FLAG_OVERLAPPED,
						PIPE_TYPE_MESSAGE | 
						PIPE_READMODE_MESSAGE | 
 						PIPE_WAIT, 
						1,	/* one instance max */
						BUFSIZE, /* output buf size */
						BUFSIZE, /* input buf size */
						0, /* client timeout */
						&saAttr);

	if (pp2c[PIPE_WRITE] == INVALID_HANDLE_VALUE) {
#ifdef USE_ADD_LOG
		add_log(1, "Daemon: Cannot set up DOWNWARD pipe...");
#endif
		return 0;
	}

	/* Create event object */
	{
		HANDLE child_event_r, child_event_w; 	/* Event for signalling readability/writability */
		CHAR   event_str[128];				/* Event name */

		SECURITY_ATTRIBUTES	sa;
		
		sa.nLength = sizeof (SECURITY_ATTRIBUTES);
		sa.bInheritHandle = FALSE;
		sa.lpSecurityDescriptor = newSecurityDescriptor();

		/* note: 2^15 + 1 = 32767 */
		sprintf (event_str, "eif_event_r%x_%s", debuggee_pid, "app");
		child_event_r = CreateSemaphore (&sa, 0, 32767, event_str);

		sprintf (event_str, "eif_event_w%x_%s", debuggee_pid, "app");
		child_event_w = CreateSemaphore (&sa, 0, 32767, event_str);

		*p_event_r = child_event_r;
		*p_event_w = child_event_w;
	}

#ifdef USE_ADD_LOG
	add_log(2, "Daemon: send ready");
#endif
	sprintf(out_buf, "daemon: ready");
	if (send(socketfd, out_buf, ((unsigned int)strlen(out_buf) + 1), 0) < 0) {
#ifdef USE_ADD_LOG
		add_log(1, "Daemon: ERROR - send() failed");
#endif
		return 0;
	}


#else /* non EIF_WINDOWS */
	/*  child to parent: debuggee to debugger */
	sprintf (pipe_c2p_name, C2P_IPC_NAMED_PIPE_PID_APP_TPL, debuggee_pid, "app");
	retcode = mkfifo(pipe_c2p_name, 0666);
	if ((retcode == -1) && (errno != EEXIST)) {
#ifdef USE_ADD_LOG
		add_log(1, "Error creating the named pipe: c2p (err: %s)", strerror(errno));
#endif
		return 0;
	}

	/*  parent to child: debugger to debuggee */
	sprintf (pipe_p2c_name, P2C_IPC_NAMED_PIPE_PID_APP_TPL, debuggee_pid, "app");
	retcode = mkfifo(pipe_p2c_name, 0666);
	if ((retcode == -1) && (errno != EEXIST)) {
#ifdef USE_ADD_LOG
		add_log(1, "Error creating the named pipe: p2c (err: %s)", strerror(errno));
#endif
		return 0;
	}

	/* Send to the app the pipe's data, so that the app start opening them 
	 * and do not block the following p2c opening for writing
	 */
	sprintf(out_buf, "daemon: ready");
	if (send(socketfd, out_buf, ((unsigned int)strlen(out_buf) + 1), 0) < 0) {
#ifdef USE_ADD_LOG
		add_log(1, "Daemon: ERROR - send() failed");
#endif
		return 0;
	}

	/* Open c2p for reading */
	pc2p[PIPE_READ] = open(pipe_c2p_name, O_RDONLY);
	if (pc2p[PIPE_READ] < 0) {
#ifdef USE_ADD_LOG
		add_log(1, "Daemon: Error opening %s c2p[PIPE_READ]=%d errno=%d", pipe_c2p_name, pc2p[PIPE_READ], errno);
#endif
		return 0;
#ifdef USE_ADD_LOG
	} else {
		add_log(1, "Open %s c2p[PIPE_READ]=%d DONE", pipe_c2p_name, pc2p[PIPE_READ]);
#endif
	}

	/* Open p2c writing */
	pp2c[PIPE_WRITE] = open(pipe_p2c_name, O_WRONLY);
	if (pp2c[PIPE_WRITE] < 0) {
#ifdef USE_ADD_LOG
		add_log(1, "Daemon: Error opening %s p2c[PIPE_WRITE]=%d errno=%d", pipe_p2c_name, pp2c[PIPE_WRITE], errno);
#endif
		return 0;
#ifdef USE_ADD_LOG
	} else {
		add_log(1, "Open %s p2c[PIPE_WRITE]=%d DONE", pipe_p2c_name, pp2c[PIPE_WRITE]);
#endif
	}
#endif

	/* Wait for the debuggee to be ready  (get pipes and events) */
	if (recv(socketfd, in_buf, sizeof(in_buf), 0) < 0)
	{
#ifdef USE_ADD_LOG
		add_log(1, "Daemon: ERROR - recv() failed ");
#endif
		return 0;
	}

#ifdef EIF_WINDOWS
#else
	/* clean the named pipe from the filesystem */
	if (unlink(pipe_c2p_name) == -1) {
#ifdef USE_ADD_LOG
		add_log(3, "Daemon: ERROR while trying to unlink %s\n",pipe_c2p_name);
#endif
	};
	if (unlink(pipe_p2c_name) == -1) {
#ifdef USE_ADD_LOG
		add_log(3, "Daemon: ERROR while trying to unlink %s\n",pipe_p2c_name);
#endif
	};
#endif


	/* Close the client socket */
#ifdef EIF_WINDOWS
	if (closesocket(socketfd) < 0) {
#else
	if (close(socketfd) < 0) {
#endif
#ifdef USE_ADD_LOG
		add_log(3, "Daemon: ERROR - closesocket() failed");
#endif
	}

#ifdef EIF_WINDOWS
	/* Clean-up winsock */
	WSACleanup();
#endif

	return debuggee_pid;
}
