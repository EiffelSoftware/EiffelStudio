/*

 #####   ######   #####  #####      #    ######  #    #  ######           ####
 #    #  #          #    #    #     #    #       #    #  #               #    #
 #    #  #####      #    #    #     #    #####   #    #  #####           #
 #####   #          #    #####      #    #       #    #  #        ###    #
 #   #   #          #    #   #      #    #        #  #   #        ###    #    #
 #    #  ######     #    #    #     #    ######    ##    ######   ###     ####

	Eiffel retrieve mechanism.
*/

#include "eif_project.h" /* for egc_ce_gtype, egc_bit_dtype */
#include "eif_config.h"
#include "eif_portable.h"
#include "eif_macros.h"
#include "eif_malloc.h"
#include "eif_garcol.h"
#include "eif_except.h"
#include "eif_hector.h"
#include "eif_cecil.h"
#include "eif_retrieve.h"
#include "eif_store.h"
#include "eif_bits.h"
#include "eif_run_idr.h"
#include "eif_error.h"
#include "eif_rtlimits.h"
#include "eif_traverse.h"
#include "eif_compress.h"
#include "x2c.header"	/* For macro LNGPAD */

#include <ctype.h>					/* For isspace() */

#ifdef EIF_OS2
#include <io.h>
#endif

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#ifdef EIF_WIN32
#include <io.h>		/* %%ss added for read */
#include <winsock.h>
#endif

/*#define DEBUG_GENERAL_STORE */	/**/

/*#define DEBUG 1 */ /**/

/* Size of the buffer to retrieve an object */
#define RETRIEVE_BUFFER_SIZE 262144L

/*
 * Public data declarations 
 */
rt_public struct htable *rt_table;		/* Table used for solving references */
rt_public int32 nb_recorded = 0;		/* Number of items recorded in Hector */
rt_public char rt_kind;			/* Kind of storable */
rt_public char rt_kind_version;		/* Version of storable */

/*
 * Private data declaration
 */
rt_private int **dattrib;				/* Pointer to attribute offsets in each object
						 * for independent store */
rt_private int *dtypes;				/* Dynamic types */
rt_private uint32 *spec_elm_size;			/*array of special element sizes*/
rt_private uint32 old_overhead = 0;		/*overhead size from stored object*/
rt_private char * r_buffer = (char *) 0;		/*buffer for make_header*/

#ifndef EIF_THREADS
rt_private int r_fides;			/* File descriptor use for retrieve */
#endif /* EIF_THREADS */

/*
 * Function declations
 */
rt_public char *eretrieve(EIF_INTEGER file_desc);		/* Retrieve object store in file */
rt_public char *stream_eretrieve(char **, long);		/* Retrieve object store in stream */
rt_public char *portable_retrieve(int (*char_read_function)(char *, int));

rt_public char *irt_make(void);			/* Do the independant retrieve */
rt_public char *grt_make(void);			/* Do the general retrieve (3.3 and later) */
rt_public char *irt_nmake(EIF_CONTEXT long int objectCount);			/* Retrieve n objects independent form*/
rt_public char *grt_nmake(EIF_CONTEXT long int objectCount);			/* Retrieve n objects general form*/
rt_private void iread_header(EIF_CONTEXT_NOARG);		/* Read independent header */
rt_private void rt_clean(void);			/* Clean data structure */
rt_private void rt_update1(register char *old, register EIF_OBJECT new);			/* Reference correspondance update */
rt_private void rt_update2(char *old, char *new, char *parent);			/* Fields updating */
rt_public char *rt_make(void);				/* Do the retrieve */
rt_public char *rt_nmake(EIF_CONTEXT long int objectCount);			/* Retrieve n objects */
rt_private void read_header(EIF_CONTEXT char rt_type);			/* Read general header */
rt_private void object_read (char *object, char *parent);		/* read the individual attributes of the object*/
rt_private void gen_object_read (char *object, char *parent);	/* read the individual attributes of the object*/
rt_private long get_expanded_pos (uint32 o_type, uint32 num_attrib);

rt_private int readline (register char *ptr, register int *maxlen);
rt_private int buffer_read (register char *object, int size);
rt_private void rt_read_cid (uint32 *, uint32 *, uint32);
rt_private void rt_id_read_cid (uint32 *, uint32 *, uint32);

/* Initialization and Resetting for retrieving an independent store */
rt_private void independent_retrieve_init (long idrf_size, EIF_BOOLEAN is_limited_by_short);
rt_private void independent_retrieve_reset (void);

/* Functions to write on the specified IO_MEDIUM */
rt_private int (char_read) (char *, int);
rt_private int (stream_read) (char *, int);

/* read function declarations */
int retrieve_read (void);
int old_retrieve_read (void);
int retrieve_read_with_compression (void);
int old_retrieve_read_with_compression (void);

int (*retrieve_read_func)(void) = retrieve_read_with_compression;
int (*char_read_func)(char *, int) = char_read;
int (*old_retrieve_read_func)(void) = retrieve_read_with_compression;
int (*old_char_read_func)(char *, int) = char_read;
rt_private long old_buffer_size = RETRIEVE_BUFFER_SIZE;
rt_private char old_rt_kind;			/* Kind of storable */

/*
 * Convenience functions
 */

/* Declarations to work with streams */
rt_private char *stream_buffer;
rt_private int stream_buffer_position;
rt_private long stream_buffer_size;

/* Static CID array */

rt_private int16 cidarr [256];

/* Initialize retrieve function pointers and globals */
 
rt_public void rt_init_retrieve(int (*retrieve_function) (void), int (*char_read_function)(char *, int), int buf_size)
{
		/* Storing the previous state of the retrieving operation before the new one start */
	old_retrieve_read_func = retrieve_read_func;
	old_char_read_func = char_read_func;
	old_buffer_size = buffer_size;
	old_rt_kind = rt_kind;

		/* Set the retrieving functions which are going to be used for the current retrieving
		 * operation */
	retrieve_read_func = retrieve_function;
	char_read_func = char_read_function;
	if (buf_size)
		buffer_size = buf_size;
}
 
/* Reset retrieve function pointers and globals to their default values */
 
rt_public void rt_reset_retrieve(void) {
	retrieve_read_func = old_retrieve_read_func;
	char_read_func = old_char_read_func;
	buffer_size = old_buffer_size;
	rt_kind = old_rt_kind;
}

/*
 * Function definitions
 */

rt_public char *eretrieve(EIF_INTEGER file_desc)
{
	EIF_GET_CONTEXT
	r_fides = file_desc;
	
	return portable_retrieve(char_read);
	EIF_END_GET_CONTEXT
}

rt_public char *stream_eretrieve(char **buffer, long size)
{
	stream_buffer = *buffer;
	stream_buffer_size = size;

	return portable_retrieve(stream_read);
}

rt_public char *portable_retrieve(int (*char_read_function)(char *, int))
{
	/* Retrieve object store in file `filename' */

	EIF_GET_CONTEXT
	char *retrieved = (char *) 0;
	char rt_type = (char) 0;
	int pos = 0;

	/* Reset nb_recorded */
	nb_recorded = 0;

	/* Read the kind of stored hierachy */
	if (char_read_function(&rt_type, sizeof (char)) < sizeof (char))
		eise_io("Retrieve: unable to read type of storable.");

	/* set rt_kind depending on the type to be retrieved */

	switch (rt_type) {
		case BASIC_STORE_3_1:			/*old basic store */
			rt_init_retrieve(old_retrieve_read, char_read_function, RETRIEVE_BUFFER_SIZE);
			allocate_gen_buffer ();
			rt_kind = BASIC_STORE;
			break;
		case BASIC_STORE_3_2:			/* New basic store */
			rt_init_retrieve(retrieve_read, char_read_function, RETRIEVE_BUFFER_SIZE);
			allocate_gen_buffer ();
			rt_kind = BASIC_STORE;
			break;
		case BASIC_STORE_4_0:
			rt_init_retrieve(retrieve_read_with_compression, char_read_function, RETRIEVE_BUFFER_SIZE);
			allocate_gen_buffer ();
			rt_kind = BASIC_STORE;
			break;
		case GENERAL_STORE_3_1:			/* Old general store */
			rt_init_retrieve(old_retrieve_read, char_read_function, RETRIEVE_BUFFER_SIZE);
			allocate_gen_buffer ();
			rt_kind = GENERAL_STORE;
			break;
		case GENERAL_STORE_3_2:			/* New General store */
		case GENERAL_STORE_3_3:			/* New General store 3.3 */
			rt_init_retrieve(retrieve_read, char_read_function, RETRIEVE_BUFFER_SIZE);
			allocate_gen_buffer ();
			rt_kind = GENERAL_STORE;
			break;
		case GENERAL_STORE_4_0:			/* New General store */
			rt_init_retrieve(retrieve_read_with_compression, char_read_function, RETRIEVE_BUFFER_SIZE);
			allocate_gen_buffer ();
			rt_kind = GENERAL_STORE;
			break;
		case INDEPENDENT_STORE_3_2:		/* New Independent store */
			rt_init_retrieve(retrieve_read, char_read_function, 4096);
			rt_kind = INDEPENDENT_STORE;
			independent_retrieve_init (4096, 1);
			break;
		case INDEPENDENT_STORE_4_0:		/* New Independent store */
			rt_init_retrieve(retrieve_read_with_compression, char_read_function, 4096);
			rt_kind = INDEPENDENT_STORE;
			independent_retrieve_init (4096, 1);
			break;
		case INDEPENDENT_STORE_4_3:
		case INDEPENDENT_STORE_4_4:		/* New Independent store */
			rt_init_retrieve(retrieve_read_with_compression, char_read_function, RETRIEVE_BUFFER_SIZE);
			rt_kind = INDEPENDENT_STORE;
			rt_kind_version = rt_type;
			independent_retrieve_init (RETRIEVE_BUFFER_SIZE, 0);
			break;
		default: 			/* If not one of the above, error!! */
			eraise("invalid retrieve type", EN_RETR);	
	}

#ifdef DEBUG
		printf ("\n %d", rt_kind);
#endif

	if (rt_kind == INDEPENDENT_STORE) {
		iread_header(MTC_NOARG);			/* Make correspondance table */
		retrieved = irt_make();
	} else if ((rt_type == GENERAL_STORE_4_0) || (rt_type == GENERAL_STORE_3_3)) {
		read_header(MTC rt_type);					/* Make correspondance table */
		retrieved = grt_make();
	} else {
		if (rt_kind)
			read_header(MTC rt_type);			/* Make correspondance table */

		/* Retrieve */
		retrieved = rt_make();
	}

	if (rt_kind)
		xfree((char *) dtypes);					/* Free the correspondance table */
	if (rt_kind == INDEPENDENT_STORE)
		xfree((char *) spec_elm_size);					/* Free the element size table */

	ht_free(rt_table);					/* Free hash table descriptor */
	epop(&hec_stack, nb_recorded);		/* Pop hector records */
	switch (rt_type) {
		case GENERAL_STORE_3_3: 
		case GENERAL_STORE_4_0: 
			free_sorted_attributes();
			break;
		case INDEPENDENT_STORE_3_2:
		case INDEPENDENT_STORE_4_0:
		case INDEPENDENT_STORE_4_3:
			independent_retrieve_reset ();
			break;
	}
	rt_reset_retrieve();

	return retrieved;
	EIF_END_GET_CONTEXT
}

/* Initialization for retrieving an independent store
 * We need to give the size of the buffer since it can now be more than SHORT_MAX
 * For compatibility reason, it is 32767 bytes for version previous INDEPENDENT_STORE_4_3
 * and it is now RETRIEVE_BUFFER_SIZE.
 */
rt_private void independent_retrieve_init (long idrf_size, EIF_BOOLEAN is_limited_by_short)
{
	run_idr_init (idrf_size, is_limited_by_short);

	idr_temp_buf = (char *) xmalloc (48, C_T, GC_OFF);
	if (idr_temp_buf == (char *)0)
		xraise (EN_MEM);

	dattrib = (int **) xmalloc (scount * sizeof (int *), C_T, GC_OFF);
	if (dattrib == (int **)0){
		xfree(idr_temp_buf);
		xraise (EN_MEM);
	}
	bzero ((char *)dattrib, scount * sizeof (int *));
}

rt_private void independent_retrieve_reset (void) {
	int i;

	run_idr_destroy ();
	xfree (idr_temp_buf);
	idr_temp_buf = (char *) 0;
	for (i = 0; i < scount; i++) {
		if (*(dattrib + i))
			xfree ((char *)(*(dattrib +i)));
	}
	xfree ((char *) dattrib);
	dattrib = (int **) 0;
}

rt_public char *rt_make(void)
{
	/* Make the retrieve of all objects in file */
	long objectCount;

	/* Read the object count in the file header */
	buffer_read((char *)(&objectCount), (sizeof(long)));

#if DEBUG & 2
		printf ("\n %ld", objectCount);
#endif


	return rt_nmake(MTC objectCount);
}


rt_public char *rt_nmake(EIF_CONTEXT long int objectCount)
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */
	EIF_GET_CONTEXT
	long nb_char;
	char *oldadd;
	char *newadd = (char *) 0;
	EIF_OBJECT new_hector;
	uint32 crflags, fflags, flags;
	uint32 spec_size = 0;
	char g_status = g_data.status;
	jmp_buf exenv;
	RTXD;

#if DEBUG & 2
/*	long saved_objectCount = objectCount;

	if (objectCount == 0)
		eif_panic("no object to retrieve");*/
#endif
	excatch(MTC (char *) exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		RTXSC;					/* Restore stack contexts */
		rt_clean();				/* Clean data structure */
		ereturn(MTC_NOARG);				/* Propagate exception */
	}

	/* Initialization of the hash table */
	nb_recorded = 0;
	rt_table = (struct htable *) xmalloc(sizeof(struct htable), C_T, GC_OFF);
	if (rt_table == (struct htable *) 0)
		xraise(EN_MEM);
	if (-1 == ht_create(rt_table, objectCount, sizeof(struct rt_struct)))
		xraise(EN_MEM);
	ht_zero(rt_table);

	for (;objectCount > 0; objectCount--) {
		/* Read object address */

		buffer_read((char *)(&oldadd), (sizeof(char *)));

#if DEBUG & 2
		printf ("\n  %lx", oldadd);
#endif


		/* Read object flags (dynamic type) */
		buffer_read((char *)(&flags), (sizeof(uint32)));
		rt_read_cid (&crflags, &fflags, flags);

#if DEBUG & 2
		printf (" %x", flags);
#endif


		/* Read a possible size */
		if (flags & EO_SPEC) {
			/*uint32 count, elm_size;*/ /* %%ss unused */

			/* Special object: read the saved size */
			buffer_read((char *)(&spec_size), (sizeof(uint32)));
			nb_char = (spec_size & B_SIZE) * sizeof(char);
			newadd = spmalloc(nb_char);
			if (rt_kind) {
				HEADER(newadd)->ov_flags |= dtypes[flags & EO_TYPE] |
							(flags & (EO_REF|EO_COMP));
			} else
				HEADER(newadd)->ov_flags |= flags & (EO_REF|EO_COMP|EO_TYPE);
		} else {
			/* Normal object */
			if (rt_kind) {
				nb_char = Size((uint16)(dtypes[flags & EO_TYPE]));
				newadd = emalloc(crflags & EO_TYPE); 
			} else {
				nb_char = Size((uint16)(flags & EO_TYPE));
				newadd = emalloc(crflags & EO_TYPE);
			}
		}
		
		/* Creation of the Eiffel object */	
		if (newadd == (char *) 0)
			xraise(EN_MEM);

		/* Stop in the garbage collector because we have now an unstable
		 * object. */
		g_data.status |= GC_STOP;

		/* Record the new object in hector table */
		new_hector = hrecord(newadd);
		nb_recorded++;

		/* Update unsolved references on `newadd' */
		rt_update1 (oldadd, new_hector);

		/* Read the object's body */
		buffer_read(newadd, (int)(sizeof(char) * nb_char));

		/* Update fileds: the garbage collector should not be called
		 * during `rt_update2' because the object is in a very unstable
		 * state.
		 */
		rt_update2(oldadd, newadd, newadd);

		/* Restore garbage collector status */
		g_data.status = g_status;
	}
	expop(&eif_stack);
#if DEBUG & 2
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
				eif_panic("retrieve incomplete");
			}
			if (rt_info->rt_status == SOLVED)
				nb_retrieved++;
		}
		if (nb_retrieved != saved_objectCount)
			eif_panic("retrieve failure");
		if (saved_objectCount != nomark(newadd))
			eif_panic("retrieve inconsistecy");
	} */
#endif
	return newadd;

	EIF_END_GET_CONTEXT
}

rt_public char *grt_make(void)
{
	/* Make the retrieve of all objects in file */
	long objectCount;

	/* Read the object count in the file header */
	buffer_read((char *)(&objectCount), sizeof(long));

#if DEBUG & 1
		printf ("\n %ld", objectCount);
#endif

	return grt_nmake(MTC objectCount);
}

rt_public char *grt_nmake(EIF_CONTEXT long int objectCount)
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */
	EIF_GET_CONTEXT
	long nb_char;
	char *oldadd;
	char *newadd = (char *) 0;
	EIF_OBJECT new_hector;
	uint32 crflags, fflags, flags;
	uint32 spec_size = 0;
	char g_status = g_data.status;
	jmp_buf exenv;
	RTXD;

	excatch(MTC (char *) exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		RTXSC;					/* Restore stack contexts */
		rt_clean();				/* Clean data structure */
		ereturn(MTC_NOARG);				/* Propagate exception */
	}

	/* Initialization of the hash table */
	nb_recorded = 0;
	rt_table = (struct htable *) xmalloc(sizeof(struct htable), C_T, GC_OFF);
	if (rt_table == (struct htable *) 0)
		xraise(EN_MEM);
	if (-1 == ht_create(rt_table, objectCount, sizeof(struct rt_struct)))
		xraise(EN_MEM);
	ht_zero(rt_table);

	for (;objectCount > 0; objectCount--) {
		/* Read object address */
		buffer_read((char *)(&oldadd), sizeof(EIF_REFERENCE));

#if DEBUG & 1
		printf ("\n  %lx", oldadd);
#endif

		/* Read object flags (dynamic type) */
		buffer_read((char *)(&flags), sizeof(uint32));
		rt_read_cid (&crflags, &fflags, flags);

#if DEBUG & 1
		printf (" %x", flags);
#endif

		/* Read a possible size */
		if (flags & EO_SPEC) {
			uint32 count, elm_size;
			uint32 dgen, spec_type;
			struct gt_info *info;
			char *vis_name;

			spec_type = dtypes[flags & EO_TYPE];
			vis_name = System(spec_type).cn_generator;

			info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
			if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, :
			 *	"dtype visible_name size nb_generics {meta_type}+"
			 */
				int16 *gt_type = info->gt_type;
				int32 *gt_gen;
				int nb_gen = info->gt_param;
	
				for (;;) {
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
						spec_size = sizeof (EIF_OBJECT);
						break;
					default:
						if (dgen & SK_BIT) 
							spec_size = BITOFF(dgen & SK_DTYPE);
						else
							eise_io("General retrieve: not an Eiffel object.");
				}
			} else {
				spec_size = Size((uint16)(dgen & SK_DTYPE)) + OVERHEAD;
			}
			buffer_read((char *)(&count), sizeof(uint32));
			nb_char = CHRPAD(count * spec_size ) + LNGPAD_2;
			buffer_read((char *)(&elm_size), sizeof(uint32));

#if DEBUG & 1
		printf (" %x", count);
		printf (" %x", elm_size);
#endif
			newadd = spmalloc(nb_char);
			{
				long * o_ref;

				o_ref = (long *) (newadd + (HEADER(newadd)->ov_size & B_SIZE) - LNGPAD_2);
				*o_ref++ = count; 		
				*o_ref = spec_size;
				/* FIXME spec_elm_size[dtypes[flags & EO_TYPE]] = elm_size;*/
			} 
			HEADER(newadd)->ov_flags |= dtypes[flags & EO_TYPE] |
							(flags & (EO_REF|EO_COMP));
		} else {
			/* Normal object */
			nb_char = Size((uint16)(dtypes[flags & EO_TYPE]));
			newadd = emalloc(crflags & EO_TYPE); 
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
		gen_object_read (newadd, newadd);

		/* Update fileds: the garbage collector should not be called
		 * during `rt_update2' because the object is in a very unstable
		 * state.
		 */
		rt_update2(oldadd, newadd, newadd);

		/* Restore garbage collector status */
		g_data.status = g_status;
	}
	expop(&eif_stack);

	return newadd;

	EIF_END_GET_CONTEXT
}

rt_public char *irt_make(void)
{
	/* Make the retrieve of all objects in file */
	long objectCount;

	/* Read the object count in the file header */
	ridr_multi_int (&objectCount, 1);

#if DEBUG & 1
		printf ("\n %ld", objectCount);
#endif

	return irt_nmake(MTC objectCount);
}

rt_public char *irt_nmake(EIF_CONTEXT long int objectCount)
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */
	EIF_GET_CONTEXT
	long nb_char;
	char *oldadd;
	char *newadd = (char *) 0;
	EIF_OBJECT new_hector;
	uint32 crflags, fflags, flags;
	uint32 spec_size = 0;
	char g_status = g_data.status;
	jmp_buf exenv;
	RTXD;

#if DEBUG & 1
/*	long saved_objectCount = objectCount;

	if (objectCount == 0)
		eif_panic("no object to retrieve");*/
#endif
	excatch(MTC (char *) exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		RTXSC;					/* Restore stack contexts */
		rt_clean();				/* Clean data structure */
		ereturn(MTC_NOARG);				/* Propagate exception */
	}

	/* Initialization of the hash table */
	nb_recorded = 0;
	rt_table = (struct htable *) xmalloc(sizeof(struct htable), C_T, GC_OFF);
	if (rt_table == (struct htable *) 0)
		xraise(EN_MEM);
	if (-1 == ht_create(rt_table, objectCount, sizeof(struct rt_struct)))
		xraise(EN_MEM);
	ht_zero(rt_table);

	for (;objectCount > 0; objectCount--) {
		/* Read object address */
		ridr_multi_any ((char *) (&oldadd), 1);

#if DEBUG & 1
		printf ("\n  %lx", oldadd);
#endif

		/* Read object flags (dynamic type) */
		ridr_norm_int (&flags);
		rt_id_read_cid (&crflags, &fflags, flags);

#if DEBUG & 1
		printf (" %x", flags);
#endif

		/* Read a possible size */
		if (flags & EO_SPEC) {
			uint32 count, elm_size;
			uint32 dgen, spec_type;
			struct gt_info *info;
			char *vis_name;

			spec_type = dtypes[flags & EO_TYPE];
			vis_name = System(spec_type).cn_generator;


			info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
			if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, :
			 *	"dtype visible_name size nb_generics {meta_type}+"
			 */
				int16 *gt_type = info->gt_type;
				int32 *gt_gen;
				int nb_gen = info->gt_param;
	
				for (;;) {
#if DEBUG & 1
					if (*gt_type == SK_INVALID)
						eif_panic("corrupted cecil table");
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
						spec_size = sizeof (EIF_OBJECT);
						break;
					default:
						if (dgen & SK_BIT) 
							spec_size = BITOFF(dgen & SK_DTYPE);
						else
							eise_io("Independent retrieve: not an Eiffel object.");
				}
			} else {
				spec_size = Size((uint16)(dgen & SK_DTYPE)) + OVERHEAD;
			}
			ridr_norm_int (&count);
			nb_char = CHRPAD(count * spec_size ) + LNGPAD_2;
			ridr_norm_int (&elm_size);

#if DEBUG & 1
		printf (" %x", count);
		printf (" %x", elm_size);
#endif
			newadd = spmalloc(nb_char);
			{
				long * o_ref;

				o_ref = (long *) (newadd + (HEADER(newadd)->ov_size & B_SIZE) - LNGPAD_2);
				*o_ref++ = count; 		
				*o_ref = spec_size;
				spec_elm_size[dtypes[flags & EO_TYPE]] = elm_size;
			} 
			HEADER(newadd)->ov_flags |= dtypes[flags & EO_TYPE] |
							(flags & (EO_REF|EO_COMP));
		} else {
			/* Normal object */
			nb_char = Size((uint16)(dtypes[flags & EO_TYPE]));
			newadd = emalloc(crflags & EO_TYPE); 
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
		object_read (newadd, newadd);

		/* Update fileds: the garbage collector should not be called
		 * during `rt_update2' because the object is in a very unstable
		 * state.
		 */
		rt_update2(oldadd, newadd, newadd);

		/* Restore garbage collector status */
		g_data.status = g_status;
	}
	expop(&eif_stack);
#if DEBUG & 1
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
				eif_panic("retrieve incomplete");
			}
			if (rt_info->rt_status == SOLVED)
				nb_retrieved++;
		}
		if (nb_retrieved != saved_objectCount)
			eif_panic("retrieve failure");
		if (saved_objectCount != nomark(newadd))
			eif_panic("retrieve inconsistecy");
	} */
#endif
	return newadd;

	EIF_END_GET_CONTEXT
}

rt_private void rt_clean(void)
{
	/* Clean the data structure before raising an exception of code `code'
	/* after having cleaned the hash table */
	/* and allocated memory and reset function pointers. */
	EIF_GET_CONTEXT
	/* struct rt_struct *rt_info;*/ /* %%ss unused */

	if (rt_table != (struct htable *) 0) {
		struct rt_struct *rt_info = (struct rt_struct *) rt_table->h_values;
		int32 count = rt_table->h_size;

		for (; count > 0; count--, rt_info++) {
			if (rt_info->rt_status == UNSOLVED) {	/* Free cell list */
				struct rt_cell *cell, *next_cell;

				cell = rt_info->rt_list;
				while (cell != (struct rt_cell *) 0) {
					next_cell = cell->next;
					xfree((char *) cell);
					cell = next_cell;
				}
			}
		}
		ht_free(rt_table);						/* Free hash table descriptor */
	}
	if (dtypes != (int *) 0) {
		xfree((char *) dtypes);
		dtypes = (int *) 0;
	}
	if (spec_elm_size != (uint32 *)0) {
		xfree((char *) spec_elm_size);
		spec_elm_size = (uint32 *)0;
	}

	if (r_buffer != (char *)0) {
		xfree (r_buffer);
		r_buffer = (char *) 0;
	}
	epop(&hec_stack, nb_recorded);				/* Pop hector records */
	if (rt_kind == INDEPENDENT_STORE) {
		run_idr_destroy ();
		if (!(idr_temp_buf == (char *)0)) {
			xfree (idr_temp_buf);
			idr_temp_buf = (char *)0;
		}
		if (!(dattrib == (int **) 0)) {
			int i;

			for (i = 0; i < scount; i++) {
				if (*(dattrib + i))
					xfree ((char *) (*(dattrib +i)));
			}
			xfree ((char *) dattrib);
			dattrib = (int **) 0;
		}
	}
	free_sorted_attributes();
	rt_reset_retrieve();
	EIF_END_GET_CONTEXT
}

rt_private void rt_update1 (register char *old, register EIF_OBJECT new)
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
		eif_panic("cannot already be solved");
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
			eif_panic("should be solved");
#endif

		/* Attachement to hector pointer dereference */
		client = eif_access(rt_solved->rt_obj);
		supplier = eif_access(new);
		RTAS(supplier, client);					/* Age check */
		*(char **)(client + offset) = supplier;	/* Attachment */
	
		xfree((char *) rt_unsolved);		/* Free reference solving cell */
		rt_unsolved = next;	
	}

	/* Put the new hector pointer as a solved reference in the hash table */
	rt_info->rt_status = SOLVED;
	rt_info->rt_obj = new;
}

rt_private void rt_update2(char *old, char *new, char *parent)
{
	/* Reference field updating: record new unsolved references.
	 * The third argument is needed because of expanded objects:
	 * if `new' is not an expanded object,parent is equal to it. */

	long nb_references;
	uint32 flags, fflags;
	char *reference;
	union overhead *zone = HEADER(new);
	char* addr;
	long size;				/* New object size */
	/* struct rt_struct *rt_info;*/ /* %%ss unused */

	fflags = zone->ov_flags;
	flags = Mapped_flags(fflags);

	if (flags & EO_SPEC) {				/* Special object */
		char *o_ref;
		long count, elem_size, old_elem_size;

		if (!(flags & EO_REF))			/* Special without references */
			return;

		size = zone->ov_size & B_SIZE;	
		o_ref = (char *) (new + size - LNGPAD_2);
		count = *(long *) o_ref; 		
		if (!(flags & EO_COMP)) {		/* Special of references */
			nb_references = count;
			goto update;
		} else {						/* Special of expanded objects */
			char *old_addr;

			elem_size = *(long *) (o_ref + sizeof(long));
			if (rt_kind != INDEPENDENT_STORE) {
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
	} else {							/* Normal object */
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
	
				if (rt_kind == INDEPENDENT_STORE) {
					new_offset = get_expanded_pos (flags & EO_TYPE, (uint32)(total_ref - nb_references));
				} else
					new_offset = offset;
	
				*(char **) addr = new + new_offset;				/* Expanded reference */
				if (rt_kind) {
					/* CHECK THIS - M.S. */
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

				new_cell = (struct rt_cell *) xmalloc(sizeof(struct rt_cell), C_T, GC_OFF);
				if (new_cell == (struct rt_cell *)0)
					xraise (EN_MEM);
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


rt_private char *next_item (char *ptr)
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

rt_private void read_header(EIF_CONTEXT char rt_type)
{
	/* Read header and make the dynamic type correspondance table */
	EIF_GET_CONTEXT
	int nb_lines, i, k, old_count;
	int dtype, new_dtype;
	long size;
	int nb_gen, bsize = 1024;
	char vis_name[512];
	char * temp_buf;
	jmp_buf exenv;
	RTXD;

	errno = 0;

	excatch(MTC (char *) exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		RTXSC;					/* Restore stack contexts */
		rt_clean();				/* Clean data structure */
		ereturn(MTC_NOARG);				/* Propagate exception */
	}
	r_buffer = (char*) xmalloc (bsize * sizeof (char), C_T, GC_OFF);
	if (r_buffer == (char *)0)
		xraise (EN_MEM);

	/* Read the old maximum dyn type */
	if (readline(r_buffer, &bsize) <= 0)
		eise_io("General retrieve: unable to read number of different Eiffel types.");
	if (sscanf(r_buffer,"%d\n", &old_count) != 1)
		eise_io("General retrieve: unable to read number of different Eiffel types.");
	/* create a correspondance table */
	dtypes = (int *) xmalloc(old_count * sizeof(int), C_T, GC_OFF);
	if (dtypes == (int *) 0)
		xraise(EN_MEM);

	if ((rt_type == GENERAL_STORE_4_0) || (rt_type == GENERAL_STORE_3_3)) {
		sorted_attributes = (unsigned int **) xmalloc(scount * sizeof(unsigned int *), C_T, GC_OFF);
#ifdef DEBUG_GENERAL_STORE
printf ("Allocating sorted_attributes (scount: %d) %lx\n", scount, sorted_attributes);
#endif
		if (sorted_attributes == (unsigned int **)0) {
			xfree ((char *) dtypes);
			xraise(EN_MEM);
			}
		}
		bzero(sorted_attributes, scount * sizeof(unsigned int *));

	/* Read the number of lines */
	if (readline(r_buffer, &bsize) <= 0)
		eise_io("General retrieve: unable to read number of header lines.");
	if (sscanf(r_buffer,"%d\n", &nb_lines) != 1)
		eise_io("General retrieve: unable to read number of header lines.");

	for(i=0; i<nb_lines; i++) {
		if (readline(r_buffer, &bsize) <= 0)
			eise_io("General retrieve: unable to read current header line.");

		temp_buf = r_buffer;

		if (4 != sscanf(r_buffer, "%d %s %ld %d",&dtype,vis_name,&size,&nb_gen))
			eise_io("General retrieve: unable to read type description.");

		for (k = 1 ; k <= 4 ; k++)
			temp_buf = next_item (temp_buf);

		if (nb_gen > 0) {
			struct gt_info *info;
			int32 *t;
			int matched;
			int j, index;
			long gtype[MAX_GENERICS];
			int32 itype[MAX_GENERICS];
	

			/* Generic class */
			info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
			if (info == (struct gt_info *) 0)
				eraise(vis_name, EN_RETR);	/* Cannot find class */

			if (info->gt_param != nb_gen)
				eraise(vis_name, EN_RETR);	/* No good generic count */

			for (j=0; j<nb_gen; j++) {		/* Read meta-types */
				if (sscanf(temp_buf," %ld", &gtype[j]) != 1)
					eise_io("General retrieve: unable to read generic information.");
				temp_buf = next_item (temp_buf);
					
			}

			for (t = info->gt_gen; /* empty */; /* empty */) {

				if (*t == SK_INVALID)		/* Cannot find good meta-type */
					eraise(vis_name, EN_RETR);

				matched = 1;			/* Assume a perfect match */
				for (j=0; j<nb_gen; j++) {
					int32 gt;

					gt = (int32) gtype[j];
					itype[j] = *t++;
					if (itype[j] != gt)	/* Matching done on the fly */
						matched = 0;	/* The types do not match */
				}
				if (matched) {			/* We found the type */
					t -= nb_gen;
					break;			/* End of loop processing */
				}
			}
			index = (int) ((t - info->gt_gen) / nb_gen);
			new_dtype = info->gt_type[index] & SK_DTYPE;
		} else {
			int32 *addr;

			/* Non generic class */
			addr = (int32 *) ct_value(&egc_ce_type, vis_name);
			if (addr == (int32 *) 0)
				eraise(vis_name, EN_RETR);	/* Cannot find class */
			new_dtype = *addr & SK_DTYPE;
		}
		if (Size(new_dtype) != size) {
			eraise(vis_name, EN_RETR);		/* No good size */
		}
		dtypes[dtype] = new_dtype;

		if ((rt_type == GENERAL_STORE_4_0) || (rt_type == GENERAL_STORE_3_3))
			sort_attributes(new_dtype);
	}
	xfree (r_buffer);
	r_buffer = (char *) 0;
	expop(&eif_stack);

	EIF_END_GET_CONTEXT
}


rt_private void iread_header(EIF_CONTEXT_NOARG)
{
	/* Read header and make the dynamic type correspondance table */
	EIF_GET_CONTEXT
	int nb_lines, i, k, old_count;
	int dtype, new_dtype;
	int nb_gen, bsize = 1024;
	char vis_name[512];
	char * temp_buf;
	uint32 num_attrib;
	long read_attrib;
	char att_name[IDLENGTH + 1];
	int *attrib_order = (int *)0;
	jmp_buf exenv;
	RTXD;

	errno = 0;

	excatch(MTC (char *) exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		RTXSC;					/* Restore stack contexts */
		rt_clean();				/* Clean data structure */
		ereturn(MTC_NOARG);				/* Propagate exception */
	}

	r_buffer = (char*) xmalloc (bsize * sizeof (char), C_T, GC_OFF);
	if (r_buffer == (char *) 0)
		xraise (EN_MEM);

	/* Read the old maximum dyn type */
	if (idr_read_line(r_buffer, bsize) <= 0)
		eise_io("Independent retrieve: unable to read number of different Eiffel types.");
	if (sscanf(r_buffer,"%d\n", &old_count) != 1)
		eise_io("Independent retrieve: unable to read number of different Eiffel types.");
	/* create a correspondance table */
	dtypes = (int *) xmalloc(old_count * sizeof(int), C_T, GC_OFF);
	if (dtypes == (int *)0)
		xraise (EN_MEM);
	spec_elm_size = (uint32 *) xmalloc (old_count * sizeof (uint32), C_T, GC_OFF);
	if (spec_elm_size == (uint32 *)0)
		xraise (EN_MEM);
	if (idr_read_line(r_buffer, bsize) <= 0)
		eise_io("Independent retrieve: unable to read OVERHEAD size.");
	if (sscanf(r_buffer,"%d\n", &old_overhead) != 1)
		eise_io("Independent retrieve: unable to read OVERHEAD size.");
	if (dtypes == (int *) 0)
		xraise(EN_MEM);

	/* Read the number of lines */
	if (idr_read_line(r_buffer, bsize) <= 0)
		eise_io("Independent retrieve: unable to read number of header lines.");
	if (sscanf(r_buffer,"%d\n", &nb_lines) != 1)
		eise_io("Independent retrieve: unable to read number of header lines.");

	for(i=0; i<nb_lines; i++) {
		if (idr_read_line(r_buffer, bsize) <= 0)
			eise_io("Independent retrieve: unable to read current header line.");

		temp_buf = r_buffer;

		if (3 != sscanf(r_buffer, "%d %s %d",&dtype,vis_name,&nb_gen))
			eise_io("Indenpendent retrieve: unable to read type description.");

		for (k = 1 ; k <= 3 ; k++)
			temp_buf = next_item (temp_buf);

		if (nb_gen > 0) {
			struct gt_info *info;
			int32 *t;
			int matched;
			int j, index;
			long gtype[MAX_GENERICS];
			int32 itype[MAX_GENERICS];
	

			/* Generic class */
			info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
			if (info == (struct gt_info *) 0)
				eraise(vis_name, EN_RETR);	/* Cannot find class */

			if (info->gt_param != nb_gen)
				eraise(vis_name, EN_RETR);	/* No good generic count */

			for (j=0; j<nb_gen; j++) {		/* Read meta-types */
				if (sscanf(temp_buf," %ld", &gtype[j]) != 1)
					eise_io("Independent retrieve: unable to read generic information.");
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
			addr = (int32 *) ct_value(&egc_ce_type, vis_name);
			if (addr == (int32 *) 0)
				eraise(vis_name, EN_RETR);	/* Cannot find class */
			new_dtype = *addr & SK_DTYPE;
		}

								/* retrieve the number of attributes
								 * int the object 
								 */
		if (sscanf(temp_buf," %d", &num_attrib) != 1)
				/* error no value in buffer */
			eise_io("Independent retrieve: unable to read number of attributes.");


								/* Check the number of attributes
								 * match then verify the attributes
								 * types and names. Then store the
								 * position of the attribute in the
								 * object.
								 */
		if ((long) num_attrib == System(new_dtype).cn_nbattr) {
			int i, chk_attrib = num_attrib;

			if (num_attrib != 0) {			/* Only eif_malloc memory and process if 
								 * the object has attributes.
								 */
				attrib_order = (int *) xmalloc (num_attrib * sizeof (int), C_T, GC_OFF);
				if (attrib_order == (int *)0)
					xraise (EN_MEM);
				for (; num_attrib > 0;) {
					if (idr_read_line(r_buffer, bsize) <= 0) {
						xfree ((char *) attrib_order);
						eise_io("Independent retrieve: unable to read attribute description.");
					}
					if (sscanf(r_buffer," %lu %s", &read_attrib, att_name) != 2) {
						xfree ((char *) attrib_order);
						eise_io("Independent retrieve: unable to read attribute description.");
					}

								/* check attribute types */
					if ((*(System(new_dtype).cn_types + --num_attrib) & SK_HEAD) 
							== (uint32) read_attrib) {

									/* check attribute names */
						if (strcmp (att_name, 
								*(System (new_dtype).cn_names + num_attrib))) {
							i = 0;
	
							while (strcmp(att_name, 
									*(System (new_dtype).cn_names + i++))) {
								if (i > chk_attrib){
									xfree ((char *) attrib_order);
									eraise(vis_name, EN_RETR); 
										/* non matching attributes */
								}
							
							}
									/* check that the attribues of the
									 * same name is of the same type
									 */

							if ((*(System(new_dtype).cn_types + --i) & SK_HEAD) 
									== (uint32) read_attrib) {
								*(attrib_order + num_attrib) = i;
							} else {
								xfree ((char *) attrib_order);
								eraise(vis_name, EN_RETR);
									/* non matching attributes */
							}
						} else {
							*(attrib_order + num_attrib) = num_attrib;
						}
					} else {
						xfree ((char *) attrib_order);
						eraise(vis_name, EN_RETR);	/* non matching attributes */
					}
				}
			}
		} else {
			eraise(vis_name, EN_RETR);		/* wrong number of attributes */
		}
		dtypes[dtype] = new_dtype;			/* store new type on old type */
		dattrib [new_dtype] = attrib_order;		/* store position of attribute in obj*/
		attrib_order = (int *) 0;			/* make sure its null for next loop */
	}
	xfree (r_buffer);
	r_buffer = (char*) 0;
	expop(&eif_stack);

	EIF_END_GET_CONTEXT
}


rt_private int readline (register char *ptr, register int *maxlen)
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
		
			
rt_private int direct_read (register char *object, int size)
{
	EIF_GET_CONTEXT
	int i, amount = 0;
	char *buf = object;

	while (amount < size) {
		i = char_read_func (buf, size - amount);
		if (i <= 0)
				/* If we read 0 bytes, it means that we reached the end of file,
				 * so we are missing something, instead of going further we stop */
			eio();
		amount += i;
		buf += i;
	}
	return amount;
	EIF_END_GET_CONTEXT
}

rt_private int buffer_read (register char *object, int size)
{
	register int i;
 
#if DEBUG & 2
	printf ("Current position %d\n", current_position);
	printf ("Size %d\n", size);
	printf ("end_of_buffer %d\n", end_of_buffer);
#endif

	if (current_position + size >= end_of_buffer) {
		for (i = 0; i < size ; i++) {
			if (current_position >= end_of_buffer)
				if ((retrieve_read_func() == 0) && size != i + 1)
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

rt_private int new_buffer_read (register char *object, int size)
{
	register int read;

	if (current_position + size > end_of_buffer) {
		if (read = end_of_buffer - current_position) {
			memcpy (object, general_buffer + current_position, read);
				/* This line is useless since current_position is set to `0'
				 * after retrieve_read_func */
			/* current_position += read; */
			object += read;
		}
		if ((retrieve_read_func() == 0) && size != read + 1)
			eraise("incomplete file" , EN_RETR);

		if (size - read > end_of_buffer) {
			memcpy (object, general_buffer, end_of_buffer);
			read += end_of_buffer;
			current_position = end_of_buffer;
			return read + buffer_read (object + end_of_buffer, size - read);
		} else {
			current_position = size - read;
			memcpy (object, general_buffer, current_position);
			return size;
		}
	} else {
		memcpy (object, general_buffer + current_position, size);
		current_position += size;
		return size;
	}
}

rt_public int old_retrieve_read (void)
{
	EIF_GET_CONTEXT
	char * ptr = general_buffer;

	end_of_buffer = char_read_func (ptr, buffer_size);
	if (end_of_buffer <= 0)
			/* If we read 0 bytes, it means that we reached the end of file,
			 * so we are missing something, instead of going further we stop */
		eio();

	current_position = 0;
	return (end_of_buffer);
	EIF_END_GET_CONTEXT
}

rt_public int old_retrieve_read_with_compression (void)
{
	EIF_GET_CONTEXT
	  char* dcmps_in_ptr = (char *)0;
	  char* dcmps_out_ptr = (char *)0;
	  char* pdcmps_in_size = (char *)0;
	  int dcmps_in_size = 0;
	  int dcmps_out_size = 0;
	  char cmps_head [EIF_CMPS_HEAD_SIZE];
	  char* ptr = (char *)0;
	  int read_size = 0;
	  int part_read = 0;
	  int total_read = 0;

	  if ((char_read_func (cmps_head, EIF_CMPS_HEAD_SIZE)) < EIF_CMPS_HEAD_SIZE)
			eise_io("Retrieve: compression header mismatch.");
	  pdcmps_in_size = cmps_head + EIF_CMPS_HEAD_DIS_SIZE;
	  eif_cmps_read_u32_from_char_buf ((unsigned char*)pdcmps_in_size, (uint32*)&dcmps_in_size);

	  ptr = cmps_general_buffer;
	  memcpy(ptr, cmps_head, EIF_CMPS_HEAD_SIZE);
	  ptr += EIF_CMPS_HEAD_SIZE;
	  read_size = dcmps_in_size;

	  while (read_size > 0) {
			  part_read = char_read_func (ptr, read_size);
			  if (part_read <= 0)
				/* If we read 0 bytes, it means that we reached the end of file,
				 * so we are missing something, instead of going further we stop */
					eio();
			  read_size -= part_read;
			  ptr += part_read;
	  }

	  dcmps_in_ptr = cmps_general_buffer;
	  dcmps_out_ptr = general_buffer;

	  eif_decompress ((unsigned char*)dcmps_in_ptr,
									  (unsigned long)dcmps_in_size,
									  (unsigned char*)dcmps_out_ptr,
									  (unsigned long*)&dcmps_out_size);

	  current_position = 0;
	  end_of_buffer = dcmps_out_size;
	  return (end_of_buffer);
	EIF_END_GET_CONTEXT
}

rt_public int retrieve_read (void)
{
	EIF_GET_CONTEXT
	char * ptr = general_buffer;
	short read_size;
	int part_read = 0, total_read = 0;

	if ((char_read_func ((char *)&read_size, sizeof (short))) < sizeof (short))
		eise_io("Retrieve: unable to read buffer size.");
	end_of_buffer = read_size;

	while (read_size > 0) {
		part_read = char_read_func (ptr, read_size);
		if (part_read <= 0)
				/* If we read 0 bytes, it means that we reached the end of file,
				 * so we are missing something, instead of going further we stop */
			eio();
		read_size -= part_read;
		ptr += part_read;
	}
	current_position = 0;
	return (end_of_buffer);
	EIF_END_GET_CONTEXT
}

rt_public int retrieve_read_with_compression (void)
{
	EIF_GET_CONTEXT
	char* dcmps_in_ptr = (char *)0;
	char* dcmps_out_ptr = (char *)0;
	char* pdcmps_in_size = (char *)0;
	int dcmps_in_size = 0;
	int dcmps_out_size = 0;
	char cmps_head [EIF_CMPS_HEAD_SIZE];
	char* ptr = (char *)0;
	int read_size = 0;
	int part_read = 0;
	int total_read = 0;
	
	if ((char_read_func (cmps_head, EIF_CMPS_HEAD_SIZE)) < EIF_CMPS_HEAD_SIZE)
		eise_io("Retrieve: compression header mismatch.");
	pdcmps_in_size = cmps_head + EIF_CMPS_HEAD_DIS_SIZE;
	eif_cmps_read_u32_from_char_buf ((unsigned char*)pdcmps_in_size, (uint32*)&dcmps_in_size);

	ptr = cmps_general_buffer;
	memcpy(ptr, cmps_head, EIF_CMPS_HEAD_SIZE);
	ptr += EIF_CMPS_HEAD_SIZE;
	read_size = dcmps_in_size;
	
	while (read_size > 0) {
		part_read = char_read_func (ptr, read_size);
		if (part_read <= 0)
				/* If we read 0 bytes, it means that we reached the end of file,
				 * so we are missing something, instead of going further we stop */
			eio();
		read_size -= part_read;
		ptr += part_read;
	}
	
	dcmps_in_ptr = cmps_general_buffer;
	dcmps_out_ptr = general_buffer;
	
	eif_decompress ((unsigned char*)dcmps_in_ptr,
					(unsigned long)dcmps_in_size,
					(unsigned char*)dcmps_out_ptr,
					(unsigned long*)&dcmps_out_size);
	
	current_position = 0;
	end_of_buffer = dcmps_out_size;
	return (end_of_buffer);
	EIF_END_GET_CONTEXT
}

rt_private void gen_object_read (char *object, char *parent)
{
	long attrib_offset;
	/* int z;*/ /* %%ss removed */
	uint32 o_type;
	uint32 num_attrib;
	uint32 fflags = HEADER(object)->ov_flags;
	uint32 flags;
	/* int *attrib_order;*/ /* %%ss removed */

	flags = Mapped_flags(fflags);
	o_type = flags & EO_TYPE;
	num_attrib = System(o_type).cn_nbattr;

	if (num_attrib > 0) {
		for (; num_attrib > 0;) {
			uint32 types_cn;

			attrib_offset = get_alpha_offset(o_type, --num_attrib);
			types_cn = *(System(o_type).cn_types + num_attrib);

			switch (types_cn & SK_HEAD) {
				case SK_INT:
					buffer_read(object + attrib_offset, sizeof(EIF_INTEGER));
					break;
				case SK_BOOL:
				case SK_CHAR:
					buffer_read(object + attrib_offset, sizeof(EIF_CHARACTER));
					break;
				case SK_FLOAT:
					buffer_read(object + attrib_offset, sizeof(EIF_REAL));
					break;
				case SK_DOUBLE:
					buffer_read(object + attrib_offset, sizeof(EIF_DOUBLE));
					break;
				case SK_BIT:
						{
							/* int q; */ /* %%ss removed */
							uint32 old_flags, hflags;
							struct bit *bptr = (struct bit *)(object + attrib_offset);

							HEADER(bptr)->ov_flags = egc_bit_dtype;
							buffer_read((char *) (&old_flags), sizeof(uint32));
							rt_read_cid ((uint32 *) 0, &hflags, old_flags);
							HEADER(bptr)->ov_flags = hflags & (EO_COMP | EO_REF);

							buffer_read((char *) bptr, bptr->b_length);
							if ((types_cn & SK_DTYPE) != LENGTH(bptr))
								eise_io("General retrieve: mismatch size for BIT object.");
						}

					break;
				case SK_EXP: {
					uint32  old_flags, hflags;
					long size_count;

					buffer_read(object + attrib_offset, sizeof(EIF_REFERENCE));
					buffer_read((char *) (&old_flags), sizeof(uint32));
					rt_read_cid ((uint32 *) 0, &hflags, old_flags);
					/* FIXME size_count = get_expanded_pos (o_type, attrib_order[--num_attrib]);*/
					size_count = get_expanded_pos (o_type, --num_attrib);

					HEADER(object + size_count)->ov_flags = (hflags & (EO_REF|EO_COMP|EO_TYPE));
					HEADER(object + size_count)->ov_size = (uint32)(get_expanded_pos (o_type, -1) + (object - parent));
					gen_object_read (object + size_count, parent);						

					}
					break;
				case SK_REF:
				case SK_POINTER:
					buffer_read(object + attrib_offset, sizeof(EIF_REFERENCE));
					break;
				default:
					eise_io("General retrieve: not an Eiffel object.");
			}
		} 
	} else {
		if (flags & EO_SPEC) {		/* Special object */
			long count, elem_size;
			char *ref, *o_ptr;
			char *vis_name;
			uint32 dgen;
			struct gt_info *info;

			o_ptr = (char *) (object + (HEADER(object)->ov_size & B_SIZE) - LNGPAD_2);
			count = *(long *) o_ptr;
			vis_name = System(o_type).cn_generator;


			info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
			if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, :
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
	
			if (!(flags & EO_REF)) {			/* Special of simple types */
				switch (dgen & SK_HEAD) {
					case SK_INT:
						buffer_read((char *)object, count*sizeof(EIF_INTEGER));
						break;
					case SK_BOOL:
					case SK_CHAR:
						buffer_read(object, count*sizeof(EIF_CHARACTER));
						break;
					case SK_FLOAT:
						buffer_read((char *)object, count*sizeof(EIF_REAL));
						break;
					case SK_DOUBLE:
						buffer_read((char *)object, count*sizeof(EIF_DOUBLE));
						break;
					case SK_EXP: {
						uint32 old_flags, hflags;

						elem_size = *(long *) (o_ptr + sizeof(long));
						buffer_read((char *) (&old_flags), sizeof(uint32));
						rt_read_cid ((uint32 *) 0, &hflags, old_flags);
						for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
	
							HEADER(ref)->ov_flags = (hflags & (EO_REF|EO_COMP|EO_TYPE));
							HEADER(ref)->ov_size = (uint32)(ref - parent);
							gen_object_read (ref, parent);						
							}
						}
						break;
					case SK_BIT: {
						/* uint32 l;*/ /* %%ss removed */

						elem_size = *(long *) (o_ptr + sizeof(long));
						buffer_read((char *)object, count*elem_size); /* %%ss cast was struct bit* */
						}
						break;
					case SK_POINTER:
						buffer_read(object, count*sizeof(EIF_POINTER));
						break;
					default:
   	   			  		eise_io("General retrieve: not an Eiffel object.");
						break;
				}
			} else {
				if (!(flags & EO_COMP)) {		/* Special of references */
					buffer_read(object, count*sizeof(EIF_REFERENCE));
				} else {						/* Special of composites */
					uint32  old_flags, hflags;

					buffer_read((char *) (&old_flags), sizeof(uint32));
					rt_read_cid ((uint32 *) 0, &hflags, old_flags);
					elem_size = *(long *) (o_ptr + sizeof(long));
					for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
						HEADER(ref)->ov_flags = (hflags & (EO_REF|EO_COMP|EO_TYPE));
						HEADER(ref)->ov_size = (uint32)(ref - parent);
						gen_object_read (ref, parent);						
					}
				}
			}
		} 
	}
}


rt_private void object_read (char *object, char *parent)
{
#if DEBUG & 1
	int z;
#endif
	long attrib_offset;
	uint32 o_type;
	uint32 num_attrib;
	uint32 fflags = HEADER(object)->ov_flags;
	uint32 flags;
	int *attrib_order;

	flags = Mapped_flags(fflags);
	o_type = flags & EO_TYPE;
	num_attrib = System(o_type).cn_nbattr;
	attrib_order = dattrib[o_type];

	if (num_attrib > 0) {
		for (; num_attrib > 0;) {
			uint32 types_cn;

			attrib_offset = get_offset(o_type, attrib_order[--num_attrib]);
			types_cn = *(System(o_type).cn_types + num_attrib);

			switch (types_cn & SK_HEAD) {
				case SK_INT:
					ridr_multi_int ((long int *) (object + attrib_offset), 1);
#if DEBUG & 1
					printf (" %lx", *((long *)(object + attrib_offset)));
#endif

					break;
				case SK_BOOL:
				case SK_CHAR:
					ridr_multi_char (object + attrib_offset, 1);
#if DEBUG & 1
					printf (" %lx", *((char *)(object + attrib_offset)));
#endif

					break;
				case SK_FLOAT:
					ridr_multi_float ((float *) (object + attrib_offset), 1);
#if DEBUG & 1
					printf (" %f", *((float *)(object + attrib_offset)));
#endif

					break;
				case SK_DOUBLE:
					ridr_multi_double ((double *) (object + attrib_offset), 1);
#if DEBUG & 1
					printf (" %lf", *((double *)(object + attrib_offset)));
#endif

					break;
				case SK_BIT:
						{
#if DEBUG & 1
							int q;
#endif
							uint32 old_flags, hflags;
							struct bit *bptr = (struct bit *)(object + attrib_offset);

							HEADER(bptr)->ov_flags = egc_bit_dtype;
							ridr_norm_int (&old_flags);
							rt_id_read_cid ((uint32 *) 0, &hflags, old_flags);
							HEADER(bptr)->ov_flags = hflags & (EO_COMP | EO_REF);

							ridr_multi_bit (bptr, 1, 0);
							if ((types_cn & SK_DTYPE) != LENGTH(bptr))
								eise_io("Basic retrieve: mismatch size for BIT object.");
#if DEBUG & 1
							printf (" %x", (bptr->b_length));
							printf (" %x", old_flags);
							for (q = 0; q < BIT_NBPACK( LENGTH(bptr)) ; q++) {
								printf (" %lx", *((uint32 *)(bptr->b_value + q)));
								if (!(q % 40))
									printf ("\n");
							}
#endif
						}

					break;
				case SK_EXP: {
					uint32  old_flags, hflags;
					long size_count;

					ridr_multi_any (object + attrib_offset, 1);
					ridr_norm_int (&old_flags);
					rt_id_read_cid ((uint32 *) 0, &hflags, old_flags);
					size_count = get_expanded_pos (o_type, attrib_order[--num_attrib]);

#if DEBUG & 1
					printf ("\n %lx", *((char **)(object + attrib_offset)));
					printf (" %lx", old_flags);
#endif
					HEADER(object + size_count)->ov_flags = (hflags & (EO_REF|EO_COMP|EO_TYPE));
					HEADER(object + size_count)->ov_size = (uint32)(get_expanded_pos (o_type, -1) + (object - parent));
					object_read (object + size_count, parent);						

					}
					break;
				case SK_REF:
				case SK_POINTER:
					ridr_multi_any (object + attrib_offset, 1);
#if DEBUG & 1
					printf (" %lx", *((char **)(object + attrib_offset)));
#endif
					break;

				default:
					eise_io("Basic retrieve: not an Eiffel object.");
			}
		} 
	} else {
		if (flags & EO_SPEC) {		/* Special object */
			long count, elem_size;
			char *ref, *o_ptr;
			char *vis_name;
			uint32 dgen;
			struct gt_info *info;

			o_ptr = (char *) (object + (HEADER(object)->ov_size & B_SIZE) - LNGPAD_2);
			count = *(long *) o_ptr;
			vis_name = System(o_type).cn_generator;


			info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
			if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, :
			 *	"dtype visible_name size nb_generics {meta_type}+"
			 */
				int16 *gt_type = info->gt_type;
				int32 *gt_gen;
				int nb_gen = info->gt_param;
	
				for (;;) {
#if DEBUG & 1
					if (*gt_type == SK_INVALID)
						eif_panic("corrupted cecil table");
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
						ridr_multi_int ((long *)object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((long *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif

						break;
					case SK_BOOL:
					case SK_CHAR:
						ridr_multi_char (object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lx", *((char *)(object + z)));
							if (!(z % 40))
								printf ("\n");
						}
#endif

						break;
					case SK_FLOAT:
						ridr_multi_float ((float *)object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %f", *(((float *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif

						break;
					case SK_DOUBLE:
						ridr_multi_double ((double *)object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lf", *(((double *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif
						break;
					case SK_EXP: {
						uint32  old_flags, hflags;

						elem_size = *(long *) (o_ptr + sizeof(long));
						ridr_norm_int (&old_flags);
						rt_id_read_cid ((uint32 *) 0, &hflags, old_flags);
						for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
	
#if DEBUG & 1
							printf (" %x", old_flags);
#endif
							HEADER(ref)->ov_flags = (hflags & (EO_REF|EO_COMP|EO_TYPE));
							HEADER(ref)->ov_size = (uint32)(ref - parent);
							object_read (ref, parent);						
	
						}
					}
						break;
					case SK_BIT: 
					{
#if DEBUG & 1
						uint32 l; /* %%ss read but never initialized */
#endif
						elem_size = *(long *) (o_ptr + sizeof(long));
						ridr_multi_bit ((struct bit *)object, count, elem_size);
#if DEBUG & 1
						printf (" %x", l);

						for (ref = object; count > 0; count--, ref += elem_size ) {
							int q;
							for (q = 0; q < BIT_NBPACK(l) ; q++) {
								printf (" %lx", *((uint32 *)(((struct bit *)ref)->b_value + q)));
								if (!(q % 40))
									printf ("\n");
							}
							printf ("\n");
						}
#endif
					}
						break;
					case SK_POINTER:
						ridr_multi_any (object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((char *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif

						break;

					default:
						eise_io("Basic retrieve: not an Eiffel object.");
						break;
				}
			} else {
	
				if (!(flags & EO_COMP)) {		/* Special of references */
					ridr_multi_any (object, count);
#if DEBUG & 1
					for (ref = object; count > 0; count--,
							ref = (char *) ((char **) ref + 1)) {
						printf (" %lx", *(char **)(ref));
						if (!(count % 40))
							printf ("\n");
					}
#endif
				} else {						/* Special of composites */
					uint32  old_flags, hflags;

					ridr_norm_int (&old_flags);
					rt_read_cid ((uint32 *) 0, &hflags, old_flags);
#if DEBUG & 1
					printf (" %x", old_flags);
#endif
					elem_size = *(long *) (o_ptr + sizeof(long));
					for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
						HEADER(ref)->ov_flags = (hflags & (EO_REF|EO_COMP|EO_TYPE));
						HEADER(ref)->ov_size = (uint32)(ref - parent);
						object_read (ref, parent);						
					}
				}
			}
		} 
	}
}

rt_private long dbl_off(long v, long w, long x, long y, long z)
{
	return (PTROFF(v,w,x,y)+(z)*PTRSIZ+PADD(PTROFF(v,w,x,y)+(z)*PTRSIZ,DBLSIZ));
}

rt_private long obj_size(long u, long v, long w, long x, long y, long z)
{
	return (dbl_off(u,v,w,x,y)+(z)*DBLSIZ+REMAINDER(dbl_off(u,v,w,x,y)+(z)*DBLSIZ));
}

rt_private long get_expanded_pos (uint32 o_type, uint32 num_attrib)
{
	/* long Result;*/ /* %%ss removed */
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
				eise_io("Retrieve: incorrect expanded object.");
		}
	}
#ifdef SYMANTEC_CPP
	return (obj_size(num_ref,num_char,num_int,num_float,num_pointer,num_double)+bit_size+exp_size+OVERHEAD);
#else
	return ((long) OBJSIZ(num_ref,num_char,num_int,num_float,num_pointer,num_double)+bit_size+exp_size+OVERHEAD);
#endif
}

int char_read(char *pointer, int size)
{
	EIF_GET_CONTEXT
	return read(r_fides, pointer, size);
	EIF_END_GET_CONTEXT
}

int stream_read(char *pointer, int size)
{
	EIF_GET_CONTEXT

	if (stream_buffer_size - stream_buffer_position < size) {
		stream_buffer_size += buffer_size;
		stream_buffer = (char *) realloc (stream_buffer, stream_buffer_size);
	}	

	memcpy (pointer, (stream_buffer + stream_buffer_position), size);
	stream_buffer_position += size;
	return size;
	EIF_END_GET_CONTEXT
}

rt_private void rt_read_cid (uint32 *crflags, uint32 *nflags, uint32 oflags)

{
	int16 count, dftype;

	*nflags = oflags;   /* default */

	if (rt_kind) {
		if (crflags != (uint32 *) 0)
			/* Used for creation (emalloc). Map type */
			*crflags = (uint32) dtypes [oflags & EO_TYPE];
	} else
		*crflags = oflags;

	buffer_read ((char *) &count, sizeof (int16));

	if (count < 2)  /* Nothing to read */
		return;

	*cidarr = count;
	buffer_read ((char *) (cidarr+1), count * sizeof (int16));
	cidarr [count+1] = -1;

	if (rt_kind)
		dftype = eif_gen_id_from_cid (cidarr, dtypes);
	else
		dftype = eif_gen_id_from_cid (cidarr, (int *)0);

	*nflags = (oflags & EO_UPPER) | dftype;

	if (crflags != (uint32 *) 0)
		/* Used for creation (emalloc). Map type */
		*crflags = *nflags;
}

rt_private void rt_id_read_cid (uint32 *crflags, uint32 *nflags, uint32 oflags)

{
	uint32 count, val;
	int16 dftype, *ip;
	int i;

	*nflags = oflags;   /* default */

	if (rt_kind) {
		if (crflags != (uint32 *) 0)
			/* Used for creation (emalloc). Map type */
			*crflags = (uint32) dtypes [oflags & EO_TYPE];
	} else
		*crflags = oflags;

	ridr_norm_int (&count);    

	if (count < 2)  /* Nothing to read */
		return;

	*cidarr = count;
	ip = cidarr + 1;

	for (i = count; i; --i, ++ip)
	{
		ridr_norm_int (&val);
		*ip = (int16) val;
	}

	cidarr [count+1] = -1;

	if (rt_kind)
		dftype = eif_gen_id_from_cid (cidarr, dtypes);
	else
		dftype = eif_gen_id_from_cid (cidarr, (int *)0);

	*nflags = (oflags & EO_UPPER) | dftype;

	if (crflags != (uint32 *) 0)
		/* Used for creation (emalloc). Map type */
		*crflags = *nflags;
}

