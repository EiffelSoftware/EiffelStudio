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

#ifdef __VMS
 /* define these routines in upr case, cause that's how they are in the lib */
 #define lib$find_file LIB$FIND_FILE
 #define cma$tis_errno_get_addr CMA$TIS_ERRNO_GET_ADDR
 #include <errno.h>	/* redefine cma$tis... to caps before this include! */
 #include <string.h>
 #include <lib$routines.h>
 #include <stdio.h>
 #include <ctype.h>
 #include <descrip.h>
 #include <rmsdef.h>

/*
**  Header file for VMS readdir() routines.
**  Written by Rich $alz, <rsalz@bbn.com> in August, 1990.
**  This code has no copyright.
**
**  You must #include <descrip.h> before this file.
*/

/* 12-NOV-1990 added d_namlen field -GJC@MITECH.COM */

    /* Data structure returned by READDIR(). */
struct dirent {
    char	d_name[100];		/* File name		*/
    int         d_namlen;
    int		vms_verscount;		/* Number of versions	*/
    int		vms_versions[20];	/* Version numbers	*/
};

    /* Handle returned by opendir(), used by the other routines.  You
     * are not supposed to care what's inside this structure. */
typedef struct _dirdesc {
    long			context;
    int				vms_wantversions;
    char			*pattern;
    struct dirent		entry;
    struct dsc$descriptor_s	pat;
} DIR;


#define rewinddir(dirp)		seekdir((dirp), 0L)


extern DIR		*opendir();
extern struct dirent	*readdir();
extern long		telldir();
extern void		seekdir();
extern void		closedir();
extern void		vmsreaddirversions();

#endif

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

public void eif_dir_delete(name)
char *name;
{
		/* Delete directory `name' */

	struct stat buf;				/* File statistics */
	int status;						/* Status from system call */

	file_stat(name, &buf);			/* Side effect: ensure file exists */

	for (;;) {
		errno = 0;					/* Reset error condition */
		status = rmdir(name);		/* Remove only if empty */
		if (status == -1) {			/* An error occurred */
			if (errno == EINTR)		/* Interrupted by signal */
				continue;			/* Re-issue system call */
			else
				esys();				/* Raise exception */
			}
		break;
	}
}

#ifdef __VMS
/*
**  VMS readdir() routines.
**  Written by Rich $alz, <rsalz@bbn.com> in August, 1990.
**  This code has no copyright.
*/

    /* Uncomment the next line to get a test routine. */
/*#define TEST*/

    /* Number of elements in vms_versions array */
#define VERSIZE(e)	(sizeof e->vms_versions / sizeof e->vms_versions[0])


/*
**  Open a directory, return a handle for later use.
*/
DIR *
opendir(name)
    char	*name;
{
    DIR		*dd;

    /* Get memory for the handle, and the pattern. */
    if ((dd = (DIR *)malloc(sizeof *dd)) == NULL) {
	errno = ENOMEM;
	return NULL;
    }
    
    if (strcmp(".",name) == 0) name = "";
    
    dd->pattern = malloc((unsigned int)(strlen(name) + sizeof "*.*" + 1));
    if (dd->pattern == NULL) {
	free((char *)dd);
	errno = ENOMEM;
	return NULL;
    }

    /* Fill in the fields; mainly playing with the descriptor. */
    (void)sprintf(dd->pattern, "%s*.*", name);
    dd->context = 0;
    dd->vms_wantversions = 0;
    dd->pat.dsc$a_pointer = dd->pattern;
    dd->pat.dsc$w_length = strlen(dd->pattern);
    dd->pat.dsc$b_dtype = DSC$K_DTYPE_T;
    dd->pat.dsc$b_class = DSC$K_CLASS_S;

    return dd;
}


/*
**  Set the flag to indicate we want versions or not.
*/
void
vmsreaddirversions(dd, flag)
    DIR		*dd;
    int		flag;
{
    dd->vms_wantversions = flag;
}


/*
**  Free up an opened directory.
*/
void
closedir(dd)
    DIR		*dd;
{
    free(dd->pattern);
    free((char *)dd);
}


/*
**  Collect all the version numbers for the current file.
*/
static void
collectversions(dd)
    DIR				*dd;
{
    struct dsc$descriptor_s	pat;
    struct dsc$descriptor_s	res;
    struct dirent		*e;
    char			*p;
    char			buff[sizeof dd->entry.d_name];
    int				i;
    char			*text;
    long			context;

    /* Convenient shorthand. */
    e = &dd->entry;

    /* Add the version wildcard, ignoring the "*.*" put on before */
    i = strlen(dd->pattern);
    text = malloc((unsigned int)(i + strlen(e->d_name)+ 2 + 1));
    if (text == NULL)
	return;
    (void)strcpy(text, dd->pattern);
    (void)sprintf(&text[i - 3], "%s;*", e->d_name);

    /* Set up the pattern descriptor. */
    pat.dsc$a_pointer = text;
    pat.dsc$w_length = strlen(text);
    pat.dsc$b_dtype = DSC$K_DTYPE_T;
    pat.dsc$b_class = DSC$K_CLASS_S;

    /* Set up result descriptor. */
    res.dsc$a_pointer = buff;
    res.dsc$w_length = sizeof buff - 2;
    res.dsc$b_dtype = DSC$K_DTYPE_T;
    res.dsc$b_class = DSC$K_CLASS_S;

    /* Read files, collecting versions. */
    for (context = 0; e->vms_verscount < VERSIZE(e); e->vms_verscount++) {
	if (lib$find_file(&pat, &res, &context) == RMS$_NMF || context == 0)
	    break;
	buff[sizeof buff - 1] = '\0';
	if (p = strchr(buff, ';'))
	    e->vms_versions[e->vms_verscount] = atoi(p + 1);
	else
	    e->vms_versions[e->vms_verscount] = -1;
    }

    free(text);
}


/*
**  Read the next entry from the directory.
*/
struct dirent *
readdir(dd)
    DIR				*dd;
{
    struct dsc$descriptor_s	res;
    char			*p;
    char			buff[sizeof dd->entry.d_name];
    int				i;

    /* Set up result descriptor, and get next file. */
    res.dsc$a_pointer = buff;
    res.dsc$w_length = sizeof buff - 2;
    res.dsc$b_dtype = DSC$K_DTYPE_T;
    res.dsc$b_class = DSC$K_CLASS_S;
    if (lib$find_file(&dd->pat, &res, &dd->context) == RMS$_NMF
     || dd->context == 0L)
	/* None left... */
	return NULL;

    /* Force the buffer to end with a NUL. */
    buff[sizeof buff - 1] = '\0';
    for (p = buff; !isspace(*p); p++)
	;
    *p = '\0';

    /* Skip any directory component and just copy the name. */
    if (p = strchr(buff, ']'))
	(void)strcpy(dd->entry.d_name, p + 1);
    else
	(void)strcpy(dd->entry.d_name, buff);

    /* Clobber the version. */
    if (p = strchr(dd->entry.d_name, ';'))
	*p = '\0';

    dd->entry.d_namlen = strlen(dd->entry.d_name);

    dd->entry.vms_verscount = 0;
    if (dd->vms_wantversions)
	collectversions(dd);
    return &dd->entry;
}


/*
**  Return something that can be used in a seekdir later.
*/
long
telldir(dd)
    DIR		*dd;
{
    return dd->context;
}


/*
**  Return to a spot where we used to be.
*/
void
seekdir(dd, pos)
    DIR		*dd;
    long	pos;
{
    dd->context = pos;
}


#ifdef	TEST
main()
{
    char		buff[256];
    DIR			*dd;
    struct dirent	*dp;
    int			i;
    int			j;

    for ( ; ; ) {
	printf("\n\nEnter dir:  ");
	(void)fflush(stdout);
	(void)gets(buff);
	if (buff[0] == '\0')
	    break;
	if ((dd = opendir(buff)) == NULL) {
	    perror(buff);
	    continue;
	}

	/* Print the directory contents twice, the second time print
	 * the versions. */
	for (i = 0; i < 2; i++) {
	    while (dp = readdir(dd)) {
		printf("%s%s", i ? "\t" : "    ", dp->d_name);
		for (j = 0; j < dp->vms_verscount; j++)
		    printf("  %d", dp->vms_versions[j]);
		printf("\n");
	    }
	    rewinddir(dd);
	    vmsreaddirversions(dd, 1);
	}
	closedir(dd);
    }
    exit(0);
}
#endif	/* TEST */
#endif	/* VMS */
