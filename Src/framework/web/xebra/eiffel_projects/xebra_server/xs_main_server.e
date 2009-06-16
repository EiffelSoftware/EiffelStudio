note
	description: "[
			The main component of the Server. ...
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
    XS_MAIN_SERVER

inherit
	XSC_SERVER_INTERFACE
	XS_SHARED_SERVER_OUTPUTTER
	ERROR_SHARED_MULTI_ERROR_MANAGER
	XS_SHARED_SERVER_CONFIG

create
    make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create commands.make
		ensure
			commands_attached: commands /= Void
		end

feature -- Access

	http_connection_server: detachable XS_HTTP_CONN_SERVER
			-- Handles connections to http server requests

	input_server: detachable XS_INPUT_SERVER

	commands: XS_COMMAND_MANAGER

	stop: BOOLEAN
		-- Stops the server

feature -- Constants

	Name: STRING = "XEBSRV"


feature {XS_APPLICATION} -- Setup

	setup (a_arg_parser: XS_ARGUMENT_PARSER)
			--
		require
			a_arg_parser_attached: a_arg_parser /= Void
		do
			config.args.set_clean (a_arg_parser.clean)
			config.args.set_debug_level (a_arg_parser.debug_level)
			config.args.set_config_filename (a_arg_parser.config_filename)
			config.args.set_assume_webapps_are_running (a_arg_parser.assume_webapps_are_running)
			print("%N%N%N")
			o.iprint ("Starting Xebra Web Application Server...")
			o.dprint (config.args.print_configuration, 2)
			stop := false
			commands.put (create {XSC_LOAD_CONFIG}.make)
			commands.put (create {XSC_LAUNCH_HTTPS}.make)

			launch_input_server
			run
		end

feature {NONE} -- Operations

	run
				-- Executes commands in the queue until stopped
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
		do
			from

			until
				stop
			loop
				commands.execute_next (current)
			end

			o.iprint ("Shutting down...")
			shutdown_webapps
			shutdown_https
			if input_server.running then
				o.iprint ("Remote Shutdown. Bye!")
				(create {EXCEPTIONS}).die (1)
			else
				o.iprint ("Shutdown complete. Bye!")
			end
		end


feature {XS_COMMAND} -- Status setting

	shutdown_webapps
			-- <Precursor>
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
		do
			o.dprint ("Terminating Web Applications...",3)
			create l_webapp_handler.make
			l_webapp_handler.stop_apps
		end

	shutdown_https
			-- <Precursor>
		do
			if attached http_connection_server as https then
				if https.launched then
					o.dprint ("Waiting for http_connection_server to shutdown...", 3)
					https.shutdown
					https.join
				end
			end
		end



	launch_https
			-- <Precursor>
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
			l_webapp_finder: XS_WEBAPP_FINDER
			l_config_reader: XS_CONFIG_READER
		do
			shutdown_https

			o.iprint ("Launching http connection server...")
			http_connection_server := create {XS_HTTP_CONN_SERVER}.make (commands)
			if not http_connection_server.is_bound then
					error_manager.add_error (create {XERROR_SOCKET_NOT_BOUND}.make, false)
			else
				http_connection_server.launch
				print ("Done.")
			end
		end

	launch_input_Server
			-- <Precursor>	
		do
			o.iprint ("Launching input server...")
			input_server := create {XS_INPUT_SERVER}.make (current)
			input_server.launch
			print ("Done.")
		end


	load_config
			-- <Precursor>
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
			l_webapp_finder: XS_WEBAPP_FINDER
			l_config_reader: XS_CONFIG_READER
		do
			o.iprint ("Reading config...")
			create l_config_reader.make
			if attached l_config_reader.process_file (config.args.config_filename) as l_config then
				config.file := l_config
				create l_webapp_finder.make
				config.file.set_webapps (l_webapp_finder.search_webapps (config.file.webapps_root))
				o.dprint (config.file.print_configuration, 2)
				o.iprint ("Done.")
			end
		end

	shutdown_server
			-- <Precursor>
		do
			stop := True
		end

	handle_errors
			-- <Precursor>
		local
			l_printer: XS_ERROR_PRINTER
		do
			create l_printer.default_create
			if error_manager.has_warnings then
				error_manager.trace_warnings (l_printer)
			end

			if not error_manager.is_successful then
				error_manager.trace_errors (l_printer)
				stop := True
			end

		end

--	set_http_connection_server (a_http_connection_server: like http_connection_server)
--			-- Sets http_connection_server.
--		require
--			a_http_connection_server_attached: a_http_connection_server /= Void
--		do
--			http_connection_server  := a_http_connection_server
--		ensure
--			http_connection_server_set: http_connection_server  = a_http_connection_server
--		end

--	set_stop (a_stop: like stop)
--			-- Sets stop.
--		require
--			a_stop_attached: a_stop /= Void
--		do
--			stop  := a_stop
--		ensure
--			stop_set: stop  = a_stop
--		end


--	set_input_server (a_input_server: like input_server)
--			-- Sets input_server.
--		require
--			a_input_server_attached: a_input_server /= Void
--		do
--			input_server  := a_input_server
--		ensure
--			input_server_set: input_server  = a_input_server
--		end




invariant
		commands_attached: commands /= Void

end
