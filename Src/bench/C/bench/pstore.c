/*

 #####    ####    #####   ####   #####   ######           ####
 #    #  #          #    #    #  #    #  #               #    #
 #    #   ####      #    #    #  #    #  #####           #
 #####        #     #    #    #  #####   #        ###    #
 #       #    #     #    #    #  #   #   #        ###    #    #
 #        ####      #     ####   #    #  ######   ###     ####

	Partial store mechanism
*/

#include "config.h"
#include "portable.h"
#include "macros.h"
#include "traverse.h"
#include "garcol.h"
#include "except.h"
#include "store.h"
#include "garcol.h"
#include "compress.h"

#ifdef EIF_OS2
#include <io.h>
#endif

rt_private fnptr make_index;	/* Index building routine */
rt_private fnptr need_index;	/* Index checking routine */
rt_private char *server;		/* Current server used */
rt_private long pst_store();	/* Recursive store */

rt_private void partial_store_write();

extern void esys();			/* raise op sys error */
extern void eio();
extern void allocate_gen_buffer();
extern char gc_ison();

#undef DEBUG

void c_sv_init(f_desc)
EIF_INTEGER f_desc;
{
	/* Position file `f' at the end. */
    if (lseek((int)f_desc,0,SEEK_END) == -1)
		esys();
}

long store_append(f_desc, o, mid, nid, s)
EIF_INTEGER f_desc;
char *o;
fnptr mid, nid;
char *s;
{
	/* Append `o' in file `f', and applies routine `mid'
	 * on server `s'. Return position in the file where the object is
	 * stored. */

	extern void gc_stop();
	extern void gc_run();
#ifdef DEBUG
    extern long nomark();
#endif
	long result;	/* Position in the file */
	char gc_stopped;

	/* Initialization */

	store_write_func = partial_store_write;

	fides = (int)f_desc;				/* For use of `st_write' */
	fstoretype = 'F';
	result = lseek (fides, 0, SEEK_CUR);
	if (result==-1) esys();

	make_index = mid;
	need_index = nid;
	server = s;
	gc_stopped = !gc_ison();
	gc_stop();					/* Procedure `make_index' may call the GC
								 * while creating objects. */

#ifdef DEBUG
	(void) nomark(o);
#endif
	/* Do the traversal: mark and count the objects to store */
	obj_nb = 0;
	traversal(o,0);

	allocate_gen_buffer();

	/* Write in file `fides' the count of stored objects */
	buffer_write(&obj_nb, sizeof(long));

#ifndef DEBUG
	(void) pst_store(o,0L);		/* Recursive store process */
#else
	{
		long nb_stored = pst_store(o,0L);

		if (obj_nb != nb_stored) {
			printf("obj_nb = %ld nb_stored = %ld\n", obj_nb, nb_stored);
			panic("Eiffel partial store");
		}
	}
	if (obj_nb != nomark(o))
		panic("Partial store inconsistency");
#endif

	flush_st_buffer();				/* Flush the buffer */

	if (!gc_stopped) gc_run();					/* Restart GC */

	store_write_func = store_write;

	return result;
}

rt_private long pst_store(object, object_count)
char *object;
long object_count;
{
	/* Second pass of the store mechanism: writing on the disk.
	 */

	char *o_ref;
	char *o_ptr;
	long nb_references;
	union overhead *zone = HEADER(object);
	uint32 flags;
	int is_expanded;
	EIF_BOOLEAN object_needs_index;
	long saved_file_pos;
	long saved_object_count = object_count;

	object_needs_index = (EIF_BOOLEAN) ((EIF_BOOLEAN (*)())need_index)(server,object);

	if (object_needs_index) {
			/* If the object needs an index, the buffer is flushed so that
			 * a new compression header is stored just before the object
			 * thus the decompression will work when starting the retrieve
			 * there
			 */
		flush_st_buffer();

		saved_file_pos = lseek(fides, 0, SEEK_CUR);
		if (saved_file_pos==-1) esys();
	}

	flags = zone->ov_flags;
	is_expanded = (flags & EO_EXP) != (uint32) 0;
	if (!(is_expanded || (flags & EO_STORE)))
		return object_count;		/* Unmarked means already stored */
	else if (!is_expanded)
		object_count++;
	
	zone->ov_flags &= ~EO_STORE;	/* Unmark it */

#ifdef DEBUG
		printf("object 0x%lx [%s %lx]\n", object, System(flags & EO_TYPE).cn_generator,
zone->ov_flags);
#endif
	/* Evaluation of the number of references of the object */
	if (flags & EO_SPEC) {					/* Special object */
		if (!(flags & EO_REF)) {			/* Special of simple types */
		} else {
			long count, elem_size;
			char *ref;

			o_ptr = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD(2));
			count = *(long *) o_ptr;
			if (!(flags & EO_COMP)) {		/* Special of references */
				for (ref = object; count > 0; count--,
						ref = (char *) ((char **) ref + 1)) {
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
		(make_index)(server,object,saved_file_pos,object_count-saved_object_count);

	return object_count;
}

long fpos2(file_desc)
EIF_INTEGER file_desc;
{
	register long result = (long) lseek((int)file_desc, 0, SEEK_CUR);

	if (result == -1)
		esys();

	return result;
}

rt_private void partial_store_write()
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
		number_writen = write (fides, ptr, number_left);
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

