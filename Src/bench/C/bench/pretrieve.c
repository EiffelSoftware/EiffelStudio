/*

 #####   #####   ######   #####  #####      #    ######  #    #  ######
 #    #  #    #  #          #    #    #     #    #       #    #  #
 #    #  #    #  #####      #    #    #     #    #####   #    #  #####
 #####   #####   #          #    #####      #    #       #    #  #        ###
 #       #   #   #          #    #   #      #    #        #  #   #        ###
 #       #    #  ######     #    #    #     #    ######    ##    ######   ###

	Partial retrieve mechanism
*/

#include "eif_portable.h"
#include "eif_macros.h"
#include "eif_malloc.h"
#include "eif_garcol.h"
#include "eif_store.h"
#include "eif_error.h"
#include "eif_globals.h"
#include "rt_retrieve.h"
#include "minilzo.h"

#ifdef EIF_WIN32
#include <io.h>
#else
#include "unistd.h"
#endif

/* Public features */
rt_public char *partial_retrieve (EIF_INTEGER f_desc, long position, long nb_obj);
rt_public char *retrieve_all(EIF_INTEGER f_desc, long position);

rt_public void parsing_retrieve_initialize (void);

/* Private features */
rt_private void stream_buffer_initialization (EIF_INTEGER file_desc, size_t file_size, long position);
rt_private int parsing_retrieve_read_with_compression (void);
rt_private int parsing_char_read (char *, int);
rt_private int parsing_stream_read (char *pointer, int size);	/* store in stream */
rt_private char *parsing_stream_buffer;
rt_private int parsing_stream_position;
rt_private int parsing_stream_size;
rt_private int file_descriptor;

#define RETRIEVE_BUFFER_SIZE 262144L

/* Implementation */

rt_public void parsing_retrieve_initialize (void)
{
	rt_kind = BASIC_STORE;
	rt_init_retrieve(
		parsing_retrieve_read_with_compression,
		parsing_char_read,
		RETRIEVE_BUFFER_SIZE);
	allocate_gen_buffer();
}

rt_public EIF_REFERENCE parsing_retrieve (EIF_INTEGER f_desc)
{
	return ise_compiler_retrieve (f_desc, parsing_retrieve_read_with_compression);
}

rt_public char *partial_retrieve(EIF_INTEGER f_desc, long position, long nb_obj)
	/* Return `nb_obj' retrieved in file `file_ptr' read at `position'. */
{
	EIF_GET_CONTEXT
	char *result;

/*	parsing_stream_position = 0; */
	file_descriptor = (int) f_desc;
	if (lseek (f_desc, position, SEEK_SET) == -1)
		esys ();
/* 	stream_buffer_initialization (f_desc, file_size, position); */
	current_position = 0;
	end_of_buffer = 0;

	result = rt_nmake(nb_obj);			/* Retrieve `nb_obj' objects */
	ht_free(rt_table);                  /* Free hash table descriptor */
    epop(&hec_stack, nb_recorded);      /* Pop hector records */

	return result;
}

rt_public char *retrieve_all(EIF_INTEGER f_desc, long position)
{
	EIF_GET_CONTEXT
	/* Return object graph retrieved in file `file_ptr' read at
	 * position. */
	char *result;

/*	parsing_stream_position = 0; */
	file_descriptor = (int)f_desc;
	if (lseek(file_descriptor, position, SEEK_SET) == -1)
		esys();   /* bail out */
/*	stream_buffer_initialization (f_desc, file_size, position); */

	current_position = 0;
	end_of_buffer = 0;
	result = rt_make();
	ht_free(rt_table);					/* Free hash table descriptor */
	epop(&hec_stack, nb_recorded);		/* Pop hector records */

	return result;
}

rt_private int parsing_char_read (char *pointer, int size)
{
	return read(file_descriptor, pointer, size);
}

int parsing_stream_read(char *pointer, int size)
{
	memcpy (pointer, (parsing_stream_buffer + parsing_stream_position), size);
	parsing_stream_position += size;
	return size;
}

rt_private void stream_buffer_initialization (EIF_INTEGER file_desc, size_t file_size, long position)
{
	long number_left = file_size - position;
	long number_read;

	if (number_left > parsing_stream_size) {
		parsing_stream_size = number_left; 
		parsing_stream_buffer = (char *) realloc (parsing_stream_buffer, parsing_stream_size);
	}

	if (lseek (file_desc, position, SEEK_SET) == -1)
		esys ();

	number_read = read (file_desc, parsing_stream_buffer, number_left);
	if ((number_read <= 0) || (number_read != number_left))
			eio ();
}

extern long cmp_buffer_size;

rt_private int parsing_retrieve_read_with_compression (void)
{
	EIF_GET_CONTEXT
	char* dcmps_in_ptr = (char *)0;
	char* dcmps_out_ptr = (char *)0;
	int dcmps_in_size = 0;
	int dcmps_out_size = cmp_buffer_size;
	char* ptr = (char *)0;
	int read_size = 0;
	int part_read = 0;
	
	ptr = cmps_general_buffer;
	if (char_read_func ((char *) &read_size, sizeof(int)) < sizeof(int))
	  eio();

	dcmps_in_size = read_size;

	while (read_size > 0) {
		part_read = char_read_func (ptr, read_size);
		if (part_read <= 0)
				/* If we read 0 bytes, it means that we reached the end of file,
				 * so we are missing something, instead of going further we stop */
			eio();
		read_size -= part_read;
		ptr += part_read;
	}
	
	dcmps_in_ptr = cmps_general_buffer;
	dcmps_out_ptr = general_buffer;
	
	lzo1x_decompress (dcmps_in_ptr, dcmps_in_size,
					dcmps_out_ptr, &dcmps_out_size, NULL);

	current_position = 0;
	end_of_buffer = dcmps_out_size;
	return (end_of_buffer);
}

