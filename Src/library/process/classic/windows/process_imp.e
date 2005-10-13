indexing
	description: "Object that implements PROCESS."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_IMP

inherit
	PROCESS
	
	THREAD_CONTROL
		export
			{NONE} all
		end
	
create
	make, make_with_command_line
	
feature {NONE} -- Initialization

	make (a_exec_name: STRING; args: LIST[STRING]; a_working_directory: STRING) is
		do
			create arguments.make			
				-- make up a command_line
			create command_line.make_from_string (a_exec_name)

			if args /= Void then				
				from
					args.start
				until
					args.after
				loop
					command_line.append (" ")
					command_line.append (args.item)
					arguments.extend (args.item)
					args.forth
				end
			end
			input_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			output_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			error_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection			
			buffer_size := initial_buffer_size
			last_operation_successful := True
			if a_working_directory = Void then
				working_directory := ""
			else
				create working_directory.make_from_string (a_working_directory)
			end

			hidden := False
			has_console := True
			last_error := Void
			last_output := Void
			create prc_launcher.make (command_line, working_directory)
		end
		
	make_with_command_line (cmd_line: STRING; a_working_directory: STRING) is
		local
			ls: LIST [STRING]
			p_name :STRING
			args: ARRAYED_LIST [STRING]
		do
			ls := cmd_line.split (' ')
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
			make (p_name, args, a_working_directory)
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
				prc_launcher.close	
				if timer /= Void then
					timer.destroy				
				end	

				on_exit		
			end
		end
				
feature	-- Control

	terminate is
		local
			retried: BOOLEAN
		do
			if not retried then
				if timer /= Void then
					timer.destroy
				end
				wait_for_timer_to_be_destroyed
				from
					
				until
					prc_launcher.has_process_exited = True
				loop
					prc_launcher.terminate				
				end
				if out_thread /= Void then
					out_thread.set_exit_signal
				end
				if err_thread /= Void then
					err_thread.set_exit_signal
				end		
						
				wait_for_threads_to_exit	
				prc_launcher.close								
				force_terminated := True				
				last_operation_successful := True	
				on_terminate							
			end
		rescue		
			retried := True
			last_operation_successful := False
			force_terminated := False
			if timer /= Void and then timer.destroyed then
				timer.start
			end
			retry
		end
		
	launch is
		local
			retried:BOOLEAN
			l_in_fname: STRING
			l_out_fname: STRING
			l_err_fname: STRING
		do
			if not retried then
				if timer /= Void then
					wait_for_timer_to_be_destroyed
				end				
				
				on_start
				
				launched := False
				force_terminated := False
				
				if hidden = True then
					prc_launcher.run_hidden
				end
				
				prc_launcher.set_has_console (has_console)
				
				if input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
					l_in_fname := ""
				else
					l_in_fname := input_file_name
				end
				
				if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
					l_out_fname := ""
				else
					l_out_fname := output_file_name
				end	
							
				if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
					l_err_fname := ""
				else
					l_err_fname := error_file_name
				end	
				prc_launcher.set_input_direction (input_direction)
				prc_launcher.set_output_direction (output_direction)
				prc_launcher.set_error_direction (error_direction)
				
				prc_launcher.launch (l_in_fname, l_out_fname, l_err_fname,  buffer_size)
				
				last_operation_successful := prc_launcher.last_operation_successful
				launched := last_operation_successful
				
				if launched then
					-- start a output listening thread is necessory
					if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent then
					   create out_thread.make (Current)	
					   out_thread.launch
					else
						out_thread := Void
					end
		
					-- start a error listening thread is necessory	
					if error_direction /= {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output then
						if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent then
							create err_thread.make (Current)
							err_thread.launch
						else
							err_thread := Void
						end						
					end		
					on_launch_successed
					if timer /= Void then
						timer.start
					else
						create {PROCESS_THREAD_TIMER}timer.make (initial_time_interval // 1000)
						timer.set_process_launcher (Current)
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
				wait_for_timer_to_be_destroyed		
				prc_launcher.terminate
			
				if out_thread /= Void then
					out_thread.set_exit_signal
				end
			
				if err_thread /= Void then
					err_thread.set_exit_signal
				end		
					
				wait_for_threads_to_exit	
			
				prc_launcher.close
					
				on_launch_failed
										
			end
			launched := False
			last_operation_successful := False
			retry
		end
		
	wait_for_exit is
		do
			prc_launcher.wait_for_exit
			wait_for_threads_to_exit
			wait_for_timer_to_be_destroyed
		end

	put_string (s: STRING) is
		local
			retried: BOOLEAN
		do
			if not retried then
				if not prc_launcher.has_process_exited and then not s.is_empty then
					prc_launcher.put_string (s)
					last_operation_successful := prc_launcher.last_operation_successful
				end				
			end
		rescue
			retried := True
			last_operation_successful := False
			retry
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
			prc_launcher.check_process_state
			last_operation_successful := prc_launcher.last_operation_successful
			Result := prc_launcher.last_process_result
		end

feature{PROCESS_IMP} -- Implementation

	out_thread: PROCESS_OUTPUT_LISTENER_THREAD
	err_thread: PROCESS_ERROR_LISTENER_THREAD
			-- Threads to listen to output and error from child process.

feature{PROCESS_IO_LISTENER_THREAD} -- Interprocess data transmit

	last_output: STRING
			-- Last output received from process

	last_error: STRING
			-- Last error received from process

	read_output_stream is
			-- Read output stream of process and store data read, if any, in `last_output'.
		do
			prc_launcher.read_output_stream (buffer_size)
			last_output := prc_launcher.last_string
			last_operation_successful := prc_launcher.last_operation_successful			
		end	
				
	read_error_stream is
			-- Read error stream of process and store data read, if any, in `last_error'.
		do
			prc_launcher.read_error_stream (buffer_size)
			last_error := prc_launcher.last_error
			last_operation_successful := prc_launcher.last_operation_successful			
		end
		
feature {NONE} -- Implementation
		
	prc_launcher: IO_REDIRECTION_PROCESS_LAUNCHER
			-- Process launcher 
			
	initial_buffer_size: INTEGER is 1024
			-- Initial size of buffer used to store interprocess data temporarily
	
	initial_time_interval: INTEGER is 10000
			-- Initial time interval in nanoseconds used to check process status
			
	has_process_exited: BOOLEAN is
			-- Has process exited?
		do
			Result := prc_launcher.has_process_exited
		end
		
	wait_for_threads_to_exit is
			-- If parent process starts some listening threads, then wait for them to exit.
		require
			process_launched: launched
		do
			from
			until
				((out_thread /= Void) implies out_thread.terminated) and
				((err_thread /= Void) implies err_thread.terminated)
			loop
				sleep (initial_time_interval)
			end	
			out_thread := Void
			err_thread := Void		
		end
		
	wait_for_timer_to_be_destroyed is
			-- Wait for timer to be destroyed.
		do
			if timer /= Void then
				from
					
				until
					timer.destroyed
				loop
					sleep (initial_time_interval)
				end
			end
		end

invariant
	prc_launcher_not_void: prc_launcher /= Void
end
