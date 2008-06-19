indexing
	description:
		"[
			Object that implements PROCESS on UNIX
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_IMP

inherit
	PROCESS

	PROCESS_UNIX_OS
		export
			{NONE}all
		end

	PROCESS_INFO_IMP
		rename
			command_line as environment_command_line,
			launch as environment_launch
		export
			{NONE}all
		end

	EXCEPTIONS
		rename
			ignore as exce_ignore,
			catch as exec_catch
		end

create
	make, make_with_command_line

feature {NONE} -- Initialization

	make (a_exec_name: STRING; args: LIST[STRING]; a_working_directory: STRING) is
		do
			setup_command (a_exec_name, args, a_working_directory)
			create_child_process_manager
			initialize_parameter
		end

	make_with_command_line (cmd_line: STRING; a_working_directory: STRING) is
		local
			p_name :STRING
			args: LIST [STRING]
		do
			args := separated_words (cmd_line)
			check not args.is_empty end
			if args.count = 1 then
				make (args.first, Void, a_working_directory)
			else
				args.start
				p_name := args.item
				args.remove
				make (p_name, args, a_working_directory)
			end
		end

feature  -- Control

	launch is
		local
			l_timeout: BOOLEAN
		do
				-- For repeated launch, we must ensure all listening threads, if any have terminated.
			if timer.has_started then
				l_timeout := timer.wait (0)
			end
			on_start
			initialize_child_process
				-- Launch process.
			if is_launched_in_new_process_group and then is_terminal_control_enabled then
				attach_terminals (process_id)
			end
			child_process.spawn_nowait (is_terminal_control_enabled, environment_table_as_pointer, is_launched_in_new_process_group)
			internal_id := child_process.process_id
			launched := (internal_id /= -1)
			if launched then
				initialize_after_launch
				on_launch_successed
			else
				on_launch_failed
			end
		end

	terminate is
		do
			internal_terminate (False)
		end

	terminate_tree is
		do
			if is_launched_in_new_process_group then
				internal_terminate (True)
			else
				internal_terminate (False)
			end
		end

	wait_for_exit is
		local
			l_wait: BOOLEAN
		do
			l_wait := timer.wait (0)
		end

	wait_for_exit_with_timeout (a_timeout: INTEGER) is
		local
			l_wait: BOOLEAN
		do
			l_wait := timer.wait (a_timeout)
		end

	put_string (s: STRING) is
		do
			append_input_buffer (s)
		end

feature -- Status reporting

	id: INTEGER is
		do
			Result := internal_id
		end

	has_exited: BOOLEAN is
		do
			Result := has_cleaned_up
		end

	exit_code: INTEGER is
		do
			Result := child_process.exit_code
		end

feature {PROCESS_TIMER}  -- Status checking

	check_exit is
			-- Check if process has exited.
		local
			l_threads_exited: BOOLEAN
		do
			if not has_exited then
				if not has_process_exited then
					child_process.wait_for_process (id, False)
					has_process_exited := not child_process.is_executing
						-- If launched process exited, send signal to all listenning threads.
					if has_process_exited then
						if is_launched_in_new_process_group and then is_terminal_control_enabled then
							attach_terminals (process_id)
						end

						if in_thread /= Void then
							in_thread.set_exit_signal
						end
						if out_thread /= Void then
							out_thread.set_exit_signal
						end
						if err_thread /= Void then
							err_thread.set_exit_signal
						end
					end
				else
					l_threads_exited := ((in_thread /= Void) implies in_thread.terminated) and
							  ((out_thread /= Void) implies out_thread.terminated) and
							  ((err_thread /= Void) implies err_thread.terminated)
							  -- If all listenning threads exited, perform clean up.
					if l_threads_exited then
						if not has_cleaned_up then
							timer.destroy
							if input_buffer /= Void then
								input_buffer.clear_all
							end
							child_process.close_pipes
							has_cleaned_up := True
								-- Call registered actions.
							if force_terminated then
								on_terminate
							else
								on_exit
							end
						end
					end
				end
			end
		end

feature{NONE} -- Interprocess IO

	input_buffer: STRING
			-- Buffer used to store input data of process
			-- This buffer is used temporarily to store data that can not be
			-- consumed by launched process.

	append_input_buffer (a_input:STRING) is
			-- Append `a_input' to `input_buffer'.
		require
			a_input_not_void: a_input /= Void
		do
			input_mutex.lock
			input_buffer.append (a_input)
			input_mutex.unlock
		end

feature{PROCESS_IO_LISTENER_THREAD} -- Interprocess IO

	last_output_bytes: INTEGER
			-- Number of bytes of data read from output of process

	last_error_bytes: INTEGER
			-- Number of bytes of data read from error of process

	last_input_bytes: INTEGER
			-- Number of bytes in `buffer_size' wrote to process the last time

	write_input_stream is
			-- Write at most `buffer_size' bytes of data in `input_buffer' into launched process.
			--|Note: This feature will be used in input listening thread.
		require
			process_running: is_running
			input_redirected_to_stream: input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		local
			l_cnt: INTEGER
			l_left: INTEGER
			l_str: STRING
			l_retried: BOOLEAN
		do
			if not l_retried and then not is_read_pipe_broken then
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
				if l_str /= Void then
					child_process.put_string (l_str)
				end
			end
		rescue
			l_retried := True
			if is_signal and then signal = sigpipe then
				set_is_read_pipe_broken (True)
				retry
			end
		end

	read_output_stream is
			-- Read output stream from launched process and dispatch data to `output_handler'.
			--|Note: This feature will be used in output listening thread.			
		require
			process_running: is_running
			output_redirected_to_agent: output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent
			output_handler_not_void: output_handler /= Void
		do
			child_process.read_output_stream (buffer_size)
			if child_process.last_output /= Void then
				last_output_bytes := child_process.last_output.count
				output_handler.call ([child_process.last_output])
			else
				last_output_bytes := 0
			end
		end

	read_error_stream is
			-- Read output stream from launched process and dispatch data to `output_handler'.
			--|Note: This feature will be used in error listening thread.
		require
			process_running: is_running
			error_redirected_to_agent: error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent
			error_hander_not_viod: error_handler /= Void
		do
			child_process.read_error_stream (buffer_size)
			if child_process.last_error /= Void then
				last_error_bytes := child_process.last_error.count
				error_handler.call ([child_process.last_error])
			else
				last_error_bytes := 0
			end
		end

feature{NONE} -- Status reporting

	has_process_exited: BOOLEAN
			-- Has launched process exited?

feature {NONE}  -- Implementation

	internal_terminate (is_tree: BOOLEAN) is
			-- Terminate current launched process.
			-- If `is_tree' is True, terminate whole process group.
		require
			process_launched: launched
		do
			child_process.terminate_hard (is_tree)
			force_terminated := True
		end

	initialize_child_process is
			-- Initialize `child_process'.
		do
			launched := False
			force_terminated := False
			create_child_process_manager
			child_process.set_input_file_name (input_file_name)
			child_process.set_output_file_name (output_file_name)
			if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output then
				child_process.set_error_same_as_output
			else
				child_process.set_error_file_name (error_file_name)
			end
			set_is_read_pipe_broken (False)
		end

	initialize_after_launch is
			-- Initialize when process has been launched successfully.
		do
			has_process_exited := False
			force_terminated := False
			last_termination_successful := True
			has_cleaned_up := False
			start_listening_threads
		end

	new_thread_attributes: THREAD_ATTRIBUTES is
			-- New threads attributes used to launch thread
		do
			create Result.make
			Result.set_detached (True)
		ensure
			result_attached: Result /= Void
		end

	start_listening_threads is
			-- Setup listeners for process output/error and for process status acquiring.
		do
			if input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream then
				create input_buffer.make (initial_buffer_size)
				create input_mutex.make
				create in_thread.make (Current)
				in_thread.launch_with_attributes (new_thread_attributes)
			end
				-- Start  output listening thread is necessory
			if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent then
				create out_thread.make (Current)
			   	out_thread.launch_with_attributes (new_thread_attributes)
			end
				-- Start a error listening thread is necessory	
			if (error_direction /= {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output)  then
				if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent then
					create err_thread.make (Current)
					err_thread.launch_with_attributes (new_thread_attributes)
				end
			end
					-- Start a timer for process status acquiring.
			timer.start
		end

feature{NONE} -- Initialization

	setup_command (a_exec_name: STRING; args: LIST[STRING]; a_working_directory: STRING) is
			-- Setup command line.
		require
			a_exec_name_not_void: a_exec_name /= Void
			a_exec_name_not_empty: not a_exec_name.is_empty
		do
			create command_line.make_from_string (a_exec_name)
			create executable.make_from_string (a_exec_name)
			initialize_working_directory (a_working_directory)

			if args /= Void then
				create arguments.make
				from
					args.start
				until
					args.after
				loop
					command_line.append_character (' ')
					command_line.append (args.item)
					arguments.extend (args.item)
					args.forth
				end
			end
		ensure
			command_line_not_void: command_line /= Void
			command_line_not_empty: not command_line.is_empty
			executable_not_void: executable /= Void
			executable_not_empty: not executable.is_empty
			arguments_set:
					(args /= Void implies (arguments /= Void and then arguments.count = args.count)) and
					(args = Void implies arguments = Void)
		end

	create_child_process_manager is
			-- Create child process manager
		require
			executable_not_void: executable /= Void
			executable_not_empty: not executable.is_empty
		do
			create child_process.make (executable, arguments, working_directory)
			child_process.set_close_nonstandard_files (True)
		end

feature {NONE} -- Implementation

	executable: STRING
			-- Program which will be launched

	in_thread: PROCESS_INPUT_LISTENER_THREAD
	out_thread: PROCESS_OUTPUT_LISTENER_THREAD
	err_thread: PROCESS_ERROR_LISTENER_THREAD
			-- Threads to listen to output and error from process

	input_mutex: MUTEX
		-- Mutex used to synchorinze listening threads		

	child_process: PROCESS_UNIX_PROCESS_MANAGER
			-- Child process manager

	has_cleaned_up: BOOLEAN
			-- Has cleanup performed after launched process exited?

	internal_id: INTEGER
			-- Internal process id

	environment_table_as_pointer: POINTER is
			-- {POINTER} representation of `environment_variable_table'
			-- Return `default_pointer' if `environment_variable_table' is Void or empty.
		local
			l_tbl: like environment_variable_table
			l_ptr: MANAGED_POINTER
			l_ptr2: MANAGED_POINTER
			l_cnt: INTEGER
			i: INTEGER
			l_ptr_bytes: INTEGER
			l_str: STRING
			l_key: STRING
			l_value: STRING
		do
			l_tbl := environment_variable_table
			if l_tbl /= Void and then not l_tbl.is_empty then
				from
					l_tbl.start
				until
					l_tbl.after
				loop
					if l_tbl.key_for_iteration /= Void and then l_tbl.item_for_iteration /= Void then
						l_cnt := l_cnt + 1
					end
					l_tbl.forth
				end
				create l_ptr2.make (1)
				l_ptr_bytes := l_ptr2.pointer_bytes
				create l_ptr.make ((l_cnt + 1) * l_ptr_bytes)
				from
					l_tbl.start
					i := 0
				until
					l_tbl.after
				loop
					l_key := l_tbl.key_for_iteration
					l_value := l_tbl.item_for_iteration
					if l_key /= Void and then l_value /= Void then
						create l_str.make (l_key.count + l_value.count + 1)
						l_str.append (l_key)
						l_str.append_character ('=')
						l_str.append (l_value)
						l_ptr.put_pointer ((create {C_STRING}.make (l_str)).item, i * l_ptr_bytes)
						i := i + 1
					end
					l_tbl.forth
				end
				l_ptr.put_pointer (default_pointer, i * l_ptr_bytes)
				Result := l_ptr.item
			else
				Result := default_pointer
			end
		end

feature{NONE} -- Error recovery

	is_read_pipe_broken: BOOLEAN
			-- Is pipe used for reading broken?

	set_is_read_pipe_broken (b: BOOLEAN) is
			-- Set `is_read_pipe_broken' with `b'.
		do
			is_read_pipe_broken := b
		ensure
			is_read_pipe_broken_set: is_read_pipe_broken = b
		end

invariant
	child_process_not_void: child_process /= Void

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
