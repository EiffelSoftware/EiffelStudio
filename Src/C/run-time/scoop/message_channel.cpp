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
doc:<file name="message_channel.cpp" header="rt_message_channel.hpp" version="$Id$" summary="A channel for rt_message structs between processors.">
*/

#include "rt_message_channel.hpp"
#include "spsc.hpp"
#include "rt_message.h"

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
rt_private rt_inline struct mc_node* load_consume (struct mc_node** const node_address)
{

		/* Note: We use volatile on the pointer, not the item pointed to. */
		/* RS: Is this to ensure that the memory lookup actually happens and isn't optimized away, i.e. to reduce latency? */
	struct mc_node** const volatile volatile_node_address = (struct mc_node** const volatile) node_address;
	struct mc_node* result = *volatile_node_address;

		/* This is the correct position of the fence.
		 * The fence nesures that all the values written into the mc_node
		 * struct by another thread are now visible by this thread. */

		/* Compiler fence */
	EIF_MEMORY_BARRIER;

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
rt_private rt_inline void store_release (struct mc_node** const node_address, struct mc_node* node)
{
		/* This is the correct position of the fence.
		* The fence nesures that all the values written into the mc_node
		* struct by this thread are visible by the other thread once it loads the pointer with load_consume. */

		/* Compiler fence */
	EIF_MEMORY_BARRIER;

		/* Hardware fence is implicit on x86. */

		/* Note: We use volatile on the pointer, not the item pointed to. */
		/* RS: Is this to ensure that the memory lookup actually happens and isn't optimized away, i.e. to reduce latency? */
	struct mc_node** const volatile volatile_node_address = (struct mc_node** const volatile) node_address;

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
		self->first = result->next;

	} else {
			/* We need to allocate a new node on the heap. */
		 result = (struct mc_node*) malloc (sizeof (struct mc_node));
		 if (!result) {
				/* Report allocation failure. */
			enomem();
		 }
	}

		/* Do some basic initialization. */
	result -> next = NULL;

	ENSURE ("not_null", result);
	ENSURE ("partially_initialized", !result->next);

	return result;
}


/*
doc:	<routine name="enqueue" return_type="void" export="private">
doc:		<summary> Enqueue a message in rt_message_channel 'self'. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The rt_message_channel struct. Must not be NULL. </param>
doc:		<param name="message_type" type="enum scoop_message_type"> The type of the message. </param>
doc:		<param name="sender" type="struct processor*"> The sender processor. Must not be NULL for SCOOP_MESSAGE_EXECUTE and SCOOP_MESSAGE_CALLBACK. </param>
doc:		<param name="call" type="struct call_data*"> Information about a call to be executed. Must not be NULL for SCOOP_MESSAGE_EXECUTE and SCOOP_MESSAGE_CALLBACK. </param>
doc:		<thread_safety> Safe for exactly one sender thread and one receiver thread. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
 */
rt_private rt_inline void enqueue (struct rt_message_channel* self, enum scoop_message_type message_type, processor* sender, struct call_data* call)
{
	struct mc_node* node = NULL;
	REQUIRE ("self_not_null", self);

		/* Allocate a new node. */
	node = allocate_node (self);
	CHECK ("next_is_null", !node->next);

		/* Set up the rt_message value. */
	rt_message_init (&node->value, message_type, sender, call);

		/* Enqueue the message. The store_release guarantees that the receiver
		 * will see a consistent view of the node (i.e. with all fields initialized
		 * as in rt_message_init). This store_release pairs with the load_consume in enqueue().*/
	store_release ( &(self->head->next), node);

		/* Update the head pointer (note that this pointer is only accessed by the producer). */
	self -> head = node;
}

/*
doc:	<routine name="dequeue" return_type="EIF_BOOLEAN" export="private">
doc:		<summary> Dequeue a message from rt_message_channel 'self'. This feature is non-blocking. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The rt_message_channel struct. Must not be NULL. </param>
doc:		<param name="message" type="struct rt_message*"> A pointer to a rt_message struct where the result shall be stored. May be NULL. </param>
doc:		<return> EIF_TRUE if the dequeue operation was successful. EIF_FALSE if no message is ready to be dequeued. </return>
doc:		<thread_safety> Safe for exactly one sender thread and one receiver thread. </thread_safety>
doc:		<synchronization> None required. </synchronization>
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
		 * This load_consume pairs with the store_release in dequeue(). */
	item = load_consume ( &(self->tail->next));

	if (item) {
		result = EIF_TRUE;

			/* Copy the values of the received message. */
		if (message) {
			*message = item->value;
		}

			/* Update the tail pointer.
			 * This releases the node into the cache of unused nodes.
			 * The store_release ensures that the producer will see all our writes.
			 * This store_release pairs with the load_consume in allocate_node(). */
		store_release (&self->tail, item->next);
	}

	return result;
}



/*
doc:	<routine name="rt_message_channel_send" return_type="void" export="shared">
doc:		<summary> Send the message 'message_type' over channel 'self'. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel on which to send the message. Must not be NULL. </param>
doc:		<param name="message_type" type="enum scoop_message_type"> The type of the message. </param>
doc:		<param name="sender" type="struct processor*"> The sender processor. Must not be NULL for SCOOP_MESSAGE_EXECUTE and SCOOP_MESSAGE_CALLBACK. </param>
doc:		<param name="call" type="struct call_data*"> Information about a call to be executed. Must not be NULL for SCOOP_MESSAGE_EXECUTE and SCOOP_MESSAGE_CALLBACK. </param>
doc:		<thread_safety> Safe for exactly one sender thread and one receiver thread. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_shared void rt_message_channel_send (struct rt_message_channel* self, enum scoop_message_type message_type, processor* sender, struct call_data* call)
{
	struct rt_message message;

	REQUIRE ("self_not_null", self);
	REQUIRE ("sender_not_null", sender || (message_type != SCOOP_MESSAGE_EXECUTE && message_type != SCOOP_MESSAGE_CALLBACK));
	REQUIRE ("call_not_null", call || (message_type != SCOOP_MESSAGE_EXECUTE && message_type != SCOOP_MESSAGE_CALLBACK));

	rt_message_init (&message, message_type, sender, call);

		/* Perform the non-blocking enqueue operation. */
	self -> impl.q.enqueue (message);

		/* Lock the condition variable mutex. */
	eif_pthread_mutex_lock (self->has_elements_condition_mutex);

		/* Wake up the receiver. */
	eif_pthread_cond_signal (self->has_elements_condition);

		/* Release the condition variable mutex. */
	eif_pthread_mutex_unlock (self->has_elements_condition_mutex);

}

/*
doc:	<routine name="rt_message_channel_receive" return_type="void" export="shared">
doc:		<summary> Receive a message on channel 'self' and store the result in 'message'. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel on which to receive the message. Must not be NULL. </param>
doc:		<param name="message" type="struct rt_message*"> A pointer to a rt_message struct where the result shall be stored. Must not be NULL. </param>
doc:		<thread_safety> Safe for exactly one sender thread and one receiver thread. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_shared void rt_message_channel_receive (struct rt_message_channel* self, struct rt_message* message)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("message_not_null", message);

		/* TODO: In theory we could allow 'message' to be NULL.
		 * There's one use case in processor_registry that is not interested in the result. */

		/* First try to dequeue in a non-blocking fashion. */
	for (size_t i=0; i < self->spin; ++i) {
		if (self->impl.q.dequeue (*message)) {
			return; /* TODO: Use a boolean. */
		}
	}

		/* If we didn't get an item so far, we wait on the condition variable. */

		/* Inform the GC that we're blocked. */
	EIF_ENTER_C;

		/* Lock the condition variable mutex. */
	eif_pthread_mutex_lock (self->has_elements_condition_mutex);

		/* Try to receive a message. */
	while (!self->impl.q.dequeue (*message)) {
			/* Wait on the condition variable for a producer to signal availability of new messages. */
		eif_pthread_cond_wait (self->has_elements_condition, self->has_elements_condition_mutex);
	}

		/* Release the condition variable mutex. */
	eif_pthread_mutex_unlock (self->has_elements_condition_mutex);

		/* Inform the GC that we're no longer blocked. */
	EIF_EXIT_C;
	RTGC;
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
	REQUIRE ("self_not_null", self);
	REQUIRE ("marking_not_null", marking);
	self->impl.mark (marking);
}

/*
doc:	<routine name="rt_message_channel_init" return_type="void" export="shared">
doc:		<summary> Initialize the rt_message_channel struct 'self' and allocate some initial memory. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel to be initialized. Must not be NULL. </param>
doc:		<param name="default_spin" type="size_t"> The number of times a thread should spin on receive before waiting on a condition variable. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_message_channel_init (struct rt_message_channel* self, size_t default_spin)
{
	int error = T_OK;
	struct mc_node* l_node = NULL;

	REQUIRE ("self_not_null", self);

		/* Ensure that the struct is in a consistent state
		 * for de-initialization if some allocation fails. */
	self->first = NULL;
	self->has_elements_condition = NULL;
	self->has_elements_condition_mutex = NULL;
	self->spin = default_spin;

		/* Allocate the first tail node (a guard node with no valid value). */
	l_node = (struct mc_node*) malloc (sizeof (struct mc_node));
	if (!l_node) {
			/* Report allocation failure. */
		enomem();
	}

		/* TODO: Initialize the rt_message within to some default state ?*/
	l_node->next = NULL;


		/* In the beginning, all pointers point to the guard node. */
	self->head = l_node;
	self->tail = l_node;
	self->first = l_node;
	self->tail_copy = l_node;

		/* Create the mutex for blocking wait. */
	error = eif_pthread_mutex_create (&self->has_elements_condition_mutex);
	if (error != T_OK) {
			/* Free resources and report failure. */
		rt_message_channel_deinit (self);
		esys();
	}

		/* Create the condition variable for blocking wait. */
	error = eif_pthread_cond_create (&self->has_elements_condition);
	if (error != T_OK) {
			/* Free resources and report failure. */
		rt_message_channel_deinit (self);
		esys ();
	}
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
	self -> first = NULL;

		/* Free all nodes in the internal linked list. */
		/* NOTE: If we're ever having more than just pointers in an
		 * rt_message struct, we may need to free some more stuff here. */
	while (item) {
		next = item -> next;
		free (item);
		item = next;
	}

		/* Free the mutex and condition variables. */
	if (self -> has_elements_condition) {
		eif_pthread_cond_destroy (self->has_elements_condition);
		self->has_elements_condition = NULL;
	}

	if (self -> has_elements_condition_mutex) {
		eif_pthread_mutex_destroy (self->has_elements_condition_mutex);
		self->has_elements_condition_mutex = NULL;
	}
}

/*
doc:</file>
*/
