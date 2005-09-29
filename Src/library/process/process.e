indexing
	description: "Interface of a multi-platform process launcher(on Win32, .Net and Unix/Linux)"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROCESS

inherit
	PROCESS_REDIRECTION_CONSTANTS

feature {NONE} -- Initialization

	make (fname: STRING; a_working_directory: STRING; args: LIST [STRING]) is
			-- Use `fname' and `args' to make a command line 
			-- fname is the absolute name (path included) of the program 
			-- to be launched.
			-- a_working_directory indicates directory of the program to be launched
			-- args are arguments of the program and can be Void meaning
			-- no argument is to be used.
		require
			file_name_not_void: fname /= Void
			file_name_not_empty: not fname.is_empty
		deferred	
		ensure	
			command_line_not_null: command_line /= Void 
			comand_line_not_empty: not command_line.is_empty
			directory_set: working_directory = a_working_directory			
			process_not_launched: not launched
			process_not_hidden: not hidden
			buffer_size_positive: buffer_size > 0
			operation_succcessful: last_operation_successful	
			init_succeeded: initialization_successful
		end
		
	make_with_command_line (c_line: STRING; a_working_directory: STRING) is
			-- Use `c_line' in which both program name and parameters are
			-- included to make a command line.
			-- a_working_directory indicates directory of the program to be launched.
		require
			command_line_not_void: c_line /= Void
			command_line_not_empty: not c_line.is_empty			
		deferred
		ensure	
			command_line_not_null: command_line /= Void 
			comand_line_not_empty: not command_line.is_empty
			directory_set: working_directory = a_working_directory			
			process_not_launched: not launched
			process_not_hidden: not hidden
			buffer_size_positive: buffer_size > 0			
			operation_succcessful: last_operation_successful	
			init_succeeded: initialization_successful		
		end

feature -- Control
	
	terminate is
			-- Try to terminate the launched process
			-- Not only terminate the child process, but also
			-- wait for the parent's listening threads to exit.
		require
			process_launched: launched
		deferred
		end
		
	launch is
			-- Launch process
			-- Before launching, you should use IO redirection features
			-- to indicate the input, output and error stream of the process.
		require
			process_not_launched: not launched
		deferred
		end
		
	wait_for_exit is
			-- Block the parent process and wait until 
			-- the child process has finished.
			-- Depending on your IO redirection choice, the parent process
			-- may start some threads to listen to relative IO stream for data
			-- so wait_for_exit also waits until these listener threads exit.
		require
			process_launched: launched 
		deferred
		ensure
			process_not_in_action: has_exited
		end

	put_string (s: STRING) is
			-- Put a string into the newly launched process's 
			-- input stream.
			-- Only use this feature when the input of the process
			-- has been redirected to stream.
		require
			process_launched: launched
			input_redirect_to_stream: input_redirection = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
			string_not_void: s /= Void			
		deferred
		end
	
	read_error is
			-- Try to get error message (length of the message
			-- is not more than buffer_size, which you can set 
			-- with set_buffer_size) from launched process
			-- ONLY use this feature when the error of the process
			-- has been redirected to stream.
			-- This feature may block.
			-- This feature will set last_output to Void if all data
			-- has been read.
		require
			process_launched: launched
			error_redirected_to_stream: error_redirection = {PROCESS_REDIRECTION_CONSTANTS}.to_stream			
		deferred
		end

	read_output is
			-- Try to get the output (length of message
			-- is not more than buffer_size, which you can set 
			-- with set_buffer_size) from the launched process
			-- Only used this feature when the output of the process
			-- has been redirected to stream.
			-- This feature may block.
			-- This feature will set last_output to Void if all data
			-- has been read.
		require
			process_launched: launched
			output_redirected_to_stream: output_redirection = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		deferred
		end

feature -- Status report
		
	force_terminated: BOOLEAN
			-- Has process been terminated by user?
					
	launched: BOOLEAN
			-- Has the process been launched?
		
	has_exited: BOOLEAN is
			-- Has the process finished?
		require
			process_launched: launched
		deferred
		end	
		
	platform: PLATFORM is
			-- Facility to tell us which `platform' we are on.
		once
			create Result
		ensure
			platform_created: Result /= Void
		end		
		
	buffer_size: INTEGER
			-- This can influence how much data can be read in to
			-- `last_output' and `last_error' by `read_output' and `read_error', respectively.
		
	last_operation_successful: BOOLEAN	
			-- Is the last operation successful?
	
	last_output: STRING
			-- Last output data from the child process
	
	last_error: STRING
			-- Last error data from the child process
					
	hidden: BOOLEAN is
			-- Will the process be launched silently?
		do
			Result := is_hidden
		end
		
	exit_code: INTEGER is
			-- Exit code of child process
		require
			process_launched: launched
			process_has_exited: has_exited
		deferred
		end
				
	input_redirection: INTEGER
			-- Where will input stream of the to-be launched process be redirected.
			-- Valid values are those constants defined in class PROCESS_REDIRECTION_CONSTANTS
			-- See class PROCESS_REDIRECTION_CONSTANTS for more information.

	output_redirection: INTEGER
			-- Where will the output stream of the to-be launched process be redirected.
			-- Valid values are those constants defined in class PROCESS_REDIRECTION_CONSTANTS
			-- See class PROCESS_REDIRECTION_CONSTANTS for more information.

	error_redirection: INTEGER
			-- Where will the error stream of the to-be launched process be redirected.
			-- Valid values are those constants defined in class PROCESS_REDIRECTION_CONSTANTS
			-- See class PROCESS_REDIRECTION_CONSTANTS for more information.

	input_file_name: STRING
			-- File name served as the redirected input stream of the new process
	
	output_file_name: STRING
			-- File name served as the redirected output stream of the new process
	
	error_file_name: STRING
			-- File name served as the redirected error stream of the new process

feature -- Status setting
	
	set_timer (pt: PROCESS_TIMER) is
			-- Set `pt' as timer used by this process launcher.
		require
			process_not_launched: not launched
			pt_not_void: pt /= Void			
		deferred
		ensure
			timer_set: timer = pt
		end
		
	set_hidden (h: BOOLEAN) is
			-- Set `is_hidden' with `h'.
		require
			process_not_launched: not launched
			on_windows: platform.is_windows
		do
			is_hidden := h
		ensure
			hidden_flag_set: is_hidden = h
		end
		
	run_with_console (c: BOOLEAN) is
			-- Will process be launched with a new console?
			-- Only has effects on Windows.
		require
			process_not_launched: not launched
			on_windows: platform.is_windows
		do
			with_console := c
		ensure
			with_console_flag_set: with_console = c
		end
			
	redirect_input_to_stream is
			-- Redirect the input stream of the process to its parent's stream
			-- So you can use put_stream feature to control the input data freely.
		require
			process_not_launched: not launched
		deferred
		ensure
			input_redirected_to_stream:
				input_redirection = {PROCESS_REDIRECTION_CONSTANTS}.To_stream
			input_file_name_void: input_file_name = Void
		end
		
	redirect_input_to_file (fname: STRING) is
			-- Redirect the input stream of the process to a file
		require
			process_not_launched: not launched
			file_name_not_void: fname /= Void
			file_name_not_empty: not fname.is_empty
		deferred
		ensure
			input_redirectd_to_file:
				input_redirection = {PROCESS_REDIRECTION_CONSTANTS}.To_file	
			input_file_name_set: input_file_name = fname
		end
		
	redirect_output_to_stream is
			-- Redirect the output stream of the process to its parent's stream
		require
			process_not_launched: not launched		
		deferred
		ensure
			output_redirected_to_stream:
				output_redirection = {PROCESS_REDIRECTION_CONSTANTS}.To_stream
			output_file_name_void: output_file_name = Void
			output_handler_void: output_handler = Void
		end
	
	redirect_output_to_file (fname: STRING) is
			-- Redirect the output stream of the process to a file
		require
			process_not_launched: not launched
			file_name_not_void: fname /= Void
			file_name_not_empty: not fname.is_empty
			output_error_file_not_same: 
				(error_file_name /= Void) implies not error_file_name.is_equal (fname)
		deferred
		ensure
			output_redirected_to_file:
				output_redirection = {PROCESS_REDIRECTION_CONSTANTS}.To_file
			output_file_name_set: output_file_name = fname
			output_handler_void: output_handler = Void
		end
		
	redirect_output_to_agent (a_output_handler: ROUTINE [ANY, TUPLE [STRING]]) is
			-- Redirect the output stream of the process to an agent
			-- so whenever some data comes out of the process,
			-- the agent will be called with it's parameter assigned to
			-- the output data
		require
			process_not_launched: not launched
			handler_not_void: a_output_handler /= Void
			not_same_as_error_handler: (error_handler /= Void) implies (error_handler /= a_output_handler)
		deferred
		ensure
			output_redirected_to_agent: output_redirection = {PROCESS_REDIRECTION_CONSTANTS}.To_agent	
			output_handler_set: output_handler = a_output_handler
			output_file_name_void: output_file_name = Void
		end
		
	redirect_error_to_same_as_output is
			-- Redirect output and error to the same location.
			-- Not applicable on .NET. 
		require
			process_not_launched: not launched	
			not_on_dotnet_platform: not platform.is_dotnet	
		deferred	
		ensure
			error_redirected_to_same_as_output:
				error_redirection = To_same_as_output
		end
		
	redirect_error_to_stream is	
			-- Redirect the error stream of the process to its parent's stream
		require
			process_not_launched: not launched		
		deferred
		ensure
			error_redirected_to_stream:
				error_redirection = {PROCESS_REDIRECTION_CONSTANTS}.To_stream	
			error_file_name_void: error_file_name = Void
			error_handler_void: error_handler = Void
		end

	redirect_error_to_file (fname: STRING) is
			-- Redirect the error stream of the process to a file
		require
			process_not_launched: not launched
			file_name_not_void: fname /= Void
			file_name_not_empty: not fname.is_empty
			output_error_file_not_same: 
				(output_file_name /= Void) implies (not output_file_name.is_equal (fname))		
		deferred
		ensure
			error_redirected_to_file: error_redirection = {PROCESS_REDIRECTION_CONSTANTS}.To_file
			error_file_set: error_file_name = fname
			error_handler_void: error_handler = Void
		end
		
	redirect_error_to_agent (a_error_handler: ROUTINE [ANY, TUPLE [STRING]]) is
			-- Redirect the error stream of the process to an agent
			-- so whenever some error message comes out of the process,
			-- the agent will be called with it's parameter assigned to
			-- the output data
		require
			process_not_launched: not launched
			handler_not_void: a_error_handler /= Void
			not_same_as_output_handler: (output_handler /= Void) implies (a_error_handler /= output_handler)
 		deferred
 		ensure
			error_redirected_to_agent: error_redirection = {PROCESS_REDIRECTION_CONSTANTS}.To_agent	
			error_handler_set: error_handler = a_error_handler
			error_file_name_void: error_file_name = Void
		end
		
	set_buffer_size (size: INTEGER) is
			-- Set `buffer_size' with `size'.
		require
			process_not_launched: not launched
			size_positive: size > 0
		do
			buffer_size := size
		ensure
			buffer_size_set: buffer_size = size
		end
		
	set_on_start_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process starts.
		require
			process_not_launched: not launched
			handler_not_void: handler /= Void
		deferred
		ensure
			handler_set: on_start_handler = handler
		end
		
	disable_on_start_handler is
			-- Disable handler called when process starts.
		require
			process_not_launched: not launched
		deferred
		ensure
			handler_set_to_void: on_start_handler = Void
		end
		
	set_on_exit_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process exits.
			-- Note: If you use PROCESS_THREAD_TIMER as process status listening
			-- timer, pay attention to `handler' to make it thread-safe.
			-- See `set_timer'
		require
			process_not_launched: not launched
			handler_not_void: handler /= Void
		deferred
		ensure
			handler_set: on_exit_handler = handler
		end

		
	disable_on_exit_handler is
			-- Disable handler called when process exits.
		require
			process_not_launched: not launched
		deferred
		ensure
			handler_set_to_void: on_exit_handler = Void
		end
		
	set_on_terminate_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process has been terminated.
		require
			process_not_launched: not launched
			handler_not_void: handler /= Void
		deferred
		ensure
			handler_set: on_terminate_handler = handler
		end
	
	disable_on_terminate_handler is
			-- Disable handler called when process has been terminated
		require
			process_not_launched: not launched
		deferred
		ensure
			handler_set_to_void: on_terminate_handler = Void
		end	
		
	set_on_launch_failed_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process launch failed
		require
			process_not_launched: not launched
			handler_not_void: handler /= Void
		deferred
		ensure
			handler_set: on_launch_failed_handler = handler
		end
	
	disable_on_launch_failed_handler is
			-- Disable handler called when process launch failed.
		require
			process_not_launched: not launched
		deferred
		ensure
			handler_set_to_void: on_launch_failed_handler = Void
		end	
		
	set_on_launch_successed_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process launch successed.
		require
			process_not_launched: not launched
			handler_not_void: handler /= Void
		deferred
		ensure
			handler_set: on_launch_successed_handler = handler
		end
	
	disable_on_launch_successed_handler is
			-- Disable handler called when process launch successed.
		require
			process_not_launched: not launched
		deferred
		ensure
			handler_set_to_void: on_launch_successed_handler = Void
		end	
	
	is_hidden: BOOLEAN
			-- Will process be launched hidden?
			-- Has effects on Windows.
			
	with_console: BOOLEAN
			-- Will process be launched with a console?
			-- Has effects on Windows.
	
	command_line: STRING
			-- Program (with its arguments, if any) which will be run
			-- in launched process
		
	working_directory: STRING
			-- Working directory of the program to be launched

	output_handler: PROCEDURE [ANY, TUPLE [STRING]]
			-- An agent to a routine dealing with the output data from
			-- the process
			-- Has effect when output stream of the process has been
			-- redirected to agent.
			
	error_handler: PROCEDURE [ANY, TUPLE [STRING]]
			-- An agent to a routine dealing with the error data from
			-- the process
			-- Has effect when error stream of the process has been
			-- redirected to agent.	

feature {NONE} -- Implementation

	on_start_handler: ROUTINE [ANY, TUPLE]
			-- Agent called when process starts
	
	on_exit_handler: ROUTINE [ANY, TUPLE]
			-- Agent called when process exits
				
	on_terminate_handler: ROUTINE [ANY, TUPLE]
			-- Agent called when process has been terminated
			
	on_launch_failed_handler: ROUTINE [ANY, TUPLE]
			-- Agent called when process launch failed
			
	on_launch_successed_handler: ROUTINE [ANY, TUPLE]
			-- Agent called when process launch is successful
	
	last_process_result: INTEGER
			-- Last launched process return value
	
	file_name: STRING
			-- File name of the program which is going to be run in the new launched process
	
	arguments: LINKED_LIST [STRING]
			-- Arguments of the program indicated by file_name
			
	timer: PROCESS_TIMER
			-- Timer used to check process termination so that some cleanups are done
						
	initialization_successful: BOOLEAN is
			-- Is initialization successful?
		do
			Result := (input_redirection = {PROCESS_REDIRECTION_CONSTANTS}.To_stream) and
				(output_redirection = {PROCESS_REDIRECTION_CONSTANTS}.To_stream) and
				(error_redirection = {PROCESS_REDIRECTION_CONSTANTS}.To_stream) and		
				(output_handler = Void) and
				(error_handler = Void) and			
				(last_output = Void) and
				(last_error = Void) and					
				(input_file_name = Void) and
				(output_file_name = Void) and
				(error_file_name = Void) and
				(timer = Void)
		end

end
