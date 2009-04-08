note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_HTTP_CONN_SERVER

inherit
	THREAD
	XU_DEBUG_OUTPUTTER

create make

feature -- Initialization

	make  (a_webapp_handler: XS_WEBAPP_HANDLER)
			-- Initializes current
		do
			webapp_handler := a_webapp_handler
            create socket.make_server_by_port (default_http_server_port)
            create thread_pool.make (max_thread_number, agent request_handler_spawner)
            stop := False
		ensure
			webapp_handler_set: a_webapp_handler = webapp_handler
       	end

feature -- Inherited Features

	execute
			-- <Precursor>
		do
        	from
                socket.listen (max_tcp_clients.as_integer_32)
            until
            	stop
            loop
                socket.accept
                dprint ("Connection to http accepted",1)
	            if attached {NETWORK_STREAM_SOCKET} socket.accepted as thread_http_socket then
	            	thread_pool.add_work (agent {XS_REQUEST_HANDLER}.do_execute (thread_http_socket, webapp_handler))
				end
            end
            socket.cleanup
        	check
        		socket.is_closed
        	end
		end

feature -- Access

	thread_pool: DATA_THREAD_POOL [XS_REQUEST_HANDLER]

	socket: NETWORK_STREAM_SOCKET
			-- The socket

	webapp_handler: XS_WEBAPP_HANDLER
			-- Stores registered Webapps and is able to send/receive request and responses

	stop: BOOLEAN
			-- Set true to stop accept loop

feature -- Constants

	default_http_server_port: INTEGER = 55000
			-- Port for communication between http server and xebra server

	max_tcp_clients: NATURAL = 100
			-- Maximal number of clients which can simultanuously connect

	max_thread_number: NATURAL = 10
			-- Maximal number of simultaneous threads

	message_upper_bound: NATURAL = 65536
			-- Upper bound for a message fragment

	message_default_bound: NATURAL = 32768
			-- Default bound for a message fragment

feature -- Status setting

	shutdown
			-- Stops the thread
		do
			stop := True
			socket.cleanup
			check
        		socket.is_closed
        	end
		end



feature {POOLED_THREAD} -- Implementation

	request_handler_spawner: XS_REQUEST_HANDLER
			-- Instantiates a new {XS_REQUEST_HANDLER}.
			-- Used for the thread_manager.
		do
			create Result.make (message_default_bound, message_upper_bound)
		end
end
