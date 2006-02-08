/*
	description: "Garbage collection routines."
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
doc:<file name="garcol.c" header="eif_garcol.h" version="$Id$" summary="Garbage collection routines">
*/

#include "eif_portable.h"
#include "eif_project.h" /* for egc_prof_enabled */
#include "eif_eiffel.h"		/* For bcopy/memcpy */
#include "eif_struct.h"
#include "rt_globals.h"
#include "eif_misc.h"	
#include "eif_size.h"
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "rt_types.h"
#include "rt_threads.h"
#include "rt_lmalloc.h"	/* for eif_free */
#include "eif_memory.h"
#if ! defined CUSTOM || defined NEED_TIMER_H
#include "rt_timer.h"
#endif
#include "rt_macros.h"
#include "rt_sig.h"
#include "rt_urgent.h"
#include "rt_search.h"
#include "rt_gen_conf.h"	/* For eif_gen_conf_cleanup () */
#include "rt_gen_types.h"	/* For tuple marking */
#include "eif_cecil.h"
#include "rt_struct.h"
#include "x2c.h"		/* For macro LNGPAD */
#ifdef VXWORKS
#include <string.h>
#endif

#include <stdio.h>		/* For stream flushing */

#include "rt_assert.h" 				/* For assertions checking. */
#if ! defined CUSTOM || defined NEED_OPTION_H
#include "rt_option.h"		/* For exitprf */
#endif
#if ! defined CUSTOM || defined NEED_OBJECT_ID_H
#include "rt_object_id.h"	/* For the object id and separate stacks */
#endif
#include "rt_hector.h"
#include "rt_except.h"
#include "rt_debug.h"
#include "rt_main.h"

#ifdef WORKBENCH
#include "rt_interp.h"
#endif


#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_WINDOWS
extern void eif_cleanup(void); /* %%ss added. In extra/win32/console/argcargv.c */
#endif

#ifdef ISE_GC

#ifdef EIF_ASSERTIONS
extern EIF_BOOLEAN has_object (struct stack *, EIF_REFERENCE); 
#endif

#define MARK_SWITCH hybrid_mark
#define GEN_SWITCH hybrid_gen_mark

/*#define DEBUG 63 */				/* Debugging level */
/*#define MEMCHK		*/		/* Activate memory checking */
/*#define MEM_STAT		*/		/* Activate Eiffel memory monitoring */

/*
doc:	<attribute name="rt_g_data" return_type="struct gcinfo" export="shared">
doc:		<summary>Internal data structure used to monitor the activity of the garbage collection process and help the auto-adaptative algorithm in its decisions (heuristics).</summary>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if caller holds either `eif_gc_mutex' or `eif_g_data_mutex'.</synchronization>
doc:		<fixme>Because it is very easy to turn the GC on or off, if more than one threads plays with it we are stuck a most likely the GC will be off. We need to have a better synchronization thanwhat we have at the moment, so that we only let one thread turn the GC off, no one else but this threads can turn it back on.</fixme>
doc:	</attribute>
*/
rt_shared struct gacinfo rt_g_data = {			/* Global status */
	0L,			/* nb_full */
	0L,			/* nb_partial */
	0L,			/* mem_used */
	0,			/* gc_to */
	(char) 0,	/* status */
};

/*
doc:	<attribute name="rt_g_stat" return_type="struct gacstat [GST_NBR]" export="shared">
doc:		<summary>Run-time statistics, one for partial scavenging and one for generational.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_gc_mutex'.</synchronization>
doc:	</attribute>
*/
rt_shared struct gacstat rt_g_stat[GST_NBR] = {	/* Run-time statistics */
	{
		0L,		/* count */				0L,		/* mem_used */
		0L,		/* mem_collect */		0L,		/* mem_avg */
		0L,		/* real_avg */			0L,		/* real_time */
		0L,		/* real_iavg */			0L,		/* real_itime */
		0.,		/* cpu_avg */			0.,		/* sys_avg */
		0.,		/* cpu_iavg */			0.,		/* sys_iavg */
		0.,		/* cpu_time */			0.,		/* sys_time */
		0.,		/* cpu_itime */			0.,		/* sys_itime */
	},
	{
		0L,		/* count */				0L,		/* mem_used */
		0L,		/* mem_collect */		0L,		/* mem_avg */
		0L,		/* real_avg */			0L,		/* real_time */
		0L,		/* real_iavg */			0L,		/* real_itime */
		0.,		/* cpu_avg */			0.,		/* sys_avg */
		0.,		/* cpu_iavg */			0.,		/* sys_iavg */
		0.,		/* cpu_time */			0.,		/* sys_time */
		0.,		/* cpu_itime */			0.,		/* sys_itime */
	}
};


#endif /* ISE_GC */

#ifndef EIF_THREADS
#ifdef ISE_GC
/*
doc:	<attribute name="loc_stack" return_type="struct stack" export="public">
doc:		<summary>To protect EIF_REFERENCE in C routines through RT_GC_PROTECT/RT_GC_WEAN macros. Used internally by runtime. Content points to ojbects which may be moved by garbage collector or memory management routines.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_public struct stack loc_stack = {			/* Local indirection stack */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};

/*
doc:	<attribute name="loc_set" return_type="struct stack" export="public">
doc:		<summary>To protect Eiffel objects in C generated code. Same purpose as `loc_stack' but only used for C generated code.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_public struct stack loc_set = {				/* Local variable stack */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};
#endif
/*
doc:	<attribute name="once_set" return_type="struct stack" export="public">
doc:		<summary>Keep safe references of once function results which are computed per thread (default behavior).</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_public struct stack once_set = {			/* Once functions */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};
/*
doc:	<attribute name="oms_set" return_type="struct stack" export="public">
doc:		<summary>Keep safe references of once manifest strings which are computed per thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_public struct stack oms_set = {			/* Once manifest strings */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};
#else
/*
doc:	<attribute name="global_once_set" return_type="struct stack" export="public">
doc:		<summary>Same as `once_set' but for results that are computed per process.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_global_once_set_mutex'</synchronization>
doc:	</attribute>
*/
rt_public struct stack global_once_set = {			/* Once functions */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};

	/* Same as above except that GC keeps track of all thread specific stack to
	 * perform a GC cycle among all threads */
#ifdef ISE_GC
/*
doc:	<attribute name="loc_stack_list" return_type="struct stack_list" export="public">
doc:		<summary>List of all `loc_stack'. There is one per thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_public struct stack_list loc_stack_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};

/*
doc:	<attribute name="loc_set_list" return_type="struct stack_list" export="public">
doc:		<summary>List of all `loc_set'. There is one per thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_public struct stack_list loc_set_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};
#endif
/*
doc:	<attribute name="once_set_list" return_type="struct stack_list" export="public">
doc:		<summary>List of all `once_set'. There is one per thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_public struct stack_list once_set_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};
/*
doc:	<attribute name="oms_set_list" return_type="struct stack_list" export="public">
doc:		<summary>List of all `oms_set'. There is one per thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_public struct stack_list oms_set_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};
#ifdef ISE_GC
/*
doc:	<attribute name="hec_stack_list" return_type="struct stack_list" export="public">
doc:		<summary>List of all `hec_stack'. There is one per thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_public struct stack_list hec_stack_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};

/*
doc:	<attribute name="hec_saved_list" return_type="struct stack_list" export="public">
doc:		<summary>List of all `hec_saved'. There is one per thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_public struct stack_list hec_saved_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};
#endif
/*
doc:	<attribute name="eif_stack_list" return_type="struct stack_list" export="public">
doc:		<summary>List of all `eif_stack'. There is one per thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_public struct stack_list eif_stack_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};

/*
doc:	<attribute name="eif_trace_list" return_type="struct stack_list" export="public">
doc:		<summary>List of all `eif_trace'. There is one per thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_public struct stack_list eif_trace_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};

#ifdef WORKBENCH
/*
doc:	<attribute name="opstack_list" return_type="struct stack_list" export="public">
doc:		<summary>List of all `op_stack'. There is one per thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_public struct stack_list opstack_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};
#endif

#endif

#ifdef ISE_GC
/*
doc:	<attribute name="rem_set" return_type="struct stack" export="private">
doc:		<summary>Remembered set. Remembers all old objects pointing on new ones.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_set_mutex</synchronization>
doc:	</attribute>
*/
rt_private struct stack rem_set = {			/* Remembered set */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,	/* st_top */
	(EIF_REFERENCE *) 0,	/* st_end */
};

/*
doc:	<attribute name="moved_set" return_type="struct stack" export="shared">
doc:		<summary>Moved objets set. Track all objects allocated outside the scavenge zone.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_set_mutex</synchronization>
doc:	</attribute>
*/
rt_shared struct stack moved_set = {			/* Moved objects set */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,	/* st_top */
	(EIF_REFERENCE *) 0,	/* st_end */
};

/*
doc:	<attribute name="memory_set" return_type="struct stack" export="public">
doc:		<summary>Memory set. Track all objects allocated in the scavenge zone which have a `dispose' routine.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_set_mutex for insertion, eif_gc_mutex for manipulating it.</synchronization>
doc:	</attribute>
*/
rt_public struct stack memory_set = 
{
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,	/* st_top */
	(EIF_REFERENCE *) 0,	/* st_end */
};

/*
doc:	<attribute name="overflow_stack_set" return_type="struct stack" export="private">
doc:		<summary>Stack containing objects that are not yet traversed because it could generate a stack overflow during a GC cycle.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_private struct stack overflow_stack_set = {
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,	/* st_top */
	(EIF_REFERENCE *) 0,	/* st_end */
};

/*
doc:	<attribute name="overflow_stack_count" return_type="uint32" export="private">
doc:		<summary>Number of elements in `overflow_stack_set'.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_private uint32 overflow_stack_count = 0;

/*
doc:	<attribute name="overflow_stack_depth" return_type="uint32" export="private">
doc:		<summary>Depth current recursive call to marking routine.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_private uint32 overflow_stack_depth = 0;

/*
doc:	<attribute name="overflow_stack_limit" return_type="uint32" export="shared">
doc:		<summary>Limit on `overflow_stack_depth'. When limit is reached, recursive calls are stopped and current element is stored in `overflow_stack_set' for later traversal.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_shared uint32 overflow_stack_limit = 0;


	/* Signature of marking functions. They take the address where
	 * reference is stored (to be updated by `mark_overflow_stack'
	 * if we are too deep in the call stack) and return new location
	 * of object. */
typedef EIF_REFERENCE (*MARKER) (EIF_REFERENCE *);

#endif

#ifdef EIF_THREADS
/*
doc:	<attribute name="eif_gc_mutex" return_type="EIF_LW_MUTEX_TYPE *" export="public">
doc:		<summary>Mutex used for run-time synchronization when performing a GC cycle. All running threads should be stopped on `eif_gc_mutex' or be blocked before starting a GC cycle</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/
rt_public EIF_LW_MUTEX_TYPE *eif_gc_mutex = NULL;

/*
doc:	<attribute name="eif_gc_set_mutex" return_type="EIF_LW_MUTEX_TYPE *" export="public">
doc:		<summary>Mutex used to access all the global sets `moved_set', `rem_set' and `memory_set'.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/
rt_public EIF_LW_MUTEX_TYPE *eif_gc_set_mutex = NULL;

#ifdef ISE_GC
/*
doc:	<attribute name="eif_g_data_mutex" return_type="EIF_LW_MUTEX_TYPE *" export="public">
doc:		<summary>Mutex used to access `rt_g_data' when not protected by `eif_gc_mutex'.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/
rt_public EIF_LW_MUTEX_TYPE *eif_rt_g_data_mutex = NULL;
#endif

/*
doc:	<attribute name="eif_global_once_set_mutex" return_type="EIF_LW_MUTEX_TYPE *" export="public">
doc:		<summary>Mutex used to protect insertion of global once result in `global_once_set'.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/
rt_public EIF_LW_MUTEX_TYPE *eif_global_once_set_mutex = NULL;
#endif

/*
doc:	<attribute name="age_table" return_type="uint32 [TENURE_MAX]" export="private">
doc:		<summary>Array used to store the number of objects used, indexed by object's age. This is used when computing the demographic feedback-mediated tenuring threshold for the next step (generation collection).</summary>
doc:		<indexing>age</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_private uint32 age_table[TENURE_MAX];		/* Number of objects/age */ 

/*
doc:	<attribute name="size_table" return_type="rt_uint_ptr [TENURE_MAX]" export="private">
doc:		<summary>Array used to store the size of objects used, indexed by object's age. This is used when computing the demographic feedback-mediated tenuring threshold for the next step (generation collection) and by the generation scavenging algorithm.</summary>
doc:		<indexing>age</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_private rt_uint_ptr size_table[TENURE_MAX];		/* Amount of bytes/age */ 

/*
doc:	<attribute name="tenure" return_type="int" export="shared">
doc:		<summary>Maximum age for tenuring.</summary>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None since initialized in `main.c'.</synchronization>
doc:		<fixme>Because `tenure' is also accessed in `hector' this causes a potential thread safe access. We need to protect his access in `efreeze'.</fixme>
doc:	</attribute>
*/
rt_shared int tenure;
											
/*
doc:	<attribute name="plsc_per" return_type="long" export="public">
doc:		<summary>Period of calls to `plsc' in `acollect'.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None while initialized in main.c, but use `eif_memory_mutex' when updating its value.</synchronization>
doc:	</attribute>
*/
rt_public long plsc_per;

/*
doc:	<attribute name="force_plsc" return_type="long" export="shared">
doc:		<summary>When moving objects outside the scavenge zone, if it turns out we do not have enough memory in the free list, we force a full collection at the next collection. That way we are sure not to over-allocate block of memory when not needed. Doing so reduces the memory foot-print of Eiffel applications.</summary>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Under `trigger_gc_mutex' or `eiffel_usage_mutex' or GC synchronization.</synchronization>
doc:	</attribute>
*/
rt_shared long force_plsc = 0;

/*
doc:	<attribute name="gc_running" return_type="int" export="public">
doc:		<summary>Is GC running?</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Does not seem to be used anymore apart in `option.c' for profiling but we don't even know why? We might want to get rid of it.</fixme>
doc:	</attribute>
*/
rt_public int gc_running = 0;			/* Is the GC running */ 

/*
doc:	<attribute name="last_gc_time" return_type="double" export="public">
doc:		<summary>Last time spent on last collect, sweep or whatever the GC did.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>As with `gc_running' we don't know when it is really used.</fixme>
doc:	</attribute>
*/
rt_public double last_gc_time = 0;

/*
doc:	<attribute name="gc_ran" return_type="int" export="public">
doc:		<summary>Has the GC been running?</summary>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Same as `gc_running'. There is a mistery to solve.</fixme>
doc:	</attribute>
*/
rt_public int gc_ran = 0;				/* Has the GC been running */ 

/*
doc:	<attribute name="clsc_per" return_type="EIF_INTEGER" export="public">
doc:		<summary>Period of full coalescing. If `0', it is never called.</summary>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Updated needs to be synchronized with a mutex.</fixme>
doc:	</attribute>
*/
rt_public EIF_INTEGER clsc_per;			/* Period of full coalescing: 0 => never. */

/* Zones used for partial scavenging */
/*
doc:	<attribute name="ps_from" return_type="struct partial_sc_zone" export="private">
doc:		<summary>From zone used for partial scavenging</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_private struct partial_sc_zone ps_from;

/*
doc:	<attribute name="ps_to" return_type="struct partial_sc_zone" export="private">
doc:		<summary>To zone used for partial scavenging</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_private struct partial_sc_zone ps_to;

/*
doc:	<attribute name="last_from" return_type="struct chunk *" export="private">
doc:		<summary>Last `from' zone used by partial scavenging.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_private struct chunk *last_from = NULL;

/*
doc:	<attribute name="th_alloc" return_type="size_t" export="public">
doc:		<summary>Allocation threshold before calling GC. Initialized in `main.c', updated in `memory.c'.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None while initialized in main.c, but use `eif_memory_mutex' when updating its value.</synchronization>
doc:	</attribute>
*/
rt_public size_t th_alloc;

/*
doc:	<attribute name="gc_monitor" return_type="int" export="public">
doc:		<summary>Disable GC time-monitoring. By default it is 0.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None while initialized in main.c, but use `eif_memory_mutex' when updating its value.</synchronization>
doc:	</attribute>
*/
rt_public int gc_monitor = 0;

/*
doc:	<attribute name="root_obj" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Pointer to root object of current system. Initialized by generated C code.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</attribute>
*/
rt_public EIF_REFERENCE root_obj = NULL;

/*
doc:	<attribute name="has_reclaim_been_called" return_type="EIF_BOOLEAN" export="private">
doc:		<summary>Flag to prevent multiple calls to `reclaim' which could occur if for some reasons `reclaim´ failed, then the `main' routine of the Eiffel program will call `failure' which calls `reclaim' again. So if it failed the first time around it is going to fail a second time and therefore it is useless to call `reclaim' again.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</attribute>
*/
rt_public EIF_BOOLEAN has_reclaim_been_called = 0;

#ifdef ISE_GC

#ifdef DEBUG
rt_private int nb_items(struct stack *);	/* Number of items held in a stack */
#endif
/* Automatic invokations of GC */
rt_shared int acollect(void);				/* Collection based on threshold */
rt_shared int scollect(int (*gc_func) (void), int i);				/* Collect with statistics */

#endif /* ISE_GC */

/* Stopping/restarting the GC */
rt_public void gc_stop(void);				/* Stop the garbage collector */
rt_public void gc_run(void);				/* Restart the garbage collector */

rt_public void reclaim(void);				/* Reclaim all the objects */
#ifdef ISE_GC
rt_private void internal_marking(MARKER marking, int moving);
rt_private void full_mark(EIF_CONTEXT_NOARG);			/* Marks all reachable objects */
rt_private void full_sweep(void);			/* Removes all un-marked objects */
rt_private void run_collector(void);		/* Wrapper for full collections */

/* Stack markers */
rt_private void mark_simple_stack(struct stack *stk, MARKER marker, int move);	/* Marks a collector's stack */
rt_private void mark_stack(struct stack *stk, MARKER marker, int move);			/* Marks a collector's stack */
rt_private void mark_overflow_stack(MARKER marker, int move);
#if ! defined CUSTOM || defined NEED_OBJECT_ID_H
rt_private void update_object_id_stack(void); /* Update the object id stack */
#endif
/* Storage compation reclaimer */
rt_public void plsc(void);					/* Storage compaction reclaimer entry */
rt_private int partial_scavenging(void);	/* The partial scavenging algorithm */
rt_private void run_plsc(void);			/* Run the partial scavenging algorithm */
rt_shared void urgent_plsc(EIF_REFERENCE *object);			/* Partial scavenge with given local root */
rt_private void init_plsc(void);			/* Initialize the scavenging process */
rt_private void clean_zones(void);			/* Clean up scavenge zones */
rt_private EIF_REFERENCE scavenge(register EIF_REFERENCE root, char **top);			/* Scavenge an object */
/*rt_private void clean_space();*/			/* Sweep forwarded objects */ /* %%ss undefine */
rt_private void full_update(void);			/* Update scavenge-related structures */
rt_private int split_to_block (int is_to_keep);		/* Keep only needed space in 'to' block */
rt_private int sweep_from_space(void);		/* Clean space after the scavenging */
rt_private int find_scavenge_spaces(void);	/* Find a pair of scavenging spaces */
#ifndef EIF_NO_SCAVENGING
rt_private struct chunk *find_from_space(void);	/* Look for a chunk that could be used as a `from' space. */
rt_private void find_to_space(void);		/* Look for a chunk that could be used as a 'to' chunks */
#endif

/* Generation based collector */
rt_public int collect(void);				/* Generation based collector main entry */
rt_private int generational_collect(void);	/* The generational collection algorithm */
rt_public void eremb(EIF_REFERENCE obj);				/* Remember an old object */
rt_public void erembq(EIF_REFERENCE obj);				/* Quick version (no GC call) of eremb */
rt_private void update_memory_set (void);		/* Update memory set */
rt_private void mark_new_generation(EIF_CONTEXT_NOARG);	/* The name says it all, I think--RAM */
rt_private EIF_REFERENCE mark_expanded(EIF_REFERENCE root, MARKER marker);		/* Marks expanded reference in stack */
rt_private void update_moved_set(void);	/* Update the moved set (young objects) */
rt_private void update_rem_set(void);		/* Update remembered set */
rt_shared int refers_new_object(register EIF_REFERENCE object);		/* Does an object refers to young ones ? */
rt_private EIF_REFERENCE gscavenge(EIF_REFERENCE root);			/* Generation scavenging on an object */
rt_private void swap_gen_zones(void);		/* Exchange 'from' and 'to' zones */

/* Dealing with dispose routine */
rt_shared void gfree(register union overhead *zone);				/* Free object, eventually call dispose */

#endif
/* Stack handling routines */
rt_shared int epush(register struct stack *stk, register void *value);				/* Push value on stack */
rt_shared EIF_REFERENCE *st_alloc(register struct stack *stk, register int size);		/* Creates an empty stack */
rt_shared void st_truncate(register struct stack *stk);		/* Truncate stack if necessary */
rt_shared void st_wipe_out(register struct stchunk *chunk);		/* Remove unneeded chunk from stack */
rt_shared int st_extend(register struct stack *stk, register int size);			/* Extends size of stack */
#ifdef ISE_GC

/* Marking algorithm */
rt_private EIF_REFERENCE hybrid_mark(EIF_REFERENCE *root);		/* Mark all reachable objects */
rt_private EIF_REFERENCE hybrid_gen_mark(EIF_REFERENCE *root);	/* hybrid_mark with on-the-fly copy */

rt_private void mark_ex_stack(struct xstack *stk, MARKER marker, int move);		/* Marks the exception stacks */

#ifdef WORKBENCH
rt_private void mark_op_stack(struct opstack *stk, MARKER marker, int move);		/* Marks operational stack */
#endif

/* Compiled with -DTEST, we turn on DEBUG if not already done */
#ifdef TEST
#ifndef DEBUG
#define DEBUG	63		/* Highest debug level */
#endif
#endif

#ifdef DEBUG
#define NB_FULL		0
#define NB_PARTIAL	1

#define debug_ok(n)	( \
	(n) & DEBUG || \
	(rt_g_data.nb_full == NB_FULL && fdone || rt_g_data.nb_partial == NB_PARTIAL) \
	)
#define dprintf(n)	\
	if ( \
			DEBUG & (n) && debug_ok(n)\
	) printf 
#define flush			fflush(stdout);

static int fdone = 0;	/* Tracing flag to only get the last full collect */
#endif


/* Function(s) used only in DEBUG mode */
#ifdef DEBUG
#ifndef MEMCHK
#define memck(x)	;				/* No memory checking compiled */
#endif
#endif

#ifdef TEST
/* This is to make tests */
#undef References
#undef Size
#define References(type)	2				/* Number of references in object */
#define Size(type)			40				/* Size of the object */
#define Dispose(type)	((void (*)()) 0)	/* No dispose routine */
#endif

/*
 * Automatic collection and statistics routines.
 */
/*
doc:	<routine name="acollect" return_type="int" export="shared">
doc:		<summary>This is the main dispatcher for garbage collection. Calls are based on a threshold th_alloc. Statistics are gathered while performing collection. We run the collect() most of the time (for a generational mark and sweep and/or a generation scavenging) and a full collection once every 'plsc_per' (aka the period) calls. Each time we run a full collection, we perform a full coalesc of the memory. Our experience shows that it is more efficient to do the coalesc just after a full collection, doing it in between degrades the performance.</summary>
doc:		<return>0 if collection was done, -1 otherwise.</return>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Through `trigger_gc_mutex'.</synchronization>
doc:	</routine>
*/

rt_shared int acollect(void)
{
	static long nb_calls = 0;		/* Number of calls to function */
	static rt_uint_ptr eif_total = 0;		/* Total Eiffel memory allocated */
	int status;						/* Status returned by scollect() */
#ifdef EIF_CONDITIONAL_COLLECT
	int freemem;					/* Amount of free memory */
	int tau;						/* Mean allocation rate */
	int half_tau;					
	int allocated;					/* Memory used since last full collect */
#endif	/* EIF_CONDITIONAL_COLLECT */
	if (rt_g_data.status & GC_STOP)
#ifdef DEBUG
	{
		dprintf(1)("acollect: Nothing has to be done because GC_STOP\n");
#endif
		return -1;					/* Garbage collection stopped */
#ifdef DEBUG
	}
#endif

#ifdef DEBUG
	dprintf(1)("acollect: automatic garbage collection with %s\n",
		nb_calls % plsc_per ? "generation collection" : "partial scavenging");
	flush;
#endif

	/* If the Eiffel memory free F is such that F > (.5 * P * T), where P is
	 * the period of full collections 'plsc_per' and T is the allocation
	 * threshold 'th_alloc', and F < (1.5 * P * T) then nothing is done. Thus
	 * we do collections only when a small amount of free memory is left or
	 * when a large amout is free (in the hope we'll be able to give some of
	 * this memory to the kernel).
	 * However, we have to counter balance this scheme with the extra amount of
	 * memory allocated since the last full collection. Whenever it is more
	 * than (P * T), we want to run a collection since some garbage might have
	 * been created.
	 */

#ifdef EIF_CONDITIONAL_COLLECT
	freemem = rt_e_data.ml_total - rt_e_data.ml_used - rt_e_data.ml_over;
	tau = plsc_per * th_alloc;
	half_tau = tau >> 1;
	allocated = rt_e_data.ml_total - eif_total;

	if (allocated < tau && freemem > half_tau && freemem < (tau + half_tau)) {

#ifdef DEBUG
		dprintf(1)("acollect: skipping call (%d bytes free)\n", freemem);
#endif
		return -1;	/* Do not perform collection */ /* %%ss -1 was 0 */
	}
#endif
	/* Every "plsc_per" collections, we ran a full collection.
	 * This period can be set by the user.
	 */

	if (plsc_per) {				/* Can we run full collections?.*/
		if (force_plsc || (0 == nb_calls % plsc_per)) {	/* Full collection required */
			plsc();
			status = 0;
				/* Reset `force_plsc' since we don't want to have a second full
				 * collection right after this one. */
			force_plsc = 0;
				/* Reset `nb_calls' so that if we came here because of a `force_plsc'
				 * which happens between `0' and `plsc_per', we still wait `plsc_per'
				 * calls before launching the next full collection. */
			nb_calls = 0;
			eif_total = rt_e_data.ml_total;
		} else							/* Generation-base collector */
			status = collect();
	} else {						/* Generation-base collector called, since
									 * there is no Full Collection. */
		status = collect();
	}

#ifdef DEBUG
	dprintf(1)("acollect: returning status %d\n", status);
#endif

	nb_calls++;			/* Records the call */

	return status;		/* Collection done, forward status */
}

/*
doc:	<routine name="scollect" return_type="int" export="shared">
doc:		<summary>Run a garbage collection cycle with statistics updating. We monitor both the time spent in the collection and the memory released, if any, as well as time between two collections... </summary>
doc:		<param name="gc_func" type="int (*) (void)">Collection function to be called.</param>
doc:		<param name="i" type="int">Index in `rt_g_stat' array where statistics are kept.</param>
doc:		<return>Return the status given by the collection function.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Performs a GC synchronization before executing itself.</synchronization>
doc:	</routine>
*/

rt_shared int scollect(int (*gc_func) (void), int i)
{
	RT_GET_CONTEXT
	static uint32 nb_stats[GST_NBR];	/* For average computation */
#ifndef FAST_RUNTIME
	static Timeval lastreal[GST_NBR];	/* Last real time of invocation */
	Timeval realtime, realtime2;		/* Real time stamps */
	double usertime, systime;			/* CPU stats before collection */
	double usertime2, systime2;			/* CPU usage after collection */
	static double lastuser[GST_NBR];	/* Last CPU time for last call */
	static double lastsys[GST_NBR];		/* Last kernel time for last call */
#endif
	rt_uint_ptr mem_used;						/* Current amount of memory used */
	rt_uint_ptr e_mem_used_before, e_mem_used_after;
	int status;							/* Status reported by GC function */
	struct gacstat *gstat = &rt_g_stat[i];	/* Address where stats are kept */
	int nbstat;							/* Current number of statistics */
	unsigned long nb_full;

	if (rt_g_data.status & GC_STOP)
		return -1;						/* Garbage collection stopped */

	GC_THREAD_PROTECT(eif_synchronize_gc (rt_globals));
	DISCARD_BREAKPOINTS;

	nb_full = rt_g_data.nb_full;
	mem_used = rt_m_data.ml_used + rt_m_data.ml_over;		/* Count overhead */
	e_mem_used_before = rt_e_data.ml_used + rt_e_data.ml_over;
	nbstat = ++nb_stats[i];							/* One more computation */

	/* Reset scavenging-related figures, since those will be updated by the
	 * scavenging routines when needed.
	 */

	rt_g_data.mem_move = 0;				/* Memory subject to scavenging */
	rt_g_data.mem_copied = 0;				/* Amount of that memory which moved */

#ifndef FAST_RUNTIME
	/* Get the current time before CPU time, because the accuracy of the
	 * real time clock is usually less important than the one used for CPU
	 * accounting.
	 */

	if (gc_monitor) {
		gettime(&realtime);					/* Get current time stamp */
		getcputime(&usertime, &systime);	/* Current CPU usage */
	}
#endif

#ifdef MEMCHK
#ifdef DEBUG
	dprintf(1)("scollect: before GC\n");
	memck(0);
#endif
#endif

	status = (gc_func)();				/* GC invocation */

#ifdef MEMCHK
#ifdef DEBUG
	dprintf(1)("scollect: after GC\n");
	memck(0);
#endif
#endif

#ifndef FAST_RUNTIME
	/* Get CPU time before real time, so that we have a more precise figure
	 * (gettime uses a system call)--RAM.
	 */

	if (gc_monitor) {
		getcputime(&usertime2, &systime2);	/* Current CPU usage */
		gettime(&realtime2);				/* Get current time stamp */
	}
#endif

	/* Now collect the statistics in the rt_g_stat structure. The real time
	 * field will not be really significant if the time() system call is
	 * used (granularity is one second).
	 * Note that the memory collected can be negative, e.g. at the first
	 * partial scavenging where a scavenge zone is allocated.
	 */

	rt_g_data.mem_used = rt_m_data.ml_used + rt_m_data.ml_over;	/* Total mem used */
	gstat->mem_used = rt_g_data.mem_used;
		/* Sometimes during a collection we can have increased our memory
		 * pool because for example we moved objects outside the scavenge zone
		 * and therefore more objects have been allocated in memory. */
	if (mem_used > rt_g_data.mem_used) {
		gstat->mem_collect = mem_used - rt_g_data.mem_used;	/* Memory collected */
	} else {
		gstat->mem_collect = 0;
	}
	gstat->mem_collect +=		/* Memory freed by scavenging (with overhead) */
		rt_g_data.mem_copied - rt_g_data.mem_move;
	gstat->mem_avg = ((gstat->mem_avg * (nbstat - 1)) +
		gstat->mem_collect) / nbstat;					/* Average mem freed */

	if (nb_full != rt_g_data.nb_full) {
			/* We are during a full collection cycle. This is were we
			 * will update value of `plsc_per' to a better value.
			 * We only increase its value if the ratio freed memory
			 * used memory is less than 1/3, betwen 1/3 and 2/3 we do not change
			 * anything, and above 2/3 we decrease its value. */
		rt_uint_ptr partial_used_memory = (rt_e_data.ml_used + rt_e_data.ml_over) / 3;
		rt_uint_ptr freed_memory;
		if (mem_used > rt_g_data.mem_used) {
			freed_memory = mem_used - rt_g_data.mem_used;
		} else {
			freed_memory = 0;
		}
		if (freed_memory == 0) {
			/* Gogo stage. That is to say new memory has been allocated
			 * while we were collecting (moving young objects to old).
			 * Therefore there is nothing we can say about increasing or
			 * decreasing the full collection perido, so we don't change
			 * anything. */
		} else if (freed_memory <= partial_used_memory) {
				/* Perform a dichotomic increase */
			if (plsc_per < 100) {
				if (plsc_per < 50) {
					if (plsc_per < 8) {
						if (plsc_per < 4) {
							plsc_per += 1;
						} else {
							plsc_per += 2;
						}
					} else {
						plsc_per += 4;
					}
				} else {
					plsc_per += 8;
				}  
			} else {
				plsc_per += 16;
			}
			if (plsc_per < 0) {
					/* Overflow here, so restore back the max positive integer value */
				plsc_per = 0x7FFFFFFF;
			}
		} else if (freed_memory > 2 * partial_used_memory) {
				/* Perform a dichotomic decrease */
			if (plsc_per <= 100) {
				if (plsc_per <= 50) {
					if (plsc_per <= 8) {
						if (plsc_per <= 4) {
							plsc_per -= 1;
						} else {
							plsc_per -= 2;
						}
					} else {
						plsc_per -= 4;
					}
				} else {
					plsc_per -= 8;
				}  
			} else {
				plsc_per -= 16;
			}
			if (plsc_per < 1) {
				plsc_per = 1;
			}
		}
	} else {
		e_mem_used_after = rt_e_data.ml_used + rt_e_data.ml_over;
		if (e_mem_used_before > e_mem_used_after) {
				/* Some memory of free list was freed, so we should update `eiffel_usage' accordingly. */
			e_mem_used_before -= e_mem_used_after;
			if (eiffel_usage > e_mem_used_before) {
				eiffel_usage -= e_mem_used_before;
			} else {
				eiffel_usage = 0;
			}
		}
	}
			
#ifndef FAST_RUNTIME
	if (gc_monitor) {
		gstat->real_time = elapsed(&realtime, &realtime2);
		gstat->cpu_time = usertime2 - usertime;			/* CPU time (user) */
		gstat->sys_time = systime2 - systime;			/* CPU time (kernel) */
	} else {
		gstat->real_time = gstat->real_avg;		/* Adding the average */
		gstat->cpu_time = gstat->cpu_avg;		/* will not change the */
		gstat->sys_time = gstat->sys_avg;		/* computation done so far */
	}
	gstat->real_avg = ((gstat->real_avg * (nbstat - 1)) +
		gstat->real_time) / nbstat;						/* Average real time */
	gstat->cpu_avg = ((gstat->cpu_avg * (nbstat - 1)) +
		gstat->cpu_time) / nbstat;						/* Average user time */
	gstat->sys_avg = ((gstat->sys_avg * (nbstat - 1)) +
		gstat->sys_time) / nbstat;						/* Average sys time */


	/* If it is not the first time, update the statistics. First compute the
	 * time elapsed since last call, then update the average accordingly.
	 */

	if (lastuser[i] != 0) {
		if (gc_monitor) {
			gstat->cpu_itime = usertime - lastuser[i];
			gstat->sys_itime = systime - lastsys[i];
			gstat->real_itime = elapsed(&lastreal[i], &realtime);
		} else {
			gstat->cpu_itime = gstat->cpu_iavg;		/* Adding the average */
			gstat->sys_itime = gstat->sys_iavg;		/* does not change the */
			gstat->real_itime = gstat->real_iavg;	/* data we already have */
		}
		gstat->real_iavg = ((gstat->real_iavg * (nbstat - 2)) +
			gstat->real_itime) / (nbstat - 1);
		gstat->cpu_iavg = ((gstat->cpu_iavg * (nbstat - 2)) +
			gstat->cpu_itime) / (nbstat - 1);
		gstat->sys_iavg = ((gstat->sys_iavg * (nbstat - 2)) +
			gstat->sys_itime) / (nbstat - 1);
	}

	/* Record current times for next invokation */

	if (gc_monitor) {
		lastuser[i] = usertime2;		/* User time after last GC */
		lastsys[i] = systime2;			/* System time after last GC */
		memcpy (&lastreal[i], &realtime2, sizeof(Timeval));
	}
#endif /* ifndef FAST_RUNTIME */

#ifdef DEBUG
	dprintf(1)("scollect: statistics for %s\n",
		i == GST_PART ? "partial scavenging" : "generation collection");
	dprintf(1)("scollect: # of full collects: %ld\n", rt_g_data.nb_full);
	dprintf(1)("scollect: # of partial collects: %ld\n", rt_g_data.nb_partial);
	dprintf(1)("scollect: Total mem allocated: %ld bytes\n", rt_m_data.ml_total);
	dprintf(1)("scollect: Total mem used: %ld bytes\n", rt_m_data.ml_used);
	dprintf(1)("scollect: Total overhead: %ld bytes\n", rt_m_data.ml_over);
	dprintf(1)("scollect: Collected: %ld bytes\n", gstat->mem_collect);
	dprintf(1)("scollect: (Scavenging collect: %ld bytes)\n",
		rt_g_data.mem_copied - rt_g_data.mem_move);
	if (gc_monitor) {
		dprintf(1)("scollect: Real time: %lfs\n", gstat->real_time / 100.);
		dprintf(1)("scollect: CPU time: %lfs\n", gstat->cpu_time);
		dprintf(1)("scollect: System time: %lfs\n", gstat->sys_time);
		dprintf(1)("scollect: Average real time: %lfs\n", gstat->real_avg / 100.);
		dprintf(1)("scollect: Average CPU time: %lf\n", gstat->cpu_avg);
		dprintf(1)("scollect: Average system time: %lf\n", gstat->sys_avg);
		dprintf(1)("scollect: Interval time: %lf\n", gstat->real_itime / 100.);
		dprintf(1)("scollect: Interval CPU time: %lf\n", gstat->cpu_itime);
		dprintf(1)("scollect: Interval sys time: %lf\n", gstat->sys_itime);
		dprintf(1)("scollect: Avg interval time: %lf\n", gstat->real_iavg / 100.);
		dprintf(1)("scollect: Avg interval CPU time: %lf\n", gstat->cpu_iavg);
		dprintf(1)("scollect: Avg interval sys time: %lf\n", gstat->sys_iavg);
	}
#endif

	UNDISCARD_BREAKPOINTS;
	GC_THREAD_PROTECT(eif_unsynchronize_gc (rt_globals));
	return status;		/* Forward status report */
}
#endif /* ISE_GC */

/*
 * Garbage collector stop/run
 */

rt_public void gc_stop(void)
{
	/* Stop the GC -- this should be used in case of emergency only, i.e.
	 * in an exception handler or in a time-critical routine.
	 * Note that when we are in an exception handler, requests to GC controls
	 * are silently ignored anyway (GC is turned off before executing the
	 * signal handler).
	 */

#ifdef ISE_GC
	EIF_G_DATA_MUTEX_LOCK;
	if (!(rt_g_data.status & GC_SIG))		/* If not in signal handler */
		rt_g_data.status |= GC_STOP;		/* Stop GC */
	EIF_G_DATA_MUTEX_UNLOCK;
#endif
}

rt_public void gc_run(void)
{
	/* Restart the GC -- the garbage collector should always run excepted in
	 * some critical operations, which should be rare. Anyway, after having
	 * stopped it, here is the way to wake it up. Note that no collection
	 * cycle is raised.
	 * As for gc_stop(), the request is ignored while in the exception handler.
	 * The garbage collector is turned off in that case to avoid the dangling
	 * reference problem--RAM.
	 */

#ifdef ISE_GC
	EIF_G_DATA_MUTEX_LOCK;
	if (!(rt_g_data.status & GC_SIG))		/* If not in signal handler */
		rt_g_data.status &= ~GC_STOP;		/* Restart GC */
	EIF_G_DATA_MUTEX_UNLOCK;
#endif
}

#if defined (WORKBENCH) || defined (EIF_THREADS)
/*
doc:	<routine name="alloc_oms" return_type="EIF_REFERENCE **" export="shared">
doc:		<summary>Allocate array of once manifest strings.</summary>
doc:		<return>Allocated array filled with 0s.</return>
doc:		<exception>"No more memory" when allocation fails.</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</routine>
*/
rt_shared EIF_REFERENCE ** alloc_oms ()
{
	EIF_REFERENCE ** result;
	
	result = (EIF_REFERENCE **) eif_calloc (eif_nb_org_routines, sizeof (EIF_REFERENCE *));
	if (result == (EIF_REFERENCE **) 0) { /* Out of memory */
		enomem ();
	}
	return result;
}

/*
doc:	<routine name="free_oms" return_type="void" export="shared">
doc:		<summary>Free array of once manifest strings.</summary>
doc:		<param name="oms_array" type="EIF_REFERENCE **">Array to free.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</routine>
*/
rt_shared void free_oms (EIF_REFERENCE **oms_array)
{
	uint32 i;

	if (oms_array) {
		i = eif_nb_org_routines;
		while (i > 0) {
			i --;
			if (oms_array[i]) {
				eif_free (oms_array[i]); /* have been allocated with eif_malloc */
			}
		}
	}
	eif_free (oms_array); /* have been allocated with eif_malloc */
}
#endif

rt_public void reclaim(void)
{
	/* At the end of the process's lifetime, all the objects need to be
	 * reclaimed, so that all the "dispose" procedures are called to perform
	 * their clean-up job (such as removing locks or temporary files).
	 * As all the objects are unmarked, we simply call full_sweep.
	 * There is no need to explode the scavenge zone as objects held there
	 * are known not to have any dispose routine (cf emalloc).
	 */

	EIF_GET_CONTEXT

#ifdef ISE_GC
	struct chunk *c, *cn;
#endif

	DISCARD_BREAKPOINTS;

#ifdef ISE_GC
	GC_THREAD_PROTECT(eif_terminate_all_other_threads());
#endif

		/* Mark final collection */
	eif_is_in_final_collect = EIF_TRUE;

	if (!has_reclaim_been_called) {
		has_reclaim_been_called = 1;

#if ! defined CUSTOM || defined NEED_OPTION_H
		if (egc_prof_enabled) {
			exitprf();			/* Store profile information */
		}
#endif

#ifdef ISE_GC
		if (!eif_no_reclaim && !(rt_g_data.status & GC_STOP)) {	/* Does user want no reclaim? */
#else
		if (!eif_no_reclaim) {
#endif

#ifdef RECLAIM_DEBUG
			fprintf(stderr, "reclaim: collecting all objects...\n");
#endif

#ifdef ISE_GC
			if (gen_scavenge & GS_ON) {		/* If generation scaveging was on */
				sc_stop();					/* Free 'to' and explode 'from' space */
			}

				/* Reset GC status otherwise plsc() might skip some memory blocks
				 * (those previously used as partial scavenging areas).
				 */
			rt_g_data.status = (char) 0;
				/* Call for the last time the GC through a `full_collect'. It enables
				 * the call to `dispose' routine of remaining objects which defines
				 * the dispose routine. 
				 * Ensures that `root_obj' is cleared.
				 */
			root_obj = NULL;
			plsc ();

#endif

			if (EIF_once_values != (EIF_once_value_t *) 0) {
				eif_free (EIF_once_values); /* have been allocated with eif_malloc */
				EIF_once_values = (EIF_once_value_t *) 0;
			}
#ifdef EIF_THREADS
			{
				int i = EIF_process_once_count;
				while (i > 0) {
					i--;
					eif_thr_mutex_destroy (EIF_process_once_values [i].mutex);
				}
			}

			if (EIF_process_once_values != (EIF_process_once_value_t *) 0) {
				eif_free (EIF_process_once_values); /* Free array of process-relative once results. */
			}
#endif
			FREE_ONCE_INDEXES; /* Free array of once indexes. */

			FREE_OMS (EIF_oms); /* Free array of once manifest strings */

			eif_free (starting_working_directory);
			eif_gen_conf_cleanup ();
#ifdef EIF_WINDOWS
			eif_cleanup(); 
			eif_free_dlls();
#endif /* EIF_WINDOWS */

#ifdef WORKBENCH
			dbreak_free_table ();
#endif

#ifdef EIF_THREADS 
			CHECK ("Root thread", eif_thr_is_root ());
			eif_thread_cleanup ();
#endif	/* EIF_THREADS */

#ifdef ISE_GC
			for (c = cklst.ck_head; c != (struct chunk *) 0; c = cn) {
				cn = c->ck_next;
				eif_free (c);	/* Previously allocated with eif_malloc. */
			}
			cklst.ck_head = (struct chunk *) 0;
#endif

#ifdef ISE_GC
#ifdef LMALLOC_CHECK
				eif_lm_display ();
				eif_lm_free ();
#endif	/* LMALLOC_CHECK */
#endif
		}
	}

		/* Final collection terminated, unmark the flag */
	eif_is_in_final_collect = EIF_FALSE;

	UNDISCARD_BREAKPOINTS;
}

#ifdef ISE_GC
rt_private void run_collector(void)
{
	/* Run the mark and sweep collectors, assuming the state is already set.
	 * Provision is made for generation scavenging, as this zone cannot be
	 * collected excepted by using a scavenging algorithm (with no aging).
	 */

	rt_g_data.nb_full++;	/* One more full collection */

#ifdef DEBUG
	fdone = rt_g_data.nb_full == NB_FULL;
	dprintf(1)("run_collector: gen_scavenge: 0x%lx, status: 0x%lx\n",
		gen_scavenge, rt_g_data.status);
	flush;
#endif

	/* If the root object address is void, only run a full sweep. At the end
	 * of the program (when the final disposal is run) or at the beginning
	 * (when allocating some memory in "optimized for memory" mode), the root
	 * object's address will be null and a mark phase does not really make
	 * sense--RAM.
	 */

	full_mark(MTC_NOARG);		/* Mark phase */
	full_update();		/* Update moved and remembered set (BEFORE sweep) */
	full_sweep();			/* Sweep phase */

	/* After a full collection (this routine is only called for a full mark
	 * and sweep or a partial scavenging), give generation scavenging a try
	 * again (in case it was stopped) by clearing the GS_STOP flag.
	 */

	if (gen_scavenge & GS_ON)		/* Generation scavenging is on */
		swap_gen_zones();			/* Swap generation zones */
	gen_scavenge &= ~GS_STOP;		/* Clear any stop flag */
	if (gen_scavenge == GS_OFF) {
			/* If generation scavenging is off, try to restore the scavenge zone
			 * so that they can be reused for next Eiffel object creation. */
		create_scavenge_zones();
	}

	ufill();		/* Eventually refill our urgent memory stock */

#ifdef DEBUG
	fdone = 0;		/* Do not trace any further */
#endif
}

rt_private void full_mark (EIF_CONTEXT_NOARG)
{
	/* Mark phase -- Starting from the root object and the subsidiary
	 * roots in the local stack, we recursively mark all the reachable
	 * objects. At the beginning of this phase, it is assumed that no
	 * object is marked.
	 */

#ifdef EIF_THREADS
	int i;
#endif
	int moving = rt_g_data.status & (GC_PART | GC_GEN);

		/* Initialize our overflow depth */
	overflow_stack_depth = 0;

		/* Perform marking */
	root_obj = MARK_SWITCH(&root_obj);	/* Primary root */

		/* Deal with once manifest strings. */
#ifndef EIF_THREADS
	mark_stack(&oms_set, MARK_SWITCH, moving);
#else
	for (i = 0; i < oms_set_list.count; i++)
		mark_stack(oms_set_list.threads.sstack[i], MARK_SWITCH, moving);
#endif

	internal_marking (MARK_SWITCH, moving);
}

rt_private void internal_marking(MARKER marking, int moving)
	/* Generic marking of all stacks. This code is common to `full_mark' and
	 * `mark_new_generation'
	 */
{
#ifdef EIF_THREADS
	int i;
#endif

#ifndef EIF_THREADS
	/* The regular Eiffel variables have their values stored directly within
	 * the loc_set stack. Those variables are the local roots for the garbage
	 * collection process.
	 */
	mark_stack(&loc_set, marking, moving);

	/* The stack of local variables holds the addresses of variables
	 * in the process's stack which refers to the objects, hence the
	 * double indirection necessary to reach the objects.
	 */
	mark_stack(&loc_stack, marking, moving);

	/* Once functions are old objects that are always alive in the system.
	 * They are all gathered in a stack and always belong to the old
	 * generation (thus they are allocated from the free-list). As with
	 * locals, a double indirection is necessary.
	 */
#if defined WORKBENCH
	mark_simple_stack(&once_set, marking, moving);
#else
	mark_stack(&once_set, marking, moving);
#endif

	/* The hector stacks record the objects which has been given to C and may
	 * have been kept by the C side. Those objects are alive, of course.
	 */
	mark_simple_stack(&hec_stack, marking, moving);
	mark_simple_stack(&hec_saved, marking, moving);

#ifdef WORKBENCH
	/* The operational stack of the interpreter holds some references which
	 * must be marked and/or updated.
	 */
	mark_op_stack(&op_stack, marking, moving);

	/* The exception stacks are scanned. It is more to update the references on
	 * objects than to ensure these objects are indeed alive...
	 */
	mark_ex_stack(&eif_stack, marking, moving);
	mark_ex_stack(&eif_trace, marking, moving);

#else
	if (exception_stack_managed) {
		/* The exception stacks are scanned. It is more to update the references on
		 * objects than to ensure these objects are indeed alive...
		 */
		mark_ex_stack(&eif_stack, marking, moving);
		mark_ex_stack(&eif_trace, marking, moving);
	}
#endif
#else /* EIF_THREADS */
	for (i = 0; i < loc_set_list.count; i++)
		mark_stack(loc_set_list.threads.sstack[i], marking, moving);

	for (i = 0; i < loc_stack_list.count; i++)
		mark_stack(loc_stack_list.threads.sstack[i], marking, moving);

	mark_stack(&global_once_set, marking, moving);

	for (i = 0; i < once_set_list.count; i++)
		mark_simple_stack(once_set_list.threads.sstack[i], marking, moving);

	for (i = 0; i < hec_stack_list.count; i++)
		mark_simple_stack(hec_stack_list.threads.sstack[i], marking, moving);
	for (i = 0; i < hec_saved_list.count; i++)
		mark_simple_stack(hec_saved_list.threads.sstack[i], marking, moving);

#ifdef WORKBENCH
	for (i = 0; i < opstack_list.count; i++)
		mark_op_stack(opstack_list.threads.opstack[i], marking, moving);
	for (i = 0; i < eif_stack_list.count; i++)
		mark_ex_stack(eif_stack_list.threads.xstack[i], marking, moving);
	for (i = 0; i < eif_trace_list.count; i++)
		mark_ex_stack(eif_trace_list.threads.xstack[i], marking, moving);

#else
	if (exception_stack_managed) {
		for (i = 0; i < eif_stack_list.count; i++)
			mark_ex_stack(eif_stack_list.threads.xstack[i], marking, moving);
		for (i = 0; i < eif_trace_list.count; i++)
			mark_ex_stack(eif_trace_list.threads.xstack[i], marking, moving);
	}
#endif

#endif /* EIF_THREADS */

#if ! defined CUSTOM || defined NEED_OBJECT_ID_H
#ifdef CONCURRENT_EIFFEL
	/* The separate_object_id_set records object referenced by other processors */
	mark_simple_stack(&separate_object_id_set, marking, moving);
#endif

	/* process overflow_stack_set */
	mark_overflow_stack(marking, moving);

	/* The object id stacks record the objects referenced by an identifier. Those objects
	 * are not necessarily alive. Thus only an update after a move is needed.
	 */
	if (moving) update_object_id_stack();
#endif
}

rt_private void mark_simple_stack(struct stack *stk, MARKER marker, int move)
									/* The stack which is to be marked */
									/* The routine used to mark objects */
				 					/* Are the objects expected to move? */
{
	/* Loop over the specified stack, using the supplied marker to recursively
	 * mark the objects. The 'move' flag is a flag which tells us whether the
	 * objects are expected to more or not (to avoid useless writing
	 * indirections). Stack holds direct references to objects.
	 */
#ifdef DEBUG
	EIF_GET_CONTEXT
#endif

	EIF_REFERENCE *object;		/* For looping over subsidiary roots */
	rt_uint_ptr roots;			/* Number of roots in each chunk */
	struct stchunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */

#ifdef DEBUG
	int saved_roots; EIF_REFERENCE *saved_object;
	dprintf(1)("mark_simple_stack: scanning %s stack for %s collector\n",
		stk == &loc_set ? "local" : (stk == &rem_set ? "remembered" : "other"),
		marker == GEN_SWITCH ? "generation" : "traditional");
	flush;
#endif

	if (stk->st_top == (EIF_REFERENCE *) 0)	/* Stack is not created yet */
		return;

	for (s = stk->st_hd; s && !done; s = s->sk_next) {
		object = s->sk_arena;					/* Start of stack */
		if (s != stk->st_cur)					/* Before current pos? */
			roots = s->sk_end - object;			/* The whole chunk */
		else {
			roots = stk->st_top - object;		/* Stop at the top */
			done = 1;							/* Reached end of stack */
		}

#ifdef DEBUG
		dprintf(2)("mark_simple_stack: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		saved_roots = roots; saved_object = object;
		if (DEBUG & 2 && debug_ok(2)) {
			int i; EIF_REFERENCE *obj = object;
			for (i = 0; i < roots; i++, obj++)
				printf("%d: 0x%lx\n", i, *obj);
		}
		flush;
#endif

		/* This is the actual marking! (hard to see in the middle of all those
		 * debug statement, so the only purpose of this comment is to catch
		 * the eye and spot the parsing code)--RAM.
		 */

		if (move) {
			for (; roots > 0; roots--, object++)
				*object = mark_expanded(*object, marker);
		} else {
			for (; roots > 0; roots--, object++)
				(void) mark_expanded(*object, marker);
		}
#ifdef DEBUG
		roots = saved_roots; object = saved_object;
		dprintf(2)("mark_simple_stack: after GC: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		if (DEBUG & 2 && debug_ok(2)) {
			int i; EIF_REFERENCE *obj = object;
			for (i = 0; i < roots; i++, obj++)
				printf("%d: 0x%lx\n", i, *obj);
		}
		flush;
#endif
	}
}

#if ! defined CUSTOM || defined NEED_OBJECT_ID_H
rt_private void update_object_id_stack(void)
{
	/* Loop over the specified stack to update the objects after a move.
	 * Stack holds direct references to objects.
	 * No marking is done, just the update, i.e. the objects are not roots
	 * for the GC.
	 */

	struct stack *stk = &object_id_stack;

	EIF_REFERENCE *object;		/* For looping over subsidiary roots */
	rt_uint_ptr roots;			/* Number of roots in each chunk */
	struct stchunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */

#ifdef DEBUG
	int saved_roots; EIF_REFERENCE *saved_object;
	dprintf(1)("mark_object_id_stack\n");
	flush;
#endif

	if (stk->st_top == (EIF_REFERENCE *) 0)	/* Stack is not created yet */
		return;

	for (s = stk->st_hd; s && !done; s = s->sk_next) {
		object = s->sk_arena;					/* Start of stack */
		if (s != stk->st_cur)					/* Before current pos? */
			roots = s->sk_end - object;			/* The whole chunk */
		else {
			roots = stk->st_top - object;		/* Stop at the top */
			done = 1;							/* Reached end of stack */
		}

#ifdef DEBUG
		dprintf(2)("mark_object_id_stack: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		saved_roots = roots; saved_object = object;
		if (DEBUG & 2 && debug_ok(2)) {
			int i; EIF_REFERENCE *obj = object;
			for (i = 0; i < roots; i++, obj++)
				printf("%d: 0x%lx\n", i, *obj);
		}
		flush;
#endif

		for (; roots > 0; roots--, object++)
			{
			register char* root;
			register union overhead *zone;

			root = *object;
			if (root != (EIF_REFERENCE)0){
				zone = HEADER(root);
					/* If the object has moved, update the stack */
				if (zone->ov_size & B_FWD)
					*object = zone->ov_fwd;
				}
			}

#ifdef DEBUG
		roots = saved_roots; object = saved_object;
		dprintf(2)("mark_object_id_stack: after GC: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		if (DEBUG & 2 && debug_ok(2)) {
			int i; EIF_REFERENCE *obj = object;
			for (i = 0; i < roots; i++, obj++)
				printf("%d: 0x%lx\n", i, *obj);
		}
		flush;
#endif
	}
}
#endif /* !CUSTOM || NEED_OBJECT_ID_H */

rt_private void mark_stack(struct stack *stk, MARKER marker, int move)
									/* The stack which is to be marked */
									/* The routine used to mark objects */
				 					/* Are the objects expected to move? */
{
	/* Loop over the specified stack, using the supplied marker to recursively
	 * mark the objects. The 'move' flag is a flag which tells us whether the
	 * objects are expected to move or not (to avoid useless writing
	 * indirections). Stack holds indirect references to objects.
	 */
#ifdef DEBUG
	EIF_GET_CONTEXT
#endif
	EIF_REFERENCE *object;		/* For looping over subsidiary roots */
	rt_uint_ptr roots;			/* Number of roots in each chunk */
	struct stchunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */

#ifdef DEBUG
	int saved_roots; EIF_REFERENCE *saved_object;
	dprintf(1)("mark_stack: scanning %s stack for %s collector\n",
		stk == &loc_stack ? "local (indirect)" : "once",
		marker == GEN_SWITCH ? "generation" : "traditional");
	flush;
#endif

	if (stk->st_top == (EIF_REFERENCE *) 0)	/* Stack is not created yet */
		return;

	for (s = stk->st_hd; s && !done; s = s->sk_next) {
		object = s->sk_arena;					/* Start of stack */
		if (s != stk->st_cur)					/* Before current pos? */
			roots = s->sk_end - object;			/* The whole chunk */
		else {
			roots = stk->st_top - object;		/* Stop at the top */
			done = 1;							/* Reached end of stack */
		}

#ifdef DEBUG
		dprintf(2)("mark_stack: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		saved_roots = roots; saved_object = object;
		if (DEBUG & 2 && debug_ok(2)) {
			int i; EIF_REFERENCE *obj = object;
			for (i = 0; i < roots; i++, obj++)
				printf("%d: 0x%lx\n", i, *(EIF_REFERENCE *) *obj);
		}
		flush;
#endif

		if (move) {
			for (; roots > 0; roots--, object++)
				*(EIF_REFERENCE *) *object = mark_expanded(*(EIF_REFERENCE *) *object, marker);
		} else {
			for (; roots > 0; roots--, object++)
				(void) mark_expanded(*(EIF_REFERENCE *) *object, marker);
		}

#ifdef DEBUG
		roots = saved_roots; object = saved_object;
		dprintf(2)("mark_stack: after GC: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		if (DEBUG & 2 && debug_ok(2)) {
			int i; EIF_REFERENCE *obj = object;
			for (i = 0; i < roots; i++, obj++)
				printf("%d: 0x%lx\n", i, * (EIF_REFERENCE *) *obj);
		}
		flush;
#endif
	}
}

rt_private EIF_REFERENCE mark_expanded(EIF_REFERENCE root, MARKER marker)
		 				/* Expanded reference to be marked */
						/* The routine used to mark objects */
{
	/* The main invariant from the GC is: "expanded objects are only referenced
	 * once, therefore they are not marked and must be traversed only once".
	 * Here, the operational stack may reference expanded objects directly,
	 * hence jeopardizing the invariant. This routine will ask for a traversal
	 * of the enclosing object and then update the reference to the expanded
	 * should the enclosing object have moved.
	 */

	EIF_REFERENCE enclosing;	/* Address of the enclosing object */
	EIF_REFERENCE new;			/* New address of the enclosing object */
	rt_uint_ptr offset;		/* Offset of the expanded object within enclosing one */
	union overhead *zone;

	if (root == (EIF_REFERENCE) 0)
		return (EIF_REFERENCE) 0;

	zone = HEADER(root);			/* Malloc info zone */

	if (zone->ov_size & B_FWD)
		return zone->ov_fwd;		/* Already forwarded, i.e. traversed */

	if (!(zone->ov_flags & EO_EXP)) {
			/* It is guaranteed that first call to `marker' will not put it
			 * in `overflow_stack_set', therefore giving the address of
			 * `root' is ok. */
		return (marker)(&root);		/* Mark non-expanded objects directly */
	}

		/* Expanded in the call stack have a size of `0' therefore
		 * the following code is still safe because it is just equivalent to
		 * marking `root'. */
	offset = zone->ov_size & B_SIZE;
	enclosing = root - offset;

		/* See remark above for `overflow_stack_set' */
	new = (marker)(&enclosing);		/* Traverse enclosing, save new location */
	if (new == enclosing)			/* Object did not move */
		return root;				/* Neither did the expanded object */

	return new + offset;			/* New address of the expanded object */
}

/* Start of workbench-specific marking functions */
#ifdef WORKBENCH
rt_private void mark_op_stack(struct opstack *stk, MARKER marker, int move)
									/* The routine used to mark objects */
				 					/* Are the objects expected to move? */
{
	/* Loop over the operational stack (the one used by the interpreter) and
	 * mark all the references found.
	 */

	struct item *last;	/* For looping over subsidiary roots */
	rt_uint_ptr roots;			/* Number of roots in each chunk */
	struct stochunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */

#ifdef DEBUG
	int saved_roots; struct item *saved_last;
	dprintf(1)("mark_op_stack: scanning operational stack for %s collector\n",
		marker == GEN_SWITCH ? "generation" : "traditional");
	flush;
#endif

	/* There is no need to check for the existence of the operational stack:
	 * we know it has already been created.
	 */

	for (s = stk->st_hd; s && !done; s = s->sk_next) {
		last = s->sk_arena;						/* Start of stack */
		if (s != stk->st_cur)				/* Before current pos? */
			roots = s->sk_end - last;			/* The whole chunk */
		else {
			roots = stk->st_top - last;		/* Stop at the top */
			done = 1;							/* Reached end of stack */
		}

#ifdef DEBUG
		dprintf(2)("mark_op_stack: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		saved_roots = roots; saved_last = last;
		if (DEBUG & 2 && debug_ok(2)) {
			int i; struct item *lst = last;
			for (i = 0; i < roots; i++, lst++) {
				switch (lst->type & SK_HEAD) {
				case SK_EXP: printf("\t%d: expanded 0x%lx\n", i, lst->it_ref); break;
				case SK_REF: printf("\t%d: 0x%lx\n", i, lst->it_ref); break;
				case SK_BOOL: printf("\t%d: bool %s\n", i, lst->it_char ? "true" : "false"); break;
				case SK_CHAR: printf("\t%d: char %d\n", i, lst->it_char); break;
				case SK_WCHAR: printf("\t%d: wide char %lu\n", i, lst->it_wchar); break;
				case SK_UINT8: printf("\t%d: uint8 %ld\n", i, lst->it_uint8); break;
				case SK_UINT16: printf("\t%d: uint16 %ld\n", i, lst->it_uint16); break;
				case SK_UINT32: printf("\t%d: uint32 %ld\n", i, lst->it_uint32); break;
				case SK_UINT64: printf("\t%d: uint64 %ld\n", i, lst->it_uint64); break;
				case SK_INT8: printf("\t%d: int8 %ld\n", i, lst->it_int8); break;
				case SK_INT16: printf("\t%d: int16 %ld\n", i, lst->it_int16); break;
				case SK_INT32: printf("\t%d: int32 %ld\n", i, lst->it_int32); break;
				case SK_INT64: printf("\t%d: int64 %ld\n", i, lst->it_int64); break;
				case SK_REAL32: printf("\t%d: real32 %f\n", i, lst->it_real32); break;
				case SK_REAL64: printf("\t%d: real64 %lf\n", i, lst->it_real64); break;
				case SK_BIT: printf("\t%d: BITS\n", i); break;
				case SK_POINTER: printf("\t%d: pointer 0x%lx\n", i, lst->it_ref); break;
				case SK_VOID: printf("\t%d: void\n", i); break;
				default:
					printf("\t%d: UNKNOWN TYPE 0x%lx\n", i, lst->type);
				}
			}
		}
		flush;
#endif

		if (move)
			for (; roots > 0; roots--, last++)		/* Objects may be moved */
				switch (last->type & SK_HEAD) {		/* Type in stack */
				case SK_REF:						/* Reference */
				case SK_EXP:
				case SK_BIT:
					last->it_ref = mark_expanded(last->it_ref, marker);
					break;
				}
		else
			for (; roots > 0; roots--, last++) 		/* Objects cannot move */
				switch (last->type & SK_HEAD) {		/* Type in stack */
				case SK_REF:						/* Reference */
				case SK_EXP:
				case SK_BIT:
					(void) mark_expanded(last->it_ref, marker);
					break;
				}

#ifdef DEBUG
		roots = saved_roots;
		last = saved_last;
		dprintf(2)("mark_op_stack: after GC: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		if (DEBUG & 2 && debug_ok(2)) {
			int i; struct item *lst = last;
			for (i = 0; i < roots; i++, lst++) {
				switch (lst->type & SK_HEAD) {
				case SK_EXP: printf("\t%d: expanded 0x%lx\n", i, lst->it_ref); break;
				case SK_REF: printf("\t%d: 0x%lx\n", i, lst->it_ref); break;
				case SK_BOOL: printf("\t%d: bool %s\n", i, lst->it_char ? "true" : "false"); break;
				case SK_CHAR: printf("\t%d: char %d\n", i, lst->it_char); break;
				case SK_WCHAR: printf("\t%d: wide char %lu\n", i, lst->it_wchar); break;
				case SK_UINT8: printf("\t%d: uint8 %ld\n", i, lst->it_uint8); break;
				case SK_UINT16: printf("\t%d: uint16 %ld\n", i, lst->it_uint16); break;
				case SK_UINT32: printf("\t%d: uint32 %ld\n", i, lst->it_uint32); break;
				case SK_UINT64: printf("\t%d: uint64 %ld\n", i, lst->it_uint64); break;
				case SK_INT8: printf("\t%d: int %ld\n", i, lst->it_int8); break;
				case SK_INT16: printf("\t%d: int %ld\n", i, lst->it_int16); break;
				case SK_INT32: printf("\t%d: int %ld\n", i, lst->it_int32); break;
				case SK_INT64: printf("\t%d: int %ld\n", i, lst->it_int64); break;
				case SK_REAL32: printf("\t%d: real32 %f\n", i, lst->it_real32); break;
				case SK_REAL64: printf("\t%d: real64 %lf\n", i, lst->it_real64); break;
				case SK_BIT: printf("\t%d: BITS\n", i); break;
				case SK_POINTER: printf("\t%d: pointer 0x%lx\n", i, lst->it_ref); break;
				case SK_VOID: printf("\t%d: void\n", i); break;
				default:
					printf("\t%d: UNKNOWN TYPE 0x%lx\n", i, lst->type);
				}
			}
		}
		flush;
#endif

	}
}
#endif
/* End of workbench-specific marking functions */

rt_private void mark_ex_stack(struct xstack *stk, MARKER marker, int move)
							 		/* The stack which is to be marked */
									/* The routine used to mark objects */
				 					/* Are the objects expected to move? */
{
	/* Loop over the exception stacks (the one used by the exception handling
	 * mechanism) and update all the references found. Those references are
	 * alive, so the sole purpose of this traversal is to update the pointers
	 * when objects are moved around.
	 */

#ifdef DEBUG
	RT_GET_CONTEXT
#endif

	struct ex_vect *last;	/* For looping over subsidiary roots */
	rt_uint_ptr roots;			/* Number of roots in each chunk */
	struct stxchunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */

#ifdef DEBUG
	dprintf(1)("mark_ex_stack: scanning exception %s stack for %s collector\n",
		stk == &eif_trace ? "trace" : "vector",
		marker == GEN_SWITCH ? "generation" : "traditional");
	flush;
#endif

	if (stk->st_top == (struct ex_vect *) 0)
		return;						/* Stack is not created yet */

	for (s = stk->st_hd; s && !done; s = s->sk_next) {
		last = s->sk_arena;					/* Start of stack */
		if (s != stk->st_cur)				/* Before current pos? */
			roots = s->sk_end - last;		/* The whole chunk */
		else {
			roots = stk->st_top - last;		/* Stop at the top */
			done = 1;						/* Reached end of stack */
		}
		if (move)
			for (; roots > 0; roots--, last++)
				switch (last->ex_type) {			/* Type in stack */
					/* The following are meaningful when printing the exception
					 * trace: the first set records the enclosing calls, the
					 * second records the failed preconditions (because in that
					 * case, the enclosing call does not appear in the printed
					 * stack).
					 */
					case EX_CALL: case EN_FAIL:
					case EX_RESC: case EN_RESC:
					case EX_RETY: case EN_RES:
						last->ex_id = mark_expanded(last->ex_id, marker);
						break;
					/* Do not inspect EX_PRE records. They do not carry any
					 * valid object ID, which is put in the EN_PRE vector by
					 * backtrack (the precondition failure raises exception in
					 * caller).
					 */
					case EN_PRE:
					case EX_CINV: case EN_CINV:
						last->ex_oid = mark_expanded(last->ex_oid, marker);
						break;
				}
		else
			for (; roots > 0; roots--, last++)
				switch (last->ex_type) {			/* Type in stack */
					/* The following are meaningful when printing the exception
					 * trace: the first set records the enclosing calls, the
					 * second records the failed preconditions (because in that
					 * case, the enclosing call does not appear in the printed
					 * stack).
					 */
					case EX_CALL: case EN_FAIL:
					case EX_RESC: case EN_RESC:
					case EX_RETY: case EN_RES:
						(void) mark_expanded(last->ex_id, marker);
						break;
					/* Do not inspect EX_PRE records. They do not carry any
					 * valid object ID, which is put in the EN_PRE vector by
					 * backtrack (the precondition failure raises exception in
					 * caller).
					 */
					case EN_PRE:
					case EX_CINV: case EN_CINV:
						(void) mark_expanded(last->ex_oid, marker);
						break;
				}
			
	}
}

rt_private void mark_overflow_stack(MARKER marker, int move)
	/* The routine used to mark objects */
	/* Are the objects expected to move? */
{
	/* Overflow stack management:
	 * --------------------------
	 *
	 * During the marking phase, each time we reach a depth of `overflow_stack_limit' we stop
	 * the recursion on the marking routines. What we do instead is to store the location
	 * where the reference to the object is stored and we insert it in `overflow_stack_set'.
	 * Then we continue with our marking. As a consequence the marking phase has
	 * a stack depth which is bounded to `current_stack_depth + overflow_stack_limit'.
	 *
	 * When all structures have been marked, we are marking in an iterative manner
	 * all objects stored in `stk' a copy of `overflow_stack_set'. Same things here,
	 * if we reach the maximum depth during marking, we add the item to a freshly created
	 * copy of `overflow_stack_set'. We repeat this process until there are no more
	 * objects added to `overflow_stack_set'.
	 *
	 * Note the trick is to store the address of where the object is referenced from.
	 * Without it we would not be able to resolve all references to moved objects during
	 * marking.
	 */

	/* Loop over the `overflow_stack_set' stack, using the supplied marker to recursively
	 * mark the objects. The 'move' flag is a flag which tells us whether the
	 * objects are expected to move or not (to avoid useless writing
	 * indirections). Stack holds indirect references to objects.
	 */
	EIF_REFERENCE *object;		/* For looping over subsidiary roots */
	rt_uint_ptr roots;			/* Number of roots in each chunk */
	struct stchunk *s;	/* To walk through each stack's chunk */
	struct stack stk;				/* Copy of current `overflow_stack_set' */
	int done;						/* Top of stack not reached yet */

	while (overflow_stack_count > 0) {
			/* Copy `overflow_stack' to `stk', as we will iterate through `stk'.
			 * We do this process as long as `overflow_stack_count' is not null. */
		memcpy(&stk, &overflow_stack_set, sizeof(struct stack));
		memset(&overflow_stack_set, 0, sizeof(struct stack));
		overflow_stack_count = 0;
		done = 0;

		CHECK("Stack created", stk.st_top != NULL);	/* Stack should be created since count > 0 */

		for (s = stk.st_hd; s && !done; s = s->sk_next) {
			object = s->sk_arena;					/* Start of stack */
			if (s != stk.st_cur)					/* Before current pos? */
				roots = s->sk_end - object;			/* The whole chunk */
			else {
				roots = stk.st_top - object;		/* Stop at the top */
				done = 1;							/* Reached end of stack */
			}

			if (move) {
				for (; roots > 0; roots--, object++)
					*(EIF_REFERENCE *) *object = mark_expanded(*(EIF_REFERENCE *) *object, marker);
			} else {
				for (; roots > 0; roots--, object++)
					(void) mark_expanded(*(EIF_REFERENCE *) *object, marker);
			}
		}

			/* Free memory used by stack as we don't need it anymore */
		st_reset(&stk);
	}

	ENSURE ("Overflow stack empty", overflow_stack_count == 0);
}


rt_private EIF_REFERENCE hybrid_mark(EIF_REFERENCE *a_root)
{
	/* Mark all the objects referenced by the root object.
	 * All the attributes of an object are recursively marked,
	 * except the last one. This brings a noticeable
	 * improvement with structures like LINKED_LIST when its `right'
	 * part is the last reference (note this is not always the case).
	 * It also prevents stack overflow with the `overflow_stack_set'.
	 */
	union overhead *zone;		/* Malloc info zone fields */
	uint32 flags;				/* Eiffel flags */
	long offset;				/* Reference's offset */
	rt_uint_ptr size;				/* Size of an item (for array of expanded) */
	EIF_REFERENCE *object;				/* Sub-objects scanned */
	EIF_REFERENCE current;				/* Object currently inspected */
	EIF_REFERENCE *prev;				/* Holder of current (for update) */
	EIF_REFERENCE root = *a_root;		/* Root object */
	long count;					/* Number of references */

	/* If 'root' is a void reference, return immediately. This is redundant
	 * with the beginning of the loop, but this case occurs quite often.
	 */
	if (root == (EIF_REFERENCE) 0)
		return (EIF_REFERENCE) 0;

		/* Stack overflow protection */
	overflow_stack_depth++;
	if (overflow_stack_depth > overflow_stack_limit) {
		epush(&overflow_stack_set, a_root);
		overflow_stack_count++;
		overflow_stack_depth--;
		return root;
	}

	/* Initialize the variables for the loop */
	current = root;
	prev = (EIF_REFERENCE *) 0;

	do {
		if (current == (EIF_REFERENCE) 0)		/* No further exploration */
			goto done;					/* Exit the procedure */

		zone = HEADER(current);			/* Malloc info zone */
		flags = zone->ov_flags;			/* Fetch Eiffel flags */

#ifdef DEBUG
	if (zone->ov_size & B_FWD) {
		dprintf(16)("hybrid_mark: 0x%lx fwd to 0x%lx (DT %d, %d bytes)\n",
			current,
			zone->ov_fwd,
			HEADER(zone->ov_fwd)->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	} else {
		dprintf(16)("hybrid_mark: 0x%lx %s%s%s(DT %d, %d bytes)\n",
			current,
			zone->ov_flags & EO_MARK ? "marked " : "",
			zone->ov_flags & EO_OLD ? "old " : "",
			zone->ov_flags & EO_REM ? "remembered " : "",
			zone->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	}
	flush;
#endif

		/* Deal with scavenging here, namely scavenge the reached object if it
		 * belongs to a 'from' space. Leave a forwarding pointer behind and mark
		 * the object as forwarded. Scavenging while marking avoids another pass
		 * for scavenging the 'from' zone and another entire pass to update the
		 * references, so it should be a big win--RAM. Note that scavenged
		 * objects are NOT marked: the fact that they have been forwarded is the
		 * mark. The expanded objects are never scavenged (only the object which
		 * holds them is).
		 */
		offset = (uint32) rt_g_data.status;		/* Garbage collector's status */

		if (offset & (GC_PART | GC_GEN)) {

			/* If we enter here, then we are currently running a scavenging
			 * algorithm of some sort. Depending on the garbage collector's
			 * flag, we are able to see if the current object is in a 'from'
			 * zone (i.e. has to be scavenged). Note that the generation
			 * scavenging process does not usually call this routine (tenuring
			 * can fail, and we are in a process that is not allowed to fail).
			 * Here, the new generation is simply scavenged, with no tenuring.
			 * Detecting whether an object is in the scavenge zone or not is
			 * easy and fast: all the objects in the scavenge zone have their
			 * B_BUSY flag reset.
			 */

			size = zone->ov_size;
			if (size & B_FWD) {			/* Can't be true if expanded */
				if(prev)				/* Update the referencing address */
					*prev = zone->ov_fwd;
				goto done;				/* So it has been already processed */
			}

			if (flags & (EO_MARK | EO_C))	/* Already marked or C object */
				goto done;				/* Object processed and did not move */

			if (offset & GC_GEN && !(size & B_BUSY)) {
				current = scavenge(current, &sc_to.sc_top);	/* Simple scavenging */
				zone = HEADER(current);					/* Update zone */
				flags = zone->ov_flags;					/* And Eiffel flags */
				if (prev)					/* Update referencing pointer */
					*prev = current;
				goto marked;
			} else
				if
					((offset & GC_PART) && (current > ps_from.sc_arena && current <= ps_from.sc_end) &&
					 (ps_to.sc_top + ((size & B_SIZE) + OVERHEAD) <= ps_to.sc_end))
				{
						/* Record location of previous `top' which will be used to set the
						 * B_LAST flag at the end of the scavenging. */
					ps_to.sc_previous_top = ps_to.sc_top;
					current = scavenge(current, &ps_to.sc_top);/* Partial scavenge */
					zone = HEADER(current);				/* Update zone */
					flags = zone->ov_flags;				/* And Eiffel flags */
					if (prev)
						*prev = current;	/* Update referencing pointer */
					goto marked;
				}
		}

		/* This part of code, until the 'marked' label is executed only when the
		 * object does not belong any scavenging space, or no scavenging is to
		 * ever be done.
		 */

		/* If current object is already marked, it has been (or is)
		 * studied. So return immediately. Idem if object is a C one.
		 */
		if (flags & (EO_MARK | EO_C))
			goto done;


		/* Expanded objects have no 'ov_size' field. Instead, they have a
		 * pointer to the object which holds them. This is needed by the
		 * scavenging process, so that we can update the internal references
		 * to the expanded in the scavenged object.
		 * It's useless to mark an expanded, because it has only one reference
		 * on itself, in the object which holds it.
		 */
		if (!(flags & EO_EXP)) {
			flags |= EO_MARK;
			zone->ov_flags = flags;
		}

marked: /* Goto label needed to avoid code duplication */

		/* Now explore all the references of the current object.
		 * For each object of type 'type', References(type) gives the number
		 * of references in the objects. The references are placed at the
		 * beginning of the data space by the Eiffel compiler. Expanded
		 * objects have a reference to them, so no special treatment is
		 * required. Special objects full of references are also explored.
		 */

		if (flags & EO_SPEC) {
			EIF_REFERENCE o_ref;

			/* Special objects may have no references (e.g. an array of
			 * integer or a string), so we have to skip those.
			 */

			if (!(flags & EO_REF)) /* If object moved, reference updated */
				goto done;

			/* At the end of the special data zone, there are two long integers
			 * which give informations to the run-time about the content of the
			 * zone: the first is the 'count', i.e. the number of items, and the
			 * second is the size of each item (for expandeds, the overhead of
			 * the header is not taken into account).
			 */
			o_ref = RT_SPECIAL_INFO_WITH_ZONE(current, zone);
			count = offset = RT_SPECIAL_COUNT_WITH_INFO(o_ref);	/* Get # of items */

			if (flags & EO_TUPLE) {
				EIF_TYPED_ELEMENT *l_item = (EIF_TYPED_ELEMENT *) current;
					/* Don't forget that first element of TUPLE is just a placeholder
					 * to avoid offset computation from Eiffel code */
				l_item++;
				offset--;
				if (rt_g_data.status & (GC_PART | GC_GEN)) {
					for (; offset > 1; offset--, l_item++ ) {
						if (eif_tuple_item_type(l_item) == EIF_REFERENCE_CODE) {
							eif_reference_tuple_item(l_item) =
								hybrid_mark (&eif_reference_tuple_item(l_item));
						}
					}
				} else {
					for (; offset > 1; offset--, l_item++ ) {
						if (eif_tuple_item_type(l_item) == EIF_REFERENCE_CODE) {
							(void) hybrid_mark(&eif_reference_tuple_item(l_item));
						}
					}		
				}
				if ((count >= 1) && (eif_tuple_item_type(l_item) == EIF_REFERENCE_CODE)) {
						/* If last element of TUPLE is a reference, then we continue the
						 * iteration. */
					prev = &eif_reference_tuple_item(l_item);
					current = eif_reference_tuple_item(l_item);
					continue;
				} else
					goto done;		/* End of iteration; exit procedure */
			} else if (flags & EO_COMP) {
				/* Treat arrays of expanded object here, because we have a special
				 * way of looping over the array (we must take the size of each item
				 * into account). Code below is somewhat duplicated with the normal
				 * code for regular objects or arrays of references, but this is
				 * because we have to increment our pointers by size and I do not
				 * want to to slow down the normal loop--RAM.
				 */
				size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ref);	/* Item's size */
				if (rt_g_data.status & (GC_PART | GC_GEN)) {	/* Moving objects */
					object = (EIF_REFERENCE *) (current + OVERHEAD);/* First expanded */
					for (; offset > 1; offset--) {		/* Loop over array */
						*object = hybrid_mark(object);
						object = (EIF_REFERENCE *) ((char *) object + size);
					}
				} else {								/* Object can't move */
					object = (EIF_REFERENCE *) (current + OVERHEAD);/* First expanded */
					for (; offset > 1; offset--) {		/* Loop over array */
						(void) hybrid_mark(object);
						object = (EIF_REFERENCE *) ((char *) object + size);
					}
				}
				/* Keep iterating if and only if the current object has at
				 * least one attribute.
				 */
				if (count >= 1) {
					prev = object;
					current = *object;
					continue;
				} else
					goto done;		/* End of iteration; exit procedure */
			}

		} else
			count = offset = References(Deif_bid(flags));	/* # items */

#ifdef DEBUG
	dprintf(16)("hybrid_mark: %d references for 0x%lx\n", offset, current);
	if (DEBUG & 16 && debug_ok(16)) {
		int i;
		for (i = 0; i < offset; i++)
			printf("\t0x%lx\n", *((EIF_REFERENCE *) current + i));
	}
	flush;
#endif

		/* Mark all objects under root, updating the references if scavenging */

		if (rt_g_data.status & (GC_PART | GC_GEN))
			for (object = (EIF_REFERENCE *) current; offset > 1; offset--, object++)
				*object = hybrid_mark(object);
		else
			for (object = (EIF_REFERENCE *) current; offset > 1; offset--, object++)
				(void) hybrid_mark(object);

		if (count >= 1) {
			prev = object;
			current = *object;
		} else
			goto done;

	} while(current);

done:
	/* Return the [new] address of the root object */
	zone = HEADER(root);
	overflow_stack_depth--;
	return ((zone->ov_size & B_FWD) ? zone->ov_fwd : root);
}

rt_private void full_sweep(void)
{
	/* Sweep phase -- All the reachable objects have been marked, so
	 * all we have to do is scan all the objects and look for garbage.
	 * The remaining objects are unmarked. If partial scavenging is on,
	 * the 'from' and 'to' spaces are left untouched (the objects in the
	 * 'to' space are unmarked but alive...).
	 */
	union overhead *zone;		/* Malloc info zone */
	rt_uint_ptr size;				/* Object's size in bytes */
	EIF_REFERENCE end;				/* First address beyond chunk */
	uint32 flags;				/* Eiffel flags */
	struct chunk *chunk;		/* Current chunk */
	EIF_REFERENCE arena;				/* Arena in chunk */

	/* We start the sweeping at the end of the memory, and we walk
	 * backawrds along the chunk list. That way, the freed objects
	 * are inserted at the beginning of the free list (which is kept
	 * in increasing order). If I did it the other way round, then
	 * the first freed objects would be inserted at the beginning but
	 * the last one would take much more time to get inserted, not to
	 * mention all the paging problems that could be involved--RAM.
	 */

	for (chunk = cklst.ck_tail; chunk; chunk = chunk->ck_prev) {

		arena = (EIF_REFERENCE) (chunk + 1);

		/* Skip the scavenge zones, if they exist and we are in a partial
		 * scavenge: (objects there have to go back to the free list only if
		 * the chunk is not completely free, i.e. if it has C blocks in it).
		 * The 'to' zone is full of 'alive' objects, but they are unmarked...
		 * There is no special consideration for generation scavenging,
		 * because the blocks which hold these zone are C ones.
		 *
		 * In non-partial scavenging mode, then only the 'to' has to be skipped:
		 * the scavenge zone are unused in this mode, but 'to' contains a bunch
		 * of objects which should be dead (it was surely a 'from' during the
		 * last scavenging cycle).
		 */

		if (arena == ps_to.sc_arena) {
				/* Only traverse the bottom part of `ps_to' which
				 * is actually not used as a `to' zone for partial scavenging. */
			end = ps_to.sc_active_arena;
		} else if ((rt_g_data.status & GC_PART) && (arena == ps_from.sc_arena)) {
			continue;
		} else {
			end = (EIF_REFERENCE) arena + chunk->ck_length;	/* Chunk's tail */
		}

		/* Objects are not chained together, so the only way to walk
		 * through them is to use the size field of each block. C blocks
		 * have to be skipped. The main disadvantage of this mechanism is
		 * that it involves swapping, but this is the price to pay to have
		 * only an 8 bytes header--RAM.
		 */

		for (
			zone = (union overhead *) arena;
			(EIF_REFERENCE) zone < end;
			zone = (union overhead *) (((EIF_REFERENCE) zone) + size + OVERHEAD)
		) {
			size = zone->ov_size;			/* Size and flags */

			if (!(size & B_BUSY)) {
				/* Object belongs to the free list (not busy).
				 */
				size &= B_SIZE;				/* Keep only pure size */
				continue;					/* Skip block */
			}


			if (size & B_C) {
				/* Object is a C one.
				 * However, any Eiffel object (i.e. any object not bearing
				 * the EO_C mark) is marked during the marking phase and has
				 * to be unmarked now. It is not freed however, since it is
				 * marked B_C and hence is under user control. Moreover, we
				 * would not be able to remove the reference from hector.
				 */
				size &= B_SIZE;				/* Keep only pure size */
				zone->ov_flags &= ~EO_MARK;	/* Unconditionally unmark it */
				continue;					/* Skip block */
			}

			size &= B_SIZE;					/* Remove block flags */
			flags = zone->ov_flags;			/* Fetch Eiffel flags */

			if (flags & EO_MARK) { 					/* Object is marked */
				zone->ov_flags = flags & ~EO_MARK;	/* Unmark it */
				continue;							/* And skip it */
			}

			/* Expanded objects are within normal objects and therefore
			 * cannot be explicitely removed. I assume it is impossible
			 * to reference an expanded object directly (via another object
			 * reference)--RAM.
			 */

			gfree(zone);		/* Object is freed */
#ifdef FULL_SWEEP_DEBUG
		printf("FULL_SWEEP: Removing 0x%x (type %d, %d bytes) %s %s %s %s %s %s %s, age %ld\n",
			(union overhead *) zone + 1,
			HEADER( (union overhead *) zone + 1 )->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE,
			((union overhead *) zone + 1),
			zone->ov_size & B_FWD ? "forwarded" : "",
			zone->ov_flags & EO_MARK ? "marked" : "",
			zone->ov_flags & EO_REF ? "ref" : "",
			zone->ov_flags & EO_COMP ? "cmp" : "",
			zone->ov_flags & EO_SPEC ? "spec" : "",
			zone->ov_flags & EO_NEW ? "new" : "",
			zone->ov_flags & EO_OLD ? "old" : "",
			((zone->ov_flags & EO_AGE) >> 24) / 2);
		

#endif	/* FULL_SWEEP_DEBUG */
		}
	}

	/* The Hector stack has to be traversed to call `dispose' on protected objects 
	 * Standard dispose traversal checks for Eiffel objects, frozen obj are 
	 * marked as C obj thus ignored. The other stacks are referencing "moving" 
	 * objects so there's no problem */
}

rt_private void full_update(void)
{
	/* After a mark and sweep, eventually mixed with scavenging, the data
	 * structures which are used to describe the generations have to be
	 * updated, in case the references changed or some objects died.
	 * An object is considered to be alive iff it carries the EO_MARK bit
	 * or if it has been forwarded. The references are updated in that case.
	 * The routines rely on the garbage collector's status flag to do the
	 * proper job.
	 */

	update_moved_set();
	update_rem_set();		/* Must be done after moved set (for GC_FAST) */
	update_memory_set ();
}
#endif /* ISE_GC */


/*
doc:	<routine name="plsc" export="public">
doc:		<summary>Mixed strategy garbage collector (mark and sweep plus scavenging). This can also be qualified as a storage compaction garbage collector. The partial scavenging entry point, which is monitored for statistics updating (available to the user via MEMORY).</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Synchronization done through `scollect'.</synchronization>
doc:	</routine>
*/

rt_public void plsc(void)
{
#ifdef ISE_GC
	if (rt_g_data.status & GC_STOP)
		return;				/* Garbage collection stopped */

	(void) scollect(partial_scavenging, GST_PART);
#endif /* ISE_GC */
}

#ifdef ISE_GC
rt_private int partial_scavenging(void)
{
	/* Partial Scavenging -- Implementation of the INRIA algorithm
	 * Lang-Dupont 1987. The idea is to do a full mark and sweep for
	 * most of the memory, the 'from' space excepted. This space is
	 * scavenged to the 'to' space, thus doing storage compaction.
	 * Note that for efficiency reasons and for the memory update to
	 * work correctly, 'from' MUST be the address of the first block
	 * of a memory chunk (because this zone is skipped by doing pointer
	 * comparaisons).
	 */
	RT_GET_CONTEXT

	SIGBLOCK;				/* Block all signals during garbage collection */
	init_plsc();			/* Initialize scavenging (find 'to' space) */
	run_plsc();				/* Normal sequence */
	rel_core();				/* We may give some core back to the kernel */
	eiffel_usage = 0;		/* Reset Eiffel memory allocated since last collection */
	SIGRESUME;				/* Dispatch any signal which has been queued */
	return 0;
}

rt_private void run_plsc(void)
{
		/* This routine actually invokes the partial scavenging. */
	run_collector();		/* Call a wrapper to do the job */
		/* Clean up `from' and `to' scavenge zone if a partial scavenging is done, not
		 * a simple mark and sweep. */
	if (rt_g_data.status & GC_PART) {
		clean_zones();			/* Clean up 'from' and 'to' scavenge zonse */
	}
}

rt_shared void urgent_plsc(EIF_REFERENCE *object)
{
	/* Perform an urgent partial scavenging, taking 'object' as a pointer
	 * to the address of a variable holding a reference to an Eiffel object
	 * which must be part of the local roots for the collector.
	 */

	RT_GET_CONTEXT
	if ((rt_g_data.status & GC_STOP) GC_THREAD_PROTECT(|| !thread_can_launch_gc))
		return;							/* Garbage collection stopped */

	SIGBLOCK;				/* Block all signals during garbage collection */
	GC_THREAD_PROTECT(eif_synchronize_gc(rt_globals));
	init_plsc();			/* Initialize scavenging (find 'to' space) */

	/* This object needs to be taken care of, because it might be dead from
	 * the GC's point of view although we know that it is not... As its location
	 * may change, we use an indirection to reach it.
	 */
	*object = MARK_SWITCH(object);	/* Ensure object is alive */

	run_plsc();				/* Normal sequence */
	SIGRESUME;				/* Dispatch any signal which has been queued */

	GC_THREAD_PROTECT(eif_unsynchronize_gc(rt_globals));
}

rt_private void clean_zones(void)
{
	/* This routine is called after a partial scavenging has been done.
	 * Run over the 'from' field, coalescing all the Eiffel block we find
	 * there. If we reach a C block, then the entire zone is polluted and the
	 * free blocks are returned to the free list. Otherwise, the whole chunk
	 * is kept for the next partial scavenge (this should be the case all the
	 * time, but some C blocks may pollute the zones if we are low in memory).
	 */

	int is_ps_to_keep, has_block_been_split;
	static rt_uint_ptr copied_average = 0;

	REQUIRE("GC_PART", rt_g_data.status & GC_PART);

		/* Compute the amount of copied bytes and the size of the scavenging zone
		 * we were dealing with. This is used by scollect to update its statistics
		 * about the memory collected (since when scavenging is done, some memory
		 * is collected without having the free-list disturbed, thus making the
		 * malloc statistics inaccurate in this respect)--RAM.
		 */
	rt_g_data.mem_copied += ps_from.sc_size;	/* Bytes subject to copying */
	rt_g_data.mem_move += ps_to.sc_top - ps_to.sc_active_arena;

		/* Update the average. */
	copied_average = (copied_average + (ps_to.sc_top - ps_to.sc_active_arena)) / 2;
	if
		((ps_to.sc_top >= ps_to.sc_end) ||
		(((copied_average * 2) <= ps_to.sc_size) &&
		 	(((rt_uint_ptr) (ps_to.sc_end - ps_to.sc_top)) <= ((copied_average * 50) / 100))))
	{
			/* If we have reached the end of the `ps_to' zone, then we cannot keep it. */
			/* If we compact in average less than half of the `ps_to' zone, and then if we
			 * have less than 50% of `copied_average' bytes available in `ps_to', we
			 * cannot keep it, since next partial scavenging might overflow `ps_to' and thus
			 * as if no partial scavenging was done.
			 */
		is_ps_to_keep = 0;
	} else {
		is_ps_to_keep = 1;
	}

		/* Put final free block back to the free list?
		 * If we cannot do that, then `is_ps_to_keep' has to be updated
		 * accordingly, that is to say, we cannot keep it for next partial collection. */
	has_block_been_split = split_to_block(is_ps_to_keep);
	is_ps_to_keep = is_ps_to_keep && (has_block_been_split == 1);

	if (is_ps_to_keep) {
			/* Update `ps_to' so that we can reuse it for next compaction. */
			/* Reset `sc_active_arena', so that it corresponds to `top'. */
		ps_to.sc_size = ps_to.sc_size - (ps_to.sc_top - ps_to.sc_active_arena);
		ps_to.sc_active_arena = ps_to.sc_top;
			/* Update size so that it is seen as a non-free block of memory. */
		ps_to.sc_flags = ((union overhead *) ps_to.sc_top)->ov_size;
			/* B_BUSY and B_LAST flag should be set by `split_to_block'. */
		CHECK("B_BUSY set", ((union overhead *) ps_to.sc_top)->ov_size & B_BUSY);
		CHECK("B_LAST set", ((union overhead *) ps_to.sc_top)->ov_size & B_LAST);
	} else {
			/* Reset `ps_to' since we cannot reuse it. */
		memset (&ps_to, 0, sizeof(struct partial_sc_zone));
	}

	if (0 == sweep_from_space()) {	/* Clean up 'from' space */
			/* For malloc, set the B_LAST bit to indicate that the block held
			 * in the space is the last one in the chunk.
			 */
		((union overhead *) ps_from.sc_arena)->ov_size |= B_LAST;

			/* The whole 'from' space is now free. If the 'to' space holds at least
			 * one object, then the `from' space will become the new 'to' space.
			 * Otherwise, we keep the same 'to' space and the 'from' space is put
			 * back to the free list.
			 */
		if (is_ps_to_keep) {
				/* The 'to' space is partially empty -- Free the 'from' space but keep the
				 * to zone for next scavenge (it's so hard to find). Before
				 * freeing the scavenge zone, do not forget to set the B_BUSY
				 * flag for eif_rt_xfree. The number of 'to' zones allocated is also
				 * decreased by one, since its allocation is compensated by the
				 * release of the from space (well, sort of).
				 */
			((union overhead *) ps_from.sc_arena)->ov_size |= B_BUSY;
			eif_rt_xfree (ps_from.sc_arena + OVERHEAD);	/* One big bloc */
			rt_g_data.gc_to--;
		} else {
				/* The 'to' space holds at least one object (normal case). The
				 * 'from' space is completely empty and will be the next 'to' space
				 * in the next partial scavenging.
				 */
			memcpy (&ps_to, &ps_from, sizeof(struct partial_sc_zone));
			ps_to.sc_flags = ((union overhead *) ps_from.sc_arena)->ov_size;
		}
			/* Reset `ps_from' since not needed anymore. */
		memset (&ps_from, 0, sizeof(struct partial_sc_zone));	/* Was freed */
		return;
	}
}

rt_private void init_plsc(void)
{
	/* Set a correct status for the garbage collector, so that the recursive
	 * mark process knows about what we are doing. If we are unable to get
	 * a valid 'to' zone for the scavenge, a simple mark and sweep will be done.
	 */

	if (0 == find_scavenge_spaces())
		rt_g_data.status = (char) ((gen_scavenge & GS_ON) ? GC_PART | GC_GEN : GC_PART);
	else
		rt_g_data.status = (char) ((gen_scavenge & GS_ON) ? GC_GEN : 0);

	/* If partial scavenging was not activated, make sure no scavenge space is
	 * recorded at all, to avoid problems with malloc and core releasing.
	 */

	if (!(rt_g_data.status & GC_PART)) {
		ps_from.sc_arena = (EIF_REFERENCE) 0;		/* Will restart from end */
		if (ps_to.sc_arena != (EIF_REFERENCE) 0) {	/* One chunk was kept in reserve */
			CHECK("Block is indeed busy", ((union overhead *) ps_to.sc_active_arena)->ov_size |= B_BUSY);
			eif_rt_xfree (ps_to.sc_active_arena + OVERHEAD);
			ps_to.sc_arena = (EIF_REFERENCE) 0;	/* No to zone yet */
		}
	}
}

/*
doc:	<routine name="split_to_block" return_type="int" export="private">
doc:		<summary>The `ps_to' space may  well not be full. Thus if `is_to_keep' is set to `0' then we will return the remaining part at the end to the free list, if `is_to_keep' is set to `1' then we will not return the end to the free list, it will be used for the next partial collection as the new `ps_to' zone. This routine is also responsible to set the B_LAST flag to the last block in `ps_to'.</summary>
doc:		<param name="is_to_keep" type="int">Is the remaining part of `ps_to' being kept for next partial collection?</param>
doc:		<return>1 when block was split, 0 otherwise.</return>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Synchronization done through `scollect'.</synchronization>
doc:	</routine>
*/

rt_private int split_to_block (int is_to_keep)
{
	union overhead *base;	/* Base address */
	rt_uint_ptr size;			/* Amount of bytes used (malloc point's of view) */
	rt_uint_ptr old_size;		/* To save the old size for the leading object */
	int result;

	REQUIRE("Valid sc_top", !is_to_keep || (ps_to.sc_top < ps_to.sc_end));

	base = (union overhead *) ps_to.sc_active_arena;
	size = ps_to.sc_top - (EIF_REFERENCE) base;	/* Plus overhead for first block */


	if (size == 0) {
			/* No objects were scavenged, make sure that `ps_to.sc_top' refers to a B_LAST
			 * block. */
		CHECK("previous_same_as_top", ps_to.sc_top == ps_to.sc_previous_top);
		CHECK("valid sc_top", ps_to.sc_top < ps_to.sc_end);
		((union overhead *) ps_to.sc_top)->ov_size |= B_LAST;
		if (is_to_keep) {
				/* Mark `ps_to' as non-free block. */
			((union overhead *) ps_to.sc_top)->ov_size |= B_BUSY;
		}
			/* Even if no split occurred, it is still a successful split when
			 * seen from the client of this routine. */
		result = 1;
	} else {
			/* I'm faking a big block which will hold all the scavenged object,
			 * so that eif_rt_split_block() will be fooled and correctly split the block
			 * after the last scavenged object--RAM. In fact, I'm restoring the
			 * state the space was in when it was selected for a scavenge.
			 * The malloc flags attached to the 'to' zone are restored. The two
			 * which matters are B_LAST and B_CTYPE (needed by eif_rt_split_block).
			 */
		old_size = base->ov_size;			/* Save size of 1st block */
		base->ov_size = ps_to.sc_flags;		/* Malloc flags for whole space */
		result = (eif_rt_split_block(base, size - OVERHEAD) != -1);
		base->ov_size = old_size;			/* Restore 1st block integrity */

			/* Perform memory update only if we can split block, if not possible. */
		if (!result) {
			CHECK("valid sc_previous_top", ps_to.sc_previous_top < ps_to.sc_end);
				/* Could not split the block, so make sure that `ps_to.sc_previous_top'
				 * has its size updated as well as setting the B_LAST block. */
			size = (((union overhead *) ps_to.sc_previous_top)->ov_size & B_SIZE) +
				(ps_to.sc_end - ps_to.sc_top);
				/* Clear previous size and then put the new one. */
			((union overhead *) ps_to.sc_previous_top)->ov_size &= ~B_SIZE;
			((union overhead *) ps_to.sc_previous_top)->ov_size |= size;
				/* Make it last block. */
			((union overhead *) ps_to.sc_previous_top)->ov_size |= B_LAST;
				/* Update `ps_to.sc_top' and `ps_to.sc_previous_top' to the end of block. */
			ps_to.sc_previous_top = ps_to.sc_end;
			ps_to.sc_top = ps_to.sc_end;
		} else {
				/* We were able to split the block, so we simply need to put the B_LAST flag
				 * on sc_top, not on sc_previous_top. */
			((union overhead *) ps_to.sc_top)->ov_size |= B_LAST;
				/* Update `ps_to.sc_previous_top' to now point at the same location as `ps_to.sc_top'
				 * since we don't want to update the flags or size twice of the previous block
				 * in case a partial collection does nothing. */
			ps_to.sc_previous_top = ps_to.sc_top;
			if (is_to_keep) {
					/* Block needs to be kept, so we remove it from free list and mark it B_BUSY,
					 * so that it is not freed later. */
				lxtract((union overhead *) ps_to.sc_top);
					/* Mark `ps_to' as non-free block. */
				((union overhead *) ps_to.sc_top)->ov_size |= B_BUSY;
					/* Update accounting information, we need to remove one OVERHEAD since block
					 * is not free anymore. */
				rt_m_data.ml_over -= OVERHEAD;
				if (ps_to.sc_flags & B_CTYPE) {
					rt_c_data.ml_over -= OVERHEAD;
				} else {
					rt_e_data.ml_over -= OVERHEAD;
				}
			} else {
					/* Update accounting information: the eif_rt_split_block() routine only update
					 * the overhead usage, because it assumes the block it is splitting is
					 * still "used", so the split only appears to add overhead. This is not
					 * the case here. We also free some memory which was accounted as used.
					 */
				size = ps_to.sc_end - ps_to.sc_top;		/* Memory unused (freed) */

				rt_m_data.ml_used -= size;
				if (ps_to.sc_flags & B_CTYPE) {
					rt_c_data.ml_used -= size;
				} else {
					rt_e_data.ml_used -= size;
				}
			}
		}
	}
	return result;
}

rt_private int sweep_from_space(void)
{
	/* After a scavenging, the 'ps_from' zone has to be cleaned up. If by
	 * chance the whole zone is free, it will be kept for the next 'to' zone,
	 * unless that one is also empty in which case the 'from' space will be
	 * returned to the free list anyway. If only one C block remains, then
	 * every block is freed, after having been coalesced.
	 * Note that the coalescing has to be done manually. I would prefer to use
	 * the coalesc() routine in the malloc package, but it assumes that the
	 * coalesced block belongs to the free list, which is not true here.
	 * The function returns 0 if the whole space is free, -1 otherwise.
	 * When this function produces a big free block (i.e. when it returns 0),
	 * that block should carry the B_LAST bit. Currently, it is added by the
	 * caller because there is no reason this should be true if we did not use.
	 */
	union overhead *zone;		/* Currently inspected block */
	union overhead *next;		/* Address of next block */
	rt_uint_ptr flags;				/* Malloc flags and size infos */
	EIF_REFERENCE end;				/* First address beyond from space */
	uint32 dtype;				/* Dynamic type of object */
	EIF_REFERENCE base;							/* First address of 'from' space */
	rt_uint_ptr size;							/* Size of current object */
	char gc_status;						/* Saved GC status */

	base = ps_from.sc_arena;
	zone = (union overhead *) base;		/* Start of from space */
	end = ps_from.sc_end;				/* End of zone */

#ifdef DEBUG
	dprintf(1)("sweep_from_space: chunk from 0x%lx to 0x%lx (excluded)\n",
		base, end);
	flush;
#endif

	for (;;) {

		flags = zone->ov_size;				/* Malloc information flags */

		/* Loop until we reach an Eiffel block which is not marked. */
		for (
			next = (union overhead *) (((EIF_REFERENCE) zone) + (flags & B_SIZE) + OVERHEAD);
			(flags & B_C) || (!(flags & B_FWD) && (zone->ov_flags & EO_MARK));
			next = (union overhead *) (((EIF_REFERENCE) zone) + (flags & B_SIZE) + OVERHEAD)
		) {

#ifdef DEBUG
			dprintf(8)("sweep_from_space: found a %d bytes C block at 0x%lx\n",
				zone->ov_size & B_SIZE, zone + 1);
			flush;
#endif

			/* Make sure object is unmarked (could be a frozen Eiffel object).
			 * The C objects do not use the EO_MARK bit so there is no need
			 * for tests.
			 */
			
			zone->ov_flags &= ~EO_MARK;	/* Unconditionally unmark object */
			zone = next;				/* Advance to next object */
			if ((EIF_REFERENCE) zone >= end)	/* This zone block was the last one */
				break;
			flags = zone->ov_size;		/* Update flags for loop tests */
		}

		/* Either we reached an Eiffel block, a free block or the end of the
		 * 'from' space. I could have tested for the B_LAST bit to check for
		 * one big free block at the head instead of comparing zone and base.
		 * Never mind, this would have added a test whereas the one here is
		 * mandatory--RAM.
		 */

		if ((EIF_REFERENCE) zone >= end)		/* Seems we reached the end of space */
			return -1;					/* 'from' holds at least one C block */
	
#ifdef DEBUG
		dprintf(8)(
		"sweep_from_space: %sfound a %s %s%s%sblock (%d bytes) at 0x%lx\n",
			(EIF_REFERENCE) zone == base ? "" : "(spoilt) ",
			zone->ov_size & B_LAST ? "last" : "normal",
			zone->ov_size & B_BUSY ? "" : "free ",
			zone->ov_size & B_FWD ? "" : "dead ",
			zone->ov_size & B_C ? "BUG " : "",
			zone->ov_size & B_SIZE,
			zone + 1);
		flush;
#endif

		/* Every free block has to be extracted from the free list for
		 * coalescing to occur safely. Non-free blocks which are dead
		 * have to be "dispose"ed properly. Memory accounting has to be
		 * performed diligently, but, halas (!), this simply undoes the work
		 * done during the allocation. And all that overhead will be there for
		 * nothing if the space is spoilt and has to be freed.
		 */

		size = flags & B_SIZE;		/* Pre-compute that guy */

		if (flags & B_BUSY) {		/* We reached a busy block */

			/* Update statistics: every block we extract from the free list and
			 * every dead object we find here is still "used" in the sense that
			 * it is part of a scavenge zone which is still allocated in memory.
			 */

			if (!(flags & B_FWD)) {	/* Non-forwarded block is dead */
				if (zone->ov_flags & EO_DISP) {			/* Exists ? */
					dtype = Deif_bid(zone->ov_flags);		/* Dispose ptr */
					gc_status = rt_g_data.status;			/* Save GC current status */
					rt_g_data.status |= GC_STOP;			/* Stop GC */
					DISP(dtype, (EIF_REFERENCE) (zone + 1));	/* Call it */
					rt_g_data.status = gc_status;			/* Restart GC */
				}
				CHECK ("Cannot be in object ID stack",
					!has_object (&object_id_stack, (EIF_REFERENCE) zone + 1));
			}
		} else {
			lxtract(zone);			/* Extract it from free list */
			rt_m_data.ml_used += size;	/* Memory accounting */
			if (flags & B_CTYPE) {	/* Bloc is in a C chunk */
				rt_c_data.ml_used += size;
			} else {
				rt_e_data.ml_used += size;
			}
		}

		/* Whenever we reach a "first" block which will be the first one in the
		 * coalesced block, we MUST make sure it is marked B_BUSY. In the event
		 * the whole coalesced block would be freed (e.g. when we reach a C
		 * block), eif_rt_xfree() would be called and that would be a no-op if no
		 * B_BUSY mark was carried. Of course, the 'flags' variable, which is
		 * carrying the original version of the malloc flags is left
		 * undisturbed.
		 */

		zone->ov_size |= B_BUSY;	/* Or free would not do anything */

		/* Loop over the Eiffel/free blocks and merge them into one (as
		 * described in the 'zone' header). Stop at the end of the space or
		 * when a C block is reached.
		 */
		for (
			/* empty */;
			!(flags & B_C) && !(!(flags & B_FWD) && (next->ov_flags & EO_MARK)) && (EIF_REFERENCE) next < end;
			next = (union overhead *) (((EIF_REFERENCE) next) + size + OVERHEAD)
		) {
			flags = next->ov_size;			/* Fetch flags for next loop */

#ifdef DEBUG
			dprintf(8)(
			"sweep_from_space: followed by a %s %s%sblock (%d bytes) at 0x%lx\n",
				next->ov_size & B_LAST ? "last" : "normal",
				next->ov_size & B_BUSY ? "" : "free ",
				next->ov_size & B_C ? "C " : next->ov_size & B_FWD ? "":"dead ",
				next->ov_size & B_SIZE,
				next + 1);
			flush;
#endif

			if ((flags & B_C) || (!(flags & B_FWD) && (next->ov_flags & EO_MARK)))		/* Current block followed by a C one */
				break;				/* Coalescing has to stop here */

			/* Any coalesced free block must be removed from the free list,
			 * otherwise, if the coalesced block is finally freed because
			 * the space is spoilt, the block will be listed twice in the list,
			 * once in the original entry and once as being part of a bigger
			 * block. Gulp!
			 * Other non-forwarded blocks are dead and dispose is called if
			 * necessary.
			 */

			size = flags & B_SIZE;		/* Pre-compute that guy */

			if (flags & B_BUSY) {		/* We reached a busy block */

				/* I don't expect any overflow which could corrupt the flags.
				 * The updating of the overhead is only done when the object
				 * was dead, otherwise its overhead has been transferred to
				 * the other scavenging zone (we are talking about partial
				 * scavenging here, so there is no tenuring involved)--RAM.
				 */

				if (!(flags & B_FWD)) {	/* Non-forwarded block is dead */
					if (next->ov_flags & EO_DISP) {				/* Exists ? */
						dtype = Deif_bid(next->ov_flags);	/* Dispose ptr */
						gc_status = rt_g_data.status;		/* Save GC current status */
						rt_g_data.status |= GC_STOP;		/* Stop GC */
						DISP(dtype,(EIF_REFERENCE) (next + 1));/* Call it */
						rt_g_data.status = gc_status;		/* Restore previous GC status */
					}
					CHECK ("Cannot be in object ID stack",
						!has_object (&object_id_stack, (EIF_REFERENCE) next + 1));

					rt_m_data.ml_over -= OVERHEAD;		/* Memory accounting */
					rt_m_data.ml_used += OVERHEAD;		/* Overhead is used */
					if (flags & B_CTYPE) {
						rt_c_data.ml_over -= OVERHEAD;	/* Overhead is decreasing */
						rt_c_data.ml_used += OVERHEAD;
					} else {
						rt_e_data.ml_over -= OVERHEAD;	/* Block in Eiffel chunk */
						rt_e_data.ml_used += OVERHEAD;
#ifdef MEM_STAT
		printf ("Eiffel: %ld used (+%ld), %ld total (sweep_from_space)\n",
			rt_e_data.ml_used, OVERHEAD, rt_e_data.ml_total);
#endif
					}
				}
			} else {
				lxtract(next);					/* Remove it from free list */
				rt_m_data.ml_over -= OVERHEAD;		/* Memory accounting */
				rt_m_data.ml_used += OVERHEAD + size;
				if (flags & B_CTYPE) {			/* Bloc is in a C chunk */
					rt_c_data.ml_over -= OVERHEAD;	/* Overhead is decreasing */
					rt_c_data.ml_used += OVERHEAD + size;
				} else {
					rt_e_data.ml_over -= OVERHEAD;	/* Block in Eiffel chunk */
					rt_e_data.ml_used += OVERHEAD + size;
#ifdef MEM_STAT
		printf ("Eiffel: %ld used (+%ld), %ld total (sweep_from_space)\n",
			rt_e_data.ml_used, OVERHEAD + size, rt_e_data.ml_total);
#endif
				}
			}

			zone->ov_size += size + OVERHEAD;	/* Do coalescing */

#ifdef DEBUG
			dprintf(8)("sweep_from_space: coalesced %s block is now %d bytes\n",
				zone->ov_flags & B_BUSY ? "busy" : "free",
				zone->ov_size & B_SIZE);
			flush;
#endif
		}

		/* Either we reached a C block or the end of the 'from' space. In case
		 * we have a last block to free within a spoilt zone, we have to set
		 * the B_LAST bit, in case we coalesced on the fly.
		 */

		if ((EIF_REFERENCE) next >= end) {		/* We reached the end */

#ifdef DEBUG
			if ((EIF_REFERENCE) zone != base)
				dprintf(8)("sweep_from_space: freed %d bytes (zone spoilt)\n",
					zone->ov_size & B_SIZE);
			flush;
#endif

			if ((EIF_REFERENCE) zone == base)		/* The whole space is free */
				return 0;					/* 'from' may become next 'to' */
			else {							/* At least one C block */
				zone->ov_size |= B_LAST;	/* Ensure malloc sees it as last */
				eif_rt_xfree((EIF_REFERENCE) (zone + 1));	/* Back to free list */
				return -1;					/* Space is spoilt */
			}
		}

#ifdef DEBUG
		dprintf(8)("sweep_from_space: giving %d bytes to free list\n",
			zone->ov_size & B_SIZE);
		flush;
#endif

		/* We must have reached a C block, which means we can free the block.
		 * Free the coalesced block we have so far, starting at zone and reset
		 * the coalescing base to the next object. We will then enter the first
		 * loop which walks other the C blocks, and this loop will unmark the
		 * current object.
		 * This routine is a mess and needs rewriting--RAM.
		 */

		eif_rt_xfree((EIF_REFERENCE) (zone + 1));		/* Put block back to free list */
		zone = next;					/* Reset coalescing base */
	}
	/* NOTREACHED */
}

rt_private int find_scavenge_spaces(void)
{
	/* Look for a 'from' and a 'to' space for partial scavenging. Usually, the
	 * Eiffel memory is viewed as a cyclic memory, where the old 'from' becomes
	 * the 'to' space and the next 'from' will be the chunk following the new
	 * 'to' (i.e the old 'from') until 'to' is near the break, at which point
	 * it is given back to the kernel.
	 * The function returns 0 if all is ok, -1 otherwise.
	 */
#if defined EIF_NO_SCAVENGING
	return -1;
#else	/* EIF_NO_SCAVENGING */
	size_t from_size;					/* Size of selected 'from' space */
	EIF_REFERENCE to_space;					/* Location of the 'to' space */

#ifdef DEBUG
	dprintf(1)("find_scavenge_spaces: last from was 0x%lx\n", last_from);
	flush;
#endif

		/* Find next from zone for scavenging. */
	last_from = find_from_space();
	
#ifdef DEBUG
	dprintf(1)("find_scavenge_spaces: from space is now 0x%lx\n", last_from);
	flush;
#endif

	if (last_from == (struct chunk *) 0) 	/* There are no space available. */
		return -1;

	/* Water-mark is unused by the partial scavenging algorithm */
	from_size = last_from->ck_length;				/* Record length */
	ps_from.sc_size = from_size;					/* Subject to copying */
	ps_from.sc_arena = (EIF_REFERENCE) (last_from + 1);	/* Overwrites first header */
	ps_from.sc_active_arena = (EIF_REFERENCE) (last_from + 1);	/* Overwrites first header */
	ps_from.sc_end = ps_from.sc_arena + from_size;	/* First location beyond */
	ps_from.sc_previous_top = ps_from.sc_top = ps_from.sc_arena;		/* Empty for now */

	if (ps_to.sc_arena) {
		CHECK("valid ps_to", ps_to.sc_previous_top == ps_to.sc_top);
			/* Clear B_LAST flag, it will be set in `split_to_block' at the end of this GC cycle. */
		((union overhead *) ps_to.sc_top)->ov_size &= ~B_LAST;
		return 0;			/* We already have a 'to' space */
	}

	find_to_space();	/* Try to find a 'to' space by coalescing */
	if (ps_to.sc_arena)		/* It worked */
		return 0;			/* We got our 'to' space */

	/* We cannot indefinitely ask for malloced chunks, as the size of the
	 * process may increase each time we do so... Therefore, we count each
	 * time we do so and are allowed at most TO_MAX allocations. Passed this
	 * limit, there cannot be any partial scavenging, at least for this cycle.
	 * Note that when core is released to the kernel, the count of malloc'ed
	 * 'to' zones decreases accordingly.
	 */

	if (rt_g_data.gc_to >= TO_MAX || rt_e_data.ml_chunk < CHUNK_MIN)
		return -1;						/* Cannot allocate a 'to' space */

	/* Find a 'to' space.
	 * We ask for more core, I repeat: we ask for more core. If this fails, then no
	 * scavenging will be done. This is why it is so important to be able to
	 * always have a 'to' handy for the next scavenge (i.e. no C blocks in the
	 * 'from' space).
	 * It's necessary to have the 'to' space in the Eiffel space, so I call a
	 * somewhat low-level malloc routine.
	 *
	 * The get_to_from_core replaces the previous call to malloc_from_eiffel_list_no_gc which used
	 * to get a to_space anywhere in the free list. But we want an 
	 * empty chunk and if we arrive here, the only way to get a free chunk
	 * is to get it from the kernel. It does not happen so often. Usually
	 * it happens the first time partial scavenging is called.
	 * Fixes random-string-blank-panic and random-array-alloc-loop.
	 * -- Fabrice.
	 */

	to_space = get_to_from_core(from_size - OVERHEAD);	/* Allocation from free list */
	if ((EIF_REFERENCE) 0 == to_space)
		return -1;			/* Unable to find a 'to' space */
	
	/* The 'to' space will see its header overwritten, which is basically why
	 * we have to save the flags associated with the arena. When it's time to
	 * split the 'to' block, we can always fake the original block by saving the
	 * size header (which belongs to the first scavenged object), restoring the
	 * original, doing the split and finally restoring the saved header.
	 */

	rt_g_data.gc_to++;								/* Count 'to' zone allocation */
	ps_to.sc_arena = to_space - OVERHEAD;		/* Overwrite the header */
	ps_to.sc_active_arena = to_space - OVERHEAD;		/* Overwrite the header */
	ps_to.sc_flags = HEADER(to_space)->ov_size;	/* Save flags */
	ps_to.sc_size = from_size;					/* Used for statistics */
	ps_to.sc_end = ps_to.sc_arena + from_size;	/* First free location beyond */
	ps_to.sc_top = ps_to.sc_arena;				/* Is empty */
	ps_to.sc_previous_top = ps_to.sc_arena;				/* Is empty */
		/* Clear B_LAST flag, it will be set in `split_to_block' at the end of this GC cycle. */
	((union overhead *) ps_to.sc_top)->ov_size &= ~B_LAST;

#ifdef DEBUG
	dprintf(1)("find_scavenge_spaces: malloc'ed a to space at 0x%lx (#%d)\n",
		ps_to.sc_arena, rt_g_data.gc_to);
	dprintf(1)("find_scavenge_spaces: from [0x%lx, 0x%lx] to [0x%lx, 0x%lx]\n",
		ps_from.sc_arena, ps_from.sc_end - 1,
		ps_to.sc_arena, ps_to.sc_end - 1);
	flush;
#endif

	return 0;		/* Ok, we got a 'to' space */
#endif	/* EIF_NO_SCAVENGING */
}

#ifndef EIF_NO_SCAVENGING

/*
doc:	<routine name="find_from_space" return_type="struct chunk *" export="private">
doc:		<summary>Find the next chunk that can be used as from space for `ps_from'. We cycle through the list of available Eiffel chunks and updates the Eiffel chunk cursor accordingly.</summary>
doc:		<return>NULL when not found, otherwise a chunk of Eiffel memory.</return>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Synchronization done through `scollect'.</synchronization>
doc:	</routine>
*/
rt_private struct chunk *find_from_space()
{
	char *l_arena;
	struct chunk *start, *real_start;

	if (last_from == NULL) {
			/* If `last_from' is null, then it was never set, we start from the beginning by
			 * flagging `real_start' to NULL. */
		real_start = NULL;
	} else if (last_from != cklst.e_cursor) {
			/* `last_from' was set, but now it is different from the cursor position, we take
			 * the current cursor position as a from space. */
			/* Note that it can be NULL if we are off the list. */
		real_start = cklst.e_cursor;
	} else {
			/* We continue our iteration to the next block. */
			/* Note that it can be NULL if we are off the list. */
		real_start = last_from->ck_lnext;
	}
	if (!real_start) {
			/* Could not find a valid start, we start from the begginning. */
		real_start = cklst.eck_head;
	}
	for (start = real_start; start != NULL; start = start->ck_lnext) {
			/* Skip the active 'to' space, if any: we must not have 'from' and
			 * 'to' at the same location, otherwise it's a 4 days bug--RAM.
			 */
		l_arena = (char *) (start + 1);
		if (l_arena != ps_to.sc_arena) {
			cklst.e_cursor = start;
			return start;							/* No, it's ok */
		}
	}

		/* We haven't found a block, so we restart from beginning if `real_start' was not
		 * already at the beginning. */
	for (start = cklst.eck_head; start != real_start; start = start->ck_lnext) {
			/* See previous loop for explanations. */
		l_arena = (char *) (start + 1);
		if (l_arena != ps_to.sc_arena) {
			cklst.e_cursor = start;
			return start;							/* No, it's ok */
		}
	}
	return NULL;		/* No chunk found */
}

rt_private void find_to_space(void)
					/* The zone structure we want to fill in */
{
	/* Look for a suitable space which could be used by partial scanvenging
	 * as `ps_to' zone. If the leading block in the chunk is free but not
	 * equal to the whole chunk, we even attempt block coalescing.
	 */
	size_t std_size = eif_chunk_size - sizeof(struct chunk);
	struct chunk *cur;	/* Current chunk we are considering */
	rt_uint_ptr flags = 0;		/* Malloc info flags */
	EIF_REFERENCE arena = (EIF_REFERENCE) 0;	/* Where chunk's arena starts */

	for (cur = cklst.eck_head; cur != (struct chunk *) 0; cur = cur->ck_lnext) {
		arena = (EIF_REFERENCE) cur + sizeof(struct chunk);
		if (arena == ps_from.sc_arena)
			continue;						/* Skip scanvenging from space */
		flags = ((union overhead *) arena)->ov_size;
		if (flags & B_BUSY)					/* Leading block allocated */
			continue;						/* Chunk not completely free */
		if (!(flags & B_LAST))				/* Looks like a fragmented chunk */
			if (0 == chunk_coalesc(cur))	/* Coalescing was useless */
				continue;					/* Skip this chunk */
		flags = ((union overhead *) arena)->ov_size;
		if (flags & B_LAST)					/* One big happy free block */
			break;
	}

	if (cur == (struct chunk *) 0)		/* Did not find any suitable chunk */
		return;
	CHECK ("Flags must be initialized", flags != 0);
	CHECK ("Arena must be initialized", arena != (EIF_REFERENCE) 0);

	/* Initialize scavenging zone. Note that the arena of the zone starts at
	 * the header of the first block, but we save the malloc flags so that we
	 * can restore the block later when it is time to put it back to the free
	 * list world.
	 */

	ps_to.sc_previous_top = ps_to.sc_top = ps_to.sc_arena = ps_to.sc_active_arena = arena;
	ps_to.sc_flags = flags;
	ps_to.sc_end = ps_to.sc_arena + (flags & B_SIZE) + OVERHEAD;
	ps_to.sc_size = (flags & B_SIZE) + OVERHEAD;
		/* Clear B_LAST flag, it will be set in `split_to_block' at the end of this GC cycle. */
	((union overhead *) ps_to.sc_top)->ov_size &= ~B_LAST;

	/* This zone is now used for scavening, so it must be removed from the free
	 * list so that further mallocs do not attempt to use this space (when
	 * tenuring, for instance). Also the block is used from the statistics
	 * point of view.
	 */

	lxtract((union overhead *) arena);	/* Extract block from free list */

	rt_m_data.ml_used += (flags & B_SIZE);
	if (flags & B_CTYPE) {
		rt_c_data.ml_used += (flags & B_SIZE);
	} else {
		rt_e_data.ml_used += (flags & B_SIZE);
	}

#ifdef DEBUG
	dprintf(1)("find_to_space: coalesced a to space at 0x%lx (#%d)\n",
		ps_to.sc_arena, rt_g_data.gc_to);
	dprintf(1)("find_to_space: from [0x%lx, 0x%lx] to [0x%lx, 0x%lx]\n",
		ps_from.sc_arena, ps_from.sc_end - 1,
		ps_to.sc_arena, ps_to.sc_end - 1);
	flush;
#endif
}
#endif

rt_private EIF_REFERENCE scavenge(register EIF_REFERENCE root, char **top)
{
	/* The object pointed to by 'root' is to be scavenged in the 'to' space,
	 * provided it is not an expanded object (otherwise, it has already been
	 * scavenged as part of the object that holds it). The function returns the
	 * pointer to the new object's location, in the 'to' space.
	 */
	union overhead *zone;	/* Malloc info header */
	rt_uint_ptr length;						/* Length of scavenged object */

	REQUIRE ("Algorithm moves objects",
			rt_g_data.status & (GC_GEN | GC_PART) || rt_g_data.status & GC_FAST);

	zone = HEADER(root);

	/* Expanded objects are held in one object, and a pseudo-reference field
	 * in the father object points to them. However, the scavenging process
	 * does not update this reference. Instead, the expanded header knows how to
	 * reach the header of the father object. If scavenging is on, we reach the
	 * expanded once the father has been scavenged, and we get the new address
	 * by following the forwarding pointer left behind. Nearly a kludge.
	 * Let A be the address of the original object (zone below) and A' (new) the
	 * address of the scavenged object (given by following the forwarding
	 * pointer left) and P the pointed expanded object in the original (root).
	 * Then the address of the scavenged expanded is A'+(P-A).
	 */
	if (zone->ov_flags & EO_EXP) {
			/* Compute original object's address (before scavenge) */
		EIF_REFERENCE exp;					/* Expanded data space */
		EIF_REFERENCE new;					/* New object's address */
		union overhead *container_zone;	/* Header of object containing
													 * expanded object `root' */
		container_zone = (union overhead *) ((EIF_REFERENCE) zone - (zone->ov_size & B_SIZE));

		if (!(container_zone->ov_size & B_FWD)) {
				/* Container object of `root' did not move, so nothing
				 * needs to be done */
			return root;
		}

		CHECK ("In Generation Scavenge From zone",
			(rt_g_data.status & GC_PART) ||
				((rt_g_data.status & (GC_GEN | GC_FAST)) &&
				(root > sc_from.sc_arena) && 
				(root <= sc_from.sc_end)));

		CHECK ("In Partial Scavenge From zone",
			(rt_g_data.status & (GC_GEN | GC_FAST)) ||
				((rt_g_data.status & GC_PART) &&
				(root > ps_from.sc_arena) && 
				(root <= ps_from.sc_end)));

		new = container_zone->ov_fwd;			/* Data space of the scavenged object */
		exp = new + (root - (EIF_REFERENCE) (container_zone + 1));	/* New data space */
			
		zone->ov_fwd = exp;			/* Leave forwarding pointer */
		zone->ov_size |= B_FWD;		/* Mark object as forwarded */
		return exp;					/* This is the new location of expanded */
	}

	CHECK ("In Generation Scavenge From zone",
		(rt_g_data.status & GC_PART) ||
			((rt_g_data.status & (GC_GEN | GC_FAST)) &&
			(root > sc_from.sc_arena) && 
			(root <= sc_from.sc_end)));

	CHECK ("In Partial Scavenge From zone",
		(rt_g_data.status & (GC_GEN | GC_FAST)) ||
			((rt_g_data.status & GC_PART) &&
			(root > ps_from.sc_arena) && 
			(root <= ps_from.sc_end)));

	CHECK ("Not in Generation Scavenge TO zone",
		!((rt_g_data.status & GC_GEN) &&
		(root > sc_to.sc_arena) && 
		(root <= sc_to.sc_end))
	);				
	CHECK ("Not in Partial Scavenge TO zone.",
		!((rt_g_data.status & GC_PART) &&
		(root > ps_to.sc_active_arena) && 
		(root <= ps_to.sc_end))
	);

	/* If an Eiffel object holds the B_C mark (we know it's an Eiffel object
	 * because it is referenced by an Eiffel object), then simply ignore it.
	 * It is important to mark the object though, because it might be a frozen
	 * object part of the remembered set, and it will be removed if it is not
	 * marked. Besides, we need to cut recursion to prevent loops.
	 */
	if (zone->ov_size & B_C) {
		if (!(zone->ov_flags & EO_C))	/* Not a C object */
			zone->ov_flags |= EO_MARK;	/* Mark it */
		return root;					/* Leave object where it is */
	}

	root = *top;						/* New location in 'to' space */
	length = (zone->ov_size & B_SIZE) + OVERHEAD;
	*top += length;					/* Update free-location pointer */
	memcpy (root, zone, length);			/* The scavenge process itself */
	zone->ov_fwd = root + OVERHEAD;			/* Leave forwarding pointer */
	zone->ov_size |= B_FWD;					/* Mark object as forwarded */

#ifdef EIF_NO_SCAVENGING
	CHECK ("Scavenging is not disabled", 0);
#endif	/* EIF_NO_SCAVENGING */

	return root + OVERHEAD;			/* New object's location */
}

/* Generation-based collector. This is a non incremental fast collector, which
 * is derived from Ungar's papers (ACM 1984 and OOPSLA'88). Provision is made
 * for both generation collection and generation scavenging.
 */

#endif /* ISE_GC */
/*
doc:	<routine name="collect" return_type="int" export="public">
doc:		<summary>The generational collector entry point, with statistics updating. The time spent in the algorithm is monitored by scollect and accessible to the user via MEMORY primitives.</summary>
doc:		<return>0 if collection was done, -1 otherwise.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Synchronization done through `scollect'.</synchronization>
doc:	</routine>
*/

rt_public int collect(void)
{
#ifdef ISE_GC
	int result;
	result = scollect(generational_collect, GST_GEN);
	return result;
#else
	return 0;
#endif /* ISE_GC */
}

#ifdef ISE_GC
rt_private int generational_collect(void)
{
	/* Generation collector -- The new generation is completely collected
	 * and survival objects are tenured (i.e. promoted to the old generation).
	 * The routine returns 0 if collection performed normally, -1 if GC is
	 * stopped or generation scavenging was stopped for some reason.
	 */

	RT_GET_CONTEXT
	int age;			/* Computed tenure age */
	rt_uint_ptr overused;		/* Amount of data over watermark */
	EIF_REFERENCE watermark;			/* Watermark in generation zone */

	if (rt_g_data.status & GC_STOP)
		return -1;				/* Garbage collection stopped */

	SIGBLOCK;					/* Block signals during garbage collection */
	rt_g_data.status = GC_FAST;	/* Fast generation collection */
	rt_g_data.nb_partial++;		/* One more partial collection */

#ifdef DEBUG
	dprintf(1)("collect: tenure age is %d for this cycle\n", tenure);
	flush;
#endif

	/* First, reset the age tables, so that we can recompute the tenure
	 * threshold for the next pass (feedback). We reset the all array
	 * instead of just using `eif_tenure_max' elements for two reasons:
	 * 1 - most of the time `eif_tenure_max == TENURE_MAX'
	 * 2 - can be optimized better by C compiler.
	 */
	memset (size_table, 0, TENURE_MAX * sizeof (rt_uint_ptr));
	memset (age_table, 0, TENURE_MAX * sizeof (uint32));

	mark_new_generation(MTC_NOARG);		/* Mark all new reachable objects */
	full_update();				/* Sweep the youngest generation */
	if (gen_scavenge & GS_ON)
		swap_gen_zones();		/* Swap generation scavenging spaces */

	/* Compute the tenure for the next pass. If generation scavenging is on,
	 * we use Ungar's feedback technique on the size_table array, otherwise
	 * the age_table array is used.
	 */

	tenure = eif_tenure_max;

	if (gen_scavenge == GS_ON) {
		/* Generation scavenging is on and has not been stopped. If less than
		 * the watermark is used, set tenure to eif_tenure_max, 
		 * to avoid tenuring for the next cycle. Otherwise, set it so 
		 * that we tenure at least
		 * 'overused' bytes next cycle. GS_FLOATMARK is set to 40% of the
		 * scavenge zone size and lets us get some free space to let other
		 * young objects die, hopefully.
		 * When compiled for speed however, we do not want to spend our time
		 * copying objects back and forth too many times. So in this case,
		 * we test for the watermark minus GS_FLOATMARK to maintain at least
		 * that space free. This should limit collection racing when objects
		 * are allocated at a high rate, at the price of more memory usage,
		 * since this will incur some tenuring.
		 */
		
		watermark = cc_for_speed ? sc_from.sc_mark - GS_FLOATMARK : sc_from.sc_mark;

		if (sc_from.sc_top >= watermark) {
			overused = sc_from.sc_top - sc_from.sc_mark + GS_FLOATMARK;
			for (age = eif_tenure_max - 1; age >= 0; age--) {
				if (overused >= size_table[age]) {
						/* Amount tenured at 'age' */
					overused -= size_table [age];
				} else {
					break;
				}
			}
			tenure = age;		/* Tenure threshold for next cycle */
		}
	}

	/* Deal with the objects in the chunk space. Our aim is to limit the number
	 * of young objects to OBJ_MAX, so that we do not spend a considerable time
	 * walking through the moved set and the remembered set.
	 */
	
	overused = 0;
	for (age = 0; age < eif_tenure_max; age++)
		overused += age_table[age];

#ifdef DEBUG
	dprintf(1)("collect: %d objects in moved set\n", overused);
	dprintf(1)("collect: scavenged %d bytes (%d bytes free in zone)\n",
		sc_from.sc_top - sc_from.sc_arena, sc_from.sc_end - sc_from.sc_top);
#endif

	if (overused > OBJ_MAX) {
		overused -= OBJ_MAX;				/* Amount of spurious objects */
		for (age = eif_tenure_max - 1; age >= 0; age--) {
			if (overused >= age_table [age]) {
					/* Amount tenured at 'age' */
				overused -= age_table[age];
			} else {
				break;
			}
		}
		tenure = tenure < age ? tenure : age;	/* Tenure for next cycle */
	}

	/* We have computed the tenure based on the current state, but at the next
	 * cycle, the objects will be one generation older, so we have to increase
	 * the tenure limit by one, in not at eif_tenure_max - 1 or above.
	 */

	if (tenure < eif_tenure_max - 1)
		tenure++;

#ifdef DEBUG
	dprintf(1)("collect: tenure fixed to %d for next cycle\n", tenure);
	flush;
#endif

	SIGRESUME;			/* Restore signal handling and dispatch queued ones */

	return (gen_scavenge & GS_STOP) ? -1 : 0;	/* Signals error if stopped */
}

rt_private void mark_new_generation(EIF_CONTEXT_NOARG)
{
	/* Genration mark phase -- All the young objects which are reachable
	 * from the remembered set are alive. Old objects have reached immortality,
	 * not less--RAM. We must not forgive new objects that are referenced only
	 * via new objects. The new generation is described by the moved set.
	 * I am aware of the code duplication, but this is a trade for speed over
	 * run-time size and maintainability--RAM.
	 */
	int moving = gen_scavenge & GS_ON;	/* May objects be moved? */

		/* Initialize our overflow depth */
	overflow_stack_depth = 0;

	/* First deal with the root object. If it is not old, then mark it */
	if (root_obj && !(HEADER(root_obj)->ov_flags & EO_OLD))
		root_obj = GEN_SWITCH(&root_obj);

	/* Deal with remembered set, which records the addresses of all the
	 * old objects pointing to new ones.
	 */
	mark_simple_stack(&rem_set, GEN_SWITCH, moving);

	internal_marking(GEN_SWITCH, moving);
}

rt_private EIF_REFERENCE hybrid_gen_mark(EIF_REFERENCE *a_root)
{
	/* Mark all the objects referenced by the root object.
	 * All the attributes of an object are recursively marked,
	 * except the last one. This brings a noticeable
	 * improvement with structures like LINKED_LIST when its `right'
	 * part is the last reference (note this is not always the case).
	 * It also prevents stack overflow with the `overflow_stack_set'.
	 */
	union overhead *zone;		/* Malloc info zone fields */
	uint32 flags;				/* Eiffel flags */
	long offset;				/* Reference's offset */
	uint32 size;				/* Size of items (for array of expanded) */
	EIF_REFERENCE *object;				/* Sub-objects scanned */
	EIF_REFERENCE current;				/* Object currently inspected */
	EIF_REFERENCE *prev;				/* Holder of current (for update) */
	EIF_REFERENCE root = *a_root;		/* Root object */
	long count;					/* Number of references */

	/* If 'root' is a void reference, return immediately. This is redundant
	 * with the beginning of the loop, but this case occurs quite often.
	 */

	if (root == (EIF_REFERENCE) 0)
		return (EIF_REFERENCE) 0;

		/* Stack overflow protection */
	overflow_stack_depth++;
	if (overflow_stack_depth > overflow_stack_limit) {
		epush(&overflow_stack_set, a_root);
		overflow_stack_count++;
		overflow_stack_depth--;
		return root;
	}

	/* Initialize the variables for the loop */
	current = root;
	prev = (EIF_REFERENCE *) 0;

	do {
		if (current == (EIF_REFERENCE) 0)		/* No further exploration */
			goto done;					/* Exit the procedure */

		zone = HEADER(current);			/* Malloc info zone */

#ifdef DEBUG
	if (zone->ov_size & B_FWD) {
		dprintf(16)("hybrid_gen_mark: 0x%lx fwd to 0x%lx (DT %d, %d bytes)\n",
			current,
			zone->ov_fwd,
			HEADER(zone->ov_fwd)->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	 } else {
		dprintf(16)("hybrid_gen_mark: 0x%lx %s%s%s%s(DT %d, %d bytes)\n",
			current,
			zone->ov_flags & EO_MARK ? "marked " : "",
			zone->ov_flags & EO_OLD ? "old " : "",
			zone->ov_flags & EO_NEW ? "new " : "",
			zone->ov_flags & EO_REM ? "remembered " : "",
			zone->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	}
	flush;
#endif

		/* If we reach a marked object or a forwarded object, return
		 * immediately: the object has been already processed. Otherwise, an old
		 * object which is not remembered is not processed, as it can't
		 * reference any new objects. Old remembered objects are marked when
		 * they are processed, otherwise it would be possible to process it
		 * twice (once via a reference from another object and once because it's
		 * in the remembered list).
		 */

		if (zone->ov_size & B_FWD) {	/* Object was forwarded (scavenged) */
			if(prev)
				*prev = zone->ov_fwd;	/* Update with its new location */
			goto done;					/* Exit the procedure */
		}

		flags = zone->ov_flags;			/* Fetch Eiffel flags */
		if (flags & (EO_MARK | EO_C))	/* Object has been already processed? */
			goto done;					/* Exit the procedure */

		if (flags & EO_OLD) {			/* Old object unmarked */
			if (flags & EO_REM) {		/* But remembered--mark it as processed */
				zone->ov_flags = flags | EO_MARK;
			} else						/* Old object is not remembered */
				goto done;				/* Skip it--object did not move */
		}

		/* If we reach an expanded object, then we already dealt with the object
		 * which holds it. If this object has been forwarded, we need to update
		 * the reference field. Of course object with EO_OLD set are ignored.
		 * It's easy to know whether a normal object has to be scavenged or
		 * marked. The new objects outside the scavenge zone carry the EO_NEW
		 * mark.
		 */
		if (!(flags & EO_OLD) || (flags & EO_EXP)) {
			current = gscavenge(current);	/* Generation scavenging */
			zone = HEADER(current);			/* Update zone */
			flags = zone->ov_flags;			/* And Eiffel flags */
			if (prev)						/* Update referencing pointer */
				*prev = current;
		}

		/* It's useless to mark an expanded, because it has only one reference
		 * on itself, in the object which holds it. Scavengend objects need not
		 * any mark either, as the forwarding mark tells that they are alive.
		 */
		if (!(flags & EO_EXP) && (flags & EO_NEW)) {
			flags |= EO_MARK;
			zone->ov_flags = flags;
		}

		/* Now explore all the references of the current object.
		 * For each object of type 'type', Reference[type] gives the number
		 * of references in the objects. The references are placed at the
		 * beginning of the data space by the Eiffel compiler. Expanded
		 * objects have a reference to them, so no special treatment is
		 * required. Special objects full of references are also explored.
		 */
		if (flags & EO_SPEC) {				/* Special object */
			EIF_REFERENCE o_ref;

			/* Special objects may have no references (e.g. an array of
			 * integer or a string), so we have to skip those.
			 */
			if (!(flags & EO_REF))
				goto done;				/* Skip if no references */

			/* At the end of the special data zone, there are two long integers
			 * which give informations to the run-time about the content of the
			 * zone: the first is the 'count', i.e. the number of items, and the
			 * second is the size of each item (for expandeds, the overhead of
			 * the header is not taken into account).
			 */
			o_ref = RT_SPECIAL_INFO_WITH_ZONE(current, zone);
			count = offset = RT_SPECIAL_COUNT_WITH_INFO(o_ref);	/* Get # items */

			if (flags & EO_TUPLE) {
				EIF_TYPED_ELEMENT *l_item = (EIF_TYPED_ELEMENT *) current;
					/* Don't forget that first element of TUPLE is just a placeholder
					 * to avoid offset computation from Eiffel code */
				l_item++;
				offset--;
				if (gen_scavenge & GS_ON) {
					for (; offset > 1; offset--, l_item++ ) {
						if (eif_tuple_item_type(l_item) == EIF_REFERENCE_CODE) {
							eif_reference_tuple_item(l_item) =
								hybrid_gen_mark (&eif_reference_tuple_item(l_item));
						}
					}
				} else {
					for (; offset > 1; offset--, l_item++ ) {
						if (eif_tuple_item_type(l_item) == EIF_REFERENCE_CODE) {
							(void) hybrid_gen_mark(&eif_reference_tuple_item(l_item));
						}
					}		
				}
				if ((count >= 1) && (eif_tuple_item_type(l_item) == EIF_REFERENCE_CODE)) {
						/* If last element of TUPLE is a reference, then we continue the
						 * iteration. */
					prev = &eif_reference_tuple_item(l_item);
					current = eif_reference_tuple_item(l_item);
					continue;
				} else
					goto done;		/* End of iteration; exit procedure */
			} else if (flags & EO_COMP) {
				/* Treat arrays of expanded object here, because we have a special
				 * way of looping over the array (we must take the size of each item
				 * into account).
				 */
				size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ref);	/* Item's size */
				if (gen_scavenge & GS_ON) {					/* Moving objects */
					object = (EIF_REFERENCE *) (current + OVERHEAD);/* First expanded */
					for (; offset > 1; offset--) {		/* Loop over array */
						*object = hybrid_gen_mark(object);
						object = (EIF_REFERENCE *) ((EIF_REFERENCE) object + size);
					}
				} else {							/* Object can't move */
					object = (EIF_REFERENCE *) (current + OVERHEAD);/* First expanded */
					for (; offset > 1; offset--) {		/* Loop over array */
						(void) hybrid_gen_mark(object);
						object = (EIF_REFERENCE *) ((EIF_REFERENCE) object + size);
					}
				}
				/* Keep iterating if and only if the current object has at
				 * least one attribute.
				 */
				if (count >= 1) {
					prev = object;
					current = *object;
					continue;
				} else
					goto done;		/* End of iteration; exit procedure */
			}
		} else
			count = offset = References(Deif_bid(flags)); /* # of references */

#ifdef DEBUG
	dprintf(16)("hybrid_gen_mark: %d references for 0x%lx\n", offset, current);
	if (DEBUG & 16 && debug_ok(16)) {
		int i;
		for (i = 0; i < offset; i++)
			printf("\t0x%lx\n", *((EIF_REFERENCE *) current + i));
	}
	flush;
#endif

		/* Mark all objects under root, updating the references if scavenging */

		if (gen_scavenge & GS_ON) {
			for (object = (EIF_REFERENCE *) current; offset > 1; offset--, object++)
				*object = hybrid_gen_mark(object);
		} else {
			for (object = (EIF_REFERENCE *) current; offset > 1; offset--, object++)
				(void) hybrid_gen_mark(object);
		}

		if (count >= 1) {
			prev = object;
			current = *object;
		} else
			goto done;

	} while(current);

done:
	/* Return the [new] address of the root object */
	zone = HEADER(root);
	overflow_stack_depth--;
	return ((zone->ov_size & B_FWD) ? zone->ov_fwd : root);
}

rt_private EIF_REFERENCE gscavenge(EIF_REFERENCE root)
{
	/* Generation scavenging of 'root', with tenuring done on the fly. The
	 * address of the new object (scavenged or tenured) is returned.
	 * Whenever tenuring fails, the flag GS_STOP is set which means that
	 * scavenging is to be done without tenuring.
	 */
	union overhead *zone;		/* Malloc header zone */
	int age;				/* Object's age */
	uint32 flags;				/* Eiffel flags */
	EIF_REFERENCE new;							/* Address of new object (tenured) */ 
	rt_uint_ptr size;							/* Size of scavenged object */
	int ret;							/* status returned by "epush" */

	zone = HEADER(root);				/* Info header */
	flags = zone->ov_flags;				/* Eiffel flags */

	if (gen_scavenge & GS_STOP)			/* Generation scavenging was stopped */
		if (!(flags & EO_NEW))			/* Object inside scavenge zone */
			return scavenge(root, &sc_to.sc_top);	/* Simple scavenging */
		
	if (flags & EO_EXP) {				/* Expanded object */
		if (!(flags & EO_NEW))			/* Object inside scavenge zone */
			return scavenge(root, &sc_to.sc_top);	/* Update reference pointer */
		else
			return root;				/* Do nothing for expanded objects */
	}

	if (zone->ov_size & B_C)	/* Eiffel object not under GC control */
		return root;			/* Leave it alone */

	/* Get the age of the object, update it and fill in the age table.
	 * Tenure when necessary (i.e. when age is greater than 'tenure_age',
	 * overflow is taken into account but this relies on the fact that
	 * the age is not stored in the leftmost bits, to leave room for the
	 * overflow bit--RAM). Note that when tenure is set to eif_tenure_max,
	 * no object can ever be tenured.
	 */

	age = flags & EO_AGE;			/* Fetch object's age */
	age += AGE_ONE;					/* Make a wish, it's your birthday */

	if (age >= (tenure << AGE_OFFSET)) {	/* Object is to be tenured */

		if (flags & EO_NEW) {			/* Object outside scavenge zone */

			/* Object is becomming old, so maybe it has to be remembered. Add
			 * it to the remembered set for later perusal. If the object cannot
			 * be remembered, it remains in the new generation.
			 */

			ret = epush (&rem_set, root);
			if (-1 != ret) {	/* We could record it */

				/* Mark the object as being old, but do not remove the EO_MARK
				 * mark. See comment about GC_FAST in update_moved_set()--RAM.
				 */

				flags &= ~EO_NEW;			/* No longer new */
				flags |= EO_OLD | EO_REM | EO_MARK;	/* See below for EO_MARK */
				zone->ov_flags = flags;		/* Store updated flags */

#ifdef DEBUG
				dprintf(4)("gscavenge: tenured 0x%lx at age %d (%d bytes)\n",
					root, age >> AGE_OFFSET, zone->ov_size & B_SIZE);
				flush;
#endif

				return root;				/* Object did not move */
			}

		} else {					/* Object is inside scavenge zone */

			/* Try tenuring after having marked the object as old. We get the size
			 * from the object to perform the copy.
			 * Addition: now it can be a special object if the EIF_GSZ_ALLOC_OPTIMIZATION
			 * has been enabled, because we try to allocate them in the GSZ
			 * as much as possible (70% speed improvement on the eiffel compiler).
			 */

#ifndef EIF_GSZ_ALLOC_OPTIMIZATION
			CHECK ("Not a special", !(HEADER (root)->ov_flags & EO_SPEC));
#endif
			size = zone->ov_size & B_SIZE;		/* Size without header */

			new = malloc_from_eiffel_list_no_gc (size);				/* Try in Eiffel chunks first */
			if ((EIF_REFERENCE) 0 == new) {			/* Out of memory */
				gen_scavenge |= GS_STOP;		/* Stop generation scavenging */
				return scavenge(root, &sc_to.sc_top);	/* Simple scavenge */
			}

			/* Object is promoted, so add it to the remebered set for later
			 * perusal (the set will be scanned and eventually some items will
			 * be removed--object does not reference any young ones any more).
			 */

			ret = epush (&rem_set, new);
			if (ret == -1) {	/* Cannot record it */
				gen_scavenge |= GS_STOP;		/* Mark failure */
				eif_rt_xfree(new);						/* Back where we found it */
				return scavenge(root, &sc_to.sc_top);	/* Simple scavenge */
			}

			/* Copy the object to its new location, then update the header: the
			 * object is now an old one. Leave a forwarding pointer behind us.
			 * The data part of the object is copied as-is, but references on
			 * expanded will be correctly updated by the recursive process.
			 * The address of the new object has been inserted in the remembered
			 * set, so we must not remove the collector's mark otherwise it
			 * would be considered dead by update_rem_set()--RAM.
			 */

			flags |= EO_OLD | EO_REM | EO_MARK;	/* See below for EO_MARK */

			/* It is imperative to mark the object we've just tenured, so that
			 * we do not process it twice!! The tenured object will be processed
			 * as we return from this routine, but hybrid_mark has already
			 * dealt with EO_MARK, so it is our responsability... This was a bug
			 * I spent three days tracking--RAM.
			 */
			memcpy (new, root, size);		/* Copy data part */

#ifdef EIF_NO_SCAVENGING
			eif_panic ("Generation Scavenging is not disabled");
#endif	/* EIF_NO_SCAVENGING */
			zone->ov_size |= B_FWD;		/* Mark object as forwarded */
			zone->ov_fwd = new;			/* Leave forwarding pointer */
			zone = HEADER(new);			/* New info zone */
			zone->ov_flags = flags;		/* Copy flags for new object */
			zone->ov_size &= ~B_C;		/* Object is an Eiffel one */

#ifdef DEBUG
			dprintf(4)("gscavenge: tenured 0x%lx to 0x%lx at age %d (%d bytes)\n",
				root, new, age >> AGE_OFFSET, size);
			flush;
#endif

			return new;		/* Done */
		}
	}

	/* Object is to be kept in the new generation */

#ifdef DEBUG
	dprintf(4)("gscavenge: keeping %s0x%lx at age %d (%d bytes)\n",
		flags & EO_NEW ? "new " : "",
		root, age >> AGE_OFFSET, zone->ov_size & B_SIZE);
	flush;
#endif

	age |= flags & (~EO_AGE);			/* New Eiffel flags */
	zone->ov_flags = age & (~EO_MARK);	/* Age merged, object unmarked */
	age = (age & EO_AGE) >> AGE_OFFSET;	/* Scalar value of age */
	if (flags & EO_NEW) {				/* Object allocated from free list */
		age_table[age]++;				/* One more object for this age */
		return root;					/* Object not moved */
	} else {							/* Object is in the scavenge zone */
		size_table[age] += (zone->ov_size & B_SIZE) + OVERHEAD;
		return scavenge(root, &sc_to.sc_top);	/* Move object */
	}
	/* NOTREACHED */
}

rt_private void update_moved_set(void)
{
	/* Update the moved set. This routine is called to throw away from the moved
	 * set all the dead objects.
	 * Generation collection has its own treatment for that, as we need to
	 * eventually collect the dead objects. If partial collection has been done
	 * we may need to update some references.
	 * Note that I could free the dead objects here, but I chose to wait for
	 * the general sweep process because of the swapping problems--RAM. Only
	 * the generation-based collectors have their free here, for the objects
	 * outside the scavenge zone (those in the moved set, precisely).
	 */

	EIF_REFERENCE *obj;			/* Pointer to objects held in a stack */
	rt_uint_ptr i;				/* Number of items in stack chunk */
	union overhead *zone;	/* Referenced object's header */
	struct stchunk *s;	/* To walk through each stack's chunk */
	uint32 flags;			/* Used only if GC_FAST */
	struct stack new_stack;			/* The new stack built from the old one */
	int done = 0;					/* Top of stack not reached yet */

	memcpy (&new_stack, &moved_set, sizeof(struct stack));
	s = new_stack.st_cur = moved_set.st_hd;		/* New empty stack */
	if (s) {
		new_stack.st_top = s->sk_arena;			/* Lowest possible top */
		new_stack.st_end = s->sk_end;			/* End of first chunk */
	}

#ifdef DEBUG
	dprintf(1)("update_moved_set: %d objects to be studied\n",
		nb_items(&moved_set));
	flush;
#endif

	/* If generation collection is active, a marked object is kept in the
	 * moved set if and only if it has not been promoted (in which case the
	 * EO_NEW bit has been cleared). In that case, the object is unmarked.
	 * Otherwise, if object has been promoted, it is not kept, but we
	 * unmark it only if it has not been remembered (because after the update
	 * of the moved set, we're going to update the remembered set and any
	 * alive object must still be marked).
	 */

	if (rt_g_data.status & GC_PART) {			/* Partial collection */
		for (s = moved_set.st_hd; s && !done; s = s->sk_next) {
			obj = s->sk_arena;					/* Start of stack */
			if (s != moved_set.st_cur)			/* Top is before after 's' */
				i = s->sk_end - obj;			/* Look at the whole chunk */
			else {
				i = moved_set.st_top - obj;		/* Stop at the top */
				done = 1;						/* Reached end of stack */
			}
			for (; i > 0; i--, obj++) {			/* Stack viewed as an array */
				zone = HEADER(*obj);			/* Referenced object */
				if (zone->ov_size & B_FWD) {		/* Object forwarded? */
					zone = HEADER(zone->ov_fwd);	/* Look at fwd object */
					if (zone->ov_flags & EO_NEW)	/* It's a new one */
						epush(&new_stack, (EIF_REFERENCE)(zone+1));	/* Update reference */
				} else if (EO_MOVED == (zone->ov_flags & EO_MOVED))
					epush(&new_stack, (EIF_REFERENCE)(zone+1));	/* Remain as is */
			}
		}
	} else if (rt_g_data.status & GC_FAST) {	/* Generation collection */
		for (s = moved_set.st_hd; s && !done; s = s->sk_next) {
			obj = s->sk_arena;					/* Start of stack */
			if (s != moved_set.st_cur)			/* Top is before after 's' */
				i = s->sk_end - obj;			/* Look at the whole chunk */
			else {
				i = moved_set.st_top - obj;		/* Stop at the top */
				done = 1;						/* Reached end of stack */
			}
			for (; i > 0; i--, obj++) {			/* Stack viewed as an array */
				zone = HEADER(*obj);			/* Referenced object */
				flags = zone->ov_flags;			/* Get Eiffel flags */
				if (flags & EO_MARK) {			/* Object is alive? */
					if (flags & EO_NEW) {				/* Not tenrured */
						epush(&new_stack, (EIF_REFERENCE)(zone+1));		/* Remains "as is" */
						zone->ov_flags &= ~EO_MARK;		/* Unmark object */
					} else if (!(flags & EO_REM))		/* Not remembered */
						zone->ov_flags &= ~EO_MARK;		/* Unmark object */
				} else if (!(zone->ov_size & B_C) && (zone->ov_size & B_BUSY))
					gfree(zone);				/* Free if under GC control */
			}
		}
	} else {								/* Mark and sweep */
		for (s = moved_set.st_hd; s && !done; s = s->sk_next) {
			obj = s->sk_arena;					/* Start of stack */
			if (s != moved_set.st_cur)			/* Top is before after 's' */
				i = s->sk_end - obj;			/* Look at the whole chunk */
			else {
				i = moved_set.st_top - obj;		/* Stop at the top */
				done = 1;						/* Reached end of stack */
			}
			for (; i > 0; i--, obj++) {			/* Stack viewed as an array */
				zone = HEADER(*obj);			/* Referenced object */
				if (EO_MOVED == (zone->ov_flags & EO_MOVED))
					epush(&new_stack,(EIF_REFERENCE)(zone+1));	/* Remains "as is" */
			}
		}
	}

#ifdef DEBUG
	dprintf(1)("update_moved_set: %d objects remaining\n",
		nb_items(&new_stack));
	flush;
#endif

	memcpy (&moved_set, &new_stack, sizeof(struct stack));

	/* As for the remembered set (see comment in update_rem_set), we release the
	 * spurious chunks used by the moved set stack.
	 */

	st_truncate(&moved_set);
}

rt_private void update_rem_set(void)
{
	/* Update the remembered set. This is an iterative process: for each item,
	 * we look for references to new objects. If there are none, the object is
	 * removed from the set. This "in place" updating cannot lead to a stack
	 * overflow.
	 * This routine checks that the object is alive only when doing a full
	 * collection. Otherwise, the objects in the remembered set are old ones,
	 * which means they are not affected by generation collections.
	 */

	EIF_REFERENCE *object;					/* Current inspected object */
	rt_uint_ptr n;							/* Number of objects to be dealt with */
	struct stack new_stack;			/* The new stack built from the old one */
	EIF_REFERENCE current;		/* Address of inspected object */
	char moving;			/* May GC move objects around? */
	union overhead *zone;	/* Malloc info zone */
	struct stchunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */
	int generational;				/* Are we in a generational cycle? */

	memcpy (&new_stack, &rem_set, sizeof(struct stack));
	s = new_stack.st_cur = rem_set.st_hd;		/* New empty stack */
	if (s) {
		new_stack.st_top = s->sk_arena;			/* Lowest possible top */
		new_stack.st_end = s->sk_end;			/* End of first chunk */
	}

	moving = rt_g_data.status;				/* Garbage collector's state */
	generational = moving & GC_FAST;	/* Is this a collect() cycle? */
	moving &= GC_PART | GC_GEN;			/* Current algorithm moves objects? */

#ifdef DEBUG
	dprintf(1)("update_rem_set: %d objects to be studied\n",
		nb_items(&rem_set));
	flush;
#endif

	for (s = rem_set.st_hd; s && !done; s = s->sk_next) {
		object = s->sk_arena;				/* Start of stack */
		if (s != rem_set.st_cur)			/* Top is before after 's' */
			n = s->sk_end - object;			/* Look at the whole chunk */
		else {
			n = rem_set.st_top - object;	/* Stop at the top */
			done = 1;						/* Reached end of stack */
		}

		for (; n > 0; n--, object++) {
			current = *object;				/* Save that for later perusal */
			zone = HEADER(current);			/* Object's header */

#ifdef DEBUG
			dprintf(4)("update_rem_set: at 0x%lx (type %d, %d bytes) %s%s\n",
				current,
				HEADER(
					zone->ov_size & B_FWD ? zone->ov_fwd : current
				)->ov_flags & EO_TYPE,
				zone->ov_size & B_SIZE,
				zone->ov_size & B_FWD ? "forwarded" : "",
				zone->ov_flags & EO_MARK ? "marked" : ""
			);
			flush;
#endif

			/* When objects are moving, we need to focus on both the B_FWD
			 * mark (which is an indication that the object is alive) and the
			 * EO_MARK which is the traditional alive mark. Dead objects are
			 * simply removed from the remembered set.
			 */

			if (moving) {					/* Object may move? */
				if (zone->ov_size & B_FWD)	/* Object was forwarded */
					current = zone->ov_fwd;	/* Follow forwarding pointer */
				else if (!(zone->ov_flags & EO_MARK))	/* Object is dead */
					continue;				/* Remove it from remembered set */
			} else if (!(zone->ov_flags & EO_MARK))	/* Object cannot move */
				continue;					/* It's dead -- remove it */

			/* In a generational cycle, we need to explicitely unmark all the
			 * alive objects, whether we keep them in the remembered set or
			 * not. Why? Because when we tenure those objects, we mark them
			 * and also set the EO_OLD and EO_REM bit. If we do not unmark them
			 * and those are once functions, then we will never scan the inside
			 * of those objects. In other cycles, the unmarking will be done
			 * by the full sweep operation.
			 */

			if (generational)
				HEADER(current)->ov_flags &= ~EO_MARK;	/* Unmark object */

			/* The objects referred by the current object could have been
			 * tenured, so we need to recheck whether it has its place in the
			 * remembered set.
			 */

			if (refers_new_object(current))	/* Object deserves remembering? */
				epush(&new_stack, current);	/* Save it for posterity */
			else
				HEADER(current)->ov_flags &= ~EO_REM;	/* Not remembered */

#ifdef DEBUG
			dprintf(4)("update_rem_set: %s object %lx (type %d, %d bytes) %s\n",
				HEADER(current)->ov_flags & EO_OLD ? "old" :
					HEADER(current)->ov_flags & EO_NEW ? "new" : "gen",
				current, HEADER(current)->ov_flags & EO_TYPE,
				HEADER(current)->ov_size & B_SIZE,
				HEADER(current)->ov_flags & EO_REM ? "remembered":"forgotten");
			flush;
#endif

		}
	}

#ifdef DEBUG
	dprintf(1)("update_rem_set: %d objects remaining\n",
		nb_items(&new_stack));
	flush;
#endif

	/* Objects remembered have been pushed on stack "new_stack". Now reset the
	 * remembered set correctly by making "rem_set" refer to the new stack.
	 */

	memcpy (&rem_set, &new_stack, sizeof(struct stack));

	/* Usually, the remembered set shrinks after a collection. The unused chunks
	 * in the stack are freed. Yet, we'll have to call malloc() again to extend
	 * the stack, but this raises the chances of being able to shrink the
	 * process size--RAM.
	 */
	
	st_truncate(&rem_set);
}

rt_private void update_memory_set ()
	/* Traverse the memory_set which contains all the objects, which have a
	 * dispose routine. It calls the dispose routine
	 * on the objects thar are garbage.
	 * To be compared with "update_rem_set ()". 
	 * -- ET
	 */
{
	EIF_GET_CONTEXT					/* In MT-mode, for memory_set.	*/

	EIF_REFERENCE *object;					/* Current inspected object */
	rt_uint_ptr n;							/* Number of objects to be dealt with */
	struct stack new_stack;			/* The new stack built from the old one */
	EIF_REFERENCE current;		/* Address of inspected object */
	union overhead *zone;	/* Malloc info zone */
	struct stchunk *s;	/* To walk through each stack's chunk */
	int saved_in_assertion;			/* Saved assertion level.	*/
	char gc_status;					/* Saved GC status.	*/
	int dtype;						/* Dynamic type of Current object.	*/
	int done = 0;					/* Top of stack not reached yet */

	REQUIRE ("GC is not stopped", !(rt_g_data.status & GC_STOP));

	/************************* End of postconditions. **********************/

	memcpy (&new_stack, &memory_set, sizeof(struct stack));
	s = new_stack.st_cur = memory_set.st_hd;		/* New empty stack */
	if (s) {
		new_stack.st_top = s->sk_arena;				/* Lowest possible top */
		new_stack.st_end = s->sk_end;				/* End of first chunk */
	}

#ifdef DEBUG_UPDATE_MEMORY_SET
	printf("update_memory_set: %d objects to be studied\n",
		nb_items(&memory_set));
#endif

	/* Traverse stack.	*/
	for (s = memory_set.st_hd; s && !done; s = s->sk_next) 
	{
		object = s->sk_arena;				/* Start of stack */
		if (s != memory_set.st_cur)			/* Top is before after 's' */
			n = s->sk_end - object;			/* Look at the whole chunk */
		else 
		{
			n = memory_set.st_top - object;	/* Stop at the top */
			done = 1;						/* Reached end of stack */
		}

		for (; n > 0; n--, object++) 
		{
			current = *object;				/* Save that for later perusal */
			zone = HEADER(current);			/* Object's header */

#ifdef DEBUG_UPDATE_MEMORY_SET
			printf("update_memory_set: at 0x%lx (type %d, %d bytes) %s\n",
				current,
				HEADER(
					zone->ov_size & B_FWD ? zone->ov_fwd : current
				)->ov_flags & EO_TYPE,
				zone->ov_size & B_SIZE,
				zone->ov_size & B_FWD ? "forwarded" : "dead"
			);
#endif	/* DEBUG_UPDATE_MEMORY_SET	*/

			/* We need to call the dispose routine on the objects that
			 * not alive any longer. 
			 * If the object holds the B_FWD flag, it has survived the 
			 * generational collection and we just need to update the proper
			 * entry in the stack. Otherwise it is garbage: we must call the 
			 * dispose routine on it and remove it from the stack. 
			 */

			CHECK ("Objects not in GSZ", !(zone->ov_size & (EO_OLD | EO_NEW | EO_MARK | EO_SPEC)));	

			if (zone->ov_size & B_FWD)	/* Object survived GS collection. */
			{
				current = zone->ov_fwd;		/* Update entry. */

				CHECK ("Has dispose routine", Disp_rout (Dtype (HEADER (current) + 1)));
				CHECK ("Not forwarded twice", !(HEADER (current)->ov_size & B_FWD));

				if (!(HEADER (current)->ov_flags & (EO_OLD | EO_NEW)))
										/* Forwarded object is still in GSZ. */
					epush(&new_stack, current);		/* Save it in the stack. */
			}
			else 									/* Object is dead. */
			{										/* Call dispose routine.*/
				dtype = Deif_bid(zone->ov_flags);	/* Need it for dispose.	*/ 

				CHECK ("Has with dispose routine", Disp_rout (dtype));

				gc_status = rt_g_data.status;			/* Save GC status. */
				rt_g_data.status |= GC_STOP;			/* Stop GC. */

				/* We should disable invariants but not postconditions 
				 * (see `dispose' from IDENTIFIED).
 				 */
				saved_in_assertion = in_assertion;	/* Save in_assertion. */
				in_assertion = ~0;			/* Turn off assertion checking. */
				DISP(dtype,(EIF_REFERENCE) (zone + 1));	/* Call 'dispose'. */
				in_assertion = saved_in_assertion;	/* Set in_assertion back. */
				rt_g_data.status = gc_status;		/* Restore previous GC status.*/
				CHECK ("Cannot be in object ID stack",
					!has_object (&object_id_stack, (EIF_REFERENCE) zone + 1));
			}

#ifdef DEBUG_UPDATE_MEMORY_SET
			printf("update_memory_set: object %lx (type %d, %d bytes) %s\n",
				current, HEADER(current)->ov_flags & EO_TYPE,
				HEADER(current)->ov_size & B_SIZE,
				HEADER(current)->ov_size & B_FWD ? "updated":"disposed");
#endif	/* DEBUG_UPDATE_MEMORY_SET	*/

		}	/* for ... */
	}	/* for ... */

#ifdef DEBUG_UPDATE_MEMORY_SET
	printf("update_memory_set: %d objects remaining\n",
		nb_items(&new_stack));
#endif	/* DEBUG_UPDATE_MEMORY_SET	*/

	/* Memory objects have been pushed on stack "new_stack". Now reset the
	 * the memory set correctly by making "memory_set" refer to the new stack.
	 */

	memcpy (&memory_set, &new_stack, sizeof(struct stack));

	/* Usually, the memory set shrinks after a collection. The unused chunks
	 * in the stack are freed. 
	 */
	
	st_truncate(&memory_set);

}	/* update_memory_set() */	


rt_shared int refers_new_object(register EIF_REFERENCE object)
{
	/* Does 'object' directly refers to a new object? Stop as soon as the
	 * answer is known. Return a boolean value stating the result. This
	 * routine is recursively called to deal with expanded objects. However,
	 * there are few of them, so I chose to delcare locals in registers--RAM.
	 */

	uint32 flags;			/* Eiffel flags */
	int refs;				/* Number of references */
	EIF_REFERENCE root;			/* Address of referred object */
	uint32 size;			/* Size in bytes of an item */

#ifdef MAY_PANIC
	/* If 'object' is a void reference, panic immediately */
	if (object == (EIF_REFERENCE) 0)
		eif_panic("remembered set botched");
#endif

	size = REFSIZ;
	flags = HEADER(object)->ov_flags;	/* Fetch Eiffel flags */
	if (flags & EO_SPEC) {				/* Special object */
		EIF_REFERENCE o_ref;
		if (!(flags & EO_REF))			/* (see hybrid_mark() for details) */
			return 0;					/* No references at all */
		o_ref = RT_SPECIAL_INFO(object);
		refs = RT_SPECIAL_COUNT_WITH_INFO(o_ref);
		if (flags & EO_TUPLE) {
			EIF_TYPED_ELEMENT *l_item = (EIF_TYPED_ELEMENT *) object;
			l_item ++;
			refs--;
			for (; refs > 0; refs--, l_item++) {
				if (eif_tuple_item_type (l_item) == EIF_REFERENCE_CODE) {
					root = eif_reference_tuple_item(l_item);
					if (root) {
						if (!(HEADER(root)->ov_flags & EO_OLD)) {
							return 1;
						}
					}
				}
			}
				/* Job is now done */
			return 0;
		} else if (flags & EO_COMP)			/* Composite object = has expandeds */
			size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ref) + OVERHEAD;
		else
			size = REFSIZ;		/* Usual item size */
	} else
		refs = References(Deif_bid(flags));	/* Number of references */

	/* Loop over the referenced objects to see if there is a new one. If the
	 * reference is on an expanded object, recursively explore that object.
	 * No infinite loop is to be feared, as expanded object can only have ONE
	 * reference from the object within which they are held.
	 * When checking for new object, I check for not EO_OLD, because the new
	 * objects in the scavenge zone do not carry the EO_NEW mark.
	 */
	for (; refs != 0; refs--, object += size) {
		root = *(EIF_REFERENCE *) object;			/* Get reference */
		if (root == (EIF_REFERENCE) 0)
			continue;						/* Skip void references */
		flags = HEADER(root)->ov_flags;
		if (flags & EO_EXP)	{				/* Expanded object, grrr... */
			if (refers_new_object(root))
				return 1;					/* Object references a young one */
		} else if (!(flags & EO_OLD))
			return 1;						/* Object references a young one */
	}

	return 0;		/* Object does not reference any new object */
}

rt_private void swap_gen_zones(void)
{
	/* After a generation scavenging, swap the 'from' and 'to' zones. There is
	 * no need to loop over the old 'from' and dispose dead objects: no objects
	 * with a dispose procedure are allowed to be allocated there.
	 */

	struct sc_zone temp;				/* For swapping */

	/* Before swapping, we have to compute the amount of bytes we copied and
	 * the size of the original scavenging zone so that we can update the
	 * statistics accordingly. Unfortunately, those figures are counting the
	 * overhead associated with the objects--RAM.
	 */

	rt_g_data.mem_copied += sc_from.sc_top - sc_from.sc_arena;	/* Initial */
	rt_g_data.mem_move += sc_to.sc_top - sc_to.sc_arena;		/* Moved */

	memcpy (&temp, &sc_from, sizeof(struct sc_zone));
	memcpy (&sc_from, &sc_to, sizeof(struct sc_zone));
	memcpy (&sc_to, &temp, sizeof(struct sc_zone));

	sc_to.sc_top = sc_to.sc_arena;	/* Make sure 'to' is empty */
}

rt_public void eremb(EIF_REFERENCE obj)
{
	/* Remembers the object 'obj' by pushing it in the remembered set.
	 * It is up to the caller to ensure that 'obj' is not already remembered
	 * by testing the EO_REM bit in the header. In affectations, it is
	 * normally done by the RTAR macro.
	 */

	GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_LOCK);
	if (-1 == epush(&rem_set, obj)) {		/* Low on memory */
		GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
		urgent_plsc(&obj);					/* Compacting garbage collection */
		GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_LOCK);
		if (-1 == epush(&rem_set, obj)) {	/* Still low on memory */
			GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
			enomem(MTC_NOARG);						/* Critical exception */
		} else {
			GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
		}
	} else {
		GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
	}

#ifdef DEBUG
	dprintf(4)("eremb: remembering object %lx (type %d, %d bytes) at age %d\n",
		obj,
		HEADER(obj)->ov_flags & EO_TYPE,
		HEADER(obj)->ov_size & B_SIZE,
		(HEADER(obj)->ov_flags & EO_AGE) >> AGE_OFFSET);
	flush;
#endif

	/* If we come here, the object was successfully pushed in the stack */
	
	HEADER(obj)->ov_flags |= EO_REM;	/* Mark it as remembered */
}

rt_public void erembq(EIF_REFERENCE obj)
{
	/* Quick version of eremb(), but without any call to the GC. This is
	 * provided for special objects (we don't want to ask for GC hooks
	 * on every 'put' operation).
	 */

	GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_LOCK);
	if (-1 == epush(&rem_set, obj)) {		/* Cannot record object */
		GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
		enomem(MTC_NOARG);						/* Critical exception */
	} else {
		GC_THREAD_PROTECT(EIF_GC_SET_MUTEX_UNLOCK);
	}

	HEADER(obj)->ov_flags |= EO_REM;	/* Mark object as remembered */
}


/*
 * Freeing objects: each class has a chance to redefine the 'dispose' routine
 * which will be called whenever the object is released under GC control.
 * Of course the dispose MUST NOT do anything fancy: the collection cycle is
 * done so all the pointers are safe, but the object is meant to be destroyed,
 * so its address cannot be kept to be put in a free-list for instance. To
 * minimize problems, the garbage collector is stopped before invoking the
 * 'dispose' routine--RAM.
 */

rt_shared void gfree(register union overhead *zone)
							/* Pointer on malloc info zone */
{
	/* The entry Dispose(type) holds a pointer to the dispose function to
	 * be called when freeing an entity of dynamic type 'type'. A void entry
	 * means nothing has to be done. Of course, the object is physically
	 * freed AFTER dispose has been called...
	 */

	EIF_GET_CONTEXT
	char gc_status;					/* Saved GC status */
	int saved_in_assertion;		/* Saved in_assertion value */
	uint32 dtype;			/* Dynamic type of object */

	REQUIRE("Busy", zone->ov_size & B_BUSY);
							
	if (!(zone->ov_size & B_FWD)) {	/* If object has not been forwarded
									then call the dispose routine */
		if (zone->ov_flags & EO_DISP) { 
			dtype = Deif_bid(zone->ov_flags);
			EIF_G_DATA_MUTEX_LOCK;
			gc_status = rt_g_data.status;			/* Save GC status */
			rt_g_data.status |= GC_STOP;			/* Stop GC */
			EIF_G_DATA_MUTEX_UNLOCK;
			saved_in_assertion = in_assertion;	/* Save in_assertion */
			in_assertion = ~0;					/* Turn off assertion checking */
			DISP(dtype,(EIF_REFERENCE) (zone + 1));	/* Call 'dispose' */
			in_assertion = saved_in_assertion;	/* Set in_assertion back */
			EIF_G_DATA_MUTEX_LOCK;
			rt_g_data.status = gc_status;			/* Restore previous GC status */
			EIF_G_DATA_MUTEX_UNLOCK;
		}
	}

	CHECK ("Cannot be in object ID stack",
		!has_object (&object_id_stack, (EIF_REFERENCE) zone + 1));

#ifdef DEBUG
	dprintf(8)("gfree: freeing object 0x%lx, DT = %d\n",
		zone + 1, dtype);
	flush;
#endif

	eif_rt_xfree((EIF_REFERENCE) (zone + 1));		/* Put object back to free-list */
}

#endif

/* Once functions need to be kept in a dedicated stack, so that they are
 * always kept alive. Before returning, a once function needs to call the
 * following to properly record itself.
 */

rt_public EIF_REFERENCE * onceset(void)
{
	/* Record result of once functions onto the once_set stack, so that the
	 * run-time may update the address should the result be moved around by
	 * the garbage collector (we are storing the address of a C static variable.
	 */

	EIF_GET_CONTEXT
#ifdef DEBUG
	dprintf(32)("onceset");
	flush;
#endif
	
	if (-1 == epush(&once_set, (EIF_REFERENCE) 0 ))
		eraise("once function recording", EN_MEM);

	return once_set.st_top - 1;
}

rt_public void new_onceset(EIF_REFERENCE address)
{
	/* Record result of once functions onto the once_set stack, so that the
	 * run-time may update the address should the result be moved around by
	 * the garbage collector (we are storing the address of a C static variable.
	 */

	EIF_GET_CONTEXT
	if (-1 == epush(&once_set, (EIF_REFERENCE) address))
		eraise("once function recording", EN_MEM);
}

/*
doc:	<routine name="register_oms" return_type="void" export="public">
doc:		<summary>Register an address of a once manifest string in the
doc:		`oms_set' so that the run-time may update the address should
doc:		the string objec be moved around by the garbage collector.</summary>
doc:		<param name="address" type="EIF_REFERENCE *">Address of a memory location
doc:		that stores a string object.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Uses only per thread data.</synchronization>
doc:	</routine>
*/
rt_public void register_oms (EIF_REFERENCE *address)
{
	EIF_GET_CONTEXT
	if (-1 == epush(&oms_set, address)) {
		eraise("once manifest string recording", EN_MEM);
	}
}

#if defined(WORKBENCH) || defined(EIF_THREADS)
/*
doc:	<routine name="alloc_once_indexes" export="shared">
doc:		<summary>Allocate array to store once routine indexes during start-up.</summary>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Not required when used during start-up in main thread.</synchronization>
doc:	</routine>
*/
rt_shared void alloc_once_indexes (void)
{
	if ((EIF_once_indexes == (BODY_INDEX *) 0) && (eif_nb_org_routines != 0)) {
			/* Indexes have not been allocated yet. */
		EIF_once_indexes = (BODY_INDEX *) eif_calloc (eif_nb_org_routines, sizeof *EIF_once_indexes);
		if (EIF_once_indexes == (BODY_INDEX *) 0) { /* Out of memory */
			enomem ();
		}
	}
#ifdef EIF_THREADS
	if ((EIF_process_once_indexes == (BODY_INDEX *) 0) && (eif_nb_org_routines != 0)) {
			/* Indexes have not been allocated yet. */
		EIF_process_once_indexes = (BODY_INDEX *) eif_calloc (eif_nb_org_routines, sizeof *EIF_process_once_indexes);
		if (EIF_process_once_indexes == (BODY_INDEX *) 0) { /* Out of memory */
			enomem ();
		}
	}
#endif
}

/*
doc:	<routine name="free_once_indexes" export="shared">
doc:		<summary>Free array of once routine indexes.</summary>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Not required when used during start-up in main thread.</synchronization>
doc:	</routine>
*/
rt_shared void free_once_indexes (void)
{
	if (EIF_once_indexes != (BODY_INDEX *) 0) {
		eif_free (EIF_once_indexes);
		EIF_once_indexes = (BODY_INDEX *) 0;
	}
#ifdef EIF_THREADS
	if (EIF_process_once_indexes != (BODY_INDEX *) 0) {
		eif_free (EIF_process_once_indexes);
		EIF_process_once_indexes = (BODY_INDEX *) 0;
	}
#endif
}

/*
doc:	<routine name="once_index" return_type="ONCE_INDEX" export="public">
doc:		<summary>Calculate index of a once routine in an array of
doc:		once routine results given its code index.</summary>
doc:		<param name="code_id" type="BODY_INDEX">Code index of a once routine.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Not required when used during start-up in main thread.</synchronization>
doc:	</routine>
*/
rt_public ONCE_INDEX once_index (BODY_INDEX code_id)
{
	BODY_INDEX * p = EIF_once_indexes;
	ONCE_INDEX i = 0;
	while (1)
	{
		BODY_INDEX index = p [i];
		if (index == code_id) {
				/* Once routine with this `code_id' is found. */
				/* Use it. */
			break;
		}
		else if (index == 0)
		{
				/* Once routine with this `code_id' is not found. */
				/* Add it. */
			p [i] = code_id;
			EIF_once_count++;
			break;
		}
		i++;
	}
	return i;
}
#endif

#ifdef EIF_THREADS
/*
doc:	<routine name="process_once_index" return_type="ONCE_INDEX" export="public">
doc:		<summary>Calculate index of a process-relative once routine in an array of
doc:		process-relative once routine results given its code index.</summary>
doc:		<param name="code_id" type="BODY_INDEX">Code index of a once routine.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Not required when used during start-up in main thread.</synchronization>
doc:	</routine>
*/
rt_public ONCE_INDEX process_once_index (BODY_INDEX code_id)
{
	BODY_INDEX * p = EIF_process_once_indexes;
	ONCE_INDEX i = 0;
	while (1)
	{
		BODY_INDEX index = p [i];
		if (index == code_id) {
				/* Once routine with this `code_id' is found. */
				/* Use it. */
			break;
		}
		else if (index == 0)
		{
				/* Once routine with this `code_id' is not found. */
				/* Add it. */
			p [i] = code_id;
			EIF_process_once_count++;
			break;
		}
		i++;
	}
	return i;
}

/*
doc:	<routine name="globalonceset" export="public">
doc:		<summary>Insert a global once result `address' which is an EIF_REFERENCE into `global_once_set' so that GC can update `address' and track objects references by `address' during a collection.</summary>
doc:		<param name="address" type="EIF_REFERENCE">Address that needs to be tracked/protected.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_global_once_set_mutex'</synchronization>
doc:	</routine>
*/

rt_public void globalonceset(EIF_REFERENCE address)
{
	EIF_LW_MUTEX_LOCK(eif_global_once_set_mutex, "Could not lock global once mutex");
	if (-1 == epush(&global_once_set, address)) {
		EIF_LW_MUTEX_UNLOCK(eif_global_once_set_mutex, "Could not unlock global once mutex");
		eraise("once function recording", EN_MEM);
	}
	EIF_LW_MUTEX_UNLOCK(eif_global_once_set_mutex, "Could not unlock global once mutex");
}
#endif

/*
 * Stack handling routines. Each of these require the address of the
 * associated stack structure as a parameter. This avoids code duplication
 * at the cost of an additional parameter--RAM.
 * A stack is a collection of some small chunks, linked together. The main
 * structure 'stack' describes the whole data structure completely.
 */

rt_shared int epush(register struct stack *stk, register void *value)
									/* The stack */
									/* Value to be pushed */
{
	/* Push 'value' on top of the given stack 'stk'. If the stack is
	 * full, we try to allocate a new chunk. If this fails, nothing is done,
	 * and -1 is returned to signal failure. Otherwise 0 is returned.
	 */
	RT_GET_CONTEXT
	EIF_REFERENCE *top = stk->st_top;		/* Current top of stack */

	if (top == (EIF_REFERENCE *) 0)	{					/* No stack yet? */
		top = st_alloc(stk, eif_stack_chunk);		/* Create one */
		if (top == (EIF_REFERENCE *) 0)
			return -1;				/* Could not create stack */
	}

#ifdef DEBUG
	dprintf(32)("epush: value 0x%lx on stack 0x%lx\n", value, stk);
	flush;
#endif

	if (stk->st_end == top) {
		/* The end of the current stack chunk has been reached. If there is
		 * a chunk allocated after the current one, use it, otherwise create
		 * a new one and insert it in the list.
		 */
		SIGBLOCK;							/* Critical section */
		if (stk->st_cur == stk->st_tl) {	/* Reached last chunk */
			if (-1 == st_extend(stk, eif_stack_chunk))
				return -1;			/* Could not extend stack */
			top = stk->st_top;		/* New top */
		} else {
			struct stchunk *current;		/* New current chunk */

			/* Update the new stack context (main structure) */
			current = stk->st_cur = stk->st_cur->sk_next;
			top = stk->st_top = current->sk_arena;
			stk->st_end = current->sk_end;
		}
		SIGRESUME;		/* End of critical section */
	}

	*top++ = value;			/* Push value on top of the stack */
	stk->st_top = top;		/* Points to next free location */

	return 0;		/* Value was successfully pushed on the stack */
}

rt_shared EIF_REFERENCE *st_alloc(register struct stack *stk, register int size)
									/* The stack */
				 					/* Initial size */
{
	/* The stack 'stk' is created, with size 'size'. Return the arena value */
	RT_GET_CONTEXT
	EIF_REFERENCE *arena;				/* Address for the arena */
	struct stchunk *chunk;	/* Address of the chunk */
	rt_uint_ptr l_size = size * REFSIZ + sizeof(struct stchunk);

	chunk = (struct stchunk *) eif_rt_xmalloc(l_size, C_T, GC_OFF);
	if (chunk == (struct stchunk *) 0)
		return (EIF_REFERENCE *) 0;		/* Malloc failed for some reason */

	SIGBLOCK;							/* Critical section */
	stk->st_hd = chunk;					/* New stack (head of list) */
	stk->st_tl = chunk;					/* One chunk for now */
	stk->st_cur = chunk;				/* Current chunk */
	arena = (EIF_REFERENCE *) (chunk + 1);		/* Header of chunk */
	stk->st_top = arena;				/* Empty stack */
	chunk->sk_arena = arena;			/* Base address */
	stk->st_end = chunk->sk_end =
		(EIF_REFERENCE *) ((char *) chunk + l_size);	/* First free location beyond stack */
	chunk->sk_next = (struct stchunk *) 0;
	chunk->sk_prev = (struct stchunk *) 0;
	SIGRESUME;							/* End of critical section */

	return arena;			/* Stack allocated */
}

rt_shared int st_extend(register struct stack *stk, register int size)
									/* The stack */
				 					/* Size of new chunk to be added */
{
	/* The stack 'stk' is extended and the 'stk' structure updated.
	 * 0 is returned in case of success. Otherwise, -1 is returned.
	 */
	RT_GET_CONTEXT
	EIF_REFERENCE *arena;				/* Address for the arena */
	struct stchunk *chunk;	/* Address of the chunk */
	rt_uint_ptr l_size = size * REFSIZ + sizeof(struct stchunk);

	chunk = (struct stchunk *) eif_rt_xmalloc(l_size, C_T, GC_OFF);
	if (chunk == (struct stchunk *) 0)
		return -1;		/* Malloc failed for some reason */

	SIGBLOCK;								/* Critical section */
	arena = (EIF_REFERENCE *) (chunk + 1);			/* Header of chunk */
	chunk->sk_next = (struct stchunk *) 0;	/* Last chunk in list */
	chunk->sk_prev = stk->st_tl;			/* Preceded by the old tail */
	stk->st_tl->sk_next = chunk;			/* Maintain link w/previous */
	stk->st_tl = chunk;						/* New tail */
	chunk->sk_arena = arena;				/* Where items are stored */
	chunk->sk_end =
		(EIF_REFERENCE *) ((char *) chunk + l_size);	/* First item beyond chunk */
	stk->st_top = arena;					/* New top */
	stk->st_end = chunk->sk_end;			/* End of current chunk */
	stk->st_cur = chunk;					/* New current chunk */
	SIGRESUME;								/* End of critical section */

	return 0;			/* Everything is ok */
}

rt_shared void st_truncate(register struct stack *stk)
									/* The stack to be truncated */
{
	/* Free unused chunks in the stack. If the current chunk has at least
	 * MIN_FREE locations, then we may free all the chunks starting with the
	 * next one. Otherwise, we skip the next chunk and free the remainder.
	 */

	EIF_REFERENCE *top;			/* The current top of the stack */
	struct stchunk *next;			/* Address of next chunk */

	top = stk->st_top;						/* The first free location */
	if (top == (EIF_REFERENCE *) 0)					/* Not allocated yet */
		return;

	if (stk->st_end - top > MIN_FREE) {		/* Enough locations left */
		stk->st_tl = stk->st_cur;			/* Last chunk from now on */
		st_wipe_out(stk->st_cur->sk_next);	/* Free starting at next chunk */
	} else {								/* Current chunk is nearly full */
		next = stk->st_cur->sk_next;		/* We are followed by 'next' */
		if (next != (struct stchunk *) 0) {	/* There is indeed a next chunk */
			stk->st_tl = next;				/* New tail chunk */
			st_wipe_out(next->sk_next);		/* Skip it, wipe out remainder */
		}
	}
}

rt_shared void st_wipe_out(register struct stchunk *chunk)
							 		/* First chunk to be freed */
{
	/* Free all the chunks after 'chunk' */

	struct stchunk *next;		/* Address of next chunk */

	if (chunk == (struct stchunk *) 0)	/* No chunk */
		return;							/* Nothing to be done */

	chunk->sk_prev->sk_next = (struct stchunk *) 0;	/* Nothing after previous */

	for (
		next = chunk->sk_next;
		chunk != (struct stchunk *) 0;
		chunk = next, next = chunk ? chunk->sk_next : chunk
	)
		eif_rt_xfree((EIF_REFERENCE) chunk);
}

rt_public void st_reset(struct stack *stk)
		/* The stack */
{
	/* Reset the stack 'stk' to its minimal state and disgard all its
	 * contents. Walking through the list of chunks, we free them and
	 * clear the 'stk' structure.
	 */

	struct stchunk *k;	/* To walk through the list */
	struct stchunk *n;	/* Save next before freeing chunk */

	for (k = stk->st_hd; k; k = n) {
		n = k->sk_next;		/* This is not necessary given current eif_rt_xfree() */
		eif_rt_xfree((EIF_REFERENCE) k);	/* But how do I know implementation won't change? */
	}

	memset (stk, 0, sizeof(struct stack));
}

#ifdef ISE_GC
#ifdef DEBUG
rt_private void scavenge_statistics (struct sc_zone *to)
{
	char *arena = NULL;
	char *top = NULL;
	EIF_REFERENCE obj = NULL;
	EIF_INTEGER size = 0, total_size = 0;
	EIF_INTEGER nb = 0, i = 0;
	EIF_INTEGER max_size = 0, min_size = 0x7fffffff, average_size = 0;
	EIF_INTEGER alignmax = ((MEM_ALIGNBYTES < OVERHEAD) ? OVERHEAD : MEM_ALIGNBYTES);
	EIF_INTEGER count = 100;
	EIF_INTEGER *nb_allocated = (EIF_INTEGER *) malloc (sizeof (EIF_INTEGER) * (count + 1));

	REQUIRE("to not null", to != NULL);

	arena = to->sc_arena;
	top = to->sc_top;

	memset (nb_allocated, 0, sizeof(EIF_INTEGER) * (count + 1));

	while ((arena + OVERHEAD) <= top) {
		obj = arena + OVERHEAD;
		nb++;
		size = HEADER(obj)->ov_size & B_SIZE;
		if (size > count) {
			nb_allocated = realloc (nb_allocated, sizeof (EIF_INTEGER) * (size + 1));
			memset (nb_allocated + count, 0, sizeof(EIF_INTEGER) * (size + 1 - count));
			count = size;
		}
		nb_allocated [size] = nb_allocated [size] + 1;

		if (size > max_size) {
			max_size = size;
		}
		if (size < min_size) {
			min_size = size;
		}
		total_size += size;
		arena += size + OVERHEAD + (alignmax - OVERHEAD);
	}

	average_size = total_size / nb;

	dprintf(1) ("Total size is %d\n", total_size);
	dprintf(1) ("Number of objects is %d\n", nb);
	dprintf(1) ("Occupied zone is %d\n", nb * OVERHEAD + total_size);
	dprintf(1) ("Min size is %d\n", min_size);
	dprintf(1) ("Max size is %d\n", max_size);
	dprintf(1) ("Average size is %d\n", average_size);
	for (i = 0; i <= count; i ++) {
		if (nb_allocated [i] > 0) {
			dprintf(1) (" Allocated %d objects of size %d\n", nb_allocated [i], i);
		}
	}
	dprintf(1) ("\n");
}

rt_private int nb_items(struct stack *stk)
		/* The stack */
{
	/* Gives the number of items held in the stack */

	struct stchunk *s;	/* To walk through the list */
	int n = 0;			/* Number of items */
	int done = 0;			/* Top of stack not reached yet */

	for (s = stk->st_hd; s && !done; s = s->sk_next) {
		if (s != stk->st_cur)
			n += s->sk_end - s->sk_arena;		/* The whole chunk */
		else {
			n += stk->st_top - s->sk_arena;		/* Stop at the top */
			done = 1;							/* Reached end of stack */
		}
	}

	return n;		/* Number of objects held in stack */
}
#endif	/* !NDEBUG */

#endif /* ISE_GC */

#ifdef __cplusplus
}
# endif

/*
doc:</file>
*/
