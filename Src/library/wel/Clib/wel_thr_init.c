/*
indexing
	description: "Initialization of per-thread data in WEL."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

#include "wel_thr_init.h"

#ifdef EIF_THREADS

rt_public wel_global_context_t * wel_thr_context(void)
{
	/*
	 * Allocates memory for the wel_globals structure, initializes it
	 * and makes it part of the Thread Specific Data (TSD).
	 */

	GTCX
	wel_global_context_t * wel_globals = (wel_global_context_t *) (eif_globals->wel_per_thread_data);
	if (wel_globals == NULL) {
			/* Allocate new memory properly initialized with zeros. This memory will
			 * be automatically freed by the runtime when the thread is terminated. */
		wel_globals = (wel_global_context_t *) eif_thr_create_wel_per_thread_data (sizeof(wel_global_context_t));
	}
	return wel_globals;
}

/*
 * WEL thread context if it exists or NULL otherwise.
 * Same as wel_thr_context, but does not allocate new context if there is none.
 * Useful to avoid allocating new context when WEL object is disposed and original thread context has been cleaned.
 */
rt_public wel_global_context_t * wel_thr_context_opt (void)
{
	GTCX
	return (wel_global_context_t *) (eif_globals->wel_per_thread_data);
}


#endif
