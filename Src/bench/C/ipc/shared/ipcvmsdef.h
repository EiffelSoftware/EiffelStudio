#ifndef _ipcvmsdef_h_
#define _ipcvmsdef_h_

#if defined(__vms)

/*  Private definitions file for special IPC/VMS facility  */

#ifndef DEBUG	/* if not already defined */
#define DEBUG	/* force debug for now */
#define DEBUG	/* this one generates a warning */
#endif

#define WRITE_ASYNC 1	/* 1 = always, 2 = if O_NDELAY in pipe() call */


#include <assert.h>
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifndef USE_VARARGS	/* default = USE_STDARG */
#define USE_STDARG
#endif
#ifdef USE_STDARG
#include <stdarg.h>
#define VA_START(ap, start)  va_start(ap, start)
#else
#include <varargs.h>
#define VA_START(ap, start)  va_start(ap)
#endif

#include "ipcvms.h"	    /* sys public definitions */

/* These are probably included by ipcvms.h, but what the hey... */
#include <processes.h>	    /* pipe, exec, vfork... */
#include <unixio.h>	    /* open, close, read, write, dup, ... */
#include <file.h>	    /* O_RDWR, O_NDELAY, ... */

#define CONST const
typedef int FD;

/* int ipcvms_pipe(int fd[2], ...); */



#endif /* __vms */
#endif /* _ipcvmsdef_h_ */
