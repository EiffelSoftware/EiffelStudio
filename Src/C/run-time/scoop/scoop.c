/*
	description:	"SCOOP support."
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
doc:<file name="scoop.c" header="eif_scoop.h" version="$Id$" summary="SCOOP support.">
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

/* Call logging */

rt_public void eif_log_call (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid, call_data *data)
{
	struct rt_processor *client = rt_get_processor (client_pid);
	struct rt_processor *supplier = rt_get_processor (supplier_pid);
	struct rt_private_queue *pq = rt_queue_cache_retrieve (&client->cache, supplier);

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

rt_public void eif_call_const (call_data * a)
{
	/* Constant value is hard-coded in the generated code: nothing to do here. */
	/* Avoid C compiler error about unreferenced parameter. */
	(void) a;
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

/* Status report */

rt_public int eif_is_synced_on (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	struct rt_processor *client = rt_get_processor (client_pid);
	struct rt_processor *supplier = rt_get_processor (supplier_pid);
	struct rt_private_queue *pq = rt_queue_cache_retrieve (&client->cache, supplier);

	return rt_private_queue_is_synchronized (pq);
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

/* Obsolete functions */

/* Push client `c' on the request chain stack `stk' without notifying SCOOP mananger. */
rt_public void eif_request_chain_push (EIF_REFERENCE c, struct stack * stk)
{
	epush (stk, c);
}

/* Pop one element from the request chain stack `stk' without notifying SCOOP mananger. */
rt_public void eif_request_chain_pop (struct stack * stk)
{
	EIF_REFERENCE * top = stk->st_top - 1;   /* Start from the current top. */

	if (top >= stk->st_cur->sk_arena) {
		stk->st_top = top;               /* We remain in current chunk. */
	}
	else {
		struct stchunk * s;              /* Top is in the previous chunk. */

		RT_GET_CONTEXT

		SIGBLOCK;                        /* Entering critical section */

		s = stk->st_cur->sk_prev;        /* Look at previous chunk */
		CHECK("sep_stack underflow", s);
		top = s->sk_end - 1;		 /* Top at the end of previous chunk */

		stk->st_cur = s;                 /* Update stack structure */
		stk->st_top = top;
		stk->st_end = s->sk_end;

		SIGRESUME;                       /* Leaving critical section */
#ifdef WORKBENCH
		if (d_cxt.pg_status == PG_RUN)   /* Program is running */
#endif
			st_truncate(stk);        /* Remove unused chunks */
	}
}

/* Restore request chain stack `stk' to have the top `t' notifying SCOOP manager about all removed request chains. */
rt_public void eif_request_chain_restore (EIF_REFERENCE * t, struct stack * stk)
{
	EIF_REFERENCE * top = stk->st_top;
	if (!t) {
		t = stk->st_hd->sk_arena; /* Use the beginning of the stack in case stack was empty. */
	}
	while (top != t) {
		eif_request_chain_pop (stk); /* Pop one element. */
		top = stk->st_top;
		RTS_RD (*top);               /* Notify SCOOP manager about removed item. */
	}
}

/*Functions to manipulate the request group stack */

/* RTS_RC (o) - create request group for o */
rt_public void eif_new_scoop_request_group (EIF_SCP_PID client_pid)
{
	struct rt_processor* client = rt_get_processor (client_pid);
	rt_processor_request_group_stack_extend (client);
}

/* RTS_RD (o) - delete request group of o and release any locks */
rt_public void eif_delete_scoop_request_group (EIF_SCP_PID client_pid)
{
	struct rt_processor* client = rt_get_processor (client_pid);

		/* Unlock, deallocate and remove the request group. */
	rt_processor_request_group_stack_remove_last (client);
}

/* RTS_RF (o) - wait condition fails */
rt_public void eif_scoop_wait_request_group (EIF_SCP_PID client_pid)
{
	struct rt_processor* client = rt_get_processor (client_pid);
	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);
	rt_request_group_wait (l_group);
}

/* RTS_RS (c, s) - add supplier s to current group for c */
rt_public void eif_scoop_add_supplier_request_group (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	struct rt_processor* client = rt_get_processor (client_pid);
	struct rt_processor* supplier = rt_get_processor (supplier_pid);

	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);
	rt_request_group_add (l_group, supplier);
}

/* RTS_RW (o) - sort all suppliers in the group and get exclusive access */
rt_public void eif_scoop_lock_request_group (EIF_SCP_PID client_pid)
{
	struct rt_processor* client = rt_get_processor (client_pid);
	struct rt_request_group* l_group = rt_processor_request_group_stack_last (client);
	rt_request_group_lock (l_group);
}

/*
doc:</file>
*/
