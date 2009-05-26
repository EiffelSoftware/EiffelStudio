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
	XU_SHARED_OUTPUTTER

create make

feature -- Initialization

	make  (a_server_config: XS_CONFIG)
			-- Initializes current
		do
			server_config := a_server_config
            create http_socket.make_server_by_port (default_http_server_port)
--          create thread_pool.make (max_thread_number, agent request_handler_spawner)
	       	http_socket.set_accept_timeout (500)
            stop := False
		ensure
			http_socket_attached: http_socket /= Void
			server_config_set: server_config = a_server_config
		end

feature -- Inherited Features

	execute
			-- <Precursor>
		local
			l_r_handler: XS_REQUEST_HANDLER
		do
			create l_r_handler.make
			o.set_name ({XS_MAIN_SERVER}.Name)
			o.set_debug_level (server_config.arg_config.debug_level)
			from
                http_socket.listen (max_tcp_clients.as_integer_32)
            until
            	stop
            loop
            	o.dprint ("Waiting for request from http server...", 3)
                http_socket.accept
                if not stop then
                	o.dprint ("%N__________________________________%N",3)
	                o.dprint ("Connection to http server accepted",1)
		            if attached {NETWORK_STREAM_SOCKET} http_socket.accepted as thread_http_socket then
	--					thread_pool.add_work (agent {XS_REQUEST_HANDLER}.do_execute (thread_http_socket, webapp_handler))
		            		--singleusermode
		            	l_r_handler.receive_message (thread_http_socket, server_config)
					end
				end
            end
            http_socket.cleanup
        	check
        		http_socket.is_closed
        	end
		end

feature -- Access

--	thread_pool: DATA_THREAD_POOL [XS_REQUEST_HANDLER]

	http_socket: NETWORK_STREAM_SOCKET
			-- The socket

	server_config: XS_CONFIG

	stop: BOOLEAN
			-- Set true to stop accept loop

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
	server_config_attached: server_config /= Void
end
