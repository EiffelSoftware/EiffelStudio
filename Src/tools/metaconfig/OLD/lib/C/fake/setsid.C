/*
 * setsid.C -- A setsid replacement.
 */

/*
 * $Id: setsid.C 78389 2004-11-30 00:17:17Z manus $
 *
 *  Copyright (c) 1991-1993, Raphael Manfredi
 *  
 *  You may redistribute only under the terms of the Artistic Licence,
 *  as specified in the README file that comes with the distribution.
 *  You may reuse parts of this distribution only within the terms of
 *  that same Artistic Licence; a copy of which may be found at the root
 *  of the source tree for dist 3.0.
 *
 * $Log$
 * Revision 1.1  2004/11/30 00:17:18  manus
 * Initial revision
 *
 * Revision 3.0.1.1  1994/01/24  13:58:47  ram
 * patch16: created
 *
 */

#include "config.h"
#include "confmagic.h"		/* Remove if not metaconfig -M */

#ifndef HAS_SETSID
/*
 * setsid
 *
 * Set the process group ID and create a new session for the process.
 *
 * This is a pale imitation of the setsid() system call, since a session
 * and a process group are two distinct things for the kernel. However,
 * when setsid() is not available, the effects should be comparable.
 */
V_FUNC_VOID(int setsid)
{
	int error = 0;

#ifdef HAS_SETPGID
	/*
	 * setpgid() supersedes setpgrp() in OSF/1.
	 */
	error = setpgid(0 ,getpid());
#else
#ifdef HAS_SETPGRP
	/*
	 * Good old way to get a process group leader.
	 */
#ifdef USE_BSDPGRP
	error = setpgrp(0 ,getpid());	/* bsd way */
#else
	error = setpgrp();				/* usg way */
#endif
#endif
#endif

	/*
	 * When none of the above is defined, do nothing.
	 */

	return error;
}
#endif

