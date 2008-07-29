/*
	description: "Implementations of some non-standard system routines."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "eif_config.h"
#include "eif_portable.h"

#include <sys/types.h>
#include "timehdr.h"
#include <signal.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>

#ifdef I_SYS_FILE
#include <sys/file.h>
#endif
#ifdef I_FCNTL
#include <fcntl.h>
#endif

#ifdef EIF_WINDOWS
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
#ifdef EIF_WINDOWS

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
