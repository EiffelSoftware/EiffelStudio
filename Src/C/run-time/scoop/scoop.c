/*
	description:	"Main functions of the SCOOP runtime."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2010-2015, Eiffel Software."
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
doc:<file name="scoop.c" header="eif_scoop.h" version="$Id$" summary="Main functions of the SCOOP runtime.">
*/

#include "eif_portable.h"
#include "rt_assert.h"
#include "rt_globals.h"
#include "rt_globals_access.h"
#include "rt_struct.h"
#include "rt_wbench.h"
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "rt_macros.h"

#include "rt_processor_registry.h"
#include "rt_processor.h"

#ifndef EIF_THREADS
#error "SCOOP is currenly supported only in multithreaded mode."
#endif

#ifdef EIF_ASSERTIONS
/* Helper function to check whether a SCOOP call is executed on the thread that handles processor 'processor_id' */
rt_private EIF_BOOLEAN is_correct_thread (EIF_SCP_PID processor_id)
{
	EIF_GET_CONTEXT
	return processor_id == eif_globals->scoop_processor_id;

}
#endif

/*
doc:	<routine name="rt_scoop_impersonated_call" return_type="void" export="private">
doc:		<summary> Execute the separate call 'call' on the client processor, while assuming the identity of 'supplier'. </summary>
doc:		<param name="client" type="struct rt_processor*"> The client processor. Must not be NULL. </param>
doc:		<param name="supplier" type="struct rt_processor*"> The supplier processor whose identity is temporarily adopted. Must not be NULL. </param>
doc:		<param name="call" type="struct eif_scoop_call_data*"> The call to be executed. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the client while the supplier is synchronized. </synchronization>
doc:	</routine>
*/
rt_private void rt_scoop_impersonated_call (struct rt_processor* client, struct rt_processor* supplier, struct eif_scoop_call_data* call)
{
	EIF_GET_CONTEXT
	EIF_SCP_PID stored_pid = eif_globals->scoop_region_id;
	int error = 0;
	EIF_BOOLEAN is_successful;
#ifdef EIF_ASSERTIONS
	struct rt_private_queue* pq = NULL; /* For assertion checking. */
#endif

	REQUIRE ("client_not_null", client);
	REQUIRE ("supplier_not_null", supplier);
	REQUIRE ("queue_available", T_OK == rt_queue_cache_retrieve (&client->cache, supplier, &pq));
	REQUIRE ("callback_or_synchronized", (supplier->is_passive_region /*&& !supplier->is_creation_procedure_logged*/) || rt_queue_cache_has_locks_of (&client->cache, supplier) || rt_private_queue_is_synchronized (pq));

		/* Perform lock passing. Bail out if there's no memory*/
	error = rt_queue_cache_push_on_impersonation (&client->cache, &supplier->cache);
	if (error != T_OK) {
		enomem();
	}

		/* Adjust the region ID and the once values of the target region.*/
	eif_scoop_impersonate (eif_globals, supplier->pid);

		/* Perform the call. We perform a safe call here because we need
		 * to free the eif_scoop_call_data struct afterwards. */
	is_successful = rt_try_execute_scoop_call (call);

		/* Adopt the once values of the current region and revert the region ID. */
	eif_scoop_impersonate (eif_globals, stored_pid);

		/* Return the locks. */
	rt_queue_cache_pop_on_impersonation (&client->cache, 1);

		/* Free the call structure. */
	free (call);

		/* If there was an error, raise an exception now. */
	if (!is_successful) {
		eraise ((const char *) "EVE/Qs dirty processor exception", EN_DIRTY);
	}
}


/*
doc:	<routine name="eif_scoop_can_impersonate" return_type="EIF_BOOLEAN" export="public">
doc:		<summary> Can a separate call from 'client_processor_id' to 'supplier_region_id' be impersonated? </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The ID of the client processor. </param>
doc:		<param name="supplier_region_id" type="EIF_SCP_PID"> The ID of the supplier region. </param>
doc:		<param name="is_synchronous" type="EIF_BOOLEAN"> Whether the call is synchronous (e.g. a query). </param>
doc:		<return> A boolean indicating whether the separate call can be impersonated. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the thread that handles 'client_processor_id'. </synchronization>
doc:	</routine>
*/
rt_public EIF_BOOLEAN eif_scoop_can_impersonate (EIF_SCP_PID client_processor_id, EIF_SCP_PID supplier_region_id, EIF_BOOLEAN is_synchronous)
{
	struct rt_processor* supplier = rt_get_processor (supplier_region_id);
	struct rt_processor* client = NULL;
	struct rt_private_queue *queue = NULL;
	EIF_BOOLEAN result;

	REQUIRE ("correct_thread", is_correct_thread (client_processor_id));
	CHECK ("passive_implies_impersonable", !supplier->is_passive_region || supplier->is_impersonation_allowed);

		/* First of all, the supplier has to agree that it can handle impersonation.
		 * There's one exception: when the client processor is currently impersonating another region,
		 * and now wants to perform a callback into its own region. */
	result = supplier->is_impersonation_allowed || supplier_region_id == client_processor_id;

		/* Once we determine that impersonation is allowed, we check whether we can impersonate this particular call. */
	if (result) {

			/* A call to a passive region is always impersonated. */
		result = supplier->is_passive_region;

		if (!result) {
				/* We need to look at the private queue... */
			client = rt_get_processor (client_processor_id);
			if (T_OK != rt_queue_cache_retrieve (&client->cache, supplier, &queue)) {
				enomem();
			}

				/* If we're currently synchronized with the supplier (i.e. we already sent
				* 'supplier' a synchronous call), and the next call is also synchronous,
				* we can apply impersonation. */
			result = is_synchronous && rt_private_queue_is_synchronized (queue);

				/* A separate callback is always synchronous, so we can impersonate it. */
			result = result || rt_queue_cache_has_locks_of (&client->cache, supplier);
		}
	}
	return result;
}

/*
doc:	<routine name="prepare_separate_call" return_type="void" export="private">
doc:		<summary> Prepare the call data structure: Calculate whether the call is synchronous and set the correct PID for expanded objects. </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The ID of the client processor. </param>
doc:		<param name="client_region_id" type="EIF_SCP_PID"> The ID of the client region. </param>
doc:		<param name="call" type="struct eif_scoop_call_data"> The separate call to be prepared. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None </synchronization>
doc:	</routine>
*/
rt_private void prepare_separate_call (EIF_SCP_PID client_processor_id, EIF_SCP_PID client_region_id, struct eif_scoop_call_data* call)
{
	EIF_REFERENCE obj = NULL;
	EIF_SCP_PID supplier_id = RTS_PID (call->target);
	size_t i = 0;

#ifdef WORKBENCH
		/* Remove the result pointer when not needed. */
	if (call->result && call->result->type == SK_VOID) {
		call->result = NULL;
	}
#endif

		/* A call with a result is always synchronous. */
	if (call->result) {
		call->is_synchronous = EIF_TRUE;
	}

		/* Iterate over all arguments and see whether they're controlled.
		 * We only care about non-NULL reference arguments. */
	for (i=0; i < call->count; ++i) {
		if (call->argument [i].type == SK_REF) {
			obj = call->argument [i].item.r;
			if (obj) {

					/* Set the correct PID for expanded objects.
					 * See also eweasel test#scoop072. */
				if (eif_is_expanded (HEADER(obj)->ov_flags)) {
					RTS_PID (obj) = supplier_id;
				} else {

					/* Mark the call as synchronous if there is an argument
					 * that is controlled by the current processor. */
					if (!call->is_synchronous && RTS_PID (obj) != supplier_id
						&& !eif_scoop_is_uncontrolled (client_processor_id, client_region_id, RTS_PID(obj)))
					{
						call->is_synchronous = EIF_TRUE;
					}
				}
			}
		}
	}
}

/*
doc:	<routine name="eif_scoop_log_call" return_type="void" export="public">
doc:		<summary> Log the separate call 'data' and wait for the result if necessary. </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The processor ID of the client. </param>
doc:		<param name="client_region_id" type="EIF_SCP_PID"> The region ID of the client. </param>
doc:		<param name="data" type="struct eif_scoop_call_data*"> The separate call to be logged and executed. </param>
doc:		<thread_safety> Safe. </thread_safety>
doc:		<synchronization> None for creation procedures. For regular calls, make sure that the supplier region is locked within an rt_request_group. </synchronization>
doc:	</routine>
*/
rt_public void eif_scoop_log_call (EIF_SCP_PID client_processor_id, EIF_SCP_PID client_region_id, struct eif_scoop_call_data *data)
{
	EIF_SCP_PID supplier_pid = RTS_PID (data->target);
	struct rt_processor *client = rt_get_processor (client_processor_id);
	struct rt_processor *supplier = rt_get_processor (supplier_pid);
	struct rt_private_queue *pq = NULL;

	REQUIRE("has data", data);
	REQUIRE("different_regions", client_region_id != supplier_pid);

		/* Calculate whether this call is synchronous. */
	prepare_separate_call (client_processor_id, client_region_id, data);

		/* Check whether we can impersonate the call. At this stage,
		 * we may still encounter some impersonable calls from the interpreter
		 * or calls that may not have been detected by RTS_CI. */
	if (eif_scoop_can_impersonate (client_processor_id, supplier_pid, data->is_synchronous)) {
		rt_scoop_impersonated_call (client, supplier, data);
	} else {

			/* This is a regular call. Get the private queue to the other processor. */
		if (T_OK != rt_queue_cache_retrieve (&client->cache, supplier, &pq)) {
			enomem();
		}

		if (!supplier->is_creation_procedure_logged) {
				/* We're logging a creation procedure and need to lock
				 * the private queue first. */
			rt_private_queue_lock (pq, client);
			rt_private_queue_log_call(pq, client, data);
			rt_private_queue_unlock (pq, EIF_FALSE);
			supplier->is_creation_procedure_logged = EIF_TRUE;
		} else {
				/* Perform a regular call. */
			rt_private_queue_log_call(pq, client, data);
		}
	}
}

/*
doc:	<routine name="eif_scoop_impersonate" return_type="void" export="public">
doc:		<summary> Let the current processor adopt the region ID and once values of 'region_id'. </summary>
doc:		<param name="eif_globals" type="eif_global_context_t*"> The global context to be modified. The context is the same as in EIF_GET_CONTEXT
doc:			of the caller; the argument is just used to avoid a lookup of thread-local storage. </param>
doc:		<param name="region_id" type="EIF_SCP_PID"> The region that shall be impersonated. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call this function when the current thread has exclusive access over 'region_id'. </synchronization>
doc:	</routine>
*/
rt_public void eif_scoop_impersonate (eif_global_context_t* eif_globals, EIF_SCP_PID region_id)
{
	struct rt_processor* target_region = rt_get_processor (region_id);

	CHECK ("same_pid", target_region->pid == region_id);

	eif_globals->scoop_region_id = region_id;
	eif_globals->EIF_once_values_cx = target_region->stored_once_values;
	eif_globals->EIF_oms_cx = target_region->stored_oms_values;

#ifdef EIF_WINDOWS
	eif_globals->wel_per_thread_data = target_region->stored_wel_per_thread_data;
#endif
}

/*
doc:	<routine name="eif_call_const" return_type="void" export="public">
doc:		<summary> Stub pattern for separate calls to constants in finalized mode (constants are hardcoded and propagated at compile time). </summary>
doc:		<thread_safety> Safe </thread_safety>
doc:		<synchronization> None </synchronization>
doc:	</routine>
*/
rt_public void eif_call_const (struct eif_scoop_call_data* a)
{
	/* Constant value is hard-coded in the generated code: nothing to do here. */
	/* Avoid C compiler error about unreferenced parameter. */
	(void) a;
}

/*
doc:	<routine name="eif_scoop_new_processor" return_type="EIF_SCP_PID" export="public">
doc:		<summary> Create a new SCOOP region. If there's no free region ID, the function will trigger a GC run and then wait for a new ID. </summary>
doc:		<param name="is_passive" type="EIF_BOOLEAN"> Whether a passive region shall be created. </param>
doc:		<return> The ID of the newly created region. </return>
doc:		<thread_safety> Safe. </thread_safety>
doc:		<synchronization> Done internally. Careful: May trigger garbage collection. </synchronization>
doc:	</routine>
*/
rt_public EIF_SCP_PID eif_scoop_new_processor (EIF_BOOLEAN is_passive)
{
	EIF_SCP_PID new_pid = 0;
	int error = T_OK;

	error = rt_processor_registry_create_region (&new_pid, is_passive);

	if (error == T_OK) {

		rt_processor_registry_activate (new_pid);
				/* For passive regions we'll execute the creation procedure right away. */
		if (is_passive) {
			rt_get_processor (new_pid)->is_creation_procedure_logged = EIF_TRUE;
		}
	} else {
		if (error == T_NO_MORE_MEMORY) {
			enomem ();
		} else {
			esys ();
		}
	}
	return new_pid;
}

/* Status report */

/*
doc:	<routine name="eif_scoop_is_uncontrolled" return_type="EIF_BOOLEAN" export="public">
doc:		<summary> Is the region with ID 'supplier_region_id' uncontrolled by the current region?
doc:			A region is only uncontrolled when all of the following apply:
doc:				- The region is different from the current region.
doc:				- The client processor has no lock on the region yet.
doc:				- No separate callback: The client doesn't own the locks of the supplier (i.e. the supplier has not passed its locks to the client in a previous call). </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The processor ID of the client. </param>
doc:		<param name="client_region_id" type="EIF_SCP_PID"> The region ID of the client. May be different from the processor ID when there's impersonation. </param>
doc:		<param name="supplier_region_id" type="EIF_SCP_PID"> The region ID of the supplier. </param>
doc:		<return> Whether 'supplier_region_id' is uncontrolled by the client. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the thread that handles 'client_processor_id'. Careful: May trigger garbage collection. </synchronization>
doc:	</routine>
*/
rt_public EIF_BOOLEAN eif_scoop_is_uncontrolled (EIF_SCP_PID client_processor_id, EIF_SCP_PID client_region_id, EIF_SCP_PID supplier_region_id)
{
 	struct rt_processor *client_processor = rt_get_processor (client_processor_id);
	struct rt_processor *supplier = rt_get_processor (supplier_region_id);

	REQUIRE ("correct_thread", is_correct_thread (client_processor_id));

	return client_region_id != supplier_region_id
		&& !rt_queue_cache_is_locked (&client_processor->cache, supplier)
		&& !rt_queue_cache_has_locks_of (&client_processor->cache, supplier);
}

/*
doc:	<routine name="eif_scoop_wait_for_all_processors" return_type="void" export="public">
doc:		<summary> Enter the SCOOP application loop and wait for all processors to finish. NOTE: Entry point for the root thread. </summary>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the root thread. </synchronization>
doc:	</routine>
*/
rt_public void eif_scoop_wait_for_all_processors(void)
{
	rt_processor_registry_quit_root_processor ();
}

/*Functions to manipulate the request group stack */

/*
doc:	<routine name="eif_scoop_new_request_group" return_type="void" export="public">
doc:		<summary> Create a new request group and put it at the end of the request group stack of processor 'client_processor_id'. </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The client processor that wants to allocate a new request group. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the thread that handles 'client_processor_id'.</synchronization>
doc:	</routine>
*/
rt_public void eif_scoop_new_request_group (EIF_SCP_PID client_processor_id)
{
	struct rt_processor* client = rt_get_processor (client_processor_id);
	REQUIRE ("correct_thread", is_correct_thread (client_processor_id));

	if (T_OK != rt_processor_request_group_stack_extend (client)) {
		enomem();
	}
}

/*
doc:	<routine name="eif_scoop_request_group_stack_count" return_type="size_t" export="public">
doc:		<summary> Return the current size of the request group stack of 'client_processor_id'. </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The processor that owns the request group stack. </param>
doc:		<return> The size of the request group stack. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the thread that handles 'client_processor_id'. </synchronization>
doc:	</routine>
*/
rt_public size_t eif_scoop_request_group_stack_count (EIF_SCP_PID client_processor_id)
{
	struct rt_processor* client = rt_get_processor (client_processor_id);
	REQUIRE ("correct_thread", is_correct_thread (client_processor_id));

	return rt_processor_request_group_stack_count (client);
}

/*
doc:	<routine name="eif_scoop_delete_request_group" return_type="void" export="public">
doc:		<summary> Delete the last 'count' elements of the request group stack of 'client_processor_id' and release any locks within. </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The processor that owns the request group stack. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the thread that handles 'client_processor_id'. </synchronization>
doc:	</routine>
*/
rt_public void eif_scoop_delete_request_group (EIF_SCP_PID client_processor_id, size_t count)
{
	struct rt_processor* client = rt_get_processor (client_processor_id);
	REQUIRE ("correct_thread", is_correct_thread (client_processor_id));
		/* Unlock, deallocate and remove the request group. */
	rt_processor_request_group_stack_remove (client, count);
}

/*
doc:	<routine name="eif_scoop_wait_request_group" return_type="void" export="public">
doc:		<summary> Handle a wait condition failure in 'client_processor_id':
doc:			Subscribe for wait condition change notifications.
doc:			Release the locks in the last element of the request group stack.
doc:			Go to sleep until there's a notification.
doc:			Acquire the previously released locks again. </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The processor that owns the request group stack. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the thread that handles 'client_processor_id'. </synchronization>
doc:	</routine>
*/
rt_public void eif_scoop_wait_request_group (EIF_SCP_PID client_processor_id)
{
	struct rt_processor* client = rt_get_processor (client_processor_id);
	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);

	REQUIRE ("correct_thread", is_correct_thread (client_processor_id));

	if (rt_request_group_wait (l_group) == T_OK) {
			/* Lock the request group again for re-evaluation. */
		rt_request_group_lock (l_group);
	} else {
			/* Raise an error if we get a memory allocation failure.
			* Note: The request group will be unlocked sometime later while handling the exception. */
		enomem();
	}
}

/*
doc:	<routine name="eif_scoop_add_supplier_request_group" return_type="void" export="public">
doc:		<summary> Add the new supplier 'supplier_region_id' to the top element of the request group stack of 'client_processor_id'. </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The processor that owns the request group stack. </param>
doc:		<param name="supplier_region_id" type="EIF_SCP_PID"> The region ID of the new supplier. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the thread that handles 'client_processor_id'.</synchronization>
doc:	</routine>
*/
rt_public void eif_scoop_add_supplier_request_group (EIF_SCP_PID client_processor_id, EIF_SCP_PID supplier_region_id)
{
	struct rt_processor* client = rt_get_processor (client_processor_id);
	struct rt_processor* supplier = rt_get_processor (supplier_region_id);
	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);

	REQUIRE ("correct_thread", is_correct_thread (client_processor_id));

		/* Raise an exception if we get a memory allocation failure. */
	if (T_OK != rt_request_group_add (l_group, supplier)) {
		enomem();
	}
}

/*
doc:	<routine name="eif_scoop_lock_request_group" return_type="void" export="public">
doc:		<summary> Atomically acquire the lock to all suppliers in the top element of the request group stack of 'client_processor_id'.
doc:			For active regions, this means adding the private queues to the queue-of-queue of the supplier. </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The processor that owns the request group stack. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the thread that handles 'client_processor_id'.</synchronization>
doc:	</routine>
*/
rt_public void eif_scoop_lock_request_group (EIF_SCP_PID client_processor_id)
{
	struct rt_processor* client = rt_get_processor (client_processor_id);
	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);

	REQUIRE ("correct_thread", is_correct_thread (client_processor_id));

	rt_request_group_lock (l_group);
}

/* Lock stack management */

/*
doc:	<routine name="eif_scoop_lock_stack_count" return_type="size_t" export="public">
doc:		<summary> Return the current size of the lock stack of 'client_processor_id'. </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The processor that owns the lock stack. </param>
doc:		<return> The size of the lock stack. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the thread that handles 'client_processor_id'. </synchronization>
doc:	</routine>
*/
rt_public size_t eif_scoop_lock_stack_count (EIF_SCP_PID client_processor_id)
{
	struct rt_processor* proc = rt_get_processor (client_processor_id);
	REQUIRE ("correct_thread", is_correct_thread (client_processor_id));

	return rt_queue_cache_lock_passing_count (&proc->cache);
}

/*
doc:	<routine name="eif_scoop_lock_stack_impersonated_push" return_type="void" export="public">
doc:		<summary> Push the locks of 'supplier_region_id' onto the lock stack of 'client_processor_id'. </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The processor that owns the lock stack. </param>
doc:		<param name="supplier_region_id" type="EIF_SCP_PID"> The region whose locks shall be taken. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the thread that handles 'client_processor_id', and only when the supplier is either synced or passive.</synchronization>
doc:	</routine>
*/
rt_public void eif_scoop_lock_stack_impersonated_push (EIF_SCP_PID client_processor_id, EIF_SCP_PID supplier_region_id)
{
	struct rt_processor* client = rt_get_processor (client_processor_id);
	struct rt_processor* supplier = rt_get_processor (supplier_region_id);

	REQUIRE ("correct_thread", is_correct_thread (client_processor_id));

	if (T_OK != rt_queue_cache_push_on_impersonation (&client->cache, &supplier->cache)) {
		enomem();
	}
}

/*
doc:	<routine name="eif_scoop_lock_stack_impersonated_pop" return_type="void" export="public">
doc:		<summary> Remove the top 'count' elements from the lock stack of 'client_processor_id'. </summary>
doc:		<param name="client_processor_id" type="EIF_SCP_PID"> The processor that owns the lock stack. </param>
doc:		<param name="count" type="size_t"> The number of elements to be removed. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the thread that handles 'client_processor_id'. </synchronization>
doc:	</routine>
*/
rt_public void eif_scoop_lock_stack_impersonated_pop (EIF_SCP_PID client_processor_id, size_t count)
{
	struct rt_processor* client = rt_get_processor (client_processor_id);
	REQUIRE ("correct_thread", is_correct_thread (client_processor_id));

	rt_queue_cache_pop_on_impersonation (&client->cache, count);
}

/* Debugger extensions. */

/*
doc:	<routine name="eif_scoop_client_of" return_type="EIF_SCP_PID" export="public">
doc:		<summary> Return the ID of the client processor that initially logged the private queue 'supplier' is currently working on. </summary>
doc:		<param name="supplier" type="EIF_SCP_PID"> The supplier processor. </param>
doc:		<return> The ID of the current client. If 'supplier' is not processing a private queue at the moment, the result is EIF_NULL_PROCESSOR. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call when 'supplier' is blocked (e.g. during debugging). </synchronization>
doc:	</routine>
*/
rt_public EIF_SCP_PID eif_scoop_client_of (EIF_SCP_PID supplier)
{
	REQUIRE ("valid_id", supplier != EIF_NULL_PROCESSOR && supplier < RT_MAX_SCOOP_PROCESSOR_COUNT);
	REQUIRE ("exists", rt_get_processor (supplier) != NULL);
	return rt_get_processor (supplier) -> client;
}

/* Externals to EiffelBase */

/*
doc:	<routine name="eif_scoop_set_is_impersonation_allowed" return_type="void" export="public">
doc:		<summary> Enable or disable impersonation for a specific processor. </summary>
doc:		<param name="pid" type="EIF_SCP_PID"> The processor for which the is_impersonation_allowed status shall be changed. </param>
doc:		<param name="status" type="EIF_BOOLEAN"> The new value. EIF_FALSE disables impersonation. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call this function when the caller has exclusive access to 'processor'. </synchronization>
doc:	</routine>
*/
rt_public void eif_scoop_set_is_impersonation_allowed (EIF_SCP_PID pid, EIF_BOOLEAN status)
{
	struct rt_processor* proc = NULL;
	REQUIRE ("valid_processor", pid < RT_MAX_SCOOP_PROCESSOR_COUNT && rt_get_processor(pid));

	proc = rt_get_processor (pid);
	proc->is_impersonation_allowed = status;
}


/*
doc:</file>
*/
