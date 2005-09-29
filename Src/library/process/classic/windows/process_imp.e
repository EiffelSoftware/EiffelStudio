indexing
	description: "Object that implements the PROCESS using Win32 API"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_IMP

inherit
	PROCESS
	
	THREAD_CONTROL
	
create
	make, make_with_command_line
	
feature {NONE} -- Initialization

	make (fname: STRING; a_working_directory: STRING; args: LIST[STRING]) is
		do
			file_name := fname
			create arguments.make
			
				-- make up a command_line
			command_line := file_name

			if args /= Void then				
				from
					args.start
				until
					args.after
				loop
					command_line.append (" ")
					command_line.append (args.item)
					arguments.extend(args.item)
					args.forth
				end
			end
			buffer_size := initial_buffer_size
			last_operation_successful := True
			working_directory := a_working_directory
			create eweasel_prc.make (command_line, working_directory)
		end
		
	make_with_command_line (c_line: STRING; a_working_directory: STRING) is
			--
		local
			ls: LIST [STRING]
			p_name :STRING
			args: ARRAYED_LIST [STRING]
		do
			ls := c_line.split (' ')
			create p_name.make_from_string (ls.i_th (1))
			ls.start
			ls.remove
			if ls.count > 0 then
				create args.make (ls.count)
				from 
					ls.start
				until
					ls.after
				loop
					args.extend (ls.item)	
					ls.forth
				end
			else
			end
			make (p_name, a_working_directory, args)
		end
		
feature{PROCESS_TIMER}  -- Status checking

	check_exit is
			-- Check whether process has exited.
		do
			if (launched and then has_process_exited) 
			then
				if out_thread /= Void then
					out_thread.set_exit_signal
				end
				if err_thread /= Void then
					err_thread.set_exit_signal
				end	
				wait_for_threads_to_exit	
				eweasel_prc.close		
				if (on_exit_handler /= Void) then
					on_exit		
				end
	
				if timer /= Void then
					timer.destroy				
				end			
			end
		end
		
feature{NONE} -- Actions

	on_start is
		-- Called when process launched.
		require
			on_start_handler_not_null: on_start_handler /= Void
		do
			on_start_handler.call ([])				
		end
		
	on_terminate is
			-- Called when process has been terminated.
		require
			on_terminate_handler_not_null: on_terminate_handler /= Void
		do
			on_terminate_handler.call ([])
		end
		
	on_exit is
			-- Called when process has exited.
		require
			on_exit_handler_not_null: on_exit_handler /= Void
		do
			on_exit_handler.call ([])
		end
		
	on_launch_failed is
			-- 
		do
			if on_launch_failed_handler /= Void then
				on_launch_failed_handler.call ([])
			end
			
		end
		
	on_launch_successed is
			-- 
		do
			if on_launch_successed_handler /= Void then
				on_launch_successed_handler.call ([])
			end
		end
				
feature	-- Control

	terminate is
		do
			if timer /= Void then
				timer.destroy
			end
			from
				
			until
				eweasel_prc.has_process_exited = True
			loop
				eweasel_prc.terminate				
			end
			if out_thread /= Void then
				out_thread.set_exit_signal
			end
			if err_thread /= Void then
				err_thread.set_exit_signal
			end		
					
			wait_for_threads_to_exit	
			eweasel_prc.close
			
			force_terminated := True
			
			if on_terminate_handler /= Void then
				on_terminate				
			end	

			if (on_exit_handler /= Void) then
				on_exit		
			end			
		end
		
	launch is
		local
			retried:BOOLEAN
			pt: PROCESS_THREAD_TIMER
		do
			if not retried then
				if hidden = True then
					eweasel_prc.run_hidden
				end
				
				if with_console then
					eweasel_prc.run_with_console
				end

				if on_start_handler /= Void then
					on_start_handler.call ([])
				end	
					
				eweasel_prc.launch (input_file_name, output_file_name, error_file_name,  buffer_size, error_redirection = To_same_as_output)
				
				last_operation_successful := eweasel_prc.last_operation_successful
				launched := last_operation_successful
				
				if launched then
--					end_of_output := False
--					end_of_error := False
					-- start a output listening thread is necessory
					if output_redirection = To_agent then
					   create out_thread.make (Current)	
					   out_thread.launch
					end
		
					-- start a error listening thread is necessory	
					if error_redirection /= To_same_as_output then
						if error_redirection = To_agent then
							create err_thread.make (Current)
							err_thread.launch
						end						
					end		
					on_launch_successed
					if timer /= Void then
						timer.start
					else
						create {PROCESS_THREAD_TIMER}timer.make (Current, initial_time_interval)
						timer.start
					end
				else
					on_launch_failed
				end
			end
		rescue
			retried := True
			if launched = True then
				
				if timer /= Void then
					timer.destroy				
				end	
								
				eweasel_prc.terminate
			
				if out_thread /= Void then
					out_thread.set_exit_signal
				end
			
				if err_thread /= Void then
					err_thread.set_exit_signal
				end		
					
				wait_for_threads_to_exit	
			
				eweasel_prc.close
					
				on_launch_failed									
			end
			launched := False
			retry
		end
		
	wait_for_exit is
		do
			eweasel_prc.wait_for_exit
		end

	put_string (s: STRING) is
		-- put a string into the child process's input stream
		local
			retried: BOOLEAN
		do
			if not retried then
				if not eweasel_prc.has_process_exited and then not s.is_empty then
					eweasel_prc.put_string (s)
					last_operation_successful := eweasel_prc.last_operation_successful
				end				
			end
		rescue
			retried := True
			last_operation_successful := False
			retry
		end
		
	read_error is
		do
			read_error_stream
		end

	read_error_stream is
			-- 
		do
			eweasel_prc.read_error_stream (buffer_size)
			last_error := eweasel_prc.last_error
			
			last_operation_successful := eweasel_prc.last_operation_successful			
		end
		
	read_output_stream is
			-- 
		do
			eweasel_prc.read_output_stream (buffer_size)
			last_output := eweasel_prc.last_string

			last_operation_successful := eweasel_prc.last_operation_successful			
		end	
			
	read_output is
		do
			read_output_stream
		end

feature -- Status report
		
	has_exited: BOOLEAN is
		do
			Result := has_process_exited
			if Result then
					-- Process was launched and exited. Let's check that 
					-- threads if any have exited as well.
				Result :=
					(out_thread /= Void implies out_thread.terminated) and
					(err_thread /= Void implies err_thread.terminated)
			end
		end	
				
	exit_code: INTEGER is
		do
			eweasel_prc.check_process_state
			last_operation_successful := eweasel_prc.last_operation_successful
			Result := eweasel_prc.last_process_result
		end
		
			
feature -- Status setting
		
	redirect_input_to_stream is
		do
			input_redirection := To_stream
			input_file_name := Void
		end
		
	redirect_input_to_file (fname: STRING) is
		do
			input_redirection := To_file
			input_file_name := fname
		end
		

	redirect_output_to_stream is
		do
			output_redirection := To_stream
			output_file_name := Void
			output_handler := Void
		end
		
	redirect_output_to_file (fname: STRING) is
		do
			output_redirection := To_file
			output_file_name := fname
			output_handler := Void
		end
		
	redirect_output_to_agent (a_output_handler: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- 
		do
			output_redirection := To_agent
			output_handler := a_output_handler
			output_file_name := Void
		end	
		
	redirect_error_to_same_as_output is
			-- 
		do
			error_redirection := To_same_as_output
			error_file_name := Void
			error_handler := Void
		end
		
	redirect_error_to_stream is	
			-- 
		do
			error_redirection := To_stream
			error_file_name := Void
			error_handler := Void
		end
	redirect_error_to_file (fname: STRING) is
			-- 
		do
			error_redirection := To_file
			error_file_name := fname
			error_handler := Void
		end
		
	redirect_error_to_agent (a_error_handler: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- 
		do
			error_redirection := To_agent
			error_handler := a_error_handler
			error_file_name := Void
		end	
		
	set_on_start_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- 
		do
			on_start_handler := handler
		end
		
	disable_on_start_handler is
			-- 
		do
			on_start_handler := Void
		end
		
	set_on_exit_handler (handler: ROUTINE [ANY, TUPLE [PROCESS]]) is
			-- 
		do
			on_exit_handler := handler
		end
		
	disable_on_exit_handler is
			-- 
		do
			on_exit_handler := Void
		end	
		
	set_on_terminate_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- 
		do
			on_terminate_handler := handler
		end
	
	disable_on_terminate_handler is
			-- 
		do
			on_terminate_handler := Void
		end	
		
	set_on_launch_failed_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- 
		do
			on_launch_failed_handler := handler
		end
	
	disable_on_launch_failed_handler is
			-- 
		do
			on_launch_failed_handler := Void
		end	
		
	set_on_launch_successed_handler (handler: ROUTINE [ANY, TUPLE]) is
		do	
			on_launch_successed_handler := handler
		end
		
	disable_on_launch_successed_handler is
		do				
			on_launch_successed_handler := Void
		end
		
	set_timer (pt: PROCESS_TIMER) is		
			-- 
		do
			timer := pt
		end

feature{PROCESS_IMP, PROCESS_TIMER_THREAD}

	out_thread: PROCESS_OUTPUT_LISTENER_THREAD
	err_thread: PROCESS_ERROR_LISTENER_THREAD
			-- Threads to listen to the output and error from child process.

feature {NONE} -- Implementation

	eweasel_prc: IO_REDIRECTION_PROCESS_LAUNCHER
			-- Win32 process launcher
			
	initial_buffer_size: INTEGER is 1024
	
	initial_time_interval: INTEGER is 1000
	
	has_process_exited: BOOLEAN is
			-- Has process exited?
		do
			Result := eweasel_prc.has_process_exited
		end
		
	wait_for_threads_to_exit is
			-- If parent process starts some listening threads,
			-- then wait for them to exit.
		require
			process_launched: launched = True

		do
			from
			until
				((out_thread /= Void) implies out_thread.terminated) and
				((err_thread /= Void) implies err_thread.terminated)
			loop
				sleep (100)
			end			
		end
	
invariant
	EWEASEL_launched_not_null: eweasel_prc /= Void
end
