note
	description: "[
		Handler of the connection with the XEbra-server. Delegates all incoming
		requests to the appropriate servlet. Caching of sessions and session objects
		handled as well.
		A specific handler which inherits from this class is generated to accomodate
		all the xeb pages of a particular web application.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REQUEST_HANDLER

feature -- Access

	request_pool: DATA_THREAD_POOL [SERVLET_HANDLER]
			-- A thread pool for the incoming requests from the xebra server

	stateless_servlets: TABLE [STATELESS_SERVLET, STRING]
			-- All the servlets which do not need a state
			-- Page id points to the thread pool of servlets

	session_map: TABLE [SESSION, STRING]
			-- A table which maps a session id on a session

feature -- Implementation

	run
			-- Starts the web application.
            -- Accept communication with client and exchange messages.
        local
            server_socket: NETWORK_STREAM_SOCKET
        do
            create server_socket.make_server_by_port (3491)
            from
                server_socket.listen (5)
            until
                false
            loop
                process (server_socket) -- See below
            end
            server_socket.cleanup
        end


	servlet_handler_spawner: SERVLET_HANDLER
			-- Spawns {SERVLET_HANDLER}s for the `request_pool'
		do
			create Result.make
		end

    process (server_socket: NETWORK_STREAM_SOCKET)
            -- Receive a message, handle it, and send it back
        do
            server_socket.accept
            if attached {NETWORK_STREAM_SOCKET} server_socket.accepted as thread_socket then
	            if attached {STRING} thread_socket.retrieved as message then
	            	request_pool.add_work (agent {SERVLET_HANDLER}.process (message, thread_socket))
	            end
            end
        end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
