/*
	description: "Transfer routines between ewb and app via ised."
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
#include <sys/types.h>
#include "eif_logfile.h"
#include "shared.h"
#include "com.h"
#include "transfer.h"
#include "request.h"
#include "stream.h"
#include <stdio.h>				/* To get BUFSIZ */
#include <string.h>
#include "rt_assert.h"

#ifdef EIF_WINDOWS
rt_shared STREAM *sp;				/* Stream used for communications */
#else
rt_private STREAM *sp;				/* Stream used for communications */
#endif
rt_private char* reading_buffer;		/* Buffer used for communication, grows as needed */
rt_private size_t allocated_buffer_size; 	/* Currently allocated size for buffer */

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

	Request_Clean (rqst);
#ifdef DEBUG
#ifdef USE_ADD_LOG
#ifdef EIF_WINDOWS
	add_log(20, "waiting for leading request on #%d", sp);
#else
	add_log(20, "waiting for leading request on #%d", readfd(sp));
#endif
#endif
#endif

	/* The first request gives us the amount of bytes we have to expect */
#ifdef EIF_WINDOWS
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
	
		/* + 1 to prevent errors if we need a 0-sized buffer and no buffer has been allocated yet */
	if (allocated_buffer_size < (size_t) rqst.rq_ack.ak_type + 1) {
			/* We need to allocate a bigger buffer */
		if (reading_buffer != NULL) free (reading_buffer);
		reading_buffer = (char *) malloc(rqst.rq_ack.ak_type + 1);
		allocated_buffer_size = rqst.rq_ack.ak_type + 1;
	}
		/* FIXME XR: Is this really needed?? If we can't allocate memory, we're really in deep trouble anyway */
	if (reading_buffer == (char *) 0) {
#ifdef USE_ADD_LOG
		add_log(1, "ERROR cannot allocate %d bytes", rqst.rq_ack.ak_type);
#endif
#ifdef EIF_WINDOWS
		swallow(sp, rqst.rq_ack.ak_type);
#else
		swallow(readfd(sp), rqst.rq_ack.ak_type);
#endif
		if (size != (int *) 0)
			*size = 0;
		return (char *) 0;
	}

#ifdef EIF_WINDOWS
#ifdef USE_ADD_LOG
	add_log(9, "expecting %d bytes from remote process", rqst.rq_ack.ak_type);
#endif

	if (-1 == net_recv(sp, reading_buffer, rqst.rq_ack.ak_type, TRUE)) {
#else
	if (-1 == net_recv(readfd(sp), reading_buffer, rqst.rq_ack.ak_type)) {
#endif
#ifdef USE_ADD_LOG
		add_log(1, "ERROR net_recv: %m (%e)");
#endif
		if (size != (int *) 0)
			*size = 0;
		return (char *) 0;
	}

	if (size != (int *) 0)
		*size = (int) rqst.rq_ack.ak_type;

	return reading_buffer;
}

rt_public int twrite(void *buffer, size_t size)
{
	/* Write 'size' bytes held in 'buffer' into the "pipe". Return the number
	 * of bytes effectively written or -1 if an error occurred.
	 */

	Request rqst;		/* Leading request */
	size_t t;

	REQUIRE("Valid size", size <= INT32_MAX);

	Request_Clean (rqst);
	rqst.rq_type = TRANSFER;
		/* Safe cast since `size' is less than INT32_MAX. */
	rqst.rq_ack.ak_type = (int) size;

#ifdef DEBUG
#ifdef USE_ADD_LOG
	add_log(20, "sending leading request on #%d", writefd(sp));
#endif
#endif

#ifdef EIF_WINDOWS
	send_packet(sp, &rqst);
#else
	send_packet(writefd(sp), &rqst);
#endif

#ifdef DEBUG
#ifdef USE_ADD_LOG
	add_log(20, "sending %d bytes to remote process", size);
#endif
#endif

#ifdef EIF_WINDOWS
	t = net_send(sp, buffer, size);
#ifdef USE_ADD_LOG
	add_log(20, "net_send was %d", t);
#endif
#else
	t = net_send(writefd(sp), buffer, size);
#endif

		/* Cast safe since size is less than INT32_MAX. */
	return (int) t;
}

#ifdef EIF_WINDOWS
rt_public void swallow(STREAM *fd, size_t size)
#else
rt_public void swallow(int fd, size_t size)
#endif
{
	/* Swallow 'size' bytes from 'fd' and discard them */

	char buf[BUFSIZ];
	size_t amount;

	REQUIRE("Valid size", size <= INT32_MAX);

	while (size > 0) {
		amount = size;
		if (amount > BUFSIZ)
			amount = BUFSIZ;
#ifdef EIF_WINDOWS
		if (-1 == net_recv(fd, buf, amount, TRUE))
#else
		if (-1 == net_recv(fd, buf, amount))
#endif
			return;
		size -= amount;
	}
}

/* After debugging completed, we need to free the communication buffer */
rt_public void end_debug()
{
	if (reading_buffer != NULL) free (reading_buffer);
	reading_buffer = NULL;
	allocated_buffer_size = 0;
}
