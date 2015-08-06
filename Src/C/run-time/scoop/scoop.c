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

/*
doc:	<routine name="rt_swap_thread_context" return_type="void" export="private">
doc:		<summary> Swap the once values, the PID and some other data between 'first_pid' and 'second_pid'. This is used to perform impersonation in SCOOP. </summary>
doc:		<param name="first_pid" type="struct rt_processor*"> The processor of the first thread. </param>
doc:		<param name="second_pid" type="struct rt_processor*"> The processor of the second thread. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by one of the threads participating in the swap, while the second one is blocked. Must not be called during GC. </synchronization>
doc:	</routine>
*/
rt_private void rt_swap_thread_context (struct rt_processor* first_processor, struct rt_processor* second_processor)
{
	EIF_SCP_PID first_pid = first_processor->pid;
	EIF_SCP_PID second_pid = second_processor->pid;
	rt_global_context_t* first = global_ctxs [first_pid];
	rt_global_context_t* second = global_ctxs [second_pid];
	EIF_once_value_t* tmp_once;
	EIF_REFERENCE** tmp_oms;
	struct rt_message_channel* tmp_result_notify_proxy;

#ifdef EIF_WINDOWS
	void* tmp_wel_per_thread_data;
#endif

	REQUIRE ("valid_first_pid", first_pid < RT_MAX_SCOOP_PROCESSOR_COUNT && global_ctxs [first_pid]);
	REQUIRE ("valid_second_pid", second_pid < RT_MAX_SCOOP_PROCESSOR_COUNT && global_ctxs [second_pid]);

	CHECK ("matching_first_pid", first->eif_thr_context_cx->logical_id == first_pid);
	CHECK ("matching_second_pid", second->eif_thr_context_cx->logical_id == second_pid);

		/* Swap the once values. */
	tmp_once = first->eif_globals->EIF_once_values_cx;
	first->eif_globals->EIF_once_values_cx = second->eif_globals->EIF_once_values_cx;
	second->eif_globals->EIF_once_values_cx = tmp_once;

		/* Swap the once manifest strings. */
	tmp_oms = first->eif_globals->EIF_oms_cx;
	first->eif_globals->EIF_oms_cx = second->eif_globals->EIF_oms_cx;
	second->eif_globals->EIF_oms_cx = tmp_oms;

#ifdef EIF_WINDOWS
		/* Swap the WEL per-thread data. */
	tmp_wel_per_thread_data = first->eif_globals->wel_per_thread_data;
	first->eif_globals->wel_per_thread_data = second->eif_globals->wel_per_thread_data;
	second->eif_globals->wel_per_thread_data = tmp_wel_per_thread_data;
#endif

		/* Swap the result_notify of both processors. This is necessary, because otherwise
		 * the result of a separate call may wake up the processor that's being impersonated,
		 * instead of the impersonator, when the impersonator is currently executing a separate callback. */
	tmp_result_notify_proxy = first_processor->result_notify_proxy;
	first_processor->result_notify_proxy = second_processor->result_notify_proxy;
	second_processor->result_notify_proxy = tmp_result_notify_proxy;

		/* Swap the SCOOP ID. */
	first->eif_thr_context_cx->logical_id = second_pid;
	second->eif_thr_context_cx->logical_id = first_pid;

		/* Swap the position in global_ctxs. */
	global_ctxs [first_pid] = second;
	global_ctxs [second_pid] = first;
}

/*
doc:	<routine name="rt_scoop_impersonate" return_type="void" export="private">
doc:		<summary> Execute the separate call 'call' on the client processor, while assuming the identity of 'supplier'. </summary>
doc:		<param name="client" type="struct rt_processor*"> The client processor. Must not be NULL. </param>
doc:		<param name="second_pid" type="EIF_SCP_PID"> The supplier processor whose identity is temporarily adopted. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the client while the supplier is synchronized. </synchronization>
doc:	</routine>
*/
rt_private void rt_scoop_impersonated_call (struct rt_processor* client, struct rt_processor* supplier, struct call_data* call)
{
	size_t l_count = 0;
	EIF_BOOLEAN is_successful = EIF_FALSE;
#ifdef EIF_ASSERTIONS
	struct rt_private_queue* pq = NULL; /* For assertion checking. */
#endif

	REQUIRE ("client_not_null", client);
	REQUIRE ("supplier_not_null", supplier);
	REQUIRE ("queue_available", T_OK == rt_queue_cache_retrieve (&client->cache, supplier, &pq));
	REQUIRE ("callback_or_synchronized", (supplier->is_passive_region && !supplier->is_creation_procedure_logged) || rt_queue_cache_has_locks_of (&client->cache, supplier) || rt_private_queue_is_synchronized (pq));

		/* Adopt the once values and logical ID of the new thread. */
	rt_swap_thread_context (client, supplier);

		/* Store the size of the request group stack of the impersonated thread. */
	l_count = rt_processor_request_group_stack_count (supplier);

		/* Perform lock passing. */
	is_successful = (T_OK == rt_queue_cache_push (&supplier->cache, &client->cache));

	if (is_successful) {

			/* Register the call_data for GC marking, because it may happen in rt_scoop_try_call()
			* before the Eiffel function starts its execution. */
		client->current_impersonated_call = call;

			/* Safely execute the call and catch exceptions. */
		is_successful = rt_scoop_try_call (call);

			/* Unregister the call_data struct. */
		client->current_impersonated_call = NULL;

			/* Revoke the locks. */
		rt_queue_cache_pop (&supplier->cache);
	}

		/* Restore the size of the request group stack in the supplier. */
	rt_processor_request_group_stack_remove (supplier, rt_processor_request_group_stack_count (supplier) - l_count);

		/* Restore the thread context. */
	rt_swap_thread_context (supplier, client);

		/* Free the call_data struct. */
	free (call);

		/* Propagate the exception, if any. */
	if (!is_successful) {
		eraise ("EVE/Qs dirty processor exception", EN_DIRTY);
	}

}


/*
doc:	<routine name="rt_scoop_is_impersonation_allowed" return_type="void" export="private">
doc:		<summary> Can a separate call be impersonated? </summary>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Should only be called by the client while the supplier is synchronized. </synchronization>
doc:	</routine>
*/
rt_private rt_inline EIF_BOOLEAN rt_scoop_is_impersonation_allowed (struct rt_processor* client, struct rt_processor* supplier, struct rt_private_queue* queue, struct call_data* call)
{
	EIF_BOOLEAN result = EIF_TRUE;

		/* First of all, both client and supplier have to agree that they can handle impersonation.
		 * NOTE: In theory this only depends on the supplier, but we may run into problems with
		 * separate callbacks if we don't consider both processors. */
		/* NOTE: This restriction is also true for passive processors!
		 * As long as there's still a thread, and until we find a better solution, we just
		 * let the other thread execute the call. This undermines the semantics of passive
		 * regions, but at least we don't run into a deadlock. */
	result = client->is_impersonation_allowed && supplier->is_impersonation_allowed;

	if (result) {

			/* A call to a passive region is always impersonated. */
		result = supplier->is_passive_region;

			/* If we're currently synchronized with the supplier (i.e. we already sent
			 * 'supplier' a synchronous call), and the next call is also synchronous,
			 * we can apply impersonation. */
		result = result || (call->sync_pid != EIF_NULL_PROCESSOR &&  rt_private_queue_is_synchronized (queue));

			/* A separate callback is always synchronous, so we can impersonate it. */
		result = result || rt_queue_cache_has_locks_of (&client->cache, supplier);
	}

	return result;
}

/* Fix the call_data struct for expanded types (their PID is wrongly set to the client region). */
rt_private void fix_call_data (struct call_data* call)
{
	size_t i = 0;
	for (; i < call->count; ++i) {
		if (call->argument [i].type == SK_REF) {
			EIF_REFERENCE obj = call->argument [i].item.r;
			if (obj && eif_is_expanded (HEADER(obj)->ov_flags)) {
				RTS_PID (obj) = RTS_PID (call->target);
			}
		}
	}
}

/* Call logging */
rt_public void eif_log_call (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid, call_data *data)
{
	struct rt_processor *client = rt_get_processor (client_pid);
	struct rt_processor *supplier = rt_get_processor (supplier_pid);
	struct rt_private_queue *pq = NULL;
	int error = T_OK;

	REQUIRE("has data", data);

	fix_call_data (data);

	error = rt_queue_cache_retrieve (&client->cache, supplier, &pq);
	if (error != T_OK) {
		enomem();
	}

	if (!supplier->is_creation_procedure_logged) {
			/* Log a creation procedure. */
		if (supplier->is_passive_region && rt_scoop_is_impersonation_allowed (client, supplier, pq, data)) {
			rt_scoop_impersonated_call (client, supplier, data);
		} else {
			rt_private_queue_lock (pq, client);
			rt_private_queue_log_call(pq, client, data);
			rt_private_queue_unlock (pq);
		}
		supplier->is_creation_procedure_logged = EIF_TRUE;

	} else if (rt_scoop_is_impersonation_allowed (client, supplier, pq, data)) {
				/* Perform an impersonated call. */
			rt_scoop_impersonated_call (client, supplier, data);
	} else {
			/* Perform a regular call. */
		rt_private_queue_log_call(pq, client, data);
	}
}

rt_public void eif_call_const (call_data * a)
{
	/* Constant value is hard-coded in the generated code: nothing to do here. */
	/* Avoid C compiler error about unreferenced parameter. */
	(void) a;
}

/* Processor creation */

/* RTS_PA */
rt_public void eif_new_processor (EIF_REFERENCE obj, EIF_BOOLEAN is_passive)
{
	EIF_SCP_PID new_pid = 0;
	int error = T_OK;

		/* TODO: Return newly allocated PID instead of writing it to 'obj'
		   so that the argument 'obj' can be removed. */
	EIF_OBJECT object = eif_protect (obj);

	error = rt_processor_registry_create_region (&new_pid, is_passive);

	switch (error) {
		case T_OK:
			obj = eif_access (object);
			RTS_PID(obj) = new_pid;
			eif_wean (object);
			rt_processor_registry_activate (new_pid);
			break;
		case T_NO_MORE_MEMORY:
			eif_wean (object);
			enomem();
			break;
		default:
			eif_wean (object);
			esys();
			break;
	}
}

/* Status report */

rt_public int eif_is_synced_on (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	struct rt_private_queue* pq = NULL;
	int error = T_OK;
	struct rt_processor* client = rt_get_processor (client_pid);
	struct rt_processor* supplier = rt_get_processor (supplier_pid);

	error = rt_queue_cache_retrieve (&client->cache, supplier, &pq);

	return (error == T_OK) && rt_private_queue_is_synchronized (pq);
}

int eif_is_uncontrolled (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	struct rt_processor *client = rt_get_processor (client_pid);
	struct rt_processor *supplier = rt_get_processor (supplier_pid);

	/*
	 * An object is only uncontrolled when all of the following apply:
	 * - the handlers are different
	 * - the client has no lock on the supplier yet
	 * - the supplier has not passed its locks to the client in a previous call (separate callbacks).
	 */

	return client != supplier
		&& !rt_queue_cache_is_locked (&client->cache, supplier)
		&& !rt_queue_cache_has_locks_of (&client->cache, supplier);
}

/* Entry point for the root thread. */

rt_public void eif_wait_for_all_processors(void)
{
	rt_processor_registry_quit_root_processor ();
}

/*Functions to manipulate the request group stack */

/* RTS_RC (o) - create request group for o */
rt_public void eif_new_scoop_request_group (EIF_SCP_PID client_pid)
{
	struct rt_processor* client = rt_get_processor (client_pid);
	int error = rt_processor_request_group_stack_extend (client);
	if (error != T_OK) {
		enomem();
	}
}

/* Get current size of request group stack. */
rt_public size_t eif_scoop_request_group_stack_count (EIF_SCP_PID client_pid)
{
	struct rt_processor* client = rt_get_processor (client_pid);
	return rt_processor_request_group_stack_count (client);
}

/* RTS_RD (o) - delete request group of o and release any locks */
rt_public void eif_delete_scoop_request_group (EIF_SCP_PID client_pid, size_t count)
{
	struct rt_processor* client = rt_get_processor (client_pid);

		/* Unlock, deallocate and remove the request group. */
	rt_processor_request_group_stack_remove (client, count);
}

/* RTS_RF (o) - wait condition fails */
rt_public void eif_scoop_wait_request_group (EIF_SCP_PID client_pid)
{
	struct rt_processor* client = rt_get_processor (client_pid);
	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);
	int error = rt_request_group_wait (l_group);
		/* Raise an error if we get a memory allocation failure.
		 * Note: The request group will be unlocked sometime later while handling the exception. */
	if (error != T_OK) {
		enomem();
	}
}

/* RTS_RS (c, s) - add supplier s to current group for c */
rt_public void eif_scoop_add_supplier_request_group (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	struct rt_processor* client = rt_get_processor (client_pid);
	struct rt_processor* supplier = rt_get_processor (supplier_pid);

	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);
	int error = rt_request_group_add (l_group, supplier);

		/* Raise an exception if we get a memory allocation failure. */
	if (error != T_OK) {
		enomem();
	}
}

/* RTS_RW (o) - sort all suppliers in the group and get exclusive access */
rt_public void eif_scoop_lock_request_group (EIF_SCP_PID client_pid)
{
	struct rt_processor* client = rt_get_processor (client_pid);
	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);
	rt_request_group_lock (l_group);
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
