/*
indexing
	description: "EiffelNet: library of reusable components for networking."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
	Eiffel Net C interfacing --- 	.../library/net/Clib/storable.c
*/

#include "eif_config.h"
#include "eif_portable.h" 	/* required for VMS, recommended for others */

#ifdef EIF_WINDOWS
#include <winsock2.h>
#endif

#include "eif_except.h"		/* eraise */
#include "eif_store.h"
#include "eif_retrieve.h"
#include "eif_error.h"    	/* for eio() */
#include "eif_traverse.h"

#ifdef EIF_WINDOWS
#define GET_SOCKET_ERROR WSAGetLastError()
#else
#ifdef I_SYS_TIME
#include <sys/time.h>		/* select */
#endif
#ifdef I_SYS_TIMES
#include <sys/times.h>
#endif
#ifdef EIF_VMS
#include "netvmsdef.h"
#else
#include <sys/types.h>		/* select */
#endif
#include <unistd.h>
#define SOCKET_ERROR -1
#define GET_SOCKET_ERROR errno
#endif

#ifdef VXWORKS
#include <string.h>
#include <selectLib.h>	/* For select. */
#endif

#ifdef EIF_WINDOWS
/* To create portable code we override the definition of some errno constants to
 * map what winsock returns to us for error codes. */
#ifdef EWOULDBLOCK
	#undef EWOULDBLOCK
#endif
#define EWOULDBLOCK WSAEWOULDBLOCK
#endif

#define SOCKET_UNAVAILABLE_FOR_WRITING "Socket unavailable for writing"
#define SOCKET_UNAVAILABLE_FOR_READING "Socket unavailable for reading"

#ifndef EIF_THREADS
rt_private int socket_fides;
#endif

extern void idr_flush (void);



#ifdef EIF_VMS
/* 
** Some VMS TCP/IP stacks appear to have a problem (bug?) with large (i.e.
** size < 65535) transfers.  The bug is confirmed in VMS Multinet and may
** exist in other VMS TCP/IP stacks as well.  Changing EIF_BUFFER_SIZE for
** VMS doesnt help, because it must match the value used for packetizing
** messages in run-time/store.c.
**
** The workaround is to constrain socket recv and send (read and write) calls
** to some workable maximum. The first try used socket buffersize, i.e.
** SO_SNDBUF/SO_RCVBUF. A more efficient workaround is to constrain 
** the send/recv calls to the largest counts that are known to work.  I have
** discovered through experimentation that send calls of up to 65535 bytes
** work while 65536 fails.  recv calls of up to 65534 bytes work and 65536
** fails (I haven't completely tested recv calls of 65535 bytes).  However, I
** also noticed that the VMS Porting Library (aka VMS_JACKETS) limits i/o
** transfers to a maximum size of 32768 (defined as GENERIC_K_MAXBUF); I
** shall do likewise here.
*/

#ifndef GENERIC_K_MAXBUF
#define GENERIC_K_MAXBUF 32768
#endif
#define get_socket_maxrecv(fd) GENERIC_K_MAXBUF
#define get_socket_maxsend(fd) GENERIC_K_MAXBUF
#endif /* EIF_VMS */



/* Returns nonzero if the socket is ready for, zero otherwise */
/* read = 0, check the socket to be ready for writing */
/* read = 1, check the socket to be ready for reading */ 
int net_socket_ready (int read)
{
	GTCX
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
	GTCX
	int i;
#ifdef EIF_VMS
        int rcvbuf = get_socket_maxrecv (socket_fides);
        int chunksize = size;
        if (size > rcvbuf) chunksize = rcvbuf;
#endif

retry:
#ifdef EIF_WINDOWS
	i = recv(socket_fides, pointer, size, 0);
#elif defined EIF_VMS
        i = recv(socket_fides, pointer, chunksize, 0);
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
			buffer = (char*) malloc (min_size);
		else
			buffer = (char*) realloc (buffer, min_size);

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
#ifdef EIF_VMS
        int sndbuf = get_socket_maxsend (socket_fides);
        int chunksize = size;
        if (chunksize > sndbuf) chunksize = sndbuf;
#endif

retry:
#ifdef EIF_WINDOWS
	i = send(fd, pointer, size, 0);
#elif defined EIF_VMS
        i = send(fd, pointer, chunksize, 0);
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
	GTCX
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
#ifndef EIF_IL_DLL
	GTCX
	socket_fides = file_desc;

	return portable_retrieve(net_char_read);
#else
	return NULL;
#endif
}

rt_public void eif_net_basic_store(EIF_INTEGER file_desc, EIF_REFERENCE object)
{
#ifndef EIF_IL_DLL
	GTCX
	socket_fides = file_desc;
	eif_store_object (net_char_write, object, BASIC_STORE);
#endif
}

rt_public void eif_net_independent_store(EIF_INTEGER file_desc, EIF_REFERENCE object)
{
#ifndef EIF_IL_DLL
	GTCX
	socket_fides = file_desc;
	eif_store_object (net_char_write, object, INDEPENDENT_STORE);
#endif
}

rt_public void eif_net_general_store(EIF_INTEGER file_desc, EIF_REFERENCE object)
{
	eif_net_independent_store (file_desc, object);
}


