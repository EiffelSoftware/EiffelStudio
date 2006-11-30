/*
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
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

*/


/* Unix system routines which are called from Eiffel. */

#include <eif_eiffel.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <time.h>
#include <fcntl.h>
#include "unix_os.h"

#ifdef __SVR4
extern int kill(pid_t, int);
#endif

int getdtablesize(void);

/* Get current value of interval timer and put in the given components. */

void get_interval_timer (EIF_INTEGER * seconds, EIF_INTEGER * microseconds,
			 EIF_INTEGER * interval_seconds, 
			 EIF_INTEGER * interval_microseconds) {
  int rc;
  struct itimerval timer;

  *seconds = 0;
  *microseconds = 0;
  *interval_seconds = 0;
  *interval_microseconds = 0;
  rc = getitimer(ITIMER_REAL, &timer);
  if (rc == -1) {
    eraise(error_description(errno), EN_SYS);
  }
  *seconds = timer.it_value.tv_sec;
  *microseconds = timer.it_value.tv_usec;
  *interval_seconds = timer.it_interval.tv_sec;
  *interval_microseconds = timer.it_interval.tv_usec;
}

/* Set current value of interval timer. */

void set_interval_timer (EIF_INTEGER seconds, EIF_INTEGER microseconds,
			 EIF_INTEGER interval_seconds, 
			 EIF_INTEGER interval_microseconds) {
  int rc;
  struct itimerval timer;

  timer.it_value.tv_sec = seconds;
  timer.it_value.tv_usec = microseconds;
  timer.it_interval.tv_sec = interval_seconds;
  timer.it_interval.tv_usec = interval_microseconds;
  rc = setitimer(ITIMER_REAL, &timer, NULL);
  if (rc == -1) {
    eraise(error_description(errno), EN_SYS);
  }
}

/* Return current time in seconds since the start of the epoch 
   (00:00:00 GMT,  Jan.  1,  1970) */

EIF_INTEGER current_time_in_seconds (void) {
  time_t current_time;

  current_time = time(&current_time);
  if (current_time == (time_t) -1) {
#ifdef __SVR4
    eraise(error_description(errno), EN_SYS);
#else
    eraise("time() call failed", EN_PROG);
#endif
  }
  return (EIF_INTEGER) current_time;
}

/* Return current time in seconds since the start of the epoch 
   (00:00:00 GMT,  Jan.  1,  1970) with a fine resolution */

EIF_DOUBLE current_time_in_fine_seconds (void) {
  struct timeval timeval;
  int rc;

  rc = gettimeofday(&timeval, NULL);
  if (rc == -1) {
    eraise(error_description(errno), EN_SYS);
  }
  return ((EIF_DOUBLE) timeval.tv_sec) + 
    ((EIF_DOUBLE) timeval.tv_usec) / 1000000.0  ;
}

/* Pause until signal is received. */

void unix_pause (void) {
  int rc;

  rc = pause();
  /* Should never get here because when signal that is not being ignored
     is received, an exception should be raised.  But just in case... */
  if (rc == -1) {
    eraise(error_description(errno), EN_SYS);
  }
}

/* Duplicate existing file descriptor `old_fd' and give new descriptor
   the value `new_fd'. NOTE: this routine is not reentrant. */

void unix_dup2 (EIF_INTEGER old_fd, EIF_INTEGER new_fd) {
  int rc;

  rc = dup2(old_fd, new_fd);
  if (rc < 0) {
    eraise(error_description(errno), EN_SYS);
  }
}

/* Close existing file descriptor `fd' */

void unix_close (EIF_INTEGER fd) {
  int rc;

  rc = close(fd);
  if (rc != 0) {
    eraise(error_description(errno), EN_SYS);
  }
}

/* Create a new pipe for interprocess communication.  Put the read file
   descriptor in the location indicated by `read_fd' and the write file
   descriptor in the location indicated by `write_fd'. */

void unix_pipe (EIF_POINTER read_fd, EIF_POINTER write_fd) {
  int rc;
  int fd[2];
  EIF_INTEGER * read_ptr;
  EIF_INTEGER * write_ptr;

  rc = pipe(fd);
  if (rc != 0) {
    eraise(error_description(errno), EN_SYS);
  }
  read_ptr = (EIF_INTEGER *) read_fd;
  write_ptr = (EIF_INTEGER *) write_fd;
  *read_ptr = fd[0];
  *write_ptr = fd[1];
}

/* Create a new process.  Return process id of new process to parent
   and 0 to child. */

EIF_INTEGER unix_fork_process (void) {
  pid_t pid;

  pid = fork();
  if (pid == (pid_t) -1) {
    eraise(error_description(errno), EN_SYS);
  }
  return (EIF_INTEGER) pid;
}

/* Mark all descriptors for nonstandard files (descriptors > 2) as 
   "close on exec" */

void mark_descriptors_close_on_exec(int max_descriptors) {
  int k, rc;

  for (k = 3; k < max_descriptors; k++) {
    rc = fcntl(k, F_SETFD, 1);
    if (rc == -1 && errno != EBADF) {
      eraise(error_description(errno), EN_SYS);
    }
  }
}

/* Overlay current process with new one, executing `prog' with arguments
   `args' and passing it `env' if non-null.  If `env' is null, passes
   current environment.  Does not return */

void unix_exec_process (EIF_POINTER prog, EIF_POINTER args, EIF_POINTER env,
			EIF_BOOLEAN close_nonstd_files) {
  int max_descriptors;
  
  if (close_nonstd_files == EIF_TRUE) {
    max_descriptors = getdtablesize();
    mark_descriptors_close_on_exec(max_descriptors);
  }
  if (env == NULL) {
    (void) execv((char *) prog, (char **) args);
  } else {
    (void) execve((char *) prog, (char **) args, (char **) env);
  }
  eraise(error_description(errno), EN_SYS);
}

/* Return process id of currently executing process */

EIF_INTEGER unix_get_process_id (void) {
  return (EIF_INTEGER) getpid();
}

/* Return a pointer to newly allocated memory for `count' arguments which 
   is not subject to garbage collection */

EIF_POINTER unix_allocate_arg_memory (EIF_INTEGER count) {
  char ** result;

#ifdef __SVR4
  result = (char **) malloc((size_t) (count * sizeof(char *)));
#else
  result = (char **) malloc((unsigned) (count * sizeof(char *)));
#endif
  if (result == NULL) {
    enomem();
  }
  return (EIF_POINTER) result;
}

/* Set the element of `array' at position `pos' (relative to 0) to `arg' */

void unix_set_arg_value (EIF_POINTER array, EIF_INTEGER pos, EIF_POINTER arg) {
  char ** arguments;
  
  arguments = (char **) array;
  arguments[pos] = (char *) arg;
}

/* Return a pointer to a new copy of C string */

EIF_POINTER str_dup (EIF_POINTER s) {
  char * result;

#ifdef __SVR4
  result = (char *) malloc((size_t) (strlen((char *) s) + 1));
#else
  result = (char *) malloc((unsigned) (strlen((char *) s) + 1));
#endif
  if (result == NULL) {
    enomem();
  }
  strcpy(result, s);
  return (EIF_POINTER) result;
}

/* Wait for process specified by `pid' to return status.  Block if no
   process has status available yet, unless `hang' is false.  Set
   Eiffel boolean at address `status_avail' to indicate whether any
   process had status to report. */

EIF_INTEGER unix_waitpid (EIF_INTEGER pid, EIF_BOOLEAN hang, EIF_POINTER status_avail) {
  pid_t rc;
  int status, options;
  EIF_BOOLEAN * ptr;

  options = (hang ? 0 : WNOHANG) | WUNTRACED;
  ptr = (EIF_BOOLEAN *) status_avail;
  rc = waitpid((pid_t) pid, &status, options);
  if (rc == -1) {
    eraise(error_description(errno), EN_SYS);
  } else if (rc == 0) {	/* No process has status to report yet */
    *ptr = EIF_FALSE;
  } else {		/* Process reported status */
    *ptr = EIF_TRUE;
  }
  return (EIF_INTEGER) status;
}

/* Send signal `sid' to process(es) identified by `pid'. */

void unix_kill (EIF_INTEGER pid, EIF_INTEGER sig) {
  int rc;

  rc = kill((pid_t) pid, (int) sig);
  if (rc != 0 && errno != ESRCH) {
    eraise(error_description(errno), EN_SYS);
  }
}
