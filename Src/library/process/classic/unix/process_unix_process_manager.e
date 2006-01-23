indexing
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
create
	make

feature {PROCESS_UNIX_OS} -- Creation

	make (fname: STRING; args: LIST [STRING]; working_dir: STRING) is
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
			leave_input_unchanged: input_file_name.is_equal ("")
			leave_output_unchanged: output_file_name.is_equal ("")
			leave_error_unchanged: error_file_name.is_equal ("")
			input_not_piped: not input_piped
			output_not_piped: not output_piped
			error_not_piped: not error_piped
			no_process_id: process_id = 0
			is_executing_set: not is_executing
		end

feature -- Execution properties

	process_id: INTEGER;
			-- Process id of last child process spawned or
			-- 0 if no processes have been spawned.

feature -- Modification

	set_arguments (arg_list: LIST [STRING]) is
			-- Set `arguments' to `args'.
		local
			count: INTEGER
			i: INTEGER
		do
			if arg_list /= Void then
				count := arg_list.count
				create arguments.make (1, count)
				from
					i := 1
					arg_list.start
				until
					arg_list.after
				loop
					arguments.put (arg_list.item.twin, i)
					arg_list.forth
					i := i + 1
				end
			else
				arguments := Void
			end
		end

	set_close_nonstandard_files (b: BOOLEAN) is
			-- Set `close_nonstandard_files' to `b'
		do
			close_nonstandard_files := b;
		ensure
			value_set: close_nonstandard_files = b
		end

	set_input_file_name (fname: STRING) is
			-- Set `input_file_name' to `fname', which must
			-- be the name of an existing file readable by
			-- the parent process
		do
			input_file_name := fname
			input_piped := (fname = Void)
		end

	set_output_file_name (fname: STRING) is
			-- Set `output_file_name' to `fname', which must
			-- be the name of a file writable by the parent
			-- process.  File is created if it does not exist
			-- and truncated if it does
		do
			output_file_name := fname
			output_piped := (fname = Void)
		end

	set_error_file_name (fname: STRING) is
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

	set_error_same_as_output is
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

feature -- Execution

	is_executing: BOOLEAN
			-- Is launched process executing?

	set_is_executing (b: BOOLEAN) is
			-- Set `is_executing' with `b'.
		do
			is_executing := b
		ensure
			is_executing_set: is_executing = b
		end

	spawn_nowait is
			-- Spawn a process and return immediately.
		local
			ee: EXECUTION_ENVIRONMENT
			cur_dir: STRING
			exceptions: EXCEPTIONS
			i: INTEGER
		do
			build_argument_list
			open_files_and_pipes
			create ee
			if working_directory /= Void then
				create cur_dir.make_from_string ( ee.current_working_directory)
				ee.change_working_directory (working_directory)
			end
			process_id := fork_process
			if process_id = 0 then
				new_process_group
				collection_off
				setup_child_process_files
				exec_process (program_file_name, arguments_for_exec, close_nonstandard_files)
			else
				if process_id /= -1 then
					setup_parent_process_files
					arguments_for_exec := Void
					set_is_executing (True)
				end
				if working_directory /= Void then
					ee.change_working_directory (cur_dir)
				end
			end
		rescue
			if process_id = 0 then
				create exceptions
				exceptions.die (1)
			end
		end

	wait_for_process (pid: INTEGER; is_block: BOOLEAN) is
			-- Wait for any process specified by process
			-- id `pid' to return status.
			-- Block if `is_block' is True.
			-- Set `status_available' with True if process status is available and
			-- if so, set `status' with reported process status.
		do
			unix_waitpid (pid, is_block, $status_available, $status)
			set_is_executing (not status_available)
		end

	status_available: BOOLEAN
			-- Is process status available when `wait_for_process' is called last time?

	status: INTEGER
			-- last reported process status if `status_available' is True

	exit_code_from_status (a_status: INTEGER): INTEGER is
			-- Exit code evaluated from status returned by process
		external
			"C inline use <sys/wait.h>"
		alias
			"WEXITSTATUS($a_status)"
		end

	terminate_hard (is_tree: BOOLEAN) is
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

	read_output_stream (buf_size: INTEGER) is
			-- Read at most `buf_size' bytes of data from output pipe.
			-- Set data in `lasT_outp
		require
			buf_size_positive: buf_size > 0
		do
			if is_executing and then output_piped
			then
				shared_output_unnamed_pipe.read_stream_non_block (buf_size)
				last_output := shared_output_unnamed_pipe.last_string
			else
				last_output := Void
			end
		end

	read_error_stream (buf_size: INTEGER) is
			-- Read at most `buf_size' bytes of data from error pipe.
			-- Set data in `last_error'.
		require
			buf_size_positive: buf_size > 0
		do
			if is_executing and then error_piped and then not error_same_as_output
			then
				shared_error_unnamed_pipe.read_stream_non_block (buf_size)
				last_error := shared_error_unnamed_pipe.last_string
			else
				last_error := Void
			end
		end

	put_string (s: STRING) is
			-- Put `s' into input pipe of process.
		require
			s_not_void: s /= Void
		do
			if is_executing and then input_piped then
				shared_input_unnamed_pipe.put_string (s)
			end
		end

	close_pipes is
			-- Close opened pipes.
		do
			if input_piped then
				shared_input_unnamed_pipe.close_write_descriptor
			end
			if output_piped then
				shared_output_unnamed_pipe.close_read_descriptor
			end
			if error_piped then
				shared_error_unnamed_pipe.close_read_descriptor
			end
		end

	last_output: STRING
			-- Last read data from output pipe

	last_error: STRING
			-- Last read data from error pipe

feature{NONE} -- Properties

	program_file_name: STRING;
			-- Name of file containing program which will be
			-- executed when process is spawned

	arguments: ARRAY [STRING];
			-- Arguments to passed to process when it is spawned,
			-- not including argument 0 (which is conventionally
			-- the name of the program).  If Void or if count
			-- is zero, then no arguments are passed

	close_nonstandard_files: BOOLEAN;
			-- Should nonstandard files (files other than
			-- standard input, standard output and standard
			-- error) be closed in the spawned process?

	input_file_name: STRING;
			-- Name of file to be used as standard input in
			-- spawned process if `input_descriptor' is not a
			-- valid descriptor and `input_piped' is false.
			-- A Void value leaves standard input same as
			-- parent's and an empty string closes standard input

	output_file_name: STRING;
			-- Name of file to be used as standard output in
			-- spawned process if `output_descriptor' is not a
			-- valid descriptor and `output_piped' is false.
			-- A Void value leaves standard output same as
			-- parent's and an empty string closes standard output

	error_file_name: STRING;
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

	build_argument_list is
			-- Build argument list for `exec_process' call
			-- and put it in `arguments_for_exec'.
			-- Make `process_name' argument 0 and append
			-- `arguments' as the rest of the arguments
		local
			k, count, lower, pos: INTEGER
			pname: STRING
			a: ARRAY [STRING]
		do
			if arguments /= Void then
				count := arguments.count + 1;
				lower := arguments.lower;
			else
				count := 1
				lower := 1	-- Not applicable
			end
			create a.make (1, count);

			pname := program_file_name.mirrored
			pos := pname.index_of (Directory_separator, 1)
			if pos /= 0 then
				pname := pname.substring (1, pos - 1)
			end
			pname.mirror
			a.put (pname, 1)
			from
				k := 2
			until
				k > count
			loop
				a.put (arguments.item (lower + k - 2), k)
				k := k + 1
			end
			arguments_for_exec := a;
		end

	open_files_and_pipes is
		local
			pipe_fac: UNIX_PIPE_FACTORY
		do
			create pipe_fac
				-- Open file or pipe for input.
			shared_input_unnamed_pipe := Void
			in_file := Void
			if input_piped then
				shared_input_unnamed_pipe := pipe_fac.new_unnamed_pipe
			elseif
				(input_file_name /= Void) and then
				(not input_file_name.is_empty)
			then
				create in_file.make_open_read (input_file_name)
			end
				-- Open file or pipe for output.
			shared_output_unnamed_pipe := Void
			out_file := Void
			if output_piped then
				shared_output_unnamed_pipe := pipe_fac.new_unnamed_pipe
			elseif
				(output_file_name /= Void) and then
				(not output_file_name.is_empty)
			then
				create out_file.make_open_write (output_file_name)
			end

				-- Open file or pipe for error.
			shared_error_unnamed_pipe := Void
			err_file := Void
			if not error_same_as_output then
				if error_piped then
					shared_error_unnamed_pipe := pipe_fac.new_unnamed_pipe
				elseif
					(error_file_name /= Void) and then
					(not error_file_name.is_empty)
				then
					create err_file.make_open_write (error_file_name)
				end
			end
		end

	setup_parent_process_files is
		do
			if input_piped then
				shared_input_unnamed_pipe.close_read_descriptor
			elseif
				(input_file_name /= Void) and then
				(not input_file_name.is_empty)
			then
				in_file.close
			end

			if output_piped then
				shared_output_unnamed_pipe.close_write_descriptor
			elseif
				(output_file_name /= Void) and then
				(not output_file_name.is_empty)
			then
				out_file.close
			end

			if not error_same_as_output then
				if error_piped then
					shared_error_unnamed_pipe.close_write_descriptor
				elseif
					(error_file_name /= Void) and then
					(not error_file_name.is_empty)
				then
					err_file.close
				end
			end
		end

	setup_child_process_files is
		do
			if input_piped then
				move_desc (shared_input_unnamed_pipe.read_descriptor, stdin_descriptor)
				shared_input_unnamed_pipe.close_write_descriptor
			elseif
				(input_file_name /= Void) and then
				(not input_file_name.is_empty)
			then
				move_desc (in_file.descriptor, stdin_descriptor)
			end

			if output_piped then
				move_desc (shared_output_unnamed_pipe.write_descriptor, stdout_descriptor)
				shared_output_unnamed_pipe.close_read_descriptor
			elseif
				(output_file_name /= Void) and then
				(not output_file_name.is_empty)
			then
				move_desc (out_file.descriptor, stdout_descriptor)
			end

			if error_same_as_output then
				duplicate_file_descriptor (stdout_descriptor, stderr_descriptor)
			else
				if error_piped then
					move_desc (shared_error_unnamed_pipe.write_descriptor, stderr_descriptor)
					shared_error_unnamed_pipe.close_read_descriptor
				elseif
					(error_file_name /= Void) and then
					(not error_file_name.is_empty)
				then
					move_desc (err_file.descriptor, stderr_descriptor)
				end
			end
		end

	move_desc (source, dest: INTEGER) is
			-- If descriptor `source' is different than
			-- descriptor `dest', duplicate `source' onto `dest'
			-- and close `source'
		do
			if source /= dest then
				duplicate_file_descriptor (source, dest)
				close_file_descriptor (source)
			end
		end

feature

	working_directory: STRING
			-- Working directory of process

	arguments_for_exec: ARRAY [STRING]
			-- Arguments to be passed to `exec_process'

feature{NONE} -- Implementation

	in_file: RAW_FILE
			-- File to be used by child process for standard input
			-- when it comes from a file

	out_file: RAW_FILE
			-- File to be used by child process for standard output
			-- when it goes to a file

	err_file: RAW_FILE
			-- File to be used by child process for standard error
			-- when it goes to a file

	Stdin_descriptor: INTEGER is 0
			-- File descriptor for standard input

	Stdout_descriptor: INTEGER is 1
			-- File descriptor for standard output

	Stderr_descriptor: INTEGER is 2
			-- File descriptor for standard error

feature

	shared_input_unnamed_pipe: UNIX_UNNAMED_PIPE
			-- Pipe used to redirect input of process

	shared_output_unnamed_pipe: UNIX_UNNAMED_PIPE
			-- Pipe used to redirect output of process

	shared_error_unnamed_pipe: UNIX_UNNAMED_PIPE
			-- Pipe used to redirect error of process

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
