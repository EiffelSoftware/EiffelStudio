/*

  ####    ####   #    #           ####
 #    #  #    #  ##  ##          #    #
 #       #    #  # ## #          #
 #       #    #  #    #   ###    #
 #    #  #    #  #    #   ###    #    #
  ####    ####   #    #   ###     ####

	Common protocol routines. Those routines are based on the following
	external calls:

	send_packet(int s, Request *pack) to send an XDR packet.
	recv_packet(int s, Request *pack) to receive an XDR packet.
	net_send(int s, char *buffer, int length) to send raw data.
	net_recv(int s, char *buffer, int length) to receive raw data.
	add_log(int level, char *msg) to print an error message.
	dexit(int status) to disconnect with the provided status.
*/

#include "config.h"
#include "portable.h"
#include "request.h"
#include "com.h"
#include "stream.h"

#define GRACETIME	5	/* Number of seconds to wait before immediate exit */
#define MAX_STRING	512	/* Maximum string length for log messages */

extern Malloc_t malloc(register unsigned int nbytes);	/* Memory allocation */

/* VARARGS2 */
rt_public void send_bye(int s, int code)
      		/* The socket descriptor */
         	/* The acknowledgment code */
{
	/* Send a final acknowledgement report and wait some time to ensure the
	 * client will receive the message. Then exit properly.
	 */

	send_ack(s, code);			/* Send error message back */
	sleep(GRACETIME);			/* Ensure client receives message */
	dexit(0);					/* Disconnect immediately */
}

/* VARARGS2 */
rt_public void send_ack(int s, int code)
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
	add_log(100, "sending ack %d on pipe %d", code, s);
#endif
	send_packet(s, &pack);
}

rt_public void send_info(int s, int code)
      		/* The socket descriptor */
         		/* The information code */
{
		/* Send an information report specified by code. */

	Request rqst;

	Request_Clean (rqst);
	rqst.rq_type = code;
	send_packet(s, &rqst);
}

rt_public int send_str(STREAM *sp, char *buffer)
           		/* The stream descriptor */
             	/* Where the string is held */
{
	/* Send the string held in the buffer to the remote process and return
	 * 0 if ok, -1 if the string was not sent.
	 */

	Request pack;			/* The request */
	int size;				/* Size of the string (without final null) */

	/* Here is the protocol used to send the string: the size of the string
	 * is sent as an opaque data structure (field op_size). If the length
	 * is zero, then that's all. Otherwise the remote process attempts to
	 * allocate enough room to receive the string. So we wait for the remote
	 * acknowledgment. If ok, we send the string. Otherwise we abort with a
	 * P_NOMEM status.
	 */

	Request_Clean (pack);
	size = strlen(buffer);			/* Length of string */
	pack.rq_type = EIF_OPAQUE;
	pack.rq_opaque.op_size = size;	/* Send length without final null */


#ifdef USE_ADD_LOG
        add_log(100, "sending string of size %d", size);
#endif

	send_packet(writefd(sp), &pack);	/* Send the length */

	if (size == 0)					/* Null-length string */
		return 0;

	/* Wait for the acknowledgment */
	if (-1 == recv_packet(readfd(sp), &pack))
		return -1;

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
	
	if (-1 == net_send(writefd(sp), buffer, size))
		return -1;

	return 0;		/* Ok, string was sent */
}

rt_public char *recv_str(STREAM *sp, int *sizeptr)
           		/* The STREAM pointer */
             	/* Set to the size of the string if non null pointer */
{
	/* Receive a string from socket. We return the address of the malloc'ed
	 * zone where string was stored and optionnally we set the size to the
	 * variable pointed to by 'sizeptr', if it is not a null pointer. If we
	 * cannot receive the string, a null pointer is returned.
	 */
	
	Request pack;			/* The XDR request structure */
	int size;				/* Size of the string without final null byte */
	char *buffer;			/* Where string is allocated */

	/* The protocol used here is the symetric of the one used by send_str() */

	Request_Clean (pack);
	if (-1 == recv_packet(readfd(sp), &pack))	/* Wait for length */
		return (char *) 0;

	size = pack.rq_opaque.op_size;			/* Fetch string's length */
	if (sizeptr != (int *) 0)				/* Fill in size pointer */
		*sizeptr = size;

	if (size == 0) {						/* Nothing to be received */
		if (sizeptr != (int *) 0)			/* Fill in size with 0 */
			*sizeptr = 0;
		return (char *) 0;
	}

	buffer = (char *) malloc(size + 1);		/* Null byte not included */
	if (buffer == (char *) 0) {				/* Unable to allocate memory */
		send_ack(writefd(sp), AK_ERROR);	/* Signal error to remote process */
		return (char *) 0;
	} else
		send_ack(writefd(sp), AK_OK);		/* Ready to get string */

	if (-1 == net_recv(readfd(sp), buffer, size)) {	/* Cannot receive string */
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
		sprintf(buf, "EIF_OPAQUE [%d, %d, %d]",
			rqst->rq_opaque.op_type,
			rqst->rq_opaque.op_cmd,
			rqst->rq_opaque.op_size);
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
		sprintf(buf, "default");
	}

#ifdef USE_ADD_LOG
	add_log(20, "%s request %s", status, buf);
#endif
}
#endif

