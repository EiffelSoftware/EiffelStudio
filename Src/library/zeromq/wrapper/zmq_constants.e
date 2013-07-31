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
			-- A socket type to send requests and receive replies.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_REQ"
		end

	zmq_rep: INTEGER_32
			-- A socket type to receive requests and send replies.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_REP"
		end

	zmq_router: INTEGER_32
			-- A socket of type ZMQ_ROUTER is an advanced socket type used for extending request/reply sockets.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_ROUTER"
		end

	zmq_dealer: INTEGER_32
			-- A socket of type ZMQ_DEALER is an advanced pattern used for extending request/reply sockets.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_DEALER"
		end

feature -- Socket types: Publish-subscribe pattern

	zmq_pub: INTEGER_32
			-- A socket type to distribute data.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_PUB"
		end

	zmq_sub: INTEGER_32
			-- A socket type to subscribe for data.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_SUB"
		end

	zmq_xpub: INTEGER_32
			-- A socket type to distribute data.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_XPUB"
		end

	zmq_xsub: INTEGER_32
			-- A socket type to subscribe for data.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_XSUB"
		end

feature -- Socket types: Pipeline

	zmq_push: INTEGER_32
			-- A socket of type ZMQ_PUSH is used by a pipeline node to send messages to downstream pipeline nodes.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_PUSH"
		end

	zmq_pull: INTEGER_32
			-- A socket of type ZMQ_PULL is used by a pipeline node to receive messages from upstream pipeline nodes.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_PULL"
		end

feature -- Socket Types: Exclusive pair pattern

	zmq_pair: INTEGER_32
			-- A socket of type ZMQ_PAIR can only be connected to a single peer at any one time.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_PAIR"
		end

feature -- Poll constants

	zmq_pollin: INTEGER_32
			-- For ØMQ sockets, at least one message may be received from the socket without
			-- blocking. For standard sockets this is equivalent to the POLLIN flag of
			-- the poll() system call and generally means that at least one byte of
			-- data may be read from fd without blocking.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_POLLIN"
		end

	zmq_pollout: INTEGER_32
			-- For ØMQ sockets, at least one message may be sent to the socket without
			-- blocking. For standard sockets this is equivalent to the POLLOUT flag of
			-- the poll() system call and generally means that at least one byte of
			-- data may be written to fd without blocking.
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_POLLOUT"
		end

	zmq_pollerr: INTEGER_32
			-- For standard sockets, this flag is passed through zmq_poll() to the
			-- underlying poll() system call and generally means that some sort of
			-- error condition is present on the socket specified by fd. For ØMQ sockets
			-- this flag has no effect if set in events, and shall never be returned
			-- in revents by zmq_poll().
		external
			"C inline use <zmq.h>"
		alias
			"ZMQ_POLLERR"
		end

feature -- Socket options

	zmq_noblock: INTEGER_32
		external
			"C inline use <zmq.h>"
		alias
			"return ZMQ_NOBLOCK;"
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class ZMQ_SOCKET_TYPES
