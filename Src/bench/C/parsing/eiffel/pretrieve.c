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
#include "eif_retrieve.h"
#include "eif_store.h"
#include "eif_error.h"
#include "eif_globals.h"

#ifdef EIF_WIN32
#include <io.h>
#else
#include "unistd.h"
#endif

/* Public features */
/* rt_public char *partial_retrieve (EIF_INTEGER f_desc, long position, long nb_obj);
rt_public char *retrieve_all(EIF_INTEGER f_desc, long position); */
rt_public char *partial_retrieve (EIF_INTEGER f_desc, size_t file_size, long position, long nb_obj);
rt_public char *retrieve_all(EIF_INTEGER f_desc, size_t file_size, long position);

/* Private features */
rt_private void stream_buffer_initialization (EIF_INTEGER file_desc, size_t file_size, long position);
rt_private int parsing_char_read (char *, int);
rt_private int parsing_stream_read (char *pointer, int size);	/* store in stream */
rt_private char *parsing_stream_buffer;
rt_private int parsing_stream_position;
rt_private int parsing_stream_size;
rt_private int file_descriptor;
rt_private int file_position;

/* Implementation */

/* rt_public char *partial_retrieve(EIF_INTEGER f_desc, long position, long nb_obj) */
rt_public char *partial_retrieve(EIF_INTEGER f_desc, size_t file_size, long position, long nb_obj)
{
	EIF_GET_CONTEXT
	/* Return `nb_obj' retrieved in file `file_ptr' read at `position'. */
	char *result;

/*	parsing_stream_position = 0; */
	file_descriptor = (int) f_desc;
	if (lseek (f_desc, position, SEEK_SET) == -1)
		esys ();

	rt_init_retrieve(
		retrieve_read_with_compression,
		parsing_char_read,
		262144);

	rt_kind = '\0';
/* 	stream_buffer_initialization (f_desc, file_size, position); */

	allocate_gen_buffer();
	result = rt_nmake(nb_obj);			/* Retrieve `nb_obj' objects */
	ht_free(rt_table);                  /* Free hash table descriptor */
    epop(&hec_stack, nb_recorded);      /* Pop hector records */

	rt_reset_retrieve();

	return result;
	EIF_END_GET_CONTEXT
}

/* rt_public char *retrieve_all(EIF_INTEGER f_desc, long position) */
rt_public char *retrieve_all(EIF_INTEGER f_desc, size_t file_size, long position)
{
	EIF_GET_CONTEXT
	/* Return object graph retrieved in file `file_ptr' read at
	 * position. */
	char *result;

/*	parsing_stream_position = 0; */
	file_descriptor = (int)f_desc;
	if (lseek(file_descriptor, position, SEEK_SET) == -1)
		esys();   /* bail out */

	rt_init_retrieve(
		retrieve_read_with_compression,
		parsing_char_read,
		262144L);

	rt_kind = '\0';
/*	stream_buffer_initialization (f_desc, file_size, position); */

	allocate_gen_buffer();
	result = rt_make();
	ht_free(rt_table);					/* Free hash table descriptor */
	epop(&hec_stack, nb_recorded);		/* Pop hector records */

	rt_reset_retrieve();

	return result;
	EIF_END_GET_CONTEXT
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

rt_private void stream_buffer_initialization (EIF_INTEGER file_desc, size_t file_size, long position) {
	long number_left = file_size - position;
	long number_read;

	if (number_left > parsing_stream_size) {
		parsing_stream_size = number_left; 
		parsing_stream_buffer = realloc (parsing_stream_buffer, parsing_stream_size);
	}

	if (lseek (file_desc, position, SEEK_SET) == -1)
		esys ();

	number_read = read (file_desc, parsing_stream_buffer, number_left);
	if ((number_read <= 0) || (number_read != number_left))
			eio ();
}
