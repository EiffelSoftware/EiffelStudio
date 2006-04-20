/*
	description: "Handles logging facilities."
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

#ifdef EIF_VMS
#include "ipcvms.h"		/* only affects VMS */
#endif

#ifdef I_TIME
# include <time.h>
#endif

#ifdef I_SYS_TIME
# include <sys/time.h>
#endif

#ifdef I_SYS_TIME_KERNEL
# define KERNEL
# include <sys/time.h>
# undef KERNEL
#endif

#ifdef I_FCNTL
#include <fcntl.h>
#endif

#ifdef I_SYS_FILE
#include <sys/file.h>
#endif

#include <string.h>					/* Try to find strerror() there */

#ifdef USE_ADD_LOG
#include "eif_logfile.h"

#define MAX_STRING	1024			/* Maximum length for logging string */

rt_private int logfile = -2;			/* File descriptor used for logging */
rt_private char *logname = (char *) 0;	/* Name of the logfile in use */
rt_private int loglvl = 20;			/* Logging level */
rt_private void expand(char *, char*);	/* Run the %m %e expansion on the string */
rt_private int add_error(char *);			/* Prints description of error in errno */
rt_private int add_errcode(char *);			/* Print the symbolic error name */
rt_public void dexit(int);

rt_public char *progname = "ram";	/* Program name */

#ifndef EIF_WINDOWS
rt_public Pid_t progpid = 0;		/* Program PID */
extern int errno;				/* System error report variable */
#endif

extern Time_t time(time_t *);			/* Time in seconds since the Epoch */
extern int file_lock();			/* Obtain a lock file with .lock extension */ /* %%ss undefined nowhere */
extern void release_lock(void);		/* Release previous lock */

rt_public void dexit(int status)
{
	add_log(12, "exiting with status %d", status);
	exit(status);
}

/* VARARGS2 */
#ifdef EIF_WINDOWS
rt_public void add_log(int level, char *format, int arg1, HANDLE arg2, HANDLE arg3, HANDLE arg4, HANDLE arg5)
#else
rt_public void add_log(int level, char *format, int arg1, int arg2, int arg3, int arg4, int arg5)
#endif
{
	/* Add logging informations at specified level. Note that the arguments are
	 * declared as 'int', but it should work fine, even when we give doubles,
	 * because they will be pased "as is" to fprintf. Maybe I should use
	 * vfprintf when it is available--RAM.
	 * The only magic string substitution which occurs is the '%m', which is
	 * replaced by the error message, as given by errno and '%e' which gives
	 * the symbolic name of the error (if available, otherwise the number).
	 * The log file must have been opened with open_log() before add_log calls.
	 */

	struct tm *ct;				/* Current time (pointer to static data) */
	Time_t clock;				/* Number of seconds since the Epoch */
	char buffer[MAX_STRING];	/* Buffer which holds the expanded %m string */
	char message[MAX_STRING];	/* Where logging message is built */
	int fd;						/* File descriptor to be used for message */

	if (loglvl < level)			/* Logging level is not high enough */
		return;

	if (logfile == -2)			/* Logfile not opened for whatever reason */
		fd = 2;					/* Use stderr if no logfile opened */
	else
		fd = logfile;			/* Thie is the normal log file */

	clock = time((Time_t *) 0);	/* Number of seconds */
	ct = localtime(&clock);		/* Get local time from amount of seconds */
	expand(format, buffer);		/* Expansion of %m and %e into buffer */

	sprintf(message, buffer, arg1, arg2, arg3, arg4, arg5);
	sprintf(buffer, "%d/%.2d/%.2d %.2d:%.2d:%.2d %s[%d]: %s\n",
		ct->tm_year, ct->tm_mon + 1, ct->tm_mday,
		ct->tm_hour, ct->tm_min, ct->tm_sec,
#ifdef EIF_WINDOWS
		progname, 0, message);
#else
		progname, progpid, message);
#endif
	(void) write(fd, buffer, strlen(buffer));
}

rt_public int open_log(char *name)
{
	/* Open log file 'name' for logging. If a previous log file was opened,
	 * it is closed before. The routine returns -1 in case of error.
	 */

	if (logfile != -2)
		close(logfile);

#ifdef __VMS	/* create a new file the first time called only */
	{
	    static int been_here_done_that = FALSE;
	    if (been_here_done_that)
	        logfile = open(name, O_WRONLY | O_CREAT | O_APPEND, 0644);
	    else
	        logfile = open(name, O_WRONLY | O_CREAT | O_TRUNC, 0644);
	    been_here_done_that = TRUE;
	}

#else
	logfile = open(name, O_WRONLY | O_CREAT | O_APPEND, 0644);
#endif  /* vms */

	logname = name;					/* Save file name */

	if (logfile == -1) {
		logfile = -2;
		return -1;
	}

	add_log(12, "logfile opened on file #%d", logfile);

	return 0;
}

rt_public void close_log(void)
{
	/* Close log file */

	if (logfile != -2)			/* File not closed */
		close(logfile);

	logfile = -2;				/* Mark file as closed */
}

rt_public int reopen_log(void)
{
	/* Reopen logfile with same name as before (useful when child wants to start
	 * with a fresh new file descriptor).
	 */

	if (logname != (char *) 0)
		return open_log(logname);

	return -1;						/* No previously opened logfile */
}

rt_public void set_loglvl(int level)
{
	/* Set logging level to 'level' */

	loglvl = level;
}

rt_private void expand(char *from, char *to)
{
	/* The string held in 'from' is copied into 'to' and every '%m' is expanded
	 * into the error message deduced from the value of errno.
	 */

	int len;							/* Length of substituted text */

	while (*to++ = *from)
		if (*from++ == '%')
			switch (*from) {
			case 'm':					/* %m is the English description */
				len = add_error(to - 1);
				to += len - 1;
				from++;
				break;
			case 'e':					/* %e is the symbolic error code */
				len = add_errcode(to - 1);
				to += len - 1;
				from++;
				break;
			}
}

rt_private int add_error(char *where)
{
	/* Prints a description of the error code held in 'errno' into 'where' if
	 * it is available, otherwise simply print the error code number.
	 */

#ifdef HAS_SYS_ERRLIST
	extern int sys_nerr;					/* Size of sys_errlist[] */
	extern char *sys_errlist[];				/* Maps error code to string */
#endif

#if defined HAS_STRERROR || defined HAS_SYS_ERRLIST
	sprintf(where, "%s", Strerror(errno));
#else
	sprintf(where, "error #%d", errno);
#endif

	return strlen(where);		/* FIXME */
}

rt_private int add_errcode(char *where)
{
	/* Prints the symbolic description of the error code heldin in 'errno' into
	 * 'where' if possible. Otherwise, prints the error number.
	 */

#ifdef HAS_SYS_ERRNOLIST
	extern int sys_nerrno;					/* Size of sys_errnolist[] */
	extern char *sys_errnolist[];			/* Error code to symbolic name */
#endif

#ifdef HAS_SYS_ERRNOLIST
	if (errno < 0 || errno >= sys_nerrno)
		sprintf(where, "UNKNOWN");
	else
		sprintf(where, "%s", sys_errnolist[errno]);
#else
		sprintf(where, "%d", errno);
#endif

	return strlen(where);		/* FIXME */
}

#endif
