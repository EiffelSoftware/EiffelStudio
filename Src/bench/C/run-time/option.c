/*

  ####   #####    #####     #     ####   #    #           ####
 #    #  #    #     #       #    #    #  ##   #          #    #
 #    #  #    #     #       #    #    #  # #  #          #
 #    #  #####      #       #    #    #  #  # #   ###    #
 #    #  #          #       #    #    #  #   ##   ###    #    #
  ####   #          #       #     ####   #    #   ###     ####

		Option queries in workbench mode
*/

#include "config.h"
#include "struct.h"
#include "option.h"
#include "hashin.h"
#include "malloc.h"
#include "macros.h"
#include "except.h"
#include "timer.h"
#include "tools.h"		/* For hashcode() */
#include <stdio.h>
#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

public int trace_call_level = 0;	/* call level for E-TRACE
					 * recursive calls (whether direct or indirect).
					 */

public struct stack *prof_stack;

/* INTERNAL TRACE VARIABLES */

int last_dtype;			/* These three variables are needed because we */
int last_origin;		/* want to print "...---..." instead of "...>>>... _nextline_ ...<<<..." */
char *last_name;		/* when we deal with a so called terminal feature (a feature without calls to other features) */

/* INTERNAL PROFILE STRUCTURES */

/* Struct to keep the information gathered */
struct prof_info {
				char	*featurename;		/* Name of feature */
				int		dtype;				/* DTYPE of feature */
				int		origin;				/* ORIGIN of feature */
	unsigned	long	feature_hcode;		/* Hash code */
				long	number_of_calls;	/* # calls to feature */
				double	this_total_time;	/* Time spent in the feature */
											/* (during this execution) */
				double	all_total_time;		/* Time spent in the feature */
											/* (summarized) */
				double	descendent_time;	/* Time spent in the */
											/* descendents */
				int		is_running;			/* Is the feature running? */
											/* Needed for recursives */
};

public struct stack *profile_stack;

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

void update_class_table();				/* Update H table */
void prof_stack_push();					/* Push item on staack */
void prof_stack_free();					/* Free profile stack memory */
void prof_stack_init();					/* Initialize stack */
void prof_time();						/* Get time */
struct prof_info* prof_stack_top();		/* Top the stack */
struct prof_info* prof_stack_pop();		/* Pop top off stack */

/* We do debug only in WORKBENCH mode
 * We also need check_options and check_options_stop in WORKBENCH mode
 */

#ifdef WORKBENCH

public int is_debug(st_type, key)
int st_type;
char *key;
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

void check_options(opt, dtype)
struct eif_opt *opt;	/* Options for the Eiffel feature*/
int dtype;				/* Dtype of the Eiffel class */
{
	/* Check whether the class `dty[e' has E-TRACE or E-PROFILE
	 * options in `opt' and dispatch to the finctions `start_trace()'
	 * and `start_profile()' if necessary.
	 * This function is directly called by RTSA in WORKBENCH mode; it is
	 * called explicitly from the interpreter as soon as it determines that
	 * a feature is to be executed.
	 */

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

void check_options_stop()
{
	/* Checks whether the feature on top of the 'eif_stack' is E-TRACEd
	 * and E-PROFILEd and dispatches to the functions `stop_trace()' and
	 * `stop_profile()' if necessary.
	 * This function is called by RTSO, which is called by RTEE. Thus we
	 * guarantee that at least this part of E-TRACE and E-PROFILE will
	 * work for both frozen and melted code.
	 */

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

void initprf()
{
	/* Creates the table needed for E-PROFILE. This function only
	 * allocates that table if `eif_profiler_on'.
	 */

	if(eif_profiler_on) {
			/* Allocate table */
		class_table = (struct htable *) xcalloc(1, sizeof(struct htable));
		if (class_table == (struct htable *) 0)
			enomem();

			/* Create H table */
		if (!ht_create(class_table, 10, sizeof(struct feat_table)))
			ht_zero(class_table);		/* Lucky! */
		else
			eraise("Hashtable creation failure", EN_FATAL);

		prof_stack_init();		/* Initialize stack */
	}
}

void exitprf()
{
	/* Exit profiling. Call this function only at exit of Eiffel system.
	 * Store information to disk and deallocate structures.
	 */

	if(eif_profiler_on) {
		unsigned long *keys;		/* Keys from H table */
		struct feat_table *f_values;	/* Values from class H table */
		struct prof_info *features;	/* Features from H tables */
		int i,					/* Outer-loop-counter */
	    	j,					/* Inner-loop-counter */
	    	index;				/* Index counter for output */
		FILE *prof_output;		/* Storage file */

		prof_output = fopen(profile_output_file, "w");
		if (!prof_output) {
				/* Too bad: no file */
			eraise("Unable to open to output file for profile", EN_FATAL);
		}

		keys = class_table->h_keys;
		f_values = (struct feat_table *) class_table->h_values;
		index = 1;

		for (i = 0; i < class_table->h_size; i++) {
			if (keys[i] != 0) {
				for (j = 0; j < f_values[i].htab->h_size; j++) {
					if (f_values[i].htab->h_keys[j] != 0) {
						features = (struct prof_info *) f_values[i].htab->h_values;
						fprintf(prof_output, "[%d]\t%.2f\t%.2f\t%ld\t%s from %d\t[%d]\n", index,
#ifdef HAS_GETRUSAGE
		    					features[j].all_total_time / 1000000.,
								features[j].descendent_time / 1000000.,
#else
#ifdef HAS_TIMES
								features[j].all_total_time / (double)HZ,
								features[j].descendent_time / (double)HZ,
#else
								features[j].all_total_time.
								features[j].descendent_time,
#endif /* HAS_TIMES */
#endif /* HAS_GETRUSAGE */
		    					features[j].number_of_calls,
		    					features[j].featurename,
								f_values[i].dtype,
								index);
						index++;
					}
				}
				ht_free(f_values[i].htab);
			}
		}

		fclose(prof_output);		/* Close the file */
			/* No need to `xfree' the struct: is done by `ht_free()' */
		ht_free(class_table);		/* Free memory */
		prof_stack_free();			/* Deallocate stack */
	}
}

void start_profile(name, origin, dtype)
char *name; /* Feature name */
int origin; /* Origin of `name' */
int dtype;  /* Dynamic type of `name'*/
{
	/* Initialize timer and push `name' on `prof_stack'. */

	if(eif_profiler_on) {
		struct prof_info *new_item;	/* New item for `name' */
		double dummy;			/* User time */

			/* Allocate `new_item' */
		new_item = (struct prof_info *) cmalloc (sizeof(struct prof_info));
		if (!new_item) {
				/* Bad Luck! */
			enomem();
		}

			/* Basic initialization */
		new_item->number_of_calls = 1;
		new_item->featurename = name;
		new_item->dtype = dtype;
		new_item->origin = origin;
		new_item->feature_hcode = hashcode(name, strlen(name));
			/* Record time value */
		prof_time(&dummy, &(new_item->this_total_time));
			/* Zero values */
		new_item->all_total_time = 0.;
		new_item->descendent_time = 0.;
			/* Mark running */
		new_item->is_running = 1;

		prof_stack_push(new_item);
	}
}

void stop_profile()
{
	/* Stop timer for feature on top of 'prof_stack' and store
	 * information in `class_table'.
	 */

	if(eif_profiler_on) {
		struct prof_info *item;	/* The information to change */

		if((item = prof_stack_pop())) {	/* Testing against NULL */
				/* `prof_stack' doesn't contain the finishing
				 * feature anymore. This makes live easier.
				 */
			struct prof_info *stk_item;
			double dummy, new_value;	/* Timinig */

			prof_time(&dummy, &new_value);	/* Get CPU Time */
			item->all_total_time = new_value - item->this_total_time;
			item->is_running = 0; /* Mark feature is not running */

			if (gc_ran && !gc_running) {
					/* Get time wasted by GC */
				item->all_total_time -= last_gc_time;
				gc_ran = 0;
			}

			if ((stk_item = prof_stack_top())) {
					/* There is still a callee, so
					 * update it.
					 */

				stk_item->all_total_time -= item->all_total_time;
				stk_item->descendent_time += item->all_total_time;
			}

			update_class_table(item);		/* Record times */
		} else {
				/* Bad Luck! (Profile stack corrupted) */
			panic("Profile stack coprrupted");
		}
	}
}

#define Classname(x)	System(x).cn_generator

void start_trace(name, origin, dtype)
char *name;				/* The routine name */
int origin;				/* The origin of the routine */
int dtype;				/* The class in which the routine is defined */
{
	/* Prints, on stdout, the message that feature 'name' in class 'dtype' inherited from 'origin' is just entered.
	 * The user can redirect the output to a file, when he/she wants that.
	 */

	int i;				/* Counter needed for loops */

	if (trace_call_level != 0 && last_dtype != -1) {
		fprintf(stderr, "\n");
		for (i = 0; i < trace_call_level - 1; i++)
			fprintf (stderr, "|  ");		/* Print preceding spaces */

		fprintf(stderr, ">>> %s from %s", last_name, Classname(last_dtype));		/* Standard message for entering features */

		if (last_dtype != last_origin)	/* Check if it is inherited... */
			fprintf(stderr, " (%s)", Classname(last_origin));
	}

	trace_call_level++;		/* Increase the call_level */

	last_dtype = dtype;
	last_origin = origin;
	last_name = name;
}

void stop_trace(name, origin, dtype)
char *name;				/* The routine name */
int origin;				/* The origin of the routine */
int dtype;				/* The class in which the routine is defined */
{
	/* Prints that feature 'name' in class 'dtype' inherited from 'origin' is about to leave. */

	int i;				/* Counter needed for loops */

	trace_call_level--;		/* Decrease the call_level */

	fprintf(stderr, "\n");

	for (i = 0; i < trace_call_level; i++)
		fprintf(stderr, "|  ");		/* Print preceding spaces */

	if ((strcmp(last_name, name) == 0) && (last_dtype == dtype) && (last_origin == origin)) {
		fprintf(stderr, "---");
		last_dtype = -1;
	} else {
		fprintf(stderr, "<<<");
	}

	fprintf(stderr, " %s from %s", name, Classname(dtype));		/* Standard message for leaving features */

	if (dtype != origin)	/* Check if it is inherited... */
		fprintf(stderr, " (%s)", Classname(origin));
}

struct prof_info* prof_stack_pop()
{
	/* Pop the top off `prof_stack'.
	 * Return NULL if there is no top item to pop.
	 */

	if(eif_profiler_on) {
		register1 struct prof_info *stk_item;	/* Top item of stack */

		if((stk_item = prof_stack_top())) {
				/* Okay, data structure still intact */
			prof_stack->st_top -= 1;	/* Reset top */
			if(prof_stack->st_top < prof_stack->st_cur->sk_arena) {
					/* Oops, current chunk is empty */
				prof_stack->st_cur = prof_stack->st_cur->sk_prev;
				prof_stack->st_top = prof_stack->st_cur->sk_end - 1;
				st_truncate(prof_stack);	/* Reuse memory */
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

struct prof_info* prof_stack_top()
{
	/* Return top of `prof_stack'.
	 * NULL if no item is available on `prof_stack'
	 */

	if(eif_profiler_on) {
		char **top;

		top = prof_stack->st_top;	/* Next free location */
		top -= 1;
		if(top < prof_stack->st_cur->sk_arena) {
				/* Bad Luck! */
			return 0;
		}

		return (struct prof_info *) (*top);
	} else
		return 0;
}

void prof_stack_init()
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

	if(eif_profiler_on) {
			/* Allocate profile stack */
		prof_stack = (struct stack *) cmalloc(sizeof(struct stack));
		if(!prof_stack)
			enomem();	/* Bad Luck! */

			/* Allocate arena and chunk for memory problem */
		if(!st_alloc(prof_stack, STACK_CHUNK))
			enomem();	/* Bad Luck! */
	}
}

void prof_stack_free()
{
	/* Free the memory allocated for `prof_stack'. */

	if(eif_profiler_on) {
		xfree(prof_stack->st_cur);	/* Free memory used by chunk */
		xfree(prof_stack);			/* Free memory used by stack */
	}
}

void prof_stack_push(new_item)
struct prof_info *new_item;
{
	/* Push `new_item' on `prof_stack'.
	 * Painc if not possible.
	 */

	if(eif_profiler_on) {
		if(epush(prof_stack, (char *) new_item) == -1) {
				/* Bad Luck! */
			panic("Push profile info failed.");
		}
	}
}

void update_class_table(item)
struct prof_info *item;
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

	if(eif_profiler_on) {
		struct feat_table *f_t;		/* Feature table */
		struct prof_info *p_i;		/* New item */
		unsigned long f_hcode;		/* Feature H code */

			/* Find the H table of features of class dtype */
		f_t = (struct feat_table *) ht_value(class_table, item->dtype);
		if(!f_t) {
				/* Create a new Hash table */
			f_t = (struct feat_table *) xcalloc(1, sizeof(struct feat_table));
			if(!f_t)
				enomem();	/* Bad Luck */

				/* Initialize new feature table for dtype */
			f_t->dtype = item->dtype;
			f_t->htab = (struct htable *) xcalloc(1, sizeof(struct htable));
			if(!f_t->htab)
				enomem();	/* Bad Luck */

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
			char **address;
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
				((struct prof_info *)*address)->this_total_time += p_i->all_total_time;
			}

			xfree(item);
		}
	}
}

void prof_stack_rewind(old_top)
char **old_top;		/* Old top. Just to know where to stop rewinding. */
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

	if(eif_profiler_on) {
			/* Traverse the stack to a certain point */
		while(prof_stack->st_top >= old_top) {
				/* Stop profiling top item */
			stop_profile();
		}
	}
}

void prof_time(usertime, systime)
double *usertime;	/* User time */
double *systime;	/* System time */
	/* Get the user and system time.
	 * This function is optimized for the profiler. `getcputime()' in `timer.c'
	 * always divides the result.
	 * Quantify told us that that is a bad idea.
	 */

#ifdef HAS_GETRUSAGE
{
	struct rusage usage;

	getrusage(RUSAGE_SELF, &usage);

	*usertime = (double)usage.ru_utime.tv_sec + (double)usage.ru_utime.tv_usec;
	*systime = (double)usage.ru_stime.tv_sec + (double)usage.ru_stime.tv_usec;
}
#else
#ifdef HAS_TIMES
{
	struct tms time;

	(void) times(&time);
	*usertime = (double)time.tms_utime;
	*systime = (double)time.tms_stime;
}
#else
{
	*user_time = 0;
	*system_time = 0;
}
#endif /* HAS_TIMES */
#endif /* HAS_GETRUSAGE */
