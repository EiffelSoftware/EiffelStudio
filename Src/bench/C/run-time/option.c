/*

  ####   #####    #####     #     ####   #    #           ####
 #    #  #    #     #       #    #    #  ##   #          #    #
 #    #  #    #     #       #    #    #  # #  #          #
 #    #  #####      #       #    #    #  #  # #   ###    #
 #    #  #          #       #    #    #  #   ##   ###    #    #
  ####   #          #       #     ####   #    #   ###     ####

		Option queries, profiler core, tracer core
*/

#include "eif_portable.h"
#include "eif_project.h"
#ifndef HAS_GETRUSAGE
#if defined HAS_TIMES && !defined EIF_VMS
#include <sys/param.h>      /* For value of HZ */
#endif
#endif
#ifdef _CRAY
#include <sys/machd.h>
#endif
#include "eif_struct.h"
#include "eif_option.h"
#include "eif_hashin.h"
#include "eif_lmalloc.h"
#include "rt_garcol.h"
#include "eif_malloc.h"
#include "eif_macros.h"
#include "eif_err_msg.h"
#include "eif_except.h"
#include "eif_timer.h"
#include "eif_misc.h"
#include "eif_tools.h"		/* For hashcode() */
#include "rt_main.h"
#include <stdio.h>
#include <string.h>

rt_public int trace_call_level = 0;	/* call level for E-TRACE
					 * recursive calls (whether direct or indirect).
					 */

rt_public struct stack *prof_stack;

/* Total execution time */

#ifdef HAS_GETRUSAGE
struct 	prof_rusage	*init_date;
#elif defined(HAS_TIMES)
double 	       init_date;
#elif defined(EIF_WIN32)
SYSTEMTIME 	*init_date;
#endif  /* HAS_GERUSAGE */

/* INTERNAL TRACE VARIABLES */

int last_dtype;			/* These three variables are needed because we */
int last_origin;		/* want to print "...---..." instead of "...>>>... _nextline_ ...<<<..." */
char *last_name;		/* when we deal with a so called terminal feature (a feature without calls to other features) */

/* INTERNAL PROFILE STRUCTURES */

/* Struct to keep the information gathered */
#ifdef HAS_GETRUSAGE

typedef struct
{
	long	seconds;
	long	micro_seconds;
} time_struct;

struct prof_rusage
{
	time_struct user_time;
	time_struct system_time;
};

#elif defined (EIF_WIN32)

#include <windows.h>

#endif /* HAS_GETRUSAGE */

struct prof_info {
				char	*featurename;		/* Name of feature */
				int		dtype;				/* DTYPE of feature */
				int		origin;				/* ORIGIN of feature */
	unsigned	long	feature_hcode;		/* Hash code */
				long	number_of_calls;	/* # calls to feature */
#ifdef HAS_GETRUSAGE
	struct	prof_rusage	*this_total_time;
	struct	prof_rusage	*all_total_time;
	struct	prof_rusage	*descendent_time;

#elif defined(HAS_TIMES)
				double	this_total_time;	/* Time spent in the feature */
											/* (during this execution) */
				double	all_total_time;		/* Time spent in the feature */
											/* (summarized) */
				double	descendent_time;	/* Time spent in the */
											/* descendents */
#elif defined(EIF_WIN32)
	SYSTEMTIME	*this_total_time;
	SYSTEMTIME	*all_total_time;
	SYSTEMTIME	*descendent_time;

#endif /* HAS_GERUSAGE */
				int		is_running;			/* Is the feature running? */
											/* Needed for recursives */
};

/* Internal Macros */
#ifdef HAS_GETRUSAGE

#define u_seconds	user_time.seconds
#define u_micro		user_time.micro_seconds
#define s_seconds	system_time.seconds
#define s_micro		system_time.micro_seconds

#define real_time(x)	((x)->u_seconds*1000000) + (x)->u_micro + \
					 	((x)->s_seconds*1000000) + (x)->s_micro
#define new_prof_info(x)	{\
								x = (struct prof_info *) cmalloc(sizeof(struct prof_info));\
								x->this_total_time =\
				(struct prof_rusage *) cmalloc(sizeof(struct prof_rusage));\
								x->all_total_time =\
				(struct prof_rusage *) cmalloc(sizeof(struct prof_rusage));\
								x->descendent_time =\
				(struct prof_rusage *) cmalloc(sizeof(struct prof_rusage));\
							}
#define free_prof_info(x)	{\
								xfree(x->this_total_time);\
								xfree(x->all_total_time);\
								xfree(x->descendent_time);\
								xfree(x);\
							}
#define check_existance(x)	{\
								if(!x || !(x->all_total_time) || !(x->this_total_time) || !(x->descendent_time)) {\
										/* Bad Luck ! */\
									enomem();\
								}\
							}
#define record_time(x)	prof_time(x)
#define zero_time(x)	{\
							x->u_seconds = 0;\
							x->u_micro = 0.;\
							x->s_seconds = 0;\
							x->s_micro = 0.;\
						}
#define subtract_gc_time(x,y)	{\
									(x)->u_micro -= y;\
								}
#define subtract_time(x,y,z)	{\
									(x)->u_seconds = (y)->u_seconds - (z)->u_seconds;\
									(x)->u_micro = (y)->u_micro - (z)->u_micro;\
									(x)->s_seconds = (y)->s_seconds - (z)->s_seconds;\
									(x)->s_micro = (y)->s_micro - (z)->s_micro;\
								}
#define add_time(x,y,z)	{\
							x->u_seconds = y->u_seconds + z->u_seconds;\
							x->u_micro = y->u_micro + z->u_micro;\
							x->s_seconds = y->s_seconds + z->s_seconds;\
							x->s_micro = y->s_micro + z->s_micro;\
						}

#elif defined(HAS_TIMES)
#define record_time(x)	{\
							double utime, stime;\
							prof_time(&utime, &stime);\
							x = utime + stime;\
						}
#define zero_time(x)	x = 0.
#define subtract_gc_time(x,y)	{\
									x -= y;\
								}
#define subtract_time(x,y,z)	{\
									x = y - z;\
								}
#define add_time(x,y,z)	{\
							x = y + z;\
						}
#define new_prof_info(x)	{\
								x = (struct prof_info *) cmalloc(sizeof(struct prof_info));\
							}
#define free_prof_info(x)	{\
								xfree(x);\
							}
#define check_existance(x)	{\
								if(!x) {\
										/* Bad Luck! */\
									enomem();\
								}\
							}

#elif defined(EIF_WIN32)
#define real_time(x)		((x)->wHour*3600 + (x)->wMinute*60 + (x)->wSecond + (x)->wMilliseconds / 1000.)
#define record_time(x)	{\
							prof_time(x);\
						}
#define zero_time(x)	{\
							x->wMilliseconds = 0;\
							x->wSecond = 0;\
							x->wMinute = 0;\
							x->wHour = 0;\
							x->wDay = 0;\
							x->wDayOfWeek = 0;\
							x->wMonth = 0;\
							x->wYear = 0;\
						}
#define subtract_gc_time(x,y)	{\
									if((x)->wMilliseconds >= y)\
										(x)->wMilliseconds -= (unsigned short) y;\
									else\
									{\
										(x)->wMilliseconds = 1000 - ((unsigned short) y - (x)->wMilliseconds);\
										(x)->wSecond -= 1;\
									}\
								}
#define subtract_time(x,y,z)	{\
	int ExtraSecond = 0;\
	int ExtraMinute = 0;\
	int ExtraHour = 0;\
	if(real_time((y)) == 0)\
	{\
		(x)->wMilliseconds = -((z)->wMilliseconds);\
		(x)->wSecond = -((z)->wSecond);\
		(x)->wMinute = -((z)->wMinute);\
		(x)->wHour = -((z)->wHour);\
	}\
	else\
	{\
		if((y)->wMilliseconds >= (z)->wMilliseconds)\
		{\
			(x)->wMilliseconds = (y)->wMilliseconds - (z)->wMilliseconds;\
		}\
		else\
		{\
			(x)->wMilliseconds = 1000 - ((z)->wMilliseconds - (y)->wMilliseconds);\
			ExtraSecond = -1;\
		}\
		if((y)->wSecond >= (z)->wSecond)\
		{\
			(x)->wSecond = (y)->wSecond - (z)->wSecond;\
		}\
		else\
		{\
			(x)->wSecond = 60 - ((z)->wSecond - (y)->wSecond);\
			ExtraMinute = -1;\
		}\
		(x)->wSecond += ExtraSecond;\
		if((y)->wMinute >= (z)->wMinute)\
		{\
			(x)->wMinute = (y)->wMinute - (z)->wMinute;\
		}\
		else\
		{\
			(x)->wMinute = 60 - ((z)->wMinute - (y)->wMinute);\
			ExtraHour = -1;\
		}\
		(x)->wMinute += ExtraMinute;\
		if((y)->wHour >= (z)->wHour)\
		{\
			(x)->wHour = (y)->wHour - (z)->wHour;\
		}\
		else\
		{\
			(x)->wHour = 24 - ((z)->wHour - (y)->wHour);\
		}\
		(x)->wHour += ExtraHour;\
	}\
								}
#define add_time(x,y,z)	{\
	x->wMilliseconds = y->wMilliseconds + z->wMilliseconds;\
	x->wSecond = y->wSecond + z->wSecond;\
	x->wMinute = y->wMinute + z->wMinute;\
	x->wHour = y->wHour + z->wHour;\
	if((signed) x->wMilliseconds > 1000)\
	{\
		x->wMilliseconds -= 1000;\
		x->wSecond += 1;\
	}\
	if((signed) x->wSecond > 60)\
	{\
		x->wSecond -= 60;\
		x->wMinute += 1;\
	}\
	if((signed) x->wMinute > 60)\
	{\
		x->wMinute -= 60;\
		x->wHour += 1;\
	}\
						}
#define new_prof_info(x)	{\
								x = (struct prof_info *) cmalloc(sizeof(struct prof_info));\
								x->this_total_time =\
				(SYSTEMTIME *) cmalloc(sizeof(SYSTEMTIME));\
								x->all_total_time =\
				(SYSTEMTIME *) cmalloc(sizeof(SYSTEMTIME));\
								x->descendent_time =\
				(SYSTEMTIME *) cmalloc(sizeof(SYSTEMTIME));\
							}
#define free_prof_info(x)	{\
								xfree(x->this_total_time);\
								xfree(x->all_total_time);\
								xfree(x->descendent_time);\
								xfree(x);\
							}
#define check_existance(x)	{\
								if(!x || !(x->all_total_time) || !(x->this_total_time) || !(x->descendent_time)) {\
										/* Bad Luck! */\
									enomem();\
								}\
							}

#endif /* HAS_GETRUSAGE */

rt_public struct stack *profile_stack;

/* Structure for H table of features.
 * 'hcode' is meant to be the H key of the class
 */
struct feat_table {
	int dtype;					/* The dynamic type of the features */
	struct htable *htab;		/* Features of class corresponding to 'dtype' */
};

struct htable *class_table;		/* The H table that contains all info */

/* INTERNAL PROFILE DEFINITIONS */

#define profile_output_file	"profinfo"

/* INTERNAL PROFILE FUNCTIONS */

void update_class_table(struct prof_info *item);				/* Update H table */
void prof_stack_push(struct prof_info *new_item);					/* Push item on staack */
void prof_stack_free(void);					/* Free profile stack memory */
void prof_stack_init(void);					/* Initialize stack */
#ifdef HAS_GETRUSAGE						/* %%zs added */
void prof_time(struct prof_rusage *a_time);						/* Get time */
#elif defined(HAS_TIMES)
void prof_time(double *usertime, double *systime);
#elif defined(EIF_WIN32)
void prof_time(SYSTEMTIME *a_time);
#endif
struct prof_info* prof_stack_top(void);		/* Top the stack */
struct prof_info* prof_stack_pop(void);		/* Pop top off stack */


/* Computation of the percentage, it returns a number between 0 and 1 */
rt_private double compute_percentage (double, double);

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
	int16 nb_keys;
	char **keys;

	if (debug_opt->debug_level == OPT_NO)
		return 0;

	if (debug_opt->nb_keys == 0)
		return 1;

	if ((char *) 0 == key)
		return 0;
	else {
		nb_keys = debug_opt->nb_keys;
		keys = debug_opt->keys;
		for (i=0; i<nb_keys; i++)
			if (strcmp(key,keys[i]) == 0)
				return 1;
		return 0;
	}
}

void check_options(EIF_CONTEXT struct eif_opt *opt, int dtype)
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

void check_options_stop(EIF_CONTEXT_NOARG)
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
	int dtype;

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

void initprf(void)
{
	/* Creates the table needed for E-PROFILE. This function only
	 * allocates that table if `egc_prof_enabled'. Record the time
	 * to be able to compute the total execution time.
	 */

	if(egc_prof_enabled) {
			/* Allocate table */
		class_table = (struct htable *) cmalloc(sizeof(struct htable));
		if (class_table == (struct htable *) 0)
			enomem();

			/* Create H table */
		if (!ht_create(class_table, 10, sizeof(struct feat_table)))
			ht_zero(class_table);		/* Lucky! */
		else
			eraise("Hashtable creation failure", EN_FATAL);

		prof_stack_init();		/* Initialize stack */

#ifdef HAS_GETRUSAGE
		init_date = (struct prof_rusage *) eif_malloc (sizeof (struct prof_rusage));
#elif defined(HAS_TIMES)
		
#elif defined(EIF_WIN32)
		init_date = (SYSTEMTIME *) eif_malloc (sizeof (SYSTEMTIME));
#endif  /* HAS_GERUSAGE */

		record_time (init_date); 
	}
}

void exitprf(void)
{
	/* Exit profiling. Call this function only at exit of Eiffel system.
	 * Compute the total execution time and the percentage of each feature.
	 * Store information to disk and deallocate structures.
	 */

	/* Check against `init_date' as `initprf' (which initializes `init_date')
	 * might not be called if user disabled profiling in the Ace file and 
	 * enabled it through the PROFILING_SETTING class. */

	if (egc_prof_enabled && init_date) {

#ifdef HAS_GETRUSAGE
		struct prof_rusage *execution_time;
#elif defined(HAS_TIMES)
		double execution_time;
#elif defined(EIF_WIN32)
		SYSTEMTIME *execution_time;
#endif  /* HAS_GERUSAGE */

		unsigned long *keys;		/* Keys from H table */
		struct feat_table *f_values;	/* Values from class H table */
		struct prof_info *features;	/* Features from H tables */
		int i,					/* Outer-loop-counter */
	    	j,					/* Inner-loop-counter */
	    	index;				/* Index counter for output */
		FILE *prof_output;		/* Storage file */
			
		double percentage; /* the computed percentage of each routine */

#ifdef WORKBENCH
		char *meltpath = (char *) 0;			/* directory of .UPDT */

		meltpath = (char*) eif_getenv ("MELT_PATH");
		
		if (meltpath != NULL)
		{
			chdir (meltpath);
		}
		else
#endif
		{
				/* change the current directory to EIFGEN/F_code
				 * before creating the profile_output_file */
			int error = chdir (egc_system_location);
			if (error == -1) {
					/* If we could not change to EIFGEN/F_code, we
					 * set it to the starting working directory */
				chdir (starting_working_directory);	
			}
		}

#ifdef HAS_GETRUSAGE
		execution_time = (struct prof_rusage *) eif_malloc (sizeof (struct prof_rusage));
#elif defined(HAS_TIMES)
		
#elif defined(EIF_WIN32)
		execution_time = (SYSTEMTIME *) eif_malloc (sizeof (SYSTEMTIME));
#endif  /* HAS_GERUSAGE */

		record_time (execution_time); 
		
		prof_output = fopen(profile_output_file, "w");
		if (!prof_output) {
				/* Too bad: no file */
			eraise("Unable to open to output file for profile", EN_FATAL);
		}

#ifdef HAS_GETRUSAGE
		subtract_time (execution_time, execution_time, init_date);
#elif defined(HAS_TIMES)
		execution_time = execution_time - init_date;
#elif defined(EIF_WIN32)
		subtract_time (execution_time, execution_time, init_date);
#endif 

/* NEED TO BE CHECKED BY GUILLAUME */
		/*if (gc_ran && !gc_running) {*/
/*				 Get time wasted by GC */
/*			subtract_gc_time(&execution_time, last_gc_time); */
/*			gc_ran = 0;*/
/*		}		*/

		keys = class_table->h_keys;
		f_values = (struct feat_table *) class_table->h_values;
		index = 1;

		for (i = 0; i < class_table->h_size; i++) {
			if (keys[i] != 0) {
				for (j = 0; j < f_values[i].htab->h_size; j++) {
					if (f_values[i].htab->h_keys[j] != 0) {
						features = (struct prof_info *) f_values[i].htab->h_values;
						
#ifdef HAS_GETRUSAGE
						percentage = 100.0 * compute_percentage (real_time(features[j].all_total_time), real_time(execution_time)); 
#elif defined(HAS_TIMES)
						percentage = 100.0 * compute_percentage (features[j].all_total_time, execution_time);
#elif defined(EIF_WIN32)
						percentage = 100.0 * compute_percentage (real_time(features[j].all_total_time), real_time(execution_time)); 
#endif
						
						fprintf(prof_output, "[%d]\t%.2f\t%.2f\t%ld\t%.2f\t%s from %d\n", index,
#ifdef HAS_GETRUSAGE
		    					(real_time(features[j].all_total_time)) / 1000000.,
								(real_time(features[j].descendent_time)) / 1000000.,
#elif defined(HAS_TIMES)
								features[j].all_total_time / (double)HZ,
								features[j].descendent_time / (double)HZ,
#elif defined(EIF_WIN32)
								real_time(features[j].all_total_time),
								real_time(features[j].descendent_time),
#endif /* HAS_GETRUSAGE */
		    					features[j].number_of_calls,
								percentage,
		    					features[j].featurename,
								f_values[i].dtype);
						index++;
					}
				}
				ht_free(f_values[i].htab);
			}
		}
#ifdef HAS_GETRUSAGE
		eif_free (init_date);
		eif_free (execution_time);
#elif defined(HAS_TIMES)

#elif defined(EIF_WIN32)
		eif_free (init_date);
		eif_free (execution_time);
#endif

		fclose(prof_output);		/* Close the file */
			/* No need to `xfree' the struct: is done by `ht_free()' */
		ht_free(class_table);		/* Free memory */
		prof_stack_free();			/* Deallocate stack */

		egc_prof_enabled = 0;		/* Disactive the profiler to avoid the use of it during */
								/* the `full_sweep' from `reclaim' which makes come calls */
								/* calls to the `dispose' routines and since there are */
								/* eiffel function, they can be recorded in the profiler */
								/* which is not what we want */
	}
}

void start_profile(char *name, int origin, int dtype)
            /* Feature name */
            /* Origin of `name' */
            /* Dynamic type of `name'*/
{
	/* Initialize timer and push `name' on `prof_stack'. */

	if(prof_recording) {
		struct prof_info *new_item;	/* New item for `name' */

			/* Allocate `new_item' */
		new_prof_info(new_item);
		check_existance(new_item);

			/* Basic initialization */
		new_item->number_of_calls = 1;
		new_item->featurename = name;
		new_item->dtype = dtype;
		new_item->origin = origin;
		new_item->feature_hcode = hashcode(name, strlen(name));
			/* Record time value */
		record_time(new_item->this_total_time);
			/* Zero values */
		zero_time(new_item->all_total_time);
		zero_time(new_item->descendent_time);
			/* Mark running */
		new_item->is_running = 1;

		prof_stack_push(new_item);
	}
}

void stop_profile(void)
{
	/* Stop timer for feature on top of 'prof_stack' and store
	 * information in `class_table'.
	 */

	if(prof_recording) {
		struct prof_info *item;	/* The information to change */

		if((item = prof_stack_pop())) {	/* Testing against NULL */
				/* `prof_stack' doesn't contain the finishing
				 * feature anymore. This makes live easier.
				 */
			struct prof_info *stk_item;

			record_time(item->all_total_time);
			subtract_time(item->all_total_time, item->all_total_time, item->this_total_time);
			item->is_running = 0; /* Mark feature is not running */

			if (gc_ran && !gc_running) {
					/* Get time wasted by GC */
				subtract_gc_time(item->all_total_time, last_gc_time);
				gc_ran = 0;
			}

			if ((stk_item = prof_stack_top())) {
					/* There is still a callee, so
					 * update it.
					 */

				subtract_time(stk_item->all_total_time, stk_item->all_total_time, item->all_total_time);
				add_time(stk_item->descendent_time, stk_item->descendent_time, item->all_total_time);
			}

			update_class_table(item);		/* Record times */
		} else {
				/* Bad Luck! (Profile stack corrupted) */
			eif_panic(MTC "Profile stack corrupted");
		}
	}
}

#define Classname(x)	System(x).cn_generator

void start_trace(char *name, int origin, int dtype)
           				/* The routine name */
           				/* The origin of the routine */
          				/* The class in which the routine is defined */
{
	/* Prints, on stdout, the message that feature 'name' in class 'dtype' inherited from 'origin' is just entered.
	 * The user can redirect the output to a file, when he/she wants that.
	 */

	int i;				/* Counter needed for loops */

	if (trace_call_level != 0 && last_dtype != -1) {
		print_err_msg(stderr, "\n");
		for (i = 0; i < trace_call_level - 1; i++)
			print_err_msg (stderr, "|  ");		/* Print preceding spaces */

		print_err_msg(stderr, ">>> %s from %s", last_name, Classname(last_dtype));		/* Standard message for entering features */

		if (last_dtype != last_origin)	/* Check if it is inherited... */
			print_err_msg(stderr, " (%s)", Classname(last_origin));
	}

	trace_call_level++;		/* Increase the call_level */

	last_dtype = dtype;
	last_origin = origin;
	last_name = name;
}

void stop_trace(char *name, int origin, int dtype)
           				/* The routine name */
           				/* The origin of the routine */
          				/* The class in which the routine is defined */
{
	/* Prints that feature 'name' in class 'dtype' inherited from 'origin' is about to leave. */

	int i;				/* Counter needed for loops */

	trace_call_level--;		/* Decrease the call_level */

	print_err_msg(stderr, "\n");

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
}

struct prof_info* prof_stack_pop(void)
{
	/* Pop the top off `prof_stack'.
	 * Return NULL if there is no top item to pop.
	 */

	if(prof_recording) {
		register1 struct prof_info *stk_item;	/* Top item of stack */

		if((stk_item = prof_stack_top())) {
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
			return 0;
		}
	} else {
		return 0;
	}
}

struct prof_info* prof_stack_top(void)
{
	/* Return top of `prof_stack'.
	 * NULL if no item is available on `prof_stack'
	 */

	if(prof_recording) {
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
				return 0;
			}
		}

		return (struct prof_info *) (*top);
	} else
		return 0;
}

void prof_stack_init(void)
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
			/* Allocate profile stack */
		prof_stack = (struct stack *) cmalloc(sizeof(struct stack));
		if(!prof_stack)
			enomem(MTC_NOARG);	/* Bad Luck! */

			/* Allocate arena and chunk for memory problem */
		if(!st_alloc(prof_stack, STACK_CHUNK))
			enomem(MTC_NOARG);	/* Bad Luck! */
	}
}

void prof_stack_free(void)
{
	/* Free the memory allocated for `prof_stack'. */

	if(egc_prof_enabled) {
		xfree((char *)(prof_stack->st_cur));	/* Free memory used by chunk */
		xfree((char *)prof_stack);			/* Free memory used by stack */
	}
}

void prof_stack_push(struct prof_info *new_item)
{
	/* Push `new_item' on `prof_stack'.
	 * Painc if not possible.
	 */

	if(prof_recording) {
		if(epush(prof_stack, (char *) new_item) == -1) {
				/* Bad Luck! */
			eif_panic(MTC "Push profile info failed.");
		}
	}
}

void update_class_table(struct prof_info *item)
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

	if(prof_recording) {
		struct feat_table *f_t;		/* Feature table */
		struct prof_info *p_i;		/* New item */
		unsigned long f_hcode;		/* Feature H code */

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
			if(!ht_create(f_t->htab, 10, sizeof(struct prof_info)))
				ht_zero(f_t->htab);	/* Zero it out */
			else {
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
			add_time(p_i->all_total_time, p_i->all_total_time, item->all_total_time);
			add_time(p_i->descendent_time, p_i->descendent_time,
item->descendent_time);

				/* Traversal in search of recursive `item' */
			for(current_chunk = prof_stack->st_cur;
					current_chunk != (struct stchunk *) 0 && !found;
					current_chunk = current_chunk->sk_prev) {
				/* Inspect each chunk */

				/* Starting address is end of chunk for
				 * full chunks and current insertion position
				 * for the last one
				 */
				if(current_chunk == prof_stack->st_cur)
					address = prof_stack->st_top - 1;
				else
					address = current_chunk->sk_end - 1;
				for( /* EMPTY */ ;
						address >= current_chunk->sk_arena;
						address--) {
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
				add_time(((struct prof_info *)*address)->all_total_time, ((struct prof_info *)*address)->all_total_time, p_i->all_total_time);
			}

			free_prof_info((char *) item);
		}
	}
}

void prof_stack_rewind(char **old_top)
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
rt_private double compute_percentage (double feature_time, double total_time)
{
	if (total_time == 0.0)
		return 1.0;
	else
		return feature_time / total_time;
}

/* Get the user and system time.
 * This function is optimized for the profiler. `getcputime()' in `timer.c'
 * always divides the result.
 * Quantify told us that that is a bad idea.
 */

#ifdef HAS_GETRUSAGE

void prof_time(struct prof_rusage *a_time)
                           	/* Time structure */
{
	struct rusage usage;

	getrusage(RUSAGE_SELF, &usage);

	a_time->u_seconds = usage.ru_utime.tv_sec;
	a_time->u_micro = usage.ru_utime.tv_usec;
	a_time->s_seconds = usage.ru_stime.tv_sec;
	a_time->s_micro = usage.ru_stime.tv_usec;
}

#elif defined(HAS_TIMES)

void prof_time(double *usertime, double *systime)
		/* Time in user mode */
		/* Time in kernel mode */

{
	struct tms time;

	(void) times(&time);
	*usertime = (double)time.tms_utime;
	*systime = (double)time.tms_stime;
}

#elif defined(EIF_WIN32)

void prof_time(SYSTEMTIME *a_time)

{
	GetSystemTime(a_time);
}

#endif /* HAS_GETRUSAGE */
