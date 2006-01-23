indexing
	description: "Object that implements PROCESS."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_IMP

inherit
	PROCESS
		redefine
			set_buffer_size
		end
		
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
			executable := a_exec_name
			argument_line := ""
			if args /= Void then				
				from
					args.start
				until
					args.after
				loop
					argument_line.append (" ")
					argument_line.append (args.item)
					command_line.append (" ")
					command_line.append (args.item)
					arguments.extend(args.item)
					args.forth
				end
			end
			argument_line.left_adjust
			
			input_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			output_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			error_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			set_buffer_size (initial_buffer_size)
			last_operation_successful := True
			if a_working_directory /= Void then
				create working_directory.make_from_string (a_working_directory)
			else
				working_directory := Void
			end
			hidden := False
			has_console := True
			create prc_launcher.make
		ensure then
			executable_set: executable.is_equal (a_exec_name)
		end
		
	make_with_command_line (cmd_line: STRING; a_working_directory: STRING) is
			--
		local
			ls: LIST [STRING]
			p_name :STRING
			cmd_arg: LIST [STRING]
		do
			executable := ""
			argument_line := ""
				
			cmd_arg := parse_command_line (cmd_line)
			
			executable := cmd_arg.i_th (1)
			argument_line := cmd_arg.i_th (2)

			if a_working_directory /= Void then
				create working_directory.make_from_string (a_working_directory)
			else
				working_directory := Void
			end
			
			input_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			output_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			error_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			set_buffer_size (initial_buffer_size)
			last_operation_successful := True
			
			hidden := False
			has_console := True
			create prc_launcher.make
		end

feature {PROCESS_TIMER}  -- Status checking

	check_exit is
			-- Check whether process has exited.
		do
			if (launched and then prc_launcher.has_exited) 
			then
				if in_thread /= Void then
					in_thread.set_exit_signal
				end
				if out_thread /= Void then
					out_thread.set_exit_signal
				end
				if err_thread /= Void then
					err_thread.set_exit_signal
				end	
				wait_for_threads_to_exit	
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
				prc_launcher.kill
				if in_thread /= Void then
					in_thread.set_exit_signal
				end
				if out_thread /= Void then
					out_thread.set_exit_signal
				end
				if err_thread /= Void then
					err_thread.set_exit_signal
				end		
				wait_for_threads_to_exit	
											
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
			startup_info: SYSTEM_DLL_PROCESS_START_INFO
			l_flag: BOOLEAN
			retried :BOOLEAN	
		do
			if not retried then
				
				if timer /= Void then
					wait_for_timer_to_be_destroyed
				end				
				
				launched := False
				on_start
				create prc_launcher.make
				create startup_info.make_from_file_name_and_arguments (executable, argument_line)
				if working_directory /= Void then
					startup_info.set_working_directory (working_directory)				
				end
				if hidden then
					startup_info.set_window_style ({SYSTEM_DLL_PROCESS_WINDOW_STYLE}.hidden)
				else
					startup_info.set_window_style ({SYSTEM_DLL_PROCESS_WINDOW_STYLE}.normal)					
				end
				if has_console then
					startup_info.set_create_no_window (False)
				else
					startup_info.set_create_no_window (True)
				end
				startup_info.set_create_no_window (False)
				startup_info.set_window_style ({SYSTEM_DLL_PROCESS_WINDOW_STYLE}.normal)
				
				l_flag := 
					input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection and
					output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection and
					error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
				
				if l_flag then
						-- No IO redirection
					startup_info.set_use_shell_execute (True)
				else
					startup_info.set_use_shell_execute (False)
						-- Input redirection
					
					if input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
						startup_info.set_redirect_standard_input (False)
					else
							-- Input redirected
						startup_info.set_redirect_standard_input (True)	
											
					end
					
					if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
						startup_info.set_redirect_standard_output (False)
					else
							-- output redirected
						startup_info.set_redirect_standard_output (True)						
					end	
					
					if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
						startup_info.set_redirect_standard_error (False)
					else
							-- error redirected
						startup_info.set_redirect_standard_error (True)						
					end										
				end
				prc_launcher.set_start_info (startup_info)
				launched := prc_launcher.start
				last_operation_successful := launched
				if launched then
					if input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
						create in_thread.make (Current)
						in_thread.launch
					else
						in_thread := Void
					end
					if output_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
						create out_thread.make (Current)
						out_thread.launch	
					else					
						out_thread := Void
					end
					if error_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
						create err_thread.make (Current)
						err_thread.launch						
					else					
						err_thread := Void
					end
					if timer /= Void then
						timer.start
					else
						create {PROCESS_THREAD_TIMER}timer.make (initial_time_interval // 1000)
						timer.set_process_launcher (Current)
						timer.start
					end
					
					on_launch_successed
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
				prc_launcher.kill
			
				if in_thread /= Void then
					in_thread.set_exit_signal
				end
				if out_thread /= Void then
					out_thread.set_exit_signal
				end
			
				if err_thread /= Void then
					err_thread.set_exit_signal
				end		
					
				wait_for_threads_to_exit	
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
		-- put a string into the child process's input stream
		local
			retried: BOOLEAN
		do
			if not retried then
				prc_launcher.standard_input.write_string (s)
				last_operation_successful := True			
			end
		rescue
			retried := True
			last_operation_successful := False
			retry
		end
		
	set_buffer_size (size: INTEGER) is
			-- Set `buffer_size' with `size'.
		do
			buffer_size := size
			if output_buffer = Void then
				create output_buffer.make (0, size + 10)
			else
				output_buffer.clear_all
				output_buffer.conservative_resize (0, size+ 10)							
			end
			if error_buffer = Void then
				create error_buffer.make (0, size+ 10)
			else
				error_buffer.clear_all
				error_buffer.conservative_resize (0, size+ 10)				
			end
		end		

feature -- Status report
		
	has_exited: BOOLEAN is
		do
			Result := prc_launcher.has_exited
			if Result then
					-- Process was launched and exited. Let's check that 
					-- threads if any have exited as well.
				Result :=
					(out_thread /= Void implies out_thread.terminated) and
					(err_thread /= Void implies err_thread.terminated) and
					(in_thread /= Void implies in_thread.terminated)
			end
			
		end	
				
	exit_code: INTEGER is
		do
			Result := prc_launcher.exit_code
		end
		
	ccc: INTEGER		
		
feature {PROCESS_IO_LISTENER_THREAD} -- Interprocess data transmit

	last_output: STRING
			-- Last output received from process

	last_error: STRING
			-- Last error received from process

	read_output_stream is
			-- Read output stream of process and store
			-- data read, if any, in `last_output'
 		local
 			l_cnt: INTEGER
 			i: INTEGER
 			retried: BOOLEAN
		do
			if not retried then
				l_cnt := prc_launcher.standard_output.read_block (output_buffer, 0, buffer_size)	
				if l_cnt > 0 then
					if last_output = Void then
						last_output := ""
					else
						last_output.clear_all						
					end

					from
						i:=0
					until
						i = l_cnt
					loop
						last_output.append_character (output_buffer.item (i))
						i:=i+1
					end			
				else
					last_output := Void
				end	
				last_operation_successful := True			
			end
		rescue
			retried := True
			last_operation_successful := False
			last_output := Void
		end	
			

		
	read_error_stream is
			-- Read error stream of process and store
			-- data read, if any, in `last_error'
 		local
 			l_cnt: INTEGER
 			i: INTEGER
 			retried: BOOLEAN
		do
			if not retried then
				l_cnt := prc_launcher.standard_error.read_block (error_buffer, 0, buffer_size)	
				if l_cnt >0 then
					if last_error = Void then
						last_error := ""
					else
						last_error.clear_all						
					end
	
					from
						i:=0
					until
						i = l_cnt
					loop
						last_error.append_character (error_buffer.item (i))
						i:=i+1
					end	
				else	
					last_error := Void
				end
				last_operation_successful := True			
			end
		rescue
			retried := True
			last_operation_successful := False
			last_error := Void
		end		

feature {PROCESS_IMP} -- Implementation
		
	in_thread: DOTNET_PROCESS_INPUT_LISTENER_THREAD
	out_thread: DOTNET_PROCESS_OUTPUT_LISTENER_THREAD
	err_thread: DOTNET_PROCESS_ERROR_LISTENER_THREAD
			-- Threads to listen to input, output and error from child process
	
feature{NONE} -- Implementation

	output_buffer: ARRAY [CHARACTER]
			-- Buffer used to read output from process
		
	error_buffer: ARRAY [CHARACTER]
			-- Buffer used to read error from process

	executable: STRING
			-- Program which will be launched
	
	argument_line: STRING
			-- Argument list of `executable'
			
	initial_buffer_size: INTEGER is 1024
			-- Initial size of buffer used to store interprocess data temporarily
	
	initial_time_interval: INTEGER is 1000
			-- Initial time interval in nanoseconds used to check process status
			
		
	wait_for_threads_to_exit is
			-- If parent process starts some listening threads,
			-- then wait for them to exit.
		require
			process_launched: launched = True
		do	
			from
			until
				((out_thread /= Void) implies out_thread.terminated) and
				((err_thread /= Void) implies err_thread.terminated) and
				((in_thread /= Void) implies in_thread.terminated)
			loop
				sleep (initial_time_interval)
			end	
			in_thread := Void
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

	parse_command_line (a_cmd_line: STRING): LIST [STRING] is	
			-- Parse command line `a_cmd_line' and return a list 
			-- of 2 items, the first item is program name, the second 
			-- item is argument list (if any).
		require
			a_cmd_line_not_void: a_cmd_line /= Void
			a_cmd_line_not_empty: not a_cmd_line.is_empty
		local
			i: INTEGER
			done: BOOLEAN
			cnt: INTEGER
			in_quote: BOOLEAN
			c: CHARACTER
			cmd_line: STRING
			cmd: ARRAYED_LIST [STRING]
		do
			from
				i := 1
				create cmd_line.make_from_string (a_cmd_line)
				cmd_line.left_adjust
				cnt := cmd_line.count
				done := False
				in_quote := False
			until
				i > cnt or done
			loop
				c := cmd_line.item (i)
				inspect
					c
				when '%"' then
					if in_quote then
						in_quote := False
					else
						in_quote := True
					end	
					i := i + 1
				when ' ' then
					if not in_quote then
						done := True
					else
						i := i + 1
					end
				else
					i := i + 1
				end
			end
			create cmd.make (2)
			if not done then
				cmd.extend (cmd_line)
				cmd.extend ("")
			else
				cmd.extend (cmd_line.substring (1, i-1))
				if i < cnt then
					cmd.extend (cmd_line.substring (i + 1, cnt))
				else
					cmd.extend ("")
				end
			end
			Result := cmd
		end	
		
	prc_launcher: SYSTEM_DLL_PROCESS
		-- Class used to manipulate a process on .Net

invariant
	prc_launcher_not_void: prc_launcher /= Void

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
