note
	description: "Process launcher on .NET"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_IMP

inherit
	PROCESS

	THREAD_CONTROL
		export
			{NONE}all
		end

create
	make,
	make_with_command_line

feature{NONE} -- Initialization

	make (a_exec_name: STRING; args: detachable LIST [STRING]; a_working_directory: detachable STRING)
		local
			l_arg: STRING
		do
			create child_process.make
			create input_buffer.make_empty
			create exit_mutex.make
			create input_mutex.make

			create arguments.make
			create command_line.make_from_string (a_exec_name)
			create argument_line.make (128)
			executable := a_exec_name.twin
			if args /= Void and then not args.is_empty then
				from
					args.start
				until
					args.after
				loop
					l_arg := args.item
					if l_arg /= Void and then not l_arg.is_empty then
						argument_line.append_character (' ')
						if separated_words (l_arg).count > 1 then
							argument_line.append_character ('"')
							argument_line.append (l_arg)
							argument_line.append_character ('"')
						else
							argument_line.append (l_arg)
						end
					end
					args.forth
				end
				command_line.append (argument_line)
				argument_line.left_adjust
			end
			initialize_working_directory (a_working_directory)
			initialize_parameter
		ensure then
			executable_set: executable.is_equal (a_exec_name)
		end

	make_with_command_line (cmd_line: STRING; a_working_directory: detachable STRING)
			-- If directory name or file name in `cmd_line' includes space, use double quotes around
			-- those names.
		local
			cmd_arg: LIST [STRING]
		do
			create child_process.make
			create input_buffer.make_empty
			create exit_mutex.make
			create input_mutex.make

			create command_line.make_from_string (cmd_line)
			cmd_arg := separated_words (cmd_line)
			check not cmd_arg.is_empty end
			create executable.make_from_string (cmd_arg.i_th (1))
			if cmd_arg.count = 1 then
				create argument_line.make_empty
			else
				create argument_line.make_from_string (cmd_line.substring (executable.count + 1, cmd_line.count))
				argument_line.left_adjust
			end
			initialize_working_directory (a_working_directory)
			initialize_parameter
		end

feature -- Control

	launch
			-- Launch process.	
		local
			retried: BOOLEAN
			l_timeout: BOOLEAN
		do
			if not retried then
				if timer.has_started then
					l_timeout := timer.wait (0)
				end
				child_process.set_start_info (start_info)
				launched := child_process.start
				if launched then
					initialize_after_launch
					on_launch_successed
				else
					on_launch_failed
				end
			end
		rescue
			retried := True
			launched := False
			retry
		end

	terminate
			-- Terminate launched process.
		local
			retried: BOOLEAN
		do
			exit_mutex.lock
			if not retried then
				if not has_exited then
					child_process.kill
					last_termination_successful := True
					force_terminated := True
				end
			end
			exit_mutex.unlock
		rescue
			last_termination_successful := False
			force_terminated := False
			retried := True
			exit_mutex.unlock
			retry
		end

	terminate_tree
			-- Terminate process tree starting from current launched process.
		local
			retried: BOOLEAN
			l_prc: SYSTEM_DLL_PROCESS
		do
			exit_mutex.lock
			if not retried then
				if not has_exited then
					create l_prc.make
					l_prc.enter_debug_mode
					terminate_sub_tree (id, False)
					l_prc.leave_debug_mode
					if last_termination_successful or else not abort_termination_when_failed then
						child_process.kill
						last_termination_successful := True
						force_terminated := True
					end
				end
			end
			exit_mutex.unlock
		rescue
			last_termination_successful := False
			force_terminated := False
			retried := True
			exit_mutex.unlock
			retry
		end

	wait_for_exit
			-- Wait until process has exited.
		local
			l_wait: BOOLEAN
		do
			l_wait := timer.wait (0)
		end

	wait_for_exit_with_timeout (a_timeout: INTEGER)
			-- Wait launched process to exit for at most `a_timeout' milliseconds.
			-- Check `has_exited' after to see if launched process has exited.
		local
			l_timeout: BOOLEAN
		do
			l_timeout := not timer.wait (a_timeout)
		end

feature{PROCESS_TIMER} -- Process status checking

	check_exit
			-- Check if process has exited.
		local
			l_threads_exited: BOOLEAN
			l_in_thread: like in_thread
			l_out_thread: like out_thread
			l_err_thread: like err_thread
		do
			exit_mutex.lock
			if not has_exited then
				l_in_thread := in_thread
				l_out_thread := out_thread
				l_err_thread := err_thread
				if not process_has_exited then
					process_has_exited := child_process.has_exited
					if process_has_exited then
						internal_exit_code := child_process.exit_code
						if l_in_thread /= Void then
							l_in_thread.set_exit_signal
						end
						if l_out_thread /= Void then
							l_out_thread.set_exit_signal
						end
						if l_err_thread /= Void then
							l_err_thread.set_exit_signal
						end
					end
				else
					l_threads_exited := ((l_in_thread /= Void) implies l_in_thread.terminated) and
							  ((l_out_thread /= Void) implies l_out_thread.terminated) and
							  ((l_err_thread /= Void) implies l_err_thread.terminated)
					if l_threads_exited then
						if not has_cleaned_up then
							timer.destroy
							input_buffer.clear_all
							child_process.close
							has_cleaned_up := True
							if force_terminated then
								on_terminate
							else
								on_exit
							end
						end
					end
				end
			end
			exit_mutex.unlock
		end

feature -- Interprocess data transmission

	put_string (s: STRING)
			-- Send `s' into launched process as its input data.
		do
			append_input_buffer (s)
		end

feature -- Status reporting

	id: INTEGER
		do
			Result := internal_id
		end

	has_exited: BOOLEAN
		do
			Result := has_cleaned_up
		end

	exit_code: INTEGER
		do
			Result := internal_exit_code
		end

feature{NONE} -- Interprocess IO

	input_buffer: STRING
			-- Buffer used to store input data of process
			-- This buffer is used temporarily to store data that can not be
			-- consumed by launched process.

	append_input_buffer (a_input:STRING)
			-- Append `a_input' to `input_buffer'.
		require
			a_input_not_void: a_input /= Void
		do
			input_mutex.lock
			input_buffer.append (a_input)
			input_mutex.unlock
		end

feature{PROCESS_IO_LISTENER_THREAD} -- Interprocess data transimission

	write_input_stream
			-- Write at most `buffer_size' bytes of data in `input_buffer' into launched process.
			--|Note: This feature will be used in input listening thread.			
		require
			process_running: is_running
			input_redirected_to_stream_or_file:
				input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream or
				input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file
		local
			l_cnt: INTEGER
			l_left: INTEGER
			l_str: detachable STRING
		do
			check
				input_buffer_set:
					input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream implies input_buffer /= Void
				input_file_set:
					input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file implies input_file /= Void and then input_file.is_open_read
			end
			if input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream then
				input_mutex.lock
				l_cnt := input_buffer.count
				if l_cnt > 0 then
					last_input_bytes := l_cnt.min (buffer_size)
					create l_str.make (last_input_bytes)
					l_left := l_cnt - last_input_bytes
					l_str.append (input_buffer.substring (1, last_input_bytes))
					input_buffer.keep_tail (l_left)
				else
					last_input_bytes := 0
				end
				input_mutex.unlock
			elseif input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
				check input_file /= Void end
				if not input_file.end_of_file then
					input_file.read_stream (buffer_size)
					l_str := input_file.last_string
					last_input_bytes := l_str.count
				else
					last_input_bytes := 0
					l_str := Void
				end
			end
			if l_str /= Void and then attached child_process.standard_input as l_writer then
				l_writer.write_string (l_str)
			end
		end

	read_output_stream
			-- Read output stream from launched process and dispatch data to `output_handler'.
			--|Note: This feature will be used in output listening thread.
		require
			process_running: is_running
			output_redirected_to_agent_or_file:
				output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent or
				output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file
		local
			i: INTEGER
			l_output: STRING
			l_reader: detachable STREAM_READER
			l_output_handler: like output_handler
		do
			check
				output_handler_set:
					output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent implies output_handler /= Void
				output_file_set:
					output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file implies output_file /= Void and then output_file.is_open_write
				output_buffer_set: output_buffer /= Void
			end
			l_reader := child_process.standard_output
			check l_reader_attached: l_reader /= Void end
			last_output_bytes := l_reader.read_block (output_buffer, 0, buffer_size)
			if last_output_bytes > 0 then
				create l_output.make (last_output_bytes)
				from
					i:=0
				until
					i = last_output_bytes
				loop
					l_output.append_character (output_buffer.item (i))
					i := i + 1
				end
				if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent then
					l_output_handler := output_handler
					check l_output_handler_attached: l_output_handler /= Void end
					l_output_handler.call ([l_output])
				elseif output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
					check output_file_attached: output_file /= Void end
					output_file.put_string (l_output)
				end
			end
		end

	read_error_stream
			-- Read output stream from launched process and dispatch data to `output_handler'.
			--|Note: This feature will be used in error listening thread.			
		require
			process_running: is_running
			error_redirected_to_agent_or_file:
				error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent or
				error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file
		local
			i: INTEGER
			l_error: STRING
			l_reader: detachable STREAM_READER
			l_error_handler: like error_handler
		do
			check
				error_handler_set:
					error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent implies error_handler /= Void
				error_file_set:
					error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file implies error_file /= Void and then error_file.is_open_write
				error_buffer_set: error_buffer /= Void
			end
			l_reader := child_process.standard_error
			check l_reader_attached: l_reader /= Void end
			last_error_bytes := l_reader.read_block (error_buffer, 0, buffer_size)
			if last_error_bytes > 0 then
				create l_error.make (last_error_bytes)
				from
					i:=0
				until
					i = last_error_bytes
				loop
					l_error.append_character (error_buffer.item (i))
					i := i + 1
				end
				if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent then
					l_error_handler := error_handler
					check l_error_handler_attached: l_error_handler /= Void end
					l_error_handler.call ([l_error])
				elseif  error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
					check error_file_attached: error_file /= Void end
					error_file.put_string (l_error)
				end
			end
		end

	last_output_bytes: INTEGER
			-- Number of bytes of data read from output of process

	last_error_bytes: INTEGER
			-- Number of bytes of data read from error of process

	last_input_bytes: INTEGER
			-- Number of bytes in `input_buffer' wrote to process the last time


feature{NONE} -- Implementation

	start_info: SYSTEM_DLL_PROCESS_START_INFO
			-- Process start information
		require
			process_not_running: not is_running
		local
			l_environ_tbl: like environment_variable_table
			l_key, l_value: SYSTEM_STRING
		do
			create Result.make_from_file_name_and_arguments (executable, argument_line)
			if attached working_directory as l_dir then
				Result.set_working_directory (l_dir)
			end
			if hidden then
				Result.set_window_style ({SYSTEM_DLL_PROCESS_WINDOW_STYLE}.hidden)
			else
				Result.set_window_style ({SYSTEM_DLL_PROCESS_WINDOW_STYLE}.normal)
			end
			if separate_console then
				Result.set_create_no_window (False)
			else
				Result.set_create_no_window (True)
			end
			l_environ_tbl := environment_variable_table
			if not is_io_redirected and then (l_environ_tbl = Void or else l_environ_tbl.is_empty) then
					-- No IO redirection and no environment variable.
				Result.set_use_shell_execute (True)
			else
				Result.set_use_shell_execute (False)
				Result.set_redirect_standard_input (input_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection)
				Result.set_redirect_standard_output (output_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection)
				Result.set_redirect_standard_error (error_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection)
			end
			if l_environ_tbl /= Void and then not l_environ_tbl.is_empty and then attached Result.environment_variables as l_environ_dic then
				from
					l_environ_tbl.start
				until
					l_environ_tbl.after
				loop
					if l_environ_tbl.key_for_iteration /= Void and then l_environ_tbl.item_for_iteration /= Void then
						l_key := l_environ_tbl.key_for_iteration
						l_value := l_environ_tbl.item_for_iteration
						if l_environ_dic.contains_key (l_key) then
							l_environ_dic.remove (l_key)
						end
						l_environ_dic.add (l_key, l_value)
					end
					l_environ_tbl.forth
				end
			end
		end

	initialize_after_launch
			-- Initialize when process has been launched successfully.
		do
			if not child_process.has_exited then
				internal_id := child_process.id
			end
			process_has_exited := False
			force_terminated := False
			last_termination_successful := True
			has_cleaned_up := False
			ending_handler_called := False
			start_listening_threads
		end

	start_listening_threads
			-- Start listening threads.
		local
			l_input_file_name: like input_file_name
			l_output_file_name: like output_file_name
			l_error_file_name: like error_file_name
			l_in_thread: like in_thread
			l_out_thread: like out_thread
			l_err_thread: like err_thread
		do
			if input_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
				create input_buffer.make (4096)
				if input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
					l_input_file_name := input_file_name
					check l_input_file_name_attached: l_input_file_name /= Void end
					create input_file.make (l_input_file_name)
					check
						input_file_exists: input_file.exists
					end
					input_file.open_read
				end
				create l_in_thread.make (Current)
				in_thread := l_in_thread
				l_in_thread.launch
			else
				in_thread := Void
			end
			if output_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
				create output_buffer.make (0, buffer_size)
				if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
					l_output_file_name := output_file_name
					check l_output_file_name_attached: l_output_file_name /= Void end
			  		create output_file.make_create_read_write (l_output_file_name)
				end
				create l_out_thread.make (Current)
				out_thread := l_out_thread
				l_out_thread.launch
			else
				out_thread := Void
			end
			if error_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection then
				create error_buffer.make (0, buffer_size)
				if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
					l_error_file_name := error_file_name
					check l_error_file_name_attached: l_error_file_name /= Void end
					create error_file.make_create_read_write (l_error_file_name)
				end
				create l_err_thread.make (Current)
				err_thread := l_err_thread
				l_err_thread.launch
			else
				err_thread := Void
			end

			check timer.destroyed end
			timer.start
		end

feature{NONE} -- Implementation

	try_terminate_process (a_process: like child_process)
			-- Try to terminate process `a_process'.
			-- Set `last_termination_successful' with True if succeeded.
		require
			a_process_not_void: a_process /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if not a_process.has_exited then
					a_process.kill
				end
				last_termination_successful := True
			end
		rescue
			last_termination_successful := False
			retried := True
			retry
		end

	terminate_sub_tree (pid: INTEGER; is_self: BOOLEAN)
			-- Try to termiate all sub-processes of process `pid'.
			-- If `is_self' is True, terminate `pid' after all its child processes have
			-- been terminated.
			-- Set `last_termination_successful' to True if succeeded.
		local
			child_prc_list: LIST [INTEGER]
			child_prc_list2: LIST [INTEGER]
			l_success: BOOLEAN
			done: BOOLEAN
			l_prc: detachable SYSTEM_DLL_PROCESS
		do
			l_success := True
			child_prc_list := direct_subprocess_list (pid)
			if not child_prc_list.is_empty then
				from
				until
					done or (not l_success and abort_termination_when_failed)
				loop
					from
						child_prc_list.start
					until
						child_prc_list.after or not l_success
					loop
						terminate_sub_tree (child_prc_list.item, True)
						l_success := last_termination_successful
						if l_success or else not abort_termination_when_failed then
							child_prc_list.forth
						end
					end
					if l_success or not abort_termination_when_failed then
							-- Check if there is new spawned sub-process.
						child_prc_list2 := direct_subprocess_list (pid)
						if child_prc_list2.is_empty then
							done := True
						else
							from
								child_prc_list2.start
							until
								child_prc_list2.after
							loop
								if child_prc_list.has (child_prc_list2.item) then
										-- We don't terminate a process more than once.
									child_prc_list2.remove
								else
									child_prc_list2.forth
								end
							end
							if child_prc_list2.is_empty then
								done := True
							else
								child_prc_list := child_prc_list2
							end
						end
					end
				end
			end
			if l_success or else not abort_termination_when_failed then
				if is_self then
					l_prc := process_by_id (pid)
					if l_prc /= Void then
						try_terminate_process (l_prc)
					else
						last_termination_successful := True
					end
				end
			end
		end

	process_by_id (pid: INTEGER): detachable SYSTEM_DLL_PROCESS
			-- Process instance whose id is `pid'
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := {SYSTEM_DLL_PROCESS}.get_process_by_id (pid)
			end
		rescue
			Result := Void
			retried := True
			retry
		end

	direct_subprocess_list (parent_id: INTEGER): LIST [INTEGER]
			-- List of direct subprocess ids of process indicated by id `parent_id'.
		local
			p_tbl: like process_id_pair_list
		do
			create {LINKED_LIST [INTEGER]}Result.make
			p_tbl := process_id_pair_list
			if p_tbl /= Void then
				from
					p_tbl.start
				until
					p_tbl.after
				loop
					if p_tbl.item.parent_id = parent_id then
						Result.extend (p_tbl.item.pid)
					end
					p_tbl.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	process_id_pair_list: LINKED_LIST [TUPLE [parent_id: INTEGER; pid: INTEGER]]
			--
		local
			l_cat: SYSTEM_DLL_PERFORMANCE_COUNTER_CATEGORY
			l_process_list: detachable NATIVE_ARRAY [detachable SYSTEM_STRING]
			i, l_upper: INTEGER
			l_prc_name_id_tbl: HASH_TABLE [INTEGER, STRING]
			l_performance_counter: SYSTEM_DLL_PERFORMANCE_COUNTER
		do
			create Result.make

				-- Get process snapshot and store process instance name and its process id in `l_prc_name_id_tbl'.
			create l_cat.make_from_category_name (once "Process")
			l_process_list := l_cat.get_instance_names
			if l_process_list /= Void then
				create l_prc_name_id_tbl.make (l_process_list.count)
				from
					i := l_process_list.lower
					l_upper := l_process_list.upper
				until
					i > l_upper
				loop
					if attached l_process_list.item (i) as l_process_name then
						create l_performance_counter.make_with_category_name (once "Process", once "ID Process", l_process_name, True)
						l_prc_name_id_tbl.force (l_performance_counter.raw_value.as_integer_32, l_process_name)
					end
					i := i + 1
				end
					-- Find out parent process id for each process in `l_prc_name_id_tbl'.
				from
					l_prc_name_id_tbl.start
				until
					l_prc_name_id_tbl.after
				loop
					Result.extend ([parent_process_id (l_prc_name_id_tbl.key_for_iteration), l_prc_name_id_tbl.item_for_iteration])
					l_prc_name_id_tbl.forth
				end
			end
		end

	parent_process_id (a_process_instance_name: SYSTEM_STRING): INTEGER
			-- Parent process id of process named `a_process_instance_name'
		require
			a_process_instance_name_attached: a_process_instance_name /= Void
		local
			l_performance_counter: SYSTEM_DLL_PERFORMANCE_COUNTER
		do
			create l_performance_counter.make_from_category_name_and_counter_name_and_instance_name (once "Process", once "Creating Process ID", a_process_instance_name)
			Result := l_performance_counter.raw_value.as_integer_32
		end

	process_instance_name (a_pid: INTEGER; a_process_list: detachable NATIVE_ARRAY [detachable SYSTEM_STRING]): detachable STRING
			-- Process instance name of process id `a_pid' in `a_process_list'		
		require
			a_process_list_attached: a_process_list /= Void
		local
			l_performance_counter: SYSTEM_DLL_PERFORMANCE_COUNTER
			l_upper: INTEGER
			i: INTEGER
			done: BOOLEAN
		do
			if a_process_list.count > 0 then
				from
					i := a_process_list.lower
					l_upper := a_process_list.upper
				until
					i > l_upper or done
				loop
					create l_performance_counter.make_with_category_name (once "Process", once "ID Process", a_process_list.item (i), True)
					done := a_pid = l_performance_counter.raw_value.as_integer_32
					if not done then
						i := i + 1
					end
				end
				if done and then attached a_process_list.item (i) as l_process_name then
					Result := l_process_name
				end
			end
		end

feature{NONE} -- Implementation

	is_io_redirected: BOOLEAN
			-- Is input, output or error redirected?
		do
			Result := input_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection or
					  output_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection or
					  error_direction /= {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
		end

	child_process: SYSTEM_DLL_PROCESS
		-- Class used to manipulate a process

	executable: STRING
			-- Program which will be launched

	argument_line: STRING
			-- Argument list of `executable'

	out_thread: detachable PROCESS_OUTPUT_LISTENER_THREAD
	err_thread: detachable PROCESS_ERROR_LISTENER_THREAD
	in_thread: detachable PROCESS_INPUT_LISTENER_THREAD
			-- Threads to listen to output and error from child process.

	input_mutex: MUTEX
	exit_mutex: MUTEX
		-- Mutex used to synchorinze listening threads			

	input_file: detachable RAW_FILE note option: stable attribute end
	output_file: detachable RAW_FILE note option: stable attribute end
	error_file: detachable RAW_FILE note option: stable attribute end

	output_buffer: detachable ARRAY [CHARACTER] note option: stable attribute end
			-- Buffer used to read output from process

	error_buffer: detachable ARRAY [CHARACTER] note option: stable attribute end
			-- Buffer used to read error from process	

	process_has_exited: BOOLEAN
			-- Has process exited?

	has_cleaned_up: BOOLEAN
			-- Has clean up finished when launched exited?
			-- Clean up includes close io redirection pipes and process handle.

	ending_handler_called: BOOLEAN
			-- Has `on_exit_handler' or `on_terminate_handler' been called?

	internal_exit_code: INTEGER
			-- Internal exit code

	internal_id: INTEGER
			-- Internal process id

	environment_table_as_pointer: POINTER
			-- {POINTER} representation of `environment_variable_table'
			-- Return `default_pointer' if `environment_variable_table' is Void or empty.
		do
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
