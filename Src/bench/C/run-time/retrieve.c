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
#include "store.h"
#include "bits.h"

/*#define DEBUG /**/

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
private uint32 *spec_elm_size;				/*array of special element sizes*/
private uint32 old_overhead = 0;

/*
 * Function declations
 */
public char *rt_make();					/* Do the retrieve */
public char *rt_nmake();				/* Retrieve n objects */
private void rt_clean();				/* Clean data structure */
private void rt_update1();				/* Reference correspondance update */
private void rt_update2();				/* Fields updating */
private void read_header();				/* Read header */
extern long get_offset ();
private void object_read ();
private long get_expanded_pos ();

public int r_fides;			/* File descriptor use for retrieve */


#define GEN_MAX	4		/* Maximum number of generic parameters */

/*
 * Function definitions
 */

public char *sretrieve(fd)
int fd;
{
	/* Retrieve object store in file `filename' */

	char *retrieved;

	/* Open file */
	r_fides = fd;

	allocate_gen_buffer ();

	/* Read the kind of stored hierachy */
	buffer_read(&rt_kind, (sizeof(char)));

#ifdef DEBUG
		printf ("\n%d", rt_kind);
#endif

	if (rt_kind)
		read_header();					/* Make correspondance table */

	/* Retrieve */
	retrieved = rt_make();

	if (rt_kind)
		xfree(dtypes);					/* Free the correspondance table */
	if (rt_kind == '\02')
		xfree(spec_elm_size);			/* Free the element size table */

	ht_free(rt_table);					/* Free hash table descriptor */
	epop(&hec_stack, nb_recorded);		/* Pop hector records */
	return retrieved;
}


public char *eretrieve(file_ptr)
FILE *file_ptr;
{
	/* Retrieve object store in file `filename' */

	char *retrieved;

	/* Open file */
	r_fides = fileno (file_ptr);

	allocate_gen_buffer ();

	/* Read the kind of stored hierachy */
	buffer_read(&rt_kind, (sizeof(char)));

#ifdef DEBUG
		printf ("\n %d", rt_kind);
#endif


	if (rt_kind)
		read_header();					/* Make correspondance table */

	/* Retrieve */
	retrieved = rt_make();

	if (rt_kind)
		xfree(dtypes);					/* Free the correspondance table */
	if (rt_kind == '\02')
		xfree(spec_elm_size);					/* Free the element size table */

	ht_free(rt_table);					/* Free hash table descriptor */
	epop(&hec_stack, nb_recorded);		/* Pop hector records */
	return retrieved;
}

public char *rt_make()
{
	/* Make the retrieve of all objects in file */
	long objectCount;

	/* Read the object count in the file header */
	buffer_read(&objectCount, (sizeof(long)));

#ifdef DEBUG
		printf ("\n %ld", objectCount);
#endif


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
/*	long saved_objectCount = objectCount;
	extern long nomark();

	if (objectCount == 0)
		panic("no object to retrieve");*/
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
#if PTRSIZ > 4
		unsigned int trunc_ptr;

		if (rt_kind == '\02') {
			buffer_read (&trunc_ptr, sizeof (unsigned int));
			oldadd = (long) trunc_ptr;
		} else
			buffer_read(&oldadd, (sizeof(char *)));
#else
		buffer_read(&oldadd, (sizeof(char *)));
#endif

#ifdef DEBUG
		printf ("\n  %lx", oldadd);
#endif


		/* Read object flags (dynamic type) */
		buffer_read(&flags, (sizeof(uint32)));

#ifdef DEBUG
		printf (" %x", flags);
#endif


		/* Read a possible size */
		if (flags & EO_SPEC) {
			uint32 count, elm_size;

			if (rt_kind == '\02') {
				uint32 dgen, spec_type;
				struct gt_info *info;
				char *vis_name;

				spec_type = dtypes[flags & EO_TYPE];
				vis_name = System(spec_type).cn_generator;


				info = (struct gt_info *) ct_value(&ce_gtype, vis_name);
				if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
				/* Generic type, :
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
						if ((*gt_type++ & SK_DTYPE) == (int16) spec_type)
							break;
					}
					gt_type--;
					gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
					dgen = *gt_gen;
				}
	
				if (!((dgen & SK_HEAD) == SK_EXP)) {
					switch (dgen) {
						case SK_INT:
							spec_size = sizeof (EIF_INTEGER);
							break;
						case SK_CHAR:
							spec_size = sizeof (EIF_CHARACTER);
							break;
						case SK_BOOL:
							spec_size = sizeof (EIF_BOOLEAN);
							break;
						case SK_FLOAT:
							spec_size = sizeof (EIF_REAL);
							break;
						case SK_DOUBLE:
							spec_size = sizeof (EIF_DOUBLE);
							break;
						case SK_POINTER:
							spec_size = sizeof (EIF_POINTER);
							break;
						case SK_DTYPE:
						case SK_REF:
							spec_size = sizeof (EIF_OBJ);
							break;
						default:
							if (dgen & SK_BIT) 
								spec_size = BITOFF(dgen & SK_DTYPE);
							else
								eio();
					}
				} else {
					spec_size = Size((uint16)(dgen & SK_DTYPE)) + OVERHEAD;
				}
				buffer_read(&count, (sizeof(uint32)));
				nb_char = CHRPAD(count * spec_size ) + LNGPAD(2);
				buffer_read(&elm_size, (sizeof(uint32)));

#ifdef DEBUG
		printf (" %x", count);
		printf (" %x", elm_size);
#endif


			} else {
					/* Special object: read the saved size */
				buffer_read(&spec_size, (sizeof(uint32)));
				nb_char = (spec_size & B_SIZE) * sizeof(char);
			}
			newadd = spmalloc(nb_char);
			if (rt_kind) {
				if (rt_kind == '\02') {
					long * o_ref;

					o_ref = (long *) (newadd + (HEADER(newadd)->ov_size & B_SIZE) - LNGPAD(2));
					*o_ref++ = count; 		
					*o_ref = spec_size;
					spec_elm_size[dtypes[flags & EO_TYPE]] = elm_size;
				} 
				HEADER(newadd)->ov_flags |= dtypes[flags & EO_TYPE] |
											(flags & (EO_REF|EO_COMP));
			} else
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
		if (rt_kind =='\02') {
			object_read (newadd, newadd);
		} else {
			buffer_read(newadd, (sizeof(char) * nb_char));
		}

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
/*
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
	} */
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
	if (spec_elm_size != (uint32 *)0)
		xfree(spec_elm_size);

	epop(&hec_stack, nb_recorded);				/* Pop hector records */
}

private void rt_update1 (old, new)
register4 char *old;
register3 EIF_OBJ new;
{
	/* `new' is hector pointer to a retrieved object. We have to solve
	 * possible references with it, before putting it in the hash table.
	 */

	unsigned long key = ((unsigned long) old) - 1;	/* Key in the hash table */
	unsigned long solved_key;
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
		long count, elem_size, old_elem_size;

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
			if (rt_kind != '\02') {
				old_overhead = OVERHEAD;
				old_elem_size = elem_size;
			} else
				old_elem_size = spec_elm_size[flags & EO_TYPE];

			for (	addr = new + OVERHEAD, old_addr = old + old_overhead;
					count>0 ;
					count--, addr += elem_size, old_addr += old_elem_size) {
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
		int total_ref = nb_references;

		/* *(char **)new is a pointer an a stored object: check if
		 * the corresponding reference is already in the hash table
		 */
		reference = *(char **)addr;
		if (reference == 0)
			continue;
		if (System(flags & EO_TYPE).cn_nbattr) {
			if (((System(flags & EO_TYPE).cn_types[total_ref - nb_references]) & SK_HEAD) == SK_EXP) {
				/* This is an internal expanded reference */
				long new_offset;
				long offset = reference - old;
	
				if (rt_kind == '\02') {
					new_offset = get_expanded_pos (flags & EO_TYPE, total_ref - nb_references);
				} else
					new_offset = offset;
	
				*(char **) addr = new + new_offset;				/* Expanded reference */
				if (rt_kind) {
					uint32 old_flags = HEADER(new + new_offset)->ov_flags;
					HEADER(new + new_offset)->ov_flags &= ~EO_TYPE;
					HEADER(new + new_offset)->ov_flags |= dtypes[old_flags & EO_TYPE];
				}
				rt_update2(old + offset, new + new_offset, parent);	/* Recursion */
				continue;
			} 
		} 
		{
			struct rt_struct *rt_info;
			unsigned long key = ((unsigned long) reference) - 1;
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
				new_cell->key = ((unsigned long) old) - 1;
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


private char *next_item (ptr)
char * ptr;
{
	int first_char = 0;

	for (;;) {
		if (!(isspace(*ptr)) && !first_char ) 
			first_char = 1;
		else if (isspace(*ptr) && first_char)
			break;
		ptr++;
	}
	return (ptr);
}

private void read_header()
{
	/* Read header and make the dynamic type correspondance table */
	int nb_lines, i, k, old_count;
	extern int errno;
	int dtype, new_dtype;
	long size;
	int nb_gen, bsize = 1024;
	char vis_name[512], end, *bufer;
	char * temp_buf;

	errno = 0;

	bufer = (char*) cmalloc (bsize * sizeof (char));

	/* Read the old maximum dyn type */
	if (readline(bufer, &bsize) <= 0)
		eio();
	if (sscanf(bufer,"%d\n", &old_count) != 1)
		eio();
	/* create a correspondance table */
	dtypes = (int *) xmalloc(old_count * sizeof(int), C_T, GC_OFF);
	if (rt_kind == '\02') {
		spec_elm_size = (uint32 *) xmalloc (old_count * sizeof (uint32), C_T, GC_OFF);
		if (readline(bufer, &bsize) <= 0)
			eio();
		if (sscanf(bufer,"%d\n", &old_overhead) != 1)
			eio();
		
	}
	if (dtypes == (int *) 0)
		xraise(EN_MEM);

	/* Read the number of lines */
	if (readline(bufer, &bsize) <= 0)
		eio();
	if (sscanf(bufer,"%d\n", &nb_lines) != 1)
		eio();

	for(i=0; i<nb_lines; i++) {
		if (readline(bufer, &bsize) <= 0)
			eio();

		temp_buf = bufer;

		if (
			4 != sscanf(bufer, "%d %s %ld %d",&dtype,vis_name,&size,&nb_gen)
		)
			eio();

		for (k = 1 ; k <= 4 ; k++)
			temp_buf = next_item (temp_buf);

		if (nb_gen > 0) {
			struct gt_info *info;
			int32 *t;
			int matched;
			int j, index;
			long gtype[GEN_MAX];
			int32 itype[GEN_MAX];
	

			/* Generic class */
			info = (struct gt_info *) ct_value(&ce_gtype, vis_name);
			if (info == (struct gt_info *) 0)
				eraise(vis_name, EN_RETR);	/* Cannot find class */

			if (info->gt_param != nb_gen)
				eraise(vis_name, EN_RETR);	/* No good generic count */

			for (j=0; j<nb_gen; j++) {		/* Read meta-types */
				if (sscanf(temp_buf," %ld", &gtype[j]) != 1)
					eio();
				temp_buf = next_item (temp_buf);
					
			}

			for (t = info->gt_gen; /* empty */; /* empty */) {

				if (*t == SK_INVALID)		/* Cannot find good meta-type */
					eraise(vis_name, EN_RETR);

				matched = 1;					/* Assume a perfect match */
				for (j=0; j<nb_gen; j++) {
					int32 gt;

					gt = (int32) gtype[j];
					itype[j] = *t++;
					if (itype[j] != gt)	/* Matching done on the fly */
						matched = 0;			/* The types do not match */
				}
				if (matched) {					/* We found the type */
					t -= nb_gen;
					break;						/* End of loop processing */
				}
			}
			index = (int) ((t - info->gt_gen) / nb_gen);
			new_dtype = info->gt_type[index] & SK_DTYPE;
		} else {
			int32 *addr;

			/* Non generic class */
			addr = (int32 *) ct_value(&ce_type, vis_name);
			if (addr == (int32 *) 0)
				eraise(vis_name, EN_RETR);	/* Cannot find class */
			new_dtype = *addr & SK_DTYPE;
		}
		if (Size(new_dtype) != size) {
			if (rt_kind == '\02') {
				uint32 num_attrib;
				long read_attrib;

				if (sscanf(temp_buf," %d", &num_attrib) != 1)
					eio();
				temp_buf = next_item (temp_buf);
				if (num_attrib == System(new_dtype).cn_nbattr) {
					for (; num_attrib > 0;) {
						if (sscanf(temp_buf," %lu", &read_attrib) != 1)
							eio();
						temp_buf = next_item (temp_buf);
						if ((*(System(new_dtype).cn_types + --num_attrib) & SK_HEAD) == (uint32) read_attrib)
							continue;
						else
							eraise(vis_name, EN_RETR);		/* non matching attributes */
					}
				} else 
					eraise(vis_name, EN_RETR);		/* wrong number of attributes */
			} else
				eraise(vis_name, EN_RETR);		/* No good size */
		}
		dtypes[dtype] = new_dtype;
	}
	xfree (bufer);
}


private int readline (ptr, maxlen)
register char * ptr;
register int *maxlen;
{
	int num_char, read_char;
	char c;

	for (num_char = 1; num_char < *maxlen; num_char ++) {
		if ((read_char = buffer_read(&c, sizeof (char))) == (sizeof (char))) {
			*ptr++ = c;
			if (c == '\n') {
				break;
			}
		}
		else if (read_char == 0) {
			if (num_char == 1) {
				return (0);
			}
			else {
				break;
			}
		}
		else {
			return (-1);
		}
	}
	*ptr = '\0';
	return (num_char);
}
		
			
private int buffer_read (object, size)
register char * object;
int size;
{
	register i;
	
	if (current_position + size >= end_of_buffer) {
		for (i = 0; i < size ; i++) {
			if (current_position >= end_of_buffer)
				if ((retrieve_read() == 0) && size != i + 1)
					eraise("incomplete file" , EN_RETR);
			*(object++) = *(general_buffer + current_position++);
		}
	} else {

		for (i = 0; i < size ; i++) {
			*(object++) = *(general_buffer + current_position++);
		}
	}
	return (i);
}


private int retrieve_read ()
{
	char * ptr = general_buffer;

	end_of_buffer = read (r_fides, ptr, buffer_size);
	if (end_of_buffer < 0)
		eio();

	current_position = 0;
	return (end_of_buffer);
}




private void object_read (object, parent)
char * object, parent;
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
			uint32 types_cn;

			attrib_offset = get_offset(o_type, --num_attrib);
			types_cn = *(System(o_type).cn_types + num_attrib);

			switch (types_cn & SK_HEAD) {
				case SK_INT:
					buffer_read (object + attrib_offset, sizeof(long));
#ifdef DEBUG
					printf (" %lx", *((long *)(object + attrib_offset)));
#endif

					break;
				case SK_BOOL:
				case SK_CHAR:
					buffer_read (object + attrib_offset, sizeof(char));
#ifdef DEBUG
					printf (" %lx", *((char *)(object + attrib_offset)));
#endif

					break;
				case SK_FLOAT:
					buffer_read (object + attrib_offset, sizeof(float));
#ifdef DEBUG
					printf (" %f", *((float *)(object + attrib_offset)));
#endif

					break;
				case SK_DOUBLE:
					buffer_read (object + attrib_offset, sizeof(double));
#ifdef DEBUG
					printf (" %lf", *((double *)(object + attrib_offset)));
#endif

					break;
				case SK_BIT:
						{
							int q;
							uint32 old_flags;
							struct bit *bptr = (struct bit *)(object + attrib_offset);

							buffer_read (&(bptr->b_length), sizeof (uint32));
							if ((types_cn & SK_DTYPE) != LENGTH(bptr))
								eio();
							HEADER(bptr)->ov_flags = bit_dtype;
							buffer_read (&old_flags, sizeof (uint32));
							HEADER(bptr)->ov_flags |= old_flags & (EO_COMP | EO_REF);
#ifdef DEBUG
							printf (" %x", (bptr->b_length));
							printf (" %x", old_flags);
#endif
							for (q = 0; q < BIT_NBPACK( LENGTH(bptr)) ; q++) {
								buffer_read (bptr->b_value + q, sizeof (uint32));
#ifdef DEBUG
								printf (" %lx", *((uint32 *)(bptr->b_value + q)));
#endif
							}
						}

					break;
				case SK_EXP: {
					uint32  old_flags;
					long size_count;

#if PTRSIZ > 4
					unsigned int trunc_ptr;

					buffer_read (&trunc_ptr, sizeof (unsigned int));
					*((long *) object + attrib_offset) = (long) trunc_ptr;
#else
					buffer_read (object + attrib_offset, sizeof(char *));
#endif
					buffer_read (&old_flags, sizeof(uint32));
					size_count = get_expanded_pos (o_type, num_attrib);

#ifdef DEBUG
					printf ("\n %lx", *((char **)(object + attrib_offset)));
					printf (" %lx", old_flags);
#endif
					HEADER(object + size_count)->ov_flags = (old_flags & (EO_REF|EO_COMP|EO_TYPE));
					HEADER(object + size_count)->ov_size = (uint32)(get_expanded_pos (o_type, -1) + (object - parent));
					object_read (object + size_count, parent);						

					}
					break;
				case SK_REF:
				case SK_POINTER:
					buffer_read (object + attrib_offset, sizeof(char *));
#ifdef DEBUG
					printf (" %lx", *((char **)(object + attrib_offset)));
#endif

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
			uint32 dgen;
			struct gt_info *info;

			o_ptr = (char *) (object + (HEADER(object)->ov_size & B_SIZE) - LNGPAD(2));
			count = *(long *) o_ptr;
			vis_name = System(o_type).cn_generator;


			info = (struct gt_info *) ct_value(&ce_gtype, vis_name);
			if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, :
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
							buffer_read (((long *)object) + z, sizeof(long));
#ifdef DEBUG
							printf (" %lx", *(((long *)object) + z));
#endif
						}

						break;
					case SK_BOOL:
					case SK_CHAR:
						buffer_read (object, sizeof(char) * count);
#ifdef DEBUG
						for (z = 0; z < count; z++) {
							printf (" %lx", *((char *)(object + z)));
						}
#endif

						break;
					case SK_FLOAT:
						for (z = 0; z < count; z++) {
							buffer_read (((float *)object) + z, sizeof(float));
#ifdef DEBUG
							printf (" %f", *(((float *)object) + z));
#endif
						}

						break;
					case SK_DOUBLE:
						for (z = 0; z < count; z++) {
							buffer_read (((double *)object) + z, sizeof(double));
#ifdef DEBUG
							printf (" %lf", *(((double *)object) + z));
#endif
						}
						break;
					case SK_EXP: {

						elem_size = *(long *) (o_ptr + sizeof(long));
						for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
								uint32  old_flags;
	
								buffer_read (&old_flags, sizeof(uint32));
#ifdef DEBUG
								printf (" %x", old_flags);
#endif
								HEADER(ref)->ov_flags = (old_flags & (EO_REF|EO_COMP|EO_TYPE));
								HEADER(ref)->ov_size = (uint32)(ref - parent);
								object_read (ref, parent);						
	
						}
					}
						break;
					case SK_BIT: {
						uint32 l;
						elem_size = *(long *) (o_ptr + sizeof(long));
						buffer_read (&l, sizeof (uint32));
#ifdef DEBUG
						printf (" %x", l);
#endif
						if ((dgen & SK_DTYPE) != l)
							eio();
						for (ref = object; count > 0; count--, ref += elem_size ) {
							int q;
							((struct bit *)ref)->b_length = l;
							for (q = 0; q < BIT_NBPACK(l) ; q++) {
								buffer_read (((struct bit *)ref)->b_value + q, sizeof (uint32));
#ifdef DEBUG
								printf (" %lx", *((uint32 *)(((struct bit *)ref)->b_value + q)));
#endif
							}
						}
						}
						break;
					case SK_POINTER:
						for (z = 0; z < count; z++) {
							buffer_read (object + z, sizeof(char *));
#ifdef DEBUG
							printf (" %lx", *(((char *)object) + z));
#endif
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

						buffer_read (&trunc_ptr, sizeof (unsigned int));
						*(long *)ref = (long) trunc_ptr;
#else
						buffer_read (ref, sizeof(char *));
#endif
#ifdef DEBUG
						printf (" %lx", *(char **)(ref));
#endif
					}
				} else {						/* Special of composites */
					elem_size = *(long *) (o_ptr + sizeof(long));
					for (ref = object + OVERHEAD; count > 0;
						count --, ref += elem_size) {
							uint32  old_flags;

							buffer_read (&old_flags, sizeof(uint32));
#ifdef DEBUG
							printf (" %x", old_flags);
#endif
							HEADER(ref)->ov_flags = (old_flags & (EO_REF|EO_COMP|EO_TYPE));
							HEADER(ref)->ov_size = (uint32)(ref - parent);
							object_read (ref, parent);						
					}
				}
			}
		} 
	}
}

private long get_expanded_pos (o_type, num_attrib)
uint32 o_type, num_attrib;
{
	int numb, counter, bit_size = 0;
	int num_ref = 0, num_char = 0, num_float = 0, num_double = 0;
	int num_pointer = 0, num_int = 0, exp_size = 0, num_exp = 0;
	uint32 types_cn;

	numb = System(o_type).cn_nbattr;
	for (counter = 0; counter < numb; counter++) {
		types_cn = *(System(o_type).cn_types + counter);
		switch (types_cn & SK_HEAD) {
			case SK_EXP:
				if ((counter + (++num_ref - num_attrib)) < num_attrib) {
					exp_size += (OVERHEAD + Size(types_cn & SK_DTYPE));
				}
				break;
			case SK_REF:
				num_ref++;
				break;
			case SK_POINTER:
				num_pointer++;
				break;
			case SK_INT:
				num_int++;
				break;
			case SK_BOOL:
			case SK_CHAR:
				num_char++;
				break;
			case SK_FLOAT:
				num_float++;
				break;
			case SK_DOUBLE:
				num_double++;
				break;
			case SK_BIT:
				bit_size += (OVERHEAD + BITOFF(types_cn & SK_DTYPE));
				break;
			default:
				eio();
		}
	}
	return ( (long) OBJSIZ (num_ref, num_char, num_int, num_float, num_pointer, num_double) 
				+ bit_size + exp_size + OVERHEAD);
}
