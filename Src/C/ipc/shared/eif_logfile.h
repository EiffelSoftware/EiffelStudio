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
extern void add_log (int level, char *StrFmt, ...);

extern int open_log(char *name);	/* Open logging file */
extern void close_log(void);		/* Close logging file */
extern void set_loglvl(int level);	/* Set logging level */
extern int reopen_log(void);		/* Re-open same logfile */

/* The following need to be provided externally */
extern char *progname;			/* Program name */
#ifndef EIF_WINDOWS
extern Pid_t progpid;			/* Program PID */
#endif

/* Note[2011/03/24] We could use
 *
 * #define ADD_LOG(level, ...) add_log(level, __VA_ARGS__);
 *
 * but it is not supported by all compiler, so we decided to duplicated those macro
 * to avoid using #ifdef USE_ADD_LOG everywhere ...
 */
#define ADD_LOG(lev,str) add_log(lev,str)
#define ADD_LOG_d(lev,str,d) add_log(lev,str,d)
#define ADD_LOG_d_d(lev,str,d1,d2) add_log(lev,str,d1,d2)
#define ADD_LOG_s(lev,str,s) add_log(lev,str,s)
#define ADD_LOG_s_s(lev,str,s1,s2) add_log(lev,str,s1,s2)
#define ADD_LOG_s_d(lev,str,s,d) add_log(lev,str,s,d)
#else
#define ADD_LOG(lev,str) 
#define ADD_LOG_d(lev,str,d) 
#define ADD_LOG_d_d(lev,str,d1,d2)
#define ADD_LOG_s(lev,str,s) 
#define ADD_LOG_s_s(lev,str,s1,s2)
#define ADD_LOG_s_d(lev,str,s,d)
#endif /* USE_ADD_LOG */

#endif /* _logfile_h_ */

