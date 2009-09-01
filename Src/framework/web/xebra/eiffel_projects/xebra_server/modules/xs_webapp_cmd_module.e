note
	description: "[
		A server module that reads commands on a socket.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_CMD_MODULE

inherit
	XC_SERVER_MODULE
		rename
			make as module_make
		end
	THREAD
	XS_SHARED_SERVER_CONFIG
	XS_SHARED_SERVER_OUTPUTTER

create
	make

feature -- Initialization

	make (a_main_server: like main_server; a_name: STRING)
			-- Initializes current
		require
			a_main_server_attached: a_main_server /= Void
			a_name_attached: a_name /= Void
		do
			module_make (a_name)
			main_server := a_main_server
 		ensure
			main_server_set: a_main_server ~ main_server
			name_set: name ~ a_name
		end

feature -- Inherited Features

	execute
			-- <Precursor>
		local
			l_command_response: XC_COMMAND_RESPONSE
			l_cmd_socket: detachable NETWORK_STREAM_SOCKET

		do
			stop := False
			is_launched := True
			is_running := True

			create l_cmd_socket.make_server_by_port ({XU_CONSTANTS}.Cmd_server_port)

			if not l_cmd_socket.is_bound then
				log.eprint ("Socket could not be bound on port " + {XU_CONSTANTS}.Cmd_server_port.out, generating_type)
			else

	 	       	l_cmd_socket.set_accept_timeout ({XU_CONSTANTS}.Socket_accept_timeout)
				from
	                l_cmd_socket.listen ({XU_CONSTANTS}.Max_tcp_clients.as_integer_32)
	                log.dprint("Command Server ready on port " + {XU_CONSTANTS}.Cmd_server_port.out, log.debug_start_stop_components)
	            until
	            	stop
	            loop
	                l_cmd_socket.accept

	                if not stop then
			            if attached {NETWORK_STREAM_SOCKET} l_cmd_socket.accepted as thread_cmd_socket then
	 					 	log.dprint ("Command connection to Webapp accepted", log.debug_verbose_subtasks)
	 					 	thread_cmd_socket.read_natural
				            if attached {XC_SERVER_COMMAND} thread_cmd_socket.retrieved as l_command then
				            	log.dprint ("Command retreived...", log.debug_verbose_subtasks)
								l_command_response := l_command.execute (main_server)

					 	       	if l_command.has_response then
						 	       	log.dprint ("Sending back command_response...", log.debug_subtasks)
									thread_cmd_socket.put_natural (0)
									thread_cmd_socket.independent_store (l_command_response)
					 	       	end
				 	       	end
				         	thread_cmd_socket.cleanup
				            check
				            	socket_closed: thread_cmd_socket.is_closed
				            end
						end
					end
				end

	            l_cmd_socket.cleanup
	        	check
	        		socket_closed: l_cmd_socket.is_closed
	       		end
	       		log.dprint("Command Server ends.", log.debug_start_stop_components)
	       		is_running := False
	       	end
       		rescue
       			log.eprint ("Command Server Module shutdown due to exception. Please relaunch manually.", generating_type)

				if attached {NETWORK_STREAM_SOCKET} l_cmd_socket as ll_cmd_socket then
					ll_cmd_socket.cleanup
					check
		        		ll_cmd_socket.is_closed
		       		end
				end

				stop := True
				is_running := False
       	end

feature -- Access

	stop: BOOLEAN
			-- Set true to stop accept loop

feature {NONE} -- Access

	main_server: XC_SERVER_INTERFACE

feature -- Status setting

	shutdown
			-- Stops the thread
		do
			stop := True
		end

invariant
	main_server_attached: main_server /= Void
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

