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
#include <sys/stat.h>
#include <unistd.h>
#include "file.h"
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

public EIF_POINTER dir_open(name)
char *name;
{
	/* Open directory `name' for reading (can't do much else on UNIX) */

	DIR *dirp;

	errno = 0;
	dirp = (DIR *) opendir(name);
	if (dirp == (DIR *) 0)
		esys();

	return (EIF_POINTER) dirp;
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
#ifdef HAS_REWINDDIR
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

public EIF_OBJ dir_current()
{
	/* Return the Eiffel string corresponding to the current working
	 * directory.  Note this always returns a new string.
	 */

	char *cwd;
	char *cwd_string;

	cwd = getcwd(NULL, PATH_MAX);
	cwd_string = makestr(cwd, strlen (cwd));
	free (cwd);
	return ((EIF_OBJ)cwd_string);
}

public EIF_CHARACTER eif_dir_separator ()
{
#ifdef __WATCOMC__
	return '\\';
#else
	return '/';
#endif
}

public EIF_INTEGER eif_chdir (path)
EIF_OBJ path;
{
	/* Set current dir to `path'
	 * Returns the error status
	 */
	return chdir (eif_access(path));
}

public EIF_BOOLEAN eif_dir_exists(name)
char *name;
{
    /* Test whether file exists or not by checking the return from the stat()
     * system call, hence letting the kernel run all the tests. Return true
     * if the file exists.
     * Stat is called directly, because failure is allowed here obviously.
	 * Test to see if it is really a directory and not a palin text file.
     */

    struct stat buf;            /* Buffer to get file statistics */

	if (stat(name, &buf) == -1)	/* Attempt to stat file */
		return (EIF_BOOLEAN) 0;
	else
		return (buf.st_mode & S_IFDIR) ? (EIF_BOOLEAN) '\1' : (EIF_BOOLEAN) '\0';
}

public EIF_BOOLEAN eif_dir_is_readable(name)
char *name;
{
	/* Is directory readable */
#ifdef HAS_GETEUID
	int uid, gid;				/* File owner and group */
#endif

#define ST_MODE     0x0fff      /* Keep only permission mode */

	int mode;					/* Current mode */
	struct stat buf;            /* Buffer to get file statistics */

	stat(name, &buf);			/* Cannot fail (precondition) */
	mode = buf.st_mode & ST_MODE;

#ifdef HAS_GETEUID
	uid = buf.st_uid;
	gid = buf.st_gid;

	if (uid == geteuid())
		return (EIF_BOOLEAN) ((mode & S_IRUSR) ? '\01' : '\0');
	else if (gid = getegid())
		return (EIF_BOOLEAN) ((mode & S_IRGRP) ? '\01' : '\0');
	else
#endif
		return (EIF_BOOLEAN) ((mode & S_IROTH) ? '\01' : '\0');
}

public EIF_BOOLEAN eif_dir_is_writable(name)
char *name;
{
	/* Is directory writable */
#ifdef HAS_GETEUID
	int uid, gid;				/* File owner and group */
#endif

	int mode;					/* Current mode */
	struct stat buf;            /* Buffer to get file statistics */

	stat(name, &buf);			/* Cannot fail (precondition) */
	mode = buf.st_mode & ST_MODE;

#ifdef HAS_GETEUID
	uid = buf.st_uid;
	gid = buf.st_gid;

	if (uid == geteuid())
		return (EIF_BOOLEAN) ((mode & S_IWUSR) ? '\01' : '\0');
	else if (gid = getegid())
		return (EIF_BOOLEAN) ((mode & S_IWGRP) ? '\01' : '\0');
	else
#endif
		return (EIF_BOOLEAN) ((mode & S_IWOTH) ? '\01' : '\0');
}

public EIF_BOOLEAN eif_dir_is_executable(name)
char *name;
{
	/* Is directory executable */
#ifdef HAS_GETEUID
	int uid, gid;				/* File owner and group */
#endif

	int mode;					/* Current mode */
	struct stat buf;            /* Buffer to get file statistics */

	stat(name, &buf);			/* Cannot fail (precondition) */
	mode = buf.st_mode & ST_MODE;

#ifdef HAS_GETEUID
	uid = buf.st_uid;
	gid = buf.st_gid;

	if (uid == geteuid())
		return (EIF_BOOLEAN) ((mode & S_IXUSR) ? '\01' : '\0');
	else if (gid = getegid())
		return (EIF_BOOLEAN) ((mode & S_IXGRP) ? '\01' : '\0');
	else
#endif
		return (EIF_BOOLEAN) ((mode & S_IXOTH) ? '\01' : '\0');
}


