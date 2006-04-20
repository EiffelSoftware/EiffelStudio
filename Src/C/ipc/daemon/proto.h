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
#include "stream.h"

/* The daemon flags are used to control the communication parameters with
 * the remote client (workbench).
 */
struct d_flags {				/* Daemon flags (protocol with client) */
	unsigned int d_rqst;		/* Number of requests proceeded */
	unsigned int d_sent;		/* Number of requests sent */
	STREAM *d_cs;				/* Connected stream with ewb */
	STREAM *d_as;				/* Connected stream with application */
#ifdef EIF_WINDOWS
	HANDLE d_ewb;				/* Workbench pid */
	HANDLE d_app;				/* Application process handle */
	DWORD d_app_id;				/* Application process id */
	LPVOID	d_interrupt_flag;	/* pointer to the interruption flag inside application memory space */
#else
 	int d_ewb;					/* Workbench pid */
	int d_app;					/* Application pid */
#endif
};

#define rqstcnt		daemon_data.d_rqst
#define rqstsent	daemon_data.d_sent

extern struct d_flags daemon_data;	/* Global daemon's status */

/* Routine declarations */
#ifdef EIF_WINDOWS
extern void drqsthandle(EIF_LPSTREAM);	/* General request processor */
extern void send_packet(STREAM *s, Request *dans);
extern int recv_packet(STREAM *s, Request *rqst, BOOL reset);
extern void prt_destroy (void);
#else
extern void drqsthandle(int s);	/* General request processor */
extern void send_packet(int s, Request *dans);	/* Send an asnwer to client */
extern int recv_packet(int s, Request *rqst);	/* Receive data from client */
#endif

extern void apphandle();		/* Handle messages from application */ /* %%ss undefined not used in C */
extern void dead_app(void);		/* Signals ewb that app is dead */
extern void prt_init(void);		/* Initialize IDR filters */

#endif
