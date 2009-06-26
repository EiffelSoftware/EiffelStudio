note
	description: "[

	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_SERVER_CONN_HANDLER

inherit
	THREAD
	XU_SHARED_OUTPUTTER
	XC_WEBAPP_INTERFACE

feature {NONE} -- Initialization

	make (a_config: XC_WEBAPP_CONFIG)
			-- Initialization of classes.
		require
			a_config_attached: a_config /= Void
		do
			config := a_config
			create session_manager.make
	--		create request_pool.make  (10, agent servlet_handler_spawner)
			create {HASH_TABLE [XWA_SERVLET, STRING]} stateless_servlets.make (1)
			create xserver_socket.make_server_by_port (config.port.value)
			xserver_socket.set_accept_timeout (500)
			stop := False
			add_servlets
		ensure
			config_attached: config /= Void
			xserver_socket_attached: xserver_socket /= Void
			session_manager_attached: session_manager /= Void
			stateless_servlets_attached: stateless_servlets /= Void
		end

feature -- Constants

	session_manager: XWA_SESSION_MANAGER
		-- The session manager for a wep app. Has to be
		-- created before threads are spawned

feature -- Access

--	request_pool: DATA_THREAD_POOL [XWA_REQUEST_HANDLER]
			-- A thread pool for the incoming requests from the xebra server

	stateless_servlets: TABLE [XWA_SERVLET, STRING]
			-- All the servlets which do not need a state
			-- Page id points to the thread pool of servlets

	stop: BOOLEAN
			-- Used to stop the thread

	config: XC_WEBAPP_CONFIG
			-- The configuration for the webapp

	xserver_socket: NETWORK_STREAM_SOCKET
			-- The socket to the server

feature -- Implementation

	execute
			-- Waits for connections from the Xebra Server
		local

			l_response:  XC_COMMAND_RESPONSE
		do
			o.set_name (config.name.out)
			o.set_debug_level (config.arg_config.debug_level)

        	from
                xserver_socket.listen (10)
            until
            	stop
            loop
                xserver_socket.accept
                if not stop then
	                if attached {NETWORK_STREAM_SOCKET} xserver_socket.accepted as socket then
		                o.dprint ("Connection to Xebra Server accepted",1)
		                socket.read_natural
			             if attached {XC_WEBAPP_COMMAND} socket.retrieved as l_command then
			             	l_response := l_command.execute (current)
			            else
							l_response := (create {XER_INVALID_COMMAND}.make("")).render_to_command_response
			            end
					    o.dprint ("Sending back response...", 2)
				        socket.put_natural (0)
						socket.independent_store (l_response)
			            socket.cleanup
			            check
				        	socket.is_closed
				       	end
			         end
		         end
            end
            xserver_socket.cleanup
        ensure then
        	xserver_socket_closed: xserver_socket.is_closed
		end

feature -- Status report

	is_bound: BOOLEAN
			-- Checks if the socket could be bound
		do
			Result := xserver_socket.is_bound
		end

feature -- Status setting

	add_servlets
			-- Adds servlets
		deferred
		end


feature {XC_COMMAND} -- Inherited from XC_WEBAPP_INTERFACE

	handle_http_request (a_request: XH_REQUEST): XC_COMMAND_RESPONSE
			-- <Precursor>
		local
			l_request_handler: XWA_REQUEST_HANDLER
		do
			o.dprint ("Handling http request...", 4)
			create l_request_handler.make
			create {XCCR_HTTP_REQUEST}Result.make (l_request_handler.process_servlet (session_manager, a_request, Current))
		end

	get_sessions: XC_COMMAND_RESPONSE
			-- <Precursor>
		do	o.dprint ("Counting sessions (=" + session_manager.sessions.count.as_natural_32.out + ")", 4)
			Result := create {XCCR_GET_SESSIONS}.make (session_manager.sessions.count.as_natural_32)
		end

feature -- Basic Operations

	shutdown: XC_COMMAND_RESPONSE
			-- <Precursor>
		do
			o.dprint ("Shutting down...", 1)
			stop := True
			Result := create {XCCR_OK}.make
		end

invariant
	config_attached: config /= Void
	xserver_socket_attached: xserver_socket /= Void
	session_manager_attached: session_manager /= Void
	stateless_servlets_attached: stateless_servlets /= Void
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
