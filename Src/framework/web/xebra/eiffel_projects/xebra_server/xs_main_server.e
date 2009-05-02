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
	XU_SHARED_OUTPUTTER
	ERROR_SHARED_ERROR_MANAGER

create
    make

feature -- Initialization

	make
			-- Creates a server which listens to requests from http servers and from xebra apps
		local
			l_printer: ERROR_CUI_PRINTER
		do
			set_outputter_name ("XEBSRV")
			print ("%N%N%N")
			o.iprint ("Starting Xebra Server...")
			o.dprint ("Reading configuration...",1)
			create server_config.make_from_file (Default_server_config_path)
			--create compile_service.make (server_config)

			create l_printer.default_create
			if error_manager.has_warnings then
				error_manager.trace_warnings (l_printer)
			end

			if not error_manager.is_successful then
				error_manager.trace_last_error (l_printer)
			else
				o.dprint ("Launching HTTP Connection Server...",1)
				create http_connection_server.make (server_config)
				if not http_connection_server.is_bound then
					o.eprint ("Socket could not be bound!", generating_type)
				else
					http_connection_server.launch

					o.iprint ("Xebra Server ready to rock...")

					o.iprint ("(enter 'x' to shut down)")
					from
						io.read_character
					until
						io.last_character.is_equal ('x')
					loop
						io.read_character
					end

					o.iprint ("Shutting down...")
					o.dprint ("Terminating Web Applications...",3)
					server_config.stop_apps
					o.dprint ("Waiting for http_connection_server to shutdown...", 3)
					http_connection_server.shutdown
				end
			end


			o.iprint ("All done. Bye!")

			(create {EXCEPTIONS}).die (0)
		end

feature -- Access


	http_connection_server: XS_HTTP_CONN_SERVER
			-- Handles connections to http server requests

--	app_connection_server: XS_APP_CONN_SERVER
--			-- Handles connections to xebra web application requests (for registration)


--	compile_service: XS_COMPILE_SERVICE

	server_config: XS_SERVER_CONFIG

feature -- Constants

--	Default_server_config_path: STRING = "$XEBRA_DEV/eiffel_projects/xebra_server/config.xml"
	Default_server_config_path: STRING = "config.xml"

end
