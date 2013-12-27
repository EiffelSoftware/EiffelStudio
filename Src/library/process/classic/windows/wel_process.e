note
	description: "Object that represents a launched process"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROCESS

inherit
	WEL_PROCESS_LAUNCHER
		rename
			launch as wel_launch
		export
			{ANY} process_info
		redefine
			startup_info
		end

create
	make

feature{NONE} -- Implementation

	make
			-- Initialize instance.
		do
			is_std_input_open := False
			is_std_output_open := False
			is_std_error_open := False

				--| In the original implementation, `input_file_name', `output_file_name' and `error_file_name'
				--| were initialized Void. Since nowhere in the process library it is checked if they are Void,
				--| they are now attached and by default attached (Arno 1/14/2009).
			input_file_name := ""
			output_file_name := ""
			error_file_name := ""

			input_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			output_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			error_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			internal_has_exited := True
		ensure
			std_input_not_open: not is_std_input_open
			std_output_not_open: not is_std_output_open
			std_error_not_open: not is_std_error_open
			input_file_name_set: input_file_name.is_empty
			output_file_name_set: output_file_name.is_empty
			error_file_name_set: error_file_name.is_empty
			no_input_redirection: input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			no_output_redirection: output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			no_error_redirection: error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			internal_has_exited: internal_has_exited
		end

feature -- Process operations

	launch (a_cmd: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL; has_separate_console: BOOLEAN; has_detached_console: BOOLEAN)
			-- Launch a process whose command is `a_cmd' in `a_working_directory'.
			-- If `has_separate_console' is True, launch process in a separate console.
			-- If `has_detached_console' is True, launch process without any console.
		require
			a_cmd_not_void: a_cmd /= Void
			a_cmd_not_empty: not a_cmd.is_empty
			not_launched: process_info = Void
			input_closed: not is_std_input_open
			output_closed: not is_std_output_open
			error_closed: not is_std_error_open
			separate_xor_detached: not (has_separate_console and has_detached_console)
		local
			l_success: BOOLEAN
			l_flag: INTEGER
		do
			if has_separate_console then
				l_flag := create_new_console
			elseif has_detached_console then
				l_flag := detached_process
			end
			spawn_with_flags (a_cmd, a_working_directory, l_flag)
			l_success := file_handle.close (child_input)
			l_success := file_handle.close (child_output)
			if not is_error_same_as_output then
				l_success := file_handle.close (child_error)
			end
			launched := last_launch_successful
			if launched then
				internal_has_exited := False
			end
		end

	check_process_state
			-- Try to get the last state that the child process has returned.
			-- after calling this feature, check `last_operation_successful'
			-- to see whether it succeeded. If so, the last process state is stored
			-- in `last_process_result'.
		require
			process_launched: launched
		do
			if attached process_info as l_process_info then
				last_operation_successful := {WEL_API}.get_exit_code_process (l_process_info.process_handle, $last_process_result)
			else
				last_operation_successful := False
			end
		end

feature -- Status setting

	set_input_direction (direction: INTEGER)
			-- Set `input_direction' with `direction'
		do
			input_direction := direction
		ensure
			input_direction_set: input_direction = direction
		end

	set_output_direction (direction: INTEGER)
			-- Set `output_direction' with `direction'
		do
			output_direction := direction
		ensure
			output_direction_set: output_direction = direction
		end

	set_error_direction (direction: INTEGER)
			-- Set `error_direction' with `direction'
		do
			error_direction := direction
		ensure
			error_direction_set: error_direction = direction
		end

	set_input_file_name (a_name: READABLE_STRING_GENERAL)
			-- Set `input_file_name' with `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			input_file_name := a_name.twin
		ensure
			file_name_set: input_file_name.same_string (a_name)
		end

	set_output_file_name (a_name: READABLE_STRING_GENERAL)
			-- Set `output_file_name' with `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			output_file_name := a_name.twin
		ensure
			file_name_set: output_file_name.same_string (a_name)
		end

	set_error_file_name (a_name: READABLE_STRING_GENERAL)
			-- Set `error_file_name' with `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			error_file_name := a_name.twin
		ensure
			file_name_set: error_file_name.same_string (a_name)
		end

feature -- Status reporting

	has_exited: BOOLEAN
			-- Has the process exited?
		require
			process_launched: launched
		do
			if not internal_has_exited then
				check_process_state
				internal_has_exited := not (last_process_result = {WEL_API}.still_active)
			end
			 Result := internal_has_exited
		end

	last_operation_successful: BOOLEAN
			-- Is last operation successful?

	launched: BOOLEAN
			-- Has process been launched?

	is_error_same_as_output: BOOLEAN
			-- Is error redirected to same direction as output?
		do
			Result := error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output
		end

	input_pipe_needed: BOOLEAN
			-- Is a pipe needed to write input from current process?
		do
			Result := input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		end

	output_pipe_needed: BOOLEAN
			-- Is a pipe needed to read output from current process?
		do
			Result := output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent
		end

	error_pipe_needed: BOOLEAN
			-- Is a pipe needed to read error from current process?			
		do
			Result := error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent
		end

	is_io_redirected: BOOLEAN
			-- Is input, output or error redirected?
		do
			Result := input_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection or
					  output_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection or
					  error_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
		end

feature -- Access

	input_direction: INTEGER
			-- Direction of input of process

	output_direction: INTEGER
			-- Direction of output of process

	error_direction: INTEGER
			-- Direction of error of process

	std_input, std_output, std_error: POINTER
			-- Handle used to read input and output from child.

	child_input, child_output, child_error: POINTER
			-- Input/output given to child.

	is_std_input_open: BOOLEAN
			-- Is std input open?

	is_std_output_open: BOOLEAN
			-- Is std output open?

	is_std_error_open: BOOLEAN
			-- Is std error open?

	input_file_name: READABLE_STRING_GENERAL
			-- Name if any of input file

	output_file_name: READABLE_STRING_GENERAL
			-- Name if any of output file

	error_file_name: READABLE_STRING_GENERAL
			-- Name if any of error file

feature -- Handle operation

	close_std_output
			-- Close standard output handle.
		local
			l_success: BOOLEAN
		do
			if is_std_output_open then
				if std_output /= default_pointer then
					l_success := file_handle.close (std_output)
				end
				is_std_output_open := False
			end
		ensure
			handle_closed: not is_std_output_open
		end

	close_std_input
			-- Close standard input handle.
		local
			l_success: BOOLEAN
		do
			if is_std_input_open then
				if std_input /= default_pointer then
					l_success := file_handle.close (std_input)
				end
				is_std_input_open := False
			end
		ensure
			handle_closed: not is_std_input_open
		end

	close_std_error
			-- Close standard error handle.
		local
			l_success: BOOLEAN
		do
			if is_std_error_open then
				if std_error /= default_pointer then
					l_success := file_handle.close (std_error)
				end
			end
			is_std_error_open := False
		ensure
			handle_closed: not is_std_error_open
		end

	close_io
			-- Close input, output and error handles.
		do
			close_std_input
			close_std_output
			close_std_error
		end

	close_process_handle
			-- Close process handle.
		require
			process_launched: launched
		do
			if attached process_info as l_process_info then
				last_operation_successful := file_handle.close (l_process_info.thread_handle)
				l_process_info.set_thread_handle (default_pointer)
					-- Make sure to not reset the value of `last_operation_successful'.
				last_operation_successful := file_handle.close (l_process_info.process_handle) and last_operation_successful
				l_process_info.set_process_handle (default_pointer)
			else
				last_operation_successful := False
			end
		end

feature

	startup_info: WEL_STARTUP_INFO
			-- Process startup information
		do
			create Result.make

			if is_io_redirected then
				Result.set_flags (Startf_use_std_handles)

					-- Initialize input of child
				if input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
					Result.set_std_input (stdin)
				else
					if input_pipe_needed then
						if attached file_handle.create_pipe_read_inheritable as l_tuple then
							child_input := l_tuple.read_pipe
							std_input := l_tuple.write_pipe
						else
								-- An error occurred
							child_input := default_pointer
							std_input := default_pointer
						end
					else
						child_input := file_handle.open_file_inheritable (input_file_name)
						std_input := default_pointer
					end
					is_std_input_open := True
					Result.set_std_input (child_input)
				end

					-- Initialize output of child
				if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
					Result.set_std_output (stdout)
				else
					if output_pipe_needed then
						if attached file_handle.create_pipe_write_inheritable as l_tuple then
							std_output := l_tuple.read_pipe
							child_output := l_tuple.write_pipe
						else
								-- An error occurred
							std_output := default_pointer
							child_output := default_pointer
						end
					else
						child_output := file_handle.create_file_inheritable (output_file_name, True)
						std_output := default_pointer
					end
					is_std_output_open := True
					Result.set_std_output (child_output)
				end
				if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
					Result.set_std_error (stderr)
				else
					if is_error_same_as_output then
						if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
							Result.set_std_error (stderr)
						else
							child_error := child_output
							std_error := std_output
							Result.set_std_error (child_error)
						end
					else
						if error_pipe_needed then
							if attached file_handle.create_pipe_write_inheritable as l_tuple then
								std_error := l_tuple.read_pipe
								child_error := l_tuple.write_pipe
							else
									-- An error occurred
								std_error := default_pointer
								child_error := default_pointer
							end
						else
							child_error := file_handle.create_file_inheritable (error_file_name, True)
							std_error := default_pointer
						end
						Result.set_std_error (child_error)
						is_std_error_open := True
					end
				end
			end

			if hidden then
				Result.set_show_command (Sw_hide)
			else
				Result.set_show_command (Sw_show)
			end
			Result.add_flag (Startf_use_show_window)
		end

feature{NONE} -- Implementation

	internal_has_exited: BOOLEAN
			-- Internal status indicating whether process has exited

	file_handle: FILE_HANDLE
			-- Factory for managing HANDLE
		once
			create Result
		ensure
			file_handle_not_void: Result /= Void
		end

	stdin: POINTER
			-- Standard input handle
		external
			"C inline use <windows.h>"
		alias
			"GetStdHandle (STD_INPUT_HANDLE)"
		end

	stdout: POINTER
			-- Standard output handle
		external
			"C inline use <windows.h>"
		alias
			"GetStdHandle (STD_OUTPUT_HANDLE)"
		end

	stderr: POINTER
			-- Standard error handle
		external
			"C inline use <windows.h>"
		alias
			"GetStdHandle (STD_ERROR_HANDLE)"
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
