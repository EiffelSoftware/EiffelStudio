/*

 #####    #####          ######  #    #   ####   ######  #####    #####         #    #
 #    #     #            #        #  #   #    #  #       #    #     #           #    #
 #    #     #            #####     ##    #       #####   #    #     #           ###### 
 #####      #            #         ##    #       #       #####      #     ###   #    #
 #   #      #            #        #  #   #    #  #       #          #     ###   #    #
 #    #     #   #######  ######  #    #   ####   ######  #          #     ###   #    #

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

#ifdef EIF_WIN32
extern void set_windows_exception_filter(void);
#endif

extern void xraise(EIF_CONTEXT int code);			/* Raise an exception with no tag */
extern struct ex_vect *exget(register2 struct xstack *stk);	/* Get a new vector on stack */
extern struct ex_vect *extop(register1 struct xstack *stk);	/* Top of Eiffel stack */
extern struct ex_vect *exnext(EIF_CONTEXT_NOARG);	/* Read next eif_trace item from bottom */
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
