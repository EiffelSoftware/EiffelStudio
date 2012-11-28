/*
	description: "Declarations for ewb_child.c."
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

#ifndef _ewb_child_h_
#define _ewb_child_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_WINDOWS
extern STREAM *spawn_ecdbgd(char *id, EIF_NATIVE_CHAR *ecdbgd_path, HANDLE *child_process_handle);
extern int ewb_active_check(STREAM *sp, HANDLE pid);
#else
extern STREAM *spawn_ecdbgd(char *id, EIF_NATIVE_CHAR *ecdbgd_path, Pid_t *child_pid);
extern int ewb_active_check(STREAM *sp, int pid);
#endif

#ifdef __cplusplus
}
#endif

#endif
