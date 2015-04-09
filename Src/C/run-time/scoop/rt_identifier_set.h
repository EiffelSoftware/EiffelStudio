/*
	description:	"Definitions for a set of EIF_SCP_PID identifiers."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2014-2015, Eiffel Software."
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

#ifndef _rt_identifier_set_h_
#define _rt_identifier_set_h_

#include "eif_portable.h"
#include "eif_posix_threads.h"
#include "eif_error.h"

/* TODO: Move the implementations into a C file and adapt the build system accordingly. */

struct rt_identifier_set {
	EIF_SCP_PID* area;
	size_t capacity;
	size_t count;
	size_t start;

	EIF_MUTEX_TYPE* lock;
	EIF_COND_TYPE* is_empty_condition;
};

rt_private rt_inline int rt_identifier_set_init (struct rt_identifier_set* self, size_t a_capacity)
{
	int error = T_OK;

	REQUIRE ("self_not_null", self);

		/* Basic stuff to safely call rt_identifier_set_deinit if allocation fails. */
	self->area = NULL;
	self->lock = NULL;
	self->is_empty_condition = NULL;

		/* Create mutex and condition variable. */
	error = eif_pthread_mutex_create (&self->lock);

	if (T_OK == error) {
		error = eif_pthread_cond_create (&self->is_empty_condition);
	}

		/* Allocate memory for the queue items. */
	if (T_OK == error) {
		self->area = (EIF_SCP_PID*) malloc (a_capacity * sizeof (EIF_SCP_PID));
		if (!self->area) {
			error = T_NO_MORE_MEMORY;
		}
	}

	if (T_OK == error) {
			/* Initialize the already present SCOOP identifiers in the set. */
		for (EIF_SCP_PID i = 0; i < a_capacity; ++i) {
			self->area[i] = i;
		}
		self->capacity = a_capacity;

			/* The first element with ID 0 is already consumed. */
		self->count = a_capacity - 1;
		self->start = 1;
	}

	return error;
}

rt_private rt_inline void rt_identifier_set_deinit (struct rt_identifier_set* self)
{
	REQUIRE ("self_not_null", self);

	free (self->area);
	self->area = NULL;

	RT_TRACE (eif_pthread_mutex_destroy (self->lock));
	self->lock = NULL;

	RT_TRACE (eif_pthread_cond_destroy (self->is_empty_condition));
	self->is_empty_condition = NULL;
}

rt_private rt_inline int rt_identifier_set_extend (struct rt_identifier_set* self, EIF_SCP_PID pid)
{
	int error = T_OK;
	size_t position = 0;

	REQUIRE ("self_not_null", self);
	REQUIRE ("not_full", self->count < self->capacity);

	error = eif_pthread_mutex_lock (self->lock);

	if (T_OK == error) {

			/* Perform the actual enqueue operation. */
		position = (self->start + self->count) % self->capacity;
		self->area [position] = pid;
		self->count = self->count + 1;

			/* Send a signal to potentially waiting threads and release the lock. */
		RT_TRACE (eif_pthread_cond_signal (self->is_empty_condition));
		RT_TRACE (eif_pthread_mutex_unlock (self->lock));
	}
	return error;
}

rt_private rt_inline void rt_identifier_set_do_consume (struct rt_identifier_set* self, EIF_SCP_PID* result)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("pid_not_null", result);
	REQUIRE ("not_empty", self->count > 0);

	*result = self->area [self->start];
	self->start = (self->start + 1) % self->capacity;
	self->count = self->count - 1;
}


rt_private rt_inline int rt_identifier_set_consume (struct rt_identifier_set* self, EIF_SCP_PID* result)
{
	int error = T_OK;

	REQUIRE ("self_not_null", self);
	REQUIRE ("pid_not_null", result);

	error = eif_pthread_mutex_lock (self->lock);

	if (T_OK == error) {

		if (self->count == 0) {
				/* We need to wait for a new PID. This might take some time...
				 * Allow the garbage collector to run in the meantime. */
			EIF_ENTER_C;
			while (self->count == 0) {
				RT_TRACE (eif_pthread_cond_wait (self->is_empty_condition, self->lock));
			}
			EIF_EXIT_C;
			RTGC;
		}

			/* Perform the actual dequeue operation and release the lock. */
		rt_identifier_set_do_consume (self, result);
		RT_TRACE (eif_pthread_mutex_unlock (self->lock));
	}

	return error;
}

rt_private rt_inline EIF_BOOLEAN rt_identifier_set_try_consume (struct rt_identifier_set* self, EIF_SCP_PID* result)
{
	EIF_BOOLEAN success = EIF_FALSE;
	int error = T_OK;

	REQUIRE ("self_not_null", self);
	REQUIRE ("pid_not_null", result);

	error = eif_pthread_mutex_lock (self->lock);

	if (T_OK == error) {
		if (self->count > 0) {
			rt_identifier_set_do_consume (self, result);
			success = EIF_TRUE;
		}
		RT_TRACE (eif_pthread_mutex_unlock (self->lock));
	}
	return success;
}

#endif /* _rt_identifier_set_h_ */
