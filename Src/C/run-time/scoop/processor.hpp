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

#ifndef _PROCESSOR_H
#define _PROCESSOR_H
#include <memory>
#include "qoq.hpp"

#include "private_queue.hpp"
#include "req_grp.hpp"
#include "queue_cache.hpp"

#include "rt_vector.h"

/* Define the struct to be used for the group stack. */
RT_DECLARE_VECTOR_BASE (request_group_stack_t, struct rt_request_group)

/* Define the vector to be used for wait condition subscribers. */
RT_DECLARE_VECTOR_BASE (subscriber_list_t, processor*)

/* Define the vector to be used for keeping track of private queues of this processor. */
RT_DECLARE_VECTOR_BASE (private_queue_list_t, priv_queue*)



/* The SCOOP logical unit of processing.
 *
 * The processor is responsible for receiving calls, executing them, and
 * notifying clients of changes.
 */
class processor
{

public:
  /* Construct a new processor.
   * @_pid the processor ID that will be used to identify this processor
   *       to the Eiffel runtime
   * @_has_backing_thread whether the processor alreadyd has a backing thread,
   *                      normally this is false, but for the root processor
   *                      it will already be true.
   *
   * The new processor will usually not yet have a thread backing it.
   */
  processor(EIF_SCP_PID _pid,
            bool _has_backing_thread = false);

  ~processor();

  /* The main loop of the processor.
   *
   * Normally this will be called when the thread spawns but here we expose it
   * so that it may be called externally for the root thread (whose thread is
   * the main thread of the program, and thus already exists).
   */
  void application_loop();

  /* Send a shutdown message.
   *
   * Sending a shutdown message will cause the thread to shutdown when it
   * receives it. It will only receive it after it has processed the other
   * requests in its <qoq>, so it may not take effect immediately.
   */
  void shutdown();

public:
  /* The cache of private queues.
   */
  queue_cache cache;

  /* Process a call on this processor.
   * @client the client of the call
   * @call the call to execute.
   */
  void
  operator()(processor *client, call_data* call);

public:
  /* The queue of queues.
   * 
   * This will be used by private queues to add new calls for this processor
   * to apply.
   */
  mpscq <qoq_item> qoq;
  EIF_MUTEX_TYPE* queue_of_queues_mutex;

public:
  /* A stack of request groups.
   * 
   * The vector here is used as a stack, which mirrors the processors locked
   * in the real call stack.
   */
  struct request_group_stack_t request_group_stack;

public:

	/* The mutex and condition variable
	* for wait conditions. Suppliers will signal on this
	* CV when a wait condition may have changed, and the client
	* (the current processor) will wait on this variable. */
	EIF_MUTEX_TYPE* wait_condition_mutex;
	EIF_COND_TYPE* wait_condition;

		/* The processors that registered for a wait condition change. */
	subscriber_list_t wait_condition_subscribers;

private:
  void notify_next(processor *);


public:

  /* Has a client.
   * 
   * This is used to prevent an active
   * processor, which may not have any references to it, from being collected.
   */
  bool has_client;

  /* Marks the processor's <priv_queues>
   * @mark The specific marking routine.
   */
  void mark (MARKER marking);

public:
  /* A result notifier.
   * 
   * This is the notifier that this processor will wait on when
   * it asks another processor for a result.
   */
  struct rt_message_channel result_notify;

public:
  /* Ask the Eiffel runtime to make a new thread for this processor.
   */
  void spawn();
  
  /* Has an associated thread.
   * 
   * True if this processor has a thread spawned to back it.
   */
  volatile bool has_backing_thread;

  /* Notifier for startup.
   *
   * Lets the constructing thread know that the backing
   * thread for this processor has been spawned.
   * It is important for GC that the thread that requested this processor
   * to spawn a thread doesn't proceed until it has been constructed.
   */
  struct rt_message_channel startup_notify;

  /* The processor ID.
   */
  EIF_SCP_PID pid;

public:
  /* New private queue.
   *
   * @return a new private queue whose supplier is this processor.
   */
  priv_queue*
  new_priv_queue();

private:
	/* The queues generated by this processor.
	 * Every queue in this list has the current processor as its supplier. */
	struct private_queue_list_t generated_private_queues;
	EIF_MUTEX_TYPE* generated_private_queues_mutex;

private:

  /* Stores whether the current processor / region is marked as dirty.*/
  bool is_dirty;

  /* The current message we have.
   * 
   * This call in here will be traced during marking.
   */
  rt_message current_msg;

  /* Try to execute a call from the private queue.
   * @pq private queue to take the call from
   * @call the call to apply
   */
  bool try_call (call_data *call);

  void process_priv_queue(priv_queue*);

};

/* Wait condition subscription management. */
rt_shared void rt_processor_subscribe_wait_condition (processor* self, processor* client);
rt_shared void rt_processor_unsubscribe_wait_condition (processor* self, processor* dead_processor);

/* Declarations for group stack manipulation. */
rt_shared void rt_processor_request_group_stack_extend (processor* self);
rt_shared struct rt_request_group* rt_processor_request_group_stack_last (processor* self);
rt_shared void rt_processor_request_group_stack_remove_last (processor* self);

#endif
