#include "except.h"		/* eraise */
#include "store.h"
#include "retrieve.h"
#include "compress.h"

#ifdef EIF_WIN32
#include "winsock.h"
#define GET_SOCKET_ERROR WSAGetLastError()
#else
#include <sys/time.h>		/* select */
#define SOCKET_ERROR -1
#define GET_SOCKET_ERROR errno
#endif

#define SOCKET_UNAVAILLABLE_FOR_WRITING "Socket unavaillable for writing"
#define SOCKET_UNAVAILLABLE_FOR_READING "Socket unavaillable for reading"


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
		FD_SET (fides, &fdset);
		if (read) {
			/* Wait until the socket is ready for reading*/
			num_active = select (fides + 1, &fdset, NULL, NULL,
					     &tm);
		} else {
				/* Wait until the socket is ready for writing*/
			num_active = select (fides + 1, NULL, &fdset, NULL,
					     &tm);
		}
		
		if (num_active != SOCKET_ERROR) {
			break;
		} else if (GET_SOCKET_ERROR != EINTR)  {
			eio();
		}
	} 

	return (FD_ISSET (fides, &fdset));
}

int net_char_read(char *pointer, int size)
{
	int i;

#ifdef EIF_WIN32
	i = recv(r_fides, pointer, size, 0);
#else
	i = read(r_fides, pointer, size);
#endif
	if (i == SOCKET_ERROR && GET_SOCKET_ERROR == EAGAIN)
	{
		if (!net_socket_ready(1))
		{
			/* The desired socket is not ready. Raise an
			   exception. */
			eraise(SOCKET_UNAVAILLABLE_FOR_READING, EN_RETR);
		} else {	
			i = net_char_read(pointer, size);
		}
	}
	return i;
}
 
int net_char_write(char *pointer, int size)
{
	int i;

#ifdef EIF_WIN32
	i = send (fides, pointer, size, 0);
#else
	i = write(fides, pointer, size);
#endif
	if (i == SOCKET_ERROR && GET_SOCKET_ERROR == EAGAIN)
	{
	 	if (!net_socket_ready(0))
		{
			/* The desired socket is not ready. Raise an
			   exception. */
			eraise(SOCKET_UNAVAILLABLE_FOR_WRITING, EN_RETR);
		}else {	
			i = net_char_write(pointer, size);
		}
	}
	return i;
}

void net_store_write()
{
	char* cmps_in_ptr = (char *)0;
	char* cmps_out_ptr = (char *)0;
	int cmps_in_size = 0;
	int cmps_out_size = 0;
	register char * ptr = (char *)0;
	register int number_left = 0;
	int number_writen = 0;

	cmps_in_ptr = general_buffer;
	cmps_in_size = current_position;
	cmps_out_ptr = cmps_general_buffer;
 
	eif_compress ((unsigned char*)cmps_in_ptr,
					(unsigned long)cmps_in_size,
					(unsigned char*)cmps_out_ptr,
					(unsigned long*)&cmps_out_size);
 
	ptr = cmps_general_buffer;
	number_left = cmps_out_size + EIF_CMPS_HEAD_SIZE;

	while (number_left > 0) {
		number_writen = net_char_write (ptr, number_left);

		if (number_writen <= 0)
			eio();
		number_left -= number_writen;
		ptr += number_writen;
	}

	if (ptr - cmps_general_buffer == cmps_out_size + EIF_CMPS_HEAD_SIZE)
		current_position = 0;
	else
		eio();
}

rt_public char *eif_net_retrieved(EIF_INTEGER file_desc)
{
	return portable_retrieve(file_desc, net_char_read);
}

rt_public void eif_net_basic_store(EIF_INTEGER file_desc, char *object)
{
	rt_init_store(net_store_write, net_char_write, 0);
	estore(file_desc, object);
	rt_reset_store();
}

rt_public void eif_net_general_store(EIF_INTEGER file_desc, char *object)
{
	rt_init_store(net_store_write, net_char_write, 0); 
	eestore(file_desc, object);
	rt_reset_store();
}

rt_public void eif_net_independent_store(EIF_INTEGER file_desc, char *object)
{
	rt_init_store(net_store_write, net_char_write, 0); 
	sstore (file_desc, object);
	rt_reset_store();
}

