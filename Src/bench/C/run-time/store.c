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

public FILE *st_file;

/*
 * Function declarations
 */
private void internal_store();
private void st_store();				/* Second pass of the store */
private void make_header();				/* Make header */

/*
 * Shared data declarations
 */
shared char *account;					/* Array of traversed dyn types */

extern int scount;						/* Maximum dtype */

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

	internal_store(file_ptr, object, TR_ACCOUNT);
}

public void estore(file_ptr, object)
FILE *file_ptr;
char *object;
{
	/* Store object hierarchy of root `object' without header. */

	internal_store(file_ptr,object,0);
}

private void internal_store(file_ptr, object, accounting)
FILE *file_ptr;
char *object;
int accounting;
{
	/* Store object hierarchy of root `object' in file `file_ptr' and
	 * produce header if `accounting'.
	 */
	char c;

	st_file = file_ptr;

	if (accounting) {		/* Prepare character array */
		account = (char *) xmalloc(scount * sizeof(char), C_T, GC_OFF);
		if (account == (char *) 0)
			xraise(EN_MEM);
		bzero(account, scount * sizeof(char));
		c = '\01';
	} else
		c = '\0';

	/* Write the kind of store */
	if (fwrite(&c, sizeof(char), 1, st_file) < 0)
		eio();

	/* Do the traversal: mark and count the objects to store */
	obj_nb = 0;
	traversal(object,accounting);

	if (accounting) {
		make_header();			/* Make header */
		xfree(account);			/* Free accouting character array */
	}
	/* Write in file `st_file' the count of stored objects */
	if (fwrite(&obj_nb, sizeof(long), 1, st_file) != 1)
		eio();

	st_store(object);			/* Write objects to be stored in `st_file' */
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
				elem_size = *(long *) (o_ref + sizeof(long));
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
		st_write(object);		/* Write the object on the disk */

}

public void st_write(object)
char *object;
{
	/* Write an object in file `st_file'.
	 */

	register2 union overhead *zone;
	uint32 flags;
	register1 uint32 nb_char;

	zone = HEADER(object);
	flags = zone->ov_flags;
	/* Write address */
	if (fwrite(&object, sizeof(char *), 1, st_file) != 1)
		eio();
	if (fwrite(&flags, sizeof(uint32), 1, st_file) != 1)
		eio();
	if (flags & EO_SPEC) {
		/* We have to save the size of the special object */
		if (fwrite(&zone->ov_size, sizeof(uint32), 1, st_file) != 1)
			eio();
		/* Evaluation of the size of a special object */
		nb_char = (zone->ov_size & B_SIZE) * sizeof(char);
	} else
		/* Evaluation of the size of a normal object */
		nb_char = Size((uint16)(flags & EO_TYPE));
	/* Write the body of the object */
	if (fwrite(object, sizeof(char), nb_char, st_file) != nb_char)
		eio();
}

private void make_header()
{
	/* Generate header for stored hiearchy retrivable by other systems. */
	int i;
	char *vis_name;			/* Visible name of a class */
	struct gt_info *info;
	int nb_line = 0;

	/* Write maximum dynamic type */
	if (0 > fprintf(st_file,"%d\n", scount))
		eio();
	for (i=0; i<scount; i++)
		if (account[i])
			nb_line++;
	/* Write number of header lines */
	if (0 > fprintf(st_file,"%d\n", nb_line))
		eio();

	for (i=0; i<scount; i++) {
		if (!account[i])
			continue;				/* No object of dyn. type `i'.
		/* vis_name = Visible(i) */;/* Visible name of the dyn. type */
		vis_name = System(i).cn_generator;
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
				fprintf(st_file, "%d %s %ld %d", i, vis_name, Size(i), nb_gen)
			)
				eio();
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
			for (j=0; j<nb_gen; j++)
				if (0 > fprintf(st_file, " %ld", *gt_gen++))
					eio();
			if (0 > fprintf(st_file,"\n"))
				eio();
		} else
			/* Non-generic type, write in file:
			 *    "dtype visible_name size 0"
			 */
			if (0 > fprintf(st_file, "%d %s %ld 0\n", i, vis_name, Size(i)))
				eio();
	}
}
