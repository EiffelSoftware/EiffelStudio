note
	description: "[
			Implementation of HTTPD_CONNECTION_HANDLER_I for concurrency mode: Thread
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTPD_CONNECTION_HANDLER

inherit
	HTTPD_CONNECTION_HANDLER_I
		redefine
			initialize
		end

create
	make

feature {NONE} -- Initialization

	initialize
		local
			n: INTEGER
		do
			n := max_concurrent_connections (server).max (1) -- At least one thread!
			create pool.make (n.to_natural_32)
		end

feature -- Access

	is_shutdown_requested: BOOLEAN

	max_concurrent_connections (a_server: like server): INTEGER
		do
			Result := a_server.configuration.max_concurrent_connections
		end

feature {HTTPD_SERVER_I} -- Execution

	shutdown
		do
			if not is_shutdown_requested then
				is_shutdown_requested := True
				pool_gracefull_stop (pool)
			end
		end

	pool_gracefull_stop (p: like pool)
		do
			p.terminate
		end

	accept_incoming_connection (a_listening_socket: HTTPD_STREAM_SOCKET)
		local
			cl: separate HTTPD_STREAM_SOCKET
		do
			debug ("dbglog")
				dbglog (generator + ".ENTER accept_connection {"+ a_listening_socket.descriptor.out +"}")
			end

			if is_shutdown_requested then
					-- cancel
			elseif attached factory.new_handler as h then
				cl := h.client_socket
				a_listening_socket.accept_to (cl)
				if h.is_connected then
					pool.add_work (agent h.safe_execute)
				end
			end

			debug ("dbglog")
				dbglog (generator + ".LEAVE accept_incoming_connection {"+ a_listening_socket.descriptor.out +"}")
			end
		end

feature {HTTPD_SERVER_I} -- Status report

	wait_for_completion
			-- Wait until Current is ready for shutdown
		do
			pool.wait_for_completion
		end

feature {NONE} -- Access

	pool: THREAD_POOL [HTTPD_REQUEST_HANDLER] --ANY] --POOLED_THREAD [HTTP_REQUEST_HANDLER]]
			-- Pool of concurrent connection handlers.

invariant
	pool_attached: pool /= Void

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
