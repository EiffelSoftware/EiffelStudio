note
	description: "[
			Interface for the incoming connection handler.

			Each incoming socket connection is processed by 
			an implementation of HTTPD_CONNECTION_HANDLER_I.

			Note there are 3 implementations, one for each concurrent mode: none, thread, scoop.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_CONNECTION_HANDLER_I

inherit
	HTTPD_DEBUG_FACILITIES

feature {NONE} -- Initialization

	frozen make (a_server: like server)
		do
			server := a_server
			factory := separate_factory (a_server)
			initialize
		end

	initialize
		deferred
		end

feature {NONE} -- Access

	factory: separate HTTPD_REQUEST_HANDLER_FACTORY
			-- Request handler factory.

	server: separate HTTPD_SERVER_I
			-- Associated server.

feature {HTTPD_SERVER_I} -- Execution

	accept_incoming_connection (a_listening_socket: HTTPD_STREAM_SOCKET)
			-- Accept incoming connection from `a_listening_socket'.
		deferred
		end

	shutdown
			-- Shutdown server.
		deferred
		end

	wait_for_completion
			-- Wait until Current completed any pending task.
			--| Used for SCOOP synchronisation.
		deferred
		end

feature {HTTPD_SERVER} -- Status report

	is_shutdown_requested: BOOLEAN
			-- Any request to shutdown the server?
		deferred
		end

feature {NONE} -- Implementation

	log (a_message: separate READABLE_STRING_8)
			-- Log `a_message'
		do
				-- FIXME: Concurrency issue on `server'
			separate_server_log (server, a_message)
		end

	separate_factory (a_server: like server): like factory
			-- Separate factory from `a_server'.
			--| required by SCOOP design.
		do
			Result := a_server.factory
		end

	separate_server_log (a_server: like server; a_message: separate READABLE_STRING_8)
			-- Concurrent call to `a_server.log (a_message)'.
		do
			a_server.log (a_message)
		end

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
