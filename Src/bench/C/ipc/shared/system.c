/*

  ####    #   #   ####    #####  ######  #    #           ####
 #         # #   #          #    #       ##  ##          #    #
  ####      #     ####      #    #####   # ## #          #
      #     #         #     #    #       #    #   ###    #
 #    #     #    #    #     #    #       #    #   ###    #    #
  ####      #     ####      #    ######  #    #   ###     ####

	Implementations of some non-standard system routines.
*/

#include "eif_config.h"
#include "eif_portable.h"

#include <sys/types.h>
#include "timehdr.h"
#include <signal.h>
#include <errno.h>
#include <stdio.h>

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#ifdef I_SYS_FILE
#include <sys/file.h>
#endif
#ifdef I_FCNTL
#include <fcntl.h>
#endif

#ifdef EIF_WIN32
#include <windows.h>
#endif

#ifndef HAS_DUP2
rt_public int dup2(int old, int new)
{
#ifdef HAS_FCNTL
#ifdef F_DUPFD
#define USE_FCNTL_THEN
#endif
#endif

#ifdef USE_FCNTL_THEN
	if (old == new)
		return 0;

	close(new);
	return fcntl(old, F_DUPFD, new);
#else
	int fd_used[256];		/* Fixed stack used to record dup'ed files */
	int fd_top = 0;			/* Top in the fixed stack */
	int fd;					/* Currently dup'ed file descriptor */

	if (old == new)
		return 0;

	close(new);							/* Ensure one free slot */
	while ((fd = dup(old)) != new)		/* Until dup'ed file matches */
		fd_used[fd_top++] = fd;			/* Remember we have to close it later */

	while (fd_top > 0)					/* Close all useless dup'ed slots */
		close(fd_used[--fd_top]);

	return 0;
#endif
}
#endif

#ifndef HAS_USLEEP
#ifdef EIF_WIN32

rt_public int usleep (int usec)
{
	Sleep (usec / 1000);
	return 0;
}

#else
rt_public int usleep(int usec)
{
	/* Sleep for 'usec' micro-seconds */

	struct timeval tm;

	tm.tv_sec = (usec > 1000000) ? usec / 1000000 : 0;
	tm.tv_usec = (usec < 1000000) ? usec : usec % 1000000;

	(void) select(1, (Select_fd_set_t) 0, (Select_fd_set_t) 0, (Select_fd_set_t) 0, &tm);
	return 0;
}
#endif
#define HAS_USLEEP
#endif

#ifndef EIF_WIN32
rt_public char *str_save(char *s)
{
	/* Save string 's' somewhere in memory */

	char *new;

	if (s == (char *) 0)
		return (char *) 0;

	new = (char *) malloc(strlen(s) + 1);
	if (new == (char *) 0) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot malloc %d bytes", strlen(s) + 1);
#endif
		return (char *) 0;
	}

	(void) strcpy(new, s);
	return new;
}
#endif
