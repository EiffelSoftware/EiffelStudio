/*
	description:	"A bounded queue for EIF_SCP_PID identifiers."
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

/*
doc:<file name="identifier_set.c" header="rt_identifier_set.h" version="$Id$" summary="A bounded queue for EIF_SCP_PID identifiers.">
 */

#include "eif_portable.h"
#include "rt_identifier_set.h"

#include "eif_error.h"
#include "rt_assert.h"
#include "eif_macros.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
doc:	<routine name="rt_identifier_set_init" return_type="int" export="shared">
doc:		<summary> Initialize the processor identifier queue 'self' and allocate internal resources.
doc:			The feature also adds all PIDs in the range [1, a_capacity-1] to the queue.
doc:			Note that the root PID 0 will not be added. </summary>
doc:		<param name="self" type="struct rt_identifier_set*"> The queue to be initialized. Must not be NULL. </param>
doc:		<param name="a_capacity" type="size_t"> The total capacity of the queue. </param>
doc:		<return> An error code: T_OK on success. T_NO_MORE_MEMORY when memory allocation fails, or any of the error codes that may happen during mutex creation. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only called by the root thread during program startup. </synchronization>
doc:	</routine>
*/
rt_shared int rt_identifier_set_init (struct rt_identifier_set* self, size_t a_capacity)
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
		EIF_SCP_PID i;
			/* Initialize the area array with all valid identifiers. */
		for (i = 0; i < a_capacity; ++i) {
			self->area[i] = i;
		}
		self->capacity = a_capacity;

			/* The first element with ID 0 is already consumed. */
		self->count = a_capacity - 1;
		self->start = 1;
	}

	return error;
}

/*
doc:	<routine name="rt_identifier_set_deinit" return_type="void" export="shared">
doc:		<summary> Free all internal resources in the queue 'self'. </summary>
doc:		<param name="self" type="struct rt_identifier_set*"> The queue to be deallocated. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only called by the root thread during program termination. </synchronization>
doc:	</routine>
*/
rt_shared void rt_identifier_set_deinit (struct rt_identifier_set* self)
{
	REQUIRE ("self_not_null", self);

	free (self->area);
	self->area = NULL;

	RT_TRACE (eif_pthread_mutex_destroy (self->lock));
	self->lock = NULL;

	RT_TRACE (eif_pthread_cond_destroy (self->is_empty_condition));
	self->is_empty_condition = NULL;
}


/*
doc:	<routine name="rt_identifier_set_extend" return_type="void" export="shared">
doc:		<summary> Add the processor identifier 'pid' to the queue 'self' and inform any waiting thread that a new element has been inserted. </summary>
doc:		<param name="self" type="struct rt_identifier_set*"> The rt_identifier_set struct. Must not be NULL. </param>
doc:		<param name="pid" type="EIF_SCP_PID"> The PID to be inserted. </param>
doc:		<thread_safety> Safe </thread_safety>
doc:		<synchronization> Done internally through 'self->lock'. </synchronization>
doc:	</routine>
*/
rt_shared void rt_identifier_set_extend (struct rt_identifier_set* self, EIF_SCP_PID pid)
{
	size_t position = 0;

	REQUIRE ("self_not_null", self);
	REQUIRE ("not_full", self->count < self->capacity);

	RT_TRACE (eif_pthread_mutex_lock (self->lock));

		/* Perform the actual enqueue operation. */
	position = (self->start + self->count) % self->capacity;
	self->area [position] = pid;
	self->count = self->count + 1;

		/* Send a signal to potentially waiting threads and release the lock. */
	RT_TRACE (eif_pthread_cond_signal (self->is_empty_condition));
	RT_TRACE (eif_pthread_mutex_unlock (self->lock));
}

/*
doc:	<routine name="rt_identifier_set_do_consume" return_type="void" export="private">
doc:		<summary> Helper feature for the consume operation. </summary>
doc:		<param name="self" type="struct rt_identifier_set*"> The rt_identifier_set struct. Must not be NULL. </param>
doc:		<param name="result" type="EIF_SCP_PID*"> A pointer to the location where the result shall be stored. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Required by client. </synchronization>
doc:	</routine>
*/
rt_private rt_inline void rt_identifier_set_do_consume (struct rt_identifier_set* self, EIF_SCP_PID* result)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("pid_not_null", result);
	REQUIRE ("not_empty", self->count > 0);

	*result = self->area [self->start];
	self->start = (self->start + 1) % self->capacity;
	self->count = self->count - 1;
}

/*
doc:	<routine name="rt_identifier_set_consume" return_type="void" export="shared">
doc:		<summary> Remove and return an element from the queue 'self'. This feature waits on 'self->is_empty_condition' when no item is available.
doc:			This feature should be called after rt_identifier_set_try_consume fails, as it introduces some overhead for compatibility with the GC. </summary>
doc:		<param name="self" type="struct rt_identifier_set*"> The rt_identifier_set struct. Must not be NULL. </param>
doc:		<param name="result" type="EIF_SCP_PID*"> A pointer to the location where the result shall be stored. Must not be NULL. </param>
doc:		<thread_safety> Safe. </thread_safety>
doc:		<synchronization> Done internally through 'self->lock'. </synchronization>
doc:	</routine>
*/
rt_shared void rt_identifier_set_consume (struct rt_identifier_set* self, EIF_SCP_PID* result)
{

	REQUIRE ("self_not_null", self);
	REQUIRE ("pid_not_null", result);

		/* We need to wait for a new PID. This might take some time...
		 * Allow the garbage collector to run in the meantime. */
	EIF_ENTER_C;
	RT_TRACE (eif_pthread_mutex_lock (self->lock));

		/* Wait for the queue to become non-empty. */
	while (self->count == 0) {
		RT_TRACE (eif_pthread_cond_wait (self->is_empty_condition, self->lock));
	}

		/* Perform the actual dequeue operation and release the lock. */
	rt_identifier_set_do_consume (self, result);

	RT_TRACE (eif_pthread_mutex_unlock (self->lock));
	EIF_EXIT_C;
	RTGC;
}

/*
doc:	<routine name="rt_identifier_set_try_consume" return_type="EIF_BOOLEAN" export="shared">
doc:		<summary> Remove and return an element from the queue 'self'. This feature is non-blocking, but returns EIF_FALSE when no item is available. </summary>
doc:		<param name="self" type="struct rt_identifier_set*"> The rt_identifier_set struct. Must not be NULL. </param>
doc:		<param name="result" type="EIF_SCP_PID*"> A pointer to the location where the result shall be stored. Must not be NULL. </param>
doc:		<return> EIF_TRUE on success. EIF_FALSE otherwise. </return>
doc:		<thread_safety> Safe. </thread_safety>
doc:		<synchronization> Done internally through 'self->lock'. </synchronization>
doc:	</routine>
*/
rt_shared EIF_BOOLEAN rt_identifier_set_try_consume (struct rt_identifier_set* self, EIF_SCP_PID* result)
{
	EIF_BOOLEAN success = EIF_FALSE;

	REQUIRE ("self_not_null", self);
	REQUIRE ("pid_not_null", result);

	RT_TRACE (eif_pthread_mutex_lock (self->lock));

	if (self->count > 0) {
		rt_identifier_set_do_consume (self, result);
		success = EIF_TRUE;
	}
	RT_TRACE (eif_pthread_mutex_unlock (self->lock));

	return success;
}

#ifdef __cplusplus
}
#endif

/*
doc:</file>
*/
