note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
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
		do
			print ("%N%N%N")
			create l_arg_parser.make
			l_arg_parser.execute (agent setup (l_arg_parser))
		end


feature {NONE} -- Operations Internal

	setup (a_arg_parser: XWA_ARGUMENT_PARSER)
			-- Sets the configuration.
		local
			l_config_reader: XWA_CONFIG_READER
			l_printer: ERROR_CUI_PRINTER
		do
			create l_config_reader.make
			if attached l_config_reader.process_file (a_arg_parser.config_filename) as l_config then
				config := l_config
			end
			create l_printer.default_create
			if error_manager.has_warnings then
				error_manager.trace_warnings (l_printer)
			end

			if not error_manager.is_successful then
				error_manager.trace_errors (l_printer)
			else
				check config /= Void end
				o.iprint ("Starting " + config.name.out)
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
		do
			if attached server_connection_handler as server then
				set_outputter_name (config.name)
				server.launch
				o.iprint ("Xebra Wep Application ready to rock...")
				if config.is_interactive.value then
					o.iprint ("(enter 'x' to shut down)")
					from
						stop := False
					until
						stop
					loop
						io.read_character
						if io.last_character.is_equal ('x') then
							stop := True
						end
					end
					o.iprint ("Shutting down...")
					server.shutdown
					o.iprint ("Bye!")
				end
				server.join
			end
		end

feature -- Access

	server_connection_handler: detachable XWA_SERVER_CONN_HANDLER
			-- Returns the applications server conn handler

	stop: BOOLEAN
			-- Is used to stop the application

	config: XWA_CONFIG
			-- Configuration for the webapp

feature -- Setter

	set_stop (a_stop: BOOLEAN)
			-- Setter
		do
			stop := a_stop
		ensure
			stop_set: stop = a_stop
		end


end
