/*
	description: "[
			Identify parent, to make sure we are started via the ised wrapper.

			For Windows:
				Well actually check we were launched from a legitimate launcher.
				We need to uudecode the arguments that come down.
				We use the real command line usng GetCommandLine.
				Dummy console handles are (re)created at this point.
			]"
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
#ifdef EIF_VMS
#include "ipcvms.h"		/* only affects VMS */
#endif
#include <string.h>
#ifdef I_SYS_TIMES
#include <sys/times.h>
#elif defined(I_SYS_TIME)
#include <sys/times.h>
#endif
#include <sys/types.h>
#include <sys/stat.h>
#include "eif_logfile.h"
#include "timehdr.h"
#include "ewbio.h"
#include "identify.h"
#include <stdio.h>

#ifdef EIF_WINDOWS
#include "uu.h"
#include <windows.h>
HANDLE global_ewbin, global_ewbout, global_event_r, global_event_w;
#else
#include <unistd.h>
#endif

#ifdef EIF_WINDOWS
rt_public int identify()
{
	/* Identification protocol, to make sure we have been started via the
	 * ised wrapper. We expect a null character from file descriptor EWBIN and
	 * write a ^A on EWBOUT.
	 */

	HANDLE ewbin, ewbout;
	HANDLE eif_conoutfile, eif_coninfile;
	HANDLE event_r, event_w;
	CHAR   event_str [20];
	DWORD wait;
	SECURITY_ATTRIBUTES sa;
	char c;
	DWORD count;
	size_t tl, sz;
	char *t, *uu_str, *uu_t;
	HANDLE uu_handles [2];

	/* check the handle is valid
	 */

	t = GetCommandLine();
	tl = strlen (t);
		/* 2 because we retrieve 2 HANDLEs from the command line. */
	sz = (2 * sizeof(HANDLE) * 4 + 2) / 3;
	if (sz % 4) {
		sz += 4 - (sz % 4);
	}
	if ((tl < sz + 5) || (t[tl-1] != '"') || (t[tl-2] != '?') || (t[tl-(sz+3)] != '?') || (t[tl-(sz+4)] != '"'))
		return -1;

	uu_str = strdup ((t + tl  - (sz + 2)));
	uu_str [strlen(uu_str) -2] = '\0';
	uu_t = uudecode_str (uu_str);
	memcpy ((char *)uu_handles, uu_t, 2 * sizeof (HANDLE));
	free (uu_t);
	ewbin = uu_handles [1];
	ewbout = uu_handles [0];

	sprintf (event_str, "eif_event_w%x", GetCurrentProcessId());
	event_r = NULL;

/*      NT 3.51 is really fast - at this point we know we were launched by ebench.
	lets wait for it to catch up with us */

	for (count = 0; (event_r == NULL) && (count < 10); count++) {
		event_r = OpenSemaphore (SEMAPHORE_ALL_ACCESS, FALSE, event_str);
		if (event_r == NULL)
			Sleep(500);
	}
	if (event_r == NULL) {
#ifdef USE_ADD_LOG
		add_log(12, "not started from wrapper - no read event %d", GetLastError());
#endif
		return -1;
	}
	sprintf (event_str, "eif_event_r%x", GetCurrentProcessId());
	event_w = OpenSemaphore (SEMAPHORE_ALL_ACCESS, FALSE, event_str);
	if (event_w == NULL) {
#ifdef USE_ADD_LOG
		add_log(12, "not started from wrapper - no write event");
#endif
		return -1;
	}

	global_event_r = event_r;
	global_event_w = event_w;

	global_ewbin = ewbin;
	global_ewbout = ewbout;

	/* Quickly poll on ewbin to see whether it's worth attempting a read on
	 * it or not. Wait at most 10 seconds (to let our parent initialize) and
	 * then return if nothing is available within that time frame.
	 */

	if ((wait = WaitForSingleObject (event_r, 10000)) == WAIT_TIMEOUT) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR unexpected WaitForSingleObject timeout");
#endif
		return -1;
	}

	if (wait == WAIT_FAILED) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR unexpected WaitForSingleObject failure %x", GetLastError());
#endif
		return -1;
	}

	if (wait != WAIT_OBJECT_0) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR unexpected WaitForSingleObject failure");
#endif
		return -1;
	}

	/* If nothing is available on ewbin, return with an error log message */

	if (!ReadFile(ewbin, &c, 1, &count, NULL)) {
#ifdef USE_ADD_LOG
		add_log(12, "not started from wrapper - read failure %d", GetLastError());
#endif
		return -1;
	} else if (c != 0) {
#ifdef USE_ADD_LOG
		add_log(12, "wrong parent, it would seem");
#endif
		return -1;
	} else {
		c = '\01';
		if (!WriteFile(ewbout, &c, 1, &count, NULL)) {
#ifdef USE_ADD_LOG
			add_log(12, "identification back failed %d on %d", GetLastError(), ewbout);
#endif
			return -1;
		}
		ReleaseSemaphore (event_w, 1, NULL);
	}

#ifdef USE_ADD_LOG
	add_log(12, "started from wrapper");
#endif
	sa.nLength = sizeof(SECURITY_ATTRIBUTES);
	sa.lpSecurityDescriptor = NULL;
	sa.bInheritHandle = TRUE;

      eif_conoutfile = CreateFile ("CONOUT$", GENERIC_WRITE | GENERIC_READ,
	      FILE_SHARE_READ | FILE_SHARE_WRITE, &sa, OPEN_EXISTING, 0, 0);

      if (eif_conoutfile == INVALID_HANDLE_VALUE)
	      {
#ifdef USE_ADD_LOG
/*              add_log(12, "Create output handle failed %d", GetLastError()); */
#endif
/*              return -1; */
	      }

	SetStdHandle (STD_OUTPUT_HANDLE, eif_conoutfile);
	eif_coninfile = CreateFile ("CONIN$", GENERIC_READ | GENERIC_WRITE,
	      FILE_SHARE_READ | FILE_SHARE_WRITE, &sa, OPEN_EXISTING, 0, 0);

	if (eif_coninfile == INVALID_HANDLE_VALUE)
	      {
#ifdef USE_ADD_LOG
/*              add_log(12, "Create input handle failed %d", GetLastError()); */
#endif
/*              return -1; */
	      }
	SetStdHandle (STD_INPUT_HANDLE, eif_coninfile);
	return 0;
}

#else
rt_public int identify(void)
{
	/* Identification protocol, to make sure we have been started via the
	 * ised wrapper. We expect a null character from file descriptor EWBIN and
	 * write a ^A on EWBOUT.
	 */

	char c;
	fd_set mask;
	struct timeval tm;			/* Timeout for select */
	struct stat buf;			/* Statistics buffer */

	/* Cut off the whole process if file EWBIN is not a valid file descriptor,
	 * something the kernel will gladly tell us by making the fstat() system
	 * call fail.
	 */

	FD_ZERO(&mask);
	FD_SET(EWBIN, &mask);	/* Want to select of fd ewbin */

	if (-1 == fstat(EWBIN, &buf)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR fstat: %m (%e)");
		add_log(2, "ERROR file EWBIN not initialized by parent");
#endif
		return -1;
	}

	/* Quickly poll on ewbin to see whether it's worth attempting a read on
	 * it or not. Wait at most 2 seconds (to let our parent initialize) and
	 * then return if nothing is available within that time frame.
	 */

#ifdef __VMS	/* I admit it; it can take a long time to spawn on vms. */
	tm.tv_sec = 5;
#else
	tm.tv_sec = 2;
#endif /* vms */
	tm.tv_usec = 0;
	if (-1 == select(EWBIN + 1, &mask, (Select_fd_set_t) 0, (Select_fd_set_t) 0, &tm)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR select: %m (%e)");
		add_log(2, "ERROR unexpected select failure");
#endif
		return -1;
	}

	/* If nothing is available on ewbin, return with an error log message */
	if (!FD_ISSET(EWBIN, &mask)) {
#ifdef USE_ADD_LOG
		add_log(12, "nothing distilled by parent");
#endif
		return -1;
	}

	if (-1 == read(EWBIN, &c, 1)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR read: %m (%e)");
		add_log(12, "not started from wrapper");
#endif
		return -1;
	} else if (c != 0) {
#ifdef USE_ADD_LOG
		add_log(12, "wrong parent, it would seem");
#endif
		return -1;
	} else {
		c = '\01';
		/* I don't care if we get SIGPIPE */
		if (-1 == write(EWBOUT, &c, 1)) {
#ifdef USE_ADD_LOG
			add_log(1, "SYSERR read: %m (%e)");
			add_log(12, "identification back failed");
#endif
			return -1;
		}
	}

#ifdef USE_ADD_LOG
	add_log(12, "started from wrapper");
#endif

	return 0;
}
#endif
