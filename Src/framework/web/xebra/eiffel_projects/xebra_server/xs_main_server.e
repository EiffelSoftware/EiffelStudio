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
			create modules.make (1)
		ensure
			modules_attached: modules /= Void
		end

feature {NONE} -- Access

	modules: XS_SERVER_MODULES

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
			load_config.do_nothing
			modules.force (create {XS_CONSOLE_MODULE}.make (current), "mod_console")
			modules.force (create {XS_HTTP_CONN_MODULE}.make (current), "mod_http")
			modules.force (create {XS_WEBAPP_CMD_MODULE}.make (current), "mod_cmd")
			o.dprint("Launching modules...",2)
			modules.run_all
			run
		end

feature {NONE} -- Operations

	run
			--  until stopped
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
		do
			from

			until
				stop
			loop
				do_nothing
			end

			o.iprint ("Shutting down...")
			shutdown_webapps.do_nothing
			shutdown_all_modules
			if attached modules ["mod_input"] as mod_input then
				if mod_input.running then
					o.iprint ("Remote Shutdown. Bye!");
					(create {EXCEPTIONS}).die (1)
				end
			end
			o.iprint ("Shutdown complete. Bye!")
		end


	shutdown_all_modules
			-- Shuts all modules down
		do
			from
				modules.start
			until
				modules.after
			loop
				shutdown_module (modules.key_for_iteration).do_nothing
				modules.forth
			end
		end


feature {XS_SERVER_MODULE} -- Status setting


	shutdown_webapps: XS_COMMAND_RESPONSE
			-- <Precursor>
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
		do
			o.iprint ("Terminating Web Applications...")
			create l_webapp_handler.make
			l_webapp_handler.stop_apps
			Result := create {XSCR_OK}.make
		end

	shutdown_module (a_name: STRING): XS_COMMAND_RESPONSE
			-- <Precursor>
		do
			o.iprint ("Shutting down module '" + a_name + "'...")
			if attached modules [a_name] as l_mod then
				l_mod.shutdown
				l_mod.join
			else
				o.iprint ("No module '" + a_name + "' found.")
			end
			Result := create {XSCR_OK}.make
		end

	relaunch_module (a_name: STRING): XS_COMMAND_RESPONSE
			-- <Precursor>
		do
			o.iprint ("Launching module '" + a_name + "'...")
			if attached modules [a_name] as l_mod then
				shutdown_module (a_name).do_nothing
				l_mod.launch
			else
				o.iprint ("No module '" + a_name + "' found.")
			end
			Result := create {XSCR_OK}.make
		end

	load_config: XS_COMMAND_RESPONSE
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
			end
			Result := create {XSCR_OK}.make
		end

	shutdown_server: XS_COMMAND_RESPONSE
			-- <Precursor>
		do
			stop := True
			Result := create {XSCR_OK}.make
		end

	get_modules: XS_COMMAND_RESPONSE
			-- <Precursor>
		local
			l_response: XSCR_GET_MODULES
		do
			create l_response.make
			from
				modules.start
			until
				modules.after
			loop
				l_response.modules.force ( [modules.key_for_iteration, modules.item_for_iteration.launched, modules.item_for_iteration.running])
				modules.forth
			end
			Result := l_response
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

invariant
		modules_attached: modules /= Void
end
