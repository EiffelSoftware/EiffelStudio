/*

 #####      #    #####            ####
 #    #     #    #    #          #    #
 #    #     #    #    #          #
 #    #     #    #####    ###    #
 #    #     #    #   #    ###    #    #
 #####      #    #    #   ###     ####

	Externals for directory handling.

*/

#include "config.h"
#include "portable.h"
#include <sys/types.h>
#include "dir.h"
#include "plug.h"

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#ifndef HAS_READDIR
	Sorry! You have to find a PD implementation of readdir()...
#endif

extern int errno;				/* Kernel error report */
extern int esys();				/* Raise 'Operating system error' exception */
extern int eio();				/* Raise 'I/O error' exception */

/*
 * Opening and closing a directory.
 */

public fnptr dir_open(name)
char *name;
{
	/* Open directory `name' for reading (can't do much else on UNIX) */

	DIR *dirp;

	errno = 0;
	dirp = (DIR *) opendir(name);
	if (dirp == (DIR *) 0)
		esys();

	return (fnptr) dirp;
}

public void dir_close(dirp)
DIR *dirp;
{
	(void) closedir(dirp);
}

/*
 * Rewinding directory (may be a macro).
 */

public void dir_rewind(dirp)
DIR *dirp;
{
#ifndef __WATCOMC__
	rewinddir(dirp);
#endif
}

/*
 * Looking for a specific entry.
 */

public char *dir_search(dirp, name)
DIR *dirp;		/* Directory where search is made */
char *name;		/* Entry we are looking for */
{
	/* Look for a given entry throughout the directory and return a pointer
	 * to a descriptor if found, a null pointer otherwise.
	 * Note that no rewinddir() is performed, as the Eiffel side provides
	 * us with a freshly opened directory pointer.
	 */

#ifdef DIRNAMLEN
	int len = strlen(name);		/* Avoid unncessary calls to strcmp() */
#endif
#ifdef __WATCOMC__
	DIR *dp;
#else
	DIRENTRY *dp;
#endif

	for (dp = readdir(dirp); dp != (DIRENTRY *) 0; dp = readdir(dirp))
#ifdef DIRNAMLEN
		if (dp->d_namlen == len && 0 == strcmp(dp->d_name, name))
			return (char *) dp;
#else
		if (0 == strcmp(dp->d_name, name))
			return (char *) dp;
#endif
		
	return (char *) 0;		/* Not found */
}

public char *dir_next(dirp)
DIR *dirp;
{
	/* Return the Eiffel string corresponding to the next entry name, or a
	 * null pointer if we reached the end of the directory.
	 */

	DIRENTRY *dp = readdir(dirp);

	if (dp == (DIRENTRY *) 0)
		return (char *) 0;
	
#ifdef DIRNAMLEN
	return makestr(dp->d_name, dp->d_namlen);
#else
	return makestr(dp->d_name, strlen(dp->d_name));
#endif
}

