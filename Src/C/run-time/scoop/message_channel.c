/*
	description:	"A channel for rt_message structs between processors."
	date:		"$Date$"
	revision:	"$Revision$"
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
doc:<file name="message_channel.c" header="rt_message_channel.h" version="$Id$" summary="A channel for rt_message structs between processors.">
*/

#include "rt_message_channel.h"
#include "eif_error.h"
#include "eif_threads.h"

/* Variables to tweak the frequency of garbage collector runs. */
#define RT_GC_TIMEOUT_START 100
#define RT_GC_TIMEOUT_STEP 2

/* TODO: The message_channel version that doesn't use locking probably has a bug
 * where a message gets lost sometimes. The bug is extremely rare and hard to
 * reproduce, but so far it didn't happen when everything is protected by locks.
 * Therefore we use the approach with locks for the moment, which may be a bit slower
 * but at least works correctly. */
#undef EIF_HAS_MEMORY_BARRIER

/*
doc:	<struct name="mc_node", export="private">
doc:		<summary> A message channel node which forms a linked list. </summary>
doc:		<field name="next", type="struct mc_node*"> The next node within the list. </field>
doc:		<field name="value", type="struct rt_message"> The message within the current node. </field>
doc:	</struct>
 */
struct mc_node {
	struct mc_node* next;
	struct rt_message value;
};

/*
doc:	<routine name="load_consume" return_type="struct mc_node*" export="private">
doc:		<summary> Dereference 'node_address', followed by an acquire fence.
doc:			The fence instruction ensures that any read or write operation after the fence is not reordered with any read operation before the fence. </summary>
doc:		<param name="node_address" type="struct mc_node**"> The pointer-pointer to be dereferenced. Must not be NULL. </param>
doc:		<return> The value at location 'node_address'. </return>
doc:		<thread_safety> Safe </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:		<fixme> Currently this only works on x86, which has relatively strong ordering guarantees.
doc:			Furthermore, we currently use a very strong fence internally.
doc:			We may be able to tune performance a bit by just using an acquire fence. </fixme>
doc:	</routine>
*/
rt_private rt_inline struct mc_node* load_consume (struct mc_node*const* node_address)
{

		/* Read this as a "pointer to a constant volatile pointer to an mc_node" */
		/* RS: Is this to ensure that the memory lookup actually happens and isn't optimized away, i.e. to reduce latency? */
	struct mc_node* const volatile* volatile_node_address = (struct mc_node* const volatile*) node_address;
	struct mc_node* result = *volatile_node_address;

		/* This is the correct position of the fence.
		 * The fence nesures that all the values written into the mc_node
		 * struct by another thread are now visible by this thread. */

#if defined EIF_HAS_MEMORY_BARRIER
		/* Compiler fence */
	EIF_MEMORY_BARRIER;
#endif

		/* Hardware fence is implicit on x86. */

	return result;
}

/*
doc:	<routine name="store_release" return_type="void" export="private">
doc:		<summary> Perform a release fence and write 'node' into memory pointed to by 'node_address'.
doc:			The fence instruction ensures that any read or write operation prior to the fence is not reordered with any write operation after the fence. </summary>
doc:		<param name="node_address" type="struct mc_node**"> The pointer-pointer that holds the address where 'node' should be stored. Must not be NULL. </param>
doc:		<param name="node_address" type="struct mc_node**"> The pointer to a node that should be stored at 'node_address'. Must not be NULL. </param>
doc:		<thread_safety> Safe </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:		<fixme> Currently this only works on x86, which has relatively strong ordering guarantees.
doc:			Furthermore, we currently use a very strong fence internally.
doc:			We may be able to tune performance a bit by just using a release fence. </fixme>
doc:	</routine>
*/
rt_private rt_inline void store_release (struct mc_node** node_address, struct mc_node* node)
{
		/* This is the correct position of the fence.
		* The fence nesures that all the values written into the mc_node
		* struct by this thread are visible by the other thread once it loads the pointer with load_consume. */
	
	struct mc_node* volatile* volatile_node_address;

#if defined EIF_HAS_MEMORY_BARRIER
		/* Compiler fence */
	EIF_MEMORY_BARRIER;
#endif

		/* Hardware fence is implicit on x86. */

		/* Read this as a "pointer to a volatile pointer to an mc_node" */
		/* RS: Is this to ensure that the memory lookup actually happens and isn't optimized away, i.e. to reduce latency? */
	volatile_node_address = (struct mc_node* volatile*) node_address;

		/* Perform the store operation. */
	*volatile_node_address = node;
}

/*
doc:	<routine name="allocate_node" return_type="struct mc_node*" export="private">
doc:		<summary> Allocate a new mc_node. First tries to reuse a node from the internal node cache, and if this fails, it allocates a new node via malloc(). </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The rt_message_channel struct. Must not be NULL. </param>
doc:		<return> A pointer to a fresh mc_node struct. </return>
doc:		<thread_safety> Must only be called by the sender thread. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_private rt_inline struct mc_node* allocate_node (struct rt_message_channel* self)
{
	struct mc_node* result = NULL;
	REQUIRE ("self_not_null", self);

		/* First move the tail copy if necessary. */
	if (self->first == self->tail_copy) {
			/* The load_consume operation ensures that we can see
			 * a consistent view if the consumer just moved the tail node.
			 * (which does not necessarily mean that we see the update already).
			 * This load_consume pairs with the store_release in dequeue(). */
		self->tail_copy = load_consume (&self->tail);
	}

	if (self->first != self->tail_copy) {
			/* We're lucky. There's an unused (i.e. already consumed) node at the beginning. */
		result = self->first;

			/* Update the first pointer. */
		self->first = self->first->next;

	} else {
			/* We need to allocate a new node on the heap. */
		 result = (struct mc_node*) malloc (sizeof (struct mc_node));
		 if (!result) {
				/* NOTE: A memory allocation failure here is a pretty fatal error,
				 * especially for UNLOCK, SHUTDOWN RESULT_READY and DIRTY messages.
				 * The reason is that the recipient may be blocked infinitely with
				 * no way to unblock it. Instead of letting this silent inconsistency
				 * sneak into our program we bail out and panic. */
				/* TODO: There might be a way to avoid a panic by making sure that
				 * nodes for the above messages are always pre-allocated. This makes
				 * the send operation unfailing, but clients would have to
				 * ensure that an "emergency" node is available prior to sending
				 * a critical message.*/
			eif_panic ("Could not allocate a message node in rt_message_channel_send.");
		 }
	}

		/* Do some basic initialization. */
	result->next = NULL;

	ENSURE ("not_null", result);
	ENSURE ("partially_initialized", !result->next);

	return result;
}


/*
doc:	<routine name="enqueue" return_type="void" export="private">
doc:		<summary> Enqueue a message in rt_message_channel 'self'. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The rt_message_channel struct. Must not be NULL. </param>
doc:		<param name="message_type" type="enum scoop_message_type"> The type of the message. </param>
doc:		<param name="sender" type="struct rt_processor*"> The sender processor. Must not be NULL for SCOOP_MESSAGE_EXECUTE and SCOOP_MESSAGE_CALLBACK. </param>
doc:		<param name="call" type="struct eif_scoop_call_data*"> Information about a call to be executed. Must not be NULL for SCOOP_MESSAGE_EXECUTE and SCOOP_MESSAGE_CALLBACK. </param>
doc:		<param name="queue" type="struct rt_private_queue*"> The queue to be executed by the receiver. Must not be NULL for ADD_QUEUE messages. </param>
doc:		<thread_safety> Safe for exactly one sender thread and one receiver thread. </thread_safety>
doc:		<synchronization> None required, but must not be called during garbage collection. </synchronization>
doc:	</routine>
 */
rt_private rt_inline void enqueue (struct rt_message_channel* self, enum scoop_message_type message_type, struct rt_processor* sender, struct eif_scoop_call_data* call, struct rt_private_queue* queue)
{
	struct mc_node* node = NULL;
	REQUIRE ("self_not_null", self);
	REQUIRE ("valid_message", rt_message_is_valid (message_type, sender, call, queue));

		/* Allocate a new node. */
	node = allocate_node (self);
	CHECK ("next_is_null", !node->next);

		/* Set up the rt_message value. */
	node->value.sender_processor = sender;
	node->value.call = call;
	node->value.queue = queue;
	node->value.message_type = message_type;

		/* Enqueue the message. The store_release guarantees that the receiver
		 * will see a consistent view of the node (i.e. with all fields initialized
		 * as in rt_message_init). This store_release pairs with the load_consume in dequeue().*/
	store_release ( &(self->head->next), node);

		/* Update the head pointer (note that this pointer is only accessed by the producer). */
	self->head = node;
}

/*
doc:	<routine name="dequeue" return_type="EIF_BOOLEAN" export="private">
doc:		<summary> Dequeue a message from rt_message_channel 'self'. This feature is non-blocking. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The rt_message_channel struct. Must not be NULL. </param>
doc:		<param name="message" type="struct rt_message*"> A pointer to a rt_message struct where the result shall be stored. May be NULL. </param>
doc:		<return> EIF_TRUE if the dequeue operation was successful. EIF_FALSE if no message is ready to be dequeued. </return>
doc:		<thread_safety> Safe for exactly one sender thread and one receiver thread. </thread_safety>
doc:		<synchronization> None required, but must not be called during garbage collection. </synchronization>
doc:	</routine>
*/
rt_private rt_inline EIF_BOOLEAN dequeue (struct rt_message_channel* self, struct rt_message* message)
{
	EIF_BOOLEAN result = EIF_FALSE;
	struct mc_node* item = NULL;

	REQUIRE ("self_not_null", self);

		/* Check if there's a message to be dequeued.
		 * The load_consume ensures that we get a consistent view
		 * if the producer just enqueued a new item.
		 * This load_consume pairs with the store_release in enqueue(). */
	item = load_consume ( &(self->tail->next));

	if (item) {
		result = EIF_TRUE;

			/* Copy the values of the received message. */
		if (message) {
			*message = item->value;
		}

			/* Update the tail pointer.
			 * This releases the current guard node into the cache of unused nodes,
			 * and makes 'node' the new guard node.
			 * The store_release ensures that the producer will see all our writes.
			 * This store_release pairs with the load_consume in allocate_node(). */
		store_release (&self->tail, self->tail->next);
	}

	return result;
}



/*
doc:	<routine name="rt_message_channel_send" return_type="void" export="shared">
doc:		<summary> Send the message 'message_type' over channel 'self'. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel on which to send the message. Must not be NULL. </param>
doc:		<param name="message_type" type="enum scoop_message_type"> The type of the message. </param>
doc:		<param name="sender_processor" type="struct rt_processor*"> The sender processor. Must not be NULL for SCOOP_MESSAGE_EXECUTE and SCOOP_MESSAGE_CALLBACK. </param>
doc:		<param name="call" type="struct eif_scoop_call_data*"> Information about a call to be executed. Must not be NULL for SCOOP_MESSAGE_EXECUTE and SCOOP_MESSAGE_CALLBACK. </param>
doc:		<param name="queue" type="struct rt_private_queue*"> The queue to be executed by the receiver. Must not be NULL for ADD_QUEUE messages. </param>
doc:		<thread_safety> Safe for exactly one sender thread and one receiver thread. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_shared void rt_message_channel_send (struct rt_message_channel* self, enum scoop_message_type message_type, struct rt_processor* sender_processor, struct eif_scoop_call_data* call, struct rt_private_queue* queue)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("valid_message", rt_message_is_valid (message_type, sender_processor, call, queue));

	/* TODO: Measure if there's any performance benefit at all by doing the enqueue operation outside the lock. */
#if defined EIF_HAS_MEMORY_BARRIER
		/* Perform the non-blocking enqueue operation. */
	enqueue (self, message_type, sender_processor, call, queue);

		/* Lock the condition variable mutex. */
	RT_TRACE (eif_pthread_mutex_lock (self->has_elements_condition_mutex));
#else
		/* Lock the condition variable mutex. */
	RT_TRACE (eif_pthread_mutex_lock (self->has_elements_condition_mutex));

			/* Perform the enqueue operation. */
	enqueue (self, message_type, sender_processor, call, queue);
#endif

		/* Wake up the receiver. */
	RT_TRACE (eif_pthread_cond_signal (self->has_elements_condition));

		/* Release the condition variable mutex. */
	RT_TRACE (eif_pthread_mutex_unlock (self->has_elements_condition_mutex));

}

/*
doc:	<routine name="rt_message_channel_receive_impl" return_type="void" export="private">
doc:		<summary> Implementation of rt_message_channel_receive and rt_message_channel_receive_with_gc.
doc:			Garbage collection runs can be triggered with the command line argument 'is_with_gc'. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel on which to receive the message. Must not be NULL. </param>
doc:		<param name="message" type="struct rt_message*"> A pointer to a rt_message struct where the result shall be stored. May be NULL. </param>
doc:		<param name="is_with_gc" type="EIF_BOOLEAN"> Whether the garbage collector shall be called periodically. </param>
doc:		<thread_safety> Safe for exactly one sender thread and one receiver thread. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_private rt_inline void rt_message_channel_receive_impl (struct rt_message_channel* self, struct rt_message* message, const EIF_BOOLEAN is_with_gc)
{
	EIF_BOOLEAN success = EIF_FALSE;
#ifdef EIF_HAS_MEMORY_BARRIER
	size_t i;
#endif
	int error = T_OK;

		/* Variables for the GC-specific receive. Note: Thanks to inlining most compilers will
		 *  optimize away the dead code paths and unused variables. */
	int gc_fingerprint = 0;
	rt_uint_ptr wait_timeout = RT_GC_TIMEOUT_START;

	REQUIRE ("self_not_null", self);

#ifdef EIF_HAS_MEMORY_BARRIER
		/* First try to dequeue in a non-blocking fashion. */
	for (i = 0; i < self->spin && !success; ++i) {
		success = dequeue (self, message);
	}
#endif

		/* If we didn't get an item so far, we wait on the condition variable. */
	if (!success) {

			/* The following code looks a bit strange and inefficient,
			 * but it is necessary to run correctly:
			 *
			 * We cannot call dequeue() at a point where the garbage collector
			 * may run, because we risk that we lose updates to moved references
			 * in the eif_scoop_call_data struct.
			 *
			 * Also, we cannot synchronize for garbage collection while holding
			 * the has_elements_condition_mutex, otherwise there might be a deadlock
			 * where a sender thread waits for the mutex, a GC thread waits for the
			 * sender, and this thread waits for GC to begin.
			 *
			 * And we have to hold the lock between a call to dequeue() and
			 * eif_pthread_cond_wait, because otherwise we risk losing a signal
			 * by the sender.
			 */

			/* Lock the condition variable mutex. */
		RT_TRACE (eif_pthread_mutex_lock (self->has_elements_condition_mutex));

			/* Try to receive a message. */
		while (!dequeue (self, message)) {

				/* We couldn't get a message. Inform the GC that we're blocked. */
			EIF_ENTER_C;

				/* Wait on the condition variable for a producer to signal availability of new messages. */
			if (is_with_gc) {
				error = eif_pthread_cond_wait_with_timeout (self->has_elements_condition, self->has_elements_condition_mutex, wait_timeout);
			} else {
				RT_TRACE (eif_pthread_cond_wait (self->has_elements_condition, self->has_elements_condition_mutex));
			}

				/* Now we need to synchronize for GC. Since the previous wait reacquired the lock,
				 * and we're not allowed to hold a lock during GC, we have to release it now. */
			RT_TRACE (eif_pthread_mutex_unlock (self->has_elements_condition_mutex));

				/* Inform the GC that we're no longer blocked, and synchronize for GC if it's currently running. */
			EIF_EXIT_C;
			RTGC;

#if defined EIF_HAS_MEMORY_BARRIER
				/* On systems with a memory barrier we can now do an early exit.
				 * That way we can avoid acquiring and releasing the mutex, since
				 * it isn't necessary for the dequeue operation. */
			if (dequeue (self, message)) {
				return;
			}
#endif

				/* If invoked with GC enabled, we have to request it here, before re-acquiring the lock. */
			if (is_with_gc && error == T_TIMEDOUT) {
				rt_uint_ptr new_timeout = RT_GC_TIMEOUT_STEP * wait_timeout;
				wait_timeout = (new_timeout > wait_timeout) ? new_timeout : wait_timeout; /* Overflow protection */
				rt_request_gc_cycle (&gc_fingerprint);
			}

				/* To perform the dequeue operation we should reacquire the lock. */
			RT_TRACE (eif_pthread_mutex_lock (self->has_elements_condition_mutex));
		}

			/* Finally, release the previously acquired lock. */
		RT_TRACE (eif_pthread_mutex_unlock (self->has_elements_condition_mutex));
	}
}

/*
doc:	<routine name="rt_message_channel_receive" return_type="void" export="shared">
doc:		<summary> Receive a message on channel 'self' and store the result in 'message'. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel on which to receive the message. Must not be NULL. </param>
doc:		<param name="message" type="struct rt_message*"> A pointer to a rt_message struct where the result shall be stored. May be NULL. </param>
doc:		<thread_safety> Safe for exactly one sender thread and one receiver thread. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_shared void rt_message_channel_receive (struct rt_message_channel* self, struct rt_message* message)
{
	rt_message_channel_receive_impl (self, message, 0);
}

/*
doc:	<routine name="rt_message_channel_receive" return_type="void" export="shared">
doc:		<summary> Receive a message on channel 'self' and store the result in 'message'.
doc:			If no message is available, trigger the garbage collector in regular intervals in between. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel on which to receive the message. Must not be NULL. </param>
doc:		<param name="message" type="struct rt_message*"> A pointer to a rt_message struct where the result shall be stored. May be NULL. </param>
doc:		<thread_safety> Safe for exactly one sender thread and one receiver thread. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_shared void rt_message_channel_receive_with_gc (struct rt_message_channel* self, struct rt_message* message)
{
	rt_message_channel_receive_impl (self, message, 1);
}


/*
doc:	<routine name="rt_message_channel_is_empty" return_type="EIF_BOOLEAN" export="shared">
doc:		<summary> Check if the message channel is empty, i.e. if there are no messages to be received. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The rt_message_channel struct. Must not be NULL. </param>
doc:		<return> EIF_TRUE when the channel is empty. EIF_FALSE if there's a message to be received. </return>
doc:		<thread_safety> Safe on the receiver thread. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_shared EIF_BOOLEAN rt_message_channel_is_empty (struct rt_message_channel* self)
{
	struct mc_node* item = NULL;
	REQUIRE ("self_not_null", self);

		/* Check if there's a message to be dequeued.
		 * The load_consume ensures that we get a consistent view
		 * if the producer just enqueued a new item. */
	item = load_consume ( &(self->tail->next));
	return !item;
}



/*
doc:	<routine name="rt_message_channel_mark" return_type="void" export="shared">
doc:		<summary> Mark all call_data structs during garbage collection in message channel 'self'. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The rt_message_channel struct. Must not be NULL. </param>
doc:		<param name="marking" type="MARKER"> The marker function. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during GC phase. </synchronization>
doc:	</routine>
*/
rt_shared void rt_message_channel_mark (struct rt_message_channel* self, MARKER marking)
{
	struct mc_node* node = NULL;
	struct eif_scoop_call_data* call = NULL;

	REQUIRE ("self_not_null", self);
	REQUIRE ("marking_not_null", marking);

	for (node = self->tail->next; node != NULL; node = node->next) {

		call = node->value.call;
		if (call) {
			rt_mark_call_data (marking, call);
		}
	}
}

/*
doc:	<routine name="rt_message_channel_init" return_type="int" export="shared">
doc:		<summary> Initialize the rt_message_channel struct 'self' and allocate some initial memory. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel to be initialized. Must not be NULL. </param>
doc:		<param name="default_spin" type="size_t"> The number of times a thread should spin on receive before waiting on a condition variable. </param>
doc:		<return> T_OK on success. T_NO_MORE_MEMORY or a mutex creation error code when a resource could not be allocated. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared int rt_message_channel_init (struct rt_message_channel* self, size_t default_spin)
{
	int error = T_OK;
	struct mc_node* l_node = NULL;

	REQUIRE ("self_not_null", self);

		/* Ensure that the struct is in a consistent state
		 * to call rt_message_channel_deinit() if some allocation fails. */
	self->first = NULL;
	self->has_elements_condition = NULL;
	self->has_elements_condition_mutex = NULL;
	self->spin = default_spin;

		/* Allocate the guard node. */
	l_node = (struct mc_node*) malloc (sizeof (struct mc_node));

	if (!l_node) {
			/* Set the correct error code if malloc failed to allocate memory. */
		error = T_NO_MORE_MEMORY;
	} else {

			/* Initialize the node to a consistent state. */
		l_node->next = NULL;
		rt_message_init (&l_node->value);

			/* In the beginning, all pointers point to the guard node. */
		self->head = l_node;
		self->tail = l_node;
		self->first = l_node;
		self->tail_copy = l_node;

			/* Create the mutex for blocking wait. */
		error = eif_pthread_mutex_create (&self->has_elements_condition_mutex);

			/* Create the condition variable for blocking wait. */
		if (T_OK == error) {
			error = eif_pthread_cond_create (&self->has_elements_condition);
		}
	}

		/* Free any allocataed resources in case of an error. */
	if (error != T_OK) {
		rt_message_channel_deinit (self);
	}
	return error;
}

/*
doc:	<routine name="rt_message_channel_deinit" return_type="void" export="shared">
doc:		<summary> Deconstruct 'self' and free all internal memory. This feature can be called multiple times. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel to be destroyed. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_message_channel_deinit (struct rt_message_channel* self)
{
	struct mc_node* item = NULL;
	struct mc_node* next = NULL;

	REQUIRE ("self_not_null", self);

	item = self->first;
	self->first = NULL;

		/* Free all nodes in the internal linked list. */
		/* NOTE: If we're ever going to have more than just pointers in an
		 * rt_message struct, we may need to free some more stuff here. */
	while (item) {
		next = item->next;
		free (item);
		item = next;
	}

		/* Free the mutex and condition variables. */
	if (self->has_elements_condition) {
		RT_TRACE (eif_pthread_cond_destroy (self->has_elements_condition));
		self->has_elements_condition = NULL;
	}

	if (self->has_elements_condition_mutex) {
		RT_TRACE (eif_pthread_mutex_destroy (self->has_elements_condition_mutex));
		self->has_elements_condition_mutex = NULL;
	}
}

/*
doc:</file>
*/
