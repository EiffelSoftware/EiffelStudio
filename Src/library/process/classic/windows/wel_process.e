indexing
	description: "Object that represents a launched process"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROCESS

inherit
	WEL_PROCESS_LAUNCHER
		rename
			launch as wel_launch
		export
			{ANY}process_info
		redefine
			startup_info
		end

create
	make

feature{NONE} -- Implementation

	make is
			-- Initialize instance.
		do
			is_std_input_open := False
			is_std_output_open := False
			is_std_error_open := False
			input_file_name := Void
			output_file_name := Void
			error_file_name := Void
			input_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			output_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			error_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			internal_has_exited := True
		ensure
			std_input_not_open: not is_std_input_open
			std_output_not_open: not is_std_output_open
			std_error_not_open: not is_std_error_open
			input_file_name_set: input_file_name = Void
			output_file_name_set: output_file_name = Void
			error_file_name_set: error_file_name = Void
			no_input_redirection: input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			no_output_redirection: output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			no_error_redirection: error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			internal_has_exited: internal_has_exited
		end

feature -- Process operations

	launch (a_cmd: STRING; a_working_directory: STRING; has_separate_console: BOOLEAN; has_detached_console: BOOLEAN; use_unicode: BOOLEAN; environs: POINTER) is
			-- Launch a process whose command is `a_cmd' in `a_working_directory'.
			-- If `has_separate_console' is True, launch process in a separate console.
			-- If `has_detached_console' is True, launch process without any console.
			-- `environs' is a pointer to environment variable block.
			-- `use_unicode' is True indicates that environment `environs' uses unicode instead of ANSI string.			
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
			if use_unicode then
				l_flag := l_flag | create_unicode_environment
			end
			spawn_process (a_cmd, a_working_directory, l_flag, environs)
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

	check_process_state is
		-- Try to get the last state that the child process has returned.
		-- after calling this feature, check `last_operation_successful'
		-- to see whether it succeeded. If so, the last process state is stored
		-- in `last_process_result'.
		require
			process_launched: launched
		do
			last_operation_successful := cwin_exit_code_process (process_info.process_handle,$last_process_result)
		end

feature -- Status setting

	set_input_direction (direction: INTEGER) is
			-- Set `input_direction' with `direction'
		do
			input_direction := direction
		ensure
			input_direction_set: input_direction = direction
		end

	set_output_direction (direction: INTEGER) is
			-- Set `output_direction' with `direction'
		do
			output_direction := direction
		ensure
			output_direction_set: output_direction = direction
		end

	set_error_direction (direction: INTEGER) is
			-- Set `error_direction' with `direction'
		do
			error_direction := direction
		ensure
			error_direction_set: error_direction = direction
		end

	set_input_file_name (a_name: STRING) is
			-- Set `input_file_name' with `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			input_file_name := a_name.twin
		ensure
			file_name_set: input_file_name.is_equal (a_name)
		end

	set_output_file_name (a_name: STRING) is
			-- Set `output_file_name' with `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			output_file_name := a_name.twin
		ensure
			file_name_set: output_file_name.is_equal (a_name)
		end

	set_error_file_name (a_name: STRING) is
			-- Set `error_file_name' with `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			error_file_name := a_name.twin
		ensure
			file_name_set: error_file_name.is_equal (a_name)
		end

feature -- Status reporting

	has_exited: BOOLEAN is
			-- Has the process exited?
		require
			process_launched: launched
		do
			if not internal_has_exited then
				check_process_state
				internal_has_exited := not (last_process_result = cwin_still_active)
			end
			 Result := internal_has_exited
		end

	last_operation_successful: BOOLEAN
			-- Is last operation successful?

	launched: BOOLEAN
			-- Has process been launched?

	is_error_same_as_output: BOOLEAN is
			-- Is error redirected to same direction as output?
		do
			Result := error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output
		end

	input_pipe_needed: BOOLEAN is
			-- Is a pipe needed to write input from current process?
		do
			Result := input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		end

	output_pipe_needed: BOOLEAN is
			-- Is a pipe needed to read output from current process?
		do
			Result := output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent
		end

	error_pipe_needed: BOOLEAN is
			-- Is a pipe needed to read error from current process?			
		do
			Result := error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent
		end

	is_io_redirected: BOOLEAN is
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

	input_file_name: STRING
			-- Name if any of input file

	output_file_name: STRING
			-- Name if any of output file

	error_file_name: STRING
			-- Name if any of error file

feature -- Handle operation

	close_std_output is
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

	close_std_input is
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

	close_std_error is
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

	close_io is
			-- Close input, output and error handles.
		do
			close_std_input
			close_std_output
			close_std_error
		end

	close_process_handle is
			-- Close process handle.
		require
			process_launched: launched
		do
			last_operation_successful := file_handle.close (process_info.thread_handle)
			last_operation_successful := file_handle.close (process_info.process_handle)
		end

feature

	startup_info: WEL_STARTUP_INFO is
			-- Process startup information
		local
			l_tuple: TUPLE [p1: POINTER; p2: POINTER]
		do
			create Result.make

			if is_io_redirected then
				Result.set_flags (Startf_use_std_handles)

					-- Initialize input of child
				if input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
					Result.set_std_input (stdin)
				else
					if input_pipe_needed then
						l_tuple := file_handle.create_pipe_read_inheritable
						child_input := l_tuple.p1
						std_input := l_tuple.p2
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
						l_tuple := file_handle.create_pipe_write_inheritable
						std_output := l_tuple.p1
						child_output := l_tuple.p2
					else
						child_output := file_handle.create_file_inheritable (output_file_name, False)
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
							l_tuple := file_handle.create_pipe_write_inheritable
							std_error := l_tuple.p1
							child_error := l_tuple.p2
						else
							child_error := file_handle.create_file_inheritable (error_file_name, False)
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

	file_handle: FILE_HANDLE is
			-- Factory for managing HANDLE
		once
			create Result
		ensure
			file_handle_not_void: Result /= Void
		end

	stdin: POINTER is
			-- Standard input handle
		external
			"C inline use <windows.h>"
		alias
			"GetStdHandle (STD_INPUT_HANDLE)"
		end

	stdout: POINTER is
			-- Standard output handle
		external
			"C inline use <windows.h>"
		alias
			"GetStdHandle (STD_OUTPUT_HANDLE)"
		end

	stderr: POINTER is
			-- Standard error handle
		external
			"C inline use <windows.h>"
		alias
			"GetStdHandle (STD_ERROR_HANDLE)"
		end

	spawn_process (a_command_line, a_working_directory: STRING_GENERAL; a_flags: INTEGER; a_environs: POINTER) is
			-- Spawn asynchronously process described in `a_command_line' from `a_working_directory'.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		local
			a_wel_string1, a_wel_string2: WEL_STRING
		do
			create process_info.make
			create a_wel_string1.make (a_command_line)
			if a_working_directory /= Void and then not a_working_directory.is_empty then
				create a_wel_string2.make (a_working_directory)
				last_launch_successful := cwin_create_process (default_pointer, a_wel_string1.item,
							default_pointer, default_pointer, True, a_flags,
							a_environs, a_wel_string2.item,
							startup_info.item, process_info.item)
			else
				last_launch_successful := cwin_create_process (default_pointer, a_wel_string1.item,
							default_pointer, default_pointer, True, a_flags,
							a_environs, default_pointer,
							startup_info.item, process_info.item)
			end
		end

end
