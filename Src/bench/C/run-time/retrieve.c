/*

 #####   ######   #####  #####      #    ######  #    #  ######           ####
 #    #  #          #    #    #     #    #       #    #  #               #    #
 #    #  #####      #    #    #     #    #####   #    #  #####           #
 #####   #          #    #####      #    #       #    #  #        ###    #
 #   #   #          #    #   #      #    #        #  #   #        ###    #    #
 #    #  ######     #    #    #     #    ######    ##    ######   ###     ####

	Eiffel retrieve mechanism.
*/

#include "eif_portable.h"
#include "eif_lmalloc.h"
#include "eif_project.h" /* for egc_ce_gtype, egc_bit_dtype */
#include "eif_macros.h"
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "eif_except.h"
#include "eif_hector.h"
#include "eif_cecil.h"
#include "eif_retrieve.h"
#include "eif_store.h"
#include "eif_bits.h"
#include "eif_run_idr.h"
#include "eif_error.h"
#include "eif_traverse.h"
#include "rt_compress.h"
#include "x2c.h"	/* For macro LNGPAD */
#ifdef VXWORKS
#include <unistd.h>	/* For read () */
#endif
#include "rt_assert.h"

#include <ctype.h>					/* For isspace() */

#ifdef EIF_OS2
#include <io.h>
#endif

#include <string.h>

#ifdef EIF_WIN32
#include <io.h>		/* %%ss added for read */
#include <winsock.h>
#endif

/*#define DEBUG_GENERAL_STORE */	/**/

/*#define DEBUG 1 */ /**/

/* Size of the buffer to retrieve an object */
#define RETRIEVE_BUFFER_SIZE 262144L

#define MAX_GENERICS      4		/* Number of generic parameters that are statically
								   allocated */

/*
 * Public data declarations 
 */
rt_public struct htable *rt_table;		/* Table used for solving references */
rt_public int32 nb_recorded = 0;		/* Number of items recorded in Hector */
rt_public char rt_kind;			/* Kind of storable */
rt_public char rt_kind_version;		/* Version of storable */
rt_public EIF_BOOLEAN eif_discard_pointer_values = EIF_TRUE;/* We do not keep pointer values
															   when retrieving a pointer object */

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
rt_public EIF_REFERENCE stream_eretrieve(char **, long, long, EIF_INTEGER *);	/* Retrieve object store in stream */
rt_public char *portable_retrieve(int (*char_read_function)(char *, int));

rt_public char *irt_make(void);			/* Do the independant retrieve */
rt_public char *grt_make(void);			/* Do the general retrieve (3.3 and later) */
rt_public char *irt_nmake(long int objectCount);			/* Retrieve n objects independent form*/
rt_public char *grt_nmake(long int objectCount);			/* Retrieve n objects general form*/
rt_private void iread_header(EIF_CONTEXT_NOARG);		/* Read independent header */
rt_private void rt_clean(void);			/* Clean data structure */
rt_private void rt_update1(register char *old, register EIF_OBJECT new);			/* Reference correspondance update */
rt_private void rt_update2(char *old, char *new, char *parent);			/* Fields updating */
rt_public char *rt_make(void);				/* Do the retrieve */
rt_public char *rt_nmake(long int objectCount);			/* Retrieve n objects */
rt_private void read_header(char rt_type);



		/* Read general header */
rt_private void object_read (char *object, char *parent);		/* read the individual attributes of the object*/
rt_private void gen_object_read (char *object, char *parent);	/* read the individual attributes of the object*/
rt_private long get_expanded_pos (uint32 o_type, uint32 num_attrib);

rt_private int readline (register char *ptr, register int *maxlen);
rt_private int buffer_read (register char *object, int size);
rt_private void rt_read_cid (uint32 *, uint32 *, uint32);
rt_private void rt_id_read_cid (uint32 *, uint32 *, uint32);

/* Initialization and Resetting for retrieving an independent store */
rt_private void independent_retrieve_init (long idrf_size);
rt_private void independent_retrieve_reset (void);

/* Functions to write on the specified IO_MEDIUM */
rt_private int (char_read) (char *, int);
rt_private int (stream_read) (char *, int);

/* read function declarations */
int retrieve_read (void);
int retrieve_read_with_compression (void);

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
}

rt_public EIF_REFERENCE stream_eretrieve(char **buffer, long size, long start_pos, EIF_INTEGER *real_size)
{
	EIF_REFERENCE new_object;
	stream_buffer = *buffer;
	stream_buffer_size = size;
	stream_buffer_position = start_pos;

	new_object = portable_retrieve(stream_read);
	*real_size = stream_buffer_position;
	return new_object;
}

rt_public char *portable_retrieve(int (*char_read_function)(char *, int))
{
	/* Retrieve object store in file `filename' */

	EIF_GET_CONTEXT
	char *retrieved = (char *) 0;
	char rt_type = (char) 0;

#ifdef EIF_ALPHA
		/* The conversion from a FILE pointer to a file descriptor
		 * does not keep the position correctly in the stream, one has
		 * to call `fflush' to ensure the validity of the position in
		 * the stream.
		 */
	fflush (NULL);
#endif

	/* Reset nb_recorded */
	nb_recorded = 0;

	/* Read the kind of stored hierachy */
	if (char_read_function(&rt_type, sizeof (char)) < sizeof (char))
		eise_io("Retrieve: unable to read type of storable.");

	/* set rt_kind depending on the type to be retrieved */

	switch (rt_type) {
		case BASIC_STORE_4_0:			/* New Basic store */
			rt_init_retrieve(retrieve_read_with_compression, char_read_function, RETRIEVE_BUFFER_SIZE);
			allocate_gen_buffer ();
			rt_kind = BASIC_STORE;
			break;
		case GENERAL_STORE_4_0:			/* New General store */
			rt_init_retrieve(retrieve_read_with_compression, char_read_function, RETRIEVE_BUFFER_SIZE);
			allocate_gen_buffer ();
			rt_kind = GENERAL_STORE;
			break;
		case INDEPENDENT_STORE_4_3:
		case INDEPENDENT_STORE_4_4:
		case INDEPENDENT_STORE_5_0:
			rt_init_retrieve(retrieve_read_with_compression, char_read_function, RETRIEVE_BUFFER_SIZE);
			rt_kind = INDEPENDENT_STORE;
			rt_kind_version = rt_type;
			independent_retrieve_init (RETRIEVE_BUFFER_SIZE);
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
	} else if (rt_type == GENERAL_STORE_4_0) {
		read_header(rt_type);					/* Make correspondance table */
		retrieved = grt_make();
	} else {
		if (rt_kind)
			read_header(rt_type);			/* Make correspondance table */

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
		case GENERAL_STORE_4_0: 
			free_sorted_attributes();
			break;
		case INDEPENDENT_STORE_4_3:
		case INDEPENDENT_STORE_4_4:
		case INDEPENDENT_STORE_5_0:
			independent_retrieve_reset ();
			break;
	}
	rt_reset_retrieve();

	return retrieved;
}

rt_public EIF_REFERENCE ise_compiler_retrieve (EIF_INTEGER f_desc, int (*retrieve_function) (void))
{
	EIF_GET_CONTEXT
	EIF_REFERENCE retrieved = (char *) 0;
	char rt_type = (char) 0;

	rt_kind = BASIC_STORE;
	r_fides = f_desc;
#ifdef EIF_ALPHA
		/* The conversion from a FILE pointer to a file descriptor
		 * does not keep the position correctly in the stream, one has
		 * to call `fflush' to ensure the validity of the position in
		 * the stream.
		 */
	fflush (NULL);
#endif

	/* Reset nb_recorded */
	nb_recorded = 0;

	/* Read the kind of stored hierachy */
	if (char_read(&rt_type, sizeof (char)) < sizeof (char))
		eise_io("Retrieve: unable to read type of storable.");

	CHECK ("Valid basic storable type", rt_type == BASIC_STORE_4_0);

	rt_init_retrieve(retrieve_function, char_read, RETRIEVE_BUFFER_SIZE);
	allocate_gen_buffer ();

	retrieved = rt_make();

	ht_free(rt_table);					/* Free hash table descriptor */
	epop(&hec_stack, nb_recorded);		/* Pop hector records */
	rt_reset_retrieve();
	return retrieved;
}


/* Initialization for retrieving an independent store
 */
rt_private void independent_retrieve_init (long idrf_size)
{
		/* Initialize serialization streams for reading (0 stands for read) */
	run_idr_init (idrf_size, 0);

	idr_temp_buf = (char *) xmalloc (48, C_T, GC_OFF);
	if (idr_temp_buf == (char *)0)
		xraise (EN_MEM);

	dattrib = (int **) xmalloc (scount * sizeof (int *), C_T, GC_OFF);
	if (dattrib == (int **)0){
		xfree(idr_temp_buf);
		xraise (EN_MEM);
	}
	memset  ((char *)dattrib, 0, scount * sizeof (int *));
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
	buffer_read((char *) &objectCount, (sizeof(long)));

	return rt_nmake(objectCount);
}

rt_public EIF_REFERENCE rt_nmake(long int objectCount)
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */
	EIF_GET_CONTEXT
	long nb_byte;
	EIF_REFERENCE oldadd;
	volatile EIF_REFERENCE newadd = (EIF_REFERENCE) 0;
	EIF_OBJECT new_hector;
	uint32 crflags, fflags, flags;
	uint32 spec_size = 0;
	volatile size_t n = objectCount;
	char g_status = g_data.status;
	jmp_buf exenv;
	RTXD;

	REQUIRE ("Positive count", objectCount > 0);

	excatch(&exenv);	/* Record pseudo execution vector */
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
	for (;n > 0; n--) {
		/* Read object address */

		buffer_read((char *) &oldadd, sizeof(EIF_REFERENCE));

#if DEBUG & 2
		printf ("\n  %lx", oldadd);
#endif

		/* Read object flags (dynamic type) */
		buffer_read((char *) &flags, (sizeof(uint32)));
		rt_read_cid (&crflags, &fflags, flags);

#if DEBUG & 2
		printf (" %x", flags);
#endif

		/* Read a possible size */
		if (flags & EO_SPEC) {
				/* Special object: read the saved size */
			buffer_read((char *) &spec_size, (sizeof(uint32)));
			nb_byte = spec_size & B_SIZE;
			if (!(flags & EO_REF))
				newadd = spmalloc(nb_byte, EIF_TRUE);
			else
				newadd = spmalloc(nb_byte, EIF_FALSE);
			HEADER(newadd)->ov_flags |= crflags & (EO_REF|EO_COMP|EO_TYPE);
		} else {
				/* Normal object */
			if (rt_kind) {
				nb_byte = EIF_Size((uint16)(dtypes[flags & EO_TYPE]));
				newadd = emalloc(crflags & EO_TYPE); 
			} else {
				nb_byte = EIF_Size((uint16)(flags & EO_TYPE));
				newadd = emalloc(crflags & EO_TYPE);
			}
		}
		
			/* Creation of the Eiffel object */	
		if (newadd == (EIF_REFERENCE) 0)
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
		buffer_read(newadd, nb_byte);

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
}

rt_public char *grt_make(void)
{
		/* Make the retrieve of all objects in file */
	long objectCount;

		/* Read the object count in the file header */
	buffer_read((char *) &objectCount, sizeof(long));

	return grt_nmake(objectCount);
}

rt_public char *grt_nmake(long int objectCount)
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */
	EIF_GET_CONTEXT
	long nb_byte;
	char *oldadd;
	char * volatile newadd = (char *) 0;
	EIF_OBJECT new_hector;
	uint32 crflags, fflags, flags;
	volatile uint32 spec_size = 0;
	volatile long int n = objectCount;
	char g_status = g_data.status;
	jmp_buf exenv;
	RTXD;

	REQUIRE ("Positive count", objectCount > 0);

	excatch(&exenv);	/* Record pseudo execution vector */
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

	for (;n > 0; n--) {
		/* Read object address */
		buffer_read((char *) &oldadd, sizeof(EIF_REFERENCE));

#if DEBUG & 1
		printf ("\n  %lx", oldadd);
#endif

		/* Read object flags (dynamic type) */
		buffer_read((char *) &flags, sizeof(uint32));
		rt_read_cid (&crflags, &fflags, flags);

#if DEBUG & 1
		printf (" %x", flags);
#endif

		/* Read a possible size */
		if (flags & EO_SPEC) {
			uint32 count, elm_size;
			uint32 dgen, spec_type;
			int16 *gt_type;
			int32 *gt_gen;
			int nb_gen;
			struct gt_info *info;
			char *vis_name;

			spec_type = dtypes[flags & EO_TYPE];
			vis_name = System(spec_type).cn_generator;

			info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
			CHECK ("Must be generic", info != (struct gt_info *) 0);

			/* Generic type, :
			 *	"dtype visible_name size nb_generics {meta_type}+"
			 */
			gt_type = info->gt_type;
			nb_gen = info->gt_param;

			for (;;) {
				if ((*gt_type++ & SK_DTYPE) == (int16) spec_type)
					break;
			}
			gt_type--;
			gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
			dgen = *gt_gen;

			if (!((dgen & SK_HEAD) == SK_EXP)) {
				switch (dgen) {
					case SK_INT8:
						spec_size = sizeof (EIF_INTEGER_8);
						break;
					case SK_INT16:
						spec_size = sizeof (EIF_INTEGER_16);
						break;
					case SK_INT32:
						spec_size = sizeof (EIF_INTEGER_32);
						break;
					case SK_INT64:
						spec_size = sizeof (EIF_INTEGER_64);
						break;
					case SK_CHAR:
						spec_size = sizeof (EIF_CHARACTER);
						break;
					case SK_WCHAR:
						spec_size = sizeof (EIF_WIDE_CHAR);
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
				spec_size = EIF_Size((uint16)(dgen & SK_DTYPE)) + OVERHEAD;
			}
			buffer_read((char *) &count, sizeof(uint32));
			nb_byte = CHRPAD(count * spec_size ) + LNGPAD_2;
			buffer_read((char *) &elm_size, sizeof(uint32));

#if DEBUG & 1
		printf (" %x", count);
		printf (" %x", elm_size);
#endif
			if (!(crflags & EO_REF))
				newadd = spmalloc(nb_byte, EIF_TRUE);
			else
				newadd = spmalloc(nb_byte, EIF_FALSE);
			{
				long * o_ref;

				o_ref = (long *) (newadd + (HEADER(newadd)->ov_size & B_SIZE) - LNGPAD_2);
				*o_ref++ = count; 		
				*o_ref = spec_size;
				/* FIXME spec_elm_size[dtypes[flags & EO_TYPE]] = elm_size;*/
			} 
			HEADER(newadd)->ov_flags |= crflags & (EO_REF|EO_COMP|EO_TYPE);
		} else {
			/* Normal object */
			nb_byte = EIF_Size((uint16)(dtypes[flags & EO_TYPE]));
			newadd = emalloc(crflags & EO_TYPE); 
		}
		
		/* Creation of the Eiffel object */	
		if (newadd == (EIF_REFERENCE) 0)
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
}

rt_public char *irt_make(void)
{
	/* Make the retrieve of all objects in file */
	EIF_INTEGER_32 objectCount;

	/* Read the object count in the file header */
	ridr_multi_int32 (&objectCount, 1);

#if DEBUG & 1
		printf ("\n %ld", objectCount);
#endif

	return irt_nmake(objectCount);
}

rt_public char *irt_nmake(long int objectCount)
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */
	EIF_GET_CONTEXT
	long nb_byte;
	char *oldadd;
	char * volatile newadd = NULL;
	EIF_OBJECT new_hector;
	uint32 crflags, fflags, flags;
	volatile uint32 spec_size = 0;
	volatile long int n = objectCount;
	char g_status = g_data.status;
	jmp_buf exenv;
	RTXD;

	REQUIRE ("Positive count", objectCount > 0);

	excatch(&exenv);	/* Record pseudo execution vector */
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

	for (;n > 0; n--) {
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
			int16 *gt_type;
			int32 *gt_gen;
			int nb_gen;
			struct gt_info *info;
			char *vis_name;

			spec_type = dtypes[flags & EO_TYPE];
			vis_name = System(spec_type).cn_generator;


			info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
			CHECK ("Must be generic", info != (struct gt_info *) 0);

			/* Generic type, :
			 *	"dtype visible_name size nb_generics {meta_type}+"
			 */
			gt_type = info->gt_type;
			nb_gen = info->gt_param;

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

			if (!((dgen & SK_HEAD) == SK_EXP)) {
				switch (dgen) {
					case SK_INT8:
						spec_size = sizeof (EIF_INTEGER_8);
						break;
					case SK_INT16:
						spec_size = sizeof (EIF_INTEGER_16);
						break;
					case SK_INT32:
						spec_size = sizeof (EIF_INTEGER_32);
						break;
					case SK_INT64:
						spec_size = sizeof (EIF_INTEGER_64);
						break;
					case SK_CHAR:
						spec_size = sizeof (EIF_CHARACTER);
						break;
					case SK_WCHAR:
						spec_size = sizeof (EIF_WIDE_CHAR);
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
				spec_size = EIF_Size((uint16)(dgen & SK_DTYPE)) + OVERHEAD;
			}
			ridr_norm_int (&count);
			nb_byte = CHRPAD(count * spec_size ) + LNGPAD_2;
			ridr_norm_int (&elm_size);

#if DEBUG & 1
		printf (" %x", count);
		printf (" %x", elm_size);
#endif
			if (!(crflags & EO_REF))
				newadd = spmalloc(nb_byte, EIF_TRUE);
			else
				newadd = spmalloc(nb_byte, EIF_FALSE);
			{
				long * o_ref;

				o_ref = (long *) (newadd + (HEADER(newadd)->ov_size & B_SIZE) - LNGPAD_2);
				*o_ref++ = count; 		
				*o_ref = spec_size;
				spec_elm_size[dtypes[flags & EO_TYPE]] = elm_size;
			} 
			HEADER(newadd)->ov_flags |= crflags & (EO_REF|EO_COMP|EO_TYPE);
		} else {
			/* Normal object */
			nb_byte = EIF_Size((uint16)(dtypes[flags & EO_TYPE]));
			newadd = emalloc(crflags & EO_TYPE); 
		}
		
			/* Creation of the Eiffel object */	
		if (newadd == (EIF_REFERENCE) 0)
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
	return newadd;
}

rt_private void rt_clean(void)
{
	/* Clean the data structure before raising an exception of code `code'
	 * after having cleaned the hash table 
	 * and allocated memory and reset function pointers. */
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
}

rt_private void rt_update1 (register EIF_REFERENCE old, register EIF_OBJECT new)
{
	/* `new' is hector pointer to a retrieved object. We have to solve
	 * possible references with it, before putting it in the hash table.
	 */

	unsigned long key = ((unsigned long) old) - 1;	/* Key in the hash table */
	unsigned long solved_key;
	long offset;
	struct rt_struct *rt_info, *rt_solved;
	struct rt_cell *rt_unsolved, *next;
	EIF_REFERENCE  client, supplier;
	

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

		*(EIF_REFERENCE *)(client + offset) = supplier;	/* Attachment */
#ifdef EIF_REM_SET_OPTIMIZATION
		if (((HEADER(client))->ov_flags & (EO_SPEC | EO_REF)) == (EO_SPEC | EO_REF)) {
			CHECK ("No expanded objects in `new'", !(HEADER (new)->ov_flags & EO_COMP));
			RTAS_OPT (supplier, offset >> EIF_REFERENCE_BITS, client);	
					/* Casting with (EIF_REFERENCE *) gives directly the
					 * index instead of the offset. */
		} else	{
			RTAS(supplier, client);					/* Age check */
		}
#else	/* EIF_REM_SET_OPTIMIZATION */
		RTAS(supplier, client);					/* Age check */
#endif	/* EIF_REM_SET_OPTIMIZATION */

		xfree((char *) rt_unsolved);		/* Free reference solving cell */
		rt_unsolved = next;	
	}

	/* Put the new hector pointer as a solved reference in the hash table */
	rt_info->rt_status = SOLVED;
	rt_info->rt_obj = new;
}

rt_private void rt_update2(EIF_REFERENCE old, EIF_REFERENCE new, EIF_REFERENCE parent)
{
	/* Reference field updating: record new unsolved references.
	 * The third argument is needed because of expanded objects:
	 * if `new' is not an expanded object,parent is equal to it. */

	long nb_references = 0;
	uint32 flags, fflags;
	EIF_REFERENCE reference, addr;
	union overhead *zone = HEADER(new);
	long size;				/* New object size */
	/* struct rt_struct *rt_info;*/ /* %%ss unused */

#ifndef NDEBUG
	nb_references = -1;
#endif
	fflags = zone->ov_flags;
	flags = Mapped_flags(fflags);

	if (flags & EO_SPEC) {				/* Special object */
		EIF_REFERENCE o_ref;
		EIF_INTEGER count, elem_size, old_elem_size;

		if (!(flags & EO_REF))			/* Special without references */
			return;

		size = zone->ov_size & B_SIZE;	
		o_ref = (EIF_REFERENCE) (new + size - LNGPAD_2);
		count = *(EIF_INTEGER *) o_ref; 		
		if (!(flags & EO_COMP)) {		/* Special of references */
			nb_references = count;
			goto update;
		} else {						/* Special of expanded objects */
			EIF_REFERENCE  old_addr;

			elem_size = *(EIF_INTEGER *) (o_ref + sizeof(EIF_INTEGER));
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
		size = EIF_Size(flags & EO_TYPE);
	}

	CHECK ("Must be initialized", nb_references != -1);

update:
	/* Update references */
	for (addr = new; 	nb_references > 0;
			nb_references--, addr = (EIF_REFERENCE)(((EIF_REFERENCE *) addr) + 1)) {
		int total_ref = nb_references;

		/* *(char **)new is a pointer an a stored object: check if
		 * the corresponding reference is already in the hash table
		 */
		reference = *(EIF_REFERENCE *)addr;
		if (reference == (EIF_REFERENCE) 0)
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
	
				*(EIF_REFERENCE *) addr = new + new_offset;				/* Expanded reference */
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
			EIF_REFERENCE supplier;

			rt_info = (struct rt_struct *) ht_first(rt_table, key);
			if (rt_info->rt_status == SOLVED) {
				/* Reference is already solved */
				supplier = eif_access(rt_info->rt_obj);
				*(EIF_REFERENCE *) addr = supplier;			/* Attachment */
#ifdef EIF_REM_SET_OPTIMIZATION
				if ((HEADER (new)->ov_flags & (EO_SPEC | EO_REF)) == (EO_SPEC | EO_REF)) {
					CHECK ("No expanded objects in `new'", !(HEADER (new)->ov_flags & EO_COMP));
					RTAS_OPT (supplier, (EIF_REFERENCE *) addr - (EIF_REFERENCE *) new , new);
						/* Casting with (EIF_REFERENCE *) gives directly the
						 * index instead of the offset. */
				} else	{
					RTAS(supplier, new);						/* Age check */
				}
#else	/* EIF_REM_SET_OPTIMIZATION */
				RTAS(supplier, new);					/* Age check */
#endif	/* EIF_REM_SET_OPTIMIZATION */

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
				*(EIF_REFERENCE *) addr = (char *) 0; 
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

rt_private void read_header(char rt_type)
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

	excatch(&exenv);	/* Record pseudo execution vector */
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

	if (rt_type == GENERAL_STORE_4_0) {
		sorted_attributes = (unsigned int **) xmalloc(scount * sizeof(unsigned int *), C_T, GC_OFF);
#ifdef DEBUG_GENERAL_STORE
printf ("Allocating sorted_attributes (scount: %d) %lx\n", scount, sorted_attributes);
#endif
		if (sorted_attributes == (unsigned int **)0) {
			xfree ((char *) dtypes);
			xraise(EN_MEM);
			}
		}
		memset (sorted_attributes, 0, scount * sizeof(unsigned int *));

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
			long *gtype, sgtype[MAX_GENERICS];
			int32 *itype, sitype[MAX_GENERICS];
	
			if (nb_gen > MAX_GENERICS) {
					/* Not enough space we need to allocate dynamically */
				gtype = (long *) cmalloc (nb_gen * sizeof(long));
				itype = (int32 *) cmalloc (nb_gen * sizeof(int32));
			} else {
				gtype = sgtype;
				itype = sitype;
			}


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
		if (EIF_Size(new_dtype) != size) {
			eraise(vis_name, EN_RETR);		/* No good size */
		}
		dtypes[dtype] = new_dtype;

		if (rt_type == GENERAL_STORE_4_0)
			sort_attributes(new_dtype);
	}
	xfree (r_buffer);
	r_buffer = (char *) 0;
	expop(&eif_stack);
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
	char att_name[512];
	int * volatile attrib_order = NULL;
	jmp_buf exenv;
	RTXD;

	errno = 0;

	excatch(&exenv);	/* Record pseudo execution vector */
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
			long *gtype, sgtype[MAX_GENERICS];
			int32 *itype, sitype[MAX_GENERICS];
	
			if (nb_gen > MAX_GENERICS) {
					/* Not enough space we need to allocate dynamically */
				gtype = (long *) cmalloc (nb_gen * sizeof(long));
				itype = (int32 *) cmalloc (nb_gen * sizeof(int32));
			} else {
				gtype = sgtype;
				itype = sitype;
			}

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
						

						if (strcmp (att_name, *(System (new_dtype).cn_names + num_attrib))) {
							i = 0;
	
							while (strcmp(att_name, *(System (new_dtype).cn_names + i++))) {
								if (i >= chk_attrib){
									xfree ((char *) attrib_order);
									(void) strcat (vis_name + strlen (vis_name), ".");
									(void) strcat (vis_name + strlen (vis_name), att_name);
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
								(void) strcat (vis_name + strlen (vis_name), ".");
								(void) strcat (vis_name + strlen (vis_name), att_name);
								eraise(vis_name, EN_RETR);
									/* non matching attributes */
							}
						} else {
							*(attrib_order + num_attrib) = num_attrib;
						}
					} else {
						xfree ((char *) attrib_order);
						(void) strcat (vis_name + strlen (vis_name), ".");
						(void) strcat (vis_name + strlen (vis_name), att_name);
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
		
			
rt_private int buffer_read (register char *ptr, int size)
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
			*(ptr++) = *(general_buffer + current_position++);
		}
	} else {

		for (i = 0; i < size ; i++) {
			*(ptr++) = *(general_buffer + current_position++);
		}
	}
	return (i);
}

rt_public int retrieve_read (void)
{
	char * ptr = general_buffer;
	int read_size;
	int part_read = 0;

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
}

extern long cmp_buffer_size;

rt_public int retrieve_read_with_compression (void)
{
	char* dcmps_in_ptr = (char *)0;
	char* dcmps_out_ptr = (char *)0;
	char* pdcmps_in_size = (char *)0;
	int dcmps_in_size = 0;
	int dcmps_out_size = 0;
	char cmps_head [EIF_CMPS_HEAD_SIZE];
	char* ptr = (char *)0;
	int read_size = 0;
	int part_read = 0;
	
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
				case SK_INT8:
					buffer_read(object + attrib_offset, sizeof(EIF_INTEGER_8));
					break;
				case SK_INT16:
					buffer_read(object + attrib_offset, sizeof(EIF_INTEGER_16));
					break;
				case SK_INT32:
					buffer_read(object + attrib_offset, sizeof(EIF_INTEGER_32));
					break;
				case SK_INT64:
					buffer_read(object + attrib_offset, sizeof(EIF_INTEGER_64));
					break;
				case SK_BOOL:
				case SK_CHAR:
					buffer_read(object + attrib_offset, sizeof(EIF_CHARACTER));
					break;
				case SK_WCHAR:
					buffer_read(object + attrib_offset, sizeof(EIF_WIDE_CHAR));
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
							buffer_read((char *)&old_flags, sizeof(uint32));
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
					buffer_read((char *) &old_flags, sizeof(uint32));
					rt_read_cid ((uint32 *) 0, &hflags, old_flags);
					/* FIXME size_count = get_expanded_pos (o_type, attrib_order[--num_attrib]);*/
					size_count = get_expanded_pos (o_type, --num_attrib);

					HEADER(object + size_count)->ov_flags = (hflags & (EO_REF|EO_COMP|EO_TYPE));
					HEADER(object + size_count)->ov_size = (uint32)(get_expanded_pos (o_type, -1) + (object - parent));
					gen_object_read (object + size_count, parent);						

					}
					break;
				case SK_REF:
					buffer_read(object + attrib_offset, sizeof(EIF_REFERENCE));
					break;
				case SK_POINTER:
					buffer_read(object + attrib_offset, sizeof(EIF_REFERENCE));
					if (eif_discard_pointer_values) {
						*(EIF_POINTER *) (object + attrib_offset) = NULL;
					}
					break;
				default:
					eise_io("General retrieve: not an Eiffel object.");
			}
		} 
	} else {
		if (flags & EO_SPEC) {		/* Special object */
			EIF_INTEGER count, elem_size;
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
			CHECK ("Must be generic", info != (struct gt_info *) 0);

			/* Generic type, :
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
	
			if (!(flags & EO_REF)) {			/* Special of simple types */
				switch (dgen & SK_HEAD) {
					case SK_INT8:
						buffer_read(object, count*sizeof(EIF_INTEGER_8));
						break;
					case SK_INT16:
						buffer_read(object, count*sizeof(EIF_INTEGER_16));
						break;
					case SK_INT32:
						buffer_read(object, count*sizeof(EIF_INTEGER_32));
						break;
					case SK_INT64:
						buffer_read(object, count*sizeof(EIF_INTEGER_64));
						break;
					case SK_BOOL:
					case SK_CHAR:
						buffer_read(object, count*sizeof(EIF_CHARACTER));
						break;
					case SK_WCHAR:
						buffer_read(object, count*sizeof(EIF_WIDE_CHAR));
						break;
					case SK_FLOAT:
						buffer_read(object, count*sizeof(EIF_REAL));
						break;
					case SK_DOUBLE:
						buffer_read(object, count*sizeof(EIF_DOUBLE));
						break;
					case SK_EXP: {
						uint32 old_flags, hflags;

						elem_size = *(EIF_INTEGER *) (o_ptr + sizeof(EIF_INTEGER));
						buffer_read((char *) &old_flags, sizeof(uint32));
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

						elem_size = *(EIF_INTEGER *) (o_ptr + sizeof(EIF_INTEGER));
						buffer_read(object, count*elem_size); /* %%ss cast was struct bit* */
						}
						break;
					case SK_POINTER:
						buffer_read(object, count*sizeof(EIF_POINTER));
						if (eif_discard_pointer_values) {
							memset (object, 0, count * sizeof(EIF_POINTER));
						}
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

					buffer_read((char *) &old_flags, sizeof(uint32));
					rt_read_cid ((uint32 *) 0, &hflags, old_flags);
					elem_size = *(EIF_INTEGER *) (o_ptr + sizeof(EIF_INTEGER));
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
				case SK_INT8:
					ridr_multi_int8 ((EIF_INTEGER_8 *) (object + attrib_offset), 1);
					break;
				case SK_INT16:
					ridr_multi_int16 ((EIF_INTEGER_16 *) (object + attrib_offset), 1);
					break;
				case SK_INT32:
					ridr_multi_int32 ((EIF_INTEGER_32 *) (object + attrib_offset), 1);
					break;
				case SK_INT64:
					ridr_multi_int64 ((EIF_INTEGER_64 *) (object + attrib_offset), 1);
					break;
				case SK_BOOL:
				case SK_CHAR:
					ridr_multi_char ((EIF_CHARACTER *) (object + attrib_offset), 1);
					break;
				case SK_WCHAR:
					ridr_multi_int32 ((EIF_INTEGER_32 *) (object + attrib_offset), 1);
					break;
				case SK_FLOAT:
					ridr_multi_float ((EIF_REAL *) (object + attrib_offset), 1);
					break;
				case SK_DOUBLE:
					ridr_multi_double ((EIF_DOUBLE *) (object + attrib_offset), 1);
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
					ridr_multi_any (object + attrib_offset, 1);
#if DEBUG & 1
					printf (" %lx", *((char **)(object + attrib_offset)));
#endif
					break;
				case SK_POINTER:
					ridr_multi_any (object + attrib_offset, 1);
					if (eif_discard_pointer_values) {
						*(EIF_POINTER *) (object + attrib_offset) = NULL;
					}
					break;

				default:
					eise_io("Basic retrieve: not an Eiffel object.");
			}
		} 
	} else {
		if (flags & EO_SPEC) {		/* Special object */
			EIF_INTEGER count, elem_size;
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
			CHECK ("Must be generic", info != (struct gt_info *) 0);

			/* Generic type, :
			 *	"dtype visible_name size nb_generics {meta_type}+"
			 */
			gt_type = info->gt_type;
			nb_gen = info->gt_param;

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
	
			if (!(flags & EO_REF)) {			/* Special of simple types */
				switch (dgen & SK_HEAD) {
					case SK_INT8:
						ridr_multi_int8 ((EIF_INTEGER_8 *)object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((EIF_INTEGER_8 *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif
						break;
					case SK_INT16:
						ridr_multi_int16 ((EIF_INTEGER_16 *)object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((EIF_INTEGER_16 *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif
						break;
					case SK_INT32:
						ridr_multi_int32 ((EIF_INTEGER_32 *)object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((EIF_INTEGER_32 *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif
						break;
					case SK_INT64:
						ridr_multi_int64 ((EIF_INTEGER_64 *)object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((EIF_INTEGER_64 *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif

						break;
					case SK_BOOL:
					case SK_CHAR:
						ridr_multi_char ((EIF_CHARACTER *) object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lx", *((EIF_CHARACTER *)(object + z)));
							if (!(z % 40))
								printf ("\n");
						}
#endif

						break;
					case SK_WCHAR:
						ridr_multi_int32 ((EIF_INTEGER_32 *) object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lx", *((EIF_CHARACTER *)(object + z)));
							if (!(z % 40))
								printf ("\n");
						}
#endif

						break;
					case SK_FLOAT:
						ridr_multi_float ((EIF_REAL *)object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %f", *(((EIF_REAL *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif

						break;
					case SK_DOUBLE:
						ridr_multi_double ((EIF_DOUBLE *)object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lf", *(((EIF_DOUBLE *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif
						break;
					case SK_EXP: {
						uint32  old_flags, hflags;

						elem_size = *(EIF_INTEGER *) (o_ptr + sizeof(EIF_INTEGER));
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
						elem_size = *(EIF_INTEGER *) (o_ptr + sizeof(EIF_INTEGER));
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
						if (eif_discard_pointer_values) {
							memset (object, 0, count * sizeof(EIF_POINTER));
						}
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
					elem_size = *(EIF_INTEGER *) (o_ptr + sizeof(EIF_INTEGER));
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

rt_private long dbl_off(long t, long u,long v, long w, long x, long y, long z)
{
	long add = I64OFF(t,u,v,w,x,y) + z*I64SIZ;
	return add + PADD(add,DBLSIZ);
}
rt_private long obj_size(long s, long t, long u, long v, long w, long x, long y, long z)
{
	long add = dbl_off (s,t,u,v,w,x,y)+ z*DBLSIZ;
	return add+REMAINDER(add);
}

rt_private long get_expanded_pos (uint32 o_type, uint32 num_attrib)
{
	/* long Result;*/ /* %%ss removed */
	int numb, counter, bit_size = 0;
	int num_ref = 0, num_char = 0, num_float = 0, num_double = 0;
	int num_pointer = 0, num_int = 0, exp_size = 0; 
	int num_int16 = 0, num_int64 = 0;
	uint32 types_cn;

	numb = System(o_type).cn_nbattr;
	for (counter = 0; counter < numb; counter++) {
		types_cn = *(System(o_type).cn_types + counter);
		switch (types_cn & SK_HEAD) {
			case SK_EXP:
				if ((counter + (++num_ref - num_attrib)) < num_attrib) {
					exp_size += (OVERHEAD + EIF_Size(types_cn & SK_DTYPE));
				}
				break;
			case SK_REF:
				num_ref++;
				break;
			case SK_POINTER:
				num_pointer++;
				break;
			case SK_INT32:
			case SK_WCHAR:
				num_int++;
				break;
			case SK_INT16:
				num_int16++;
				break;
			case SK_INT64:
				num_int64++;
				break;
			case SK_BOOL:
			case SK_CHAR:
			case SK_INT8:
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
	return (obj_size(num_ref,num_char,num_int16,num_int,num_float,num_pointer,num_int64,num_double)+bit_size+exp_size+OVERHEAD);
}

rt_private int char_read(char *pointer, int size)
{
	EIF_GET_CONTEXT
	return read(r_fides, pointer, size);
}

rt_private int stream_read(char *pointer, int size)
{
	if (stream_buffer_size - stream_buffer_position < size) {
		stream_buffer_size += buffer_size;
		stream_buffer = (char *) eif_realloc (stream_buffer, stream_buffer_size);
	}	

	memcpy (pointer, (stream_buffer + stream_buffer_position), size);
	stream_buffer_position += size;
	return size;
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

	*cidarr = (int16) count;
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

