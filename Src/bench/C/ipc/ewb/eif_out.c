/*

 ######     #    ######           ####   #    #   #####           ####
 #          #    #               #    #  #    #     #            #    #
 #####      #    #####           #    #  #    #     #            #
 #          #    #               #    #  #    #     #     ###    #
 #          #    #               #    #  #    #     #     ###    #    #
 ######     #    #      #######   ####    ####      #     ###     ####

	Externals for dealing with sent (outgoing) requests.
*/

#include "eif_io.h"
#include "eif_eiffel.h"
#include "eproto.h"

#include "stack.h"

#ifdef EIF_WIN32
#include "stream.h"
extern STREAM *sp;
extern void start_timer(void);			/* Starts the timer for communication */
extern void stop_timer(void);			/* Stops the timer */
#endif

rt_public void send_rqst_0 (long int code)
{
	Request rqst;
#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

#ifdef USE_ADD_LOG
    add_log(100, "sending request 0: %ld from es4", code);
#endif

#ifdef EIF_WIN32
	if (code == APPLICATION)
		start_timer();
#endif

	Request_Clean (rqst);
	rqst.rq_type = (int) code;

#ifdef EIF_WIN32
	send_packet(sp, &rqst);
#else
	send_packet(writefd(sp), &rqst);
#endif
}

rt_public void send_rqst_1 (long int code, long int info1)
{
	Request rqst;
#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

#ifdef USE_ADD_LOG
    add_log(100, "sending request 1: %ld from es4", code);
#endif
	Request_Clean (rqst);
	rqst.rq_type = (int) code;
	rqst.rq_opaque.op_first = (int) info1;

#ifdef EIF_WIN32
	send_packet(sp, &rqst);
#else
	send_packet(writefd(sp), &rqst);
#endif
}

rt_public void send_rqst_2 (long int code, long int info1, long int info2)
{
	Request rqst;
#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

#ifdef USE_ADD_LOG
    add_log(100, "sending request 2: %ld from es4", code);
#endif

	Request_Clean (rqst);
	rqst.rq_type = (int) code;
	rqst.rq_opaque.op_first = (int) info1;
	rqst.rq_opaque.op_second = (int) info2;

#ifdef EIF_WIN32
	send_packet(sp, &rqst);
#else
	send_packet(writefd(sp), &rqst);
#endif
}

rt_public void send_rqst_3 (long int code, long int info1, long int info2, long int info3)
{
	Request rqst;
#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

#ifdef USE_ADD_LOG
    add_log(100, "sending request 3: %ld from es4", code);
#endif

	Request_Clean (rqst);
	rqst.rq_type = (int) code;
	rqst.rq_opaque.op_first = (int) info1;
	rqst.rq_opaque.op_second = (int) info2;
	rqst.rq_opaque.op_third = (long) info3;

#ifdef EIF_WIN32
	send_packet(sp, &rqst);
#else
	send_packet(writefd(sp), &rqst);
#endif
}

rt_public EIF_BOOLEAN recv_ack (void)
{
	Request pack;
#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

	Request_Clean (pack);
#ifdef EIF_WIN32
	if (-1 == recv_packet(sp, &pack, TRUE))
#else
	if (-1 == recv_packet(readfd(sp), &pack))
#endif
		return (EIF_BOOLEAN) 0;


#ifdef USE_ADD_LOG
    add_log(100, "receiving request : %ld for es4", pack.rq_type);
#endif

	switch (pack.rq_type) {
	case ACKNLGE:

#ifdef USE_ADD_LOG
	    add_log(100, "acknowledge request : %ld for es4", pack.rq_ack.ak_type);
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
#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

	Request_Clean (pack);
#ifdef EIF_WIN32
	if (-1 == recv_packet(sp, &pack, TRUE))
#else
	if (-1 == recv_packet(readfd(sp), &pack))
#endif
		return (EIF_BOOLEAN) 0;

#ifdef USE_ADD_LOG
    add_log(100, "receiving request : %ld for es4", pack.rq_type);
#endif

#ifdef EIF_WIN32
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
#ifndef EIF_WIN32
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
	free (str);
	return e_str;
}

#ifdef EIF_WIN32
rt_public void send_simple_request(code)
long code;		/* Request type */
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
#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

	Request_Clean (rqst);
	rqst.rq_type = code;

#ifdef EIF_WIN32
	if (-1 == send_packet (sp, &rqst))
#else
	if (-1 == send_packet (writefd(sp), &rqst))
#endif
		error

	? = twrite (buf, size);

	ACK ???
*/
}

void request_dump (void) {
	send_rqst_1 (DUMP, 2L /* ST_FULL */);
}

