indexing
	description: "Unix-specific operating system services for process"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PROCESS_UNIX_OS

inherit
	UNIX_SIGNALS
		rename
			meaning as signal_meaning
		end

feature -- File descriptor operations

	valid_file_descriptor (fd: INTEGER): BOOLEAN is
			-- Is `fd' in the range of valid file descriptors?
		do
			Result := fd >= 0
		end

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
			"C inline use <unistd.h>"
		alias
			"[
				{
				  int rc;
				  rc = dup2($old_fd, $new_fd);
				  if (rc < 0) {
					    eraise(Strerror(errno), EN_SYS);
				  }
				}
			]"
		end;

	close_file_descriptor (fd: INTEGER) is
			-- Close existing open file descriptor `fd'
		require
			valid_descriptor: valid_file_descriptor (fd)
		external
			"C inline use <unistd.h>"
		alias
			"[
				{
					 int rc;
					  rc = close($fd);
					  if (rc != 0) {
					    eraise(Strerror(errno), EN_SYS);
					  }
				}
			]"
		end

feature -- Pipes

	new_pipe: PROCESS_UNIX_PIPE is
			-- New pipe object for interprocess communication
		local
			read_fd, write_fd: INTEGER
		do
			unix_pipe ($read_fd, $write_fd)
			create Result.make (read_fd, write_fd)
		ensure
			result_exists: Result /= Void;
		end;

feature -- Process operations

	fork_process: INTEGER is
			-- Fork a new process.  Return process id of new
			-- process to the parent process and 0 to the child
		do
			Result := unix_fork_process;
		end

	new_process_group is
			-- Let the current process become a process group leader.
		external
			"C inline use <sys/types.h>, <unistd.h>, <termios.h>"
		alias
			"[
				{
					setpgid (0, 0);
				}
			]"
		end

	exec_process (prog_file: STRING; args: ARRAY [STRING];
			close_nonstd_files: BOOLEAN; env_ptr: POINTER) is
			-- Overlay the process with a new process,
			-- which will execute program `prog_file' with
			-- arguments `args' and environment variables stored in `env_ptr'.
			-- If `close_nonstd_files'
			-- is true, then change all open file
			-- descriptors greater than 2 so that they are
			-- closed on a successful exec. If env_ptr is a `default_pointer', the new
			-- process has the same environment as the
			-- current one, otherwise, it will use the environment specified in `env_ptr'.
			-- This routine never returns to
			-- the caller normally, although it may raise
			-- an exception.
		require
			program_name_exists: prog_file /= Void
			arguments_exist: args /= Void
		local
			k, count, lower: INTEGER
			pname, area: ANY
			arguments, arg_copy, null_ptr: POINTER
		do
			count := args.count
			lower := args.lower
			pname := prog_file.to_c
			arguments := unix_allocate_arg_memory (count + 1)
			from
				k := 1
			until
				k > count
			loop
				area := args.item (lower + k - 1).to_c
				arg_copy := str_dup ($area)
				unix_set_arg_value (arguments, k - 1, arg_copy)
				k := k + 1
			end
			unix_set_arg_value (arguments, count, null_ptr)
			unix_exec_process ($pname, arguments, env_ptr, close_nonstd_files)
		end

	terminate_hard (pid: INTEGER) is
			-- Send a kill signal (SIGKILL) to the process(es)
			-- identified by `pid'
		do
			send_signal (Sigkill, pid)
		end

feature{NONE} -- Implementation

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
			unix_kill (pid, sig)
		end

	unix_fork_process: INTEGER is
			-- Create a new process.  Return the process id
			-- to the parent and 0 to the child
		do
			c_unix_fork_process ($Result)
		end

	str_dup (area: POINTER): POINTER is
			-- Return new copy of C string indicated by `area'
		do
			c_str_dup (area, $Result);
		end

	unix_allocate_arg_memory (count: INTEGER): POINTER is
			-- Return pointer to newly allocated memory
			-- for `count' arguments which is not subject
			-- to garbage collection.  `count' must
			-- include both argument 0 and the trailing
			-- null pointer that terminates the argument list
		do
			c_unix_allocate_arg_memory (count, $Result)
		end

feature {NONE} -- Externals

	c_str_dup (area: POINTER; a_result: TYPED_POINTER [POINTER]) is
			-- Duplicate data from `area' to `a_result'.
			external
				"C inline use <string.h>"
			alias
				"[
					{
					  char *result;
					  result = (char *) malloc((unsigned) (strlen((char *) $area) + 1));
					  if (result == NULL) {
				    	enomem();
					  }
					  strcpy(result, $area);
					  *$a_result = result;
					}
				]"
			end


	unix_pipe (read_fd, write_fd: POINTER) is
			-- Create a new pipe and put the read file descriptor
			-- in `read_fd' and the write file descriptor in
			-- `write_fd'
		external
			"C inline use <unistd.h>"
		alias
			"[
				{
				  int rc;
				  int fd[2];
				  EIF_INTEGER * read_ptr;
				  EIF_INTEGER * write_ptr;
				  rc = pipe(fd);
				  if (rc != 0) {
				    eraise(Strerror(errno), EN_SYS);
				  }
				  read_ptr = (EIF_INTEGER *) $read_fd;
				  write_ptr = (EIF_INTEGER *) $write_fd;
				  *read_ptr = fd[0];
				  *write_ptr = fd[1];
				}
			]"
		end

	unix_kill (pid, sig: INTEGER) is
			-- Send signal `sig' to process(es) identified by `pid'
		external
			"C inline use <sys/types.h>, <signal.h>"
		alias
			"[
			 {
				int rc;
				rc = kill((pid_t) $pid, (int) $sig);
			    if (rc != 0 && errno != ESRCH) {
					eraise(Strerror(errno), EN_SYS);
				}
			}
			]"

		end

	unix_waitpid (pid: INTEGER; block: BOOLEAN; status_avail_addr: TYPED_POINTER [BOOLEAN]; a_status: TYPED_POINTER [INTEGER]; a_succ: TYPED_POINTER [BOOLEAN]) is
			-- Wait for process specified by `pid'.  Block if
			-- no process has status available if `block' is
			-- true.  Set boolean at `status_avail_addr' to
			-- indicate whether status was available.
			-- Set reported process status in `a_status' if `status_avail_addr' is set with True.
			-- If succeeded, set `a_succ' to True, otherwise False.
		external
			"C blocking inline use <sys/types.h>, <sys/wait.h>"
		alias
			"[
				{
				  pid_t rc;
				  int status;
				  
				  rc = waitpid((pid_t) $pid, &status, ($block ? 0 : WNOHANG) | WUNTRACED);
				  *(EIF_BOOLEAN *) $a_succ = (rc != -1);
				  if (rc != -1) {				    
					  if (rc == 0) { /* No process has status to report yet */
					    *(EIF_BOOLEAN *) $status_avail_addr = EIF_FALSE;
					  } else { /* Process reported status */
					    *(EIF_BOOLEAN *) $status_avail_addr = EIF_TRUE;
					  }
					  *(EIF_INTEGER *) $a_status = (EIF_INTEGER) status;
				  }
				}
			]"
		end

	c_unix_fork_process (a_result : TYPED_POINTER [INTEGER]) is
			-- Fork process, and set return value in `a_result'.
		external
			"C inline use <sys/types.h>, <unistd.h>"
		alias
			"[
				{
				  pid_t pid;
				  pid = fork();
				  *$a_result = (EIF_INTEGER)pid;
				}
			]"
		end


	unix_exec_process (pname, args, env: POINTER; close_nonstd_files: BOOLEAN) is
			-- Call execv or execve to overlay current process with
			-- new one.  Does not return (raises exception
			-- if error doing the exec)
		external
			"C inline use <fcntl.h>"
		alias
			"[
				{
				  int max_descriptors;
				  int k, rc;
  				  if ($close_nonstd_files == EIF_TRUE) {
				    max_descriptors = getdtablesize();
					for (k = 3; k < max_descriptors; k++) {
					    rc = fcntl(k, F_SETFD, 1);
					    if (rc == -1 && errno != EBADF) {
						      eraise(Strerror(errno), EN_SYS);
					    }
			  	    }
				  }
				  if ($env == NULL) {
				    (void) execv((char *) $pname, (char **) $args);
				  } else {
				    (void) execve((char *) $pname, (char **) $args, (char **) $env);
				  }
				  eraise(Strerror(errno), EN_SYS);
				}
			]"
		end

	c_unix_allocate_arg_memory (count: INTEGER; a_result: TYPED_POINTER [POINTER]) is
			-- Allocate memory for a POINTER array of `count' items.
		external
			"C inline"
		alias
			"[
				{
					EIF_POINTER result;
					result = (EIF_POINTER) malloc((size_t) ($count * sizeof(char *)));
					if (result == NULL) {
						enomem();
					}
					*$a_result = result;
				}
			]"
		end


	unix_set_arg_value (arg_array: POINTER; pos: INTEGER; arg: POINTER) is
			-- Set the element of `arg_array' at position `pos'
			-- (relative to 0) to `arg'
		external
			"C inline"
		alias
			"[
				{
				  char ** arguments;
 				  arguments = (char **) $arg_array;
				  arguments[$pos] = (char *) $arg;
				}
			]"
		end

	attach_terminals (pid: INTEGER) is
			-- Attach terminal control to process group to which process `pid' belongs.
		external
			"C inline use <sys/types.h>, <unistd.h>, <termios.h>"
		alias
			"[
				{
					pid_t pgid = getpgid ($pid);
					tcsetpgrp (1, pgid);
					tcsetpgrp (2, pgid);
				}
			]"
		end

indexing
	library:   "EiffelProcess: Manipulation of processes with IO redirection."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
