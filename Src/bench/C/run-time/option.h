/*

  ####   #####    #####     #     ####   #    #          #    #
 #    #  #    #     #       #    #    #  ##   #          #    #
 #    #  #    #     #       #    #    #  # #  #          ######
 #    #  #####      #       #    #    #  #  # #   ###    #    #
 #    #  #          #       #    #    #  #   ##   ###    #    #
  ####   #          #       #     ####   #    #   ###    #    #

	Include file for options queries in workbench mode
*/

#ifndef _option_h_
#define _option_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_globals.h"

/*
 * Options in workbench mode
 */

struct dbg_opt {
	int16 debug_level;			/* debug level */
	int16 nb_keys;				/* keys number */
	char **keys;				/* debug keys */
};

struct eif_opt {
	int16 assert_level;			/* Assertion level */
	int16 trace_level;			/* Tracing level */
	int16 profile_level;			/* Profiling level */
	struct dbg_opt debug_level;	  	/* Debug level */
};

/* Assertion flags for tests */
#define CK_CHECK	  	128
#define CK_LOOP			 64
#define CK_REQUIRE		 32
#define CK_ENSURE	 	 16
#define CK_INVARIANT	  8

/* Assertion level values */

/* The order is no, require, ensure, invariant, loop, check
 * and for example, specifying ensure implies verifying require so
 * AS_ENSURE is AS_REQUIRE+CK_ENSURE and so on for all the
 * different levels.
 */

#define AS_NO				0
#define AS_REQUIRE			CK_REQUIRE
#define AS_ENSURE			(AS_REQUIRE+CK_ENSURE)
#define AS_INVARIANT		(AS_ENSURE+CK_INVARIANT)
#define AS_LOOP		  		(AS_INVARIANT+CK_LOOP)
#define AS_CHECK	  		(AS_LOOP+CK_CHECK)
#define AS_ALL				AS_CHECK

/* Option level values for debugging, tracing and profiling */
#define OPT_NO				0		 /* No option */
#define OPT_ALL				1		 /* Yes/all option */

extern struct eif_opt foption[];	/* Frozen option table */
extern struct eif_opt *eoption;		/* Melted option table */

extern int is_debug(int st_type, char *key);		/* Debug level query */

/*
 * Options for E-PROFILE && E-TRACE
 */

#define PROF_RECORDING	1	/* Mask for checking whethter profiler is currently recording */
#define IN_ACE_FILE	2	/* Mask for checking whether profile(yes) is in the Ace file */

#define prof_enabled 	EIF_TEST(eif_profiler_level & IN_ACE_FILE)	/* Has the profiler been enabled in the ACE file? */
#define prof_recording	EIF_TEST(eif_profiler_level & PROF_RECORDING)	/* Is the profile currently recording? */

extern EIF_INTEGER eif_profiler_level;		/* Is the Eiffel profiler on */

extern int trace_call_level;			/* Call level to report at E-TRACE output */

extern struct stack *prof_stack;		/* Stack that maintains profile information */

extern void check_options();			/* Dispatches to start_profile and start_trace */
extern void check_options_stop();		/* Dispatches to stop_profile and stop_trace */

extern void start_trace();			/* Prints entering feature ... */
extern void stop_trace();			/* Prints leaving feature ... */

extern void initprf();				/* Generates table for profiling */
extern void exitprf();				/* Saves table as textfile */

extern void start_profile();			/* Starts profiling of a certain feature */
extern void stop_profile();			/* Stops profiling of a certain feature */

extern void prof_stack_rewind();		/* Stops all timer counts in
						 * the stack items,
						 * updates the table, and
						 * pops the items from the stack
						 */

#ifdef __cplusplus
}
#endif

#endif
