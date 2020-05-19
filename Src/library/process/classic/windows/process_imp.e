note
	description: "Process launcher on Windows."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_IMP

inherit
	PROCESS
		redefine
			check_exit,
			launch,
			wait_for_exit_with_timeout
		select
			put_string
		end

	BASE_PROCESS_IMP
		rename
			parameter_initialized as base_parameter_initialized,
			put_string as blocking_put_string
		undefine
			cancel_error_redirection,
			cancel_output_redirection,
			initialize_parameter,
			is_error_redirection_valid,
			is_output_redirection_valid,
			redirect_error_to_file,
			redirect_error_to_same_as_output,
			redirect_output_to_file
		redefine
			check_exit,
			initialize_after_launch,
			launch,
			make_with_command_line,
			wait_for_exit,
			wait_for_exit_with_timeout
		end

create
	make,
	make_with_command_line

feature{NONE} -- Initialization

	make_with_command_line (cmd_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			create input_buffer.make_empty
			create input_mutex.make
			Precursor (cmd_line, a_working_directory)
		end

feature -- Control

	launch
			-- <Precursor>
		do
				-- For repeated process launch, make sure all listening threads have exited.				
			if timer.has_started then
				timer.wait (0).do_nothing
			end
			Precursor
		end

	wait_for_exit
			-- <Precursor>
		do
			timer.wait (0).do_nothing
		end

	wait_for_exit_with_timeout (a_timeout: INTEGER)
			-- <Precursor>
		do
			is_last_wait_timeout := not timer.wait (a_timeout)
		end

feature -- Interprocess data transmission

	put_string (s: READABLE_STRING_8)
			-- Send `s' into launched process as its input data.
		do
			input_mutex.lock
			input_buffer.append (s)
			input_mutex.unlock
		end

feature {PROCESS_TIMER} -- Process status checking

	check_exit
			-- <Precursor>
		local
			l_in_thread: like in_thread
			l_out_thread: like out_thread
			l_err_thread: like err_thread
		do
			if not has_exited then
				l_in_thread := in_thread
				l_out_thread := out_thread
				l_err_thread := err_thread
				if not has_process_exited then
					has_process_exited := child_process.has_exited
						-- If launched process exited, send signal to all listenning threads.
					if has_process_exited then
						if attached l_in_thread then
							l_in_thread.set_exit_signal
						end
						if attached l_out_thread then
							l_out_thread.set_exit_signal
						end
						if attached l_err_thread then
							l_err_thread.set_exit_signal
						end
					end
				elseif
					(attached l_in_thread implies l_in_thread.terminated) and
					(attached l_out_thread implies l_out_thread.terminated) and
					(attached l_err_thread implies l_err_thread.terminated)
				then
						  -- If all listenning threads exited, perform clean up.
					timer.destroy
					input_buffer.wipe_out
					Precursor
				end
			end
		end

feature{NONE} -- Interprocess IO

	input_buffer: STRING_8
			-- Buffer used to store input data of process
			-- This buffer is used temporarily to store data that can not be
			-- consumed by launched process.

feature {PROCESS_IO_LISTENER_THREAD} -- Interprocess data transimission

	last_output_bytes: INTEGER
			-- Number of bytes of data read from output of process

	last_error_bytes: INTEGER
			-- Number of bytes of data read from error of process

	last_input_bytes: INTEGER
			-- Number of bytes in `input_buffer' wrote to process the last time

	write_input_stream
			-- Write at most `buffer_size' bytes of data in `input_buffer' into launched process.
			--|Note: This feature will be used in input listening thread.
		require
			process_running: is_running
			input_redirected_to_stream: input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		local
			l_cnt: INTEGER
			l_left: INTEGER
			l_str: detachable STRING_8
		do
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
			if l_str /= Void and attached input_file_handle as l_input_file_handle then
				l_input_file_handle.put_string (child_process.std_input, l_str)
			end
		end

	read_output_stream
			-- Read output stream from launched process and dispatch data to `output_handler'.
			--|Note: This feature will be used in output listening thread.
		require
			process_running: is_running
			output_redirected_to_stream: output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		local
			succ: BOOLEAN
			bytes_avail: INTEGER
		do
			last_output_bytes := 0
			if attached output_handler as l_output_handler and then attached output_file_handle as l_output_file_handle then
				succ := cwin_peek_named_pipe (child_process.std_output, default_pointer, 0, default_pointer, $bytes_avail, default_pointer)
				if succ and bytes_avail > 0 then
					l_output_file_handle.read_stream (child_process.std_output, buffer_size.min (bytes_avail))
					if attached l_output_file_handle.last_string as l_last_string then
						last_output_bytes := l_output_file_handle.last_read_bytes
						l_output_handler.call ([l_last_string])
					end
				end
			end
		end

	read_error_stream
			-- Read output stream from launched process and dispatch data to `output_handler'.
			--|Note: This feature will be used in error listening thread.			
		require
			process_running: is_running
			error_redirected_to_stream: error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		local
			succ: BOOLEAN
			bytes_avail: INTEGER
		do
			last_error_bytes := 0
			if attached error_handler as l_error_handler and then attached error_file_handle as l_error_file_handle then
				succ := cwin_peek_named_pipe (child_process.std_error, default_pointer, 0, default_pointer, $bytes_avail, default_pointer)
				if succ and bytes_avail > 0 then
					l_error_file_handle.read_stream (child_process.std_error, buffer_size.min (bytes_avail))
					if attached l_error_file_handle.last_string as l_last_string then
						last_error_bytes := l_error_file_handle.last_read_bytes
						l_error_handler (l_last_string)
					end
				end
			end
		end

feature{NONE} -- Implementation

	cwin_peek_named_pipe (a_handle: POINTER; a_buffer:  POINTER;  buf_size: INTEGER; bytes_read: POINTER; bytes_avail: POINTER; a_integer: POINTER): BOOLEAN
			-- Peek a pipe to see whether there is data in it.
		external
			"C blocking macro signature (HANDLE, LPVOID, DWORD, LPDWORD, LPDWORD, LPDWORD): BOOL use <windows.h>"
		alias
			"PeekNamedPipe"
		end

	initialize_after_launch
			-- <Precursor>
		do
			Precursor
			if attached child_process.process_handle then
				start_listening_threads
			end
		end

	start_listening_threads
			-- Start listening threads.
		local
			l_in_thread: like in_thread
			l_out_thread: like out_thread
			l_err_thread: like err_thread
		do
			if input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream then
				create input_buffer.make (4096)
				create l_in_thread.make (Current)
				in_thread := l_in_thread
				l_in_thread.launch
			else
				in_thread := Void
			end
			if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream then
				create output_file_handle
				create l_out_thread.make (Current)
				out_thread := l_out_thread
				l_out_thread.launch
			else
				out_thread := Void
			end
			if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream then
				create error_file_handle
				create l_err_thread.make (Current)
				err_thread := l_err_thread
				l_err_thread.launch
			else
				err_thread := Void
			end
			check timer.is_destroyed end
			timer.start
		end

feature {NONE} -- Standard input-output redirection

	out_thread: detachable PROCESS_OUTPUT_LISTENER_THREAD
	err_thread: detachable PROCESS_ERROR_LISTENER_THREAD
	in_thread: detachable PROCESS_INPUT_LISTENER_THREAD
			-- Threads to listen to output and error from child process.

	input_mutex: MUTEX
			-- Mutex used to synchorinze listening threads.

	output_file_handle,
	error_file_handle: detachable FILE_HANDLE
			-- Handles used to read and write file.

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
