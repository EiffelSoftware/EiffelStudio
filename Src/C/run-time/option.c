/*
	description: "Option queries, profiler core, tracer core."
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
doc:<file name="option.c" header="eif_option.h" version="$Id$" summary="Option queries, profiler core, tracer core, assertions level">
*/

#include "eif_portable.h"
#include "eif_project.h"
#ifdef _CRAY
#include <sys/machd.h>
#endif
#include "eif_struct.h"
#include "rt_option.h"
#include "rt_hashin.h"
#include "rt_lmalloc.h"
#include "rt_garcol.h"
#include "rt_malloc.h"
#include "eif_macros.h"
#include "rt_err_msg.h"
#include "rt_except.h"
#include "rt_timer.h"
#include "eif_misc.h"
#include "rt_tools.h"		/* For hashcode() */
#include "rt_main.h"
#include "rt_dir.h"
#include <stdio.h>
#include <string.h>
#include "rt_assert.h"

#ifdef EIF_WINDOWS
#elif defined(HAS_GETRUSAGE)
#elif defined(HAS_TIMES)
#else
#include <sys/timeb.h>
#include <time.h>
#endif

struct prof_info {
	char			*featurename;		/* Name of feature */
	EIF_TYPE_INDEX	dtype;				/* DTYPE of feature */
	EIF_TYPE_INDEX	origin;				/* ORIGIN of feature */
	rt_uint_ptr		feature_hcode;		/* Hash code */
	rt_uint64		number_of_calls;	/* # calls to feature */
	rt_uint64		this_total_time;
	rt_uint64		all_total_time;
	rt_uint64		descendent_time;
	int				is_running;			/* Is the feature running? */
};

#ifndef EIF_THREADS

/* Special additional data needed for keeping track of time depending on the implementation. */
#ifdef EIF_WINDOWS
#elif defined(HAS_GETRUSAGE)
#elif defined(HAS_TIMES)
/*
doc:	<attribute name="rt_nb_ticks_per_second" return_type="rt_uint64" export="shared">
doc:		<summary>Number of ticks in one seconds. Needed to compute number of nanoseconds a tick is equal to.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_private rt_uint64 rt_nb_ticks_per_second;

#else
/*
doc:	<attribute name="rt_start_time" return_type="rt_uint64" export="shared">
doc:		<summary>Time when application started in nanoseconds.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_private rt_uint64 rt_start_time;
#endif

/*
doc:	<attribute name="trace_call_level" return_type="int" export="public">
doc:		<summary>Call level for Eiffel tracing recursive calls (wether direct or indirect).</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_public int trace_call_level = 0;

/*
doc:	<attribute name="prof_stack" return_type="struct stack *" export="public">
doc:		<summary>Profiler stack where `struct prof_info *' are stored. In multithreaded mode, we perform a per thread profiling.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_public struct stack *prof_stack;

/* INTERNAL TRACE VARIABLES */

/*
doc:	<attribute name="eif_trace_disabled" return_type="int" export="private">
doc:		<summary>Is tracing currently disabled at the application level? By default 0.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private int eif_trace_disabled = 0;

/*
doc:	<attribute name="last_dtype" return_type="int" export="private">
doc:		<summary>Along with `last_origin' and `last_name', these three variables are needed because we want to print "...---..." instead of "...&gt;&gt;&gt;... _nextline_ ...&lt;&lt;&lt;..."  when we deal with a so called terminal feature (a feature without calls to other features)</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private int last_dtype;

/*
doc:	<attribute name="last_origin" return_type="int" export="private">
doc:		<summary>Along with `last_origin' and `last_name', these three variables are needed because we want to print "...---..." instead of "...&gt;&gt;&gt;... _nextline_ ...&lt;&lt;&lt;..."  when we deal with a so called terminal feature (a feature without calls to other features)</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private int last_origin;

/*
doc:	<attribute name="last_name" return_type="int" export="private">
doc:		<summary>Along with `last_origin' and `last_name', these three variables are needed because we want to print "...---..." instead of "...&gt;&gt;&gt;... _nextline_ ...&lt;&lt;&lt;..."  when we deal with a so called terminal feature (a feature without calls to other features)</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private char *last_name;

/* INTERNAL PROFILE STRUCTURES */

/*
doc:	<attribute name="init_date" return_type="rt_uint64" export="private">
doc:		<summary>Store starting date of profiling.</summary>
doc:		<access>Read/Write once</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private rt_uint64 init_date;

#define EIF_TRACE_LOCK
#define EIF_TRACE_UNLOCK
#else	/* EIF_THREADS */

/*
doc:	<attribute name="eif_trace_mutex" return_type="EIF_LW_MUTEX_TYPE" export="shared">
doc:		<summary>Ensure that outputs of tracing are properly synchronized.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</attribute>
*/
rt_shared	EIF_LW_MUTEX_TYPE *eif_trace_mutex = (EIF_LW_MUTEX_TYPE *) 0;
#define EIF_TRACE_LOCK	EIF_ASYNC_SAFE_LW_MUTEX_LOCK (eif_trace_mutex, "Couldn't lock trace mutex");
#define EIF_TRACE_UNLOCK EIF_ASYNC_SAFE_LW_MUTEX_UNLOCK (eif_trace_mutex, "Couldn't unlock trace mutex");

#endif

/* Convenient macros to convert units to nanoseconds. */
#define NB_NANO_IN_ONE_SECOND	RTU64C(1000000000)
#define NB_NANO_IN_ONE_MILLI	RTU64C(1000000)
#define NB_NANO_IN_ONE_MICRO	RTU64C(1000)

/*
doc:	<routine name="process_time" return_type="void" export="private">
doc:		<summary>Set `a_timee' with the current process time usage. This is the core of the profiling.</summary>
doc:		<param name="a_time" type="rt_uint64 *">Time argument</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</attribute>
*/
rt_private rt_uint64 process_time (void)
{
#ifdef EIF_WINDOWS
	FILETIME l_creation, l_exit, l_user, l_kernel;
	GetProcessTimes(GetCurrentProcess(), &l_creation, &l_exit, &l_kernel, &l_user);
		/* Times are given in 100-nanoseconds unit. */
	return (*(rt_uint64 *) &l_user + *(rt_uint64 *) &l_kernel) * 100;

#elif defined(HAS_GETRUSAGE)
	struct rusage usage;
	getrusage(RUSAGE_SELF, &usage);

	return usage.ru_utime.tv_sec * NB_NANO_IN_ONE_SECOND + usage.ru_utime.tv_usec * NB_NANO_IN_ONE_MICRO +
		usage.ru_stime.tv_sec * NB_NANO_IN_ONE_SECOND + usage.ru_stime.tv_usec * NB_NANO_IN_ONE_MICRO;

#elif defined(HAS_TIMES)
	struct tms time;

	times(&time);
	return (time.tms_utime + time.tms_stime) / (rt_nb_ticks_per_second * NB_NANO_IN_ONE_SECOND);
#else
	struct timeb tm;

	ftime(&tm);
	return tm->time * NB_NANO_IN_ONE_SECOND + tm->millitm * NB_NANO_IN_ONE_MILLI - rt_start_time;
#endif
}

/* Structure for H table of features.
 * 'hcode' is meant to be the H key of the class
 */
struct feat_table {
	EIF_TYPE_INDEX dtype;					/* The dynamic type of the features */
	struct htable *htab;		/* Features of class corresponding to 'dtype' */
};

#ifndef EIF_THREADS
/*
doc:	<attribute name="class_table" return_type="struct htable *" export="private">
doc:		<summary>The hash-table containing all profiling information. In multithreaded mode, it records a per thread profiling.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>Dtype</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private struct htable *class_table;		/* The H table that contains all info */
#endif

/* INTERNAL PROFILE DEFINITIONS */

#define profile_output_file	"profinfo"

/* INTERNAL PROFILE FUNCTIONS */

rt_public void update_class_table(struct prof_info *item);				/* Update H table */
rt_public void prof_stack_push(struct prof_info *new_item);					/* Push item on staack */
rt_public void prof_stack_free(void);					/* Free profile stack memory */
rt_public void prof_stack_init(void);					/* Initialize stack */
struct prof_info* prof_stack_top(void);		/* Top the stack */
struct prof_info* prof_stack_pop(void);		/* Pop top off stack */


/* Computation of the percentage, it returns a number between 0 and 1 */
rt_private double compute_percentage (rt_uint64, rt_uint64);

/* We do debug only in WORKBENCH mode
 * We also need check_options and check_options_stop in WORKBENCH mode
 */

#ifdef WORKBENCH

rt_public int is_debug(int st_type, char *key)
{
	/* Is the debug option of the class of type `st_type' consistent
	 * with `key'.
	 */

	struct dbg_opt *debug_opt = &(eoption[st_type].debug_level);
	int i;
	int16 dbg_lvl;
	int16 nb_keys;
	char **keys;

	dbg_lvl = debug_opt->debug_level;

	/* no debugging at all? */
	if (dbg_lvl == OPT_NO)
		return 0;

	/* unnamed or named */
	if ((char *) 0 == key)
		return (dbg_lvl & OPT_UNNAMED) == OPT_UNNAMED;
	else {
		nb_keys = debug_opt->nb_keys;
		if (nb_keys == 0) {
			return 0;
		}
		keys = debug_opt->keys;
		for (i=0; i<nb_keys; i++)
			if (strcmp(key,keys[i]) == 0)
				return 1;
		return 0;
	}
}

rt_public void check_options(EIF_CONTEXT struct eif_opt *opt, EIF_TYPE_INDEX dtype)
                    	/* Options for the Eiffel feature*/
          				/* Dtype of the Eiffel class */
{
	/* Check whether the class `dtype' has E-TRACE or E-PROFILE
	 * options in `opt' and dispatch to the finctions `start_trace()'
	 * and `start_profile()' if necessary.
	 * This function is directly called by RTSA in WORKBENCH mode; it is
	 * called explicitly from the interpreter as soon as it determines that
	 * a feature is to be executed.
	 */
	EIF_GET_CONTEXT
	struct ex_vect *vector = (struct ex_vect *) 0;

 	if (opt->trace_level) {
			/* Vector is not initialized before for efficiency:
			 * if both trace and profiling are off,
			 * there is no need to get the exception vector.
			 */

			/* Get top of the exception stack for
			 * the routine name etc.
			 */
		vector = extop(&eif_stack);

			/* User wants tracing. */
		start_trace(vector->ex_rout, vector->ex_orig, dtype);
	}

	if (opt->profile_level) {
		if (!vector) {
				/* Get top of the exception stack for
			 	* the routine name etc.
			 	*/
			vector = extop(&eif_stack);
		}

			/* User wants profiling. */
		start_profile(vector->ex_rout, vector->ex_orig, dtype);
	}
}

rt_public void check_options_stop(EIF_CONTEXT_NOARG)
{
	/* Checks whether the feature on top of the 'eif_stack' is E-TRACEd
	 * and E-PROFILEd and dispatches to the functions `stop_trace()' and
	 * `stop_profile()' if necessary.
	 * This function is called by RTSO, which is called by RTEE. Thus we
	 * guarantee that at least this part of E-TRACE and E-PROFILE will
	 * work for both frozen and melted code.
	 */
	EIF_GET_CONTEXT
	struct ex_vect *vector;
	struct eif_opt opt;
	EIF_TYPE_INDEX dtype;

	vector = extop(&eif_stack);
	dtype = Dtype(vector->ex_id);
	opt = eoption[dtype];

	if (opt.trace_level) {
			/* User wants tracing. */
		stop_trace(vector->ex_rout, vector->ex_orig, dtype);
	}

	if (opt.profile_level) {
			/* User wants profiling. */
		stop_profile();
	}
}

#endif /* WORKBENCH */

rt_public void initprf(void)
{
	/* Creates the table needed for E-PROFILE. This function only
	 * allocates that table if `egc_prof_enabled'. Record the time
	 * to be able to compute the total execution time.
	 */

	if (egc_prof_enabled) {
		RT_GET_CONTEXT
			/* Allocate table */
		class_table = (struct htable *) cmalloc(sizeof(struct htable));
		if (class_table == (struct htable *) 0)
			enomem();

			/* Create H table */
		if (ht_create(class_table, 10, sizeof(struct feat_table))) {
			eraise("Hashtable creation failure", EN_FATAL);
		}

		prof_stack_init();		/* Initialize stack */

#ifdef EIF_WINDOWS
#elif defined(HAS_GETRUSAGE)
#elif defined(HAS_TIMES)
		rt_nb_ticks_per_second = sysconf(_SC_CLK_TCK);
#else
		{
			struct timeb tm;
			ftime(&tm);
			rt_start_time = tm->time * NB_NANO_IN_ONE_SECOND + tm->millitm * NB_NANO_IN_ONE_MILLI;
		}
#endif

		init_date = process_time(); 
	}
}

rt_shared void exitprf(void)
{
	/* Exit profiling. Call this function only at exit of Eiffel system.
	 * Compute the total execution time and the percentage of each feature.
	 * Store information to disk and deallocate structures.
	 */

	/* Check against `init_date' as `initprf' (which initializes `init_date')
	 * might not be called if user disabled profiling in the Ace file and 
	 * enabled it through the PROFILING_SETTING class. */

	RT_GET_CONTEXT
	if (egc_prof_enabled) {
		rt_uint64 execution_time;
		rt_uint_ptr *keys;		/* Keys from H table */
		struct feat_table *f_values;	/* Values from class H table */
		struct prof_info *features;	/* Features from H tables */
		size_t i;					/* Outer-loop-counter */
	    size_t j;					/* Inner-loop-counter */
	    rt_uint64 index;			/* Index counter for output */
		FILE *prof_output;		/* Storage file */
		int l_chdir_res = -1;
#ifdef EIF_THREADS
		char *file_name;
		char buffer[256];
#endif
			
#ifdef WORKBENCH
		char *meltpath = (char *) 0;			/* directory of .UPDT */
		meltpath = (char*) getenv ("MELT_PATH");
		if (meltpath != NULL) {
			l_chdir_res = chdir (meltpath);
		}
		if (l_chdir_res == -1) {
			l_chdir_res = chdir (starting_working_directory);
		}
#else
			/* change the current directory to EIFGEN/F_code
			 * before creating the profile_output_file */
		l_chdir_res = chdir (egc_system_location);
		if (l_chdir_res == -1) {
				/* If we could not change to EIFGEN/F_code, we
				 * set it to the starting working directory */
			l_chdir_res = chdir (starting_working_directory);	
		}
#endif

		execution_time = process_time(); 

#ifdef EIF_THREADS
		sprintf(buffer, "%" EIF_POINTER_DISPLAY, (rt_uint_ptr) eif_thr_context->tid);
		file_name = malloc (strlen(profile_output_file) + strlen(buffer) + 2);
		file_name[0] = '\0';
		strcat (file_name, profile_output_file);
		strcat (file_name, "_");
		strcat (file_name, buffer);
		prof_output = fopen(file_name, "w");
#else
		prof_output = fopen(profile_output_file, "w");
#endif
		if (!prof_output) {
				/* Too bad: no file */
			eraise("Unable to open to output file for profile", EN_FATAL);
		}

		execution_time = execution_time - init_date;

		keys = class_table->h_keys;
		f_values = (struct feat_table *) class_table->h_values;
		index = 1;

		for (i = 0; i < class_table->h_size; i++) {
			if (keys[i] != 0) {
				for (j = 0; j < f_values[i].htab->h_size; j++) {
					if (f_values[i].htab->h_keys[j] != 0) {
						features = (struct prof_info *) f_values[i].htab->h_values;
						
						
						fprintf(prof_output, "[%" EIF_NATURAL_64_DISPLAY "]\t%.6f\t%.6f\t%"
								EIF_NATURAL_64_DISPLAY "\t%.6f\t%s from %d\n",
							index,
	    					(double) features[j].all_total_time / (double) NB_NANO_IN_ONE_SECOND,
							(double) features[j].descendent_time / (double) NB_NANO_IN_ONE_SECOND,
	    					features[j].number_of_calls,
							100.0 * compute_percentage (features[j].all_total_time, execution_time), 
	    					features[j].featurename,
							f_values[i].dtype);
						index++;
					}
				}
				ht_free(f_values[i].htab);
			}
		}

		fclose(prof_output);		/* Close the file */
			/* No need to `eif_rt_xfree' the struct: is done by `ht_free()' */
		ht_free(class_table);		/* Free memory */
		prof_stack_free();			/* Deallocate stack */

#ifdef EIF_THREADS
		if (eif_thr_is_root())
#endif
		egc_prof_enabled = 0;		/* Disactive the profiler to avoid the use of it during */
								/* the `full_sweep' from `reclaim' which makes come calls */
								/* calls to the `dispose' routines and since there are */
								/* eiffel function, they can be recorded in the profiler */
								/* which is not what we want */
	}
}

rt_public void start_profile(char *name, EIF_TYPE_INDEX origin, EIF_TYPE_INDEX dtype)
            /* Feature name */
            /* Origin of `name' */
            /* Dynamic type of `name'*/
{
	/* Initialize timer and push `name' on `prof_stack'. */

	if(prof_recording) {
		struct prof_info *new_item;	/* New item for `name' */

			/* Allocate `new_item' */
		new_item = (struct prof_info *) cmalloc (sizeof(struct prof_info));
		if (!new_item) {
				/* Bad Luck! */
			enomem();
		} else {
				/* Basic initialization */
			new_item->number_of_calls = 1;
			new_item->featurename = name;
			new_item->dtype = dtype;
			new_item->origin = origin;
			CHECK("valid_length", strlen(name) <= 0x7FFFFFFF);
			new_item->feature_hcode = (rt_uint_ptr) hashcode(name, (EIF_INTEGER) strlen(name));
				/* Record time value */
			new_item->this_total_time = process_time(); 
				/* Zero values */
			new_item->all_total_time = RTU64C(0);
			new_item->descendent_time = RTU64C(0);
				/* Mark running */
			new_item->is_running = 1;

			prof_stack_push(new_item);
		}
	}
}

rt_public void stop_profile(void)
{
	/* Stop timer for feature on top of 'prof_stack' and store
	 * information in `class_table'.
	 */

	if(prof_recording) {
		struct prof_info *item;	/* The information to change */

		item = prof_stack_pop();
		if (item) {	/* Testing against NULL */
				/* `prof_stack' doesn't contain the finishing
				 * feature anymore. This makes live easier.
				 */
			struct prof_info *stk_item;

			item->all_total_time = process_time(); 
			item->all_total_time -= item->this_total_time;
			item->is_running = 0; /* Mark feature is not running */

			stk_item = prof_stack_top();
			if (stk_item) {
					/* There is still a callee, so update it. */
				stk_item->all_total_time -= item->all_total_time;
				stk_item->descendent_time += item->all_total_time;
			}

			update_class_table(item);		/* Record times */
		} else {
				/* Bad Luck! (Profile stack corrupted) */
			eif_panic(MTC "Profile stack corrupted");
		}
	}
}

#define Classname(x)	System(x).cn_generator

/*
doc:	<routine name="eif_is_tracing_enabled" return="EIF_BOOLEAN" export="public">
doc:		<summary>Enable tracing for current thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/
rt_public EIF_BOOLEAN eif_is_tracing_enabled (void) 
{
	RT_GET_CONTEXT
	return EIF_TEST(eif_trace_disabled = 0);
}

/*
doc:	<routine name="eif_enable_tracing" export="public">
doc:		<summary>Enable tracing for current thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/
rt_public void eif_enable_tracing (void) 
{
	RT_GET_CONTEXT
	eif_trace_disabled = 0;
}

/*
doc:	<routine name="eif_disable_tracing" export="public">
doc:		<summary>Disable tracing for current thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/
rt_public void eif_disable_tracing (void) 
{
	RT_GET_CONTEXT
	eif_trace_disabled = 1;
}

rt_public void start_trace(char *name, EIF_TYPE_INDEX origin, EIF_TYPE_INDEX dtype)
           				/* The routine name */
           				/* The origin of the routine */
          				/* The class in which the routine is defined */
{
	/* Prints, on stdout, the message that feature 'name' in class 'dtype' inherited from 'origin'
	 * is just entered.
	 * The user can redirect the output to a file, when he/she wants that.
	 */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	int i;				/* Counter needed for loops */

	if (!eif_trace_disabled) {
		if (trace_call_level != 0 && last_dtype != -1) {
			EIF_TRACE_LOCK
			print_err_msg(stderr, "\n");
#ifdef EIF_THREADS
			print_err_msg(stderr, "Thread ID 0x%016" EIF_POINTER_DISPLAY ":", (rt_uint_ptr) eif_thr_context->tid);
#endif
			for (i = 0; i < trace_call_level - 1; i++)
				print_err_msg (stderr, "|  ");		/* Print preceding spaces */

			print_err_msg(stderr, ">>> %s from %s", last_name, Classname(last_dtype));		/* Standard message for entering features */

			if (last_dtype != last_origin)	/* Check if it is inherited... */
				print_err_msg(stderr, " (%s)", Classname(last_origin));
			EIF_TRACE_UNLOCK
		}

		trace_call_level++;		/* Increase the call_level */

		last_dtype = dtype;
		last_origin = origin;
		last_name = name;
	}
}

rt_public void stop_trace(char *name, EIF_TYPE_INDEX origin, EIF_TYPE_INDEX dtype)
           				/* The routine name */
           				/* The origin of the routine */
          				/* The class in which the routine is defined */
{
	/* Prints that feature 'name' in class 'dtype' inherited from 'origin' is about to leave. */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	int i;				/* Counter needed for loops */

	trace_call_level--;		/* Decrease the call_level */

	EIF_TRACE_LOCK
	print_err_msg(stderr, "\n");
#ifdef EIF_THREADS
		print_err_msg(stderr, "Thread ID 0x%016" EIF_POINTER_DISPLAY ":", (rt_uint_ptr) eif_thr_context->tid);
#endif

	for (i = 0; i < trace_call_level; i++)
		print_err_msg(stderr, "|  ");		/* Print preceding spaces */

	if ((strcmp(last_name, name) == 0) && (last_dtype == dtype) && (last_origin == origin)) {
		print_err_msg(stderr, "---");
		last_dtype = -1;
	} else {
		print_err_msg(stderr, "<<<");
	}

	print_err_msg(stderr, " %s from %s", name, Classname(dtype));		/* Standard message for leaving features */

	if (dtype != origin)	/* Check if it is inherited... */
		print_err_msg(stderr, " (%s)", Classname(origin));

	EIF_TRACE_UNLOCK
}

struct prof_info* prof_stack_pop(void)
{
	/* Pop the top off `prof_stack'.
	 * Return NULL if there is no top item to pop.
	 */

	if(prof_recording) {
		EIF_GET_CONTEXT
		struct prof_info *stk_item;	/* Top item of stack */

		stk_item = prof_stack_top();
		if (stk_item) {
				/* Okay, data structure still intact */
			prof_stack->st_top -= 1;	/* Reset top */
			if(prof_stack->st_top < prof_stack->st_cur->sk_arena) {
					/* Oops, current chunk is empty */
				prof_stack->st_cur = prof_stack->st_cur->sk_prev;
				prof_stack->st_end = prof_stack->st_cur->sk_end;
				prof_stack->st_top = prof_stack->st_end - 1;
			}
			return stk_item;
		} else {
				/* Bad Luck! */
			return NULL;
		}
	} else {
		return NULL;
	}
}

struct prof_info* prof_stack_top(void)
{
	/* Return top of `prof_stack'.
	 * NULL if no item is available on `prof_stack'
	 */

	if(prof_recording) {
		EIF_GET_CONTEXT
		char **top;

		top = prof_stack->st_top;	/* Next eif_free location */
		top -= 1;
		if(top < prof_stack->st_cur->sk_arena) {
				/* Oops, stack chunk ends here. Let's see if there is
				 * more in this stack or not...
				 */
			if(prof_stack->st_cur->sk_prev) {
					/* There seems to be more: We're Lucky (for now).
					 * Get the last valid value in previous chunk:
					 * stk->st_cur->st_prev->sk_end is a boundary, thus
					 * (pointer decrement) - 1 should yield valid pointer.
					 */
				top = prof_stack->st_cur->sk_prev->sk_end - 1;
			} else {
					/* Bad Luck! */
				return NULL;
			}
		}

		return (struct prof_info *) (*top);
	} else
		return NULL;
}

rt_public void prof_stack_init(void)
{
	/* Initialize `prof_stack' by allocating memory for the
	 * stack-structure and then calling st_alloc() in `garcol.c'.
	 *
	 * We use one stack for all profiled features. This is because of
	 * a few reasons:
	 * A) the previous version was bogus and needed to be optimized
	 * B) less memory is used.
	 * C) RAM implemented stack manipulation, so why bother and do it
	 *    again?
	 */

	if(egc_prof_enabled) {
		EIF_GET_CONTEXT
			/* Allocate profile stack */
		prof_stack = (struct stack *) cmalloc(sizeof(struct stack));
		if(!prof_stack)
			enomem(MTC_NOARG);	/* Bad Luck! */

			/* Allocate arena and chunk for memory problem */
		if(!st_alloc(prof_stack, eif_stack_chunk))
			enomem(MTC_NOARG);	/* Bad Luck! */
	}
}

rt_public void prof_stack_free(void)
{
	/* Free the memory allocated for `prof_stack'. */

	if(egc_prof_enabled) {
		EIF_GET_CONTEXT
		st_reset (prof_stack);						/* Free memory used by chunks */
		eif_rt_xfree((char *)prof_stack);			/* Free memory used by stack */
		prof_stack = NULL;							/* Mark `prof_stack' as clean. */
	}
}

rt_public void prof_stack_push(struct prof_info *new_item)
{
	/* Push `new_item' on `prof_stack'.
	 * Painc if not possible.
	 */

	if(prof_recording) {
		EIF_GET_CONTEXT
		if(epush(prof_stack, (char *) new_item) == -1) {
				/* Bad Luck! */
			eif_panic(MTC "Push profile info failed.");
		}
	}
}

rt_public void update_class_table(struct prof_info *item)
{
	/* The `class_table' is a H table containing H tables. This is
 	* because of the fact that the only precise identification of
 	* a feature is its class (whether origin or dtype) plus its name.
 	* It is possible to concatenate the class id and feature name to
 	* produce a unique hash key. However, we would have to deal with
 	* a humongous H table in the end. This means that it becomes
 	* obvious that insertion will have to do several searches empty
 	* slots. That would slow down the profiler...
 	*
 	* OK: The way it is done: first we check whether the class id has
 	* been inserted already, and hence we know if there is a H table
 	* for the features of that class.  If we cannot find an entry
 	* matching the class id, we create a new H table and insert it
 	* into the `class_table'. Second, we search the feature in the
 	* found H table and update the information (if it was known)
 	* or insert the in formation (if it was unknown).
 	*/

	if (prof_recording) {
		RT_GET_CONTEXT
		EIF_GET_CONTEXT
		struct feat_table *f_t;		/* Feature table */
		struct prof_info *p_i;		/* New item */
		rt_uint_ptr f_hcode;		/* Feature H code */

			/* Find the H table of features of class dtype */
		f_t = (struct feat_table *) ht_value(class_table, item->dtype);
		if(!f_t) {
		
				/* Create a new Hash table */
			f_t = (struct feat_table *) cmalloc(sizeof(struct feat_table));
			if(!f_t)
				enomem(MTC_NOARG);	/* Bad Luck */

				/* Initialize new feature table for dtype */
			f_t->dtype = item->dtype;
			f_t->htab = (struct htable *) cmalloc(sizeof(struct htable));
			if(!f_t->htab)
				enomem(MTC_NOARG);	/* Bad Luck */

				/* Create H table internal structures */
			if(ht_create(f_t->htab, 10, sizeof(struct prof_info))) {
					/* Something is wrotten */
				eraise("Hashtable creation failure", EN_FATAL);
			}

				/* Add feature table to `class_table'. */
			ht_force(class_table, f_t->dtype, (char *) f_t);
		}

			/* OK. Either the class was known and `f_t' is directly
			 * from `class_table', or we were able to create
			 * a new one.
			 */

		f_hcode = item->feature_hcode;
		p_i = (struct prof_info *) ht_value(f_t->htab, f_hcode);
		if(!p_i) {
			ht_force(f_t->htab, f_hcode, (char *) item);
		} else {
			register struct stchunk *current_chunk;
			char **address = NULL;
			int found = 0;

			p_i->number_of_calls += item->number_of_calls;
			p_i->all_total_time += item->all_total_time;
			p_i->descendent_time += item->descendent_time;

				/* Traversal in search of recursive `item' */
			for(current_chunk = prof_stack->st_cur;
					current_chunk != (struct stchunk *) 0 && !found;
					current_chunk = current_chunk->sk_prev) {
				/* Inspect each chunk */

				/* Starting address is end of chunk for
				 * full chunks and current insertion position
				 * for the last one
				 */
				if(current_chunk == prof_stack->st_cur) {
					address = prof_stack->st_top - 1;
				} else {
					address = current_chunk->sk_end - 1;
				}
				for( ; address >= current_chunk->sk_arena; address--) {
					if(((struct prof_info *)*address)->dtype == p_i->dtype &&
						((struct prof_info *)*address)->origin == p_i->origin &&
						((struct prof_info *)*address)->feature_hcode == p_i->feature_hcode){
								/* Found item looking for */
						found = 1;
						break;
					}
				}
			}

				/* Did we find one? */
			if(found) {
					/* Update it */
				((struct prof_info *)*address)->all_total_time += p_i->all_total_time;
			}

			eif_rt_xfree(item);
		}
	}
}

rt_public void prof_stack_rewind(char **old_top)
               		/* Old top. Just to know where to stop rewinding. */
{
	/* Rewinds part of 'prof_stack' and thus updates all features in
 	* that part and puts data in the profile table. This function
 	* is useful when the system is interrupted by an exception which
 	* is "rescued" and then the feature is "retried". We can simple
 	* rewind `prof_stack' until we hit `old_top'.
 	*
 	* Thus we must declare char**, and store 'prof_stack->st_top'
 	* in it, every time a feature has a rescue-clause. Then we must
 	* rewind the new part of `prof_stack' with this function while
 	* passing down the stored top.
 	*
 	* This guarantees that all information, so far, will be kept even
 	* if the system has caught an exception. For exceptions which
 	* cause the system to stop (i.e. nowhere was a rescue-clause),
 	* we guarantee very much useless information, because we always
 	* do a 'exitprf' in 'reclaim'. -- GLJ
 	*/

	if(prof_recording) {
		EIF_GET_CONTEXT
			/* Traverse the stack to a certain point */
		while(prof_stack->st_top > old_top) {
				/* Stop profiling top item */
			stop_profile();

				/* Check where we are right now in the stack. If st_top is
				 * bottom line of the current chunk right here, reset it
				 * to the end of the previous chunk.
				 * Will there always be a previous chunk here? In other
				 * words: Can we rewind up to the point where we just
				 * stopped profiling the creation routine of the system?
				 * Well, no... (hopefully). If it is possible OTOH, please
				 * update the next code block to have a guard for a
				 * prof_stack->st_cur->sk_prev != NULL.
				 */

			if(prof_stack->st_top <= prof_stack->st_cur->sk_arena) {
					/* Oops, current chunk is empty */
				prof_stack->st_cur = prof_stack->st_cur->sk_prev;
				prof_stack->st_end = prof_stack->st_cur->sk_end;
				prof_stack->st_top = prof_stack->st_end;
			}
		}
	}
}
/* Computation of the percentage, it returns a number between 0 and 1 */
rt_private double compute_percentage (rt_uint64 feature_time, rt_uint64 total_time)
{
	if (total_time == 0.0)
		return 1.0;
	else
		return (double) feature_time / (double) total_time;
}
/*
doc:</file>
*/
