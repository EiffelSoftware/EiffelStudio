/*

  ####   #####    #####     #     ####   #    #          #    #
 #    #  #    #     #       #    #    #  ##   #          #    #
 #    #  #    #     #       #    #    #  # #  #          ######
 #    #  #####      #       #    #    #  #  # #   ###    #    #
 #    #  #          #       #    #    #  #   ##   ###    #    #
  ####   #          #       #     ####   #    #   ###    #    #

	Include file for options queries in workbench mode
*/

#ifndef _eif_option_h_
#define _eif_option_h_

#include "eif_portable.h"
#include "eif_globals.h"

#ifdef EIF_WIN32
#include <windows.h>
#include <direct.h>	/* In order to use chdir and getcwd */
#else
#include <unistd.h>	/* In order to use chdir and getcwd */
#endif

#ifdef __cplusplus
extern "C" {
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
#define CK_REQUIRE		0x00000001
#define CK_ENSURE	 	0x00000002
#define CK_CHECK	  	0x00000004
#define CK_LOOP			0x00000008
#define CK_INVARIANT	0x00000010

/* Option level values for debugging, tracing and profiling */
#define OPT_NO				0		 /* No option */
#define OPT_ALL				1		 /* Yes/all option */

RT_LNK struct eif_opt *eoption;		/* Melted option table */

RT_LNK int is_debug(int st_type, char *key);		/* Debug level query */

/*
 * Options for E-PROFILE && E-TRACE
 */

#define PROF_RECORDING	1	/* Mask for checking whethter profiler is currently recording */
#define IN_ACE_FILE	2	/* Mask for checking whether profile(yes) is in the Ace file */

#ifdef HAS_GETRUSAGE	/* Variable to get the total execution time */
extern struct prof_rusage *init_date;
#elif defined(HAS_TIMES)
extern double init_date;
#elif defined(EIF_WIN32)
extern SYSTEMTIME *init_date;
#endif /* HAS_GERUSAGE */

/* #define prof_enabled    EIF_TEST(egc_prof_enabled & IN_ACE_FILE) */      /* Has the profiler been enabled in the ACE file? */
#define prof_recording	EIF_TEST(egc_prof_enabled & PROF_RECORDING)   /* Is the profile currently recording? */

RT_LNK int trace_call_level;			/* Call level to report at E-TRACE output */

RT_LNK struct stack *prof_stack;		/* Stack that maintains profile information */

RT_LNK void check_options(struct eif_opt *opt, int dtype);			/* Dispatches to start_profile and start_trace */
RT_LNK void check_options_stop(void);		/* Dispatches to stop_profile and stop_trace */

RT_LNK void start_trace(char *name, int origin, int dtype);			/* Prints entering feature ... */
RT_LNK void stop_trace(char *name, int origin, int dtype);			/* Prints leaving feature ... */

RT_LNK void initprf(void);				/* Generates table for profiling */
RT_LNK void exitprf(void);				/* Saves table as textfile */

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
