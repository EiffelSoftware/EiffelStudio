indexing
	description: "Process launcher on Windows with IO redirection ability."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IO_REDIRECTION_PROCESS_LAUNCHER

inherit
	EXCEPTIONS
		export
			{NONE} all
		end

	WEL_PROCESS_LAUNCHER
		rename
			launch as wel_launch
		redefine
			startup_info
		end

	WEL_TOOLHELP
		undefine
			cwin_close_handle
		end

	THREAD_CONTROL

create
	make

feature -- Creation
	make (cmd: STRING; a_working_directory: STRING) is
		require
			command_line_not_null: cmd /= Void
			command_line_not_empty: not cmd.is_empty
		do
			cmd_line := cmd
			working_directory := a_working_directory
			launched := False
			input_has_been_closed := True
			output_has_been_closed := True
			error_has_been_closed := True
			input_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			output_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			error_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
		ensure
			command_line_set: cmd_line = cmd
			working_directory_set: working_directory = a_working_directory
			process_not_launched: not launched
			input_direction_set:
				input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			output_direction_set:
				output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			error_direction_set:
				error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection

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

feature -- Control

	launch (inf, outf, errf: STRING; buffer_size: INTEGER) is
			-- Launch a process
			-- inf is the file name of the input stream, if Void,
			-- use pipe to communicate between parent and child processes.
			-- outf is the file name of the output stream, if Void,
			-- use pipe to communicate between parent and child processes.
			-- errf is the file name of the error stream, if Void,
			-- use pipe to communicate between parent and child processes.
			-- buffer_size is only used when pipe is needed. It indicates
			-- the size of the string that you can read from or write to a
			-- pipe.
		require
			process_not_running: (not launched) or (launched and then has_process_exited)
			input_closed: input_has_been_closed
			output_closed: output_has_been_closed
			error_closed: error_has_been_closed
		local
			l_success1:BOOLEAN
			l_success2:BOOLEAN
			l_success3:BOOLEAN
		do
			close
			input_file_name := inf
			output_file_name := outf
			error_file_name := errf
			is_error_same_as_output := error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output

			input_pipe_needed := input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
			output_pipe_needed :=
				--(output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream or
				output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent

			error_pipe_needed :=
				--(error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream or
				error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent

			if separate_console then
				spawn_with_flags (cmd_line, working_directory, create_new_console)
			else
				spawn_with_flags (cmd_line, working_directory, 0)
			end

			last_operation_successful := last_launch_successful
			l_success1 := file_handle.close (child_input)
			l_success2 := file_handle.close (child_output)

			if not is_error_same_as_output then
				l_success3 := file_handle.close (child_error)
			else
				l_success3 := l_success2
			end

			last_operation_successful := last_operation_successful
			launched := last_operation_successful
			if process_info /= Void then
				process_id := process_info.process_id
			end
		end

	wait_for_exit is
			-- Wait for child process to exit.
		require
			process_launched: launched
		local
			successed: BOOLEAN
		do
			successed := cwin_wait_for_single_object (process_info.process_handle,
						cwin_infinite) = cwin_wait_object_0

		end

	read_output_stream (bsize: INTEGER) is
		require
			buffer_size_positive: bsize > 0
			process_launched: launched
		local
			in_progress: BOOLEAN
			l_file_handle: FILE_HANDLE
			succ: BOOLEAN
			bytes_avail: INTEGER
		do
			if not in_progress then
				succ := cwin_peek_named_pipe (std_output, default_pointer, 0, default_pointer, $bytes_avail, default_pointer)
				if succ then
					if bytes_avail > 0 then
						create l_file_handle
						l_file_handle.read_stream (std_output, bsize.min (bytes_avail))
						if not l_file_handle.last_read_successful then
								--When the child process exits, it will close its
								--write end of the output pipe, and this action
								--will in term cause the underlying ReadFile
								--function fail.
							last_string := ""
						else
							last_string := l_file_handle.last_string
						end
						last_operation_successful := l_file_handle.last_read_successful
					else
						last_string := ""
					end
				else
					last_string := Void
				end
			end
		rescue
			last_operation_successful := False
			if exception = Io_exception then
				in_progress := True
				retry
			end
		end

	read_error_stream (bsize: INTEGER) is
		require
			buffer_size_positive: bsize > 0
			process_launched: launched
		local
			in_progress: BOOLEAN
			l_file_handle: FILE_HANDLE
			succ: BOOLEAN
			bytes_avail: INTEGER
		do
			if not in_progress then
				succ := cwin_peek_named_pipe (std_error, default_pointer, 0, default_pointer, $bytes_avail, default_pointer)
				if succ then
					if bytes_avail > 0 then
						create l_file_handle
						l_file_handle.read_stream (std_error, bsize.min (bytes_avail))
						if not l_file_handle.last_read_successful then
								--When the child process exits, it will close its
								--write end of the output pipe, and this action
								--will in term cause the underlying ReadFile
								--function fail.
							last_error := ""
						else
							last_error := l_file_handle.last_string
						end
						last_operation_successful := l_file_handle.last_read_successful
					else
						last_error := ""
					end
				else
					last_error := Void
				end
			end
		rescue
			last_operation_successful := False
			if exception = Io_exception then
				in_progress := True
				retry
			end
		end

	put_string (s: STRING) is
			-- Send characters in `s' to process
		require
			string_not_void: s /= Void
		local
			l_file_handle: FILE_HANDLE
		do
			if input_pipe_needed then
				create l_file_handle
				l_file_handle.put_string (std_input, s)
			end
		end

	close_std_output is
			--
		local
			l_success: BOOLEAN
		do
			if not output_has_been_closed then
				if std_output /= default_pointer then
					l_success := file_handle.close (std_output)
				end
				output_has_been_closed := True
			end

		end

	close_std_input is
			--
		local
			l_success: BOOLEAN
		do
			if not input_has_been_closed  then
				if std_input /= default_pointer then
					l_success := file_handle.close (std_input)
				end
				input_has_been_closed := True
			end

		end

	close_std_error is
			--
		local
			l_success: BOOLEAN
		do
			if not error_has_been_closed then
				if std_error /= default_pointer then
					l_success := file_handle.close (std_error)
				end
			end
			error_has_been_closed := True
		end

	close is
			-- Close input, output and error files
		do
			close_std_input
			close_std_output
			close_std_error
		end

	terminate is
			-- Terminate independent process
		local
			a_boolean: BOOLEAN
			l_terminated: BOOLEAN
		do
			close
			a_boolean := cwin_exit_code_process (process_info.process_handle, $last_process_result)
			if a_boolean then
				if last_process_result = cwin_still_active then
					l_terminated := cwin_terminate_process (process_info.process_handle, 0)
				end
				cwin_close_handle (process_info.thread_handle)
				cwin_close_handle (process_info.process_handle)
			end
			suspended := False
		end

	terminate_tree (prc_id: INTEGER; is_self: BOOLEAN): BOOLEAN is
			-- Terminate all subprocesses whose parent process is indicated by id `prc_id'.
			-- If `is_self' is True, terminate process `prc_id' after all its sub-processes
			-- have been terminated.
		local
			child_prc_list: LIST [INTEGER]
			bad_prc_list: LINKED_LIST [INTEGER]
		do
			child_prc_list := direct_subprocess_list (prc_id)
			if child_prc_list /= Void and then not child_prc_list.is_empty then
				create bad_prc_list.make
				from

				until
					child_prc_list.is_empty
				loop
					from
						child_prc_list.start
					until
						child_prc_list.after
					loop
						if not terminate_tree (child_prc_list.item, True) then
							bad_prc_list.extend (child_prc_list.item)
							child_prc_list.remove
						else
							child_prc_list.forth
						end
					end
					child_prc_list := direct_subprocess_list (prc_id)
					if child_prc_list /= Void and then not child_prc_list.is_empty then
						from
							child_prc_list.start
						until
							child_prc_list.after
						loop
							if bad_prc_list.has (child_prc_list.item) then
								child_prc_list.remove
							else
								child_prc_list.forth
							end
						end
					end
				end
			end
			if is_self then
				Result := terminate_process_by_id (prc_id)
			else
				Result := True
			end
		end

	set_separate_console (b: BOOLEAN) is
			--
		do
			separate_console := b
		ensure
			separate_console_set: separate_console = b
		end

feature -- Status reporting

	process_id: INTEGER
			-- Process identifier of last launched process

	input_direction: INTEGER
			-- Direction of input of process

	output_direction: INTEGER
			-- Direction of output of process

	error_direction: INTEGER
			-- Direction of error of process

	suspended: BOOLEAN
			-- Is process suspended awaiting user input?

	last_error: STRING

	last_string: STRING
			-- Result of last call to `read_line'


	last_operation_successful: BOOLEAN
		-- Is last process operation successful?

	launched: BOOLEAN
		-- has the process been launched?

	has_process_exited: BOOLEAN is
			-- Has the process exited?
		require
			process_launched: launched = True
		do
			check_process_state

			if last_operation_successful=True then
				Result := not (last_process_result = cwin_still_active)
			else -- Modify here if have a better solution
				 -- If error occurs, assume that the process has already exited.
				Result := True
			end
		end

	input_has_been_closed: BOOLEAN

	output_has_been_closed: BOOLEAN

	error_has_been_closed: BOOLEAN

	check_process_state is
		-- Try to get the last state that the child process has returned.
		-- after calling this feature, check last_operation_successful feature
		-- to see whether it successed. If so, the last process state is stored
		-- in last_process_result.
		require
			process_launched: launched = True
		do
			last_operation_successful := cwin_exit_code_process (process_info.process_handle,$last_process_result)
		end

feature {NONE} -- Implementation

	sleep_time: INTEGER is 1000000
			-- Time to sleep after terminate sub-process tree

	input_pipe_needed: BOOLEAN
			-- Is a pipe needed to write input from current process?

	output_pipe_needed: BOOLEAN
			-- Is a pipe needed to read output from current process?

	input_file_name: STRING
			-- Name if any of input file

	output_file_name: STRING
			-- Name if any of output file

	savefile: RAW_FILE
			-- File to which output read from process is written,
			-- if not void

	std_input, std_output: POINTER
			-- Handle used to read input and output from child.

	child_input, child_output: POINTER
			-- Input/output given to child.

	last_character: CHARACTER
			-- Result of last call to `read_character'

	file_handle: FILE_HANDLE is
			-- Factory for managing HANDLE
		once
			create Result
		ensure
			file_handle_not_void: Result /= Void
		end


	cmd_line: STRING

	working_directory: STRING

	error_pipe_needed: BOOLEAN

	error_file_name: STRING

	std_error: POINTER
			-- Handle used to read error from child.

	child_error: POINTER
			-- Error handle given to child.	

	is_error_same_as_output: BOOLEAN

	separate_console: BOOLEAN
			-- Will process be launched with a new console instead of inheriting parent's console?
			-- Only has effects on Windows

	startup_info: WEL_STARTUP_INFO is
			-- Process startup information
		local
			l_tuple: TUPLE [POINTER, POINTER]
			l_flag: BOOLEAN
		do
			create Result.make

			l_flag :=
				input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection and
				output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection and
				error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			if not l_flag then
				Result.set_flags (Startf_use_std_handles)

					-- Initialize input of child
				if not (input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection) then
					if input_pipe_needed then
						l_tuple := file_handle.create_pipe_read_inheritable
						child_input := l_tuple.pointer_item (1)
						std_input := l_tuple.pointer_item (2)
					else
						child_input := file_handle.open_file_inheritable (input_file_name)
						std_input := default_pointer
					end
					input_has_been_closed := False
					Result.set_std_input (child_input)
				else
					Result.set_std_input (stdin)
				end

					-- Initialize output of child
				if not (output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection) then
					if output_pipe_needed then
						l_tuple := file_handle.create_pipe_write_inheritable
						std_output := l_tuple.pointer_item (1)
						child_output := l_tuple.pointer_item (2)
					else
						child_output := file_handle.create_file_inheritable (output_file_name, False)
						std_output := default_pointer
					end
					output_has_been_closed := False
					Result.set_std_output (child_output)
				else
					Result.set_std_output (stdout)
				end

				if not (error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection) then
					if not is_error_same_as_output then
						if error_pipe_needed then
							l_tuple := file_handle.create_pipe_write_inheritable
							std_error := l_tuple.pointer_item (1)
							child_error := l_tuple.pointer_item (2)
						else
							child_error := file_handle.create_file_inheritable (error_file_name, False)
							std_error := default_pointer
						end
						Result.set_std_error (child_error)
						error_has_been_closed := False
					else
						if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
							Result.set_std_error (stderr)
						else
							child_error := child_output
							std_error := std_output
							Result.set_std_error (child_error)
						end
					end
				else
					Result.set_std_error (stderr)
				end
			end

			if hidden then
				Result.set_show_command (Sw_hide)
			else
				Result.set_show_command (Sw_show)
			end
			Result.add_flag (Startf_use_show_window)

		end

	cwin_peek_named_pipe (a_handle: POINTER; a_buffer:  POINTER;  buf_size: INTEGER; bytes_read: POINTER; bytes_avail: POINTER; a_integer: POINTER): BOOLEAN is
			-- Peek a pipe to see whether there is data in it.
		external
			"C blocking macro signature (HANDLE, LPVOID, DWORD, LPDWORD, LPDWORD, LPDWORD): BOOL use <windows.h>"
		alias
			"PeekNamedPipe"
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

	terminate_process_by_id (pid: INTEGER): BOOLEAN is
			-- Terminate process indicated by identifier `pid'.
		require
			pid_not_negative: pid >= 0
		local
			handle: POINTER
			l_boolean: BOOLEAN
			l_last_result: INTEGER
		do
			handle := cwin_open_process (cwin_process_all_access, False, pid)
			if handle /= default_pointer then
				l_boolean := cwin_exit_code_process (handle, $l_last_result)
				if l_boolean then
					if l_last_result = cwin_still_active then
						l_boolean := cwin_terminate_process (handle, 0)
					end
					cwin_close_handle (handle)
				end
				Result := True
			else
				Result := False
			end
		end

	direct_subprocess_list (parent_id: INTEGER): LIST [INTEGER] is
			-- List of direct subprocess ids of process indicated by id `parent_id'.
		local
			p_tbl: LINKED_LIST [ WEL_PROCESS_ID_PAIR ]
		do
			p_tbl := process_id_pair_list
			if p_tbl /= Void then
				create {LINKED_LIST [INTEGER]}Result.make
				from
					p_tbl.start
				until
					p_tbl.after
				loop
					if p_tbl.item.parent_id = parent_id then
						Result.extend (p_tbl.item.id)
					end
					p_tbl.forth
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
