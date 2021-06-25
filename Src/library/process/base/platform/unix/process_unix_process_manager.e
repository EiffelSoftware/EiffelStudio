note
	description: "A Unix process launcher with IO redirection capability."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PROCESS_UNIX_PROCESS_MANAGER

inherit
	UNIX_SIGNALS
		rename
			meaning as signal_meaning
		export
			{PROCESS_UNIX_PROCESS_MANAGER} all
			{NONE} is_defined, is_ignored, signal, catch, ignore,
				reset_all_default, reset_default, is_caught,
				c_signal_map, c_signal_name
		end

	PROCESS_UNIX_OS
		rename
			send_signal as unix_send_signal,
			terminate_hard as unix_terminate_hard
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	MEMORY
		export
			{NONE} all
		end

	PROCESS_INFO_IMP
		rename
			process_id as current_process_id
		export
			{NONE} all
		end

	RT_DEBUGGER

create {PROCESS_UNIX_OS}
	make

feature {NONE} -- Creation

	make (fname: READABLE_STRING_GENERAL; args: detachable LIST [READABLE_STRING_GENERAL]; a_working_dir: detachable READABLE_STRING_GENERAL)
			-- Create a process object which represents an
			-- independent process that can execute the
			-- program residing in file `fname'
		require
			file_name_exists: fname /= Void
			file_name_not_empty: not fname.is_empty
		do
			if a_working_dir /= Void then
				create working_directory.make_from_string (a_working_dir)
			else
				working_directory := Void
			end
			program_file_name := fname
			set_arguments (args)
			process_id := 0
			set_input_file_name ("")
			set_output_file_name ("")
			set_error_file_name ("")
			set_is_executing (False)
		ensure
			program_file_name_set: program_file_name.same_string (fname)
			input_file_name_empty: attached input_file_name as l_input_fn and then l_input_fn.is_empty
			output_file_name_empty: attached output_file_name as l_output_fn and then l_output_fn.is_empty
			error_file_name_empty: attached error_file_name as l_error_fn and then l_error_fn.is_empty
			input_not_piped: not input_piped
			output_not_piped: not output_piped
			error_not_piped: not error_piped
			no_process_id: process_id = 0
			is_executing_set: not is_executing
		end

feature -- Access

	process_id: INTEGER
			-- Process id of last child process spawned or
			-- 0 if no processes have been spawned.

	status: INTEGER
			-- last reported process status if `is_status_available' is True

	exit_code: INTEGER
			-- Exit code
		do
			if not is_executing and then is_last_wait_successful and then is_status_available then
				Result := exit_code_from_status (status)
			end
		end

	working_directory: detachable PATH
			-- Working directory of process

	arguments_for_exec: detachable ARRAY [READABLE_STRING_GENERAL]
			-- Arguments to be passed to `exec_process'

feature -- Status report

	is_last_wait_successful: BOOLEAN
			-- Is last `wait_for_process' succeeded?

	is_executing: BOOLEAN
			-- Is launched process executing?

	is_stopped: BOOLEAN
			-- Is current process stopped by a signal?
		do
			Result := is_status_available and then signaled_flag_from_status (status)
		end

	is_last_process_spawn_successful: BOOLEAN
			-- Is last process spawn successful?
			-- Check it after invoking `spawn_nowait'.
		do
			Result := process_id /= -1
		end

	is_status_available: BOOLEAN
			-- Is process status available when `wait_for_process' is called last time?

	is_terminated_by_signal: BOOLEAN
			-- Is process terminated by a signal?
		do
			Result := is_status_available and then signaled_flag_from_status (status)
		end

feature -- Setting

	set_arguments (argument_list: detachable LIST [READABLE_STRING_GENERAL])
			-- Initialize `arguments' from `argument_list'.
		local
			l_arguments: like arguments
		do
			if attached argument_list then
				create l_arguments.make (0)
				across
					argument_list as argument
				loop
					l_arguments.extend (argument.twin)
				end
			end
			arguments := l_arguments
		end

	set_close_nonstandard_files (b: BOOLEAN)
			-- Set `close_nonstandard_files' to `b'
		do
			close_nonstandard_files := b
		ensure
			value_set: close_nonstandard_files = b
		end

	set_input_file_name (fname: like input_file_name)
			-- Set `input_file_name' to `fname', which must
			-- be the name of an existing file readable by
			-- the parent process
		do
			input_file_name := fname
			input_piped := fname = Void
		end

	set_output_file_name (fname: like output_file_name)
			-- Set `output_file_name' to `fname', which must
			-- be the name of a file writable by the parent
			-- process.  File is created if it does not exist
			-- and truncated if it does
		do
			output_file_name := fname
			output_piped := fname = Void
		end

	set_error_file_name (fname: like error_file_name)
			-- Set `error_file_name' to `fname', which must
			-- be the name of a file writable by the parent
			-- process.  File is created if it does not exist
			-- and truncated if it does
		do
			error_file_name := fname
			error_piped := fname = Void
			error_same_as_output := False
		ensure
			error_not_output: not error_same_as_output
		end

	set_error_same_as_output
			-- Set `error_same_as_output' to true
		do
			error_same_as_output := True
			error_piped := False
			error_file_name := Void
		ensure
			error_is_output: error_same_as_output
			error_not_piped: not error_piped
			error_not_file: error_file_name = Void
		end

feature {BASE_PROCESS_IMP} -- Process management

	wait_for_process (pid: INTEGER; is_block: BOOLEAN)
			-- Wait for any process specified by process
			-- id `pid' to return status.
			-- Block if `is_block' is True.
			-- Set `is_status_available' to True if process status is available and
			-- if so, set `status' with reported process status.
		local
			l_status: INTEGER
			l_status_available, l_success: BOOLEAN
		do
			unix_waitpid (pid, is_block, $l_status_available, $l_status, $l_success)
			is_last_wait_successful := l_success
			if is_last_wait_successful then
				is_status_available := l_status_available
				status := l_status
				if
					is_status_available and then
					(terminate_flag_from_status (status) or signaled_flag_from_status (status))
				then
					set_is_executing (False)
				else
					set_is_executing (True)
				end
			else
				is_status_available := False
				set_is_executing (False)
			end
		end

	close_pipes
			-- Close opened pipes.
		do
			if attached shared_input_unnamed_pipe as l_in_pipe then
				l_in_pipe.close_write_descriptor
			end
			if attached shared_output_unnamed_pipe as l_out_pipe then
				l_out_pipe.close_read_descriptor
			end
			if attached shared_error_unnamed_pipe as l_err_pipe then
				l_err_pipe.close_read_descriptor
			end
		end

	spawn_nowait (is_control_terminal_enabled: BOOLEAN; envs: detachable HASH_TABLE [READABLE_STRING_GENERAL, READABLE_STRING_GENERAL]; a_new_process_group: BOOLEAN)
			-- Spawn a process and return immediately.
			-- If `is_control_terminal_enabled' is true, attach controlling terminals to spawned process.
			-- Environment variables for new process is stored in `envptr'. If `envptr' is `default_pointer',
			-- new process will inherit all environment variables from its parent process.
			-- If `a_new_process_group' is True, launch process in a new process group.
			-- Check `is_last_process_spawn_successful' after to make sure process has been spawned successfully.
		local
			ee: EXECUTION_ENVIRONMENT
			cur_dir: detachable PATH
			l_debug_state: like debug_state
			l_working_directory: like working_directory
			l_arguments: like arguments_for_exec
		do
			l_arguments := built_argument_list
			arguments_for_exec := l_arguments
			open_files_and_pipes
			create ee
			l_working_directory := working_directory
			if l_working_directory /= Void then
				cur_dir := ee.current_working_path
				ee.change_working_path (l_working_directory)
			end
			l_debug_state := debug_state
			disable_debug

			process_id := fork_process
			inspect process_id
			when -1 then --| Error
				set_debug_state (l_debug_state)
					-- Error ... no fork allowed
				if cur_dir /= Void then
					ee.change_working_path (cur_dir)
				end
			when 0 then --| Child process
				collection_off
				if a_new_process_group then
					new_process_group
					if is_control_terminal_enabled then
						attach_terminals (process_id)
					end
				end
				setup_child_process_files
				exec_process (program_file_name, l_arguments, close_nonstandard_files, environment_table_as_pointer (envs))
			else --| Parent process
				set_debug_state (l_debug_state)
				setup_parent_process_files
				arguments_for_exec := Void
				set_is_executing (True)
				if cur_dir /= Void then
					ee.change_working_path (cur_dir)
				end
			end
		rescue
			if process_id = 0 then
				; (create {EXCEPTIONS}).die (1)
			end
			set_debug_state (l_debug_state)
		end

	terminate_hard (is_tree: BOOLEAN)
			-- Send a kill signal (SIGKILL) to process(es).
			-- if `is_tree' is True, send signal to whole process group,
			-- otherwise only send signal to current launched process.
		do
			if is_tree then
				unix_terminate_hard (- process_id)
			else
				unix_terminate_hard (process_id)
			end
		end

	read_output_stream (buf_size: INTEGER)
			-- Read at most `buf_size' bytes of data from output pipe.
			-- Set data in `last_output`.
		require
			buf_size_positive: buf_size > 0
		do
			if attached shared_output_unnamed_pipe as l_out_pipe then
				l_out_pipe.read_stream_non_block (buf_size)
				last_output := l_out_pipe.last_string
			else
				last_output := Void
			end
		end

	read_output_to_special (buffer: SPECIAL [NATURAL_8])
			-- Read data from the output stream to `buffer`.
			-- Maximum number if bytes to read is `buffer.count`.
			-- Update `buffer.count` with actually read bytes.
		do
			if attached shared_output_unnamed_pipe as p then
				p.read_to_special (buffer)
				has_output_stream_error := not p.last_read_successful
			else
				has_output_stream_error := True
					-- Update `buffer.count` with actual bytes read.
				buffer.wipe_out
				check
					buffer_is_empty: buffer.count = 0
				end
			end
		end

	read_error_stream (buf_size: INTEGER)
			-- Read at most `buf_size' bytes of data from error pipe.
			-- Set data in `last_error'.
		require
			buf_size_positive: buf_size > 0
		do
			if not error_same_as_output and then attached shared_error_unnamed_pipe as l_err_pipe then
				l_err_pipe.read_stream_non_block (buf_size)
				last_error := l_err_pipe.last_string
			else
				last_error := Void
			end
		end

	read_error_to_special (buffer: SPECIAL [NATURAL_8])
			-- Read data from the error stream to `buffer`.
			-- Maximum number if bytes to read is `buffer.count`.
			-- Update `buffer.count` with actually read bytes.
		do
			if attached shared_error_unnamed_pipe as p then
				p.read_to_special (buffer)
				has_error_stream_error := not p.last_read_successful
			else
				has_error_stream_error := True
					-- Update `buffer.count` with actual bytes read.
				buffer.wipe_out
				check
					buffer_is_empty: buffer.count = 0
				end
			end
		end

	put_string (s: READABLE_STRING_8)
			-- Put `s' into input pipe of process.
		require
			s_not_void: s /= Void
		do
			if is_executing and then attached shared_input_unnamed_pipe as l_in_pipe then
				l_in_pipe.put_string (s)
				has_write_error := not l_in_pipe.last_write_successful
			else
				has_write_error := True
			end
		end

	has_write_error: BOOLEAN
			-- Has last write operation to `shared_input_unnamed_pipe' ended with an error?

	has_output_stream_error: BOOLEAN
			-- Has last read operation from `shared_output_unnamed_pipe' ended with an error?

	has_error_stream_error: BOOLEAN
			-- Has last read operation from `shared_error_unnamed_pipe' ended with an error?

	last_output: detachable STRING
			-- Last read data from output pipe

	last_error: detachable STRING
			-- Last read data from error pipe

feature {NONE} -- Properties

	program_file_name: READABLE_STRING_GENERAL
			-- Name of file containing program which will be
			-- executed when process is spawned

	arguments: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Arguments to passed to process when it is spawned,
			-- not including argument 0 (which is conventionally
			-- the name of the program).  If Void or if count
			-- is zero, then no arguments are passed

	close_nonstandard_files: BOOLEAN
			-- Should nonstandard files (files other than
			-- standard input, standard output and standard
			-- error) be closed in the spawned process?

	input_file_name: detachable READABLE_STRING_GENERAL
			-- Name of file to be used as standard input in
			-- spawned process if `input_descriptor' is not a
			-- valid descriptor and `input_piped' is false.
			-- A Void value leaves standard input same as
			-- parent's and an empty string closes standard input

	output_file_name: detachable READABLE_STRING_GENERAL
			-- Name of file to be used as standard output in
			-- spawned process if `output_descriptor' is not a
			-- valid descriptor and `output_piped' is false.
			-- A Void value leaves standard output same as
			-- parent's and an empty string closes standard output

	error_file_name: detachable READABLE_STRING_GENERAL
			-- Name of file to be used as standard error in
			-- spawned process if `error_descriptor' is not a
			-- valid descriptor and `error_piped' is false.
			-- A Void value leaves standard error same as
			-- parent's and an empty string closes standard error

	input_piped: BOOLEAN
			-- Should standard input for spawned process
			-- come from a pipe connected to parent,
			-- instead of from a file descriptor or named file?

	output_piped: BOOLEAN
			-- Should standard output for spawned process go to a
			-- pipe connected to parent, instead of to a
			-- file descriptor or named file?

	error_piped: BOOLEAN
			-- Should standard error for spawned process go to a
			-- pipe connected to parent, instead of to a
			-- file descriptor or named file?

	error_same_as_output: BOOLEAN
			-- Should standard error for spawned process be
			-- the same as standard output (i.e., identical
			-- file descriptor)?

feature {NONE} -- Implementation

	built_argument_list: attached like arguments_for_exec
			-- Build argument list for `exec_process' call
			-- and put it in `arguments_for_exec'.
			-- Make `process_name' argument 0 and append
			-- `arguments' as the rest of the arguments
		local
			k: INTEGER
		do
			if attached arguments as a then
				create Result.make_filled (program_file_name, 1, a.count + 1)
				across
					a as argument
				from
					k := 2
				loop
					Result.put (argument, k)
					k := k + 1
				end
			else
				create Result.make_filled (program_file_name, 1, 1)
			end
		end

	open_files_and_pipes
		local
			pipe_fac: UNIX_PIPE_FACTORY
			l_input_fn: like input_file_name
			l_output_fn: like output_file_name
			l_error_fn: like error_file_name
		do
			create pipe_fac
				-- Open file or pipe for input.
			shared_input_unnamed_pipe := Void
			in_file := Void
			if input_piped then
				shared_input_unnamed_pipe := pipe_fac.new_unnamed_pipe
			else
				l_input_fn := input_file_name
				if l_input_fn /= Void and then not l_input_fn.is_empty then
					create in_file.make_open_read (l_input_fn)
				end
			end
				-- Open file or pipe for output.
			shared_output_unnamed_pipe := Void
			out_file := Void
			if output_piped then
				shared_output_unnamed_pipe := pipe_fac.new_unnamed_pipe
			else
				l_output_fn := output_file_name
				if l_output_fn /= Void and then not l_output_fn.is_empty then
					create out_file.make_open_append (l_output_fn)
				end
			end

				-- Open file or pipe for error.
			shared_error_unnamed_pipe := Void
			err_file := Void
			if not error_same_as_output then
				if error_piped then
					shared_error_unnamed_pipe := pipe_fac.new_unnamed_pipe
				else
					l_error_fn := error_file_name
					if l_error_fn /= Void and then not l_error_fn.is_empty then
						create err_file.make_open_append (l_error_fn)
					end
				end
			end
		end

	setup_parent_process_files
		do
			if attached shared_input_unnamed_pipe as l_in_pipe then
				l_in_pipe.close_read_descriptor
			elseif attached in_file as l_in_file then
				l_in_file.close
			end

			if attached shared_output_unnamed_pipe as l_out_pipe then
				l_out_pipe.close_write_descriptor
			elseif attached out_file as l_out_file then
				l_out_file.close
			end

			if not error_same_as_output then
				if attached shared_error_unnamed_pipe as l_err_pipe then
					l_err_pipe.close_write_descriptor
				elseif attached err_file as l_err_file then
					l_err_file.close
				end
			end
		end

	setup_child_process_files
		do
			if attached shared_input_unnamed_pipe as l_in_pipe then
				move_desc (l_in_pipe.read_descriptor, stdin_descriptor)
				l_in_pipe.close_write_descriptor
			elseif attached in_file as l_in_file then
				move_desc (l_in_file.descriptor, stdin_descriptor)
			end

			if attached shared_output_unnamed_pipe as l_out_pipe then
				move_desc (l_out_pipe.write_descriptor, stdout_descriptor)
				l_out_pipe.close_read_descriptor
			elseif attached out_file as l_out_file then
				move_desc (l_out_file.descriptor, stdout_descriptor)
			end

			if error_same_as_output then
				duplicate_file_descriptor (stdout_descriptor, stderr_descriptor)
			else
				if attached shared_error_unnamed_pipe as l_err_pipe then
					move_desc (l_err_pipe.write_descriptor, stderr_descriptor)
					l_err_pipe.close_read_descriptor
				elseif attached err_file as l_err_file then
					move_desc (l_err_file.descriptor, stderr_descriptor)
				end
			end
		end

	move_desc (source, dest: INTEGER)
			-- If descriptor `source' is different than
			-- descriptor `dest', duplicate `source' onto `dest'
			-- and close `source'
		do
			if source /= dest then
				duplicate_file_descriptor (source, dest)
				close_file_descriptor (source)
			end
		end

feature {NONE} -- Input-output

	in_file: detachable RAW_FILE
			-- File to be used by child process for standard input
			-- when it comes from a file

	out_file: detachable RAW_FILE
			-- File to be used by child process for standard output
			-- when it goes to a file

	err_file: detachable RAW_FILE
			-- File to be used by child process for standard error
			-- when it goes to a file

	Stdin_descriptor: INTEGER = 0
			-- File descriptor for standard input

	Stdout_descriptor: INTEGER = 1
			-- File descriptor for standard output

	Stderr_descriptor: INTEGER = 2
			-- File descriptor for standard error

feature {NONE} -- Access

	environment_table_as_pointer (a_envs: detachable HASH_TABLE [READABLE_STRING_GENERAL, READABLE_STRING_GENERAL]): POINTER
			-- {POINTER} representation of `environment_variable_table'.
			-- Return `default_pointer' if `environment_variable_table' is Void or empty.
			--| Not that memory will be leaked if not use for spawning the process.
		local
			l_ptr: MANAGED_POINTER
			l_natstr: NATIVE_STRING
			l_cstr_ptr: POINTER
			i, nb: INTEGER
			l_str: STRING_32
		do
			if a_envs /= Void and then not a_envs.is_empty then
					-- Estimate the number of environment variables that will be stored.
				across
					a_envs as c
				loop
					if attached @ c.key and then attached c then
						nb := nb + 1
					end
				end
					-- We allocate `Result', then use a MANAGED_POINTER to fill its content.
				Result := Result.memory_alloc ((nb + 1) * {PLATFORM}.pointer_bytes)
				create l_ptr.share_from_pointer (Result, (nb + 1) * {PLATFORM}.pointer_bytes)
				across
					a_envs as c
				loop
					if
						attached @ c.key as l_key and then
						attached c as l_value
					then
						create l_str.make (l_key.count + l_value.count + 1)
						l_str.append_string_general (l_key)
						l_str.append_character ('=')
						l_str.append_string_general (l_value)

						create l_natstr.make (l_str)

						l_cstr_ptr := l_cstr_ptr.memory_alloc (l_natstr.bytes_count + 1)
						l_cstr_ptr.memory_copy (l_natstr.item, l_natstr.bytes_count + 1)

						l_ptr.put_pointer (l_cstr_ptr, i * {PLATFORM}.pointer_bytes)

						i := i + 1
					end
				end
				l_ptr.put_pointer (default_pointer, i * {PLATFORM}.pointer_bytes)
			end
		end

	shared_input_unnamed_pipe: detachable UNIX_UNNAMED_PIPE
			-- Pipe used to redirect input of process

	shared_output_unnamed_pipe: detachable UNIX_UNNAMED_PIPE
			-- Pipe used to redirect output of process

	shared_error_unnamed_pipe: detachable UNIX_UNNAMED_PIPE
			-- Pipe used to redirect error of process

	exit_code_from_status (a_status: INTEGER): INTEGER
			-- Exit code evaluated from status returned by process
		external
			"C inline use %"eif_process.h%""
		alias
			"WEXITSTATUS($a_status)"
		end

	terminate_flag_from_status (a_status: INTEGER): BOOLEAN
			-- Returns true if the child terminated normally.
		external
			"C inline use %"eif_process.h%""
		alias
			"WIFEXITED($a_status)"
		end

	signaled_flag_from_status (a_status: INTEGER): BOOLEAN
			-- Returns true if the child process was terminated by a signal.
		external
			"C inline use %"eif_process.h%""
		alias
			"WIFSIGNALED($a_status)"
		end

	stopped_flag_from_status (a_status: INTEGER): BOOLEAN
			-- Returns true if the child process was stopped by delivery of a signal.
		external
			"C inline use %"eif_process.h%""
		alias
			"WIFSTOPPED($a_status)"
		end

	continued_flag_from_status (a_status: INTEGER): BOOLEAN
			-- Returns true if the child process was stopped by delivery of a signal.
		external
			"C inline use %"eif_process.h%""
		alias
			"WIFSTOPPED($a_status)"
		end

	set_is_executing (b: BOOLEAN)
			-- Set `is_executing' with `b'.
		do
			is_executing := b
		ensure
			is_executing_set: is_executing = b
		end

invariant
	input_piped_no_file: input_piped implies input_file_name = Void
	output_piped_no_file: output_piped implies output_file_name = Void
	error_piped_no_file: error_piped implies error_file_name = Void

	input_named_no_pipe: input_file_name /= Void implies not input_piped
	output_named_no_pipe: output_file_name /= Void implies not output_piped
	error_named_no_pipe: error_file_name /= Void implies not error_piped

	valid_stdin_descriptor: valid_file_descriptor (Stdin_descriptor)
	valid_stdout_descriptor: valid_file_descriptor (Stdout_descriptor)
	valid_stderr_descriptor: valid_file_descriptor (Stderr_descriptor)

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
