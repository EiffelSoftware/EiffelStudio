/*
	description: "Include file for traversal of objects."
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

#ifndef _eif_traverse_h_
#define _eif_traverse_h_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Flags for traversal */
#define TR_PLAIN		0x00		/* No accounting during object traversal */
#define TR_ACCOUNT		0x01		/* Accounting of objects in obj_nb */
#define TR_MAP			0x02		/* Build a maping table in obj_table */
#define TR_ACCOUNT_ATTR	0x04		/* Accounting of types of attributes */
#define INDEPEND_ACCOUNT 0x11
#define RECOVER_ACCOUNT	0x15

RT_LNK EIF_REFERENCE find_referers (EIF_REFERENCE target, EIF_INTEGER result_type);
RT_LNK EIF_REFERENCE find_instance_of (EIF_INTEGER instance_type, EIF_INTEGER result_type);
RT_LNK EIF_REFERENCE find_all_instances (EIF_INTEGER result_type);

RT_LNK void eif_lock_marking (void);
RT_LNK void eif_unlock_marking (void);

#ifdef __cplusplus
}
#endif

#endif

