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
doc:<file name="private_queue.cpp" header="private_queue.hpp" version="$Id$" summary="SCOOP support.">
*/

#include "rt_msc_ver_mismatch.h"
#include "internal.hpp"
#include "processor.hpp"
#include "processor_registry.hpp"
#include "private_queue.hpp"
#include "eif_utils.hpp"

priv_queue::priv_queue (processor *_supplier) :
	supplier (_supplier),
	dirty (false),
	synced (false),
	lock_depth(0)
{
	rt_message_channel_init (&this->channel, 512);
	rt_message_init (&this->call_stack_msg, SCOOP_MESSAGE_UNLOCK, NULL, NULL); /* TODO: default state? */
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


	if (rt_queue_cache_has_locks_of (&client->cache, supplier)) {
		/* 
		 * We need to log a call which is a separate callback, 
		 * meaning that the supplier has previously logged a 
		 * synchronous call on the client and is now waiting for a result.
		 * 
		 * The supplier might perform (nested) callbacks or dirty wakeups,
		 * and we have to be ready to receive them afterwards.
		 * 
		 * See also test#scoop044, test#scoop051 and review#6008977502502912.
		 */
		
		/* A separate callback should always be synchronous. */
		l_sync_pid = client-> pid;
		call -> sync_pid = client -> pid;
		will_sync = EIF_TRUE;

		rt_message_channel_send (&supplier->result_notify, SCOOP_MESSAGE_CALLBACK, client, call);
		
	} else {
			/* NOTE: After this push(), call might be free'd, */
			/* therefore processor ID should be stored before it. */
		rt_message_channel_send (&this->channel, SCOOP_MESSAGE_EXECUTE, client, call);
	}
	
	if (will_sync) {
			/* 
			 * TODO: Figure out if it's really necessary to go to
			 * the registry again to get the client to sync on.
			 * In particular, would this invariant hold here?
			 * client == (shadowed) client && (shadowed) client->pid == l_sync_pid
			 */
		processor *client = registry[l_sync_pid];

			/* Wait on our own result notifier for a message by the other processor. */
		rt_message_channel_receive (&client->result_notify, &call_stack_msg);

		for (;
			call_stack_msg.message_type == SCOOP_MESSAGE_CALLBACK;
			rt_message_channel_receive (&client->result_notify, &call_stack_msg))
		{
			(*client)(call_stack_msg.sender, call_stack_msg.call);
			call_stack_msg.call = NULL;
		}

		if (call_stack_msg.message_type == SCOOP_MESSAGE_DIRTY) {
			eraise ((const char *) "EVE/Qs dirty processor exception", 32);
		}
	}

	synced = will_sync;
}

void priv_queue::unlock()
{
	lock_depth--;

	if (lock_depth == 0) {
		rt_message_channel_send (&this->channel, SCOOP_MESSAGE_UNLOCK, NULL, NULL);
		synced = false;
	}
}

void priv_queue::mark(MARKER marking)
{
	rt_message_channel_mark (&this->channel, marking);

	if (call_stack_msg.call) {
		rt_mark_call_data (marking, call_stack_msg.call);
	}
}

/*
doc:</file>
*/
