/*

	Externals for classes PATH_NAME, DIRECTORY_NAME and FILE_NAME,
	platform independent manipulation of path names

*/


#include "eif_config.h"
#include "eif_path_name.h"	/* includes eif_portable.h */
#include "eif_project.h"

#ifdef EIF_WINDOWS
#include <windows.h>
#endif

#include <stdlib.h>			/* For getenv */

#include <sys/types.h>
#include <sys/stat.h>

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#include "eif_macros.h"
#include "eif_plug.h"
#include "eif_eiffel.h"			/* For Windows and OS2 */
#include "eif_lmalloc.h"

#ifdef EIF_VMS
#include <lib$routines>
#include <dvidef>
#include <ssdef>
#pragma message disable (NEEDCONSTEXT)	/* skip non-constant address warnings */
#pragma message disable (ADDRCONSTEXT)	/* skip non-constant address warnings */
#define DX_BUF(d,buf) DX d = { sizeof buf, DSC$K_DTYPE_T, DSC$K_CLASS_S, (char*)&buf }
#endif

#if defined EIF_WINDOWS || defined EIF_OS2 || defined EIF_VMSxxx
rt_public EIF_BOOLEAN eif_is_file_valid (EIF_POINTER);
rt_public EIF_BOOLEAN eif_is_directory_name_valid (EIF_POINTER);
rt_public EIF_BOOLEAN eif_is_volume_name_valid (EIF_POINTER);
#endif

/* FIXME: Manu: 09/17/97 There is a need to review all the *_valid function both for UNIX and
 * Windows since there are not working at all
 * For example C:\Dir\\Toto is not a valid directory name but the DOS console does not complain
 * So I don't have the time to do it now, but someone need to do the job soon
 * 
 * Solution: all the *_valid function are returning the UNIX meaning
 *
 */

/* Validity */

rt_public EIF_BOOLEAN eif_is_directory_valid(EIF_POINTER p)
{
		/* Test to see if `p' is a well constructed directory path */
#if defined EIF_WINDOWS || defined EIF_OS2
	char *s, *c;
	int i, len, last_bslash;
	EIF_BOOLEAN result;

	return EIF_TRUE;	/* FIXME: Manu: 09/17/97 Look at the beginning */
	len = strlen (p);
	s = (char *) eif_malloc (len + 1);
	strcpy (s, p);
	c = s + len - 1;
	last_bslash = 0;
	for (i = len;i >= 0; i--, c--)
		if (*c == '\\')
			if (strlen(c+1) && !eif_is_directory_name_valid (c+1)) {
				eif_free(s);
				return EIF_FALSE;
			} else
				if (last_bslash -1 != i) {
					*c = '\0';
					last_bslash = i;
				} else {
					eif_free(s);
					return EIF_FALSE; /* two \ is a row */
				}
		else 
			if (*c == ':')
				/* Form a:xyz\def or a:\xyz\def */
				if ((strlen (c+1)) && (!eif_is_directory_name_valid (c+1))) {
					/* Form a:xyz where xyz is invalid */
					eif_free(s);
					return EIF_FALSE;
				} else {
					/* Form a:\xyz or a: - currently as a:*/
					* (c+1) = '\0';
					result = eif_is_volume_name_valid (s);
					eif_free(s);
					return result;
				}
			else
				;
					
	/* 	Did we start with an \ ? If so s is empty other wise it is a relative path */
	if (strlen(s))
		result = eif_is_directory_name_valid (s);
	else
		result = EIF_TRUE;

	eif_free(s);
	return result;

#elif defined EIF_VMS
	/* first check to see if p includes a ] */
	/* in fact, the last character should be ] */
	if ( p[strlen(p)-1] != ']')		/* end with ] */
		return EIF_FALSE;
	if ( strchr( (char *)p,'[') == NULL)	/* has a opening bracket */
		return EIF_FALSE;
	if ( strchr( (char *)p,'/') != NULL)	/* no slash allowed */
		return EIF_FALSE;
	return EIF_TRUE;

#else  /* must be Unix */
		/* FIXME */
	return EIF_TRUE;
#endif
}

rt_public EIF_BOOLEAN eif_is_volume_name_valid (EIF_POINTER p)
{
#ifdef EIF_WIN32
	char rootpath[4];
		/* Test to see if `p' is a valid volume name */
	if (p)
		if ((strlen (p) == 2) && (*(p+1) == ':'))
			{
			strcpy (rootpath, p);
			rootpath[2] = '\\';
			rootpath [3] = '\0';
			return (EIF_BOOLEAN) (GetDriveType (rootpath) != 1);
			}
	return EIF_FALSE;
#elif defined EIF_OS2
	/* To implement */

#elif defined EIF_VMS
	if (p && *p && p[strlen(p)-1] == ':' ) {
	    /* ***VMS_FIXME*** */
	    long ret;
	    DX_BLD (dev_dx, p, strlen(p));
	    char resbuf[256];	/* this size should be a symbolic somehwere */
	    DX_BLD (res_dx, resbuf, sizeof resbuf);	/* result is zero filled */
	    unsigned short reslen;
	    VMS_STS sts = lib$getdvi (&DVI$_DISPLAY_DEVNAM, 0, &dev_dx, 0, &res_dx, &reslen);
	    if (VMS_SUCCESS(sts) || sts == SS$_NOSUCHDEV)
		return EIF_TRUE;
	}
	return EIF_FALSE;

#else
		/* Unix */
	return (*p == '\0');
#endif
}

rt_public EIF_BOOLEAN eif_is_file_name_valid (EIF_POINTER p)
{
#if defined EIF_WINDOWS || defined EIF_OS2
#define MAX_FILE_LEN 256

		/* Test to see if `p' is a valid file name (no directory part) */
	int len;
	char *s, valid [] = "_^$~!#%&-{}@'`()";

	return EIF_TRUE;	/* FIXME: Manu: 09/17/97 Look at the beginning */

	if ((p == NULL) || ((len = strlen (p)) == 0) || (len > MAX_FILE_LEN) )
		return EIF_FALSE;

	for (s = p; *s; s++)
		if ((*s == '\\') || (*s == '*') || (*s == '?') || (*s == ':')) 
				return EIF_FALSE;
	return EIF_TRUE;

#elif defined EIF_VMS
	/* VMS filenames are of the form [ <name> ] [ . [ <ext> ] ] */
	/* where <name> and <ext> start with an alphabetic and may be followed */
	/* by up to 38 alphanumeric chars. Alphabetic are A-Z, $, _.   */
	/* but we want to allow unix syntax also */

	/* ***VMS_FIXME*** */
	return EIF_TRUE;

#else
		/* Unix implement */
	return EIF_TRUE;
#endif /* platform */
}

rt_public EIF_BOOLEAN eif_is_extension_valid (EIF_POINTER p)
{
	return EIF_TRUE;	/* FIXME: Manu: 09/17/97 Look at the beginning */
		/* Test to see if `p' is a valid extension */
#if defined EIF_WINDOWS || defined EIF_OS2
	if ((p == NULL) || (strlen (p) > 254))
		return EIF_FALSE;

	return eif_is_file_name_valid (p);

#elif defined EIF_VMS
	
	/* ***VMS_FIXME*** */
	return EIF_TRUE;

#else
		/* Unix implement */
	return EIF_TRUE;
#endif
}

rt_public EIF_BOOLEAN eif_is_file_valid (EIF_POINTER p)
{
		/* Test to see if `p' is a well constructed file name (with directory part) */
#if defined EIF_WINDOWS || defined EIF_OS2
	char *s, *c;
	int i, len;

	return EIF_TRUE;	/* FIXME: Manu: 09/17/97 Look at the beginning */

	len = strlen (p);
	s = (char *) eif_malloc (len + 1);
		/* FIXME: memory leak */
	strcpy (s, p);
	c = s + len -1;
	for (i = len; i >= 0; i --, c--)
		if (*c == '\\')
			{
			*c = '\0';
			break;
			}
	if (!eif_is_file_name_valid (c+1))
		return EIF_FALSE;
	return eif_is_directory_valid (s);

#elif defined EIF_VMS
	/* To implement */

	/* ***VMS_FIXME*** */
	return EIF_TRUE;
#else
		/* Unix implement */
	return EIF_TRUE;
#endif
}

rt_public EIF_BOOLEAN eif_is_directory_name_valid (EIF_POINTER p)
{
		/* Test to see if `p' is a valid directory name (no parent directory part) */
#if defined EIF_WINDOWS || defined EIF_OS2
	return eif_is_file_name_valid (p);
#elif defined EIF_VMS
	/* For VMS, allow "subdir" or "[.subdir]" or "dev:[sub.subdir]" */
	if ( strchr( (char *)p,'[') != NULL) /* if it has a [ ... */
		if ( p[strlen(p)-1] != ']')	/* ... end with ] */
			return EIF_FALSE;
	if ( strchr( (char *)p,'/') != NULL)	/* no slash allowed */
		return EIF_FALSE;
	return EIF_TRUE;
#else
		/* Unix implement */
	return EIF_TRUE;
#endif
}

rt_public EIF_BOOLEAN eif_path_name_compare(EIF_POINTER s, EIF_POINTER t, EIF_INTEGER length)
{
		/* Test to see if `s' and `t' represent the same path name */
#if defined EIF_WINDOWS || defined EIF_OS2
	return EIF_TEST(!strnicmp(s, t, length));
#elif defined EIF_VMS
	/** **VMS_FIXME** **VMS** implement this routine for VMS */
	return EIF_TEST (!strncasecmp(s, t, length) );
#else	/* Unix */
	return EIF_TEST(!strncmp(s, t, length));
#endif
}

/* Concatenation */

rt_public void eif_append_directory(EIF_REFERENCE string, EIF_POINTER p, EIF_POINTER v)
{
		/* If the path is not empty, include a separator */
		/* Otherwise, it will just be a relative path name */

#ifdef EIF_VMS
	/* ASSUMING P & V ARE VALID DIRECTORY & SUBDIR AND IN VMS FORMAT */
	/* allowable forms for p are device:[dir]file	*/
	/* allowable forms for v are [.subdir] or subdir */
	/* make p "[x]" look like "[x." if p is not "[x.]" */
	if (*p == '\0') strcpy (p, "[.]");
	if (*((char *)p) != '\0') {
		char *q = p + strlen(p) - 1;	/* q --> last char of p	*/
		char *w = (char*)v;			/* w --> 1st char of v	*/
		/* skip leading delimiters [ or [. in second string */
		if (*w == '[') {			/* if w starts with [	*/
		if (*++w == '.')		/* skip it, check for .	*/
			++w;			/*   skip . also 	*/
		}
		/* check trailing delimiter in first string */
		if (*q == ':') {			/* if a : (device only)	*/
		*++q = '[';			/*   append [ after :	*/
		} else if (*q == ']') {		/* if a ]		*/
		if (*--q != '.')		/* if not .]		*/
			*++q = '.';			/*   make it so		*/
		} else {				/* none (name only)	*/
		*++q = ':'; *++q = '[';		/* append :[		*/
		}
		/* q still --> last char of p  (p + strlen(p) -1)  */
		strcpy (++q, w);			/* append 2nd string (v) */
		/* ensure it has a closing ] */
		if ( *(w = p + strlen(p) - 1) != ']')
		strcat (p, "]");
	} else { /* p is empty string */
		/* what to do with v??? */
		strcpy (p, v);
	}

#else	/* (not) EIF_VMS */
	if (*((char *)p) != '\0')
#if defined EIF_WINDOWS || defined EIF_OS2
		strcat ((char *)p, "\\");
#else	/* Unix */
		strcat ((char *)p, "/");
#endif  /* Windows/Unix */
	strcat ((char *)p, (char *)v);

#endif	/* EIF_VMS */

	(egc_strset)(string, strlen ((char *)p));
}

rt_public void eif_set_directory(EIF_REFERENCE string, EIF_POINTER p, EIF_POINTER v)
{
		/* Set the absolute part of the path name */
#ifdef EIF_VMS
	/* assume *p == '\0' ? */
	*p = '\0';
	strcat (strcat (strcat ((char*)p, "["), (char*)v), "]");
	strcpy (p, v);
#elif defined EIF_WIN32 || defined EIF_OS2
	strcat ((char *)p, (char *)v);
#else	/* Unix */
	if (*((char*)v) != '/' )
		strcat ((char *)p, "/");
	strcat ((char *)p, (char *)v);
#endif
	(egc_strset)(string, strlen ((char *)p));
}

rt_public void eif_append_file_name(EIF_REFERENCE string, EIF_POINTER p, EIF_POINTER v)
{
		/* Append the file name part in the path name */
	if (*((char *)p) == '\0'){
		strcat ((char *)p, (char *)v);
	} else {
#if defined EIF_WINDOWS || defined EIF_OS2
		strcat ((char *)p, "\\");
#elif !defined (EIF_VMS)		/* no separator for vms */
		strcat ((char *)p, "/");
#endif
		strcat ((char *)p, (char *)v);
	}

	(egc_strset)(string, strlen ((char *)p));
}

rt_public EIF_BOOLEAN eif_case_sensitive_path_names(void)
{
		/* Are path names case sensitive? */
#if defined EIF_WINDOWS || defined EIF_OS2
	return EIF_FALSE;
#elif defined (EIF_VMS)
	return EIF_FALSE;
#else
		/* Unix */
	return EIF_TRUE;
#endif
}

rt_public EIF_REFERENCE eif_current_dir_representation(void)
{
		/* String representation of Current directory */
#ifdef EIF_VMS
	return RTMS("[]");
#else
	return RTMS(".");
#endif
}

rt_public EIF_BOOLEAN eif_home_dir_supported(void)
{
		/* Is the notion of $HOME supported */
#ifdef EIF_WIN_31
	return EIF_FALSE;
#else
	return EIF_TRUE;
#endif
}

rt_public EIF_BOOLEAN eif_root_dir_supported(void)
{
		/* Is the notion of root directory supported */
	return EIF_TRUE;
}

rt_public EIF_REFERENCE eif_home_directory_name(void)
{
		/* String representation of $HOME */
#ifdef EIF_WIN_31
	return NULL;
#elif defined (EIF_VMS)
	return RTMS(getenv("SYS$LOGIN"));
#else
	return RTMS(getenv("HOME"));
#endif
}

rt_public EIF_REFERENCE eif_root_directory_name(void)
{
		/* String representation of the root directory */
#if defined EIF_WINDOWS || defined EIF_OS2
	return RTMS("\\");
#elif defined (EIF_VMS)
	return RTMS("[000000]");
#else
	return RTMS("/");
#endif
}

 
/* Routines to split a PATH_NAME in its different parts */
 
rt_public EIF_REFERENCE eif_volume_name(EIF_POINTER p)
{
	/* Returns p's volume name as an EIFFEL string */
 
#if defined EIF_WINDOWS || defined EIF_OS2
	/* To implement */
#elif defined (EIF_VMS)
	/* To implement */
#else
	/* Unix */
	/* To implement */
#endif
	return (EIF_REFERENCE) 0;
}
 
rt_public EIF_REFERENCE eif_extracted_paths(EIF_POINTER p)
{
	/* Returns p's directory components as a manifest array */
 
	EIF_GET_CONTEXT
	EIF_REFERENCE array;
 
	array = emalloc((uint32)eif_typeof_array_of((int16)egc_str_dtype));
	epush(&loc_stack, (char *) (&array));
 
#if defined EIF_WINDOWS || defined EIF_OS2
	/* To implement */
#elif defined (EIF_VMS)
	/* To implement */
#else
	/* Unix */
	/* To implement */
#endif
	return (EIF_REFERENCE) 0;
	EIF_END_GET_CONTEXT
}

