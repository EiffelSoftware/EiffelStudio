/*

  ####      #     ####            ####
 #          #    #    #          #    #
  ####      #    #               #
      #     #    #  ###   ###    #
 #    #     #    #    #   ###    #    #
  ####      #     ####    ###     ####

	Signal handling and filtering.

	If this file is compiled with -DTEST, it will produce a standalone
	executable.
*/

#if defined USE_BSD_SIGNALS || defined EIF_SGI
#	define _BSD_SIGNALS /* For sgi */
#endif

#include "eif_portable.h"
#include "eif_except.h"
#include "eif_sig.h"
#include <signal.h>
#include <errno.h>
#include <stdio.h>				/* For sprintf() */
#include <string.h>

#if !defined sigmask
#define sigmask(m)	(1<<((m)-1))
#endif

/* For debugging */
/*#define DEBUG 1 */		/**/
#define dprintf(n)		if (DEBUG & (n)) printf

#define DESC_LEN	29		/* Maximum length for signal description */

/* Array of signal handlers used by the run-time to dispatch signals as they
 * arrive. The array is modified via class EXCEPTION. If no signal handler
 * is provided, then the signal is delivered to the process after beeing
 * reset to its default behaviour (of course, we do this only when the
 * default behaviour is not SIG_IGN).
 */
rt_public Signal_t (*esig[EIF_NSIG])(int);	/* Array of signal handlers */

#ifndef EIF_THREADS

/* Records whether a signal is ignored by default or not. Some of these
 * values where set during the initialization, others were hardwired. We also
 * record the original signal status to know whether by default a signal is
 * ignored or not.
 */
rt_public char sig_ign[EIF_NSIG];			/* Is signal ignored by default? */
rt_public char osig_ign[EIF_NSIG];		/* Original signal default (1 = ignored) */

/* Global signal handler status. If set to 0, then signal handler is activated
 * an normal processing occurs. Otherwise, signals are queued if they are not
 * ignored, for later processing.
 */
rt_shared int esigblk = 0;			/* By default, signals are not blocked */

/* The FIFO stack (circular buffer) used to record arrived signals while
 * esigblk was set (for instance, while in the garbage collector).
 */
rt_shared struct s_stack sig_stk;		/* Initialized by initsig() */

#endif /* EIF_THREADS */

/* Routine declarations */
rt_public char *signame(int sig);				/* Give English description of a signal */
rt_public Signal_t ehandlr(EIF_CONTEXT register int sig);			/* Eiffel main signal handler */
rt_public Signal_t exfpe(int sig);			/* Floating point exception handler */
rt_private int dangerous(int sig);			/* Is a given signal dangerous for us? */
rt_shared void esdpch(EIF_CONTEXT_NOARG);				/* Dispatch queued signals */
rt_shared void initsig(void);				/* Run-time initialization for trapping */
rt_private void spush(int sig);				/* Queue signal in a FIFO stack */
rt_private int spop(void);					/* Extract signals from queued stack */

/* Compiled with -DTEST, we turn on DEBUG if not already done */
#ifdef TEST
#ifndef DEBUG
#define DEBUG	1		/* Highest debug level */
#endif
#endif

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

/*
 * Signal handler routines.
 */

rt_public Signal_t ehandlr(EIF_CONTEXT register int sig)
{
	/* Eiffel signal handler -- all the signals that can be caught let the
	 * process jump to this routine, which is in charge of dispatching the
	 * signal or simply ignoring it.
	 */
	EIF_GET_CONTEXT
	Signal_t (*handler)(int);			/* The Eiffel signal handler routine */

#ifndef SIGNALS_KEPT
	(void) signal(sig, ehandlr);	/* Restore catching if disarmed */
#endif

	if (sig_ign[sig])				/* If signal is to be ignored */
		return;						/* Nothing to be done */

	if (esigblk) {					/* Signals are blocked */
		if (dangerous(sig))			/* Harmful signal in critical section */
			eif_panic(MTC "unexpected harmful signal");
		spush(sig);					/* Record sig on FIFO stack */
		return;						/* That's all for now */
	}

	/* With BSD reliable signals, further instances of the signal we received
	 * are blocked until this function returns or a longjmp (not _longjmp) is
	 * issued (which restores the signal mask at the time setjmp was issued).
	 * Under USG, race condition may occur--RAM.
	 */

	handler = esig[sig];			/* Fetch signal handler's address */
	if (handler) {					/* There is a signal handler */
		esigblk++;					/* Queue further signals */
		exhdlr(MTC handler, sig);		/* Call handler */
		esigblk--;					/* Restore signal handling */
	} else {						/* Signal not caught -- raise exception */

		/* On BSD systems (those with sigvec() facilities), we have to clear
		 * the signal mask for the signal received. That way, it is possible
		 * to use _setjmp and _longjmp for exception handling. If we did not
		 * reset the signal, either we would have to use setjmp/longjmp or
		 * we could only receive one occurrence of a signal--RAM.
		 */

#ifdef HAS_SIGSETMASK
		int oldmask;	/* To get old signal mask */ /* %%ss moved from above */
		oldmask = sigsetmask(0xffffffff);	/* Fetch old signal mask */
		oldmask &= ~sigmask(sig);			/* Unblock signal */
		(void) sigsetmask(oldmask);			/* Resynchronize signal mask */
#endif

		echsig = sig;				/* Signal's number */
		xraise(EN_SIG);				/* Operating system signal */
	}
}

rt_public Signal_t exfpe(int sig)
{
	/* Raise a floating point exception */

	/* The following is really important. It is a small part of the code, but
	 * it will make the difference on BSD systems, allowing us to use the
	 * _longjmp and _setjmp routines which do not do any system call.
	 */

	EIF_GET_CONTEXT

#ifdef HAS_SIGSETMASK
	int oldmask;	/* Signal mask value */ /* %%ss moved from above */

		oldmask = sigsetmask(0xffffffff);	/* Fetch old signal mask */
		oldmask &= ~sigmask(sig);			/* Unblock signal */
		(void) sigsetmask(oldmask);			/* Resynchronize signal mask */
#endif

#ifndef SIGNALS_KEPT
	(void) signal(sig, exfpe);	/* Restore catching if disarmed */
#endif

	if (sig_ign[sig])				/* If signal is to be ignored */
		return;						/* Nothing to be done */

	xraise(EN_FLOAT);		/* Raise a floating point exception */
}

rt_shared void trapsig(Signal_t (*handler) (int))
                      		/* The signal handler provided */
{
	/* This routine is usually called only by the main() when something wrong
	 * happened. All the signals are trapped and redirected to the supplied
	 * handler. Only SIGQUIT, SIGINT and SIGTSTP receive a special treatment.
	 */

	int sig;						/* Signal number to be set */

	for (sig = 1; sig < EIF_NSIG; sig++)
#ifdef EIF_THREADS
	/* In Multi-threaded mode, we do not want to call
     * signal () on some specific signals.
	 */

	switch (sig) {
	
#ifdef EIF_DFLT_SIGUSR
		/* So far, used in Linux threads */
		case SIGUSR1:
			break;

		case SIGUSR2:
			break;
#endif /* EIF_DFLT_SIGUSR */

#ifdef EIF_DFLT_SIGVTALARM
		/* So far, used in PCTHREADS (obsolete, anyway) */
		case SIGVTALRM:
			break;
#endif /* EIF_DFLT_SIGVTALARM */

#ifdef EIF_DFLT_SIGPTRESCHED
		/* So far, used in Posix 1003.1c threads */
		case SIGPTRESCHED:
			break;
#endif /* EIF_DFLT_SIGPTRESCHED */

#ifdef EIF_DFLT_SIGPTINTR
		/* So far, used in Posix 1003.1c */
		case SIGPTINTR:
			break;
#endif /* EIF_DFLT_SIGPTINTR */

#ifdef EIF_DFLT_SIGRTMIN
		/* So far, used in Posix 1003.1b */
		case SIGRTMIN:
			break;
#endif /* EIF_DFLT_SIGRTMIN */

#ifdef EIF_DFLT_SIGRTMAX
		/* So far, used in Posix 1003.1b */
		case SIGRTMAX:
			break;
#endif /* EIF_DFLT_SIGRTMAX */

#ifdef EIF_DFLT_SIGWAITING 
		/* So far, used in solaris threads (SunOS 5.5+ and Unixware 2.0)
		 * On solaris 2.4, it is not used, which is a bug of the thread lib 
		 */
		case SIGWAITING:
			break;
#endif /* EIF_DFLT_SIGWAITING */

/*#ifdef VXWORKS
		case 34528:
			break;
*/
		default:
		(void) signal(sig, handler);	/* Ignore EINVAL errors */
	}			
#else
		(void) signal(sig, handler);	/* Ignore EINVAL errors */
#endif	/* EIF_THREADS */

	/* Do not catch SIGTSTP (stop signal from tty like ^Z under csh or ksh)
	 * otherwise job control will not be allowed. However, SIGSTOP is caught.
	 * Idem for continue signal SIGCONT.
	 */

#ifdef SIGTSTP
	(void) signal(SIGTSTP, SIG_DFL);	/* Restore default behaviour */
#endif
#ifdef SIGCONT
	(void) signal(SIGCONT, SIG_DFL);	/* Restore default behaviour */
#endif
}

rt_private int dangerous(int sig)
{
	/* Return true if the signal 'sig' is dangerous, false otherwise. A signal
	 * is thought as being dangerous if it may be caused by a corrupted memory
	 * or data segment.
	 */

	if (sig == 0)						/* Dummy to enable 'else if' tests */
		return 0;
#ifdef SIGILL
	else if (sig == SIGILL)				/* Illegal instruction */
		return 1;
#endif
#ifdef SIGBUS
	else if (sig == SIGBUS)				/* Bus error */
		return 1;
#endif
#ifdef SIGSEGV
	else if (sig == SIGSEGV)			/* Segmentation violation */
		return 1;
#endif

	return 0;			/* Signal is not dangerous for us */
}

/*
 * Dispatching queued signals.
 */

rt_shared void esdpch(EIF_CONTEXT_NOARG)
{
	/* Dispatches any pending signal in a FIFO manner as if the signal was
	 * being received now. We knwo the signal was not meant to be ignored,
	 * otherwise it would not have been queued.
	 */
	EIF_GET_CONTEXT
	Signal_t (*handler)(int);			/* The Eiffel signal handler routine */
	int sig;						/* Signal number to be sent */

	/* Note that all the signal queued here have their corresponding bit in
	 * the signal mask cleared, because the handler which queued them have
	 * returned since then--RAM.
	 */

	while ((sig = spop())) {		/* While there are some buffered signals */
		handler = esig[sig];		/* Fetch signal handler's address */
		if (handler) {				/* There is a signal handler */
			esigblk++;				/* Queue further signals */
			exhdlr(MTC handler, sig);	/* Call handler */
			esigblk--;				/* Restore signal handling */
		} else {					/* Signal not caught -- raise exception */
			echsig = sig;			/* Signal's number */
			xraise(EN_SIG);			/* Operating system signal */
		}
	}
}

/*
 * Kernel signal interface.
 */

rt_public Signal_t (*esignal(int sig, Signal_t (*func) (int)))(int)
        				/* Signal to handle */
                   		/* Handler to be associated with signal */
{
	/* Set-up a signal handler for a specific signal and return the previous
	 * handler. This routine behaves exactly as its kernel counterpart, except
	 * that it knows about the run-time data structures.
	 * NB: when signal handlers are installed via this interface, they are
	 * automatically reinstanciated by the run-time (although race conditions
	 * may occur if this is not done by the kernel).
	 */
	EIF_GET_CONTEXT
	Signal_t (*oldfunc)(int);		/* Previous signal handler set */
	int ignored;				/* Ignore status for previous handler */

	if (sig >= EIF_NSIG)
		return ((Signal_t (*)(int)) -1); /* %%ss added cast int */

	oldfunc = esig[sig];		/* Get previous handler */
	ignored = sig_ign[sig];		/* Was signal ignored? */

	if (func == SIG_IGN)		/* Signal is to be ignored */
		sig_ign[sig] = 1;
	else if (func == SIG_DFL) {	/* Default behaviour to be restored */
		sig_ign[sig] = osig_ign[sig];
		esig[sig] = (Signal_t (*)(int)) 0; /* %%ss added cast int */
	} else {
		sig_ign[sig] = 0;		/* Do not ignore this signal */
		esig[sig] = func;		/* Signal handler to be called */
	}

	/* Now set up the return value we would expect from the kernel routine.
	 * If the signal was ignored, SIG_IGN is returned. If a null handler was
	 * present, SIG_DFL is returned. Otherwise return the handler's address.
	 */

	if (ignored)
		oldfunc = SIG_IGN;
	else if (oldfunc == (Signal_t (*)(int)) 0)
		oldfunc = SIG_DFL;

	return oldfunc;				/* Previous signal handler */
}

#ifndef HAS_SIGVEC
#ifndef HAS_SIGVECTOR
rt_public int esigvec(void)
{
	/* The sigvec() kernel interface (named sigvector() on HP-UX, thanks HP)
	 * is missing. This raises an external event exception.
	 */

	eraise("sigvec() absent", EN_EXT); 
/* NOT REACHED */
	return -1;
}
#else
#define HAS_SIGVEC
#endif
#endif

#ifdef HAS_SIGVEC
rt_public int esigvec(int sig, struct sigvec *vec, struct sigvec *ovec)
{
	/* This routine is a wrapper to the kernel sigvec() routine. This is needed
	 * since all the signals are nornally trapped by the run-time first, and
	 * the user must not bypass that control or the semantics of signal
	 * reception will no longer be well-defined.
	 */

	EIF_GET_CONTEXT
	Signal_t (*oldfunc)(int);		/* Previous signal handler set */
	/*	int ignored;	*/			/* Ignore status for previous handler */

	if (sig >= EIF_NSIG) {		/* Bad signal, don't bother issuing system call */
		errno = EINVAL;
		return -1;
	}

	/* The user cannot, repeat, cannot set his own routine as a signal handler.
	 * All the handling is done through the run-time ehandler(). The user-
	 * defined handler is recorded in the esig[] array.
	 */

	if (vec != (struct sigvec *) 0) {
		oldfunc = esignal(sig, vec->sv_handler);	/* Record new handler */
		vec->sv_handler = ehandlr;					/* Force wrapper handler */
	} else {
		if (sig_ign[sig])
			oldfunc = SIG_IGN;
		else if (esig[sig] == (Signal_t (*)()) 0)
			oldfunc = SIG_DFL;
		else
			oldfunc = esig[sig];
	}

#ifdef HAS_SIGVECTOR
	if (-1 == sigvector(sig, vec, ovec))
		return -1;
#else
	if (-1 == sigvec(sig, vec, ovec))
		return -1;
#endif

	/* Make sure the user receives a meaningful value, i.e. not the wrapper
	 * handler but the user-defined handler installed, thus making the
	 * run-time layer completely transparent.
	 */

	if (ovec != (struct sigvec *) 0)
		ovec->sv_handler = oldfunc;

	return 0;		/* Call succeeded */
}
#endif

/*
 * Initialization section.
 */

rt_shared void initsig(void)
{
	/* This routine should be called by the main() of the Eiffel program to
	 * properly initialize signals. This code is thus executed only once
	 * and was made as short as possible--RAM.
	 */
	EIF_GET_CONTEXT
	register1 int sig;				/* To loop over the signals */
	register2 Signal_t (*old)();	/* Old signal handler */

	/* Initialize the signal stack (circular buffer). The last read location is
	 * set to SIGSTACK - 1 (i.e. at the end of the array) while the first free
	 * location is 0 (i.e. first item in the array).
	 */
	sig_stk.s_min = SIGSTACK - 1,	/* Last read location */
	sig_stk.s_max = 0;				/* First free location */
	sig_stk.s_pending = '\0';		/* No signals pending yet */

	for (sig = 1; sig < EIF_NSIG; sig++) {
#ifdef EIF_THREADS
	/* In Multi-threaded mode, we do not want to call
     * signal () on some specific signals.
	 */

	old = SIG_IGN;

	switch (sig) {
	
#ifdef EIF_DFLT_SIGUSR
		/* So far, used in Linux threads */
		case SIGUSR1:
			break;

		case SIGUSR2:
			break;
#endif /* EIF_DFLT_SIGUSR */

#ifdef EIF_DFLT_SIGVTALARM
		/* So far, used in PCTHREADS (obsolete, anyway) */
		case SIGVTALRM:
			break;
#endif /* EIF_DFLT_SIGVTALARM */

#ifdef EIF_DFLT_SIGPTRESCHED
		/* So far, used in Posix 1003.1c threads */
		case SIGPTRESCHED:
			break;
#endif /* EIF_DFLT_SIGPTRESCHED */

#ifdef EIF_DFLT_SIGPTINTR
		/* So far, used in Posix 1003.1c */
		case SIGPTINTR:
			break;
#endif /* EIF_DFLT_SIGPTINTR */

#ifdef EIF_DFLT_SIGRTMIN
		/* So far, used in Posix 1003.1b */
		case SIGRTMIN:
			break;
#endif /* EIF_DFLT_SIGRTMIN */

#ifdef EIF_DFLT_SIGRTMAX
		/* So far, used in Posix 1003.1b */
		case SIGRTMAX:
			break;
#endif /* EIF_DFLT_SIGRTMAX */

#ifdef EIF_DFLT_SIGWAITING 
		/* So far, used in solaris threads (SunOS 5.5+ and Unixware 2.0)
		 * On solaris 2.4, it is not used, which is a bug of the thread lib 
		 */
		case SIGWAITING:
			break;
#endif /* EIF_DFLT_SIGWAITING */

/*#ifdef VXWORKS
		case 34528:
			break;
*/
#if defined  PROFILED_RUNTIME && defined SIGPROF
		/* When profiling the run-time, we must not  
		 * catch this signal.
		 */
		case SIGPROF:
			break;
#endif /* PROFILED_RUN_TIME */

		default:
			if (esigdefined (sig) == (char) 1) 
				old = signal(sig, ehandlr);		/* Ignore EINVAL errors */
	}			
#else
		if (esigdefined (sig) == (char) 1) 
#if defined PROFILED_RUNTIME && defined SIGPROF
			if (sig != SIGPROF)
#endif
				old = signal(sig, ehandlr);		/* Ignore EINVAL errors */
#endif	/* EIF_THREADS */
		if (old == SIG_IGN)
			sig_ign[sig] = 1;			/* Signal was ignored by default */
		else
			sig_ign[sig] = 0;			/* Signal was not ignored */
		esig[sig] = (Signal_t (*)(int)) 0;	/* No Eiffel handler provided yet */ /* %%ss added cast int */
	}

	/* Hardwired defaults: ignore SIGCHLD (or SIGCLD), SIGIO, SIGURG, SIGCONT
	 * and SIGWINCH if they are defined. That is to say, the Eiffel run-time
	 * will not deliver these to the process if the user does not explicitely
	 * set a handler for them.
	 */

#ifdef SIGCHLD
	sig_ign[SIGCHLD] = 1;			/* Ignore death of a child */
	signal(SIGCHLD, SIG_DFL);		/* Restore the default value */
#endif
#ifdef SIGCLD
	sig_ign[SIGCLD] = 1;			/* Ignore death of a child */
#endif
#ifdef SIGIO
	sig_ign[SIGIO] = 1;				/* Ignore pending I/O on descriptor */
#endif
#ifdef SIGCONT
	sig_ign[SIGCONT] = 1;			/* Ignore continue after a stop */
#endif
#ifdef SIGURG
	sig_ign[SIGURG] = 1;			/* Ignore urgent condition on socket */
#endif
#ifdef SIGWINCH
	sig_ign[SIGWINCH] = 1;			/* Ignore window size change */
	(void) signal(SIGWINCH, SIG_IGN);
#endif
#ifdef SIGTTIN
	sig_ign[SIGTTIN] = 1;			/* Ignore background input signal */
	(void) signal(SIGTTIN, SIG_IGN);
#endif
#ifdef SIGTTOU
	sig_ign[SIGTTOU] = 1;			/* Ignore background output signal */
	(void) signal(SIGTTOU, SIG_IGN);
#endif

	/* Do not catch SIGTSTP (stop signal from tty like ^Z under csh or ksh)
	 * otherwise job control will not be allowed. However, SIGSTOP is caught.
	 * Likewise, do not catch SIGCONT (continue signal for stopped process).
	 */

#ifdef SIGTSTP
	sig_ign[SIGTSTP] = 0;				/* Do not ignore that signal */
	(void) signal(SIGTSTP, SIG_DFL);	/* Restore default behaviour */
#endif
#ifdef SIGCONT
	sig_ign[SIGCONT] = 0;				/* Do not ignore continue signal */
	(void) signal(SIGCONT, SIG_DFL);	/* Restore default behaviour */
#endif

	/* It would not be wise to catch SIGTRAP: C debuggers may use this signal
	 * to do step-by-step execution and we do not want the Eiffel run-time
	 * to interfere with this particular low-level signal--RAM.
	 */

#ifdef SIGTRAP
	sig_ign[SIGTRAP] = 0;	/* Do not ignore Trap signal */
#	ifdef EIF_SGI
		/* On some platforms (sgi), SIGTRAP is used as a
		 * Integer-Division-By-Zero signal
		 */
		(void) signal(SIGTRAP, ehandlr);	
#	else
		(void) signal(SIGTRAP, SIG_DFL);	/* Restore default behaviour */
		
#	endif /* EIF_SGI */
#endif

	/* Special treatment for SIGFPE -- always raise an Eiffel exception when
	 * it is caught (unless exception is explicitely ignored, but that's the
	 * handler's problem).
	 */

#ifdef SIGFPE
	sig_ign[SIGFPE] = 0;			/* Do not ignore a floating point signal */
	(void) signal(SIGFPE, exfpe);	/* Raise an Eiffel exception when caught */
#endif

	/* Now save all the defaults in the special original status array, in order
	 * for the run-time to know what to do when a signal is restored to its
	 * "default" state.
	 */

	for (sig = 1; sig < EIF_NSIG; sig++)
		osig_ign[sig] = sig_ign[sig];
}

/*
 * Eiffel signal's FIFO stack.
 */

rt_private void spush(int sig)
{
	/* Record a signal in the FIFO stack for deferred handling. If the buffer
	 * is full, we panic immediately (I chose to hardwire size, alas--RAM).
	 * As the writing in the structure can't be made atomic, unless there
	 * are BSD reliable signals out there, race conditions may occur and lead
	 * to duplicate signals and/or losses--RAM.
	 */
	EIF_GET_CONTEXT
#ifdef HAS_SIGSETMASK
	 int oldmask;	/* To save old signal blocking mask */ /* %%ss addded #if ..#endif */
#endif
	static char desc[DESC_LEN + 1];	/* Signal's description for panic */

#ifdef DEBUG
	dprintf(1)("spush: max = %d, min = %d, signal = %d\n",
		sig_stk.s_max, sig_stk.s_min, sig);
#endif

	if (sig_stk.s_max == sig_stk.s_min)
		eif_panic(MTC "signal stack overflow");
	
	/* We do not stack multiple consecutive occurrences of the same signal (the
	 * kernel doesn't do that anyway), and "dangerous" signals raise a panic
	 * rather than being stacked if the default Eiffel handler is on.
	 */
	if (dangerous(sig) && esig[sig] == (Signal_t (*)(int)) 0) { /* %%ss added cast int */
		sprintf(desc, "%s", signame(sig));	/* Translate into English name */
		eif_panic(MTC desc);						/* And raise a run-time eif_panic */
	} else {
		int last = (sig_stk.s_max ? sig_stk.s_max : SIGSTACK) - 1;
		if (sig == sig_stk.s_buf[last])
			return;							/* Same signal already on top */
	}
#ifdef HAS_SIGSETMASK
	oldmask = sigsetmask(0xffffffff);		/* Block 31 signals */
#endif

	/* The following section is protected against being interrupted by other
	 * signals if HAS_SIGSETMASK is defined. Otherwise, it's time to pray--RAM.
	 */
	sig_stk.s_buf[sig_stk.s_max++] = (char) sig;	/* Signal < 128 */
	if (sig_stk.s_max >= SIGSTACK)			/* Reached the right end */
		sig_stk.s_max = 0;					/* Back to left end */

	sig_stk.s_pending = 1;				/* A signal is pending */

#ifdef HAS_SIGSETMASK
	(void) sigsetmask(oldmask);			/* Restore old mask */
#endif
}

rt_private int spop(void)
{
	/* Pops off a signal from the FIFO stack and returns its value. If the
	 * stack is empty, return 0.
	 */
	EIF_GET_CONTEXT
	register1 int newpos;		/* Position we'll go to if we read something */
	int cursig;					/* Current signal to be sent */

#ifdef HAS_SIGSETMASK
	int oldmask;				/* To save old signal blocking mask */ /* %%ss moved from above */
	oldmask = sigsetmask(0xffffffff);		/* Block 31 signals */
#endif

	/* The following section is protected against being interrupted by other
	 * signals if HAS_SIGSETMASK is defined. Otherwise, nothing guaranteed--RAM.
	 */
	newpos = sig_stk.s_min + 1;	/* s_min is the last successfully read pos */
	if (newpos >= SIGSTACK)			/* If we overflow */
		newpos = 0;					/* Go back to the left end */

	if (sig_stk.s_max == newpos) {	/* Nothing to be read */
#ifdef HAS_SIGSETMASK
		(void) sigsetmask(oldmask);	/* Restore old mask */
#endif
		sig_stk.s_pending = 0;		/* No more pending signals */
		return 0;					/* Return end of stack condition */
	}
	
	/* Now update the stack structure and do not forget to "clear" the last
	 * signal on the stack (i.e. the one we are about to deal with). This is
	 * actually only important when that signal is the only pending one,
	 * because spush() makes sure we are not queuing two consecutives occurrences
	 * of the same signal, and the location checked is the one before s_max.
	 */

	sig_stk.s_min = newpos;			/* Update last read position */
	cursig = (int) sig_stk.s_buf[newpos];
	sig_stk.s_buf[newpos] = 0;		/* Clear "last" signal on stack */

#ifdef DEBUG
	dprintf(1)("spop: returning signal #%d\n", cursig);
#endif

#ifdef HAS_SIGSETMASK
	(void) sigsetmask(oldmask);		/* Restore old mask */
#endif

	return cursig;			/* Signal to be dealt with */
}

/*
 * Signal meaning (English description of a signal).
 */

struct sig_desc {			/* Signal description structure */
	int idx;				/* Index for Eiffel/C mapping */
	int s_num;				/* Signal number */
	char *s_desc;			/* English description */
};

/* The following array describes the signals. Instead of having a big switch
 * and #ifdef'ed cases, it is best to have the structure sig_desc. True, we
 * need a linear look-up to find the description, but many systems overload
 * signals, so the switch statement would be quickly un-manageable--RAM.
 * Message limit is 28 char..., sorry (to get a nice execution stack).
 */

rt_private struct sig_desc sig_name[] = {
#ifdef SIGHUP
	{ 1, SIGHUP, "Hangup" },
#endif
#ifdef SIGINT
	{ 2, SIGINT, "Interrupt" },
#endif
#ifdef SIGQUIT
	{ 3, SIGQUIT, "Quit" },
#endif
#ifdef SIGILL
	{ 4, SIGILL, "Illegal instruction" },
#endif
#ifdef SIGTRAP
#	ifdef EIF_SGI
	{ 5, SIGTRAP, "Trace trap or Divide-by-zero" },
#	else
	{ 5, SIGTRAP, "Trace trap" },
#	endif	/* EIF_SGI */
	
#endif
#ifdef SIGABRT
	{ 6, SIGABRT, "Abort" },
#endif
#ifdef SIGIOT
	{ 7, SIGIOT, "IOT instruction" },
#endif
#ifdef SIGEMT
	{ 8, SIGEMT, "EMT instruction" },
#endif
#ifdef SIGFPE
	{ 9, SIGFPE, "Floating point exception" },
#endif
#ifdef SIGKILL
	{ 10, SIGKILL, "Terminator" },
#endif
#ifdef SIGBUS
	{ 11, SIGBUS, "Bus error" },
#endif
#ifdef SIGSEGV
	{ 12, SIGSEGV, "Segmentation violation" },
#endif
#ifdef SIGSYS
	{ 13, SIGSYS, "Bad argument to system call" },
#endif
#ifdef SIGPIPE
	{ 14, SIGPIPE, "Broken pipe" },
#endif
#ifdef SIGALRM
	{ 15, SIGALRM, "Alarm clock" },
#endif
#ifdef SIGTERM
	{ 16, SIGTERM, "Software termination" },
#endif
#ifdef SIGUSR1
	{ 17, SIGUSR1, "User-defined signal #1" },
#endif
#ifdef SIGUSR2
	{ 18, SIGUSR2, "User-defined signal #2" },
#endif
#ifdef SIGCHLD
	{ 19, SIGCHLD, "Death of a child" },
#endif
#ifdef SIGCLD
	{ 20, SIGCLD, "Death of a child" },
#endif
#ifdef SIGIO
	{ 21, SIGIO, "Pending I/O on a descriptor" },
#endif
#ifdef SIGPOLL
	{ 22, SIGPOLL, "Selectable event pending" },
#endif
#ifdef SIGTTIN
	{ 23, SIGTTIN, "Tty input from background" },
#endif
#ifdef SIGTTOU
	{ 24, SIGTTOU, "Tty output from background" },
#endif
#ifdef SIGSTOP
	{ 25, SIGSTOP, "Stop" },
#endif
#ifdef SIGTSTP
	{ 26, SIGTSTP, "Stop from tty" },
#endif
#ifdef SIGXCPU
	{ 27, SIGXCPU, "Cpu time limit exceeded" },
#endif
#ifdef SIGXFSZ
	{ 28, SIGXFSZ, "File size limit exceeded" },
#endif
#ifdef SIGVTALRM
	{ 29, SIGVTALRM, "Virtual time alarm" },
#endif
#ifdef SIGPWR
	{ 30, SIGPWR, "Power-fail" },
#endif
#ifdef SIGPROF
	{ 31, SIGPROF, "Profiling timer alarm" },
#endif
#ifdef SIGWINCH
	{ 32, SIGWINCH, "Window size changed" },
#endif
#ifdef SIGWIND
	{ 33, SIGWIND, "Window change" },
#endif
#ifdef SIGPHONE
	{ 34, SIGPHONE, "Line status change" },
#endif
#ifdef SIGLOST
	{ 35, SIGLOST, "Resource lost" },
#endif
#ifdef SIGURG
	{ 36, SIGURG, "Urgent condition on socket" },
#endif
#ifdef SIGCONT
	{ 37, SIGCONT, "Continue after stop" },
#endif
#ifdef SIGBREAK
	{ 38, SIGBREAK, "Ctrl-Break"},
#endif
	{ 39, 0, "Unknown signal" }
};

rt_public char *signame(int sig)
{
	/* Returns a description of a signal given its number. If sys_siglist[]
	 * is available and gives a non-null description, then use it. Otherwise
	 * use our own description as found in the sig_name array.
	 */

	int i;

#ifdef HAS_SYS_SIGLIST
	if (sig >= 0 && sig < EIF_NSIG && 0 < (unsigned int)strlen(sys_siglist[sig]))
		return (char *) sys_siglist[sig];
#endif

	for (i = 0; /*empty */; i++)
		if (sig == sig_name[i].s_num || 0 == sig_name[i].s_num)
			return sig_name[i].s_desc;
}

/*
 * Eiffel interface
 */

rt_public long esigmap(long int idx)
{
	/* C signal code for signal of index `idx' */

	int i;

	for (i = 0; /*empty */ ; i++)
		if (((int) idx) == sig_name[i].idx || 0 == sig_name[i].s_num)
			return (long) (sig_name[i].s_num);
}

rt_public char *esigname(long int sig)
{
	/* Returns a description of a signal given its number. If sys_siglist[]
	 * is available and gives a non-null description, then use it. Otherwise
	 * use our own description as found in the sig_name array.
	 * Same as `signame' with proper casting for Eiffel.
	 */

	return (signame((int) sig));
} 

rt_public long esignum(EIF_CONTEXT_NOARG)	/* %%zmt never called in C dir. */
{
	/* Number of last signal */
	EIF_GET_CONTEXT

	return (long) echsig;
}

rt_public void esigcatch(long int sig)
{
	EIF_GET_CONTEXT
	/* Catch signal `sig'.
	 * Check that the signal is defined
	 */

	if (!(esigdefined(sig) == (char) 1))
		return;

	/* We may not change the status of SIGPROF because it is possible
	 * that we do (run-time) external profiling. Changing the catch
	 * status of this signal means that profiling stops.
	 */

#ifdef SIGPROF
	if (sig == SIGPROF)
		return;
#endif

	sig_ign[sig] = 0;
#ifdef SIGTTIN
	if (sig == SIGTTIN) {
		(void) signal(SIGTTIN, SIG_DFL);	/* Ignore background input signal */
		return;
	}
#endif
#ifdef SIGTTOU
	if (sig == SIGTTOU) {
		(void) signal(SIGTTOU, SIG_DFL);	/* Ignore background output signal */
		return;
	}
#endif
#ifdef SIGTSTP
	if (sig == SIGTSTP) {
		(void) signal(SIGTSTP, SIG_DFL);	/* Restore default behaviour */
		return;
	}
#endif
#ifdef SIGCONT
	if (sig == SIGCONT) {
		(void) signal(SIGCONT, SIG_DFL);	/* Restore default behaviour */
		return;
	}
#endif
#ifdef SIGTRAP
	if (sig == SIGTRAP) {
#	ifdef EIF_SGI
		(void) signal(SIGTRAP, ehandlr); 	/* Integer-Division-by-Zero on sgi */
#	else
		(void) signal(SIGTRAP, SIG_DFL);	/* Restore default behaviour */
#	endif 	/* EIF_SGI */

		return;
	}
#endif
#ifdef SIGFPE
	if (sig == SIGFPE) {
		(void) signal(SIGFPE, exfpe);		/* Raise an Eiffel exception when caught */
		return;
	}
#endif
}

rt_public void esigignore(long int sig)
{
	EIF_GET_CONTEXT
	/* Ignore signal `sig'.
	 * Check that the signal is defined
     */

	if (!(esigdefined(sig) == (char) 1))
		return;

	/* We may not change the status of SIGPROF because it is possible
	 * that we do (run-time) external profiling. Changing the catch
	 * status of this signal means that profiling stops.
	 */

#ifdef SIGPROF
	if (sig == SIGPROF)
		return;
#endif

	sig_ign[sig] = 1;
#ifdef SIGTTIN
	if (sig == SIGTTIN) {
		(void) signal(SIGTTIN, SIG_IGN);	
		return;
	}
#endif
#ifdef SIGTTOU
	if (sig == SIGTTOU) {
		(void) signal(SIGTTOU, SIG_IGN);
		return;
	}
#endif
#ifdef SIGTSTP
	if (sig == SIGTSTP) {
		(void) signal(SIGTSTP, SIG_IGN);
		return;
	}
#endif
#ifdef SIGCONT
	if (sig == SIGCONT) {
		(void) signal(SIGCONT, SIG_IGN);
		return;
	}
#endif
#ifdef SIGTRAP
	/* Not necessary on SGI since it is handled by ehandlr by default */
	if (sig == SIGTRAP) {
		(void) signal(SIGTRAP, SIG_IGN);
		return;
	}
#endif
#ifdef SIGFPE
	if (sig == SIGFPE) {
		(void) signal(SIGFPE, SIG_IGN);	
		return;
	}
#endif
}

rt_public char esigiscaught(long int sig)
{
	EIF_GET_CONTEXT
	/* Is signal of number `sig' caught?
	 * Check that the signal is defined
     */

	if (esigdefined(sig) == (char) 1)
		return ((sig_ign[sig] == 1)?(char)0:(char)1);
	else
		return (char) 0;
}

rt_public char esigdefined (long int sig)
{
	/* Id signal of number `sig' defined? */

	int i;

	if (sig < 1 || sig > EIF_NSIG-1)
		return (char) 0;
	for (i = 0; /*empty */; i++) {
		if ((int) sig == sig_name[i].s_num) 
			return (char) 1;
		else
			if (0 == sig_name[i].s_num)
				return (char) 0;
	}
}

void esigresall(void)
{
	/* Reset all the signals to their default handling */
	EIF_GET_CONTEXT
	int sig;
	for (sig = 1; sig < EIF_NSIG; sig++)
#ifdef SIGPROF
		if (sig != SIGPROF)
			sig_ign[sig] = osig_ign[sig];
#else
		sig_ign[sig] = osig_ign[sig];
#endif
	
#ifdef SIGTTIN
	(void) signal(SIGTTIN, SIG_IGN);/* Ignore background input signal */
#endif
#ifdef SIGTTOU
	(void) signal(SIGTTOU, SIG_IGN);/* Ignore background output signal */
#endif
#ifdef SIGTSTP
	(void) signal(SIGTSTP, SIG_DFL);	/* Restore default behaviour */
#endif
#ifdef SIGCONT
	(void) signal(SIGCONT, SIG_DFL);	/* Restore default behaviour */
#endif
#ifdef SIGTRAP
#	ifdef EIF_SGI
		(void) signal(SIGTRAP, ehandlr);
#	else
		(void) signal(SIGTRAP, SIG_DFL);	/* Restore default behaviour */
#	endif /* EIF_SGI */
		
#endif
#ifdef SIGFPE
	(void) signal(SIGFPE, exfpe);	/* Raise an Eiffel exception when caught */
#endif
}

void esigresdef(long int sig)
{
	EIF_GET_CONTEXT

	/* Reset signal `sig' to its default handling */
	if (!(esigdefined(sig) == (char) 1))
		return;

	/* We may not change the status of SIGPROF because it is possible
	 * that we do (run-time) external profiling. Changing the catch
	 * status of this signal means that profiling stops.
	 */

#ifdef SIGPROF
	if (sig == SIGPROF)
		return;
#endif

	sig_ign[sig] = osig_ign[sig];
#ifdef SIGTTIN
	if (sig == SIGTTIN) {
		(void) signal(SIGTTIN, SIG_IGN);	/* Ignore background input signal */
		return;
	}
#endif
#ifdef SIGTTOU
	if (sig == SIGTTOU) {
	 	(void) signal(SIGTTOU, SIG_IGN);	/* Ignore background output signal */
		return;
	}
#endif
#ifdef SIGTSTP
	if (sig == SIGTSTP) {
		(void) signal(SIGTSTP, SIG_DFL);	/* Restore default behaviour */
		return;
	}
#endif
#ifdef SIGCONT
	if (sig == SIGCONT) {
		(void) signal(SIGCONT, SIG_DFL);	/* Restore default behaviour */
		return;
	}
#endif
#ifdef SIGTRAP
	if (sig == SIGTRAP) {
#	ifdef EIF_SGI
		(void) signal(SIGTRAP, ehandlr);	/* Restore default behaviour */
#	else
		(void) signal(SIGTRAP, SIG_DFL);	/* Restore default behaviour */
#	endif /* EIF_SGI */
		
		return;
	}
#endif
#ifdef SIGFPE
	if (sig == SIGFPE) {
		(void) signal(SIGFPE, exfpe);		/* Raise an Eiffel exception when caught */
		return;
	}
#endif
}

#ifdef TEST

/* This section implements a set of tests for the signal handling package.
 * It should not be regarded as a model of C programming :-)
 * To run this, compile the file with -DTEST.
 */

struct eif_exception exdata;	/* Exception handling global flags */
rt_private int bufstate(void);	/* Print circular buffer state */

Signal_t test_handler(int sig)
{
	printf("test_handler: caught signal #%d\n", sig);
}

main()
{
	printf("> Starting test for signal handling mechanism.\n");
	printf(">> Initializing signals.\n");
	initsig();
	printf(">> Installing test_handler.\n");
	esig[2] = test_handler;
	printf(">> Sending first signal #2.\n");
	kill(getpid(), 2);
	printf(">> Sending second signal #2.\n");
	kill(getpid(), 2);
	printf(">> Inhibing signals.\n");
	esigblk = 1;
	bufstate();
	printf(">> Sending signal #2.\n");
	kill(getpid(), 2);
	bufstate();
	printf(">> Sending signal #1.\n");
	kill(getpid(), 1);
	bufstate();
	printf(">> Restauring signal handling.\n");
	esigblk = 0;
	if (signal_pending) {
		printf(">> There are signal pending.\n");
	} else {
		printf(">> FAILED!! NO SIGNAL PENDING.\n");
		exit(1);
	}
	printf(">> Dispatching pending signals.\n");
	esdpch();
	bufstate();
	if (signal_pending) {
		printf(">> FAILED!! THERE IS A SIGNAL PENDING.\n");
		exit(1);
	} else {
		printf(">> There are no more signal pending.\n");
	}
#ifdef SIGCHLD
	printf(">> Sending ignored signal SIGCHLD.\n");
	kill(getpid(), SIGCHLD);
#else
	printf(">> Sending ignored signal SIGCLD.\n");
	kill(getpid(), SIGCLD);
#endif
	printf(">> Sending exception raising signal #1.\n");
	kill(getpid(), 1);
	printf("> End of tests.\n");
}

rt_private int bufstate(void)
{
	/* Give circular buffer state */

	printf(">>> Circular buffer: min = %d, max = %d\n",
		sig_stk.s_min, sig_stk.s_max);
}

/* Functions not provided here */
rt_public void eif_panic(char *s)
{
	printf("PANIC: %s\n", s);
	exit(1);
}

rt_public void xraise(int val)
{
	printf("xraise: exception code %d\n", val);
}

rt_public void exhdlr(Signal_t (*handler)(int), int sig)
{
	(handler)(sig);		/* Call handler */
}

#endif
