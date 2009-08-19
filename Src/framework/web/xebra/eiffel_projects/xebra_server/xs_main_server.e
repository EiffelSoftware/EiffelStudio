note
	description: "[
			The main component of the Server.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
    XS_MAIN_SERVER

inherit
	XC_SERVER_INTERFACE

	XS_SHARED_SERVER_OUTPUTTER

	ERROR_SHARED_MULTI_ERROR_MANAGER

	XS_SHARED_SERVER_CONFIG

	EIFFEL_ENV

create
    make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create modules.make (3)
		ensure
			modules_attached: modules /= Void
		end

feature {NONE} -- Access

	modules: XS_SERVER_MODULES

	stop: BOOLEAN
		-- Stops the server

feature -- Constants

	Name: STRING = "XS"

feature {XS_APPLICATION} -- Setup

	setup (a_arg_parser: XS_ARGUMENT_PARSER)
			-- Sets the arguments to the config, reads the config file and launches the modules
		require
			a_arg_parser_attached: a_arg_parser /= Void
		do
			config.args.set_debug_level (a_arg_parser.debug_level)
			config.args.set_config_filename (a_arg_parser.config_filename)
			config.args.set_unmanaged (a_arg_parser.unmanaged)

			print("%N%N%N")
			o.iprint ("Starting Xebra Web Application Server...")
			if check_xebra_environment_variable then
				o.dprint (config.args.print_configuration, o.Debug_configuration)
				stop := false
				if attached {XCCR_OK} load_config then
					if attached a_arg_parser.create_webapp as l_config  then
						run_compile_mode (l_config)
					else
						modules.force (create {XS_CONSOLE_MODULE}.make (current, "mod_console"), "mod_console")
						modules.force (create {XS_HTTP_CONN_MODULE}.make (current, "mod_http"), "mod_http")
						modules.force (create {XS_WEBAPP_CMD_MODULE}.make (current, "mod_cmd"), "mod_cmd")
						o.dprint("Launching modules...", o.Debug_tasks)
						modules.run_all
						run
					end
				end
			end
		end

feature {NONE} -- Operations

	run
			-- Start the server
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
			l_thread: EXECUTION_ENVIRONMENT
		do
			create l_thread
			from until stop	loop
				l_thread.sleep (1000000)
			end

			o.dprint ("Shutting down...", o.Debug_start_stop_app)
			shutdown_all_modules
			shutdown_webapps.do_nothing
			if attached modules ["mod_input"] as l_mi then
				if l_mi.running then
					o.iprint ("Remote Shutdown. Bye!");
					(create {EXCEPTIONS}).die (1)
				end
			end
			o.iprint ("Shutdown complete. Bye!")
		end

	run_compile_mode (a_config: STRING)
			-- The server is not started as usual but only initiates translation of the specified webapp and ends afterwards.
		local
			l_w: XS_MANAGED_WEBAPP
			l_webapp_config_reader: XC_WEBAPP_JSON_CONFIG_READER
			l_thread: EXECUTION_ENVIRONMENT
			l_stop: BOOLEAN
		do
			create l_webapp_config_reader
			create l_thread
			if attached {XC_WEBAPP_CONFIG} l_webapp_config_reader.process_file (a_config) as l_c then
				create l_w.make_with_config (l_c)
				l_w.force_translate
				from
					o.iprint ("CREATING WEBAPP, hit enter to abort.")
				until
					l_stop
				loop
					io.read_line
					l_stop := True
				end
				o.iprint ("Aborting...")
				l_w.shutdown_all
			end
			handle_errors.do_nothing
		end

feature {XS_SERVER_MODULE} -- Status setting

	shutdown_all_modules
			-- Shuts all modules down
		local
			l_mods: ARRAYED_LIST [STRING]
		do
				-- Copy module names from hash table to arrayed list
			create l_mods.make (3)
			from
				modules.start
			until
				modules.after
			loop
				l_mods.force (modules.key_for_iteration)
				modules.forth
			end
				-- Shut down modules
			from
				l_mods.start
			until
				l_mods.after
			loop
				shutdown_module (l_mods.item_for_iteration).do_nothing
				l_mods.forth
			end
		end

	force_translate (a_name: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>.
		do
			if attached {XS_MANAGED_WEBAPP} config.file.webapps [a_name] as l_w then
				o.iprint ("Forcing retranslation of webapp '" + a_name + "'")
				l_w.force_translate
				create {XCCR_OK}Result
			elseif attached {XS_UNMANAGED_WEBAPP} config.file.webapps [a_name] then
				create {XCCR_INVALID_CMD_UNMANAGED}Result.make (a_name)
			else
				create {XCCR_WEBAPP_NOT_FOUND}Result.make (a_name)
			end
		end

	get_sessions (a_name: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>
		local
			l_webapp: XS_WEBAPP
		do
			from
				config.file.webapps.start
			until
				config.file.webapps.after
			loop
				l_webapp := config.file.webapps.item_for_iteration

				if not l_webapp.app_config.name.value.is_equal (a_name) then
					if not l_webapp.get_sessions then
						create {XCCR_INTERNAL_SERVER_ERROR}Result
					end
				end
				config.file.webapps.forth
			end
			create {XCCR_OK}Result
		end

	fire_off_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>
		do
			if attached {XS_WEBAPP} config.file.webapps [a_name] as l_w then
				o.iprint ("Fireing off webapp '" + a_name + "'")
				l_w.fire_off
				create {XCCR_OK}Result
			else
				create {XCCR_WEBAPP_NOT_FOUND}Result.make (a_name)
			end
		end

	dev_mode_on_global: XC_COMMAND_RESPONSE
			-- <Precursor>.
		do
			o.iprint ("Setting dev_mode global on.")
			from
				config.file.webapps.start
			until
				config.file.webapps.after
			loop
				if attached {XS_MANAGED_WEBAPP} config.file.webapps.item_for_iteration as l_webapp then
					l_webapp.dev_mode := True
				end
				config.file.webapps.forth
			end
			create {XCCR_OK}Result
		end

	dev_mode_off_global: XC_COMMAND_RESPONSE
			-- <Precursor>.
		do
			o.iprint ("Setting dev_mode global off.")
			from
				config.file.webapps.start
			until
				config.file.webapps.after
			loop
				if attached {XS_MANAGED_WEBAPP} config.file.webapps.item_for_iteration as l_webapp then
					l_webapp.dev_mode := False
				end
				config.file.webapps.forth
			end
			create {XCCR_OK}Result
		end

	dev_mode_on_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>.
		do
			if attached {XS_MANAGED_WEBAPP} config.file.webapps [a_name] as l_w then
				o.iprint ("Setting dev_mode of webapp '" + a_name + "' to on.")
				l_w.dev_mode := True
				create {XCCR_OK}Result
			elseif attached {XS_UNMANAGED_WEBAPP} config.file.webapps [a_name] then
				Result := create {XCCR_INVALID_CMD_UNMANAGED}.make (a_name)
			else
				create {XCCR_WEBAPP_NOT_FOUND}Result.make (a_name)
			end
		end

	dev_mode_off_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>.
		do
			if attached {XS_MANAGED_WEBAPP} config.file.webapps [a_name] as l_w then
				o.iprint ("Setting dev_mode of webapp '" + a_name + "' to off.")
				l_w.dev_mode := False
				create {XCCR_OK}Result
			elseif attached {XS_UNMANAGED_WEBAPP} config.file.webapps [a_name] then
				Result := create {XCCR_INVALID_CMD_UNMANAGED}.make (a_name)
			else
				create {XCCR_WEBAPP_NOT_FOUND}Result.make (a_name)
			end
		end


	launch_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>.
		do
			if attached {XS_MANAGED_WEBAPP} config.file.webapps [a_name] as l_w then
				o.iprint ("Launching webapp '" + a_name + "'...")
				l_w.send (create {XCWC_EMPTY}.make).do_nothing
				create {XCCR_OK}Result
			elseif attached {XS_UNMANAGED_WEBAPP} config.file.webapps [a_name] then
				Result := create {XCCR_INVALID_CMD_UNMANAGED}.make (a_name)
			else
				create {XCCR_WEBAPP_NOT_FOUND}Result.make (a_name)
			end
		end

	shutdown_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>.
		do
			if attached {XS_MANAGED_WEBAPP} config.file.webapps [a_name] as l_w then
				o.iprint ("Shutting down webapp '" + a_name + "'...")
				l_w.shutdown_all
				create {XCCR_OK}Result
			elseif attached {XS_UNMANAGED_WEBAPP} config.file.webapps [a_name] then
				Result := create {XCCR_INVALID_CMD_UNMANAGED}.make (a_name)
			else
				create {XCCR_WEBAPP_NOT_FOUND}Result.make (a_name)
			end
		end

	get_webapps: XC_COMMAND_RESPONSE
			-- <Precursor>.
		local
			l_response: XCCR_GET_WEBAPPS
		do
			create l_response.make
			if attached {HASH_TABLE [XS_WEBAPP, STRING]}config.file.webapps as l_webapps then
				from
					l_webapps.start
				until
					l_webapps.after
				loop
					l_response.webapps.force (l_webapps.item_for_iteration.copy_from_bean)
					l_webapps.forth
				end
			end
			Result := l_response
		end

	enable_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>.
		do
			if attached {XS_WEBAPP} config.file.webapps [a_name] as l_w then
				l_w.is_disabled := False
				o.iprint ("Enabling webapp '" + a_name + "'...")
				create {XCCR_OK}Result
			else
				create {XCCR_WEBAPP_NOT_FOUND}Result.make (a_name)
			end
		end

	disable_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>.
		do
			if attached {XS_WEBAPP} config.file.webapps [a_name] as l_w  then
				l_w.is_disabled := True
				o.iprint ("Disabling webapp '" + a_name + "'...")
				create {XCCR_OK}Result
			else
				create {XCCR_WEBAPP_NOT_FOUND}Result.make (a_name)
			end
		end

	clean_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>.
		do
			if attached {XS_MANAGED_WEBAPP} config.file.webapps [a_name] as l_webapp then
				l_webapp.set_needs_cleaning
				o.iprint ("Cleaning webapp '" + a_name + "'...")
				l_webapp.force_clean
				Result := create {XCCR_OK}
			elseif attached {XS_UNMANAGED_WEBAPP} config.file.webapps [a_name] then
				Result := create {XCCR_INVALID_CMD_UNMANAGED}.make (a_name)
			else
				Result := create {XCCR_WEBAPP_NOT_FOUND}.make (a_name)
			end
		end

	shutdown_webapps: XC_COMMAND_RESPONSE
			-- <Precursor>
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
		do
			o.iprint ("Terminating managed web applications...")
			create l_webapp_handler
			l_webapp_handler.stop_managed_apps
			Result := create {XCCR_OK}
		end

	shutdown_module (a_name: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>
		do
			o.iprint ("Shutting down module '" + a_name + "'...")
			if attached {XC_SERVER_MODULE} modules [a_name] as l_mod then
				l_mod.shutdown
				l_mod.join
			else
				o.iprint ("No module '" + a_name + "' found.")
			end
			Result := create {XCCR_OK}
		end

	relaunch_module (a_name: STRING): XC_COMMAND_RESPONSE
			-- <Precursor>
		do
			o.iprint ("Launching module '" + a_name + "'...")
			if attached modules [a_name] as l_mod then
				shutdown_module (a_name).do_nothing
				l_mod.launch
			else
				o.iprint ("No module '" + a_name + "' found.")
			end
			Result := create {XCCR_OK}
		end

	load_config: XC_COMMAND_RESPONSE
			-- <Precursor>
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
			l_config_reader: XS_JSON_CONFIG_READER
		do
			o.iprint ("Reading config...")
			create l_webapp_handler
			Result := create {XCCR_CONFIG_ERROR}
			create l_config_reader
			if attached {XS_FILE_CONFIG} l_config_reader.process_file (config.args.config_filename) as l_config then
				config.file := l_config
				if handle_errors then
					Result := create {XCCR_OK}
					o.dprint (config.file.print_configuration, o.Debug_configuration)

					if attached l_webapp_handler.search_webapps (config.file.webapps_root.value) as l_managed_webapps then
						from
							l_managed_webapps.start
						until
							l_managed_webapps.after
						loop
							config.file.webapps.force (l_managed_webapps.item_for_iteration, l_managed_webapps.key_for_iteration)
							l_managed_webapps.forth
						end
					end
					handle_errors.do_nothing
					o.dprint (config.file.print_webapp_configuration, o.Debug_configuration)
				end
			end
			handle_errors.do_nothing
		end

	shutdown_server: XC_COMMAND_RESPONSE
			-- <Precursor>
		do
			stop := True
			Result := create {XCCR_OK}
		end

	get_modules: XC_COMMAND_RESPONSE
			-- <Precursor>
		local
			l_response: XCCR_GET_MODULES
		do
			create l_response.make
			from
				modules.start
			until
				modules.after
			loop
				l_response.modules.force (create {XC_SERVER_MODULE_BEAN}.make_from_module(modules.item_for_iteration))
				modules.forth
			end
			Result := l_response
		end


	handle_errors: BOOLEAN
			-- <Precursor>
		local
			l_printer: XS_ERROR_PRINTER
		do
			Result := True
			create l_printer.default_create
			if error_manager.has_warnings then
				error_manager.trace_warnings (l_printer)
			end

			if not error_manager.is_successful then
				error_manager.trace_errors (l_printer)
				Result := False
			end
		end


feature -- From EIFFEL_ENV

	application_name: STRING = "xebra"

	check_xebra_environment_variable: BOOLEAN
			-- Check if needed environment variables are set up.
			-- Returns false if a var is missing.
		local
			l_product_names: PRODUCT_NAMES
			l_op_env: like operating_environment
			l_file: RAW_FILE
			l_dir: DIRECTORY
			l_dir_name: DIRECTORY_NAME
			l_value: detachable STRING_8
			l_variables: like required_environment_variables
			l_variable: TUPLE [var: STRING_8; is_directory: BOOLEAN]
			l_is_valid: like is_valid_environment
		do
			Result := True
			create l_variables.make (2)
			l_op_env := operating_environment
			l_variables.extend ([{XU_CONSTANTS}.Xebra_root_env, True])
			l_variables.extend ([{XU_CONSTANTS}.Xebra_library_env, True])

			from l_variables.start until l_variables.after loop
				l_variable := l_variables.item
				l_value := get_environment (l_variable.var)

				if
					l_value /= Void and then l_value.item (l_value.count) = l_op_env.directory_separator and then
					({PLATFORM}.is_windows or else not (l_value.is_equal ("/") or l_value.is_equal ("~/")))
				then
						-- Remove trailing directory separator
					l_value.prune_all_trailing (l_op_env.directory_separator)
				end

				if l_value = Void or else l_value.is_empty then
					o.eprint ("The registry key or environment variable " + l_variable.var + " has not been set!", generating_type)
					Result := False
				else
						-- Set the environment variable, as it may have come from the Windows registry.
					set_environment (l_value, l_variable.var)
				end
				l_variables.forth
			end
		end

invariant
		modules_attached: modules /= Void
end

