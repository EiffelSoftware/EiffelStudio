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

#include "eif_config.h"
#include "eif_portable.h"
#include "rt_macros.h"
#include "rt_struct.h"
#include "rt_traverse.h"
#include "eif_garcol.h"
#include "eif_except.h"
#include "eif_memory.h"
#include "rt_error.h"
#include "x2c.h"		/* For LNGPAD macro */
#include "rt_store.h"
#include "pstore.h"
#include "minilzo.h"
#include "rt_retrieve.h"
#include "rt_compress.h"
#include "rt_gen_types.h"
#include "rt_globals.h"
#include "rt_assert.h"

#ifdef EIF_WINDOWS
#include <io.h>
#else
#include "unistd.h"
#endif

/* Internal variables */
rt_private fnptr make_index;	/* Index building routine */
rt_private fnptr need_index;	/* Index checking routine */
rt_private EIF_REFERENCE server;		/* Current server used */
rt_private long file_position;	/* Position in current opened file */

rt_private char *parsing_buffer = (char *) 0;
rt_private long parsing_position = 0;
rt_private long parsing_buffer_size = 0;
rt_private int file_descriptor;

rt_private uint32 pst_store(char *object, uint32 a_object_count);	/* Recursive store */
rt_private void parsing_store_write(size_t);
rt_private void parsing_store_append(char *object, fnptr mid, fnptr nid);
rt_private int compiler_char_write(char *pointer, int size);

/* Memory writing function */
rt_private int parsing_char_write (char *pointer, int size);	/* store in stream */
rt_private void parsing_compiler_write(size_t);

#define EIF_BUFFER_SIZE 262144L

rt_public void parsing_store_initialize (void) {
	rt_init_store(
		parsing_store_write,
		parsing_char_write,
		flush_st_buffer,
		st_write,
		NULL,
		0);
	
	if (parsing_buffer == (char *) 0) {
		allocate_gen_buffer ();
		parsing_buffer = (char *) malloc (sizeof (char) * EIF_BUFFER_SIZE);
	}
	parsing_buffer_size = EIF_BUFFER_SIZE;
	parsing_position = 0;
}

rt_public void parsing_store_dispose (void) {
	free (parsing_buffer);
}

rt_public void parsing_store (EIF_INTEGER file_desc, EIF_REFERENCE object)
{
	file_descriptor = (int) file_desc;

	rt_init_store (
		parsing_compiler_write,
		compiler_char_write,
		flush_st_buffer,
		st_write,
		make_header,
		0);

	allocate_gen_buffer();
	internal_store(object);

	rt_reset_store ();
}

rt_public long store_append(EIF_INTEGER f_desc, char *object, fnptr mid, fnptr nid, EIF_REFERENCE s)
{
	/* Append `object' in file `f', and applies routine `mid'
	 * on server `s'. Return position in the file where the object is
	 * stored. */

	/* Initialization */
	server = s;

	if ((file_position = lseek ((int) f_desc, 0, SEEK_END)) == -1)
		eraise ("Unable to seek on internal data files", EN_SYS);

	parsing_store_append(object, mid, nid);

	write (f_desc, parsing_buffer, parsing_position);
	parsing_position = 0;

	return file_position;
}

rt_private void parsing_store_append(EIF_REFERENCE object, fnptr mid, fnptr nid)
{
	RT_GET_CONTEXT
	int gc_stopped;

	make_index = mid;
	need_index = nid;
	gc_stopped = !gc_ison();
	gc_stop();		/* Procedure `make_index' may call the GC
				 * while creating objects. */

		/* Need to hold mutex here since we are using traversal. */
	EIF_EO_STORE_LOCK;

#ifdef DEBUG
	(void) nomark(object);
#endif
	/* Do the traversal: mark and count the objects to store */
	obj_nb = 0;
	traversal(object,0);

	current_position = 0;
	end_of_buffer = 0;

	/* Write in file `file_descriptor' the count of stored objects */
	buffer_write((char *) (&obj_nb), sizeof(uint32));

#ifndef DEBUG
	(void) pst_store(object,0L);		/* Recursive store process */
#else
	{
		uint32 nb_stored = pst_store(object,0L);

		if (obj_nb != nb_stored) {
			printf("obj_nb = %d nb_stored = %d\n", obj_nb, nb_stored);
			eraise ("Eiffel partial store", EN_IO);
		}
	}
	if (obj_nb != nomark(object))
		eraise ("Partial store inconsistency", EN_IO);
#endif

	flush_st_buffer();				/* Flush the buffer */

	EIF_EO_STORE_UNLOCK;	/* Unlock our mutex. */
	if (!gc_stopped)
		gc_run();					/* Restart GC */

}

rt_private uint32 pst_store(EIF_REFERENCE object, uint32 a_object_count)
{
	/* Second pass of the store mechanism: writing on the disk.
	 */

	char *o_ref;
	char *o_ptr;
	long nb_references;
	union overhead *zone = HEADER(object);
	uint32 fflags, flags;
	int is_expanded;
	EIF_BOOLEAN object_needs_index;
	long saved_file_pos = 0;
	long saved_object_count = a_object_count;

	object_needs_index = (EIF_BOOLEAN) ((EIF_BOOLEAN (*)())need_index)(server,object);

	if (object_needs_index) {
			/* If the object needs an index, the buffer is flushed so that
			 * a new compression header is stored just before the object
			 * thus the decompression will work when starting the retrieve
			 * there */
		flush_st_buffer();
		saved_file_pos = file_position + parsing_position;
	}

	fflags = zone->ov_flags;
	flags = Mapped_flags(fflags);
	is_expanded = eif_is_nested_expanded(flags) != (uint32) 0;
	if (!(is_expanded || (flags & EO_STORE)))
		return a_object_count;		/* Unmarked means already stored */
	else if (!is_expanded)
		a_object_count++;
	
	zone->ov_flags &= ~EO_STORE;	/* Unmark it */

#ifdef DEBUG
		printf("object 0x%" EIF_POINTER_DISPLAY " [%s %" EIF_POINTER_DISPLAY "]\n", (rt_uint_ptr) object, System(Deif_bid(flags)).cn_generator, (rt_uint_ptr) zone->ov_flags);
#endif
	/* Evaluation of the number of references of the object */
	if (flags & EO_SPEC) {					/* Special object */
		if (!(flags & EO_REF)) {			/* Special of simple types */
		} else {
			EIF_INTEGER count, elem_size;
			EIF_REFERENCE ref;

			o_ptr = RT_SPECIAL_INFO_WITH_ZONE (object, zone);
			count = RT_SPECIAL_COUNT_WITH_INFO (o_ptr);
			if (flags & EO_TUPLE) {
				EIF_TYPED_ELEMENT * l_item = (EIF_TYPED_ELEMENT *) object;
					/* Don't forget that first element of TUPLE is just a placeholder
					 * to avoid offset computation from Eiffel code */
				l_item++;
				count--;
				for (; count > 0; count--, l_item++) {
					if (eif_tuple_item_type(l_item) == EIF_REFERENCE_CODE) {
						ref = eif_reference_tuple_item(l_item);
						if (ref) {
							a_object_count = pst_store (ref, a_object_count);
						}
					}
				}
			} else if (!(flags & EO_COMP)) {		/* Special of references */
				for (
					ref = object;
					count > 0;
					count--, ref = (EIF_REFERENCE) ((EIF_REFERENCE *) ref + 1))
				{
					o_ref = *(EIF_REFERENCE *) ref;
					if (o_ref != (EIF_REFERENCE) 0)
						a_object_count = pst_store(o_ref,a_object_count);
				}
			} else {						/* Special of composites */
				elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO (o_ptr);
				for (ref = object + OVERHEAD; count > 0;
					count --, ref += elem_size) {
					a_object_count = pst_store(ref,a_object_count);
				}
			}
		}
	} else {								/* Normal object */
		nb_references = References(Deif_bid(flags));

		/* Traversal of references of `object' */
		for (
			o_ptr = object; 
			nb_references > 0;
			nb_references--, o_ptr = (EIF_REFERENCE) (((EIF_REFERENCE *) o_ptr) +1)
		) {
			o_ref = *(EIF_REFERENCE *)o_ptr;
			if (o_ref != (EIF_REFERENCE) 0)
				a_object_count = pst_store(o_ref,a_object_count);
		}
	}

	if (!is_expanded)
		st_write(object, HEADER(object)->ov_flags);		/* Write the object on the disk */

	/* Call `make_index' on `server' with `object' */
    if (object_needs_index)
		(make_index)(server, object, saved_file_pos, a_object_count - saved_object_count);


	return a_object_count;
}

/* Work-memory needed for compression. Allocate memory in units
 * of `long' (instead of `char') to make sure it is properly aligned.
 */

#define HEAP_ALLOC(var,size) \
	long __LZO_MMODEL var [ ((size) + (sizeof(long) - 1)) / sizeof(long) ]

static HEAP_ALLOC(wrkmem,LZO1X_1_MEM_COMPRESS);


rt_private void parsing_store_write(size_t size)
{
	RT_GET_CONTEXT
	char* cmps_out_ptr = cmps_general_buffer;
	lzo_uint cmps_out_size = (lzo_uint) cmp_buffer_size;
	int signed_cmps_out_size;
	
	REQUIRE("buffer_size not too big", cmp_buffer_size <= 0xFFFFFFFF);
	REQUIRE("size not too big", size <= 0xFFFFFFFF);

	lzo1x_1_compress (
					(unsigned char *) general_buffer,		/* Current buffer location */
					(lzo_uint) size,	/* Current buffer size */
					(unsigned char *) cmps_out_ptr,		/* Output buffer for compressed data */
					&cmps_out_size,		/* Size of output buffer and then size of compressed data */
					wrkmem);			/* Memory allocator */

	signed_cmps_out_size = cmps_out_size;

		/* Write size of compressed data */
	if (parsing_char_write ((char *) &signed_cmps_out_size, sizeof(int)) <= 0)
		eraise ("Unable to write compressed data size", EN_IO);

		/* Write compressed data */
	if (parsing_char_write (cmps_out_ptr, signed_cmps_out_size) <= 0)
		eraise ("Unable to write on specified device", EN_IO);
}

rt_private int parsing_char_write (char *pointer, int size)
{
	if (parsing_buffer_size - parsing_position < size) {
		parsing_buffer_size += parsing_buffer_size;
		parsing_buffer = (char *) realloc ((void *)parsing_buffer, parsing_buffer_size);
	}

	memcpy ((parsing_buffer + parsing_position), pointer, size);
	parsing_position += size;
	return size;
}

rt_private void parsing_compiler_write(size_t size)
{
	RT_GET_CONTEXT
	char* cmps_out_ptr = cmps_general_buffer;
	lzo_uint cmps_out_size = (lzo_uint) cmp_buffer_size;
	int signed_cmps_out_size;
	int number_written;

	REQUIRE("buffer_size not too big", cmp_buffer_size <= 0xFFFFFFFF);
	REQUIRE("size not too big", size <= 0xFFFFFFFF);
	
	lzo1x_1_compress (
					(unsigned char *) general_buffer,		/* Current buffer location */
					(lzo_uint) size,	/* Current buffer size */
					(unsigned char *) cmps_out_ptr,		/* Output buffer for compressed data */
					&cmps_out_size,		/* Size of output buffer and then size of compressed data */
					wrkmem);			/* Memory allocator */

	signed_cmps_out_size = cmps_out_size;

		/* Write size of compressed data */
	if (write (file_descriptor, (char *) &signed_cmps_out_size, sizeof(int)) <= 0)
		eraise ("Unable to write compressed data size", EN_IO);

		/* Write compressed data */
	while (signed_cmps_out_size > 0) {
		number_written = write (file_descriptor, cmps_out_ptr, signed_cmps_out_size);
		if (number_written <= 0)
			eio();
		signed_cmps_out_size -= number_written;
		cmps_out_ptr += number_written;
	}
}

rt_private int compiler_char_write(char *pointer, int size)
{
	return write(file_descriptor, pointer, size);
}
