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
#include "eif_portable.h"

#ifdef EIF_WIN32
#include <windows.h>
#include <direct.h>	/* In order to use chdir and getcwd */
#else
#include <unistd.h>	/* In order to use chdir and getcwd */
#endif

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

extern EIF_INTEGER prof_enabled;	  /* Is the Eiffel profiler on */

/* #define prof_enabled    EIF_TEST(prof_enabled & IN_ACE_FILE) */      /* Has the profiler been enabled in the ACE file? */
#define prof_recording	EIF_TEST(prof_enabled & PROF_RECORDING)   /* Is the profile currently recording? */

extern int trace_call_level;			/* Call level to report at E-TRACE output */

extern struct stack *prof_stack;		/* Stack that maintains profile information */

extern void check_options(struct eif_opt *opt, int dtype);			/* Dispatches to start_profile and start_trace */
extern void check_options_stop(void);		/* Dispatches to stop_profile and stop_trace */

extern void start_trace(char *name, int origin, int dtype);			/* Prints entering feature ... */
extern void stop_trace(char *name, int origin, int dtype);			/* Prints leaving feature ... */

extern void initprf(void);				/* Generates table for profiling */
extern void exitprf(void);				/* Saves table as textfile */

extern void start_profile(char *name, int origin, int dtype);			/* Starts profiling of a certain feature */
extern void stop_profile(void);			/* Stops profiling of a certain feature */

extern void prof_stack_rewind(char **old_top);		/* Stops all timer counts in
						 * the stack items,
						 * updates the table, and
						 * pops the items from the stack
						 */

#ifdef __cplusplus
}
#endif

#endif
