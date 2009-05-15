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
		do
			Result := True
		end

feature -- Status setting

	stop
			-- <Precursor>
		do
		end

feature {NONE} -- Implementation

	internal_execute: XH_RESPONSE
			-- <Precursor>
		local
			l_webapp_socket: NETWORK_STREAM_SOCKET
		do
			o.dprint("-=-=-=--=-=SENDING TO WEBAPP (0) -=-=-=-=-=-=", 10)
			create l_webapp_socket.make_client_by_port (webapp.config.port, webapp.config.host)
			o.dprint ("Connecting to " + webapp.config.name.out + "@" + webapp.config.port.out, 2)
			l_webapp_socket.connect
            if  l_webapp_socket.is_connected then
				o.dprint ("Forwarding request", 2)
	            l_webapp_socket.independent_store (webapp.request_message)
	            o.dprint ("Waiting for response", 2)
				if attached {XH_RESPONSE} l_webapp_socket.retrieved as l_response then
					o.dprint ("Response retrieved", 2)
	            	Result := l_response
	            else
	            	Result := (create {XER_BAD_RESPONSE}.make (webapp.config.name.out)).render_to_response
	            end
	        else
	        	Result := (create {XER_CANNOT_CONNECT}.make (webapp.config.name.out)).render_to_response
	        end
		end

end


