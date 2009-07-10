/*
	description: "[
			Common protocol routines. Those routines are based on the following
			external calls:
		
			send_packet(int s, Request *pack) to send an XDR packet.
			recv_packet(int s, Request *pack) to receive an XDR packet.
			net_send(int s, char *buffer, int length) to send raw data.
			net_recv(int s, char *buffer, int length) to receive raw data.
			add_log(int level, char *msg) to print an error message.
			dexit(int status) to disconnect with the provided status.
			]"
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

#include "eif_config.h"
#include "eif_portable.h"
#include "request.h"
#include "com.h"
#include "stream.h"
#include "eif_logfile.h"
#include <string.h>
#include "rt_assert.h"

#ifndef EIF_WINDOWS
#include <unistd.h>
#endif

#define GRACETIME	5	/* Number of seconds to wait before immediate exit */
#define MAX_STRING	512	/* Maximum string length for log messages */

/*
 * Registered send_packet and recv_packet functions management ... 
 */

typedef struct {				/* Daemon flags (protocol with client) */
	EIF_PSTREAM sp;
	void (*p_send_fct)(EIF_PSTREAM, Request*);
#ifdef EIF_WINDOWS
	int  (*p_recv_fct)(EIF_PSTREAM, Request*, BOOL) ;
#else
	int  (*p_recv_fct)(EIF_PSTREAM, Request*);
#endif
} send_recv_fct_by_sp;

rt_private send_recv_fct_by_sp* registered_send_recv_fct_data[3]; /* Max is 3 */
rt_private int registered_send_recv_fct_data_max = 3;
rt_private send_recv_fct_by_sp* send_recv_fct_data_for (EIF_PSTREAM sp)
{
	int i;
	for (i = 0; i < registered_send_recv_fct_data_max; i++) {
		if (registered_send_recv_fct_data[i] != NULL
			&& registered_send_recv_fct_data[i]->sp == sp) 
		{
			return registered_send_recv_fct_data[i];
		};
	}
	return NULL;
}


rt_public void unregister_packet_functions (EIF_PSTREAM sp)
{
	int i;
	for (i = 0; i < registered_send_recv_fct_data_max; i++) {
		if (registered_send_recv_fct_data[i] != NULL
			&& registered_send_recv_fct_data[i]->sp == sp) 
		{
			registered_send_recv_fct_data[i] = NULL;
			break;
		}
	}
	return;
}

rt_public void register_packet_functions (EIF_PSTREAM sp, void(*p_send_fct)(EIF_PSTREAM, Request*) , 
#ifdef EIF_WINDOWS
			int (*p_recv_fct)(EIF_PSTREAM, Request*, BOOL) 
#else
			int (*p_recv_fct)(EIF_PSTREAM, Request*)
#endif
		) 
{
	int i;
	send_recv_fct_by_sp *p_data;
	REQUIRE("valid stream", sp != NULL);
	p_data = send_recv_fct_data_for (sp);
	if (p_data == NULL) {
		for (i = 0; i < registered_send_recv_fct_data_max; i++) {
			if (registered_send_recv_fct_data[i] == NULL) {
				p_data = (send_recv_fct_by_sp*) malloc (sizeof(send_recv_fct_by_sp));
				registered_send_recv_fct_data[i] = p_data;
				break;
			};
		}
	}
	CHECK("p_data not null", p_data);
	p_data->sp = sp;
	p_data->p_send_fct = p_send_fct;
	p_data->p_recv_fct = p_recv_fct;
	return;
}

rt_public void send_packet(EIF_PSTREAM sp, Request *rqst)
      				/* The connected socket */
              		/* The request to be sent */
{
	send_recv_fct_by_sp* p_data;
	REQUIRE("valid stream", sp != NULL);
	p_data = send_recv_fct_data_for (sp);
	CHECK("valid index", p_data != NULL);
	(*p_data->p_send_fct)(sp, rqst);
	return;
}

#ifdef EIF_WINDOWS
rt_public int recv_packet(EIF_PSTREAM sp, Request *dans , BOOL reset)
#else
rt_public int recv_packet(EIF_PSTREAM sp, Request *dans)
#endif
      				/* The connected socket */
              		/* The daemon's answer */
{
	send_recv_fct_by_sp* p_data;
	p_data = send_recv_fct_data_for (sp);
	CHECK("valid index", p_data != NULL);
#ifdef EIF_WINDOWS
	return (*p_data->p_recv_fct)(sp, dans, reset);
#else
	return (*p_data->p_recv_fct)(sp, dans);
#endif
}

/* VARARGS2 */
rt_public void send_bye(EIF_PSTREAM sp, int code)
      		/* The socket descriptor */
         	/* The acknowledgment code */
{
	/* Send a final acknowledgement report and wait some time to ensure the
	 * client will receive the message. Then exit properly.
	 */

	send_ack(sp, code);			/* Send error message back */
#ifdef EIF_WINDOWS
	Sleep (GRACETIME * 1000);			/* Ensure client receives message */
#else
	sleep(GRACETIME);			/* Ensure client receives message */
#endif
	dexit(0);					/* Disconnect immediately */
}

/* VARARGS2 */
rt_public void send_ack(EIF_PSTREAM sp, int code)
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
	pack.rq_ack.ak_type = code;			/* Report code */

#ifdef USE_ADD_LOG
	add_log(100, "sending ack %d on pipe %d", code, writefd (sp));
#endif
	send_packet(sp, &pack);
}

rt_public void send_info(EIF_PSTREAM sp, int code)
      		/* The socket descriptor */
         		/* The information code */
{
		/* Send an information report specified by code. */

	Request rqst;

	Request_Clean (rqst);
	rqst.rq_type = code;
	send_packet(sp, &rqst);
}

rt_public int send_sized_str(EIF_PSTREAM sp, char *buffer, int size)
           		/* The stream descriptor */
             	/* Where the string is held */
{
	/* Send the string held in the buffer to the remote process and return
	 * 0 if ok, -1 if the string was not sent.
	 */

	Request pack;			/* The request */

	/* Here is the protocol used to send the string: the size of the string
	 * is sent as an opaque data structure (field op_size). If the length
	 * is zero, then that's all. Otherwise the remote process attempts to
	 * allocate enough room to receive the string. So we wait for the remote
	 * acknowledgment. If ok, we send the string. Otherwise we abort with a
	 * P_NOMEM status.
	 */

	Request_Clean (pack);
	pack.rq_type = EIF_OPAQUE;
	CHECK("valid size", size <= INT32_MAX);
	pack.rq_opaque.op_size = size;	/* Send length without final null */

#ifdef USE_ADD_LOG
        add_log(100, "sending string of size %d", size);
#endif

	send_packet(sp, &pack);	/* Send the length */

	if (size == 0) {					/* Null-length string */
		return 0;
	}

	/* Wait for the acknowledgment */
#ifdef EIF_WINDOWS
	if (-1 == recv_packet(sp, &pack, TRUE))
#else
	if (-1 == recv_packet(sp, &pack))
#endif
	{
		return -1;
	}

	/* Analyze the acknowledgment received */
	switch (pack.rq_type) {
	case ACKNLGE:
		switch (pack.rq_ack.ak_type) {
		case AK_OK:					/* Ok, we may proceed */
			break;
		case AK_ERROR:				/* Remote process is out of memory */
			return -1;
		default:					/* Protocol error */
			return -1;
		}
		break;
	default:
		return -1;
	}

	/* If we come here, then the remote process is ready to swallow the string.
	 * Send it and as TCP/IP is a reliable protocol, there is no need to wait
	 * for another acknowledgment.
	 */

	if (-1 == net_send(sp, buffer, size))
	{
		return -1;
	}

	return 0;		/* Ok, string was sent */
}

rt_public int send_str(EIF_PSTREAM sp, char *buffer)
           		/* The stream descriptor */
             	/* Where the string is held */
{
	/* Send the string held in the buffer to the remote process and return
	 * 0 if ok, -1 if the string was not sent.
	 */

	size_t size;				/* Size of the string (without final null) */
	size = strlen(buffer);			/* Length of string */
	return send_sized_str (sp, buffer, (int) size);
}

rt_public char *recv_str(EIF_PSTREAM sp, size_t *sizeptr)
           		/* The STREAM pointer */
             	/* Set to the size of the string if non null pointer */
{
	/* Receive a string from socket. We return the address of the malloc'ed
	 * zone where string was stored and optionnally we set the size to the
	 * variable pointed to by 'sizeptr', if it is not a null pointer. If we
	 * cannot receive the string, a null pointer is returned.
	 */

	Request pack;			/* The XDR request structure */
	size_t size;				/* Size of the string without final null byte */
	char *buffer;			/* Where string is allocated */

	/* The protocol used here is the symetric of the one used by send_str() */

	Request_Clean (pack);
#ifdef EIF_WINDOWS
	if (-1 == recv_packet(sp, &pack, TRUE))	/* Wait for length */
#else
	if (-1 == recv_packet(sp, &pack))	/* Wait for length */
#endif
	{
		return (char *) 0;
	}

	size = pack.rq_opaque.op_size;			/* Fetch string's length */
	if (sizeptr) {
			/* Fill in size pointer */
		*sizeptr = size;
	}

	if (size == 0) {						/* Nothing to be received */
		return (char *) 0;
	}

	buffer = (char *) malloc(size + 1);		/* Null byte not included */
	if (buffer == (char *) 0) {				/* Unable to allocate memory */
		send_ack(sp, AK_ERROR);	/* Signal error to remote process */
		return (char *) 0;
	} else {
		send_ack(sp, AK_OK);		/* Ready to get string */
	}

#ifdef EIF_WINDOWS
	if (-1 == net_recv(sp, buffer, size, TRUE))
#else
	if (-1 == net_recv(sp, buffer, size)) 	
#endif
	{
		/* Cannot receive string */
		free(buffer);
		return (char *) 0;
	}

	buffer[size] = '\0';		/* Ensure null terminated string */

	return buffer;
}

#ifdef DEBUG
rt_public void trace_request(char *status, Request *rqst)
{
	/* Dump the request received in the log file */

	char message[MAX_STRING];
	char buf[MAX_STRING];

	switch (rqst->rq_type) {
	case EIF_OPAQUE:
		sprintf(buf, "EIF_OPAQUE [%d, %d, %d, %d]",
			rqst->rq_opaque.op_type,
			rqst->rq_opaque.op_cmd,
			rqst->rq_opaque.op_size,
			rqst->rq_opaque.op_info);
		break;
	case ACKNLGE:
		switch (rqst->rq_ack.ak_type) {
		case AK_OK:
			sprintf(message, "AK_OK");
			break;
		case AK_ERROR:
			sprintf(message, "AK_ERROR");
			break;
		}
		sprintf(buf, "ACKNLGE [%s]", message);
		break;
	default:
#ifdef EIF_WINDOWS
		sprintf(buf, "default %d", rqst->rq_type);
#else
		sprintf(buf, "default");
#endif
	}

#ifdef USE_ADD_LOG
	add_log(20, "%s request %s", status, buf);
#endif
}
#endif
