indexing
	description: "Unix external routines"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "June 4, 2008"

class UNIX_EXTERNALS

feature -- File descriptors

	close_file_descriptor (fd: INTEGER) is
			-- Close existing open file descriptor `fd'
		require
			valid_descriptor: fd >= 0
		external
			"C inline use <unistd.h>"
		alias
			"[
				int rc;
				rc = close($fd);
				if (rc != 0) {
					xraise(EN_SYS);
				}
			]"
		end;

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
  				int rc;

  				rc = dup2($old_fd, $new_fd);
				if (rc < 0) {
					xraise(EN_SYS);
  				}
			]"
		end;
	
		
	valid_file_descriptor (fd: INTEGER): BOOLEAN is
			-- Is `fd' in the range of valid file descriptors?
		do
			Result := fd >= 0
		end

	Invalid_file_descriptor: INTEGER is -1;
			-- File descriptor which is not in valid range


feature -- Date and time
	
	current_time_in_seconds: INTEGER is
			-- Current time in seconds since the start of
			-- the epoch (00:00:00 GMT,  Jan.  1,  1970)
		external
			"C inline use <time.h>"
		alias "[
  				time_t current_time;

  				current_time = time(&current_time);
  				if (current_time == (time_t) -1) {
    					eraise("time() call failed", EN_PROG);
  				}
  				return (EIF_INTEGER) current_time;
			]"
		end;

	current_time_in_fine_seconds: DOUBLE is
			-- Current time in seconds since the start of
			-- the epoch (00:00:00 GMT,  Jan.  1,  1970), with
			-- a fine resolution
		external
			"C inline use <sys/time.h>"
		alias
			"[
  				struct timeval timeval;
  				int rc;

  				rc = gettimeofday(&timeval, NULL);
  				if (rc == -1) {
    					xraise(EN_SYS);
  				}
  				return ((EIF_DOUBLE) timeval.tv_sec) + 
    					((EIF_DOUBLE) timeval.tv_usec) / 1000000.0  ;
			]"
		end;

feature -- String manipulation

	str_dup (area: POINTER): POINTER is
			-- Return new copy of C string indicated by `area'
		external
			"C inline use <stdlib.h>, <string.h>"
		alias
			"[
  				void * result;

  				result = (char *) malloc((size_t) (strlen((char *) $area) + 1));
  				if (result == NULL) {
    					enomem();
  				}
  				strcpy(result, $area);
  				return (EIF_POINTER) result;
			]"
		end;

feature -- Pipes

	unix_pipe (read_fd, write_fd: POINTER) is
			-- Create a new pipe and put the read file descriptor
			-- in `read_fd' and the write file descriptor in
			-- `write_fd'
		external
			"C inline use <unistd.h>"
		alias
			"[
  				int rc;
  				int fd[2];
  				EIF_INTEGER * read_ptr;
  				EIF_INTEGER * write_ptr;

  				rc = pipe(fd);
  				if (rc != 0) {
    					xraise(EN_SYS);
  				}
  				read_ptr = (EIF_INTEGER *) $read_fd;
  				write_ptr = (EIF_INTEGER *) $write_fd;
  				*read_ptr = fd[0];
  				*write_ptr = fd[1];
			]"
		end;

feature -- Memory allocation and setting

	unix_allocate_arg_memory (count: INTEGER): POINTER is
			-- Return pointer to newly allocated memory
			-- for `count' arguments which is not subject
			-- to garbage collection.  `count' must
			-- include both argument 0 and the trailing
			-- null pointer that terminates the argument list
		external
			"C inline use <stdlib.h>"
		alias
			"[
  				char ** result;

  				result = (char **) malloc((size_t) ($count * sizeof(char *)));
  				if (result == NULL) {
    					enomem();
  				}
  				return (EIF_POINTER) result;
			]"
		end;

	unix_set_arg_value (arg_array: POINTER; pos: INTEGER; arg: POINTER) is
			-- Set the element of `arg_array' at position `pos' 
			-- (relative to 0) to `arg'
		external
			"C inline"
		alias
			"[
  				char ** arguments;
  
  				arguments = (char **) $arg_array;
  				arguments[$pos] = (char *) $arg;
			]"
		end;

feature -- Process operations

	unix_fork_process: INTEGER is
			-- Create a new process.  Return the process id
			-- to the parent and 0 to the child
		external
			"C inline use <unistd.h>"
		alias
			"[
  				pid_t pid;

  				pid = eif_thread_fork();
  				if (pid == (pid_t) -1) {
    					xraise(EN_SYS);
  				}
  				return (EIF_INTEGER) pid;
			]"
		end;

	unix_exec_process (pname, args, env: POINTER; close_nonstd_files: BOOLEAN) is
			-- Call execv or execve to overlay current process with
			-- new one.  Does not return (raises exception
			-- if error doing the exec)
		external
			"C inline use <unistd.h>, <fcntl.h>, <errno.h>"
		alias
			"[
				int getdtablesize(void);
  				int max_descriptors;
  				int k, rc;
  
  				if ($close_nonstd_files == EIF_TRUE) {
    					max_descriptors = getdtablesize();
  					for (k = 3; k < max_descriptors; k++) {
    						rc = fcntl(k, F_SETFD, 1);
    						if (rc == -1 && errno != EBADF) {
      							xraise(EN_SYS);
    						}
  					}
  				}
  				if ($env == NULL) {
    					(void) execv((char *) $pname, (char **) $args);
  				} else {
    					(void) execve((char *) $pname, (char **) $args, (char **) $env);
  				}
  				xraise(EN_SYS);
			]"
		end;

	unix_kill (pid, sig: INTEGER) is
			-- Send signal `sig' to process(es) identified by `pid'
		external
			"C inline use <signal.h>, <errno.h>"
		alias
			"[
  				int rc;

  				rc = kill((pid_t) $pid, (int) $sig);
  				if (rc != 0 && errno != ESRCH) {
    					xraise(EN_SYS);
  				}
			]"
		end;

	unix_waitpid (pid: INTEGER; block: BOOLEAN; status_avail_addr: POINTER): INTEGER is
			-- Wait for process specified by `pid'.  Block if
			-- no process has status available if `block' is
			-- true.  Set boolean at `status_avail_addr' to
			-- indicate whether status was available
		external
			"C inline use <sys/wait.h>"
		alias
			"[
  				pid_t rc;
  				int status, options;
  				EIF_BOOLEAN * ptr;

  				options = (($block == EIF_TRUE) ? 0 : WNOHANG) | WUNTRACED;
  				ptr = (EIF_BOOLEAN *) $status_avail_addr;
  				rc = waitpid((pid_t) $pid, &status, options);
  				if (rc == (pid_t) -1) {
    					xraise(EN_SYS);
  				} else if (rc == (pid_t) 0) {	/* No process has status to report yet */
    					*ptr = EIF_FALSE;
  				} else {		/* Process reported status */
    					*ptr = EIF_TRUE;
  				}
  				return (EIF_INTEGER) status;
			]"
		end;

feature -- Sleeping

	sleep_nanoseconds (n: INTEGER_64) is
			-- Suspend execution for `n' nanoseconds
		external
			"C inline use <time.h>"
		alias
			"[
				int rc;
				struct timespec req;
				struct timespec rem;
				req.tv_sec = $n / 1000000000;
				req.tv_nsec = $n % 1000000000;
				
				while (((rc = nanosleep (&req, &rem)) == -1) && (errno == EINTR)) {
					/* Function is interrupted by a signal.   */
					/* Let's call it again to complete pause. */
					req = rem;
				}
				if (rc == -1) {
    					xraise(EN_SYS);
				}
			]"
		end;

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


end -- class OS_ACCESS
