/*

 #####      #    #####            ####
 #    #     #    #    #          #    #
 #    #     #    #    #          #
 #    #     #    #####    ###    #
 #    #     #    #   #    ###    #    #
 #####      #    #    #   ###     ####

	Externals for directory handling.
	$Id$
*/

#include "eif_portable.h"
#include "eif_lmalloc.h"	/* for eif_malloc, eif_free */
#include "eif_path_name.h"	/* for eifrt_vms_directory_file_name */

#include <stdio.h>
#if !defined EIF_VMS && !defined VXWORKS 
#include <malloc.h>
#endif

#ifdef EIF_VMS_V6_ONLY
 /* define these routines in upr case, cause that's how they are in the lib */
#define lib$find_file LIB$FIND_FILE
#define sys$getmsg SYS$GETMSG
#define cma$tis_errno_get_addr CMA$TIS_ERRNO_GET_ADDR
#include <errno.h>	/* redefine cma$tis... to caps before this include! */
#include <string.h>
#include <lib$routines.h>
#include <stdio.h>
#include <ctype.h>
#include <descrip.h>
#include <ssdef.h>	/* for system services error codes */
#include <rmsdef.h>	/* for RMS error codes */
#include <starlet.h>	/* for sys$getmsg() */
#endif


#include <sys/types.h>
#include <sys/stat.h>
#ifdef EIF_WIN32
#include <io.h>			/* %%ss added for access */
#include <direct.h>		/* %%ss added for (ch|rm)dir */
#else
	/* FIXME: write dummy unit */
#include <unistd.h>
#endif

#include "eif_dir.h"
#include "eif_file.h" /* %%ss moved from 2 lines above */
#include "eif_plug.h"
#include "eif_error.h"

#include <string.h>

/* %%zs moved EIF_WIN_DIRENT definition block to dir.h from here */

#ifndef HAS_READDIR
	Sorry! You have to find a PD implementation of readdir()...
#endif

#define ST_MODE     0x0fff      /* Keep only permission mode */

/*
 * Opening and closing a directory.
 */

rt_public EIF_POINTER dir_open(char *name)
{
	/* Open directory `name' for reading (can't do much else on UNIX) */
#ifdef EIF_WIN32
	EIF_WIN_DIRENT *c;

	c = (EIF_WIN_DIRENT *) eif_malloc (sizeof(EIF_WIN_DIRENT));
	if (c == (EIF_WIN_DIRENT *) 0)
		enomem(MTC_NOARG);

	strcpy (c->name, name);
	c->handle = NULL;
	return (EIF_POINTER) c;
#else
	DIR *dirp;

	errno = 0;
	dirp = (DIR *) opendir(name);

	if (dirp == (DIR *) 0)
		esys();

	return (EIF_POINTER) dirp;
#endif
}

rt_public void dir_close(EIF_POINTER d)
{
#ifdef EIF_WIN32
	EIF_WIN_DIRENT *dirp = (EIF_WIN_DIRENT *) d;
	if (dirp->handle != NULL)
		FindClose (dirp->handle);
	eif_free(dirp);
#else
	DIR *dirp = (DIR *) d;
	(void) closedir(dirp);
#endif
}

/*
 * Rewinding directory (may be a macro).
 */

rt_public void dir_rewind(EIF_POINTER d)
{
#ifdef EIF_WIN32
	EIF_WIN_DIRENT *dirp = (EIF_WIN_DIRENT *) d;
	if (dirp->handle != NULL)
		FindClose(dirp->handle);
	dirp->handle = NULL;
#else
	DIR *dirp = (DIR *) d;
#ifdef HAS_REWINDDIR
	rewinddir(dirp);
#endif
#endif
}

/*
 * Looking for a specific entry.
 */

rt_public char *dir_search(EIF_POINTER d, char *name)
          		/* Directory where search is made */
           		/* Entry we are looking for */
{
#ifdef EIF_WIN32
	EIF_WIN_DIRENT *dirp = (EIF_WIN_DIRENT *) d;
	HANDLE h;
	WIN32_FIND_DATA wfd;
	char *filename;

	filename = (char *) eif_malloc (strlen(name) + strlen (dirp->name) + 2);
	if (filename == (char *) 0)
		enomem(MTC_NOARG);

	strcpy (filename, dirp->name);
	if (filename[strlen(filename)-1] != '\\')
		strcat (filename, "\\");
	strcat (filename, name);
	h = FindFirstFile (filename, &wfd);
	eif_free (filename);
	if (h != INVALID_HANDLE_VALUE) {
		FindClose (h);
		return (char *) 1;
	}

	return (char *) 0;		/* Not found */

#else /* UNIX, VMS */
	/* Look for a given entry throughout the directory and return a pointer
	 * to a descriptor if found, a null pointer otherwise.
	 * Note that no rewinddir() is performed, as the Eiffel side provides
	 * us with a freshly opened directory pointer.
	 */

	DIR *dirp = (DIR *) d;
#ifdef DIRNAMLEN
	int len = strlen(name);		/* Avoid unncessary calls to strcmp() */
#endif
#ifdef EIF_WIN_31
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
#endif
}

rt_public EIF_REFERENCE dir_next(EIF_POINTER d)
	/* Return the Eiffel string corresponding to the next entry name, or a
	 * null pointer if we reached the end of the directory.
	 */
{
#ifdef EIF_WIN32
	EIF_WIN_DIRENT *dirp = (EIF_WIN_DIRENT *) d;
	HANDLE h;
	WIN32_FIND_DATA wfd;
	BOOL r;
	char *name;

	if (dirp->handle != NULL)
		{
		r = FindNextFile (dirp->handle, &wfd);
		if (r)
			return makestr (wfd.cFileName, strlen (wfd.cFileName));
		else
			return (char *) 0;
		}
	else
		{
		name = (char *) eif_malloc (strlen(dirp->name) + 5);
		if (name == (char *) 0)
			enomem(MTC_NOARG);

		strcpy (name,dirp->name);
		if (name[strlen(name)-1] == '\\')
			strcat (name, "*.*");
		else
			strcat (name , "\\*.*");
		h = FindFirstFile (name, &wfd);
		eif_free (name);
		if (h != INVALID_HANDLE_VALUE)
			{
			dirp->handle = h;
			return makestr (wfd.cFileName, strlen (wfd.cFileName));
			}
		else
			return (char *) 0;
		}
#else  /* UNIX, VMS */
	DIR *dirp = (DIR *) d;

	DIRENTRY *dp = readdir(dirp);

	if (dp == (DIRENTRY *) 0)
		return (char *) 0;

#ifdef EIF_VMS_V6_ONLY
	/* strip any trailing version number from the returned string */
	{
	    char *verp = strrchr(dp->d_name, ';');
	    if (verp)
		return makestr (dp->d_name, verp - dp->d_name);
	    else return makestr (dp->d_name, strlen(dp->d_name));
	}
#elif defined DIRNAMLEN
	return makestr(dp->d_name, dp->d_namlen);
#else
	return makestr(dp->d_name, strlen(dp->d_name));
#endif
#endif
}

rt_public EIF_REFERENCE dir_current(void)
{
	/* Return the Eiffel string corresponding to the current working
	 * directory.  Note this always returns a new string.
	 */

	char *cwd;
	EIF_REFERENCE  cwd_string;

	cwd = getcwd (NULL, PATH_MAX);
	cwd_string = RTMS(cwd);
	free (cwd);	/* Not `eif_free', getcwd() call malloc in POSIX.1 */
	return cwd_string;
}

rt_public EIF_CHARACTER eif_dir_separator (void)
{
#if defined EIF_WIN32
	return '\\';
#elif defined EIF_VMS
	/* This is a gross oversimplification! */
	return '.';
#else
	return '/';
#endif
}

rt_public EIF_INTEGER eif_chdir (EIF_OBJECT path)
{
	/* Set current dir to `path'
	 * Returns the error status
	 */
	return chdir (eif_access(path));
}

rt_public EIF_BOOLEAN eif_dir_exists(char *name)
{
#ifdef EIF_VMS_V6_ONLY
	/* Need to check if directory is passed as simple name
	** such as "subdir", or as Unix-like (subdir/ or /top/subdir),
	** or as VMS style ([.subdir] or [top.subdir] or subdir.dir).
	** If not VMS style, convert it.
	** Will have to treat [...subdir] different from [...]subdir.dir
	** because lib$find_file will return "file not found" in the first
	** case (if subdir exists) and same error in 2nd case (if it doesn't!)
	** Was using stat(), but this would have required parsing p
	** and moving up one level, and check for subdir.dir with stat()
	** Now using lib$find_file, which will accept a file or dir.
	*/
	int		status;
	char		buff[PATH_MAX];
	char		namecopy[PATH_MAX];
	int		i;
	int		len;
	struct dsc$descriptor_s	pat;
	struct dsc$descriptor_s	res;
	unsigned int		context=0;
	int			flags = 0xf;
	char			mesg[PATH_MAX];
	/* $DESCRIPTOR(message_text,mesg);	this generates warning */
	struct dsc$descriptor_s message_text;
	unsigned short		mesglen;
	int			getmsgstatus;
	/* ASSUMING DIRECTORY IS VALID AND IN VMS FORMAT */
	/* Set up the pattern descriptor. */
	strcpy(namecopy,name);
	pat.dsc$a_pointer = namecopy;
	pat.dsc$w_length = strlen(namecopy);
	pat.dsc$b_class = DSC$K_CLASS_S;
	pat.dsc$b_dtype = DSC$K_DTYPE_T;
	/* Set up result descriptor. */
	res.dsc$a_pointer = buff;
	res.dsc$w_length = sizeof buff;
	res.dsc$b_dtype = DSC$K_DTYPE_T;
	res.dsc$b_class = DSC$K_CLASS_S;
	status = lib$find_file(&pat,&res,&context);

	/* buff is padded at end with blanks, prune them off */
	/* find last blank, then set it to null */
	len = strlen(buff); /* may not be null terminated properly */
	if (len >= sizeof buff) len = (sizeof buff) -1;
	for (i=len-1;buff[i]==' ';i--)
		buff[i]='\0';
	switch (status) {
		case RMS$_FNF: /* this will be the return code
			** if the argument was [...subdir] and
			** subdir exists and the file .; doesn't exist.
			*/
			/*printf("File not found.\n");*/
			 break;
		case RMS$_NORMAL:
			/* normal return if checking subdir.dir
			** or if the file [...subdir].; exists
			*/
			/*printf("Normal status return.\n");*/
			 break;
		case RMS$_NMF:	/*printf("No more files.\n");*/ break;
       		case RMS$_DNF:	/*printf("Directory not found.\n");*/ break;
		case RMS$_SYN:	/* not sure what this is */ break;
		default:
			printf("eif_dir_exists: Unknown return status: %d\n",status);
			printf("Result: <%s>\n",buff);
			message_text.dsc$a_pointer = mesg;
			message_text.dsc$w_length = sizeof mesg;
			message_text.dsc$b_dtype = DSC$K_DTYPE_T;
			message_text.dsc$b_class = DSC$K_CLASS_S;
			getmsgstatus = SYS$GETMSG(status,&mesglen,&message_text,flags,0);
			printf("\n<%d> %s\n",getmsgstatus,mesg);
			 break;
		}

	/* assume that if last character is ']' then the argument
	** that was passed is of the form '[...subdir]' and therefore
	** a "file not found" error means the directory exists
	*/
	i = access (name,0);
	return ( ( (status==RMS$_FNF) && (name[strlen(name)-1]==']') )
		||(status==RMS$_NORMAL) /* incase subdir.dir */ );

/*#elif defined EIF_WIN32	*/	
					/* ifdef VMS */

/*	return (EIF_BOOLEAN) (access(name,0) != -1 ); */
		/* Removed: Does not check if not dir -ET */

#else	/* Unix, Win32, VMS (V7 or later), et. al. */

    /* Test whether file exists or not by checking the return from the stat()
     * system call, hence letting the kernel run all the tests. Return true
     * if the file exists.
     * Stat is called directly, because failure is allowed here obviously.
     * Test to see if it is really a directory and not a plain text file.
     */

	struct stat buf;            /* Buffer to get file statistics */

	if (stat(name, &buf) == -1)	/* Attempt to stat file */
		return (EIF_BOOLEAN) '\0';
	else
		return (EIF_BOOLEAN) ((buf.st_mode & S_IFDIR) ? '\1' : '\0');
#endif	/* else (platform) */
}

rt_public EIF_BOOLEAN eif_dir_is_readable(char *name)
{
	/* Is directory readable */

#ifdef EIF_VMS_V6_ONLY	/* and hence no unix filespec support */
	char	copy[PATH_MAX];
	strcpy(copy,name);
	if ( -1 == access(dir_dot_dir(copy),R_OK) )
		return (EIF_BOOLEAN) FALSE;
	else	return (EIF_BOOLEAN) TRUE;

#elif defined EIF_VMS
	/* Here is a major stupid: stat accepts unix directory paths, access does not! */
	/* return (EIF_BOOLEAN) (access(name, R_OK) != -1);           wont work!     */
	char vms_path [PATH_MAX +1];
	int dbg = access((name), R_OK);
	int result = access(eifrt_vms_directory_file_name (name, vms_path), R_OK);
	return (EIF_BOOLEAN) (result != -1);

#elif defined EIF_WIN32

	return (EIF_BOOLEAN) (access (name, 04) != -1);

#else
#ifdef HAS_GETEUID
	int uid, gid;				/* File owner and group */
	int euid, egid;				/* Effective user and group */
#endif

	int mode;					/* Current mode */
	struct stat buf;            /* Buffer to get file statistics */

	stat(name, &buf);			/* Cannot fail (precondition) */
	mode = buf.st_mode & ST_MODE;

#ifdef HAS_GETEUID

	uid = buf.st_uid;
	gid = buf.st_gid;

	euid = geteuid();
	egid = getegid();

	if (euid == 0)
		return (EIF_BOOLEAN) '\01';
	else if (uid == euid)
		return (EIF_BOOLEAN) ((mode & S_IRUSR) ? '\01' : '\0');
	else if (gid == egid)
		return (EIF_BOOLEAN) ((mode & S_IRGRP) ? '\01' : '\0');
#ifdef HAS_GETGROUPS
	else if (eif_group_in_list(gid))
		return (EIF_BOOLEAN) ((mode & S_IRGRP) ? '\01' : '\0');
#endif
	else
#endif
		return (EIF_BOOLEAN) ((mode & S_IROTH) ? '\01' : '\0');
#endif	/* not vms */
}

rt_public EIF_BOOLEAN eif_dir_is_writable(char *name)
{
	/* Is directory writable */

#ifdef EIF_VMS_V6_ONLY
	char	copy[PATH_MAX];
	strcpy(copy,name);
	if ( -1 == access(dir_dot_dir(copy),W_OK) )
		return (EIF_BOOLEAN) FALSE;
	else	return (EIF_BOOLEAN) TRUE;

#elif defined EIF_VMS

	/* This requies write and delete access on the directory to be true. */
	char vms_path [PATH_MAX +1];
	int dbg = access((name), W_OK);
	int result = access(eifrt_vms_directory_file_name (name, vms_path), W_OK);
	return (EIF_BOOLEAN) (result != -1);

#elif defined EIF_WIN32

	return (EIF_BOOLEAN) (access (name, 02) != -1);

#else

#ifdef HAS_GETEUID
	int uid, gid;				/* File owner and group */
	int euid, egid;				/* Effective user and group */
#endif

	int mode;					/* Current mode */
	struct stat buf;            /* Buffer to get file statistics */

	stat(name, &buf);			/* Cannot fail (precondition) */
	mode = buf.st_mode & ST_MODE;

#ifdef HAS_GETEUID
	uid = buf.st_uid;
	gid = buf.st_gid;

	euid = geteuid();
	egid = getegid();
#if defined EIF_VMS && defined _VMS_V6_SOURCE
	euid |= egid << 16;		/* VMS: mask in group id */
#endif

	if (euid == 0)
		return (EIF_BOOLEAN) '\01';
	else if (uid == euid)
		return (EIF_BOOLEAN) ((mode & S_IWUSR) ? '\01' : '\0');
	else if (gid == egid)
		return (EIF_BOOLEAN) ((mode & S_IWGRP) ? '\01' : '\0');
#ifdef HAS_GETGROUPS
	else if (eif_group_in_list(gid))
		return (EIF_BOOLEAN) ((mode & S_IWGRP) ? '\01' : '\0');
#endif
	else
#endif
		return (EIF_BOOLEAN) ((mode & S_IWOTH) ? '\01' : '\0');
#endif	/* not vms */
}

rt_public EIF_BOOLEAN eif_dir_is_executable(char *name)
{
	/* Is directory executable */

#ifdef EIF_VMS_V6_ONLY
	char	copy[PATH_MAX];
	strcpy(copy,name);
	if ( -1 == access(dir_dot_dir(copy),X_OK) )
		return (EIF_BOOLEAN) FALSE;
	else
		return (EIF_BOOLEAN) TRUE;

#elif defined EIF_VMS
	char vms_path [PATH_MAX +1];
	int dbg = access((name), X_OK);
	int result = access(eifrt_vms_directory_file_name (name, vms_path), X_OK);
	return (EIF_BOOLEAN) (result != -1);

#elif defined EIF_WIN32
	return (EIF_BOOLEAN) (access (name, 0) != -1);
#else
#ifdef HAS_GETEUID
	int uid, gid;				/* File owner and group */
	int euid, egid;				/* Effective user and group */
#endif

	int mode;					/* Current mode */
	struct stat buf;            /* Buffer to get file statistics */

	stat(name, &buf);			/* Cannot fail (precondition) */
	mode = buf.st_mode & ST_MODE;

#ifdef HAS_GETEUID
	uid = buf.st_uid;
	gid = buf.st_gid;

	euid = geteuid();
	egid = getegid();
#if defined EIF_VMS && defined _VMS_V6_SOURCE
	euid |= egid << 16;		/* VMS: mask in group id */
#endif

	if (euid == 0)
		return (EIF_BOOLEAN) '\01';
	else if (uid == euid)
		return (EIF_BOOLEAN) ((mode & S_IXUSR) ? '\01' : '\0');
	else if (gid == egid)
		return (EIF_BOOLEAN) ((mode & S_IXGRP) ? '\01' : '\0');
#ifdef HAS_GETGROUPS
	else if (eif_group_in_list(gid))
		return (EIF_BOOLEAN) ((mode & S_IXGRP) ? '\01' : '\0');
#endif
	else
#endif
		return (EIF_BOOLEAN) ((mode & S_IXOTH) ? '\01' : '\0');
#endif	/* not vms */
}

rt_public EIF_BOOLEAN eif_dir_is_deletable(char *name)
{
	/* Is directory deletable */

#ifdef EIF_VMS
	return (EIF_BOOLEAN) TRUE;  /* ***VMS FIXME:*** */
#else
    return eif_dir_is_writable (name);
#endif
}


rt_public void eif_dir_delete(char *name)
{
		/* Delete directory `name' */

	struct stat buf;				/* File statistics */
	int status;						/* Status from system call */

#ifdef EIF_VMS
	printf("Directory delete not implemented yet.\n");
	printf("Directory: %s\n",name);
#else
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
#endif	/* vms */
}


#ifdef EIF_VMS
#define USE_VMS_WRAPPERS
/**
*** VMS wrappers for readdir package (readdir, opendir, closedir, etc.).
*** The wrappers ensure that only the latest file versions are returned from readdir.
**/

#ifdef  USE_VMS_WRAPPERS
typedef struct { size_t siz; int magic; DIR* dirp; char *prev; } EIF_VMS_DIR;
static const int magic = 7652;

#undef opendir   
#undef closedir  
#undef rewinddir 
#undef readdir   
#undef seekdir   
#undef telldir   
#endif

rt_public DIR* eif_vms_opendir (const char *dirname)
{
    DIR* DECC$OPENDIR (const char* dirname);
#ifdef USE_VMS_WRAPPERS
    EIF_VMS_DIR* res = NULL;
    const size_t siz = sizeof *res;
    struct dirent *ep;
    if ( (res = calloc (1, sizeof *res)) ) {
	if ( (res->prev = calloc (FILENAME_MAX +1, sizeof(char))) ) {
	    res->magic = magic;		/* magic number */
	    res->siz = sizeof *res;		/* size of structure */
	    res->dirp = DECC$OPENDIR (dirname);
	} 
	if (!res->dirp) { 
	    eif_free (res->prev);
	    eif_free (res);
	    res = NULL;
	} 
    } 
    return (DIR*)res;
#else
    return DECC$OPENDIR (dirname);
#endif
}

rt_public int eif_vms_closedir (DIR* notadirp)
{
    int DECC$CLOSEDIR (DIR *dirp);
#ifdef USE_VMS_WRAPPERS
    EIF_VMS_DIR* evdp = (EIF_VMS_DIR*)notadirp;
    int res = 0;
    if (evdp) {
	if (evdp->dirp) res = DECC$CLOSEDIR (evdp->dirp);
	eif_free (evdp->prev);
	eif_free (evdp);
    } else {
	/* is closedir (NULL) harmless? */
    }
    return res;
#else
    return DECC$CLOSEDIR (notadirp);
#endif
}

rt_public struct dirent * eif_vms_readdir (DIR* notadirp)
{
    struct dirent * DECC$READDIR (DIR*);
#ifdef USE_VMS_WRAPPERS
    EIF_VMS_DIR* evdp = (EIF_VMS_DIR*)notadirp;
    struct dirent * res;
    do {    /* read directory until different filename encountered */
	if ( (res = DECC$READDIR (evdp->dirp)) ) {
	    char *endp = strchr (res->d_name, ';');
	    if (endp)
		res->d_name[endp - res->d_name] = '\0';
	}
    } while (res && !strcasecmp (evdp->prev, res->d_name));
    if (res) {
	strcpy (evdp->prev, res->d_name);
    } else *evdp->prev = '\0';
    return res;
#else
    return DECC$READDIR (notadirp);
#endif
}

rt_public void eif_vms_rewinddir (DIR* notadirp)
{
    void DECC$REWINDDIR (DIR *dirp);
#ifdef USE_VMS_WRAPPERS
    EIF_VMS_DIR* evdp = (EIF_VMS_DIR*)notadirp;
    DECC$REWINDDIR (evdp->dirp);
    *evdp->prev = '\0';
#else
    DECC$REWINDDIR (notadirp);
#endif
}

rt_public void eif_vms_seekdir (DIR* notadirp, long int loc)
{
    void DECC$SEEKDIR (DIR*, long int);
#ifdef USE_VMS_WRAPPERS
    EIF_VMS_DIR* evdp = (EIF_VMS_DIR*)notadirp;
    (void) DECC$SEEKDIR (evdp->dirp, loc);
#else
    DECC$SEEKDIR (notadirp, loc);
#endif
}

rt_public long eif_vms_telldir (DIR* notadirp)
{
    long DECC$TELLDIR (DIR*);
#ifdef USE_VMS_WRAPPERS
    EIF_VMS_DIR* evdp = (EIF_VMS_DIR*)notadirp;
    return DECC$TELLDIR (evdp->dirp);
#else
    return DECC$TELLDIR (notadirp);
#endif
}


#ifdef EIF_VMS_V6_ONLY
char * dir_dot_dir (char * duplicate)
{
/*	For a given directory path, return the name of the directory file.
 *	For example, given DKA200:[DIR1.SUBDIR], return this:
 *		DKA200:[DIR1]SUBDIR.DIR
 * 	NOTE: THIS ROUTINE CHANGES THE STRING WHOSE POINTER IS PASSED TO IT.
 */
	int	i, j;
	int	orig_strlen;

	if ( duplicate == NULL ) 	return NULL;
	orig_strlen = strlen(duplicate);
	if ( duplicate[orig_strlen-1] != ']')	return NULL;
	if (orig_strlen == 2 && duplicate[0] == '[') {
		/* [] means current directory */
		/* have to get full directory name */
		getcwd(duplicate,PATH_MAX - 1);
		orig_strlen = strlen(duplicate);
	}	/* current directory */
	/* first locate the last . in the path by stepping backwards */
	for ( i=(orig_strlen-2);
		(i>0) 			/* at beginning of string */
		&& (duplicate[i] != '.')	/* found the dot */
		&& (duplicate[i] != '[');	/* found the leading bracket */
		i-- )	{ /* do nothing */ }
	if (i==0)	return NULL;
	if (duplicate[i]=='.') {		/* FOUND THE DOT */
		duplicate[i] = ']';
		duplicate[strlen(duplicate)-1] = '\0';	/* get rid of trailing ] */
		strcat(duplicate,".DIR");
		return duplicate;
	}	/* found the dot */
	if (duplicate[i]=='[') {	/* FOUND LEADING BRACKET */
		/* must be top level directory */
		/* change [topdir] to [000000]topdir.dir */
		for ( j=strlen(duplicate) -2 ; j > i ; j-- ) {
			duplicate[j+7] = duplicate[j];
		}	/* for */
		for ( j=i+1; j < i+7; j++ )	/* now insert 0's */
			duplicate[j] = '0';
		duplicate[i+7] = ']';
		duplicate[orig_strlen+6] = '\0';
		strcat(duplicate,".dir");
		return duplicate;
	}	/* found leading bracket */

}	/* dir_dot_dir */

/*
**  VMS readdir() routines.
**  Written by Rich $alz, <rsalz@bbn.com> in August, 1990.
**  This code has no copyright.
*/

    /* Uncomment the next line to get a test routine. */
/*#define TEST*/

    /* Number of elements in vms_versions array */
#define CARDINALITY(a)	( sizeof(a) / sizeof (*a) )
#define VERSIZE(e)	( CARDINALITY (e->vms_versions ) )


/*
**  Open a directory, return a handle for later use.
*/
DIR *opendir (char *name)
{
    DIR		*dd;

    /* Get memory for the handle, and the pattern. */
    if ((dd = (DIR *)eif_malloc(sizeof *dd)) == NULL) {
	errno = ENOMEM;
	return NULL;
    }

    if (strcmp(".",name) == 0) name = "";

    dd->pattern = eif_malloc((unsigned int)(strlen(name) + sizeof "*.*" + 1));
    if (dd->pattern == NULL) {
	eif_free((char *)dd);
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
void vmsreaddirversions(DIR *dd, int flag)
{
    dd->vms_wantversions = flag;
}


/*
**  Free up an opened directory.
*/
void closedir(DIR *dd)
{
    eif_free(dd->pattern);
    eif_free((char *)dd);
}


/*
**  Collect all the version numbers for the current file.
*/
static void collectversions(DIR *dd)
{
    struct dsc$descriptor_s	pat;
    struct dsc$descriptor_s	res;
    struct dirent		*e;
    char			*p;
    char			buff[sizeof dd->entry.d_name];
    int				i;
    char			*text;
    unsigned int 		context;

    /* Convenient shorthand. */
    e = &dd->entry;

    /* Add the version wildcard, ignoring the "*.*" put on before */
    i = strlen(dd->pattern);
    text = eif_malloc((unsigned int)(i + strlen(e->d_name)+ 2 + 1));
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

    eif_free(text);
}


/*
**  Read the next entry from the directory.
*/
struct dirent *readdir(DIR *dd)
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
long telldir(DIR *dd)
{
    return dd->context;
}


/*
**  Return to a spot where we used to be.
*/
void seekdir(DIR *dd, long pos)
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
#endif	/* EIF_VMS_V6_ONLY */
#endif /* EIF_VMS */
