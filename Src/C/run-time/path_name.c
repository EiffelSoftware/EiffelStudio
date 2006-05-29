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

#ifdef EIF_WINDOWS
#include <windows.h>
#include <shlobj.h>
#endif

#include <stdlib.h>			/* For getenv */

#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

#include "rt_macros.h"
#include "eif_plug.h"
#include "eif_eiffel.h"			/* For Windows and OS2 */
#include "rt_lmalloc.h"

#ifdef EIF_VMS
#include "rt_assert.h"
#include <lib$routines>
#include <descrip>
#include <dvidef>
#include <ssdef>	/* SS$_ symbols */
#include <fab>		/* RMS FAB definitions */
#include <nam>		/* RMS NAM (name block) definitions */
#include <starlet>	/* system, rms services - sys$parse et. al. */

/*
doc:	<attribute name="vms_valid_filename_chars" return_type="char []" export="private">
doc:		<summary>VMS filenames or types (.extensions) may contain any of the following.</summary>
doc:		<fixme>This is no longer true, ODS-5 allows more liberal naming. These definitions should be removed, and pathnames should be tested by calling sys$parse.</fixme>
doc:		<access>Read</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since statically initialized.</synchronization>
doc:	</attribute>
*/
rt_private const char vms_valid_filename_chars[] 
	= "$_-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz01234567890";

/*
doc:	<attribute name="vms_path_delimiters" return_type="char []" export="private">
doc:		<summary>VMS characters used for delimiters in filenames. Period is excluded.</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since statically initialized.</synchronization>
doc:	</attribute>
*/
rt_private const char vms_path_delimiters[] = ":[]<>";

/* does path p end in a VMS path delimiter? */
#define IS_VMS_PATH_TERMINATED(p) ( strchr (vms_path_delimiters, (p)[strlen(p) -1]) )

/* Is path p VMS or a UNIX filespec? */
/* NB. these are not complementary; a simple filename with no path delimiters is neither. */
#define IS_VMS_FILESPEC(p)  ( strpbrk ( (char*)(p), vms_path_delimiters) )
#define IS_UNIX_FILESPEC(p) ( strchr  ( (char*)(p), '/') )
#endif /* EIF_VMS */

#if defined EIF_WINDOWS || defined EIF_OS2 || defined EIF_VMS
rt_public EIF_BOOLEAN eif_is_file_valid (EIF_CHARACTER *);
rt_public EIF_BOOLEAN eif_is_directory_name_valid (EIF_CHARACTER *);
rt_public EIF_BOOLEAN eif_is_volume_name_valid (EIF_CHARACTER *);
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

rt_public EIF_BOOLEAN eif_is_directory_valid(EIF_CHARACTER *p)
{
		/* Test to see if `p' is a well constructed directory path */
#if defined EIF_WINDOWS || defined EIF_OS2
	char *s, *c;
	size_t i, len, last_bslash;
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

#elif defined EIF_VMS_TBS
	/* ***VMS_FIXME*** is null path valid? empty path? unix path? */
	/* use sys$parse to check VMS validity, but what about unix validity? */
	/* for now, just skip all of this and return TRUE */
	EIF_BOOLEAN result = EIF_FALSE;

	if (p && *p) {
	    EIF_CHARACTER last = p[strlen((char*)p)-1];
	    /* first check to see if p includes a ] */
	    /* in fact, the last character should be ] */
	    if (last != ']')		/* end with ]; what about > ? */
		    return EIF_FALSE;
	    if ( strchr( (char *)p,'[') == NULL)	/* has a opening bracket */
		    return EIF_FALSE;
	    if ( strchr( (char *)p,'/') != NULL)	/* no slash allowed */
		    return EIF_FALSE;
	    return EIF_TRUE;
	}
	result = EIF_TRUE;
	return result;

#else /* must be Unix */
		/* FIXME */
	return EIF_TRUE;
#endif
}

rt_public EIF_BOOLEAN eif_is_volume_name_valid (EIF_CHARACTER *p)
{
#ifdef EIF_WINDOWS
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
	/* string must end in ":" */
	if (p && *p && p[strlen((char*)p)-1] == ':' ) {
		DX_BLD (dev_dx, p, strlen((char*)p));
		int devsts;
		VMS_STS sts = lib$getdvi (&DVI$_DEVSTS, 0, &dev_dx, &devsts, 0, 0);
		if (VMS_SUCCESS(sts) || sts == SS$_NOSUCHDEV)
		return EIF_TRUE;
	}
	return EIF_FALSE;

#else
		/* Unix */
	return (*p == '\0');
#endif
}

rt_public EIF_BOOLEAN eif_is_file_name_valid (EIF_CHARACTER *p)
{
#if defined EIF_WINDOWS || defined EIF_OS2
#define MAX_FILE_LEN 256

		/* Test to see if `p' is a valid file name (no directory part) */
	size_t len;
	char *s, valid [] = "_^$~!#%&-{}@'`()";

	return EIF_TRUE;	/* FIXME: Manu: 09/17/97 Look at the beginning */

	if ((p == NULL) || ((len = strlen (p)) == 0) || (len > MAX_FILE_LEN) )
		return EIF_FALSE;

	for (s = p; *s; s++)
		if ((*s == '\\') || (*s == '*') || (*s == '?') || (*s == ':')) 
				return EIF_FALSE;
	return EIF_TRUE;

#elif defined EIF_VMS_TBS
	/* VMS filenames are of the form [ <name> ] [ . [ <ext> ] ] */
	/* where <name> and <ext> start with an alphabetic and may be followed */
	/* by up to 38 alphanumeric chars. Alphabetic are [A-Za-z$_-]   */
	/* but since those restrictions may be relaxed (ODS-5), lets ask the system. */
	if (p && *p) {
		/* perform a parse on the name supplied */
		struct FAB fab = cc$rms_fab;
		struct NAM nam = cc$rms_nam;
		VMS_STS sts;
		fab.fab$l_fna = (char*)p; fab.fab$b_fns = strlen((char*)p);
		fab.fab$l_nam = &nam;
		nam.nam$b_nop |= NAM$M_SYNCHK;	/* request syntax check only, no lookup */
		sts = sys$parse (&fab);
		if (VMS_SUCCESS(sts))
		return EIF_TRUE;
	}
	return EIF_FALSE;

#else
		/* Unix implement */
	return EIF_TRUE;
#endif /* platform */
}

rt_public EIF_BOOLEAN eif_is_extension_valid (EIF_CHARACTER *p)
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

rt_public EIF_BOOLEAN eif_is_file_valid (EIF_CHARACTER *p)
{
		/* Test to see if `p' is a well constructed file name (with directory part) */
#if defined EIF_WINDOWS || defined EIF_OS2
	char *s, *c;
	size_t i, len;

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

rt_public EIF_BOOLEAN eif_is_directory_name_valid (EIF_CHARACTER *p)
{
		/* Test to see if `p' is a valid directory name (no parent directory part) */
#if defined EIF_WINDOWS || defined EIF_OS2
	return eif_is_file_name_valid (p);
#elif defined EIF_VMS_V6_ONLY
	/* For VMS, allow "subdir" or "[.subdir]" or "dev:[dir.subdir]" */
	if ( strchr( (char*)p,'[') != NULL)	    /* if it has a [ ... */
		if ( p[strlen((char*)p)-1] != ']')  /* ... end with ] */
			return EIF_FALSE;
	if ( strchr( (char*)p,'/') != NULL)	    /* no slash allowed */
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

rt_public EIF_BOOLEAN eif_path_name_compare(EIF_CHARACTER *s, EIF_CHARACTER *t, EIF_INTEGER length)
{
		/* Test to see if `s' and `t' represent the same path name */
#if defined EIF_WINDOWS || defined EIF_OS2
	return EIF_TEST(!strnicmp(s, t, length));
#elif defined EIF_VMS
	/** **VMS_FIXME** **VMS** implement this routine for VMS */
	return EIF_TEST (!strncasecmp((char*)s, (char*)t, length) );
#else	/* Unix */
	return EIF_TEST(!strncmp((char *) s, (char *) t, length));
#endif
}

/* Concatenation */

rt_public void eif_append_directory(EIF_REFERENCE string, EIF_CHARACTER *p, EIF_CHARACTER *v)
{
#ifdef WORKBENCH
	EIF_GET_CONTEXT
#endif

		/* If the path is not empty, include a separator */
		/* Otherwise, it will just be a relative path name */

#ifdef EIF_VMS
	/*** DEBUG ***/
	char *pu = decc$translate_vms ((char*)p);   /* note: returns in static buffer */
	char *vu = decc$translate_vms ((char*)v);
	/*** END DEBUG ***/
	/* if unix path delimiters in either string use unix syntax, else use VMS syntax. */
	//if ( IS_UNIX_FILESPEC(p) || IS_UNIX_FILESPEC(v) ) {
	if ( !IS_VMS_FILESPEC(p) && !IS_VMS_FILESPEC(v) ) {
	    strcat (strcat ((char*)p, "/"), (char*)v);
	} else if (!*p && !strcspn ((char*)v, vms_valid_filename_chars)) { 
	    /* HACK: if p is empty and v is a simple filename (no .type), force unix syntax */
	    /* This works around the problem of es4 using append_directory ("kernel", "any.e")   */
	    /* when it should be using append_filename() by forcing the relative path to    */
	    /* be unix syntax ("./kernel", "any.e") so that the distinction is nugatory.    */
	    strcat (strcpy ((char*)p, "./"), (char*)v);
	} else {
		/* ASSUMING P & V ARE VALID DIRECTORY & SUBDIR AND IN VMS FORMAT */
		/* allowable forms for p are device:[dir]file	*/
		/* allowable forms for v are [.subdir] or subdir */
		/* make p "[x]" look like "[x." if p is not "[x.]" */
		if (*p == '\0') strcpy ((char*)p, "[.]");
		if (*p != '\0') {
		    /* require: strlen(p) >= 1 */
		    char *q = (char*)p + strlen((char*)p) - 1; 
						/* q -> last char of p	*/
		    char *w = (char*)v;		/* w -> first char of v */
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
		/* q still --> last char of p (p + strlen(p) -1) */
		strcpy (++q, w);		/* append 2nd string (v) */
		/* ensure it has a closing ] */
		if ( *(w = (char*)p + strlen((char*)p) - 1) != ']')
		    strcat ((char*)p, "]");
		} else { /* p is empty string */
		    /* what to do with v??? */
		    strcpy ((char*)p, (char*)v);
		}
	    }

#else	/* (not) EIF_VMS */
	if (*((char *)p) != '\0')
#if defined EIF_WINDOWS || defined EIF_OS2
		strcat ((char *)p, "\\");
#else	/* Unix */
		strcat ((char *)p, "/");
#endif /* Windows/Unix */
	strcat ((char *)p, (char *)v);

#endif	/* EIF_VMS */

	RT_STRING_SET_COUNT(string, strlen((char *) p));
}

rt_public void eif_set_directory(EIF_REFERENCE string, EIF_CHARACTER *p, EIF_CHARACTER *v)
{
#ifdef WORKBENCH
	EIF_GET_CONTEXT
#endif
		/* Set the absolute part of the path name p to directory name v */
#if defined EIF_VMS_V6_ONLY
	/* VMS FIXME: this is not correct - what if path is relative? */
	/* assume *p == '\0' ? */
	*p = '\0';
	strcat (strcat (strcat ((char*)p, "["), (char*)v), "]");
	strcpy (p, v);
#elif defined EIF_VMS
	/* assume *p == '\0' ? */
	if (!IS_VMS_FILESPEC(v) && *p != '\0' && *v != '/')
	    strcat ((char*)p, "/");
	strcat ((char*)p, (char*)v);
#elif defined EIF_WINDOWS || defined EIF_OS2
	strcat ((char *)p, (char *)v);
#else	/* Unix */
	if (*((char*)v) != '/' )
		strcat ((char *)p, "/");
	strcat ((char *)p, (char *)v);
#endif
	RT_STRING_SET_COUNT(string, strlen((char *) p));
}

rt_public void eif_append_file_name(EIF_REFERENCE string, EIF_CHARACTER *p, EIF_CHARACTER *v)
{
#ifdef WORKBENCH
	EIF_GET_CONTEXT
#endif

		/* Append the file name part in the path name */
	if (*((char *)p) == '\0'){
		strcat ((char *)p, (char *)v);
	} else {

#if defined EIF_WINDOWS || defined EIF_OS2
		if (p[strlen(p) - 1] != '\\')
			strcat ((char *)p, "\\");

#elif defined EIF_VMS_V6_ONLY
		/* vms: append unix separator iff no delimiter present */
		if (strchr (vms_valid_filename_chars, p[strlen(p) -1]))
			strcat ((char *)p, "/");

#elif defined EIF_VMS
		/* vms: append unix separator iff no vms-specific delimiter at end of path */
		if (!strchr (vms_path_delimiters, p[strlen((char*)p) -1]))
			strcat ((char *)p, "/");
#else /* Not Windows or VMS: append unix delimiter */
		if (p[strlen((char *) p) - 1] != '/')
			strcat ((char *)p, "/");

#endif
		strcat ((char *)p, (char *)v);
	}

	RT_STRING_SET_COUNT(string, strlen((char *) p));
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

rt_public EIF_REFERENCE eif_home_directory_name(void)
{
		/* String representation of $HOME */
#ifdef EIF_WINDOWS
#if (_WIN32_IE < 0x0500)
#ifndef CSIDL_LOCAL_APPDATA
#define CSIDL_LOCAL_APPDATA             0x001C      // non roaming, user\Local Settings\Application Data
#endif
#ifndef CSIDL_FLAG_CREATE
#define CSIDL_FLAG_CREATE               0x8000      // new for Win2K, or this in to force creation of folder
#endif
#define SHGFP_TYPE_CURRENT				0
#endif


		/* Not All versions of the C compiler supports `SHGetFolderPath' this is why we do a dynamic call. */
	char l_path[MAX_PATH + 1];
	HRESULT hr = S_FALSE;
	FARPROC sh_get_folder_path = NULL;
	HMODULE shell32_module = LoadLibrary ("shell32.dll");

	if (shell32_module) {
		sh_get_folder_path = GetProcAddress (shell32_module, "SHGetFolderPathA");
		if (sh_get_folder_path) {
			hr = (FUNCTION_CAST_TYPE(HRESULT,WINAPI,(HWND, int, HANDLE, DWORD, LPSTR)) sh_get_folder_path) (
				NULL, CSIDL_LOCAL_APPDATA | CSIDL_FLAG_CREATE, NULL, SHGFP_TYPE_CURRENT, l_path);
		}
		FreeLibrary(shell32_module);
	}

	if (hr == S_OK) {
		return RTMS(l_path);
	} else if (getenv ("APPDATA")) {
		return RTMS(getenv("APPDATA"));
	} else {
		return NULL;
	}
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
 
rt_public EIF_REFERENCE eif_volume_name(EIF_CHARACTER *p)
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
 
rt_public EIF_REFERENCE eif_extracted_paths(EIF_CHARACTER *p)
{
	/* Returns p's directory components as a manifest array */
 
	/* To be implementated 
	EIF_REFERENCE array;
 
	array = emalloc((uint32)eif_typeof_array_of((int16)egc_str_dtype));
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


#ifdef EIF_VMS

/* does the path end in a VMS terminator (dev:[dir] or dev:)? Boolean result. */
rt_public int eifrt_vms_has_path_terminator (const char* path)
{
	if (path && *path) {
	if (strchr (vms_path_delimiters, path[strlen(path) -1]))
		return 1;	/* TRUE (VMS delimiter found) */
	}
	return 0;	/* FALSE */
}

/* append a filename to a path (VMS or Unix file specification syntax) */
/* assumes path can accomodate appended name */
rt_public void eifrt_vms_append_file_name (char* path, const char* file)
{
	/* append unix separator iff no vms-specific delimiter at end of path */
	if (eifrt_vms_has_path_terminator (path))
	strcat (path, "/");
	strcat (path, file);
}

/* This is ugly (thread unsafe, too) but there's no other way to return the translated filespec. */
rt_private char stupid_vms_name[FILENAME_MAX +1] = { '\0' };
rt_private int stupid_vms_trick (char *name, int type)
{
	REQUIRE ("`name' is not too big", strlen(name) < sizeof stupid_vms_name);
	strcpy (stupid_vms_name, name);
	return 0;
}

/* convert a file specification to VMS syntax */
rt_public char* eifrt_vms_filespec (const char* filespec, char* buf)
{
	int is_unix = (strchr(filespec, '/') != NULL);	/* if filespec contains a '/' it might be a foreign filespec */
	int res = decc$to_vms (filespec, stupid_vms_trick, 0, 1);
	if (res) strcpy (buf, stupid_vms_name);
	else strcpy (buf, filespec);
	return buf;
}

/* Given a VMS path (directory), return the directory file name (eg. dev:[dir.sub] ==> dev:[dir]sub.dir */
rt_public char* eifrt_vms_directory_file_name (const char* dir, char* buf)
{
	struct FAB fab = cc$rms_fab;
	struct NAM nam = cc$rms_nam;
	char esb[NAM$C_MAXRSS +1], rsb[NAM$C_MAXRSS +1];
	const char* dnm = "[ERROR__DIRECTORY_NOT_SPECIFIED]";
	VMS_STS sts;
	char vms_dir [PATH_MAX +1];

//	if (strchr(dir, '/')) {	    /* if dir contains a '/' it might be a Unix filespec */
		int res = decc$to_vms (dir, stupid_vms_trick, 0, 2);
		if (res) dir = strcpy (vms_dir, stupid_vms_name);
//	}
	/* perform a parse on the name supplied */
	fab.fab$l_dna = (char*)dnm; fab.fab$b_dns = strlen(dnm);
	fab.fab$l_fna = (char*)dir; fab.fab$b_fns = strlen(dir);
	fab.fab$l_nam = &nam;
	nam.nam$l_esa = esb; nam.nam$b_ess = sizeof esb -1;
	nam.nam$l_rsa = rsb; nam.nam$b_rss = sizeof rsb -1;
	/* VMS debug note: use nam.nam$r_nop_overlay. { nam$b_nop | nam$r_nop_bits } to examine. */
	nam.nam$b_nop |= NAM$M_SYNCHK;	/* request syntax check only, no lookup */
	sts = sys$parse (&fab);
	if (VMS_FAILURE(sts)) {
		/* parse failed; ensure expanded and resultant string length is zero */
		nam.nam$b_esl = nam.nam$b_rsl = 0;
	}
	/* if directory present and name, type, and version are missing (just delimiters) */
	if (nam.nam$b_dir && nam.nam$b_name == 0 && nam.nam$b_type <= 1 && nam.nam$b_ver <= 1) {
		char *dirend = nam.nam$l_dir + nam.nam$b_dir -1;	/* points to directory terminator */
		char dirdelim = *dirend;				/* save directory terminator (']' or '>') */
		char *subdir;
		int len;

		REQUIRE ("", nam.nam$l_dir + nam.nam$b_dir == nam.nam$l_name || !nam.nam$l_name);

		/* find the last [sub]directory name (.sub]) and make it the file name .DIR (]sub.DIR) */
		if (*(dirend -1) == '.') --dirend;	/* handle terminal . case ("[dir.]") */
		*dirend = '\0';				/* terminate after directory */
		subdir = strrchr (nam.nam$l_dir, '.');	/* find rightmost '.' in directory */
		if (!subdir) {				/* if no '.' found */
			/* only one (or none) directory name, insert top level directory [000000.<rest>] */
			const char* topdir = "000000.";
			const size_t topdir_len = strlen(topdir);
			len = dirend - nam.nam$l_dir;	/* debug: number of chars to shift */
			memmove (nam.nam$l_dir +1 + topdir_len, nam.nam$l_dir +1, dirend - nam.nam$l_dir);
			strncpy (nam.nam$l_dir +1, topdir, topdir_len);
			subdir = nam.nam$l_dir + topdir_len;
			dirend += topdir_len;
		}
		/* check for "[dir.][sub]" */
		*subdir++ = dirdelim;			/* insert directory delimiter (replace '.') */
		{
			int dbg1 = strcspn (subdir, vms_valid_filename_chars);
			int dbg2 = strspn (subdir, vms_path_delimiters);
		}
		if ( (len=strcspn (subdir, vms_valid_filename_chars)) > 0) {
			int rem = strlen(subdir);	/* debug */
			memmove (subdir, subdir + len, strlen(subdir + len));
			dirend -= len;
		}
		strcpy (dirend, ".DIR");

		/* return result in caller buffer, allocate space if null. */
		CHECK ("", nam.nam$l_node == esb);
		if (!buf) 
			buf = malloc (strlen(esb) +1);
		if (buf)
			strcpy (buf, esb);
		return buf;
	}
	return NULL;
} /* end eifrt_vms_directory_file_name() */

#endif /* EIF_VMS */


/*
doc:</file>
*/
