/*
	description: "Include file for Eiffel equality."
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

#ifndef _eif_equal_h_
#define _eif_equal_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Routine declarations
 */

RT_LNK EIF_BOOLEAN xequal(EIF_REFERENCE ref1, EIF_REFERENCE ref2);			/* Equality with no conformance constraint */
RT_LNK EIF_BOOLEAN eequal(register EIF_REFERENCE target, register EIF_REFERENCE source);			/* Standard equality on standard objects */
extern EIF_BOOLEAN eiso(EIF_REFERENCE target, EIF_REFERENCE source);				/* Standard isomorphism on normal objects */
extern EIF_BOOLEAN spiso(register EIF_REFERENCE target, register EIF_REFERENCE source);				/* Standard isomorphism on special objects */
RT_LNK EIF_BOOLEAN ediso(EIF_REFERENCE target, EIF_REFERENCE source);				/* Standard recursive isomorphism */

#ifdef __cplusplus
}
#endif

#endif
