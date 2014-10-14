/*
	description: "Declarations."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2013, Eiffel Software."
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

#ifndef _ewb_init_h_
#define _ewb_init_h_

#include "eif_eiffel.h"

extern int is_ecdbgd_alive (void);
extern int launch_ecdbgd (EIF_NATIVE_CHAR* progn, EIF_NATIVE_CHAR* cmd, int eif_timeout);
extern int close_ecdbgd (int eif_timeout);
extern void init_connection(int* err);

#ifdef EIF_WINDOWS
extern DWORD ewb_current_process_id(void);
#else
extern int ewb_current_process_id(void);
extern int ewb_pipe_read_fd (void);
#endif

#ifdef EIF_WINDOWS
#	ifndef USE_ADD_LOG
extern char progname[30];	/* Otherwise defined in logfile.c */
#	endif
#else
#	ifndef USE_ADD_LOG
extern char *progname;	/* Otherwise defined in logfile.c */
#	endif
#endif



#endif /* _ewb_init_h_ */

