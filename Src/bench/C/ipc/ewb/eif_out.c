/*
	description: "Externals for dealing with sent (outgoing) requests."
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

#include "eif_io.h"
#include "eif_eiffel.h"
#include "eproto.h"

#include "stack.h"

#ifdef EIF_WINDOWS
#include "stream.h"
extern STREAM *sp;
extern void start_timer(void);			/* Starts the timer for communication */
extern void stop_timer(void);			/* Stops the timer */
#endif

/* forward definitions */
rt_private void send_dmpitem_request(struct item *ip);


rt_public void send_rqst_0 (long int code)
{
	Request rqst;
#ifndef EIF_WINDOWS
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

#ifdef USE_ADD_LOG
    add_log(100, "sending request 0: %ld from ec", code);
#endif

#ifdef EIF_WINDOWS
	if (code == APPLICATION)
		start_timer();
#endif

	Request_Clean (rqst);
	rqst.rq_type = (int) code;

#ifdef EIF_WINDOWS
	send_packet(sp, &rqst);
#else
	send_packet(writefd(sp), &rqst);
#endif
}

rt_public void send_rqst_1 (long int code, long int info1)
{
	Request rqst;
#ifndef EIF_WINDOWS
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

#ifdef USE_ADD_LOG
    add_log(100, "sending request 1: %ld from ec", code);
#endif
	Request_Clean (rqst);
	rqst.rq_type = (int) code;
	rqst.rq_opaque.op_first = (int) info1;

#ifdef EIF_WINDOWS
	send_packet(sp, &rqst);
#else
	send_packet(writefd(sp), &rqst);
#endif
}

rt_public void send_rqst_2 (long int code, long int info1, long int info2)
{
	Request rqst;
#ifndef EIF_WINDOWS
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

#ifdef USE_ADD_LOG
    add_log(100, "sending request 2: %ld from ec", code);
#endif

	Request_Clean (rqst);
	rqst.rq_type = (int) code;
	rqst.rq_opaque.op_first = (int) info1;
	rqst.rq_opaque.op_second = (int) info2;

#ifdef EIF_WINDOWS
	send_packet(sp, &rqst);
#else
	send_packet(writefd(sp), &rqst);
#endif
}

rt_public void send_rqst_3 (long int code, long int info1, long int info2, rt_uint_ptr info3)
{
	Request rqst;
#ifndef EIF_WINDOWS
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

#ifdef USE_ADD_LOG
    add_log(100, "sending request 3: %ld from ec", code);
#endif

	Request_Clean (rqst);
	rqst.rq_type = (int) code;
	rqst.rq_opaque.op_first = (int) info1;
	rqst.rq_opaque.op_second = (int) info2;
	rqst.rq_opaque.op_third = info3;

#ifdef EIF_WINDOWS
	send_packet(sp, &rqst);
#else
	send_packet(writefd(sp), &rqst);
#endif
}

rt_private void send_dmpitem_request(struct item *ip)
{
	Request rqst;
#ifndef EIF_WINDOWS
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

#ifdef USE_ADD_LOG
    add_log(100, "sending specific request: %ld from ec", code);
#endif

	/* prepare the request to send */
	Request_Clean (rqst);
	rqst.rq_type = DUMPED;
	rqst.rq_dump.dmp_type = DMP_ITEM;
	rqst.rq_dump.dmp_item = ip;

	/* send the request */
#ifdef EIF_WINDOWS
	send_packet(sp, &rqst);
#else
	send_packet(writefd(sp), &rqst);
#endif
}

/* send an integer value to the application */
rt_public void send_integer_value(EIF_INTEGER value)
{	
	struct item item;
	
	/* fill in the item to send */
	item.type = SK_INT32;
	item.it_int32 = value;
	item.it_addr = NULL;
	
	/* send the request */
	send_dmpitem_request(&item);
}

/* send an integer_64 value to the application */
rt_public void send_integer_64_value(EIF_INTEGER_64 value)
{	
	struct item item;
	
	/* fill in the item to send */
	item.type = SK_INT64;
	item.it_int64 = value;
	item.it_addr = NULL;
	
	/* send the request */
	send_dmpitem_request(&item);
}

/* send a real value to the application */
rt_public void send_real_value(EIF_REAL_32 value)
{
	struct item item;
	
	/* fill in the item to send */
	item.type = SK_REAL32;
	item.it_real32 = value;
	item.it_addr = NULL;
	
	/* send the request */
	send_dmpitem_request(&item);
}

/* send a double value to the application */
rt_public void send_double_value(EIF_REAL_64 value)
{
	struct item item;
	
	/* fill in the item to send */
	item.type = SK_REAL64;
	item.it_real64 = value;
	item.it_addr = NULL;
	
	/* send the request */
	send_dmpitem_request(&item);
}

/* send a char value to the application */
rt_public void send_char_value(EIF_CHARACTER value)
{
	struct item item;
	
	/* fill in the item to send */
	item.type = SK_CHAR;
	item.it_char = value;
	item.it_addr = NULL;
	
	/* send the request */
	send_dmpitem_request(&item);
}

/* send a boolean value to the application */
rt_public void send_bool_value(EIF_BOOLEAN value)
{
	struct item item;
	
	/* fill in the item to send */
	item.type = SK_BOOL;
	item.it_char = value;
	item.it_addr = NULL;
	
	/* send the request */
	send_dmpitem_request(&item);
}

/* send a reference value to the application */
rt_public void send_ref_value(EIF_REFERENCE value)
{
	struct item item;
	
	/* fill in the item to send */
	item.type = SK_REF;
	item.it_ref = value;
	item.it_addr = NULL;
	
	/* send the request */
	send_dmpitem_request(&item);
}

/* send a pointer value to the application */
rt_public void send_ptr_value(EIF_POINTER value)
{
	struct item item;
	
	/* fill in the item to send */
	item.type = SK_POINTER;
	item.it_ptr = value;
	item.it_addr = NULL;
	
	/* send the request */
	send_dmpitem_request(&item);
}

/* send a string to the application */
rt_public void send_string_value(char* string)
{
	struct item item;
	
	/* fill in the item to send */
	item.type = SK_STRING;
	item.it_ref = string;
	item.it_addr = NULL;
	
	/* send the request */
	send_dmpitem_request(&item);
}

/* send a bit value to the application */
rt_public void send_bit_value(char *value)
{
	struct item item;
	
	/* fill in the item to send */
	item.type = SK_BIT;
	item.it_bit = value;
	item.it_addr = NULL;
	
	/* send the request */
	send_dmpitem_request(&item);
}

rt_public EIF_BOOLEAN recv_ack (void)
{
	Request pack;
#ifndef EIF_WINDOWS
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

	Request_Clean (pack);
#ifdef EIF_WINDOWS
	if (-1 == recv_packet(sp, &pack, TRUE))
#else
	if (-1 == recv_packet(readfd(sp), &pack))
#endif
		return (EIF_BOOLEAN) 0;


#ifdef USE_ADD_LOG
    add_log(100, "receiving request : %ld for ec", pack.rq_type);
#endif

	switch (pack.rq_type) {
	case ACKNLGE:

#ifdef USE_ADD_LOG
	    add_log(100, "acknowledge request : %ld for ec", pack.rq_ack.ak_type);
#endif
		switch (pack.rq_ack.ak_type) {
		case AK_OK:
			return (EIF_BOOLEAN) 1;
		case AK_ERROR:
			return (EIF_BOOLEAN) 0;
		default:
			return (EIF_BOOLEAN) 0;
		}
	default:
		return (EIF_BOOLEAN) 0;
	}
}

rt_public EIF_BOOLEAN recv_dead (void)
{
		/* Wait for a message saying that the application is dead */

	Request pack;
#ifndef EIF_WINDOWS
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

	Request_Clean (pack);
#ifdef EIF_WINDOWS
	if (-1 == recv_packet(sp, &pack, TRUE))
#else
	if (-1 == recv_packet(readfd(sp), &pack))
#endif
		return (EIF_BOOLEAN) 0;

#ifdef USE_ADD_LOG
    add_log(100, "receiving request : %ld for ec", pack.rq_type);
#endif

#ifdef EIF_WINDOWS
	stop_timer ();
#endif

	switch (pack.rq_type) {
	case DEAD:
		return (EIF_BOOLEAN) 1;
	default:
		return (EIF_BOOLEAN) 0;
	}
}

rt_public void c_send_str (char *s)
{
#ifndef EIF_WINDOWS
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

	send_str (sp, s);
}

rt_public void c_twrite (char *s, long int l)
{
	twrite (s, (int) l);
}

EIF_REFERENCE c_tread (void)
{

	int size;
	char *str;
	EIF_REFERENCE e_str;

	str = tread (&size);
	e_str = (EIF_REFERENCE) makestr (str, size);
	return e_str;
}

#ifdef EIF_WINDOWS
rt_public void send_simple_request(long code)
{
	/* Send the simple request specified by code */

	Request rqst;

	Request_Clean (rqst);
	rqst.rq_type = code;
	send_packet(sp, &rqst);
}
#endif

rt_public int async_shell(char *cmd)
{
	/* Send a shell command to be performed in the background and return the
	 * job number of the request. The daemon will fork and execute the command,
	 * then send the command status.
	 */

	return background(cmd);
}

rt_public void send_run_request(long int code, char *buf, long int len)
{
/*
	Request rqst;
#ifndef EIF_WINDOWS
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

	Request_Clean (rqst);
	rqst.rq_type = code;

#ifdef EIF_WINDOWS
	if (-1 == send_packet (sp, &rqst))
#else
	if (-1 == send_packet (writefd(sp), &rqst))
#endif
		error

	? = twrite (buf, size);

	ACK ???
*/
}

void request_dump (int elem_nb) {
		/* Retrieve the elem_nb first elements from the call stack. *
		 * Passing -1 retrieves the whole call stack. */
	send_rqst_1 (DUMP, elem_nb);
}

