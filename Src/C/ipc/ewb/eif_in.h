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

#ifndef _eif_in_h_
#define _eif_in_h_

#include "eif_io.h"

extern void rqst_handler_to_c(EIF_OBJ eif_rqst_hdlr, EIF_INTEGER rqst_type, EIF_PROC eif_set);
extern EIF_REFERENCE request_handler (void);
extern EIF_REFERENCE request_dispatch (Request rqst);

/* Following routines are not in use but kept in case we would use them again. */
extern void send_byte_code (EIF_INTEGER real_body_index, BODY_INDEX real_body_id, char *byte_array, EIF_INTEGER size);
extern void send_breakpoint (BODY_INDEX real_body_id, long int offset, EIF_BOOLEAN opcode);
extern void send_ack_end (void);

#endif /* _eif_in_h_ */
