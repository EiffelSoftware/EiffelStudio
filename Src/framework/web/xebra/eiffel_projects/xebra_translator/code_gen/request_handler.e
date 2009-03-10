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

	request_pool: THREAD_POOL_MANAGER [SERVLET_HANDLER]
			-- A thread pool for the incoming requests from the xebra server

	stateless_servlets: TABLE [STATELESS_SERVLET, STRING]
			-- All the servlets which do not need a state
			-- Page id points to the thread pool of servlets

	session_map: TABLE [SESSION, STRING]
			-- A table which maps a session id on a session

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

    process (server_socket: NETWORK_STREAM_SOCKET)
            -- Receive a message, handle it, and send it back
        local
            request: REQUEST
        do
            server_socket.accept
            if attached {NETWORK_STREAM_SOCKET} server_socket.accepted as thread_socket then
	            if attached {STRING} thread_socket.retrieved as message then
	            	request := build_request (message)
	            	thread_socket.independent_store (handle_request(request))
	            end
            	thread_socket.close
            end
        end

feature -- Processing

	build_request (message: STRING): REQUEST
			-- Transforms a plain text message into a {REQUEST} object
			-- for further use in he servlet.
			-- Session is retrieved and set
		do
			-- TODO: Proper session creation, management etc.
			create Result.make (extract_web_app_name (message).as_upper + "_SERVLET", create {SESSION})
		end

	extract_web_app_name (message: STRING): STRING
			-- Extracts the webapp name from the get-parameter.
		do
			Result := message.substring (16, message.count)
			Result := Result.substring (1, Result.substring_index (" ", 1)-1)
		end

	handle_request (request: REQUEST): RESPONSE
			-- Routes the request to the appropriate controller
		local
			servlet: detachable SERVLET
		do
			servlet := find_servlet (request)
			if attached servlet then
				Result := servlet.handle_request (request)
			else
				create Result.make
				Result.text := "Application not found: %"" + request.file_identifier + "%""
			end
		end

	find_servlet (request: REQUEST): detachable SERVLET
			-- Searches for the servlet requested by `request'
			-- 1. Stateless servlet?
			-- 2. Servlet in session?
			-- 3. If not found := Void
		do
			if attached {STATELESS_SERVLET} stateless_servlets [request.file_identifier] as servlet then
				Result := servlet
			else
				Result := request.session.get_servlet
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
