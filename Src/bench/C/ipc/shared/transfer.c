/*

  #####  #####     ##    #    #   ####   ######  ######  #####            ####
    #    #    #   #  #   ##   #  #       #       #       #    #          #    #
    #    #    #  #    #  # #  #   ####   #####   #####   #    #          #
    #    #####   ######  #  # #       #  #       #       #####    ###    #
    #    #   #   #    #  #   ##  #    #  #       #       #   #    ###    #    #
    #    #    #  #    #  #    #   ####   #       ######  #    #   ###     ####

	Transfer routines between ewb and app via ised.
*/

#include "eif_config.h"
#include "eif_portable.h"
#include <sys/types.h>
#include "eif_logfile.h"
#include "shared.h"
#include "com.h"
#include "transfer.h"
#include "request.h"
#include "stream.h"
#include <stdio.h>				/* To get BUFSIZ */
#include <string.h>

#ifdef EIF_WIN32
rt_public STREAM *sp;				/* Stream used for communications */
#else
rt_private STREAM *sp;				/* Stream used for communications */
#endif

extern Malloc_t malloc(register unsigned int nbytes);		/* Memory allocation */

rt_public void tpipe(STREAM *stream)
{
	/* Initialize the file descriptor to be used in data exchanges with the
	 * remote process. This enables us to omit this parameter whenever an I/O
	 * with the remote process has to be made.
	 */

	sp = stream;

#ifdef DEBUG
#ifdef USE_ADD_LOG
	add_log(20, "stream set up as (rd = #%d, wr = #%d)",
		readfd(sp), writefd(sp));
#endif
#endif
}

rt_public char *tread(int *size)
          		/* Filled in with size of read string */
{
	/* Read bytes from the "pipe" and put them into a new allocated buffer.
	 * Returns the address of that buffer or a null pointer in case of errors.
	 */

	Request rqst;		/* Leading request */
	char *buffer;		/* Where bytes are stored */

	Request_Clean (rqst);
#ifdef DEBUG
#ifdef USE_ADD_LOG
#ifdef EIF_WIN32
	add_log(20, "waiting for leading request on #%d", sp);
#else
	add_log(20, "waiting for leading request on #%d", readfd(sp));
#endif
#endif
#endif

	/* The first request gives us the amount of bytes we have to expect */
#ifdef EIF_WIN32
	if (-1 == recv_packet(sp, &rqst, TRUE)) {
#else
	if (-1 == recv_packet(readfd(sp), &rqst)) {
#endif
#ifdef USE_ADD_LOG
		add_log(1, "ERROR cannot receive transfer request");
#endif
		if (size != (int *) 0)
			*size = 0;
		return (char *) 0;
	}

#ifdef DEBUG
#ifdef USE_ADD_LOG
	add_log(20, "expecting %d bytes from remote process", rqst.rq_ack.ak_type);
#endif
#endif

	buffer = (char *) malloc(rqst.rq_ack.ak_type);
	if (buffer == (char *) 0) {
#ifdef USE_ADD_LOG
		add_log(1, "ERROR cannot allocate %d bytes", rqst.rq_ack.ak_type);
#endif
#ifdef EIF_WIN32
		swallow(sp, rqst.rq_ack.ak_type);
#else
		swallow(readfd(sp), rqst.rq_ack.ak_type);
#endif
		if (size != (int *) 0)
			*size = 0;
		return (char *) 0;
	}

#ifdef EIF_WIN32
#ifdef USE_ADD_LOG
	add_log(9, "expecting %d bytes from remote process", rqst.rq_ack.ak_type);
#endif

	if (-1 == net_recv(sp, buffer, rqst.rq_ack.ak_type, TRUE)) {
#else
	if (-1 == net_recv(readfd(sp), buffer, rqst.rq_ack.ak_type)) {
#endif
#ifdef USE_ADD_LOG
		add_log(1, "ERROR net_recv: %m (%e)");
#endif
		free(buffer);
		if (size != (int *) 0)
			*size = 0;
		return (char *) 0;
	}

	if (size != (int *) 0)
		*size = (int) rqst.rq_ack.ak_type;

	return buffer;
}

rt_public int twrite(void *buffer, int size)
{
	/* Write 'size' bytes held in 'buffer' into the "pipe". Return the number
	 * of bytes effectively written or -1 if an error occurred.
	 */

	Request rqst;		/* Leading request */
	int t;

	Request_Clean (rqst);
	rqst.rq_type = TRANSFER;
	rqst.rq_ack.ak_type = size;

#ifdef DEBUG
#ifdef USE_ADD_LOG
	add_log(20, "sending leading request on #%d", writefd(sp));
#endif
#endif

#ifdef EIF_WIN32
	send_packet(sp, &rqst);
#else
	send_packet(writefd(sp), &rqst);
#endif

#ifdef DEBUG
#ifdef USE_ADD_LOG
	add_log(20, "sending %d bytes to remote process", size);
#endif
#endif

#ifdef EIF_WIN32
	t = net_send(sp, buffer, size);
#ifdef USE_ADD_LOG
	add_log(20, "net_send was %d", t);
#endif
#else
	t = net_send(writefd(sp), buffer, size);
#endif

	return t;
}

#ifdef EIF_WIN32
rt_public void swallow(STREAM *fd, int size)
#else
rt_public void swallow(int fd, int size)
#endif
{
	/* Swallow 'size' bytes from 'fd' and discard them */

	char buf[BUFSIZ];
	int amount;

	while (size > 0) {
		amount = size;
		if (amount > BUFSIZ)
			amount = BUFSIZ;
#ifdef EIF_WIN32
		if (-1 == net_recv(fd, buf, amount, TRUE))
#else
		if (-1 == net_recv(fd, buf, amount))
#endif
			return;
		size -= amount;
	}
}
