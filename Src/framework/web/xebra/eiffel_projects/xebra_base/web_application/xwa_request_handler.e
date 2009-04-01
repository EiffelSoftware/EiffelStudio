note
	description: "[
		Handles requests and delegates them to the appropriate servlet. Is
		reponsible for sending back the response to the client.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_REQUEST_HANDLER

create
	make

feature {NONE} -- Initialization

	make
			--
		do
		end

feature -- Access

feature -- Processing

	process_servlet (a_session_manager: XWA_SESSION_MANAGER; a_request: XH_REQUEST;
					 a_socket: NETWORK_STREAM_SOCKET; a_request_handler: XWA_SERVER_CONN_HANDLER)
			-- Processes an incoming request and sends it back to the server.
			-- Routes the request to the appropriate controller.
		local
			l_servlet: detachable XWA_SERVLET
			l_response: XH_RESPONSE
		do
			l_servlet := find_servlet (a_request, a_request_handler)

			if attached l_servlet then
				l_response := l_servlet.pre_handle_request (a_session_manager, a_request)
			else
				create l_response.make
				l_response.html.put_string ("Application not found: %"" + a_request.target_uri + "%"")
			end

		  -- 	a_socket.independent_store (handle_servlet(a_request, a_request_handler))
		   	a_socket.independent_store (l_response)
	       	a_socket.close
		end

feature {NONE} -- Internal Processing

	find_servlet (a_request: XH_REQUEST; a_request_handler: XWA_SERVER_CONN_HANDLER): detachable XWA_SERVLET
			-- Searches for the servlet requested by `request'
			-- 1. Stateless servlet?
			-- 2. Servlet in session?
			-- 3. If not found := Void
		do
			if attached {XWA_STATELESS_SERVLET} a_request_handler.stateless_servlets [a_request.target_uri] as l_servlet then
				Result := l_servlet
			else
			--	Result := request.session.get_stateful_servlet
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
