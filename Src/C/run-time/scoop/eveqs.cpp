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
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with EVE/Qs.  If not, see <http://www.gnu.org/licenses/>.
//

#include "eif_utils.hpp"
#include "internal.hpp"
#include "eveqs.h"
#include "processor_registry.hpp"
#include "processor.hpp"

extern "C"
{
  // RTS_RC (o) - create request group for o
  void
  eveqs_req_grp_new (spid_t client_pid)
  {
    processor *client = registry [client_pid];
    client->group_stack.push_back (req_grp(client));
  }

  // RTS_RD (o) - delete chain (release locks?)
  void
  eveqs_req_grp_delete (spid_t client_pid)
  {
    processor *client = registry [client_pid];
    client->group_stack.back().unlock();
    client->group_stack.pop_back();
  }

  // RTS_RF (o) - wait condition fails
  void
  eveqs_req_grp_wait (spid_t client_pid)
  {
    processor *client = registry [client_pid];
    client->group_stack.back().wait();
  }

  // RTS_RS (c, s) - add supplier s to current group for c
  void
  eveqs_req_grp_add_supplier (spid_t client_pid, spid_t supplier_pid)
  {
    processor *client = registry [client_pid];
    processor *supplier = registry [supplier_pid];
    client->group_stack.back().add (supplier);
  }

  // RTS_RW (o) - sort all suppliers in the group and get exclusive access
  void
  eveqs_req_grp_lock (spid_t client_pid)
  {
    processor *client = registry [client_pid];
    client->group_stack.back().lock();
  }

  //
  // Processor creation
  //

  // RTS_PA
  void
  eveqs_processor_fresh (void *obj)
  {
    registry.create_fresh (obj);
  }

  //
  // Call logging
  //

  void
  eveqs_call_on (spid_t client_pid, spid_t supplier_pid, void* data)
  {
    call_data *call = (call_data*) data;
    processor *client = registry [client_pid];
    processor *supplier = registry [supplier_pid];
    priv_queue *pq = client->cache [supplier];

    if (!supplier->has_backing_thread)
      {
	supplier->has_backing_thread = true;
	pq->lock(client);
	pq->log_call (client, call);
	pq->unlock();
      }
    else if (client->cache.has_subordinate (supplier))
      {
	supplier->result_notify.callback_awake (client, call);
	if (call_data_sync_pid (call) != NULL_PROCESSOR_ID)
	  {
	    client->result_notify.wait();
	  }
      }
    else
      {
	pq->log_call (client, call);
      }
  }

  int
  eveqs_is_synced_on (spid_t client_pid, spid_t supplier_pid)
  {
    processor *client = registry [client_pid];
    processor *supplier = registry [supplier_pid];

    priv_queue *pq = client->cache [supplier];
    return pq->is_synced();
  }

  int
  eveqs_is_uncontrolled (spid_t client_pid, spid_t supplier_pid)
  {
    processor *client = registry [client_pid];
    processor *supplier = registry [supplier_pid];

    return client != supplier && !client->cache.has_locked (supplier);
  }

  //
  // Callback from garbage collector to indicate that the
  // processor isn't used anymore.
  //
  void
  eveqs_unmarked(spid_t pid)
  {
    registry.unmark (pid);
  }

  void
  eveqs_enumerate_live()
  {
    registry.enumerate_live();
  }

  void
  eveqs_wait_for_all()
  {
    registry.wait_for_all();
  }

  void
  eveqs_mark_all (marker_t mark)
  {
    registry.mark_all (mark);
  }
}
