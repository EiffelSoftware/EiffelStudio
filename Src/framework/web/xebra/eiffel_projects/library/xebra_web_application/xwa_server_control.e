note
	description: "[
		Is used to send commands to the server
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_SERVER_CONTROL

inherit
	XU_SHARED_OUTPUTTER

	XWA_SHARED_CONFIG

feature -- Operations

	send (a_command: XC_SERVER_COMMAND): XC_COMMAND_RESPONSE
			-- Sends a command to the server and waits for the response
		require
			a_command_attached: a_command /= Void
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			Result := create {XCCR_INTERNAL_SERVER_ERROR}

			create l_socket.make_client_by_port ({XU_CONSTANTS}.Cmd_server_port, config.server_host)
			log.dprint ("Connecting...", log.debug_verbose_subtasks)
			l_socket.set_connect_timeout ({XU_CONSTANTS}.Socket_connect_timeout)
			l_socket.connect
            if  l_socket.is_connected then
            	log.dprint("Sending command...", log.debug_verbose_subtasks)
            	l_socket.put_natural (0)
		        l_socket.independent_store (a_command)

		        if a_command.has_response then
		        	log.dprint ("Waiting for response", log.debug_verbose_subtasks)
		            l_socket.read_natural
					if attached {XC_COMMAND_RESPONSE} l_socket.retrieved as l_response then
						log.dprint ("Response retrieved", log.debug_verbose_subtasks)
		            	Result := l_response
		            else
		            	Result := create {XCCR_CANNOT_SEND}
	            	end
		        else
		        	Result := create {XCCR_NO_RESPONSE}
		        end
	        else
	        	Result := create {XCCR_CANNOT_SEND}
	        end
		ensure
			result_attached: Result /= Void
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

