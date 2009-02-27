class
    XB_SERVER_TCP
inherit

    SOCKET_RESOURCES

    STORABLE

create
    make_with_port

feature --Constants

	message_upper_bound: NATURAL = 65536
	message_default_bound: NATURAL = 32768
	default_http_server_port: NATURAL = 3490

	max_tcp_clients: NATURAL = 100
	max_thread_number: NATURAL = 10


feature -- Initialization
	thread_pool: DATA_THREAD_POOL_MANAGER [XB_MOD_HANDLER]

	make_with_port (port: NATURAL)
			-- creates a server on the specified `port' which listens to a http server mod (xebra)
		require
			not_well_known_port: port >= 1024 --should we allow registered ports?
		local
			http_server_main_socket: ?NETWORK_STREAM_SOCKET
		do
			create thread_pool.make_with_managed_target (max_thread_number, agent data_spawner)
            create http_server_main_socket.make_server_by_port (port.as_integer_32)

            from
                http_server_main_socket.listen (max_tcp_clients.as_integer_32)
            until
            	False
            loop
                http_server_main_socket.accept
	            if {thread_socket: NETWORK_STREAM_SOCKET} http_server_main_socket.accepted then
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

feature -- Agents
	data_spawner: XB_MOD_HANDLER
			-- instantiates a new {XB_MOD_HANDLER}
			-- used for the thread_manager
		do
			create Result.make (message_default_bound, message_upper_bound)
		end

end
