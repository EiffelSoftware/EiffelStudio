/*
 * scandir.C -- A scandir implementation.
 */

/*
 * $Id: scandir.C 78389 2004-11-30 00:17:17Z manus $
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
 * Revision 3.0.1.1  1994/01/24  13:58:45  ram
 * patch16: created
 *
 */

#include "config.h"

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#ifdef I_DIRENT
#include <dirent.h>
#else
#ifdef I_SYS_NDIR
#include <sys/ndir.h>
#else
#ifdef I_SYS_DIR
#include <sys/dir.h>
#endif
#endif
#endif

#include "confmagic.h"		/* Remove if not metaconfig -M */

#ifndef HAS_SCANDIR

extern Malloc_t malloc();
extern Malloc_t realloc();

extern DIR *opendir();
extern Direntry_t *readdir();

#define DIR_NULL	((DIR *) 0)
#define ENTRY_NULL	((Direntry_t *) 0)

static int alphasort _((Direntry_t **, Direntry_t **));

/*
 * scandir
 *
 * This routine reads the directory `dirnam' and builds an array of
 * pointers to directory entries using malloc(). The second parameter
 * is the address of a pointer to an array of structure pointers. The
 * third parameter is a pointer to a routine which is called with a
 * pointer to a directory entry and should return a non zero value
 * if the directory entry should be included in the arrary. If this
 * pointer is NULL, then all the directory entries will be included.
 * The last argument is a pointer to a routine which is passed to
 * qsort() to sort the completed array. If this pointer is NULL, the
 * array is not sorted.
 * scandir() returns the number of entries in the array and a pointer
 * to the array through the parameter namlist.
 * alphasort() is a routine which sorts the array alphabetically.
 */
V_FUNC(int scandir, (dirnam, namelist, sel, comp),
	char *dirnam			/* Direcotry name */ NXT_ARG
	Direntry_t ***namelist	/* Pointer to an array of struct ptrs */ NXT_ARG
	int (*sel)()			/* Routine to select entries */ NXT_ARG
	int (*comp)()			/* Routine passed to qsort */)
{
	DIR *dirp;				/* Returned by opendir() */
	Direntry_t *dp;			/* Read entry */
	Direntry_t *dp_save;	/* Place where entry is stored */
	Direntry_t **tmplist;	/* Where the array list is stored */
	int nent = 0;			/* Number of entries */

	dirp = opendir(dirnam);
	if (dirp == DIR_NULL)
		return -1;			/* Directory cannot be opened for reading */

	for (dp = readdir(dirp); dp != ENTRY_NULL; dp = readdir(dirp)) {
		if (sel == ((int (*)()) 0) || (*sel)(dp)) {
			/* If entry has to be included */
			nent++;		/* One more entry */

			if (nent == 1) {	/* Create array for first entry */
				tmplist = (Direntry_t **)
					malloc(sizeof(Direntry_t *));
				if (tmplist == (Direntry_t **) 0)
					return -1;		/* Cannot create array */
			} else {				/* Reallocate for a new entry */
				tmplist = (Direntry_t **)
					realloc(tmplist, nent*sizeof(Direntry_t *));
				if (tmplist == (Direntry_t **) 0)
					return -1;		/* Cannot reallocate array */
			}

			dp_save = (Direntry_t *) malloc(sizeof(Direntry_t));
			if (dp_save == ENTRY_NULL)
				return -1;		/* No space to save entry */
			bcopy((char *) dp, (char *) dp_save, sizeof(Direntry_t));
			*(tmplist+(nent-1)) = dp_save;
		}
	}

	if (comp != ((int (*)()) 0) && nent)	/* Need sorting ? */
		qsort(tmplist, nent, sizeof(Direntry_t *), comp);

	*namelist = tmplist;	/* Passes the address of the arrray */
	closedir(dirp);			/* Close directory */

	return nent;			/* Number of items */
}

P_FUNC(int alphasort, (d1, d2),
	Direntry_t **d1 NXT_ARG Direntry_t **d2)
{
	return strcmp((*d1)->d_name, (*d2)->d_name);
}

#endif

