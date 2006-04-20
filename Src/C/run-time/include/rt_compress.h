/*
	description: "Compresion/Decompression used by storable."
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

#ifndef _rt_compress_h_
#define _rt_compress_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

#define EIF_CMPS_HEAD_DIS_SIZE (sizeof (unsigned char))
#define EIF_CMPS_HEAD_OUT_SIZE (sizeof (uint32))
#define EIF_CMPS_HEAD_PAD_SIZE (sizeof (unsigned char))
#define EIF_CMPS_HEAD_SIZE (EIF_CMPS_HEAD_DIS_SIZE + EIF_CMPS_HEAD_OUT_SIZE + EIF_CMPS_HEAD_PAD_SIZE)

#define EIF_CMPS_DIS_CMPS     0x01
#define EIF_CMPS_DIS_NO_CMPS  0x00 

#define EIF_CMPS_IN_SIZE  262144L /* 32768 */
#define EIF_CMPS_OUT_SIZE ((EIF_CMPS_IN_SIZE * 9) / 8 + 1 + EIF_CMPS_HEAD_SIZE)

#define EIF_DCMPS_IN_SIZE EIF_CMPS_OUT_SIZE
#define EIF_DCMPS_OUT_SIZE (EIF_CMPS_IN_SIZE + 7)

extern void eif_compress (unsigned char* in_buf, unsigned long in_size, unsigned char* out_buf, unsigned long* pout_size);
extern void eif_decompress (unsigned char* in_buf, unsigned long in_size, unsigned char* out_buf, unsigned long* pout_size);

extern void eif_cmps_read_u32_from_char_buf (unsigned char* in_buf, uint32* pout_value);

#ifdef __cplusplus
}
#endif

#endif /* !_rt_compress_h_ */

