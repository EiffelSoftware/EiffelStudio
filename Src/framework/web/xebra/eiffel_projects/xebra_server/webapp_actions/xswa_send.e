note
	description: "[
		The action which sends a request to the webapp
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_SEND

inherit
	XS_WEBAPP_ACTION

create
	make

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

	internal_execute: XC_COMMAND_RESPONSE
			-- <Precursor>
		require else
			webapp_attached: webapp /= Void
		local
			l_webapp_socket: detachable NETWORK_STREAM_SOCKET
		do
			create {XCCR_INTERNAL_SERVER_ERROR}Result
			if attached webapp as l_wa then
				if attached {XC_WEBAPP_COMMAND} l_wa.current_request as l_current_request then
					o.dprint("-=-=-=--=-=SENDING TO WEBAPP (0) -=-=-=-=-=-=", 6)
					create l_webapp_socket.make_client_by_port (l_wa.app_config.port, l_wa.app_config.host)
					o.dprint ("Connecting to " + l_wa.app_config.name.out + "@" + l_wa.app_config.port.out, 2)
					l_webapp_socket.set_accept_timeout (3000)
					l_webapp_socket.connect
		            if  l_webapp_socket.is_connected then
						o.dprint ("Forwarding command", 2)
						l_webapp_socket.put_natural (0)

			            l_webapp_socket.independent_store (l_current_request)

			            if l_current_request.has_response then
			            	o.dprint ("Waiting for response", 2)
				            l_webapp_socket.read_natural
							if attached {XC_COMMAND_RESPONSE} l_webapp_socket.retrieved as l_response then
								o.dprint ("Response retrieved", 2)
				            	Result := l_response
				            else
				            	Result := (create {XER_BAD_RESPONSE}.make (l_wa.app_config.name.out)).render_to_command_response
				            end
					   else
					   		Result := create {XCCR_NO_RESPONSE}
					   end

			        else
			        	Result := (create {XER_CANNOT_CONNECT}.make (l_wa.app_config.name.out)).render_to_command_response
			        end
			        l_webapp_socket.cleanup
			     end
			    end
		    rescue
		    	o.eprint ("Exception while sending command to webapp", generating_type)
		    	if l_webapp_socket /= Void then
			    	l_webapp_socket.cleanup
		    	end
		end

end


