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
extern void add_log();			/* Add logging message */
extern int open_log();			/* Open logging file */
extern void close_log();		/* Close logging file */
extern void set_loglvl();		/* Set logging level */
extern int reopen_log();		/* Re-open same logfile */

/* The following need to be provided externally */
extern char *progname;			/* Program name */
extern Pid_t progpid;			/* Program PID */

#endif
#endif

