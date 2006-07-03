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

#ifndef _ewb_proto_h_
#define _ewb_proto_h_

#include "request.h"
#include "stream.h"


/* The ecdbgd flags are used to control the communication parameters with
 * the remote client (ecdbgd).
 */
struct ewb_flags {				/* ecdbgd flags (protocol with client) */
	unsigned int d_rqst;		/* Number of requests proceeded */
	unsigned int d_sent;		/* Number of requests sent */
	STREAM *d_cs;				/* Connected stream with ewb */
#ifdef EIF_WINDOWS
	HANDLE d_ecdbgd;				/* ecdbgd pid */
#else
 	int d_ecdbgd;					/* Workbench pid */
#endif
};

extern int ewb_rqstcnt;				/* Request count (number of requests sent) */

extern void ewb_prt_init(void);			/* Initialize IDR filters */

extern void ewb_send_packet(EIF_PSTREAM s, Request *rqst);		/* Send IDR packet to ised */
#ifdef EIF_WINDOWS
extern int ewb_recv_packet(EIF_PSTREAM s, Request *dans, BOOL reset); /* Receive IDR packet from ised */
#else
extern int ewb_recv_packet(EIF_PSTREAM s, Request *dans);		/* Receive IDR packet from ised */	
#endif

#endif
