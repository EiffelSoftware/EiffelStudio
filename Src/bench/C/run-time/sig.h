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

#ifndef _signal_h_
#define _signal_h_

#define SIGSTACK	200		/* Size of FIFO stack for signal buffering */

/* Structure used as FIFO stack for signal buffering. I really do not expect
 * this stack to overflow, so it has a huge fixed size--RAM. Should it really
 * overflow, we would panic immediately :-(.
 */
struct s_stack {
	int s_min;				/* Minimum value of circular buffer */
	int s_max;				/* Maximum value of circular buffer */
	char s_pending;			/* Are any signals pending? */
	char s_buf[SIGSTACK];	/* The circular buffer used as a FIFO stack */
};

/* Testing for pending signals -- if signals are pending, the signal dispatch
 * routine should be called. Tests are made at some strategic points in the
 * run-time to guard against longjmps in signal handlers.
 */
#define signal_pending		sig_stk.s_pending

extern int esigblk;				/* Are signals blocked for later delivery? */
extern struct s_stack sig_stk;	/* The signal stack */
extern void esdpch();			/* Dispatch queued signals */
extern char *signame();			/* Give English description of a signal */
extern void initsig();			/* Initialize the Eiffel handling of signals */
extern void trapsig();			/* Set a trap for most of the signals */
extern Signal_t exfpe();		/* Routine trapped for floating point exception */

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
#define SIGRESUME	if (--esigblk == 0 && signal_pending) esdpch()

/* Eiffel interface with class UNIX_SIGNALS */
extern long esigmap();		/* Mapping between constants and signal numbers */
extern char *esigname();	/* Signal description */
extern long esignum();		/* Signal number */
extern void esigcatch();	/* Catch signal */
extern void esigignore();	/* Ignore signal */
extern char esigiscaught();	/* Is signal caught? */
extern char esigdefined();	/* Is signal defined? */
extern void esigresall();	/* Reset all signal to their default handling */
extern void esigresdef();	/* Reset a signal to its default handling */

#endif
