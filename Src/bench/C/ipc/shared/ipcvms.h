#ifndef _IPCVMS_H
#define _IPCVMS_H   1

/*	Public definitions file for IPC/VMS facility  */

#if defined(__VMS)	/* these definitions only intended for OpenVMS */

/* must be included before unixio.h or processes.h */


#ifdef moose	/* pre DECC V5 */
/* #include <time.h>	*/	/* for ftime() */

/*  From Ultrix's time.h */
struct timeval {
    long tv_sec;	/* seconds */
    long tv_usec;	/* microseconds */
};
#else
#include <sys/socket.h>
#include <sys/time.h>
#endif

#ifdef dont_do_this_anymore	/* the future is here! */
/* abstracts EWB wakeup mechanism. In future, it will be nugatory. */
#define IPCVMS_WAKE_EWB(strm)	ipcvms_wake_ewb(strm)
void ipcvms_wake_ewb(int strm);
#else
#define IPCVMS_WAKE_EWB		/* nugatory */
#endif

/* putenv now handled in portable.h, C/run-time/misc.c
#define putenv ipcvms_putenv 
int ipcvms_putenv(char *); 
*/
int ipcvms_spawn(char *cmd, int async);

/* define macros for ipcvms_ jacket routines with fixed arglist */
#define  close ipcvms_close
#define  dup   ipcvms_dup
#define  dup2  ipcvms_dup2
#define  read  ipcvms_read
#define  write ipcvms_write
#define  select ipcvms_select
/* define macros for ipcvms_ jacket routines with variable arglist */
#define  pipe  ipcvms_pipe
#define  fdopen ipcvms_fdopen
/* #define  open  ipcvms_open */


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
   manifest constants used by the unix i/o routines. Unfortunately,
   Eiffel also has a file of the same name, which will usually
   supersede it. So, we hereinafter define those constants if they
   haven't been defined already.
*/
#include file		/* VMS-specific include-from-text-library form */
#ifndef O_RDONLY	/* if it didn't work... */
# define O_RDONLY	000
# define O_WRONLY	001
# define O_RDWR		002
# define O_NDELAY	004
#endif

#ifndef NOFILE
#define NOFILE 64	/* max number of file descriptors per process */
#endif

int ipcvms_pipe(int fd[2], ...);
int ipcvms_select(int nfds, Select_fd_set_t rd, Select_fd_set_t wrt, Select_fd_set_t excp, struct timeval *tm);


/* Secondary functions */

/* change current synchronicity mode (sync/async) */
/* int ipcvms_setmode(int fd, int newmode); */


/* Misc. utility functions - VMS abstractions. (Maybe this isn't the	*/
/* best place for these, but I don't know where else to put them.	*/
char* ipcvms_get_progname(char* buf) ;
int ipcvms_read_avail(int fd) ;

void ipcvms_free_fd_efn(int fd) ;
int ipcvms_get_fd_efn(int fd, int flag) ;

#include "bitmask.h"	/* defines fd_mask and FD_ macros */

#endif /* __VMS */
#endif /* _IPCVMS_H_ */
