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

/*#define DEBUG;    /**/

public int fides;
public char * general_buffer = (char *) 0;
public int current_position = 0;
public int buffer_size = 1024;
public int end_of_buffer = 0;


/*
 * Function declarations
 */
private void internal_store();
private void st_store();				/* Second pass of the store */
private void ist_write();
private void make_header();				/* Make header */
private int store_buffer ();
private void object_write ();
public long get_offset ();


/*
 * Shared data declarations
 */
shared char *account;					/* Array of traversed dyn types */

extern int scount;						/* Maximum dtype */

private int accounting = 0;

#ifndef lint
private char *rcsid =
	"$Id$";
#endif

/*
 * Functions definitions
 */

public void eestore(file_ptr, object)
FILE *file_ptr;
char *object;
{
	/* Store object hierarchy of root `object' and produce a header
	 * so it can be retrieved by other systems.
	 */

	fides = fileno( file_ptr);
	accounting = TR_ACCOUNT;
	internal_store(object);
	accounting = 0;
}

public void estore(file_ptr, object)
FILE *file_ptr;
char *object;
{
	/* Store object hierarchy of root `object' without header. */
	fides = fileno( file_ptr);
	accounting = 0;
	internal_store(object);
}

public void sstore (fd, object)
int fd;
char * object;
{
	/* Use file decscriptor so sockets and files can be used for storage
	 * Store object hierarchy of root `object' and produce a header
     * so it can be retrieved by other systems.
     */

    fides = fd;
	accounting = INDEPEND_ACCOUNT;
    internal_store(object);
	accounting = 0;

}

public void allocate_gen_buffer ()
{
	if (general_buffer == (char *) 0) {
		char g_status = g_data.status;

		g_data.status |= GC_STOP;
		general_buffer = (char *) cmalloc (buffer_size * sizeof (char));
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

	allocate_gen_buffer();

	if (accounting) {		/* Prepare character array */
		account = (char *) xmalloc(scount * sizeof(char), C_T, GC_OFF);
		if (account == (char *) 0)
			xraise(EN_MEM);
		bzero(account, scount * sizeof(char));
		if (accounting == INDEPEND_ACCOUNT)
			c = '\02';
		else
			c = '\01';
	} else
		c = '\0';

	/* Write the kind of store */
	buffer_write(&c, sizeof(char));

#ifdef DEBUG
		printf ("\n %d", c);
#endif

	/* Do the traversal: mark and count the objects to store */
	obj_nb = 0;
	traversal(object,accounting);

	if (accounting) {
		make_header();			/* Make header */
		xfree(account);			/* Free accouting character array */
	}
	/* Write in file `fides' the count of stored objects */
	buffer_write(&obj_nb, sizeof(long));

#ifdef DEBUG
		printf (" %lx", obj_nb);
#endif

	st_store(object);			/* Write objects to be stored in `fides' */

    if (current_position != 0)
        store_write ();
#ifdef DEBUG
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
		if (accounting == INDEPEND_ACCOUNT)
			ist_write(object);
		else
			st_write(object);		/* Write the object on the disk */

}

public void st_write(object)
char *object;
{
	/* Write an object in file `fides'.
	 * Use for basic and general store
	 */

	register2 union overhead *zone;
	uint32 flags;
	register1 uint32 nb_char;

	zone = HEADER(object);
	flags = zone->ov_flags;
	/* Write address */
	buffer_write(&object, sizeof(char *));
	buffer_write(&flags, sizeof(uint32));

#ifdef DEBUG
		printf ("\n %lx", object);
		printf (" %lx", flags);
#endif

	if (flags & EO_SPEC) {
		/* We have to save the size of the special object */
		buffer_write(&zone->ov_size, sizeof(uint32));

#ifdef DEBUG
		printf (" %lx", zone->ov_size);
#endif

		/* Evaluation of the size of a special object */
		nb_char = (zone->ov_size & B_SIZE) * sizeof(char);
	} else
		/* Evaluation of the size of a normal object */
		nb_char = Size((uint16)(flags & EO_TYPE));
	/* Write the body of the object */
	buffer_write(object, (sizeof(char) * nb_char));

#ifdef DEBUG
{
	int i;
	for (i = 0; i < nb_char ; i++) {
		printf (" %x", *(object + i));
	}
}
#endif

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

#if PTRSIZ > 4
	unsigned int trunc_ptr;
#endif
	zone = HEADER(object);
	flags = zone->ov_flags;
	/* Write address */
#if PTRSIZ > 4
 
	trunc_ptr = object & 0xffff;
	buffer_write (&trunc_ptr, sizeof (unsigned int));
#else
	buffer_write(&object, sizeof(char *));
#endif
	buffer_write(&flags, sizeof(uint32));

#ifdef DEBUG
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

#ifdef DEBUG
		printf (" %x", count);
		printf (" %x", elm_size);
#endif

	} 
	/* Write the body of the object */
	object_write(object);

}

public long get_offset (o_type, attrib_num)
uint32 o_type, attrib_num;
{
#ifdef WORKBENCH
    int32 rout_id;                  /* Attribute routine id */
    long offset;
#endif

#ifndef WORKBENCH
    return ((System(o_type).cn_offsets[attrib_num])[o_type]);
#else
    rout_id = System(o_type).cn_attr[attrib_num];
    CAttrOffs(offset,rout_id,o_type);
    return offset;
#endif


}


private void object_write (object)
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
#ifdef DEBUG
					printf (" %lx", *((long *)(object + attrib_offset)));
#endif
					buffer_write(object + attrib_offset, sizeof(long));

					break;
				case SK_BOOL:
				case SK_CHAR:
#ifdef DEBUG
					printf (" %lx", *((char *)(object + attrib_offset)));
#endif
					buffer_write(object + attrib_offset, sizeof(char));

					break;
				case SK_FLOAT:
#ifdef DEBUG
					printf (" %f", *((float *)(object + attrib_offset)));
#endif
					buffer_write(object + attrib_offset, sizeof(float));

					break;
				case SK_DOUBLE:
#ifdef DEBUG
					printf (" %lf", *((double *)(object + attrib_offset)));
#endif
					buffer_write(object + attrib_offset, sizeof(double));

					break;
				case SK_BIT:
						{
							int q;
							struct bit *bptr = (struct bit *)(object + attrib_offset);
#ifdef DEBUG
							printf (" %x", bptr->b_length);
							printf (" %x", HEADER(bptr)->ov_flags);
#endif
							buffer_write (&(bptr->b_length), sizeof (uint32));
							buffer_write (&(HEADER(bptr)->ov_flags), sizeof (uint32));
							for (q = 0; q < BIT_NBPACK(LENGTH(bptr)) ; q++) {
#ifdef DEBUG
								printf (" %lx", *((uint32 *)(bptr->b_value + q)));
#endif
								buffer_write (bptr->b_value + q, sizeof (uint32));
							}
						}

					break;
				case SK_EXP:
					ist_write (object + attrib_offset);
					break;
				case SK_REF:
				case SK_POINTER:
#ifdef DEBUG
					printf (" %lx", *((long *)(object + attrib_offset)));
#endif
					buffer_write(object + attrib_offset, sizeof(char *));

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
#ifdef DEBUG
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
	
			if (!(flags & EO_REF)) {			/* Special of simple types */
				switch (dgen & SK_HEAD) {
					case SK_INT:
						for (z = 0; z < count; z++) {
#ifdef DEBUG
							printf (" %lx", *(((long *)object) + z));
#endif
							buffer_write(((long *)object) + z, sizeof(long));
						}

						break;
					case SK_BOOL:
					case SK_CHAR:
#ifdef DEBUG
						for (z = 0; z < count; z++) {
							printf (" %lx", *((char *)(object + z)));
						}
#endif
						buffer_write(object, (int)(sizeof(char) * count));

						break;
					case SK_FLOAT:
						for (z = 0; z < count; z++) {
#ifdef DEBUG
							printf (" %f", *(((float *)object) + z));
#endif
							buffer_write(((float *)object) + z, sizeof(float));
						}

						break;
					case SK_DOUBLE:
						for (z = 0; z < count; z++) {
#ifdef DEBUG
							printf (" %lf", *(((double *)object) + z));
#endif
							buffer_write(((double *)object) + z, sizeof(double));
						}
						break;
					case SK_BIT:
						dgen_typ = dgen & SK_DTYPE;
						elem_size = *(long *) (o_ptr + sizeof(long));
#ifdef DEBUG
						printf (" %x", dgen_typ);
#endif
						buffer_write (&dgen_typ, sizeof (uint32));
						for (ref = object; count > 0; count--, 
								ref += elem_size) {
							int q;
							for (q = 0; q < BIT_NBPACK(dgen & SK_DTYPE ) ; q++) {
#ifdef DEBUG
								printf (" %lx", *((uint32 *)(((struct bit *)ref)->b_value + q)));
#endif
								buffer_write (((struct bit *)object)->b_value + q, sizeof (uint32));
							}
						}
						break;
					case SK_EXP:
						elem_size = *(long *) (o_ptr + sizeof(long));
						for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
							buffer_write (&(HEADER (ref)->ov_flags), sizeof (uint32));
							object_write(ref);
						}
						break;
					case SK_POINTER:
						for (z = 0; z < count; z++) {
#ifdef DEBUG
							printf (" %lx", (((char *)object) + z));
#endif
							buffer_write(object + z, sizeof(char *));
						}

						break;

					default:
   	   	          		eio();
						break;
				}
			} else {
				if (!(flags & EO_COMP)) {		/* Special of references */
					for (ref = object; count > 0; count--,
							ref = (char *) ((char **) ref + 1)) {
#if PTRSIZ > 4
						unsigned int trunc_ptr;

						trunc_ptr = (unsigned int)((*(long *)ref) & 0xffff);
						buffer_write (&trunc_ptr, sizeof (unsigned int));
#else
						buffer_write(ref, sizeof(char *));
#endif
#ifdef DEBUG
						printf (" %lx", *(long *)(ref));
#endif
					}
				} else {						/* Special of composites */
					elem_size = *(long *) (o_ptr + sizeof(long));
					for (ref = object + OVERHEAD; count > 0;
						count --, ref += elem_size) {
						buffer_write (&(HEADER (ref)->ov_flags), sizeof (uint32));
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
	char *bufer;
	struct gt_info *info;
	int nb_line = 0;
	int bsize = 80;

	bufer = (char *) cmalloc (bsize * sizeof( char));
	/* Write maximum dynamic type */
	if (0 > sprintf(bufer,"%d\n", scount))
		eio();
	buffer_write(bufer, (strlen (bufer)));
	
	if (accounting == INDEPEND_ACCOUNT) {
		if (0 > sprintf(bufer,"%d\n", OVERHEAD))
			eio();
		buffer_write(bufer, (strlen (bufer)));
		
	}

	for (i=0; i<scount; i++)
		if (account[i])
			nb_line++;
	/* Write number of header lines */
	if (0 > sprintf(bufer,"%d\n", nb_line))
		eio();
	buffer_write(bufer, (strlen (bufer)));

	for (i=0; i<scount; i++) {
		if (!account[i])
			continue;				/* No object of dyn. type `i'.
		/* vis_name = Visible(i) */;/* Visible name of the dyn. type */
		vis_name = System(i).cn_generator;

		if (bsize < (strlen (vis_name) + sizeof (long) + 2 * sizeof (int) + 6))
			{
				bsize = (strlen (vis_name) + sizeof (long) + 2 * sizeof (int) + 6);
				bufer = (char *) realloc ( bufer, bsize);
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

			if (0 > 
				sprintf(bufer, "%d %s %ld %d", i, vis_name, Size(i), nb_gen)
			)
				eio();

			buffer_write(bufer, (strlen (bufer)));

			for (;;) {
#ifdef DEBUG
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
				if (0 > sprintf(bufer, " %lu", dgen))
					eio();
				buffer_write(bufer, (strlen (bufer)));
			}
		} else {
			/* Non-generic type, write in file:
			 *    "dtype visible_name size 0"
			 */
			if (0 > sprintf(bufer, "%d %s %ld 0", i, vis_name, Size(i)))
				eio();
			buffer_write(bufer, (strlen (bufer)));
		}
		if (accounting == INDEPEND_ACCOUNT) {
				/* also add 
				 * "num_attributes attib_type +"
				 */

			uint32 num_attrib = System(i).cn_nbattr;
			if (0 > sprintf(bufer, " %d", num_attrib))
				eio();
			buffer_write(bufer, (strlen (bufer)));
			for (; num_attrib > 0;) {
				if (0 > sprintf(bufer, " %lu", *(System(i).cn_types + --num_attrib) & SK_HEAD))
					eio();
				buffer_write(bufer, (strlen (bufer)));
			}	
		}	
		if (0 > sprintf(bufer,"\n"))
			eio();
		buffer_write(bufer, (strlen (bufer)));
	}
	xfree (bufer);
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
            	store_write();
    	}
	} else {
    	for (i = 0; i < size; i++) {
        	*(general_buffer + current_position++) = *(data++);
    	}
	}

}



public void store_write()
{
	register char * ptr = general_buffer;
	register int number_left = current_position;

    int number_writen;

    while (number_left > 0) {
        number_writen = write (fides, ptr, number_left);
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

