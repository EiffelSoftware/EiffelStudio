/*

	Externals for classes PATH_NAME, DIRECTORY_NAME and FILE_NAME,
	platform independent manipulation of path names

*/

#include "config.h"
#include "portable.h"
#include "macros.h"
#include "plug.h"
#ifdef __WINDOWS_386__
#include "eiffel.h"
#include <windows.h>
#endif

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

#ifdef __WINDOWS_386__
EIF_BOOLEAN c_is_file_valid (EIF_POINTER);
EIF_BOOLEAN c_is_directory_name_valid (EIF_POINTER);
EIF_BOOLEAN c_is_volume_name_valid (EIF_POINTER);
#endif

/* Validity */

EIF_BOOLEAN c_is_directory_valid(p)
EIF_POINTER p;
{
		/* Test to see if `p' is a well constructed directory path */
#ifdef __WINDOWS_386__
	char *s, *c;
	int i, len, last_bslash;

	len = strlen (p);
	s = (char *) malloc (len + 1);
	strcpy (s, p);
	c = s + len - 1;
	last_bslash = 0;
	for (i = len;i >= 0; i--, c--)
		if (*c == '\\')
			if (strlen(c+1) && !c_is_directory_name_valid (c+1))
				return FALSE;
			else
				if (last_bslash -1 != i)
					{
					*c = '\0';
					last_bslash = i;
					}
				else
					return FALSE; /* two \ is a row */
		else 
			if (*c == ':')
				/* Form a:xyz\def  or a:\xyz\def */
				if ((strlen (c+1)) && (!c_is_directory_name_valid (c+1)))
					/* Form a:xyz  where xyz is invalid */
					return FALSE;
				else
					/* Form a:\xyz or a: - currently as a:*/
					{
					* (c+1) = '\0';
					return c_is_volume_name_valid (s);
					}
			else
				;
					
	/* 	Did we start with an \ ? If so s is empty other wise it is a relative path */
	if (strlen(s))
		if (c_is_directory_name_valid (s))
			return TRUE;
		else
			return FALSE;	
	else			
		return TRUE;

	/* We don't get here but */
	return FALSE;
#elif defined (__VMS)
	/* first check to see if p includes a ] */
	/* in fact, the last character should be ] */
	if ( p[strlen(p)-1] != ']')		/* end with ] */
		return FALSE;
	if ( strchr( (char *)p,'[') == NULL)	/* has a opening bracket */
		return FALSE;
	if ( strchr( (char *)p,'/') != NULL)	/* no slash allowed */
		return FALSE;
	return TRUE;
#else
	return TRUE;
#endif
}

EIF_BOOLEAN c_is_volume_name_valid (p)
EIF_POINTER p;
{
#ifdef __WINDOWS_386__
	int drive;
		/* Test to see if `p' is a valid volume name */
	if (p)
		if ((strlen (p) == 2) && (*(p+1) == ':'))
			{
			drive = toupper(* (char *) p) - 'A';
			if ((drive >= 0) && (drive <= 26))
				return (GetDriveType (drive) != 0);
			}			
	return FALSE;
#else
	return FALSE;
#endif
}

EIF_BOOLEAN c_is_file_name_valid (p)
EIF_POINTER p;
{
#ifdef __WINDOWS_386__
		/* Test to see if `p' is a valid file name (no directory part) */
	int dot, len, i;
	char * s, valid [] = "_^$~!#%&-{}@'`()";

	if ((p == NULL) || ((len = strlen (p)) == 0) || (len > 12) )
		return FALSE;	

	dot = 0;
	for (i = 0, s = p; i < len; i++, s++)
		if (*s == '.')
			{
			if ((i > 0) && (len - i) <= 4)
				if (dot == 0)
					dot = i;
				else
					return FALSE;
			else
				return FALSE;
			}
		else
			if (!isprint (*s))
				return FALSE;
			else
				if ( (!isalnum (*s)) && (strchr (valid, *s) == 0) )
					return FALSE;

	if ((dot == 0) && (len > 8))
		return FALSE;
				
	return TRUE;
#else
	return TRUE;
#endif
}

EIF_BOOLEAN c_is_extension_valid (p)
EIF_POINTER p;
{
		/* Test to see if `p' is a valid extension */
#ifdef __WINDOWS_386__
	if ((p == NULL) || (strlen(p) > 3) || (strchr (p, '.') != 0) )
		return FALSE;

	return c_is_file_name_valid (p);
#else
	return TRUE;
#endif
}

EIF_BOOLEAN c_is_file_valid (p)
EIF_POINTER p;
{
		/* Test to see if `p' is a well constructed file name (with directory part) */
#ifdef __WINDOWS_386__
	char *s, *c;
	int i, len;

	len = strlen (p);
	s = (char *) malloc (len + 1);
	strcpy (s, p);
	c = s + len -1;
	for (i = len; i >= 0; i --, c--)
		if (*c == '\\')
			{
			*c = '\0';
			break;
			}
	if (!c_is_file_name_valid (c+1))
		return FALSE;
	return c_is_directory_valid (s);
#else
	return TRUE;
#endif
}

EIF_BOOLEAN c_is_directory_name_valid (p)
EIF_POINTER p;
{
		/* Test to see if `p' is a valid directory name (no parent directory part) */
#ifdef __WINDOWS_386__
	return c_is_file_name_valid (p);
#elif defined (__VMS)
	/* For VMS, allow  "subdir" or  "[.subdir]" or "dev:[sub.subdir]" */
	if ( strchr( (char *)p,'[') != NULL) /* if it has a [ ... */
		if ( p[strlen(p)-1] != ']')	/* ... end with ] */
			return FALSE;
	if ( strchr( (char *)p,'/') != NULL)	/* no slash allowed */
		return FALSE;
	return TRUE;
#else
	return TRUE;
#endif
}

/* Concatenation */

void c_append_directory(string, p, v)
EIF_REFERENCE string;
EIF_POINTER p;
EIF_POINTER v;
{
		/* If the path is not empty, include a separator */
		/* Otherwise, it will just be a relative path name */
#ifdef __VMS
	char	vcopy[PATH_MAX];

        /* ASSUMING P & V ARE VALID DIRECTORY & SUBDIR AND IN VMS FORMAT */
	if (p == NULL)	{	/* if p is empty, just return what's in v */
		strcpy(p,v);
		}
        /* allowable forms for v are [.subdir] or subdir */
        /* make [p] look like [p. */
        p[strlen((char *)p)-1]='.'; /* change ] to .*/
        /* make v or [.v] look like v] */
        /* don't mess with v, use a copy */
        strcpy(vcopy,v);
        if (v[0]!='[')  {               /* just looks like v */
                strcat( (char *)vcopy,"]");
                }
        else    {       /* change [.v] to v] */
                strcpy((char *)vcopy,(char *)v[2]);
                }
        /* now concat [p. and v] to get [p.v] */
        strcat( (char *)p, (char *)vcopy);
        (eif_strset)(string, strlen ((char *)p));
#else	/* not vms */
	if (*((char *)p) != '\0')
#ifdef __WINDOWS_386__
		strcat ((char *)p, "\\");
#else
		strcat ((char *)p, "/");
#endif

	strcat ((char *)p, (char *)v);
	(eif_strset)(string, strlen ((char *)p));
#endif
}

void  c_set_directory(string, p, v)
EIF_REFERENCE string;
EIF_POINTER p;
EIF_POINTER v;
{
		/* Set the absolute part of the path name */
#ifdef __VMS
	strcat ((char *)p,"[");
	strcat ((char *)p, (char *)v);
	strcat ((char *)p,"]");
	(eif_strset)(string, strlen ((char *)p));
#else
#ifdef __WINDOWS_386__
	strcat ((char *)p, "\\");
#else
	strcat ((char *)p, "/");
#endif
	strcat ((char *)p, (char *)v);
	(eif_strset)(string, strlen ((char *)p));
#endif
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
#elif !defined (__VMS)		/* no separator for vms */
		strcat ((char *)p, "/");
#endif
		strcat ((char *)p, (char *)v);
	}

	(eif_strset)(string, strlen ((char *)p));
}

EIF_BOOLEAN eif_case_sensitive_path_names()
{
		/* Are path names case sensitive? */
#ifdef __WINDOWS_386__
	return FALSE;
#elif defined (__VMS)
	return FALSE;
#else
	return TRUE;
#endif
}

EIF_REFERENCE eif_current_dir_representation()
{
		/* String representation of Current directory */
#ifdef __VMS
	return RTMS("[]");
#else
	return RTMS(".");
#endif
}

EIF_BOOLEAN eif_home_dir_supported()
{
		/* Is the notion of $HOME supported */
#ifdef __WINDOWS_386__
	return FALSE;
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
#elif defined (__VMS)
	return RTMS(getenv("SYS$LOGIN"));
#else
	return RTMS(getenv("HOME"));
#endif
}

EIF_REFERENCE eif_root_directory_name()
{
		/* String representation of the root directory */
#ifdef __WINDOWS_386__
	return RTMS("\\");
#elif defined (__VMS)
	return RTMS("[000000]");
#else
	return RTMS("/");
#endif
}


