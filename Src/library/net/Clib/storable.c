#include <errno.h>
#include <sys/types.h>

#include "store.h"
#include "retrieve.h"
#include "compress.h"
#include "except.h"
#include "error.h"

#ifdef EIF_WIN32
#include "winsock.h"
#else
#include <unistd.h>
#include <sys/time.h>
#endif

#define SOCKET_UNAVAILLABLE_FOR_WRITING "Socket unavaillable for writing"
#define SOCKET_UNAVAILLABLE_FOR_READING "Socket unavaillable for reading"

int write_to_socket (const void *buf, unsigned int nbytes)
{
	int i = 0;
	struct timeval tm;
	fd_set fdset;

	errno = 0;

	/* Maximum time we should wait for the socket to be ready */
	tm.tv_sec = 10;
	tm.tv_usec = 0;

	FD_ZERO (&fdset);
	FD_SET (fides, &fdset);
	
	/* Wait until the socket is ready for writing*/
	if (select (fides + 1, NULL, &fdset, NULL, &tm) == -1) {
		eio();
	}

	if (FD_ISSET (fides, &fdset)) {
		errno = 0;
#ifdef EIF_WIN32
		i = send (fides, buf, nbytes, 0);
#else
		i = write(fides, buf, nbytes);
#endif
	} else {
				/* The desired socket is not
                                   ready. Raise an exception. */
		eraise(SOCKET_UNAVAILLABLE_FOR_WRITING, EN_RETR);
	}
	return i;
}

int net_char_read(char *pointer, int size)
{
	int i = 0;
	struct timeval tm;
	fd_set fdset;

	errno = 0;

	/* Maximum time we should wait for the socket to be ready */
	tm.tv_sec = 10;	
	tm.tv_usec = 0;

	FD_ZERO (&fdset);
	FD_SET (r_fides, &fdset);
	
	/* Wait until the socket is ready for reading */
	if (select (r_fides + 1,  &fdset, NULL, NULL, &tm) == -1) {
		eio();
	}

	if (FD_ISSET (r_fides, &fdset)) {
		errno = 0;
#ifdef EIF_WIN32
		i = recv(r_fides, pointer, size, 0);
#else
		i = read(r_fides, pointer, size);
#endif
	} else {
		/* The desired socket is not ready. Raise an
		   exception. */
		eraise(SOCKET_UNAVAILLABLE_FOR_READING, EN_RETR);
	}

	return i;
}
 
int net_char_write(char *pointer, int size)
{
	return write_to_socket(pointer, size);
}

void net_store_write(void)
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
		number_writen = write_to_socket (ptr, number_left);

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
