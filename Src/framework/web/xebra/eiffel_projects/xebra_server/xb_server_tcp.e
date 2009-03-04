class
    XB_SERVER_TCP

create
    make_with_port

feature -- Initialization

	thread_pool: DATA_THREAD_POOL_MANAGER [XB_MOD_HANDLER]

	make_with_port (port: NATURAL)
			-- Creates a server on the specified `port' which listens to a http server mod (xebra)
		require
			not_well_known_port: port >= 1024 --should we allow registered ports?
		local
			http_server_main_socket: detachable NETWORK_STREAM_SOCKET
		do
			create thread_pool.make_with_managed_target (max_thread_number, agent data_spawner)
            create http_server_main_socket.make_server_by_port (port.as_integer_32)

            from
                http_server_main_socket.listen (max_tcp_clients.as_integer_32)
            until
            	False
            loop
                http_server_main_socket.accept
	            if attached {NETWORK_STREAM_SOCKET} http_server_main_socket.accepted as thread_socket then
	            	thread_pool.add_work (agent {XB_MOD_HANDLER}.do_execute (thread_socket))
				end
            end
            http_server_main_socket.cleanup
        	check
        		http_server_main_socket.is_closed
        	end
        rescue
        	if http_server_main_socket /= Void then
	            http_server_main_socket.cleanup
        	end
		end

feature -- Access

	message_upper_bound: NATURAL = 65536
			-- Upper bound for a message fragment

	message_default_bound: NATURAL = 32768
			-- Default bound for a message fragment

	default_http_server_port: NATURAL = 3490
			-- Port for communication between http-server and `Current'

	max_tcp_clients: NATURAL = 100
			-- Maximal number of clients which can simultanuously connect

	max_thread_number: NATURAL = 10
			-- Maximal number of simultaneous threads

feature {POOLED_THREAD} -- Implementation

	data_spawner: XB_MOD_HANDLER
			-- Instantiates a new {XB_MOD_HANDLER}.
			-- Used for the thread_manager.
		do
			create Result.make (message_default_bound, message_upper_bound)
		end

end
