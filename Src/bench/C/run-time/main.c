/*

 #    #    ##       #    #    #           ####
 ##  ##   #  #      #    ##   #          #    #
 # ## #  #    #     #    # #  #          #
 #    #  ######     #    #  # #   ###    #
 #    #  #    #     #    #   ##   ###    #    #
 #    #  #    #     #    #    #   ###     ####

	Therein lie paths I would not have dared tredding alone.
*/

#include "config.h"
#include "portable.h"
#include <signal.h>
#include "urgent.h"
#include "garcol.h"
#include "except.h"
#include "sig.h"
#ifdef WORKBENCH
#include "interp.h"
#include "update.h"
#endif
#include <stdio.h>
#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#define null (char *) 0					/* Null pointer */

public int cc_for_speed = 1;			/* Fast memory allocation */
public char *ename;						/* Eiffel program's name */
public int scount;						/* Number of dynamic types */
public int ccount;						/* Number of classes */
public int fcount;						/* Number of frozen dynamic types */

#ifdef WORKBENCH
public struct cnode *esystem;			/* Updated Eiffel system */
public struct conform **co_table;		/* Updated Eiffel conformance table */
public int32 **ecall;					/* Routine id arrays */
public struct rout_info *eorg_table;	/* Routine origin/offset table */
public long dcount;						/* Count of `fdispatch' */
public uint32 *dispatch;				/* Update dispatch table */
public uint32 zeroc;					/* Frozen level */
public char **melt;						/* Byte code array */
public int *mpatidtab;					/* Table of pattern id's indexed by body id's */
public struct eif_opt *eoption;			/* Option table */
extern void winit();					/* Workbench debugger initialization */
extern void einit();					/* System-dependent initializations */
#define exvec() exset(null, 0, null)	/* How to get an execution vector */
#else
/*#define exvec() exft()					/* No stack dump in final mode */
#define exvec() exset(null, 0, null)	/* How to get an execution vector */
#endif

private void failure();					/* The Eiffel exectution failed */
private Signal_t emergency();			/* Emergency exit */

extern void umain();					/* User's initialization routine */
extern void arg_init();					/* Command line arguments saving */

#ifdef DEBUG
extern void mem_diagnose();				/* Memory usage dump */
#endif

public void main(argc, argv, envp)
int argc;
char **argv;
char **envp;
{
	struct ex_vect *exvect;				/* Execution vector for main */
	jmp_buf exenv;						/* Jump buffer for rescue */
	extern void emain();				/* The generated Eiffel main */

	/* Compute the program name, so that all the error messages can be tagged
	 * with that name (with the notable exception of the stack trace, for
	 * formatting purpose).
	 */

	ename = rindex(argv[0], '/');		/* Only last name if '/' found */
	if (ename++ == (char *) 0)			/* There was no '/' in the name */
		ename = argv[0];				/* Program name is the filename */

	initsig();							/* Initialize signal handling */
	initstk();							/* Create local and hector stacks */
	exvect = exvec();					/* Get an execution vector */
	exvect->ex_jbuf = (char *) exenv;	/* Where to jump back */
	if (echval = setjmp(exenv))			/* Get back here if exception caught */
		failure();						/* Fail properly */
	ufill();							/* Get urgent memory chunks */

#ifdef DEBUG
	/* The following install signal handlers for signals USR1 and USR2. Both
	 * raise an immediate scanning of memory and dumping of the free list usage
	 * and other statistics. The difference is that USR1 also performrs a full
	 * GC cycle before runnning the diagnosis. If memck() is programmed to
	 * panic when inconsistencies are detected, this may raise a system failure
	 * due to race condition. There is nothing the user can do about it, except
	 * pray--RAM.
	 */

	esignal(SIGUSR1, mem_diagnose);
	esignal(SIGUSR2, mem_diagnose);
#endif

#ifdef WORKBENCH
	xinitint();							/* Interpreter initialization */
	dispatch = fdispatch;				/* Initialize run-time table pointers */
	esystem = fsystem;
	ecall = fcall;
	eoption = foption;
	co_table = fco_table;
	eorg_table = forg_table;

	/* Initialize dynamically computed variables (i.e. system dependent) like
	 * 'zeroc' which is the melting temperature -- the last body id in the
	 * whole system. Then we may call update. Eventually, when debugging the
	 * application, the values loaded from the update file will be overridden
	 * by the workbench (via winit).
	 */

	einit();							/* Various static initializations */
	fcount = scount;
	update();							/* Read melted information 
										 * Note: the `update' function takes
										 * care of the initialization of the 
										 * temporary descriptor structures
										 */
	create_desc();						/* Create descriptor (call) tables */
	
	/* In workbench mode, we have a slight problem: when we link ewb in
	 * workbench mode, since ewb is a child from ised, the run-time will
	 * assume, wrongly, that the executable is started in debug mode. Therefore,
	 * we need a special run-time, with no debugging hooks involved.
	 */

#ifndef NOHOOK
	winit();							/* Did we start under ewb control? */
#endif
#endif

	umain(argc, argv, envp);			/* User's initializations */
	arg_init(argc, argv);				/* Save copy for class ARGUMENTS */
	emain((char *) 0);					/* Start the Eiffel application */
	reclaim();							/* Reclaim all the objects */

	exit(0);							/* Normal termination */

	/* NOTREACHED */
}

private void failure()
{
	/* A fatal Eiffel exception has occurred. The stack of exceptions is dumped
	 * and the memory is cleaned up, if possible.
	 */
	
	trapsig(emergency);					/* Weird signals are trapped */
	esfail();							/* Dump the execution stack trace */
	reclaim();							/* Reclaim all the objects */
	exit(1);							/* Abnormal termination */

	/* NOTREACHED */
}

private Signal_t emergency(sig)
int sig;
{
	/* A signal has been trapped while we were failing peacefully. The memory
	 * must really be in a desastrous state, so print out a give-up message
	 * and exit.
	 */
	
	fprintf(stderr, "\n\n%s: PANIC: caught signal #%d (%s) -- Giving up...\n",
		ename, sig, signame(sig));

	exit(2);							/* Really abnormal termination */

	/* NOTREACHED */
}

#ifdef NOHOOK

/* When no debugging is allowed, the file network.o is not part of the
 * archive. However, we need to define a dummy dserver() entry.
 */

public void dserver() {}
#endif
