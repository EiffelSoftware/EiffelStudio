/*
	description: "Common communication routines."
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

#ifndef _com_h_
#define _com_h_

#include "stream.h"
#include "request.h"

#ifdef EIF_WINDOWS
extern void send_bye(STREAM *s, int code);				/* Send final acknowledgment */
extern void send_ack(STREAM *s, int code);				/* Send acknowledgment */
extern void send_info(STREAM *s, int code);			/* Send information */
extern void send_packet(STREAM *s, Request *dans);	/* Send an answer to client */	
extern int recv_packet(STREAM *s, Request *rqst, BOOL reset);/* Receive data from client */	
#else
extern void send_bye(int s, int code);				/* Send final acknowledgment */
extern void send_ack(int s, int code);				/* Send acknowledgment */
extern void send_info(int s, int code);			/* Send information */
extern void send_packet(int s, Request *dans);	/* Send an answer to client */
extern int recv_packet(int s, Request *rqst);	/* Receive data from client */
#endif

extern int send_str(STREAM *sp, char *buffer);				/* Send string to the remote process */
extern char *recv_str(STREAM *sp, size_t *sizeptr);			/* Receive string from the remote process */
extern void trace_request(char *status, Request *rqst);		/* Trace received request */

#endif
