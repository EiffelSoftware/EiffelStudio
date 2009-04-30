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

feature -- Constants

	Default_listening_port: INTEGER = 55001


	session_manager: XWA_SESSION_MANAGER
		-- The session manager for a wep app. Has to be
		-- created before threads are spawned


feature -- Access

	request_pool: DATA_THREAD_POOL [XWA_REQUEST_HANDLER]
			-- A thread pool for the incoming requests from the xebra server

	stateless_servlets: TABLE [XWA_STATELESS_SERVLET, STRING]
			-- All the servlets which do not need a state
			-- Page id points to the thread pool of servlets

	stop: BOOLEAN
			-- Used to stop the thread

	name: STRING
			-- The name of the web app


	xserver_socket: NETWORK_STREAM_SOCKET

feature -- Implementation

	make (a_name: STRING; a_port: INTEGER)
			-- Initialization of classes.
		do
			name := a_name
			create session_manager.make
			create request_pool.make  (10, agent servlet_handler_spawner)
			create {HASH_TABLE [XWA_STATELESS_SERVLET, STRING]} stateless_servlets.make (1)
			create xserver_socket.make_server_by_port (a_port)
			stop := False
		ensure
			name_set: a_name = name
		end

	execute
			-- Waits for connections from the Xebra Server
		local
			l_request_handler: XWA_REQUEST_HANDLER
		do
			set_outputter_name (name)
			create l_request_handler.make
        	from
                xserver_socket.listen (10)
            until
            	stop
            loop
                xserver_socket.accept
                if not stop then
	                if attached {NETWORK_STREAM_SOCKET} xserver_socket.accepted as socket then
		                o.dprint ("Connection to Xebra Server accepted",1)
			             if attached {STRING} socket.retrieved as l_request_message then
			 	        --	request_pool.add_work (agent {XWA_REQUEST_HANDLER}.process_servlet (session_manager, l_request_message, socket, Current))
			 	        		--singleusermode
			 	        	l_request_handler.process_servlet (session_manager, l_request_message, socket, Current)
			            else
							socket.independent_store ((create {XER_GENERAL}.make("Xebra App could not retrieve valid STRING object from Xebra Server")).render_to_response)
			            end
			            socket.cleanup
			            check
				        	socket.is_closed
				       	end
			         end
		         end
            end

            xserver_socket.cleanup
        	check
        		xserver_socket.is_closed
        	end
        	exit
		end



	servlet_handler_spawner: XWA_REQUEST_HANDLER
			-- Spawns {SERVLET_HANDLER}s for the `request_pool'.
		do
			create Result.make
		end

feature -- Status setting

	shutdown
			-- Stops the thread and closes connections
		do
			stop := True
			xserver_socket.cleanup
			check
        		xserver_socket.is_closed
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
