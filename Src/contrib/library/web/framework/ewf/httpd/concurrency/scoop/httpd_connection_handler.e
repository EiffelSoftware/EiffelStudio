note
	description: "[
			Implementation of HTTPD_CONNECTION_HANDLER_I for concurrency mode: SCOOP
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTPD_CONNECTION_HANDLER

inherit
	HTTPD_CONNECTION_HANDLER_I

create
	make

feature {NONE} -- Initialization

	initialize
		local
			n: INTEGER
			p: like pool
	 	do
			n := max_concurrent_connections (server).max (1) -- At least one processor!
			create p.make (n)
			initialize_pool (p, n)
			pool := p
		end

	initialize_pool (p: like pool; n: INTEGER)
			-- Initialize Concurrent pool of `n' potential separate connection handlers.
 		do
			p.set_count (n)
 		end

feature -- Access

	is_shutdown_requested: BOOLEAN
			-- <Precursor>

	max_concurrent_connections (a_server: like server): INTEGER
			-- Max concurrent connection settings from server `a_server'.
		do
			Result := a_server.configuration.max_concurrent_connections
		end

feature {HTTPD_SERVER_I} -- Execution

	shutdown
			-- <Precursor>
		do
			if not is_shutdown_requested then
				is_shutdown_requested := True
				pool_gracefull_stop (pool)
			end
		end

	pool_gracefull_stop (p: like pool)
			-- Graceful stop concurrent pool of separate connection handlers.
		do
			p.gracefull_stop
		end

	accept_incoming_connection (a_listening_socket: HTTPD_STREAM_SOCKET)
			-- <Precursor>
		do
			accept_connection_on_pool (pool, a_listening_socket) -- Wait on not pool.is_full or is_stop_requested
		end

	accept_connection_on_pool (a_pool: like pool; a_listening_socket: HTTPD_STREAM_SOCKET)
			-- Process accept connection
			-- note that the precondition matters for scoop synchronization.
		require
			concurrency: not a_pool.is_full or is_shutdown_requested or a_pool.stop_requested
		local
			cl: separate HTTPD_STREAM_SOCKET
		do
			debug ("dbglog")
				dbglog (generator + ".ENTER accept_connection_on_pool")
			end
			if is_shutdown_requested then
					-- Cancel
			elseif attached a_pool.separate_item (factory) as h then
				cl := separate_client_socket (h)
				a_listening_socket.accept_to (cl)
				process_handler (h)
			else
				check is_not_full: False end
			end
			debug ("dbglog")
				dbglog (generator + ".LEAVE accept_connection_on_pool")
			end
		end

	process_handler (hdl: separate HTTPD_REQUEST_HANDLER)
			-- Process request handler `hdl' as soon as `hdl' is connected to accepted socket.
		require
			hdl.is_connected
		do
			hdl.safe_execute
		end

feature {HTTPD_SERVER_I} -- Status report

	wait_for_completion
			-- Wait until Current is ready for shutdown.
		do
			wait_for_pool_completion (pool)
		end

	wait_for_pool_completion (p: like pool)
			-- Wait until concurrent pool is empty and terminated.
		require
			p.is_empty -- SCOOP wait condition.
		do
			p.terminate
		end

feature {NONE} -- Implementation

	separate_client_socket (hdl: separate HTTPD_REQUEST_HANDLER): separate HTTPD_STREAM_SOCKET
			-- Client socket for request handler `hdl'.
		do
			Result := hdl.client_socket
		end

	pool: separate CONCURRENT_POOL [HTTPD_REQUEST_HANDLER]
			-- Pool of separate connection handlers.

invariant
	pool_attached: pool /= Void

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
