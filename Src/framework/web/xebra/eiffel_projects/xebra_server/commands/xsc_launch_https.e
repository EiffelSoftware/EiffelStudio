note
	description: "Summary description for {XSC_LANUCH_HTTPS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XSC_LAUNCH_HTTPS

inherit
	XS_COMMAND

create
	make

feature -- Basic operations

	execute (a_server: XS_MAIN_SERVER)
			-- <Precursor>	
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
			l_webapp_finder: XS_WEBAPP_FINDER
			l_config_reader: XS_CONFIG_READER
		do
			o.iprint ("Launching http connection server...")
			a_server.http_connection_server := create {XS_HTTP_CONN_SERVER}.make 
			if not a_server.http_connection_server.is_bound then
					error_manager.add_error (create {XERROR_SOCKET_NOT_BOUND}.make, false)
			else
				a_server.http_connection_server.launch
				o.iprint ("Done.")
			end
		end
end
