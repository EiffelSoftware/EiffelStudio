/*
	description: "[
			Custom version of storable facilities which enables the compiler to perform
			partial retrieve on a large object. Used to extract bodys of routines from
			a store class abstract syntax tree.
			]"
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

#include "eif_portable.h"
#include "eif_macros.h"
#include "eif_malloc.h"
#include "eif_garcol.h"
#include "rt_store.h"
#include "rt_error.h"
#include "eif_globals.h"
#include "rt_retrieve.h"
#include "rt_hashin.h"
#include "rt_globals.h"
#include "rt_assert.h"
#include "minilzo.h"
#include <string.h>

#ifdef EIF_WINDOWS
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
rt_private size_t parsing_retrieve_read_with_compression (void);
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
	RT_GET_CONTEXT
	rt_kind = BASIC_STORE;
	rt_init_retrieve(
		parsing_retrieve_read_with_compression,
		parsing_char_read,
		RETRIEVE_BUFFER_SIZE);
	allocate_gen_buffer();
}

rt_public EIF_REFERENCE parsing_retrieve (EIF_INTEGER f_desc, EIF_INTEGER a_pos)
{
	return ise_compiler_retrieve (f_desc, a_pos, parsing_retrieve_read_with_compression);
}

rt_public char *partial_retrieve(EIF_INTEGER f_desc, long position, long nb_obj)
	/* Return `nb_obj' retrieved in file `file_ptr' read at `position'. */
{
	RT_GET_CONTEXT
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
#ifdef ISE_GC
    epop(&hec_stack, nb_recorded);      /* Pop hector records */
#endif

	return result;
}

rt_public char *retrieve_all(EIF_INTEGER f_desc, long position)
{
	RT_GET_CONTEXT
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
#ifdef ISE_GC
    epop(&hec_stack, nb_recorded);      /* Pop hector records */
#endif

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
	long number_left = (long) (file_size - position);
	long number_read;

	REQUIRE("file not too big", file_size <= 0x7FFFFFF);

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

rt_private size_t parsing_retrieve_read_with_compression (void)
{
	RT_GET_CONTEXT
	void* dcmps_in_ptr = (char *)0;
	void* dcmps_out_ptr = (char *)0;
	lzo_uint dcmps_in_size = 0;
	lzo_uint dcmps_out_size = (lzo_uint) cmp_buffer_size;
	char* ptr = (char *)0;
	int read_size = 0;
	int part_read = 0;

	REQUIRE("buffer_size not too big", cmp_buffer_size <= 0xFFFFFFFF);

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

	CHECK("dcmps_out_size_positive", dcmps_out_size > 0);
	return dcmps_out_size;
}

