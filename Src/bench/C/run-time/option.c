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

public struct profile_stack *prof_stack;

/* INTERNAL TRACE VARIABLES */

int last_dtype;			/* These three variables are needed because we */
int last_origin;		/* want to print "...---..." instead of "...>>>... _nextline_ ...<<<..." */
char *last_name;		/* when we deal with a so called terminal feature (a feature without calls to other features) */

/* INTERNAL PROFILE STRUCTURES */

/* Stored in both the table and the stack */
struct profile_information {
	char		*featurename;		/* Name of feature */
	int		dtype;			/* DTYPE of feature */
	int		origin;			/* ORIGIN of feature */
	unsigned long	pi_hcode;		/* Hash code of the featurename */
	long		number_of_calls;	/* Number of calls to routine */
	double		this_total_time;	/* Time spent in the function. (during this execution) */
	double		all_total_time;		/* Time spent in the function. (summarized) */
	double		descendent_time;	/* Time spent in the descendents of the functions. */
	int		is_running;		/* Is the function running? To determine whether this is a recursive call or not. */
};

/* Stack items for the profile stack */
struct prof_item {
	struct profile_information *info;	/* Actual info */
	struct prof_item *link;			/* Link to next or previous item */
};

/* The stack */
struct profile_stack {
	struct prof_item *top;	/* End of the SF */
	struct prof_item *bot;	/* Start of the SF */
};

/* Structure for H table of features.
 * 'hcode' is meant to be the H key of the class
 */
struct feat_table {
	char *classname;		/* The class name where the features are written in. */
	unsigned long hcode;		/* H code of the H key, which is the classname */
	struct htable *htab;		/* Features of class corresponding to 'hcode' in H tables */
};

struct htable *class_table;		/* The H table that contains all info */

/* INTERNAL PROFILE DEFINITIONS */

#define profile_output_file	"profinfo"

/* INTERNAL PROFILE FUNCTIONS */

void update_class_table();			/* Updates the H table */
void prof_stack_push();					/* Pushes item on the profile staack */
void prof_stack_free();					/* Frees the memory allocated for the profile stack */
void prof_stack_init();					/* Initializes the profile stack */
struct profile_information* prof_stack_top();		/* Returns the top of the stack */
void prof_stack_pop();					/* Pops the top item of the profile stack */

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
	/* Checks whether the class 'dtype' has E-TRACE or E-PROFILE options in 'opt' and
	 * dispatches to the functions start_trace and start_profile if necessary.
	 * This function is directly called by RTSA in frozen mode; it is called explicitly
	 * from the interpreter as soon as it determines that a feature is to be executed. -- GLJ
	 */

	struct ex_vect *vector = (struct ex_vect *) 0;

 	if (opt->trace_level) {
			/* Vector is not initialized before for efficiency: if both trace and profiling are off,
			 * there is no need to get the exception vector.
			 */

		vector = extop(&eif_stack);	/* Get top of the exception stack for the routine name etc. */

		/* User wants tracing. */
		start_trace(vector->ex_rout, vector->ex_orig, dtype);
	}

	if (opt->profile_level) {
		if (!vector)
			vector = extop(&eif_stack);	/* Get top of the exception stack for the routine name etc. */

		/* User wants profiling. */
		start_profile(vector->ex_rout, vector->ex_orig, dtype);
	}
}

void check_options_stop()
{
	/* Checks whether the feature on top of the 'eif_stack' is E-TRACEd and E-PROFILEd and
	 * dispatches to the functions stop_trace and stop_profile if necessary.
	 * This function is called by RTSO, which is called by RTEE. Thus we guarantee that
	 * at least this part of E-TRACE and E-PROFILE will work for both frozen
	 * and melted code. -- GLJ
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

#endif

#define Classname(x)	System(x).cn_generator

void initprf()
{
	/* Creates the table needed for E-PROFILE. This function should only be called if
	 * internal profiling is specified by the user.
	 */

	if(eif_profiler_on) {
		class_table = (struct htable *) xcalloc(1, sizeof(struct htable));
		if (class_table == (struct htable *) 0)
			enomem();

		if (!ht_create(class_table, 10, sizeof(struct feat_table)))
			ht_zero(class_table);
		else
			eraise("Hashtable creation failure", EN_FATAL);

		prof_stack_init();
	}
}

void exitprf()
{
	if(eif_profiler_on) {
		unsigned long *keys;			/* Key values from the class H table */
		struct feat_table *f_values;		/* Values as stored in the class H table */
		struct profile_information *features;	/* Features from the feature H tables */
		int i,					/* Counter for the outer-loop */
	    	index,				/* Index counter for output */
	    	j;					/* Counter for the inner-loop */
		FILE *prof_output;			/* File to write the output in. */

		prof_output = fopen(profile_output_file, "w");
		if (prof_output == (FILE *) 0)
			eraise("Unable to open to output file for profile", EN_FATAL);

		keys = class_table->h_keys;
		f_values = (struct feat_table *) class_table->h_values;
		index = 1;

		for (i = 0; i < class_table->h_size; i++) {
			if (keys[i] != 0) {
				for (j = 0; j < f_values[i].htab->h_size; j++) {
					if (f_values[i].htab->h_keys[j] != 0) {
						features = (struct profile_information *) f_values[i].htab->h_values;
						fprintf(prof_output, "[%d]\t%.2f\t%.2f\t%ld\t%s from %s\t[%d]\n", index,
		    					features[j].all_total_time,
								features[j].descendent_time,
		    					features[j].number_of_calls,
		    					features[j].featurename, f_values[i].classname,
								index);
						index++;
					}
				}
				ht_free(f_values[i].htab);
				xfree(f_values[i].classname);
			}
		}

		fclose(prof_output);
		ht_free(class_table);
		prof_stack_free();
	}
}

void start_profile(name, origin, dtype)
char *name;				/* The routine name */
int origin;				/* The ancestor where 'name' is written, if and only if not in 'dtype' */
int dtype;				/* The class in which the routine is defined */
{
	/* Initializes the timer, the number of calls and the featurename for a new 'prof_stack' entry (see below). */

	if(eif_profiler_on) {
		struct profile_information *new_p_i;	/* New information */
		double dummy;				/* User time, returned by getcputime is not of interest here */

		/* Create and initialize a new entry for the stack */
		new_p_i = (struct profile_information *) cmalloc (sizeof(struct profile_information));
		if (new_p_i == (struct profile_information *) 0)
			enomem();

		new_p_i->number_of_calls = 1;
		new_p_i->featurename = name;
		new_p_i->dtype = dtype;
		new_p_i->origin = origin;
		new_p_i->pi_hcode = hashcode(name, strlen(name));
		getcputime(&dummy, &(new_p_i->this_total_time));	/* Record the current time */
		new_p_i->all_total_time = 0.;				/* Initialize to zero, stop_profile relies on this */
		new_p_i->descendent_time = 0.;				/* Initialize to zero, so we can always add values */
		new_p_i->is_running = 1;				/* Mark that the function is running */

		prof_stack_push(new_p_i);
	}
}

void stop_profile()
{
	/* Stops the timer for the feature that is on top of the 'prof_stack'. Then updates the table
	 * and pops the entry of the stack.
	 */

	if(eif_profiler_on) {
		struct profile_information *p_i;	/* The information to change */
		double dummy, new_value;

		if ((p_i = prof_stack_top()) != (struct profile_information *) 0) {

			getcputime(&dummy, &new_value);					/* Get the new time */

			p_i->all_total_time = new_value - p_i->this_total_time;		/* Compute the difference */
			p_i->is_running = 0;						/* Mark that the function isn't running anymore */

			if (gc_ran && !gc_running) {
				p_i->all_total_time -= last_gc_time;
				gc_ran = 0;
			}

			if (prof_stack->top->link->link != prof_stack->bot) {
				struct profile_information *stk_item;

				stk_item = prof_stack->top->link->link->info;
				stk_item->all_total_time -= p_i->all_total_time;
				stk_item->descendent_time += p_i->all_total_time;
			}

			update_class_table(p_i);					/* Record times in the table */
			prof_stack_pop();							/* Pop feature from the stack */
		}
	}
}

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

void prof_stack_pop()
{
	/* Pops an item of the 'prof_stack'. */

	if(eif_profiler_on) {
		struct prof_item *old_it;	/* Old stack item */

		old_it = prof_stack->top->link;		/* Get old item */
		prof_stack->top->link = prof_stack->top->link->link;	/* Unchain old item */

		xfree(old_it);			/* Free memory used by the stack entry */
	}
}

struct profile_information* prof_stack_top()
{
	/* Returns a NULL pointer if the stack is empty, otherwise the information structure.
	 * The stack is empty if and only if the next item from the top is the bottom item, i.e. top->link->link == NULL.
	 */

	if(eif_profiler_on)
		return (prof_stack->top->link->link == (struct prof_item *) 0 ? (struct profile_information *) 0 : prof_stack->top->link->info);
	else
		return (struct profile_information *) 0;
}

void prof_stack_init()
{
	/* Initializes the 'prof_stack' by allocating memory for the stack-structure and the top-item
	 * of the stack. The bottom item of the stack is a stack item with only NULL pointers.
	 * Thus we know: `(top->link->link == NULL) implies stack.empty'.
	 *
	 * We do not use the more intelligent way of using chunks in an arena, because that will be way
	 * to slow for profiling. The code which manipulates the 'prof_stack' MUST remain highly optimized
	 * for speed, because we don't want a slow execution when E-PROFILE is working.
	 * For this simple reason, we use here dynamic (i.e. pointers) rather than static structures, for we
	 * can copy a pointer in a simple way, and thus fast.
	 * Another reason for this simple stack structure is that it will be used only when we use it (i.e. for
	 * those features of a class where the user specified E-PROFILE). This means the stack will
	 * hopefully, not grow out of bounds and therefore we can just allocate blocks here and there and
	 * take the risk that a part of the stack will be swapped out by the OS. This, though, will not create
	 * a slow stack manipulation, and hence a slow system-execution. -- GLJ
	 */

	if(eif_profiler_on) {
		prof_stack = (struct profile_stack *) cmalloc(sizeof(struct profile_stack));			/* Allocate profile stack */
		if (prof_stack == (struct profile_stack *) 0)							/* Allocated? */
			enomem();

		prof_stack->bot = (struct prof_item *) cmalloc(sizeof(struct prof_item));
		prof_stack->bot->info = (struct profile_information *) 0;
		prof_stack->bot->link = (struct prof_item *) 0;

		prof_stack->top = (struct prof_item *) cmalloc(sizeof(struct prof_item));	/* Allocate top item */
		if (prof_stack->top == (struct prof_item *) 0)						/* Allocated? */
			enomem();

		prof_stack->top->link = prof_stack->bot;							/* Previous item is the bottom ==> Stack is empty */

		prof_stack->top->info = (struct profile_information *) 0;					/* Allocate new item */
	}
}

void prof_stack_free()
{
	/* Frees the memory allocated for the 'prof_stack'. */

	if(eif_profiler_on) {
		xfree(prof_stack->top);		/* Free the memory used by the top item */
		xfree(prof_stack->bot):		/* Free the memory used by the bottom item */
		xfree(prof_stack);		/* Free the memory used by the stack structure */
	}
}

void prof_stack_push(new_info)
struct profile_information *new_info;
{
	/* Pushes a new item on the 'prof_stack'. */

	if(eif_profiler_on) {
		struct prof_item *new_it;	/* New stack item */

		new_it = (struct prof_item *) cmalloc(sizeof(struct prof_item));	/* Allocate new item */
		if (new_it == (struct prof_item *) 0)
			enomem();

		bzero(new_it, sizeof(struct prof_item));
		new_it->info = new_info;
		new_it->link = prof_stack->top->link;
		prof_stack->top->link = new_it;
	}
}

void update_class_table(item)
struct profile_information *item;
{
	/* The `class_table' is a H table containing H tables. This is because of the fact that the only
	 * precise identification of a feature is its class (whether origin or dtype) plus its name.
	 * It is possible to concatenate the class id and feature name to produce a unique hash key.
	 * However, we would have to deal with a humongous H table in the end. This means that it becomes 
	 * obvious that insertion will have to do several searches empty slots. That would slow down the 
	 * system... (See above at prof_stack_init)
	 *
	 * OK: The way it is done: first we check whether the class id has been inserted already, and hence we know
	 * if there is a H table for the features of that class.  If we cannot find an entry matching the class id, 
	 * we create a new H table and insert it into the `class_table'. Second, we search the feature in the found 
	 * H table and update the information (if it was known) or insert the information (if it was unknown).
	 */

	if(eif_profiler_on) {
		struct feat_table		*f_t;		/* The H table containing features from a certain class */
		struct profile_information	*p_i;		/* New item for the H table */
		struct prof_item		*stk_p_i;	/* Item on the stack */
		char 				*class_name;	/* The name of the class */
		unsigned long 			class_hcode;	/* The hashcode for the classname */
		unsigned long 			f_hcode;	/* The hashcode for the feature name */

		if (item->dtype == item->origin)
			class_name = Classname(item->dtype);		/* The class is the origin */
		else
			class_name = Classname(item->origin);		/* The feature is written in 'origin' instead of 'dtype' */

		class_hcode = hashcode(class_name, strlen(class_name));		/* Keep the H code, to make things faster */

		f_t = (struct feat_table *) ht_value(class_table,class_hcode);	/* Try to seek the H table for the features */

		if (f_t == (struct feat_table *) 0) {
			/* Create a new Hash table */

			f_t = (struct feat_table *) xcalloc(1, sizeof(struct feat_table));
			if (f_t == (struct feat_table *) 0)
				enomem();		/* Out of memory */

			f_t->classname = class_name;		/* Initialize the just created structure */
			f_t->hcode = class_hcode;

			f_t->htab = (struct htable *) xcalloc(1, sizeof(struct htable));
			if (f_t->htab == (struct htable *) 0)
				enomem();		/* Out of memory */

			if (!ht_create(f_t->htab, 10, sizeof(struct profile_information)))	/* Create H table for features */
				ht_zero(f_t->htab);						/* initialize it */
			else
				eraise("Hashtable creation failure", EN_FATAL);			/* Something is wrotten */

			ht_force(class_table,f_t->hcode,(char *) f_t);		/* Add feature H table to class H table */
		}

		/* OK. Either the class was known and f_t is directly from the class_table, or
	 	* we were able to create a new one.
	 	*/

		f_hcode = item->pi_hcode;

		p_i = (struct profile_information *) ht_value(f_t->htab, f_hcode);

		if (p_i == (struct profile_information *) 0) {
			ht_force(f_t->htab, f_hcode, (char *) item);
		} else {
			p_i->number_of_calls += item->number_of_calls;
			p_i->all_total_time += item->all_total_time;
			p_i->descendent_time += item->descendent_time;
		
			if (prof_stack->top->link->link != prof_stack->bot) {
				for (stk_p_i = prof_stack->top->link->link;
				    	(!(stk_p_i->info->dtype == item->dtype && stk_p_i->info->origin == item->origin && stk_p_i->info->pi_hcode == f_hcode));
				    	/* EMPTY */) {
					if (stk_p_i->link == prof_stack->bot)
						break;
					else
						stk_p_i = stk_p_i->link;
				}
				if (stk_p_i->link != prof_stack->bot) {
					stk_p_i->info->this_total_time += p_i->all_total_time;
				}
			}

			xfree(item);
		}
	}
}

void prof_stack_rewind()
{
	/* Rewinds the 'prof_stack' and thus updates all features in that stack and puts data in the profile table.
	 *
	 * This function is useful when the system is interrupted by an exception which is "rescued" and then
	 * the feature is "retried". We can simple rewind the current profile stack and restore the saved profile stack.
	 * Thus we must declare a profile_stack structure, store 'prof_stack' in it, and create a new 'prof_stack' (via prof_stack_init)
	 * every time a feature has a rescue-clause. Then we must rewind the new profile stack and restore the saved
	 * profile stack into 'prof_stack', which can bo done with a simple C-assignment.
	 * This guarantees that all information, so far, will be kept EVEN if the system has a caught exception.
	 * For exceptions which causes the system to stop (i.e. no where was a rescue-clause), we guarantee very
	 * much useless information, because we always do a 'exitprf' in 'reclaim'. -- GLJ
	 */

	if(eif_profiler_on)
		while(prof_stack->top->link != prof_stack->bot)		/* As long as there are items on the stack ... */
			stop_profile();					/* ... stop profiling for the top item. */
}
