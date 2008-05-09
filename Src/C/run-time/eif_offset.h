/*
	description: "Platform specific offset computation routines of basic elements."
	date:		": 2007-02-13 02:48:06 -0800 (Tue, 13 Feb 2007) $"
	revision:	": 66628 $"
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

#ifndef _eif_offset_h_
#define _eif_offset_h_

#include "eif_size.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK size_t eif_chroff(size_t);
RT_LNK size_t eif_i16off(size_t, size_t);
RT_LNK size_t eif_lngoff(size_t, size_t, size_t);
RT_LNK size_t eif_r32off(size_t, size_t, size_t, size_t);
RT_LNK size_t eif_ptroff(size_t, size_t, size_t, size_t, size_t);
RT_LNK size_t eif_i64off(size_t, size_t, size_t, size_t, size_t, size_t);
RT_LNK size_t eif_r64off(size_t, size_t, size_t, size_t, size_t, size_t, size_t);
RT_LNK size_t eif_objsiz(size_t, size_t, size_t, size_t, size_t, size_t, size_t, size_t);

#ifdef __cplusplus
}
#endif

#endif

