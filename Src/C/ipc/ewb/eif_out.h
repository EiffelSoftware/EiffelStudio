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

#ifndef _eif_out_h_
#define _eif_out_h_

#include "eif_eiffel.h"

extern void send_rqst_0 (long int code);
extern void send_rqst_1 (long int code, long int info1);
extern void send_rqst_2 (long int code, long int info1, long int info2);
extern void send_rqst_3 (long int code, long int info1, long int info2, rt_uint_ptr info3);
extern void send_rqst_4 (long int code, long int info1, long int info2, rt_uint_ptr info3, long int info4);

extern void send_integer_8_value(EIF_INTEGER_8 value);
extern void send_integer_16_value(EIF_INTEGER_16 value);
extern void send_integer_32_value(EIF_INTEGER_32 value);
extern void send_integer_64_value(EIF_INTEGER_64 value);
extern void send_natural_8_value(EIF_NATURAL_8 value);
extern void send_natural_16_value(EIF_NATURAL_16 value);
extern void send_natural_32_value(EIF_NATURAL_32 value);
extern void send_natural_64_value(EIF_NATURAL_64 value);
extern void send_real_32_value(EIF_REAL_32 value);
extern void send_real_64_value(EIF_REAL_64 value);
extern void send_char_8_value(EIF_CHARACTER value);
extern void send_char_32_value(EIF_WIDE_CHAR value);
extern void send_bool_value(EIF_BOOLEAN value);
extern void send_ref_value(EIF_REFERENCE value);
extern void send_ptr_value(EIF_POINTER value);
extern void send_string_value(char* string);
extern void send_bit_value(char *value);

extern void ewb_send_ack_ok(void);
extern EIF_BOOLEAN recv_ack (void);
extern EIF_BOOLEAN recv_dead (void);

extern void c_send_sized_str (char *s, int size);
extern void c_send_str (char *s);
extern void c_twrite (char *s, long int l);
extern EIF_REFERENCE c_tread (void);

extern int async_shell(char *cmd);

#endif /* _eif_out_h_ */
