/*
	description: "Externals for dealing with sent (outgoing) requests."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2013, Eiffel Software."
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
#include "eif_out.h"
#include "eif_eiffel.h"
#include "eproto.h"
#include "eif_logfile.h" /* for add_log() */

#include "stack.h"
#include "stream.h"

#ifdef EIF_WINDOWS
extern void start_timer(void);			/* Starts the timer for communication */
extern void stop_timer(void);			/* Stops the timer */
#endif

/* forward definitions */
rt_private void send_dmpitem_request(EIF_TYPED_VALUE *ip, int a_info);

rt_public void send_rqst_0 (long int code)
{
	Request rqst;

#ifdef USE_ADD_LOG
    add_log(100, "sending request 0: %ld from ec", code);
#endif

#ifdef EIF_WINDOWS
	if (code == APPLICATION || code == ATTACH) {
		start_timer();
	}
#endif

	Request_Clean (rqst);
	rqst.rq_type = (int) code;

	ewb_send_packet(ewb_sp, &rqst);
}

rt_public void send_rqst_1 (long int code, long int info1)
{
	Request rqst;

#ifdef USE_ADD_LOG
    add_log(100, "sending request 1: %ld from ec", code);
#endif
	Request_Clean (rqst);
	rqst.rq_type = (int) code;
	rqst.rq_opaque.op_1 = (int) info1;

	ewb_send_packet(ewb_sp, &rqst);
}

rt_public void send_rqst_2 (long int code, long int info1, long int info2)
{
	Request rqst;

#ifdef USE_ADD_LOG
    add_log(100, "sending request 2: %ld from ec", code);
#endif

	Request_Clean (rqst);
	rqst.rq_type = (int) code;
	rqst.rq_opaque.op_1 = (int) info1;
	rqst.rq_opaque.op_2 = (int) info2;

	ewb_send_packet(ewb_sp, &rqst);
}

rt_public void send_rqst_3 (long int code, long int info1, long int info2, rt_uint_ptr info3)
{
	Request rqst;

#ifdef USE_ADD_LOG
    add_log(100, "sending request 3: %ld from ec", code);
#endif

	Request_Clean (rqst);
	rqst.rq_type = (int) code;
	rqst.rq_opaque.op_1 = (int) info1;
	rqst.rq_opaque.op_2 = (int) info2;
	rqst.rq_opaque.op_3 = info3;

	ewb_send_packet(ewb_sp, &rqst);
}

rt_public void send_rqst_4 (long int code, long int info1, long int info2, rt_uint_ptr info3, long int info4)
{
	Request rqst;

#ifdef USE_ADD_LOG
    add_log(100, "sending request 3: %ld from ec", code);
#endif

	Request_Clean (rqst);
	rqst.rq_type = (int) code;
	rqst.rq_opaque.op_1 = (int) info1;
	rqst.rq_opaque.op_2 = (int) info2;
	rqst.rq_opaque.op_3 = info3;
	rqst.rq_opaque.op_4 = (int) info4;

	ewb_send_packet(ewb_sp, &rqst);
}

rt_private void send_dmpitem_request(EIF_TYPED_VALUE *ip, int a_info)
{
	Request rqst;

#ifdef USE_ADD_LOG
    add_log(100, "sending specific request: %d from ec", DUMPED);
#endif

	/* prepare the request to send */
	Request_Clean (rqst);
	rqst.rq_type = DUMPED;
	rqst.rq_dump.dmp_type = DMP_ITEM;
	rqst.rq_dump.dmp_item = ip;
	rqst.rq_dump.dmp_info = a_info;

	/* send the request */
	ewb_send_packet(ewb_sp, &rqst);
}

/* send an integer_8 value to the application */
rt_public void send_integer_8_value(EIF_INTEGER_8 value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_INT8;
	item.it_int8 = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send an integer value to the application */
rt_public void send_integer_16_value(EIF_INTEGER_16 value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_INT16;
	item.it_int16 = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send an integer value to the application */
rt_public void send_integer_32_value(EIF_INTEGER_32 value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_INT32;
	item.it_int32 = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send an integer_64 value to the application */
rt_public void send_integer_64_value(EIF_INTEGER_64 value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_INT64;
	item.it_int64 = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send an natural_8 value to the application */
rt_public void send_natural_8_value(EIF_NATURAL_8 value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_UINT8;
	item.it_uint8 = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send an natural value to the application */
rt_public void send_natural_16_value(EIF_NATURAL_16 value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_UINT16;
	item.it_uint16 = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send an natural value to the application */
rt_public void send_natural_32_value(EIF_NATURAL_32 value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_UINT32;
	item.it_uint32 = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send an natural_64 value to the application */
rt_public void send_natural_64_value(EIF_NATURAL_64 value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_UINT64;
	item.it_uint64 = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send a real 32 value to the application */
rt_public void send_real_32_value(EIF_REAL_32 value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_REAL32;
	item.it_real32 = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send a real 64 value to the application */
rt_public void send_real_64_value(EIF_REAL_64 value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_REAL64;
	item.it_real64 = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send a char value to the application */
rt_public void send_char_8_value(EIF_CHARACTER_8 value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_CHAR8;
	item.it_char = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send a wchar value to the application */
rt_public void send_char_32_value(EIF_CHARACTER_32 value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_CHAR32;
	item.it_wchar = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send a boolean value to the application */
rt_public void send_bool_value(EIF_BOOLEAN value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_BOOL;
	item.it_char = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send a reference value to the application */
rt_public void send_ref_value(EIF_REFERENCE value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_REF;
	item.it_ref = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send a reference+offset value to the application */
rt_public void send_ref_offset_value(EIF_REFERENCE value, EIF_NATURAL_32 a_offset)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_REF;
	item.it_ref = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send a pointer value to the application */
rt_public void send_ptr_value(EIF_POINTER value)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_POINTER;
	item.it_ptr = value;

	/* send the request */
	send_dmpitem_request(&item, 0);
}

/* send a string to the application */
rt_public void send_string_value(char* string, int a_size)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_STRING;
	item.it_ref = string;

	/* send the request */
	send_dmpitem_request(&item, a_size);
}

/* send a STRING_32 to the application */
rt_public void send_string_32_value(char* string, int a_size)
{
	EIF_TYPED_VALUE item;

	/* fill in the item to send */
	item.type = SK_STRING32;
	item.it_ref = string;

	/* send the request */
	send_dmpitem_request(&item, a_size);
}

/* send a bit value to the application */
rt_public void send_bit_value(char *value)
{
}

rt_public void ewb_send_ack_ok(void)
      		/* The socket descriptor */
         	/* The acknowledgment code */
{
	/* Send an acknowledgment report. In case it is a negative one, the error
	 * parameter gives some complementary informations. It is possible to
	 * omit the third parameters for AK_OK or AK_DENIED reports.
	 */

	Request pack;		/* The answer we'll send back */

	Request_Clean (pack);
	pack.rq_type = ACKNLGE;				/* We are sending an acknowledgment */
	pack.rq_ack.ak_type = AK_OK;		/* Report code */

#ifdef USE_ADD_LOG
	add_log(100, "sending ack %d on pipe %d", ACKNLGE, writefd(ewb_sp));
#endif
	ewb_send_packet (ewb_sp, &pack);
}

rt_public EIF_BOOLEAN recv_ack (void)
{
	Request pack;

	Request_Clean (pack);
#ifdef EIF_WINDOWS
	if (-1 == ewb_recv_packet(ewb_sp, &pack, TRUE))
#else
	if (-1 == ewb_recv_packet(ewb_sp, &pack))
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

rt_public EIF_BOOLEAN recv_dead (EIF_INTEGER* perr)
{
		/* Wait for a message saying that the application is dead */

	Request pack;

	Request_Clean (pack);
	*perr = 0;

#ifdef USE_ADD_LOG
    add_log(100, "in recv_dead ...");
#endif

#ifdef EIF_WINDOWS
	if (-1 == ewb_recv_packet(ewb_sp, &pack, TRUE))
#else
	if (-1 == ewb_recv_packet(ewb_sp, &pack))
#endif
	{
		*perr = -1;
		return (EIF_BOOLEAN) 0;
	}

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

rt_public void c_send_sized_str (char *s, int size)
{
	send_sized_str (ewb_sp, s, size);
}

rt_public void c_twrite (char *s, long int l)
{
	ewb_twrite (s, (int) l);
}

rt_public EIF_REFERENCE c_tread (void)
{

	int size;
	char *str;
	EIF_REFERENCE e_str;

	str = ewb_tread (&size);
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
	ewb_send_packet(ewb_sp, &rqst);
}
#endif
