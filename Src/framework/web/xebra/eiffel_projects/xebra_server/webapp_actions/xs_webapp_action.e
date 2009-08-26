note
	description: "[
		A deferred class for actions that the server can perform on webapps.
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

feature -- Access

	last_response: XC_COMMAND_RESPONSE
			-- The last response
		do
			if attached internal_last_response as l_response then
				Result := l_response
			else
				create {XCCR_NO_RESPONSE} Result
			end
		end

	webapp: detachable XS_WEBAPP assign set_webapp
			-- The webapp
		note
			option: stable attribute
		end

	is_running: BOOLEAN
		-- True if the action is currently running

	is_running_recursive: BOOLEAN
			-- True if is_running is true or
			-- if the next action (recursively) is running
		do
			if attached next_action as l_na then
				Result := is_running or l_na.is_running_recursive
			else
				Result := is_running
			end
		ensure
			Is_running: Result implies is_running
		end

	next_action: detachable XS_WEBAPP_ACTION assign set_next_action
		-- Is executed after the action has executed (if not void)

feature -- Paths

	app_dir: DIRECTORY_NAME
			-- The directory to the application
		require
			webapp_attached: webapp /= Void
		local
			l_string: STRING
			l_i: INTEGER
		do
			if attached webapp as l_wa then
				l_string := l_wa.app_config.ecf.out
				l_string.replace_substring_all ("\" ,"/")
				if attached {ARRAYED_LIST [ANY]} l_string.split ('/') as l_ist then
					from
						l_i := 2
						l_string := l_ist.i_th (1).out
					until
						l_i >= l_ist.count
					loop
						l_string := l_string + "/" + l_ist.i_th (l_i).out
						l_i := l_i + 1
					end
				end
				if {PLATFORM}.is_windows then
					l_string.replace_substring_all ("/" ,"\")
				end
				create Result.make_from_string (l_string)
			else
				create Result.make
			end
		ensure
			Result_attached: Result /= Void
		end

	run_workdir : DIRECTORY_NAME
			-- The working directory to execute the application X_CODE
		require
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_wa then
				Result := app_dir.twin
				Result.extend ({XU_CONSTANTS}.Dir_eifgen)
				Result.extend (l_wa.app_config.name.out)
				if config.file.finalize_webapps.value then
					Result.extend ({XU_CONSTANTS}.Dir_f_code)
				else
					Result.extend ({XU_CONSTANTS}.Dir_w_code)
				end
			else
				create Result.make
			end
		ensure
			Result_attached: Result /= Void
		end

	webapp_melted_file: FILE_NAME
			-- Returns the path to the melted file
		require
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_wa then
				if config.file.finalize_webapps.value then
					Result := webapp_exe_file
				else
					create Result.make_from_string (run_workdir.string)
					Result.set_file_name (l_wa.app_config.name.out + {XU_CONSTANTS}.Extension_melted)
				end
			else
				create Result.make
			end
		ensure
			Result_attached: Result /= Void
		end

	webapp_exe_file: FILE_NAME
			-- Returns the path to the exe of the webapp
		require
			webapp_attached: webapp /= Void
		do
			if attached webapp as l_wa then
				create Result.make_from_string (run_workdir.string)
				if {PLATFORM}.is_windows then
					Result.set_file_name (l_wa.app_config.name.out + {XU_CONSTANTS}.Extension_win_exe)
				else
					Result.set_file_name (l_wa.app_config.name.out)
				end
			else
				create Result.make
			end
		ensure
			Result_attached: Result /= Void
		end

	servlet_gen_dir: DIRECTORY_NAME
			-- The path to the servlet_gen
		do
			Result := app_dir.twin
			Result.extend ({XU_CONSTANTS}.generated_folder_name)
			Result.extend ({XU_CONSTANTS}.servlet_gen_name)
		ensure
			Result_attached: Result /= void
		end

	servlet_gen_exe_file: FILE_NAME
			-- The path to the servlet_gen executable
		do
			create Result.make_from_string (servlet_gen_dir.string)
			Result.extend ({XU_CONSTANTS}.Dir_eifgen)
			Result.extend ({XU_CONSTANTS}.servlet_gen_name)
			Result.extend ({XU_CONSTANTS}.Dir_w_code)
			if {PLATFORM}.is_windows then
				Result.set_file_name ({XU_CONSTANTS}.servlet_gen_name + {XU_CONSTANTS}.Extension_win_exe)
			else
				Result.set_file_name ({XU_CONSTANTS}.servlet_gen_name)
			end

		ensure
			Result_attached: Result /= void
		end

	servlet_gen_melted_file: FILE_NAME
		-- The path to the servlet_gen melted file
		do
			create Result.make_from_string (servlet_gen_dir.string)
			Result.extend ({XU_CONSTANTS}.Dir_eifgen)
			Result.extend ({XU_CONSTANTS}.servlet_gen_name)
			Result.extend ({XU_CONSTANTS}.Dir_w_code)

			Result.set_file_name ({XU_CONSTANTS}.servlet_gen_name + {XU_CONSTANTS}.Extension_melted)
		ensure
			Result_attached: Result /= void
		end

	servlet_gen_ecf_file: FILE_NAME
			-- The path to the servlet_gen executable
		do
			create Result.make_from_string (servlet_gen_dir.string)
			Result.set_file_name ({XU_CONSTANTS}.servlet_gen_name + {XU_CONSTANTS}.Extension_ecf)
		ensure
			Result_attached: Result /= void
		end

	servlet_gen_executed_file: FILE_NAME
				-- The path to the servlet_gen executed_at_time-file
		do
			create Result.make_from_string (app_dir.string)
			Result.extend ({XU_CONSTANTS}.Generated_folder_name)
			Result.set_file_name ({XU_CONSTANTS}.Servlet_gen_executed_file)
		ensure
			Result_attached: Result /= void
		end

feature -- Operations

	execute
			-- Executes the action if necessary or else executes the next action
		do
			if is_necessary then
				internal_execute
			else
				execute_next_action
			end
		ensure
			internal_last_response_attached: internal_last_response /= Void
		end

	execute_next_action
			--	Executes the next action if attached
		do
			if attached next_action as l_action then
				l_action.execute
				internal_last_response := l_action.last_response
			else
				internal_last_response := create {XCCR_INTERNAL_SERVER_ERROR}
			end
		ensure
			internal_last_response_attached: internal_last_response /= Void
		end

feature {NONE}  -- Status report internal

	is_necessary: BOOLEAN
			-- Tests if the action is necessairy
		deferred
		end

feature -- Status setting

	set_webapp (a_webapp: XS_WEBAPP)
			-- Setts webapp.
		require
			a_webapp_attached: a_webapp /= Void
		do
			webapp := a_webapp
		ensure
			webapp_set: webapp = a_webapp
		end

	set_next_action (a_action: like next_action)
			-- Setts a next action.
		require
			a_action_attached: a_action /= Void
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

feature {TEST_WEBAPPS} -- Implementation

	internal_execute
			-- The actual implementation of an action
		deferred
		ensure
			internal_last_response_attached: internal_last_response /= Void
		end

feature {NONE} -- Implementation

	internal_last_response: detachable XC_COMMAND_RESPONSE

	can_launch_process (a_exe: FILE_NAME; a_dir: DIRECTORY_NAME): BOOLEAN
			-- Tests if a_exe and a_dirs exist
		require
			a_exe_attached: a_exe /= Void
			a_dir_attached: a_dir /= Void
		local
			l_f_utils: XU_FILE_UTILITIES
		do
			Result := True
			create l_f_utils

			if not l_f_utils.is_dir (a_dir) then
				log.eprint ("Invalid directory for launching process: '" + a_dir + "'", generating_type)
				Result := False
			end

			if not l_f_utils.is_executable_file (a_exe) then
				log.eprint ("File does not exist for launching process: '" + a_exe + "'", generating_type)
				Result := False
			end
		end


	launch_process (a_exe: FILE_NAME;
					 a_args: STRING;
					 a_dir: DIRECTORY_NAME;
					 a_exit_handler: ROUTINE [ANY, TUPLE];
					 a_output_handler: PROCEDURE [ANY, TUPLE [STRING]];
					 a_error_output_handler: PROCEDURE [ANY, TUPLE [STRING]]): detachable PROCESS
			-- Launches a process.
			--
			-- `a_exe': The file to execute
			-- `a_args': The arguments to run the exe
			-- `a_dir': The working directory
			-- `a_exit_handler': A routine that is executed when the process ends
			-- `a_output_handler': A routine that handles output from the process
			-- `a_error_output_handler': A routine that handles error output from the process		
		require
			a_exe_attached: a_exe /= Void
			a_args_attached: a_args /= Void
			a_dir_attached: a_dir /= Void
			a_exit_handler_attached: a_exit_handler /= Void
			a_output_handler_attached: a_output_handler /= Void
			a_error_output_handler_attached: a_error_output_handler /= Void
		local
			l_process_factory: PROCESS_FACTORY
		do
			if can_launch_process (a_exe, a_dir) then
				create l_process_factory
				Result  := l_process_factory.process_launcher_with_command_line (a_exe + " " + a_args, a_dir)
				Result.set_on_exit_handler (a_exit_handler)
				Result.redirect_output_to_agent (a_output_handler)
				Result.redirect_error_to_agent (a_error_output_handler)
				log.dprint("Launching new process '" + a_exe + " " + a_args + "' in '" + a_dir + "'", log.debug_subtasks)
				Result.launch
			end
		end
end

