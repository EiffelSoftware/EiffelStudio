/*

	Externals for classes PATH_NAME, DIRECTORY_NAME and FILE_NAME,
	platform independent manipulation of path names

*/

#include "config.h"
#include "portable.h"
#include "macros.h"
#include "plug.h"

#include <sys/types.h>
#include <sys/stat.h>

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#undef FALSE
#define FALSE ((EIF_BOOLEAN) '\0')

#undef TRUE
#define TRUE ((EIF_BOOLEAN) '\01')

/* Validity */

EIF_BOOLEAN c_is_directory_valid(p)
EIF_POINTER p;
{
		/* Test to see if `p' is a well constructed directory path */
	return TRUE;
}

EIF_BOOLEAN c_is_volume_name_valid (p)
EIF_POINTER p;
{
		/* Test to see if `p' is a valid volume name */
	return FALSE;
}

EIF_BOOLEAN c_is_file_name_valid (p)
EIF_POINTER p;
{
		/* Test to see if `p' is a valid file name (no directory part) */
	return TRUE;
}

EIF_BOOLEAN c_is_extension_valid (p)
EIF_POINTER p;
{
		/* Test to see if `p' is a valid extension */
	return TRUE;
}

EIF_BOOLEAN c_is_file_valid (p)
EIF_POINTER p;
{
		/* Test to see if `p' is a well constructed file name (with directory part) */
	return TRUE;
}

EIF_BOOLEAN c_is_directory_name_valid (p)
EIF_POINTER p;
{
		/* Test to see if `p' is a valid directory name (no parent directory part) */
	return TRUE;
}

/* Concatenation */

void c_append_directory(string, p, v)
EIF_REFERENCE string;
EIF_POINTER p;
EIF_POINTER v;
{
		/* If the path is not empty, include a separator */
		/* Otherwise, it will just be a relative path name */
	if (*((char *)p) != '\0')
#ifdef __WINDOWS_386__
		strcat ((char *)p, "\\");
#else
		strcat ((char *)p, "/");
#endif

	strcat ((char *)p, (char *)v);
	(eif_strset)(string, strlen ((char *)p));
}

void  c_set_directory(string, p, v)
EIF_REFERENCE string;
EIF_POINTER p;
EIF_POINTER v;
{
		/* Set the absolute part of the path name */
#ifdef __WINDOWS_386__
	strcat ((char *)p, "\\");
#else
	strcat ((char *)p, "/");
#endif
	strcat ((char *)p, (char *)v);
	(eif_strset)(string, strlen ((char *)p));
}

void  c_append_file_name(string, p, v)
EIF_REFERENCE string;
EIF_POINTER p;
EIF_POINTER v;
{
		/* Append the file name part in the path name */
	if (*((char *)p) == '\0'){
		strcat ((char *)p, (char *)v);
	} else {
#ifdef __WINDOWS_386__
		strcat ((char *)p, "\\");
#else
		strcat ((char *)p, "/");
#endif
		strcat ((char *)p, (char *)v);
	}

	(eif_strset)(string, strlen ((char *)p));
}

EIF_BOOLEAN eif_case_sensitive_path_names()
{
		/* Are path names case sensitive? */
	return TRUE;
}

EIF_REFERENCE eif_current_dir_representation()
{
		/* String representation of Current directory */
	return RTMS(".");
}

EIF_BOOLEAN eif_home_dir_supported()
{
		/* Is the notion of $HOME supported */
#ifdef __WINDOWS_386__
	return FALSE
#else
	return TRUE;
#endif
}

EIF_BOOLEAN eif_root_dir_supported()
{
		/* Is the notion of root directory supported */
	return TRUE;
}

EIF_REFERENCE eif_home_directory_name()
{
		/* String representation of $HOME */
#ifdef __WINDOWS_386__
	return NULL;
#else
	return RTMS(getenv("HOME"));
#endif
}

EIF_REFERENCE eif_root_directory_name()
{
		/* String representation of the root directory */
#ifdef __WINDOWS_386__
	return RTMS("\\");
#else
	return RTMS("/");
#endif
}


