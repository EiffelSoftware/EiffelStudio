/*

 #####   ######   #####  #####      #    ######  #    #  ######           ####
 #    #  #          #    #    #     #    #       #    #  #               #    #
 #    #  #####      #    #    #     #    #####   #    #  #####           #
 #####   #          #    #####      #    #       #    #  #        ###    #
 #   #   #          #    #   #      #    #        #  #   #        ###    #    #
 #    #  ######     #    #    #     #    ######    ##    ######   ###     ####

	Eiffel retrieve mechanism.
*/

#include "config.h"
#include "portable.h"
#include "macros.h"
#include "malloc.h"
#include "garcol.h"
#include "except.h"
#include "hector.h"
#include "cecil.h"
#include "retrieve.h"

#undef DEBUG

/*
 * Public data declarations 
 */
public struct htable *rt_table;			/* Table used for solving references */
public int32 nb_recorded;				/* Number of items recorded in Hector */
public char rt_kind;					/* Kind of storable */

/*
 * Private data declaration
 */
private int *dtypes;					/* Dynamic types */

/*
 * Function declations
 */
public char *rt_make();					/* Do the retrieve */
public char *rt_nmake();				/* Retrieve n objects */
private void rt_clean();				/* Clean data structure */
private void rt_update1();				/* Reference correspondance update */
private void rt_update2();				/* Fields updating */
private void read_header();				/* Read header */

public FILE *rt_file;					/* File used for retrieve */

#define GEN_MAX	4		/* Maximum number of generic parameters */

/*
 * Function definitions
 */

public char *eretrieve(file_ptr)
FILE *file_ptr;
{
	/* Retrieve object store in file `filename' */

	char *retrieved;

	/* Open file */
	rt_file = file_ptr;

	/* Read the kind of stored hierachy */
	if (fread(&rt_kind, sizeof(char), 1, rt_file) != 1)
		eio();

	if (rt_kind)
		read_header();					/* Make correspondance table */

	/* Retrieve */
	retrieved = rt_make();

	if (rt_kind)
		xfree(dtypes);					/* Free the correspondance table */

	ht_free(rt_table);					/* Free hash table descriptor */
	epop(&hec_stack, nb_recorded);		/* Pop hector records */
	return retrieved;
}

public char *rt_make()
{
	/* Make the retrieve of all objects in file */
	long objectCount;

	/* Read the object count in the file header */
	if (fread(&objectCount, sizeof(long), 1, rt_file) != 1)
		eio();

	return rt_nmake(objectCount);
}

public char *rt_nmake(objectCount)
long objectCount;
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */

	long nb_char;
	char *oldadd;
	char *newadd = (char *) 0;
	EIF_OBJ new_hector;
	uint32 flags;
	uint32 spec_size = 0;
	char g_status = g_data.status;
	jmp_buf exenv;

#ifdef DEBUG
	long saved_objectCount = objectCount;
	extern long nomark();

	if (objectCount == 0)
		panic("no object to retrieve");
#endif
	excatch((char *) exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		ereturn();				/* Propagate exception */
	}

	/* Initialization of the hash table */
	nb_recorded = 0;
	rt_table = (struct htable *) malloc(sizeof(struct htable));
	if (rt_table == (struct htable *) 0)
		xraise(EN_MEM);
	if (-1 == ht_create(rt_table, objectCount, sizeof(struct rt_struct)))
		xraise(EN_MEM);
	ht_zero(rt_table);

	for (;objectCount > 0; objectCount--) {
		/* Read object address */
		if (fread(&oldadd, sizeof(char *), 1, rt_file) != 1)
			eio();

		/* Read object flags (dynamic type) */
		if (fread(&flags, sizeof(uint32), 1, rt_file) != 1)
			eio();

		/* Read a possible size */
		if (flags & EO_SPEC) {
			/* Special object: read the saved size */
			if (fread(&spec_size, sizeof(uint32), 1, rt_file) != 1)
				eio();
			nb_char = (spec_size & B_SIZE) * sizeof(char);
			newadd = spmalloc(nb_char);
			if (rt_kind)
				HEADER(newadd)->ov_flags |= dtypes[flags & EO_TYPE] |
											(flags & (EO_REF|EO_COMP));
			else
				HEADER(newadd)->ov_flags |= flags & (EO_REF|EO_COMP|EO_TYPE);
		} else {
			/* Normal object */
			if (rt_kind) {
				nb_char = Size((uint16)(dtypes[flags & EO_TYPE]));
				newadd = emalloc(dtypes[flags & EO_TYPE]); 
			} else {
				nb_char = Size((uint16)(flags & EO_TYPE));
				newadd = emalloc(flags & EO_TYPE);
			}
		}
		
		/* Creation of the Eiffel object */	
		if (newadd == (char *) 0)
			xraise(EN_MEM);

		/* Stop in the garbage collector because we have know an unstable
		 * object. */
		g_data.status |= GC_STOP;

		/* Record the new object in hector table */
		new_hector = hrecord(newadd);
		nb_recorded++;

		/* Update unsolved references on `newadd' */
		rt_update1 (oldadd, new_hector);

		/* Read the object's body */
		if (fread(newadd, sizeof(char), nb_char, rt_file) != nb_char)
			eio();

		/* Update fileds: the garbage collector should not be called
		 * during `rt_update2' because the object is in a very unstable
		 * state.
		 */
		rt_update2(oldadd, newadd, newadd);

		/* Restore garbage collector status */
		g_data.status = g_status;
	}
	expop(&eif_stack);
#ifdef DEBUG
		/* Consistency check: no more unsolved references and
		 * `objectCount' solved references. */

	{
		long nb_retrieved = 0L;
		struct rt_struct *rt_info = (struct rt_struct *) rt_table->h_values;
		int32 count = rt_table->h_size;

		for (; count > 0; count--, rt_info++) {
			if (
					rt_info->rt_status == UNSOLVED &&
					rt_info->rt_list != (struct rt_cell *) 0) {
				panic("retrieve incomplete");
			}
			if (rt_info->rt_status == SOLVED)
				nb_retrieved++;
		}
		if (nb_retrieved != saved_objectCount)
			panic("retrieve failure");
		if (saved_objectCount != nomark(newadd))
			panic("retrieve inconsistecy");
	}
#endif
	return newadd;
}

private void rt_clean()
{
	/* Raise an exception of code `code' after having cleaned the hash table */

	struct rt_struct *rt_info;

	if (rt_table != (struct htable *) 0) {
		struct rt_struct *rt_info = (struct rt_struct *) rt_table->h_values;
		int32 count = rt_table->h_size;

		for (; count > 0; count--, rt_info++) {
			if (rt_info->rt_status == UNSOLVED) {	/* Free cell list */
				struct rt_cell *cell, *next_cell;

				cell = rt_info->rt_list;
				while (cell != (struct rt_cell *) 0) {
					next_cell = cell->next;
					xfree(cell);
					cell = next_cell;
				}
			}
		}
		ht_free(rt_table);						/* Free hash table descriptor */
	}
	if (dtypes != (int *) 0)
		xfree(dtypes);
	epop(&hec_stack, nb_recorded);				/* Pop hector records */
}

private void rt_update1 (old, new)
register4 char *old;
register3 EIF_OBJ new;
{
	/* `new' is hector pointer to a retrieved object. We have to solve
	 * possible references with it, before putting it in the hash table.
	 */

	uint32 key = ((uint32) old) - 1;	/* Key in the hash table */
	uint32 solved_key;
	long offset;
	struct rt_struct *rt_info, *rt_solved;
	struct rt_cell *rt_unsolved, *next;
	char *client, *supplier;
	

	rt_info = (struct rt_struct *) ht_first(rt_table, key);

#ifdef MAY_PANIC
	if (rt_info->rt_status == SOLVED)
		panic("cannot already be solved");
#endif

	/* First, solve references if any. */
	rt_unsolved = rt_info->rt_list;
	while (rt_unsolved != (struct rt_cell *) 0) {
		next = rt_unsolved->next;

		solved_key = rt_unsolved->key;	/* Key to the solved objcet */
		offset = rt_unsolved->offset;	/* Offset in the solved object */
		rt_solved = (struct rt_struct *) ht_value(rt_table, solved_key);

#ifdef MAY_PANIC
		if (
			rt_solved == (struct rt_struct *) 0
			|| rt_solved->rt_status != SOLVED
		)
			panic("should be solved");
#endif

		/* Attachement to hector pointer dereference */
		client = eif_access(rt_solved->rt_obj);
		supplier = eif_access(new);
		RTAS(supplier, client);					/* Age check */
		*(char **)(client + offset) = supplier;	/* Attachment */
	
		xfree(rt_unsolved);		/* Free reference solving cell */
		rt_unsolved = next;	
	}

	/* Put the new hector pointer as a olved reference in the hash table */
	rt_info->rt_status = SOLVED;
	rt_info->rt_obj = new;
}

private void rt_update2(old, new, parent)
char *old, *new, *parent;
{
	/* Reference field updating: record new unsolved references.
	 * The third argument is needed because of expanded objects:
	 * if `new' is not an expanded object,parent is equal to it. */

	long nb_references;
	uint32 flags;
	char *reference;
	union overhead *zone = HEADER(new);
	char* addr;
	long size;				/* New object size */
	struct rt_struct *rt_info;

	flags = zone->ov_flags;
	if (flags & EO_SPEC) {				/* Special object */
		char *o_ref;
		long count, elem_size;

		if (!(flags & EO_REF))			/* Special without references */
			return;

		size = zone->ov_size & B_SIZE;	
		o_ref = (char *) (new + size - LNGPAD(2));
		count = *(long *) o_ref; 		
		if (!(flags & EO_COMP)) {		/* Special of references */
			nb_references = count;
			goto update;
		} else {						/* Special of expanded objects */
			char *old_addr;
			elem_size = *(long *) (o_ref + sizeof(long));
			for (	addr = new + OVERHEAD, old_addr = old + OVERHEAD;
					count>0 ;
					count--, addr += elem_size, old_addr += elem_size) {
				rt_update2(old_addr, addr, parent);
			}
		}
	} else {							  /* Normal object */
		nb_references = References(flags & EO_TYPE);
		size = Size(flags & EO_TYPE);
	}

update:
	/* Update references */
	for (addr = new; 	nb_references > 0;
			nb_references--, addr = (char *)(((char **) addr) + 1)) {
		/* *(char **)new is a pointer an a stored object: check if
		 * the corresponding reference is already in the hash table
		 */
		reference = *(char **)addr;
		if (reference == 0)
			continue;
		if ((reference > old) && (reference < old + size)) {
			/* This is an internal expanded reference */
			long offset = reference - old;

			*(char **) addr = new + offset;				/* Expanded reference */
			rt_update2(old + offset, new + offset, parent);	/* Recursion */
		} else {
			struct rt_struct *rt_info;
			uint32 key = ((uint32) reference) - 1;
			char *supplier;

			rt_info = (struct rt_struct *) ht_first(rt_table, key);
			if (rt_info->rt_status == SOLVED) {
				/* Reference is already solved */
				supplier = eif_access(rt_info->rt_obj);
				RTAS(supplier, new);						/* Age check */
				*(char **) addr = supplier;					/* Attachment */
			} else {
				/* Reference is stil unsolved */
				struct rt_cell *new_cell, *old_cell;

				new_cell = (struct rt_cell *) cmalloc(sizeof(struct rt_cell));
				new_cell->key = ((uint32) old) - 1;
				new_cell->offset = (long) (addr - parent);
				old_cell = rt_info->rt_list;
				new_cell->next = old_cell;
				rt_info->rt_list = new_cell;
				rt_info->rt_status = UNSOLVED;
				*(char **) addr = (char *) 0; 
						/* Set to zero the unsolved reference
						 * in order to put the object in a
						 * stable state. */
			}
		}
	}
}

private void read_header()
{
	/* Read header and make the dynamic type correspondance table */
	int nb_lines, i, old_count;
	extern int errno;
	int dtype, new_dtype;
	long size;
	int nb_gen;
	char vis_name[512];

	errno = 0;

	/* Read the old maximum dyn type */
	if (fscanf(rt_file,"%d\n", &old_count) != 1)
		eio();
	/* create a correspondance table */
	dtypes = (int *) xmalloc(old_count * sizeof(int), C_T, GC_OFF);
	if (dtypes == (int *) 0)
		xraise(EN_MEM);

	/* Read the number of lines */
	if (fscanf(rt_file,"%d\n", &nb_lines) != 1)
		eio();

	for(i=0; i<nb_lines; i++) {
		if (
			4 != fscanf(rt_file, "%d %s %ld %d",&dtype,vis_name,&size,&nb_gen)
		)
			eio();
		if (nb_gen > 0) {
			struct gt_info *info;
			int32 *t;
			int matched;
			int j, index;
			int32 gtype[GEN_MAX];
			int32 itype[GEN_MAX];

			/* Generic class */
			info = (struct gt_info *) ct_value(&ce_gtype, vis_name);
			if (info == (struct gt_info *) 0)
				eraise(vis_name, EN_RETR);	/* Cannot find class */

			if (info->gt_param != nb_gen)
				eraise(vis_name, EN_RETR);	/* No good generic count */

			for (j=0; j<nb_gen; j++)		/* Read meta-types */
				if (fscanf(rt_file," %ld", &gtype[j]) != 1)
					eio();

			for (t = info->gt_gen; /* empty */; /* empty */) {

				if (*t == SK_INVALID)		/* Cannot find good meta-type */
					eraise(vis_name, EN_RETR);

				matched = 1;					/* Assume a perfect match */
				for (j=0; j<nb_gen; j++) {
					itype[j] = *t++;
					if (itype[j] != gtype[j])	/* Matching done on the fly */
						matched = 0;			/* The types do not match */
				}
				if (matched) {					/* We found the type */
					t -= nb_gen;
					break;						/* End of loop processing */
				}
			}
			index = (t - info->gt_gen) / nb_gen;
			new_dtype = info->gt_type[index] & SK_DTYPE;
		} else {
			int32 *addr;

			/* Non generic class */
			addr = (int32 *) ct_value(&ce_type, vis_name);
			if (addr == (int32 *) 0)
				eraise(vis_name, EN_RETR);	/* Cannot find class */
			new_dtype = *addr & SK_DTYPE;
		}
		if (Size(new_dtype) != size)
			eraise(vis_name, EN_RETR);		/* No good size */
		dtypes[dtype] = new_dtype;
		fscanf(rt_file,"\n");
	}
}

