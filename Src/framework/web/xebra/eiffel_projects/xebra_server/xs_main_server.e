note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
    XS_MAIN_SERVER

inherit
	XU_DEBUG_OUTPUTTER
	ERROR_SHARED_ERROR_MANAGER

create
    make

feature -- Initialization

	make
			-- Creates a server which listens to requests from http servers and from xebra apps
		local
			l_printer: ERROR_CUI_PRINTER
		do
			create compile_service.make

			dprint ("%N%N%N",1)
			dprint ("Starting Xebra Server...",1)
			dprint ("Reading configuration...",1)
			create server_config.make_from_file (Default_server_config_path)

			create l_printer.default_create
			if error_manager.has_warnings then
				error_manager.trace_warnings (l_printer)
			end

			if not error_manager.is_successful then
				error_manager.trace_last_error (l_printer)
			else

				dprint ("Launching HTTP Connection Server...",1)
				create http_connection_server.make (compile_service)
				http_connection_server.launch
			--	dprint ("Launching Web App Connection Server...",1)
			--	create app_connection_server.make (webapp_handler)
			--	app_connection_server.launch

				dprint ("Xebra Server ready to rock...",1)

				dprint ("(enter 'x' to shut down)",1)
				from
					io.read_character
				until
					io.last_character.is_equal ('x')
				loop
					io.read_character
				end

				dprint ("Shutting down...",1)
				--webapp_handler.close_all
				http_connection_server.shutdown
			--	app_connection_server.shutdown
				dprint ("Bye!",1)
			end
		end

feature -- Access

	http_connection_server: XS_HTTP_CONN_SERVER
			-- Handles connections to http server requests

--	app_connection_server: XS_APP_CONN_SERVER
--			-- Handles connections to xebra web application requests (for registration)


	compile_service: XS_COMPILE_SERVICE

	server_config: XS_SERVER_CONFIG

feature -- Constants

--	Default_server_config_path: STRING = "$XEBRA_DEV/eiffel_projects/xebra_server/config.xml"
	Default_server_config_path: STRING = "config.xml"

end
