/* ipcvms.c */

/* 
********************************************************************************
    This module (together with ipcvms.h and ipcvmsdef.h) handles the vms
    specific issues for the inter-process communication (ipc) runtime code.
    It contains wrapper routines for the "unix system" i/o functions
    supplied in the VMS runtime library, in particular pipe, select, read, 
    and write.

-- Runtime configuration contols (logical names)
EIF_IPCVMS_LOG
    Causes all low level (read/write) pipe i/o to be logged to files named
    "IPCVMS_LOG_<programname>.LOG"

EIF_IPCVMS_LOG_STD, EIF_IPCVMS_LOG_SYS
    Causes i/o to stdin/stdout/stderr to be logged, as well as pipe i/o,
    Requires EIF_IPCVMS_LOG

EIF_IPCVMS_SPURIOUS_NEWLINE_HACK
    Causes logging of each instance of a "spurious" newline in a pipe read.
    See the code in ipcvms_read. 


-- Configuration control macros:
MY_PIPE
    Bypasses the C library pipe() function and does all the I/O directly.
    Currently disabled because forking needs to inherit open pipes, and I
    haven't written code to deal with that. Also, it seems like the 
    DECC RTL code for VMS 6.2 and later works pretty well.

SELECT_EVENT_DRIVEN
    uses new, improved, event driven code to wait for select rather 
    then old periodic polling. Now how much would you pay?

USE_NDELAY
    passes the O_NDELAY flag to pipe() to create a non-blocking pipe.
    It seems to be nugatory.

DEBUG
    guess

USE_STDARG
    uses facilities defined in <stdarg.h>, as opposed to the obsolescent
    <varargs.h>. At issue because I need the va_count macro (see below).


********************************************************************************
*/

/* #define MY_PIPE 1 */
#ifndef DEBUG	/* if not already defined */
#define DEBUG	/* force debug for now */
#define DEBUG	/* ...this one generates a compile-time warning */
#endif

#ifndef DEBUG
#define NDEBUG 1	    /* disables assert checks (for speed) */
#endif

#define USE_STDARG	/* <stdarg.h>, as opposed to the obsolescent <varargs.h> */


#include "eif_config.h"
#include "eif_portable.h"

#include <assert.h>
#include <ctype.h>
/* The DECbrains should have defined these in uppercase in <errno.h> so	*/
/* that when compiling with /name=as_is (which prevents external	*/
/* symbols from being forced to uppercase) they are correctly defined.	*/
/* #define cma$tis_errno_get_addr CMA$TIS_ERRNO_GET_ADDR
#define cma$tis_vmserrno_get_addr CMA$TIS_VMSERRNO_GET_ADDR
#include <errno.h>
*/
#include <limits.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>	    /* when pipes break, raise a signal */
#include <time.h>

#include <processes.h>	    /* pipe, exec, vfork... */
#include <unixlib.h>	    /* getpid, ... */
#include <unixio.h>	    /* open, close, read, write, dup, ... */
/* #include <file.h>	*//* O_RDWR, O_NDELAY, ... */
#include file		    /* be sure to get the VMS, not the Eiffel file.h */
#include <ints.h>

/* VMS specific definitions */
/* Oops. On VMS/VAX, the linker doesn't resolve system symbols that are	    */
/* specified in lower case when compiling with /NAME=AS_IS. Therefore, we   */
/* force them to uppercase here with the following macros. There is	    */
/* currently no solution, only this workaround. Curiously, the problem does */
/* not exist on VMS/AXP. Oh well, that's life...			    */
#define lib$format_date_time LIB$FORMAT_DATE_TIME
#define lib$get_ef LIB$GET_EF
#define lib$getjpi LIB$GETJPI
#define lib$free_ef LIB$FREE_EF
#define lib$reserve_ef LIB$RESERVE_EF
#define lib$signal LIB$SIGNAL
#define sys$assign SYS$ASSIGN
#define sys$ascefc SYS$ASCEFC
#define sys$asctim SYS$ASCTIM
#define sys$bintim SYS$BINTIM
#define sys$cantim SYS$CANTIM
#define sys$crelnm SYS$CRELNM
#define sys$crembx SYS$CREMBX
#define sys$dassgn SYS$DASSGN
#define sys$getdviw SYS$GETDVIW
#define sys$gettim SYS$GETTIM
#define sys$qio SYS$QIO
#define sys$qiow SYS$QIOW
#define sys$setef SYS$SETEF
#define sys$setimr SYS$SETIMR
#define sys$synch SYS$SYNCH
#define sys$waitfr SYS$WAITFR

#include <unixio.h>		/* unix "system" i/o functions */
#include <descrip.h>		/* descriptors */
#include <clidef.h>		/* CLI$M_ */
#include <cmbdef.h>		/* sys$crembx */
#include <iodef.h>		/* IO$ defs */
#include <agndef.h>		/* AGN$ (assign keywords) */
#include <starlet.h>		/* vms system services */
#include <dvidef.h>		/* sys$getdvi */
#include <jpidef.h>		/* sys$getjpi */
#include <lnmdef.h>		/* sys$crelnm, etc. LNM$ symbols */
#include <ssdef.h>		/* system status (SS$_) symbols */
#include <dcdef.h>		/* device class (DC$_) symbols */
#include <lib$routines.h>	/* lib$ routines (gee, that was hard) */
#include <libdtdef.h>		/* lib$format_date_time symbols */

#include "ipcvms.h"		/* public definitions */
#include "ipcvmsdef.h"		/* private definitions for ipcvms facility */
/* This must come after most all other includes (not my fault) */
/* #include "bitmask.h"		/* defines fd_mask and FD_ macros */


#if defined(__VAX) && !defined(va_count)
/* Ok ok, I know this is cheating. This macro is defined in <stdarg.h> for  */
/* VMS/AXP, but only in <varargs.h> for this version (4.0) of the DEC C	    */
/* compiler on VMS/VAX.							    */
void decc$va_count( int *__count );
#define va_count(count)		decc$va_count (&count)
#endif	/* __VAX */


/* global variables */
int ipcvms_errno;
int ipcvms_status;


#ifdef TRUE
#undef TRUE
#endif
#ifdef FALSE
#undef FALSE
#endif
#define TRUE 1
#define FALSE 0
#define SPACE ' '
#define ZERO '0'
#ifdef BOOLEAN
#undef BOOLEAN
#endif
#define BOOLEAN(expr) ( (expr) != 0 )
#define ISNULLP(p) ( (p) == NULL )
/* take care when using these, trailing semicolon is not desired */
#define RETURN_ERR(err)   { ipcvms_errno = errno = err; return -1; }
#define RETURN_VMSERR(st) { ipcvms_status = vaxc$errno = st; RETURN_ERR(EVMSERR) }

/* Macros to test for VMS-style (low bit) success/failure. */
#define  SUCCESS(x)	(   (x)&1	)
#define  FAILURE(x)	(   !((x)&1)	)
/* Macro to return the cardinality of an array (number of elements) */
#define CARD(a)	    ( sizeof(a) / sizeof((a)[0]) )
#define MIN(a,b)    ( (a) <= (b) ? (a) : (b) )
#define MAX(a,b)    ( (a) >= (b) ? (a) : (b) )

/* allocate/copy a string */
#define strnnew(s,l)	( strncpyz(malloc((l)+1), (s), (l)) )
#define strnew(s)	( strcpy(malloc(strlen(s)+1), (s)) )

#define MAX_DEVNAM  65		/* includes trailing null byte */

/* macros to help deal with bit masks */
typedef struct fd_mask FD_MASK;
#ifndef BPI
#define BPI 32	    /* bits per integer */
#endif
#define BIT_OFFSET(bit)	    ( (bit)/BPI )	/* offset in array */
#define BIT_MASK(bit)	    ( 1 << (bit) )	/* bit mask in integer */
#define BIT_TEST(mask,bit)  ( mask && ( mask[(bit)/BPI] & (1 << ((bit)%BPI)) ) )
#define BIT_CLEAR(mask,bit) ( mask[(bit)/BPI] &= ~(1 << ((bit)%BPI)) )


/* Type definitions */
/* typedef unsigned long VMS_STS;   	/* VMS status (condition) value */
#include gen64def
typedef struct _generic_64 VMS_BINTIM;	/* VMS binary time (64 bits) */
typedef unsigned short UWORD;		/* 16-bit integer for VMS system calls */
typedef unsigned long  ULONG;		/* 32-bit ditto */
typedef int bool_t;			/* boolean type */
/* typedef struct dsc$descriptor DX;	/* prototype descriptor */


/* Define some useful macros for dealing with descriptors		*/
/* (most are not portable because of aggregate initialization).		*/
#pragma message disable (NEEDCONSTEXT)	/* skip non-constant address warnings */
#pragma message disable (ADDRCONSTEXT)	/* skip non-constant address warnings */
#define DX_BUF(d,buf) DX d = { sizeof(buf), DSC$K_DTYPE_T, DSC$K_CLASS_S, (char*)&buf }
#define DX_BLD(d,ptr,len) DX d = { len, DSC$K_DTYPE_T, DSC$K_CLASS_S, (char*)ptr }
#define DX_STR(d,ptr) DX d = { strlen(ptr), DSC$K_DTYPE_T, DSC$K_CLASS_S, ptr }
#define DX_STRLIT(d,ptr) DX d = { sizeof(ptr)-1, DSC$K_DTYPE_T, DSC$K_CLASS_S, ptr }
#define DX_DYN(d) DX d = { 0, DSC$K_DTYPE_T, DSC$K_CLASS_D, 0 }
#define DX_ATOMIC(d,var,dtyp) DX d = { sizeof(var), dtyp, DSC$K_CLASS_S, &(var) }
/* access to descriptor components */
#define DXLEN(d) ( (d).dsc$w_length )
#define DXPTR(d) ( (d).dsc$a_pointer )


/* Forward References */
static VMS_STS post_attn(FD fd, int flag) ;

/* Data structure definitions */

/* generic parameter to system service */
#ifdef __ALPHA
typedef int64 SYSPARAM;
#else
typedef int SYSPARAM;
#endif

/* I/O status block */
typedef struct _iosb {
    UWORD	sts, bcnt;
    unsigned long pid;
    } IOSB;
#define NULL_IOSB   {1,0,0,}	/* success (nothing pending), no data... */

/* itemlist entry for vms system calls */
/* typedef struct itemlist3def { 
    unsigned short buflen, itemcode; 
    void *bufadr; 
    unsigned short *retlenadr; 
    } ITEMLIST3, ITEMLIST[];
#define ITEM(code,buf,siz,rlen) { siz, code, buf, rlen }
#define ITEM_A(code,buf,rlen)	ITEM(code, buf, sizeof(buf), rlen )
#define ITEM_S(code,buf,rlen)	ITEM(code, &buf, sizeof(buf), rlen )
#define ITEMLIST_END		{0,0,0,0}
*/



typedef enum {io_unk = 0, io_read=1, io_write=2, io_readwrite=3} io_mode;

/* structure for storing file descriptor (FD) information */
struct fdinfo {
	char *fdnam;
	io_mode mode;
	size_t devbufsiz;
	unsigned int xefn; 	/* event flag for ipcvms_get_fd_efn */
	UWORD xchan;		/* get_fd_efn i/o channel ditto */
	int postcnt;
	struct { unsigned
	    inited:1,
	    attn_req,		/* read/write notification was requested */
	    attn_rd,		/* ... and it's a read request		*/
	    attn_posted:1,	/* r/w attn is posted (outstanding)	*/
	    /* attn_delivered:1,   /* ... it was delivered		*/
	    :0; } flags; } ;
static struct fdinfo null_fdinfo = {NULL, 0, 0, 0,0, 0, {0,0,0,0} };

/* structure for storing pipe/mailbox info when we do the i/o (MY_PIPE)	*/
typedef struct _pcbdef {
    IOSB    iosb;		/* IOSB (status, size, pid) */
    char    *devnam;		/* mailbox device name */
    void*   rdbuf;		/* read buffer */
    void*   rdpos;		/* current position in read buffer */
    size_t  rdrem;		/* bytes remaining in read buffer */
    int	    fdrefcnt;		/* number of fds referencing this PCB */
    int	    devrefcnt;		/* vms device reference count */
    int	    maxmsg;		/* maximum message size */
    int	    modearg;		/* mode flag args in pipe() call */
    int	    partner_pid;	/* pid of guy at other end */
    UWORD   chan;
    struct { unsigned	/* dynamic flags */
	    busy:1,		/* i/o outstanding */
	    read_rdy:1,		/* ready to read (write attn occurred) */
	    wrtattn_wait:1,	/* write attention waiting (enqueued) */
	    closed:1,		/* pipe closed (by other end) */
	    async:1,
	    /* xstream:1,	/* handle as a byte stream (not	records) */
	    :0; } flags;

    } PCB;
#define NULL_PCB_FLAGS {0,0,0,0,0,} 
#define NULL_PCB {NULL_IOSB, NULL,NULL,NULL, 0,0,0,0,0,0,0, NULL_PCB_FLAGS } 

#ifdef moose
typedef struct _myiobuf {
    size_t  siz;		/* allocated size */
    size_t  len;		/* length remaining */
    char*   pos;		/* current position in buffer */
    void*   buf;		/* i/o buffer */
    } IOB;
#endif


/* MISC UTILITY ROUTINES */

/* like strncpy, but always null-terminates destination string.		*/
/* n.b. output must be [at least] one byte longer than maxsiz.		*/
static char *strncpyz(char *out, CONST char *inp, size_t maxsiz)
{
    strncpy(out, inp, maxsiz);
    out[maxsiz] = '\0';	    /* force last byte to be null, just in case */
    return(out);
} /* end strncpyz() */


/* name of program image executing. Used for messages, etc.  == argv[0] */
static long int ipcvms_pid = 0;
static char ipcvms_imagename[FILENAME_MAX];	/* full image file name */
static char ipcvms_progname[FILENAME_MAX];	/* like argv[0] - image file basename */

/* This ones fills in the name of the currently executing program - 	*/
/* basename(argv[0]) in unix terms.					*/
char* ipcvms_get_progname(char* buf)
{
    char *p;

    if (*ipcvms_progname == '\0') { /* have we not done this yet? */
	VMS_STS st; 
	char *p, *q;
	DX_BUF(imag_d, ipcvms_imagename);
	st = lib$getjpi(&JPI$_IMAGNAME, NULL,NULL, NULL, &imag_d, &DXLEN(imag_d));
	DXPTR(imag_d)[DXLEN(imag_d)] = '\0';
	/* make it lowercase, in true c/unix fasion */    
	for (p = q = ipcvms_imagename; *q; ++q)
	    if (isupper(*q))
		*q = _tolower(*q);
	/* remove the device and directory prefix */
	while (q = strpbrk(p, "]>"))	/* while there's a directory delim, */
	    p = ++q;			/*  skip past it */
	p = strcpy(ipcvms_progname, p);
	q = strstr(p, ".");		/* is there a ext delim? */
	if (q) *q = '\0';		/* if so, clobber it */
	p = strcpy(ipcvms_progname, p);
    } else p = ipcvms_progname;
    if (buf) p = strcpy(buf, p);
    return (p);
} /* end ipcvms_get_progname() */


    /* Routine for generating error messages. */

static int printerr(int err, char *fmt, ...)
{
    char outnam[FILENAME_MAX], errnam[FILENAME_MAX];
    va_list ap;
    VA_START(ap, fmt);
    fprintf(stdout, "%s error: ", ipcvms_progname);
    vfprintf(stdout, fmt, ap); 
    if (fmt[strlen(fmt)-1] != '\n')
	puts("");		/* rap, rap, wrap, ... */
    if (strcmp(getname(fileno(stdout), outnam),getname(fileno(stderr),errnam)) || ap) {
	fprintf(stderr, "%s error: ", ipcvms_progname);
	vfprintf(stderr, fmt, ap);
    }
    va_end(ap);
    return err;
} /* end printerr() */


#if defined(DEBUG) || defined(WORKBENCH) || 1==1
/* functions used solely for debugging, to provide access to errno global */
static int get_errno()
{
    static int err;
    err = (errno == EVMSERR ? vaxc$errno : errno);
    return (errno == err ? err : errno);
}

static int print_errno()
{
    int err = (errno == EVMSERR ? vaxc$errno : errno);
    int err1 = get_errno();
    printf("ipcvms_debug: err = %d : %s\n", err, strerror(errno, vaxc$errno));
    return err;
}

static void print_filnam(FD fd)
{
    static char filnam[FILENAME_MAX];
    getname(fd, filnam);
    printf(__FILE__": fd %2d = %s\n", fd, filnam);
}

#endif /* DEBUG et. al. */

/* This abstracts the EWB wakeup mechanism. In the future, it will be	*/
/* nugatory.  For now, it uses Tom's common event flag kludge.		*/
void ipcvms_wake_ewb(int s)
{
    unsigned int st;
    static int kludge_efn = 69;

#ifdef USE_ADD_LOG
    add_log(100, "Attempting to set the common kludge event flag %d",efn);
#endif
    st = sys$setef(kludge_efn);
    if (FAILURE(st)) {
#ifdef DEBUG
	printerr(EVMSERR, "ipcvms_wake_ewb: error %%x%x from sys$setef(%d)\n-- %s\n",
		st, kludge_efn, strerror(EVMSERR,st));
#endif /* DEBUG */
#ifdef USE_ADD_LOG
	add_log(1,"Unable to set common kludge event flag %d, status = %08x", 
		efn, st);
	dexit();
#endif
    }
    
} /* end ipcvms_wake_ewb() */


#ifdef moose	/* this now in C/run-time/misc.c */
/* VMS version of "putenv" (note - VMS V7 onward has a putenv; I'm not	*/
/* sure exactly what it does.  This one creates a logical name		*/
/* definition (in _user_ mode so that it doesn't outlive the running	*/
/* program. This is analogous to unix putenv, which doesn't allow a	*/
/* subprocess to modify a parent's environment.				*/
int ipcvms_putenv(char *envstring)
{
    VMS_STS st;
    char *eq;
    DX_BLD(nam_d,0,0);
    $DESCRIPTOR(tabnam_d, "LNM$PROCESS");
    ITEMLIST lnm_list = { ITEM(LNM$_STRING, NULL, 0, NULL), ITEMLIST_END };

    /* parse the argument: it should be of the form <name>=<value>	*/        
    eq = strchr(envstring, '=');
    if (!eq) return -1;			/* invalid argument */
    DXPTR(nam_d) = envstring;
    DXLEN(nam_d) = eq - envstring;
    lnm_list[0].bufadr = ++eq;
    lnm_list[0].buflen = strlen(eq);
    st = sys$crelnm(0, &tabnam_d, &nam_d, 0, &lnm_list);
    if (FAILURE(st)) {
#ifdef DEBUG
	printerr(EVMSERR, "ipcvms_putenv: error %%x%x from sys$crelnm(%s)\n-- %s",
		st, envstring, strerror(EVMSERR,st));
#endif /* DEBUG */
	return -1;
    }
    return 0;
} /* end ipcvms_putenv() */
#endif


/* ipcvms_spawn - used to issue an asynchronous "system" command.	*/
int ipcvms_spawn(char *cmd, int async)
{
    DX_STR(cmd_d, cmd);
    DX_STRLIT(inp_d,"nla0:");	    /* thats /dev/null to you */
    int flags;
    VMS_STS st;

    flags = 0;
    if (async) flags |= CLI$M_NOWAIT;
    st = lib$spawn(&cmd_d, 0,0, &flags);
#ifdef DEBUG
#endif
    if (SUCCESS(st)) return 0;
    else RETURN_VMSERR(st)

} /* end ipcvms_spawn */


/* local routine to return the file name associated with an open file	*/
/* descriptor (less the nugatory delimiters if a device name).		*/
static char* get_fdname(FD fd, char *buf)
{
    char *p;
    static char localbuf[FILENAME_MAX];
    if (!buf) buf = localbuf;
    if ( !(p = getname(fd, buf)) )	/* get file descriptor name */
	sprintf (buf, "*** invalid FD #%d ***", fd);
    else if ((p=strstr(buf, ":[].;"))	/* if device name with null dir */
	    || (p=strstr(buf, ":.;")))	/*  or a device name with no dir */
	*++p = '\0';			/*  trash delimiters after : */
    return (buf);
} /* end get_fdname() */

/* Get the current time with (millisecond precision) in string		*/
/* (printable) format. If dateflag is nonzero, date is prepended.	*/
/* Returns pointer to internal static string, in typical unix fashion.	*/
/* The date, if requested, is returned using the local language format.	*/
/* The time is always returned as hh:mm:ss.cc because local language	*/
/* time formats may eliminate the fractional second (.cc) field.	*/
static char* get_time_str(int dateflag)
{
    static char timbuf[80];
#ifdef moose /* c routines give 1-second granularity, we want finer */
    struct tm *now; time_t now_time; 
    now_time = time(NULL);		/* get current time in secs */
    now = localtime(&now_time); 	/* get current time */
    strftime(timbuf, sizeof(timbuf), "%H:%M:%S", now);
#else
    VMS_STS st;
    int nodate = 1;
    unsigned short shlen;
    DX_BUF(tim_d, timbuf);
    VMS_BINTIM timquad;
    st = sys$gettim(&timquad);		/* get current (binary) datetime */
    if (dateflag) {			/* get date in local language */
	long int llen, lflags;
	lflags = LIB$M_DATE_FIELDS;
	st = lib$format_date_time(&tim_d, &timquad, 0, &llen, &lflags);
	if (SUCCESS(st)) {
	    DXPTR(tim_d)[llen++] = ' ';
	    DXLEN(tim_d) -= llen;
	    DXPTR(tim_d) += llen; 
	} else nodate = 0;
    } else ;
    /* append the time in system format (ignore local time format) */
    st = sys$asctim(&shlen, &tim_d, &timquad, nodate);
    if (!SUCCESS(st))
	shlen = 0;
    DXPTR(tim_d)[shlen] = '\0';
#endif
    return timbuf;
} /* end get_time_str() */

/* local routine to wait for a brief time (denoted in millisecs).  The	*/
/* maximum time that can be specified is slightly over 7 minutes (the	*/
/* max number of VMS 100-nanosecond time units in a 32 bit integer).	*/
static int wait_brief(FD fd, PCB *pcb, int efn, int msecs)
{
    VMS_STS st; VMS_BINTIM timquad;
#ifdef DEBUG
    if (msecs > INT_MAX/10000) {
	fprintf(stderr, "%s: ipcvms wait_brief: illegal time (%d msecs) specified\n", 
	    ipcvms_progname, msecs);
	return msecs;
    }    
#endif
    /* convert wait time from milliseconds to quad bintim - See OpenVMS	*/
    /* Programming Concepts, ch. 5 - System Time Operations		*/
    timquad.gen64$l_longword[0] = msecs * -10000;
    timquad.gen64$l_longword[1] = -1;
    /* (can't use hibernate/wake, it interferes with the vms debugger) */
    /* use routine address as timer ident */
    st = sys$cantim((SYSPARAM)wait_brief, 0);	/* ensure timer not already enqueued */
    /* set the alarm clock */
    st = sys$setimr(efn, &timquad, 0, (SYSPARAM)wait_brief, 0);
    /* take a (really) quick snooze */
    st = sys$waitfr(efn);
} /* end wait_brief() */


static struct _fdvec { struct fdinfo _info; PCB *pcb; } ipcvms_fdvec[256];

/* functions/data to log i/o requests performed on pipe mailboxes */
static char log_file[FILENAME_MAX];
/* static char log_image[FILENAME_MAX]; */
/* static long log_pid; */

/* return the current time in printable format for the trace log. */
/* if dateflag is nonzero, date is included, else just time. */
static char* log_time(int dateflag)
{
    static char timbuf[80];
    strcpy(timbuf, get_time_str(dateflag));
    return timbuf;
}

/* local function returns TRUE if logging std FD (stdin/stdout/stderr) */
static int log_std(FD fd)
{
    char *p;
    if ( (p=getenv("EIF_IPCVMS_LOG_STD")) || (p=getenv("EIF_IPCVMS_LOG_SYS"))
	    && (*p=='1' || tolower(*p)=='t'|| tolower(*p)=='y') )
	return TRUE;
    return FALSE;
}

/* create a new logfile. Should only be called once. */
static void log_init()
{
    char *p;
    VMS_STS st; 
    static bool_t been_here_done_this;

    if (been_here_done_this)
	return;
    been_here_done_this = TRUE;
#ifdef moose
    {
	DX_BUF(image_d, log_image); 
	log_pid = 0;
	st = lib$getjpi(&JPI$_IMAGNAME, &log_pid,NULL, NULL, &image_d, &DXLEN(image_d));
	DXPTR(image_d)[DXLEN(image_d)] = '\0';
    }
#endif
    p = getenv("EIF_IPCVMS_LOG");
    if (p && *p) {
	FILE *lfp;
	struct tm *now; time_t now_time; char nowbuf[40];

	strcpy(log_file, p);
	if ((p=strchr(log_file, '*'))) {
	    strcpy(p + strlen(ipcvms_progname), p+1);
	    strncpy(p, ipcvms_progname, strlen(ipcvms_progname));
	} else
	    strcat(strcat(strcpy(log_file, "IPCVMS_"), ipcvms_progname), ".log");
	lfp = fopen(log_file, "w+");		/* create new file version */
	if (!lfp) {
	    log_file[0] = '\0';
	    return;
	}
	getname(fileno(lfp), log_file);		/* save full log file name */
	now_time = time(NULL);			/* get current time in secs */
	now = localtime(&now_time);		/* get current time */
	strftime(nowbuf, sizeof(nowbuf), "%d-%b-%y %H:%M:%S", now);
	strcpy(nowbuf, log_time(1));
	if (*nowbuf == ' ')
	    strcpy(nowbuf, nowbuf+1);
	fprintf(lfp, "-- IPCVMS trace log for  %s   -- created %s --"
		     "\n--    (%s)  --\n", 
		ipcvms_progname, nowbuf, log_file, log_file);
	if (log_std(0))
	    fputs  ("--    logging all read/write i/o (including stderr/stdout)\n", lfp);
	else fputs ("--    logging only read/write i/o to fd > 2\n", lfp);
	fclose(lfp);
    }
} /* end log_init() */

/* local function to return the device/file name for a FD */
static char* log_devnam(FD fd, PCB *pcb)
{
    if (pcb && 0)
	return (pcb->devnam);
    else if (ipcvms_fdvec[fd]._info.flags.inited && ipcvms_fdvec[fd]._info.fdnam)
	return (ipcvms_fdvec[fd]._info.fdnam);
    else return get_fdname(fd, NULL);
}


/* We need to handle the case where do_log_file is called to open the	*/
/* log file when it is already open. This can happen when an exception	*/
/* occurs that causes... */

static FILE* do_log_file(FD fd)
{
    static FILE *fh, *prev;

    if (*log_file && (fd > 2 || log_std(fd))) {
	prev = fh;
	fh = fopen(log_file, "a");
	if (!fh) {
log_debug:
	    fprintf(stderr, "%s: ipcvms_log: failure opening log file %s: error %d"
	    "\n-- %s\n", ipcvms_progname, log_file, errno, strerror(errno));
	    fh = fopen(log_file, "a");	    /* try again */
	}
	return (fh);
    }
    else return NULL;
}

static void do_log_entry(FD fd, char *ent, ...)
{
    FILE *lfp = do_log_file(fd);
    va_list ap;
    if (lfp) {
	VA_START(ap, ent);
	if (ent)
	    vfprintf(lfp, ent, ap);
	else fputs("?", lfp);
	fclose(lfp);
	va_end(ap);
    }
} /* end do_log_entry() */

static void do_log_oper(FD fd, PCB *pcb, int err, char *fmt, ...)
{
    FILE *lfp = do_log_file(fd);
    va_list ap;
    if (lfp) {
	char buf[1024];
	VA_START(ap, fmt);
	if (fmt)
	    vsprintf(buf, fmt, ap);
	else strcpy(buf, "?");
	fprintf(lfp, "\n-- %s: %s  (%s), result = %d\n",
		log_time(0), buf, fd ? log_devnam(fd,pcb) : "", err);
	if (err < 0)
	    fprintf(lfp, "-- \t%s\n", strerror(errno));
	fclose(lfp);
	va_end(ap);
    }
} /* end do_log_oper() */

/* like do_log_oper except that since the fd is already closed, we	*/
/* can't get the filename.						*/
static void do_log_close(FD fd, PCB *pcb, int err, char *fdname)
{
    FILE *lfp = do_log_file(fd);
    if (lfp) {
	fprintf(lfp, "\n-- %s: close(%d)  (%s), result = %d\n",
		log_time(0), fd, fdname, err);
	if (err < 0)
	    fprintf(lfp, "-- \t%s\n", strerror(errno));
	fclose(lfp);
    }
} /* end do_log_close() */

static void do_log_xfer(FD fd, PCB *pcb, char *rqtyp, size_t siz)
{
    FILE *lfp = do_log_file(fd);
    if (lfp) {
	fprintf(lfp, "\n-- %s: %s fd %d (%s), nbytes = %d\n", 
		log_time(0), rqtyp, fd, log_devnam(fd,pcb), siz);
	fclose(lfp);
    }
} /* end do_log_xfer() */

static int do_log_fin(FD fd, PCB *pcb, char *rqtyp, int nbytes)
{
    FILE *lfp = do_log_file(fd);
    if (lfp) {
	fprintf(lfp, "\t%s completed, actual nbytes = %d\n", rqtyp, nbytes);
	fclose(lfp);
    }
    return (nbytes);
} /* end do_log_fin() */

static int do_log_err(FD fd, char *rqtyp, int err)
{
    FILE *lfp = do_log_file(fd);
    if (lfp) {
	fprintf(lfp, "\t%s failed, error %d: %s\n", rqtyp, errno, strerror(errno));
	fclose(lfp);
    }
    return err;
}

/* find the next bit set in a mask */
static int find_next_set(int *mask, int start, int max)
{
    int ii;
    for (ii = start; ii < max; ++ii)
	if (BIT_TEST(mask,ii))
	    return ii;
    return -1;
}

static void do_log_select_rdy_bits(char *buf, int nfds, int *mask, char *type)
{
    int ii;
    char *p;
    if (0 <= (ii = find_next_set(mask, 0, nfds))) {
	if (*(p=buf))
	    p += strlen(strcat(p,", "));
	p += sprintf(p, "%s ready: (%d", type, ii);
	while (ii = find_next_set(mask, ++ii, nfds) >= 0)
	    p += sprintf(p, ",%d", ii);
	strcat(p, ")");
    }
}

static void do_log_select(int nfds, int *rdfds, int *wrtfds, int *excpfds, struct timeval *tm)
{
    FILE *lfp = do_log_file(3);
    if (lfp) {
	char buf[1024];
	if (tm)
	    fprintf(lfp, "\n-- %s: select(timeout=%d.%06d secs)",
		log_time(0), tm->tv_sec, tm->tv_usec);
	else fprintf(lfp, "\n-- %s: select(timeout=null)", log_time(0));

#define PRT_MASK(p,s,c)	\
	if (p) sprintf(buf+strlen(buf), s " mask = %08x" c, *p);	\
	else sprintf(buf+strlen(buf), s " mask = <null>" c);		\

	*buf = '\0';
	PRT_MASK(rdfds, "read", ", ");
	PRT_MASK(wrtfds, "write", ", ");
	PRT_MASK(excpfds, "exception", "");
#undef PRT_MASK
	fprintf(lfp, "\n\t%s", buf);
	fclose(lfp);
    }
}


static void do_log_select_result(int nrdy, int nfds, int *rdfds, int *wrtfds, int *excpfds, struct timeval *tm)
{
    FILE *lfp = do_log_file(3);
    if (lfp) {
	char buf[1024];
	fprintf(lfp, "\n\tresult = %d ", nrdy);
	if (nrdy > 0) {
	    *buf = '\0';
	    if (rdfds)   do_log_select_rdy_bits(buf, nfds, rdfds,  "read");
	    if (wrtfds)  do_log_select_rdy_bits(buf, nfds, wrtfds, "write");
	    if (excpfds) do_log_select_rdy_bits(buf, nfds, excpfds,"except");
	    fputs(buf, lfp);
	}
	else fputs("(none ready)", lfp);
	fputc('\n', lfp);
	fclose(lfp);
    }
}

static void do_log_dump(FD fd, char *pos, size_t siz, int offset)
{
    FILE *lfp = do_log_file(fd);
#define INCR	10	/* chars per line to dump */
    static char nulbuf[INCR];

    if (lfp) {
	int ii, jj; size_t l;
	char decbuf[120], ascbuf[80];
	char *p, *q;
	if (fd <= 2) 
	    fwrite(pos, siz, 1, lfp);
	else for (ii = 0;  ii < siz;  ii += INCR) {
	    /* if there's a string of nulls */
	    if ( siz - ii >= sizeof(nulbuf) 
		    && !memcmp (pos+ii, nulbuf, sizeof(nulbuf))) {
		/* find the end if the string of nulls */
		for (q=pos+ii+sizeof(nulbuf); q < pos+siz && !*q; ++q) ;/* null stmt */
		l = q - pos - ii;
		if (q < pos + siz) l = l/INCR*INCR;
		fprintf(lfp, "%8d:  (%d null bytes [from %d to %d] elided)\n",
			ii+offset, l, ii+offset, ii+offset + l - 1);
		ii += l - INCR;		/* HACK: will be incremented by loop */
	    } else {
		p = decbuf; q = ascbuf;
		for (jj = ii; jj < ii+INCR && jj < siz; ++jj) {
		    l = sprintf(p, "%03d ", pos[jj]);
		    p += l;			    /* expect l to be 4 */
		    *q++ = isprint(pos[jj]) ? pos[jj] : '.';	    
		} /* end for each char in "chunk" */
		*p = '\0'; *q = '\0';
		fprintf(lfp, "%8d: %-*s     %-*s\n", 
			ii+offset, INCR*4, decbuf, INCR, ascbuf);
	    }
	} /* end for each "chunk" to dump */
	fclose(lfp);
    } /* end if (lfp) */
} /* end do_log_dump() */


/* undefine all jacket macros */
#undef pipe
#undef open
#undef close
#undef fdopen
#undef dup
#undef dup2
#undef read
#undef write
#undef select

/* event flags to use for read and write qio calls */
static unsigned int read_efn, write_efn;
#define SELECT_EFN write_efn

static int fdvec_new(FD fd, PCB *pcb, char *devnam, io_mode rwmode, int bufsiz) 
{
    assert (fd < CARD(ipcvms_fdvec));
    /* assert ("fd is closed"); */

    ipcvms_fdvec[fd]._info.fdnam = strnew(devnam);
    ipcvms_fdvec[fd]._info.mode = rwmode;
    ipcvms_fdvec[fd]._info.devbufsiz = bufsiz;
    ipcvms_fdvec[fd]._info.flags.inited = TRUE;
    if ( (ipcvms_fdvec[fd].pcb = pcb) )		/* copy pcb. if not null */
	++pcb->fdrefcnt;			/*  then incr ref count */
    return (fd);
} /* end fdvec_new() */


/* local function called to remove a pcb reference when a file is	*/
/* closed. The pcb is freed (and its mailbox channel(s) deassigned)	*/
/* if there are no other open files which reference to it.		*/
static void fdvec_remove_pcbref(FD fd, PCB *pcb)
{
    assert (fd < CARD(ipcvms_fdvec));
    assert (pcb == ipcvms_fdvec[fd].pcb);
    if (pcb) {
	if (!pcb->fdrefcnt) {	/* if there's no more references to this pcb */
free_pcb:   /* label for debugging porpoises */
	    if (pcb->devnam) 
		assert (pcb->devnam == ipcvms_fdvec[fd]._info.fdnam);
	    if (pcb->chan)
		sys$dassgn(pcb->chan);
	    if (pcb->rdbuf)
		free(pcb->rdbuf);
	    pcb->rdbuf = NULL;			/* nugatory */
	    pcb->devnam = NULL; pcb->chan = 0;		/* nugatory */
	    free(pcb);
	} /* end if (pcb has no more references) */
    }
} /* end fdvec_remove_pcbref() */


/* This routine is called to "forget" the information for a file	*/
/* descriptor, usually when the file is closed.				*/
static void fdvec_destroy(FD fd, PCB *pcb)
{
    assert (ipcvms_fdvec[fd].pcb == pcb);
    if (ipcvms_fdvec[fd]._info.flags.inited) {
	ipcvms_free_fd_efn(fd);
	if (ipcvms_fdvec[fd].pcb) {
	    --ipcvms_fdvec[fd].pcb->fdrefcnt;
	    fdvec_remove_pcbref(fd, ipcvms_fdvec[fd].pcb);
	    ipcvms_fdvec[fd].pcb = NULL; 
	}
	/* clear fdinfo structure */
	if (ipcvms_fdvec[fd]._info.fdnam)
	    free(ipcvms_fdvec[fd]._info.fdnam);
#ifdef moose
	ipcvms_fdvec[fd]._info.fdnam = NULL;
	ipcvms_fdvec[fd]._info.mode = 0;
	ipcvms_fdvec[fd]._info.devbufsiz = 0;
	ipcvms_fdvec[fd]._info.flags.inited = FALSE;
#else
	ipcvms_fdvec[fd]._info = null_fdinfo;
#endif
    }
} /* end fdvec_destroy() */

static void fdvec_dup(FD fd1, FD fd2)
{
    assert (!ipcvms_fdvec[fd2]._info.flags.inited);
    ipcvms_fdvec[fd2] = ipcvms_fdvec[fd1];
    ipcvms_fdvec[fd2]._info.fdnam = strnew(ipcvms_fdvec[fd1]._info.fdnam);
    if (ipcvms_fdvec[fd2].pcb)
	++ipcvms_fdvec[fd2].pcb->fdrefcnt;
}

/* local function to determine mode (read/write/both) */
static io_mode get_mode(int flags)
{
    if (flags & O_RDWR)
	return io_readwrite;
    if (flags & O_WRONLY)
	return io_write;
    assert (O_RDONLY == 0);	/* stupid constant tricks */
    return io_read;
}


/* This function performs some checking and one-time initialization. */
static void ipcvms_init(FD fd)
{
    VMS_STS st;
    static int init_done;

    assert (fd < CARD(ipcvms_fdvec));
    if (!init_done) {		/* if we haven't done this yet */
	unsigned int efn;
	init_done = TRUE;
	ipcvms_pid = getpid();
	ipcvms_get_progname(NULL);
	st = lib$get_ef(&read_efn);
	if (&read_efn != &write_efn)
	    st = lib$get_ef(&write_efn);
	log_init();
	/* free event flags 2 to 22, which are initially allocated	*/
	/* [reserved] by default. We may need to allocate specific	*/
	/* flags in this range if ipcvms_get_fd_efn is called.  We	*/
	/* should really free [1-23] but I'd like to avoid using the	*/
	/* "obvious" ones.						*/
	for (efn=2; efn <= 22; ++efn) {
	    st = lib$free_ef(&efn);
	}
    }
}


/* local function to find the pcb, if any, associated with a file descriptor */
static PCB *fd_to_pcb(FD fd)
{
    PCB *pcb;
#ifdef DEBUG
    static char fdnam[FILENAME_MAX];
    getname(fd, fdnam, 1);		/* get vms style name */
#endif
    ipcvms_init(fd);			/* setup and initialization */
    if (fd >= 0 && fd < CARD(ipcvms_fdvec))
	pcb=ipcvms_fdvec[fd].pcb;
    else pcb = NULL;
    return pcb;
}


/* local routine to get info for a file descriptor */
static PCB *ipcvms_get_info(fd)
{
    PCB *pcb;

    /* ipcvms_init(fd);			/* setup and initialization */
    pcb = fd_to_pcb(fd);
    if (!ipcvms_fdvec[fd]._info.flags.inited) {
	int err; VMS_STS st; 
	char *p;
	IOSB iosb;
	static char fdnam[FILENAME_MAX];
	DX_BUF(fdnam_d, fdnam);
	int devbufsiz, devclass;
	char devnam[MAX_DEVNAM]; unsigned short devnamlen;
	ITEMLIST dvi_list = {
	    ITEM_S(DVI$_DEVBUFSIZ, devbufsiz, NULL),
	    ITEM_S(DVI$_DEVCLASS, devclass, NULL),
	    ITEM_A(DVI$_DEVNAM, devnam, &devnamlen),
	    {0,0,0,0} };

	err = isapipe(fd);
	if (err == -1) return NULL;		/* fd not open now */
	/* this is probably nugatory; isapipe should do it? */
	/* isapipe only returns true for mailboxes created by "pipe" call */
	get_fdname(fd, fdnam);
	DXLEN(fdnam_d) = strlen(fdnam);
	st = sys$getdviw(1, 0, &fdnam_d, dvi_list, &iosb, 0,0,0);
	if (FAILURE(st)) return NULL;
	/* is it a mailbox? if so, save the buffer size */
	if (devclass != DC$_MAILBOX)
	    devbufsiz = 0;
	fdvec_new(fd, pcb, fdnam, io_unk, devbufsiz);
    }
    return (pcb);
}


#ifdef DO_WE_REALLY_NEED_A_READ_DONE_AST
/* read complete routine */
static VMS_STS read_done(PCB *pcb)
{
    if (pcb->iosb.sts == SS$_ENDOFFILE) {
	/* ***FIXIT*** ensure that it's not a bogus eof */
	if (pcb->iosb.pid == 0) {
	/* this only happens with async read and mbox empty */
	    RETURN_ERR(EWOULDBLOCK)
	}
	/* make sure that it was the other guy who "closed" the pipe. */
	else if (pcb->iosb.pid == ipcvms_pid) {
read_bogus_eof:	    /* **FIXIT** WHY WHY WHY DOES THIS HAPPEN? */
	    do_log_entry(fd, "\teof (my pid=%d) ignored\n", pcb->iosb.pid);
	    /* here is a really good place for a goto! */
	    return my_read(fd, pcb, buf, nbytes, read_async);
	    /* too bad I don't belive in them! */
	} else { /* pipe closed (writer closed it or crashed) */
	    pcb->flags.closed = TRUE;
	    do_log_entry(fd, "\teof (pid=%d), pipe closed\n", pcb->iosb.pid);
	    /* raise(SIGPIPE) to writer somehow? */
	    return (0);		/* this means eof on unix */
	}
    }
    return SS$_NORMAL;
} /* read_done()  */
#endif /* non-nugatory read complete ast */

/* local function to post a read (asynchronous) to the mailbox.		*/
/* Returns the number of bytes read (0 if read is pending), -1 if	*/
/* error. "post_read" sounds better but that seems to violate the	*/
/* naming conventions...						*/
static VMS_STS read_post(FD fd, PCB *pcb, int reserved)
{
    VMS_STS st;
    int err;

    if (FALSE) {
    }
    pcb->flags.busy = TRUE;			/* this is about to be true */
    st = sys$qio(read_efn, pcb->chan, IO$_READVBLK, &pcb->iosb, 
		0,0, pcb->rdbuf, pcb->maxmsg, 0,0,0,0);
    if (SUCCESS(st))
	st = pcb->iosb.sts;
    else {
	ipcvms_status = vaxc$errno = st; 
	ipcvms_errno = errno = EVMSERR;
	fprintf(stderr, "%s: ipcvms read_post: unexpected qio error %08x on fd #%d (%s)\n    %s\n",
		    ipcvms_progname, st, fd, pcb->devnam, strerror(EVMSERR,st));
    }
    if (SUCCESS(st))
	err = pcb->iosb.bcnt;
    else if (st != 0) {	    /* if not i/o pending */
	fprintf(stderr, "%s: ipcvms read_post: unexpected i/o error %08x on fd #%d (%s)\n    %s\n",
		    ipcvms_progname, st, fd, pcb->devnam, strerror(EVMSERR,st));
	RETURN_VMSERR(st)
	ipcvms_errno = errno = EVMSERR;
	ipcvms_status = vaxc$errno = st;
	err = -1;
    }
    return err;
} /* end read_post() */

/* Returns the number of bytes present in the read buffer. */
static signed int read_avail(PCB *pcb)
{
    switch (pcb->iosb.sts) {
    case 0:
	return 0;	/* waiting for read to complete */
    case SS$_ENDOFFILE:
	return -1;	/* exception */
    default:
	if (SUCCESS(pcb->iosb.sts))
	    return pcb->iosb.bcnt;
	printf("ipcvms: read_avail: unexpected read error %08x on %s\n", 
		pcb->iosb.sts, pcb->devnam);
    } /* end switch */
    return -1;
}


/*									*/
/* Function to create a "pipe."						*/
/* We create a mailbox (with one channel) and open it on two file	*/
/* descriptors (one for reading, one for writing). Since we maintain a	*/
/* read posted to the mailbox, we also must enforce that the read and	*/
/* write file descriptors are used only for their respective purpose	*/
/* (otherwise we would always read the data that we wrote).		*/
/* This should not cause any problems because by definition, unix	*/
/* (unnamed) pipes are always unidirectional (i.e. two pipes are	*/
/* required for bidirectional communications). This is in direct	*/
/* contradiction to the pipe example in the DEC C Runtime Library	*/
/* Reference Manual, which shows the use of a pipe for bidirectional	*/
/* communications.							*/
/* 									*/
/*  Usage:								*/
/*	err = ipcvms_pipe(fdsc[1], [ flags , maxmsg , bufquo ] )	*/
/*									*/
/*									*/
int ipcvms_pipe(FD fdsc[2], ...)
{
    VMS_STS st;		
    int err, argc, flags, bufsiz, bufquo; 
    va_list ap;
    PCB *pcb;
    char devnam[MAX_DEVNAM];
#ifdef MY_PIPE
    DX_BUF(devnam_d, devnam);
    int devbufsiz; 
#ifdef DEBUG
    char devdep[4], devdep2[4];		/* 4-byte vectors (VMS Sys Svcs) */
    char fulldevnam[MAX_DEVNAM];
    unsigned short fulldevlen;
#endif

    ITEMLIST dvi_list1 = {
	ITEM_A(DVI$_DEVNAM, devnam, &DXLEN(devnam_d)), 
	ITEM_S(DVI$_DEVBUFSIZ, devbufsiz, NULL),
#ifdef DEBUG
	ITEM_A(DVI$_DEVDEPEND, devdep, NULL),
	ITEM_A(DVI$_DEVDEPEND2, devdep2, NULL),
	ITEM_A(DVI$_FULLDEVNAM, fulldevnam, &fulldevlen), 
#endif
	{0,0,0,0} };
    ITEMLIST dvi_list3 = { ITEM(DVI$_REFCNT, NULL, 0, NULL), {0,0,0,0} };
    ITEMLIST dvi_listdbg = {
	ITEM_A(DVI$_DEVDEPEND, devdep, NULL),
	ITEM_A(DVI$_DEVDEPEND2, devdep2, NULL),
	{0,0,0,0} };

    static const PCB null_pcb = NULL_PCB;
#endif /* MY_PIPE */

#define DEFAULT_FLAGS	O_RDWR
#define DEFAULT_PROTMASK 0		/* system default */
#define DEFAULT_MAXMSG	512		/* [stupid] default for DEC C */
#define MAX_MBXMAXMSG	1024
#define xxMAX_MBXMAXMSG	512		/* warn: just for debugging! */

    ipcvms_init(0);			/* one-time initialization */
    assert (ipcvms_pid);			/* we must now know our pid */
    assert (ipcvms_progname);		/*  and our program (image) name */
pipe_debug: /* label for debugging. I still don't use goto's */

    /* pick up optional arguments: flags, bufsize, bufquota */
    /* Question: how to tell if they're really present? */
    /* Answer: use unsupported nonportable "va_count" feature */
    va_count(argc);		/* kids, don't try this in portable code! */
    VA_START (ap, fdsc);
    if (argc >= 2)
	flags = va_arg (ap, int);
    else flags = DEFAULT_FLAGS;		/* default (rd/write, sync) */
    if (argc >= 3)
	bufsiz = va_arg (ap, int);
    else bufsiz = DEFAULT_MAXMSG;	/* use appropriate defaults... */
    /* if (bufsiz > 8192) bufsiz = 8192; */
    if (bufsiz > MAX_MBXMAXMSG)
	bufsiz = MAX_MBXMAXMSG;
    if (argc >= 4)
	bufquo = va_arg (ap, int);
    else bufquo = (bufsiz+12)*2;	/* ...for DEC C environment */
    va_end (ap);
    /* Restriction: bufquo maximum (see VMS System Services manual */
    /* In VMS V6, the max was lowered (from 65535) to 60000! */
    bufquo = MIN(bufquo, 60000);	/* V6 restriction */
    /* Gigantic mailbox bufquo consumes process BYTLM quota */
    bufquo = bufsiz+12;

#ifdef MY_PIPE
    /* allocate pcbs, create the mailboxes, etc. */
    /* just like the real McCoy, we open the write pipe first */
    /* create write mailbox */
    pcb = malloc(sizeof(PCB));
    memset(pcb, -1, sizeof(PCB));
    *pcb = null_pcb; 
    st = sys$crembx(0, &pcb->chan, bufsiz, bufquo, DEFAULT_PROTMASK, 0,0);
    if (FAILURE(st)) {
	fprintf(stderr, "%s: ipcvms_pipe: sys$crembx failed, VMS status %d\n    %s\n", 
		ipcvms_progname, st, strerror(EVMSERR, st);
	RETURN_VMSERR(st)
    }
    st = sys$getdviw(1, pcb->chan, 0, dvi_list1, &pcb->iosb, 0,0,0);
    assert (SUCCESS(st));
    DXPTR(devnam_d)[DXLEN(devnam_d)] = '\0';
    /* pcb->devnam = strnnew(DXPTR(devnam_d), DXLEN(devnam_d)); */

    pcb->maxmsg = devbufsiz;
    assert (devbufsiz == bufsiz);	/* should be what we asked for */

    pcb->modearg = flags;
    pcb->flags.async = BOOLEAN(flags & O_NDELAY);
    assert (SUCCESS(pcb->iosb.sts));
    assert (pcb->iosb.siz == 0);

    /* open write mailbox using C library function */
#ifdef USE_NDELAY
    err = open(devnam, O_WRONLY|(flags & ~O_NDELAY), 0);
#else
    err = open(devnam, O_WRONLY, 0);
#endif
    if (err < 0) {
	fprintf(stderr, "%s: ipcvms_pipe: error %d on open pipe write mbx %s\n    %s\n", 
		ipcvms_progname, errno, devnam, strerror(errno));
	ipcvms_errno = errno;
	return err;
    }
    **FIXIT** use get_fdname to get cannonical device name
    fdsc[1] = fdvec_new(err, pcb, devnam, io_write, pcb->maxmsg);
    pcb->devnam = ipcvms_fdvec[err]._info.fdnam;
    assert (SUCCESS(pcb->iosb.sts));
    assert (pcb->iosb.siz == 0);

    /* open read mailbox using C library function */
    /* flags &= ~O_NDELAY;			/* clear all bits but O_NDELAY */
    err = open(devnam, O_RDONLY, 0);		/* DONT SPECIFY NDELAY! */
    if (err < 0) {
	fprintf(stderr, "ipcvms_pipe: failed to open pipe read mbx %s", devnam);
	return err;
    }
    **FIXIT** use get_fdname to get cannonical device name
    fdsc[0] = fdvec_new(err, pcb, devnam, io_read, pcb->maxmsg);
    /* pcb->rdbuf = malloc(pcb->maxmsg); */
    /* read_post(fdsc[0], pcb, 1); */

    /* lastly, save the mailbox(es) device reference count */
    dvi_list3[0].bufadr = &pcb->devrefcnt;
    dvi_list3[0].buflen = sizeof(pcb->devrefcnt);
    st = sys$getdviw(1, pcb->chan, 0, dvi_list3, &pcb->iosb, 0,0,0);
    st = isapipe (fdsc[0]);
    st = isapipe (fdsc[1]);
#else	/* not MY_PIPE */
    pcb = NULL;
    err = pipe(fdsc, O_RDWR, bufsiz);
    if (!err) {
	fdvec_new(fdsc[0], NULL, get_fdname(fdsc[0], NULL), io_read, bufsiz);
	fdvec_new(fdsc[1], NULL, get_fdname(fdsc[1], NULL), io_write, bufsiz);
    }
#endif
    /* do_log_oper(err, pcb, 0, "pipe() = [%d,%d]", fdsc[0], fdsc[1]); */
    do_log_oper(fdsc[0], pcb, err, "pipe() = [%d,%d]", fdsc[0], fdsc[1]);
    return err;		/* should be zero */
} /* end ipcvms_pipe() */

/* see if you can guess what this does */
int ipcvms_close(FD fd)
{
    int err;
    PCB *pcb = ipcvms_get_info(fd);
    char fdname[FILENAME_MAX];

    get_fdname(fd, fdname);
    err = close(fd);
    if (pcb) {
	assert (err >= 0);		/* assert close did not fail */
    } 
    do_log_close(fd, pcb, err, fdname);
    fdvec_destroy(fd, pcb);
    return (err);
}

/* one of them thar unixisms - duplicate a file descriptor */
int ipcvms_dup(FD fd1)
{
    FD fd2;
    PCB *pcb = ipcvms_get_info(fd1);

    fd2 = dup(fd1);
    do_log_oper(fd1, pcb, fd2, "dup(%d)", fd1);
    if (fd2 >= 0) { /* dup succeeded */
	assert (fd2 < CARD(ipcvms_fdvec) );
	assert (ipcvms_fdvec[fd2].pcb == NULL);
	fdvec_dup(fd1, fd2);
    }
    return fd2;
}

/* what will this do in the (pathological) case of dup2(i,i)? */
int ipcvms_dup2(FD fd1, FD fd2)
{
    int err;
    PCB *pcb;
    char buf[80];

    /* always close fd2, if open, first */
    /* if ((pcb = ipcvms_get_info(fd2))) {
        do_close(fd2, pcb); 
    } */
    pcb = ipcvms_get_info(fd2);		/* get info before closed */
    err = dup2(fd1, fd2);		/* this will close fd2 if open */
    if (pcb)				/* if (known) fd2 closed by dup2 */
	sprintf(buf, "[closed %d (%s)]", fd2, pcb->devnam);
    else buf[0] = '\0';
    fdvec_destroy(fd2, pcb);		/* implicit close on fd2	*/
    pcb = ipcvms_get_info(fd1);
    do_log_oper(fd1, pcb, err, "dup2(%d,%d) %s", fd1, fd2, buf);
    if (err >= 0) {			/* dup2 succeeded */
	if (pcb) 			/* if fd1 is one of ours */
	    assert (ipcvms_fdvec[fd2].pcb == NULL);
	assert (fd2 < CARD(ipcvms_fdvec) );
	fdvec_dup(fd1, fd2);
    } else { 
	/* dup2 failed: what to do now? */  
	fprintf(stderr, "%s: ipcvms_dup2: dup2(%d,%d) failed, err=%d\n    %s\n",
		    ipcvms_progname, fd1, fd2, err, strerror(err));
    }
    return err;
}

/* Since we can't intercept read/write from inside the DEC C RTL,  	*/
/* we can't support this (until we provide a complete set of our own	*/
/* stream i/o jacket routines).						*/
FILE *ipcvms_fdopen(FD fd, char *mode)
{
    PCB *pcb = ipcvms_get_info(fd);
    if (pcb) {
	char buf[512];
	getname(fd, buf, 0);		/* get unix style name */
	getname(fd, buf, 1);		/* get vms style name */
	fprintf(stderr, "%s: ipcvms_fdopen: fdopen(%d) [ipcvms pipe %s] unsupported\n",
		ipcvms_progname, fd, pcb->devnam);
	/* return NULL; *** let it fall thru for now */
    }
    return fdopen(fd, mode);
}

#ifdef moose	/* still needs work */
int ipcvms_setmode(FD fd, int flags)
{
    PCB *pcb = ipcvms_get_info(fd);
    if (!pcb)
	return ipcvms_errno = errno = ENOENT;
    /***tbs***/
    return 0;
}
#endif /* moose */

/* i/o complete ast */
static write_done_ast(PCB *pcb)
{
    pcb->flags.busy = FALSE;
}

static void wrtattn_ast(PCB *pcb)
{
    pcb->flags.wrtattn_wait = FALSE;
    pcb->flags.read_rdy = TRUE;
    sys$setef(SELECT_EFN);
}

/* local routine to check mailbox ready-to-read status.			*/
/* Returns TRUE if data available for reading.				*/
/* This works by requesting a write attention AST, which is delivered	*/
/* when an unsolicited write i/o request is enqueued to the mailbox	*/
/* (thus indicating that it is ready to read data.			*/
static bool_t check_read(FD fd, PCB *pcb)
{
    VMS_STS st;
    /* if read attention already set, return TRUE. If not,		*/
    /* enable read attention ast (if not already enabled).		*/
    if (pcb->flags.read_rdy) return TRUE;
    if (!pcb->flags.wrtattn_wait) {
	IOSB iosb;
	pcb->flags.wrtattn_wait = TRUE;
	st = sys$qiow(1, pcb->chan, IO$_SETMODE|IO$M_WRTATTN, &iosb,
	    0,0, (void*)wrtattn_ast, (SYSPARAM)pcb, 0,0,0,0);
    }
    return pcb->flags.read_rdy;
}

/* local routine to save the "partner" pid */
static void save_pid (PCB *pcb)
{
    /* save partner (reader/writer) pid from previous i/o if known */
    if (SUCCESS(pcb->iosb.sts) && pcb->iosb.pid && pcb->iosb.pid != ipcvms_pid) 
	pcb->partner_pid = pcb->iosb.pid;
}


/* local routine to perform writes */
static my_write(FD fd, PCB *pcb, char *buf, size_t nbytes)
{
    int err; VMS_STS st; 

    if (!pcb)	/* it's one of theirs */
	err = write(fd, buf, nbytes);
    else {
#ifdef MY_PIPE
# ifdef NONBLOCKING_PIPE
	/* ensure async write wont be blocked by current activity */
	if (pcb->flags.async && pcb->flags.busy)	/* asynchronous write */
	    RETURN_ERR(EWOULDBLOCK)
	else ;
# endif
	/* insure reader is still here and has pipe open */
	if (pcb->partner_pid) {	    /* if partner (reader) is known */
	    unsigned long images;
	    st = lib$getjpi(&JPI$_IMAGECOUNT, &pcb->partner_pid,NULL, &images, 
			NULL,NULL);
	    if (st == SS$_NONEXPR || images > 1) {
		/* put a breakpoint here! */
		int foobar = images;
pipe_broken:
		++foobar;
		raise(SIGPIPE);
		RETURN_ERR(EPIPE);
	    }
	}
	/* if prior write outstanding, wait it to complete */
	assert (pcb->flags.busy == (pcb->iosb.sts == 0));
	if (pcb->flags.busy)
	    st = sys$synch(write_efn, &pcb->iosb);
	/* save partner (reader) pid from previous write if we know it */
	if (SUCCESS(pcb->iosb.sts) && pcb->iosb.pid && pcb->iosb.pid != ipcvms_pid) 
	    pcb->partner_pid = pcb->iosb.pid;
	pcb->flags.busy = TRUE;			/* this is about to be true */
	st = sys$qio(write_efn, pcb->chan, IO$_WRITEVBLK,
		&pcb->iosb, write_done_ast,pcb,
		buf, nbytes, 0,0,0,0);
	/* note: sys$qio function status return value is status of	*/
	/* system service request (i.e. whether i/o was accepted	*/
	/* and enqueued to i/o subsystem), not i/o completion	*/
	/* status, which is posted in the iosb.			*/
	if (SUCCESS(st))			/* if qio successful */
	    st = pcb->iosb.sts;			/*   get i/o status */
	if (st == 0 || SUCCESS(st))		/* i/o pending or successful */
	    err = nbytes;
	else {	/* qio or i/o failed - either way, it's a bummer */
write_error: 
	    pcb->flags.busy = FALSE;
	    /* raise(SIGPIPE); */
	    RETURN_VMSERR(st)
	    ipcvms_status = vaxc$errno = st;
	    RETURN_ERR(EVMSERR);
	}
#else /* not MY_PIPE */
	fprintf(stderr, "%s: ipcvms_write - direct pipe i/o not supported in write(%d [%s], %d\n",
		ipcvms_progname, fd, get_fdname(fd, NULL), nbytes);
	assert (1 == 0);    	
	RETURN_ERR(EIO);	
#endif /* MY_PIPE */
    }
    return err;
} /* end my_write() */

/* jacket for unixio write(). */
/* *tbs* optional arg: O_NDELAY == nonblocking write */
int ipcvms_write(FD fd, char *buf, size_t nbytes)
{
    int err;
    PCB *pcb = ipcvms_get_info(fd);
    char *pos;					/* can't increment a void* */
    size_t maxmsg, rembytes, chunksiz;
#ifdef DEBUGxxx
    char filnam[FILENAME_MAX];
    get_fdname(fd, filnam);
#endif

    if (pcb) {	/* if it's one of ours, ensure write is legal on this fd */
	if (ipcvms_fdvec[fd]._info.mode != io_write) {
	    char filnam[FILENAME_MAX];
	    printerr(EIO, "ipcvms_write: attempt to write to readonly fd #%d (%s)",
			fd, get_fdname(fd, NULL));
	    RETURN_ERR(EIO);			/* old macdonald? */
	}
    }
    do_log_xfer(fd, pcb, "write", nbytes);
    /* write data in chunks as large as the device will accept */
    if (0 == (maxmsg = ipcvms_fdvec[fd]._info.devbufsiz))
	maxmsg = nbytes;
    for ( pos = buf, rembytes = nbytes;
	  chunksiz = MIN(rembytes, maxmsg); 
	  pos += err, rembytes -= err)    {
	err = my_write(fd, pcb, pos, chunksiz);
	if (err < 0) 
	    return do_log_err(fd, "write", err);
	if (err > 0)
	    do_log_dump(fd, pos, err, pos-buf);
    } /* end for (each chunk) */
    post_attn(fd, O_WRONLY);		/* repost attn ast, if requested */
    return ((char*)pos - (char*)buf);
} /* end ipcvms_write() */

static int my_read(FD fd, PCB *pcb, char *buf, size_t nbytes, bool_t read_async)
{
    int err; VMS_STS st;

    if (!pcb) {	/* it's one of theirs */
	err = read(fd, buf, nbytes);
    } else {	/* it's one of ours */
#ifdef MY_PIPE
	int async_mod;

	if (pcb->flags.closed)	/* if pipe closed by writer (other end) */
	    return (0);		/*  how unix indicates pipe closed! */
	/* only post async read if explicitly requested */
	if (read_async) async_mod = IO$M_NOW;
	else async_mod = 0;
	assert (async_mod == 0); 	/* NO ASYNC READS, PLEASE */
	pcb->flags.read_rdy = FALSE;
	/* save partner (writer) pid from previous read if known */
	/* if (pcb->iosb.pid) pcb->partner_pid = pcb->iosb.pid; */
	st = sys$qiow(read_efn, pcb->chan, IO$_READVBLK|async_mod, &pcb->iosb, 
		0,0, buf, MIN(nbytes, pcb->maxmsg), 0,0,0,0);
	if (SUCCESS(st))			/* if qio successful */
	    st = pcb->iosb.sts;			/*   get i/o status */
	else {	/* qio failed, usually a bug of some sort */
	    fprintf(stderr, "%s: ipcvms_read: unexpected qio error %08x\n    %s\n",
			st, strerror(EVMSERR, st));
	    ipcvms_status = vaxc$errno = st; 
	    ipcvms_errno = errno = EVMSERR;
	    pcb->flags.closed = TRUE;
	    return 0;
	}

	if (SUCCESS(st)) {
	    err = pcb->iosb.siz;
	    if (err == 0) {
read_zero:  
		do_log_entry(fd, "\tzero bytes read (pid=%d), ignored\n", pcb->iosb.pid);
		/* wait for a brief interval (.010 secs == 10 msecs) */
		wait_brief(fd, pcb, read_efn, 10); 
		return my_read(fd, pcb, buf, nbytes, read_async);
	    }
	    do_log_entry(fd, "\t%d bytes read (writer pid=%d)\n", err, pcb->iosb.pid);
	    /* save partner (writer) pid if known */
	    if (pcb->iosb.pid) 
		pcb->partner_pid = pcb->iosb.pid;
	} else {    /* i/o error, check it out */
read_error:
	    if (st == SS$_ENDOFFILE) {
		if (pcb->iosb.pid == 0) {
		    /* this only happens with async read and mbox empty */
		    RETURN_ERR(EWOULDBLOCK)
		}
		/* make sure that it was the other guy who "closed" the pipe. */
		if (pcb->iosb.pid == ipcvms_pid) {
read_bogus_eof:	    /* **FIXIT** WHY WHY WHY DOES THIS HAPPEN? */
		    do_log_entry(fd, "\teof (my pid=%d) ignored\n", pcb->iosb.pid);
		    /* here is a really good place for a goto! */
		    return my_read(fd, pcb, buf, nbytes, read_async);
		    /* too bad I don't belive in them! */
		} else { /* pipe closed (writer closed it or exited) */
		    pcb->flags.closed = TRUE;
		    do_log_entry(fd, "\teof (pid=%d), pipe closed\n", pcb->iosb.pid);
		    /* raise(SIGPIPE) to writer somehow? */
		    return (0);		/* this means eof on unix */
		}
	    }
	    else {
		RETURN_VMSERR(st)
	    }
	}
#else	/* not MY_PIPE */
	fprintf(stderr, "%s: ipcvms_read - direct pipe i/o not supported in read(%d [%s], %d\n",
		ipcvms_progname, fd, get_fdname(fd, NULL), nbytes);
	assert (1 == 0);    	
	RETURN_ERR(EIO);	
#endif /* MY_PIPE */
    }	    

#ifdef DEBUG
    if (err == 0) { /* pipe closed, log it */
	fprintf(stderr, "\n%s: ipcvms_read - zero bytes in read(%d [%s], %d\n",
		ipcvms_progname, fd, get_fdname(fd, NULL), nbytes);
    } 
    else if (err < 0) {
	fprintf(stderr, "%s: ipcvms_read - error: %d in read(%d [%s], %d\n\t%s\n",
		ipcvms_progname, errno, fd, get_fdname(fd, NULL), nbytes, strerror(errno));
	if (errno > 0)
	    print_errno();
    }
#endif
    return err;
} /* end my_read() */

/* *tbs* optional arg: O_NDELAY == nonblocking read */
int ipcvms_read(FD fd, char *buf, size_t nbytes)
{
    int err; bool_t read_async; 
    PCB *pcb = ipcvms_get_info(fd);
    char *pos;					/* can't increment a void* */
    size_t maxmsg, rembytes, chunksiz;
#ifdef DEBUGxxx
    char filnam[FILENAME_MAX];
    get_fdname(fd, filnam);
#endif

    pcb = ipcvms_get_info(fd);
    /* only post async read if explicitly requested */
    read_async = FALSE;
    if (pcb && pcb->flags.async && FALSE)
	read_async = TRUE;
    /* check for optional argument */
    va_count(err);
    if (err > 3) {
	va_list ap;
	int optarg;
	VA_START (ap, nbytes);
	optarg = va_arg (ap, int);
	va_end (ap);
	if (optarg & O_NDELAY)
	    read_async = TRUE;
    }	
    if (pcb) {	/* if it's one of ours, ensure write is legal on this fd */
	/* ensure read is legal on this fd */
	if (ipcvms_fdvec[fd]._info.mode != io_read) {
	    char filnam[FILENAME_MAX];
	    printerr(EIO, "ipcvms_read: attempt to read from writeonly fd #%d (%s)",
			fd, get_fdname(fd, NULL));
	    RETURN_ERR(EIO)			/* old macdonald? */
	}
    }
    do_log_xfer(fd, pcb, "read", nbytes);
    /* read data in chunks as large as the device will permit */
    if (0 == (maxmsg = ipcvms_fdvec[fd]._info.devbufsiz))
	maxmsg = nbytes;
    for ( pos = buf, rembytes = nbytes;
	  chunksiz = MIN(rembytes, maxmsg); 
	  pos += err, rembytes -= err)	    {
	err = my_read(fd, pcb, pos, chunksiz, read_async);
	if (err == 0) break;		    /* writer closed pipe */
	else if (err < 0) 
	    return do_log_err(fd, "read", err);

#ifndef SKIP_NEWLINE_HACK   /* default = do the hack */
	/* Hack: C rtl read function seems to return a spurious newline	*/
	/* when an attempt is made to read from an empty mailbox/pipe.	*/
	if (err == 1 && *pos == '\n' && pos == buf) {
# ifdef DEBUG	    /* shout it to the world? */
	    if (getenv("EIF_IPCVMS_SPURIOUS_NEWLINE_HACK"))
		fprintf(stderr, "%s: ipcvms_read: warning: spurious newline found in %d bytes\n", 
			ipcvms_progname, err);
# endif
newline_hack:
	    do_log_entry(fd, "\t\t(spurious newline ignored)\n");
	    --err;		/* ignore the scurilous newline */
	    /* wait for a very short time then iterate loop [retry read] */
	    wait_brief(fd, pcb, read_efn, 10);
	}
#endif /* SKIP_NEWLINE_HACK */

	else if (err > 0) {
	    do_log_dump(fd, pos, err, pos-buf);
	    if (err < chunksiz)		/* if read less then requested */
	    break;			/* then that's all there is */
	}
    } /* end for (each chunk) */
    err = (char*)pos - (char*)buf;	/* actual number of bytes read */
    do_log_fin(fd, pcb, "read", err);	/* Log 'em, Danno! */
    post_attn(fd, O_RDONLY);		/* repost attn ast, if requested */
    return (err);
} /* end ipcvms_read() */


/**** select code and supporting routines ****/

/* very local routine to return the number of messages pending in a pipe (mailbox) */
/* assumes ipcvms_get_info has been called to get fdname */
static unsigned int pending_message_count(FD fd, PCB *pcb)
{
    int err; VMS_STS st; unsigned int devdep, devclass;
    DX_BLD(fdnam_d, 0,0);
    IOSB iosb;
    ITEMLIST dvi_list = {
#ifdef DEBUG
	ITEM_S(DVI$_DEVCLASS, devclass, NULL),
#endif
	ITEM_S(DVI$_DEVDEPEND, devdep, NULL),
	{0,0,0,0} };

    err = isapipe(fd);
    if (err == -1) {
	fprintf(stderr, "%s: ipcvms.pending_message_count(%d): [%s] - not a pipe\n", 
	    ipcvms_progname, fd, ipcvms_fdvec[fd]._info.fdnam);
	return -1;		/* invalid fd */
    }
    DXLEN(fdnam_d) = strlen(DXPTR(fdnam_d) = ipcvms_fdvec[fd]._info.fdnam);
    st = sys$getdviw(1, 0, &fdnam_d, dvi_list, &iosb, 0,0,0);
    if (FAILURE(st)) {
	fprintf(stderr, "%s: ipcvms.pending_message_count(%d): [%s] - sys$getdvi status %d\n    %s\n", 
	    ipcvms_progname, fd, ipcvms_fdvec[fd]._info.fdnam, st, strerror(EVMSERR,st));
	return -1;
    }	
    assert (devclass == DC$_MAILBOX);
    return (devdep & 0xFFFF);	
} /* end pending_message_count() */

/* local routine to determine if pipe is ready for read. If there are	*/
/* any messages pending, it is deemed ready to read.			*/
static bool_t is_read_ready(FD fd, PCB *pcb)
{
    if (pcb)
	return check_read(fd, pcb);
    else {
	int cnt = pending_message_count(fd, pcb);
	return BOOLEAN(cnt > 0);
    }
} /* end is_read_ready() */

/* local routine to determine if pipe is ready for write. If no		*/
/* messages are pending, the pipe is deemed ready to write.		*/
static bool_t is_write_ready(FD fd, PCB *pcb)
{
    int cnt;
    cnt = pending_message_count(fd, pcb);
    return BOOLEAN(cnt <= 0);
} /* end is_write_ready() */

/* local routine to "select" on a set of file descriptors.		*/
/* clrbits (last) is a flag that indicates, if set, that this is the	*/
/* last pass through the file descriptor masks, and each set bit for	*/
/* which the fd is not ready should be cleared.				*/
static int do_select(int nfds, bool_t clrbits, int *rdfds, int *wrtfds, int *excpfds)
{
    int ii, readcnt, wrtcnt, excpcnt;
    PCB *pcb;

    /* loop over the file descriptor bit masks */
    for (readcnt = wrtcnt = excpcnt = 0, ii = 0;  ii < nfds;  ++ii) {
	if (BIT_TEST(rdfds,ii) || BIT_TEST(wrtfds,ii) || BIT_TEST(excpfds,ii)) {
	    pcb = ipcvms_get_info(ii);
#ifdef MY_PIPE
	    if (!(pcb))
		return /* EBADF */ 1;	    /***** TEMPORARY HACK ****/
#endif
	    if (BIT_TEST(rdfds,ii)) {
found_read:
		if (is_read_ready(ii, pcb))
		    ++readcnt;
		else if (clrbits) 
		    BIT_CLEAR(rdfds,ii);
	    }
	    if (BIT_TEST(wrtfds,ii)) {
found_write:
#ifdef MY_PIPE
#ifdef DEBUG
		assert (pcb->flags.busy == (pcb->iosb.sts == 0));
		if (ipcvms_fdvec[ii]._info.mode != io_write) {
		    char filnam[FILENAME_MAX];
		    printerr(EIO, "ipcvms_select: attempt to select(write) on readonly fd #%d (%s)",
			ii, get_fdname(ii, filnam));
		}
#endif
		if (!pcb->flags.busy)		    /* if no write pending */
#else /* not MY_PIPE */
		if (is_write_ready(ii, pcb))
#endif
		    ++wrtcnt;			    /*   then it's ready */
		else if (clrbits) BIT_CLEAR(wrtfds,ii);
	    }
	    if (BIT_TEST(excpfds,ii)) {
found_excep:
#ifdef DEBUG	/* I don't know if I can do this correctly... */
		fprintf(stderr, "%s: ipcvms.do_select: exception check on fd %d [%s]\n",
		    ipcvms_progname, ii, ipcvms_fdvec[ii]._info.fdnam);
#endif
		if (pcb && (pcb->flags.closed || pcb->iosb.sts && !SUCCESS(pcb->iosb.sts)))
		    ++excpcnt;
		else if (clrbits) BIT_CLEAR(excpfds,ii);
	    }
	} /* end if BIT_TEST(any) */
    } /* end for (each possible fd) */
    return (readcnt + wrtcnt + excpcnt);
}


#define SELECT_EVENT_DRIVEN

#ifdef SELECT_EVENT_DRIVEN

static void select_attn_ast(int param)
{
    VMS_STS st;
    st = sys$setef(param);
#ifdef DEBUG
    if (FAILURE(st))
	printerr(EVMSERR, "ipcvms.select_attn_ast: error %%x%x from sys$setef(%d)\n-- %s",
		st, param, strerror(EVMSERR,st));
#endif /* DEBUG */
}

static int select_data_numb;
static struct {
    int fd;
    UWORD chan;
} select_data[32];

static int select_attn_post(int efn, int fd, int flag)
{
    VMS_STS st; IOSB iosb; 
    DX_BLD(fdnam_d, 0,0);

    assert (select_data_numb < CARD(select_data));

    ipcvms_get_info(fd);
    select_data[select_data_numb].fd = fd;
    DXLEN(fdnam_d) = strlen(DXPTR(fdnam_d) = ipcvms_fdvec[fd]._info.fdnam);
    st = sys$assign(&fdnam_d, &select_data[select_data_numb].chan, 0, 0, AGN$M_READONLY);
    if (FAILURE(st)) {
#ifdef DEBUG
	printerr(EVMSERR, "ipcvms.select_post: cannot assign channel to mbx %s for fd %d - error %%x%x\n-- %s",
		ipcvms_fdvec[fd]._info.fdnam, fd, st, strerror(EVMSERR,st));
	RETURN_VMSERR(st);
    }
#endif

    st = sys$qiow(1, select_data[select_data_numb].chan, 
		IO$_SETMODE | (flag == O_RDONLY ? IO$M_WRTATTN : IO$M_READATTN),
		&iosb, 0,0,
		(void*)&select_attn_ast, efn, 0,0,0,0);
    if (FAILURE(st)) {
#ifdef DEBUG
	fprintf(stderr, "%s: ipcvms.select_attn : unexpected qiow error %08x on fd #%d (%s)\n    %s\n",
		    ipcvms_progname, st, fd, ipcvms_fdvec[fd]._info.fdnam, strerror(EVMSERR,st));
#endif
	RETURN_VMSERR(st);
    }
    else if (FAILURE(st = iosb.sts)) {
#ifdef DEBUG
	fprintf(stderr, "%s: ipcvms.select_attn : unexpected io error %08x on fd #%d (%s)\n    %s\n",
		    ipcvms_progname, st, fd, ipcvms_fdvec[fd]._info.fdnam, strerror(EVMSERR,st));
#endif
	RETURN_VMSERR(st);
    }
    return ++select_data_numb;
}

static void select_attn_cleanup()
{
    VMS_STS st;
    int ii;

    assert (select_data_numb <= CARD(select_data));
    for (ii=0;  ii < select_data_numb;  ++ii) {
	if (select_data[ii].chan) {
	    st = sys$cancel(select_data[ii].chan);
	    st = sys$dassgn(select_data[ii].chan);
	    select_data[ii].chan = 0;
	}	
	select_data[ii].fd = 0;
    }
    select_data_numb = 0;
}

/* local routine to setup attention ast's for selected mailboxes */
static void select_attn_set(int efn, int nfds, int *fdset, int flag)
{
    VMS_STS st; int ii;

    assert (nfds <= CARD(select_data));

    /* loop over the file descriptor bit mask */
    for (ii = 0;  ii < nfds;  ++ii) {
	if (BIT_TEST(fdset, ii)) {
	    select_attn_post(efn, ii, flag);
	}
    } /* end for each bit */
}

static void select_attn(int efn, int nfds, int *rdfds, int *wrtfds, int *excpfds)
{
    select_attn_set(efn, nfds, rdfds, O_RDONLY);
    select_attn_set(efn, nfds, wrtfds, O_WRONLY);
    select_attn_set(efn, nfds, excpfds, O_RDONLY);
} /* end select_attn() */
#endif /* SELECT_EVENT_DRIVEN */


/* select timer ast */
static int timer_ast(int *param)
{
    *param = 0;
    return 1;
}

int my_select(int nfds, int *rdfds, int *wrtfds, int *excpfds, struct timeval *tm)
{
    VMS_STS st;
    int rdy;

    assert (nfds <= 32);


    /* First check to see if any fd's are ready, and avoid all this overhead. */
    rdy = do_select(nfds, FALSE, rdfds, wrtfds, excpfds);
    if (!rdy) {					/* if not ready first time... */
	bool_t block, timed;
	char asctim[40];
	DX_BUF(asctim_d, asctim);
	VMS_BINTIM timquad;
	static int timer_pending;		/* flag: timer ast enqueued */

	timed = FALSE;				/* assume no timer used	    */
	timer_pending = FALSE;			/* clear timer pending flag */
	if (!tm) {				/* if timeout not specified */
	    block = TRUE;			/* then wait indefinitely   */
	    st = sys$clref(SELECT_EFN);	/* clear timer/wait event flag */
	} else if (!tm->tv_sec && !tm->tv_usec)	/* else if timeout zero	    */
	    block = FALSE;			/* then don't wait at all   */
	else {					/* else setup timer	    */
	    /* convert timeval time to vms binary time by way of vms ascii time */
#ifdef DEBUGxxx
	    int days, hrs, mins, secs;
	    days =	tm->tv_sec / 60 / 60 / 24;	/* days */
	    hrs =	tm->tv_sec / 60 / 60 % 24;	/* hours */
	    mins =	tm->tv_sec / 60 % 60;		/* minutes */
	    secs =	tm->tv_sec % 60;		/* seconds */
#endif
	    block = TRUE;				/* we will block... */
	    timed = TRUE;				/*  until time's up */
	    /* convert timeout to delta (string) time */
	    DXLEN(asctim_d) = sprintf(asctim, "%d %02d:%02d:%02d.%06d", 
		    tm->tv_sec/60/60/24, tm->tv_sec/60/60%24, tm->tv_sec/60%60, 
		    tm->tv_sec%60, tm->tv_usec);
	    st = sys$bintim(&asctim_d, &timquad);	/* convert to system time */
	    /* set the timer and clear the flag */
	    timer_pending = TRUE;			/* what an optimist! */
	    st = sys$setimr(SELECT_EFN, &timquad, (void(*)())timer_ast, 
			(SYSPARAM)&timer_pending, 0);
	}

	if (block) {
#ifdef SELECT_EVENT_DRIVEN
	    select_attn(SELECT_EFN, nfds, rdfds, wrtfds, excpfds);	
	    st = sys$waitfr(SELECT_EFN);	/* sleep until event */
	    /* in case some other event woke us up and we might wait again */
	    /* st = sys$clref(SELECT_EFN);	/* clear timer event flag */
	    select_attn_cleanup();
#else /* periodically poll the devices (not as efficient...) */
#define SNOOZE_MAX 1000				/* (1.0 secs) */
	    int snooze = 1;			/* 1st snooze: 1 msecs */
	    /* sleep until the timer expires or something becomes ready */
	    while (!(rdy = do_select(nfds, FALSE, rdfds, wrtfds, excpfds))) {
		wait_brief(0, NULL, read_efn, snooze);
		snooze *= 2;			/* next snooze 2* longer */
		/* never snooze more than SNOOZE_MAX secs */
		if (snooze > SNOOZE_MAX) snooze = SNOOZE_MAX;
		if (timed && !timer_pending) break;	/* time's up */
		/* (else) check again */
		/* rdy = do_select(nfds, FALSE, rdfds, wrtfds, excpfds); */
	    } /* end while */
#endif /* !SELECT_EVENT_DRIVEN */

	    if (timer_pending)				/* if timer is still armed */
		st = sys$cantim((SYSPARAM)&timer_pending,0);	/*  disarm it */
	} /* end if (block) */
    } /* end if not ready first time */

    /* do one final select to clear the non-ready mask bits */
    if (rdy >= 0)
	rdy = do_select(nfds, TRUE, rdfds, wrtfds, excpfds);
    return (rdy);			/* better luck next time */
} /* end my_select() */

int ipcvms_select(int nfds, Select_fd_set_t rdfds, Select_fd_set_t wrtfds, Select_fd_set_t excpfds, struct timeval *tm)
{
    int err;
    /* char logbuf[1024]; */

    do_log_select(nfds, (int*)rdfds, (int*)wrtfds, (int*)excpfds, tm);
    err = my_select(nfds, (int*)rdfds, (int*)wrtfds, (int*)excpfds, tm);
    do_log_select_result(err, nfds, (int*)rdfds, (int*)wrtfds, (int*)excpfds, tm);
    return err;
}


/* This routine is used (as a temporary hack) by ewb to make sure that	*/
/* data is available in a "pipe" before reading it.			*/
int ipcvms_read_avail(FD fd)
{
    int err;
    PCB *pcb = ipcvms_get_info(fd);
    return is_read_ready(fd, pcb);
}


/* These routines are used to support event driven pipes (mailboxes).	*/

/* This routine is called to "allocate" an event flag that may be used	*/
/* for Xt toolkit calls (i.e. XtAppAddInput) on a pipe in place of the	*/
/* file descriptor numbers used in unix implementations.  The event	*/
/* flag will be caused to be set whenever data becomes available in the	*/
/* pipe (read) or whenever the pipe is waiting for data (write).	*/
/* Flag must be O_RDONLY or O_WRONLY, indicating a pipe used for input	*/
/* or output, respectively.						*/
/* A return value of -1 indicates no event flag is available.		*/
/* This is a limited resource, and must be free'd when done, by calling	*/
/* ipcvms_free_fd_efn.							*/
/* Vision/Clib/X/io_handler is uses this facility to support calling	*/
/* XtAppAddInput.							*/

int ipcvms_get_fd_efn(FD fd, int flag)
{
    VMS_STS st;
    unsigned int efn; UWORD chan;
    DX_BLD(fdnam_d, 0,0);

    /* ensure that info is present for this fd */
    ipcvms_get_info(fd);
    if (flag != O_RDONLY && flag != O_WRONLY) {
#ifdef DEBUG
	printerr(EINVAL, "ipcvms_get_fd_efn: invalid flag value %d\n", flag);
#endif /* DEBUG */
	RETURN_ERR(EINVAL)
    }
    if (!isapipe(fd)) {
#ifdef DEBUG
	printerr(EINVAL, "ipcvms_get_fd_efn: fd (%d [%s] not a pipe\n", 
		fd, ipcvms_fdvec[fd]._info.fdnam);
#endif /* DEBUG */
	RETURN_ERR(ESPIPE)
    }
    if (ipcvms_fdvec[fd]._info.flags.attn_req) {
#ifdef DEBUG
	printerr(EBUSY, "ipcvms_get_fd_efn: fd (%d [%s] already active\n", 
		fd, ipcvms_fdvec[fd]._info.fdnam);
#endif /* DEBUG */
	RETURN_ERR(EBUSY)
    }

    /* reserve an event flag in the proper range. Xt Intrinsics require	*/
    /* that it is in the range 0-31. VMS convention reserves 24-31 for	*/
    /* system use, so we start with 23 and work down. We have to do it	*/
    /* in this awkward fashion because LIB$GET_EF will allocate an	*/
    /* arbitrary event flag in the range 1-23,32-63, and only event	*/
    /* flags in the range 0-31 can be used with XtAppAddInput, but we	*/
    /* restrict the range to [2-22] (inclusive)				*/
    for (efn=22;  efn >= 2;  --efn) {
	if (SUCCESS(st = lib$reserve_ef(&efn)))
	    break;
    }
    if (FAILURE(st)) {
#ifdef DEBUG
	printerr(EVMSERR, "ipcvms_get_fd_efn: cannot reserve event flag - error %%x%x\n-- %s\n",
		st, strerror(EVMSERR,st));
#endif /* DEBUG */
	RETURN_VMSERR(st);
    }
    DXLEN(fdnam_d) = strlen(DXPTR(fdnam_d) = ipcvms_fdvec[fd]._info.fdnam);
    st = sys$assign(&fdnam_d, &chan, 0, 0, AGN$M_READONLY);
    if (FAILURE(st)) {
	lib$free_ef(&efn);
#ifdef DEBUG
	printerr(EVMSERR, "ipcvms_get_fd_efn: cannot assign channel to mbx %s for fd %d - error %%x%x\n-- %s",
		ipcvms_fdvec[fd]._info.fdnam, fd, st, strerror(EVMSERR,st));
#endif
    }

    ipcvms_fdvec[fd]._info.xefn = efn;
    ipcvms_fdvec[fd]._info.xchan = chan;
    ipcvms_fdvec[fd]._info.flags.attn_req = TRUE;
    ipcvms_fdvec[fd]._info.flags.attn_rd = (flag == O_RDONLY);
    
    st = post_attn(fd, flag);
    if (FAILURE(st)) {
	ipcvms_free_fd_efn(fd);
	RETURN_VMSERR(st);
    }
    return efn;
} /* end ipcvms_get_fd_efn() */


/* And here we have the free function... */
void ipcvms_free_fd_efn(fd)
{
    VMS_STS st; 

    assert (fd < CARD(ipcvms_fdvec));
    if (ipcvms_fdvec[fd]._info.xchan)
	st = sys$dassgn(ipcvms_fdvec[fd]._info.xchan);
    if (ipcvms_fdvec[fd]._info.xefn)
	st = lib$free_ef(&ipcvms_fdvec[fd]._info.xefn);
    ipcvms_fdvec[fd]._info.xchan = 0; ipcvms_fdvec[fd]._info.xefn = 0;
    ipcvms_fdvec[fd]._info.flags.attn_req = 0;
    ipcvms_fdvec[fd]._info.flags.attn_rd = 0;
} /* end ipcvms_free_fd_efn() */



/* Mailbox attention ast. Called by VMS io subsystem when unsolicited	*/
/* data is written to or attempted to be read from mailbox. It sets the	*/
/* event flag associated with the file descriptor (presumably a pipe),	*/
/* which is used as a trigger (eg. XtAppAddInput). Note that the	*/
/* callback routine (invoked via XtAppAddInput) must clear the event	*/
/* flag to avoid being called repeatedly.				*/
static void mbx_attn(FD fd)
{
    VMS_STS st;

    assert (fd < CARD(ipcvms_fdvec));
    assert (ipcvms_fdvec[fd]._info.flags.inited);
    if (ipcvms_fdvec[fd]._info.xefn) {
	st = sys$setef(ipcvms_fdvec[fd]._info.xefn);
	if (FAILURE(st)) {
#ifdef DEBUG
	    printerr(EVMSERR, "ipcvms.mbx_attn: error %%x%x from sys$setef(%d)\n-- %s",
		    st, ipcvms_fdvec[fd]._info.xefn, strerror(EVMSERR,st));
#endif /* DEBUG */
	}
    }
    ipcvms_fdvec[fd]._info.flags.attn_posted = FALSE;
    --ipcvms_fdvec[fd]._info.postcnt;
#ifdef DEASSIGN_MBX_CHAN
    /* deassign the channel (see post_attn for reasoning) */
    st = sys$dassgn(ipcvms_fdvec[fd]._info.xchan);
    ipcvms_fdvec[fd]._info.xchan = 0;
#endif
} /* end mbx_attn() */


/* This routine is called to (re)post the read/write attention ast to	*/
/* the mailbox associated with a pipe.  <<<Terminology alert:>>> a VMS	*/
/* write attention ast gets called when someone writes to the mailbox	*/
/* (i.e.  notifies that the mailbox should be read), and vice versa.	*/
/* Normally a read of zero bytes means the write closed the pipe	*/
/* (mailbox). This is normally indicated by a special "EOF" message in	*/
/* the mailbox at the VMS level which, by convention, is usually	*/
/* written to a mailbox when a writer closes it. I think that, in VMS	*/
/* V7.0, the DECC RTL may ignore any EOF messages if there are multiple	*/
/* channels assigned to the mailbox, in order to more closely emulate	*/
/* the unix behavior of only returning a zero-length read when all	*/
/* writers have closed the pipe.  For this reason, I can't keep a	*/
/* channel open on the mailbox after the attention AST has been		*/
/* delivered.								*/
static VMS_STS repost_attn(FD fd, int flag, int efn)
{
    VMS_STS st; IOSB iosb; 

    assert (fd < CARD(ipcvms_fdvec));
    assert (ipcvms_fdvec[fd]._info.flags.inited);

    /* (re)assign channel if not currently assigned */
    if (!ipcvms_fdvec[fd]._info.xchan) {
	DX_BLD(fdnam_d, 0,0);
	DXLEN(fdnam_d) = strlen(DXPTR(fdnam_d) = ipcvms_fdvec[fd]._info.fdnam);
	st = sys$assign(&fdnam_d, &ipcvms_fdvec[fd]._info.xchan, 0,0,AGN$M_READONLY);
	if (FAILURE(st)) {
	    printerr(EVMSERR, "ipcvms.post_attn: cannot reassign channel to mbx %s for fd %d - error %%x%x\n-- %s",
		    ipcvms_fdvec[fd]._info.fdnam, fd, st, strerror(EVMSERR,st));
	return st;	
	}
    }

    assert (ipcvms_fdvec[fd]._info.flags.attn_req 
	== BOOLEAN(ipcvms_fdvec[fd]._info.xchan && efn));

    if (ipcvms_fdvec[fd]._info.flags.attn_posted)
	return 1;
    /* st = sys$clref(efn);			/* just in case... */

    /* Optimistically set data to reflect posted ast.  Also avoids race	*/
    /* conditions without the overhead of blocking AST delivery.	*/
    ipcvms_fdvec[fd]._info.flags.attn_posted = TRUE;
    ++ipcvms_fdvec[fd]._info.postcnt;
    st = sys$qiow(1, ipcvms_fdvec[fd]._info.xchan, 
		IO$_SETMODE | (flag == O_RDONLY ? IO$M_WRTATTN : IO$M_READATTN),
		&iosb, 0,0,
		(void*)&mbx_attn, fd, 0,0,0,0);
#ifdef DEBUG
    if (FAILURE(st)) 
	fprintf(stderr, "%s: ipcvms.post_attn : unexpected qiow error %08x on fd #%d (%s)\n    %s\n",
		    ipcvms_progname, st, fd, ipcvms_fdvec[fd]._info.fdnam, strerror(EVMSERR,st));
    else if (FAILURE(st = iosb.sts)) 
	fprintf(stderr, "%s: ipcvms.post_attn : unexpected io error %08x on fd #%d (%s)\n    %s\n",
		    ipcvms_progname, st, fd, ipcvms_fdvec[fd]._info.fdnam, strerror(EVMSERR,st));
#endif /* DEBUG */

    if ( FAILURE(st) || FAILURE(st = iosb.sts)) {
	ipcvms_fdvec[fd]._info.flags.attn_posted = FALSE;
	--ipcvms_fdvec[fd]._info.postcnt;
    }
    return(st);
}

static VMS_STS post_attn(FD fd, int flag)
{
    VMS_STS st; IOSB iosb; 

    assert (fd < CARD(ipcvms_fdvec));
    assert (ipcvms_fdvec[fd]._info.flags.inited);

    if (!ipcvms_fdvec[fd]._info.flags.attn_req)
	return 1;

    st = sys$clref(ipcvms_fdvec[fd]._info.xefn); 	/* just in case... */
    repost_attn(fd, flag, ipcvms_fdvec[fd]._info.xefn);

} /* end post_attn() */

void * ipcvms_dummy(void)
{
    return (void*)(ipcvms_dummy);
}
