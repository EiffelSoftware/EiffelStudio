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

private fnptr make_index;	/* Index building routine */
private char *server;		/* Current server used */
private long pst_store();	/* Recursive store */

#undef DEBUG

long st_counter = 0;

void c_sv_init(f)
FILE *f;
{
	/* Position file `f' at the end. */

    fseek(f,0,2);
}

long nb_object(obj)
char *obj;
{
	/* Return the number of objects reached from `obj'. */

	obj_nb = 0;
	traversal (obj,0);

	return obj_nb;
}

long store_append(f, o, mid, s)
FILE *f;
char *o;
fnptr mid;
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
	int32 result = ftell(f);	/* Position in the file */

	/* Initialization */
	st_file = f;				/* For use of `st_write' */
	make_index = mid;
	server = s;
	gc_stop();					/* Procedure `make_index' may call the GC
								 * while creating objects. */

#ifdef DEBUG
	(void) nomark(o);
#endif
	/* Do the traversal: mark and count the objects to store */
	obj_nb = 0;
	traversal(o,0);

	/* Write in file `st_file' the count of stored objects */
	if (fwrite(&obj_nb, sizeof(long), 1, st_file) != 1)
		eio();

#ifndef DEBUG
	(void) pst_store(o,0);		/* Recursive store process */
#else
	{
		long nb_stored = pst_store(o,0);

		if (obj_nb != nb_stored) {
			printf("obj_nb = %ld nb_stored = %ld\n", obj_nb, nb_stored);
			panic("Eiffel partial store");
		}
	}
	if (obj_nb != nomark(o))
		panic("Partial store inconsistency");
#endif

	gc_run();					/* Restart GC */
	fflush(f);
	return result;
}

private long pst_store(object, object_count)
char *object;
long object_count;
{
	/* Second pass of the store mecahnism: writing on the disk.
	 */

	char *o_ref;
	char *o_ptr;
	long nb_references;
	union overhead *zone = HEADER(object);
	uint32 flags;
	int is_expanded;
	long saved_file_pos = ftell(st_file);
	long saved_object_count = object_count;

	flags = zone->ov_flags;
	is_expanded = (flags & EO_EXP) != (uint32) 0;
	if (!(is_expanded || (flags & EO_STORE)))
		return object_count;		/* Unmarked means already stored */
	else if (!is_expanded)
		object_count++;
	
	zone->ov_flags &= ~EO_STORE;	/* Unmark it */

#ifdef DEBUG
	if (st_counter == 1248)
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
				elem_size = *(long *) (o_ref + sizeof(long));
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
    (make_index)(server,object,saved_file_pos,object_count-saved_object_count);

	return object_count;
}

long fpos1()
{
	return (long) ftell(st_file);
}

long fpos2(file_ptr)
FILE *file_ptr;
{
	return (long) ftell(file_ptr);
}
