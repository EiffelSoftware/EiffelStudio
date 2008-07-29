/*
	description: "Declarations."
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

#ifndef _ewb_dumped_h_
#define _ewb_dumped_h_

#include "eif_eiffel.h"

extern void c_recv_rout_info (EIF_OBJ target);
extern void c_recv_value (EIF_OBJ target);
extern void c_pass_recv_routines (
	EIF_PROC d_nat_8,
	EIF_PROC d_nat_16,
	EIF_PROC d_nat_32,
	EIF_PROC d_nat_64,
	EIF_PROC d_int_8,
	EIF_PROC d_int_16,
	EIF_PROC d_int_32,
	EIF_PROC d_int_64,
	EIF_PROC d_bool,
	EIF_PROC d_char,
	EIF_PROC d_wchar,
	EIF_PROC d_real,
	EIF_PROC d_double,
	EIF_PROC d_ref,
	EIF_PROC d_point,
	EIF_PROC d_bits,
	EIF_PROC d_error,
	EIF_PROC d_exception_ref,
	EIF_PROC d_void);
extern void c_pass_set_rout (EIF_PROC d_rout);

#endif /* _ewb_dumped_h_ */
