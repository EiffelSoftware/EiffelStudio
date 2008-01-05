/*
	description: "Routines for runtime initialization."
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

#ifndef _eif_main_h_
#define _eif_main_h_

#include "eif_portable.h"
#include "eif_globals.h"

#ifdef EIF_WINDOWS
#include <windows.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
RT_LNK EIF_process_once_value_t *EIF_process_once_values; /* Once values for a process */
#else
RT_LNK EIF_once_value_t *EIF_once_values; /* Once values for a thread */
RT_LNK EIF_REFERENCE **EIF_oms;           /* Once manifest strings for a thread */
RT_LNK int in_assertion;                  /* Value of the assertion level */
#ifdef WORKBENCH
RT_LNK int is_inside_rt_eiffel_code;
#endif
#endif

RT_LNK long EIF_once_count;			/* Nr. of once routines */
#ifdef EIF_THREADS
RT_LNK long EIF_process_once_count;		/* Nr. of process-relative once routines */
#endif
RT_LNK EIF_TYPE_INDEX scount;					/* Maximum dtype */
RT_LNK void eif_alloc_init(void);

#ifdef EIF_WINDOWS
RT_LNK void get_argcargv (int *argc, char ***argv);
RT_LNK void free_argv (char ***argv);
RT_LNK HANDLE ghInstance;
RT_LNK HINSTANCE eif_hInstance;
RT_LNK HINSTANCE eif_hPrevInstance;
RT_LNK LPWSTR eif_lpCmdLine;
RT_LNK int eif_nCmdShow;
#endif

RT_LNK char **eif_environ;
RT_LNK int is_debug_mode (void);
RT_LNK void set_debug_mode (int);

#ifdef __cplusplus
}
#endif

#endif
