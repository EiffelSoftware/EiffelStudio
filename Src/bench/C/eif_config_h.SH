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
 * This file was produced by running the config_h.SH script, which
 * gets its values from config.sh, which is generally produced by
 * running Configure.
 *
 * Feel free to modify any of this as the need arises.  Note, however,
 * that running config_h.SH again will wipe out any changes you've made.
 * For a more permanent change edit config.sh and rerun config_h.SH.
 *
 * \$Id$
 */

/* Configuration time: $cf_time
 * Configured by: $cf_by
 * Target system: $myuname
 */

#ifndef _config_h_
#define _config_h_

/* VMS:
 *	This symbol, if defined, indicates that the program is running under
 *	VMS.  It is currently only set in conjunction with the EUNICE symbol.
 */
/* BSD:
 *	This symbol, if defined, indicates that the program is running under
 *	a BSD system.
 */
#$d_eunice VMS		/* NC */
#$d_bsd BSD		/* NC */

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
#define CAT4(a,b,c,d)a/* NC */b/* NC */c/* NC */d
#define CAT5(a,b,c,d,e)a/* NC */b/* NC */c/* NC */d/* NC */e
#define STRINGIFY(a)"a"
		/* If you can get stringification with catify, tell me how! */
#endif
#if $cpp_stuff == 42
#define CAT2(a,b)a ## b
#define CAT3(a,b,c)a ## b ## c
#define CAT4(a,b,c,d)a ## b ## c ## d
#define CAT5(a,b,c,d,e)a ## b ## c ## d ## e
#define StGiFy(a)# a
#define STRINGIFY(a)StGiFy(a)
#define SCAT2(a,b)StGiFy(a) StGiFy(b)
#define SCAT3(a,b,c)StGiFy(a) StGiFy(b) StGiFy(c)
#define SCAT4(a,b,c,d)StGiFy(a) StGiFy(b) StGiFy(c) StGiFy(d)
#define SCAT5(a,b,c,d,e)StGiFy(a) StGiFy(b) StGiFy(c) StGiFy(d) StGiFy(e)
#endif
#ifndef CAT2
#include "Bletch: How does this C preprocessor catenate tokens?"
#endif

/* VAL_NOFILE:
 *	This symbol contains the number of file descriptors available to the
 *	process, as determined at configuration time. Unless a static constant
 *	is needed, you should rely on getdtablesize() to obtain that number.
 */
#define VAL_NOFILE $nofile	/* Number of file descriptors */

/* HAS_BCMP:
 *	This symbol is defined if the bcmp() routine is available to
 *	compare blocks of memory.
 */
#$d_bcmp HAS_BCMP	/* NC */

/* HAS_BCOPY:
 *	This symbol is defined if the bcopy() routine is available to
 *	copy blocks of memory.
 */
#$d_bcopy HAS_BCOPY	/* NC */

/* USE_BSDJMP:
 *	This symbol, if defined, indicates that the BSD _setjmp and _longjmp
 *	routines are available to do non-local gotos wihtout saving or restoring
 *	the signal mask flag.
 */
#$d_bsdjmp USE_BSDJMP		/* NC */

/* HAS_BZERO:
 *	This symbol is defined if the bzero() routine is available to
 *	set a memory block to 0.
 */
#$d_bzero HAS_BZERO	/* NC */

/* HAS_CHOWN:
 *	This symbol, if defined, indicates that the chown routine is
 *	available.
 */
#$d_chown HAS_CHOWN		/* NC */

/* HAS_DLOPEN:
 *	This symbol, if defined, indicates that the dlopen routine is
 *	available.
 */
#$d_dlopen HAS_DLOPEN		/* NC */

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
/* HAS_GETTIMEOFDAY:
 *	This symbol, if defined, indicates that the gettimeofday() system
 *	call is available for a sub-second accuracy clock. Usually, the file
 *	<sys/resource.h> needs to be included (see I_SYS_RESOURCE).
 *	The type "Timeval" should be used to refer to "struct timeval".
 */
#$d_ftime HAS_FTIME		/* NC */
#$d_gettimeod HAS_GETTIMEOFDAY	/* NC */
#ifdef HAS_FTIME
#define Timeval struct timeb		/* Structure used by ftime() */
#endif
#ifdef HAS_GETTIMEOFDAY
#define Timeval struct timeval	/* Structure used by gettimeofday() */
#endif

/* HAS_GETGROUPS:
 *	This symbol, if defined, indicates that the getgroups() routine is
 *	available to get the list of process groups.  If unavailable, multiple
 *	groups are probably not supported.
 */
#$d_getgrps HAS_GETGROUPS		/* NC */

/* HAS_GETHOSTID:
 *	This symbol, if defined, indicates that the gethostid system call is
 *	available to get the host id.
 */
#$d_gethid HAS_GETHOSTID		/* NC */

/* HAS_GETHOSTNAME:
 *	This symbol, if defined, indicates that the C program may use the
 *	gethostname() routine to derive the host name.  See also HAS_UNAME
 *	and PHOSTNAME.
 */
/* HAS_UNAME:
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
#$d_gethname HAS_GETHOSTNAME	/* NC */
#$d_uname HAS_UNAME		/* NC */
#$d_phostname PHOSTNAME "$aphostname"	/* How to get the host name */

/* HAS_GETOPT:
 *	This symbol, if defined, indicates that the getopt() routine exists.
 */
#$d_getopt HAS_GETOPT		/* NC */

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

/* HAS_MEMMOVE:
 *	This symbol, if defined, indicates that the memmove routine is available
 *	to copy potentially overlapping blocks of memory. This should be used
 *	only when HAS_SAFE_BCOPY is not defined. If neither is there, roll your
 *	own version.
 */
#$d_memmove HAS_MEMMOVE	/* NC */

/* HAS_MKDIR:
 *	This symbol, if defined, indicates that the mkdir routine is available
 *	to create directories.  Otherwise you should fork off a new process to
 *	exec /bin/mkdir.
 */
#$d_mkdir HAS_MKDIR		/* NC */

/* HAS_MKTIME:
 *	This symbol, if defined, indicates that the mktime routine is
 *	available.
 */
#$d_mktime HAS_MKTIME		/* NC */

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

/* HAS_SAFE_BCOPY:
 *	This symbol, if defined, indicates that the bcopy routine is available
 *	to copy potentially overlapping memory blocks. Otherwise you should
 *	probably use memmove() or memcpy(). If neither is defined, roll your
 *	own version.
 */
#$d_safebcpy HAS_SAFE_BCOPY	/* NC */

/* HAS_SAFE_MEMCPY:
 *	This symbol, if defined, indicates that the memcpy routine is available
 *	to copy potentially overlapping memory blocks. Otherwise you should
 *	probably use memmove() or memcpy(). If neither is defined, roll your
 *	own version.
 */
#$d_safemcpy HAS_SAFE_MEMCPY	/* NC */

/* HAS_SBRK:
 *	This symbol, if defined, indicates that the sbrk system call is
 *	available to add/relase core. Always true on Unix.
 */
#$d_sbrk HAS_SBRK	/* NC */

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
/* HAS_SIGVECTOR:
 *	This symbol, if defined, indicates that the sigvec() routine is called
 *	sigvector() instead, and that sigspace() is provided instead of
 *	sigstack().  This is probably only true for HP-UX.
 */
#$d_sigvec HAS_SIGVEC	/* NC */
#$d_sigvectr HAS_SIGVECTOR	/* NC */

/* HAS_SOCKET:
 *	This symbol, if defined, indicates that the BSD socket interface is
 *	supported.
 */
#$d_socket HAS_SOCKET		/* NC */

/* HAS_INDEX:
 *	This symbol is defined to indicate that the index()/rindex()
 *	functions are available for string searching.
 */
#$d_index HAS_INDEX	/* NC */

/* USE_STRUCT_COPY:
 *	This symbol, if defined, indicates that this C compiler knows how
 *	to copy structures.  If undefined, you'll need to use a block copy
 *	routine of some sort instead.
 */
#$d_strctcpy	USE_STRUCT_COPY	/* NC */

/* HAS_STRDUP:
 *	This symbol, if defined, indicates that the strdup routine is
 *	available to duplicate strings in memory. Otherwise, roll up
 *	your own...
 */
#$d_strdup HAS_STRDUP		/* NC */

/* HAS_STRERROR:
 *	This symbol, if defined, indicates that the strerror routine is
 *	available to translate error numbers to strings. See the writeup
 *	of Strerror() in this file before you try to define your own.
 */
/* HAS_SYS_ERRLIST:
 *	This symbol, if defined, indicates that the sys_errlist array is
 *	available to translate error numbers to strings. The extern int
 *	sys_nerr gives the size of that table.
 */
/* HAS_SYS_ERRNOLIST:
 *	This symbol, if defined, indicates that the sys_errnolist array is
 *	available to translate an errno code into its symbolic name (e.g.
 * ENOENT). The extern int sys_nerrno gives the size of that table.
 */
/* Strerror:
 *	This preprocessor symbol is defined as a macro if strerror() is
 *	not available to translate error numbers to strings but sys_errlist[]
 *	array is there.
 */
#$d_strerror HAS_STRERROR		/* NC */
#$d_syserrlst HAS_SYS_ERRLIST	/* NC */
#$d_sysernlst HAS_SYS_ERRNOLIST	/* NC */
#define Strerror(e) $d_strerrm

/* HAS_TIME:
 *	This symbol, if defined, indicates that the time() routine exists.
 */
/* Time_t:
 *	This symbol holds the type returned by time(). It can be long,
 *	or time_t on BSD sites (in which case <sys/types.h> should be
 *	included).
 */
#$d_time HAS_TIME		/* NC */
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

/* Signal_t:
 *	This symbol's value is either "void" or "int", corresponding to the
 *	appropriate return type of a signal handler.  Thus, you can declare
 *	a signal handler using "Signal_t (*handler)()", and define the
 *	handler using "Signal_t handler(sig)".
 */
#define Signal_t $signal_t	/* Signal handler's return type */

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

/* I_DIRENT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <dirent.h>. Using this symbol also triggers the definition
 *	of the Direntry_t define which ends up being 'struct dirent' or
 *	'struct direct' depending on the availability of <dirent.h>.
 */
/* DIRNAMLEN:
 *	This symbol, if defined, indicates to the C program that the length
 *	of directory entry names is provided by a d_namlen field.  Otherwise
 *	you need to do strlen() on the d_name field.
 */
#$i_dirent I_DIRENT		/* NC */
#$d_dirnamlen DIRNAMLEN	/* NC */

/* I_DLFCN:
 *	This symbol, if defined, indicates that <dlfcn.h> exists and should
 *	be included.
 */
#$i_dlfcn I_DLFCN		/* NC */

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

/* I_MEMORY:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <memory.h> for using memset. Otherwise, you may try <string.h>.
 */
/*#$i_memory I_MEMORY */

/* I_NETINET_IN:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <netinet/in.h>. Otherwise, you may try <sys/in.h>.
 */
/* I_SYS_IN:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/in.h> instead of <netinet/in.h>.
 */
#$i_niin I_NETINET_IN	/* NC */
#$i_sysin I_SYS_IN		/* NC */

/* I_PWD:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <pwd.h>.
 */
#$i_pwd I_PWD		/* NC */

/* I_STRING:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <string.h> (USG systems) instead of <strings.h> (BSD systems).
 */
#$i_string I_STRING		/* NC */

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
/* I_SYS_TIME:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/time.h>.
 */
/* I_SYS_TIME_KERNEL:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/time.h> with KERNEL defined.
 */
#$i_time I_TIME		/* NC */
#$i_systime I_SYS_TIME		/* NC */
#$i_systimek I_SYS_TIME_KERNEL		/* NC */

/* I_UTIME:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <utime.h>.
 */
#$i_utime I_UTIME		/* NC */

/* I_STDARG:
 *	This symbol, if defined, indicates that <stdarg.h> exists and should
 *	be included.
 */
/* I_VARARGS:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <varargs.h>.
 */
#$i_stdarg I_STDARG		/* NC */
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
/* _:
 *	This macro is used to declare function parameters for folks who want
 *	to make declarations with prototypes using a different style than
 *	the above macros.  Use double parentheses.  For example:
 *
 *		int main _((int argc, char *argv[]));
 */
#$prototype	CAN_PROTOTYPE	/* NC */
#ifdef CAN_PROTOTYPE
#define	_(args) args
#else
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
#define register1 $reg1		/* NC */
#define register2 $reg2		/* NC */
#define register3 $reg3		/* NC */
#define register4 $reg4		/* NC */
#define register5 $reg5		/* NC */
#define register6 $reg6		/* NC */
#define register7 $reg7		/* NC */

/* HAS_SMART_SBRK:
 *	This symbol is defined when the sbrk() system call may be used with
 *	a negative argument to lower the break value, therefore releasing
 *	core to the system. If not, you'd probably be better off using the
 *	mmap() system call.
 */
#$sbrksmart HAS_SMART_SBRK /* NC */

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
/* HAS_GETGRGID:
 *	This symbol, if defined, indicates that the getgrgid system call is
 *	available
 */
/* HAS_GETEUID:
 *	This symbol, if defined, indicates that the geteuid system call is
 *	available
 */
#$d_getpwuid HAS_GETPWUID	/* NC */

#$d_getgrgid HAS_GETGRGID	/* NC */

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

/* I_DIRECT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <direct.h>.
 * This is a pseudo unit for the Watcom C compiler (DOS)
 */
#$i_direct I_DIRECT		/* NC */

/* I_FD_SET_SYS_SELECT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/select.h> in order to get definition of struct fd_set.
 */
#$i_fd_setsyss I_FD_SET_SYS_SELECT	/* NC */

/* I_NETNS_NS:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <netns/ns.h>.
 */
#$i_netns_ns I_NETNS_NS		/* NC */

/* I_TMVAL_SYS_SELECT:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <sys/select.h> in order to get definition of struct timeval.
 *.I_SYS_SELECT is not set correctly in the dist3.0 p22
 * This unit overrides the default one. It checks the content of
 * the include file <sys/select.h> to find the definition of timeval
 */
#$i_tmvlsyss I_TMVAL_SYS_SELECT	/* NC */

/* I_XM_PROTOCOLS:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <Xm/Protocols.h>.
 */
#$i_xm_protocols I_XM_PROTOCOLS		/* NC */

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

#$d_bsdsig USE_BSD_SIGNALS

/* INTEGER_64 display format:
 * 	This symbol is used in printf and others to display 64 bits signed
 *	integers.
 */
$inttypes_include
#define EIF_INTEGER_64_DISPLAY $eif_integer_64_display

#endif
!GROK!THIS!
