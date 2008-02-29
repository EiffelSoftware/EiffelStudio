/*
 * rename.C -- A rename emulation, for renaming files only.
 */

/*
 * $Id: rename.C 78389 2004-11-30 00:17:17Z manus $
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
 * Revision 3.0.1.1  1994/01/24  13:58:42  ram
 * patch16: created
 *
 */

#include "config.h"
#include "confmagic.h"		/* Remove if not metaconfig -M */

#ifndef HAS_RENAME
/*
 * rename
 *
 * Renames a file within a file system. This cannot be used to rename
 * directories, unfortunately.
 */
V_FUNC(int rename, (from, to),
	char *from		/* Original name */ NXT_ARG
	char *to		/* Target name */)
{
	(void) unlink(to);
	if (-1 == link(from, to))
		return -1;
	if (-1 == unlink(from))
		return -1;

	return 0;
}
#endif

