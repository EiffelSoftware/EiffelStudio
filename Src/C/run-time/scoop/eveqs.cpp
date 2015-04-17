/*
	description:	"SCOOP support."
	date:		"$Date$"
	revision:	"$Revision: 96304 $"
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

/*
doc:<file name="eveqs.cpp" header="eif_scoop.h" version="$Id$" summary="SCOOP support.">
*/

#include "rt_msc_ver_mismatch.h"
#include "processor_registry.hpp"
#include "processor.hpp"
#include "eif_interp.h"
#include "eif_atomops.h"
#include "rt_wbench.h"
#include "rt_struct.h"
#include "rt_assert.h"

#ifdef __cplusplus
extern "C" {
#endif

/* RTS_RC (o) - create request group for o */
rt_public void eif_new_scoop_request_group (EIF_SCP_PID client_pid)
{
	processor *client = rt_get_processor (client_pid);
	rt_processor_request_group_stack_extend (client);
}

/* RTS_RD (o) - delete request group of o and release any locks */
rt_public void eif_delete_scoop_request_group (EIF_SCP_PID client_pid)
{
	processor *client = rt_get_processor (client_pid);

		/* Unlock, deallocate and remove the request group. */
	rt_processor_request_group_stack_remove_last (client);
}

/* RTS_RF (o) - wait condition fails */
rt_public void eif_scoop_wait_request_group (EIF_SCP_PID client_pid)
{
	processor *client = rt_get_processor (client_pid);
	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);
	rt_request_group_wait (l_group);
}

/* RTS_RS (c, s) - add supplier s to current group for c */
rt_public void eif_scoop_add_supplier_request_group (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	processor *client = rt_get_processor (client_pid);
	processor *supplier = rt_get_processor (supplier_pid);

	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);
	rt_request_group_add (l_group, supplier);
}

/* RTS_RW (o) - sort all suppliers in the group and get exclusive access */
rt_public void eif_scoop_lock_request_group (EIF_SCP_PID client_pid)
{
	processor *client = rt_get_processor (client_pid);
	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);
	rt_request_group_lock (l_group);
}

/* Processor creation */
/* RTS_PA */
rt_public void eif_new_processor (EIF_REFERENCE obj)
{
	EIF_SCP_PID new_pid = 0;
	int error = T_OK;

		/* TODO: Return newly allocated PID instead of writing it to 'obj'
		   so that the argument 'obj' can be removed. */
	EIF_OBJECT object = eif_protect (obj);

	error = rt_processor_registry_create_region (&new_pid);

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

/* Call logging */

#ifdef WORKBENCH
rt_public void eif_apply_wcall (call_data *data)
{
	uint32            pid = 0; /* Pattern id of the frozen feature */
	EIF_NATURAL_32    i;
	EIF_NATURAL_32    n;
	BODY_INDEX        body_id;
	EIF_TYPED_VALUE * v;

	REQUIRE("has data", data);
	REQUIRE("has target", data->target);

		/* Push arguments to the evaluation stack */
	for (n = data->count, i = 0; i < n; i++) {
		v = iget ();
		* v = data->argument [i];
		if ((v->it_r) && (v->type & SK_HEAD) == SK_REF) {
			v->it_r = v->it_r;
		}
	}
		/* Push current to the evaluation stack */
	v = iget ();
	v->it_r = data->target;
	v->type = SK_REF;
		/* Make a call */
	CBodyId(body_id, data->routine_id,Dtype(data->target));
	if (egc_frozen [body_id]) {		/* We are below zero Celsius, i.e. ice */
		pid = (uint32) FPatId(body_id);
		(pattern[pid].toc)(egc_frozen[body_id]); /* Call pattern */
	} else {
		/* The proper way to start the interpretation of a melted feature is to call `xinterp'
		 * in order to initialize the calling context (which is not done by `interpret').
		 * `tagval' will therefore be set, but we have to resynchronize the registers anyway.
		 */
		xinterp(MTC melt[body_id], 0);
	}
		/* Save result of a call if any. */
	v = data->result;
	if (v) {
		* v = * opop ();
	}
}
#endif

rt_public void eif_log_call (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid, call_data *data)
{
	processor *client = rt_get_processor (client_pid);
	processor *supplier = rt_get_processor (supplier_pid);
	priv_queue *pq = rt_queue_cache_retrieve (&client->cache, supplier);

	REQUIRE("has data", data);

	if (!supplier->is_creation_procedure_logged) {
		rt_private_queue_lock (pq, client);
		rt_private_queue_log_call(pq, client, data);
		rt_private_queue_unlock (pq);
		supplier->is_creation_procedure_logged = EIF_TRUE;
	} else {
		rt_private_queue_log_call(pq, client, data);
	}
}

rt_public int eif_is_synced_on (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	processor *client = rt_get_processor (client_pid);
	processor *supplier = rt_get_processor (supplier_pid);
	priv_queue *pq = rt_queue_cache_retrieve (&client->cache, supplier);

	return rt_private_queue_is_synchronized (pq);
}

int eif_is_uncontrolled (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	processor *client = rt_get_processor (client_pid);
	processor *supplier = rt_get_processor (supplier_pid);
	
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

/* Callback from garbage collector to indicate that the */
/* processor isn't used anymore. */
rt_shared void rt_unmark_processor (EIF_SCP_PID pid)
{
	rt_processor_registry_deactivate (pid);
}

/*
doc:	<routine name="rt_enumerate_live_processors" return_type="void" export="shared">
doc:		<summary> Mark all processors that currently have a client as alive. 
doc:			Note: This is an approximation (i.e. a subset) of the truly alive processors.
doc:			Some processors may not have a client at the moment, but some objects on them are still referenced. </summary>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during GC. </synchronization>
doc:	</routine>
*/
rt_shared void rt_enumerate_live_processors(void)
{
	processor* proc = NULL;
	
	for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
		
		proc = rt_lookup_processor (i);
		
			/* We also mark processors as alive whose creation procedure has not been logged yet.
			 * This avoids a potential problem that a processor is garbage collected after creation,
			 * just before the RTS_PID() of its root feature has been set. */
		if (proc && (proc->has_client || !proc->is_creation_procedure_logged)) {
			rt_mark_live_pid (proc->pid);
		}
	}
}

rt_public void eif_wait_for_all_processors(void)
{
	rt_processor_registry_quit_root_processor ();
}

/*
doc:	<routine name="rt_mark_all_processors" return_type="void" export="shared">
doc:		<summary> Mark all processors in the system. </summary>
doc:		<param name="marking" type="MARKER"> The marker function. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during GC. </synchronization>
doc:	</routine>
*/
rt_shared void rt_mark_all_processors (MARKER marking)
{
	static volatile EIF_INTEGER_32 rt_is_marking = 0;
	processor* proc = NULL;

	EIF_INTEGER_32 new_value = 1;
	EIF_INTEGER_32 expected = 0;

	REQUIRE ("marking_not_null", marking);

		/* Use compare-exchange to determine whether marking is necessary. */
		/* TODO: RS: Why is it necessary to use CAS here? As far as I can see this
		 * operation is called exactly once and only by a single thread during GC... */
	EIF_INTEGER_32 previous = RTS_ACAS_I32 (&rt_is_marking, new_value, expected);

	if (previous == expected) {
		for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {

			proc = rt_lookup_processor (i);
			if (proc) {
				rt_processor_mark (proc, marking);
			}
		}
			/* Reset rt_is_marking to zero. */
		RTS_AS_I32 (&rt_is_marking, 0);
	}
}

/*
doc:	<routine name="rt_scoop_setup" return_type="void" export="shared">
doc:		<summary> Initialize the SCOOP subsystem and mark the root thread as a processor with ID 0. </summary>
doc:		<param name="is_scoop_enabled" type="int"> Whether SCOOP was enabled in the project settings. Depending on this value initialization may be partially skipped. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during program startup. </synchronization>
doc:	</routine>
*/
rt_public void rt_scoop_setup (int is_scoop_enabled)
{
		/* Note: We initialize the SCOOP processor_registry in any case,
		 * because of a bug in the interpreter which may sometimes execute RTS_OU
		 * even in non-SCOOP systems. */
	int error = rt_processor_registry_init ();

	if (T_OK == error && is_scoop_enabled) {
			/* Record that the current thread is associated with a processor of a PID 0. */
		eif_set_processor_id (0);
	}

	if (T_OK != error) {
		eif_panic ("Could not initialize SCOOP subsystem.");
	}
}

/*
doc:	<routine name="rt_scoop_reclaim" return_type="void" export="shared">
doc:		<summary> Reclaim all resources in the SCOOP subsystem. </summary>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during program termination. </synchronization>
doc:	</routine>
*/
rt_public void rt_scoop_reclaim (void)
{
	rt_processor_registry_deinit();
}


#ifdef __cplusplus
}
#endif

/*
doc:</file>
*/
