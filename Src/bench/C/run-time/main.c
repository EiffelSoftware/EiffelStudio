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
#include "wbench.h"		/* %%ss added for create_desc */
#include "interp.h"
#include "update.h"
#ifdef EIF_WIN_31						/* for winit() */
#include "network.h"					/* extra/mswin/ipc */
#elif defined EIF_WIN32
#include "server.h"						/* extra/win32/ipc/app */
#else									/* Unix */
#include "server.h"						/* ../ipc/app */
#endif /* EIF_WIN_31 */
#endif /* WORKBENCH */

#ifdef EIF_WINDOWS
#include "econsole.h"					/* show_trace(), extra/win32/console */
#endif

#include <stdio.h>
#include <stdlib.h>
#include "err_msg.h"
#ifdef EIF_WINDOWS
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdlib.h>
#include <fcntl.h>
#endif
#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif
#include "umain.h"
#include "argv.h"
#ifdef DEBUG
#include "malloc.h"						/* for mem_diagnose */
#endif
#include "main.h"
#include "project.h"					/* for einit() */

#define null (char *) 0					/* Null pointer */

#ifdef EIF_WINDOWS
	/* when malloc() fails, the system dies otherwise !!! */
	/* FIXME?? */
rt_public int cc_for_speed = 0;			/* Fast memory allocation */
#else
rt_public int cc_for_speed = 1;			/* Fast memory allocation */
#endif

rt_public char *ename;						/* Eiffel program's name */
rt_public int scount;						/* Number of dynamic types */

rt_public int in_assertion = 0;			/* Is an assertion being evaluated ? */
#ifdef WORKBENCH
rt_public int ccount;						/* Number of classes */
rt_public int fcount;						/* Number of frozen dynamic types */
rt_public struct cnode *esystem;			/* Updated Eiffel system */
rt_public struct conform **co_table;		/* Updated Eiffel conformance table */
rt_public int32 **ecall;					/* Routine id arrays */
rt_public struct rout_info *eorg_table;	/* Routine origin/offset table */
rt_public long dcount;						/* Count of `dispatch' */
rt_public uint32 *dispatch;				/* Update dispatch table */
rt_public uint32 zeroc;					/* Frozen level */
rt_public char **melt;						/* Byte code array */
rt_public int *mpatidtab;					/* Table of pattern id's indexed by body id's */
rt_public struct eif_opt *eoption;			/* Option table */
rt_public struct p_interface *pattern;		/* Pattern table */

#define exvec() exset(null, 0, null)	/* How to get an execution vector */
#else
rt_public struct cnode *esystem;			/* Eiffel system (updated by DLE) */
rt_public struct conform **co_table;		/* Eiffel conformance table (updated DLE) */
rt_public long *esize;						/* Size of objects (updated by DLE) */
rt_public long *nbref;						/* Gives # of references (updated by DLE) */

/*#define exvec() exft()					/* No stack dump in final mode */
#define exvec() exset(null, 0, null)	/* How to get an execution vector */
#endif

rt_public void failure(void);					/* The Eiffel exectution failed */
rt_private Signal_t emergency(int sig);			/* Emergency exit */

#ifndef EIF_WIN_31
rt_public unsigned TIMEOUT;     /* Time out for interprocess communications */
#endif

rt_public void eif_rtinit(int argc, char **argv, char **envp)
{
	/* struct ex_vect *exvect;*/ /* Execution vector for main */ /* %%ss removed */
	/* jmp_buf exenv;*/	/* Jump buffer for rescue */ /* %%ss removed */
#ifndef EIF_WIN_31
	char *eif_timeout;
#endif


	/* Compute the program name, so that all the error messages can be tagged
	 * with that name (with the notable exception of the stack trace, for
	 * formatting purpose).
	 */

#ifdef EIF_WIN_31

	_fmode = O_BINARY;
	_grow_handles (40);
	ename = rindex(_argv[0], '\\');		/* Only last name if '\' found */

	if (ename++ == (char *) 0)			/* There was no '/' in the name */
		ename = _argv[0];				/* Program name is the filename */
#elif defined EIF_WINDOWS
	static char module_name [255] = {0};

	_fmode = O_BINARY;
	GetModuleFileName (NULL, module_name, 255);

	ename = strrchr (module_name, '\\');
	if (ename++ == (char *) 0)
		ename = module_name;
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


#ifndef EIF_WIN_31
	/* Check if the user wants to override the default timeout value
	 * for interprocess communications. This new value is specified in
	 * the EIF_TIMEOUT environment variable
	 */
	eif_timeout = getenv("EIF_TIMEOUT");
	if (eif_timeout != (char *) 0)		/* Environment variable set */
		TIMEOUT = (unsigned) atoi(eif_timeout);
	else
		TIMEOUT = 120;
#endif


#ifdef WORKBENCH
	xinitint();							/* Interpreter initialization */
	dispatch = fdispatch;				/* Initialize run-time table pointers */
	esystem = fsystem;
	ecall = fcall;
	eoption = foption;
	co_table = fco_table;
	eorg_table = forg_table;
	pattern = fpattern;

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

#ifdef EIF_WIN_31
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

#else

	/*
	 * Initialize the finalized system with the static data structures.
	 * These may be updated later on by loading DLE system.
	 */
	esystem = fsystem;
	co_table = fco_table;
	nbref = fnbref;
	esize = fsize;

#endif

#ifdef EIF_WIN_31
	umain(_argc, _argv, envp);			/* User's initializations */
	arg_init(_argc, _argv);				/* Save copy for class ARGUMENTS */
#else
	umain(argc, argv, envp);			/* User's initializations */
	arg_init(argc, argv);				/* Save copy for class ARGUMENTS */
#endif
}

rt_public void failure(void)
{
	/* A fatal Eiffel exception has occurred. The stack of exceptions is dumped
	 * and the memory is cleaned up, if possible.
	 */
	
	trapsig(emergency);					/* Weird signals are trapped */
	esfail(MTC_NOARG);							/* Dump the execution stack trace */

#ifdef EIF_WINDOWS
	show_trace();
#endif

	reclaim();							/* Reclaim all the objects */
	exit(1);							/* Abnormal termination */

	/* NOTREACHED */
}

rt_private Signal_t emergency(int sig)
{
	/* A signal has been trapped while we were failing peacefully. The memory
	 * must really be in a desastrous state, so print out a give-up message
	 * and exit.
	 */
	
	print_err_msg(stderr, "\n\n%s: PANIC: caught signal #%d (%s) -- Giving up...\n",
		ename, sig, signame(sig));

#ifdef EIF_WINDOWS
	show_trace();
#endif

	exit(2);							/* Really abnormal termination */

	/* NOTREACHED */
}

#ifdef NOHOOK

/* When no debugging is allowed, the file network.o is not part of the
 * archive. However, we need to define dummy dserver() and dinterrupt() entries.
 */

rt_public void dserver(void) {}
rt_public void dinterrupt(void) {}
#endif

rt_public void dexit(int code)
{
	/* This routine is called by functions from libipc.a to raise immediate
	 * termination with a chance to trap the action and perform some clean-up.
	 * Here we call esdie() which will collect all the Eiffel objects and
	 * eventually call dispose() on some of them.
	 */

	esdie(code);						/* Propagate dying request */
}


