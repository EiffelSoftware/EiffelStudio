/*

  #####  #####     ##    #    #   ####   ######  ######  #####            ####
    #    #    #   #  #   ##   #  #       #       #       #    #          #    #
    #    #    #  #    #  # #  #   ####   #####   #####   #    #          #
    #    #####   ######  #  # #       #  #       #       #####    ###    #
    #    #   #   #    #  #   ##  #    #  #       #       #   #    ###    #    #
    #    #    #  #    #  #    #   ####   #       ######  #    #   ###     ####

	Transfer routines between ewb and app via ised.
*/

#include "config.h"
#include "portable.h"
#include <sys/types.h>
#include "logfile.h"
#include "shared.h"
#include "transfer.h"
#include "request.h"
#include "stream.h"
#include <stdio.h>				/* To get BUFSIZ */

rt_private STREAM *sp;				/* Stream used for communications */

extern Malloc_t malloc();		/* Memory allocation */

rt_public void tpipe(stream)
STREAM *stream;
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

rt_public char *tread(size)
int *size;		/* Filled in with size of read string */
{
	/* Read bytes from the "pipe" and put them into a new allocated buffer.
	 * Returns the address of that buffer or a null pointer in case of errors.
	 */

	Request rqst;		/* Leading request */
	char *buffer;		/* Where bytes are stored */

	Request_Clean (rqst);
#ifdef DEBUG
#ifdef USE_ADD_LOG
	add_log(20, "waiting for leading request on #%d", readfd(sp));
#endif
#endif

	/* The first request gives us the amount of bytes we have to expect */
	if (-1 == recv_packet(readfd(sp), &rqst)) {
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
		swallow(readfd(sp), rqst.rq_ack.ak_type);
		if (size != (int *) 0)
			*size = 0;
		return (char *) 0;
	}

	if (-1 == net_recv(readfd(sp), buffer, rqst.rq_ack.ak_type)) {
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

rt_public int twrite(buffer, size)
char *buffer;
int size;
{
	/* Write 'size' bytes held in 'buffer' into the "pipe". Return the number
	 * of bytes effectively written or -1 if an error occured.
	 */

	Request rqst;		/* Leading request */

	Request_Clean (rqst);
	rqst.rq_type = TRANSFER;
	rqst.rq_ack.ak_type = size;

#ifdef DEBUG
#ifdef USE_ADD_LOG
	add_log(20, "sending leading request on #%d", writefd(sp));
#endif
#endif

	send_packet(writefd(sp), &rqst);

#ifdef DEBUG
#ifdef USE_ADD_LOG
	add_log(20, "sending %d bytes to remote process", size);
#endif
#endif

	return net_send(writefd(sp), buffer, size);
}

rt_public void swallow(fd, size)
int fd;
int size;
{
	/* Swallow 'size' bytes from 'fd' and discard them */

	char buf[BUFSIZ];
	int amount;

	while (size > 0) {
		amount = size;
		if (amount > BUFSIZ)
			amount = BUFSIZ;
		if (-1 == net_recv(fd, buf, amount))
			return;
		size -= amount;
	}
}

