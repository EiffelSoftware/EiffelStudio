case $CONFIG in
'')
	if test ! -f config.sh; then
		ln ../config.sh . || \
		ln ../../config.sh . || \
		ln ../../../config.sh . || \
		(echo "Can't find config.sh."; exit 1)
	fi 2>/dev/null
	. ./config.sh
	;;
esac
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Extracting config.h (with variable substitutions)"
sed <<!GROK!THIS! >config.h -e 's!^#undef!/\*#define!'
/*
 * This file was produced by running the config_h.SH script, which
 * gets its values from config.sh, which is generally produced by
 * running Configure.
 *
 * Feel free to modify any of this as the need arises.  Note, however,
 * that running config.h.SH again will wipe out any changes you've made.
 * For a more permanent change edit config.sh and rerun config.h.SH.
 *
 * \$Id$
 */

/* Configuration time: $cf_time
 * Configured by: $cf_by
 * Target system: $myuname
 */

#ifndef _config_h_
#define _config_h_

/* BSD:
 *	This symbol, if defined, indicates that the program is running under
 *	a BSD system.
 */
#$d_bsd BSD		/**/

/* ABORTSIG:
 *	This symbol holds the signal number (symbol) used by the abort() call. To
 *	actually define the signal symbol, <signal.h> should be included.
 */
#define ABORTSIG $abortsig		/**/

/* ALIGNBYTES:
 *	This symbol contains the number of bytes required to align a
 *	double. Usual values are 2, 4 and 8.
 */
#define ALIGNBYTES $alignbytes	/**/

/* BYTEORDER:
 *	This symbol hold the hexadecimal constant defined in byteorder,
 *	i.e. 0x1234 or 0x4321, etc...
 */
#define BYTEORDER 0x$byteorder	/* large digits for MSB */

/* VAL_NOFILE:
 *	This symbol contains the number of file descriptors available to the
 *	process, as determined at configuration time. Unless a static constant
 *	is needed, you should rely on getdtablesize() to obtain that number.
 */
#define VAL_NOFILE $nofile	/* Number of file descriptors */

/* bcmp:
 *	This symbol is maped to memcmp if the bcmp() routine is not
 *	available to compare strings.
 */
#$d_bcmp bcmp(s,d,l) memcmp((s),(d),(l))	/* mapped to memcmp */

/* bcopy:
 *	This symbol is maped to memcpy if the bcopy() routine is not
 *	available to copy strings.
 */
#$d_bcopy bcopy(s,d,l) memcpy((d),(s),(l))		/* mapped to memcpy */

/* USE_BSDJMP
 *	This symbol, if defined, indicates that the BSD _setjmp and _longjmp
 *	routines are available to do non-local gotos wihtout saving or restoring
 *	the signal mask flag.
 */
#$d_bsdjmp USE_BSDJMP		/**/

/* bzero:
 *	This symbol is maped to memset if the bzero() routine is not
 *	available to set memory to 0.
 */
#$d_bzero bzero(s,l) memset((s),0,(l))	/* mapped to memset */

/* HAS_DUP2
 *	This symbol, if defined, indicates that the dup2 routine is
 *	available to duplicate file descriptors.
 */
#$d_dup2 HAS_DUP2	/**/

/* EOFPIPE:
 *	This symbol, if defined, indicates that EOF condition will be detected
 *	by the reader of the pipe when it is closed by the writing process.
 *	That is, a select() call on that file descriptor will not block when
 *	only an EOF remains (typical behaviour for BSD systems).
 */
#$d_eofpipe EOFPIPE		/**/

/* HAS_FCNTL:
 *	This symbol, if defined, indicates to the C program that
 *	the fcntl() function exists.
 */
#$d_fcntl HAS_FCNTL		/**/

/* HAS_FTIME
 *	This symbol, if defined, indicates that the ftime() routine exists.
 *	It is basically a sub-second accuracy clock, but is less accurate
 *	than gettimeofday(2) anyway. The type "Timeval" should be used to
 *	refer to "struct timeb".
 */
/* HAS_GETTIMEOFDAY
 *	This symbol, if defined, indicates that the gettimeofday() system
 *	call is available for a sub-second accuracy clock. Usually, the file
 *	<sys/resource.h> needs to be included (see I_SYS_RESOURCE).
 *	The type "Timeval" should be used to refer to "struct timeval".
 */
#$d_ftime HAS_FTIME		/**/
#$d_gettimeod HAS_GETTIMEOFDAY	/**/
#ifdef HAS_FTIME
#define Timeval struct timeb		/* Structure used by ftime() */
#endif
#ifdef HAS_GETTIMEOFDAY
#define Timeval struct timeval	/* Structure used by gettimeofday() */
#endif

/* HAS_GETHOSTID
 *	This symbol, if defined, indicates that the gethostid system call is
 *	available to get the host id.
 */
#$d_gethid HAS_GETHOSTID		/**/

/* HAS_GETHOSTNAME
 *	This symbol, if defined, indicates that the C program may use the
 *	gethostname() routine to derive the host name.  See also HAS_UNAME
 *	and PHOSTNAME.
 */
/* HAS_UNAME
 *	This symbol, if defined, indicates that the C program may use the
 *	uname() routine to derive the host name.  See also HAS_GETHOSTNAME
 *	and PHOSTNAME.
 */
/* PHOSTNAME:
 *	This symbol, if defined, indicates that the C program may use the
 *	contents of PHOSTNAME as a command to feed to the popen() routine
 *	to derive the host name.  See also HAS_GETHOSTNAME and HAS_UNAME.
 *	Note that the command uses a fully qualified path, so that it is safe
 *	even if used by a process with super-user privileges.
 */
#$d_gethname HAS_GETHOSTNAME	/**/
#$d_uname HAS_UNAME		/**/
#$d_phostname PHOSTNAME "$aphostname"	/* How to get the host name */

/* HAS_GETOPT
 *	This symbol, if defined, indicates that the getopt() routine exists.
 */
#$d_getopt HAS_GETOPT		/**/

/* PAGESIZE_VALUE
 *	This symbol holds the size in bytes of a system page (obtained via
 *	the getpagesize() system call at configuration time or asked to the
 *	user if the system call is not available).
 */
#define PAGESIZE_VALUE $pagesize	/* System page size, in bytes */

/* SIGNALS_KEPT
 *	This symbol is defined if signal handlers must be reinstated after
 *	receipt of a signal.
 */
#$d_keepsig SIGNALS_KEPT	/**/

/* HAS_LSTAT
 *	This symbol, if defined, indicates that the lstat routine is
 *	available to do file stats on symbolic links.
 */
#$d_lstat HAS_LSTAT		/**/

/* HAS_MKDIR
 *	This symbol, if defined, indicates that the mkdir routine is available
 *	to create directories.  Otherwise you should fork off a new process to
 *	exec /bin/mkdir.
 */
#$d_mkdir HAS_MKDIR		/**/

/* PIDCHECK:
 *	This symbol, if defined, means that the kill(pid, 0) will
 *	check for an active pid (i.e. the kernel will run all the
 *	necessary pid checks, but no signal is actually sent).
 */
#$d_pidcheck PIDCHECK		/**/

/* HAS_READDIR
 *	This symbol, if defined, indicates that the readdir routine is
 *	available to read directory entries. You may have to include
 *	<dirent.h>. See I_DIRENT.
 */
#$d_readdir HAS_READDIR		/**/

/* HAS_RENAME
 *	This symbol, if defined, indicates that the rename routine is available
 *	to rename files.  Otherwise you should do the unlink(), link(), unlink()
 *	trick.
 */
#$d_rename HAS_RENAME	/**/

/* HAS_RMDIR
 *	This symbol, if defined, indicates that the rmdir routine is
 *	available to remove directories. Otherwise you should fork off a
 *	new process to exec /bin/rmdir.
 */
#$d_rmdir HAS_RMDIR		/**/

/* HAS_GETRUSAGE
 *	This symbol, if defined, indicates that the getrusage() routine is
 *	available to get process statistics with a sub-second accuracy.
 *	Inclusion of <sys/resource.h> and <sys/time.h> may be necessary.
 */
#$d_rusage HAS_GETRUSAGE		/**/

/* USE_BSDPGRP
 *	This symbol, if defined, indicates that the BSD notion of process
 *	group is to be used. For instance, you have to say setpgrp(pid, pgrp)
 *	instead of the USG setpgrp().
 */
#$d_bsdpgrp USE_BSDPGRP		/**/

/* HAS_SYS_SIGLIST
 *	This symbol, if defined, indicates that the sys_siglist array is
 *	available to translate signal numbers to strings.
 */
#$d_siglist HAS_SYS_SIGLIST		/**/

/* HAS_SIGSETMASK
 *	This symbol, if defined, indicates that the sigsetmask() routine is
 *	available to set current signal mask. Otherwise, you should probably
 *	emulate this by using signal(), but fear race conditions...
 */
#$d_sigsetmk HAS_SIGSETMASK		/**/

/* HAS_SIGVEC
 *	This symbol, if defined, indicates that BSD reliable signals are
 *	supported.
 */
/* HAS_SIGVECTOR
 *	This symbol, if defined, indicates that the sigvec() routine is called
 *	sigvector() instead, and that sigspace() is provided instead of
 *	sigstack().  This is probably only true for HP-UX.
 */
#$d_sigvec HAS_SIGVEC	/**/
#$d_sigvectr HAS_SIGVECTOR	/**/

/* HAS_SOCKET
 *	This symbol, if defined, indicates that the BSD socket interface is
 *	supported.
 */
#$d_socket HAS_SOCKET		/**/

/* index:
 *	This preprocessor symbol is defined, along with rindex, if the system
 *	uses the strchr and strrchr routines instead.
 */
/* rindex:
 *	This preprocessor symbol is defined, along with index, if the system
 *	uses the strchr and strrchr routines instead.
 */
#$d_strchr	index strchr	/**/
#$d_strchr	rindex strrchr	/**/

/* USE_STRUCT_COPY
 *	This symbol, if defined, indicates that this C compiler knows how
 *	to copy structures.  If undefined, you'll need to use a block copy
 *	routine of some sort instead.
 */
#$d_strctcpy	USE_STRUCT_COPY	/**/

/* HAS_STRERROR
 *	This symbol, if defined, indicates that the strerror routine is
 *	available to translate error numbers to strings.
 */
/* HAS_SYS_ERRLIST
 *	This symbol, if defined, indicates that the sys_errlist array is
 *	available to translate error numbers to strings. The extern int
 *	sys_nerr gives the size of that table.
 */
/* HAS_SYS_ERRNOLIST
 *	This symbol, if defined, indicates that the sys_errnolist array is
 *	available to translate an errno code into its symbolic name (e.g.
 * ENOENT). The extern int sys_nerrno gives the size of that table.
 */
/* strerror:
 *	This preprocessor symbol is defined as a macro if strerror() is
 *	not available to translate error numbers to strings but sys_errlist[]
 *	array is there.
 */
#$d_strerror HAS_STRERROR		/**/
#$d_syserrlst HAS_SYS_ERRLIST	/**/
#$d_sysernlst HAS_SYS_ERRNOLIST	/**/
#$d_strerrm strerror(e) ((e)<0||(e)>=sys_nerr?"unknown":sys_errlist[e]) /**/

/* HAS_TIME
 *	This symbol, if defined, indicates that the time() routine exists.
 */
/* Time_t
 *	This symbol holds the type returned by time(). It can be long,
 *	or time_t on BSD sites (in which case <sys/types.h> should be
 *	included).
 */
#$d_time HAS_TIME		/**/
#define Time_t $timetype		/* Time type */

/* HAS_TIMES
 *	This symbol, if defined, indicates that the times() routine exists.
 *	Note that this became obsolete on some systems (SUNOS), which now
 * use getrusage(). It may be necessary to include <sys/times.h>.
 */
/* Clock_t
 *	This symbol holds the type returned by times(). It can be long,
 *	or clock_t on BSD sites (in which case <sys/types.h> should be
 *	included).
 */
#$d_times HAS_TIMES		/**/
#define Clock_t $clocktype	/* Clock time */

/* HAS_USLEEP
 *	This symbol, if defined, indicates that the usleep routine is
 *	available to let the process sleep on a sub-second accuracy.
 */
#$d_usleep HAS_USLEEP		/**/

/* Signal_t
 *	This symbol's value is either "void" or "int", corresponding to the
 *	appropriate return type of a signal handler.  Thus, you can declare
 *	a signal handler using "Signal_t (*handler)()", and define the
 *	handler using "Signal_t handler(sig)".
 */
#define Signal_t $signal_t	/* Signal handler's return type */

/* I_DIRENT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <dirent.h>.
 */
/* DIRNAMLEN:
 *	This symbol, if defined, indicates to the C program that the length
 *	of directory entry names is provided by a d_namlen field.  Otherwise
 *	you need to do strlen() on the d_name field.
 */
#$i_dirent I_DIRENT		/**/
#$d_dirnamlen DIRNAMLEN	/**/

/* I_FCNTL
 *	This manifest constant tells the C program to include <fcntl.h>.
 */
#$i_fcntl I_FCNTL	/**/

/* I_LIMITS:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <limits.h> to get definition of symbols like WORD_BIT or
 *	LONG_MAX, i.e. machine dependant limitations.
 */
#$i_limits I_LIMITS		/**/

/* I_NETINET_IN:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <netinet/in.h>. Otherwise, you may try <sys/in.h>.
 */
/* I_SYS_IN
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/in.h> instead of <netinet/in.h>.
 */
#$i_niin I_NETINET_IN	/**/
#$i_sysin I_SYS_IN		/**/

/* I_STDARG:
 *	This symbol, if defined, indicates that <stdarg.h> exists and should
 *	be included.
 */
#$i_stdarg I_STDARG		/**/

/* I_STRING:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <string.h> (USG systems) instead of <strings.h> (BSD systems).
 */
#$i_string I_STRING		/**/

/* I_SYS_DIR
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/dir.h>.
 */
#$i_sysdir I_SYS_DIR		/**/

/* I_SYS_FILE
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/file.h> to get definition of R_OK and friends.
 */
#$i_sysfile I_SYS_FILE		/**/

/* USE_TIOCNOTTY
 *	This symbol, if defined indicate to the C program that the ioctl()
 *	call with TIOCNOTTY should be used to void tty association.
 *	Otherwise (on USG probably), it is enough to close the standard file
 *	decriptors and do a setpgrp().
 */
#$d_voidtty USE_TIOCNOTTY	/**/

/* I_SYS_NDIR
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/ndir.h>.
 */
#$i_sysndir I_SYS_NDIR	/**/

/* I_SYS_RESOURCE
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/resource.h>.
 */
#$i_sysresrc I_SYS_RESOURCE		/**/

/* I_SYS_SELECT
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/select.h> in order to get definition of struct timeval.
 */
#$i_sysselct I_SYS_SELECT	/**/

/* I_SYS_SOCKET:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/socket.h> before performing socket calls.
 */
#$i_syssock	I_SYS_SOCKET		/**/

/* I_SYS_TIMEB
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/timeb.h>, in order to define struct timeb (some systems
 *	define this in <sys/time.h>). This is useful when using ftime().
 *	You should include <sys/time.h> if I_SYS_TIMEB is not defined,
 *	nor is I_SYS_TIME.
 */
#$i_systimeb I_SYS_TIMEB		/**/

/* I_SYS_TIMES
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/times.h>.
 */
#$i_systimes	I_SYS_TIMES		/**/

/* I_SYS_UN:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/un.h> to get UNIX domain socket definitions.
 */
#$i_sysun I_SYS_UN		/**/

/* I_TIME
 *	This symbol, if defined, indicates to the C program that it should
 *	include <time.h>.
 */
/* I_SYS_TIME
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/time.h>.
 */
/* I_SYS_TIME_KERNEL
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/time.h> with KERNEL defined.
 */
#$i_time I_TIME		/**/
#$i_systime I_SYS_TIME		/**/
#$i_systimek I_SYS_TIME_KERNEL		/**/

/* I_VARARGS:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <varargs.h>.
 */
#$i_varargs I_VARARGS		/**/

/* INTSIZE:
 *	This symbol contains the size of an int, so that the C preprocessor
 *	can make decisions based on it.
 */
#define INTSIZE $intsize		/**/

/* Malloc_t
 *	This symbol is the type of pointer returned by malloc and realloc.
 */
#define Malloc_t $malloctype			/**/

/* Pid_t
 *	This symbol holds the type used to declare process ids in the kernel.
 *	It can be int, uint, pid_t, etc... It may be necessary to include
 *	<sys/types.h> to get any typedef'ed information.
 */
#define Pid_t $pidtype		/* PID type */

/* CAN_PROTOTYPE :
 *	If defined, this macro indicates that the C compiler can handle
 *	function prototypes.
 */
/* DOTS :
 *	This macro is used to specify the ... in function prototypes which
 *	have arbitrary additional arguments.
 */
/* NXT_ARG :
 *	This macro is used to separate arguments in the declared argument list.
 */
/* P_FUNC :
 *	This macro is used to declare "private" (static) functions.
 *	It takes three arguments: the function type and name, a parenthesized
 *	traditional (comma separated) argument list, and the declared argument
 *	list (in which arguments are separated with NXT_ARG, and additional
 *	arbitrary arguments are specified with DOTS).  For example:
 *
 *		P_FUNC(int foo, (bar, baz), int bar NXT_ARG char *baz[])
 */
/* P_FUNC_VOID :
 *	This macro is used to declare "private" (static) functions that have
 *	no arguments.  The macro takes one argument: the function type and name.
 *	For example:
 *
 *		P_FUNC_VOID(int subr)
 */
/* V_FUNC :
 *	This macro is used to declare "public" (non-static) functions.
 *	It takes three arguments: the function type and name, a parenthesized
 *	traditional (comma separated) argument list, and the declared argument
 *	list (in which arguments are separated with NXT_ARG, and additional
 *	arbitrary arguments are specified with DOTS).  For example:
 *
 *		V_FUNC(int main, (argc, argv), int argc NXT_ARG char *argv[])
 */
/* V_FUNC_VOID :
 *	This macro is used to declare "public" (non-static) functions that have
 *	no arguments.  The macro takes one argument: the function type and name.
 *	For example:
 *
 *		V_FUNC_VOID(int fork)
 */
/* _
 *	This macro is used to declare function parameters for folks who want
 *	to make declarations with prototypes using a different style than
 *	the above macros.  Use double parentheses.  For example:
 *
 *		int main _((int argc, char *argv[]));
 */
#$prototype	CAN_PROTOTYPE	/**/
#ifdef CAN_PROTOTYPE
#define	NXT_ARG ,
#define	DOTS , ...
#define	V_FUNC(name, arglist, args)name(args)
#define	P_FUNC(name, arglist, args)static name(args)
#define	V_FUNC_VOID(name)name(VOID)
#define	P_FUNC_VOID(name)static name(VOID)
#define	_(args) args
#else
#define	NXT_ARG ;
#define	DOTS
#define	V_FUNC(name, arglist, args)name arglist args;
#define	P_FUNC(name, arglist, args)static name arglist args;
#define	V_FUNC_VOID(name)name()
#define	P_FUNC_VOID(name)static name()
#define	_(args) ()
#endif

/* register1:
 *	This symbol, along with register2, register3, etc. is either the word
 *	"register" or null, depending on whether the C compiler pays attention
 *	to this many register declarations.  The intent is that you don't have
 *	to order your register declarations in the order of importance, so you
 *	can freely declare register variables in sub-blocks of code and as
 *	function parameters.  Do not use register<n> more than once per routine.
 */
#define register1 $reg1		/**/
#define register2 $reg2		/**/
#define register3 $reg3		/**/
#define register4 $reg4		/**/
#define register5 $reg5		/**/
#define register6 $reg6		/**/
#define register7 $reg7		/**/

/* Caddr_t
 *	This symbol holds the type of a core address. It is inteded to be used
 *	to safely declare the return type of system calls like sbrk(). It might
 *	be necessary to include <sys/types.h> as well.
 */
#define Caddr_t $sbrktype	/* <core address> type */

/* KEEPALIVE:
 *	This symbol if defined indicates to the C program that the SO_KEEPALIVE
 *	option of setsockopt() will work as advertised in the manual.
 */
#$d_keepalive KEEPALIVE		/**/

/* Uid_t
 *	This symbol holds the type used to declare user ids in the kernel.
 *	It can be int, ushort, uid_t, etc... It may be necessary to include
 *	<sys/types.h> to get any typedef'ed information.
 */
#define Uid_t $uidtype		/* UID type */

/* USE_ADD_LOG:
 *	This symbol is defined if the run time logging is enabled, mainly for
 *	debugging purposes (although the logging level may be set to a low level
 *	to leave only critical error messages). This will never be defined by
 *	default.
 */
#$add_log USE_ADD_LOG		/* Allow logging */
#define LOGGING_LEVEL	9	/* Logging level */

/* MAY_PANIC:
 *	This symbol is defined if the run-time is to be compiled with extra
 *	consistency checks. Those checks make sure some "impossible" conditions
 *	never occur, and they raise a panic if they do. Typical checks include
 *	free-list consistency check, stack overflow or underflow, etc...
 */
#$d_maypanic MAY_PANIC	/* Extra run-time consistency checks */

#endif
!GROK!THIS!
