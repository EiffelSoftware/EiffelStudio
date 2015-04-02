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
#include "eif_utils.hpp"
#include "processor_registry.hpp"
#include "internal.hpp"
#include "eif_interp.h"
#include "rt_wbench.h"
#include "rt_struct.h"
#include "rt_assert.h"

#ifdef __cplusplus
extern "C" {
#endif

/* RTS_RC (o) - create request group for o */
rt_public void eif_new_scoop_request_group (EIF_SCP_PID client_pid)
{
	processor *client = registry [client_pid];
	rt_processor_request_group_stack_extend (client);
}

/* RTS_RD (o) - delete request group of o and release any locks */
rt_public void eif_delete_scoop_request_group (EIF_SCP_PID client_pid)
{
	processor *client = registry [client_pid];

		/* Unlock, deallocate and remove the request group. */
	rt_processor_request_group_stack_remove_last (client);
}

/* RTS_RF (o) - wait condition fails */
rt_public void eif_scoop_wait_request_group (EIF_SCP_PID client_pid)
{
	processor *client = registry [client_pid];
	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);
	rt_request_group_wait (l_group);
}

/* RTS_RS (c, s) - add supplier s to current group for c */
rt_public void eif_scoop_add_supplier_request_group (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	processor *client = registry [client_pid];
	processor *supplier = registry [supplier_pid];

	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);
	rt_request_group_add (l_group, supplier);
}

/* RTS_RW (o) - sort all suppliers in the group and get exclusive access */
rt_public void eif_scoop_lock_request_group (EIF_SCP_PID client_pid)
{
	processor *client = registry [client_pid];
	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);
	rt_request_group_lock (l_group);
}

/* Processor creation */
/* RTS_PA */
rt_public void eif_new_processor (EIF_REFERENCE obj)
{
	registry.create_fresh (obj);
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
	processor *client = registry [client_pid];
	processor *supplier = registry [supplier_pid];
	priv_queue *pq = rt_queue_cache_retrieve (&client->cache, supplier);

	REQUIRE("has data", data);

	if (!supplier->is_creation_procedure_logged) {
		supplier->is_creation_procedure_logged = EIF_TRUE;
		rt_private_queue_lock (pq, client);
		rt_private_queue_log_call(pq, client, data);
		rt_private_queue_unlock (pq);
	} else {
		rt_private_queue_log_call(pq, client, data);
	}
}

rt_public int eif_is_synced_on (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	processor *client = registry [client_pid];
	processor *supplier = registry [supplier_pid];
	priv_queue *pq = rt_queue_cache_retrieve (&client->cache, supplier);

	return rt_private_queue_is_synchronized (pq);
}

int eif_is_uncontrolled (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	processor *client = registry [client_pid];
	processor *supplier = registry [supplier_pid];
	
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
	registry.unmark(pid);
}

rt_shared void rt_enumerate_live_processors(void)
{
	registry.enumerate_live();
}

rt_public void eif_wait_for_all_processors(void)
{
	registry.wait_for_all();
}

rt_shared void rt_mark_all_processors (MARKER marking)
{
	registry.mark_all(marking);
}

#ifdef __cplusplus
}
#endif

/*
doc:</file>
*/
