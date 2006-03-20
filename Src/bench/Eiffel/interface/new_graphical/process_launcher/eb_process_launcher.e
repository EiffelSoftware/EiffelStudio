indexing
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

	EB_SHARED_FLAGS

	SHARED_PLATFORM_CONSTANTS

	SHARED_EXEC_ENVIRONMENT

	EB_SHARED_PREFERENCES

feature -- Launching parameters setting

	prepare_command_line (cmd: STRING; args: LIST [STRING]; a_working_directory: STRING) is
			--
		require
			process_not_in_action: (not launched) or (launched and has_exited)
			cmd_not_void: cmd /= Void
			cmd_not_empty: not cmd.is_empty
			a_working_dir_not_null: a_working_directory /= Void
		local
			s: STRING
		do
			create command_line.make_from_string (cmd)
			if a_working_directory = Void then
				working_directory := Void
			else
				create working_directory.make_from_string (a_working_directory)
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
					create s.make_from_string (args.item)
					arguments.extend (s)
					args.forth
				end
			end
		ensure
			command_line_set: command_line.is_equal (cmd)
			working_directory_set: (working_directory /= Void) implies working_directory.is_equal (a_working_directory)
			arguments_set:
				((args = Void) implies arguments = Void) or
				((args /= Void) implies arguments.count = args.count)
		end

	set_hidden (h: BOOLEAN) is
			-- Set `is_hidden' with `h'.
		do
			is_hidden := h
		ensure
			is_hidden_set: is_hidden = h
		end


	set_buffer_size (size: INTEGER) is
			-- Set buffer_size to `size'
		require
			process_not_in_action: (not launched) or (launched and has_exited)
			size_positive: size > 0
		do
			buffer_size := size
		ensure
			buffer_size_set: buffer_size = size
		end

	set_time_interval (itv: INTEGER) is
			-- Set time interval to `itv'
		require
			process_not_in_action: (not launched) or (launched and has_exited)
			interval_not_nagetive: itv > 0
		do
			time_interval := itv
		ensure
			time_interval_set: time_interval = itv
		end

	set_output_handler (handler: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Set the agent handler used when output from the child process arrives.
		require
			process_not_in_action: (not launched) or (launched and has_exited)
			output_handler_not_null: handler /= Void
		do
			output_handler := handler
		ensure
			output_handler_set: output_handler = handler
		end

	set_error_handler (handler: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Set the agent handler used when error from the child process arrives.
		require
			process_not_in_action: (not launched) or (launched and has_exited)
			error_handler_not_null: handler /= Void
		do
			error_handler := handler
		ensure
			error_handler_set: error_handler = handler
		end

	set_on_start_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process starts.
			-- if `handler' is Void, on_start_handler will be disabled
		require
			process_not_in_action: (not launched) or (launched and has_exited)
		do
			on_start_handler := handler
		ensure
			handler_set: on_start_handler = handler
		end

	set_on_fail_launch_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process launch failed.
			-- if `handler' is Void, on_launch_failed_handler will be disabled			
		require
			process_not_in_action: (not launched) or (launched and has_exited)
		do
			on_fail_launch_handler := handler
		ensure
			handler_set: on_fail_launch_handler = handler
		end

	set_on_successful_launch_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process launch successed.
			-- if `handler' is Void, on_launch_successed_handler will be disabled						
		require
			process_not_in_action: (not launched) or (launched and has_exited)
		do
			on_successful_launch_handler := handler
		ensure
			handler_set: on_successful_launch_handler = handler
		end

	set_on_exit_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process exits.
			-- if `handler' is Void, on_exit_handler will be disabled						
		require
			process_not_in_action: (not launched) or (launched and has_exited)
		do
			on_exit_handler := handler
		ensure
			handler_set: on_exit_handler = handler
		end

	set_on_terminate_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process has been terminated.
			-- if `handler' is Void, on_terminate_handler will be disabled									
		require
			process_not_in_action: (not launched) or (launched and has_exited)
		do
			on_terminate_handler := handler
		ensure
			handler_set: on_terminate_handler = handler
		end

feature -- Control

	launch (redirection_needed: BOOLEAN; use_argument: BOOLEAN) is
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
			ee: EXECUTION_ENVIRONMENT
			dir: STRING
			prc_imp: PROCESS_IMP
			pt: PROCESS_TIMER
		do
			create prc_ftry
			if use_argument then
				prc := prc_ftry.process_launcher (command_line, arguments, working_directory)
			else
				prc := prc_ftry.process_launcher_with_command_line (command_line, working_directory)
			end

			prc.redirect_input_to_stream
			prc_imp ?= prc
			if redirection_needed then
				prc.redirect_input_to_stream
				prc.redirect_output_to_agent (output_handler)
				prc.redirect_error_to_same_as_output
				if platform_constants.is_windows then
					prc.set_hidden (is_hidden)
					prc.set_separate_console (False)
				end
			else
				prc.cancel_error_redirection
				prc.cancel_input_redirection
				prc.cancel_output_redirection
				if platform_constants.is_windows then
					prc.set_hidden (False)
					prc.set_separate_console (True)
				end
			end

			if is_gui then
				pt := create {PROCESS_VISION2_TIMER}.make (time_interval)
			else
				pt := create {PROCESS_THREAD_TIMER}.make (time_interval)
			end
			prc.enable_terminal_control
			prc.set_timer (pt)
			prc.set_abort_termination_when_failed (False)
			prc.set_on_start_handler (on_start_handler)
			prc.set_on_exit_handler (on_exit_handler)
			prc.set_on_terminate_handler (on_terminate_handler)
			prc.set_on_fail_launch_handler (on_fail_launch_handler)
			prc.set_on_successful_launch_handler (on_successful_launch_handler)

			prc.set_buffer_size (buffer_size)

			ee := Void

			if not working_directory.is_empty then
				create ee
				dir := ee.current_working_directory
				ee.change_working_directory (working_directory)
			end
			prc.launch

			if ee /= Void then
				ee.change_working_directory (dir)
			end
		end

	wait_for_exit is
			-- Wait for process to exit.
		do
			if launched and not has_exited then
				prc.wait_for_exit
			end
		ensure
			process_has_exited: launched implies has_exited
		end

	put_string (s: STRING) is
			-- Sent a string to child process' input.
		require
			string_not_null: s /= Void
		do
			if prc.launched and not prc.has_exited then
				prc.put_string (s)
			end
		end

	terminate is
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

	open_console_in_dir (dir: STRING) is
			-- Open console in `dir'.
		require
			dir_not_void: dir /= VOid
		local
			cmdexe: STRING
			str: STRING
			cl: STRING
		do
			create cl.make (50)
			if platform_constants.is_windows then
				cmdexe := Execution_environment.get ("COMSPEC")
				if cmdexe /= Void then
						-- This allows the use of `dir' etc.
					cl.append (cmdexe)
				else
					cl.append (preferences.misc_data.console_shell_command)
				end
			else
				cl.append (once "/bin/sh -c ")
				cl.append (preferences.misc_data.console_shell_command)
			end
			str := execution_environment.current_working_directory
			execution_environment.change_working_directory (dir)
			execution_environment.launch (cl)
			execution_environment.change_working_directory (str)
		end

feature -- Status reporting

	exit_code: INTEGER is
			-- Exit code of process
		require
			process_launched: launched
			process_has_exited: has_exited
		do
			Result := prc.exit_code
		end

	launched: BOOLEAN is
			-- Has c compiler been launched?
		do
			if prc /= Void then
				Result := prc.launched
			else
				Result := False
			end
		end

	has_exited: BOOLEAN is
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

	is_running: BOOLEAN is
			-- Is process running?
		do
			Result := launched and then (not has_exited)
		end

	force_terminated: BOOLEAN is
			-- Is child process terminated by user?
		do
			if prc /= Void then
				Result := prc.force_terminated
			else
				Result := False
			end
		end

	output_handler: PROCEDURE [ANY, TUPLE [STRING]]
	error_handler:	PROCEDURE [ANY, TUPLE [STRING]]
			-- Handlers of output or error from process	

	command_line: STRING
			-- Command line (with arguments) of child process

	arguments: ARRAYED_LIST [STRING]
			-- Arguments for process

	working_directory: STRING
			-- Working directory of child process.

	time_interval: INTEGER
			-- Time interval for a timer to check the status of child process
	buffer_size: INTEGER
			-- Internal buffer size used to get output and error from child process

feature{NONE} -- Process data storage

	data_storage: EB_PROCESS_IO_STORAGE is
			-- Data storage used to store output and error that come from the launched process
		deferred
		end

feature {NONE} -- Implementation

	prc: PROCESS
			-- Process launcher implementation class

	is_hidden: BOOLEAN
			-- Should process be launched hidden?

	on_start_handler: ROUTINE [ANY, TUPLE]
	on_exit_handler: ROUTINE [ANY, TUPLE]
	on_terminate_handler: ROUTINE [ANY, TUPLE]
	on_fail_launch_handler: ROUTINE [ANY, TUPLE]
	on_successful_launch_handler: ROUTINE [ANY, TUPLE]
			-- Different agent handlers

	initial_time_interval: INTEGER is 100
	initial_buffer_size: INTEGER is 128

	child_termination_timeout: INTEGER is 5000
			-- Time in milliseconds to wait when terminating child process

invariant
	data_storage_not_void: data_storage /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
