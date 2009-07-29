note
	description: "[
		The run class that starts the application.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_APPLICATION

inherit
	XU_SHARED_OUTPUTTER
	ERROR_SHARED_MULTI_ERROR_MANAGER


feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.				
		local
			l_arg_parser: XWA_ARGUMENT_PARSER
			l_common_classes: XC_CLASSES
		do
			create l_common_classes.make
			print ("%N%N%N")
			create l_arg_parser.make
			l_arg_parser.execute (agent setup (l_arg_parser))
		end


feature {NONE} -- Operations Internal

	setup (a_arg_parser: XWA_ARGUMENT_PARSER)
			-- Sets the configuration.
		require
			a_arg_parser_attached: a_arg_parser /= Void
		local
			l_config_reader: XC_WEBAPP_CONFIG_READER
			l_printer: ERROR_CUI_PRINTER
		do
			create l_config_reader.make
			if attached l_config_reader.process_file (a_arg_parser.config_filename) as l_config then
				config := l_config
				config.arg_config.set_debug_level (a_arg_parser.debug_level)
				if a_arg_parser.is_interactive then
					config.is_interactive := True
				end
			end

			create l_printer.default_create
			if error_manager.has_warnings then
				error_manager.trace_warnings (l_printer)
			end

			if not error_manager.is_successful then
				error_manager.trace_errors (l_printer)
			else
				check config /= Void end

				o.set_name (config.name.out)
				o.set_debug_level (config.arg_config.debug_level)
				o.iprint ("Starting " + config.name.out + "@" + config.port.out)
				initialize_server_connection_handler
				run
			end
		end

	initialize_server_connection_handler
			-- Creates the server_connection_handler.
		require
			config_attached: config /= Void
		deferred
		ensure
			server_connection_handler_attached: server_connection_handler /= Void
		end

	run
			-- Runs the application.
		require
			server_connection_handler_attached: server_connection_handler /= Void
			config_attached: config /= Void
		do
			if attached server_connection_handler as server then
				if not server.is_bound then
					o.eprint ("Socket could not be bound!", generating_type)
				else
					server.launch
					o.iprint ("Xebra Web Application ready to rock...")
					if config.is_interactive.value then
						o.iprint ("(enter 'x' to shut down)")
						from
						until
							io.last_character.is_equal ('x')
						loop
							io.read_character
						end
						o.iprint ("Shutting down...")
						server.shutdown.do_nothing
					end
					server.join
					o.iprint ("Bye!")
				end
			end
		end

feature -- Access

	server_connection_handler: detachable XWA_SERVER_CONN_HANDLER
			-- Returns the applications server conn handler

	config: XC_WEBAPP_CONFIG
			-- Configuration for the webapp

feature -- Other

end
