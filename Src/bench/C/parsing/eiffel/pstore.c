/*

 #####    ####    #####   ####   #####   ######           ####
 #    #  #          #    #    #  #    #  #               #    #
 #    #   ####      #    #    #  #    #  #####           #
 #####        #     #    #    #  #####   #        ###    #
 #       #    #     #    #    #  #   #   #        ###    #    #
 #        ####      #     ####   #    #  ######   ###     ####

	Partial store mechanism
*/

#include "eif_config.h"
#include "eif_portable.h"
#include "eif_macros.h"
#include "eif_traverse.h"
#include "eif_garcol.h"
#include "eif_except.h"
#include "eif_store.h"
#include "eif_garcol.h"
#include "eif_memory.h"
#include "eif_error.h"
#include "eif_compress.h"
#include "pstore.h"
#include "x2c.h"		/* For LNGPAD macro */

#ifdef EIF_WIN32
#include <io.h>
#else
#include "unistd.h"
#endif

/* Internal variables */
rt_private fnptr make_index;	/* Index building routine */
rt_private fnptr need_index;	/* Index checking routine */
rt_private char *server;		/* Current server used */
rt_private long file_position;	/* Position in current opened file */

rt_private char *parsing_buffer = (char *) 0;
rt_private long parsing_position = 0;
rt_private long parsing_buffer_size = 0;

rt_private long pst_store(char *object, long int object_count);	/* Recursive store */
rt_private void parsing_store_write(void);
rt_private void parsing_store_append(char *object, fnptr mid, fnptr nid);

/* Memory writing function */
rt_private int parsing_char_write (char *pointer, int size);	/* store in stream */

/* Followings declaration are coming from store.c and eif_store.h */
#define EIF_BUFFER_SIZE EIF_CMPS_IN_SIZE

rt_public void parsing_store_initialize (void) {
	rt_init_store(
		parsing_store_write,
		parsing_char_write,
		flush_st_buffer,
		st_write,
		(void *) (0),
		0,
		EIF_BUFFER_SIZE);
	
	if (parsing_buffer == (char *) 0) {
		allocate_gen_buffer ();
		parsing_buffer = (char *) malloc (sizeof (char) * EIF_BUFFER_SIZE);
	}
	parsing_buffer_size = EIF_BUFFER_SIZE;
	parsing_position = 0;
}

rt_public long store_append(EIF_INTEGER f_desc, char *object, fnptr mid, fnptr nid, char *s)
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

rt_private void parsing_store_append(char *object, fnptr mid, fnptr nid)
{
	char gc_stopped;

	make_index = mid;
	need_index = nid;
	gc_stopped = !gc_ison();
	gc_stop();		/* Procedure `make_index' may call the GC
				 * while creating objects. */

#ifdef DEBUG
	(void) nomark(object);
#endif
	/* Do the traversal: mark and count the objects to store */
	obj_nb = 0;
	traversal(object,0);

	current_position = 0;
	end_of_buffer = 0;

	/* Write in file `file_descriptor' the count of stored objects */
	buffer_write((char *) (&obj_nb), sizeof(long));

#ifndef DEBUG
	(void) pst_store(object,0L);		/* Recursive store process */
#else
	{
		long nb_stored = pst_store(object,0L);

		if (obj_nb != nb_stored) {
			printf("obj_nb = %ld nb_stored = %ld\n", obj_nb, nb_stored);
			eraise ("Eiffel partial store", EN_IO);
		}
	}
	if (obj_nb != nomark(object))
		eraise ("Partial store inconsistency", EN_IO);
#endif

	flush_st_buffer();				/* Flush the buffer */

	if (!gc_stopped)
		gc_run();					/* Restart GC */

}

rt_private long pst_store(char *object, long int object_count)
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
	long saved_file_pos;
	long saved_object_count = object_count;

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
	is_expanded = (flags & EO_EXP) != (uint32) 0;
	if (!(is_expanded || (flags & EO_STORE)))
		return object_count;		/* Unmarked means already stored */
	else if (!is_expanded)
		object_count++;
	
	zone->ov_flags &= ~EO_STORE;	/* Unmark it */

#ifdef DEBUG
		printf("object 0x%lx [%s %lx]\n", object, System(flags & EO_TYPE).cn_generator, zone->ov_flags);
#endif
	/* Evaluation of the number of references of the object */
	if (flags & EO_SPEC) {					/* Special object */
		if (!(flags & EO_REF)) {			/* Special of simple types */
		} else {
			long count, elem_size;
			char *ref;

			o_ptr = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD_2);
			count = *(long *) o_ptr;
			if (!(flags & EO_COMP)) {		/* Special of references */
				for (ref = object; count > 0; count--, ref = (char *) ((char **) ref + 1)) {
					o_ref = *(char **) ref;
					if (o_ref != (char *) 0)
						object_count = pst_store(o_ref,object_count);
				}
			} else {						/* Special of composites */
				elem_size = *(long *) (o_ptr + sizeof(long));
				for (ref = object + OVERHEAD; count > 0;
					count --, ref += elem_size) {
					object_count = pst_store(ref,object_count);
				}
			}
		}
	} else {								/* Normal object */
		nb_references = References(flags & EO_TYPE);

		/* Traversal of references of `object' */
		for (
			o_ptr = object; 
			nb_references > 0;
			nb_references--, o_ptr = (char *) (((char **) o_ptr) +1)
		) {
			o_ref = *(char **)o_ptr;
			if (o_ref != (char *) 0)
				object_count = pst_store(o_ref,object_count);
		}
	}

	if (!is_expanded)
		st_write(object);		/* Write the object on the disk */

	/* Call `make_index' on `server' with `object' */
    if (object_needs_index)
		(make_index)(server, object, saved_file_pos, object_count - saved_object_count);


	return object_count;
}

rt_private void parsing_store_write(void)
{
	char* cmps_in_ptr = general_buffer;
	char* cmps_out_ptr = cmps_general_buffer;
	int cmps_out_size = 0;
	int number_writen = 0;
	
	eif_compress ((unsigned char*)cmps_in_ptr, 
				  (unsigned long)current_position,  /* corresponds to cmps_in_size */
				  (unsigned char*)cmps_out_ptr, 
				  (unsigned long*)&cmps_out_size);
				  
	number_writen = parsing_char_write (cmps_general_buffer,
							cmps_out_size + EIF_CMPS_HEAD_SIZE);
	if (number_writen <= 0)
		eraise ("Unable to write on specified device", EN_IO);
	else
		current_position = 0;
}

rt_private int parsing_char_write (char *pointer, int size)
{
	if (parsing_buffer_size - parsing_position < size) {
		parsing_buffer_size += parsing_buffer_size;
		parsing_buffer = realloc (parsing_buffer, parsing_buffer_size);
	}

	memcpy ((parsing_buffer + parsing_position), pointer, size);
	parsing_position += size;
	return size;
}

