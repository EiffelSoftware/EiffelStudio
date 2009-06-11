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
	XS_SHARED_SERVER_OUTPUTTER
	ERROR_SHARED_MULTI_ERROR_MANAGER
	XS_SHARED_SERVER_CONFIG

create
    make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create {ARRAYED_QUEUE [XS_COMMAND]}commands.make (4)
		ensure
			commands_attached: commands /= Void
		end

feature -- Access

	http_connection_server: detachable XS_HTTP_CONN_SERVER assign set_http_connection_server
			-- Handles connections to http server requests

	input_server: detachable XS_INPUT_SERVER assign set_input_server

	commands: QUEUE [XS_COMMAND]

	stop: BOOLEAN assign set_stop
		-- Stops the server
feature -- Constants

	Name: STRING = "XEBSRV"

feature -- Operations

	setup (a_arg_parser: XS_ARGUMENT_PARSER)
			--
		require
			a_arg_parser_attached: a_arg_parser /= Void
		do
			config.args.set_clean (a_arg_parser.clean)
			config.args.set_debug_level (a_arg_parser.debug_level)
			config.args.set_config_filename (a_arg_parser.config_filename)

			print("%N%N%N")
			o.iprint ("Starting Xebra Web Application Server...")
			stop := false
			commands.force (create {XSC_LOAD_CONFIG}.make)
			commands.force (create {XSC_LAUNCH_HTTPS}.make)
			commands.force (create {XSC_LAUNCH_INPUTS}.make)
			run
		end

	run
				-- Executes commands in the queue until stopped
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
		do
			from

			until
				stop
			loop
				if not commands.is_empty then
					commands.item.execute (current)
					commands.item.handle_error (current)
					commands.remove
				end
			end

			o.iprint ("Shutting down...")
			o.dprint ("Terminating Web Applications...",3)
			create l_webapp_handler.make
			l_webapp_handler.stop_apps

			if attached http_connection_server as https then
				o.dprint ("Waiting for http_connection_server to shutdown...", 3)
				https.shutdown
				https.join
			end
			o.iprint ("Shutdown complete. Bye!")
		end

--	run (a_arg_parser: XS_ARGUMENT_PARSER)
--			-- Creates a server which listens to requests from http servers and from xebra apps
--		require
--			a_arg_parser_attached: a_arg_parser /= Void
--		local
--			l_printer: ERROR_CUI_PRINTER
--			l_webapp_handler: XS_WEBAPP_HANDLER
--			l_webapp_finder: XS_WEBAPP_FINDER
--			l_config_reader: XS_CONFIG_READER
--		do
--			o.set_debug_level (a_arg_parser.debug_level)
--			o.set_name ({XS_MAIN_SERVER}.Name)

--			print ("%N%N%N")
--			o.iprint ("Starting Xebra Server...")
--			o.dprint ("Reading configuration...",1)

--			create l_config_reader.make
--			if attached l_config_reader.process_file (a_arg_parser.config_filename) as config then
--				server_config := config
--				server_config.arg_config.set_debug_level (a_arg_parser.debug_level)
--				server_config.arg_config.set_clean (a_arg_parser.clean)
--				create l_webapp_finder.make
--				server_config.set_webapps (l_webapp_finder.search_webapps (server_config.webapps_root))

--				o.dprint (server_config.print_configuration, 2)
--			end

--			create l_printer.default_create
--			if error_manager.has_warnings then
--				error_manager.trace_warnings (l_printer)
--			end

--			if not error_manager.is_successful then
--				error_manager.trace_errors (l_printer)
--			else
--				check server_config /= Void end

--				o.dprint ("Launching HTTP Connection Server...",1)
--				create http_connection_server.make (server_config)
--				if not http_connection_server.is_bound then
--					o.eprint ("Socket could not be bound!", generating_type)
--				else
--					http_connection_server.launch
--					o.iprint ("Xebra Server ready to rock...")
--					o.iprint ("(enter 'x' to shut down)")
--					from
--						io.read_character
--					until
--						io.last_character.is_equal ('x')
--					loop
--						io.read_character
--					end
--					o.iprint ("Shutting down...")
--					o.dprint ("Terminating Web Applications...",3)
--					create l_webapp_handler.make (server_config)
--					l_webapp_handler.stop_apps
--					o.dprint ("Waiting for http_connection_server to shutdown...", 3)
--					http_connection_server.shutdown
--					http_connection_server.join
--				end
--			end
--			o.iprint ("All done. Bye!")
--		end

feature -- Status setting

	set_http_connection_server (a_http_connection_server: like http_connection_server)
			-- Sets http_connection_server.
		require
			a_http_connection_server_attached: a_http_connection_server /= Void
		do
			http_connection_server  := a_http_connection_server
		ensure
			http_connection_server_set: http_connection_server  = a_http_connection_server
		end

	set_stop (a_stop: like stop)
			-- Sets stop.
		require
			a_stop_attached: a_stop /= Void
		do
			stop  := a_stop
		ensure
			stop_set: stop  = a_stop
		end

	set_input_server (a_input_server: like input_server)
			-- Sets input_server.
		require
			a_input_server_attached: a_input_server /= Void
		do
			input_server  := a_input_server
		ensure
			input_server_set: input_server  = a_input_server
		end

invariant
		commands_attached: commands /= Void

end
