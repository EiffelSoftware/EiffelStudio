//
// EVE/Qs - A new runtime for the EVE SCOOP implementation
// Copyright (C) 2014 Scott West <scott.gregory.west@gmail.com>
//
// This file is part of EVE/Qs.
//
// EVE/Qs is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// EVE/Qs is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with EVE/Qs.	If not, see <http://www.gnu.org/licenses/>.
//

#include "eif_utils.hpp"
#include "internal.hpp"
#include "processor_registry.hpp"
#include "processor.hpp"

#ifdef __cplusplus
extern "C" {
#endif

// RTS_RC (o) - create request group for o
rt_public void eif_new_scoop_request_group (EIF_SCP_PID client_pid)
{
	processor *client = registry [client_pid];
	client->group_stack.push_back (req_grp(client));
}

// RTS_RD (o) - delete chain (release locks?)
rt_public void eif_delete_scoop_request_group (EIF_SCP_PID client_pid)
{
	processor *client = registry [client_pid];
	client->group_stack.back().unlock();
	client->group_stack.pop_back();
}

// RTS_RF (o) - wait condition fails
rt_public void eif_scoop_wait_request_group (EIF_SCP_PID client_pid)
{
	processor *client = registry [client_pid];
	client->group_stack.back().wait();
}

// RTS_RS (c, s) - add supplier s to current group for c
rt_public void eif_scoop_add_supplier_request_group (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	processor *client = registry [client_pid];
	processor *supplier = registry [supplier_pid];
	client->group_stack.back().add (supplier);
}

// RTS_RW (o) - sort all suppliers in the group and get exclusive access
rt_public void eif_scoop_lock_request_group (EIF_SCP_PID client_pid)
{
	processor *client = registry [client_pid];
	client->group_stack.back().lock();
}

//
// Processor creation
//

// RTS_PA
rt_public void eif_new_processor (EIF_REFERENCE obj)
{
	registry.create_fresh (obj);
}

//
// Call logging
//

rt_public void eif_log_call (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid, void* data)
{
	call_data *call = (call_data*) data;
	processor *client = registry [client_pid];
	processor *supplier = registry [supplier_pid];
	priv_queue *pq = client->cache [supplier];

	if (!supplier->has_backing_thread) {
		supplier->has_backing_thread = true;
		pq->lock(client);
		pq->log_call(client, call);
		pq->unlock();
	} else if (client->cache.has_subordinate(supplier)) {
		supplier->result_notify.callback_awake(client, call);
		if (call_data_sync_pid(call) != NULL_PROCESSOR_ID) {
			client->result_notify.wait();
		}
	} else {
		pq->log_call(client, call);
	}
}

rt_public int eif_is_synced_on (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	processor *client = registry [client_pid];
	processor *supplier = registry [supplier_pid];

	priv_queue *pq = client->cache [supplier];
	return pq->is_synced();
}

int eif_is_uncontrolled (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid)
{
	processor *client = registry [client_pid];
	processor *supplier = registry [supplier_pid];

	return client != supplier && !client->cache.has_locked(supplier);
}

//
// Callback from garbage collector to indicate that the
// processor isn't used anymore.
//
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
