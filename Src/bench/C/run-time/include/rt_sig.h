/*

  ####      #     ####           #    #
 #          #    #    #          #    #
  ####      #    #               ######
      #     #    #  ###   ###    #    #
 #    #     #    #    #   ###    #    #
  ####      #     ####    ###    #    #

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

#ifdef __cplusplus
}
#endif

#endif

