/*
	description: "Include file for source file `copy.c'."
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

#ifndef _eif_copy_h_
#define _eif_copy_h_

#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

/* 
 * Functions declarations
 */

RT_LNK EIF_REFERENCE eclone(register EIF_REFERENCE source);			/* Clone of an Eiffel object */
RT_LNK EIF_REFERENCE edclone(EIF_CONTEXT EIF_REFERENCE source);			/* Deep clone of an Eiffel object */
RT_LNK EIF_REFERENCE rtclone(EIF_REFERENCE source);			/* The Eiffel clone operation (run-time) */
RT_LNK void xcopy(EIF_REFERENCE source, EIF_REFERENCE target);			/* Expanded copy with possible exception */
RT_LNK void ecopy(register EIF_REFERENCE source, register EIF_REFERENCE target);			/* Standard copy of a normal Eiffel object */
RT_LNK void eif_std_ref_copy(register EIF_REFERENCE source, register EIF_REFERENCE target);			/* Standard copy of a normal Eiffel object */
RT_LNK EIF_BOOLEAN c_check_assert (EIF_BOOLEAN b);
RT_LNK void sp_copy_data (EIF_REFERENCE Current, EIF_REFERENCE source, EIF_INTEGER source_index, EIF_INTEGER destination_index, EIF_INTEGER n);
RT_LNK void spclearall(EIF_REFERENCE spobj);		/* Reset special object's items to default */

#ifdef __cplusplus
}
#endif

#endif
