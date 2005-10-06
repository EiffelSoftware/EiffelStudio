indexing
	description: 
		"[
			Process launcher used in EiffelStudio.
			It will redirect the input of the process to a stream of its parent process and
			and output and error of the child process to two agents.
		 ]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROCESS_LAUNCHER
		
feature -- Launching parameters setting

	prepare_command_line (c_line: STRING; a_working_directory: STRING) is
			-- Set `a_working_directory' as working directory and 
			-- `c_line' as command line of the to-be launched process.
		require
			process_not_in_action: (not launched) or (launched and has_exited)
			command_line_not_void: c_line /= Void
			command_line_not_empty: not c_line.is_empty	
			working_dir_not_null: a_working_directory /= Void				
		do
			command_line := c_line
			working_directory := a_working_directory
		ensure
			command_line_set: command_line = c_line
			working_directory_set: working_directory = a_working_directory
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
		
	launch (redirection_needed: BOOLEAN) is
			-- Launch process.
			-- If `redirection_needed', redirect input, output and error of process.
		require
			output_handler_set: output_handler /= Void
			error_handler_set: error_handler /= Void
			command_line_not_null: command_line /= Void
			command_line_not_empty: not command_line.is_empty
			working_dir_not_null: working_directory /= Void
			time_interval_positive: time_interval > 0
			buffer_size_positive: buffer_size > 0
		local
			prc_ftry: PROCESS_FACTORY
			ee: EXECUTION_ENVIRONMENT
			dir: STRING
			err_thread: PROCESS_ERROR_LISTENER_THREAD
			out_thread: PROCESS_OUTPUT_LISTENER_THREAD
			prc_imp: PROCESS_IMP
			pt: PROCESS_VISION2_TIMER
		do
			create prc_ftry
			prc := prc_ftry.new_process_launcher_with_command_line (command_line, working_directory)						
			prc.redirect_input_to_stream
			prc_imp ?= prc			
			create err_thread.make (prc_imp)
			create out_thread.make (prc_imp)
			if redirection_needed then
				prc.redirect_input_to_stream
				prc.redirect_error_to_agent (error_handler)
				prc.redirect_output_to_agent (output_handler)				
			else
				prc.cancel_error_redirection
				prc.cancel_input_redirection
				prc.cancel_output_redirection
			end
			create pt.make (prc_imp, time_interval)
			prc.set_timer (pt)
	
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
			
			prc.set_hidden (is_hidden)
			prc.set_has_console (False)
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
			-- Terminate child process.
		do
			if launched and then (not has_exited) then
				prc.terminate
			end
		ensure
			process_terminated: launched implies has_exited
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
		
	last_operation_successful: BOOLEAN is
			-- Is last operation successful?
		do
			if prc /= Void then
				Result := prc.last_operation_successful
			else
				Result := True
			end			
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
	
	command_line: STRING
			-- Command line (with arguments) of child process
			
	working_directory: STRING
			-- Working directory of child process.
			
	time_interval: INTEGER
			-- Time interval for a timer to check the status of child process
	buffer_size: INTEGER
			-- Internal buffer size used to get output and error from child process
		
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

	initial_time_interval: INTEGER is 10
	initial_buffer_size: INTEGER is 50
				
end
