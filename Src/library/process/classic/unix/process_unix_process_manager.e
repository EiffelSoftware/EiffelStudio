note
	description: "A Unix process launcher with IO redirection capability"
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

create
	make

feature {PROCESS_UNIX_OS} -- Creation

	make (fname: STRING; args: ?LIST [STRING]; working_dir: like working_directory)
			-- Create a process object which represents an
			-- independent process that can execute the
			-- program residing in file `fname'
		require
			file_name_exists: fname /= Void
			file_name_not_empty: not fname.is_empty
		do
			working_directory := working_dir
			program_file_name := fname
			set_arguments (args)
			process_id := 0
			set_input_file_name ("")
			set_output_file_name ("")
			set_error_file_name ("")
			set_is_executing (False)
		ensure
			program_file_name_set: program_file_name.is_equal (fname)
			input_file_name_empty: {l_input_fn: like input_file_name} input_file_name and then l_input_fn.is_empty
			output_file_name_empty: {l_output_fn: like output_file_name} output_file_name and then l_output_fn.is_empty
			error_file_name_empty: {l_error_fn: like error_file_name} error_file_name and then l_error_fn.is_empty
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

	working_directory: ?STRING
			-- Working directory of process

	arguments_for_exec: ?ARRAY [STRING]
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

	set_arguments (arg_list: ?LIST [STRING])
			-- Set `arguments' to `args'.
		local
			count: INTEGER
			i: INTEGER
			l_arguments: like arguments
		do
			if arg_list /= Void then
				count := arg_list.count
				create l_arguments.make (1, count)
				from
					i := 1
					arg_list.start
				until
					arg_list.after
				loop
					l_arguments.put (arg_list.item.twin, i)
					arg_list.forth
					i := i + 1
				end
				arguments := l_arguments
			else
				arguments := Void
			end
		end

	set_close_nonstandard_files (b: BOOLEAN)
			-- Set `close_nonstandard_files' to `b'
		do
			close_nonstandard_files := b;
		ensure
			value_set: close_nonstandard_files = b
		end

	set_input_file_name (fname: like input_file_name)
			-- Set `input_file_name' to `fname', which must
			-- be the name of an existing file readable by
			-- the parent process
		do
			input_file_name := fname
			input_piped := (fname = Void)
		end

	set_output_file_name (fname: like output_file_name)
			-- Set `output_file_name' to `fname', which must
			-- be the name of a file writable by the parent
			-- process.  File is created if it does not exist
			-- and truncated if it does
		do
			output_file_name := fname
			output_piped := (fname = Void)
		end

	set_error_file_name (fname: like error_file_name)
			-- Set `error_file_name' to `fname', which must
			-- be the name of a file writable by the parent
			-- process.  File is created if it does not exist
			-- and truncated if it does
		do
			error_file_name := fname
			error_piped := (fname = Void)
			error_same_as_output := False;
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

feature {PROCESS_IMP} -- Process management

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
		local
			l_in_pipe: like shared_input_unnamed_pipe
			l_out_pipe: like shared_output_unnamed_pipe
			l_err_pipe: like shared_error_unnamed_pipe
		do
			if input_piped then
				l_in_pipe := shared_input_unnamed_pipe
				check l_in_pipe /= Void end
				l_in_pipe.close_write_descriptor
			end
			if output_piped then
				l_out_pipe := shared_output_unnamed_pipe
				check l_out_pipe /= Void end
				l_out_pipe.close_read_descriptor
			end
			if error_piped then
				l_err_pipe := shared_error_unnamed_pipe
				check l_err_pipe /= Void end
				l_err_pipe.close_read_descriptor
			end
		end

	spawn_nowait (is_control_terminal_enabled: BOOLEAN; evnptr: POINTER; a_new_process_group: BOOLEAN)
			-- Spawn a process and return immediately.
			-- If `is_control_terminal_enabled' is true, attach controlling terminals to spawned process.
			-- Environment variables for new process is stored in `envptr'. If `envptr' is `default_pointer',
			-- new process will inherit all environment variables from its parent process.
			-- If `a_new_process_group' is True, launch process in a new process group.
			-- Check `is_last_process_spawn_successful' after to make sure process has been spawned successfully.
        local
            ee: EXECUTION_ENVIRONMENT
            cur_dir: ?STRING
            exceptions: EXCEPTIONS
            d: like internal_debug_mode
            l_working_directory: like working_directory
            l_arguments: like arguments_for_exec
        do
            build_argument_list
            open_files_and_pipes
            create ee
            l_working_directory := working_directory
            if l_working_directory /= Void then
                create cur_dir.make_from_string (ee.current_working_directory)
                ee.change_working_directory (l_working_directory)
            end
            d := internal_debug_mode
            internal_set_debug_mode (0)
            process_id := fork_process
            inspect process_id
            when -1 then --| Error
                internal_set_debug_mode (d)
                -- Error ... no fork allowed
                if l_working_directory /= Void then
                	check cur_dir /= Void end
                    ee.change_working_directory (cur_dir)
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
                l_arguments := arguments_for_exec
                check l_arguments /= Void end
                exec_process (program_file_name, l_arguments, close_nonstandard_files, evnptr)
            else --| Parent process
                internal_set_debug_mode (d)
                setup_parent_process_files
                arguments_for_exec := Void
                set_is_executing (True)
                if l_working_directory /= Void then
                	check cur_dir /= Void end
                    ee.change_working_directory (cur_dir)
                end
            end
        rescue
            if process_id = 0 then
                create exceptions
                exceptions.die (1)
            end
            internal_set_debug_mode (d)
        end

	terminate_hard (is_tree: BOOLEAN)
			-- Send a kill signal (SIGKILL) to process(es).
			-- if `is_tree' is True, send signal to whole process group,
			-- otherwise only send signal to current launched process.
		do
			if is_tree then
				unix_terminate_hard (-process_id)
			else
				unix_terminate_hard (process_id)
			end
		end

	read_output_stream (buf_size: INTEGER)
			-- Read at most `buf_size' bytes of data from output pipe.
			-- Set data in `lasT_outp
		require
			buf_size_positive: buf_size > 0
		local
			l_out_pipe: like shared_output_unnamed_pipe
		do
			if output_piped then
				l_out_pipe := shared_output_unnamed_pipe
				check l_out_pipe /= Void end
				l_out_pipe.read_stream_non_block (buf_size)
				last_output := l_out_pipe.last_string
			else
				last_output := Void
			end
		end

	read_error_stream (buf_size: INTEGER)
			-- Read at most `buf_size' bytes of data from error pipe.
			-- Set data in `last_error'.
		require
			buf_size_positive: buf_size > 0
		local
			l_err_pipe: like shared_error_unnamed_pipe
		do
			if error_piped and then not error_same_as_output then
				l_err_pipe := shared_error_unnamed_pipe
				check l_err_pipe /= Void end
				l_err_pipe.read_stream_non_block (buf_size)
				last_error := l_err_pipe.last_string
			else
				last_error := Void
			end
		end

	put_string (s: STRING)
			-- Put `s' into input pipe of process.
		require
			s_not_void: s /= Void
		local
			l_in_pipe: like shared_input_unnamed_pipe
		do
			if is_executing and then input_piped then
				l_in_pipe := shared_input_unnamed_pipe
				check l_in_pipe /= Void end
				l_in_pipe.put_string (s)
			end
		end

	last_output: ?STRING
			-- Last read data from output pipe

	last_error: ?STRING
			-- Last read data from error pipe

feature {NONE} -- Properties

	program_file_name: STRING;
			-- Name of file containing program which will be
			-- executed when process is spawned

	arguments: ?ARRAY [STRING];
			-- Arguments to passed to process when it is spawned,
			-- not including argument 0 (which is conventionally
			-- the name of the program).  If Void or if count
			-- is zero, then no arguments are passed

	close_nonstandard_files: BOOLEAN;
			-- Should nonstandard files (files other than
			-- standard input, standard output and standard
			-- error) be closed in the spawned process?

	input_file_name: ?STRING;
			-- Name of file to be used as standard input in
			-- spawned process if `input_descriptor' is not a
			-- valid descriptor and `input_piped' is false.
			-- A Void value leaves standard input same as
			-- parent's and an empty string closes standard input

	output_file_name: ?STRING;
			-- Name of file to be used as standard output in
			-- spawned process if `output_descriptor' is not a
			-- valid descriptor and `output_piped' is false.
			-- A Void value leaves standard output same as
			-- parent's and an empty string closes standard output

	error_file_name: ?STRING;
			-- Name of file to be used as standard error in
			-- spawned process if `error_descriptor' is not a
			-- valid descriptor and `error_piped' is false.
			-- A Void value leaves standard error same as
			-- parent's and an empty string closes standard error

	input_piped: BOOLEAN;
			-- Should standard input for spawned process
			-- come from a pipe connected to parent,
			-- instead of from a file descriptor or named file?

	output_piped: BOOLEAN;
			-- Should standard output for spawned process go to a
			-- pipe connected to parent, instead of to a
			-- file descriptor or named file?

	error_piped: BOOLEAN;
			-- Should standard error for spawned process go to a
			-- pipe connected to parent, instead of to a
			-- file descriptor or named file?

	error_same_as_output: BOOLEAN;
			-- Should standard error for spawned process be
			-- the same as standard output (i.e., identical
			-- file descriptor)?		

feature {NONE} -- Implementation

	build_argument_list
			-- Build argument list for `exec_process' call
			-- and put it in `arguments_for_exec'.
			-- Make `process_name' argument 0 and append
			-- `arguments' as the rest of the arguments
		local
			k, count, lower: INTEGER
			pname: STRING
			a: ARRAY [STRING]
			l_arguments: like arguments
		do
			l_arguments := arguments
			if l_arguments /= Void then
				count := l_arguments.count + 1;
				lower := l_arguments.lower;
			else
				count := 1
				lower := 1	-- Not applicable
			end
			create a.make (1, count);

			pname := program_file_name
			a.put (pname, 1)
			from
				k := 2
			until
				k > count
			loop
				check l_arguments /= Void end
				a.put (l_arguments.item (lower + k - 2), k)
				k := k + 1
			end
			arguments_for_exec := a;
		ensure
			arguments_for_exec_attached: arguments_for_exec /= Void
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
					create out_file.make_open_write (l_output_fn)
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
						create err_file.make_open_write (l_error_fn)
					end
				end
			end
		end

	setup_parent_process_files
		local
			l_input_fn: like input_file_name
			l_output_fn: like output_file_name
			l_error_fn: like error_file_name
			l_in_pipe: like shared_input_unnamed_pipe
			l_out_pipe: like shared_output_unnamed_pipe
			l_err_pipe: like shared_error_unnamed_pipe
			l_in_file: like in_file
			l_out_file: like out_file
			l_err_file: like err_file
		do
			if input_piped then
				l_in_pipe := shared_input_unnamed_pipe
				check l_in_pipe /= Void end
				l_in_pipe.close_read_descriptor
			else
				l_input_fn := input_file_name
				if l_input_fn /= Void and then not l_input_fn.is_empty then
					l_in_file := in_file
					check l_in_file /= Void end
					l_in_file.close
				end
			end

			if output_piped then
				l_out_pipe := shared_output_unnamed_pipe
				check l_out_pipe /= Void end
				l_out_pipe.close_write_descriptor
			else
				l_output_fn := output_file_name
				if l_output_fn /= Void and then not l_output_fn.is_empty then
					l_out_file := out_file
					check l_out_file /= Void end
					l_out_file.close
				end
			end

			if not error_same_as_output then
				if error_piped then
					l_err_pipe := shared_error_unnamed_pipe
					check l_err_pipe /= Void end
					l_err_pipe.close_write_descriptor
				else
					l_error_fn := error_file_name
					if l_error_fn /= Void and then not l_error_fn.is_empty then
						l_err_file := err_file
						check l_err_file /= Void end
						l_err_file.close
					end
				end
			end
		end

	setup_child_process_files
		local
			l_input_fn: like input_file_name
			l_output_fn: like output_file_name
			l_error_fn: like error_file_name
			l_in_pipe: like shared_input_unnamed_pipe
			l_out_pipe: like shared_output_unnamed_pipe
			l_err_pipe: like shared_error_unnamed_pipe
			l_in_file: like in_file
			l_out_file: like out_file
			l_err_file: like err_file
		do
			if input_piped then
				l_in_pipe := shared_input_unnamed_pipe
				check l_in_pipe /= Void end
				move_desc (l_in_pipe.read_descriptor, stdin_descriptor)
				l_in_pipe.close_write_descriptor
			else
				l_input_fn := input_file_name
				if l_input_fn /= Void and then not l_input_fn.is_empty then
					l_in_file := in_file
					check l_in_file /= Void end
					move_desc (l_in_file.descriptor, stdin_descriptor)
				end
			end
			if output_piped then
				l_out_pipe := shared_output_unnamed_pipe
				check l_out_pipe /= Void end
				move_desc (l_out_pipe.write_descriptor, stdout_descriptor)
				l_out_pipe.close_read_descriptor
			else
				l_output_fn := output_file_name
				if l_output_fn /= Void and then not l_output_fn.is_empty then
					l_out_file := out_file
					check l_out_file /= Void end
					move_desc (l_out_file.descriptor, stdout_descriptor)
				end
			end

			if error_same_as_output then
				duplicate_file_descriptor (stdout_descriptor, stderr_descriptor)
			else
				if error_piped then
					l_err_pipe := shared_error_unnamed_pipe
					check l_err_pipe /= Void end
					move_desc (l_err_pipe.write_descriptor, stderr_descriptor)
					l_err_pipe.close_read_descriptor
				else
					l_error_fn := error_file_name
					if l_error_fn /= Void and then not l_error_fn.is_empty then
						l_err_file := err_file
						check l_err_file /= Void end
						move_desc (l_err_file.descriptor, stderr_descriptor)
					end
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

feature {NONE} -- Implementation

	in_file: ?RAW_FILE
			-- File to be used by child process for standard input
			-- when it comes from a file

	out_file: ?RAW_FILE
			-- File to be used by child process for standard output
			-- when it goes to a file

	err_file: ?RAW_FILE
			-- File to be used by child process for standard error
			-- when it goes to a file

	Stdin_descriptor: INTEGER = 0
			-- File descriptor for standard input

	Stdout_descriptor: INTEGER = 1
			-- File descriptor for standard output

	Stderr_descriptor: INTEGER = 2
			-- File descriptor for standard error

feature {NONE} -- Implementation

	shared_input_unnamed_pipe: ?UNIX_UNNAMED_PIPE
			-- Pipe used to redirect input of process

	shared_output_unnamed_pipe: ?UNIX_UNNAMED_PIPE
			-- Pipe used to redirect output of process

	shared_error_unnamed_pipe: ?UNIX_UNNAMED_PIPE
			-- Pipe used to redirect error of process

	exit_code_from_status (a_status: INTEGER): INTEGER
			-- Exit code evaluated from status returned by process
		external
			"C inline use <sys/wait.h>"
		alias
			"WEXITSTATUS($a_status)"
		end

	terminate_flag_from_status (a_status: INTEGER): BOOLEAN
			-- Returns true if the child terminated normally.
		external
			"C inline use <sys/wait.h>"
		alias
			"WIFEXITED($a_status)"
		end

	signaled_flag_from_status (a_status: INTEGER): BOOLEAN
			-- Returns true if the child process was terminated by a signal.
		external
			"C inline use <sys/wait.h>"
		alias
			"WIFSIGNALED($a_status)"
		end

	stopped_flag_from_status (a_status: INTEGER): BOOLEAN
			-- Returns true if the child process was stopped by delivery of a signal.
		external
			"C inline use <sys/wait.h>"
		alias
			"WIFSTOPPED($a_status)"
		end

	continued_flag_from_status (a_status: INTEGER): BOOLEAN
			-- Returns true if the child process was stopped by delivery of a signal.
		external
			"C inline use <sys/wait.h>"
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

feature {NONE} -- Debugger access

    internal_set_debug_mode (a_debug_mode: INTEGER)
            --
        external
            "C inline use%"eif_main.h%""
        alias
            "[
			#ifdef WORKBENCH
				set_debug_mode ($a_debug_mode);
			#endif
			]"
        end

    internal_debug_mode: INTEGER
            -- State of debugger.
        external
            "C inline use %"eif_main.h%""
        alias
			"[
			#ifdef WORKBENCH
				return is_debug_mode();
			#else
				return 0;
			#endif
			]"
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
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
