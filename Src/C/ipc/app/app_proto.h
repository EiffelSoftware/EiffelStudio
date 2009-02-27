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

#ifndef _app_proto_h_
#define _app_proto_h_

#include "request.h"

extern int app_rqstcnt;				/* Request count (number of requests sent) */

extern void stop_rqst(EIF_PSTREAM);		/* Stop notification to workbench */
extern void notify_rqst(EIF_PSTREAM, int, rt_uint_ptr); /* Send notification to ewb */
extern void arqsthandle(EIF_PSTREAM s);		/* General request handler */

extern void app_send_packet(EIF_PSTREAM sp, Request *rqst);
#ifdef EIF_WINDOWS
extern int app_recv_packet(EIF_PSTREAM, Request *, BOOL); /* Receive IDR packet from ised */
#else
extern int app_recv_packet(EIF_PSTREAM, Request *);		/* Receive IDR packet from ised */	
#endif

extern void dnotify(int, rt_uint_ptr);		/* Send Notification */
extern void app_prt_init(void);			/* Initialize IDR filters */

#endif
