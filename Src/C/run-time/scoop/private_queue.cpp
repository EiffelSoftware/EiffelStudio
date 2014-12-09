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

#include "eveqs.h"
#include "internal.hpp"
#include "processor.hpp"
#include "processor_registry.hpp"
#include "private_queue.hpp"
#include "eif_utils.hpp"

priv_queue::priv_queue (processor *_supplier) :
	spsc<pq_message>(),
	supplier (_supplier),
	dirty (false),
	call_stack_msg(),
	synced (false),
	lock_depth(0)
{
}

void priv_queue::lock(processor *client)
{
	if (lock_depth == 0) {
		supplier->qoq.push(qoq_item (client, this));
		synced = false;
	}
	lock_depth++;
}

bool priv_queue::is_locked()
{
	return lock_depth > 0;
}

bool priv_queue::is_synced()
{
	return synced;
}

void priv_queue::register_wait(processor *client)
{
	client->my_token.register_supplier(supplier);
	synced = false;
}

void priv_queue::log_call(processor *client, call_data *call)
{
	EIF_SCP_PID l_sync_pid = call_data_sync_pid(call);
	bool will_sync = l_sync_pid != NULL_PROCESSOR_ID;

		// NOTE: After this push(), call might be free'd,
		// therefore processor ID should be stored before it.
	push (pq_message (pq_message::e_normal, client, call));

	if (will_sync) {
		processor *client = registry[l_sync_pid];

		call_stack_msg = client->result_notify.wait();

		for (;
			call_stack_msg.type == notify_message::e_callback;
			call_stack_msg = client->result_notify.wait())
		{
			(*client)(call_stack_msg.client, call_stack_msg.call);
			call_stack_msg.call = NULL;
		}

		if (call_stack_msg.type == notify_message::e_dirty) {
			eraise ((const char *) "EVE/Qs dirty processor exception", 32);
		}
	}

	synced = will_sync;
}

void priv_queue::unlock()
{
	lock_depth--;

	if (lock_depth == 0) {
		push (pq_message (pq_message::e_unlock));
		synced = false;
	}
}

void priv_queue::mark(marker_t mark)
{
	spsc <pq_message>::mark (mark);

	if (call_stack_msg.call) {
		mark_call_data (mark, call_stack_msg.call);
	}
}
