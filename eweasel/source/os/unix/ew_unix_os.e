indexing
	description: "Unix-specific operating system services"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "October 7, 1997"

class EW_UNIX_OS

inherit
	EW_OPERATING_SYSTEM

	UNIX_SIGNALS
		rename
			meaning as signal_meaning
		end

	EXECUTION_ENVIRONMENT
		export
			{ANY} return_code ;
			{NONE} all
		end
		
	EW_UNIX_EXTERNALS

feature -- Path names

	null_file_name: STRING is "/dev/null";
			-- File name which represents null input or output

	full_file_name (dir_name, f_name: STRING): STRING is
			-- Full name of file in directory `dir_name'
			-- with name `f_name'.
		do
			create Result.make (dir_name.count + f_name.count + 1);
			if not dir_name.is_empty then
				Result.append (dir_name);
				if dir_name.item (dir_name.count) /= Directory_separator then
					Result.extend (Directory_separator);
				end
			end
			Result.append (f_name);
		end;

	executable_full_file_name (dir_name, f_name: STRING): STRING is
			-- Full name of file in directory `dir_name'
			-- with name `f_name'.
		do
			Result := full_file_name (dir_name, f_name)
		end;

	full_directory_name (dir_name, subdir: STRING): STRING is
			-- Full name of subdirectory `subdir' of directory
			-- `dir_name'
		do
			Result := full_file_name (dir_name, subdir);
		end;


feature -- Pipes

	new_pipe: EW_UNIX_PIPE is
			-- New pipe object for interprocess communication
		local
			read_fd, write_fd: INTEGER
		do
			unix_pipe ($read_fd, $write_fd);
			create Result.make (read_fd, write_fd);
		ensure
			result_exists: Result /= Void;
		end;

feature -- Process operations

	fork_process: INTEGER is
			-- Fork a new process.  Return process id of new
			-- process to the parent process and 0 to the child
		do
			Result := unix_fork_process;
		ensure
			process_id_nonnegative: Result >= 0
		end;

	exec_process (prog_file: STRING; args: ARRAY [STRING];
			close_nonstd_files: BOOLEAN) is
			-- Overlay the process with a new process,
			-- which will execute program `prog_file' with
			-- arguments `args'.  If `close_nonstd_files'
			-- is true, then change all open file
			-- descriptors greater than 2 so that they are
			-- closed on a successful exec.  The new
			-- process has the same environment as the
			-- current one.  This routine never returns to
			-- the caller normally, although it may raise
			-- an exception
		require
			program_name_exists: prog_file /= Void
			arguments_exist: args /= Void
		local
			k, count, lower: INTEGER;
			pname, area: ANY;
			arguments, arg_copy, null_ptr, env_ptr: POINTER;
		do
			count := args.count;
			lower := args.lower;
			pname := prog_file.to_c;
			arguments := unix_allocate_arg_memory (count + 1);
			from
				k := 1;
			until
				k > count
			loop
				area := args.item (lower + k - 1).to_c;
				arg_copy := str_dup ($area);
				unix_set_arg_value (arguments, k - 1, arg_copy);
				k := k + 1
			end
			unix_set_arg_value (arguments, count, null_ptr);
			env_ptr := default_pointer
			unix_exec_process ($pname, arguments, env_ptr, close_nonstd_files);
		end;

	wait_for_process_block (pid: INTEGER): INTEGER is
			-- Wait for any process specified by process id
			-- `pid' to return status.  Block until there
			-- a process returns status.  Return the exit
			-- or termination status of the process that
			-- finished.  It is an error to wait if there
			-- are no processes to wait for.  If `pid' > 0,
			-- wait for just the process with that process id.
			-- If `pid' = -1, wait for any child process.
			-- For effect of other values of `pid', see waitpid(2).
		local
			dummy: BOOLEAN
		do
			Result := unix_waitpid (pid, True, $dummy);
		end;

	wait_for_process_noblock (pid: INTEGER; status_avail_addr: POINTER): INTEGER is
			-- Wait for any process specified by process
			-- id `pid' to return status.  Do not block if
			-- no process has finished (the return value
			-- is not meaningful in this case).  Set
			-- boolean whose address is in
			-- `status_avail_addr' to indicate whether
			-- status was available for any process.
			-- Return the exit or termination status of
			-- the process that finished.
		do
			Result := unix_waitpid (pid, False, status_avail_addr);
		end;

	send_signal (sig, pid: INTEGER) is
			-- Send signal `sig' to the process(es) identified by
			-- `pid'.  If signal is 0, error checking is done but
			-- no signal is actually sent.  If `pid' > 0, send
			-- signal to the process with that id.  If `pid' = 0,
			-- send signal to all processes with the same
			-- process group id as current process (except system
			-- processes and process 1).  For `pid' = -1 or
			-- `pid' negative but not -1, see man page for
			-- kill(2).
		require
			valid_signal: is_defined(sig)
		do
			unix_kill (pid, sig);
		end;

	terminate_hard (pid: INTEGER) is
			-- Send a kill signal (SIGKILL) to the process(es)
			-- identified by `pid'
		do
			send_signal (Sigkill, pid)
		end

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


end -- class UNIX_OS
