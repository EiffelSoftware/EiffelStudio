
#include "store.h"
#include "retrieve.h"
#include "compress.h"

#ifdef EIF_WIN32
#include "winsock.h"
#endif
 
int net_char_read(char *pointer, int size)
{
#ifdef EIF_WIN32
	return recv(r_fides, pointer, size, 0);
#else
	return read(r_fides, pointer, size);
#endif
}
 
int net_char_write(char *pointer, int size)
{
#ifdef EIF_WIN32
	return send (fides, pointer, size, 0);
#else
	return write(fides, pointer, size);
#endif
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
#ifdef EIF_WIN32
		number_writen = send (fides, ptr, number_left, 0);
#else
		number_writen = write (fides, ptr, number_left);
#endif
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

