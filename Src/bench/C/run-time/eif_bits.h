/*
	description: "Declarations for bits handling routines."
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

#ifndef _eif_bits_h_
#define _eif_bits_h_

#include "eif_portable.h"
#include "eif_plug.h"

#ifdef __cplusplus
extern "C" {
#endif

/* 
 * Functions declarations
 */
RT_LNK EIF_BOOLEAN b_equal(EIF_REFERENCE a, EIF_REFERENCE b);	/* needed in interp.c */
RT_LNK EIF_REFERENCE b_eout(EIF_REFERENCE bit);					/* Eiffel string for out representation of a bit */
RT_LNK EIF_REFERENCE b_clone(EIF_REFERENCE bit);				/* Clones bit */
RT_LNK void b_copy(EIF_REFERENCE a, EIF_REFERENCE b);			/* Copies bit */
RT_LNK void b_put(EIF_REFERENCE bit, char value, int at);
RT_LNK EIF_BOOLEAN b_item(EIF_REFERENCE bit, EIF_INTEGER at);
RT_LNK EIF_REFERENCE b_shift(EIF_REFERENCE bit, EIF_INTEGER s);
RT_LNK EIF_REFERENCE b_rotate(EIF_REFERENCE bit, EIF_INTEGER s);
RT_LNK EIF_REFERENCE b_and(EIF_REFERENCE a, EIF_REFERENCE b);
RT_LNK EIF_REFERENCE b_implies(EIF_REFERENCE a, EIF_REFERENCE b);
RT_LNK EIF_REFERENCE b_or(EIF_REFERENCE a, EIF_REFERENCE b);
RT_LNK EIF_REFERENCE b_xor(EIF_REFERENCE a, EIF_REFERENCE b);
RT_LNK EIF_REFERENCE b_not(EIF_REFERENCE a);
RT_LNK EIF_REFERENCE b_out(EIF_REFERENCE bit);
RT_LNK EIF_REFERENCE b_mirror(EIF_REFERENCE a);
RT_LNK EIF_INTEGER b_count(EIF_REFERENCE bit);

#ifdef __cplusplus
}
#endif


#endif
