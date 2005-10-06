
indexing
	
	description: "Unix-specific operating system services";
	author: "David Hollenberg";
	date: "October 7, 1997"

class PROCESS_UNIX_OS

inherit
	PROCESS_OPERATING_SYSTEM
	UNIX_SIGNALS
		rename
			meaning as signal_meaning
		end
	EXECUTION_ENVIRONMENT
		export
			{ANY} return_code ;
			{NONE} all
		end

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


feature -- Directory operations
	
	delete_directory_tree (dir_name: STRING) is
			-- Try to delete the directory tree rooted at 
			-- `dir_name'.  Ignore any errors.  Leave status 
			-- code in `return_code'
		local
			cmd: STRING
		do
			create cmd.make (dir_name.count + 12);
			cmd.append ("/bin/rm -rf ");
			cmd.append (dir_name);
			system (cmd);
		end;

feature -- File descriptor operations

	duplicate_file_descriptor (old_fd, new_fd: INTEGER) is
			-- Duplicate existing file descriptor `old_fd' and
			-- give the new file descriptor the value `new_fd'.
			-- If `new_fd' is in use, it is first deallocated
			-- as if it were closed
		require
			valid_old_descriptor: valid_file_descriptor (old_fd)
			valid_new_descriptor: valid_file_descriptor (new_fd)
		external
			"C"
		alias
			"unix_dup2"
		end;
	
	close_file_descriptor (fd: INTEGER) is
			-- Close existing open file descriptor `fd'
		require
			valid_descriptor: valid_file_descriptor (fd)
		external
			"C"
		alias
			"unix_close"
		end;

feature -- Interval timer

	system_interval_timer: PROCESS_UNIX_SYSTEM_INTERVAL_TIMER is
			-- Operating system's interval timer
		once
			create Result;
		end;

feature -- Pipes

	new_pipe: PROCESS_UNIX_PIPE is
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

	my_process_id: INTEGER is
			-- Process id of currently executing process
		do
			Result := unix_get_process_id;
		end;

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
	
feature -- Date and time
	
	current_time_in_seconds: INTEGER is
			-- Current time in seconds since the start of
			-- the epoch (00:00:00 GMT,  Jan.  1,  1970)
		external
			"C"
		end;

	current_time_in_fine_seconds: DOUBLE is
			-- Current time in seconds since the start of
			-- the epoch (00:00:00 GMT,  Jan.  1,  1970), with
			-- a fine resolution
		external
			"C"
		end;

feature -- Sleeping

	sleep_milliseconds (n: DOUBLE) is
			-- Suspend execution for `n' milliseconds.
			-- Actual time could be longer or shorter
			-- since routine is awakened by any signal
			-- (not just the SIGALRM signal)
		do
			sleep_seconds (n / 1.0E3);
		end;

	sleep_seconds (n: DOUBLE) is
			-- Suspend execution for `n' seconds.
			-- Actual time could be longer or shorter
			-- since routine is awakened by any signal
			-- (not just the SIGALRM signal)
		local
			timer: PROCESS_INTERVAL_TIMER
			tried: BOOLEAN
		do
			if not tried then
				create timer.set_seconds (n);
				unix_pause;
			
				-- Shouldn't ever get here since signal will
				-- raise an exception and take us to 
				-- rescue clause
				timer.clear;
			end
		rescue
			if timer /= Void and then not timer.is_expired then
				timer.clear;
			end
			if timer /= Void and then timer.is_expiration_exception then
				tried := True
				retry
			end
		end;

feature {NONE} -- Externals

	str_dup (area: POINTER): POINTER is
			-- Return new copy of C string indicated by `area'
		external
			"C"
		end;

	unix_pipe (read_fd, write_fd: POINTER) is
			-- Create a new pipe and put the read file descriptor
			-- in `read_fd' and the write file descriptor in
			-- `write_fd'
		external
			"C"
		end;

	unix_kill (pid, sig: INTEGER) is
			-- Send signal `sig' to process(es) identified by `pid'
		external
			"C"
		end;

	unix_waitpid (pid: INTEGER; block: BOOLEAN; status_avail_addr: POINTER): INTEGER is
			-- Wait for process specified by `pid'.  Block if
			-- no process has status available if `block' is
			-- true.  Set boolean at `status_avail_addr' to
			-- indicate whether status was available
		external
			"C"
		end;

	unix_fork_process: INTEGER is
			-- Create a new process.  Return the process id
			-- to the parent and 0 to the child
		external
			"C"
		end;

	unix_exec_process (pname, args, env: POINTER; close_nonstd_files: BOOLEAN) is
			-- Call execv or execve to overlay current process with
			-- new one.  Does not return (raises exception
			-- if error doing the exec)
		external
			"C"
		end;

	unix_get_process_id: INTEGER is
			-- Process id of currently executing process
		external
			"C"
		end;
	
	unix_allocate_arg_memory (count: INTEGER): POINTER is
			-- Return pointer to newly allocated memory
			-- for `count' arguments which is not subject
			-- to garbage collection.  `count' must
			-- include both argument 0 and the trailing
			-- null pointer that terminates the argument list
		external
			"C"
		end;

	unix_set_arg_value (arg_array: POINTER; pos: INTEGER; arg: POINTER) is
			-- Set the element of `arg_array' at position `pos' 
			-- (relative to 0) to `arg'
		external
			"C"
		end;

	unix_pause is
			-- Pause until signal is received
		external
			"C"
		end;

end -- class PROCESS_UNIX_OS
