/*
	description: "Structures used for request handling."
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

#ifndef _request_h_
#define _request_h_

#include "rqst_const.h"
#include "stack.h"

/*
 * Data structures used by the requests
 */

typedef struct {
	int op_type;
	int op_cmd;
	rt_uint_ptr op_size;
} Opaque;

#define op_first	op_type
#define op_second	op_cmd
#define op_third	op_size

/* Acknowledgment codes and object inspection codes defined in rqst_const.h */

typedef struct {			/* Acknowledgment */
	int ak_type;			/* General type of acknowledgment */
} Acknlge;

typedef struct {			/* Position in program execution flow */
	char *wh_name;			/* Feature name */
	rt_uint_ptr wh_obj;		/* Object address (can't use (char *) with XDR) */
	int wh_origin;			/* Where feature comes from */
	int wh_type;			/* Dynamic type of Current */
	int wh_offset;			/* Offset within byte code (-1 if none) */
	rt_uint_ptr wh_thread_id;	/* Thread id */
} Where;

typedef struct {			/* Stopping notification */
	Where st_where;			/* Where we are now */
	int st_why;				/* Why did we stop? */
	int st_code;			/* Exception code */
	char *st_tag;			/* Exception tag, if appropriate */
} Stop;
typedef struct {			/* Event notification */
	int st_type;			/* Event type */
	int st_data;			/* Event data */
} Notif;

typedef struct dump Dump;	/* Structure returned by dumps */

/* General protocol request structure. Each time a new structure is added, we
 * need to write an XDR serializing routine for it, and we have to update the
 * XDR routine for the following request.
 */

/* Request types with specific information carried in structure:
 * check rqst_conf.h
 */

typedef struct {			/* General client request format */
	int rq_type;			/* Union's discriminent */
	union {
		Acknlge rqu_ack;		/* Acknowledgment (positive/negative) */
		Dump rqu_dump;			/* A dumped stack item */
		Opaque rqu_opaque;		/* Opaque parameters for request */
		Stop rqu_stop;			/* Stop information */
		Where rqu_where;		/* Position within program */
		Notif rqu_event;		/* Event notified */
	} rqu;
} Request;

#define rq_ack			rqu.rqu_ack
#define rq_dump			rqu.rqu_dump
#define rq_opaque		rqu.rqu_opaque
#define rq_stop			rqu.rqu_stop
#define rq_where		rqu.rqu_where
#define rq_event		rqu.rqu_event

#define Request_Clean(rqst)		(memset (&(rqst), 0, sizeof (Request)))
	/* Ensure that the Request is properly initialized
	 * Remember C does NOT automaically set locals to a default `0' value
	 */

#endif
