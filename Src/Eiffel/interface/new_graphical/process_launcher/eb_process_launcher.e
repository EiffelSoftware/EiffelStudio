note
	description:
		"[
			Process launcher used in EiffelStudio.
			It will redirect the input of the process to a stream of its parent process and
			and output and error of the child process to two agents.
		 ]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_PROCESS_LAUNCHER

inherit
	EB_SHARED_MANAGERS

	SHARED_FLAGS

	SHARED_EXECUTION_ENVIRONMENT

	EB_SHARED_PREFERENCES

feature -- Launching parameters setting

	prepare_command_line (cmd: STRING_32; args: LIST [READABLE_STRING_GENERAL]; a_working_directory: PATH)
			-- Prepare command line for process launching.
			-- `cmd' is the process command to launch, `args' are possible arguments and
			-- `a_working_directory' is the path where process will be launched.
		require
			process_not_in_action: (not launched) or (launched and has_exited)
			cmd_not_void: cmd /= Void
			cmd_not_empty: not cmd.is_empty
			a_working_dir_not_null: a_working_directory /= Void
		do
			create command_line.make_from_string (cmd)
			if a_working_directory = Void then
				working_directory := Void
			else
				working_directory := a_working_directory
			end

			if args = Void then
				arguments := Void
			else
				create arguments.make (args.count)
				from
					args.start
				until
					args.after
				loop
					arguments.extend (args.item.twin) -- Probably safer to twin
					args.forth
				end
			end
		ensure
			command_line_set: command_line.same_string (cmd)
			working_directory_set: (working_directory /= Void) implies working_directory.same_as (a_working_directory)
			arguments_set:
				((args = Void) implies arguments = Void) or
				((args /= Void) implies arguments.count = args.count)
		end

	set_hidden (h: BOOLEAN)
			-- Set `is_hidden' with `h'.
		do
			is_hidden := h
		ensure
			is_hidden_set: is_hidden = h
		end

	set_buffer_size (size: INTEGER)
			-- Set buffer_size to `size'
		require
			process_not_in_action: (not launched) or (launched and has_exited)
			size_positive: size > 0
		do
			buffer_size := size
		ensure
			buffer_size_set: buffer_size = size
		end

	set_time_interval (itv: INTEGER)
			-- Set time interval to `itv'
		require
			process_not_in_action: (not launched) or (launched and has_exited)
			interval_not_nagetive: itv > 0
		do
			time_interval := itv
		ensure
			time_interval_set: time_interval = itv
		end

	set_output_handler (handler: PROCEDURE [STRING])
			-- Set the agent handler used when output from the child process arrives.
		require
			process_not_in_action: (not launched) or (launched and has_exited)
			output_handler_not_null: handler /= Void
		do
			output_handler := handler
		ensure
			output_handler_set: output_handler = handler
		end

	set_error_handler (handler: PROCEDURE [STRING])
			-- Set the agent handler used when error from the child process arrives.
		require
			process_not_in_action: (not launched) or (launched and has_exited)
			error_handler_not_null: handler /= Void
		do
			error_handler := handler
		ensure
			error_handler_set: error_handler = handler
		end

	set_on_start_handler (handler: ROUTINE)
			-- Set a `handler' which will be called when process starts.
			-- if `handler' is Void, on_start_handler will be disabled
		require
			process_not_in_action: (not launched) or (launched and has_exited)
		do
			on_start_handler := handler
		ensure
			handler_set: on_start_handler = handler
		end

	set_on_fail_launch_handler (handler: ROUTINE)
			-- Set a `handler' which will be called when process launch failed.
			-- if `handler' is Void, on_launch_failed_handler will be disabled			
		require
			process_not_in_action: (not launched) or (launched and has_exited)
		do
			on_fail_launch_handler := handler
		ensure
			handler_set: on_fail_launch_handler = handler
		end

	set_on_successful_launch_handler (handler: ROUTINE)
			-- Set a `handler' which will be called when process launch successed.
			-- if `handler' is Void, on_launch_successed_handler will be disabled						
		require
			process_not_in_action: (not launched) or (launched and has_exited)
		do
			on_successful_launch_handler := handler
		ensure
			handler_set: on_successful_launch_handler = handler
		end

	set_on_exit_handler (handler: ROUTINE)
			-- Set a `handler' which will be called when process exits.
			-- if `handler' is Void, on_exit_handler will be disabled						
		require
			process_not_in_action: (not launched) or (launched and has_exited)
		do
			on_exit_handler := handler
		ensure
			handler_set: on_exit_handler = handler
		end

	set_on_terminate_handler (handler: ROUTINE)
			-- Set a `handler' which will be called when process has been terminated.
			-- if `handler' is Void, on_terminate_handler will be disabled									
		require
			process_not_in_action: (not launched) or (launched and has_exited)
		do
			on_terminate_handler := handler
		ensure
			handler_set: on_terminate_handler = handler
		end

feature -- Actions

	start_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be invoked when process launch starts
			-- These actions are called before the process launch, and then
			-- after launch, either `launchd_actions' or `launch_failed_actions' will be called.
		do
			if start_actions_internal = Void then
				create start_actions_internal
			end
			Result := start_actions_internal
		ensure
			result_attached: Result /= Void
		end

	launched_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be invoked when process is launched successfully
		do
			if launched_actions_internal = Void then
				create launched_actions_internal
			end
			Result := launched_actions_internal
		ensure
			result_attached: Result /= Void
		end

	launch_failed_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be invoked when process launch is failed
		do
			if launch_failed_actions_internal = Void then
				create launch_failed_actions_internal
			end
			Result := launch_failed_actions_internal
		ensure
			result_attached: Result /= Void
		end

	terminated_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be invoked when process is terminated by user
		do
			if terminated_actions_internal = Void then
				create terminated_actions_internal
			end
			Result := terminated_actions_internal
		ensure
			result_attached: Result /= Void
		end

	exited_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be invoked when process is exited by itself
		do
			if exited_actions_internal = Void then
				create exited_actions_internal
			end
			Result := exited_actions_internal
		ensure
			result_attached: Result /= Void
		end

	finished_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be invoked when process is finished (either launch failed, terminated or exited)
		do
			if finished_actions_internal = Void then
				create finished_actions_internal
			end
			Result := finished_actions_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Control

	launch (redirection_needed: BOOLEAN; use_argument: BOOLEAN)
			-- Launch process.
			-- If `redirection_needed', redirect input, output and error of process.
		require
			output_handler_set: output_handler /= Void
			command_line_not_null: command_line /= Void
			command_line_not_empty: not command_line.is_empty
			working_dir_not_null: working_directory /= Void
			time_interval_positive: time_interval > 0
			buffer_size_positive: buffer_size > 0
		local
			prc_ftry: PROCESS_FACTORY
			pt: PROCESS_TIMER
		do
			create prc_ftry
			if use_argument then
				prc := prc_ftry.process_launcher (command_line, arguments, working_directory.name)
			else
				prc := prc_ftry.process_launcher_with_command_line (command_line, working_directory.name)
			end

			prc.redirect_input_to_stream
			if redirection_needed then
				prc.redirect_input_to_stream
				prc.redirect_output_to_agent (output_handler)
				prc.redirect_error_to_same_as_output
				if {PLATFORM}.is_windows then
					prc.set_hidden (is_hidden)
					prc.set_separate_console (False)
				end
			else
				prc.cancel_error_redirection
				prc.cancel_input_redirection
				prc.cancel_output_redirection
				if {PLATFORM}.is_windows then
					prc.set_hidden (False)
					prc.set_separate_console (True)
				end
			end

			if is_gui then
				pt := create {PROCESS_VISION2_TIMER}.make (time_interval)
			else
				pt := create {PROCESS_THREAD_TIMER}.make (time_interval)
			end
			prc.enable_launch_in_new_process_group
			prc.set_timer (pt)
			prc.set_abort_termination_when_failed (False)
			prc.set_on_start_handler (on_start_handler)
			prc.set_on_exit_handler (on_exit_handler)
			prc.set_on_terminate_handler (on_terminate_handler)
			prc.set_on_fail_launch_handler (on_fail_launch_handler)
			prc.set_on_successful_launch_handler (on_successful_launch_handler)

			prc.set_buffer_size (buffer_size)

			data_storage.wipe_out
			prc.launch
		end

	wait_for_exit
			-- Wait for process to exit.
		do
			if launched and not has_exited then
				prc.wait_for_exit
			end
		ensure
			process_has_exited: launched implies has_exited
		end

	put_string (s: STRING)
			-- Sent a string to child process' input.
		require
			string_not_null: s /= Void
		do
			if prc.launched and not prc.has_exited then
				prc.put_string (s)
			end
		end

	terminate
			-- Terminate C compilation.
		do
			if is_running then
				prc.terminate_tree
				check
					prc.last_termination_successful
				end
				prc.wait_for_exit
			end
		end

feature -- Unmanaged process launch

	open_console_in_dir (dir: PATH)
			-- Open console in `dir'.
		require
			dir_not_void: dir /= Void
		local
			cmdexe: detachable STRING_32
			cl: STRING_32
			console_shell: STRING
			l_old_path: PATH
		do
			create cl.make (50)
			console_shell := preferences.misc_data.console_shell_command
			if console_shell /= Void then
				cl.append (console_shell)
			end
			if cl.is_empty then
				if {PLATFORM}.is_windows then
					cmdexe := Execution_environment.item ("COMSPEC")
					if cmdexe /= Void then
							-- This allows the use of `dir' etc.
						cl.append (cmdexe)
					else
						cl.append ({STRING_32} "CMD")
					end
				else
					cl.append (once {STRING_32} "/bin/sh -c xterm -geometry 80x40")
				end
			end

			l_old_path := execution_environment.current_working_path
			execution_environment.change_working_path (dir)
			execution_environment.launch (cl)
			execution_environment.change_working_path (l_old_path)
		end

	open_file_in_file_browser (a_full_path: READABLE_STRING_GENERAL)
			-- Open directory `a_full_path' in file browser and select the file
		require
			dir_attached: a_full_path /= Void
		local
			l_cmd: STRING_32
			l_platform: PLATFORM
			l_path: STRING_32
			l_index: INTEGER
		do
			l_cmd := preferences.misc_data.file_browser_command.twin.as_string_32
			if l_cmd /= Void then
				l_path := a_full_path.twin.as_string_32

				create l_platform
				if l_platform.is_windows then
					-- We add argument to select file
					l_path	:= {STRING_32} "/select,%"" + l_path + {STRING_32} "%""
				elseif l_platform.is_unix then
					-- "nautilus" don't accept last file name, we removed it here
					-- We should find a way to select file in "nautilus" file browser like Windows explorer does
					l_index := l_path.last_index_of ('/', l_path.count)
					l_path.remove_substring (l_index, l_path.count)
				end

				l_cmd.replace_substring_all ({STRING_32} "$target", l_path)
				execution_environment.launch (l_cmd)
			end
		end

	open_dir_in_file_browser (dir: PATH)
			-- Open directory `dir' in file browser.
		require
			dir_attached: dir /= Void
		local
			l_cmd: STRING_32
			l_target: STRING_32
		do
			l_cmd := preferences.misc_data.file_browser_command
			if l_cmd /= Void then
				create l_target.make (2 + dir.name.count)
				l_target.append_character ('%"')
				l_target.append_string_general (dir.name)
				l_target.append_character ('%"')
				l_cmd := l_cmd.twin
				l_cmd.replace_substring_all ("$target", l_target)
				execution_environment.launch (l_cmd)
			end
		end

	open_url_in_web_browser (a_url: STRING_32)
			-- Open directory `a_url' in web browser.
		require
			not_void: a_url /= Void
		local
			l_cmd: STRING_32
		do
			l_cmd := preferences.misc_data.web_browser_command.twin
			if l_cmd /= Void then
				l_cmd.replace_substring_all ({STRING_32} "$url", a_url)
				execution_environment.launch (l_cmd)
			end
		end

feature -- Status reporting

	exit_code: INTEGER
			-- Exit code of process
		require
			process_launched: launched
			process_has_exited: has_exited
		do
			Result := prc.exit_code
		end

	launched: BOOLEAN
			-- Has c compiler been launched?
		do
			if prc /= Void then
				Result := prc.launched
			else
				Result := False
			end
		end

	has_exited: BOOLEAN
			-- Has c compiler exited?
		do
			if prc /= Void then
				if not prc.launched then
					Result := True
				else
					Result := prc.has_exited
				end
			else
				Result := True
			end
		end

	is_running: BOOLEAN
			-- Is process running?
		do
			Result := launched and then (not has_exited)
		end

	force_terminated: BOOLEAN
			-- Is child process terminated by user?
		do
			if prc /= Void then
				Result := prc.force_terminated
			else
				Result := False
			end
		end

	output_handler: PROCEDURE [STRING]
	error_handler:	PROCEDURE [STRING]
			-- Handlers of output or error from process	

	command_line: STRING_32
			-- Command line (with arguments) of child process

	arguments: ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Arguments for process

	working_directory: PATH
			-- Working directory of child process.

	time_interval: INTEGER
			-- Time interval for a timer to check the status of child process
	buffer_size: INTEGER
			-- Internal buffer size used to get output and error from child process

feature{NONE} -- Process data storage

	data_storage: separate EB_PROCESS_IO_STORAGE
			-- Data storage used to store output and error that come from the launched process
		deferred
		end

feature {NONE} -- Implementation

	prc: PROCESS
			-- Process launcher implementation class

	is_hidden: BOOLEAN
			-- Should process be launched hidden?

	on_start_handler: ROUTINE
	on_exit_handler: ROUTINE
	on_terminate_handler: ROUTINE
	on_fail_launch_handler: ROUTINE
	on_successful_launch_handler: ROUTINE
			-- Different agent handlers

	initial_time_interval: INTEGER = 250
	initial_buffer_size: INTEGER = 4096

	child_termination_timeout: INTEGER = 5000
			-- Time in milliseconds to wait when terminating child process

feature{NONE} -- Implementation

	start_actions_internal: like start_actions
			-- Implementation of `start_actions'

	launched_actions_internal: like launched_actions
			-- Implementation of `launched_actions'

	launch_failed_actions_internal: like launch_failed_actions
			-- Implementation of `launch_failed_actions'

	terminated_actions_internal: like terminated_actions
			-- Implementation of `terminated_actions'

	exited_actions_internal: like exited_actions
			-- Implementation of `exited_actions'

	finished_actions_internal: like finished_actions
			-- Implementation of `finished_actions'


invariant
	data_storage_not_void: data_storage /= Void

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
