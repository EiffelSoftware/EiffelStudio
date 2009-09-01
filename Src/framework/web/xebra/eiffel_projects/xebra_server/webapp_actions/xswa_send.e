note
	description: "[
		The action which sends a command to the webapp.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_SEND

inherit
	XS_WEBAPP_ACTION



feature {NONE} -- Status report

	action_name: STRING
			-- The name of the action as it appears in the status messages
		do
			Result := "Send Command to Webapp"
		end

	internal_is_execution_needed (a_with_cleaning: BOOLEAN): TUPLE [BOOLEAN, detachable LIST [XSWA_STATUS]]
			-- <Precursor>
			--
			-- List is always empty.
		do
			Result := [True, Void]
		end

feature -- Status setting

	set_running (a_running: BOOLEAN)
			-- Sets is_running	
		do
			if attached webapp as l_webapp then
				is_running := a_running
			end
		end
	stop
			-- <Precursor>
		do
			-- Can't be stopped.
		end

feature {NONE} -- Implementation

	internal_execute
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		local
			l_webapp_socket: detachable NETWORK_STREAM_SOCKET
			retried: BOOLEAN
		do
			create {XCCR_INTERNAL_SERVER_ERROR}internal_last_response
			if attached webapp as l_webapp then
				if not retried then
					if attached {XC_WEBAPP_COMMAND} l_webapp.current_request as l_current_request then
						log.dprint("-=-=-=--=-=SENDING TO WEBAPP (0) -=-=-=-=-=-=", log.debug_verbose_subtasks)
						create l_webapp_socket.make_client_by_port (l_webapp.app_config.port, l_webapp.app_config.webapp_host)
						log.dprint ("Connecting to " + l_webapp.app_config.name.out + "@" + l_webapp.app_config.port.out, log.debug_subtasks)
						l_webapp_socket.set_accept_timeout ({XU_CONSTANTS}.Socket_accept_timeout)
						l_webapp_socket.set_connect_timeout ({XU_CONSTANTS}.Socket_connect_timeout)
						l_webapp_socket.connect
			            if  l_webapp_socket.is_connected then
							log.dprint ("Forwarding command", log.debug_subtasks)
							l_webapp_socket.put_natural (0)

				            l_webapp_socket.independent_store (l_current_request)

				            if l_current_request.has_response then
				            	log.dprint ("Waiting for response", log.debug_subtasks)
					            l_webapp_socket.read_natural
								if attached {XC_COMMAND_RESPONSE} l_webapp_socket.retrieved as l_response then
									log.dprint ("Response retrieved", log.debug_subtasks)
					            	internal_last_response := l_response
					            else
					            	internal_last_response := (create {XER_BAD_RESPONSE}.make (l_webapp.app_config.name.out)).render_to_command_response
					            end
						   else
						   		internal_last_response := create {XCCR_NO_RESPONSE}
						   end

				        else
				        	internal_last_response := (create {XER_CANNOT_CONNECT}.make (l_webapp.app_config.name.out)).render_to_command_response
				        end
				        l_webapp_socket.cleanup
				    end
				else
					internal_last_response := (create {XER_CANNOT_CONNECT}.make (l_webapp.app_config.name.out)).render_to_command_response
				end
			end
		rescue
	    	log.eprint ("Exception while sending command to webapp", generating_type)
	    	if l_webapp_socket /= Void then
		    	l_webapp_socket.cleanup
	    	end
	    	retried := True
	    	retry
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


