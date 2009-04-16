note
	description: "[
		Handler of the connection with the XEbraServer. Delegates all incoming
		requests to the appropriate servlet. Caching of sessions and session objects
		handled as well.
		A specific handler which inherits from this class is generated to accomodate
		all the xeb pages of a particular web application.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_SERVER_CONN_HANDLER

inherit
	THREAD
	XU_DEBUG_OUTPUTTER
	XU_ERROR_OUTPUTTER

feature -- Constants

	Default_server_port: INTEGER = 55001

	Default_server_host: STRING = "localhost"

	Max_queue: INTEGER = 5

	session_manager: XWA_SESSION_MANAGER
		-- The session manager for a wep app. Has to be
		-- created before threads are spawned

feature -- Protocol Constants

	Key_register: STRING = "#REG#"
	Key_register_ack: STRING = "#RACK#"

feature -- Access

	socket: XU_THREAD_NETWORK_STREAM_SOCKET
			-- The socket to the xebra server

	request_pool: DATA_THREAD_POOL [XWA_REQUEST_HANDLER]
			-- A thread pool for the incoming requests from the xebra server

	stateless_servlets: TABLE [XWA_STATELESS_SERVLET, STRING]
			-- All the servlets which do not need a state
			-- Page id points to the thread pool of servlets

	stop: BOOLEAN
			-- Used to stop the thread

	name: STRING
			-- The name of the web app



feature -- Implementation

	make (a_name: STRING)
			-- Initialization of classes.
		do
			name := a_name
			create session_manager.make
			create request_pool.make  (10, agent servlet_handler_spawner)
			create {HASH_TABLE [XWA_STATELESS_SERVLET, STRING]} stateless_servlets.make (1)
			create socket.make_client_by_port (Default_server_port, Default_server_host)
			stop := False
		ensure
			name_set: a_name = name
		end

	execute
			-- Registers to server and waits for requests.
		do
			if register then
				run
			else
				eprint ("Failed to register.")
			end
		end

	register: BOOLEAN
			-- Register with the xebra server.
		do
			Result := False

			dprint ("Connecting to Xebra Server...",1)
			socket.connect
			if socket.is_connected then
				dprint ("Connected.",1)

				dprint ("Sending registration...",1)
				socket.independent_store (Key_register + name)

				dprint ("Waiting for registration confirmation...",1)
				if attached {STRING} socket.retrieved as l_buf then
					if l_buf.is_equal (Key_register_ack) then
						dprint ("Registered.",1)
						Result := True
					else
						eprint ("No register confirmation was received.")
					end
				else
					eprint ("Not validly retrieved.")
				end
			else
				eprint ("Could not connect!")
			end
		end
	run
            -- Waits for incomming requests from the xebra server
        do
            from
            until
                stop
            loop
                process_request
            end
        end

	servlet_handler_spawner: XWA_REQUEST_HANDLER
			-- Spawns {SERVLET_HANDLER}s for the `request_pool'.
		do
			create Result.make
		end

    process_request
              -- Receive a request, handle it in new thread, and send it back.
        local
        	l_request_handler: XWA_REQUEST_HANDLER
        do
        	create l_request_handler.make
            if socket.is_connected then
	            if attached {STRING} socket.retrieved as l_request_message then
	 	        --	request_pool.add_work (agent {XWA_REQUEST_HANDLER}.process_servlet (session_manager, l_request_message, socket, Current))
	 	        		--singleusermode
	 	        	l_request_handler.process_servlet (session_manager, l_request_message, socket, Current)
	            else
					socket.independent_store ((create {XER_GENERAL}.make("Xebra App could not retrieve valid STRING object from Xebra Server")).render_to_response)
	            end
	        else
	        	eprint ("Connection lost.")
	        end
        end

feature -- Status setting

	shutdown
			-- Stops the thread and closes connections
		do
			stop := True
			socket.cleanup
			check
        		socket.is_closed
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
