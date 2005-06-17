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
 Exception handling C code.
*/

#ifndef _rt_except_h_
#define _rt_except_h_

#include "eif_except.h"
#include "rt_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS
extern struct xstack eif_trace;       /* Unsolved exception trace */
#endif

#ifdef EIF_WINDOWS
extern void set_windows_exception_filter(void);
#endif

extern struct ex_vect *exget(struct xstack *stk);	/* Get a new vector on stack */
extern struct ex_vect *extop(struct xstack *stk);	/* Top of Eiffel stack */
extern struct ex_vect *exnext(EIF_CONTEXT_NOARG);	/* Read next eif_trace item from bottom */
extern void xstack_reset (struct xstack *stk);		/* Clear content of `stk'. */
extern void ereturn(EIF_CONTEXT_NOARG);			/* Return to lastly recorded rescue entry */
extern void excatch(jmp_buf *jmp);			/* Set exception catcher from C to interpret */
extern void exhdlr(EIF_CONTEXT Signal_t (*handler)(int), int sig);			/* Call signal handler */

#ifdef EIF_THREADS
extern void eif_except_thread_init (void);
extern EIF_LW_MUTEX_TYPE *eif_except_lock;
#endif

#ifdef __cplusplus
}
#endif

#endif
