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
#include <stdlib.h>
#include "err_msg.h"
#ifdef __WATCOMC__
#include <stdlib.h>
#include <fcntl.h>
#endif
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

public int in_assertion = 0;			/* Is an assertion being evaluated ? */
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

public void failure();					/* The Eiffel exectution failed */
private Signal_t emergency();			/* Emergency exit */

extern void umain();					/* User's initialization routine */
extern void arg_init();					/* Command line arguments saving */

#ifdef DEBUG
extern void mem_diagnose();				/* Memory usage dump */
#endif

public void eif_rtinit(argc, argv, envp)
int argc;
char **argv;
char **envp;
{
	struct ex_vect *exvect;				/* Execution vector for main */
	jmp_buf exenv;						/* Jump buffer for rescue */

	/* Compute the program name, so that all the error messages can be tagged
	 * with that name (with the notable exception of the stack trace, for
	 * formatting purpose).
	 */

#ifdef __WATCOMC__
	extern int _argc;
	extern char **_argv;

	_fmode = O_BINARY;
	_grow_handles (40);
	ename = rindex(_argv[0], '\\');		/* Only last name if '\' found */

	if (ename++ == (char *) 0)			/* There was no '/' in the name */
		ename = _argv[0];				/* Program name is the filename */
#else
	ename = rindex(argv[0], '/');		/* Only last name if '/' found */

	if (ename++ == (char *) 0)			/* There was no '/' in the name */
		ename = argv[0];				/* Program name is the filename */
#endif

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

	{
		char temp = 0;
		int i;

#ifdef __WATCOMC__
		for (i=1;i<_argc;i++) {
			if (0 == strcmp (_argv[i], "-ignore_updt")) {
#else
		for (i=1;i<argc;i++) {
			if (0 == strcmp (argv[i], "-ignore_updt")) {
#endif
				temp = (char) 1;	
				break;
			}
		}
		update(temp);					
	}									/* Read melted information
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

#ifdef __WATCOMC__
	umain(_argc, _argv, envp);			/* User's initializations */
	arg_init(_argc, _argv);				/* Save copy for class ARGUMENTS */
#else
	umain(argc, argv, envp);			/* User's initializations */
	arg_init(argc, argv);				/* Save copy for class ARGUMENTS */
#endif
}

public void failure()
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
	
	print_err_msg(stderr, "\n\n%s: PANIC: caught signal #%d (%s) -- Giving up...\n",
		ename, sig, signame(sig));

	exit(2);							/* Really abnormal termination */

	/* NOTREACHED */
}

#ifdef NOHOOK

/* When no debugging is allowed, the file network.o is not part of the
 * archive. However, we need to define dummy dserver() and dinterrupt() entries.
 */

public void dserver() {}
public void dinterrupt() {}
#endif

public void dexit(code)
{
	/* This routine is called by functions from libipc.a to raise immediate
	 * termination with a chance to trap the action and perform some clean-up.
	 * Here we call esdie() which will collect all the Eiffel objects and
	 * eventually call dispose() on some of them.
	 */

	esdie(code);						/* Propagate dying request */
}


