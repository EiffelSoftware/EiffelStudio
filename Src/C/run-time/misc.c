/*
	description: "Miscellaneous Eiffel externals."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2012, Eiffel Software."
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
doc:<file name="misc.c" header="eif_misc.h" version="$Id$" summary="Miscellenaous eiffel externals">
*/

#include "eif_portable.h"
#ifdef VXWORKS
#include <sysLib.h>
#include <taskLib.h>        /* 'thread' operations */
#include <taskVarLib.h>     /* 'thread' 'specific data' */
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
#include "rt_assert.h"
#include "eif_misc.h"
#include "eif_malloc.h"
#include "rt_lmalloc.h"		/* for eif_malloc() */
#include "rt_macros.h"
#include "rt_dir.h"
#include "rt_threads.h"
#include "rt_struct.h"
#include "rt_gen_types.h"
#include "eif_size.h"

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
doc:	<routine name="init_scp_manager" export="public">
doc:		<summary>Initialize ISE_SCOOP_MANAGER if available.</summary>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_public void init_scp_manager (void)
	/* Initialize ISE_SCOOP_MANAGER
	 */
{
	if (egc_init_scoop_manager != NULL)
	{
	EIF_INTEGER pf_status = egc_prof_enabled;
	EIF_BOOLEAN tr_status = eif_is_tracing_enabled();
	
		/* No need to create the global instance, when it has already been created by one thread. */
	scp_mnger = RTLNSMART(egc_scp_mngr_dtype);

#ifndef ENABLE_STEP_THROUGH
	DISCARD_BREAKPOINTS; /* prevent the debugger from stopping in the following functions */
#endif
	eif_disable_tracing(); /* Disable tracing to not clobber the output. */
	egc_prof_enabled = 0; /* Disable profiling to be safe. */
	(egc_init_scoop_manager)(scp_mnger);
	egc_prof_enabled = pf_status; /* Resume profiling status. */
	if (!tr_status) {
			/* Resume tracing if it was previously enabled. */
		eif_enable_tracing();
	}
#ifndef ENABLE_STEP_THROUGH
	UNDISCARD_BREAKPOINTS; /* prevent the debugger from stopping in the following functions */
#endif
	}
}

/*
doc:	<routine name="eif_sleep" export="public">
doc:		<summary>Suspend execution of current thread by interval `nanoseconds'. It uses the most precise sleep function available for a given platform.</summary>
doc:		<param name="nanoseconds" type="EIF_INTEGER_64">Number of nanoseconds to sleep.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_public void eif_sleep(EIF_INTEGER_64 nanoseconds)
{
	/*
	 * Suspend thread execution for interval specified by `nanoseconds'.
	 * Use the most precise sleep function if possible.
	 */

#ifdef VXWORKS
	int n = (int) (((EIF_NATURAL_64) nanoseconds * (EIF_NATURAL_64) sysClkRateGet())/1000000000);
	taskDelay(n);
#else
#ifdef HAS_NANOSLEEP
	struct timespec req;
	struct timespec rem;
	req.tv_sec = nanoseconds / 1000000000;
	req.tv_nsec = nanoseconds % 1000000000;
	while ((nanosleep (&req, &rem) == -1) && (errno == EINTR)) {
			/* Function is interrupted by a signal.   */
			/* Let's call it again to complete pause. */
		req = rem;
	}
#else
#	ifdef HAS_USLEEP
#		define EIF_SLEEP_PRECISION 1000
#		define EIF_SLEEP_TYPE      unsigned long
#		define EIF_SLEEP_FUNCTION  usleep
#	elif defined EIF_WINDOWS
#		define EIF_SLEEP_PRECISION 1000000
#		define EIF_SLEEP_TYPE      DWORD
#		define EIF_SLEEP_FUNCTION  Sleep
#	else
#		define EIF_SLEEP_PRECISION 1000000000
#		define EIF_SLEEP_TYPE      unsigned int
#		define EIF_SLEEP_FUNCTION  sleep
#	endif
		/* Set total delay time */
	if (nanoseconds > 1)
	{
		EIF_INTEGER_64 total_time = nanoseconds / EIF_SLEEP_PRECISION;
			/* Set maximum timeout that can be handled by one API call */
		EIF_SLEEP_TYPE timeout = ~((~ (EIF_SLEEP_TYPE) 0) << (sizeof timeout * 8 - 1));
		if ((nanoseconds % EIF_SLEEP_PRECISION) > 0) {
				/* Increase delay to handle underflow */
			total_time++;
		}
		while (total_time > 0) {
				/* Sleep for maximum timeout not exceeding time left */
			if (timeout > total_time) {
				timeout = (EIF_SLEEP_TYPE) total_time;
			}
			EIF_SLEEP_FUNCTION (timeout);
			total_time -= timeout;
		}
	}
	else
	{
		EIF_SLEEP_FUNCTION ((EIF_SLEEP_TYPE) nanoseconds);
	}
#  undef EIF_SLEEP_PRECISION
#  undef EIF_SLEEP_TYPE
#  undef EIF_SLEEP_FUNCTION
#endif
#endif
}

/*
 * Protected call to system
 */

/*
doc:	<routine name="eif_system" return_type="EIF_INTEGER" export="public">
doc:		<summary>Execute a command using system shell.</>
doc:		<param name="s" type="EIF_NATIVE_CHAR *">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<return>0 if it succeeds, -1 otherwise. Upon failure `errno' is set with the reason code.</return>
doc:		<thread_safety>Re-entrant</thread_safety>
doc:	</routine>
*/
rt_public EIF_INTEGER eif_system (EIF_NATIVE_CHAR *s)
{
	EIF_INTEGER result;

#ifdef EIF_VMS_V6_ONLY	
	/* if s contains any VMS filespec delimiters, prepend 'RUN ' command */
	{ /* if it contains a '[' before a space (ie. no verb), prepend "run " */
		/* ***VMS FIXME*** revisit this for long filenames - may contain space in filename */
		char *p = strchr (s, '[');
		if ( (p) && p < strchr (s, ' ') ) {
			char * run_cmd = eif_malloc (10 + strlen(s));
			if ( (run_cmd) ) {
				strcat (strcpy (run_cmd, "run "), s);
				result = (EIF_INTEGER) system (run_cmd);
				eif_free (run_cmd);
			}
			else result = -1;
		}
		else result = (EIF_INTEGER) system (s);
	}

#elif defined EIF_VMS
	result = eifrt_vms_spawn (s, EIFRT_VMS_SPAWN_FLAG_TRANSLATE);	    /* synchronous spawn */

#elif defined EIF_WINDOWS
	result = (EIF_INTEGER) _wsystem (s);
#else
	result = (EIF_INTEGER) system (s);
#endif

	return result;
}

/*
doc:	<routine name="eif_system_asynchronous" return_type="void" export="public">
doc:		<summary>Execute a command using system shell.</>
doc:		<param name="cmd" type="EIF_NATIVE_CHAR *">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:	</routine>
*/
rt_public void eif_system_asynchronous (EIF_NATIVE_CHAR *cmd)
{
	/* Run a command asynchronously, that is to say in background. The command
	 * is identified by the client via a "job number", which is inserted in
	 * the request itself.
	 * The daemon forks a copy of itself which will be in charge of running
	 * the command and sending the acknowledgment back, tagged with the command
	 * number.
	 */

#ifdef EIF_WINDOWS
	STARTUPINFOW			siStartInfo;
	PROCESS_INFORMATION		procinfo;
	wchar_t					*current_dir;
	EIF_INTEGER result;
#else
	int status;			/* Command status, as returned by system() */
	char *meltpath, *appname, *envstring;	/* set MELT_PATH */
#endif

#ifdef EIF_WINDOWS
	current_dir = (wchar_t *) _wgetcwd(NULL, PATH_MAX);

	memset (&siStartInfo, 0, sizeof siStartInfo);
	siStartInfo.cb = sizeof(STARTUPINFO);
	siStartInfo.lpTitle = NULL;
	siStartInfo.lpReserved = NULL;
	siStartInfo.lpReserved2 = NULL;
	siStartInfo.cbReserved2 = 0;
	siStartInfo.lpDesktop = NULL;
	siStartInfo.dwFlags = STARTF_FORCEONFEEDBACK;

		/* We do not used DETACHED_PROCESS below because it won't work when
		 * launching interactive console application such as `cmd.exe'. */
	result = CreateProcessW (
		NULL,
		cmd,
		NULL,
		NULL,
		FALSE,
		CREATE_NEW_CONSOLE,
		NULL,
		current_dir,
		&siStartInfo,
		&procinfo);
	if (result) {
		CloseHandle (procinfo.hProcess);
		CloseHandle (procinfo.hThread);
	}
	_wchdir(current_dir);
	free(current_dir);
#else /* (not) EIF_WINDOWS */

#if !defined(EIF_VMS) && !defined(VXWORKS)	/* VMS needs a higher level abstraction for async system() */
	switch (fork()) {
	case -1:				/* Cannot fork */
		return;
	case 0:					/* Child is performing the command */
		break;
	default:
		return;				/* Parent returns immediately */
	}
#endif /* not VMS/VXWORKS (skips fork/parent code if VMS/VXWORKS) */

/* child (except on VMS, where this code runs in the parent) */
	meltpath = (char *) malloc (strlen(cmd) + 1);
	meltpath = strcpy (meltpath, cmd);
	if (!meltpath)
		return;

#ifdef EIF_VMS_V6_ONLY
	appname = strrchr (meltpath, ']');
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
	appname = strrchr (meltpath, '/');
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

#ifdef EIF_VMS
	status = eifrt_vms_spawn (cmd, EIFRT_VMS_SPAWN_FLAG_ASYNC);
	//??? putenv ("MELT_PATH=");
	//??? free (meltpath); meltpath = NULL;
	//??? free (envstring); envstring = NULL;
	if (status) {	/* command failed */
		const char *pgmname = eifrt_vms_get_progname (NULL,0);
		fprintf (stderr, "%s: %s: \n-- error from system() call: %d\n"
			"-- failed cmd: \"%s\" -- %s\n", 
			pgmname, __FILE__, errno, cmd, strerror(errno));
	}
	return;		/* skip send ack packet, Fred says not done anymore */

#else	/* (not) VMS */
	status = system(cmd);				/* Run command via /bin/sh */

#ifdef VXWORKS
	exit(0);
#else
	_exit(0);							/* Child is exiting properly */
#endif
#endif /* EIF_VMS */
#endif /* EIF_WINDOWS */
	/* NOTREACHED */

}

extern union overhead *eif_header (EIF_REFERENCE);
rt_shared union overhead * eif_header (EIF_REFERENCE object) {
	REQUIRE("object not null", object);

	return HEADER(object);
}
/***************************************/

rt_public EIF_REFERENCE arycpy(EIF_REFERENCE area, EIF_INTEGER i, EIF_INTEGER k)
{
	/* Reallocation of memory for an array's `area' for new count `i', keeping
	 * the old content.(starts at 0 and is `k' long).
	 */

	char *new_area, *ref;
	rt_uint_ptr elem_size;			/* Size of each item within area */
	EIF_INTEGER old_count;
	EIF_TYPE_INDEX exp_dftype;		/* Full dynamic type of the first expanded object */
	EIF_INTEGER n;					/* Counter for initialization of expanded */

	REQUIRE ("Must be special", HEADER (area)->ov_flags & EO_SPEC);
	REQUIRE ("Must not be TUPLE", !(HEADER (area)->ov_flags & EO_TUPLE));
 
	old_count = RT_SPECIAL_COUNT(area);
	elem_size = RT_SPECIAL_ELEM_SIZE(area);

#ifdef ARYCPY_DEBUG
	printf ("ARYCPY: area 0x%x, new count %d, old count %d, start %d and %d long\n", area, i, old_count, k);
#endif	/* ARYCPY_DEBUG */

	/* Possible optimization: remembering process for special objects full of
	 * references can be discarded in this call to `sprealloc', since
	 * we will change the order of the indices. */

	new_area = sprealloc(area, i);		/* Reallocation of special object */

		/* Move old contents to the right position and fill in empty parts with
		 * zeros. */
	if (old_count == k)	/* Is this the usual case. */
		return new_area;		/* All have been done in sprealloc () . */

	/* If the new area is full of references and remembered,
	 * the information in the special table
	 * may be completely obsolete. Thus, we remove its entry 
	 * and relaunch the remembering process. */

	CHECK ("Must be special", HEADER (new_area)->ov_flags & EO_SPEC);
	CHECK ("Must not be TUPLE", !(HEADER (new_area)->ov_flags & EO_TUPLE));
	CHECK ("Proper size", i == RT_SPECIAL_COUNT(new_area));

	if (!(HEADER(new_area)->ov_flags & EO_COMP))
		return new_area;				/* No expanded objects */

	/* If there are some expanded objects, then we must initialize them by
	 * calling the initialization routine (which will set up intra references).
	 * The dynamic type of all the expanded object is the same, so we only
	 * compute the one of the first element. Note that the Dtype() macro needs
	 * a pointer to the object and not to the zone, hence the shifting by
	 * OVERHEAD bytes in the computation of 'dtype'--RAM.
	 */

	exp_dftype = eif_gen_param_id (Dftype(new_area), 1);

#ifndef WORKBENCH
	if (References(To_dtype(exp_dftype)) > 0) {
#endif
		/* If there is a header for each expanded in the special, then update expanded
		 * offsets for k objects. */
	for (
		n = k - 1, ref = new_area + (n * elem_size);
		n >= 0;
		n--, ref -= elem_size)
	{
		CHECK("size nonnegative", (ref - new_area + OVERHEAD) >= 0);
		CHECK("valid size", (ref - new_area + OVERHEAD) <= B_SIZE);
		((union overhead *) ref)->ov_size = (uint32) (ref - new_area + OVERHEAD);
	}
#ifndef WORKBENCH
	}
#endif
	
		/* Intialize remaining objects from k to (i - 1) */
	new_area = sp_init(new_area, exp_dftype, k, i - 1);

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
