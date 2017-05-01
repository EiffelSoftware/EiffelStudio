note
	description: "Process launcher on .NET"
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
			make_with_executable_and_arguments,
			terminate,
			terminate_tree,
			wait_for_exit,
			wait_for_exit_with_timeout
		end

create
	make,
	make_with_command_line

feature{NONE} -- Initialization

	make_with_executable_and_arguments (executable_path, argument_string: READABLE_STRING_GENERAL; work_directory: detachable READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			create input_buffer.make_empty
			create exit_mutex.make
			create input_mutex.make
			Precursor (executable_path, argument_string, work_directory)
		end

feature -- Control

	launch
			-- Launch process.	
		local
			retried: BOOLEAN
		do
			if not retried then
				if timer.has_started then
					timer.wait (0).do_nothing
				end
				Precursor
			end
		rescue
			retried := True
			retry
		end

	terminate
			-- <Precursor>
		local
			retried: BOOLEAN
		do
			exit_mutex.lock
			if not retried then
				Precursor
			end
			exit_mutex.unlock
		rescue
			retried := True
			exit_mutex.unlock
			retry
		end

	terminate_tree
			-- <Precursor>
		local
			retried: BOOLEAN
		do
			exit_mutex.lock
			if not retried then
				Precursor
			end
			exit_mutex.unlock
		rescue
			retried := True
			exit_mutex.unlock
			retry
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
			exit_mutex.lock
			if not has_exited then
				l_in_thread := in_thread
				l_out_thread := out_thread
				l_err_thread := err_thread
				if not has_process_exited then
					has_process_exited := child_process.has_exited
						-- If launched process exited, send signal to all listenning threads.
					if has_process_exited then
						exit_code := child_process.exit_code
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
			exit_mutex.unlock
		end

feature{NONE} -- Interprocess IO

	input_buffer: STRING
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
			l_str: detachable STRING
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
			if l_str /= Void and then attached child_process.standard_input as l_writer then
				l_writer.write_string (l_str)
			end
		end

	read_output_stream
			-- Read output stream from launched process and dispatch data to `output_handler'.
			--|Note: This feature will be used in output listening thread.
		require
			process_running: is_running
			output_redirected_to_stream: output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		local
			i: INTEGER
			l_output: STRING
		do
			if output_buffer /= Void and then attached output_handler as l_output_handler and then attached child_process.standard_output as l_reader then
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
					l_output_handler.call ([l_output])
				end
			else
				last_output_bytes := 0
			end
		end

	read_error_stream
			-- Read output stream from launched process and dispatch data to `output_handler'.
			--|Note: This feature will be used in error listening thread.			
		require
			process_running: is_running
			error_redirected_to_stream: error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		local
			i: INTEGER
			l_error: STRING
		do
			if error_buffer /= Void and then attached error_handler as l_error_handler and then attached child_process.standard_error as l_reader then
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
					l_error_handler.call ([l_error])
				else
					last_error_bytes := 0
				end
			end
		end

feature{NONE} -- Implementation

	initialize_after_launch
			-- <Precursor>
		do
			Precursor
			start_listening_threads
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
				create output_buffer.make_filled ('%U', 0, buffer_size)
				create l_out_thread.make (Current)
				out_thread := l_out_thread
				l_out_thread.launch
			else
				out_thread := Void
			end
			if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream then
				create error_buffer.make_filled ('%U', 0, buffer_size)
				create l_err_thread.make (Current)
				err_thread := l_err_thread
				l_err_thread.launch
			else
				err_thread := Void
			end

			check timer.is_destroyed end
			timer.start
		end

feature{NONE} -- Access

	out_thread: detachable PROCESS_OUTPUT_LISTENER_THREAD
	err_thread: detachable PROCESS_ERROR_LISTENER_THREAD
	in_thread: detachable PROCESS_INPUT_LISTENER_THREAD
			-- Threads to listen to output and error from child process.

	input_mutex: MUTEX
	exit_mutex: MUTEX
		-- Mutex used to synchorinze listening threads			

	output_buffer: detachable ARRAY [CHARACTER] note option: stable attribute end
			-- Buffer used to read output from process

	error_buffer: detachable ARRAY [CHARACTER] note option: stable attribute end
			-- Buffer used to read error from process	

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
