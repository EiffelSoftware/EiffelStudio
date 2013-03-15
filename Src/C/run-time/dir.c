/*
	description: "Routines for manipulating directories."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2013, Eiffel Software."
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="dir.c" header="eif_dir.h" version="$Id$" summary="Externals for directory handling">
*/

#include "eif_portable.h"
#include "rt_lmalloc.h"	/* for eif_malloc, eif_free */
#include "eif_path_name.h"	/* for eifrt_vms_directory_file_name */

#include <stdio.h>

#include <sys/types.h>
#include <sys/stat.h>
#ifdef EIF_WINDOWS
#include <io.h>			/* %%ss added for access */
#include <direct.h>		/* %%ss added for (ch|rm)dir */
#include <wchar.h>
#else
	/* FIXME: write dummy unit */
#include <unistd.h>
#endif

#include "rt_dir.h"
#include "rt_file.h"
#include "eif_plug.h"
#include "rt_error.h"
#include "rt_assert.h"

#include <string.h>

#ifndef HAS_READDIR
	Sorry! You have to find a PD implementation of readdir()...
#endif

#define ST_MODE     0x0fff      /* Keep only permission mode */

#ifdef EIF_WINDOWS
typedef struct tagDIR {
	HANDLE	handle;
	wchar_t	*name;
	WIN32_FIND_DATAW last_entry;
} EIF_DIR;
#else
typedef struct tagDIR {
	DIR *dir;
	DIRENTRY *last_entry;
} EIF_DIR;
#endif

/*
 * Opening and closing a directory.
 */

/*
doc:	<routine name="eif_dir_open" return_type="EIF_POINTER" export="public">
doc:		<summary>Start traversing a directory.</summary>
doc:		<return>A pointer to a platform specific directory structure which needs to be freed using `eif_dir_close'.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_POINTER eif_dir_open(EIF_FILENAME name)
{
	EIF_DIR *dirp;
	dirp = (EIF_DIR *) eif_malloc (sizeof(EIF_DIR));
	if (!dirp) {
		enomem(MTC_NOARG);
		return NULL;
	} else {
			/* Zero out allocated memory. */
		memset(dirp, 0, sizeof(EIF_DIR));
#ifdef EIF_WINDOWS
		dirp->name = name;
#else
		errno = 0;
		dirp->dir = opendir (name);
		if (!dirp->dir) {
			eif_free (dirp);
			esys();
		}
#endif
		return dirp;
	}
}

/*
doc:	<routine name="eif_dir_close" return_type="void" export="public">
doc:		<summary>Release memory held by `d' used to traverse a directory.</summary>
doc:		<param name="d" type="EIF_POINTER">Directory structure used for traversal.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public void eif_dir_close(EIF_POINTER d)
{
	EIF_DIR *dirp = (EIF_DIR *) d;
#ifdef EIF_WINDOWS
	if (dirp->handle) {
		(void) FindClose (dirp->handle);
		dirp->handle = NULL;
	}
#else
	(void) closedir(dirp->dir);
#endif
	eif_free(dirp);
}

/*
 * Rewinding directory (may be a macro).
 */

rt_public EIF_POINTER eif_dir_rewind(EIF_POINTER d, EIF_FILENAME a_name)
{
	EIF_DIR *dirp = (EIF_DIR *) d;
#ifdef EIF_WINDOWS
	if (dirp->handle) {
		(void) FindClose(dirp->handle);
		dirp->handle = NULL;
	}
#else
#ifdef HAS_REWINDDIR
	rewinddir(dirp->dir);
#else
	eif_dir_close(dirp);
	dirp = eif_dir_open (a_name)
#endif
#endif
	return dirp;
}

/*
doc:	<routine name="eif_dir_next" return_type="EIF_POINTER" export="public">
doc:		<summary>Given a directory `d', return the name of the next file in the current iteration in `a_buffer'.</summary>
doc:		<return>Return a null terminated pointer to the next file in the current iteration.</return>
doc:		<param name="d" type="EIF_POINTER">Pointer to the current working directory.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_POINTER eif_dir_next(EIF_POINTER d)
{
	EIF_DIR *dirp = (EIF_DIR *) d;

#ifdef EIF_WINDOWS
	HANDLE h;
	BOOL r;
	size_t a_name_length;
	wchar_t * wname;

	if (dirp->handle) {
		r = FindNextFileW (dirp->handle, &dirp->last_entry);
	} else {
		r = EIF_FALSE;
			/* Allocate additional space for "\\*": 2 characters + terminating zero */
		a_name_length = wcslen (dirp->name);
		wname = (wchar_t *) eif_malloc ((a_name_length + 3) * sizeof (wchar_t));
		if (!wname) {
			enomem(MTC_NOARG);
		} else {
			wcscpy (wname, dirp->name);
			if (wname[a_name_length - 1] == '\\') {
				wcscat (wname, L"*");
			} else {
				wcscat (wname , L"\\*");
			}
			h = FindFirstFileW (wname, &dirp->last_entry);
			eif_free (wname);
			if (h != INVALID_HANDLE_VALUE) {
				dirp->handle = h;
				r = EIF_TRUE;
			}
		}
	}
	if (r) {
		return dirp->last_entry.cFileName;
	} else {
		return NULL;
	}
#else  /* UNIX, VMS */
	DIRENTRY *dp = readdir(dirp->dir);

	if (dp) {
		dirp->last_entry = dp;
		return dirp->last_entry->d_name;
	} else {
		return NULL;
	}
#endif
}

/*
doc:	<routine name="eif_dir_current" return_type="EIF_INTEGER" export="public">
doc:		<summary>Store a EIF_FILENAME pointer corresponding to the current working directory if it can be computed in `a_buffer'.</summary>
doc:		<return>Size in bytes actually required in `a_buffer' including the terminating null character. If `a_count' is less than the returned value or if `a_buffer' is NULL, nothing is done to `a_buffer'. If there is an error, we return -1.</return>
doc:		<param name="a_buffer" type="EIF_POINTER">Pointer to a buffer that will hold the current working directory, or NULL if leng�h of buffer is required.</param>
doc:		<param name="a_count" type="EIF_INTEGER">Length of `a_buffer' in bytes.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_INTEGER eif_dir_current (EIF_FILENAME a_buffer, EIF_INTEGER a_count)
{
	EIF_INTEGER l_nbytes;

#ifdef EIF_WINDOWS
	wchar_t *subpart;
	wchar_t drive[2];
	drive [0] = '.';
	drive [1] = '\0';
		/* First calculate the length of the buffer we need to hold the current working directory. */
	l_nbytes = (GetFullPathNameW (drive, 0, NULL, &subpart) + 1) * sizeof(wchar_t) ;

	if (l_nbytes == 0) {
			/* Failure: we cannot retrieve our current directory. */
		l_nbytes = -1;
	} else {
		if (a_buffer && (a_count >= l_nbytes)) {
			l_nbytes = (GetFullPathNameW (drive, l_nbytes / sizeof(wchar_t), a_buffer, &subpart) + 1) * sizeof(wchar_t);
		}
	}
	return l_nbytes;

#else
	char *cwd;
#ifdef EIF_VMS
	cwd = getcwd (NULL, PATH_MAX, 0);   // force Unix format filespec
	if (cwd == NULL) {
			/* if cwd is not representable in Unix form (if it is a VMS search list) */
	    cwd = getcwd (NULL, PATH_MAX, 1);
	}
#else
	cwd = getcwd (NULL, PATH_MAX);
#endif

	if (cwd) {
		l_nbytes = (strlen(cwd) + 1) * sizeof(char);
		if (a_buffer && (a_count >= l_nbytes)) {
			memcpy (a_buffer, cwd, l_nbytes);
		}
		free(cwd);	/* Not `eif_free', getcwd() call malloc in POSIX.1 */
	} else {
		l_nbytes = -1;
	}

	return l_nbytes;

#endif /* (platform) */
}

rt_public EIF_CHARACTER_8 eif_dir_separator (void)
{
#if defined EIF_WINDOWS
	return '\\';
#elif defined EIF_VMS
	/** return '.'; **/
	/*** This is a gross oversimplification! VMS has multiple path separators, and also allows UNIX paths. ***/
	/* This allows handling like UNIX, until this is replaced with a better abstraction. */
	return '/';
#else
	return '/';
#endif
}

/*
doc:	<routine name="eif_chdir" return_type="EIF_INTEGER" export="public">
doc:		<summary>Set current directory to a given path.</summary>
doc:		<return>Zero on success and non-zero otehrwise.</return>
doc:		<param name="path" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_INTEGER eif_chdir (EIF_FILENAME path)
{
#ifdef EIF_WINDOWS
	return _wchdir (path);
#else
	return chdir (path);
#endif
}

/*
doc:	<routine name="eif_dir_exists" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>Test if the given path represents an existing directory.</summary>
doc:		<return>TRUE or FALSE indicating that the directory exists or not.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_BOOLEAN eif_dir_exists(EIF_FILENAME name)
{
    /* Test whether file exists or not by checking the return from the `rt_stat'
     * system call, hence letting the kernel run all the tests. Return true
     * if the file exists.
     * Stat is called directly, because failure is allowed here obviously.
     * Test to see if it is really a directory and not a plain text file.
     */

	rt_stat_buf buf;            /* Buffer to get file statistics */

		/* Attempt to stat file */
	return (EIF_BOOLEAN) ((!rt_stat (name, &buf) && S_ISDIR(buf.st_mode)) ? '\1' : '\0');
}

/*
doc:	<routine name="eif_dir_is_readable" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>Test if the given path represents a readable directory.</summary>
doc:		<return>TRUE or FALSE indicating that the directory is readable or not.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_BOOLEAN eif_dir_is_readable(EIF_FILENAME name)
{
	/* Is directory readable */
#if defined EIF_VMS
	int result;
	char vms_path [PATH_MAX +1];
	result = access (name, R_OK);
	if (result == -1) 
	    result = access (eifrt_vms_directory_file_name (name, vms_path), R_OK);
	return (EIF_BOOLEAN) (result != -1);

#elif defined EIF_WINDOWS

	return (EIF_BOOLEAN) (_waccess (name, R_OK) != -1);

#else
#ifdef HAS_GETEUID
	int uid, gid;				/* File owner and group */
	int euid, egid;				/* Effective user and group */
#endif

	int mode;					/* Current mode */
	rt_stat_buf buf;            /* Buffer to get file statistics */

	rt_stat (name, &buf);			/* Cannot fail (precondition) */
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

/*
doc:	<routine name="eif_dir_is_writable" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>Test if the given path represents a writable directory.</summary>
doc:		<return>TRUE or FALSE indicating that the directory is writable or not.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/

rt_public EIF_BOOLEAN eif_dir_is_writable(EIF_FILENAME name)
{
	/* Is directory writable */
#ifdef EIF_VMS
	/* n.b. this requires both write and delete access on the directory to be true. */
	int result;
	char vms_path [PATH_MAX +1];
	result = access (name, W_OK);
	if (result == -1)
	    result = access (eifrt_vms_directory_file_name (name, vms_path), W_OK);
	return (EIF_BOOLEAN) (result != -1);

#elif defined EIF_WINDOWS
	return (EIF_BOOLEAN) (_waccess (name, W_OK) != -1);

#else

#ifdef HAS_GETEUID
	int uid, gid;				/* File owner and group */
	int euid, egid;				/* Effective user and group */
#endif

	int mode;					/* Current mode */
	rt_stat_buf buf;            /* Buffer to get file statistics */

	rt_stat (name, &buf);			/* Cannot fail (precondition) */
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

/*
doc:	<routine name="eif_dir_is_executable" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>Test if the given path represents an executable directory.</summary>
doc:		<return>TRUE or FALSE indicating that the directory is executable or not.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_BOOLEAN eif_dir_is_executable(EIF_FILENAME name)
{
	/* Is directory executable */
#ifdef EIF_VMS
	int result;
	char vms_path [PATH_MAX +1];
	result = access (name, X_OK);
	if (result == -1)
	    result = access (eifrt_vms_directory_file_name (name, vms_path), X_OK);
	return (EIF_BOOLEAN) (result != -1);

#elif defined EIF_WINDOWS
	return (EIF_BOOLEAN) (_waccess (name, F_OK) != -1);

#else
#ifdef HAS_GETEUID
	int uid, gid;				/* File owner and group */
	int euid, egid;				/* Effective user and group */
#endif

	int mode;					/* Current mode */
	rt_stat_buf buf;            /* Buffer to get file statistics */

	rt_stat (name, &buf);			/* Cannot fail (precondition) */
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

/*
doc:	<routine name="eif_dir_is_writable" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>Test if the given path represents a deletable directory.</summary>
doc:		<return>TRUE or FALSE indicating that the directory is deletable or not.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_BOOLEAN eif_dir_is_deletable(EIF_FILENAME name)
{
#ifdef EIF_VMS
	return EIF_TRUE;  /* ***VMS FIXME:*** */
#else
    return eif_dir_is_writable (name);
#endif
}

/*
doc:</file>
*/
