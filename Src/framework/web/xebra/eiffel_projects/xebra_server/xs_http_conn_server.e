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
	XS_SHARED_SERVER_OUTPUTTER

create make

feature -- Initialization

	make
			-- Initializes current
		do

            create http_socket.make_server_by_port (default_http_server_port)
         --	create thread_pool.make (max_thread_number, agent request_handler_spawner)
	       	http_socket.set_accept_timeout (500)
            stop := False
            launched := False
		ensure
			http_socket_attached: http_socket /= Void
		end

feature -- Inherited Features

	execute
			-- <Precursor>
		local
			l_r_handler: XS_REQUEST_HANDLER
		do
			launched := True
			create l_r_handler.make
			from
                http_socket.listen (max_tcp_clients.as_integer_32)
            until
            	stop
            loop
--            	o.dprint ("Waiting for request from http server...", 3)
                http_socket.accept
                if not stop then
--                	o.dprint ("%N__________________________________%N",3)
--	                o.dprint ("Connection to http server accepted",1)
		            if attached {NETWORK_STREAM_SOCKET} http_socket.accepted as thread_http_socket then
						--multithread
						--thread_pool.add_work (agent l_r_handler.receive_message (thread_http_socket, server_config))
		            	--singleusermode
		            	l_r_handler.receive_message (thread_http_socket)
					end
				end
            end
         --   thread_pool.terminate
            http_socket.cleanup
        	check
        		http_socket.is_closed
        	end
		end

feature -- Access

--	thread_pool: DATA_THREAD_POOL [XS_REQUEST_HANDLER]

	http_socket: NETWORK_STREAM_SOCKET
			-- The socket

	stop: BOOLEAN
			-- Set true to stop accept loop

	launched: BOOLEAN

feature -- Status

	is_bound: BOOLEAN
			-- Checks if the socket could be bound
		do
			Result := http_socket.is_bound
		end


feature -- Constants

	default_http_server_port: INTEGER = 55000
			-- Port for communication between http server and xebra server

	max_tcp_clients: NATURAL = 100
			-- Maximal number of clients which can simultanuously connect

	max_thread_number: NATURAL = 10
			-- Maximal number of simultaneous threads



feature -- Status setting

	shutdown
			-- Stops the thread
		do
			stop := True
		end

feature {POOLED_THREAD} -- Implementation

	request_handler_spawner: XS_REQUEST_HANDLER
			-- Instantiates a new {XS_REQUEST_HANDLER}.
			-- Used for the thread_manager.
		do
			create Result.make
		ensure
			Result_attached: Result /= Void
		end

invariant
	http_socket_attached: http_socket /= Void
end
