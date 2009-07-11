note
	description: "[
		The action which sends a request to the webapp
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
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
		local
			l_webapp_socket: NETWORK_STREAM_SOCKET
		do
			if attached {XC_WEBAPP_COMMAND} webapp.current_request as l_current_request then
				o.dprint("-=-=-=--=-=SENDING TO WEBAPP (0) -=-=-=-=-=-=", 6)
				create l_webapp_socket.make_client_by_port (webapp.app_config.port, webapp.app_config.host)
				o.dprint ("Connecting to " + webapp.app_config.name.out + "@" + webapp.app_config.port.out, 2)
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
			            	Result := (create {XER_BAD_RESPONSE}.make (webapp.app_config.name.out)).render_to_command_response
			            end
				   else
				   		Result := create {XCCR_NO_RESPONSE}.make
				   end

		        else
		        	Result := (create {XER_CANNOT_CONNECT}.make (webapp.app_config.name.out)).render_to_command_response
		        end
		     end
		    rescue
		    	o.eprint ("Exception while sending command to webapp", generating_type)
		end

end


