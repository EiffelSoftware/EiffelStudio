/*

 #    #    ##       #    #    #           ####
 ##  ##   #  #      #    ##   #          #    #
 # ## #  #    #     #    # #  #          #
 #    #  ######     #    #  # #   ###    #
 #    #  #    #     #    #   ##   ###    #    #
 #    #  #    #     #    #    #   ###     ####

	The main entry point.
*/

#include "config.h"
#include "portable.h"
#include "err_msg.h"
#include <sys/types.h>
#include <stdio.h>
#include "proto.h"
#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif
#include <signal.h>
#include "logfile.h"
#include "stream.h"
#include <stdlib.h>


#define EIFFEL3		"/usr/lib/Eiffel3"	/* Default installation directory */
#define EWB			"/bin/es3 -bench"	/* Ewb process within Eiffel dir */

/* Function declaration */
rt_public void dexit();			/* Daemon's exit */
rt_private void die();				/* A termination signal was trapped */
rt_private Signal_t handler();		/* Signal handler */
rt_private void set_signal();		/* Set up the signal handler */

extern STREAM *spawn_child();	/* Start up child with ipc link */
extern char *getenv();			/* Get environment variable value */
extern Malloc_t malloc();		/* Memory allocation */
rt_public unsigned TIMEOUT;		/* Time out for interprocess communications */

rt_public struct d_flags d_data = {	/* Internal daemon's flags */
	(unsigned int) 0,	/* d_rqst */
	(unsigned int) 0,	/* d_sent */
	(STREAM *) 0,		/* d_cs */
	(STREAM *) 0,		/* d_as */
};

#ifndef USE_ADD_LOG
rt_public char *progname;	/* Otherwise defined in logfile.c */
#endif

rt_public void main(argc, argv)
int argc;
char **argv;
{
	/* This is the main entry point for the ISE daemon */

	STREAM *sp;			/* Stream used to talk to the child */
	Pid_t pid;			/* Pid of the spawned child */
	char *ewb_path;		/* Path leading to the ewb executable */
	char *eiffel3;		/* Eiffel 3 installation directory */
	char *platform;
	char *eif_timeout;	/* Timeout specified in environment variable */

	/* Check if the user wants to override the default timeout value
	 * required by the children processes to launch and initialize
	 * themselves. This new value is specified in the EIF_TIMEOUT 
	 * environment variable
	 */
	eif_timeout = getenv("EIF_TIMEOUT");
	if (eif_timeout != (char *) 0)			/* Environment variable set */
		TIMEOUT = (unsigned) atoi(eif_timeout);
	else
		TIMEOUT = 120;

	/* Compute program name, removing any leading path to keep only the name
	 * of the executable file.
	 */
	progname = rindex(argv[0], '/');	/* Only last name if '/' found */
	if (progname++ == (char *) 0)		/* There were no '/' */
		progname = argv[0];				/* This must be the filename then */

#ifdef USE_ADD_LOG
	progpid = getpid();					/* Program's PID */

	/* Open a logfile in /tmp */
	(void) open_log("/tmp/ised.log");
	set_loglvl(LOGGING_LEVEL);			/* Set debug level */
#endif

	set_signal();						/* Set up signal handler */
	signal (SIGABRT ,exit);
	signal (SIGQUIT, exit);

#ifdef USE_ADD_LOG
	add_log(20, "ised process started");
#endif

	/* To find out where the ewb process is located, we use the environment
	 * variable EIFFEL3 to get the path to the Eiffel 3.0 directory. Then the
	 * ewb process is in the bin/ subdirectory. In the name of standardization,
	 * the /usr/lib/Eiffel3 path is used when the EIFFEL3 variable is not set.
	 */
	
	eiffel3 = getenv("EIFFEL3");		/* Installation directory */
	if (eiffel3 == (char *) 0) {		/* Environment variable not set */
		print_err_msg(stderr, "The environment variable EIFFEL3 is not set\n");
		exit (1);
	}
	platform = getenv ("PLATFORM");
	if (platform == (char *) 0) {		/* Environment variable not set */
		print_err_msg(stderr, "The environment variable PLATFORM is not set\n");
		exit (1);
	}

	ewb_path = (char *) malloc(2048);
	if (ewb_path == (char *) 0) {
		print_err_msg(stderr, "%s: out of memory\n", progname);
		exit(1);
	}
	
	strcpy(ewb_path, eiffel3);			/* Base name */
	strcat(ewb_path, "/bench/spec/");
	strcat(ewb_path, platform);
	strcat(ewb_path, EWB);				/* Append process name */

	/* FIXME
		FIXME
		FIXME
		FIXME
		FIXME
		check that es3 exists
	*/
	sp = spawn_child(ewb_path, &pid);	/* Bring workbench to life */
	if (sp == (STREAM *) 0)	{			/* Could not do it */
		print_err_msg(stderr, "%s: could not launch %s\n", progname, ewb_path);
		exit(1);
	}

	d_data.d_cs = sp;				/* Record workbench stream */
	d_data.d_ewb = (int) pid;		/* And keep track of the child pid */
	prt_init();						/* Initialize IDR filters */
	dwide_listen();					/* Enter server mode... */

	dexit(0);		/* Workbench died, so do we */
}

rt_private void set_signal()
{
	/* Set up the signal handler */

#ifdef SIGHUP
	signal(SIGHUP, handler);
#endif
#ifdef SIGINT
	signal(SIGINT, handler);
#endif
#ifdef SIGQUIT
	signal(SIGQUIT, handler);
#endif
#ifdef SIGTERM
	signal(SIGTERM, handler);
#endif
#ifdef BSD 
	signal (SIGCHLD, SIG_IGN);
#else
	signal (SIGCLD, SIG_IGN);
#endif
}

rt_private Signal_t handler(sig)
int sig;
{
	/* A signal was caught */

#ifndef SIGNALS_KEPT
	signal(sig, handler);
#endif

#ifdef USE_ADD_LOG
	add_log(12, "caught signal #%d", sig);
#endif
	dexit(0);
}

rt_private void die()
{
#ifdef USE_ADD_LOG
	add_log(9, "going down on termination signal");
#endif
	dexit(0);
}

rt_public void dexit(code)
int code;
{
#ifdef USE_ADD_LOG
	add_log(12, "exiting with status %d", code);
#endif
	exit(code);
}

#ifndef HAS_STRDUP

rt_public char *strdup (s)
char * s;
{
	char *new;
	int l = strlen (s) + 1;

	if (new = (char *) malloc (l))
		strncpy (new, s, l);
	else
		return (char *) 0;

	return new;
}
#endif

