note
	description: "[
		The action which sends a shutdown message to the webapp
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_SHUTDOWN

inherit
	XS_WEBAPP_ACTION

create
	make

feature -- Constants

	Shutdown_message: STRING = "#KAMIKAZE#"

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

	internal_execute: XS_COMMANDS
			-- <Precursor>
		local
			l_webapp_socket: NETWORK_STREAM_SOCKET
		do
			create l_webapp_socket.make_client_by_port (webapp.app_config.port, webapp.app_config.host.out)
			o.dprint ("Shutdown connect to " + webapp.app_config.name.out + "@" + webapp.app_config.port.out, 4)
			l_webapp_socket.connect
            if  l_webapp_socket.is_connected then
				o.dprint ("Sending shutdown signal", 2)
	            l_webapp_socket.independent_store (Shutdown_message)
	            l_webapp_socket.cleanup
	        else
	         	o.eprint ("Cannot shutdown connect to '" + webapp.app_config.name.out + "'", generating_type)
			end
			Result := create {XS_COMMANDS}.make_with_response((create {XER_GENERAL}.make("Shutting down")).render_to_response)
		end


end
