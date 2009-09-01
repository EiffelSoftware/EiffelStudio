note
	description: "[
			Receives {XC_WEBAPP_COMMAND}s from the server, executes them and responds with {XC_COMMAND_RESPONSE}.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_SERVER_CONN_HANDLER

inherit
	THREAD
	XU_SHARED_OUTPUTTER
	XC_WEBAPP_INTERFACE
	XU_STOPWATCH
	XWA_SHARED_CONFIG

feature {NONE} -- Initialization

	make
			-- Initialization of classes.
		do
			create session_manager.make
			create {HASH_TABLE [XWA_SERVLET, STRING]} stateless_servlets.make (1)
			create server_socket.make_server_by_port (config.port.value)
			server_socket.set_accept_timeout ({XU_CONSTANTS}.Socket_accept_timeout)
			stop := False
			add_servlets
		ensure
			server_socket_attached: server_socket /= Void
			session_manager_attached: session_manager /= Void
			stateless_servlets_attached: stateless_servlets /= Void
		end

feature -- Constants

	session_manager: XWA_SESSION_MANAGER
		-- The session manager for a wep app. Has to be
		-- created before threads are spawned

feature -- Access

	stateless_servlets: TABLE [XWA_SERVLET, STRING]
			-- All the servlets which do not need a state

	stop: BOOLEAN
			-- Used to stop the thread

	server_socket: NETWORK_STREAM_SOCKET
			-- The socket to the server

feature -- Implementation

	execute
			-- Waits for connections from the Xebra Server
		local
			l_response:  XC_COMMAND_RESPONSE
		do
			log.set_name (config.name.out)
			log.set_debug_level (config.arg_config.debug_level)

        	from
                server_socket.listen ({XU_CONSTANTS}.Max_tcp_clients)
            until
            	stop
            loop
                server_socket.accept
                if not stop then
	                if attached {NETWORK_STREAM_SOCKET} server_socket.accepted as l_socket then
	                	if config.arg_config.debug_level > log.debug_configuration then
	                		start_time
	                	end
		                log.dprint ("Connection to Xebra Server accepted", log.debug_subtasks)
		                l_socket.read_natural
			             if attached {XC_WEBAPP_COMMAND} l_socket.retrieved as l_command then
			             	l_response := l_command.execute (current)
			       			if l_command.has_response then
							    log.dprint ("Sending back response...", log.debug_subtasks)
						        l_socket.put_natural (0)
								l_socket.independent_store (l_response)

								debug
									if attached {XCCR_HTTP_REQUEST} l_response as l_http_response then
										log.dprint ("%N%N----------------%N" + l_http_response.response.render_to_string  + "%N", 7)
									end
								end
			       			end
			            end
			            l_socket.cleanup
			            check
				        	l_socket.is_closed
				       	end
				       	if config.arg_config.debug_level > log.debug_configuration then
				       		stop_time
	                		log.dprint ("Webapp Request Time: " + last_elapsed_time, log.debug_configuration)
	                	end
			         end
		         end
            end
            server_socket.cleanup
			log.dprint("Server connection server ends.", log.debug_start_stop_components)
		ensure then
        	server_socket_closed: server_socket.is_closed
		rescue
       		log.eprint ("Exception in server connection server! Retrying...", generating_type)
			server_socket.cleanup
			check
        		server_socket.is_closed
       		end
			if not stop then
				retry
			end
        end

feature -- Status report

	is_bound: BOOLEAN
			-- Checks if the socket could be bound
		do
			Result := server_socket.is_bound
		end

feature -- Status setting

	add_servlets
			-- Adds servlets
		deferred
		end


feature {XC_COMMAND} -- Inherited from XC_WEBAPP_INTERFACE

	handle_http_request (a_request: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>
		local
			l_request_handler: XWA_REQUEST_HANDLER
			l_parser: XH_REQUEST_PARSER
		do
			log.dprint ("Handling http request...", log.debug_tasks)
			log.dprint ("%N%N---%N" + a_request  + "%N", 7)

			create l_parser.make
			create l_request_handler
			if attached {XH_REQUEST} l_parser.request (a_request) as l_request then
				create {XCCR_HTTP_REQUEST}Result.make (l_request_handler.process_servlet (session_manager, l_request, Current))
			else
				create {XCCR_INTERNAL_SERVER_ERROR}Result
				log.eprint ("Request could not be parsed!", generating_type)
			end

		end

	get_sessions: XC_COMMAND_RESPONSE
			-- <Precursor>
		do
			log.dprint ("Counting sessions (=" + session_manager.sessions.count.as_natural_32.out + ")", log.debug_verbose_subtasks)
			Result := create {XCCR_GET_SESSIONS}.make (session_manager.sessions.count.as_natural_32)
		end

feature -- Basic Operations

	shutdown: XC_COMMAND_RESPONSE
			-- <Precursor>
		do
			log.dprint ("Shutting down...", log.debug_start_stop_app)
			stop := True
			Result := create {XCCR_OK}
		end

invariant
	server_socket_attached: server_socket /= Void
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
