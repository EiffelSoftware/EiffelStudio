/*

  ####    #####   ####   #####   ######           ####
 #          #    #    #  #    #  #               #    #
  ####      #    #    #  #    #  #####           #
      #     #    #    #  #####   #        ###    #
 #    #     #    #    #  #   #   #        ###    #    #
  ####      #     ####   #    #  ######   ###     ####

	Eiffel storing mechanism.
*/

#include "config.h"
#include "portable.h"
#include "macros.h"
#include "malloc.h"
#include "except.h"
#include "store.h"
#include "traverse.h"
#include "except.h"
#include "cecil.h"
#include <stdio.h>
#include "struct.h"
#include "bits.h"
#include "plug.h"
#include "run_idr.h"

#ifdef EIF_WINDOWS
#include "winsock.h"
#endif

#ifdef I_STRING
#include <string.h>				/* For strlen() */
#else
#include <strings.h>
#endif

/*#define DEBUG_GENERAL_STORE	/**/

/*#define DEBUG 1    /**/

public int fides;
public char fstoretype;
public char * general_buffer = (char *) 0;
public int current_position = 0;
public int buffer_size = 1024;
public int end_of_buffer = 0;
private char *s_buffer = (char *) 0;
extern char *idr_temp_buf; 			/*temporary buffer for idr floats and doubles*/


/*
 * Function declarations
 */
extern void eio();
private void internal_store();
private void st_store();				/* Second pass of the store */
private void ist_write();
private void gst_write();
private void make_header();				/* Make header */
private void imake_header();				/* Make header */
private int store_buffer ();
private void object_write ();
private void gen_object_write ();
public long get_offset ();
public long get_alpha_offset ();
public void allocate_gen_buffer();
void store_write();
private void st_clean();
public void free_sorted_attributes();

/*
 * Shared data declarations
 */
shared char *account = (char *) 0;			/* Array of traversed dyn types */
shared unsigned int **sorted_attributes = (unsigned int **) 0;	/* Array of sorted attributes */

extern int scount;					/* Maximum dtype */

private int accounting = 0;

#ifndef lint
private char *rcsid =
	"$Id$";
#endif

/*function pointers to save on if statements*/

void (*make_header_func)() = make_header;
void (*st_write_func)() = st_write;
void (*flush_buffer_func)() = flush_st_buffer;
void (*store_write_func)() = store_write;

/*
 * Functions definitions
 */

public void eestore(file_desc, object, file_storage_type)
EIF_INTEGER file_desc;
char *object;
EIF_CHARACTER file_storage_type;
{
	/* Store object hierarchy of root `object' and produce a header
	 * so it can be retrieved by other systems.
	 */

	fides = (int) file_desc;
	fstoretype = file_storage_type;
	accounting = TR_ACCOUNT;
	st_write_func = gst_write;
	allocate_gen_buffer();
	internal_store(object);
	free_sorted_attributes();
	accounting = 0;
	st_write_func = st_write;
}

public void estore(file_desc, object, file_storage_type)
EIF_INTEGER file_desc;
char *object;
EIF_CHARACTER file_storage_type;
{
	/* Store object hierarchy of root `object' without header. */
	fides = (int) file_desc;
	fstoretype = file_storage_type;
	accounting = 0;
	allocate_gen_buffer();
	internal_store(object);
}

public void sstore (fd, object, file_storage_type)
EIF_INTEGER fd;
char * object;
EIF_CHARACTER file_storage_type;
{
	/* Use file decscriptor so sockets and files can be used for storage
	 * Store object hierarchy of root `object' and produce a header
     * so it can be retrieved by other systems.
     */
	extern void run_idr_init();
	extern void run_idr_destroy();
	extern void idr_flush();

	fides = (int) fd;
	fstoretype = file_storage_type;
	accounting = INDEPEND_ACCOUNT;
	make_header_func = imake_header;
	flush_buffer_func = idr_flush;
	st_write_func = ist_write;
	run_idr_init ();
	idr_temp_buf = (char *) xmalloc (48, C_T, GC_OFF);
	internal_store(object);
	accounting = 0;
	run_idr_destroy ();
	make_header_func = make_header;
	flush_buffer_func = flush_st_buffer;
	st_write_func = st_write;
	xfree (idr_temp_buf);
	idr_temp_buf = (char *)0;
}

public void allocate_gen_buffer ()
{
	if (general_buffer == (char *) 0) {
		char g_status = g_data.status;

		g_data.status |= GC_STOP;
		general_buffer = (char *) xmalloc (buffer_size * sizeof (char), C_T, GC_OFF);
		if (general_buffer == (char *) 0)
			eraise ("out of memory", EN_PROG);
		g_data.status = g_status;
	}
	current_position = 0;
	end_of_buffer = 0;
}

private void internal_store(object)
char *object;
{
	/* Store object hierarchy of root `object' in file `file_ptr' and
	 * produce header if `accounting'.
	 */
	char c;


	if (accounting) {		/* Prepare character array */
		account = (char *) xmalloc(scount * sizeof(char), C_T, GC_OFF);
		if (account == (char *) 0)
			xraise(EN_MEM);
		bzero(account, scount * sizeof(char));
		if (accounting == INDEPEND_ACCOUNT)
			c = INDEPENDENT_STORE_3_2;
		else {
			c = GENERAL_STORE_3_3;

				/* Allocate the array to store the sorted attributes */
			sorted_attributes = (unsigned int **) xmalloc(scount * sizeof(unsigned int *), C_T, GC_OFF);
#ifdef DEBUG_GENERAL_STORE
printf ("Malloc on sorted_attributes %d %d %lx\n", scount, scount * sizeof(unsigned int *), sorted_attributes);
#endif
			if (sorted_attributes == (unsigned int **) 0){
				xfree(accounting);
				xraise(EN_MEM);
			}
			bzero(sorted_attributes, scount * sizeof(unsigned int *));
		}
	} else
		c = BASIC_STORE_3_2;

	/* Write the kind of store */
#ifdef EIF_WINDOWS
	if (((fstoretype == 'F')
		? write(fides, &c, sizeof(char))
		: send (fides, &c, sizeof(char), 0)) < 0) {
#else
	if (write(fides, &c, sizeof(char)) < 0){
#endif
		if (accounting) {
			xfree(account);
			if (c==GENERAL_STORE_3_3)
					/* sorted_attributes is empty so a basic free is enough */
				xfree(sorted_attributes);
				sorted_attributes = (unsigned int **) 0;
			}
		eio();
		}

#if DEBUG & 3
		printf ("\n %d", c);
#endif

	/* Do the traversal: mark and count the objects to store */
	obj_nb = 0;
	traversal(object,accounting);

	if (accounting) {
		make_header_func();			/* Make header */
		xfree(account);			/* Free accouting character array */

		account = (char *) 0;
	}
	/* Write in file `fides' the count of stored objects */
	if (accounting == INDEPEND_ACCOUNT)
		widr_multi_int (&obj_nb, 1);
	else
		buffer_write(&obj_nb, sizeof(long));

#if DEBUG & 3
		printf (" %lx", obj_nb);
#endif

	st_store(object);			/* Write objects to be stored in `fides' */

						/* flush the buffer */
        flush_buffer_func ();
#if DEBUG & 3
		printf ("\n");
#endif
}

private void st_store(object)
char *object;
{
	/* Second pass of the store mecahnism: writing on the disk. */

	char *o_ref;
	char *o_ptr;
	long nb_references;
	union overhead *zone = HEADER(object);
	uint32 flags;
	int is_expanded;

	flags = zone->ov_flags;
	is_expanded = (flags & EO_EXP) != (uint32) 0;
	if (!(is_expanded || (flags & EO_STORE)))
		return;		/* Unmarked means already stored */

	zone->ov_flags = flags & ~EO_STORE;		/* Unmark it */

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
						st_store(o_ref);
				}
			} else {						/* Special of composites */
				elem_size = *(long *) (o_ptr + sizeof(long));
				for (ref = object + OVERHEAD; count > 0;
					count --, ref += elem_size) {
					st_store(ref);
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
				st_store(o_ref);
		}
	}

	if (!is_expanded)
		st_write_func(object);		/* write the object */

}

public void st_write(object)
char *object;
{
	/* Write an object in file `fides'.
	 * Use for basic and general (before 3.3) store
	 */

	register2 union overhead *zone;
	uint32 flags;
	register1 uint32 nb_char;

	zone = HEADER(object);
	flags = zone->ov_flags;
	/* Write address */

	buffer_write(&object, sizeof(char *));
	buffer_write(&flags, sizeof(uint32));
#if DEBUG & 2
		printf ("\n %lx", object);
		printf (" %lx", flags);
#endif

	if (flags & EO_SPEC) {
		/* We have to save the size of the special object */
		buffer_write(&zone->ov_size, sizeof(uint32));

#if DEBUG & 2
		printf (" %lx", zone->ov_size);
#endif

		/* Evaluation of the size of a special object */
		nb_char = (zone->ov_size & B_SIZE) * sizeof(char);
	} else
		/* Evaluation of the size of a normal object */
		nb_char = Size((uint16)(flags & EO_TYPE));
	/* Write the body of the object */
	buffer_write(object, (sizeof(char) * nb_char));

#if DEBUG & 2
{
	int i;
	for (i = 0; i < nb_char ; i++) {
		printf (" %x", *(object + i));
		if (!(i % 40))
			printf ("\n");
	}
}
#endif

}

private void gst_write(object)
char *object;
{
	/* Write an object in file `fides'.
	 * used for general store
	 */

	register2 union overhead *zone;
	uint32 flags;
	register1 uint32 nb_char;

	zone = HEADER(object);
	flags = zone->ov_flags;
	/* Write address */

	buffer_write(&object, sizeof(char *));
	buffer_write(&flags, sizeof(uint32));

#if DEBUG & 1
		printf ("\n %lx", object);
		printf (" %lx", flags);
#endif

	if (flags & EO_SPEC) {
		char * o_ptr;
		uint32 count, elm_size;
		o_ptr = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD(2));
		count = (uint32)(*(long *) o_ptr);
		elm_size = (uint32)(*(long *) (o_ptr + sizeof (long *)));

		/* We have to save the number of objects in the special object */

		buffer_write(&count, sizeof(uint32));
		buffer_write(&elm_size, sizeof(uint32));

#if DEBUG & 1
		printf ("\ncount  %x", count);
		printf (" %x", elm_size);
#endif

	} 
	/* Write the body of the object */
	gen_object_write(object);

}

private void ist_write(object)
char *object;
{
	/* Write an object in file `fides'.
	 * used for independent store
	 */

	register2 union overhead *zone;
	uint32 flags;
	register1 uint32 nb_char;

	zone = HEADER(object);
	flags = zone->ov_flags;
	/* Write address */

	widr_multi_any (&object, 1);
	widr_norm_int (&flags);

#if DEBUG & 1
		printf ("\n %lx", object);
		printf (" %lx", flags);
#endif

	if (flags & EO_SPEC) {
		char * o_ptr;
		uint32 count, elm_size;
		o_ptr = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD(2));
		count = (uint32)(*(long *) o_ptr);
		elm_size = (uint32)(*(long *) (o_ptr + sizeof (long *)));

		/* We have to save the number of objects in the special object */

		widr_norm_int(&count);
		widr_norm_int(&elm_size);

#if DEBUG & 1
		printf ("\ncount  %x", count);
		printf (" %x", elm_size);
#endif

	} 
	/* Write the body of the object */
	object_write(object);

}

public long get_offset(o_type, attrib_num)
uint32 o_type, attrib_num;
{
#ifndef WORKBENCH
	return ((System(o_type).cn_offsets[attrib_num])[o_type]);
#else
    int32 rout_id;                  /* Attribute routine id */
    long offset;

    rout_id = System(o_type).cn_attr[attrib_num];
    CAttrOffs(offset,rout_id,o_type);
    return offset;
#endif
}

public long get_alpha_offset(o_type, attrib_num)
uint32 o_type, attrib_num;
{
	/* Get the offset for attribute number `attrib_num' (after alphabetical sort) */

#ifdef WORKBENCH
	int32 rout_id;                  /* Attribute routine id */
	long offset;
#endif
	uint32 alpha_attrib_num;

	unsigned int *attr_types = sorted_attributes[o_type];

	if (attr_types == (unsigned int *)0) {
		alpha_attrib_num = attrib_num;
	} else {
		alpha_attrib_num = attr_types[attrib_num];
	}
#ifndef WORKBENCH
	return ((System(o_type).cn_offsets[alpha_attrib_num])[o_type]);
#else
	rout_id = System(o_type).cn_attr[alpha_attrib_num];
	CAttrOffs(offset,rout_id,o_type);
	return offset;
#endif
}


private void gen_object_write(object)
char * object;
{
		/* Writes an object to disk (used by the new (3.3) general store)
		 * It uses the same algorithm as `object_write' and should be updated
		 * at the same time.
		 */

	long attrib_offset;
	int z;
	uint32 o_type;
	uint32 num_attrib;
	uint32 flags = HEADER(object)->ov_flags;

	o_type = flags & EO_TYPE;
	num_attrib = System(o_type).cn_nbattr;

	if (num_attrib > 0) {
		for (; num_attrib > 0;) {
			attrib_offset = get_alpha_offset(o_type, --num_attrib);
			switch (*(System(o_type).cn_types + num_attrib) & SK_HEAD) {
				case SK_INT:
					buffer_write(object + attrib_offset, sizeof(EIF_INTEGER));
					break;
				case SK_BOOL:
				case SK_CHAR:
					buffer_write(object + attrib_offset, sizeof(EIF_CHARACTER));
					break;
				case SK_FLOAT:
					buffer_write(object + attrib_offset, sizeof(EIF_REAL));
					break;
				case SK_DOUBLE:
					buffer_write(object + attrib_offset, sizeof(EIF_DOUBLE));
					break;
				case SK_BIT:
					{
						int q;
						struct bit *bptr = (struct bit *)(object + attrib_offset);
						buffer_write(&(HEADER(bptr)->ov_flags), sizeof(uint32));
						buffer_write(&(bptr->b_length), sizeof(uint32));
						buffer_write(bptr->b_value, bptr->b_length);
					}
					break;
				case SK_EXP:
					gst_write (object + attrib_offset);
					break;
				case SK_REF:
				case SK_POINTER:
					buffer_write(object + attrib_offset, sizeof(EIF_REFERENCE));
					break;
				default:
					eio();
			}
		} 
	} else {
		if (flags & EO_SPEC) {		/* Special object */
			long count, elem_size;
			char *ref, *o_ptr;
			char *vis_name;
			uint32 dgen, dgen_typ;
			struct gt_info *info;

			o_ptr = (char *) (object + (HEADER(object)->ov_size & B_SIZE) - LNGPAD(2));
			count = *(long *) o_ptr;
			vis_name = System(o_type).cn_generator;


			info = (struct gt_info *) ct_value(&ce_gtype, vis_name);
			if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, write in file:
			 *    "dtype visible_name size nb_generics {meta_type}+"
			 */
				int16 *gt_type = info->gt_type;
				int32 *gt_gen;
				int nb_gen = info->gt_param;
	
				for (;;) {
					if ((*gt_type++ & SK_DTYPE) == (int16) o_type)
						break;
				}
				gt_type--;
				gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
				dgen = *gt_gen;
			}
	
			if (!(flags & EO_REF)) {		/* Special of simple types */
				switch (dgen & SK_HEAD) {
					case SK_INT:
						buffer_write(((long *)object), count*sizeof(EIF_INTEGER));
						break;
					case SK_BOOL:
					case SK_CHAR:
						buffer_write(object, count*sizeof(EIF_CHARACTER));
						break;
					case SK_FLOAT:
						buffer_write((float *)object, count*sizeof(EIF_REAL));
						break;
					case SK_DOUBLE:
						buffer_write((double *)object, count*sizeof(EIF_DOUBLE));
						break;
					case SK_BIT:
						dgen_typ = dgen & SK_DTYPE;
						elem_size = *(long *) (o_ptr + sizeof(long));

/*FIXME: header for each object ????*/
						buffer_write((struct bit *)object, count*elem_size);
						break;
					case SK_EXP:
						elem_size = *(long *) (o_ptr + sizeof(long));
						buffer_write(&(HEADER (object + OVERHEAD)->ov_flags), sizeof(uint32));
						for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
							gen_object_write(ref);
						}
						break;
					case SK_POINTER:
						buffer_write(object, count*sizeof(EIF_POINTER));
						break;
					default:
   	   	          		eio();
						break;
				}
			} else {
				if (!(flags & EO_COMP)) {	/* Special of references */
					buffer_write(object, count*sizeof(EIF_REFERENCE));
				} else {			/* Special of composites */
					elem_size = *(long *) (o_ptr + sizeof(long));
					buffer_write(&(HEADER (object)->ov_flags), sizeof(uint32));
					for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
						gen_object_write(ref);
					}
				}
			}
		} 
	}
}


private void object_write(object)
char * object;
{
	long attrib_offset;
	int z;
	uint32 o_type;
	uint32 num_attrib;
	uint32 flags = HEADER(object)->ov_flags;

	o_type = flags & EO_TYPE;
	num_attrib = System(o_type).cn_nbattr;

	if (num_attrib > 0) {
		for (; num_attrib > 0;) {
			attrib_offset = get_offset(o_type, --num_attrib);
			switch (*(System(o_type).cn_types + num_attrib) & SK_HEAD) {
				case SK_INT:
#if DEBUG &1
					printf (" %lx", *((long *)(object + attrib_offset)));
#endif
					widr_multi_int (object + attrib_offset, 1);

					break;
				case SK_BOOL:
				case SK_CHAR:
#if DEBUG &1
					printf (" %lx", *((char *)(object + attrib_offset)));
#endif
					widr_multi_char (object + attrib_offset, 1);

					break;
				case SK_FLOAT:
#if DEBUG &1
					printf (" %f", *((float *)(object + attrib_offset)));
#endif
					widr_multi_float (object + attrib_offset, 1);

					break;
				case SK_DOUBLE:
#if DEBUG &1
					printf (" %lf", *((double *)(object + attrib_offset)));
#endif
					widr_multi_double (object + attrib_offset, 1);

					break;
				case SK_BIT:
					{
						int q;
						struct bit *bptr = (struct bit *)(object + attrib_offset);
#if DEBUG &1
						printf (" %x", bptr->b_length);
						printf (" %x", HEADER(bptr)->ov_flags);
						for (q = 0; q < BIT_NBPACK(LENGTH(bptr)) ; q++) {
							printf (" %lx", *((uint32 *)(bptr->b_value + q)));
							if (!(q % 40))
								printf ("\n");
						}
#endif
						widr_norm_int (&(HEADER(bptr)->ov_flags), 1);
						widr_multi_bit (bptr, 1, bptr->b_length, NULL);
					}

					break;
				case SK_EXP:
					ist_write (object + attrib_offset);
					break;
				case SK_REF:
				case SK_POINTER:
#if DEBUG &1
					printf (" %lx", *((long *)(object + attrib_offset)));
#endif
					widr_multi_any (object + attrib_offset, 1);

					break;

				default:
					eio();
			}
		} 
	} else {
		if (flags & EO_SPEC) {		/* Special object */
			long count, elem_size;
			char *ref, *o_ptr;
			char *vis_name;
			uint32 dgen, dgen_typ;
			struct gt_info *info;

			o_ptr = (char *) (object + (HEADER(object)->ov_size & B_SIZE) - LNGPAD(2));
			count = *(long *) o_ptr;
			vis_name = System(o_type).cn_generator;


			info = (struct gt_info *) ct_value(&ce_gtype, vis_name);
			if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, write in file:
			 *    "dtype visible_name size nb_generics {meta_type}+"
			 */
				int16 *gt_type = info->gt_type;
				int32 *gt_gen;
				int nb_gen = info->gt_param;
	
				for (;;) {
#if DEBUG &1
					if (*gt_type == SK_INVALID)
						panic("corrupted cecil table");
#endif
					if ((*gt_type++ & SK_DTYPE) == (int16) o_type)
						break;
				}
				gt_type--;
				gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
				dgen = *gt_gen;
			}
	
			if (!(flags & EO_REF)) {		/* Special of simple types */
				switch (dgen & SK_HEAD) {
					case SK_INT:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((long *)object) + z));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_int (((long *)object), count);
						break;
					case SK_BOOL:
					case SK_CHAR:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %lx", *((char *)(object + z)));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_char (object, count);
						break;
					case SK_FLOAT:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %f", *(((float *)object) + z));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_float ((float *)object, count);
						break;
					case SK_DOUBLE:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %lf", *(((double *)object) + z));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_double ((double *)object, count);
						break;
					case SK_BIT:
						dgen_typ = dgen & SK_DTYPE;
						elem_size = *(long *) (o_ptr + sizeof(long));
#if DEBUG &1
						printf (" %x", dgen_typ);
						for (ref = object; count > 0; count--, 
								ref += elem_size) {
							int q;
							for (q = 0; q < BIT_NBPACK(dgen & SK_DTYPE ) ; q++) {
								printf (" %lx", *((uint32 *)(((struct bit *)ref)->b_value + q)));
								if (!(q % 40))
									printf("\n");
							}
							printf ("\n");
						}
#endif
						widr_multi_bit ((struct bit *)object, count, dgen_typ, elem_size);
						break;
					case SK_EXP:
						elem_size = *(long *) (o_ptr + sizeof(long));
						widr_norm_int (&(HEADER (object + OVERHEAD)->ov_flags), 1);
						for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
							object_write(ref);
						}
						break;
					case SK_POINTER:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %lx", (((char *)object) + z));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_any (object, count);
						break;

					default:
   	   	          		eio();
						break;
				}
			} else {
				if (!(flags & EO_COMP)) {	/* Special of references */
					widr_multi_any (object, count);
#if DEBUG &1
					for (ref = object; count > 0; count--,
							ref = (char *) ((char **) ref + 1)) {
						printf (" %lx", *(long *)(ref));
						if (!(count % 40))
							printf ("\n");
					}
#endif
				} else {			/* Special of composites */
					elem_size = *(long *) (o_ptr + sizeof(long));
					widr_norm_int (&(HEADER (object)->ov_flags), 1);
					for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
						object_write(ref);
					}
				}
			}
		} 
	}
}



private void make_header()
{
	/* Generate header for stored hiearchy retrivable by other systems. */
	int i;
	char *vis_name;			/* Visible name of a class */
	struct gt_info *info;
	int nb_line = 0;
	int bsize = 80;

        jmp_buf exenv;

        excatch((char *) exenv);        /* Record pseudo execution vector */
        if (setjmp(exenv)) {
                st_clean();                            /* Clean data structure */
                ereturn();                              /* Propagate exception */
        }

	s_buffer = (char *) xmalloc (bsize * sizeof( char), C_T, GC_OFF);
	/* Write maximum dynamic type */
	if (0 > sprintf(s_buffer,"%d\n", scount)) {
		eio();
	}
	buffer_write(s_buffer, (strlen (s_buffer)));
	

	for (i=0; i<scount; i++)
		if (account[i])
			nb_line++;
	/* Write number of header lines */
	if (0 > sprintf(s_buffer,"%d\n", nb_line)) {
		eio();
	}
	buffer_write(s_buffer, (strlen (s_buffer)));

	for (i=0; i<scount; i++) {
		if (!account[i])
			continue;				/* No object of dyn. type `i'. */

		sort_attributes(i);

		/* vis_name = Visible(i) */;/* Visible name of the dyn. type */
		vis_name = System(i).cn_generator;

		if (bsize < (strlen (vis_name) + sizeof (long) + 2 * sizeof (int) + 6))
			{
				bsize = (strlen (vis_name) + sizeof (long) + 2 * sizeof (int) + 6);
				s_buffer = (char *) xrealloc (s_buffer, bsize, GC_OFF);
		}

		info = (struct gt_info *) ct_value(&ce_gtype, vis_name);
		if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, write in file:
			 *    "dtype visible_name size nb_generics {meta_type}+"
			 */
			int16 *gt_type = info->gt_type;
			int32 *gt_gen;
			int nb_gen = info->gt_param;
			int j;

			if (0 > sprintf(s_buffer, "%d %s %ld %d", i, vis_name, Size(i), nb_gen)) {
				eio();
			}

			buffer_write(s_buffer, (strlen (s_buffer)));

			for (;;) {
#if DEBUG &1
				if (*gt_type == SK_INVALID)
					panic("corrupted cecil table");
#endif
				if ((*gt_type++ & SK_DTYPE) == (int16) i)
					break;
			}
			gt_type--;
			gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
			for (j=0; j<nb_gen; j++) {
				long dgen;

				dgen = (long) *(gt_gen++);
				if (0 > sprintf(s_buffer, " %lu", dgen)) {
					eio();
				}
				buffer_write(s_buffer, (strlen (s_buffer)));
			}
		} else {
			/* Non-generic type, write in file:
			 *    "dtype visible_name size 0"
			 */
			if (0 > sprintf(s_buffer, "%d %s %ld 0", i, vis_name, Size(i))) {
				eio();
			}
			buffer_write(s_buffer, (strlen (s_buffer)));
		}
		if (0 > sprintf(s_buffer,"\n")) {
			eio();
		}
		buffer_write(s_buffer, (strlen (s_buffer)));
	}
	xfree (s_buffer);
	s_buffer = (char *) 0;
	expop(&eif_stack);
}

public void sort_attributes(dtype)
int dtype;
{
	/* Sort the attributes alphabeticaly by type */

	struct cnode *class_info;		/* Info on the current type */
	unsigned int *s_attr;			/* Sorted attributes for the type */
	char **attr_names;
	uint32 *attr_types;
	unsigned int no_swap, swapped, tmp;

	long attr_nb;
	unsigned int j;

	class_info = &(System(dtype));
	attr_nb = class_info->cn_nbattr;

	if (attr_nb){
		attr_names = class_info->cn_names;
		attr_types = class_info->cn_types;

#ifdef DEBUG_GENERAL_STORE
printf ("attr_nb: %d class name: %s\n", attr_nb, class_info->cn_generator);
printf ("Dtype: %d \n", dtype);
#endif
		s_attr = (unsigned int*) xmalloc (attr_nb * sizeof(unsigned int), C_T, GC_OFF);
#ifdef DEBUG_GENERAL_STORE
printf ("alloc s_attr (%d) %lx\n", dtype, s_attr);
#endif
		if (s_attr == (unsigned int*) 0)
			xraise(EN_MEM);

		sorted_attributes[dtype] = s_attr;

		for (j=0; j < attr_nb; j++)
			s_attr[j] = j;

		swapped = no_swap = 1;

		while (swapped)
			for (j = swapped = 0; j < attr_nb-1; j ++)
				if ((attr_types[s_attr[j]]==attr_types[s_attr[j+1]])&&
					(strcmp (attr_names[s_attr[j]], attr_names[s_attr[j+1]]) > 0)) {
#ifdef DEBUG
printf ("Swapping %s and %s\n", attr_names[s_attr[j]], attr_names[s_attr[j+1]]);
printf ("%d %d\n", s_attr[j], s_attr[j+1]);
printf ("%d %d\n", attr_types[s_attr[j]], attr_types[s_attr[j+1]]);
#endif
						swapped = 1;
						no_swap = 0;
						tmp = s_attr[j];
						s_attr[j] = s_attr[j+1];
						s_attr[j+1] = tmp;
					}

			/* if the skeleton is already sorted, bcopy will work both for store and retrieve */
		if (no_swap){
#ifdef DEBUG_GENERAL_STORE
printf ("Freeing s_attr %lx\n", s_attr);
#endif
			xfree(s_attr);
			sorted_attributes[dtype] = (unsigned int*)0;
			}
		}
}

private void imake_header()
{
	/* Generate header for stored hiearchy retrivable by other systems. */
	int i;
	char *vis_name;			/* Visible name of a class */
	struct gt_info *info;
	int nb_line = 0;
	int bsize = 600;
	uint32 num_attrib;
        jmp_buf exenv;

        excatch((char *) exenv);        /* Record pseudo execution vector */
        if (setjmp(exenv)) {
                st_clean();                             /* Clean data structure */
                ereturn();                              /* Propagate exception */
        }

	s_buffer = (char *) xmalloc (bsize * sizeof( char), C_T, GC_OFF);
	/* Write maximum dynamic type */
	if (0 > sprintf(s_buffer,"%d\n", scount)) {
		eio();
	}
	widr_multi_char (s_buffer, (strlen (s_buffer)));
	
	if (0 > sprintf(s_buffer,"%d\n", OVERHEAD)) {
		eio();
	}
	widr_multi_char (s_buffer, (strlen (s_buffer)));

	for (i=0; i<scount; i++)
		if (account[i])
			nb_line++;
	/* Write number of header lines */
	if (0 > sprintf(s_buffer,"%d\n", nb_line)) {
		eio();
	}
	widr_multi_char (s_buffer, (strlen (s_buffer)));

	for (i=0; i<scount; i++) {
		if (!account[i])
			continue;				/* No object of dyn. type `i'.
		/* vis_name = Visible(i) */;/* Visible name of the dyn. type */
		vis_name = System(i).cn_generator;

		if (bsize < (strlen (vis_name) + sizeof (long) + 2 * sizeof (int) + 6))
			{
				bsize = (strlen (vis_name) + sizeof (long) + 2 * sizeof (int) + 6);
				s_buffer = (char *) xrealloc (s_buffer, bsize, GC_OFF);
		}

		info = (struct gt_info *) ct_value(&ce_gtype, vis_name);
		if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, write in file:
			 *    "dtype visible_name size nb_generics {meta_type}+"
			 */
			int16 *gt_type = info->gt_type;
			int32 *gt_gen;
			int nb_gen = info->gt_param;
			int j;

			if (0 > sprintf(s_buffer, "%d %s %d", i, vis_name, nb_gen)) {
				eio();
			}

			widr_multi_char (s_buffer, (strlen (s_buffer)));

			for (;;) {
#if DEBUG &1
				if (*gt_type == SK_INVALID)
					panic("corrupted cecil table");
#endif
				if ((*gt_type++ & SK_DTYPE) == (int16) i)
					break;
			}
			gt_type--;
			gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
			for (j=0; j<nb_gen; j++) {
				long dgen;

				dgen = (long) *(gt_gen++);
				if (0 > sprintf(s_buffer, " %lu", dgen)) {
					eio();
				}
				widr_multi_char (s_buffer, (strlen (s_buffer)));
			}
		} else {
			/* Non-generic type, write in file:
			 *    "dtype visible_name size 0"
			 */
			if (0 > sprintf(s_buffer, "%d %s 0", i, vis_name)) {
				eio();
			}
			widr_multi_char (s_buffer, (strlen (s_buffer)));
		}
		
				/* also add 
				 * "num_attributes attib_type +"
				 */

		num_attrib = System(i).cn_nbattr;
		if (0 > sprintf(s_buffer, " %d", num_attrib)) {
			eio();
		}
		widr_multi_char (s_buffer, (strlen (s_buffer)));
		for (; num_attrib-- > 0;) {
			if (0 > sprintf(s_buffer, "\n%lu %s", (*(System(i).cn_types + num_attrib) & SK_HEAD), 
					*(System(i).cn_names + num_attrib))) {
				eio();
			}
			widr_multi_char (s_buffer, (strlen (s_buffer)));
		}	
		if (0 > sprintf(s_buffer,"\n")) {
			eio();
		}
		widr_multi_char (s_buffer, (strlen (s_buffer)));
	}
	xfree (s_buffer);
	s_buffer = (char *) 0;
	expop(&eif_stack);
}


private void st_clean()
{
	/* clean up memory allocation and reset function pointers */

	make_header_func = make_header;
	flush_buffer_func = flush_st_buffer;
	st_write_func = st_write;
	if (s_buffer != (char *) 0) {
		xfree(s_buffer);
		s_buffer = (char *) 0;
	}
	if (account != (char *)0) {
		xfree(account);
		account = (char *) 0;
	}
	free_sorted_attributes();
	if (idr_temp_buf != (char *)0) {
		xfree(idr_temp_buf);
		idr_temp_buf = (char *)0;
	}
}

public void free_sorted_attributes()
{
	unsigned int i;
	unsigned int *s_attr;

	if (sorted_attributes != (unsigned int **)0){
#ifdef DEBUG_GENERAL_STORE
printf ("free_sorted_attributes %lx\n", sorted_attributes);
#endif
		for (i=0; i < scount; i++)
			if ((s_attr = sorted_attributes[i])!= (unsigned int *)0){
				xfree(s_attr);
#ifdef DEBUG_GENERAL_STORE
printf ("Free s_attr (%d) %lx\n", i, s_attr);
#endif
				}
		sorted_attributes = (unsigned int **)0;
	}
}

public void buffer_write(data, size)
register char * data;
int size;
{
    register int i;
   	
	if (current_position + size >= buffer_size) {
    	for (i = 0; i < size; i++) {
        	*(general_buffer + current_position) = *(data++);
        	if (++current_position >= buffer_size)
			store_write_func();
    	}
	} else {
    	for (i = 0; i < size; i++) {
        	*(general_buffer + current_position++) = *(data++);
    	}
	}

}

public void flush_st_buffer ()
{
	if (current_position != 0)
		store_write_func ();
}


void store_write()
{
	register char * ptr = general_buffer;
	register int number_left = current_position;
	short send_size = (short) current_position;

	int number_writen;

#ifdef EIF_WINDOWS
	if (fstoretype == 'F')
		{
		if ((write (fides, &send_size, sizeof (short))) < sizeof (short))
			eio();
		}
	else
		if ((send (fides, &send_size, sizeof (short), 0)) < sizeof (short))
			eio();
#else
	if ((write (fides, &send_size, sizeof (short))) < sizeof (short))
		eio();
#endif
	while (number_left > 0) {
#ifdef EIF_WINDOWS
		if (fstoretype == 'F')
			number_writen = write (fides, ptr, number_left);
		else
			number_writen = send (fides, ptr, number_left, 0);
#else
		number_writen = write (fides, ptr, number_left);
#endif
		if (number_writen <= 0)
			eio();
		number_left -= number_writen;
		ptr += number_writen;
	}
	if (ptr - general_buffer == current_position)
		current_position = 0;
	else
		eio();
}

