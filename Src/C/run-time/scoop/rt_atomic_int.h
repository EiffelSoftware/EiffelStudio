/*
	description:	"Atomic integer class, with fallback to locks if not supported on the target platform."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2010-2012, Eiffel Software.",
				"Copyright (c) 2014 Scott West <scott.gregory.west@gmail.com>"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

#ifndef _rt_atomic_int_h_
#define _rt_atomic_int_h_

#include "eif_portable.h"
#include "eif_atomops.h"

#if !defined EIF_HAS_ATOMIC
#include "eif_posix_threads.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

struct rt_atomic_int {
#if !defined EIF_HAS_ATOMIC
	EIF_MUTEX_TYPE* lock;
#endif
	volatile EIF_INTEGER_32 count;
};

rt_private rt_inline void rt_atomic_int_init (struct rt_atomic_int* self) {
#if !defined EIF_HAS_ATOMIC
	RT_TRACE (eif_pthread_mutex_create (&self->lock));
#endif
	self->count = 0;
}

rt_private rt_inline void rt_atomic_int_deinit (struct rt_atomic_int* self) {
#if !defined EIF_HAS_ATOMIC
	RT_TRACE (eif_pthread_mutex_destroy (&self->lock));
#endif
}

rt_private rt_inline void rt_atomic_int_increment (struct rt_atomic_int* self) {
#if !defined EIF_HAS_ATOMIC
	RT_TRACE (eif_pthread_mutex_lock (&self->lock));
	++(self->count);
	RT_TRACE (eif_pthread_mutex_unlock (&self->lock));
#else
	RTS_AI_I32 (&self->count);
#endif
}

rt_private rt_inline int rt_atomic_int_decrement_and_fetch (struct rt_atomic_int* self) {
	int result = 0;
#if !defined EIF_HAS_ATOMIC
	RT_TRACE (eif_pthread_mutex_lock (&self->lock));
	result = (--self->count);
	RT_TRACE (eif_pthread_mutex_unlock (&self->lock));
#else
	result = RTS_AD_I32 (&self->count);
#endif
	return result;
}

#ifdef __cplusplus
}
#endif

#endif /* _rt_atomic_int_h_ */

