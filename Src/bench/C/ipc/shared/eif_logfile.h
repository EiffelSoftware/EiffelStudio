/*
	description: "Declarations for logging."
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

#ifndef _logfile_h_
#define _logfile_h_

extern void dexit(int);				/* Exit from the program by adding a log */
#ifdef USE_ADD_LOG

#include <sys/types.h>
#include "eif_config.h"

/* Routine defined by logging package */
#ifdef EIF_WINDOWS
extern void add_log(int level, char *format, int arg1, HANDLE arg2, HANDLE arg3, HANDLE arg4, HANDLE arg5);
#else
extern void add_log(int level, char *format, int arg1, int arg2, int arg3, int arg4, int arg5);			/* Add logging message */
#endif

extern int open_log(char *name);	/* Open logging file */
extern void close_log(void);		/* Close logging file */
extern void set_loglvl(int level);	/* Set logging level */
extern int reopen_log(void);		/* Re-open same logfile */

/* The following need to be provided externally */
extern char *progname;			/* Program name */
#ifndef EIF_WINDOWS
extern Pid_t progpid;			/* Program PID */
#endif

#endif
#endif

