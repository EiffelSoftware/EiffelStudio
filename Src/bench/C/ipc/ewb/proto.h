/*
	description: "Some structures and definitions used to ensure protocol."
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

#ifndef _proto_h_
#define _proto_h_

#include "request.h"

extern int rqstcnt;				/* Request count (number of requests sent) */

extern void prt_init(void);			/* Initialize IDR filters */

#ifdef EIF_WINDOWS
extern void send_packet(STREAM *s, Request *rqst);		/* Send IDR packet to ised */
extern int recv_packet(STREAM *s, Request *dans, BOOL reset); /* Receive IDR packet from ised */
#else
extern void send_packet(int s, Request *rqst);		/* Send IDR packet to ised */
extern int recv_packet(int s, Request *dans);		/* Receive IDR packet from ised */	
#endif

#endif
