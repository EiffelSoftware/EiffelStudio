note
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

	make (a_exec_name: READABLE_STRING_GENERAL; args: detachable LIST [READABLE_STRING_GENERAL]; a_working_directory: detachable READABLE_STRING_GENERAL)
		do
			setup_command (a_exec_name, args, a_working_directory)
			create_child_process_manager
			create input_buffer.make_empty
			create input_mutex.make
			initialize_parameter
		end

	make_with_command_line (cmd_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL)
		local
			l_exec_name: STRING_32
			l_args: detachable like separated_words
		do
			l_args := separated_words (cmd_line)
			if l_args.is_empty then
				l_exec_name := " "
				l_args := Void
			elseif l_args.count = 1 then
				l_exec_name := l_args.first
				l_args := Void
			else
				l_exec_name := l_args.first
				l_args.start
				l_args.remove
			end
			make (l_exec_name, l_args, a_working_directory)
		end

feature  -- Control

	launch
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
			child_process.spawn_nowait (is_terminal_control_enabled, environment_variable_table, is_launched_in_new_process_group)
			internal_id := child_process.process_id
			launched := (internal_id /= -1)
			if launched then
				initialize_after_launch
				on_launch_successed
			else
				on_launch_failed
			end
		end

	terminate
		do
			internal_terminate (False)
		end

	terminate_tree
		do
			if is_launched_in_new_process_group then
				internal_terminate (True)
			else
				internal_terminate (False)
			end
		end

	wait_for_exit
		local
			l_wait: BOOLEAN
		do
			l_wait := timer.wait (0)
		end

	wait_for_exit_with_timeout (a_timeout: INTEGER)
		do
			is_last_wait_timeout := not timer.wait (a_timeout)
		end

	put_string (s: READABLE_STRING_8)
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
			Result := child_process.exit_code
		end

feature {PROCESS_TIMER}  -- Status checking

	check_exit
			-- Check if process has exited.
		local
			l_threads_exited: BOOLEAN
			l_in_thread: like in_thread
			l_out_thread: like out_thread
			l_err_thread: like err_thread
		do
			if not has_exited then
				l_in_thread := in_thread
				l_out_thread := out_thread
				l_err_thread := err_thread
				if not has_process_exited then
					child_process.wait_for_process (id, False)
					has_process_exited := not child_process.is_executing
						-- If launched process exited, send signal to all listenning threads.
					if has_process_exited then
						if is_launched_in_new_process_group and then is_terminal_control_enabled then
							attach_terminals (process_id)
						end

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
							  -- If all listenning threads exited, perform clean up.
					if l_threads_exited then
						if not has_cleaned_up then
							timer.destroy
							input_buffer.wipe_out
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

feature {NONE} -- Interprocess IO

	input_buffer: STRING
			-- Buffer used to store input data of process
			-- This buffer is used temporarily to store data that can not be
			-- consumed by launched process.

	append_input_buffer (a_input: READABLE_STRING_8)
			-- Append `a_input' to `input_buffer'.
		require
			a_input_not_void: a_input /= Void
			input_mutex_attached: input_mutex /= Void
			input_buffer_attached: input_buffer /= Void
		do
			input_mutex.lock
			input_buffer.append (a_input)
			input_mutex.unlock
		end

feature {PROCESS_IO_LISTENER_THREAD} -- Interprocess IO

	last_output_bytes: INTEGER
			-- Number of bytes of data read from output of process

	last_error_bytes: INTEGER
			-- Number of bytes of data read from error of process

	last_input_bytes: INTEGER
			-- Number of bytes in `buffer_size' wrote to process the last time

	write_input_stream
			-- Write at most `buffer_size' bytes of data in `input_buffer' into launched process.
			--|Note: This feature will be used in input listening thread.
		require
			process_running: is_running
			input_redirected_to_stream: input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		local
			l_cnt: INTEGER
			l_left: INTEGER
			l_str: detachable STRING
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

	read_output_stream
			-- Read output stream from launched process and dispatch data to `output_handler'.
			--|Note: This feature will be used in output listening thread.			
		require
			process_running: is_running
			output_redirected_to_agent: output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent
		do
			last_output_bytes := 0
			if attached output_handler as l_output_handler then
				child_process.read_output_stream (buffer_size)
				if attached child_process.last_output as l_last_output then
					last_output_bytes := l_last_output.count
					l_output_handler.call ([l_last_output])
				end
			end
		end

	read_error_stream
			-- Read output stream from launched process and dispatch data to `output_handler'.
			--|Note: This feature will be used in error listening thread.
		require
			process_running: is_running
			error_redirected_to_agent: error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent
		do
			last_error_bytes := 0
			if attached error_handler as l_error_handler then
				child_process.read_error_stream (buffer_size)
				if attached child_process.last_error as l_last_error then
					last_error_bytes := l_last_error.count
					l_error_handler.call ([l_last_error])
				end
			end
		end

feature{NONE} -- Status reporting

	has_process_exited: BOOLEAN
			-- Has launched process exited?

feature {NONE}  -- Implementation

	internal_terminate (is_tree: BOOLEAN)
			-- Terminate current launched process.
			-- If `is_tree' is True, terminate whole process group.
		require
			process_launched: launched
		do
			child_process.terminate_hard (is_tree)
			force_terminated := True
		end

	initialize_child_process
			-- Initialize `child_process'.
		local
			u: UTF_CONVERTER
		do
			launched := False
			force_terminated := False
			create_child_process_manager
			if attached input_file_name as l_file_name then
				child_process.set_input_file_name (u.string_32_to_utf_8_string_8 (l_file_name))
			else
				child_process.set_input_file_name (Void)
			end
			if attached output_file_name as l_file_name then
				child_process.set_output_file_name (u.string_32_to_utf_8_string_8 (l_file_name))
			else
				child_process.set_output_file_name (Void)
			end
			if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output then
				child_process.set_error_same_as_output
			else
				if attached error_file_name as l_file_name then
					child_process.set_error_file_name (u.string_32_to_utf_8_string_8 (l_file_name))
				else
					child_process.set_error_file_name (Void)
				end
			end
			set_is_read_pipe_broken (False)
		end

	initialize_after_launch
			-- Initialize when process has been launched successfully.
		do
			has_process_exited := False
			force_terminated := False
			last_termination_successful := True
			has_cleaned_up := False
			start_listening_threads
		end

	new_thread_attributes: THREAD_ATTRIBUTES
			-- New threads attributes used to launch thread
		do
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	start_listening_threads
			-- Setup listeners for process output/error and for process status acquiring.
		local
			l_in_thread: like in_thread
			l_out_thread: like out_thread
			l_err_thread: like err_thread
		do
			if input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream then
				create input_buffer.make (initial_buffer_size)
				create input_mutex.make
				create l_in_thread.make (Current)
				l_in_thread.launch_with_attributes (new_thread_attributes)
				in_thread := l_in_thread
			end
				-- Start  output listening thread is necessory
			if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent then
				create l_out_thread.make (Current)
			   	l_out_thread.launch_with_attributes (new_thread_attributes)
			   	out_thread := l_out_thread
			end
				-- Start a error listening thread is necessory	
			if (error_direction /= {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output)  then
				if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent then
					create l_err_thread.make (Current)
					l_err_thread.launch_with_attributes (new_thread_attributes)
					err_thread := l_err_thread
				end
			end
					-- Start a timer for process status acquiring.
			timer.start
		end

feature{NONE} -- Initialization

	setup_command (a_exec_name: READABLE_STRING_GENERAL; a_args: detachable LIST [READABLE_STRING_GENERAL]; a_working_directory: detachable READABLE_STRING_GENERAL)
			-- Setup command line.
		require
			a_exec_name_not_void: a_exec_name /= Void
			a_exec_name_not_empty: not a_exec_name.is_empty
		local
			l_cmd_line: STRING_32
		do
			create l_cmd_line.make (a_exec_name.count)
			l_cmd_line.append_string_general (a_exec_name)
			executable := l_cmd_line

			initialize_working_directory (a_working_directory)

			arguments := a_args

			if a_args /= Void then
				across a_args as l_args loop
					l_cmd_line.append_character (' ')
					l_cmd_line.append_string_general (l_args.item)
				end
			end
			command_line := l_cmd_line
		ensure
			command_line_not_void: command_line /= Void
			command_line_not_empty: not command_line.is_empty
			executable_not_void: executable /= Void
			executable_not_empty: not executable.is_empty
			arguments_set:
					(a_args /= Void implies (attached arguments as l_args and then l_args.count = a_args.count)) and
					(a_args = Void implies arguments = Void)
		end

	create_child_process_manager
			-- Create child process manager
		require
			executable_not_void: executable /= Void
			executable_not_empty: not executable.is_empty
		local
			l_args: detachable ARRAYED_LIST [STRING_8]
			u: UTF_CONVERTER
		do
			if attached arguments as l_arguments then
				create l_args.make (l_arguments.count)
				across l_arguments as l_argument loop
					l_args.extend (u.string_32_to_utf_8_string_8 (l_argument.item.as_string_32))
				end
			end
			if attached working_directory as l_cwd then
				create child_process.make (u.string_32_to_utf_8_string_8 (executable), l_args, u.string_32_to_utf_8_string_8 (l_cwd))
			else
				create child_process.make (u.string_32_to_utf_8_string_8 (executable), l_args, Void)
			end
			child_process.set_close_nonstandard_files (True)
		end

feature {NONE} -- Implementation

	executable: IMMUTABLE_STRING_32
			-- Program which will be launched

	in_thread: detachable PROCESS_INPUT_LISTENER_THREAD
	out_thread: detachable PROCESS_OUTPUT_LISTENER_THREAD
	err_thread: detachable PROCESS_ERROR_LISTENER_THREAD
			-- Threads to listen to output and error from process

	input_mutex: MUTEX
		-- Mutex used to synchorinze listening threads		

	child_process: PROCESS_UNIX_PROCESS_MANAGER
			-- Child process manager

	has_cleaned_up: BOOLEAN
			-- Has cleanup performed after launched process exited?

	internal_id: INTEGER
			-- Internal process id

feature{NONE} -- Error recovery

	is_read_pipe_broken: BOOLEAN
			-- Is pipe used for reading broken?

	set_is_read_pipe_broken (b: BOOLEAN)
			-- Set `is_read_pipe_broken' with `b'.
		do
			is_read_pipe_broken := b
		ensure
			is_read_pipe_broken_set: is_read_pipe_broken = b
		end

invariant
	child_process_not_void: child_process /= Void

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
