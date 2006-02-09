/*
	description: "Miscellaneous Eiffel externals."
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
doc:<file name="misc.c" header="eif_misc.h" version="$Id$" summary="Miscellenaous eiffel externals">
*/

#include "eif_portable.h"
#ifdef VXWORKS
#include <envLib.h>
#endif
#ifdef EIF_WINDOWS
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <eif_file.h>
#endif

#include <signal.h>
#include <stdlib.h>
#include <string.h>
#if defined(EIF_SGI) || defined(EIF_SOLARIS)
#include <strings.h>	/* for index and rindex. */
#endif
#include "rt_assert.h"
#include "eif_misc.h"
#include "eif_malloc.h"
#include "rt_lmalloc.h"		/* for eif_malloc() */
#include "rt_macros.h"
#include "rt_dir.h"
#include "rt_threads.h"
#include "rt_struct.h"
#include "x2c.h"

#include <ctype.h>			/* For toupper(), is_alpha(), ... */
#include <stdio.h>

/*
doc:	<routine name="eif_pointer_identity" export="public">
doc:		<summary>Because of a crash of VC6++ when directly assigning a function pointer to an array of function pointer in a loop, we create this identity function that cannot be inlined and thus prevents the bug to occur. As soon as VC6++ is not supported we can get rid of it. Read comments on ROUT_TABLE.generate_loop_initialization for details.</summary>
doc:		<param name="p" type="void *">Pointer to return.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_public void * eif_pointer_identity (void * p)
{
	return p;
}

rt_public EIF_INTEGER bointdiv(EIF_INTEGER n1, EIF_INTEGER n2)
{
	/* Return the greatest integer less or equal to the
	 * integer division of `n1' by `n2'
	 */

	return ((n1 >= 0) ^ (n2 > 0)) ? (n1 % n2 ? n1 / n2 - 1: n1 / n2) : n1 / n2;
}

rt_public EIF_INTEGER upintdiv(EIF_INTEGER n1, EIF_INTEGER n2)
{
	/* Return the smallest integer greater or equal to the
	 * integer division of `n1' by `n2'
	 */

	return ((n1 >= 0) ^ (n2 > 0)) ? n1 / n2: ((n1 % n2) ? n1 / n2 + 1: n1 / n2);
}


/*
 * Protected call to system
 */

rt_public EIF_INTEGER eif_system (char *s)
{
	EIF_INTEGER result;

#ifdef EIF_VMS	/* if s contains any VMS filespec delimiters, prepend 'RUN ' command */
	{ /* if it contains a '[' before a space (ie. no verb), prepend "run " */
		/* ***VMS FIXME*** revisit this for long filenames - may contain space in filename */
		char *p = strchr (s, '[');
		if ( (p) && p < strchr (s, ' ') ) {
			char * run_cmd = eif_malloc (10 + strlen(s));
			if ( (run_cmd) ) {
			strcat (strcpy (run_cmd, "run "), s);
			result = (EIF_INTEGER) system (run_cmd);
			eif_free (run_cmd);
			} else result = -1;
		}
		else result = (EIF_INTEGER) system (s);
	}

#else /* (not) EIF_VMS */
	result = (EIF_INTEGER) system (s);
#endif /* EIF_VMS */

	return result;
}

rt_public void eif_system_asynchronous (char *cmd)
{
	/* Run a command asynchronously, that is to say in background. The command
	 * is identified by the client via a "job number", which is inserted in
	 * the request itself.
	 * The daemon forks a copy of itself which will be in charge of running
	 * the command and sending the acknowledgment back, tagged with the command
	 * number.
	 */

#ifdef EIF_WINDOWS
	STARTUPINFO				siStartInfo;
	PROCESS_INFORMATION		procinfo;
	char 					*current_dir;
	EIF_INTEGER result;
#else
	int status;			/* Command status, as returned by system() */
	char *meltpath, *appname, *envstring;	/* set MELT_PATH */
#endif

#ifdef EIF_WINDOWS
	current_dir = (char *) getcwd(NULL, PATH_MAX);

	memset (&siStartInfo, 0, sizeof(STARTUPINFO));
	siStartInfo.cb = sizeof(STARTUPINFO);
	siStartInfo.lpTitle = NULL;
	siStartInfo.lpReserved = NULL;
	siStartInfo.lpReserved2 = NULL;
	siStartInfo.cbReserved2 = 0;
	siStartInfo.lpDesktop = NULL;
	siStartInfo.dwFlags = STARTF_FORCEONFEEDBACK;

		/* We do not used DETACHED_PROCESS below because it won't work when
		 * launching interactive console application such as `cmd.exe'. */
	result = CreateProcess (
		NULL,
		cmd,
		NULL,
		NULL,
		TRUE,
		CREATE_NEW_CONSOLE,
		NULL,
		current_dir,
		&siStartInfo,
		&procinfo);
	if (result) {
		CloseHandle (procinfo.hProcess);
		CloseHandle (procinfo.hThread);
	}
	chdir(current_dir);
	free(current_dir);

#else

#if !defined(EIF_VMS) && !defined(VXWORKS)	/* VMS needs a higher level abstraction for async system() */
	switch (fork()) {
	case -1:				/* Cannot fork */
		return;
	case 0:					/* Child is performing the command */
		break;
	default:
		return;				/* Parent returns immediately */
	}
#endif /* not VMS (skip fork/parent code if VMS) */

/* child (except on VMS, where this code runs in the parent) */
	meltpath = (char *) malloc (strlen(cmd) + 1);
	meltpath = strcpy (meltpath, cmd);
	if (!meltpath)
		return;

#ifdef EIF_VMS_V6_ONLY
	appname = rindex (meltpath, ']');
	if (appname)
		*appname = 0;
	else
		strcpy (meltpath, "[]");
#elif defined EIF_VMS
	{
	    size_t siz = eifrt_vms_dirname_len (meltpath);
	    if (siz)
		meltpath[siz] = '\0';
	    else
		strcpy (meltpath, "[]");
	}
#else
	appname = rindex (meltpath, '/');
	if (appname)
		*appname = 0;
	else
		strcpy (meltpath, ".");
#endif
	envstring = (char *)malloc (strlen (meltpath)
		+ strlen ("MELT_PATH=") + 1);
	if (!envstring)
		return;
	sprintf (envstring, "MELT_PATH=%s", meltpath);
	putenv (envstring);

#ifndef EIF_VMS
	status = system(cmd);				/* Run command via /bin/sh */
#else	/* VMS */
	status = eifrt_vms_spawn(cmd, 1);
#endif	/* EIF_VMS */

#ifdef EIF_VMS
	if (status) {	/* command failed */
		const char *pgmname = eifrt_vms_get_progname (NULL,0);
		fprintf (stderr, "%s: %s: \n-- error from system() call: %d\n"
			"-- failed cmd: \"%s\" -- %s\n", 
			pgmname, __FILE__, errno, cmd, strerror(errno));
	}
	return;		/* skip send ack packet, Fred says not done anymore */
#else /* not VMS */

#ifdef VXWORKS
	exit(0);
#else
	_exit(0);							/* Child is exiting properly */
#endif
#endif /* EIF_VMS */
#endif /* EIF_WINDOWS */
	/* NOTREACHED */

}

rt_public char * eif_getenv (char * k)
{
#ifdef EIF_WINDOWS
	char *result = getenv (k);

	if (result)
		return result;
	else {
		char *key, *lower_k; /* %%ss removed *value */
		size_t appl_len, key_len;
		HKEY hkey;
		DWORD bsize = 1024;
		static unsigned char buf[1024];
	
		appl_len = strlen (egc_system_name);
		key_len = strlen (k);
		if ((key = (char *) eif_calloc (appl_len + 46 +key_len, 1)) == NULL)
			return result;
	
		if ((lower_k = (char *) eif_calloc (key_len+1, 1)) == NULL) {
			eif_free (key);
			return result;
		}
	
		strcpy (lower_k, k);
		CHECK("Not too big", key_len <= 0xFFFFFFFF);
		CharLowerBuff (lower_k, (DWORD) key_len);
	
		strcpy (key, "Software\\ISE\\Eiffel57\\");
		strncat (key, egc_system_name, appl_len);
	
		if (RegOpenKeyEx (HKEY_CURRENT_USER, key, 0, KEY_READ, &hkey) != ERROR_SUCCESS) {
			if (RegOpenKeyEx (HKEY_LOCAL_MACHINE, key, 0, KEY_READ, &hkey) != ERROR_SUCCESS) {
				eif_free (key);
				eif_free (lower_k);
				return result;
			}
			if (RegQueryValueEx (hkey, lower_k, NULL, NULL, buf, &bsize) != ERROR_SUCCESS) {
				eif_free (key);
				eif_free (lower_k);
				RegCloseKey (hkey);
				return result;
			}
		} else {
			if (RegQueryValueEx (hkey, lower_k, NULL, NULL, buf, &bsize) != ERROR_SUCCESS) {
					/* Could not read from HKCU entry, so let's close it before opening
					 * the one possibly in HKLM */
				RegCloseKey(hkey);
				if (RegOpenKeyEx (HKEY_LOCAL_MACHINE, key, 0, KEY_READ, &hkey) != ERROR_SUCCESS) {
					eif_free (key);
					eif_free (lower_k);
					return result;
				}
				if (RegQueryValueEx (hkey, lower_k, NULL, NULL, buf, &bsize) != ERROR_SUCCESS) {
					eif_free (key);
					eif_free (lower_k);
					RegCloseKey (hkey);
					return result;
				}
			}
		}

		eif_free (key);
		eif_free (lower_k);
		RegCloseKey (hkey);
		return (char *) buf;
	}
#else
	return (char *) getenv (k);
#endif
}

/***************************************/

rt_public EIF_REFERENCE arycpy(EIF_REFERENCE area, EIF_INTEGER i, EIF_INTEGER j, EIF_INTEGER k)
{
	/* Reallocation of memory for an array's `area' for new count `i', keeping
	 * the old content.(starts at `j' and is `k' long).
	 */

	char *new_area, *ref;
	long elem_size;			/* Size of each item within area */
	long old_count;
	uint32 exp_dftype;		/* Full dynamic type of the first expanded object */
	int n;					/* Counter for initialization of expanded */

	REQUIRE ("Must be special", HEADER (area)->ov_flags & EO_SPEC);
	REQUIRE ("Must not be TUPLE", !(HEADER (area)->ov_flags & EO_TUPLE));
 
	ref = RT_SPECIAL_INFO(area);
	old_count = RT_SPECIAL_COUNT_WITH_INFO(ref);
	elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(ref);

#ifdef ARYCPY_DEBUG
	printf ("ARYCPY: area 0x%x, new count %d, old count %d, start %d and %d long\n", area, i, *(long*) ref, j, k);
#endif	/* ARYCPY_DEBUG */

	/* Possible optimization: remembering process for special objects full of
	 * references can be discarded in this call to `sprealloc', since
	 * we will change the order of the indices. */

	new_area = sprealloc(area, i);		/* Reallocation of special object */
							

	/* Move old contents to the right position and fill in empty parts with
	 * zeros.
	 */
	if ((j == 0) && (old_count == k))	/* Is this the usual case. */
		return new_area;		/* All have been done in sprealloc () . */

	/* Otherwise, in some rare cases, we may change the 
	 * order of the items in the array. 
	 */

	memmove(new_area + j * elem_size, new_area, k * elem_size); /* takes care of overlaping */
	memset (new_area, 0, j * elem_size);		/* Fill empty parts of area with 0 */
	memset (new_area + (j + k) * elem_size, 0, (i - j - k) * elem_size);

	/* If the new area is full of references and remembered,
	 * the information in the special table
	 * may be completely obsolete. Thus, we remove its entry 
	 * and relaunch the remembering process. */

	CHECK ("Must be special", HEADER (new_area)->ov_flags & EO_SPEC);
	REQUIRE ("Must not be TUPLE", !(HEADER (new_area)->ov_flags & EO_TUPLE));

	if (!(HEADER(new_area)->ov_flags & EO_COMP))
		return new_area;				/* No expanded objects */

	/* If there are some expanded objects, then we must initialize them by
	 * calling the initialization routine (which will set up intra references).
	 * The dynamic type of all the expanded object is the same, so we only
	 * compute the one of the first element. Note that the Dtype() macro needs
	 * a pointer to the object and not to the zone, hence the shifting by
	 * OVERHEAD bytes in the computation of 'dtype'--RAM.
	 */

	exp_dftype = eif_gen_param_id (-1, (int16) Dftype(new_area), 1);

		/* Initialize expanded objects from 0 to (j - 1) */
	new_area = sp_init(new_area, exp_dftype, 0, j - 1);

#ifndef WORKBENCH
	if (References(Deif_bid(exp_dftype)) > 0) {
#endif
		/* If there is a header for each expanded in the special, then update expanded
		 * offsets for k objects starting at j. */
	for (
		n = j + k - 1, ref = new_area + (n * elem_size);
		n >= j;
		n--, ref -= elem_size)
	{
		CHECK("size nonnegative", (ref - new_area + OVERHEAD) >= 0);
		CHECK("valid size", (ref - new_area + OVERHEAD) <= B_SIZE);
		((union overhead *) ref)->ov_size = (uint32) (ref - new_area + OVERHEAD);
	}
#ifndef WORKBENCH
	}
#endif
	
		/* Intialize remaining objects from (j + k) to (i - 1) */
	new_area = sp_init(new_area, exp_dftype, j + k, i - 1);

	return new_area;
}



#ifdef EIF_WINDOWS

/* DLL declarations */

#define EIF_DLL_CHUNK 20

struct eif_dll_info {
	char *dll_name;
	HANDLE dll_module_ptr;
};

/*
doc:	<attribute name="eif_dll_table" return_type="struct eif_dll_info *" export="private">
doc:		<summary>Hold all shared libraries that have been already loaded. Used for `DLL' C externals.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>We simply need a mutex to protect update access.</fixme>
doc:	</attribute>
*/
rt_private struct eif_dll_info *eif_dll_table = (struct eif_dll_info *) 0;

/*
doc:	<attribute name="eif_dll_capacity" return_type="int" export="private">
doc:		<summary>Capacity of `eif_dll_table'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>We simply need a mutex to protect update access.</fixme>
doc:	</attribute>
*/
rt_private int eif_dll_capacity = EIF_DLL_CHUNK;

/*
doc:	<attribute name="eif_dll_count" return_type="int" export="private">
doc:		<summary>Count of `eif_dll_table'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>We simply need a mutex to protect update access.</fixme>
doc:	</attribute>
*/
rt_private int eif_dll_count = 0;

rt_public HMODULE eif_load_dll(char *module_name)
{
	HMODULE a_result;
	char *m_name;
	int i;

	if (eif_dll_table == (struct eif_dll_info *) 0) {
		eif_dll_table = eif_malloc(sizeof(struct eif_dll_info) * eif_dll_capacity);
		if (eif_dll_table == (struct eif_dll_info *) 0)
			enomem(MTC_NOARG);
	}

	for (i=0; i < eif_dll_count; i++) {
			/* Case insensitive comparison */
		if (strcmpi(eif_dll_table[i].dll_name, module_name) == 0)
			return eif_dll_table[i].dll_module_ptr;
	}

	if (eif_dll_count == eif_dll_capacity) {
		eif_dll_capacity += EIF_DLL_CHUNK;
		eif_dll_table = eif_realloc(eif_dll_table, sizeof(struct eif_dll_info) * eif_dll_capacity);

		if (eif_dll_table == (struct eif_dll_info *) 0)
			enomem(MTC_NOARG);
	}

	if ((m_name = (char *) eif_malloc(strlen(module_name)+1)) == (char *) 0)
		enomem(MTC_NOARG);
	strcpy (m_name, module_name);

	a_result = LoadLibrary(module_name);

	eif_dll_table[eif_dll_count].dll_name = m_name;
	eif_dll_table[eif_dll_count].dll_module_ptr = a_result;

	eif_dll_count++;

	return a_result;
}

rt_public void eif_free_dlls(void)
{
	int i;
	HINSTANCE module_ptr;

	if (eif_dll_table) {
		for (i=0; i< eif_dll_count; i++) {
			eif_free(eif_dll_table[i].dll_name);

			module_ptr = eif_dll_table[i].dll_module_ptr;
			if (module_ptr != NULL)
				(void) FreeLibrary(module_ptr);
		}
		eif_free(eif_dll_table);
	}
}

#endif /* EIF_WINDOWS */

#ifndef EIF_WINDOWS
rt_public pid_t eiffel_fork(void) {
#ifdef VXWORKS
	return 0;
#elif defined (EIF_THREADS)
	return eif_thread_fork();
#else
	return fork();
#endif
}
#endif

/*
doc:</file>
*/
