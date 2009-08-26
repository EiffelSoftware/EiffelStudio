note
	description: "[
		The action which sends a request to the webapp.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_SEND

inherit
	XS_WEBAPP_ACTION

feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
			-- Necessary if:
			--	- always
		do
			Result := True
		end

feature -- Status setting

	stop
			-- <Precursor>
		do
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
			if attached webapp as l_wa then
				if not retried then
					if attached {XC_WEBAPP_COMMAND} l_wa.current_request as l_current_request then
						log.dprint("-=-=-=--=-=SENDING TO WEBAPP (0) -=-=-=-=-=-=", log.debug_verbose_subtasks)
						create l_webapp_socket.make_client_by_port (l_wa.app_config.port, l_wa.app_config.webapp_host)
						log.dprint ("Connecting to " + l_wa.app_config.name.out + "@" + l_wa.app_config.port.out, log.debug_subtasks)
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
					            	internal_last_response := (create {XER_BAD_RESPONSE}.make (l_wa.app_config.name.out)).render_to_command_response
					            end
						   else
						   		internal_last_response := create {XCCR_NO_RESPONSE}
						   end

				        else
				        	internal_last_response := (create {XER_CANNOT_CONNECT}.make (l_wa.app_config.name.out)).render_to_command_response
				        end
				        l_webapp_socket.cleanup
				    end
				else
					internal_last_response := (create {XER_CANNOT_CONNECT}.make (l_wa.app_config.name.out)).render_to_command_response
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

end


