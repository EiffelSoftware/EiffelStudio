note
	description: "[
		A deferred class for actions that the server can perform on webapps.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XS_WEBAPP_ACTION

inherit
	XS_SHARED_SERVER_OUTPUTTER

	XS_SHARED_SERVER_CONFIG

feature -- Access

	webapp: detachable XS_WEBAPP assign set_webapp
			-- The webapp
		note
			option: stable attribute
		end

	is_running: BOOLEAN
		-- True if the action is currently running

	next_action: detachable XS_WEBAPP_ACTION assign set_next_action
			-- Is executed after the action has executed (if not void)
		note
			option: stable attribute
		end

feature -- Status Report

	last_response: XC_COMMAND_RESPONSE
			-- The last response
		do
			if attached internal_last_response as l_response then
				Result := l_response
			else
				create {XCCR_NO_RESPONSE} Result
			end
		end

	is_running_recursive: BOOLEAN
			-- True if is_running is true or
			-- if the next action (recursively) is running
		do
			Result := is_running or else attached next_action as a and then a.is_running_recursive
		ensure
			Is_running: Result implies is_running
		end

feature -- Paths

	app_dir: DIRECTORY_NAME
			-- The directory to the application
		require
			webapp_attached: webapp /= Void
		local
			l_string: STRING
			i: INTEGER
		do
			if attached internal_app_dir as l_app_dir then
				Result := l_app_dir
			else
				if attached webapp as l_webapp then
					l_string := l_webapp.app_config.ecf.out
					l_string.replace_substring_all ("\" ,"/")
					i := l_string.last_index_of ('/', l_string.count)
					l_string := l_string.substring (1, i - 1)
					if {PLATFORM}.is_windows then
						l_string.replace_substring_all ("/" ,"\")
					end
					create Result.make_from_string (l_string)
				else
					create Result.make
				end
				internal_app_dir := Result
			end
		ensure
			Result_attached: Result /= Void
			Result_consistent: internal_app_dir ~ Result
		end

	run_workdir : DIRECTORY_NAME
			-- The working directory to execute the application X_CODE
		require
			webapp_attached: webapp /= Void
		do
			if attached internal_run_workdir as l_run_workdir then
				Result := l_run_workdir
			else
				if attached webapp as l_webapp then
					Result := app_dir.twin
					Result.extend ({XU_CONSTANTS}.Dir_eifgen)
					Result.extend (l_webapp.app_config.name.out)
					if config.file.finalize_webapps.value then
						Result.extend ({XU_CONSTANTS}.Dir_f_code)
					else
						Result.extend ({XU_CONSTANTS}.Dir_w_code)
					end
				else
					create Result.make
				end
				internal_run_workdir := Result
			end
		ensure
			Result_attached: Result /= Void
			Result_consistent: internal_run_workdir ~ Result
		end

	webapp_melted_file: FILE_NAME
			-- Returns the path to the melted file
		require
			webapp_attached: webapp /= Void
		do
			if attached internal_webapp_melted_file as l_webapp_melted_file then
				Result := l_webapp_melted_file
			else
				if attached webapp as l_webapp then
					if config.file.finalize_webapps.value then
						Result := webapp_exe_file
					else
						create Result.make_from_string (run_workdir.string)
						Result.set_file_name (l_webapp.app_config.name.out + {XU_CONSTANTS}.Extension_melted)
					end
				else
					create Result.make
				end
				internal_webapp_melted_file := Result
			end
		ensure
			Result_attached: Result /= Void
			Result_consistent: internal_webapp_melted_file ~ Result
		end

	webapp_exe_file: FILE_NAME
			-- Returns the path to the exe of the webapp
		require
			webapp_attached: webapp /= Void
		local
			l_os: XU_OS
		do
			if attached internal_webapp_exe_file as l_webapp_exe_file then
				Result := l_webapp_exe_file
			else
				create l_os
				if attached webapp as l_webapp then
					create Result.make_from_string (run_workdir.string)
					Result.set_file_name (l_webapp.app_config.name.out + l_os.exe_extension)
				else
					create Result.make
				end
				internal_webapp_exe_file := Result
			end
		ensure
			Result_attached: Result /= Void
			Result_consistent: internal_webapp_exe_file ~ Result
		end

	servlet_gen_dir: DIRECTORY_NAME
			-- The path to the servlet_gen
		do
			if attached internal_servlet_gen_dir as l_servlet_gen_dir then
				Result := l_servlet_gen_dir
			else
				Result := app_dir.twin
				Result.extend ({XU_CONSTANTS}.generated_folder_name)
				Result.extend ({XU_CONSTANTS}.servlet_gen_name)
				internal_servlet_gen_dir := Result
			end
		ensure
			Result_attached: Result /= Void
			Result_consistent: internal_servlet_gen_dir ~ Result
		end

	servlet_gen_exe_file: FILE_NAME
			-- The path to the servlet_gen executable
		local
			l_os: XU_OS
		do
			if attached internal_servlet_gen_exe_file as l_servlet_gen_exe_file then
				Result := l_servlet_gen_exe_file
			else
				create l_os
				create Result.make_from_string (servlet_gen_dir.string)
				Result.extend ({XU_CONSTANTS}.Dir_eifgen)
				Result.extend ({XU_CONSTANTS}.servlet_gen_name)
				Result.extend ({XU_CONSTANTS}.Dir_w_code)
				Result.set_file_name ({XU_CONSTANTS}.servlet_gen_name + l_os.exe_extension)
				internal_servlet_gen_exe_file := Result
			end
		ensure
			Result_attached: Result /= Void
			Result_consistent: internal_servlet_gen_exe_file ~ Result
		end

	servlet_gen_melted_file: FILE_NAME
		-- The path to the servlet_gen melted file
		do
			if attached internal_servlet_gen_melted_file as l_servlet_gen_melted_file then
				Result := l_servlet_gen_melted_file
			else
				create Result.make_from_string (servlet_gen_dir.string)
				Result.extend ({XU_CONSTANTS}.Dir_eifgen)
				Result.extend ({XU_CONSTANTS}.servlet_gen_name)
				Result.extend ({XU_CONSTANTS}.Dir_w_code)

				Result.set_file_name ({XU_CONSTANTS}.servlet_gen_name + {XU_CONSTANTS}.Extension_melted)
				internal_servlet_gen_melted_file := Result
			end
		ensure
			Result_attached: Result /= Void
			Result_consistent: internal_servlet_gen_melted_file ~ Result
		end

	servlet_gen_ecf_file: FILE_NAME
			-- The path to the servlet_gen executable
		do
			if attached internal_servlet_gen_ecf_file as l_servlet_gen_ecf_file then
				Result := l_servlet_gen_ecf_file
			else
				create Result.make_from_string (servlet_gen_dir.string)
				Result.set_file_name ({XU_CONSTANTS}.servlet_gen_name + {XU_CONSTANTS}.Extension_ecf)
				internal_servlet_gen_ecf_file := Result
			end
		ensure
			Result_attached: Result /= Void
			Result_consistent: internal_servlet_gen_ecf_file ~ Result
		end

	servlet_gen_executed_file: FILE_NAME
				-- The path to the servlet_gen executed_at_time-file
		do
			if attached internal_servlet_gen_executed_file as l_servlet_gen_executed_file then
				Result := l_servlet_gen_executed_file
			else
				create Result.make_from_string (app_dir.string)
				Result.extend ({XU_CONSTANTS}.Generated_folder_name)
				Result.set_file_name ({XU_CONSTANTS}.Servlet_gen_executed_file)
					internal_servlet_gen_executed_file := Result
			end
		ensure
			Result_attached: Result /= Void
			Result_consistent: internal_servlet_gen_executed_file ~ Result
		end

feature {NONE} -- Internal Status Report

	action_name: STRING
			-- The name of the action as it appears in the status messages
		deferred
		end

	is_necessary: BOOLEAN
			-- Checks if the current action is necessary
		local
			l_out: STRING
		do
			if attached internal_is_execution_needed (true) as l_res then
				if attached {BOOLEAN} l_res[1] as l_boolean then
					Result := l_boolean
				end

				if attached {LIST [ANY]} l_res[2] as l_ist then
					if not l_ist.is_empty then
						l_out := action_name + " is necessary because: "
						from l_ist.start until l_ist.after loop
							l_out.append ("%N%T- " + l_ist.item_for_iteration.out)
							l_ist.forth
						end
						log.dprint (l_out, log.debug_subtasks)
					end
				end
			end
		end

	is_successful: BOOLEAN
			-- Checks if the current action was successful
		local
			l_out: STRING
		do
			if attached internal_is_execution_needed (false) as l_res then
				if attached {BOOLEAN} l_res[1] as l_boolean then
					Result := not l_boolean
				end
				if attached {LIST [ANY]} l_res[2] as l_ist then
					if not l_ist.is_empty then
						l_out := action_name + " failed because: "
						from l_ist.start until l_ist.after loop
							l_out.append ("%N%T- " + l_ist.item_for_iteration.out)
							l_ist.forth
						end
						log.eprint (l_out, generating_type)
					end
				end
			end
		end

	internal_is_execution_needed (a_with_cleaning: BOOLEAN): TUPLE [BOOLEAN, detachable LIST [XSWA_STATUS]]
			-- Returns a TUPLE of BOOLEAN and LIST of {XSWA_STATUS}.
			-- If the BOOLEAN is true, there execution of this action is needed, i.e. it IS necessary to execute the action or the action WAS NOT successful.
			-- The LIST is optional, each item describes a reason.
			--
			-- `a_with_cleaning': If set, it will also check for `needs_cleaning'
		deferred
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

feature {NONE} -- Internal Operations

	execute_next_action
			--	Executes the next action if attached
		require
			next_action_exists: next_action /= Void
		do
			if attached next_action as l_action then
				l_action.execute
				internal_last_response := l_action.last_response
			end
		ensure
			internal_last_response_attached: internal_last_response /= Void
		end

feature -- Status setting

	set_webapp (a_webapp: like webapp)
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

	set_running (a_running: BOOLEAN)
			-- Sets is_running
		require
			webapp_attached: webapp /= Void
		deferred
		ensure
			set: is_running ~ a_running
		end

	stop
			-- Stops the action
		deferred
		ensure
			not_running: is_running = False
		end

feature {NONE} -- Process output agents

	output_regular (a_string: STRING)
			-- Prints a_string to log.dprint
		do
			log.dprint_noformat(a_string, log.debug_subtasks)
		end

	output_error (a_string: STRING)
			-- Prints a_String to log.eprint
		do
			if not a_string.is_empty then
				log.eprint (a_string, generating_type)
			end
		end

feature {NONE} -- Internal Access

	internal_last_response: detachable XC_COMMAND_RESPONSE

		-- The following internal_ paths are use for once per object pattern
	internal_app_dir: detachable like app_dir
	internal_run_workdir: detachable like run_workdir
	internal_webapp_melted_file: detachable like webapp_melted_file
	internal_webapp_exe_file: detachable like webapp_exe_file
	internal_servlet_gen_exe_file: detachable like servlet_gen_exe_file
	internal_servlet_gen_dir: detachable like servlet_gen_dir
	internal_servlet_gen_melted_file: detachable like servlet_gen_melted_file
	internal_servlet_gen_ecf_file: detachable like servlet_gen_ecf_file
	internal_servlet_gen_executed_file: detachable like servlet_gen_executed_file

feature {NONE} -- Implementation

	internal_execute
			-- The actual implementation of an action
		deferred
		ensure
			internal_last_response_attached: internal_last_response /= Void
		end

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
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

