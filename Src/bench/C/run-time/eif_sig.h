/*

  ####      #     ####           #    #
 #          #    #    #          #    #
  ####      #    #               ######
      #     #    #  ###   ###    #    #
 #    #     #    #    #   ###    #    #
  ####      #     ####    ###    #    #

	Signal handling declarations.

	This file used to be named "signal.h", but that conflicted with the system
	header file which bears the same name... Of course, I had to use some fancy
	'cc -I' commands to really grasp how painful that could be--RAM.
*/

#ifndef _eif_signal_h_
#define _eif_signal_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_globals.h"

/* Testing for pending signals -- if signals are pending, the signal dispatch
 * routine should be called. Tests are made at some strategic points in the
 * run-time to guard against longjmps in signal handlers.
 */
#define signal_pending		sig_stk.s_pending

extern Signal_t ehandlr(EIF_CONTEXT register int sig);			/* Eiffel main signal handler */
extern void esdpch(EIF_CONTEXT_NOARG);			/* Dispatch queued signals */
extern char *signame(int sig);			/* Give English description of a signal */
RT_LNK void initsig(void);			/* Initialize the Eiffel handling of signals */
extern void trapsig(void (*handler) (int));			/* Set a trap for most of the signals */
extern Signal_t exfpe(int sig);		/* Routine trapped for floating point exception */

/* The following two macros are used to protect critical sections against any
 * signal interruption. This is because signals may be turned into exceptions,
 * which means the signal handler will never return into the original code.
 * This can lead to disasters if the interrupted routine was playing around
 * with pointers. This adds a slight overhead, but this is the price to pay
 * to have signals raising exceptions--RAM.
 * Note that these requests may have to work in a nested fashion, hence the
 * increment/decrement operations instead of plain boolean affectations.
 */

#define SIGBLOCK	esigblk++
#define SIGRESUME	if (--esigblk == 0 && signal_pending) esdpch(MTC_NOARG)

/* Eiffel interface with class UNIX_SIGNALS */
extern long esigmap(long int idx);		/* Mapping between constants and signal numbers */
extern char *esigname(long int sig);	/* Signal description */
extern long esignum(EIF_CONTEXT_NOARG);		/* Signal number */
extern void esigcatch(long int sig);	/* Catch signal */
extern void esigignore(long int sig);	/* Ignore signal */
extern char esigiscaught(long int sig);	/* Is signal caught? */
extern char esigdefined(long int sig);	/* Is signal defined? */
extern void esigresall(void);	/* Reset all signal to their default handling */
extern void esigresdef(long int sig);	/* Reset a signal to its default handling */

#ifdef HAS_SYS_SIGLIST
	extern char *sys_siglist[];
#endif

#ifdef __cplusplus
}
#endif

#endif

