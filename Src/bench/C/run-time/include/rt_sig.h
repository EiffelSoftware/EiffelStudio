/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
	Private signal handling declarations.
*/

#ifndef _rt_signal_h_
#define _rt_signal_h_

#include "eif_sig.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS
extern int esigblk;				/* Are signals blocked for later delivery? */
extern struct s_stack sig_stk;	/* The signal stack */
#endif

/* Testing for pending signals -- if signals are pending, the signal dispatch
 * routine should be called. Tests are made at some strategic points in the
 * run-time to guard against longjmps in signal handlers.
 */
#define signal_pending		sig_stk.s_pending

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

extern Signal_t ehandlr(EIF_CONTEXT register int sig);			/* Eiffel main signal handler */
extern void esdpch(EIF_CONTEXT_NOARG);			/* Dispatch queued signals */
extern char *signame(int sig);			/* Give English description of a signal */
extern void trapsig(void (*handler) (int));			/* Set a trap for most of the signals */
extern Signal_t exfpe(int sig);		/* Routine trapped for floating point exception */

#ifndef HAS_SYS_SIGLIST
	extern char *sys_siglist[];
#endif

#ifdef __cplusplus
}
#endif

#endif

