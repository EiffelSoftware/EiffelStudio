note
	description: "[
		A deferred class for actions that the server can perform on webapps
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XS_WEBAPP_ACTION

inherit
	XS_SHARED_SERVER_OUTPUTTER
	XS_SHARED_SERVER_CONFIG

feature {NONE} -- Initialization

	make (a_webapp: XS_WEBAPP)
			-- Initialization for `Current'.
		require
			a_webapp_attached: a_webapp /= Void
		do
			webapp := a_webapp
		ensure
			a_webapp_set: equal (a_webapp, webapp)
		end

feature -- Access

	webapp: XS_WEBAPP
		-- The webapp

	is_running: BOOLEAN
		-- True if the action has to wait e.g. for a process to terminate

	is_running_recursive: BOOLEAN
			-- True if internal_is_running is true and
			-- if the next action (recursively) is still running
		do
			if attached next_action then
				Result := is_running or next_action.is_running_recursive
			else
				Result := is_running
			end
		end

	next_action: detachable XS_WEBAPP_ACTION
		-- Is executed after the action has executed

feature -- Paths

	app_dir: FILE_NAME
			-- The directory to the application
		do
			Result := config.file.webapps_root_filename.twin
			Result.extend (webapp.app_config.name.out)
			end

	run_workdir : FILE_NAME
			-- The working directory to execute the application X_CODE
		do
			Result := app_dir.twin
			Result.extend ("EIFGENs")
			Result.extend (webapp.app_config.name.out)
			if config.file.finalize_webapps.value then
				Result.extend ("F_code")
			else
				Result.extend ("W_code")
			end
		end

	webapp_melted_file_path: FILE_NAME
			-- Returns the path to the melted file
		do
			if config.file.finalize_webapps.value then
				Result := webapp_exe
			else
				Result := run_workdir.twin
				Result.set_file_name (webapp.app_config.name.out + ".melted")
			end
		ensure
			Result_attached: Result /= Void
		end

	webapp_exe: FILE_NAME
			-- Returns the path to the exe of the webapp
		do
			Result := run_workdir.twin
			if {PLATFORM}.is_windows then
				Result.set_file_name (webapp.app_config.name.out + ".exe")
			else
				Result.set_file_name (webapp.app_config.name.out)
			end
		ensure
			Result_attached: Result /= Void
		end

feature -- Operations

--	config_outputter
--			-- Has to be called in every new thread (?), also in every process_exit_handler...
--		do
--			o.set_name ({XS_MAIN_SERVER}.name)
--			o.set_debug_level (args.debug_level)
--		end

	execute: XC_COMMAND_RESPONSE
			-- Executes the action if necessary and stops the stop_action if attached.
			-- Returns a
		do
			if is_necessary then
				Result := internal_execute
			else
				Result := next_action.execute
			end
		ensure
			Result_attached: Result /= Void
		end

feature  -- Status report internal

	is_necessary: BOOLEAN
			-- Tests if the action is necessairy
		deferred
		end



feature -- Status setting

--	set_stop_action (a_action: XS_WEBAPP_ACTION)
--			-- Sets a stop action
--		do
--			stop_action := a_action
--		ensure
--			action_set: stop_action = a_action
--		end

	set_next_action (a_action: XS_WEBAPP_ACTION)
			-- Setts a next action
		do
			next_action := a_action
		ensure
			action_set: next_action = a_action
		end

	stop
			-- Stops the action
		deferred
		ensure
			not_running: is_running = False
		end



feature {NONE} -- Implementation

	internal_execute: XC_COMMAND_RESPONSE
			-- The actual implementation of an action
		deferred
		ensure
			Result_attached: Result /= Void
		end

	can_launch_process (a_exe: FILE_NAME; a_dir: FILE_NAME): BOOLEAN
			-- Tests if the files and dirs exist
		local
			l_f_utils: XU_FILE_UTILITIES
		do
			Result := True
			create l_f_utils.make

			if not l_f_utils.is_dir (a_dir) then
				o.eprint ("Invalid directory for launching process: '" + a_dir + "'", generating_type)
				Result := False
			end

			if not l_f_utils.is_executable_file (a_exe) then
				o.eprint ("File does not exist for launching process: '" + a_exe + "'", generating_type)
				Result := False
			end
		end


	launch_process (a_exe: FILE_NAME;
					 a_args: STRING;
					 a_dir: FILE_NAME;
					 a_exit_handler: PROCEDURE [XS_WEBAPP_ACTION, detachable TUPLE];
					 a_output_handler: PROCEDURE [ANY, detachable TUPLE [detachable STRING]];
					 a_error_output_handler: PROCEDURE [ANY, detachable TUPLE [detachable STRING]]): detachable PROCESS
			-- Launches a process
		local
			l_process_factory: PROCESS_FACTORY
		do
			if can_launch_process (a_exe, a_dir) then
				create l_process_factory
				Result  := l_process_factory.process_launcher_with_command_line (a_exe + " " + a_args, a_dir)
				Result.set_on_exit_handler (a_exit_handler)
				Result.redirect_output_to_agent (a_output_handler)
				Result.redirect_error_to_agent (a_error_output_handler)
				o.dprint("Launching new process '" + a_exe + " " + a_args + "' in '" + a_dir + "'", 3)
				Result.launch
			end
		end

invariant
	webapp_attached: webapp /= Void
end

