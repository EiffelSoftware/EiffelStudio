/*

 #        ####    ####   ######     #    #       ######          #    #
 #       #    #  #    #  #          #    #       #               #    #
 #       #    #  #       #####      #    #       #####           ######
 #       #    #  #  ###  #          #    #       #        ###    #    #
 #       #    #  #    #  #          #    #       #        ###    #    #
 ######   ####    ####   #          #    ######  ######   ###    #    #

	Declarations for logging.
*/

#ifndef _logfile_h_
#define _logfile_h_
#ifdef USE_ADD_LOG

#include <sys/types.h>
#include "config.h"


/* Routine defined by logging package */
extern void add_log(int level, char *format, int arg1, int arg2, int arg3, int arg4, int arg5);			/* Add logging message */
extern int open_log(char *name);	/* Open logging file */
extern void close_log(void);		/* Close logging file */
extern void set_loglvl(int level);	/* Set logging level */
extern int reopen_log(void);		/* Re-open same logfile */

/* The following need to be provided externally */
extern char *progname;			/* Program name */
extern Pid_t progpid;			/* Program PID */

#endif
#endif

