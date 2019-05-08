note
	description: "Various constants used for ZMQ."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Socket Types", "src=http://api.zeromq.org/3-3:zmq-socket", "protocol=uri"

class
	ZMQ_CONSTANTS

feature -- Context constants

	io_threads: INTEGER
			-- The ZMQ_IO_THREADS argument specifies the size of the ØMQ thread pool to
			-- handle I/O operations. If your application is using only the inproc transport
			-- for messaging you may set this to zero, otherwise set it to at least one.
			-- This option only applies before creating any sockets on the context.
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_IO_THREADS;"
		ensure
			is_class: class
		end

	max_sockets: INTEGER
			-- The ZMQ_MAX_SOCKETS argument sets the maximum number of sockets allowed on the context.
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_MAX_SOCKETS;"
		ensure
			is_class: class
		end

feature -- Socket types : Request-Replay Pattern

	req: INTEGER_32
			-- A socket type to send requests and receive replies.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_REQ"
		ensure
			is_class: class
		end

	rep: INTEGER_32
			-- A socket type to receive requests and send replies.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_REP"
		ensure
			is_class: class
		end

	router: INTEGER_32
			-- A socket of type ZMQ_ROUTER is an advanced socket type used for extending request/reply sockets.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_ROUTER"
		ensure
			is_class: class
		end

	dealer: INTEGER_32
			-- A socket of type ZMQ_DEALER is an advanced pattern used for extending request/reply sockets.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_DEALER"
		ensure
			is_class: class
		end

feature -- Socket types: Publish-subscribe pattern

	pub: INTEGER_32
			-- A socket type to distribute data.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_PUB"
		ensure
			is_class: class
		end

	sub: INTEGER_32
			-- A socket type to subscribe for data.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_SUB"
		ensure
			is_class: class
		end

	xpub: INTEGER_32
			-- A socket type to distribute data.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_XPUB"
		ensure
			is_class: class
		end

	xsub: INTEGER_32
			-- A socket type to subscribe for data.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_XSUB"
		ensure
			is_class: class
		end

feature -- Socket types: Pipeline

	push: INTEGER_32
			-- A socket of type ZMQ_PUSH is used by a pipeline node to send messages to downstream pipeline nodes.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_PUSH"
		ensure
			is_class: class
		end

	pull: INTEGER_32
			-- A socket of type ZMQ_PULL is used by a pipeline node to receive messages from upstream pipeline nodes.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_PULL"
		ensure
			is_class: class
		end

feature -- Socket Types: Exclusive pair pattern

	pair: INTEGER_32
			-- A socket of type ZMQ_PAIR can only be connected to a single peer at any one time.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_PAIR"
		ensure
			is_class: class
		end

feature -- Poll constants

	pollin: INTEGER_32
			-- For ØMQ sockets, at least one message may be received from the socket without
			-- blocking. For standard sockets this is equivalent to the POLLIN flag of
			-- the poll() system call and generally means that at least one byte of
			-- data may be read from fd without blocking.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_POLLIN"
		ensure
			is_class: class
		end

	pollout: INTEGER_32
			-- For ØMQ sockets, at least one message may be sent to the socket without
			-- blocking. For standard sockets this is equivalent to the POLLOUT flag of
			-- the poll() system call and generally means that at least one byte of
			-- data may be written to fd without blocking.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_POLLOUT"
		ensure
			is_class: class
		end

	pollerr: INTEGER_32
			-- For standard sockets, this flag is passed through zmq_poll() to the
			-- underlying poll() system call and generally means that some sort of
			-- error condition is present on the socket specified by fd. For ØMQ sockets
			-- this flag has no effect if set in events, and shall never be returned
			-- in revents by zmq_poll().
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_POLLERR"
		ensure
			is_class: class
		end

feature -- Socket options

	noblock: INTEGER_32
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_NOBLOCK;"
		ensure
			is_class: class
		end

	sndhwm: INTEGER_32
			-- Set high water mark for outbound messages
			-- The ZMQ_SNDHWM option shall set the high water mark for outbound messages on the specified
			-- socket. The high water mark is a hard limit on the maximum number of outstanding messages ØMQ
			-- shall queue in memory for any single peer that the specified socket is communicating with.
			-- A value of zero means no limit.
			--
			-- If this limit has been reached the socket shall enter an exceptional state and depending on the
			-- socket type, ØMQ shall take appropriate action such as blocking or dropping sent messages.
			-- Refer to the individual socket descriptions in zmq_socket(3) for details on the exact action
			-- taken for each socket type.
			--
			-- ØMQ does not guarantee that the socket will accept as many as ZMQ_SNDHWM messages, and the
			-- actual limit may be as much as 60-70% lower depending on the flow of messages on the socket.
			--
			-- Option value type	int
			-- Option value unit	messages
			-- Default value	1000
			-- Applicable socket types	all
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_SNDHWM;"
		ensure
			is_class: class
		end

	rcvhwm: INTEGER_32
			-- Set high water mark for inbound messages
			-- The ZMQ_RCVHWM option shall set the high water mark for inbound messages on the specified
			-- socket. The high water mark is a hard limit on the maximum number of outstanding messages ØMQ
			-- shall queue in memory for any single peer that the specified socket is communicating with. A
			-- value of zero means no limit.
			--
			-- If this limit has been reached the socket shall enter an exceptional state and depending on
			-- the socket type, ØMQ shall take appropriate action such as blocking or dropping sent messages.
			-- Refer to the individual socket descriptions in zmq_socket(3) for details on the exact action
			-- taken for each socket type.
			--
			-- Option value type	int
			-- Option value unit	messages
			-- Default value	1000
			-- Applicable socket types	all
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_RCVHWM;"
		ensure
			is_class: class
		end

	affinity: INTEGER_32
			-- Set I/O thread affinity
			-- The ZMQ_AFFINITY option shall set the I/O thread affinity for newly created connections on the
			-- specified socket.
			--
			-- Affinity determines which threads from the ØMQ I/O thread pool associated with the socket's
			-- context shall handle newly created connections. A value of zero specifies no affinity, meaning
			-- that work shall be distributed fairly among all ØMQ I/O threads in the thread pool. For
			-- non-zero values, the lowest bit corresponds to thread 1, second lowest bit to thread 2 and so
			-- on. For example, a value of 3 specifies that subsequent connections on socket shall be handled
			-- exclusively by I/O threads 1 and 2.
			--
			-- See also zmq_init for details on allocating the number of I/O threads for a specific context.
			--
			-- Option value type	uint64_t
			-- Option value unit	N/A (bitmap)
			-- Default value	0
			-- Applicable socket types	N/A
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_AFFINITY;"
		ensure
			is_class: class
		end

	subscribe: INTEGER_32
			-- Establish message filter
			-- The ZMQ_SUBSCRIBE option shall establish a new message filter on a ZMQ_SUB socket. Newly
			-- created ZMQ_SUB sockets shall filter out all incoming messages, therefore you should call this
			-- option to establish an initial message filter.
			--
			-- An empty option_value of length zero shall subscribe to all incoming messages. A non-empty
			-- option_value shall subscribe to all messages beginning with the specified prefix.
			-- Multiple filters may be attached to a single ZMQ_SUB socket, in which case a message shall be
			-- accepted if it matches at least one filter.
			--
			-- Option value type	binary data
			-- Option value unit	N/A
			-- Default value	N/A
			-- Applicable socket types	ZMQ_SUB
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_SUBSCRIBE;"
		ensure
			is_class: class
		end

	unsubscribe: INTEGER_32
			-- Remove message filter
			-- The ZMQ_UNSUBSCRIBE option shall remove an existing message filter on a ZMQ_SUB socket.
			-- The filter specified must match an existing filter previously established with the
			-- ZMQ_SUBSCRIBE option. If the socket has several instances of the same filter attached the
			-- ZMQ_UNSUBSCRIBE option shall remove only one instance, leaving the rest in place and
			-- functional.
			--
			-- Option value type	binary data
			-- Option value unit	N/A
			-- Default value	N/A
			-- Applicable socket types	ZMQ_SUB
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_UNSUBSCRIBE;"
		ensure
			is_class: class
		end

	identity: INTEGER_32
			-- Set socket identity
			-- The ZMQ_IDENTITY option shall set the identity of the specified socket. Socket identity is
			-- used only by request/reply pattern. Namely, it can be used in tandem with ROUTER socket to
			-- route messages to the peer with specific identity.
			--
			-- Identity should be at least one byte and at most 255 bytes long. Identities starting with
			-- binary zero are reserved for use by ØMQ infrastructure.
			--
			-- If two peers use the same identity when connecting to a third peer, the results shall be
			-- undefined.
			--
			-- Option value type	binary data
			-- Option value unit	N/A
			-- Default value	NULL
			-- Applicable socket types	all
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_IDENTITY;"
		ensure
			is_class: class
		end

	rate: INTEGER_32
			-- Set multicast data rate
			-- The ZMQ_RATE option shall set the maximum send or receive data rate for multicast transports
			-- such as zmq_pgm(7) using the specified socket.
			--
			-- Option value type	int
			-- Option value unit	kilobits per second
			-- Default value	100
			-- Applicable socket types	all, when using multicast transports
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_RATE;"
		ensure
			is_class: class
		end

	recovery_ivl: INTEGER_32
			-- Set multicast recovery interval
			-- The ZMQ_RECOVERY_IVL option shall set the recovery interval for multicast transports using the
			-- specified socket. The recovery interval determines the maximum time in milliseconds that a
			-- receiver can be absent from a multicast group before unrecoverable data loss will occur.
			--
			-- Exercise care when setting large recovery intervals as the data needed for recovery will be
			-- held in memory. For example, a 1 minute recovery interval at a data rate of 1Gbps requires a
			-- 7GB in-memory buffer.
			--
			-- Option value type	int
			-- Option value unit	milliseconds
			-- Default value	10000
			-- Applicable socket types	all, when using multicast transports
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_RECOVERY_IVL;"
		ensure
			is_class: class
		end

	sndbuf: INTEGER_32
			-- Set kernel transmit buffer size
			-- The ZMQ_SNDBUF option shall set the underlying kernel transmit buffer size for the socket to
			-- the specified size in bytes. A value of zero means leave the OS default unchanged. For details
			-- please refer to your operating system documentation for the SO_SNDBUF socket option.
			--
			-- Option value type	int
			-- Option value unit	bytes
			-- Default value	0
			-- Applicable socket types	all
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_SNDBUF;"
		ensure
			is_class: class
		end

	rcvbuf: INTEGER_32
			-- Set kernel receive buffer size
			-- The ZMQ_RCVBUF option shall set the underlying kernel receive buffer size for the socket to the
			-- specified size in bytes. A value of zero means leave the OS default unchanged. For details
			-- refer to your operating system documentation for the SO_RCVBUF socket option.
			--
			-- Option value type	int
			-- Option value unit	bytes
			-- Default value	0
			-- Applicable socket types	all
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_RCVBUF;"
		ensure
			is_class: class
		end

	linger: INTEGER_32
			-- Set linger period for socket shutdown
			-- The ZMQ_LINGER option shall set the linger period for the specified socket. The linger period
			-- determines how long pending messages which have yet to be sent to a peer shall linger in memory
			-- after a socket is closed with zmq_close(3), and further affects the termination of the
			-- socket's context with zmq_term(3). The following outlines the different behaviours:
			--
			-- The default value of -1 specifies an infinite linger period. Pending messages shall not be
			-- discarded after a call to zmq_close(); attempting to terminate the socket's context with
			-- zmq_term() shall block until all pending messages have been sent to a peer.
			-- The value of 0 specifies no linger period. Pending messages shall be discarded immediately
			-- when the socket is closed with zmq_close().
			-- Positive values specify an upper bound for the linger period in milliseconds. Pending messages
			-- shall not be discarded after a call to zmq_close(); attempting to terminate the socket's
			-- context with zmq_term() shall block until either all pending messages have been sent to a
			-- peer, or the linger period expires, after which any pending messages shall be discarded.
			--
			-- Option value type	int
			-- Option value unit	milliseconds
			-- Default value	-1 (infinite)
			-- Applicable socket types	all

		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_LINGER;"
		ensure
			is_class: class
		end

	reconnect_ivl: INTEGER_32
			-- Set reconnection interval
			-- The ZMQ_RECONNECT_IVL option shall set the initial reconnection interval for the specified
			-- socket. The reconnection interval is the period ØMQ shall wait between attempts to reconnect
			-- disconnected peers when using connection-oriented transports. The value -1 means no
			-- reconnection.
			--
			-- The reconnection interval may be randomized by ØMQ to prevent reconnection storms in
			-- topologies with a large number of peers per socket.
			--
			--
			-- Option value type	int
			-- Option value unit	milliseconds
			-- Default value	100
			-- Applicable socket types	all, only for connection-oriented transports
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_RECONNECT_IVL;"
		ensure
			is_class: class
		end

	reconnect_ivl_max: INTEGER_32
			-- Set maximum reconnection interval
			-- The ZMQ_RECONNECT_IVL_MAX option shall set the maximum reconnection interval for the specified
			-- socket. This is the maximum period ØMQ shall wait between attempts to reconnect. On each
			-- reconnect attempt, the previous interval shall be doubled untill ZMQ_RECONNECT_IVL_MAX is
			-- reached. This allows for exponential backoff strategy. Default value means no exponential
			-- backoff is performed and reconnect interval calculations are only based on ZMQ_RECONNECT_IVL.
			--
			-- Values less than ZMQ_RECONNECT_IVL will be ignored.
			--
			-- Option value type	int
			-- Option value unit	milliseconds
			-- Default value	0 (only use ZMQ_RECONNECT_IVL)
			-- Applicable socket types	all, only for connection-oriented transports
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_RECONNECT_IVL_MAX;"
		ensure
			is_class: class
		end

	backlog: INTEGER_32
			-- Set maximum length of the queue of outstanding connections
			-- The ZMQ_BACKLOG option shall set the maximum length of the queue of outstanding peer
			-- connections for the specified socket; this only applies to connection-oriented transports.
			-- For details refer to your operating system documentation for the listen function.
			--
			-- Option value type	int
			-- Option value unit	connections
			-- Default value	100
			-- Applicable socket types	all, only for connection-oriented transports.
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_BACKLOG;"
		ensure
			is_class: class
		end

	maxmsgsize: INTEGER_32
			-- Maximum acceptable inbound message size
			-- Limits the size of the inbound message. If a peer sends a message larger than ZMQ_MAXMSGSIZE
			-- it is disconnected. Value of -1 means no limit.
			--
			-- Option value type	int64_t
			-- Option value unit	bytes
			-- Default value	-1
			-- Applicable socket types	all
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_MAXMSGSIZE;"
		ensure
			is_class: class
		end

	multicast_hops: INTEGER_32
			-- Maximum network hops for multicast packets
			-- Sets the time-to-live field in every multicast packet sent from this socket. The default is
			-- 1 which means that the multicast packets don't leave the local network.
			--
			-- Option value type	int
			-- Option value unit	network hops
			-- Default value	1
			-- Applicable socket types	all, when using multicast transports
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_MULTICAST_HOPS;"
		ensure
			is_class: class
		end

	rcvtimeo: INTEGER_32
			-- Maximum time before a recv operation returns with EAGAIN
			-- Sets the timeout for receive operation on the socket. If the value is 0, zmq_recv(3) will
			-- return immediately, with a EAGAIN error if there is no message to receive. If the value is -1,
			-- it will block until a message is available. For all other values, it will wait for a message
			-- for that amount of time before returning with an EAGAIN error.
			--
			-- Option value type	int
			-- Option value unit	milliseconds
			-- Default value	-1 (infinite)
			-- Applicable socket types	all
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_RCVTIMEO;"
		ensure
			is_class: class
		end

	sndtimeo: INTEGER_32
			-- Maximum time before a send operation returns with EAGAIN
			-- Sets the timeout for send operation on the socket. If the value is 0, zmq_send(3) will return
			-- immediately, with a EAGAIN error if the message cannot be sent. If the value is -1, it will
			-- block until the message is sent. For all other values, it will try to send the message for
			-- that amount of time before returning with an EAGAIN error.
			--
			-- Option value type	int
			-- Option value unit	milliseconds
			-- Default value	-1 (infinite)
			-- Applicable socket types	all
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_SNDTIMEO;"
		ensure
			is_class: class
		end

--	ipv6: INTEGER_32
--			-- Enable IPv6 on socket
--			-- Set the IPv6 option for the socket. A value of 1 means IPv6 is enabled on the socket, while 0
--			-- means the socket will use only IPv4. When IPv6 is enabled the socket will connect to, or accept
--			-- connections from, both IPv4 and IPv6 hosts.
--			--
--			-- Option value type	int
--			-- Option value unit	boolean
--			-- Default value	0 (false)
--			-- Applicable socket types	all, when using TCP transports.
--		external
--			"C inline use <zmq.h>"
--		alias
--			"return ZMQ_IPV6;"
--		end

	ipv4only: INTEGER_32
			-- Use IPv4-only on socket
			-- Set the IPv4-only option for the socket. This option is deprecated. Please use the ZMQ_IPV6
			-- option.
			--
			-- Option value type	int
			-- Option value unit	boolean
			-- Default value	1 (true)
			-- Applicable socket types	all, when using TCP transports.
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_IPV4ONLY;"
		ensure
			is_class: class
		end

--	immediate: INTEGER_32
--			-- Queue messages only to completed connections
--			-- By default queues will fill on outgoing connections even if the connection has not completed.
--			-- This can lead to "lost" messages on sockets with round-robin routing (REQ, PUSH, DEALER). If
--			-- this option is set to 1, messages shall be queued only to completed connections. This will
--			-- cause the socket to block if there are no other connections, but will prevent queues from
--			-- filling on pipes awaiting connection.
--			--
--			-- Option value type	int
--			-- Option value unit	boolean
--			-- Default value	0 (false)
--			-- Applicable socket types	all, only for connection-oriented transports.
--		external
--			"C inline use <zmq.h>"
--		alias
--			"return ZMQ_IMMEDIATE;"
--		end

	router_mandatory: INTEGER_32
			-- Accept only routable messages on ROUTER sockets
			-- Sets the ROUTER socket behavior when an unroutable message is encountered. A value of 0 is the default and discards the message silently when it cannot be routed. A value of 1 returns an EHOSTUNREACH error code if the message cannot be routed.
			--
			-- Option value type	int
			-- Option value unit	0, 1
			-- Default value	0
			-- Applicable socket types	ZMQ_ROUTER
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_ROUTER_MANDATORY;"
		ensure
			is_class: class
		end

--	router_raw: INTEGER_32
--			-- Switch ROUTER socket to raw mode
--			-- Sets the raw mode on the ROUTER, when set to 1. When the ROUTER socket is in raw mode, and
--			-- when using the tcp:// transport, it will read and write TCP data without ØMQ framing. This
--			-- lets ØMQ applications talk to non-ØMQ applications. When using raw mode, you cannot set
--			-- explicit identities, and the ZMQ_MSGMORE flag is ignored when sending data messages.
--			-- In raw mode you can close a specific connection by sending it a zero-length message
--			-- (following the identity frame).
--			--
--			-- Option value type	int
--			-- Option value unit	0, 1
--			-- Default value	0
--			-- Applicable socket types	ZMQ_ROUTER
--		external
--			"C inline use <zmq.h>"
--		alias
--			"return ZMQ_ROUTER_RAW;"
--		end

	xpub_verbose: INTEGER_32
			-- Provide all subscription messages on XPUB sockets
			-- Sets the XPUB socket behavior on new subscriptions and unsubscriptions. A value of 0 is the
			-- default and passes only new subscription messages to upstream. A value of 1 passes all
			-- subscription messages upstream.
			--
			-- Option value type	int
			-- Option value unit	0, 1
			-- Default value	0
			-- Applicable socket types	ZMQ_XPUB
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_XPUB_VERBOSE;"
		ensure
			is_class: class
		end

	tcp_keepalive: INTEGER_32
			-- Override SO_KEEPALIVE socket option
			-- Override SO_KEEPALIVE socket option(where supported by OS). The default value of -1 means to
			-- skip any overrides and leave it to OS default.
			--
			-- Option value type	int
			-- Option value unit	-1,0,1
			-- Default value	-1 (leave to OS default)
			-- Applicable socket types	all, when using TCP transports.
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_TCP_KEEPALIVE;"
		ensure
			is_class: class
		end

	tcp_keepalive_idle: INTEGER_32
			-- Override TCP_KEEPCNT(or TCP_KEEPALIVE on some OS)
			-- Override TCP_KEEPCNT(or TCP_KEEPALIVE on some OS) socket option(where supported by OS). The
			-- default value of -1 means to skip any overrides and leave it to OS default.
			--
			-- Option value type	int
			-- Option value unit	-1,>0
			-- Default value	-1 (leave to OS default)
			-- Applicable socket types	all, when using TCP transports.
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_TCP_KEEPALIVE_IDLE;"
		ensure
			is_class: class
		end

	tcp_keepalive_cnt: INTEGER_32
			-- Override TCP_KEEPCNT socket option
			-- Override TCP_KEEPCNT socket option(where supported by OS). The default value of -1 means
			-- to skip any overrides and leave it to OS default.
			--
			-- Option value type	int
			-- Option value unit	-1,>0
			-- Default value	-1 (leave to OS default)
			-- Applicable socket types	all, when using TCP transports.
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_TCP_KEEPALIVE_CNT;"
		ensure
			is_class: class
		end

	tcp_keepalive_intvl: INTEGER_32
			-- Override TCP_KEEPINTVL socket option
			-- Override TCP_KEEPINTVL socket option(where supported by OS). The default value of -1 means to
			-- skip any overrides and leave it to OS default.
			--
			-- Option value type	int
			-- Option value unit	-1,>0
			-- Default value	-1 (leave to OS default)
			-- Applicable socket types	all, when using TCP transports.
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_TCP_KEEPALIVE_INTVL;"
		ensure
			is_class: class
		end

	tcp_accept_filter: INTEGER_32
			-- Assign filters to allow new TCP connections
			-- Assign arbitrary number of filters that will be applied for each new TCP transport connection
			-- on a listening socket. If no filters applied, then TCP transport allows connections from any
			-- ip. If at least one filter is applied then new connection source ip should be matched. To
			-- clear all filters call zmq_setsockopt(socket, ZMQ_TCP_ACCEPT_FILTER, NULL, 0). Filter is a
			-- null-terminated string with ipv6 or ipv4 CIDR.
			--
			-- Option value type	binary data
			-- Option value unit	N/A
			-- Default value	no filters (allow from all)
			-- Applicable socket types	all listening sockets, when using TCP transports.
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_TCP_ACCEPT_FILTER;"
		ensure
			is_class: class
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class ZMQ_SOCKET_TYPES
