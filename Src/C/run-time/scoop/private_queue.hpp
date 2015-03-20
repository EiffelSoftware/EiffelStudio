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

#ifndef _PRIV_QUEUE_H
#define _PRIV_QUEUE_H
#include "eif_utils.hpp"

#include "rt_message.h"
#include "rt_message_channel.hpp"

class processor;
class priv_queue;

/* Declarations. */
rt_shared void rt_private_queue_init (priv_queue* self, processor* a_supplier);
rt_shared void rt_private_queue_deinit (priv_queue* self);



/* The private queue class.
 *
 * This structure functions as a lock between the client and the supplier.
 * The client is not always the original client that created the queue,
 * as this queue may be passed to other clients during lock-passing.
 */
class priv_queue
{
public:

  /* The lifetime end-point of this queue. */
  processor *supplier;
  
  /* Locks this private queue.
   * @client the client of this locking operation
   *
   * This places this queue in the <supplier>s queue of queues <qoq>.
   * Locking can be recursive, both for the owner and any recipients of
   * lock passing.
   */
  void lock(processor *client);

  /* Logs a new call to the supplier.
   * @client the client of the call
   * @call the call to go to the supplier.
   *
   * This is essentially an enqueue operation on the underlying 
   * concurrent queue, waking the supplier if it was waiting on this
   * queue for more calls.
   */
  void log_call(processor *client, call_data *call);

  /* Receive a new call.
   * @call will contain the calla fter the return of the function.
   *
   * This will be called by the supplier to receive new calls from the client
   * (**or** some processor that the client has passed its locks to).
   * This is a blocking call if no call data is available.
   */
  void pop_msg (rt_message &msg)
  {
    rt_message_channel_receive (&this->channel, &msg);
  }

  /* Register a wait operation with the <supplier>.
   * @client the client to call back
   *
   * The <supplier> will contact the client when it has executed some
   * other calls, and thus may have changed a wait-condition.
   */
  void register_wait(processor* client);

  /* Unlock this queue.
   *
   * Instructs the <supplier> to remove this queue from the <qoq>.
   */
  void unlock();

  /* The locked status of this queue.
   *
   * Reports if this queue is currently locked.
   */
  bool is_locked();

  /* The synchronization status of the queue with the <supplier>.
   *
   * The queue is considered synchronized if the <supplier> is currently processing
   * this queue but is not currently applying any call, and the queue itself
   * is empty.
   */
  bool is_synced();

  /* GC interaction */
public:
  /* Mark the call data.
   * @mark the marking routine to use.
   *
   * This is for integration with the EiffelStudio garbage collector
   * so that the target and arguments of the calls in the call data
   * (which is here outside the view of the runtime) will not be collected.
   */
  void mark (MARKER marking);

public:
  rt_message call_stack_msg;
  bool synced;
  int lock_depth;

	/* The message channel of this queue. */
  struct rt_message_channel channel;
};

#endif
