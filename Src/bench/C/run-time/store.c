/*

  ####    #####   ####   #####   ######           ####
 #          #    #    #  #    #  #               #    #
  ####      #    #    #  #    #  #####           #
	  #     #    #    #  #####   #        ###    #
 #    #     #    #    #  #   #   #        ###    #    #
  ####      #     ####   #    #  ######   ###     ####

	Eiffel storing mechanism.
*/
#include "eif_portable.h"
#include "eif_project.h" /* for egc_ce_gtype */
#include "rt_macros.h"
#include "rt_malloc.h"
#include "eif_except.h"
#include "eif_store.h"
#include "eif_traverse.h"
#include "eif_except.h"
#include "eif_cecil.h"
#include <stdio.h>
#include "eif_struct.h"
#include "eif_bits.h"
#include "eif_plug.h"
#include "eif_run_idr.h"
#include "eif_error.h"
#include "eif_main.h"
#include "rt_compress.h"
#include "eif_lmalloc.h"
#include "x2c.h"	/* For macro LNGPAD */
#ifdef VXWORKS
#include <unistd.h>	/* For write () */
#endif
#include "rt_assert.h"


#ifdef EIF_WIN32
#include <io.h>
#endif

#include <string.h>				/* For strlen() */

/*#define DEBUG_GENERAL_STORE */	/**/

/*#define DEBUG 1 */	/**/

/* compression */
#define EIF_BUFFER_SIZE EIF_CMPS_IN_SIZE
#define EIF_BUFFER_ALLOCATED_SIZE EIF_DCMPS_OUT_SIZE
#define EIF_CMPS_BUFFER_ALLOCATED_SIZE EIF_CMPS_OUT_SIZE

rt_public char* cmps_general_buffer = (char *) 0;

rt_public char *general_buffer = (char *) 0;
rt_public int current_position = 0;
rt_public long buffer_size = 0;
rt_public long cmp_buffer_size = 0;
rt_public int end_of_buffer = 0;
rt_private char *s_buffer = (char *) 0;

#ifndef EIF_THREADS
rt_private int s_fides;	/* File descriptor used during the storing process */
#endif /* EIF_THREADS */

/*
 * Function declarations
 */
rt_shared void internal_store(char *object);
rt_private void st_store(char *object);				/* Second pass of the store */
rt_public void ist_write(char *object);
rt_public void gst_write(char *object);
rt_public void make_header(void);				/* Make header */
rt_public void imake_header(void);				/* Make header */
rt_private void object_write (char *object);
rt_private void gen_object_write (char *object);
rt_private void st_write_cid (uint32);
rt_private void ist_write_cid (uint32);
rt_public long get_offset (uint32 o_type, uint32 attrib_num);
rt_public long get_alpha_offset (uint32 o_type, uint32 attrib_num);
rt_public void store_write(void);
rt_public void free_sorted_attributes(void);
rt_public void allocate_gen_buffer(void);
rt_public void buffer_write(register char *data, int size);

rt_public void rt_reset_store (void);
rt_public void rt_init_store(
	void (*store_function) (void),
	int (*char_write_function)(char *, int),
	void (*flush_buffer_function) (void),
	void (*st_write_function) (char *),
	void (*make_header_function) (void),
	int accounting_type);

rt_public void (*store_write_func)(void);
rt_public int (*char_write_func)(char *, int);
rt_public void (*flush_buffer_func)(void);
rt_public void (*st_write_func)(char *);
rt_public void (*make_header_func)(void);

rt_public void (*old_store_write_func)(void);
rt_public int (*old_char_write_func)(char *, int);
rt_public void (*old_flush_buffer_func)(void);
rt_public void (*old_st_write_func)(char *);
rt_public void (*old_make_header_func)(void);

rt_private int accounting = 0;
rt_private int old_accounting = 0;

rt_private long old_buffer_size = 0;

rt_public EIF_BOOLEAN eif_is_new_independent_format = EIF_TRUE;

/*
 * Shared data declarations
 */
rt_shared char *account = (char *) 0;	/* Array of traversed dyn types */
rt_shared unsigned int **sorted_attributes = (unsigned int **) 0;	/* Array of sorted attributes */

/* Declarations to work with streams */
rt_private char *stream_buffer;
rt_private int stream_buffer_position;
rt_private long stream_buffer_size;

/* Functions to write on the specified IO_MEDIUM */
rt_public  int char_write (char *, int);
rt_private int stream_write (char *, int);


#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

/* Convenience functions */

/* Set the default buffer_size to a certain value */
rt_public void set_buffer_size (int new_size) 
{
	buffer_size = new_size;
}

/* Initialize store function pointers and globals */
/* reset buffer size if argument is non null */
rt_public void rt_init_store(
	void (*store_function) (void),
	int (*char_write_function)(char *, int),
	void (*flush_buffer_function) (void),
	void (*st_write_function) (char *),
	void (*make_header_function) (void),
	int accounting_type)
{
	old_store_write_func = store_write_func;
	old_char_write_func = char_write_func;
	old_flush_buffer_func = flush_buffer_func;
	old_st_write_func = st_write_func;
	old_make_header_func = make_header_func;
	old_accounting = accounting;
	old_buffer_size = buffer_size;

	store_write_func = store_function;
	char_write_func = char_write_function;
	flush_buffer_func = flush_buffer_function;
	st_write_func = st_write_function;
	make_header_func = make_header_function;
	accounting = accounting_type;
	buffer_size = EIF_BUFFER_SIZE;
}

/* Reset store function pointers and globals to their default values */

rt_public void rt_reset_store(void) {
	store_write_func = old_store_write_func;
	char_write_func = old_char_write_func;
	flush_buffer_func = old_flush_buffer_func;
	st_write_func = old_st_write_func;
	make_header_func = old_make_header_func;
	accounting = old_accounting;
	buffer_size = old_buffer_size;

	if (s_buffer != (char *) 0) {
		xfree(s_buffer);
		s_buffer = (char *) 0;
	}
	if (account != (char *) 0) {
		xfree(account);
		account = (char *) 0;
	}

	free_sorted_attributes();

	if (idr_temp_buf != (char *) 0) {
		xfree(idr_temp_buf);
		idr_temp_buf = (char *) 0;
	}
}

/* Functions definitions */

/* Basic store */
/* Store object hierarchy of root `object' without header. */
rt_public void estore(EIF_INTEGER file_desc, char *object)
{
	EIF_GET_CONTEXT
	s_fides = (int) file_desc;

	rt_init_store (
		store_write,
		char_write,
		flush_st_buffer,
		st_write,
		make_header,
		0);

	allocate_gen_buffer();
	internal_store(object);

	rt_reset_store ();
}

rt_public long stream_estore(char **buffer, long size, char *object, EIF_INTEGER *real_size)
{
	rt_init_store (
		store_write,
		stream_write,
		flush_st_buffer,
		st_write,
		make_header,
		0);

	stream_buffer = *buffer;
	stream_buffer_size = size;
	stream_buffer_position = 0;

	allocate_gen_buffer();
	internal_store(object);

	*buffer = stream_buffer;
	rt_reset_store ();
	*real_size = stream_buffer_position;
	return stream_buffer_size;
}

rt_public void basic_general_free_store (char *object)
{
	allocate_gen_buffer();
	internal_store(object);
}

/* General store */
/* Store object hierarchy of root `object' and produce a header
 * so it can be retrieved by other systems. */
rt_public void eestore(EIF_INTEGER file_desc, char *object)
{
	EIF_GET_CONTEXT
	s_fides = (int) file_desc;

	rt_init_store (
		store_write,
		char_write,
		flush_st_buffer,
		gst_write,
		make_header,
		TR_ACCOUNT);

	allocate_gen_buffer();
	internal_store(object);

	rt_reset_store ();
}

rt_public long stream_eestore(char **buffer, long size, char *object, EIF_INTEGER *real_size)
{
	rt_init_store (
		store_write,
		stream_write,
		flush_st_buffer,
		gst_write,
		make_header,
		TR_ACCOUNT);

	stream_buffer = *buffer;
	stream_buffer_size = size;
	stream_buffer_position = 0;
	
	allocate_gen_buffer();
	internal_store(object);
	*buffer = stream_buffer;

	rt_reset_store ();
	*real_size = stream_buffer_position;
	return stream_buffer_size;
}

/* Independent store */
/* Use file decscriptor so sockets and files can be used for storage
 * Store object hierarchy of root `object' and produce a header
 * so it can be retrieved by other systems. */
rt_public void sstore (EIF_INTEGER file_desc, char *object)
{
	EIF_GET_CONTEXT
	s_fides = (int) file_desc;

	rt_init_store (
		(void (*)(void)) 0,
		char_write,
		idr_flush,
		ist_write,
		imake_header,
		INDEPEND_ACCOUNT);

		/* Initialize serialization streams for writting (1 stands for write) */
	run_idr_init (buffer_size, 1);
	idr_temp_buf = (char *) xmalloc (48, C_T, GC_OFF);

	internal_store(object);

	run_idr_destroy ();
	xfree (idr_temp_buf);
	idr_temp_buf = (char *)0;

	rt_reset_store ();
}

rt_public long stream_sstore (char **buffer, long size, char *object, EIF_INTEGER *real_size)
{
	rt_init_store (
		(void (*)(void)) 0,
		stream_write,
		idr_flush,
		ist_write,
		imake_header,
		INDEPEND_ACCOUNT);

	stream_buffer = *buffer;
	stream_buffer_size = size;
	stream_buffer_position = 0;

		/* Initialize serialization streams for writting (1 stands for write) */
	run_idr_init (buffer_size, 1);
	idr_temp_buf = (char *) xmalloc (48, C_T, GC_OFF);
	
	internal_store(object);

	run_idr_destroy ();
	xfree (idr_temp_buf);
	idr_temp_buf = (char *)0;

	*buffer = stream_buffer;
	rt_reset_store ();
	*real_size = stream_buffer_position;
	return stream_buffer_size;
}

rt_public void independent_free_store (char *object)
{
		/* Initialize serialization streams for writting (1 stands for write) */
	run_idr_init (buffer_size, 1);
	idr_temp_buf = (char *) xmalloc (48, C_T, GC_OFF);

	internal_store(object);

	run_idr_destroy ();
	xfree (idr_temp_buf);
	idr_temp_buf = (char *)0;
}

/* Stream allocation */
rt_public char **stream_malloc (int stream_size)	/*08/04/98*/
{
	char *buffer;
	char **real_buffer;

	buffer = (char *) eif_malloc(stream_size);
	if (buffer == (char *) 0) 
		enomem ();
	else {
		real_buffer = (char **) eif_malloc (sizeof (char *));
		if (real_buffer == (char **) 0)
			enomem ();
		else
			*real_buffer = buffer;
			return real_buffer;
	}
	return (char **) 0;		/* NOTREACHED */
}

/* Stream deallocation */
rt_public void stream_free (char **real_buffer)	/*08/04/98*/
{
	eif_free(*real_buffer);
	eif_free(real_buffer);
}

rt_public void allocate_gen_buffer (void)
{
	if (general_buffer == (char *) 0) {
		general_buffer = (char *) xmalloc (buffer_size * sizeof (char), C_T, GC_OFF);
		if (general_buffer == (char *) 0)
			eraise ("Out of memory for general_buffer creation", EN_PROG);
	
			/* compression */
		{
		  		/* Compute size of a compression block. It has to be the size of
				 * what we want to compress plus 6 bytes for the header and 1 bit
				 * for every 8 bytes. */
			size_t length = buffer_size * sizeof(char);
			cmp_buffer_size = (length * 9) / 8 + 1 + EIF_CMPS_HEAD_SIZE;
			cmps_general_buffer = (char *) xmalloc (cmp_buffer_size, C_T, GC_OFF);
			if (cmps_general_buffer == (char *) 0)
				eraise ("out of memory for cmps_general_buffer creation", EN_PROG);
		}
	}

	current_position = 0;
	end_of_buffer = 0;
}

rt_shared void internal_store(char *object)
{
	/* Store object hierarchy of root `object' in file `file_ptr' and
	 * produce header if `accounting'.
	 */
	char c;

	if (accounting) {		/* Prepare character array */
		account = (char *) xmalloc(scount * sizeof(char), C_T, GC_OFF);
		if (account == (char *) 0)
			xraise(EN_MEM);
		memset (account, 0, scount * sizeof(char));
		if (accounting == INDEPEND_ACCOUNT) {
			if (eif_is_new_independent_format) {
				c = INDEPENDENT_STORE_5_0;
				rt_kind_version = INDEPENDENT_STORE_5_0;
			} else {
				c = INDEPENDENT_STORE_4_4;
				rt_kind_version = INDEPENDENT_STORE_4_4;
			}
		}
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
			memset (sorted_attributes, 0, scount * sizeof(unsigned int *));
		}
	} else
		c = BASIC_STORE_4_0;

	/* Write the kind of store */
	if (char_write_func(&c, sizeof(char)) < 0){
		if (accounting) {
			xfree(account);
			if (c==GENERAL_STORE_4_0)
					/* sorted_attributes is empty so a basic free is enough */
				xfree((char *)sorted_attributes);
				sorted_attributes = (unsigned int **) 0;
			}
		eise_io("Store: unable to write the kind of storable.");
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
	/* Write the count of stored objects */
	if (accounting == INDEPEND_ACCOUNT)
		widr_multi_int32 (&obj_nb, 1);
	else
		buffer_write((char *)(&obj_nb), sizeof(long));

#if DEBUG & 3
		printf (" %lx", obj_nb);
#endif

	st_store(object);		/* Write objects to be stored */

	flush_buffer_func();	/* flush the buffer */
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

	/* Map generic type id to its base id */
	flags = Mapped_flags(flags);

	/* Evaluation of the number of references of the object */
	if (flags & EO_SPEC) {					/* Special object */
		if (!(flags & EO_REF)) {			/* Special of simple types */
		} else {
			long count, elem_size;
			char *ref;

			o_ptr = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD_2);
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
	/* Write an object'.
	 * Use for basic and general (before 3.3) store
	 */

	register2 union overhead *zone;
	uint32 flags, fflags;
	register1 uint32 nb_char;

	zone = HEADER(object);
	fflags = zone->ov_flags;
	flags = Mapped_flags(fflags);

	/* Write address */

	buffer_write((char *)(&object), sizeof(char *));
	buffer_write((char *)(&flags), sizeof(uint32));
	st_write_cid (fflags & EO_TYPE);

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
		nb_char = EIF_Size((uint16)(flags & EO_TYPE));
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

rt_public void gst_write(char *object)
{
	/* Write an object.
	 * used for general store
	 */

	register2 union overhead *zone;
	uint32 flags, fflags;
	/*register1 uint32 nb_char;*/ /* %%ss removed unused */

	zone = HEADER(object);
	fflags = zone->ov_flags;
	flags = Mapped_flags(fflags);

	/* Write address */

	buffer_write((char *)(&object), sizeof(char *));
	buffer_write((char *)(&flags), sizeof(uint32));
	st_write_cid (fflags & EO_TYPE);

#if DEBUG & 1
		printf ("\n %lx", object);
		printf (" %lx", flags);
#endif

	if (flags & EO_SPEC) {
		char * o_ptr;
		uint32 count, elm_size;
		o_ptr = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD_2);
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

rt_public void ist_write(char *object)
{
	/* Write an object.
	 * used for independent store
	 */

	register2 union overhead *zone;
	uint32 flags, fflags;
	/* register1 uint32 nb_char;*/ /* %%ss removed unused */

	zone = HEADER(object);
	fflags = zone->ov_flags;
	flags = Mapped_flags(fflags);

	/* Write address */

	widr_multi_any ((char *)(&object), 1);
	widr_norm_int (&flags);
	ist_write_cid (fflags & EO_TYPE);

#if DEBUG & 1
		printf ("\n %lx", object);
		printf (" %lx", flags);
#endif

	if (flags & EO_SPEC) {
		char * o_ptr;
		uint32 count, elm_size;
		o_ptr = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD_2);
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
	return (System(o_type).cn_offsets[attrib_num]);
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
	return (System(o_type).cn_offsets[alpha_attrib_num]);
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
	/* int z;*/ /* %%ss removed */
	uint32 o_type;
	uint32 num_attrib;
	uint32 fflags = HEADER(object)->ov_flags;
	uint32 flags, hflags, hfflags;

	flags = Mapped_flags(fflags);
	o_type = flags & EO_TYPE;
	num_attrib = System(o_type).cn_nbattr;

	if (num_attrib > 0) {
		for (; num_attrib > 0;) {
			attrib_offset = get_alpha_offset(o_type, --num_attrib);
			switch (*(System(o_type).cn_types + num_attrib) & SK_HEAD) {
				case SK_INT8:
					buffer_write(object + attrib_offset, sizeof(EIF_INTEGER_8));
					break;
				case SK_INT16:
					buffer_write(object + attrib_offset, sizeof(EIF_INTEGER_16));
					break;
				case SK_INT32:
					buffer_write(object + attrib_offset, sizeof(EIF_INTEGER_32));
					break;
				case SK_INT64:
					buffer_write(object + attrib_offset, sizeof(EIF_INTEGER_64));
					break;
				case SK_WCHAR:
					buffer_write(object + attrib_offset, sizeof(EIF_WIDE_CHAR));
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
						hfflags = HEADER(bptr)->ov_flags;
						hflags = Mapped_flags(hfflags);
						buffer_write((char *)(&hflags), sizeof(uint32));
						st_write_cid (hfflags & EO_TYPE);
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
					eise_io("General store: not an Eiffel object.");
			}
		} 
	} else {
		if (flags & EO_SPEC) {		/* Special object */
			long count, elem_size;
			char *ref, *o_ptr;
			char *vis_name;
			uint32 dgen;
			int16 *gt_type;
			int32 *gt_gen;
			int nb_gen;
			struct gt_info *info;

			o_ptr = (char *) (object + (HEADER(object)->ov_size & B_SIZE) - LNGPAD_2);
			count = *(long *) o_ptr;
			vis_name = System(o_type).cn_generator;


			info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
			CHECK ("Must be a generic type", info != (struct gt_info *) 0);

			/* Generic type, write in file:
			 *	"dtype visible_name size nb_generics {meta_type}+"
			 */
			gt_type = info->gt_type;
			nb_gen = info->gt_param;

			for (;;) {
				if ((*gt_type++ & SK_DTYPE) == (int16) o_type)
					break;
			}
			gt_type--;
			gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
			dgen = *gt_gen;

	
			if (!(flags & EO_REF)) {		/* Special of simple types */
				switch (dgen & SK_HEAD) {
					case SK_INT8:
						buffer_write(object, count*sizeof(EIF_INTEGER_8));
						break;
					case SK_INT16:
						buffer_write(object, count*sizeof(EIF_INTEGER_16));
						break;
					case SK_INT32:
						buffer_write(object, count*sizeof(EIF_INTEGER_32));
						break;
					case SK_INT64:
						buffer_write(object, count*sizeof(EIF_INTEGER_64));
						break;
					case SK_WCHAR:
						buffer_write(object, count*sizeof(EIF_WIDE_CHAR));
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
						elem_size = *(long *) (o_ptr + sizeof(long));

/*FIXME: header for each object ????*/
						buffer_write(object, count*elem_size); /* %%ss arg1 was cast (struct bit *) */
						break;
					case SK_EXP:
						elem_size = *(long *) (o_ptr + sizeof(long));
						hfflags = HEADER(object + OVERHEAD)->ov_flags;
						hflags = Mapped_flags(hfflags);
						buffer_write((char *) (&hflags), sizeof(uint32));
						st_write_cid (hfflags & EO_TYPE);

						for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
							gen_object_write(ref);
						}
						break;
					case SK_POINTER:
						buffer_write(object, count*sizeof(EIF_POINTER));
						break;
					default:
						eise_io("General store: not an Eiffel object.");
						break;
				}
			} else {
				if (!(flags & EO_COMP)) {	/* Special of references */
					buffer_write(object, count*sizeof(EIF_REFERENCE));
				} else {			/* Special of composites */
					hfflags = HEADER(object)->ov_flags;
					hflags = Mapped_flags(hfflags);
					elem_size = *(long *) (o_ptr + sizeof(long));
					buffer_write((char *)(&hflags), sizeof(uint32));
					st_write_cid (hfflags & EO_TYPE);
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
#if DEBUG &1
	int z; /* %%ss added #if .. #endif */
#endif
	uint32 o_type;
	uint32 num_attrib;
	uint32 fflags = HEADER(object)->ov_flags;
	uint32 flags, hflags, hfflags;

	flags = Mapped_flags(fflags);
	o_type = flags & EO_TYPE;
	num_attrib = System(o_type).cn_nbattr;

	if (num_attrib > 0) {
		for (; num_attrib > 0;) {
			attrib_offset = get_offset(o_type, --num_attrib);
			switch (*(System(o_type).cn_types + num_attrib) & SK_HEAD) {
				case SK_INT8:
					widr_multi_int8 ((EIF_INTEGER_8 *)(object + attrib_offset), 1);
					break;
				case SK_INT16:
					widr_multi_int16 ((EIF_INTEGER_16 *)(object + attrib_offset), 1);
					break;
				case SK_INT32:
					widr_multi_int32 ((EIF_INTEGER_32 *)(object + attrib_offset), 1);
					break;
				case SK_INT64:
					widr_multi_int64 ((EIF_INTEGER_64 *)(object + attrib_offset), 1);
					break;
				case SK_BOOL:
				case SK_CHAR:
					widr_multi_char ((EIF_CHARACTER *) (object + attrib_offset), 1);
					break;
				case SK_WCHAR:
					widr_multi_int32 ((EIF_INTEGER_32 *) (object + attrib_offset), 1);
					break;
				case SK_FLOAT:
					widr_multi_float ((EIF_REAL *)(object + attrib_offset), 1);
					break;
				case SK_DOUBLE:
					widr_multi_double ((EIF_DOUBLE *)(object + attrib_offset), 1);
					break;
				case SK_BIT:
					{
						struct bit *bptr = (struct bit *)(object + attrib_offset);
#if DEBUG &1
						int q;
						printf (" %x", bptr->b_length);
						printf (" %x", HEADER(bptr)->ov_flags);
						for (q = 0; q < BIT_NBPACK(LENGTH(bptr)) ; q++) {
							printf (" %lx", *((uint32 *)(bptr->b_value + q)));
							if (!(q % 40))
								printf ("\n");
						}
#endif
						hfflags = HEADER(bptr)->ov_flags;
						hflags = Mapped_flags(hfflags);
						widr_norm_int (&hflags);	/* %%zs misuse, removed ",1" */
						ist_write_cid (hfflags & EO_TYPE);
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
					eise_io("Basic store: not an Eiffel object.");
			}
		} 
	} else {
		if (flags & EO_SPEC) {		/* Special object */
			long count, elem_size;
			char *ref, *o_ptr;
			char *vis_name;
			uint32 dgen, dgen_typ;
			int16 *gt_type;
			int32 *gt_gen;
			int nb_gen;
			struct gt_info *info;

			o_ptr = (char *) (object + (HEADER(object)->ov_size & B_SIZE) - LNGPAD_2);
			count = *(long *) o_ptr;
			vis_name = System(o_type).cn_generator;


			info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
			CHECK ("Must be a generic type", info != (struct gt_info *) 0);

			/* Generic type, write in file:
			 *	"dtype visible_name size nb_generics {meta_type}+"
			 */
			gt_type = info->gt_type;
			nb_gen = info->gt_param;

			for (;;) {
#if DEBUG &1
				if (*gt_type == SK_INVALID)
					eif_panic("corrupted cecil table");
#endif
				if ((*gt_type++ & SK_DTYPE) == (int16) o_type)
					break;
			}
			gt_type--;
			gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
			dgen = *gt_gen;
	
			if (!(flags & EO_REF)) {		/* Special of simple types */
				switch (dgen & SK_HEAD) {
					case SK_INT8:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((EIF_INTEGER_8 *)object) + z));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_int8 (((EIF_INTEGER_8 *)object), count);
						break;
					case SK_INT16:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((EIF_INTEGER_16 *)object) + z));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_int16 (((EIF_INTEGER_16 *)object), count);
						break;
					case SK_INT32:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((EIF_INTEGER_32 *)object) + z));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_int32 (((EIF_INTEGER_32 *)object), count);
						break;
					case SK_INT64:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((EIF_INTEGER_64 *)object) + z));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_int64 (((EIF_INTEGER_64 *)object), count);
						break;
					case SK_BOOL:
					case SK_CHAR:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %lx", *((EIF_CHARACTER *)(object + z)));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_char ((EIF_CHARACTER *) object, count);
						break;
					case SK_WCHAR:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %lx", *((EIF_CHARACTER *)(object + z)));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_int32 ((EIF_INTEGER_32 *) object, count);
						break;
					case SK_FLOAT:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %f", *(((EIF_REAL *)object) + z));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_float ((EIF_REAL *)object, count);
						break;
					case SK_DOUBLE:
#if DEBUG &1
						for (z = 0; z < count; z++) {
							printf (" %lf", *(((EIF_DOUBLE *)object) + z));
							if (!(z % 40))
								printf("\n");
						}
#endif
						widr_multi_double ((EIF_DOUBLE *)object, count);
						break;
					case SK_BIT:
						dgen_typ = dgen & SK_DTYPE;
						elem_size = *(long *) (o_ptr + sizeof(long));
#if DEBUG &1
						printf (" %x", dgen_typ);
						for (ref = object; count > 0; count--, ref += elem_size) {
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
						hfflags = HEADER(object + OVERHEAD)->ov_flags;
						hflags = Mapped_flags(hfflags);
						widr_norm_int (&hflags);		/* %%zs misuse, removed ",1" */
						ist_write_cid (hfflags & EO_TYPE);

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
						eise_io("Basic store: not an Eiffel object.");
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
					hfflags = HEADER(object)->ov_flags;
					hflags = Mapped_flags(hfflags);
					widr_norm_int (&hflags);	/* %%zs misuse, removed ",1" */
					ist_write_cid (hflags & EO_TYPE);

					for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
						object_write(ref);
					}
				}
			}
		} 
	}
}



rt_public void make_header(EIF_CONTEXT_NOARG)
{
	/* Generate header for stored hiearchy retrivable by other systems. */
	EIF_GET_CONTEXT
	int i;
	char *vis_name;			/* Visible name of a class */
	struct gt_info *info;
	volatile int nb_line = 0;
	volatile size_t bsize = 80;
	jmp_buf exenv;
	RTXD;

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		RTXSC;					/* Restore stack contexts */
		rt_reset_store ();				/* Reset data structure */
		ereturn(MTC_NOARG);				/* Propagate exception */
	}

	s_buffer = (char *) xmalloc (bsize * sizeof( char), C_T, GC_OFF);
	/* Write maximum dynamic type */
	if (0 > sprintf(s_buffer,"%d\n", scount)) {
		eise_io("General store: unable to write number of different Eiffel types.");
	}
	buffer_write(s_buffer, (strlen (s_buffer)));
	

	for (i=0; i<scount; i++)
		if (account[i])
			nb_line++;
	/* Write number of header lines */
	if (0 > sprintf(s_buffer,"%d\n", nb_line)) {
		eise_io("General store: unable to write number of header lines.");
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

		info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
		if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, write in file:
			 *	"dtype visible_name size nb_generics {meta_type}+"
			 */
			int16 *gt_type = info->gt_type;
			int32 *gt_gen;
			int nb_gen = info->gt_param;
			int j;

			if (0 > sprintf(s_buffer, "%d %s %ld %d", i, vis_name, EIF_Size(i), nb_gen)) {
				eise_io("General store: unable to write the generic type name.");
			}

			buffer_write(s_buffer, (strlen (s_buffer)));

			for (;;) {
#if DEBUG &1
				if (*gt_type == SK_INVALID)
					eif_panic("corrupted cecil table");
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
					eise_io("General store: unable to write the generic type description.");
				}
				buffer_write(s_buffer, (strlen (s_buffer)));
			}
		} else {
			/* Non-generic type, write in file:
			 *	"dtype visible_name size 0"
			 */
			if (0 > sprintf(s_buffer, "%d %s %ld 0", i, vis_name, EIF_Size(i))) {
				eise_io("General store: unable to write type description.");
			}
			buffer_write(s_buffer, (strlen (s_buffer)));
		}
		if (0 > sprintf(s_buffer,"\n")) {
			eise_io("General store: unable to write new header entry.");
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

	unsigned long attr_nb;
	unsigned long j;

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

rt_public void imake_header(EIF_CONTEXT_NOARG)
{
	/* Generate header for stored hiearchy retrivable by other systems. */
	EIF_GET_CONTEXT
	int i;
	char *vis_name;			/* Visible name of a class */
	struct gt_info *info;
	volatile int nb_line = 0;
	volatile size_t bsize = 600;
	uint32 num_attrib;
	jmp_buf exenv;
	RTXD;

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		RTXSC;					/* Restore stack contexts */
		rt_reset_store ();				/* Clean data structure */
		ereturn(MTC_NOARG);				/* Propagate exception */
	}

	s_buffer = (char *) xmalloc (bsize * sizeof( char), C_T, GC_OFF);
	/* Write maximum dynamic type */
	if (0 > sprintf(s_buffer,"%d\n", scount)) {
		eise_io("Independent store: unable to write number of different Eiffel types.");
	}
	widr_multi_char ((EIF_CHARACTER *) s_buffer, (strlen (s_buffer)));
	
	if (0 > sprintf(s_buffer,"%d\n", (int) OVERHEAD)) {
		eise_io("Independent store: unable to write OVERHEAD size.");
	}
	widr_multi_char ((EIF_CHARACTER *) s_buffer, (strlen (s_buffer)));

	for (i=0; i<scount; i++)
		if (account[i])
			nb_line++;
	/* Write number of header lines */
	if (0 > sprintf(s_buffer,"%d\n", nb_line)) {
		eise_io("Independent store: unable to write number of header lines.");
	}
	widr_multi_char ((EIF_CHARACTER *) s_buffer, (strlen (s_buffer)));

	for (i=0; i<scount; i++) {
		if (!account[i])
			continue;				/* No object of dyn. type `i'.	*/
		/* vis_name = Visible(i) */;/* Visible name of the dyn. type */
		vis_name = System(i).cn_generator;

		if (bsize < (strlen (vis_name) + sizeof (long) + 2 * sizeof (int) + 6)) {
			bsize = (strlen (vis_name) + sizeof (long) + 2 * sizeof (int) + 6);
			s_buffer = (char *) xrealloc (s_buffer, bsize, GC_OFF);
		}

		info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
		if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, write in file:
			 *	"dtype visible_name size nb_generics {meta_type}+"
			 */
			int16 *gt_type = info->gt_type;
			int32 *gt_gen;
			int nb_gen = info->gt_param;
			int j;

			if (0 > sprintf(s_buffer, "%d %s %d", i, vis_name, nb_gen)) {
				eise_io("Independent store: unable to write the generic type name.");
			}

			widr_multi_char ((EIF_CHARACTER *) s_buffer, (strlen (s_buffer)));

			for (;;) {
#if DEBUG &1
				if (*gt_type == SK_INVALID)
					eif_panic("Corrupted cecil table");
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
					eise_io("Independent store: unable to write the generic type description.");
				}
				widr_multi_char ((EIF_CHARACTER *) s_buffer, (strlen (s_buffer)));
			}
		} else {
			/* Non-generic type, write in file:
			 *	"dtype visible_name size 0"
			 */
			if (0 > sprintf(s_buffer, "%d %s 0", i, vis_name)) {
				eise_io("Independent store: unable to write type description.");
			}
			widr_multi_char ((EIF_CHARACTER *) s_buffer, (strlen (s_buffer)));
		}
		
				/* also add 
				 * "num_attributes attib_type +"
				 */

		num_attrib = System(i).cn_nbattr;
		if (0 > sprintf(s_buffer, " %d", num_attrib)) {
			eise_io("Independent store: unable to write number of attributes.");
		}
		widr_multi_char ((EIF_CHARACTER *) s_buffer, (strlen (s_buffer)));
		for (; num_attrib-- > 0;) {
			if (0 > sprintf(s_buffer, "\n%lu %s", (unsigned long) (*(System(i).cn_types + num_attrib) & SK_HEAD), 
					*(System(i).cn_names + num_attrib))) {
				eise_io("Independent store: unable to write attribute description.");
			}
			widr_multi_char ((EIF_CHARACTER *) s_buffer, (strlen (s_buffer)));
		}	
		if (0 > sprintf(s_buffer,"\n")) {
			eise_io("Independent store: unable to write new header entry.");
		}
		widr_multi_char ((EIF_CHARACTER *) s_buffer, (strlen (s_buffer)));
	}
	xfree (s_buffer);
	s_buffer = (char *) 0;
	expop(&eif_stack);
}

rt_public void free_sorted_attributes(void)
	/* Free the memory allocated for `sorted_attributes'. */
{
	int i;
	unsigned int *s_attr;

	if (sorted_attributes != (unsigned int **)0) {
#ifdef DEBUG_GENERAL_STORE
printf ("free_sorted_attributes %lx\n", sorted_attributes);
#endif
		for (i=0; i < scount; i++)
			if ((s_attr = sorted_attributes[i])!= (unsigned int *) 0) {
				xfree((char *) s_attr);
#ifdef DEBUG_GENERAL_STORE
printf ("Free s_attr (%d) %lx\n", i, s_attr);
#endif
			}
		xfree((char *) sorted_attributes);
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

/* Bufferization of information on buffer. If the buffer is full
 * we write the buffer on IO_MEDIUM and flush the buffer so we can
 * do another write operation */
rt_public void new_buffer_write(register char *data, int size)
{
	if (current_position + size >= buffer_size) {
			/* Copy the data buffer into the general_buffer until the last one is full
			 * launch a writing operation on the IO_MEDIUM and do a recursive call to
			 * finish the writing of data */
		memcpy (general_buffer + current_position, data, buffer_size - current_position);
		current_position = buffer_size;
		store_write_func ();
			/* Recursive call to finish the storage on the IO_MEDIUM */
		buffer_write (data + buffer_size, size - buffer_size);
	} else {
			/* Copy the data buffer into the general_buffer
			 * Set also `current_position' to the position in the general_buffer */
		memcpy (general_buffer + current_position, data, size);
		current_position += size;
	}
}

rt_public void flush_st_buffer (void)
{
	if (current_position != 0)
		store_write_func();
}

rt_public int char_write(char *pointer, int size)
{
	EIF_GET_CONTEXT
	return write(s_fides, pointer, size);
}

rt_private int stream_write (char *pointer, int size)
{
	if (stream_buffer_size - stream_buffer_position < size) {
		stream_buffer_size += buffer_size;
		stream_buffer = (char *) eif_realloc (stream_buffer, stream_buffer_size);
	}

	memcpy ((stream_buffer + stream_buffer_position), pointer, size);
	stream_buffer_position += size;
	return size;
} 

void store_write(void)
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
	cmps_out_size = cmp_buffer_size;
 
	eif_compress ((unsigned char*)cmps_in_ptr,
					(unsigned long)cmps_in_size,
					(unsigned char*)cmps_out_ptr,
					(unsigned long*)&cmps_out_size);
 
	ptr = cmps_general_buffer;
	number_left = cmps_out_size + EIF_CMPS_HEAD_SIZE;
 
	while (number_left > 0) {
		number_writen = char_write_func (ptr, number_left);
		if (number_writen <= 0)
			eio();
		number_left -= number_writen;
		ptr += number_writen;
	}

	if (((unsigned int) (ptr - cmps_general_buffer)) == cmps_out_size + EIF_CMPS_HEAD_SIZE)
		current_position = 0;
	else
		eise_io("Store: incorrect compression size.");
}

rt_private void st_write_cid (uint32 dftype)

{
	int16 *cidarr, count;

	cidarr = eif_gen_cid ((int16) dftype);
	count  = *cidarr;

	buffer_write ((char *) (&count), sizeof (int16));

	/* If count = 1 then we don't need to write more data */

	if (count > 1)
		buffer_write ((char *) (cidarr+1), count * sizeof (int16));
}

rt_private void ist_write_cid (uint32 dftype)

{
	int16 *cidarr;
	uint32 count, i, val;

	cidarr = eif_gen_cid ((int16) dftype);
	count  = (uint32) *cidarr;

	widr_norm_int (&count);

	/* If count = 1 then we don't need to write more data */

	if (count > 1)
	{
		++cidarr;

		for (i = 1; i <= count; ++i, ++cidarr)
		{
			val = (uint32) *cidarr;
			widr_norm_int (&val);
		}
	}
}

