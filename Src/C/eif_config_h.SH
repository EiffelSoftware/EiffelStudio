case $CONFIG in
'')
	if test -f config.sh; then TOP=.;
	elif test -f ../config.sh; then TOP=..;
	elif test -f ../../config.sh; then TOP=../..;
	elif test -f ../../../config.sh; then TOP=../../..;
	elif test -f ../../../../config.sh; then TOP=../../../..;
	else
		echo "Can't find config.sh."; exit 1
	fi
	. $TOP/config.sh
	;;
esac
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Extracting eif_config.h (with variable substitutions)"
sed <<!GROK!THIS! >eif_config.h -e 's!^#undef\(.*\)/\*!/\*#define \1 \*/ /\*!' -e 's!^#un-def!#undef!'
/*
	description: "Portability information for the Eiffel Software's Runtime."
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

#ifndef _config_h_
#define _config_h_

/* ABORTSIG:
 *	This symbol holds the signal number (symbol) used by the abort() call. To
 *	actually define the signal symbol, <signal.h> should be included.
 */
#define ABORTSIG $abortsig		/* NC */

/* MEM_ALIGNBYTES:
 *	This symbol contains the number of bytes required to align a
 *	double. Usual values are 2, 4 and 8.
 */
#define MEM_ALIGNBYTES $alignbytes	/* NC */

/* BYTEORDER:
 *	This symbol hold the hexadecimal constant defined in byteorder,
 *	i.e. 0x1234 or 0x4321, etc...
 */
#define BYTEORDER 0x$byteorder	/* large digits for MSB */

/* CAT2:
 *	This macro catenates 2 tokens together.
 */
#if $cpp_stuff == 1
#define CAT2(a,b)a/* NC */b
#define CAT3(a,b,c)a/* NC */b/* NC */c
#elif $cpp_stuff == 42
#define CAT2(a,b)a ## b
#define CAT3(a,b,c)a ## b ## c
#endif

#ifndef CAT2
#include "Warning: How does this C preprocessor catenate tokens?"
#endif

/* VAL_NOFILE:
 *	This symbol contains the number of file descriptors available to the
 *	process, as determined at configuration time. Unless a static constant
 *	is needed, you should rely on getdtablesize() to obtain that number.
 */
#define VAL_NOFILE $nofile	/* Number of file descriptors */

/* USE_BSDJMP:
 *	This symbol, if defined, indicates that the BSD _setjmp and _longjmp
 *	routines are available to do non-local gotos wihtout saving or restoring
 *	the signal mask flag.
 */
#$d_bsdjmp USE_BSDJMP		/* NC */

/* HAS_CHOWN:
 *	This symbol, if defined, indicates that the chown routine is
 *	available.
 */
#$d_chown HAS_CHOWN		/* NC */

/* HAS_DUP2:
 *	This symbol, if defined, indicates that the dup2 routine is
 *	available to duplicate file descriptors.
 */
#$d_dup2 HAS_DUP2	/* NC */

/* EOFPIPE:
 *	This symbol, if defined, indicates that EOF condition will be detected
 *	by the reader of the pipe when it is closed by the writing process.
 *	That is, a select() call on that file descriptor will not block when
 *	only an EOF remains (typical behaviour for BSD systems).
 */
#$d_eofpipe EOFPIPE		/* NC */

/* HAS_FCNTL:
 *	This symbol, if defined, indicates to the C program that
 *	the fcntl() function exists.
 */
#$d_fcntl HAS_FCNTL		/* NC */

/* HAS_FTIME:
 *	This symbol, if defined, indicates that the ftime() routine exists.
 *	It is basically a sub-second accuracy clock, but is less accurate
 *	than gettimeofday(2) anyway. The type "Timeval" should be used to
 *	refer to "struct timeb".
 */
#$d_ftime HAS_FTIME		/* NC */
#ifdef HAS_FTIME
#define Timeval struct timeb		/* Structure used by ftime() */
#endif

/* HAS_GETTIMEOFDAY:
 *	This symbol, if defined, indicates that the gettimeofday() system
 *	call is available for a sub-second accuracy clock. Usually, the file
 *	<sys/resource.h> needs to be included (see I_SYS_RESOURCE).
 *	The type "Timeval" should be used to refer to "struct timeval".
 */
#$d_gettimeod HAS_GETTIMEOFDAY	/* NC */
#ifdef HAS_GETTIMEOFDAY
#define Timeval struct timeval	/* Structure used by gettimeofday() */
#endif

/* HAS_GETGROUPS:
 *	This symbol, if defined, indicates that the getgroups() routine is
 *	available to get the list of process groups.  If unavailable, multiple
 *	groups are probably not supported.
 */
#$d_getgrps HAS_GETGROUPS		/* NC */

/* Groups_t:
 *	This symbol holds the type used for the second argument to
 *	getgroups().  Usually, this is the same of gidtype, but
 *	sometimes it isn't.  It can be int, ushort, uid_t, etc...
 *	It may be necessary to include <sys/types.h> to get any
 *	typedef'ed information.  This is only required if you have
 *	getgroups().
 */
#ifdef HAS_GETGROUPS
#define Groups_t $groupstype	/* Type for 2nd arg to getgroups() */
#endif

/* PAGESIZE_VALUE:
 *	This symbol holds the size in bytes of a system page (obtained via
 *	the getpagesize() system call at configuration time or asked to the
 *	user if the system call is not available).
 */
#define PAGESIZE_VALUE $pagesize	/* System page size, in bytes */

/* SIGNALS_KEPT:
 *	This symbol is defined if signal handlers needn't be reinstated after
 *	receipt of a signal.
 */
#$d_keepsig SIGNALS_KEPT	/* NC */

/* HAS_LINK:
 *	This symbol, if defined, indicates that the link routine is
 *	available to create hard links.
 */
#$d_link HAS_LINK	/* NC */

/* HAS_LSTAT:
 *	This symbol, if defined, indicates that the lstat routine is
 *	available to do file stats on symbolic links.
 */
#$d_lstat HAS_LSTAT		/* NC */

/* HAS_MKDIR:
 *	This symbol, if defined, indicates that the mkdir routine is available
 *	to create directories.  Otherwise you should fork off a new process to
 *	exec /bin/mkdir.
 */
#$d_mkdir HAS_MKDIR		/* NC */

/* PIDCHECK:
 *	This symbol, if defined, means that the kill(pid, 0) will
 *	check for an active pid (i.e. the kernel will run all the
 *	necessary pid checks, but no signal is actually sent).
 */
#$d_pidcheck PIDCHECK		/* NC */

/* HAS_READDIR:
 *	This symbol, if defined, indicates that the readdir routine is
 *	available to read directory entries. You may have to include
 *	<dirent.h>. See I_DIRENT.
 */
#$d_readdir HAS_READDIR		/* NC */

/* HAS_REWINDDIR:
 *	This symbol, if defined, indicates that the rewinddir routine is
 *	available. You may have to include <dirent.h>. See I_DIRENT.
 */
#$d_rewinddir HAS_REWINDDIR		/* NC */

/* HAS_RENAME:
 *	This symbol, if defined, indicates that the rename routine is available
 *	to rename files.  Otherwise you should do the unlink(), link(), unlink()
 *	trick.
 */
#$d_rename HAS_RENAME	/* NC */

/* HAS_RMDIR:
 *	This symbol, if defined, indicates that the rmdir routine is
 *	available to remove directories. Otherwise you should fork off a
 *	new process to exec /bin/rmdir.
 */
#$d_rmdir HAS_RMDIR		/* NC */

/* HAS_GETRUSAGE:
 *	This symbol, if defined, indicates that the getrusage() routine is
 *	available to get process statistics with a sub-second accuracy.
 *	Inclusion of <sys/resource.h> and <sys/time.h> may be necessary.
 */
#$d_rusage HAS_GETRUSAGE		/* NC */

/* HAS_SBRK:
 *	This symbol, if defined, indicates that the sbrk system call is
 *	available to add/relase core. Always true on Unix.
 */
#$d_sbrk HAS_SBRK	/* NC */

/* HAS_SIGALTSTACK:
 *	This symbol, if defined, indicates that the sigaltstack() routine is
 *	available to set an alternative call stack. Otherwise it means that
 *  a stack overflow will not be correctly handled.
 */
#$d_sigaltstack HAS_SIGALTSTACK		/* NC */

/* HAS_SYS_SIGLIST:
 *	This symbol, if defined, indicates that the sys_siglist array is
 *	available to translate signal numbers to strings.
 */
#$d_siglist HAS_SYS_SIGLIST		/* NC */

/* HAS_SIGSETMASK:
 *	This symbol, if defined, indicates that the sigsetmask() routine is
 *	available to set current signal mask. Otherwise, you should probably
 *	emulate this by using signal(), but fear race conditions...
 */
#$d_sigsetmk HAS_SIGSETMASK		/* NC */

/* HAS_SIGVEC:
 *	This symbol, if defined, indicates that BSD reliable signals are
 *	supported.
 */
#$d_sigvec HAS_SIGVEC	/* NC */

/* HAS_SIGVECTOR:
 *	This symbol, if defined, indicates that the sigvec() routine is called
 *	sigvector() instead, and that sigspace() is provided instead of
 *	sigstack().  This is probably only true for HP-UX.
 */
#$d_sigvectr HAS_SIGVECTOR	/* NC */

/* HAS_STRERROR:
 *	This symbol, if defined, indicates that the strerror routine is
 *	available to translate error numbers to strings. See the writeup
 *	of Strerror() in this file before you try to define your own.
 */
#$d_strerror HAS_STRERROR		/* NC */

/* HAS_SYS_ERRLIST:
 *	This symbol, if defined, indicates that the sys_errlist array is
 *	available to translate error numbers to strings. The extern int
 *	sys_nerr gives the size of that table.
 */
#$d_syserrlst HAS_SYS_ERRLIST	/* NC */

/* HAS_SYS_ERRNOLIST:
 *	This symbol, if defined, indicates that the sys_errnolist array is
 *	available to translate an errno code into its symbolic name (e.g.
 * ENOENT). The extern int sys_nerrno gives the size of that table.
 */
#$d_sysernlst HAS_SYS_ERRNOLIST	/* NC */

/* Strerror:
 *	This preprocessor symbol is defined as a macro if strerror() is
 *	not available to translate error numbers to strings but sys_errlist[]
 *	array is there.
 */
#define Strerror(e) $d_strerrm

/* HAS_TIME:
 *	This symbol, if defined, indicates that the time() routine exists.
 */
#$d_time HAS_TIME		/* NC */

/* Time_t:
 *	This symbol holds the type returned by time(). It can be long,
 *	or time_t on BSD sites (in which case <sys/types.h> should be
 *	included).
 */
#define Time_t $timetype		/* Time type */

/* HAS_TIMES:
 *	This symbol, if defined, indicates that the times() routine exists.
 *	Note that this became obsolete on some systems (SUNOS), which now
 * use getrusage(). It may be necessary to include <sys/times.h>.
 */
#$d_times HAS_TIMES		/* NC */

/* HAS_USLEEP:
 *	This symbol, if defined, indicates that the usleep routine is
 *	available to let the process sleep on a sub-second accuracy.
 */
#$d_usleep HAS_USLEEP		/* NC */

/* HAS_NANOSLEEP:
 *	This symbol, if defined, indicates that the nanosleep routine is
 *	available to let the process sleep on a sub-second accuracy.
 */
#$d_nanosleep HAS_NANOSLEEP		/* NC */

/* Signal_t:
 *	This symbol's value is either "void" or "int", corresponding to the
 *	appropriate return type of a signal handler.  Thus, you can declare
 *	a signal handler using "Signal_t (*handler)()", and define the
 *	handler using "Signal_t handler(sig)".
 */
#define Signal_t $signal_t	/* Signal handler's return type */

/* I_DIRENT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <dirent.h>. Using this symbol also triggers the definition
 *	of the Direntry_t define which ends up being 'struct dirent' or
 *	'struct direct' depending on the availability of <dirent.h>.
 */
#$i_dirent I_DIRENT		/* NC */

/* DIRNAMLEN:
 *	This symbol, if defined, indicates to the C program that the length
 *	of directory entry names is provided by a d_namlen field.  Otherwise
 *	you need to do strlen() on the d_name field.
 */
#$d_dirnamlen DIRNAMLEN	/* NC */

/* I_FCNTL:
 *	This manifest constant tells the C program to include <fcntl.h>.
 */
#$i_fcntl I_FCNTL	/* NC */

/* I_GRP:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <grp.h>.
 */
#$i_grp I_GRP		/* NC */

/* I_LIMITS:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <limits.h> to get definition of symbols like WORD_BIT or
 *	LONG_MAX, i.e. machine dependant limitations.
 */
#$i_limits I_LIMITS		/* NC */

/* I_NETINET_IN:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <netinet/in.h>. Otherwise, you may try <sys/in.h>.
 */
#$i_niin I_NETINET_IN	/* NC */

/* I_SYS_IN:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/in.h> instead of <netinet/in.h>.
 */
#$i_sysin I_SYS_IN		/* NC */

/* I_PWD:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <pwd.h>.
 */
#$i_pwd I_PWD		/* NC */

/* I_SYS_DIR:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/dir.h>.
 */
#$i_sysdir I_SYS_DIR		/* NC */

/* I_SYS_FILE:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/file.h> to get definition of R_OK and friends.
 */
#$i_sysfile I_SYS_FILE		/* NC */

/* I_SYS_NDIR:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/ndir.h>.
 */
#$i_sysndir I_SYS_NDIR	/* NC */

/* I_SYS_RESOURCE:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/resource.h>.
 */
#$i_sysresrc I_SYS_RESOURCE		/* NC */

/* I_SYS_SOCKET:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/socket.h> before performing socket calls.
 */
#$i_syssock I_SYS_SOCKET		/* NC */

/* I_SYS_TIMEB:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/timeb.h>, in order to define struct timeb (some systems
 *	define this in <sys/time.h>). This is useful when using ftime().
 *	You should include <sys/time.h> if I_SYS_TIMEB is not defined,
 *	nor is I_SYS_TIME.
 */
#$i_systimeb I_SYS_TIMEB		/* NC */

/* I_SYS_TIMES:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/times.h>.
 */
#$i_systimes	I_SYS_TIMES		/* NC */

/* I_SYS_UN:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/un.h> to get UNIX domain socket definitions.
 */
#$i_sysun I_SYS_UN		/* NC */

/* I_TIME:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <time.h>.
 */
#$i_time I_TIME		/* NC */

/* I_SYS_TIME:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/time.h>.
 */
#$i_systime I_SYS_TIME		/* NC */

/* I_SYS_TIME_KERNEL:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/time.h> with KERNEL defined.
 */
#$i_systimek I_SYS_TIME_KERNEL		/* NC */

/* I_UTIME:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <utime.h>.
 */
#$i_utime I_UTIME		/* NC */

/* I_SYSUTIME:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/utime.h>.
 */
#$i_sysutime I_SYSUTIME		/* NC */

/* I_STDARG:
 *	This symbol, if defined, indicates that <stdarg.h> exists and should
 *	be included.
 */
#$i_stdarg I_STDARG		/* NC */

/* I_VARARGS:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <varargs.h>.
 */
#$i_varargs I_VARARGS	/* NC */

/* INTSIZE:
 *	This symbol contains the size of an int, so that the C preprocessor
 *	can make decisions based on it.
 */
#define INTSIZE $intsize		/* NC */

/* Malloc_t:
 *	This symbol is the type of pointer returned by malloc and realloc.
 */
#define Malloc_t $malloctype			/* NC */

/* Pid_t:
 *	This symbol holds the type used to declare process ids in the kernel.
 *	It can be int, uint, pid_t, etc... It may be necessary to include
 *	<sys/types.h> to get any typedef'ed information.
 */
#define Pid_t $pidtype		/* PID type */

/* CAN_PROTOTYPE:
 *	If defined, this macro indicates that the C compiler can handle
 *	function prototypes.
 */
#$prototype	CAN_PROTOTYPE	/* NC */

/* _:
 *	This macro is used to declare function parameters for folks who want
 *	to make declarations with prototypes using a different style than
 *	the above macros.  Use double parentheses.  For example:
 *
 *		int main _((int argc, char *argv[]));
 */
#ifdef CAN_PROTOTYPE
#define	_(args) args
#else
#define	_(args) ()
#endif

/* HAS_SMART_SBRK:
 *	This symbol is defined when the sbrk() system call may be used with
 *	a negative argument to lower the break value, therefore releasing
 *	core to the system. If not, you'd probably be better off using the
 *	mmap() system call.
 */
#$d_sbrksmart HAS_SMART_SBRK /* NC */

/* Select_fd_set_t:
 *	This symbol holds the type used for the 2nd, 3rd, and 4th
 *	arguments to select.  Usually, this is 'fd_set *', if HAS_FD_SET
 *	is defined, and 'int *' otherwise.  This is only useful if you
 *	have select(), of course.
 */
#define Select_fd_set_t 	$selecttype	/* NC */

/* CAN_KEEPALIVE:
 *	This symbol if defined indicates to the C program that the SO_KEEPALIVE
 *	option of setsockopt() will work as advertised in the manual.
 */
#$d_keepalive CAN_KEEPALIVE		/* NC */

/* Uid_t:
 *	This symbol holds the type used to declare user ids in the kernel.
 *	It can be int, ushort, uid_t, etc... It may be necessary to include
 *	<sys/types.h> to get any typedef'ed information.
 */
#define Uid_t $uidtype		/* UID type */

/* VOIDFLAGS:
 *	This symbol indicates how much support of the void type is given by this
 *	compiler.  What various bits mean:
 *
 *	    1 = supports declaration of void
 *	    2 = supports arrays of pointers to functions returning void
 *	    4 = supports comparisons between pointers to void functions and
 *		    addresses of void functions
 *	    8 = suports declaration of generic void pointers
 *
 *	The package designer should define VOIDUSED to indicate the requirements
 *	of the package.  This can be done either by #defining VOIDUSED before
 *	including eif_config.h, or by defining defvoidused in Myinit.U.  If the
 *	latter approach is taken, only those flags will be tested.  If the
 *	level of void support necessary is not present, defines void to int.
 */
#ifndef VOIDUSED
#define VOIDUSED $defvoidused
#endif
#define VOIDFLAGS $voidflags
#if (VOIDFLAGS & VOIDUSED) != VOIDUSED
#define void int		/* is void to be avoided? */
#define M_VOID			/* Xenix strikes again */
#endif

/* USE_ADD_LOG:
 *	This symbol is defined if the run time logging is enabled, mainly for
 *	debugging purposes (although the logging level may be set to a low level
 *	to leave only critical error messages). This will never be defined by
 *	default.
 */
#$add_log USE_ADD_LOG		/* Allow logging */
#define LOGGING_LEVEL	9	/* Logging level */

/* HAS_SMART_MMAP:
 *	This symbol, if defined, indicates to the C program that it can
 *	use mmap and munmap for shared memory.
 */
#$d_smartmmap HAS_SMART_MMAP	/* NC */

/* HAS_GETPWUID:
 *	This symbol, if defined, indicates that the getpwuid system call is
 *	available
 */
#$d_getpwuid HAS_GETPWUID	/* NC */

/* HAS_GETGRGID:
 *	This symbol, if defined, indicates that the getgrgid system call is
 *	available
 */
#$d_getgrgid HAS_GETGRGID	/* NC */

/* HAS_GETEUID:
 *	This symbol, if defined, indicates that the geteuid system call is
 *	available
 */
#$d_geteuid HAS_GETEUID	/* NC */

/* HAS_UNLINK:
 *	This symbol, if defined, indicates that the unlink routine is
 *	available.
 */
#$d_unlink HAS_UNLINK	/* NC */

/* HAS_UTIME:
 *	This symbol, if defined, indicates that the utime routine is
 *	available.
 */
#$d_utime HAS_UTIME	/* NC */

/* I_FD_SET_SYS_SELECT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/select.h> in order to get definition of struct fd_set.
 */
#$i_fd_setsyss I_FD_SET_SYS_SELECT	/* NC */

/* I_TMVAL_SYS_SELECT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/select.h> in order to get definition of struct timeval.
 *.I_SYS_SELECT is not set correctly in the dist3.0 p22
 * This unit overrides the default one. It checks the content of
 * the include file <sys/select.h> to find the definition of timeval
 */
#$i_tmvlsyss I_TMVAL_SYS_SELECT	/* NC */

/* MAY_PANIC:
 *	This symbol is defined if the run-time is to be compiled with extra
 *	consistency checks. Those checks make sure some "impossible" conditions
 *	never occur, and they raise a panic if they do. Typical checks include
 *	free-list consistency check, stack overflow or underflow, etc...
 */
#$d_maypanic MAY_PANIC	/* Extra run-time consistency checks */

/* USE_BSD_SIGNALS:
 * On some Unix, we need to define _BSD_SIGNALS (e.g IRIX*)
 */

#$d_bsdsig USE_BSD_SIGNALS	/* NC */

/* USE_TLS:
 *	This symbol, if defined, indicates that thread-local storage specifier
 *	can be used to access thread-local variables.
 */
#$d_tls USE_TLS	/* NC */

/* INTEGER_64 display format:
 * 	This symbol is used in printf and others to display 64 bits signed
 *	integers.
 */
$inttypes_include
#define EIF_INTEGER_64_DISPLAY $eif_integer_64_display
#define EIF_NATURAL_64_DISPLAY $eif_natural_64_display
#define EIF_POINTER_DISPLAY $eif_pointer_display

/* Does current platform support conversion from uin64 to floating point? */
#$d_uint64_to_real	HAS_BUILTIN_CONVERSION_FROM_UINT64_TO_FLOATING_POINT	/* NC */

/* INTEGER_64 constant definition: */
#ifndef RTI64C
#define RTI64C(x)	$eif_integer_64_constant
#endif
#ifndef RTU64C
#define RTU64C(x)	$eif_natural_64_constant
#endif

/* Define EIF_OS Constants */

#define EIF_OS_WINNT 	1
#define EIF_OS_LINUX 	2
#define EIF_OS_SUNOS	3
#define EIF_OS_DARWIN 	4
#define EIF_OS_ALPHA 	5
#define EIF_OS_FREEBSD 	6
#define EIF_OS_HPUX 	7
#define EIF_OS_IRIX 	8
#define EIF_OS_OPENBSD 	9
#define EIF_OS_UNICOS 	10
#define EIF_OS_VXWORKS	11
#define EIF_OS_VMS	12
#define EIF_OS_HAIKU	13

/* Define EIF_OS value */
#define EIF_OS $eif_os

/* Define EIF_ARCH Constants */

#define EIF_ARCH_X86 	1
#define EIF_ARCH_X86_64 	2
#define EIF_ARCH_SPARC 	3
#define EIF_ARCH_SPARC_64 	4
#define EIF_ARCH_PPC		5
#define EIF_ARCH_PPC_64	6
#define EIF_ARCH_C90		7
#define EIF_ARCH_T3D		8
#define EIF_ARCH_HPPA	9
#define EIF_ARCH_MIPS	10
#define EIF_ARCH_MIPS_64	11

/* Define EIF_ARCH value */
#define EIF_ARCH $eif_arch

/* Is windows platform? */
#$eif_windows EIF_WINDOWS	/* NC */

/* Is SGI platform? */
#$eif_sgi	EIF_SGI		/* NC */

/* Is Solaris platform? */
#$eif_solaris	EIF_SOLARIS		/* NC */

/* Is 64 bits platform? */
#$eif_64_bits	EIF_64_BITS		/* NC */

#endif
!GROK!THIS!
