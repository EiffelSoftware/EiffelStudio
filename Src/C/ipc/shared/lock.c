/*
	description: "Lock file handling."
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
#include <errno.h>
#include "stdio.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>

#ifdef I_FCNTL
#include <fcntl.h>
#endif
#ifdef I_SYS_FILE
#include <sys/file.h>
#endif

#define MAX_STRING	2048		/* Max string length */
#define MAX_TIME	3600		/* One hour */
#define ATTEMPTS	20			/* Number of attempts made */
#define INTERVAL	10000		/* Number of micro seconds between intervals */

rt_private char lockfile[MAX_STRING];		/* Location of lock file */
rt_private int locked = 0;					/* Did we lock successfully? */

rt_private void check_lock(char *file);				/* Make sure lockfile is not too old */

#ifndef EIF_WINDOWS
#include <unistd.h>
#ifndef EIF_VMS		/* breaks on VMS; should not <errno.h> be used for all platforms? */
extern int errno;						/* System error status */
#endif
#else
#include "io.h"
extern int usleep(unsigned int);		/* Current time */
#endif

rt_public int lock_file(char *file)
           						/* Where lockfile should be written */
{
	/* Note: this locking is not completly safe w.r.t. race conditions, but the
	 * mailagent will do its own locking checks in a rather safe way.
	 * Return 0 if locking succeeds, -1 otherwise.
	 */

	int attempts = ATTEMPTS;			/* Number of attempts to be made */
	int fd;

	sprintf(lockfile, "%s.lock", file);
	check_lock(lockfile);
	locked = 0;

	while (attempts-- > 0) {
		if (-1 == (fd = open(lockfile, O_CREAT | O_EXCL, 0))) {
			if (errno != EEXIST) {
#ifdef USE_ADD_LOG
				add_log(1, "SYSERR open: %m (%e)");
#endif
				return -1;
			} else
				usleep(INTERVAL);		/* Lockfile present, wait */
		} else {
			locked = 1;
			close(fd);
			break;
		}
	}

	return locked ? 0 : -1;
}

rt_public void release_lock(void)
{
	if (locked && -1 == unlink(lockfile)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR unlink: %m (%e)");
		add_log(4, "WARNING could not remove lockfile %s", lockfile);
#endif
	}
	locked = 0;
}

rt_public int is_locked(void)
{
	return locked;			/* Do we have a lock file active or not? */
}

rt_private void check_lock(char *file)
{
	/* Make sure the lock file is not older than MAX_TIME seconds, otherwise
	 * unlink it (something must have gone wrong).
	 */

	struct stat buf;

	if (-1 == stat(file, &buf)) {		/* Stat failed */
		if (errno == ENOENT)			/* File does not exist */
			return;
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR stat: %m (%e)");
		add_log(2, "could not check lockfile %s", file);
#endif
		return;
	}

	if ((buf.st_mtime - time((Time_t *) 0)) > MAX_TIME) {
		if (-1 == unlink(lockfile)) {
#ifdef USE_ADD_LOG
			add_log(1, "SYSERR unlink: %m (%e)");
			add_log(4, "WARNING could not remove old lock %s", lockfile);
#endif
		}
#ifdef USE_ADD_LOG
		else
			add_log(6, "UNLOCKED %s (lock older than 1 hour)", file);
#endif
	}
}

