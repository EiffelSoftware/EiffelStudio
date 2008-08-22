/*
	description: "Include file for options queries in workbench mode."
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

#ifndef _eif_option_h_
#define _eif_option_h_

#include "eif_portable.h"
#include "eif_globals.h"

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
#define CK_SUP_REQUIRE	0x00000020

/* Option level values for debugging, tracing and profiling */
#define OPT_NO				0		 /* No option */
#define OPT_ALL				1		 /* Yes/all option */
#define OPT_UNNAMED			2		 /* Unnamed debugs */

RT_LNK struct eif_opt *eoption;		/* Melted option table */

RT_LNK int is_debug(int st_type, char *key);		/* Debug level query */

/*
 * Options for E-PROFILE && E-TRACE
 */

#define PROF_RECORDING	1	/* Mask for checking whethter profiler is currently recording */
#define IN_ACE_FILE	2	/* Mask for checking whether profile(yes) is in the Ace file */

#define prof_recording	EIF_TEST(egc_prof_enabled & PROF_RECORDING)   /* Is the profile currently recording? */

#ifndef EIF_THREADS
RT_LNK int trace_call_level;			/* Call level to report at E-TRACE output */
RT_LNK struct stack *prof_stack;		/* Stack that maintains profile information */
#endif

RT_LNK void check_options(struct eif_opt *opt, int dtype);			/* Dispatches to start_profile and start_trace */
RT_LNK void check_options_stop(void);		/* Dispatches to stop_profile and stop_trace */

RT_LNK void start_trace(char *name, int origin, int dtype);			/* Prints entering feature ... */
RT_LNK void stop_trace(char *name, int origin, int dtype);			/* Prints leaving feature ... */

RT_LNK void initprf(void);				/* Generates table for profiling */

RT_LNK void start_profile(char *name, int origin, int dtype);			/* Starts profiling of a certain feature */
RT_LNK void stop_profile(void);			/* Stops profiling of a certain feature */

RT_LNK void prof_stack_rewind(char **old_top);		/* Stops all timer counts in
						 * the stack items,
						 * updates the table, and
						 * pops the items from the stack
						 */

RT_LNK EIF_BOOLEAN eif_is_tracing_enabled(void);
RT_LNK void eif_enable_tracing(void);
RT_LNK void eif_disable_tracing(void);

#ifdef __cplusplus
}
#endif

#endif
