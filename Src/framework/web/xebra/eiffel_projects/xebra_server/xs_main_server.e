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
			create commands.make
		ensure
			commands_attached: commands /= Void
		end

feature -- Access

	http_connection_server: detachable XS_HTTP_CONN_SERVER assign set_http_connection_server
			-- Handles connections to http server requests

	input_server: detachable XS_INPUT_SERVER assign set_input_server

	commands: XS_COMMAND_MANAGER

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
			config.args.set_assume_webapps_are_running (a_arg_parser.assume_webapps_are_running)
			print("%N%N%N")
			o.iprint ("Starting Xebra Web Application Server...")
			o.dprint (config.args.print_configuration, 2)
			stop := false
			commands.put (create {XSC_LOAD_CONFIG}.make)
			commands.put (create {XSC_LAUNCH_HTTPS}.make)
			commands.put (create {XSC_LAUNCH_INPUTS}.make)
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
				commands.execute_next (current)

			end

			o.iprint ("Shutting down...")
			o.dprint ("Terminating Web Applications...",3)
			create l_webapp_handler.make
			l_webapp_handler.stop_apps

			if attached http_connection_server as https then
				if https.launched then
					o.dprint ("Waiting for http_connection_server to shutdown...", 3)
					https.shutdown
					https.join
				end
			end

			if attached input_server as inputs then
				if inputs.launched then
					o.dprint ("Waiting for input_server to shutdown...", 3)
					inputs.join
				end
			end

			o.iprint ("Shutdown complete. Bye!")
		end


feature {XSC_LAUNCH_HTTPS} -- Status setting

	set_http_connection_server (a_http_connection_server: like http_connection_server)
			-- Sets http_connection_server.
		require
			a_http_connection_server_attached: a_http_connection_server /= Void
		do
			http_connection_server  := a_http_connection_server
		ensure
			http_connection_server_set: http_connection_server  = a_http_connection_server
		end

feature {XSC_STOP_SERVER} -- Status setting

	set_stop (a_stop: like stop)
			-- Sets stop.
		require
			a_stop_attached: a_stop /= Void
		do
			stop  := a_stop
		ensure
			stop_set: stop  = a_stop
		end

feature {XSC_LAUNCH_INPUTS} -- Status setting

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
