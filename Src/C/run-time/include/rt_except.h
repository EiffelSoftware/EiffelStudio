/*
	description: "Exception handling C code."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
#ifdef WORKBENCH
extern char* stack_trace_str(void);		/* Exception stack as a C string */
#endif

#ifdef __cplusplus
}
#endif

#endif
