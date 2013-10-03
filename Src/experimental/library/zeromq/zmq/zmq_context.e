note
	description: "[
		An ØMQ Context where ØMQ sockets live within.

		Each ØMQ socket lives within a specific context. Creating and
		destroying context is a counterpart of library
		initialisation/deinitialisation as used elsewhere. Ability to create
		multiple contexts saves the day when an application happens to
		link (indirectly and involuntarily) with several instances of ØMQ.

		Implementation notes: the fact that ØMQ can work in a threaded
		enviroment is currently hidden by this Liberty wrappers

		TODO: add support for pollability (ZMQ_POLL)
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	EIS: "name=Sockets", "src=http://api.zeromq.org/3-3:zmq-socket", "protocol=uri"
	date: "$Date$"
	revision: "$Revision$"

class
	ZMQ_CONTEXT

inherit
	WRAPPER_BASE
		rename
			make as make_base
		end

create
	make

feature {NONE} -- Creation

	make
			-- Context creation for non in-process communication.
		do
			is_configurable := True
			make_base ({ZMQ}.ctx_new)
		ensure
			is_configurable: is_configurable
		end

feature -- Status report

	exists: BOOLEAN
			-- Is current properly initialized?
		do
			Result := item /= default_pointer
		end

	is_configurable: BOOLEAN
			-- Is current configurable?

feature -- Access

	number_of_io_threads: INTEGER
			-- Number of I/O threads in the ZMQ thread pool.
		require
			exists: exists
		do
			Result := {ZMQ}.ctx_get (item, {ZMQ_CONSTANTS}.io_threads)
			check always_success: Result /= -1 end
		ensure
			number_of_io_threads_non_negative: Result >= 0
		end

	maximum_number_of_sockets: INTEGER
			-- Maximum number of sockets allowed in current context.
		require
			exists: exists
		do
			Result := {ZMQ}.ctx_get (item, {ZMQ_CONSTANTS}.max_sockets)
			check always_success: Result /= -1 end
		ensure
			maximum_number_of_sockets_positive: Result > 0
		end

feature -- Element change

	set_number_of_io_threads (v: INTEGER)
			-- Set `number_of_io_threads' with `v'.
		require
			exists: exists
			v_non_negative: v >= 0
			is_configurable: is_configurable
		local
			res: INTEGER
		do
			res := {ZMQ}.ctx_set (item, {ZMQ_CONSTANTS}.io_threads, v)
			check always_success: res /= -1 end
		ensure
			number_of_io_threads_set: number_of_io_threads = v
		end

	set_maximum_number_of_sockets (v: INTEGER)
			-- Set `maximum_number_of_sockets' with `v'.
		require
			exists: exists
			v_positive: v > 0
			is_configurable: is_configurable
		local
			res: INTEGER
		do
			res := {ZMQ}.ctx_set (item, {ZMQ_CONSTANTS}.max_sockets, v)
			check always_success: res /= -1 end
		ensure
			maximum_number_of_sockets_set: maximum_number_of_sockets = v
		end

feature -- Socket: Request-Replay Pattern

	new_req_socket: ZMQ_SOCKET
			-- A socket of type ZMQ_REQ is used by a client to send requests to and receive
			-- replies from a service. This socket type allows only an alternating sequence
			-- of zmq_send(request) and subsequent zmq_recv(reply) calls. Each request sent
			-- is round-robined among all services, and each reply received is matched with
			-- the last issued request.

			-- When a ZMQ_REQ socket enters the mute state due to having reached the high
			-- water mark for all services, or if there are no services at all, then any
			-- zmq_send(3) operations on the socket shall block until the mute state ends
			-- or at least one service becomes available for sending; messages are not discarded.

			-- Summary of ZMQ_REQ characteristics
			-- Compatible peer sockets:    ZMQ_REP, ZMQ_ROUTER
			-- Direction:                  Bidirectional
			-- Send/receive pattern:       Send, Receive, Send, Receive, .
			-- Outgoing routing strategy:  Round-robin
			-- Incoming routing strategy:  Last peer
			-- Action in mute state:       Block
		require
			exists: exists
		do
			create Result.make ({ZMQ}.socket (item, {ZMQ_CONSTANTS}.req), {ZMQ_CONSTANTS}.req)
			disable_configurable
		end

	new_rep_socket: ZMQ_SOCKET
			-- A socket of type ZMQ_REP is used by a service to receive requests from and send
			-- replies to a client. This socket type allows only an alternating sequence of
			-- zmq_recv(request) and subsequent zmq_send(reply) calls. Each request received
			-- is fair-queued from among all clients, and each reply sent is routed to the
			-- client that issued the last request. If the original requester doesn't exist
			-- any more the reply is silently discarded.

			-- When a ZMQ_REP socket enters the mute state due to having reached the high water
			-- mark for a client, then any replies sent to the client in question shall be
			-- dropped until the mute state ends.

			-- Summary of ZMQ_REP characteristics
			-- Compatible peer sockets:    ZMQ_REQ, ZMQ_DEALER
			-- Direction:                  Bidirectional
			-- Send/receive pattern:       Receive, Send, Receive, Send, .
			-- Incoming routing strategy:  Fair-queued
			-- Outgoing routing strategy:  Last peer
			-- Action in mute state:       Drop
		require
			exists: exists
		do
			create Result.make ({ZMQ}.socket (item, {ZMQ_CONSTANTS}.rep), {ZMQ_CONSTANTS}.rep)
			disable_configurable
		end

	new_dealer_socket: ZMQ_SOCKET
			-- A socket of type ZMQ_DEALER is an advanced pattern used for extending request/reply
			-- sockets. Each message sent is round-robined among all connected peers, and each
			-- message received is fair-queued from all connected peers.

			-- When a ZMQ_DEALER socket enters the mute state due to having reached the high water
			-- mark for all peers, or if there are no peers at all, then any zmq_send(3) operations
			-- on the socket shall block until the mute state ends or at least one peer becomes
			-- available for sending; messages are not discarded.

			-- When a ZMQ_DEALER socket is connected to a ZMQ_REP socket each message sent must
			-- consist of an empty message part, the delimiter, followed by one or more body parts.

			-- Summary of ZMQ_DEALER characteristics
			-- Compatible peer sockets:    ZMQ_ROUTER, ZMQ_REP, ZMQ_DEALER
			-- Direction:                  Bidirectional
			-- Send/receive pattern:       Unrestricted
			-- Outgoing routing strategy:  Round-robin
			-- Incoming routing strategy:  Fair-queued
			-- Action in mute state:       Block
		require
			exists: exists
		do
			create Result.make ({ZMQ}.socket (item, {ZMQ_CONSTANTS}.dealer), {ZMQ_CONSTANTS}.dealer)
			disable_configurable
		end

	new_router_socket: ZMQ_SOCKET
			-- A socket of type ZMQ_ROUTER is an advanced socket type used for extending
			-- request/reply sockets. When receiving messages a ZMQ_ROUTER socket shall
			-- prepend a message part containing the identity of the originating peer
			-- to the message before passing it to the application. Messages received
			-- are fair-queued from among all connected peers. When sending messages a
			-- ZMQ_ROUTER socket shall remove the first part of the message and use it
			-- to determine the identity of the peer the message shall be routed to. If
			-- the peer does not exist anymore the message shall be silently discarded
			-- by default, unless ZMQ_ROUTER_BEHAVIOR socket option is set to 1.

			-- When a ZMQ_ROUTER socket enters the mute state due to having reached the
			-- high water mark for all peers, then any messages sent to the socket shall
			-- be dropped until the mute state ends. Likewise, any messages routed to a
			-- peer for which the individual high water mark has been reached shall also
			-- be dropped.

			-- When a ZMQ_REQ socket is connected to a ZMQ_ROUTER socket, in addition to
			-- the identity of the originating peer each message received shall contain an
			-- empty delimiter message part. Hence, the entire structure of each received
			-- message as seen by the application becomes: one or more identity parts,
			-- delimiter part, one or more body parts. When sending replies to a ZMQ_REQ
			-- socket the application must include the delimiter part.

			-- Summary of ZMQ_ROUTER characteristics
			-- Compatible peer sockets:    ZMQ_DEALER, ZMQ_REQ, ZMQ_ROUTER
			-- Direction:                  Bidirectional
			-- Send/receive pattern:       Unrestricted
			-- Outgoing routing strategy:  See text
			-- Incoming routing strategy:  Fair-queued
			-- Action in mute state:       Drop
		require
			exists: exists
		do
			create Result.make ({ZMQ}.socket (item, {ZMQ_CONSTANTS}.router), {ZMQ_CONSTANTS}.router)
			disable_configurable
		end

feature -- Socket: Publish-subscribe pattern

	new_pub_socket: ZMQ_SOCKET
			-- A socket of type ZMQ_PUB is used by a publisher to distribute data.
			-- Messages sent are distributed in a fan out fashion to all connected
			-- peers. The zmq_recv(3) function is not implemented for this socket type.

			-- When a ZMQ_PUB socket enters the mute state due to having reached the
			-- high water mark for a subscriber, then any messages that would be sent
			-- to the subscriber in question shall instead be dropped until the mute
			-- state ends. The zmq_send() function shall never block for this socket type.

			-- Summary of ZMQ_PUB characteristics
			-- Compatible peer sockets:    ZMQ_SUB, ZMQ_XSUB
			-- Direction:                  Unidirectional
			-- Send/receive pattern:       Send only
			-- Incoming routing strategy:  N/A
			-- Outgoing routing strategy:  Fan out
			-- Action in mute state:       Drop
		require
			exists: exists
		do
			create Result.make ({ZMQ}.socket (item, {ZMQ_CONSTANTS}.pub), {ZMQ_CONSTANTS}.pub)
			disable_configurable
		end

	new_sub_socket (a_filter: detachable STRING): ZMQ_SOCKET
			-- A socket of type ZMQ_SUB is used by a subscriber to subscribe to data
			-- distributed by a publisher. Initially a ZMQ_SUB socket is not subscribed
			-- to any messages, use the ZMQ_SUBSCRIBE option of zmq_setsockopt(3) to
			-- specify which messages to subscribe to. The zmq_send() function is not
			-- implemented for this socket type.

			-- Summary of ZMQ_SUB characteristics
			-- Compatible peer sockets:    ZMQ_PUB, ZMQ_XPUB
			-- Direction:                  Unidirectional
			-- Send/receive pattern:       Receive only
			-- Incoming routing strategy:  Fair-queued
			-- Outgoing routing strategy:  N/A
			-- Action in mute state:       Drop
		require
			exists: exists
			valid_filter: attached a_filter implies a_filter.is_valid_as_string_8
		local
			l_c_filter: C_STRING
			l_err: INTEGER
		do
			create Result.make ({ZMQ}.socket (item, {ZMQ_CONSTANTS}.sub), {ZMQ_CONSTANTS}.sub)
			disable_configurable
			if a_filter /= Void then
				create l_c_filter.make (a_filter)
			else
				create l_c_filter.make ("")
			end
			l_err := {ZMQ}.setsockopt (Result.item, {ZMQ_CONSTANTS}.subscribe, l_c_filter.item, l_c_filter.bytes_count.as_natural_32)
			check
				no_error: l_err = 0
			end
		end

	new_xpub_socket: ZMQ_SOCKET
			-- Same as new_pub_socket except that you can receive subscriptions from
			-- the peers in form of incoming messages. Subscription message is a
			-- byte 1 (for subscriptions) or byte 0 (for unsubscriptions)
			-- followed by the subscription body. Messages without a sub/unsub
			-- prefix are also received, but have no effect on subscription status.

			-- Summary of ZMQ_XPUB characteristics
			-- Compatible peer sockets:    ZMQ_SUB, ZMQ_XSUB
			-- Direction:                  Unidirectional
			-- Send/receive pattern:       Send messages, receive subscriptions
			-- Incoming routing strategy:  N/A
			-- Outgoing routing strategy:  Fan out
			-- Action in mute state:       Drop
		require
			exists: exists
		do
			create Result.make ({ZMQ}.socket (item, {ZMQ_CONSTANTS}.xpub), {ZMQ_CONSTANTS}.xpub)
			disable_configurable
		end

	new_xsub_socket: ZMQ_SOCKET
			-- Same as new_pub_socket except that you subscribe by sending subscription
			-- messages to the socket. Subscription message is a byte 1 (for subscriptions)
			-- or byte 0 (for unsubscriptions) followed by the subscription body. Messages
			-- without a sub/unsub prefix may also be sent, but have no effect on subscription status.

			-- Summary of ZMQ_XSUB characteristics
			-- Compatible peer sockets:    ZMQ_PUB, ZMQ_XPUB
			-- Direction:                  Unidirectional
			-- Send/receive pattern:       Receive messages, send subscriptions
			-- Incoming routing strategy:  Fair-queued
			-- Outgoing routing strategy:  N/A
			-- Action in mute state:       Drop
		require
			exists: exists
		do
			create Result.make ({ZMQ}.socket (item, {ZMQ_CONSTANTS}.xsub), {ZMQ_CONSTANTS}.xsub)
			disable_configurable
		end

feature -- Sockets: Pipeline pattern

	new_push_socket: ZMQ_SOCKET
			-- A socket of type ZMQ_PUSH is used by a pipeline node to send messages
			-- to downstream pipeline nodes. Messages are round-robined to all connected
			-- downstream nodes. The zmq_recv() function is not implemented for this
			-- socket type.

			-- When a ZMQ_PUSH socket enters the mute state due to having reached the
			-- high water mark for all downstream nodes, or if there are no downstream
			-- nodes at all, then any zmq_send(3) operations on the socket shall block
			-- until the mute state ends or at least one downstream node becomes
			-- available for sending; messages are not discarded.

			-- Summary of ZMQ_PUSH characteristics
			-- Compatible peer sockets:    ZMQ_PULL
			-- Direction:                  Unidirectional
			-- Send/receive pattern:       Send only
			-- Incoming routing strategy:  N/A
			-- Outgoing routing strategy:  Round-robin
			-- Action in mute state:       Block
		require
			exists: exists
		do
			create Result.make ({ZMQ}.socket (item, {ZMQ_CONSTANTS}.push), {ZMQ_CONSTANTS}.push)
			disable_configurable
		end

	new_pull_socket: ZMQ_SOCKET
			-- A socket of type ZMQ_PULL is used by a pipeline node to receive messages
			-- from upstream pipeline nodes. Messages are fair-queued from among all
			-- connected upstream nodes. The zmq_send() function is not implemented for this socket type.

			-- Summary of ZMQ_PULL characteristics
			-- Compatible peer sockets:    ZMQ_PUSH
			-- Direction:                  Unidirectional
			-- Send/receive pattern:       Receive only
			-- Incoming routing strategy:  Fair-queued
			-- Outgoing routing strategy:  N/A
			-- Action in mute state:       Block
		require
			exists: exists
		do
			create Result.make ({ZMQ}.socket (item, {ZMQ_CONSTANTS}.pull),{ZMQ_CONSTANTS}.pull)
			disable_configurable
		end

feature -- Sockets: Exclusive pair pattern

	new_pair_socket: ZMQ_SOCKET
			-- A socket of type ZMQ_PAIR can only be connected to a single peer at any one time.
			-- No message routing or filtering is performed on messages sent over a ZMQ_PAIR socket.

			-- When a ZMQ_PAIR socket enters the mute state due to having reached the high
			-- water mark for the connected peer, or if no peer is connected, then any zmq_send(3)
			-- operations on the socket shall block until the peer becomes available for sending;
			-- messages are not discarded.

			-- ZMQ_PAIR sockets are designed for inter-thread communication across the zmq_inproc(7)
			-- transport and do not implement functionality such as auto-reconnection. ZMQ_PAIR
			-- sockets are considered experimental and may have other missing or broken aspects.

			-- Summary of ZMQ_PAIR characteristics
			-- Compatible peer sockets:    ZMQ_PAIR
			-- Direction:                  Bidirectional
			-- Send/receive pattern:       Unrestricted
			-- Incoming routing strategy:  N/A
			-- Outgoing routing strategy:  N/A
			-- Action in mute state:       Block
		require
			exists: exists
		do
			create Result.make ({ZMQ}.socket (item, {ZMQ_CONSTANTS}.pair), {ZMQ_CONSTANTS}.pair)
			disable_configurable
		end

feature {NONE} -- Implementation

	dispose
			-- <Precursor>
		local
			l_done: BOOLEAN
		do
			from
				l_done := item = default_pointer
			until
				l_done
			loop
				l_done := {ZMQ}.ctx_destroy (item) = 0
				if not l_done then
						 -- Only retry if we were interrupted.
					l_done := {ZMQ}.errno /= {ZMQ_ERROR_CODES}.eintr
				end
			end
			item := default_pointer
		end

	disable_configurable
			-- Disable configurability of context once sockets are created.
		do
			is_configurable := False
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
