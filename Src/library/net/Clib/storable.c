/*
	Eiffel Net C interfacing --- 	.../library/net/Clib/storable.c
*/


#include "eif_config.h"
#include "eif_portable.h" 	/* required for VMS, recommended for others */

#include "eif_except.h"		/* eraise */
#include "eif_store.h"
#include "eif_retrieve.h"
#include "eif_error.h"    	/* for eio() */
#include "eif_traverse.h"
#include "eif_lmalloc.h"

#ifdef EIF_WIN32
#include "winsock.h"
#define GET_SOCKET_ERROR WSAGetLastError()
#define EWOULDBLOCK WSAEWOULDBLOCK
#else
#include <sys/time.h>		/* select */
#include <sys/types.h>		/* select */
#include <unistd.h>
#define SOCKET_ERROR -1
#define GET_SOCKET_ERROR errno
#endif

#define SOCKET_UNAVAILABLE_FOR_WRITING "Socket unavailable for writing"
#define SOCKET_UNAVAILABLE_FOR_READING "Socket unavailable for reading"

rt_private int socket_fides;
extern void idr_flush (void);

/* Returns nonzero if the socket is ready for, zero otherwise */
/* read = 0, check the socket to be rrready for writing */
/* read = 1, check the socket to be ready for reading */ 
int net_socket_ready (int read)
{
	struct timeval tm;
	fd_set fdset;
	int num_active;

	/* Maximum time we should wait for the socket to be ready */
	tm.tv_sec = 60;
	tm.tv_usec = 0;

	
	/* If the select call is interrupted (GET_SOCKET_ERROR =
           EINTR), we have to do the select again */
	for (;;)
	{
		FD_ZERO (&fdset);
		FD_SET (socket_fides, &fdset);

		if (read) {
			/* Wait until the socket is ready for reading*/
			num_active = select (socket_fides + 1, &fdset, NULL, NULL,
					     &tm);
		} else {
				/* Wait until the socket is ready for writing*/
			num_active = select (socket_fides + 1, NULL, &fdset, NULL,
					     &tm);
		}
		
		if (num_active != SOCKET_ERROR) {
			break;
		} else if (GET_SOCKET_ERROR != EINTR)  {
			eio();
		}
	} 

	return (FD_ISSET (socket_fides, &fdset));
}

int net_char_read(char *pointer, int size)
{
	int i;

retry:
#ifdef EIF_WIN32
	i = recv(socket_fides, pointer, size, 0);
#else
	i = read(socket_fides, pointer, size);
#endif
	if (i == SOCKET_ERROR && GET_SOCKET_ERROR == EWOULDBLOCK)
	{
		if (!net_socket_ready(1))
		{
			/* The desired socket is not ready. Raise an
			   exception. */
			eraise(SOCKET_UNAVAILABLE_FOR_READING, EN_RETR);
		} else {	
			/* Should not issue a recursive call here as this may
			   potentially lead to an unbounded number of recursive
			   calls, thus causing stack overflow should the
			   socket issue this error many times in succession. */
			goto retry;
		}
	}
	else if (i > 0 && i < size)
	{
		int prev = i;

		/* A recursive call here is bounded because the remaining
		   number of bytes is guaranteed to decrease each call. */
		i = net_char_read(pointer + i, size - i);
		if (i > 0)
			i += prev;
	}
	return i;
}

/* Return a buffer large enough to hold the specified minimum size.
 */
rt_private char* net_buffer (int min_size)
{
	static char* buffer = NULL;
	static int buffer_size = 0;

	if (buffer_size < min_size)
	{
		if (buffer == NULL)
			buffer = (char*) eif_malloc (min_size);
		else
			buffer = (char*) eif_realloc (buffer, min_size);

		if (buffer == NULL)
			eraise ("Out of memory in buffered_write", EN_RETR);
		else
			buffer_size = min_size;
	}
	return buffer;
}

/* Write the specified buffer to the file desciptor, retrying until all
 * bytes are written or until an unrecoverable error occurs.
 */
rt_private int write2(int fd, char* pointer, int size)
{
	int i;
retry:
#ifdef EIF_WIN32
	i = send(fd, pointer, size, 0);
#else
	i = write(fd, pointer, size);
#endif
	if (i == SOCKET_ERROR  &&  GET_SOCKET_ERROR == EWOULDBLOCK)
	{
		if (!net_socket_ready(0))
		{
			/* The desired socket is not ready. Raise an
			   exception. */
			eraise(SOCKET_UNAVAILABLE_FOR_WRITING, EN_RETR);
		} else {
			/* Should not issue a recursive call here as this may
			   potentially lead to an unbounded number of recursive
			   calls, thus causing stack overflow should the
			   socket issue this error many times in succession. */
			goto retry;
		}
	}
	else if (i > 0 && i < size)
	{
		const int prev = i;

		/* A recursive call here is bounded because the remaining
		   number of bytes is guaranteed to decrease each call. */
		i = write2(fd, pointer + i, size - i);
		if (i > 0)
			i += prev;
	}
	return i;
}

/* This write routine is based upon the assumption that storing an object
 * issues two writes: first one byte containing the storable type, then the
 * actual object contents. This routine buffers the first single-byte write
 * and sends it when the second write occurs.
 */
int net_char_write(char *pointer, int size)
{
	static char buffered_type;
	static int buffered = 0;
	int count;

	if (buffered)
	{
		char* const buffer = net_buffer(1 + size);
		*buffer = buffered_type;
		buffered = 0;
		memcpy(buffer + 1, pointer, size);
		count = write2(socket_fides, buffer, 1 + size);
		if (count > 0)
			count -= 1;	/* do not report buffered byte */
	}
	else if (size == 1)
	{
		buffered_type = *pointer;
		buffered = 1;
		count = 1;		/* pretend buffered bytes was written */
	}
	else
		count = write2(socket_fides, pointer, size);

	return count;
}


rt_public char *eif_net_retrieved(EIF_INTEGER file_desc)
{
	socket_fides = file_desc;

	return portable_retrieve(net_char_read);
}

rt_public void eif_net_basic_store(EIF_INTEGER file_desc, char *object)
{
	socket_fides = file_desc;

	rt_init_store(
			store_write,
			net_char_write,
			flush_st_buffer,
			st_write,
			make_header,
			0);

	basic_general_free_store(object);

	rt_reset_store();
}

rt_public void eif_net_general_store(EIF_INTEGER file_desc, char *object)
{
	socket_fides = file_desc;

	rt_init_store(
			store_write,
			net_char_write,
			flush_st_buffer,
			gst_write,
			make_header,
			TR_ACCOUNT);

	basic_general_free_store(object);

	rt_reset_store();
}

rt_public void eif_net_independent_store(EIF_INTEGER file_desc, char *object)
{
	socket_fides = file_desc;

	rt_init_store(
			store_write,
		   	net_char_write,
			idr_flush,
			ist_write,
			imake_header,
			INDEPEND_ACCOUNT);

	independent_free_store (object);
	rt_reset_store();
}

