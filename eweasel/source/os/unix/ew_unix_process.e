indexing
	date: "October 9, 1997";
	description: "A Unix process"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EW_UNIX_PROCESS

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
	EW_UNIX_OS
		rename
			send_signal as unix_send_signal,
			terminate_hard as unix_terminate_hard
		export
			{ANY} valid_file_descriptor
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

feature {EW_UNIX_OS} -- Creation

	make (fname: STRING) is
			-- Create a process object which represents an
			-- independent process that can execute the
			-- program residing in file `fname'
		require
			file_name_exists: fname /= Void
			file_name_not_empty: not fname.is_empty
		do
			initialize (fname);
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
			child_input_file := Void;
			child_output_file := Void;
			child_error_file := Void;
			arguments := Void;
			process_name := Void;
			input_descriptor := Invalid_file_descriptor;
			output_descriptor := Invalid_file_descriptor;
			error_descriptor := Invalid_file_descriptor;
		ensure
			file_name_set: program_file_name.is_equal (fname)
			leave_input_unchanged: input_file_name = Void
			leave_output_unchanged: output_file_name = Void
			leave_error_unchanged: error_file_name = Void
			input_not_piped: not input_piped
			output_not_piped: not output_piped
			error_not_piped: not error_piped
			input_not_descriptor: not valid_file_descriptor (input_descriptor)
			output_not_descriptor: not valid_file_descriptor (output_descriptor)
			error_not_descriptor: not valid_file_descriptor (error_descriptor)
			no_input_pipe: input_to_child = Void
			no_output_pipe: output_from_child = Void
			no_error_pipe: error_from_child = Void
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

	input_descriptor: INTEGER;
			-- Descriptor to be used as standard input in
			-- spawned process, if value is valid descriptor

	output_descriptor: INTEGER;
			-- Descriptor to be used as standard output in
			-- spawned process, if value is valid descriptor

	error_descriptor: INTEGER;
			-- Descriptor to be used as standard error in
			-- spawned process, if value is valid descriptor

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

	output_from_child: RAW_FILE is
			-- File from which parent can read output coming
			-- from spawned process, if `output_piped' is true.
			-- If `error_same_as_output' is true, this output
			-- includes the child's standard error as well as
			-- standard output
		require
			child_output_piped: output_piped
		do
			Result := child_output_file
		ensure
			result_exists: Result /= Void
		end

	input_to_child: RAW_FILE is
			-- File to which parent can write input going to
			-- spawned process, if `input_piped' is true
		require
			child_input_piped: input_piped
		do
			Result := child_input_file
		ensure
			result_exists: Result /= Void
		end

	error_from_child: RAW_FILE is
			-- File from which parent can read error input coming
			-- from spawned process, if `error_piped' is true
		require
			child_error_piped: error_piped
		do
			Result := child_error_file
		ensure
			result_exists: Result /= Void
		end

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
			input_descriptor := Invalid_file_descriptor;
			input_piped := False;
		ensure
			file_name_set: equal (input_file_name, fname)
			input_not_descriptor: not valid_file_descriptor (input_descriptor)
			input_not_piped: not input_piped
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
			output_descriptor := Invalid_file_descriptor;
			output_piped := False;
		ensure
			file_name_set: equal (output_file_name, fname)
			output_not_descriptor: not valid_file_descriptor (output_descriptor)
			output_not_piped: not output_piped
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
			error_descriptor := Invalid_file_descriptor;
			error_piped := False;
			error_same_as_output := False;
		ensure
			file_name_set: equal (error_file_name, fname)
			error_not_descriptor: not valid_file_descriptor (error_descriptor)
			error_not_piped: not error_piped
			error_not_output: not error_same_as_output
		end

	set_input_piped is
			-- Set `input_piped' to true
		require
			process_not_executing: not is_executing
		do
			input_piped := True;
			input_descriptor := Invalid_file_descriptor;
			input_file_name := Void
		ensure
			piped_input_set: input_piped
			input_not_file: input_file_name = Void
			input_not_descriptor: not valid_file_descriptor (input_descriptor)
		end

	set_output_piped is
			-- Set `output_piped' to true
		require
			process_not_executing: not is_executing
		do
			output_piped := True;
			output_descriptor := Invalid_file_descriptor;
			output_file_name := Void
		ensure
			piped_output_set: output_piped
			output_not_file: output_file_name = Void
			output_not_descriptor: not valid_file_descriptor (output_descriptor)
		end

	set_error_piped is
			-- Set `error_piped' to true
		require
			process_not_executing: not is_executing
		do
			error_piped := True;
			error_descriptor := Invalid_file_descriptor;
			error_file_name := Void
			error_same_as_output := False;
		ensure
			piped_error_set: error_piped
			error_not_file: error_file_name = Void
			error_not_descriptor: not valid_file_descriptor (error_descriptor)
			error_not_output: not error_same_as_output
		end

	set_error_same_as_output is
			-- Set `error_same_as_output' to true
		require
			process_not_executing: not is_executing
		do
			error_same_as_output := True;
			error_piped := False;
			error_descriptor := Invalid_file_descriptor;
			error_file_name := Void
		ensure
			error_is_output: error_same_as_output
			error_not_piped: not error_piped
			error_not_file: error_file_name = Void
			error_not_descriptor: not valid_file_descriptor (error_descriptor)
		end

feature -- Execution

	spawn_nowait is
			-- Spawn process and do not wait for it to report 
			-- status before returning.  This routine may
			-- raise an exception in the parent and/or child
			-- process.  Feature `in_child' distinguishes whether
			-- the child process got the exception
		require
			process_not_executing: not is_executing
		do
			build_argument_list;
			open_files_and_pipes;
			process_id := fork_process
			if process_id = 0 then	-- Child
				in_child := True
				collection_off;
				setup_child_process_files;
				exec_process (program_file_name, arguments_for_exec, close_nonstandard_files)
				-- Never returns.  Either exec works
				-- or an exception is raised
			else			-- Parent
				setup_parent_process_files;
				arguments_for_exec := Void
			end
			is_executing := True
		ensure
			process_executing: is_executing
			process_id_set: process_id /= 0
			input_pipe_set: input_piped implies input_to_child /= Void
			output_pipe_set: output_piped implies output_from_child /= Void
			error_pipe_set: error_piped implies error_from_child /= Void
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
			-- Open any files that the child process will use 
			-- for standard input, output or error.  Create
			-- any pipes that will be needed
		do
			child_input_file := Void
			shared_input_pipe := Void
			in_file := Void
			if input_piped then
				shared_input_pipe := new_pipe;
			elseif valid_file_descriptor (input_descriptor) then
				-- No action
			elseif input_file_name = Void then
				-- No action
			elseif input_file_name.is_empty then
				-- No action
			else 	-- input_file_name is non-empty
				create in_file.make_open_read (input_file_name);
			end
			
			child_output_file := Void
			shared_output_pipe := Void
			out_file := Void
			if output_piped then
				shared_output_pipe := new_pipe;
			elseif valid_file_descriptor (output_descriptor) then
				-- No action
			elseif output_file_name = Void then
				-- No action
			elseif output_file_name.is_empty then
				-- No action
			else 	-- output_file_name is non-empty
				create out_file.make_open_write (output_file_name);
			end
			
			child_error_file := Void
			shared_error_pipe := Void
			err_file := Void
			if error_same_as_output then
				-- No action
			elseif error_piped then
				shared_error_pipe := new_pipe;
			elseif valid_file_descriptor (error_descriptor) then
				-- No action
			elseif error_file_name = Void then
				-- No action
			elseif error_file_name.is_empty then
				-- No action
			else 	-- error_file_name is non-empty
				create err_file.make_open_write (error_file_name);
			end
		end
	
	setup_parent_process_files is
			-- Setup files for parent after doing fork
		do
			if input_piped then
				create child_input_file.make ("Input_to_child");
				child_input_file.fd_open_write (shared_input_pipe.write_descriptor)
				shared_input_pipe.erase_write_descriptor
				shared_input_pipe.close_read_descriptor
			elseif valid_file_descriptor (input_descriptor) then
				-- No action
			elseif input_file_name = Void then
				-- No action
			elseif input_file_name.is_empty then
				-- No action
			else 	-- input_file_name is non-empty
				in_file.close
			end
			shared_input_pipe := Void
			in_file := Void
			
			if output_piped then
				create child_output_file.make ("Output_from_child");
				child_output_file.fd_open_read (shared_output_pipe.read_descriptor)
				shared_output_pipe.erase_read_descriptor
				shared_output_pipe.close_write_descriptor
			elseif valid_file_descriptor (output_descriptor) then
				-- No action
			elseif output_file_name = Void then
				-- No action
			elseif output_file_name.is_empty then
				-- No action
			else 	-- output_file_name is non-empty
				out_file.close
			end
			shared_output_pipe := Void
			out_file := Void
			
			if error_same_as_output then
				-- No action
			elseif error_piped then
				create child_error_file.make ("Error_from_child");
				child_error_file.fd_open_read (shared_error_pipe.read_descriptor)
				shared_error_pipe.erase_read_descriptor
				shared_error_pipe.close_write_descriptor
			elseif valid_file_descriptor (error_descriptor) then
				-- No action
			elseif error_file_name = Void then
				-- No action
			elseif error_file_name.is_empty then
				-- No action
			else 	-- error_file_name is non-empty
				err_file.close
			end
			shared_error_pipe := Void
			err_file := Void
			
		end
	
	setup_child_process_files is
			-- Setup standard input, output and error in
			-- child process after fork and before calling 
			-- `exec_process'
		require
			in_child_process: in_child
		do
			if input_piped then
				move_desc (shared_input_pipe.read_descriptor, Stdin_descriptor)
				shared_input_pipe.close_write_descriptor
			elseif valid_file_descriptor (input_descriptor) then
				duplicate_file_descriptor (input_descriptor, Stdin_descriptor)
			elseif input_file_name = Void then
				-- No action
			elseif input_file_name.is_empty then
				close_file_descriptor (Stdin_descriptor)
			else 	-- input_file_name is non-empty
				move_desc (in_file.descriptor, Stdin_descriptor)
			end
			
			if output_piped then
				move_desc (shared_output_pipe.write_descriptor, Stdout_descriptor)
				shared_output_pipe.close_read_descriptor
			elseif valid_file_descriptor (output_descriptor) then
				duplicate_file_descriptor (output_descriptor, Stdout_descriptor)
			elseif output_file_name = Void then
				-- No action
			elseif output_file_name.is_empty then
				close_file_descriptor (Stdout_descriptor)
			else 	-- output_file_name is non-empty
				move_desc (out_file.descriptor, Stdout_descriptor)
			end
			
			if error_same_as_output then
				duplicate_file_descriptor (Stdout_descriptor, Stderr_descriptor)
			elseif error_piped then
				move_desc (shared_error_pipe.write_descriptor, Stderr_descriptor)
				shared_error_pipe.close_read_descriptor
			elseif valid_file_descriptor (error_descriptor) then
				duplicate_file_descriptor (error_descriptor, Stderr_descriptor)
			elseif error_file_name = Void then
				-- No action
			elseif error_file_name.is_empty then
				close_file_descriptor (Stderr_descriptor)
			else 	-- error_file_name is non-empty
				move_desc (err_file.descriptor, Stderr_descriptor)
			end
		
			-- Close `input_descriptor', `output_descriptor'
			-- and `error_descriptor' if valid

			if valid_file_descriptor (input_descriptor) then
				close_file_descriptor (input_descriptor)
			end
			if valid_file_descriptor (output_descriptor) and 
			   output_descriptor /= input_descriptor then
				close_file_descriptor (output_descriptor)
			end
			if valid_file_descriptor (error_descriptor) and
			   error_descriptor /= input_descriptor and
			   error_descriptor /= output_descriptor then
				close_file_descriptor (error_descriptor)
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
	
	in_file: RAW_FILE
			-- File to be used by child process for standard input
			-- when it comes from a file
	
	out_file: RAW_FILE
			-- File to be used by child process for standard output
			-- when it goes to a file
	
	err_file: RAW_FILE
			-- File to be used by child process for standard error
			-- when it goes to a file
	
	shared_input_pipe: EW_UNIX_PIPE
			-- Pipe to be used by child process for standard input
	
	shared_output_pipe: EW_UNIX_PIPE
			-- Pipe to be used by child process for standard output
	
	shared_error_pipe: EW_UNIX_PIPE
			-- Pipe to be used by child process for standard error
	
	arguments_for_exec: ARRAY [STRING]
			-- Arguments to be passed to `exec_process'
	
	child_input_file: RAW_FILE;
			-- File from which child reads input (and to
			-- which parent writes output) when
			-- `input_piped' is true

	child_output_file: RAW_FILE;
			-- File to which child writes output (and from
			-- which parent reads input) when
			-- `output_piped' is true

	child_error_file: RAW_FILE;
			-- File to which child writes error output (and from
			-- which parent reads error input) when
			-- `error_piped' is true

	Stdin_descriptor: INTEGER is 0
			-- File descriptor for standard input

	Stdout_descriptor: INTEGER is 1
			-- File descriptor for standard output
	
	Stderr_descriptor: INTEGER is 2
			-- File descriptor for standard error

invariant

	input_piped_no_desc: input_piped implies 
		not valid_file_descriptor (input_descriptor)
	output_piped_no_desc: output_piped implies 
		not valid_file_descriptor (output_descriptor)
	error_piped_no_desc: error_piped implies 
		not valid_file_descriptor (error_descriptor)
	
	input_piped_no_file: input_piped implies input_file_name = Void
	output_piped_no_file: output_piped implies output_file_name = Void
	error_piped_no_file: error_piped implies error_file_name = Void
	
	input_named_no_desc: input_file_name /= Void implies 
		not valid_file_descriptor (input_descriptor)
	output_named_no_desc: output_file_name /= Void implies 
		not valid_file_descriptor (output_descriptor)
	error_named_no_desc: error_file_name /= Void implies 
		not valid_file_descriptor (error_descriptor)
	
	input_named_no_pipe: input_file_name /= Void implies 
		not input_piped
	output_named_no_pipe: output_file_name /= Void implies 
		not output_piped
	error_named_no_pipe: error_file_name /= Void implies 
		not error_piped
	
	input_desc_no_file: valid_file_descriptor (input_descriptor) implies
		input_file_name = Void
	output_desc_no_file: valid_file_descriptor (output_descriptor) implies
		output_file_name = Void
	error_desc_no_file: valid_file_descriptor (error_descriptor) implies
		error_file_name = Void
	
	input_desc_no_pipe: valid_file_descriptor (input_descriptor) implies
		not input_piped
	output_desc_no_pipe: valid_file_descriptor (output_descriptor) implies
		not output_piped
	error_desc_no_pipe: valid_file_descriptor (error_descriptor) implies
		not error_piped
	
	invalid_descriptor_invalid: not valid_file_descriptor (Invalid_file_descriptor)
	valid_stdin_descriptor: valid_file_descriptor (Stdin_descriptor)
	valid_stdout_descriptor: valid_file_descriptor (Stdout_descriptor)
	valid_stderr_descriptor: valid_file_descriptor (Stderr_descriptor)

indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"


end -- class UNIX_PROCESS
