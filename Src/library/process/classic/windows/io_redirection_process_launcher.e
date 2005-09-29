indexing
	description: "Process launcher on Windows with IO redirection ability."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IO_REDIRECTION_PROCESS_LAUNCHER

inherit
	WEL_PROCESS_LAUNCHER_2
		rename
			make as ewaesel_make,
			launch as eweasel_make
		export
			{ANY}
				last_process_result,put_string,last_string, 
				run_hidden,hidden
		redefine
			startup_info, close
		end
		
create
	make
		
feature -- Creation
	make (cmd: STRING; a_working_directory: STRING) is
		require
			command_line_not_null: cmd /= Void
			command_line_not_empty: not cmd.is_empty
			working_directory_not_null: a_working_directory /= Void
		do
			cmd_line := cmd
			working_directory := a_working_directory
			launched := False
			end_of_error := True
			end_of_file := True -- It's end of output
			input_has_been_closed := False
			output_has_been_closed := False
			error_has_been_closed := False						
		ensure		
			command_line_set: cmd_line = cmd
			working_directory_set: working_directory = a_working_directory
			process_not_launched: not launched
			end_of_error_true: end_of_error
			end_of_file_ture: end_of_file -- It's end of output
		end
		
feature -- Control
	launch (inf, outf, errf: STRING; buffer_size: INTEGER; is_err_same: BOOLEAN) is
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
			process_not_launched: not launched
		local
			l_success1:BOOLEAN
			l_success2:BOOLEAN
			l_success3:BOOLEAN
		do
			input_file_name := inf
			output_file_name := outf
			error_file_name := errf
			is_error_same_as_output := is_err_same
			
			input_pipe_needed := inf = Void
			output_pipe_needed := outf = Void	
			
			if not is_error_same_as_output then
				error_pipe_needed := errf = Void						
			else					
				error_pipe_needed := False
			end

			if with_console then
				spawn_with_flags (cmd_line, working_directory, create_new_console)
			else
				spawn_with_flags (cmd_line, working_directory, create_no_window)
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
			end_of_file := False
			end_of_error := False
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
			if exception = Io_exception then
				in_progress := True
				end_of_file := True
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
			if exception = Io_exception then
				in_progress := True
				end_of_error := True
				retry
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

			if not is_error_same_as_output then
				if not error_has_been_closed then
					if std_error /= default_pointer then
						l_success := file_handle.close (std_error)			
					end						
				end
				error_has_been_closed := True					
			end
		end
				
	close is
			-- Close input, output and error files
		do
			close_std_input
			close_std_output
			close_std_error
		end
		
	run_with_console is
			-- 
		do
			with_console := True
		ensure
			with_console_set: with_console = True
		end
		
		
feature -- Status reporting
	end_of_error: BOOLEAN

	last_error: STRING
	
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

	input_has_been_closed: BOOLEAN
	output_has_been_closed: BOOLEAN
	error_has_been_closed: BOOLEAN
	cmd_line: STRING
	
	working_directory: STRING
	
	error_pipe_needed: BOOLEAN
	
	error_file_name: STRING
	
	std_error: POINTER
			-- Handle used to read error from child.
	
	child_error: POINTER
			-- Error handle given to child.	

	is_error_same_as_output: BOOLEAN
	
	with_console: BOOLEAN
			-- Will process be launched with a console?
			-- Only has effects on Windows


		
	startup_info: WEL_STARTUP_INFO is
			-- Process startup information
		local
			l_tuple: TUPLE [POINTER, POINTER]
		do
				-- Initialize input of child
			if input_pipe_needed then
				l_tuple := file_handle.create_pipe_read_inheritable
				child_input := l_tuple.pointer_item (1)
				std_input := l_tuple.pointer_item (2)
			else
				child_input := file_handle.open_file_inheritable (input_file_name)
				std_input := default_pointer

			end
				-- Initialize output of child
			if output_pipe_needed then
				l_tuple := file_handle.create_pipe_write_inheritable
				std_output := l_tuple.pointer_item (1)
				child_output := l_tuple.pointer_item (2)
			else
				child_output := file_handle.create_file_inheritable (output_file_name, False)
				std_output := default_pointer
			
			end
			if not is_error_same_as_output then
				if error_pipe_needed then
					l_tuple := file_handle.create_pipe_write_inheritable
					std_error := l_tuple.pointer_item (1)
					child_error := l_tuple.pointer_item (2)
				else
					child_error := file_handle.create_file_inheritable (error_file_name, False)
					std_error := default_pointer				
				end	
			else			
				child_error := child_output
				std_error := std_output				
			end

			
			create Result.make
			Result.set_flags (Startf_use_std_handles)
			if hidden then
				Result.set_show_command (Sw_hide)
			else
				Result.set_show_command (Sw_show)
			end
			Result.add_flag (Startf_use_show_window)
			Result.set_std_input (child_input)
			Result.set_std_output (child_output)
			Result.set_std_error (child_error)
		end

	cwin_peek_named_pipe (a_handle: POINTER; a_buffer:  POINTER;  buf_size: INTEGER; bytes_read: POINTER; bytes_avail: POINTER; a_integer: POINTER): BOOLEAN is
		external
			"C blocking macro signature (HANDLE, LPVOID, DWORD, LPDWORD, LPDWORD, LPDWORD): BOOL use <windows.h>"
		alias
			"PeekNamedPipe"
		end	

end
