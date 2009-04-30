note
	description: "[
		Handles requests and delegates them to the appropriate servlet. Is
		reponsible for sending back the response to the client.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_REQUEST_HANDLER

inherit
	XU_SHARED_OUTPUTTER

create
	make

feature {NONE} -- Initialization

	make
			--
		do
		end

feature -- Access

feature -- Processing

process_servlet	 (a_session_manager: XWA_SESSION_MANAGER; a_request_message: STRING;
					 a_socket: NETWORK_STREAM_SOCKET;  a_server_conn_handler: XWA_SERVER_CONN_HANDLER)
			-- Processes an incoming request and sends it back to the server.
			-- Routes the request to the appropriate controller.

			-- TODO was ist hier genau der witz, dass man einen XWA_SERVER_CONN_HANDLER mitgibt? das kann sicher besser geloest werden. ist auch heike wegen thread!
		local
			l_servlet: detachable XWA_SERVLET
			l_new_request: detachable XH_REQUEST
			l_response: XH_RESPONSE
			l_request_factory: XH_REQUEST_FACTORY

		do
			create l_request_factory.make
			l_new_request := l_request_factory.get_request (a_request_message)
			create l_response.make_empty

			from

			until
				l_new_request = Void
			loop
				create l_response.make_empty
				o.dprint ("Searching matching servlet...",2)
				l_servlet := find_servlet (l_new_request, a_server_conn_handler)
				if attached l_servlet then
					o.dprint ("Handing over to matching servlet...",2)
					l_servlet.pre_handle_request (a_session_manager, l_new_request, l_response)
					l_new_request := post_process_response (l_response, l_new_request)
				else
					o.dprint ("No matching servlet found.",2)
					l_response := (create {XER_CANNOT_FIND_PAGE}.make(l_new_request.target_uri)).render_to_response
					l_new_request := Void
				end
			end
			o.dprint ("Sending back response...", 2)
		   	a_socket.independent_store (l_response)
		end

feature {NONE} -- Internal Processing

	post_process_response (a_response: XH_RESPONSE; a_previous_request: XH_REQUEST): detachable XH_GET_REQUEST
			-- If a goto value is specified in a_response a
			-- new request is generated out of it
		do
			 if not a_response.goto_request.is_empty then
				create Result.make_goto_request (a_response.goto_request, a_previous_request)
			 end
		end

	find_servlet (a_request: XH_REQUEST; a_server_conn_handler: XWA_SERVER_CONN_HANDLER): detachable XWA_SERVLET
			-- Searches for the servlet requested by `request'
			-- 1. Stateless servlet?
			-- 2. Servlet in session?
			-- 3. If not found := Void
		do
			if attached {XWA_STATELESS_SERVLET} a_server_conn_handler.stateless_servlets [a_request.target_uri] as l_servlet then
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
