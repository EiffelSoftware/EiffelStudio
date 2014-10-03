/*
	description: "[
			Externals for classes PATH_NAME, DIRECTORY_NAME and FILE_NAME,
			platform independent manipulation of path names
			]"
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="path_name.c" header="eif_path_name.h" version="$Id$" summary="Externals for PATH_NAME, DIRECTORY_NAME and FILE_NAME. Platform independent manipulation of path names.">
*/

#include "eif_portable.h"
#include "eif_path_name.h"
#include "eif_project.h"
#include "eif_misc.h"	/* for eif_getenv_native() */

#ifdef EIF_WINDOWS
#include <windows.h>
#include <shlobj.h>
#include <wchar.h>
#endif

#include <stdlib.h>			/* For getenv */

#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

#include "rt_macros.h"
#include "eif_plug.h"
#include "eif_eiffel.h"			/* For Windows and OS2 */
#include "rt_lmalloc.h"
#include "rt_assert.h"

#ifdef EIF_VMS
#include <dvidef>
#include <ssdef>	/* SS$_ symbols */
#include <fab>		/* RMS FAB definitions */
#include <nam>		/* RMS NAM (name block) definitions */
#include <starlet>	/* system, rms services - sys$parse et. al. */
#include <lib$routines>
#endif /* EIF_VMS */

/* The following routines are used to call Eiffel routines that expects a `CHARACTER_8 *'
 * by passing a `char *' and avoiding a cast all the time. */
#define rt_is_volume_name_valid(p) eif_is_volume_name_valid((EIF_CHARACTER_8 *) p)
#define rt_is_directory_name_valid(p) eif_is_directory_name_valid((EIF_CHARACTER_8 *) p)
#define rt_is_file_name_valid(p) eif_is_file_name_valid((EIF_CHARACTER_8 *) p)
#define rt_is_directory_valid(p) eif_is_directory_valid((EIF_CHARACTER_8 *) p)

/* FIXME: Manu: 09/17/97 There is a need to review all the *_valid function both for UNIX and
 * Windows since there are not working at all
 * For example C:\Dir\\Toto is not a valid directory name but the DOS console does not complain
 * So I don't have the time to do it now, but someone need to do the job soon
 * 
 * Solution: all the *_valid function are returning the UNIX meaning
 *
 */

/* Validity */

rt_public EIF_BOOLEAN eif_is_directory_valid(EIF_CHARACTER_8 *p)
	/* Test to see if `p' is a well constructed directory path */
{
		/* We do a cast once, so that we can manipulate the Eiffel string
		 * using the C routines. */
	char *l_p = (char *) p;
#if defined EIF_WINDOWS || defined EIF_OS2
	char *s, *c;
	size_t i, len, last_bslash;
	EIF_BOOLEAN result;

	return EIF_TRUE;	/* FIXME: Manu: 09/17/97 Look at the beginning */
	len = strlen (l_p);
	s = (char *) eif_malloc (len + 1);
	strcpy (s, l_p);
	c = s + len - 1;
	last_bslash = 0;
		/* FIXME: Manu: 07/16/2007: this loop will never terminate because i >= 0 is always true. */
	for (i = len;i >= 0; i--, c--)
		if (*c == '\\')
			if (strlen(c+1) && !rt_is_directory_name_valid (c+1)) {
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
				if ((strlen (c+1)) && (!rt_is_directory_name_valid (c+1))) {
					/* Form a:xyz where xyz is invalid */
					eif_free(s);
					return EIF_FALSE;
				} else {
					/* Form a:\xyz or a: - currently as a:*/
					* (c+1) = '\0';
					result = rt_is_volume_name_valid (s);
					eif_free(s);
					return result;
				}
			else
				;
					
	/* 	Did we start with an \ ? If so s is empty other wise it is a relative path */
	if (strlen(s))
		result = rt_is_directory_name_valid (s);
	else
		result = EIF_TRUE;

	eif_free(s);
	return result;

#elif defined EIF_VMS_TBS
	/* ***VMS_FIXME*** is null path valid? empty path? unix path? */
	/* use sys$parse to check VMS validity, but what about unix validity? */
	/* for now, just skip all of this and return TRUE */
	EIF_BOOLEAN result = EIF_FALSE;

	if (l_p && *l_p) {
		EIF_CHARACTER_8 last = l_p[strlen(l_p)-1];
		/* first check to see if l_p includes a ] */
		/* in fact, the last character should be ] */
		if (last != ']')		/* end with ]; what about > ? */
			return EIF_FALSE;
		if ( strchr(l_p,'[') == NULL)	/* has a opening bracket */
			return EIF_FALSE;
		if ( strchr(l_p,'/') != NULL)	/* no slash allowed */
			return EIF_FALSE;
		return EIF_TRUE;
	}
	result = EIF_TRUE;
	return result;

#else /* must be Unix */
		/* FIXME */
	return (l_p ? EIF_TRUE: EIF_FALSE);
#endif
}

rt_public EIF_BOOLEAN eif_is_volume_name_valid (EIF_CHARACTER_8 *p)
{
		/* We do a cast once, so that we can manipulate the Eiffel string
		 * using the C routines. */
	char *l_p = (char *) p;
#ifdef EIF_WINDOWS
	char rootpath[4];
		/* Test to see if `l_p' is a valid volume name */
	if (l_p)
		if ((strlen (l_p) == 2) && (*(l_p+1) == ':'))
			{
			strcpy (rootpath, l_p);
			rootpath[2] = '\\';
			rootpath [3] = '\0';
			return (EIF_BOOLEAN) (GetDriveType (rootpath) != 1);
			}
	return EIF_FALSE;
#elif defined EIF_OS2
	/* To implement */

#elif defined EIF_VMS
	/* string must end in ":" */
	if (l_p && *l_p && l_p[strlen(l_p)-1] == ':' ) {
		DX_BLD (dev_dx, l_p, strlen(l_p));
		int devsts;
		VMS_STS sts = lib$getdvi (&DVI$_DEVSTS, 0, &dev_dx, &devsts, 0, 0);
		if (VMS_SUCCESS(sts) || sts == SS$_NOSUCHDEV)
		return EIF_TRUE;
	}
	return EIF_FALSE;

#else
		/* Unix */
	return (*l_p == '\0');
#endif
}

rt_public EIF_BOOLEAN eif_is_file_name_valid (EIF_CHARACTER_8 *p)
{
		/* We do a cast once, so that we can manipulate the Eiffel string
		 * using the C routines. */
	char *l_p = (char *) p;
#if defined EIF_WINDOWS || defined EIF_OS2
#define MAX_FILE_LEN 256

		/* Test to see if `p' is a valid file name (no directory part) */
	size_t len;
	char *s;

	return EIF_TRUE;	/* FIXME: Manu: 09/17/97 Look at the beginning */

	if ((l_p == NULL) || ((len = strlen (l_p)) == 0) || (len > MAX_FILE_LEN) )
		return EIF_FALSE;

	for (s = l_p; *s; s++)
		if ((*s == '\\') || (*s == '*') || (*s == '?') || (*s == ':')) 
				return EIF_FALSE;
	return EIF_TRUE;

#elif defined EIF_VMS_TBS
	/* VMS filenames are of the form [ <name> ] [ . [ <ext> ] ] */
	/* where <name> and <ext> start with an alphabetic and may be followed */
	/* by up to 38 alphanumeric chars. Alphabetic are [A-Za-z$_-]   */
	/* but since those restrictions may be relaxed (ODS-5), lets ask the system. */
	if (l_p && *l_p) {
		/* perform a parse on the name supplied */
		struct FAB fab = cc$rms_fab;
		struct NAM nam = cc$rms_nam;
		VMS_STS sts;
		fab.fab$l_fna = l_p; fab.fab$b_fns = strlen(l_p);
		fab.fab$l_nam = &nam;
		nam.nam$b_nop |= NAM$M_SYNCHK;	/* request syntax check only, no lookup */
		sts = sys$parse (&fab);
		if (VMS_SUCCESS(sts))
		return EIF_TRUE;
	}
	return EIF_FALSE;

#else
		/* Unix implement */
	return (l_p ? EIF_TRUE : EIF_FALSE);
#endif /* platform */
}

rt_public EIF_BOOLEAN eif_is_extension_valid (EIF_CHARACTER_8 *p)
{
		/* We do a cast once, so that we can manipulate the Eiffel string
		 * using the C routines. */
	char *l_p = (char *) p;

	return EIF_TRUE;	/* FIXME: Manu: 09/17/97 Look at the beginning */
		/* Test to see if `p' is a valid extension */
#if defined EIF_WINDOWS || defined EIF_OS2
	if ((l_p == NULL) || (strlen (l_p) > 254))
		return EIF_FALSE;

	return rt_is_file_name_valid (l_p);

#elif defined EIF_VMS
	
	/* ***VMS_FIXME*** */
	return (l_p ? EIF_TRUE : EIF_FALSE);

#else
		/* Unix implement */
	return (l_p ? EIF_TRUE : EIF_FALSE);
#endif
}

rt_public EIF_BOOLEAN eif_is_file_valid (EIF_CHARACTER_8 *p)
{
		/* Test to see if `p' is a well constructed file name (with directory part) */
#if defined EIF_WINDOWS || defined EIF_OS2
	char *s, *c;
		/* We do a cast once, so that we can manipulate the Eiffel string
		 * using the C routines. */
	char *l_p = (char *) p;
	size_t i, len;

	return (l_p ? EIF_TRUE : EIF_FALSE);	/* FIXME: Manu: 09/17/97 Look at the beginning */

	len = strlen (l_p);
	s = (char *) eif_malloc (len + 1);
		/* FIXME: memory leak */
	strcpy (s, l_p);
	c = s + len -1;
		/* FIXME: Manu: 07/16/2007: this loop will never terminate because i >= 0 is always true. */
	for (i = len; i >= 0; i --, c--)
		if (*c == '\\')
			{
			*c = '\0';
			break;
			}
	if (!rt_is_file_name_valid (c+1))
		return EIF_FALSE;
	return rt_is_directory_valid (s);

#elif defined EIF_VMS
	/* To implement */

	/* ***VMS_FIXME*** */
	return EIF_TRUE;
#else
		/* Unix implement */
	return EIF_TRUE;
#endif
}

rt_public EIF_BOOLEAN eif_is_directory_name_valid (EIF_CHARACTER_8 *p)
{
		/* Test to see if `p' is a valid directory name (no parent directory part) */
#if defined EIF_WINDOWS || defined EIF_OS2
	return eif_is_file_name_valid (p);
#elif defined EIF_VMS_V6_ONLY
		/* We do a cast once, so that we can manipulate the Eiffel string
		 * using the C routines. */
	char *l_p = p;
	/* For VMS, allow "subdir" or "[.subdir]" or "dev:[dir.subdir]" */
	if ( strchr(l_p,'[') != NULL)	    /* if it has a [ ... */
		if ( l_p[strlen(l_p)-1] != ']')  /* ... end with ] */
			return EIF_FALSE;
	if ( strchr(l_p,'/') != NULL)	    /* no slash allowed */
		return EIF_FALSE;
	return EIF_TRUE;
#elif defined EIF_VMS
	/* ***tbs*** VMS implement (call sys$parse) */
	return EIF_TRUE;
#else
		/* Unix implement */
	return EIF_TRUE;
#endif
}

rt_public EIF_BOOLEAN eif_path_name_compare(EIF_CHARACTER_8 *s, EIF_CHARACTER_8 *t, EIF_INTEGER length)
{
		/* Test to see if `s' and `t' represent the same path name */
#if defined EIF_WINDOWS || defined EIF_OS2
	return EIF_TEST(!strnicmp((char *) s, (char *) t, length));
#elif defined EIF_VMS
	/** **VMS_FIXME** **VMS** implement this routine for VMS */
	return EIF_TEST (!strncasecmp((char *) s, (char *) t, length) );
#else	/* Unix */
	return EIF_TEST(!strncmp((char *) s, (char *) t, length));
#endif
}

/* Concatenation */

rt_public void eif_append_directory(EIF_REFERENCE string, EIF_CHARACTER_8 *p, EIF_CHARACTER_8 *v)
{
#ifdef WORKBENCH
	EIF_GET_CONTEXT
#endif

		/* We do a cast once, so that we can manipulate the Eiffel string
		 * using the C routines. */
	char *l_p = (char *) p;
	char *l_v = (char *) v;

		/* If the path is not empty, include a separator */
		/* Otherwise, it will just be a relative path name */

#ifdef EIF_VMS
	/*** DEBUG ***/
	char *pu = decc$translate_vms (l_p);   /* note: returns in static buffer */
	char *vu = decc$translate_vms (l_v);
	/*** END DEBUG ***/
	/* if no vms path delimiters in either string, use unix syntax, else use vms syntax (i.e. default to unix) */
	if ( !eifrt_is_vms_filespec(l_p) && !eifrt_is_vms_filespec(l_v) ) {
	    strcat (strcat (l_p, "/"), l_v);
#ifdef EIF_VMS_V6_ONLY	/* this is nugatory with default to unix */
	} else if (!*l_p && !strcspn (l_v, eifrt_vms_valid_filename_chars)) { 
	    /* HACK: if `l_p' is empty and `l_v' is a simple filename (no .type), force unix syntax */
	    /* This works around the problem of es4 using append_directory ("kernel", "any.e")   */
	    /* when it should be using append_filename() by forcing the relative path to    */
	    /* be unix syntax ("./kernel", "any.e") so that the distinction is nugatory.    */
	    strcat (strcpy (l_p, "./"), l_v);
#endif /* EIF_VMS_V6_ONLY */
	} else {
		/* ASSUMING P & V ARE VALID DIRECTORY & SUBDIR AND IN VMS FORMAT */
		/* allowable forms for `l_p' are device:[dir]file	*/
		/* allowable forms for `l_v' are [.subdir] or subdir */
		/* make `l_p' "[x]" look like "[x." if `l_p' is not "[x.]" */
		if (*l_p == '\0') strcpy (l_p, "[.]");
		if (*l_p != '\0') {
		    /* require: strlen(l_p) >= 1 */
		    char *q = l_p + strlen(l_p) - 1; 
						/* q -> last char of `l_p'	*/
		    char *w = l_v;		/* w -> first char of `l_v' */
		    /* skip leading delimiters [ or [. in second string */
		    if (*w == '[') {		/* if w starts with [	*/
			if (*++w == '.')	/* skip it, check for .	*/
			    ++w;		/* skip . also 	*/
		}
		/* check trailing delimiter in first string */
		if (*q == ':') {		/* if a : (device only)	*/
		    *++q = '[';			/* append [ after :	*/
		} else if (*q == ']') {		/* if a ]		*/
		if (*--q != '.')		/* if not .]		*/
		    *++q = '.';			/* make it so		*/
		} else {			/* none (name only)	*/
		    *++q = ':'; *++q = '[';	/* append :[		*/
		}
		/* q still --> last char of l_p (l_p + strlen(l_p) -1) */
		strcpy (++q, w);		/* append 2nd string (`l_v') */
		/* ensure it has a closing ] */
		if ( *(w = l_p + strlen(l_p) - 1) != ']')
		    strcat (l_p, "]");
		} else { /* l_p is empty string */
		    /* what to do with `l_v'??? */
		    strcpy (l_p, l_v);
		}
	    }

#else	/* (not) EIF_VMS */
	if (*(l_p) != '\0')
#if defined EIF_WINDOWS || defined EIF_OS2
		strcat (l_p, "\\");
#else	/* Unix */
		strcat (l_p, "/");
#endif /* Windows/Unix */
	strcat (l_p, l_v);

#endif	/* EIF_VMS */

#ifdef WORKBENCH
	nstcall = 0;
#endif
	RT_STRING_SET_COUNT(string, strlen(l_p));
}

rt_public void eif_set_directory(EIF_REFERENCE string, EIF_CHARACTER_8 *p, EIF_CHARACTER_8 *v)
{
#ifdef WORKBENCH
	EIF_GET_CONTEXT
#endif
	
		/* We do a cast once, so that we can manipulate the Eiffel string
		 * using the C routines. */
	char *l_p = (char *) p;
	char *l_v = (char *) v;

		/* Set the absolute part of the path name `l_p' to directory name `l_v' */
#if defined EIF_VMS_V6_ONLY
	/* VMS FIXME: this is not correct - what if path is relative? */
	/* assume *l_p == '\0' ? */
	*l_p = '\0';
	strcat (strcat (strcat (l_p, "["), l_v), "]");
	strcpy (l_p, l_v);
#elif defined EIF_VMS
	/* assume *l_p == '\0' ? */
	if (!eifrt_is_vms_filespec(l_v) && *l_p != '\0' && *l_v != '/')
	    strcat (l_p, "/");
	strcat (l_p, l_v);
#elif defined EIF_WINDOWS || defined EIF_OS2
	strcat (l_p, l_v);
#else	/* Unix */
	if (*(l_v) != '/' )
		strcat (l_p, "/");
	strcat (l_p, l_v);
#endif
#ifdef WORKBENCH
	nstcall = 0;
#endif
	RT_STRING_SET_COUNT(string, strlen(l_p));
}

rt_public void eif_append_file_name(EIF_REFERENCE string, EIF_CHARACTER_8 *p, EIF_CHARACTER_8 *v)
{
#ifdef WORKBENCH
	EIF_GET_CONTEXT
#endif
		/* We do a cast once, so that we can manipulate the Eiffel string
		 * using the C routines. */
	char *l_p = (char *) p;
	char *l_v = (char *) v;

		/* Append the file name part in the path name */
	if (*(l_p) == '\0'){
		strcat (l_p, l_v);
	} else {

#if defined EIF_WINDOWS || defined EIF_OS2
		if (l_p[strlen(l_p) - 1] != '\\')
			strcat (l_p, "\\");

#elif defined EIF_VMS_V6_ONLY	/* vms_v6: append unix separator iff no delimiter present */
		if (strchr (vms_valid_filename_chars, l_p[strlen(l_p) -1]))
			strcat (l_p, "/");

#elif defined EIF_VMS	/* vms: append unix separator iff no vms-specific delimiter at end of path */
		char lastc = l_p [strlen(l_p) -1];
		if (lastc != '/' && !strchr (eifrt_vms_path_terminators, lastc))
			strcat (l_p, "/");

#else /* Not Windows or VMS: append unix delimiter */
		if (l_p[strlen(l_p) - 1] != '/')
			strcat (l_p, "/");

#endif
		strcat (l_p, l_v);
	}
#ifdef WORKBENCH
	nstcall = 0;
#endif
	RT_STRING_SET_COUNT(string, strlen(l_p));
}

rt_public EIF_BOOLEAN eif_case_sensitive_path_names(void)
{
		/* Are path names case sensitive? */
#if defined EIF_WINDOWS || defined EIF_OS2 || defined EIF_VMS
	return EIF_FALSE;
#else	/* Unix */
	return EIF_TRUE;
#endif
}

rt_public EIF_REFERENCE eif_current_dir_representation(void)
{
		/* String representation of Current directory */
#ifdef EIF_VMS
	return RTMS("[]");	/* VMS FIXME: perhaps this should be sys$disk:[] */
#else
	return RTMS(".");
#endif
}

rt_public EIF_BOOLEAN eif_home_dir_supported(void)
{
		/* Is the notion of $HOME supported */
	return EIF_TRUE;
}

rt_public EIF_BOOLEAN eif_root_dir_supported(void)
{
		/* Is the notion of root directory supported */
#ifdef EIF_VMS	/* and probably all other non-unix platforms as well */
	return EIF_FALSE;
#else
	return EIF_TRUE;
#endif
}

/*
doc:	<routine name="eif_home_directory_name_ptr" return_type="EIF_INTEGER" export="public">
doc:		<summary>Store the representation of the home directory in `a_buffer' as a null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</summary>
doc:		<return>Size in bytes actually required in `a_buffer' including the terminating null character. If `a_count' is less than the returned value or if `a_buffer' is NULL, nothing is done to `a_buffer'.</return>
doc:		<param name="a_buffer" type="EIF_POINTER">Pointer to a buffer that will hold the current working directory, or NULL if lengþh of buffer is required.</param>
doc:		<param name="a_count" type="EIF_INTEGER">Length of `a_buffer' in bytes.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_INTEGER eif_home_directory_name_ptr(EIF_FILENAME a_buffer, EIF_INTEGER a_count)
{
		/* String representation of $HOME */
#ifdef EIF_WINDOWS
	EIF_INTEGER l_nbytes;
	if (a_buffer && (a_count >= (MAX_PATH * sizeof(wchar_t)))) {
			/* Buffer is large enough for the call to SHGetFolderPathW. */
		if (SHGetFolderPathW (NULL, CSIDL_LOCAL_APPDATA | CSIDL_FLAG_CREATE, NULL, SHGFP_TYPE_CURRENT, a_buffer) == S_OK) {
			return (EIF_INTEGER) ((wcslen(a_buffer) + 1) * sizeof (wchar_t));
		} else {
			wchar_t *l_env_value = _wgetenv (L"APPDATA");
			if (l_env_value) {
				l_nbytes = (EIF_INTEGER) ((wcslen(l_env_value) + 1) * sizeof (wchar_t));
				if (a_count >= l_nbytes) {
					memcpy (a_buffer, l_env_value, l_nbytes);
				} 
				return l_nbytes;
			} else {
				return 0;
			}
		}
	} else {
			/* Buffer is NULL or not large enough we ask for more. */
		return MAX_PATH * sizeof(wchar_t);
	}
#else
	char *l_env_value;
	char l_home [2] = "~";
	EIF_INTEGER l_nbytes;

#if defined EIF_VMS_EIF56
	l_env_value = getenv("SYS$LOGIN");
#elif defined EIF_VMS
	/* Yet another VMS hack: Eiffel 5.7 wants to create a subdirectory named .ec	*/
	/* under the user's home directory ($HOME/.ec) On VMS, this requires the home	*/
	/* directory be on an ODS-5 volume, and an escape character before the		*/
	/* leading "." in the subdirectory name (i.e DEV:[DIR.^.ec] (where SYS$LOGIN	*/
	/* is DEV:[DIR]) Workaround: return the home directory name in UNIX syntax	*/
	/* and rely on the VMS jackets to replace the leading "." with an underscore	*/
	/* if invalid.									*/
	{
		char *p = getenv("SYS$LOGIN");
		char *q = getenv ("HOME");
		char *r = eif_getenv_native ("SYS$LOGIN");
		char *s = eif_getenv_native ("HOME");
		l_env_value = wdecc$translate_vms(eif_getenv_native ("SYS$LOGIN"));
	}
#else
	l_env_value = getenv("HOME");
	if (!l_env_value) {
		l_env_value = l_home;
	}
#endif

	l_nbytes = (strlen(l_env_value) + 1) * sizeof(char);
	if (a_buffer && (a_count >= l_nbytes)) {
		memcpy (a_buffer, l_env_value, l_nbytes);
	}
	return l_nbytes;
#endif
}

/*
doc:	<routine name="eif_user_directory_name_ptr" return_type="EIF_INTEGER" export="public">
doc:		<summary>Store the representation of the user directory in `a_buffer' as a null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</summary>
doc:		<return>Size in bytes actually required in `a_buffer' including the terminating null character. If `a_count' is less than the returned value or if `a_buffer' is NULL, nothing is done to `a_buffer'.</return>
doc:		<param name="a_buffer" type="EIF_POINTER">Pointer to a buffer that will hold the current working directory, or NULL if lengþh of buffer is required.</param>
doc:		<param name="a_count" type="EIF_INTEGER">Length of `a_buffer' in bytes.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_INTEGER eif_user_directory_name_ptr(EIF_FILENAME a_buffer, EIF_INTEGER a_count)
{
#ifdef EIF_WINDOWS
	if (a_buffer && (a_count >= (MAX_PATH * sizeof(wchar_t)))) {
			/* Buffer is large enough for the call to SHGetFolderPathW. */
		if (SHGetSpecialFolderPathW (NULL, a_buffer, CSIDL_PERSONAL, TRUE)) {
			return (EIF_INTEGER) ((wcslen(a_buffer) + 1) * sizeof (wchar_t));
		} else {
			return 0;
		}
	} else {
			/* Buffer is NULL or not large enough we ask for more. */
		return MAX_PATH * sizeof(wchar_t);
	}
#else
	return 0;
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
 
rt_public EIF_REFERENCE eif_volume_name(EIF_CHARACTER_8 *p)
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
 
rt_public EIF_REFERENCE eif_extracted_paths(EIF_CHARACTER_8 *p)
{
	/* Returns p's directory components as a manifest array */
 
	/* To be implementated 
	EIF_REFERENCE array;
 
	array = emalloc(eif_typeof_array_of(egc_str_dtype));
	*/
 
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


/*
doc:</file>
*/
