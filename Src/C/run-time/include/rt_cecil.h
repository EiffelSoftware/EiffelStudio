/*
	description: "Private declaration for CECIL."
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

#ifndef _rt_cecil_h_
#define _rt_cecil_h_

#include "eif_cecil.h"
#include "rt_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
extern EIF_CS_TYPE *eif_cecil_mutex;
#endif

extern char * eif_pre_ecma_mapped_type (char *v);
extern uint32 eif_dtype_to_sk_type (EIF_TYPE_INDEX dtype);
extern EIF_TYPE_INDEX eif_sk_type_to_dtype (uint32 sk_type);

#ifdef __cplusplus
}
#endif

#endif

