/*

  ####   #    #     #    #       #####            ####
 #    #  #    #     #    #       #    #          #    #
 #       ######     #    #       #    #          #
 #       #    #     #    #       #    #   ###    #
 #    #  #    #     #    #       #    #   ###    #    #
  ####   #    #     #    ######  #####    ###     ####

	Child spawning and comforting.
*/

#include "config.h"
#include "portable.h"
#include "err_msg.h"
#include <sys/types.h>
#include "logfile.h"
#include "stream.h"
#include "timehdr.h"
#include "ewbio.h"
#include <signal.h>
#include <setjmp.h>
#include <string.h>
#include <errno.h>
#include <stdio.h>

#ifdef I_SYS_FILE
#include <sys/file.h>
#endif
#ifdef I_FCNTL
#include <fcntl.h>
#endif

#define PIPE_READ	0		/* File descriptor used for reading */
#define PIPE_WRITE	1		/* File descriptor used for writing */

extern unsigned TIMEOUT;	/* Time to let the child initialize */

/* To fight SIGPIPE signals */
rt_private jmp_buf env;		/* Environment saving for longjmp() */
rt_private Signal_t broken();	/* Signal handler for SIGPIPE */

/* Function declaration */
rt_private int comfort_child();	/* Reassure child, make him confident */
rt_private void close_on_exec();	/* Ensure this file will be closed by exec */

extern char **shword();			/* Shell word parsing of command string */

rt_public STREAM *spawn_child(cmd, child_pid)
char *cmd;			/* The child command process */
Pid_t *child_pid;	/* Where pid of the child is writtten */
{
	/* Launch the child process 'cmd' and return the stream structure which can
	 * be used to communicate with the child. Note that this function only
	 * returns in the parent process.
	 */

	int pdn[2];					/* The opened downwards file descriptors */
	int pup[2];					/* The opened upwards file descriptors */
	int new;					/* Duped file descriptor */
	Pid_t pid;					/* Pid of the child */
	STREAM *sp;					/* Stream used for communications with ewb */
	char **argv;				/* Argument vector for exec() */

	char *meltpath, *appname, *envstring;	/* set MELT_PATH */

	/* Set up pipes and fork, then exec the workbench. Two pairs of pipes are
	 * opened, one for downwards communications (ised -> ewb) and one for
	 * upwards (ewb -> ised).
	 */

	if (-1 == pipe(pup)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR: pipe: %m (%e)");
		add_log(2, "ERROR cannot set up upwards pipe");
#endif
		perror("pipe");
		dexit(1);
	}

	if (-1 == pipe(pdn)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR: pipe: %m (%e)");
		add_log(2, "ERROR cannot set up downwards pipe");
#endif
		perror("pipe");
		dexit(1);
	}

#ifdef USE_ADD_LOG
	add_log(12, "opened pipes as pup(%d, %d), pdn(%d, %d)",
		pup[0], pup[1], pdn[0], pdn[1]);
#endif

	/* The fork and exec stuff: a classic */

	pid = (Pid_t) fork();		/* That's where we fork */

	switch (pid) {
	case -1:		/* Error */
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR: fork: %m (%e)");
		add_log(2, "ERROR cannot fork, sorry");
#endif
		perror("fork");
		dexit(1);
	case 0:			/* Child process */
#ifdef USE_ADD_LOG
		close_log();					/* Logfile should not cross exec() */
#endif
		close(pdn[PIPE_WRITE]);
		close(pup[PIPE_READ]);
		/* Start duping first allocated pipe, otherwise good luck!--RAM.
		 * Be careful about the case where the pipe you want to dup on is 
		 * already used by the other pipe.
		 * (Hint #1: dup2 closes its target fd before duping file)
		 * (Hint #2: pipe() takes the lowest two file descriptors available)
		 */
		if (pdn[PIPE_READ] != EWBOUT) {
			if (pup[PIPE_WRITE] != EWBOUT) {
				dup2(pup[PIPE_WRITE], EWBOUT);	/* Child writes to ewbout */
				close(pup[PIPE_WRITE]);			/* Close dup'ed files before exec */
			}
			if (pdn[PIPE_READ] != EWBIN) {
				dup2(pdn[PIPE_READ], EWBIN);	/* Child reads from ewbin */
				close(pdn[PIPE_READ]);			/* (avoid child running out of fd!) */
			}
		} else {
			/* Bad case: pdn[PIPE_READ] == EWBOUT. We cannot use the code above since
			 * the first dup2 will close EWBOUT, which unfortunately is used by a pipe
			 * end which also need to be kept alive until dup2'ed! Ouch--RAM
			 */
			if (pdn[PIPE_READ] != EWBIN) {
				dup2(pdn[PIPE_READ], EWBIN);	/* Child reads from ewbin */
				close(pdn[PIPE_READ]);			/* (avoid child running out of fd!) */
			}
			if (pup[PIPE_WRITE] != EWBOUT) {
				dup2(pup[PIPE_WRITE], EWBOUT);	/* Child writes to ewbout */
				close(pup[PIPE_WRITE]);			/* Close dup'ed files before exec */
			}
		}
		/* Now exec command. A successful launch should not return */
		argv = shword(cmd);					/* Split command into words */
		if (argv != (char **) 0) {
			meltpath = strdup (argv [0]);
			if (meltpath == (char *)0){
#ifdef USE_ADD_LOG
				add_log(2, "ERROR out of memory: cannot exec '%s'", cmd);
#endif
				dexit (1);
			}
			appname = rindex (meltpath, '/');
			if (appname = rindex (meltpath, '/')) *appname = 0;
			else strcpy (meltpath, ".");
			envstring = (char *)malloc (strlen (meltpath)
				+ strlen ("MELT_PATH=") + 1);
			if (!envstring){
#ifdef USE_ADD_LOG
                add_log(2, "ERROR out of memory: cannot exec '%s'", cmd);
#endif
                dexit (1);
            }
			sprintf (envstring, "MELT_PATH=%s", meltpath);
			putenv (envstring); 

			execvp(argv[0], argv);
			print_err_msg(stderr,"ERROR could not launch '%s'", argv[0]);
#ifdef USE_ADD_LOG
			reopen_log();
			add_log(1, "SYSERR: exec: %m (%e)");
			add_log(2, "ERROR could not launch '%s'", argv[0]);
#endif
		}
#ifdef USE_ADD_LOG
		else
			add_log(2, "ERROR out of memory: cannot exec '%s'", cmd);
#endif
		dexit(1);
	default:		/* Parent process */
		sleep(1);	/* Let child initialize or print error */
		close(pdn[PIPE_READ]);
		close(pup[PIPE_WRITE]);
		/* Reset those file descriptors to the lowest possible number, just to
		 * remain clean (the pipe() system call allocating two files, multiple
		 * calls to pipe() lead to a messy file allocation table)--RAM.
		 */
		new = dup(pup[PIPE_READ]);
		if (new != -1 && new < pup[PIPE_READ]) {
			close(pup[PIPE_READ]);
			pup[PIPE_READ] = new;
		} else if (new != -1)
			close(new);
		/* Same thing with writing file descriptor. Note that we only keep the
		 * new duped descriptor when it is lower than the current original.
		 */
		new = dup(pdn[PIPE_WRITE]);
		if (new != -1 && new < pdn[PIPE_WRITE]) {
			close(pdn[PIPE_WRITE]);
			pdn[PIPE_WRITE] = new;
		} else if (new != -1)
			close(new);
		/* No need to dup2() file descriptors, we do not exec() anybody yet.
		 * However, do make sure those remaining descriptors will be closed
		 * by any further exec.
		 */
		close_on_exec(pup[PIPE_READ]);
		close_on_exec(pdn[PIPE_WRITE]);
	}

	/* Create a STREAM structure, which provides the illusion of bidrectional
	 * communication through the pair of pipes. When networking is added, the
	 * interface will remain unchanged.
	 */

	sp = new_stream(pup[PIPE_READ], pdn[PIPE_WRITE]);

	/* Makes sure the child started correctly, and let him know we started him
	 * from here, and that it is not a normal user invocation.
	 */

	if (-1 == comfort_child(sp))
		return (STREAM *) 0;		/* Wrong child */

	/* Record child's pid, which may be necessary to ensure it remains alive,
	 * or to send some signals, or whatever...
	 */
	
	if (child_pid != (Pid_t *) 0)
		*child_pid = pid;

	return sp;			/* Stream used to speak to child process */
}

rt_private int comfort_child(sp)
STREAM *sp;		/* Stream used to talk to the child */
{
	/* Tell the child his parent is here, and make sure he responds. The
	 * comforting protocol is the following: parent writes a null byte and
	 * child echoes ^A.
	 */

	struct timeval tm;
	fd_set mask;
	char c = '\0';
	Signal_t (*oldpipe)();

	FD_ZERO(&mask);
	FD_SET(writefd(sp), &mask);				/* We want to write to child */

	oldpipe = signal(SIGPIPE, broken);	/* Trap SIGPIPE within this function */

	/* If we get a SIGPIPE signal, come back here */
	if (0 != setjmp(env)) {
		signal(SIGPIPE, oldpipe);
#ifdef USE_ADD_LOG
		add_log(1, "child did not start at all");
#endif
		return -1;
	}

	tm.tv_sec = TIMEOUT;				/* Do not hang on the select */
	tm.tv_usec = 0;
	if (-1 == select(32, (Select_fd_set_t) 0, &mask, (Select_fd_set_t) 0, &tm)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR select: %m (%e)");
#endif
		return -1;
	}

	/* If cannot write to child, there is a problem... */
	if (!FD_ISSET(writefd(sp), &mask)) {
#ifdef USE_ADD_LOG
		add_log(12, "cannot comfort child");
#endif
		signal(SIGPIPE, oldpipe);
		return -1;
	}

	if (-1 == write(writefd(sp), &c, 1)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR write: %m (%e)");
		add_log(12, "cannot send identification");
#endif
		signal(SIGPIPE, oldpipe);
		return -1;
	}

	signal(SIGPIPE, oldpipe);			/* Restore previous handler */

	/* Now wait for the acknowledgment -- no SIGPIPE to be feared */

	FD_ZERO(&mask);
	FD_SET(readfd(sp), &mask);			/* We want to read from child */
	tm.tv_sec = TIMEOUT;				/* Child should answer quickly */
	tm.tv_usec = 0;
	if (-1 == select(32, &mask, (Select_fd_set_t) 0, (Select_fd_set_t) 0, &tm)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR select: %m (%e)");
#endif
		return -1;
	}

	if (!FD_ISSET(readfd(sp), &mask)) {
#ifdef USE_ADD_LOG
		add_log(12, "child does not answer");
#endif
		return -1;
	}
	if (-1 == read(readfd(sp), &c, 1)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR read: %m (%e)");
		add_log(12, "cannot get child answer");
#endif
		return -1;
	}
	if (c != '\01') {
#ifdef USE_ADD_LOG
		add_log(12, "wrong child, it would seem");
#endif
		return -1;
	}

#ifdef USE_ADD_LOG
	add_log(12, "child started ok");
#endif

	return 0;
}

rt_private void close_on_exec(fd)
int fd;
{
	/* Set the close on exec flag for file descriptor 'fd' */

#ifdef F_SETFD
	if (-1 == (fcntl(fd, F_SETFD, 1))) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR fcntl: %m (%e)");
		add_log(2, "ERROR cannot set close-on-exec flag on fd #%d", fd);
#endif
	}
#ifdef USE_ADD_LOG
	else
		add_log(12, "file #%d will be closed upon next exec()", fd);
#endif
#endif
}

rt_private Signal_t broken()
{
	longjmp(env, 1);			/* SIGPIPE was received */
	/* NOTREACHED */
}

