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
#include "error.h"
#include "main.h"
#include "compress.h"

#ifdef EIF_OS2
#include <io.h>
#endif

#ifdef EIF_WIN32
#include "winsock.h"
#endif

#ifdef I_STRING
#include <string.h>				/* For strlen() */
#else
#include <strings.h>
#endif

/*#define DEBUG_GENERAL_STORE	/**/

/*#define DEBUG 1	/**/

/* compression */
#define EIF_BUFFER_SIZE EIF_CMPS_IN_SIZE
#define EIF_BUFFER_ALLOCATED_SIZE EIF_DCMPS_OUT_SIZE
#define EIF_CMPS_BUFFER_ALLOCATED_SIZE EIF_CMPS_OUT_SIZE

rt_public char* cmps_general_buffer = (char *) 0;

rt_public int fides;
rt_public char fstoretype;
rt_public char *general_buffer = (char *) 0;
rt_public int current_position = 0;
rt_public int buffer_size = EIF_BUFFER_SIZE;
rt_public int end_of_buffer = 0;
rt_private char *s_buffer = (char *) 0;


/*
 * Function declarations
 */
rt_private void internal_store(char *object);
rt_private void st_store(char *object);				/* Second pass of the store */
rt_private void ist_write(char *object);
rt_private void gst_write(char *object);
rt_private void make_header(void);				/* Make header */
rt_private void imake_header(void);				/* Make header */
rt_private int store_buffer();		/* %%ss undefined not used in run-time */
rt_private void object_write (char *object);
rt_private void gen_object_write (char *object);
rt_public long get_offset (uint32 o_type, uint32 attrib_num);
rt_public long get_alpha_offset (uint32 o_type, uint32 attrib_num);
rt_public void allocate_gen_buffer(void);
void store_write(void);
rt_private void st_clean(void);
rt_public void free_sorted_attributes(void);

/*
 * Shared data declarations
 */
rt_shared char *account = (char *) 0;			/* Array of traversed dyn types */
rt_shared unsigned int **sorted_attributes = (unsigned int **) 0;	/* Array of sorted attributes */

rt_private int accounting = 0;

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

/*function pointers to save on if statements*/

void (*make_header_func)(void) = make_header;
void (*st_write_func)(char *) = st_write;
void (*flush_buffer_func)(void) = flush_st_buffer;
void (*store_write_func)(void) = store_write;

/*
 * Convenience functions
 */

/* Initialize store function pointers and globals */
/* reset buffer size if argument is non null */
rt_public void rt_init_store(void (*store_function) (void), int buf_size)
{
	store_write_func = store_function;
	if (buf_size)
		buffer_size = buf_size;
}

/* Reset store function pointers and globals to their default values */

rt_public void rt_reset_store(void) {
	store_write_func = store_write;
	buffer_size = EIF_BUFFER_SIZE;
}


/*
 * Functions definitions
 */

rt_public void eestore(EIF_INTEGER file_desc, char *object, EIF_CHARACTER file_storage_type)
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

rt_public void estore(EIF_INTEGER file_desc, char *object, EIF_CHARACTER file_storage_type)
{
	/* Store object hierarchy of root `object' without header. */
	fides = (int) file_desc;
	fstoretype = file_storage_type;
	accounting = 0;
	allocate_gen_buffer();
	internal_store(object);
}

rt_public void sstore (EIF_INTEGER fd, char *object, EIF_CHARACTER file_storage_type)
{
	/* Use file decscriptor so sockets and files can be used for storage
	 * Store object hierarchy of root `object' and produce a header
	 * so it can be retrieved by other systems.
	 */

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

rt_public void allocate_gen_buffer (void)
{
	if (general_buffer == (char *) 0) {
		char g_status = g_data.status;

		g_data.status |= GC_STOP;
		general_buffer = (char *) xmalloc (EIF_BUFFER_ALLOCATED_SIZE * sizeof (char), C_T, GC_OFF);
/* FIXME: EIF_BUFFER_ALLOCATED_SIZE = buffer_size + padding size
if no compression, use buffer_size -> 1k instead of 32k + padding
*/
		if (general_buffer == (char *) 0)
			eraise ("out of memory", EN_PROG);

		/* compression */
		cmps_general_buffer = (char *) xmalloc (EIF_CMPS_BUFFER_ALLOCATED_SIZE * sizeof (char), C_T, GC_OFF);
		if (cmps_general_buffer == (char *) 0)
			eraise ("out of memory", EN_PROG);

		g_data.status = g_status;
	}
	current_position = 0;
	end_of_buffer = 0;
}

rt_private void internal_store(char *object)
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
			c = GENERAL_STORE_4_0;

				/* Allocate the array to store the sorted attributes */
			sorted_attributes = (unsigned int **) xmalloc(scount * sizeof(unsigned int *), C_T, GC_OFF);
#ifdef DEBUG_GENERAL_STORE
printf ("Malloc on sorted_attributes %d %d %lx\n", scount, scount * sizeof(unsigned int *), sorted_attributes);
#endif
			if (sorted_attributes == (unsigned int **) 0){
				xfree((char *)accounting);
				xraise(EN_MEM);
			}
			bzero(sorted_attributes, scount * sizeof(unsigned int *));
		}
	} else
		c = BASIC_STORE_4_0;

	/* Write the kind of store */
#ifdef EIF_WIN32
	if (((fstoretype == 'F')
		? write(fides, &c, sizeof(char))
		: send (fides, &c, sizeof(char), 0)) < 0) {
#else
	if (write(fides, &c, sizeof(char)) < 0){
#endif
		if (accounting) {
			xfree(account);
			if (c==GENERAL_STORE_4_0)
					/* sorted_attributes is empty so a basic free is enough */
				xfree((char *)sorted_attributes);
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
		buffer_write((char *)(&obj_nb), sizeof(long));

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

rt_private void st_store(char *object)
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

rt_public void st_write(char *object)
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

	buffer_write((char *)(&object), sizeof(char *));
	buffer_write((char *)(&flags), sizeof(uint32));
#if DEBUG & 2
		printf ("\n %lx", object);
		printf (" %lx", flags);
#endif

	if (flags & EO_SPEC) {
		/* We have to save the size of the special object */
		buffer_write((char *)(&(zone->ov_size)), sizeof(uint32));

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

rt_private void gst_write(char *object)
{
	/* Write an object in file `fides'.
	 * used for general store
	 */

	register2 union overhead *zone;
	uint32 flags;
	/*register1 uint32 nb_char;*/ /* %%ss removed unused */

	zone = HEADER(object);
	flags = zone->ov_flags;
	/* Write address */

	buffer_write((char *)(&object), sizeof(char *));
	buffer_write((char *)(&flags), sizeof(uint32));

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

		buffer_write((char *)(&count), sizeof(uint32));
		buffer_write((char *)(&elm_size), sizeof(uint32));

#if DEBUG & 1
		printf ("\ncount  %x", count);
		printf (" %x", elm_size);
#endif

	} 
	/* Write the body of the object */
	gen_object_write(object);

}

rt_private void ist_write(char *object)
{
	/* Write an object in file `fides'.
	 * used for independent store
	 */

	register2 union overhead *zone;
	uint32 flags;
	/* register1 uint32 nb_char;*/ /* %%ss removed unused */

	zone = HEADER(object);
	flags = zone->ov_flags;
	/* Write address */

	widr_multi_any ((char *)(&object), 1);
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

rt_public long get_offset(uint32 o_type, uint32 attrib_num)
{
#ifndef WORKBENCH
	return ((System(o_type).cn_offsets[attrib_num])[o_type]);
#else
	int32 rout_id;				/* Attribute routine id */
	long offset;

	rout_id = System(o_type).cn_attr[attrib_num];
	CAttrOffs(offset,rout_id,o_type);
	return offset;
#endif
}

rt_public long get_alpha_offset(uint32 o_type, uint32 attrib_num)
{
	/* Get the offset for attribute number `attrib_num' (after alphabetical sort) */

#ifdef WORKBENCH
	int32 rout_id;				/* Attribute routine id */
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


rt_private void gen_object_write(char *object)
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
						/* int q;*/ /* %%ss removed unused */
						struct bit *bptr = (struct bit *)(object + attrib_offset);
						buffer_write((char *)(&(HEADER(bptr)->ov_flags)), sizeof(uint32));
						buffer_write((char *)(&(bptr->b_length)), sizeof(uint32));
						buffer_write((char *) (bptr->b_value), bptr->b_length);
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
			 *	"dtype visible_name size nb_generics {meta_type}+"
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
						buffer_write(object, count*sizeof(EIF_INTEGER));
						break;
					case SK_BOOL:
					case SK_CHAR:
						buffer_write(object, count*sizeof(EIF_CHARACTER));
						break;
					case SK_FLOAT:
						buffer_write(object, count*sizeof(EIF_REAL));
						break;
					case SK_DOUBLE:
						buffer_write(object, count*sizeof(EIF_DOUBLE));
						break;
					case SK_BIT:
						dgen_typ = dgen & SK_DTYPE;
						elem_size = *(long *) (o_ptr + sizeof(long));

/*FIXME: header for each object ????*/
						buffer_write(object, count*elem_size); /* %%ss arg1 was cast (struct bit *) */
						break;
					case SK_EXP:
						elem_size = *(long *) (o_ptr + sizeof(long));
						buffer_write((char *) (&(HEADER(object + OVERHEAD)->ov_flags)), sizeof(uint32));
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
					buffer_write((char *)(&(HEADER(object)->ov_flags)), sizeof(uint32));
					for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
						gen_object_write(ref);
					}
				}
			}
		} 
	}
}


rt_private void object_write(char *object)
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
					widr_multi_int ((long int *)(object + attrib_offset), 1);

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
					widr_multi_float ((float *)(object + attrib_offset), 1);

					break;
				case SK_DOUBLE:
#if DEBUG &1
					printf (" %lf", *((double *)(object + attrib_offset)));
#endif
					widr_multi_double ((double *)(object + attrib_offset), 1);

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
						widr_norm_int (&(HEADER(bptr)->ov_flags));	/* %%zs misuse, removed ",1" */
						widr_multi_bit (bptr, 1, bptr->b_length, 0);
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
			 *	"dtype visible_name size nb_generics {meta_type}+"
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
						widr_norm_int (&(HEADER (object + OVERHEAD)->ov_flags));		/* %%zs misuse, removed ",1" */
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
					widr_norm_int (&(HEADER (object)->ov_flags));	/* %%zs misuse, removed ",1" */
					for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
						object_write(ref);
					}
				}
			}
		} 
	}
}



rt_private void make_header(void)
{
	/* Generate header for stored hiearchy retrivable by other systems. */
	int i;
	char *vis_name;			/* Visible name of a class */
	struct gt_info *info;
	int nb_line = 0;
	int bsize = 80;
	jmp_buf exenv;
	RTXD;

	excatch((char *) exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		RTXSC;					/* Restore stack contexts */
		st_clean();				/* Clean data structure */
		ereturn();				/* Propagate exception */
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
			 *	"dtype visible_name size nb_generics {meta_type}+"
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
			 *	"dtype visible_name size 0"
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

rt_public void sort_attributes(int dtype)
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
			xfree((char *)s_attr);
			sorted_attributes[dtype] = (unsigned int*)0;
			}
		}
}

rt_private void imake_header(void)
{
	/* Generate header for stored hiearchy retrivable by other systems. */
	int i;
	char *vis_name;			/* Visible name of a class */
	struct gt_info *info;
	int nb_line = 0;
	int bsize = 600;
	uint32 num_attrib;
	jmp_buf exenv;
	RTXD;

	excatch((char *) exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		RTXSC;					/* Restore stack contexts */
		st_clean();				/* Clean data structure */
		ereturn();				/* Propagate exception */
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
			 *	"dtype visible_name size nb_generics {meta_type}+"
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
			 *	"dtype visible_name size 0"
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


rt_private void st_clean(void)
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

rt_public void free_sorted_attributes(void)
{
	unsigned int i;
	unsigned int *s_attr;

	if (sorted_attributes != (unsigned int **)0){
#ifdef DEBUG_GENERAL_STORE
printf ("free_sorted_attributes %lx\n", sorted_attributes);
#endif
		for (i=0; i < scount; i++)
			if ((s_attr = sorted_attributes[i])!= (unsigned int *)0){
				xfree((char *)s_attr);
#ifdef DEBUG_GENERAL_STORE
printf ("Free s_attr (%d) %lx\n", i, s_attr);
#endif
				}
		sorted_attributes = (unsigned int **)0;
	}
}

rt_public void buffer_write(register char *data, int size)
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

rt_public void flush_st_buffer (void)
{
	if (current_position != 0)
		store_write_func ();
}


void store_write(void)
{
	char* cmps_in_ptr = (char *)0;
	char* cmps_out_ptr = (char *)0;
	int cmps_in_size = 0;
	int cmps_out_size = 0;
	register char * ptr = (char *)0;
	register int number_left = 0;
	int send_size = 0;
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
	send_size = cmps_out_size + EIF_CMPS_HEAD_SIZE;
 
	while (number_left > 0) {
#ifdef EIF_WIN32
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

	if (ptr - cmps_general_buffer == cmps_out_size + EIF_CMPS_HEAD_SIZE)
		current_position = 0;
	else
		eio();
}

