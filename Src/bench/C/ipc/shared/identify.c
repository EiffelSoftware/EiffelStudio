/*

    #    #####   ######  #    #   #####     #    ######   #   #           ####
    #    #    #  #       ##   #     #       #    #         # #           #    #
    #    #    #  #####   # #  #     #       #    #####      #            #
    #    #    #  #       #  # #     #       #    #          #     ###    #
    #    #    #  #       #   ##     #       #    #          #     ###    #    #
    #    #####   ######  #    #     #       #    #          #     ###     ####

	Identify parent, to make sure we are started via the ised wrapper.
*/

#include "config.h"
#include "portable.h"
#include <sys/types.h>
#include <sys/stat.h>
#include "logfile.h"
#include "timehdr.h"
#include "ewbio.h"

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

	tm.tv_sec = 2;
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

