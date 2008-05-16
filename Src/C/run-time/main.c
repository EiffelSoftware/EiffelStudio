/*
	description: "Initialization of the runtime."
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
doc:<file name="main.c" header="eif_main.h" version="$Id$" summary="Initialization of runtime">
*/

#include "eif_portable.h"

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include "rt_assert.h"

#include "eif_project.h"
#include <string.h>
#include "rt_urgent.h"
#include "rt_except.h"
#include "rt_sig.h"
#include "rt_gen_conf.h"

#ifdef WORKBENCH
#include "eif_wbench.h"		/* %%ss added for create_desc */
#include "rt_interp.h"
#include "rt_update.h"
#include "server.h"						/* ../ipc/app */
#endif /* WORKBENCH */

#include "rt_err_msg.h"

#if !defined CUSTOM || defined NEED_UMAIN_H
#include "eif_umain.h"
#endif

#if !defined CUSTOM || defined NEED_ARGV_H
#include "rt_argv.h"
#endif

#include "rt_lmalloc.h"
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "rt_debug.h"
#include "rt_main.h"
#include "rt_macros.h"

#ifdef BOEHM_GC
#include "rt_boehm.h"
#endif

/*
doc:	<attribute name="eif_no_reclaim" return_type="int" export="public">
doc:		<summary>Tell if runtime should reclaim all objects at the very end of execution.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized once in `eif_alloc_init'.</synchronization>
doc:	</attribute>
*/
rt_public int eif_no_reclaim = 0;

/*
doc:	<attribute name="cc_for_speed" return_type="int" export="public">
doc:		<summary>Is runtime memory allocation optimized for speed or for memory. Default value is `1' (speed), except on some platforms where it is not supported or if scavenging is disabled.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Use `eif_memory_mutex' when updating its value.</synchronization>
doc:		<eiffel_classes>MEMORY</eiffel_classes>
doc:	</attribute>
*/
#if defined VXWORKS
	/* when eif_malloc() fails, the system dies otherwise !!! */
	/* FIXME? */
rt_public int cc_for_speed = 0;			/* Save memory. */
#else	/* VXWORKS */
#ifdef EIF_NO_SCAVENGING
rt_public int cc_for_speed = 0;			/* No scavenging. */
#else	/* EIF_NO_SCAVENGING */
rt_public int cc_for_speed = 1;			/* Fast memory allocation */
#endif	/* EIF_NO_SCAVENGING */
#endif	/* VXWORKS */

/*
doc:	<attribute name="scount" return_type="EIF_TYPE_INDEX" export="public">
doc:		<summary>Number of dynamic types in system.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `eplug.c' from generated C code.</synchronization>
doc:	</attribute>
*/
rt_public EIF_TYPE_INDEX scount;						/* Number of dynamic types */

/*
doc:	<attribute name="esystem" return_type="struct cnode *" export="public">
doc:		<summary>Description of types in current system.</summary>
doc:		<access>Read/Write once</access>
doc:		<indexing>Dynamic type.</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized here in `main.c' and updated once in `update' from `update.c'.</synchronization>
doc:	</attribute>
*/
rt_public struct cnode *esystem;			/* Eiffel system */

/*
doc:	<attribute name="eif_environ" return_type="char **" export="public">
doc:		<summary>Pointer to environment variable storage.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>NOT safe</thread_safety>
doc:		<synchronization>Passed in as the third argument in main function and can be modified by environment variable setting functions.</synchronization>
doc:	</attribute>
*/
rt_public char **eif_environ;	/* Environment variable pointer */

/*
doc:	<attribute name="eoption" return_type="struct eif_opt *" export="public">
doc:		<summary>Option table. Store assertion and profiling option per dynamic type.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>Dtype</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `main.c' and updated in `update.c'.</synchronization>
doc:	</attribute>
*/
rt_public struct eif_opt *eoption;


#ifdef WORKBENCH
/*
doc:	<attribute name="ccount" return_type="int" export="public">
doc:		<summary>Number of classes.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in compiler generated `einit.c'.</synchronization>
doc:	</attribute>
*/
rt_public int ccount;

/*
doc:	<attribute name="fcount" return_type="EIF_TYPE_INDEX" export="public">
doc:		<summary>Number of frozen dynamic types. Same as `scount' when system is completely frozen.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `main.c'.</synchronization>
doc:	</attribute>
*/
rt_public EIF_TYPE_INDEX fcount;

/*
doc:	<attribute name="ecall" return_type="int32 **" export="shared">
doc:		<summary>Routine ID arrays. Used for workbench mode only. Array of routine IDs per class indexed by their feature_id.</summary>
doc:		<access>Read/Write once</access>
doc:		<indexing>First index is by class_id, second by feature_id</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `main.c', updated in `update.c'.</synchronization>
doc:	</attribute>
*/
rt_shared int32 **ecall;

/*
doc:	<attribute name="eorg_table" return_type="struct rout_info *" export="shared">
doc:		<summary>Routine origin/offset table.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `main.c', updated in `update.c'.</synchronization>
doc:	</attribute>
*/
rt_shared struct rout_info *eorg_table;

/*
doc:	<attribute name="melt" return_type="unsigned char **" export="shared">
doc:		<summary>Byte code array. For each body_id, we store address in melted code array.</summary>
doc:		<access>Read/Write once</access>\
doc:		<indexing>Body_id</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since updated in `update.c'.</synchronization>
doc:	</attribute>
*/
rt_shared unsigned char **melt;

/*
doc:	<attribute name="eif_nb_features" return_type="uint32" export="public">
doc:		<summary>Number of features in frozen system. Correspond to count of generated `egc_frozen_init'.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in compiler generated `einit.c'.</synchronization>
doc:	</attribute>
*/
rt_public uint32 eif_nb_features;

/*
doc:	<attribute name="mpatidtab" return_type="int *" export="shared">
doc:		<summary>Table of pattern ID for a given body_id.</summary>
doc:		<access>Read/Write once</access>
doc:		<indexing>Body_id</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since updated in `update.c'.</synchronization>
doc:	</attribute>
*/
rt_shared int *mpatidtab;

/*
doc:	<attribute name="pattern" return_type="struct p_interface *" export="public">
doc:		<summary>Pattern table indexed by pattern ID. It is a vtable of `toi' (from C to melted code) and `toc' (from melted code to C code) routines</summary>
doc:		<access>Read/Write once</access>
doc:		<indexing>Pattern_id</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `main.c'.</synchronization>
doc:	</attribute>
*/
rt_public struct p_interface *pattern;		/* Pattern table */
#else
/*
doc:	<attribute name="esize" return_type="long *" export="public">
doc:		<summary>Size of objects indexed by dynamic type for finalized mode only. Done this way to avoid page fault by loading large `esystem' table.</summary>
doc:		<access>Read/Write once</access>
doc:		<indexing>Dtype</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `main.c'.</synchronization>
doc:	</attribute>
*/
rt_public long *esize;						/* Size of objects */

/*
doc:	<attribute name="nbref" return_type="long *" export="shared">
doc:		<summary>Number of references per dynamic type for finalized mode only. Done this way to avoid page fault by loading large `esystem' table.</summary>
doc:		<access>Read/Write once</access>
doc:		<indexing>Dtype</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in `main.c'.</synchronization>
doc:	</attribute>
*/
rt_shared long *nbref;						/* Gives # of references */
#endif

#if defined(WORKBENCH) || defined (EIF_THREADS)
/*
doc:	<attribute name="eif_nb_org_routines" return_type="uint32" export="public">
doc:		<summary>Number of original routine bodies. Additional routine bodies generated for derivations with expanded parameters are not counted.</summary>
doc:		<access>Read/Write once</access>
doc:		<indexing>Body_id</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized in compiler generated `einit.c' and updated in `update.c'.</synchronization>
doc:	</attribute>
*/
rt_public uint32 eif_nb_org_routines;
#endif

#define exvec() exset(NULL, 0, NULL)	/* How to get an execution vector */

rt_public void failure(void);					/* The Eiffel exectution failed */
rt_private Signal_t emergency(int sig);			/* Emergency exit */
rt_public unsigned int TIMEOUT;     /* Time out for interprocess communications */

/*
doc:	<attribute name="EIF_once_count" return_type="long" export="public">
doc:		<summary>Total number of once routines (computed by run-time).</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized at beginning with EIF_Minitxxx routines in generated code.</synchronization>
doc:	</attribute>
*/
rt_public long EIF_once_count = 0;

#if defined(WORKBENCH) || defined (EIF_THREADS)
/*
doc:	<attribute name="EIF_once_indexes" return_type="BODY_INDEX *" export="shared">
doc:		<summary>Code indexes of registered once routines.</summary>
doc:		<access>Read/Write once/None when executing Eiffel code.</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized and used only during start-up.</synchronization>
doc:	</attribute>
*/
rt_shared BODY_INDEX * EIF_once_indexes = 0;
#endif

#ifdef EIF_THREADS
/*
doc:	<attribute name="EIF_process_once_count" return_type="long" export="shared">
doc:		<summary>Total number of process-relative once routines (computed by run-time).</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized at beginning with EIF_Minitxxx routines in generated code.</synchronization>
doc:	</attribute>
*/
rt_shared long EIF_process_once_count = 0;

/*
doc:	<attribute name="EIF_process_once_indexes" return_type="BODY_INDEX *" export="shared">
doc:		<summary>Code indexes of registered process-relative once routines.</summary>
doc:		<access>Read/Write once/None when executing Eiffel code.</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized and used only during start-up.</synchronization>
doc:	</attribute>
*/
rt_shared BODY_INDEX * EIF_process_once_indexes = 0;

/*
doc:	<attribute name="EIF_process_once_values" return_type="EIF_process_once_value_t *" export="public">
doc:		<summary>Array to save value of each computed once. It is used to store process-relative once values.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>By once key.</indexing>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Array is initialized during start-up. Items are synchronized using their mutexes.</synchronization>
doc:	</attribute>
*/
rt_public EIF_process_once_value_t *EIF_process_once_values = NULL;

#endif

#ifndef EIF_THREADS
/*
doc:	<attribute name="in_assertion" return_type="int" export="public">
doc:		<summary>Is an assertion being evaluated? Used to avoid recursive calls on assertions.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_public int in_assertion = 0;

#ifdef WORKBENCH
rt_public int is_inside_rt_eiffel_code = 0;
#endif

/*
doc:	<attribute name="EIF_once_values" return_type="EIF_once_value_t *" export="public">
doc:		<summary>Array to save value of each computed once. It is used to store once per thread values.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>By once key.</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_public EIF_once_value_t *EIF_once_values = NULL;

/*
doc:	<attribute name="EIF_oms" return_type="EIF_REFERENCE **" export="public">
doc:		<summary>Array of pointers to arrays to save once manifest strings
doc:            for every routine. It is used to store once per thread values.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>By original routine body index.</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_public EIF_REFERENCE **EIF_oms = NULL;

#endif /* EIF_THREADS */

/*
doc:	<attribute name="starting_working_directory" return_type="char *" export="public">
doc:		<summary>Store working directory during session, ie where to put output files from runtime</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized once in `eif_rtinit'.</synchronization>
doc:		<fixme>Memory is allocated, we do chdir, but we never fill its content?</fixme>
doc:	</attribute>
*/
rt_public char *starting_working_directory;

/*
doc:	<attribute name="debug_mode" return_type="int" export="private">
doc:		<summary>This variable records whether the workbench application was launched via the ised wrapper (i.e. in debug mode) or not.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Done by `winit' at the beginning and only one thread can modify `debug_mode' while debugging.</synchronization>
doc:	</attribute>
*/
rt_shared int debug_mode = 0;	/* Assume not in debug mode */

/*
doc:	<routine name="is_debug_mode" return_type="int" export="public">
doc:		<summary>Public access to `debug_mode'.</summary>
doc:		<return>Value of `debug_mode'</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since we only read the value.</synchronization>
doc:	</routine>
*/

rt_public int is_debug_mode (void){
	return debug_mode;
}

/*
doc:	<routine name="set_debug_mode" return_type="void" export="public">
doc:		<summary>Public assigner to `debug_mode'.</summary>
doc:		<thread_safety>Probably Safe</thread_safety>
doc:	</routine>
*/

rt_public void set_debug_mode (int v){
	debug_mode = v;
}

/*
doc:	<attribute name="catcall_detection_mode" return_type="int" export="private">
doc:		<summary>This variable records whether the workbench application detect catcall or not in workbench mode (debug_mode has to be true)
doc:		</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Done by `winit' at the beginning and only one thread can modify `catcall_detection_mode' while debugging.</synchronization>
doc:	</attribute>
*/
rt_shared int catcall_detection_mode = default_catcall_detection_mode;	/* Assume we detect catcall at runtime */

rt_public void once_init (void)
{
	EIF_GET_CONTEXT

#if !defined(WORKBENCH) && !defined (EIF_THREADS)
	int32 old_egc_prof_enabled = egc_prof_enabled; /* Save profiler status */
	egc_prof_enabled = 0;	/* Disable profiler as it is not initialized yet. */
#endif

	ALLOC_ONCE_INDEXES; 	/* Allocate array of once indexes. */
	egc_system_mod_init (); /* Assign once indexes. */

#if !defined(WORKBENCH) && !defined (EIF_THREADS)
	egc_prof_enabled = old_egc_prof_enabled; /* Restore profiler status. */
#endif

	if (!debug_mode) {
			/* Once indexes could be used by debugger,
			 * but we are not under debugger at the moment. */
		FREE_ONCE_INDEXES;	/* Free once indexes. */
	}

	/* Allocate room for once manifest strings array. */
	ALLOC_OMS (EIF_oms);

	if (EIF_once_count == 0) {
		EIF_once_values = (EIF_once_value_t *) 0;
	} else {
		/* Allocate room for once values. */
		EIF_once_values = (EIF_once_value_t *) eif_realloc (EIF_once_values, EIF_once_count * sizeof *EIF_once_values);
				/* needs malloc; crashes otherwise on some pure C-ansi compiler (SGI)*/
		if (EIF_once_values == (EIF_once_value_t *) 0) /* Out of memory */
			enomem();
		memset (EIF_once_values, 0, EIF_once_count * sizeof *EIF_once_values);
	}

#ifdef EIF_THREADS
	if (EIF_process_once_count == 0) {
		EIF_process_once_values = (EIF_process_once_value_t *) 0;
	} else {
			/* Allocate room for process-relative once values. */
		EIF_process_once_values = (EIF_process_once_value_t *) eif_realloc (EIF_process_once_values, EIF_process_once_count * sizeof *EIF_process_once_values);
				/* needs malloc; crashes otherwise on some pure C-ansi compiler (SGI)*/
		if (EIF_process_once_values == (EIF_process_once_value_t *) 0) /* Out of memory */
			enomem();
		memset (EIF_process_once_values, 0, EIF_process_once_count * sizeof *EIF_process_once_values);
		{
			int i = EIF_process_once_count;
			while (i > 0) {
				i--;
				EIF_process_once_values [i].mutex = eif_thr_mutex_create ();
			}
		}
	}
#endif
}

rt_public void eif_alloc_init(void)
{
	/*
	 * This function initializes the global variables holding the values
	 * for memory allocation parameters (chunk and scavenge zone size) to
	 * their default values (env. variable or macro).
	 * The constant CHUNK has been replaced with eif_chunk_size everywhere.
	 * The constant GS_ZONE_SZ has been replaced with eif_scavenge_size.
	 * The constant TENURE_MAX is replaced by eif_tenure_max.
	 * The constant GS_LIMIT is replaced by eif_gs_limit. 
	 * The constant STACK_CHUNK is replaced by eif_stack_chunk. 
	 * The constant PLSC_PER is replaced by plsc_per.
	 * The constant CLSC_PER is replaced by clsc_per.
	 * The constants TH_ALLOC is replaced by th_alloc. 
	 */

	char *env_var;						/* Environment variable recipient. */
	static int chunk_size = 0;
	static int stack_chunk = 0;
	static int scavenge_size = 0;		/* Generational scavenge zone size. */
	static int tenure_max	= 0;		/* Maximum age of tenuring. */
	static int gs_limit	= 0;			/* Maximum size (bytes) of 
										 * objects in GSZ.*/
	static int c_per = 0;				/* Full coalesc period.*/
	static int p_per = 0;				/* full collection period.*/
	static int thd	= 0;				/* Threshold of allocation.*/
	static uint32 stk_limit = 0;			/* Stack size limit for GC */
	int mod;							/* Value to ensure that some runtime values are properly
										   rounded to ALIGNMAX */

	/* Special options. */
	env_var = getenv ("EIF_NO_RECLAIM");
	if (env_var != NULL)
		eif_no_reclaim = atoi (env_var);
		
	/* Set chunk size. */
	if (!chunk_size) {
		env_var = getenv ("EIF_MEMORY_CHUNK");
		if ((env_var != NULL) && (strlen(env_var) > 0)) {
			chunk_size = atoi (env_var);
		} else {
			chunk_size = CHUNK_DEFAULT;
		}
		if (chunk_size < CHUNK_SZ_MIN) {
			chunk_size = CHUNK_SZ_MIN;
		}
		mod = chunk_size % ALIGNMAX;
		if (mod != 0) {
			chunk_size += ALIGNMAX - mod;
		}
	}
	eif_chunk_size = chunk_size;
								/* Reasonable chunk size. */

#ifdef ISE_GC
	/* Set scavenge size. */
	if (!scavenge_size) {
		env_var = getenv ("EIF_MEMORY_SCAVENGE");
		if ((env_var != NULL) && (strlen(env_var) > 0)) {
			scavenge_size = atoi (env_var);
		} else {
			scavenge_size = GS_ZONE_SZ_DEFAULT;
		}
		mod = scavenge_size % ALIGNMAX;
		if (mod != 0) {
			scavenge_size += ALIGNMAX - mod;
		}
	}
	eif_scavenge_size = scavenge_size >= GS_SZ_MIN ? scavenge_size : GS_SZ_MIN;
								/* Reasonable GSZ size. */	

	/* Set maximum tenuring age. */
	if (!tenure_max)	/* Is maximum tenuring age not set yet? */
	{
		env_var = getenv ("EIF_TENURE_MAX");
		if ((env_var != NULL) && (strlen(env_var) > 0)) {	/* Has user specified it? */
			tenure_max = atoi (env_var);

			/* Must be in bounds. */
			if (tenure_max < 0)		
				tenure_max = 0;		/* Mimimun is 0. */
			else if (tenure_max > TENURE_MAX)
				tenure_max = TENURE_MAX;	/* Maximum is TENURE_MAX. */
		} else {
			tenure_max = TENURE_MAX;	/* RT default setting. */
		}
	}
	eif_tenure_max = tenure_max;	

	/* Set maximum size of objects in GSZ. */
	if (!gs_limit)	/* Is maximum size of objects in GSZ not set yet? */
	{
		env_var = getenv ("EIF_GS_LIMIT");
		if ((env_var != NULL) && (strlen(env_var) > 0)) {	/* Has user specified it? */
			gs_limit = atoi (env_var);
			/* Must be in bounds. */
			if (gs_limit < 0)		
				gs_limit = 0;		/* Mimimun is 0. */
			else if (gs_limit > GS_FLOATMARK)
				gs_limit = GS_FLOATMARK;	/* Maximum we allow, may crash 
											 * otherwise. */
		} else {
			gs_limit = GS_LIMIT;	/* RT default setting. */
		}
	}
	eif_gs_limit = gs_limit;	
								/* Reasonable gs_limit. */
#endif /* ISE GC */

	/* Set Size of local stack chunk. */
	if (!stack_chunk) {	/* Is maximum size of objects in GSZ not set yet? */
		env_var = getenv ("EIF_STACK_CHUNK");
		if ((env_var != NULL) && (strlen(env_var) > 0)) {	/* Has user specified it? */
			stack_chunk = atoi (env_var);
		} else {
			stack_chunk = STACK_CHUNK;	/* RT default setting. */
		}
		mod = stack_chunk % ALIGNMAX;
		if (mod != 0) {
			stack_chunk += ALIGNMAX - mod;
		}
	}
	eif_stack_chunk = stack_chunk;	

#ifdef ISE_GC
	/* Set full coalesce period. */
	if (!c_per) {	/* Is full coalesce period not set yet? */
		env_var = getenv ("EIF_FULL_COALESCE_PERIOD");
		if ((env_var != NULL) && (strlen(env_var) > 0))	/* Has user specified it? */
			c_per = atoi (env_var);
		else
			c_per = CLSC_PER;	/* RT default setting. */
	}
	clsc_per = c_per >= 0 ? c_per : 0;	

	/* Set full collection period. */
	if (!p_per) {	/* Is full collection period not set yet? */
		env_var = getenv ("EIF_FULL_COLLECTION_PERIOD");
		if ((env_var != NULL) && (strlen(env_var) > 0))	/* Has user specified it? */
			p_per = atoi (env_var);
		else
			p_per = PLSC_PER;	/* RT default setting. */
	}
	plsc_per = p_per >= 0 ? p_per : 0;	

	/* Set memory threshold. */
	if (!thd) {	/* Is memory threshold not set yet? */
		env_var = getenv ("EIF_MEMORY_THRESHOLD");
		if ((env_var != NULL) && (strlen(env_var) > 0))	/* Has user specified it? */
			thd = atoi (env_var);
		else
			thd = TH_ALLOC;	/* RT default setting. */
	}
	th_alloc = thd >= TH_ALLOC_MIN ? thd : TH_ALLOC_MIN;

	/* Set stack overflow depth to a certain threshold */
	if (!stk_limit) {	/* Is it set yet? */
		env_var = getenv ("EIF_STACK_LIMIT");
		if ((env_var != NULL) && (strlen(env_var) > 0)) {
			stk_limit = (uint32) atoi (env_var);
		} else {
			stk_limit = OVERFLOW_STACK_LIMIT;
		}
	}
	overflow_stack_limit = (stk_limit < 2 ? 2 : stk_limit);

#ifndef EIF_THREADS
		/* Try to allocate scavenge zone if possible in non-MT compilation. For MT compilation
		 * this is taken care of in `eif_thr_init_root'. */
	create_scavenge_zones ();
#endif

	/******************* Postconditions *******************/
	ENSURE ("Chunk size must be over that", eif_chunk_size >= CHUNK_SZ_MIN);
	ENSURE ("GSZ size must be over that", eif_scavenge_size >= GS_SZ_MIN);
	ENSURE ("Max tenure age in bounds", eif_tenure_max >= 0 && eif_tenure_max <= TENURE_MAX);
	ENSURE ("Reasonable max size of objects in GSZ.", eif_gs_limit >= 0 && eif_gs_limit <= GS_FLOATMARK);
	ENSURE ("Full coelesc period must be positive.", clsc_per >= 0);
	ENSURE ("Full collection period must be postive.", plsc_per >= 0);
	ENSURE ("Threshold of allocation must be positive", th_alloc >= TH_ALLOC_MIN);
	/*************** End of Postconditions. ******************/
#endif /* ISE_GC */
}

#ifdef EIF_THREADS
#ifdef WORKBENCH
rt_private void notify_root_thread (void)
{
	/* Notify ewb the root thread had been created
	 * and send the thread id
	 */
	RT_GET_CONTEXT
	dnotify_create_thread((EIF_THR_TYPE) eif_thr_id);
}
#endif
#endif

rt_public void eif_rtinit(int argc, char **argv, char **envp)
{
	char *eif_timeout;

	/* Compute the program name, so that all the error messages can be tagged
	 * with that name (with the notable exception of the stack trace, for
	 * formatting purpose).
	 */

#ifdef EIF_WINDOWS
	set_windows_exception_filter();
#endif

#ifdef BOEHM_GC
	GC_register_displacement (OVERHEAD);
#endif

	starting_working_directory = (char *) eif_malloc (PATH_MAX + 1);

	ufill();							/* Get urgent memory chunks */

#if defined (DEBUG) && ! defined (VXWORKS)
	/* The following install signal handlers for signals USR1 and USR2. Both
	 * raise an immediate scanning of memory and dumping of the free list usage
	 * and other statistics. The difference is that USR1 also performrs a full
	 * GC cycle before runnning the diagnosis. If memck() is programmed to
	 * panic when inconsistencies are detected, this may raise a system failure
	 * due to race condition. There is nothing the user can do about it, except
	 * pray--RAM.
	 */

	esignal(SIGUSR1, mem_diagnose);
	esignal(SIGUSR2, mem_diagnose);
#endif

	/* Check if the user wants to override the default timeout value
	 * for interprocess communications. This new value is specified in
	 * the ISE_TIMEOUT environment variable
	 */
	eif_timeout = getenv("ISE_TIMEOUT");
	if ((eif_timeout != NULL) && (strlen(eif_timeout) > 0)) {		/* Environment variable set */
		TIMEOUT = (unsigned) atoi(eif_timeout);
	} else {
		TIMEOUT = 30;
	}

	eoption = egc_foption;

#ifdef WORKBENCH
	xinitint();							/* Interpreter initialization */
	esystem = egc_fsystem;
	ecall = egc_fcall;
	eif_par_table = egc_partab;
	eif_par_table_size = egc_partab_size;
	eorg_table = egc_forg_table;
	pattern = egc_fpattern;

	debug_initialize(); /* Initialize debug information (breakpoints ...) */

	/* In workbench mode, we have a slight problem: when we link ewb in
	 * workbench mode, since ewb is a child from ised, the run-time will
	 * assume, wrongly, that the executable is started in debug mode. Therefore,
	 * we need a special run-time, with no debugging hooks involved.
	 */
#ifndef NOHOOK
	winit();					/* Did we start under ewb control? */
#endif

	/* Initialize dynamically computed variables (i.e. system dependent)
	 * Then we may call update. Eventually, when debugging the
	 * application, the values loaded from the update file will be overridden
	 * by the workbench (via winit).
	 */

	egc_einit();							/* Various static initializations */
	fcount = scount;

	{
		char temp = 0;
		int i;

		for (i=1;i<argc;i++) {
			if (0 == strcmp (argv[i], "-ignore_updt")) {
				temp = (char) 1;	
				break;
			}
		}
		update(temp, argv[0]);					
	}									/* Read melted information
										 * Note: the `update' function takes
										 * care of the initialization of the 
										 * temporary descriptor structures
										 */

	create_desc();						/* Create descriptor (call) tables */
	
#else

	/*
	 * Initialize the finalized system with the static data structures.
	 */
	esystem = egc_fsystem;
	eif_par_table = egc_partab;
	eif_par_table_size = egc_partab_size;
	eif_gen_conf_init (eif_par_table_size);
	nbref = egc_fnbref;
	esize = egc_fsize;

#endif

#if !defined CUSTOM || defined NEED_UMAIN_H
	umain(argc, argv, envp);			/* User's initializations */
#endif
#if !defined CUSTOM || defined NEED_ARGV_H
	arg_init(argc, argv);				/* Save copy for class ARGUMENTS */
#endif
	eif_environ = envp;				/* Save pointer to environment variable storage */
	once_init();
#ifdef EIF_THREADS
#ifdef WORKBENCH
	notify_root_thread();
#endif
#endif
#ifdef WORKBENCH
	if (egc_routdisp_wb == 0) {
		egc_routdisp_wb = (void (*)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) egc_routdisp;
	}
#else
	if (egc_routdisp_fl == 0) {
		egc_routdisp_fl = (void (*)(EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_REFERENCE, EIF_BOOLEAN, EIF_INTEGER)) egc_routdisp;
	}
#endif
	init_emnger();					/* Initialize ISE_EXCEPTION_MANAGER */
}

rt_public void failure(void)
{
	/* A fatal Eiffel exception has occurred. The stack of exceptions is dumped
	 * and the memory is cleaned up, if possible.
	 */

  	GTCX
  		/* When we arrive at this location, the Eiffel call stack is theoratically
		 * empty, but `loc_set' still points to the location where the last Eiffel
		 * call has been made. Since now `loc_set' records address of C local variable
		 * which are usually located on the C call stack. Any addition to the C call
		 * stack (like the call to `trapsig' below) will corrupt the information
		 * stored in `loc_set' since it will replace a location by another.
		 *
		 * To prevent this, we have to manually empty `loc_set'. It does not matter
		 * at this point that the GC forgets about all objects referenced through
		 * a local variable since all Eiffel calls have been executed.
		 * Doing so, enables a safe `reclaim' that will not traverse `loc_set'
		 * objects.
		 * We then create an empty `loc_set' as most of the run-time macros for stack
		 * management expect `loc_set' to have at least one chunk.
		 */
#ifdef ISE_GC
	st_reset (&loc_set);
	st_alloc (&loc_set, eif_stack_chunk);
#endif

	trapsig(emergency);					/* Weird signals are trapped */
	esfail(MTC_NOARG);							/* Dump the execution stack trace */

	reclaim();							/* Reclaim all the objects */
	exit(1);							/* Abnormal termination */

	/* NOTREACHED */
}

rt_private Signal_t emergency(int sig)
{
	/* A signal has been trapped while we were failing peacefully. The memory
	 * must really be in a desastrous state, so print out a give-up message
	 * and exit.
	 */
	
	print_err_msg(stderr, "\n\n%s: PANIC: caught signal #%d (%s) -- Giving up...\n",
		egc_system_name, sig, signame(sig));

	exit(2);							/* Really abnormal termination */

	/* NOTREACHED */
}

#ifdef NOHOOK

/* When no debugging is allowed, the file network.o is not part of the
 * archive. However, we need to define dummy dserver() and dinterrupt() entries.
 */

rt_shared void dserver(void) {}
rt_shared void dnotify(int evt_type, int evt_data) {}
rt_shared char dinterrupt(void) { return 0; }
#endif

rt_shared void dexit(int code)
{
	/* This routine is called by functions from libipc.a to raise immediate
	 * termination with a chance to trap the action and perform some clean-up.
	 * Here we call esdie() which will collect all the Eiffel objects and
	 * eventually call dispose() on some of them.
	 */

	esdie(code);						/* Propagate dying request */
}

/*
doc:</file>
*/
