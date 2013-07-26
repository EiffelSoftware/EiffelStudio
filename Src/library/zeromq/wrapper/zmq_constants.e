note
	description: "Various constants used for ZMQ."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Socket Types", "src=http://api.zeromq.org/3-3:zmq-socket", "protocol=uri"

class
	ZMQ_CONSTANTS

feature -- Context constants

	zmq_io_threads: INTEGER
			-- The ZMQ_IO_THREADS argument specifies the size of the ØMQ thread pool to
			-- handle I/O operations. If your application is using only the inproc transport
			-- for messaging you may set this to zero, otherwise set it to at least one.
			-- This option only applies before creating any sockets on the context.
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_IO_THREADS;"
		end

	zmq_max_sockets: INTEGER
			-- The ZMQ_MAX_SOCKETS argument sets the maximum number of sockets allowed on the context.
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_MAX_SOCKETS;"
		end

feature -- Socket types : Request-Replay Pattern

	zmq_req: INTEGER_32
			-- A socket type to send requests and  receive  replies.  Requests
			-- are load-balanced  among  all  the peers. This socket type allows
			-- only an alternated sequence of send's and recv's.

			-- Compatible peer sockets: ZMQ_REP, ZMQ_XREP.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_REQ"
		end

	zmq_rep: INTEGER_32
			-- A socket type to receive requests and send replies. This socket
			-- type allows only an alternated sequence of recv's and send's.
			-- Each send is routed to the peer  that  issued  the  last
			-- received request.

			-- Compatible peer sockets: ZMQ_REQ, ZMQ_XREQ.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_REP"
		end

	zmq_router: INTEGER_32
			-- A socket of type ZMQ_ROUTER is an advanced socket type used for extending request/reply sockets.
			-- When receiving messages a ZMQ_ROUTER socket shall prepend a message part containing the identity of
			-- the originating peer to the message before passing it to the application.
			-- Messages received are fair-queued from among all connected peers.
			-- When sending messages a ZMQ_ROUTER socket shall remove the first part of the message and use
			-- it to determine the identity of the peer the message shall be routed to.
			-- If the peer does not exist anymore the message shall be silently discarded by default,
			-- unless ZMQ_ROUTER_BEHAVIOR socket option is set to 1.

			-- Deprecated alias: ZMQ_XREP.
			-- Compatible peer sockets 	ZMQ_DEALER, ZMQ_REQ, ZMQ_ROUTER.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_ROUTER"
		end

	zmq_dealer: INTEGER_32
			-- A socket of type ZMQ_DEALER is an advanced pattern used for extending request/reply sockets.
			-- Each message sent is round-robined among all connected peers, and each message received is fair-queued from all connected peers.

			-- Deprecated alias: ZMQ_XREQ.
			-- Compatible peer sockets 	ZMQ_ROUTER, ZMQ_REP, ZMQ_DEALER
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_DEALER"
		end

feature -- Socket Types: Exclusive pair pattern

	zmq_pair: INTEGER_32
			--
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_PAIR"
		end

feature -- Socket types: Publish-subscribe pattern

	zmq_pub: INTEGER_32
			-- A socket type to  distribute  data. Recv fuction is not
			-- implemented for this socket type.  Messages  are  distributed  in
			-- fanout fashion to all the peers.

			-- Compatible peer sockets: ZMQ_SUB.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_PUB"
		end

	zmq_sub: INTEGER_32
			-- A socket type to  subscribe  for  data. Send function is not
			-- implemented for this socket type. Initially, socket is
			-- subscribed for  no  messages.  Use ZMQ_SUBSCRIBE option to
			-- specify which messages to subscribe for.

			-- Compatible peer sockets: ZMQ_PUB.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_SUB"
		end

end -- class ZMQ_SOCKET_TYPES
