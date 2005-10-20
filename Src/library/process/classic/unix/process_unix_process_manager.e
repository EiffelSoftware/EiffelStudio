indexing
	description: "A Unix process"
	date: "$Date$"
	revision: "$Revision$"

class PROCESS_UNIX_PROCESS_MANAGER

inherit
	UNIX_SIGNALS
		rename
			meaning as signal_meaning
		export
			{ANY} all
			{NONE} is_defined, is_ignored, signal, catch, ignore,
				reset_all_default, reset_default, is_caught,
				c_signal_map, c_signal_name
		end
		
	PROCESS_UNIX_OS
		rename
			send_signal as unix_send_signal,
			terminate_hard as unix_terminate_hard
		export
			{ANY} valid_file_descriptor, wait_for_process_noblock
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

	make (fname: STRING; working_dir: STRING) is
			-- Create a process object which represents an
			-- independent process that can execute the
			-- program residing in file `fname'
		require
			file_name_exists: fname /= Void
			file_name_not_empty: not fname.is_empty
		do
			initialize (fname);
			create working_directory.make_from_string (working_dir)			
		ensure
			file_name_set: program_file_name.is_equal (fname)
		end;

feature -- Initialization

	initialize (fname: STRING) is
			-- Initialize `Current' with program residing
			-- in file `fname'
		require
			file_name_exists: fname /= Void
			file_name_not_empty: not fname.is_empty
			process_not_executing: not is_executing
		do
			program_file_name := fname;
			is_executing := False;
			process_id := 0;
			in_child := False;
			status := 0;
			input_file_name := Void;
			output_file_name := Void;
			error_file_name := Void;
			input_piped := False;
			output_piped := False;
			error_piped := False;
			arguments := Void;
			process_name := Void;
		ensure
			file_name_set: program_file_name.is_equal (fname)
			leave_input_unchanged: input_file_name = Void
			leave_output_unchanged: output_file_name = Void
			leave_error_unchanged: error_file_name = Void
			input_not_piped: not input_piped
			output_not_piped: not output_piped
			error_not_piped: not error_piped
			no_arguments: arguments = Void
			no_process_name: process_name = Void
			process_not_executing: not is_executing
			no_process_id: process_id = 0
			not_in_child: not in_child
		end;

feature -- Properties

	program_file_name: STRING;
			-- Name of file containing program which will be
			-- executed when process is spawned

	process_name: STRING;
			-- Name to be assigned to process.  Passed as
			-- argument 0 when process is spawned.  If Void,
			-- then last component of `program_file_name'
			-- is passed

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

feature -- Execution properties

	is_executing: BOOLEAN;
			-- Is process represented by `Current' currently 
			-- executing?

	process_id: INTEGER;
			-- Process id of last child process spawned or
			-- 0 if no processes have been spawned.

	in_child: BOOLEAN;
			-- Are we currently executing in the spawned child
			-- process?  Intended only for use after
			-- a spawn call which raises an exception

	status: INTEGER;
			-- Status from last child process that reported
			-- status (0 if none)

feature -- Modification

	set_arguments (args: ARRAY [STRING]) is
			-- Set `arguments' to `args'
		require
			process_not_executing: not is_executing
		do
			arguments := args;
		ensure
			arguments_set: arguments = args
		end

	set_close_nonstandard_files (b: BOOLEAN) is
			-- Set `close_nonstandard_files' to `b'
		require
			process_not_executing: not is_executing
		do
			close_nonstandard_files := b;
		ensure
			value_set: close_nonstandard_files = b
		end

	set_input_file_name (fname: STRING) is
			-- Set `input_file_name' to `fname', which must
			-- be the name of an existing file readable by
			-- the parent process
		require
			process_not_executing: not is_executing
		do
			input_file_name := fname
--			input_descriptor := Invalid_file_descriptor;
			input_piped := (fname = Void)
--		ensure
--			input_not_descriptor: not valid_file_descriptor (input_descriptor)
		end	

	set_output_file_name (fname: STRING) is
			-- Set `output_file_name' to `fname', which must
			-- be the name of a file writable by the parent 
			-- process.  File is created if it does not exist
			-- and truncated if it does
		require
			process_not_executing: not is_executing
		do
			output_file_name := fname
--			output_descriptor := Invalid_file_descriptor;
			output_piped := (fname = Void)
		end		

	set_error_file_name (fname: STRING) is
			-- Set `error_file_name' to `fname', which must
			-- be the name of a file writable by the parent 
			-- process.  File is created if it does not exist
			-- and truncated if it does
		require
			process_not_executing: not is_executing
		do
			error_file_name := fname
--			error_descriptor := Invalid_file_descriptor;
			error_piped := (fname = Void)
			error_same_as_output := False;
		ensure
--			error_not_descriptor: not valid_file_descriptor (error_descriptor)
			error_not_output: not error_same_as_output
		end

	set_error_same_as_output is
			-- Set `error_same_as_output' to true
		require
			process_not_executing: not is_executing
		do
			error_same_as_output := True;
			error_piped := False;
--			error_descriptor := Invalid_file_descriptor;
			error_file_name := Void
		ensure
			error_is_output: error_same_as_output
			error_not_piped: not error_piped
			error_not_file: error_file_name = Void
--			error_not_descriptor: not valid_file_descriptor (error_descriptor)
		end

feature -- Execution

	spawn_nowait is
		local
			ee: EXECUTION_ENVIRONMENT
			cur_dir: STRING
		do		
			build_argument_list
			open_files_and_pipes	
			create ee
			create cur_dir.make_from_string ( ee.current_working_directory)
			ee.change_working_directory (working_directory)
			process_id := fork_process
			if process_id = 0 then
				in_child := True
				collection_off
				setup_child_process_files
				exec_process (program_file_name, arguments_for_exec, close_nonstandard_files)
			else
				setup_parent_process_files
				arguments_for_exec := Void
				ee.change_working_directory (cur_dir)
			end
			is_executing := True
		ensure
			process_executing: is_executing
			process_id_set: process_id /= 0
--			input_pipe_set: input_piped implies input_to_child /= Void
--			output_pipe_set: output_piped implies output_from_child /= Void
--			error_pipe_set: error_piped implies error_from_child /= Void
		end

	get_status_block is
			-- Wait for executing child process to report status
			-- and put it in `status'.  If child has not 
			-- reported status yet, block until it does
		require
			process_executing: is_executing
		do
			status := wait_for_process_block (process_id)
			is_executing := False
		ensure
			process_not_executing: not is_executing
		end

	send_signal (sig: INTEGER) is
			-- Send signal number `sig' to child process
		require
			process_executing: is_executing
		do
			unix_send_signal (sig, process_id)
		end
	
	terminate_hard is
			-- Send a kill signal (SIGKILL) to child process
		require
			process_executing: is_executing
		do
			unix_terminate_hard (process_id)
		end

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
			if process_name /= Void then
				pname := process_name
			else
				pname := program_file_name.mirrored
				pos := pname.index_of (Directory_separator, 1)
				if pos /= 0 then
					pname := pname.substring (1, pos - 1)
				end
				pname.mirror
			end
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
	
feature	
	
	in_file: RAW_FILE
			-- File to be used by child process for standard input
			-- when it comes from a file
	
	out_file: RAW_FILE
			-- File to be used by child process for standard output
			-- when it goes to a file
	
	err_file: RAW_FILE
			-- File to be used by child process for standard error
			-- when it goes to a file

feature
	
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

end
