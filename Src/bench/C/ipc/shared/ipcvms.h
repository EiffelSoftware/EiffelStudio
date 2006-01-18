/*
	description: "VMS specific routines."
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

#ifndef _IPCVMS_H
#define _IPCVMS_H   1

/*	Public definitions file for IPC/VMS facility  */
/*	$Id$	*/

#if defined(__VMS)	/* these definitions only intended for OpenVMS */


#ifdef moose	/* pre DECC V5 */
#include <time.h>	/* for ftime() */
/*  From Ultrix's time.h */
struct timeval {
    long tv_sec;	/* seconds */
    long tv_usec;	/* microseconds */
};
#else
#include <sys/time.h>
#endif /* pre DECC V5 */


/* Eiffel Runtime Support VMS Utility Routines */
void ipcvms_cleanup_fd (fd_set* maskp, int max_fd) ;
#ifdef dont_do_this_anymore	/* the future is here! */
/* abstracts EWB wakeup mechanism. In future, it will be nugatory. */
#define IPCVMS_WAKE_EWB(strm)	ipcvms_wake_ewb(strm)
void ipcvms_wake_ewb(int strm) ;
#else
#define IPCVMS_WAKE_EWB		/* nugatory */
#endif


#ifdef USE_VMS_JACKETS
/* undefine macros for IPCVMS_ jacket routines that have VMS Porting library jackets. */
#undef fcntl
#undef write
#undef select
#endif /* USE_VMS_JACKETS */
/* define macros for IPCVMS_ jacket routines with fixed arglist */
#define  close IPCVMS_CLOSE_JACKET
#define  dup   IPCVMS_DUP_JACKET
#define  dup2  IPCVMS_DUP2_JACKET
#define  fcntl IPCVMS_FCNTL_JACKET
#define  read  IPCVMS_READ_JACKET
#define  write IPCVMS_WRITE_JACKET
#define  select IPCVMS_SELECT_JACKET
/* define macros for IPCVMS_ jacket routines with variable arglist */
#define  pipe  IPCVMS_PIPE_JACKET
/* #define  fdopen IPCVMS_FDOPEN_JACKET */
/* #define  open  IPCVMS_OPEN_JACKET */

int IPCVMS_CLOSE_JACKET (int fd) ;
int IPCVMS_DUP_JACKET (int fd) ;
int IPCVMS_DUP2_JACKET (int fd, int fd2) ;
int IPCVMS_FCNTL_JACKET (int fd, int cmd, ...) ;
int IPCVMS_READ_JACKET (int fd, void* buf, size_t nbytes) ;
int IPCVMS_WRITE_JACKET (int fd, const void* buf, size_t nbytes) ;
int IPCVMS_PIPE_JACKET (int fd[2], ...) ;
int IPCVMS_SELECT_JACKET (int nfds, fd_set* rd, fd_set* wrt, fd_set* excp, struct timeval*) ;

/* define interfaces (if not already defined) */
#include <stdio.h>	    /* BUFSIZ et. al. */
#include <processes.h>	    /* pipe, exec, vfork... */
#include <unixio.h>	    /* open, close, read, write, dup, ... */
#include <file.h>	    /* O_RDWR, O_NDELAY, ... */
/*#define cma$tis_errno_get_addr CMA$TIS_ERRNO_GET_ADDR */
/*#define cma$tis_vmserrno_get_addr CMA$TIS_VMSERRNO_GET_ADDR */
/*#include <errno.h> */

/* 
   DECC supplies a header definition file (file.h) to define the
   manifest constants used by the unix i/o routines. Eiffel formerly
   had a file of the same name, which would supersede the DECC file. 
   So, we hereinafter define those constants if they are not defined.
*/
#include file		/* VMS DECC-specific include-from-text-library form */
#ifndef O_RDONLY	/* if it didn't work... */
# define O_RDONLY	000
# define O_WRONLY	001
# define O_RDWR		002
# define O_NDELAY	004
#endif

//#ifndef NOFILE
//#define NOFILE 64	/* max number of file descriptors per process */
//#endif

/* special fcntl cmd to dump known fd's */
//#define F_FDDUMP 9876                       

/*** prototypes for IPCVMS_ jacket functions ***/
int IPCVMS_CLOSE (int fd) ;
int IPCVMS_DUP (int fd) ;
int IPCVMS_DUP2 (int fd1, int fd2) ;
int IPCVMS_FCNTL (int fd, int cmd, ...) ;
int IPCVMS_READ  (int fd, void* buf, size_t nbytes) ;
int IPCVMS_WRITE (int fd, const void* buf, size_t nbytes) ;
int IPCVMS_SELECT(int nfds, Select_fd_set_t rd, Select_fd_set_t wrt, Select_fd_set_t excp, struct timeval *tm);
int IPCVMS_PIPE  (int fd[2], ...) ;
FILE* IPCVMS_FDOPEN (int fd, const char* a_mode, ...) ;


/*** Secondary functions ***/

/* generate dump of open file descriptors to log file (for debugging) */
void ipcvms_fd_dump (const char* fmt, ...) ;

/* change current synchronicity mode (sync/async) */
/* int ipcvms_setmode(int fd, int newmode); */


/* Misc. utility functions - VMS abstractions. (Maybe this isn't the	*/
/* best place for these, but I don't know where else to put them.	*/
int ipcvms_read_avail(int fd) ;

void ipcvms_free_fd_efn (int fd) ;
int ipcvms_get_fd_efn (int fd, int flag) ;

#include "bitmask.h"	/* defines fd_mask and FD_ macros */

#endif /* __VMS */
#endif /* _IPCVMS_H_ */
