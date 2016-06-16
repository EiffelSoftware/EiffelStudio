note
	description: "[
			Implementation of HTTPD_CONNECTION_HANDLER_I for concurrency mode: none
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
		do
		end

feature -- Access

	is_shutdown_requested: BOOLEAN
			-- <Precursor>

	shutdown_requested (a_server: like server): BOOLEAN
		do
			-- FIXME: we should probably remove this possibility, check with EWF if this is needed.
			Result := a_server.controller.shutdown_requested
		end

feature {HTTPD_SERVER_I} -- Execution

	accept_incoming_connection (a_listening_socket: HTTPD_STREAM_SOCKET)
		local
			cl: HTTPD_STREAM_SOCKET
		do
			is_shutdown_requested := is_shutdown_requested or shutdown_requested (server)
			if is_shutdown_requested then
					-- Cancel
			elseif attached factory.new_handler as h then
				cl := h.client_socket
				a_listening_socket.accept_to (cl)
				if h.is_connected then
					h.safe_execute
				end
			else
				check is_not_full: False end
			end
			update_is_shutdown_requested
		end

	update_is_shutdown_requested
		do
			is_shutdown_requested := shutdown_requested (server)
		end

	shutdown
		do
			if not is_shutdown_requested then
				is_shutdown_requested := True
				server.controller.shutdown
			end
		end

feature {HTTPD_SERVER_I} -- Status report

	wait_for_completion
			-- Wait until Current is ready for shutdown
		do
			-- no concurrency, then current task should be done.
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
