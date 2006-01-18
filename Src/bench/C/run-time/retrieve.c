/*
	description: "Eiffel retrieve mechanism."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="retrieve.c" header="eif_retrieve.h" version="$Id$" summary="Retrieval part of object serialization.">
*/

#include "eif_portable.h"
#include "rt_lmalloc.h"
#include "eif_project.h" /* for egc_ce_type, egc_bit_dtype */
#include "rt_macros.h"
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "rt_macros.h"
#include "rt_except.h"
#include "rt_hashin.h"
#include "eif_hector.h"
#include "eif_cecil.h"
#include "rt_retrieve.h"
#include "rt_store.h"
#include "rt_bits.h"
#include "rt_run_idr.h"
#include "rt_error.h"
#include "rt_traverse.h"
#include "eif_memory.h"
#include "rt_gen_types.h"
#include "rt_gen_conf.h"
#include "rt_globals.h"
#include "rt_struct.h"
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

#ifdef EIF_WINDOWS
#include <io.h>		/* %%ss added for read */
#include <winsock.h>
#endif

/* Sections of code enclosed with #ifdef RECOVERABLE_SCAFFOLDING should be
 * able to be removed, once we are satisfied that the original independent
 * store and retrieve are no longer necessary.
 */
#define RECOVERABLE_SCAFFOLDING
#ifdef RECOVERABLE_SCAFFOLDING
#ifdef DARREN		/* for doing in-editor compilation for errors */
# define RECOVERABLE_DEBUG
# undef RTXD
# define RTXD ;
# undef RTXSC
# define RTXSC ;
#endif
#endif
#ifdef RECOVERABLE_DEBUG
#define EIF_OBJECT_TYPE(obj)    eif_typename ((int16) Dftype (obj))
#ifdef PRINT_OBJECT
extern void print_object (EIF_REFERENCE object);
#endif
#endif

/*#define DEBUG_GENERAL_STORE */	/**/

/*#define DEBUG 1 */ /**/

/* Size of the buffer to retrieve an object */
#define RETRIEVE_BUFFER_SIZE 262144L

#define MAX_GENERICS      4		/* Number of generic parameters that are statically
								   allocated */

/* Constants used for generic conformance in version 5.4 and older. */
#define OLD_CHARACTER_TYPE		-2
#define OLD_BOOLEAN_TYPE		-3
#define OLD_INTEGER_32_TYPE		-4
#define OLD_REAL_32_TYPE		-5
#define OLD_REAL_64_TYPE		-6
#define OLD_BIT_TYPE			-7
#define OLD_POINTER_TYPE		-8
#define OLD_TUPLE_TYPE			-15
#define OLD_INTEGER_8_TYPE		-16
#define OLD_INTEGER_16_TYPE		-17
#define OLD_INTEGER_64_TYPE		-18
#define OLD_WIDE_CHAR_TYPE		-19
#define OLD_FORMAL_TYPE			-32
#define OLD_EXPANDED_LEVEL		-256

/* Constants used for TUPLE type identification in version 5.4 and older. */
#define OLD_EIF_BOOLEAN_CODE	'b'
#define OLD_EIF_CHARACTER_CODE	'c'
#define OLD_EIF_REAL_64_CODE	'd'
#define OLD_EIF_REAL_32_CODE	'f'
#define OLD_EIF_INTEGER_CODE	'i'
#define OLD_EIF_INTEGER_32_CODE	'i'
#define OLD_EIF_POINTER_CODE	'p'
#define OLD_EIF_REFERENCE_CODE	'r'
#define OLD_EIF_INTEGER_8_CODE	'j'
#define OLD_EIF_INTEGER_16_CODE	'k'
#define OLD_EIF_INTEGER_64_CODE	'l'
#define OLD_EIF_WIDE_CHAR_CODE	'u'




#ifndef EIF_THREADS
/*
doc:	<attribute name="rt_table" return_type="struct htable *" export="shared">
doc:		<summary>Table used for solving references.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared struct htable *rt_table;

/*
doc:	<attribute name="nb_recorded" return_type="int32" export="shared">
doc:		<summary>Number of items recorded in `hec_stack' during retrieval.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared int32 nb_recorded = 0;

/*
doc:	<attribute name="rt_kind" return_type="char" export="shared">
doc:		<summary>Kind of storable.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared char rt_kind;

/*
doc:	<attribute name="rt_kind_version" return_type="char" export="shared">
doc:		<summary>Version of storable. Only used for independent store.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared char rt_kind_version;

/*
doc:	<attribute name="eif_discard_pointer_value" return_type="EIF_BOOLEAN" export="private">
doc:		<summary>To discard or not the pointer value upon retrieval. By default we do not keep the value as a pointer value represent allocated memory which might not be present at retrieval time.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<eiffel_classes>STORABLE</eiffel_classes>
doc:	</attribute>
*/
rt_private EIF_BOOLEAN eif_discard_pointer_values = EIF_TRUE;

/*
doc:	<attribute name="type_conversions" return_type="type_table *" export="private">
doc:		<summary></summary>
doc:		<access></access>
doc:		<indexing></indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<eiffel_classes></eiffel_classes>
doc:	</attribute>
*/
rt_private type_table *type_conversions;

/*
doc:	<attribute name="mismatches" return_type="mismatch_table *" export="private">
doc:		<summary></summary>
doc:		<access></access>
doc:		<indexing></indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<eiffel_classes></eiffel_classes>
doc:	</attribute>
*/
rt_private mismatch_table *mismatches;

/*
doc:	<attribute name="dattrib" return_type="int **" export="private">
doc:		<summary>Pointer to attribyte offsets in each object for independent store.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>[dftype][i-th attribute]</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private int **dattrib;

/*
doc:	<attribute name="dtypes" return_type="int *" export="private">
doc:		<summary>Conversion between dtypes found in storable file and dtypes of current system. Used for general and independent store.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>[old dftype]</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private int *dtypes;

/*
doc:	<attribute name="spec_elm_size" return_type="uint32 *" export="private">
doc:		<summary>Array of special element sizes. Only used for special of expanded types where definition of expanded types is different in stored file and retrieval system.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>[old dftype]</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private uint32 *spec_elm_size;

/*
doc:	<attribute name="old_overhead" return_type="uint32" export="private">
doc:		<summary>Overhead size from stored object which might be different from retrieval system. Used only in case of special of expanded objects.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private uint32 old_overhead = 0;

/*
doc:	<attribute name="r_buffer" return_type="char *" export="private">
doc:		<summary>Buffer for reading of storable header.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private char * r_buffer = NULL;

/*
doc:	<attribute name="r_fides" return_type="int" export="private">
doc:		<summary>File descriptor use for retrieve.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private int r_fides;

/*
doc:	<attribute name="class_translations" return_type="unamed struct" export="private">
doc:		<summary></summary>
doc:		<access></access>
doc:		<indexing></indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<eiffel_classes></eiffel_classes>
doc:	</attribute>
*/

rt_private class_translations_table class_translations;	/* Table of class name translations */

#endif

/*
 * Function declations
 */
rt_public EIF_REFERENCE eretrieve(EIF_INTEGER file_desc);		/* Retrieve object store in file */
rt_public EIF_REFERENCE stream_eretrieve(EIF_POINTER *, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER *);	/* Retrieve object store in stream */
rt_public EIF_REFERENCE portable_retrieve(int (*char_read_function)(char *, int));

rt_public EIF_REFERENCE rrt_make(void);
rt_public EIF_REFERENCE irt_make(void);			/* Do the independant retrieve */
rt_public EIF_REFERENCE grt_make(void);			/* Do the general retrieve (3.3 and later) */
rt_public EIF_REFERENCE rrt_nmake(long int objectCount);
rt_public EIF_REFERENCE irt_nmake(long int objectCount);			/* Retrieve n objects independent form*/
rt_public EIF_REFERENCE grt_nmake(long int objectCount);			/* Retrieve n objects general form*/
rt_private void iread_header_new(EIF_CONTEXT_NOARG);
rt_private void rread_header(EIF_CONTEXT_NOARG);
#ifdef RECOVERABLE_SCAFFOLDING
rt_private void iread_header(EIF_CONTEXT_NOARG);		/* Read independent header */
#endif
rt_private void rt_clean(void);			/* Clean data structure */
rt_private void rt_update1(register EIF_REFERENCE old, register EIF_OBJECT new_obj);			/* Reference correspondance update */
rt_private void rt_update2(EIF_REFERENCE old_obj, EIF_REFERENCE new_obj, EIF_REFERENCE parent);			/* Fields updating */
rt_public EIF_REFERENCE rt_make(void);				/* Do the retrieve */
rt_public EIF_REFERENCE rt_nmake(long int objectCount);			/* Retrieve n objects */
rt_private void read_header(char rt_type);



		/* Read general header */
rt_private void object_rread_tuple (EIF_REFERENCE object, uint32 count);
rt_private EIF_REFERENCE object_rread_special (EIF_REFERENCE object, uint32 flags, uint32 count);
rt_private EIF_REFERENCE object_rread_attributes (EIF_REFERENCE object, uint32 new_flags, uint32 old_flags, long expanded_offset);
rt_private void object_read (EIF_REFERENCE object, EIF_REFERENCE parent, uint32 nflags);		/* read the individual attributes of the object*/
rt_private void gen_object_read (EIF_REFERENCE object, EIF_REFERENCE parent, uint32 nflags);	/* read the individual attributes of the object*/

rt_private size_t readline (register char *ptr, size_t maxlen);
rt_private void buffer_read (register char *object, size_t size);
rt_private uint32 rt_read_cid (uint32);
rt_private uint32 rt_id_read_cid (uint32);
rt_private struct cecil_info * cecil_info (type_descriptor *conv, char *name);

/* Initialization and Resetting for retrieving an independent store */
rt_private void independent_retrieve_init (long idrf_size);
rt_private void independent_retrieve_reset (void);

/* Functions to write on the specified IO_MEDIUM */
rt_private int (char_read) (char *, int);
rt_private int (stream_read) (char *, int);

/* read function declarations */
rt_public size_t retrieve_read (void);
rt_public size_t retrieve_read_with_compression (void);

#ifndef EIF_THREADS
/*
doc:	<attribute name="retrieve_read_func" return_type="size_t (*)(void)" export="shared">
doc:		<summary>High level function to read storable file. It uses `char_read_func' to actually read bytes of the file.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared size_t (*retrieve_read_func)(void) = retrieve_read_with_compression;

/*
doc:	<attribute name="char_read_func" return_type="int (*)(char *buf, int n)" export="shared">
doc:		<summary>Read `n' bytes from content of storable and store it in allocated buffer `buf'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared int (*char_read_func)(char *, int) = char_read;

/*
doc:	<attribute name="old_retrieve_read_func" return_type="size_t (*)(void)" export="private">
doc:		<summary>Nice hack for compiler so that compiler can use a different `retrieve_read_func' for its modified use of store/retrieve. So each time we use the compiler one, at the end we restore the `old' one which is the default one for traditional store/retrieve.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private size_t (*old_retrieve_read_func)(void) = retrieve_read_with_compression;

/*
doc:	<attribute name="old_char_read_func" return_type="int (*)(char *, int)" export="private">
doc:		<summary>Nice hack for compiler so that compiler can use a different `char_read_func' for its modified use of store/retrieve. So each time we use the compiler one, at the end we restore the `old' one which is the default one for traditional store/retrieve.</summary>
doc:		<access>Read/Wriite</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private int (*old_char_read_func)(char *, int) = char_read;

/*
doc:	<attribute name="old_rt_kind" return_type="char" export="private">
doc:		<summary>Old kind of storable.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private char old_rt_kind;			/* Kind of storable */

/*
doc:	<attribute name="old_buffer_size" return_type="size_" export="private">
doc:		<summary>Old buffer size.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private size_t old_buffer_size = RETRIEVE_BUFFER_SIZE;

/*
doc:	<attribute name="end_of_buffer" return_type="size_t" export="shared">
doc:		<summary>Size after decompression of decompressed data.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_shared size_t end_of_buffer = 0;

/*
 * Convenience functions
 */

/*
doc:	<attribute name="stream_buffer" return_type="char *" export="private">
doc:		<summary>Pointer to memory buffer where storable is located.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<fixme>Code in `stream_read' does not make sense at all since no resizing of `stream_buffer' will occur (we are reading not writing here!). </fixme>
doc:	</attribute>
*/
rt_private char *stream_buffer;

/*
doc:	<attribute name="stream_buffer_position" return_type="int" export="private">
doc:		<summary>Position of cursor in `stream_buffer' while reading storable.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private int stream_buffer_position;

/*
doc:	<attribute name="stream_buffer_size" return_type="size_t" export="private">
doc:		<summary>Size of `stream_buffer'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:	</attribute>
*/
rt_private size_t stream_buffer_size;

/*
doc:	<attribute name="cidarr" return_type="int16 [256]" export="private">
doc:		<summary>Static CID array.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<fixme>Fixed size is not good. It should be a resizable array.</fixme>
doc:	</attribute>
*/
rt_private int16 cidarr [CIDARR_SIZE];

#endif

#ifdef EIF_THREADS
rt_shared void eif_retrieve_thread_init (void)
	/* Initialize private data of `retrieve.c' in multithreaded environment. */
	/* Data is already zeroed, so only variables that needs something different
	 * than the default value will be initialized. */
{
	RT_GET_CONTEXT;
	eif_discard_pointer_values = EIF_TRUE;
	retrieve_read_func = retrieve_read_with_compression;
	char_read_func = char_read;
	old_retrieve_read_func = retrieve_read_with_compression;
	old_char_read_func = char_read;
	old_buffer_size = RETRIEVE_BUFFER_SIZE;
}
#endif

/* Initialize retrieve function pointers and globals */
 
rt_public void rt_init_retrieve(size_t (*retrieve_function) (void), int (*char_read_function)(char *, int), int buf_size)
{
		/* Storing the previous state of the retrieving operation before the new one start */
	RT_GET_CONTEXT
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
	RT_GET_CONTEXT
	retrieve_read_func = old_retrieve_read_func;
	char_read_func = old_char_read_func;
	buffer_size = old_buffer_size;
	rt_kind = old_rt_kind;
}

rt_private type_table *new_type_conversion_table (int max_types, int num_types)
{
	type_table *result;
	size_t table_size, index_size;
	int i;

	result = (type_table*) eif_rt_xmalloc (sizeof (type_table), C_T, GC_OFF);
	if (result == NULL)
		xraise (EN_MEM);

	table_size = num_types * sizeof (type_descriptor);
	result->descriptions = (type_descriptor*) eif_rt_xmalloc (table_size, C_T, GC_OFF);
	if (result->descriptions == NULL)
		xraise (EN_MEM);
	result->count = num_types;
	memset (result->descriptions, 0, table_size);
	for (i=0; i<num_types; i++) {
		result->descriptions[i].old_type = TYPE_UNDEFINED;
		result->descriptions[i].new_type = TYPE_UNDEFINED;
		result->descriptions[i].new_dftype = TYPE_UNDEFINED;
	}

	index_size = max_types * sizeof (int16);
	result->type_index = (int16 *) eif_rt_xmalloc (index_size, C_T, GC_OFF);
	if (result->type_index == NULL)
		xraise (EN_MEM);
	for (i=0; i<max_types; i++)
		result->type_index[i] = TYPE_UNDEFINED;

	return result;
}

rt_private void free_type_conversion_table (type_table *table)
{
	if (table != NULL) {
		int i;
		if (table->type_index != NULL) {
			eif_rt_xfree ((char *) table->type_index);
			table->type_index = NULL;
		}
		if (table->descriptions != NULL) {
			for (i=0; i<table->count; i++) {
				type_descriptor *t = table->descriptions + i;
				if (t->attributes != NULL) {
					int j;
					for (j=0; j<t->attribute_count; j++)
					{
						attribute_detail *a = t->attributes + j;
						eif_rt_xfree (a->name);
						a->name = NULL;
						if (a->types != NULL) {
							eif_rt_xfree ((char *) a->types);
							a->types = NULL;
						}
					}
					eif_rt_xfree ((char *) t->attributes);
					t->attributes = NULL;
				}
				if (t->generics != NULL) {
					eif_rt_xfree ((char *) t->generics);
					t->generics = NULL;
				}
				if (t->name != NULL) {
					eif_rt_xfree (t->name);
					t->name = NULL;
				}
			}
			eif_rt_xfree ((char *) table->descriptions);
			table->descriptions = NULL;
		}
		eif_rt_xfree ((char *) table);
	}
}

rt_private int type_defined (int16 old_type)
{
	RT_GET_CONTEXT
	int result = 0;
	if (old_type >= 0)
		result = type_conversions->type_index[old_type] != TYPE_UNDEFINED;
	return result;
}

rt_private type_descriptor *type_description (int32 old_type)
{
	RT_GET_CONTEXT
	type_descriptor *result;
	int16 i = type_conversions->type_index[old_type];
	if (i == TYPE_UNDEFINED)
		eraise("unknown type", EN_RETR);	
	result = type_conversions->descriptions + i;
	return result;
}

rt_private type_descriptor *type_description_for_new (
		type_table *types, int16 new_type)
{
	type_descriptor *result = NULL;
	uint32 i;
	for (i=0; i<types->count && result == NULL; i++) {
		type_descriptor *conv = types->descriptions + i;
		if (conv->new_type == new_type)
			result = conv;
	}
	if (result == NULL)
		eraise("unknown type", EN_RETR);	
	return result;
}

/* Creates a new special object to hold references to objects */
rt_private EIF_REFERENCE new_spref (int count)
{
	static EIF_TYPE_ID spref_type;		/* dynamic type of SPECIAL [ANY] */
	EIF_REFERENCE result = spmalloc (
		CHRPAD ((rt_uint_ptr) count * (rt_uint_ptr) sizeof (EIF_REFERENCE)) + LNGPAD (2), FALSE);
	union overhead *zone = HEADER (result);
	EIF_INTEGER *spec_size_info = (EIF_INTEGER *)
			((char *) result + (zone->ov_size & B_SIZE) - LNGPAD (2));
	if (spref_type == 0)
		spref_type = eif_type_id ("SPECIAL [ANY]");
	zone->ov_flags |= spref_type | EO_REF;
	spec_size_info[0] = count;
	spec_size_info[1] = sizeof (EIF_REFERENCE);
	return result;
}

rt_private mismatch_table *new_mismatch_table (uint32 min_count)
{
	uint32 capacity = min_count;
	mismatch_table *result = (mismatch_table *) eif_rt_xmalloc (
			sizeof (mismatch_table), C_T, GC_OFF);
	if (result == NULL)
		xraise (EN_MEM);
	if (capacity < 50)
		capacity = 50;
	result->count = 0;
	result->capacity = capacity;
	result->objects = eif_protect (new_spref (capacity));
	result->values = eif_protect (new_spref (capacity));
	return result;
}

rt_private void grow_mismatch_table (void)
{
	RT_GET_CONTEXT
	mismatches->capacity *= 2;
	mismatches->objects = eif_protect (
		sprealloc (eif_wean (mismatches->objects), mismatches->capacity));
	mismatches->values = eif_protect (
		sprealloc (eif_wean (mismatches->values), mismatches->capacity));
}

rt_private void free_mismatch_table (mismatch_table *table)
{
	if (table) {
		eif_wean (table->objects);
		eif_wean (table->values);
		table->objects = NULL;
		table->values = NULL;
		table->capacity = 0;
		table->count = 0;
		eif_rt_xfree ((char *) table);
	}
}

/*
 * Function definitions
 */


#ifndef EIF_THREADS
/* TODO: How should data be placed into `mismatch_information'?
 */
/*
doc:	<attribute name="mismatch_information_initialize" return_type="EIF_PROCEDURE" export="private">
doc:		<summary>Re-initialization of `mismatch_information' table used by MISMATCH_CORRECTOR.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<eiffel_classes>MISMATCH_CORRECTOR, MISMATCH_INFORMATION</eiffel_classes>
doc:	</attribute>
*/
rt_private EIF_PROCEDURE mismatch_information_initialize;

/*
doc:	<attribute name="mismatch_information_add" return_type="EIF_PROCEDURE" export="private">
doc:		<summary>Insert new items in `mismatch_information' table </summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<eiffel_classes>MISMATCH_CORRECTOR, MISMATCH_INFORMATION</eiffel_classes>
doc:	</attribute>
*/
rt_private EIF_PROCEDURE mismatch_information_add;

/*
doc:	<attribute name="mismtach_information_object" return_type="EIF_OBJECT" export="private">
doc:		<summary>Protected reference to `mismatch_information' of MISMATCH_CORRECTOR.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<eiffel_classes>MISMATCH_CORRECTOR, MISMATCH_INFORMATION</eiffel_classes>
doc:	</attribute>
*/
rt_private EIF_OBJECT mismatch_information_object;

#endif

rt_public void set_mismatch_information_access (
		EIF_OBJECT object, EIF_PROCEDURE init, EIF_PROCEDURE add)
{
	RT_GET_CONTEXT
	if (mismatch_information_object != NULL)
		eif_wean (mismatch_information_object);
	mismatch_information_object = eif_adopt (object);
	mismatch_information_initialize = init;
	mismatch_information_add = add;
}

rt_private void set_mismatch_information (
		EIF_REFERENCE object, EIF_REFERENCE values, type_table *conversions)
{
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	int16 new_dtype = Dtype (object);
	int16 new_dftype = Dftype (object);
	type_descriptor *conv = type_description_for_new (conversions, new_dtype);
	EIF_REFERENCE class_name;
	int i;

	REQUIRE ("Values in special", HEADER (values)->ov_flags & EO_SPEC);

	RT_GC_PROTECT(values);

	mismatch_information_initialize (eif_access (mismatch_information_object));

	/* Store class name in table */
	class_name = eif_gen_typename_of_type (new_dftype);
	mismatch_information_add (eif_access (mismatch_information_object), class_name, "class");

	/* Store atribute values in table */
	for (i=0; i<conv->attribute_count; i++) {
		attribute_detail *att = conv->attributes + i;
		EIF_REFERENCE old_value = ((EIF_REFERENCE *) values)[i];
		mismatch_information_add (eif_access (mismatch_information_object), old_value, att->name);
	}
	RT_GC_WEAN(values);
}

rt_private void correct_object_mismatch (
		EIF_REFERENCE object, EIF_REFERENCE values, type_table *conversions)
{
	EIF_GET_CONTEXT
	volatile EIF_BOOLEAN collecting = gc_ison ();
	volatile EIF_BOOLEAN asserting = c_check_assert (EIF_FALSE);
	jmp_buf exenv;

	REQUIRE ("Values in special", HEADER (values)->ov_flags & EO_SPEC);

	RT_GC_PROTECT(object);
	RT_GC_PROTECT(values);

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
			/* Restore assertion and GC status, and wean protected variable. */
		c_check_assert (asserting);
		if (collecting) {
			gc_run ();
		}
		RT_GC_WEAN_N(2);
		ereturn ();
	} else {
		set_mismatch_information (object, values, conversions);
#ifdef RECOVERABLE_DEBUG
		printf ("  calling correct_mismatch on %s [%p]\n", EIF_OBJECT_TYPE (object), object);
#endif
		gc_stop ();
		egc_correct_mismatch (object);
		if (collecting)
			gc_run ();
		c_check_assert (asserting);
		RT_GC_WEAN_N(2);
		expop(&eif_stack);
	}
}

rt_private void correct_one_mismatch (
		EIF_REFERENCE object, EIF_REFERENCE values, type_table *conversions)
{
	EIF_GET_CONTEXT
	uint32 flags = HEADER (object)->ov_flags;
	EIF_INTEGER count = RT_SPECIAL_COUNT (values);
	jmp_buf exenv;

	REQUIRE ("Values in special", HEADER (values)->ov_flags & EO_SPEC);

	RT_GC_PROTECT(object);
	RT_GC_PROTECT(values);

	excatch(&exenv);
	if (setjmp(exenv)) {
			/* Wean protected variable.*/
		RT_GC_WEAN_N(2);
		ereturn ();
	} else {
#ifdef RECOVERABLE_DEBUG
		printf ("Correcting %s [%p]\n", EIF_OBJECT_TYPE (object),
				object);
#endif
		if (flags & EO_TUPLE) {
			correct_object_mismatch (object, values, conversions);
		} else if (flags & EO_SPEC) {
			EIF_INTEGER i;
			EIF_INTEGER ocount = RT_SPECIAL_COUNT (object);
			EIF_INTEGER oelem_size = RT_SPECIAL_ELEM_SIZE (object);
			CHECK ("Consistent length", ocount == count);
			for (i=0; i<ocount; i++) {
				EIF_REFERENCE ref = (EIF_REFERENCE) (
						(char *) object + OVERHEAD + (i * oelem_size));
				EIF_REFERENCE vals = ((EIF_REFERENCE *) values)[i];
				correct_object_mismatch (ref, vals, conversions);
			}
		}
		else if (flags & EO_COMP) {
			uint32 dtype = flags & EO_TYPE;
			long num_attr = System (dtype).cn_nbattr;
			long i;
			CHECK ("Not too short", count == num_attr || count == num_attr + 1);
			for (i=0; i<num_attr; i++) {
				EIF_REFERENCE vals = ((EIF_REFERENCE *) values)[i];
				if (vals != NULL) {
					long attrib_offset;
					EIF_REFERENCE ref;
					CHECK ("Expanded attribute", (System (dtype).cn_types[i] & SK_HEAD) == SK_EXP);
					attrib_offset = get_offset (dtype, i);
					ref = (char *) object + attrib_offset;
					correct_object_mismatch (ref, vals, conversions);
				}
			}
			if (count == num_attr + 1) {
				EIF_REFERENCE vals = ((EIF_REFERENCE *) values)[num_attr];
				correct_object_mismatch (object, vals, conversions);
			}
		} else {
			correct_object_mismatch (object, values, conversions);
		}
		RT_GC_WEAN_N(2);
		expop(&eif_stack);
	}
}

/* Calls `correct_mismatch' on all objects contained in `mismatches'.
 * Free `retrieved_i' when done and return new address of the object
 * which could have changed since calls to Eiffel may trigger GC
 * cycle and thus move the object. This is why we get the protected
 * object as argument.
 */
rt_private EIF_REFERENCE correct_mismatches (EIF_OBJECT retrieved_i)
{
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	uint32 i;
	mismatch_table *mm = mismatches;
	type_table *conversions = type_conversions;
	jmp_buf exenv;
	RTXD;

	REQUIRE ("retrieved_i_not_null", retrieved_i);

	if (mismatch_information_object == NULL  ||
		mismatch_information_initialize == NULL  ||
		mismatch_information_add == NULL)
	{
		return eif_wean (retrieved_i);
	}

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		eif_wean (retrieved_i);
		rt_clean();				/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
		ereturn(MTC_NOARG);				/* Propagate exception */
		return NULL;	/* Not reached */
	} else {
		for (i=0; i < mm->count; i++) {
			EIF_REFERENCE object = ((EIF_REFERENCE *) eif_access (mm->objects))[i];
			EIF_REFERENCE values = ((EIF_REFERENCE *) eif_access (mm->values))[i];
			CHECK ("Values in special", HEADER (values)->ov_flags & EO_SPEC);
			correct_one_mismatch (object, values, conversions);
		}
		free_mismatch_table (mm);
		mismatches = NULL;
		free_type_conversion_table (conversions);
		type_conversions = NULL;
		expop(&eif_stack);
		return eif_wean (retrieved_i);
	}
}

rt_public EIF_REFERENCE eretrieve(EIF_INTEGER file_desc)
{
	RT_GET_CONTEXT
	r_fides = file_desc;

	return portable_retrieve(char_read);
}

rt_public EIF_REFERENCE stream_eretrieve(EIF_POINTER *buffer, EIF_INTEGER size, EIF_INTEGER start_pos, EIF_INTEGER *real_size)
{
	RT_GET_CONTEXT
	EIF_REFERENCE new_object;
	stream_buffer = (char *) *buffer;
	stream_buffer_size = size;
	stream_buffer_position = start_pos;

	new_object = portable_retrieve(stream_read);
	*real_size = stream_buffer_position;
	return new_object;
}

#ifdef RECOVERABLE_SCAFFOLDING
#ifndef EIF_THREADS
/*
doc:	<attribute name="eif_use_old_independent_retrieve" return_type="EIF_BOOLEAN" export="private">
doc:		<summary>Do we want to use old independent format or new one that can fix some mismatch? Default new one.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<eiffel_classes>STORABLE</eiffel_classes>
doc:		<fixme>Is this obsolete now?</fixme>
doc:	</attribute>
*/
rt_private EIF_BOOLEAN eif_use_old_independent_retrieve = EIF_FALSE;
#endif

rt_public void eif_set_old_independent_retrieve (EIF_BOOLEAN state)
{
	RT_GET_CONTEXT
	eif_use_old_independent_retrieve = state;
}

rt_public void eif_set_discard_pointer_values (EIF_BOOLEAN state)
	/* Do we need to store pointers or not? */
{
	RT_GET_CONTEXT
	eif_discard_pointer_values = state;
}

#endif

rt_public EIF_REFERENCE portable_retrieve(int (*char_read_function)(char *, int))
{
	/* Retrieve object store in file `filename' */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	EIF_REFERENCE retrieved = NULL;
	EIF_OBJECT retrieved_i = NULL;
	char rt_type = (char) 0;
	EIF_BOOLEAN recoverable_tables = EIF_FALSE;

#ifdef EIF_ALPHA
		/* The conversion from a FILE pointer to a file descriptor
		 * does not keep the position correctly in the stream, one has
		 * to call `fflush' to ensure the validity of the position in
		 * the stream.
		 */
	fflush (NULL);
#endif

#ifdef ISE_GC
		/* It makes performance of retrieval bad in a MT system as only one can occurs
		 * and blocks all other threads, but I don't see yet a way to achieve that without
		 * simple mutexes and dead locks. */
	GC_THREAD_PROTECT(eif_synchronize_gc(rt_globals));
#endif

	/* Reset nb_recorded */
	nb_recorded = 0;

	/* Read the kind of stored hierachy */
	if (char_read_function(&rt_type, sizeof (char)) < sizeof (char)) {
#ifdef ISE_GC
		GC_THREAD_PROTECT(eif_unsynchronize_gc(rt_globals));
#endif
		eise_io("Retrieve: unable to read type of storable.");
	}

	/* set rt_kind depending on the type to be retrieved */

	switch (rt_type) {
		case BASIC_STORE_4_0:			/* New Basic store */
			rt_init_retrieve(retrieve_read_with_compression, char_read_function, RETRIEVE_BUFFER_SIZE);
			allocate_gen_buffer ();
			rt_kind = BASIC_STORE;
			rt_kind_version = 0x0;
			break;
		case GENERAL_STORE_4_0:			/* New General store */
			rt_init_retrieve(retrieve_read_with_compression, char_read_function, RETRIEVE_BUFFER_SIZE);
			allocate_gen_buffer ();
			rt_kind = GENERAL_STORE;
			rt_kind_version = 0x0;
			break;
		case INDEPENDENT_STORE_4_3:
		case INDEPENDENT_STORE_4_4:
		case INDEPENDENT_STORE_5_0:
			rt_init_retrieve(retrieve_read_with_compression, char_read_function, RETRIEVE_BUFFER_SIZE);
			rt_kind = INDEPENDENT_STORE;
			rt_kind_version = rt_type;
			independent_retrieve_init (RETRIEVE_BUFFER_SIZE);
			break;
		case RECOVERABLE_STORE_5_3:
		case INDEPENDENT_STORE_5_5:
			rt_init_retrieve(retrieve_read_with_compression, char_read_function, RETRIEVE_BUFFER_SIZE);
			rt_kind = RECOVERABLE_STORE;
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
#ifdef RECOVERABLE_SCAFFOLDING
	  if (eif_use_old_independent_retrieve) {
#ifdef RECOVERABLE_DEBUG
		printf ("Old independent retrieval algorithm\n");
#endif
		iread_header(MTC_NOARG);			/* Make correspondance table */
		retrieved = irt_make();
	  } else {
#endif
#ifdef RECOVERABLE_DEBUG
		printf ("New independent retrieval algorithm\n");
#endif
		recoverable_tables = EIF_TRUE;
		rt_kind = RECOVERABLE_STORE;
		rt_kind_version = rt_type;
		iread_header_new(MTC_NOARG);			/* Make correspondance table */
		retrieved = rrt_make();
		retrieved_i = eif_protect (retrieved);
#ifdef RECOVERABLE_SCAFFOLDING
	  }
#endif
	} else if (rt_kind == RECOVERABLE_STORE) {
#ifdef RECOVERABLE_DEBUG
		printf ("New recoverable retrieval algorithm\n");
#endif
		recoverable_tables = EIF_TRUE;
		rread_header(MTC_NOARG);			/* Make correspondance table */
		retrieved = rrt_make();
		retrieved_i = eif_protect (retrieved);
	} else if (rt_type == GENERAL_STORE_4_0) {
		read_header(rt_type);					/* Make correspondance table */
		retrieved = grt_make();
	} else {
		if (rt_kind)
			read_header(rt_type);			/* Make correspondance table */

		/* Retrieve */
		retrieved = rt_make();
	}

	if (rt_kind) {
		eif_rt_xfree((char *) dtypes);					/* Free the correspondance table */
		dtypes = NULL;
	}
	if ((rt_kind == INDEPENDENT_STORE) || (rt_kind == RECOVERABLE_STORE)) {
		eif_rt_xfree((char *) spec_elm_size);					/* Free the element size table */
		spec_elm_size = NULL;
	}

	ht_free(rt_table);					/* Free hash table descriptor */
	rt_table = NULL;
#ifdef ISE_GC
	epop(&hec_stack, nb_recorded);		/* Pop hector records */
#endif
	nb_recorded = 0;
	switch (rt_type) {
		case GENERAL_STORE_4_0: 
			free_sorted_attributes();
			break;
		case INDEPENDENT_STORE_4_3:
		case INDEPENDENT_STORE_4_4:
		case INDEPENDENT_STORE_5_0:
		case RECOVERABLE_STORE_5_3:
		case INDEPENDENT_STORE_5_5:
			independent_retrieve_reset ();
			break;
	}
	rt_reset_retrieve();

#ifdef PRINT_OBJECT
	printf ("-- Recovered object:\n");
	if (retrieved != NULL)
		print_object (retrieved);
	else if (retrieved_i != NULL)
		print_object (eif_access (retrieved_i));
#endif
	if (recoverable_tables)
	{
			/* Global variables are freed at this point, allowing safe call-back
			 * into the run-time (another retrieve?) by the application, which
			 * is called into by correct_mismatches().
			 */
		retrieved = correct_mismatches (retrieved_i);
	}
#ifdef RECOVERABLE_DEBUG
	fflush (stdout);
#endif
	
#ifdef ISE_GC
	GC_THREAD_PROTECT(eif_unsynchronize_gc(rt_globals));
#endif
	return retrieved;
}

rt_shared EIF_REFERENCE ise_compiler_retrieve (EIF_INTEGER f_desc, EIF_INTEGER a_pos, size_t (*retrieve_function) (void))
{
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	EIF_REFERENCE retrieved = (EIF_REFERENCE) 0;
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

		/* Go to position `a_pos' in stream where storable starts. */
	if (lseek (f_desc, a_pos, SEEK_SET) == -1) {
		esys ();
	}

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
	rt_table = NULL;
#ifdef ISE_GC
	epop(&hec_stack, nb_recorded);		/* Pop hector records */
#endif
	nb_recorded = 0;
	rt_reset_retrieve();
	return retrieved;
}


/* Initialization for retrieving an independent store
 */
rt_private void independent_retrieve_init (long idrf_size)
{
	RT_GET_CONTEXT
		/* Initialize serialization streams for reading (0 stands for read) */
	run_idr_init (idrf_size, 0);

	idr_temp_buf = (char *) eif_rt_xmalloc (48, C_T, GC_OFF);
	if (idr_temp_buf == (char *)0)
		xraise (EN_MEM);

	dattrib = (int **) eif_rt_xmalloc (scount * sizeof (int *), C_T, GC_OFF);
	if (dattrib == (int **)0){
		eif_rt_xfree(idr_temp_buf);
		xraise (EN_MEM);
	}
	memset  ((char *)dattrib, 0, scount * sizeof (int *));
}

rt_private void independent_retrieve_reset (void)
	/* Clean allocated data structures for independent store */
{
	RT_GET_CONTEXT
	int i;

	run_idr_destroy ();
	if (idr_temp_buf != NULL) {
		eif_rt_xfree (idr_temp_buf);
		idr_temp_buf = NULL;
	}
	if (dattrib != NULL) {
		for (i = 0; i < scount; i++) {
			if (*(dattrib + i))
				eif_rt_xfree ((char *)(*(dattrib +i)));
		}
		eif_rt_xfree ((char *) dattrib);
		dattrib = NULL;
	}
}

/* Create a hash table to hold `count' objects, each of `size'. */
rt_private struct htable *create_hash_table (int32 count, int size)
{
	struct htable *result = (struct htable*)
			eif_rt_xmalloc (sizeof (struct htable), C_T, GC_OFF);
	if (result == NULL)
		xraise (EN_MEM);
	if (ht_create (result, count, size) == -1)
		xraise (EN_MEM);
	ht_zero (result);
	return result;
}

rt_public void class_translation_clear (void)
{
	RT_GET_CONTEXT
	REQUIRE ("Table consistency",
			(class_translations.max_count == 0) == (class_translations.table == NULL));
	if (class_translations.table != NULL) {
		unsigned int i;
		for (i=0; i<class_translations.count; i++) {
			eif_rt_xfree ((char *) class_translations.table[i].old_name);
			class_translations.table[i].old_name = NULL;

			eif_rt_xfree ((char *) class_translations.table[i].new_name);
			class_translations.table[i].new_name = NULL;
		}
		eif_rt_xfree ((char *) class_translations.table);
		class_translations.table = NULL;
		class_translations.max_count = 0;
		class_translations.count = 0;
	}
	ENSURE ("Table consistency",
			(class_translations.max_count == 0) == (class_translations.table == NULL));
}

rt_private void class_translation_grow (void)
{
	RT_GET_CONTEXT
	REQUIRE ("Table consistency",
			(class_translations.max_count == 0) == (class_translations.table == NULL));
	if (class_translations.max_count == 0) {
		int max_count = 5;
		class_translations.table =
				(class_translation *) eif_rt_xcalloc (max_count, sizeof (class_translation));
		if (class_translations.table == NULL)
			xraise (EN_MEM);
		class_translations.max_count = max_count;
		class_translations.count = 0;
	}
	else {
		int new_max_count = class_translations.max_count * 2;
		class_translation *new_table =
				(class_translation *) eif_rt_xcalloc (new_max_count, sizeof (class_translation));
		if (new_table == NULL)
			xraise (EN_MEM);
		memcpy (new_table, class_translations.table,
				class_translations.count * sizeof (class_translation));
		eif_rt_xfree ((char *) class_translations.table);
		class_translations.table = new_table;
		class_translations.max_count = new_max_count;
	}
	ENSURE ("Table consistency",
			(class_translations.max_count == 0) == (class_translations.table == NULL));
}

rt_private char *class_translation_lookup (char *old_name)
{
	RT_GET_CONTEXT
	char *result = NULL;
	REQUIRE ("Old name exists", old_name != NULL && old_name[0] != '\0');
	if (class_translations.table != NULL) {
		class_translation *trans = class_translations.table;
		int count = class_translations.count;
		for (; count-- > 0 && result == NULL; trans++) {
			if (strcmp (trans->old_name, old_name) == 0)
				result = trans->new_name;
		}
	}
	if (result == NULL)
		result = old_name;
	ENSURE ("Result exists", result != NULL);
	return result;
}

rt_public void class_translation_put (char *new_name, char *old_name)
{
	RT_GET_CONTEXT
	class_translation *trans = NULL;
	char *newnm;
	unsigned int i;
	REQUIRE ("Old name exists", old_name != NULL && old_name[0] != '\0');
	REQUIRE ("New name exists", new_name != NULL && new_name[0] != '\0');
	newnm = (char *) eif_rt_xmalloc (strlen (new_name) + 1, C_T, GC_OFF);
	if (newnm == NULL)
		xraise (EN_MEM);
	strcpy (newnm, new_name);
	for (i=0; i<class_translations.count && trans == NULL; i++) {
		if (strcmp (class_translations.table[i].old_name, old_name) == 0)
			trans = class_translations.table + i;
	}
	if (trans != NULL) {
		/* Key already in table */
		eif_rt_xfree (trans->new_name);
		trans->new_name = newnm;
	}
	else {
		/* Key not yet in table */
		if (class_translations.count == class_translations.max_count)
			class_translation_grow ();
		trans = class_translations.table + class_translations.count;
		++class_translations.count;
		trans->new_name = newnm;
		trans->old_name = (char *) eif_rt_xmalloc (strlen (old_name) + 1, C_T, GC_OFF);
		if (trans->old_name == NULL)
			xraise (EN_MEM);
		strcpy (trans->old_name, old_name);
	}
	ENSURE ("Count not too high",
			class_translations.count <= class_translations.max_count);
}

rt_public EIF_INTEGER class_translation_count (void)
{
	RT_GET_CONTEXT
	return class_translations.count;
}

/* Old name for translation `i', where `i' is a zero-based index from 0 up
 * to class_translation_count().
 */
rt_public char *class_translation_old (EIF_INTEGER i)
{
	RT_GET_CONTEXT
	char *result = NULL;
	REQUIRE ("Valid index", 0 <= i && i < (EIF_INTEGER) class_translations.count);
	if (0 <= i && i < (EIF_INTEGER) class_translations.count)
		result = class_translations.table[i].old_name;
	return result;
}

/* New name for translation `i', where `i' is a zero-based index from 0 up
 * to class_translation_count().
 */
rt_public char *class_translation_new (EIF_INTEGER i)
{
	RT_GET_CONTEXT
	char *result = NULL;
	REQUIRE ("Valid index", 0 <= i && i < (EIF_INTEGER) class_translations.count);
	if (0 <= i && i < (EIF_INTEGER) class_translations.count)
		result = class_translations.table[i].new_name;
	return result;
}

rt_private void rt_create_table (int32 count)
{
	RT_GET_CONTEXT
	rt_table = create_hash_table (count, sizeof (struct rt_struct));
}

rt_shared uint32 special_generic_type (uint32 o_type)
{
	int16 *dynamic_types;
	int32 *patterns;
	int nb_gen;
	char *vis_name = System (o_type).cn_generator;
	struct cecil_info *info;
	
		/* Special cannot be expanded, thus we only look in `egc_ce_type'. */
	info = (struct cecil_info *) ct_value (&egc_ce_type, vis_name);

	CHECK ("Must be generic", (info != NULL) && (info->nb_param > 0));

	/* Generic type, :
	 *	"dtype visible_name size nb_generics {meta_type}+"
	 */
	dynamic_types = info->dynamic_types;
	nb_gen = info->nb_param;

	for (;;) {
		if ((*dynamic_types++) == (int16) o_type)
			break;
	}
	dynamic_types--;
	patterns = info->patterns + nb_gen * (dynamic_types - info->dynamic_types);
	return *patterns;
}

rt_public EIF_REFERENCE rt_make(void)
{
		/* Make the retrieve of all objects in file */
	uint32 objectCount;

		/* Read the object count in the file header */
	buffer_read((char *) &objectCount, (sizeof(uint32)));

	return rt_nmake(objectCount);
}

rt_public EIF_REFERENCE rt_nmake(long int objectCount)
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	rt_uint_ptr nb_byte;
	EIF_REFERENCE oldadd;
	volatile EIF_REFERENCE newadd = (EIF_REFERENCE) 0;
	EIF_OBJECT new_hector;
	uint32 crflags, flags;
	uint32 spec_size = 0;
	volatile size_t n = objectCount;
#ifdef ISE_GC
	volatile char g_status = rt_g_data.status;
#endif
	jmp_buf exenv;
	RTXD;

	REQUIRE ("Positive count", objectCount > 0);

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
#ifdef ISE_GC
		rt_g_data.status = g_status;		/* If a crash occurs, since we may disable the GC in the
										 * code below, we need to make sure to restore the status
										 * to what it originally was. */
#endif
		ereturn(MTC_NOARG);				/* Propagate exception */
	}

		/* Initialization of the hash table */
	nb_recorded = 0;
	rt_create_table (objectCount);

	for (;n > 0; n--) {
		/* Read object address */
		buffer_read((char *) &oldadd, sizeof(EIF_REFERENCE));

#if DEBUG & 2
		printf ("\n  %lx", oldadd);
#endif

		/* Read object flags (dynamic type) */
		buffer_read((char *) &flags, sizeof(uint32));
		crflags = rt_read_cid (flags);

#if DEBUG & 2
		printf (" %x", flags);
#endif

		/* Read a possible size */
		if (flags & EO_SPEC) {
				/* Special object: read the saved size */
			buffer_read((char *) &spec_size, (sizeof(uint32)));
			nb_byte = spec_size & B_SIZE;
			if (flags & EO_TUPLE) {
				newadd = RTLNT(crflags & EO_TYPE);
			} else {
				newadd = spmalloc (nb_byte, EIF_TEST(!(flags & EO_REF)));
			}
			if (newadd == (EIF_REFERENCE) 0) {
					/* Creation of Eiffel object failed */
				xraise(EN_MEM);
			}

			HEADER(newadd)->ov_flags |= crflags & (EO_REF|EO_COMP|EO_TYPE);
		} else {
				/* Normal object */
			if (rt_kind) {
				nb_byte = EIF_Size((uint16)(dtypes[flags & EO_TYPE]));
			} else {
				nb_byte = EIF_Size((uint16)(flags & EO_TYPE));
			}
			newadd = emalloc(crflags & EO_TYPE);
			if (newadd == (EIF_REFERENCE) 0) {
					/* Creation of Eiffel object failed */
				xraise(EN_MEM);
			}
		}
		
#ifdef ISE_GC
			/* Stop in the garbage collector because we have now an unstable
			 * object. */
		rt_g_data.status |= GC_STOP;
#endif /* ISE_GC */

			/* Record the new object in hector table */
		new_hector = hrecord(newadd);
		nb_recorded++;

			/* Update unsolved references on `newadd' */
		rt_update1 (oldadd, new_hector);

		if (nb_byte > 0) {		
				/* Read the object's body */
			buffer_read(newadd, nb_byte);
		}

			/* Update fileds: the garbage collector should not be called
			 * during `rt_update2' because the object is in a very unstable
			 * state.
			 */
		rt_update2(oldadd, newadd, newadd);

#ifdef ISE_GC
			/* Restore garbage collector status */
		rt_g_data.status = g_status;
#endif /* ISE_GC */
	}
	expop(&eif_stack);
	return newadd;
}

rt_public EIF_REFERENCE grt_make(void)
{
		/* Make the retrieve of all objects in file */
	uint32 objectCount;

		/* Read the object count in the file header */
	buffer_read((char *) &objectCount, sizeof(uint32));

	return grt_nmake(objectCount);
}

rt_public EIF_REFERENCE grt_nmake(long int objectCount)
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	char *oldadd;
	char * volatile newadd = (char *) 0;
	EIF_OBJECT new_hector;
	uint32 crflags, flags;
	volatile uint32 spec_size = 0;
	volatile long int n = objectCount;
#ifdef ISE_GC
	volatile char g_status = rt_g_data.status;
#endif
	jmp_buf exenv;
	RTXD;

	REQUIRE ("Positive count", objectCount > 0);

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
#ifdef ISE_GC
		rt_g_data.status = g_status;		/* If a crash occurs, since we may disable the GC in the
										 * code below, we need to make sure to restore the status
										 * to what it originally was. */
#endif
		ereturn(MTC_NOARG);				/* Propagate exception */
	}

	/* Initialization of the hash table */
	nb_recorded = 0;
	rt_create_table (objectCount);

	for (;n > 0; n--) {
		/* Read object address */
		buffer_read((char *) &oldadd, sizeof(EIF_REFERENCE));

#if DEBUG & 1
		printf ("\n  %lx", oldadd);
#endif

		/* Read object flags (dynamic type) */
		buffer_read((char *) &flags, sizeof(uint32));
		crflags = rt_read_cid (flags);

#if DEBUG & 1
		printf (" %x", flags);
#endif

		/* Read a possible size */
		if (flags & EO_SPEC) {
			uint32 count, elm_size;
			rt_uint_ptr nb_byte;
			if (flags & EO_TUPLE) {
				spec_size = sizeof(EIF_TYPED_ELEMENT);
			} else {
				uint32 dgen, spec_type;

				spec_type = dtypes[flags & EO_TYPE];
				dgen = special_generic_type (spec_type);

				if (!((dgen & SK_HEAD) == SK_EXP)) {
					switch (dgen) {
						case SK_UINT8: spec_size = sizeof (EIF_NATURAL_8); break;
						case SK_UINT16: spec_size = sizeof (EIF_NATURAL_16); break;
						case SK_UINT32: spec_size = sizeof (EIF_NATURAL_32); break;
						case SK_UINT64: spec_size = sizeof (EIF_NATURAL_64); break;
						case SK_INT8: spec_size = sizeof (EIF_INTEGER_8); break;
						case SK_INT16: spec_size = sizeof (EIF_INTEGER_16); break;
						case SK_INT32: spec_size = sizeof (EIF_INTEGER_32); break;
						case SK_INT64: spec_size = sizeof (EIF_INTEGER_64); break;
						case SK_CHAR: spec_size = sizeof (EIF_CHARACTER); break;
						case SK_WCHAR: spec_size = sizeof (EIF_WIDE_CHAR); break;
						case SK_BOOL: spec_size = sizeof (EIF_BOOLEAN); break;
						case SK_REAL32: spec_size = sizeof (EIF_REAL_32); break;
						case SK_REAL64: spec_size = sizeof (EIF_REAL_64); break;
						case SK_POINTER: spec_size = sizeof (EIF_POINTER); break;
						case SK_DTYPE:
						case SK_REF: spec_size = sizeof (EIF_REFERENCE); break;
						default:
							if (dgen & SK_BIT) 
								spec_size = BITOFF(dgen & SK_DTYPE);
							else
								eise_io("General retrieve: not an Eiffel object.");
					}
				} else {
#ifdef WORKBENCH
					spec_size = EIF_Size((uint16)(dgen & SK_DTYPE)) + OVERHEAD;
#else
					spec_size = EIF_Size((uint16)(dgen & SK_DTYPE));
					if (References(dgen & SK_DTYPE) > 0) {
						spec_size = spec_size + OVERHEAD;
					}
#endif
				}
			}
			buffer_read((char *) &count, sizeof(uint32));
			nb_byte = CHRPAD((rt_uint_ptr) count * (rt_uint_ptr) spec_size ) + LNGPAD_2;
			buffer_read((char *) &elm_size, sizeof(uint32));

#if DEBUG & 1
		printf (" %x", count);
		printf (" %x", elm_size);
#endif
			
			if (crflags & EO_TUPLE) {
				newadd = RTLNT(crflags & EO_TYPE);
			} else {
				newadd = spmalloc(nb_byte, EIF_TEST(!(crflags & EO_REF)));
			}
			if (newadd == (EIF_REFERENCE) 0) {
					/* Creation of Eiffel object failed */
				xraise(EN_MEM);
			}
			{
				EIF_REFERENCE o_ref;

				o_ref = RT_SPECIAL_INFO(newadd);
				RT_SPECIAL_COUNT_WITH_INFO(o_ref) = count;
				RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ref) = spec_size;
				/* FIXME spec_elm_size[dtypes[flags & EO_TYPE]] = elm_size;*/
			} 
			HEADER(newadd)->ov_flags |= crflags & (EO_REF|EO_COMP|EO_TYPE);
		} else {
			/* Normal object */
			newadd = emalloc(crflags & EO_TYPE); 
			if (newadd == (EIF_REFERENCE) 0) {
					/* Creation of Eiffel object failed */
				xraise(EN_MEM);
			}
		}

#ifdef ISE_GC
			/* Stop in the garbage collector because we have know an unstable
			 * object. */
		rt_g_data.status |= GC_STOP;
#endif /* ISE_GC */

			/* Record the new object in hector table */
		new_hector = hrecord(newadd);
		nb_recorded++;

			/* Update unsolved references on `newadd' */
		rt_update1 (oldadd, new_hector);

			/* Read the object's body */
		gen_object_read (newadd, newadd, crflags);

			/* Update fileds: the garbage collector should not be called
			 * during `rt_update2' because the object is in a very unstable
			 * state.
			 */
		rt_update2(oldadd, newadd, newadd);

#ifdef ISE_GC
			/* Restore garbage collector status */
		rt_g_data.status = g_status;
#endif /* ISE_GC */
	}
	expop(&eif_stack);

	return newadd;
}

rt_public EIF_REFERENCE irt_make(void)
{
	/* Make the retrieve of all objects in file */
	uint32 objectCount;

	/* Read the object count in the file header */
	ridr_multi_int32 (&objectCount, 1);

#if DEBUG & 1
		printf ("\n %ld", objectCount);
#endif

	return irt_nmake(objectCount);
}

rt_public EIF_REFERENCE irt_nmake(long int objectCount)
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	rt_uint_ptr nb_byte;
	char *oldadd;
	char * volatile newadd = NULL;
	EIF_OBJECT new_hector;
	uint32 crflags, flags;
	volatile uint32 spec_size = 0;
	volatile long int n = objectCount;
#ifdef ISE_GC
	volatile char g_status = rt_g_data.status;
#endif
	jmp_buf exenv;
	RTXD;

	REQUIRE ("Positive count", objectCount > 0);

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
#ifdef ISE_GC
		rt_g_data.status = g_status;		/* If a crash occurs, since we may disable the GC in the
										 * code below, we need to make sure to restore the status
										 * to what it originally was. */
#endif
		ereturn(MTC_NOARG);				/* Propagate exception */
	}

	/* Initialization of the hash table */
	nb_recorded = 0;
	rt_create_table (objectCount);

	for (;n > 0; n--) {
		/* Read object address */
		ridr_multi_any ((char *) (&oldadd), 1);

#if DEBUG & 1
		printf ("\n  %lx", oldadd);
#endif

		/* Read object flags (dynamic type) */
		ridr_norm_int (&flags);
		crflags = rt_id_read_cid (flags);

#if DEBUG & 1
		printf (" %x", flags);
#endif

		/* Read a possible size */
		if (flags & EO_SPEC) {
			uint32 count, elm_size;
			if (flags & EO_TUPLE) {
				spec_size = sizeof(EIF_TYPED_ELEMENT);
			} else {
				uint32 dgen, spec_type;

				spec_type = dtypes[flags & EO_TYPE];
				dgen = special_generic_type (spec_type);

				if (!((dgen & SK_HEAD) == SK_EXP)) {
					switch (dgen) {
						case SK_UINT8: spec_size = sizeof (EIF_NATURAL_8); break;
						case SK_UINT16: spec_size = sizeof (EIF_NATURAL_16); break;
						case SK_UINT32: spec_size = sizeof (EIF_NATURAL_32); break;
						case SK_UINT64: spec_size = sizeof (EIF_NATURAL_64); break;
						case SK_INT8: spec_size = sizeof (EIF_INTEGER_8); break;
						case SK_INT16: spec_size = sizeof (EIF_INTEGER_16); break;
						case SK_INT32: spec_size = sizeof (EIF_INTEGER_32); break;
						case SK_INT64: spec_size = sizeof (EIF_INTEGER_64); break;
						case SK_CHAR: spec_size = sizeof (EIF_CHARACTER); break;
						case SK_WCHAR: spec_size = sizeof (EIF_WIDE_CHAR); break;
						case SK_BOOL: spec_size = sizeof (EIF_BOOLEAN); break;
						case SK_REAL32: spec_size = sizeof (EIF_REAL_32); break;
						case SK_REAL64: spec_size = sizeof (EIF_REAL_64); break;
						case SK_POINTER: spec_size = sizeof (EIF_POINTER); break;
						case SK_DTYPE:
						case SK_REF: spec_size = sizeof (EIF_REFERENCE); break;
						default:
							if (dgen & SK_BIT) 
								spec_size = BITOFF(dgen & SK_DTYPE);
							else
								eise_io("Independent retrieve: not an Eiffel object.");
					}
				} else {
					spec_size = EIF_Size((uint16)(dgen & SK_DTYPE)) + OVERHEAD;
				}
			}
			ridr_norm_int (&count);
			nb_byte = CHRPAD((rt_uint_ptr) count * (rt_uint_ptr) spec_size ) + LNGPAD_2;
			ridr_norm_int (&elm_size);

#if DEBUG & 1
		printf (" %x", count);
		printf (" %x", elm_size);
#endif
			if (crflags & EO_TUPLE) {
				newadd = RTLNT(crflags & EO_TYPE);
			} else {
				newadd = spmalloc(nb_byte, EIF_TEST(!(crflags & EO_REF)));
			}
			if (newadd == (EIF_REFERENCE) 0) {
					/* Creation of Eiffel object failed */
				xraise(EN_MEM);
			}
			{
				EIF_REFERENCE o_ref;

				o_ref = RT_SPECIAL_INFO(newadd);
				RT_SPECIAL_COUNT_WITH_INFO(o_ref) = count;
				RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ref) = spec_size;
				spec_elm_size[dtypes[flags & EO_TYPE]] = elm_size;
			} 
			HEADER(newadd)->ov_flags |= crflags & (EO_REF|EO_COMP|EO_TYPE);
		} else {
			/* Normal object */
			newadd = emalloc(crflags & EO_TYPE); 
			if (newadd == (EIF_REFERENCE) 0) {
					/* Creation of Eiffel object failed */
				xraise(EN_MEM);
			}
		}
		
#ifdef ISE_GC
			/* Stop in the garbage collector because we have know an unstable
			 * object. */
		rt_g_data.status |= GC_STOP;
#endif /* ISE_GC */

			/* Record the new object in hector table */
		new_hector = hrecord(newadd);
		nb_recorded++;

			/* Update unsolved references on `newadd' */
		rt_update1 (oldadd, new_hector);

			/* Read the object's body */
		object_read (newadd, newadd, crflags);

			/* Update fileds: the garbage collector should not be called
			 * during `rt_update2' because the object is in a very unstable
			 * state.
			 */
		rt_update2(oldadd, newadd, newadd);

#ifdef ISE_GC
			/* Restore garbage collector status */
		rt_g_data.status = g_status;
#endif /* ISE_GC */
	}
	expop(&eif_stack);
	return newadd;
}

rt_public EIF_REFERENCE rrt_make (void)
{
	/* Make the retrieve of all objects in file */
	uint32 objectCount;

	/* Read the object count in the file header */
	ridr_multi_int32 (&objectCount, 1);

	return rrt_nmake (objectCount);
}

/* Add `object' and its `old_values' into the mismatch table for later
 * correction.
 */
rt_private void add_mismatch (EIF_REFERENCE object, EIF_REFERENCE old_values)
{
	RT_GET_CONTEXT
	EIF_REFERENCE spec;

#ifdef ISE_GC
	REQUIRE ("No GC", rt_g_data.status & GC_STOP);
#endif
	if (mismatches->count == mismatches->capacity) {
		EIF_GET_CONTEXT
		RT_GC_PROTECT(object);
		RT_GC_PROTECT(old_values);
		grow_mismatch_table ();
		RT_GC_WEAN_N(2);
	}

	spec = eif_access (mismatches->values);
	((EIF_REFERENCE *) spec)[mismatches->count] = old_values;
	RTAR(spec, old_values);

	spec = eif_access (mismatches->objects);
	((EIF_REFERENCE *) spec)[mismatches->count] = object;
	RTAR(spec, object);

	++mismatches->count;
}

/* Create a DROPPED record for the address `old' in the storing system.
 * An exception is raised for a dropped object (due to its generating type
 * missing from the retrieving syste) only when an attribute is found to
 * actually reference it.
 */
rt_private void rt_dropped (register EIF_REFERENCE old, int16 old_type)
{
	RT_GET_CONTEXT
	rt_uint_ptr key = ((rt_uint_ptr) old) - 1;
	struct rt_struct *info = (struct rt_struct *) ht_first(rt_table, key);
	info->rt_status = DROPPED;
	info->rtu_data.old_type = old_type;
}

rt_private EIF_REFERENCE new_special_object (int new_type, uint32 crflags, uint32 count)
{
	EIF_REFERENCE result;
	rt_uint_ptr nb_byte;
	uint32 spec_size = 0;
	uint32 dgen = special_generic_type (new_type);

	if ((dgen & SK_HEAD) == SK_EXP) {
#ifdef WORKBENCH
		spec_size = EIF_Size((uint16)(dgen & SK_DTYPE)) + OVERHEAD;
#else
		spec_size = EIF_Size((uint16)(dgen & SK_DTYPE));
		if (References(dgen & SK_DTYPE) > 0) {
			spec_size = spec_size + OVERHEAD;
		}
#endif
	} else {
		switch (dgen) {
		case SK_UINT8: spec_size = sizeof (EIF_NATURAL_8); break;
		case SK_UINT16: spec_size = sizeof (EIF_NATURAL_16); break;
		case SK_UINT32: spec_size = sizeof (EIF_NATURAL_32); break;
		case SK_UINT64: spec_size = sizeof (EIF_NATURAL_64); break;
		case SK_INT8:    spec_size = sizeof (EIF_INTEGER_8);  break;
		case SK_INT16:   spec_size = sizeof (EIF_INTEGER_16); break;
		case SK_INT32:   spec_size = sizeof (EIF_INTEGER_32); break;
		case SK_INT64:   spec_size = sizeof (EIF_INTEGER_64); break;
		case SK_CHAR:    spec_size = sizeof (EIF_CHARACTER);  break;
		case SK_WCHAR:   spec_size = sizeof (EIF_WIDE_CHAR);  break;
		case SK_BOOL:    spec_size = sizeof (EIF_BOOLEAN);    break;
		case SK_REAL32:   spec_size = sizeof (EIF_REAL_32);       break;
		case SK_REAL64 : spec_size = sizeof (EIF_REAL_64);     break;
		case SK_POINTER: spec_size = sizeof (EIF_POINTER);    break;
		case SK_DTYPE:
		case SK_REF:     spec_size = sizeof (EIF_REFERENCE);  break;

		default:
			if (dgen & SK_BIT) 
				spec_size = BITOFF (dgen & SK_DTYPE);
			else
				eise_io ("Independent retrieve: not an Eiffel object.");
		}
	}
	nb_byte = CHRPAD ((rt_uint_ptr) count * (rt_uint_ptr) spec_size) + LNGPAD_2;
	result = spmalloc (nb_byte, EIF_TEST(!(crflags & EO_REF)));
	if (result != NULL) {
		EIF_REFERENCE o_ref = RT_SPECIAL_INFO (result);
		RT_SPECIAL_COUNT_WITH_INFO (o_ref) = count;
		RT_SPECIAL_ELEM_SIZE_WITH_INFO (o_ref) = spec_size;
		HEADER (result)->ov_flags |= crflags & (EO_REF|EO_COMP|EO_TYPE);
	} 
	return result;
}

rt_public EIF_REFERENCE rrt_nmake (long int objectCount)
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrieved object.
	 */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	EIF_REFERENCE volatile newadd = NULL;
	volatile long int i;
	jmp_buf exenv;
#ifdef ISE_GC
	volatile char g_status = rt_g_data.status;
#endif
	RTXD;

	REQUIRE ("Positive count", objectCount > 0);

	excatch (&exenv);	/* Record pseudo execution vector */
	if (setjmp (exenv)) {
		rt_clean ();			/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
#ifdef ISE_GC
		rt_g_data.status = g_status;		/* If a crash occurs, since we may disable the GC in the
										 * code below, we need to make sure to restore the status
										 * to what it originally was. */
#endif
		ereturn (MTC_NOARG);	/* Propagate exception */
	}

	mismatches = new_mismatch_table (objectCount / 10);

	/* Initialization of the hash table */
	nb_recorded = 0;
	rt_create_table (objectCount);

#ifdef RECOVERABLE_DEBUG
	printf ("-- Retrieving %ld objects:\n", objectCount);
#endif
	for (i=1; i<=objectCount; i++) {
		uint32 crflags, flags;
		uint32 count;
		int16 old_type;
		EIF_REFERENCE oldadd;
		type_descriptor *conv;

		/* Read address in storing system and object flags (w/dynamic type) */
		ridr_multi_any ((char *) &oldadd, 1);
		ridr_norm_int (&flags);
		crflags = rt_id_read_cid (flags);

		old_type = (int16) (flags & EO_TYPE);
		if (! type_defined (old_type))
			eraise ("Independent retrieve: unknown type.", EN_RETR);
		conv = type_description (old_type);
		if (conv->new_type < 0)
			newadd = NULL;				/* Stored type not in retrieving system */
		else if (flags & EO_SPEC) {		/* Special object */
			uint32 elem_size;
			ridr_norm_int (&count);
			ridr_norm_int (&elem_size);
			spec_elm_size[conv->new_type] = elem_size;
			if (flags & EO_TUPLE) {
				int16 dftype = crflags & EO_TYPE;
				if (conv->new_dftype != TYPE_UNDEFINED)
					dftype = conv->new_dftype;
				newadd = RTLNT(dftype);
			} else {
				newadd = new_special_object (conv->new_type, crflags, count);
			}
		}
		else {		/* Normal object */
			int16 dftype = crflags & EO_TYPE;
			if (conv->new_dftype != TYPE_UNDEFINED)
				dftype = conv->new_dftype;
				/* NOTE: Manu 05/30/2003
				 * We have to use RTLNSMART because of the change in the TUPLE
				 * implementation we did in version 5.4 of the compiler where
				 * now TUPLEs are just a special case of SPECIAL objects.
				 * So when we retrieve a TUPLE made with version 5.3, then
				 * we take this path and to have correct mismatch work, we need
				 * to create a proper TUPLE type, thus the use of RTLNSMART.
				 */
			newadd = RTLNSMART (dftype);
		}

#ifdef ISE_GC
			/* Stop in the garbage collector because we have now an unstable
			 * object. */
		rt_g_data.status |= GC_STOP;
#endif

#ifdef RECOVERABLE_DEBUG
		if (newadd == NULL)
			printf ("%2ld: [%p] %s discarded (type not in system)\n",
					i, oldadd, conv->name);
		else
			printf ("%2ld: [%p => %p] %s\n",
					i, oldadd, newadd, EIF_OBJECT_TYPE (newadd));
#endif
		if (newadd == NULL) {
			/* We only raise an exception for a missing type at this point
			 * if it is the type of the root object of the stored object
			 * tree. This is because the object may be no longer referenced
			 * due of the attribute holding it has been removed.
			 */
			if (i == objectCount)
				eraise (conv->name, EN_RETR);
			rt_dropped (oldadd, old_type);
			if (flags & EO_SPEC) {
				if (flags & EO_TUPLE) {
					object_rread_tuple (NULL, count);
				} else {
					object_rread_special (NULL, flags, count);
				}
			} else {
				object_rread_attributes (NULL, crflags, flags, 0L);
			}
		} else {
			EIF_REFERENCE old_values;
			EIF_OBJECT new_hector = hrecord (newadd);
			nb_recorded++;

				/* Update unsolved references on `newadd' */
			rt_update1 (oldadd, new_hector);

				/* Read object values from file */
			if (flags & EO_SPEC) {
				if (flags & EO_TUPLE) {
						/* We can always hold in a tuple types that do not match
						 * since it always contains references to items, even for
						 * expanded items. Therefore we can safely set `old_values'
						 * to NULL. */
					old_values = NULL;
					object_rread_tuple (eif_access(new_hector), count);
				} else {
					old_values = object_rread_special (
						eif_access (new_hector), flags, count);
				}
			} else {
				old_values = object_rread_attributes (eif_access (new_hector), crflags, flags, 0L);
			}

			if (old_values != NULL)
				add_mismatch (eif_access (new_hector), old_values);

				/* Update fields: the garbage collector should not be called
				 * during `rt_update2' because the object is in a very unstable
				 * state.
				 */
			rt_update2 (oldadd, eif_access (new_hector), eif_access (new_hector));

			newadd = eif_access (new_hector);
		}

#ifdef ISE_GC
			/* Restore garbage collector status */
		rt_g_data.status = g_status;
#endif
	}
	expop (&eif_stack);
	return newadd;
}

rt_private void rt_clean(void)
{
	/* Clean the data structure before raising an exception of code `code'
	 * after having cleaned the hash table 
	 * and allocated memory and reset function pointers. */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	/* struct rt_struct *rt_info;*/ /* %%ss unused */

	if (rt_table != (struct htable *) 0) {
		struct rt_struct *rt_info = (struct rt_struct *) rt_table->h_values;
		size_t count = rt_table->h_size;

		for (; count > 0; count--, rt_info++) {
			if (rt_info->rt_status == UNSOLVED) {	/* Free cell list */
				struct rt_cell *cell, *next_cell;

				cell = rt_info->rt_list;
				while (cell != (struct rt_cell *) 0) {
					next_cell = cell->next;
					eif_rt_xfree((char *) cell);
					cell = next_cell;
				}
			}
		}
		ht_free(rt_table);						/* Free hash table descriptor */
		rt_table = NULL;
	}
	if (dtypes != (int *) 0) {
		eif_rt_xfree((char *) dtypes);
		dtypes = (int *) 0;
	}
	if (spec_elm_size != (uint32 *)0) {
		eif_rt_xfree((char *) spec_elm_size);
		spec_elm_size = (uint32 *)0;
	}

	if (r_buffer != (char *)0) {
		eif_rt_xfree (r_buffer);
		r_buffer = (char *) 0;
	}
#ifdef ISE_GC
	epop(&hec_stack, nb_recorded);				/* Pop hector records */
#endif
	nb_recorded = 0;
	if (rt_kind == INDEPENDENT_STORE || rt_kind == RECOVERABLE_STORE) {
		independent_retrieve_reset ();
	}
	free_sorted_attributes();
	free_mismatch_table (mismatches);
	mismatches = NULL;
	free_type_conversion_table (type_conversions);
	type_conversions = NULL;
	rt_reset_retrieve();
}

/* Creates a SOLVED record associating object indirection `new_obj' in the
 * retrieving system with the address `old' in the storing system. Also
 * resolves any previously created UNSOLVED records created for this same
 * `old' address.
 */
rt_private void rt_update1 (register EIF_REFERENCE old, register EIF_OBJECT new_obj)
{
	/* `new_obj' is hector pointer to a retrieved object. We have to solve
	 * possible references with it, before putting it in the hash table.
	 */

	RT_GET_CONTEXT
	rt_uint_ptr key = ((rt_uint_ptr) old) - 1;	/* Key in the hash table */
	rt_uint_ptr solved_key;
	size_t offset;
	struct rt_struct *rt_info, *rt_solved;
	struct rt_cell *rt_unsolved, *next;
	EIF_REFERENCE  client = NULL, supplier = NULL;
	

	rt_info = (struct rt_struct *) ht_first(rt_table, key);

	CHECK("Not already solved", rt_info->rt_status == UNSOLVED);

	/* First, solve references if any. */
	rt_unsolved = rt_info->rt_list;
	while (rt_unsolved != (struct rt_cell *) 0) {
		next = rt_unsolved->next;

		if (rt_unsolved->status == RTU_KEYED) {
			solved_key = rt_unsolved->u.key;	/* Key to the solved object */
			rt_solved = (struct rt_struct *) ht_value(rt_table, solved_key);

#ifdef MAY_PANIC
			if (
				rt_solved == (struct rt_struct *) 0
				|| rt_solved->rt_status != SOLVED
			)
				eif_panic("should be solved");
#endif

			/* Attachment to hector pointer dereference */
			client = eif_access(rt_solved->rt_obj);
			supplier = eif_access(new_obj);
		}
		else if (rt_unsolved->status == RTU_INDIRECTION) {
			client = eif_access(rt_unsolved->u.rtu_obj);
			supplier = eif_access(new_obj);
		}
#ifdef MAY_PANIC
		else
			eif_panic("unexpected status");
#endif
		offset = rt_unsolved->offset;	/* Offset in the solved object */
		*(EIF_REFERENCE *) (client + offset) = supplier;
		RTAR(client, supplier);					/* Age check */

		eif_rt_xfree((char *) rt_unsolved);		/* Free reference solving cell */
		rt_info->rt_list = next;			/* Unlink from list */
		rt_unsolved = next;	
	}

	/* Put the new hector pointer as a solved reference in the hash table */
	rt_info->rt_status = SOLVED;
	rt_info->rt_obj = new_obj;
}

rt_private void rt_subupdate (EIF_REFERENCE old, EIF_REFERENCE reference, EIF_REFERENCE addr, EIF_REFERENCE new_obj, EIF_REFERENCE parent);

rt_private void rt_update2(EIF_REFERENCE old, EIF_REFERENCE new_obj, EIF_REFERENCE parent)
{
	/* Reference field updating: record new unsolved references.
	 * The third argument is needed because of expanded objects:
	 * if `new_obj' is not an expanded object,parent is equal to it. */

	RT_GET_CONTEXT
	long nb_references = 0;
	uint32 flags;
	EIF_REFERENCE reference, addr;
	union overhead *zone = HEADER(new_obj);
	int nb_attr = 0;
	rt_uint_ptr size;				/* New object size */
	/* struct rt_struct *rt_info;*/ /* %%ss unused */

#ifndef NDEBUG
	nb_references = -1;
#endif
	flags = Mapped_flags(zone->ov_flags);

	if (flags & EO_SPEC) {				/* Special object */
		EIF_REFERENCE o_ref;
		EIF_INTEGER count, elem_size, old_elem_size;

		if (!(flags & EO_REF))			/* Special without references */
			return;

		size = zone->ov_size & B_SIZE;	
		o_ref = RT_SPECIAL_INFO_WITH_ZONE(new_obj, zone);
		count = RT_SPECIAL_COUNT_WITH_INFO(o_ref);
		if (flags & EO_TUPLE) {
			EIF_TYPED_ELEMENT * l_item = (EIF_TYPED_ELEMENT *) new_obj;
				/* Don't forget that first element of TUPLE is just a placeholder
				 * to avoid offset computation from Eiffel code */
			l_item++;
			count--;
			for (; count > 0; count--, l_item++) {
				if
					((eif_tuple_item_type(l_item) == EIF_REFERENCE_CODE) &&
					(eif_reference_tuple_item(l_item)))
				{
						/* Update reference value to new value in retrieved system */
					rt_subupdate(old, eif_reference_tuple_item(l_item),
						(EIF_REFERENCE) &eif_reference_tuple_item(l_item), new_obj, parent);
				}
			}
			/* Nothing to do anymore */
			return;
		} else if (!(flags & EO_COMP)) {		/* Special of references */
			nb_references = count;
			goto update;
		} else {						/* Special of expanded objects */
			EIF_REFERENCE  old_addr;

			elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ref);
			if (rt_kind != INDEPENDENT_STORE && rt_kind != RECOVERABLE_STORE) {
				old_overhead = OVERHEAD;
				old_elem_size = elem_size;
			} else
				old_elem_size = spec_elm_size[flags & EO_TYPE];

			for (	addr = new_obj + OVERHEAD, old_addr = old + old_overhead;
					count>0 ;
					count--, addr += elem_size, old_addr += old_elem_size) {
				rt_update2(old_addr, addr, parent);
			}
			/* Nothing to do anymore */
			return;
		}
	} else {							/* Normal object */
		nb_references = References(flags & EO_TYPE);
		size = EIF_Size(flags & EO_TYPE);
	}

	CHECK ("Must be initialized", nb_references != -1);

update:
	/* Update references */
	nb_attr = System(flags & EO_TYPE).cn_nbattr;
	for (addr = new_obj; nb_references > 0;
			nb_references--, addr = (EIF_REFERENCE)(((EIF_REFERENCE *) addr) + 1)) {

		/* *(EIF_REFERENCE *)new_obj is a pointer an a stored object: check if
		 * the corresponding reference is already in the hash table
		 */
		reference = *(EIF_REFERENCE *)addr;
		if (reference == (EIF_REFERENCE) 0)
			continue;
		if (nb_attr) {
			if (((System(flags & EO_TYPE).cn_types[nb_attr - nb_references]) & SK_HEAD) == SK_EXP) {
					/* Because we have no way to find what was the value corresponding to
					 * `reference' in `old' object, we simply use `old' although it
					 * might not be correct, but it does not matter too much as it is
					 * a self reference and no once except the enclosing object can point
					 * to it. */
				rt_update2(old, reference, parent);	/* Recursion */
				continue;
			} 
		} 
			/* Update reference value to new value in retrieved system */
		rt_subupdate(old, reference, addr, new_obj, parent);
	}
}


rt_private void rt_subupdate (EIF_REFERENCE old, EIF_REFERENCE reference, EIF_REFERENCE addr, EIF_REFERENCE new_obj, EIF_REFERENCE parent)
{
	RT_GET_CONTEXT
	struct rt_struct *rt_info;
	rt_uint_ptr key = ((rt_uint_ptr) reference) - 1;
	EIF_REFERENCE supplier;

	rt_info = (struct rt_struct *) ht_first(rt_table, key);
	if (rt_info->rt_status == DROPPED) {
		/* We raise an exception for an object dropped (due to its
		 * generating type not being present in the retrieving
		 * system) only if an attribute actually references it.
		 * This still leads to cases where it is harmless (e.g.
		 * this object, itself, may be no longer referenced), but
		 * these cases are very hard to detect in general.
		 */
		eraise (type_description (rt_info->rtu_data.old_type)->name, EN_RETR);
	}
	else if (rt_info->rt_status == SOLVED) {
		/* Reference is already solved */
		supplier = eif_access(rt_info->rt_obj);
		*(EIF_REFERENCE *) addr = supplier;			/* Attachment */
		RTAR(new_obj, supplier);					/* Age check */
	} else {
		/* Reference is stil unsolved */
		struct rt_cell *new_cell, *old_cell;

		new_cell = (struct rt_cell *) eif_rt_xmalloc(sizeof(struct rt_cell), C_T, GC_OFF);
		if (new_cell == (struct rt_cell *)0)
			xraise (EN_MEM);
		new_cell->status = RTU_KEYED;
		new_cell->u.key = ((rt_uint_ptr) old) - 1;
		new_cell->offset = (long) (addr - parent);
		old_cell = rt_info->rt_list;
		new_cell->next = old_cell;
		rt_info->rt_list = new_cell;
		rt_info->rt_status = UNSOLVED;
		*(EIF_REFERENCE *) addr = (EIF_REFERENCE) 0; 
				/* Set to zero the unsolved reference
				 * in order to put the object in a
				 * stable state. */
	}
}

/* If the address in the storing system at `location' has already been
 * associated (via a SOLVED record) with an object in the retrieving (i.e.
 * current) system, this routine replaces the reference at `location' with
 * a reference to the associated object in the retrieving system. If the
 * address at `location' is not yet associated with an object in the
 * retrieving system, an UNSOLVED2 record is created under the key for
 * the address at `location', marked with the offset of `location' within
 * `object', and the reference at `location' is set to null to prevent
 * breaking the GC.
 */
rt_private void update_reference (EIF_REFERENCE object, EIF_REFERENCE *location)
{
	RT_GET_CONTEXT
	EIF_REFERENCE reference = *location;
	rt_uint_ptr key = ((rt_uint_ptr) reference) - 1;
	struct rt_struct *rt_info = (struct rt_struct *) ht_first (rt_table, key);
	if (rt_info->rt_status == SOLVED) {
		/* Reference is already solved */
		EIF_REFERENCE supplier = eif_access (rt_info->rt_obj);
		*location = supplier;			/* Attachment */
		RTAR(object, supplier);
	} else {
		/* Reference is still unsolved */
		struct rt_cell *new_cell, *old_cell;
		EIF_OBJECT new_hector = hrecord (object);
		nb_recorded++;

		new_cell = (struct rt_cell *) eif_rt_xmalloc (sizeof (struct rt_cell), C_T, GC_OFF);
		if (new_cell == NULL)
			xraise (EN_MEM);
		new_cell->status = RTU_INDIRECTION;
		new_cell->u.rtu_obj = new_hector;
		new_cell->offset = (char *) location - (char *) object;
		if (rt_info->rt_status == DROPPED) {
				/* We need to reset `old_cell' and not use the value from
				 * `rt_info->rt_list because it contained a type information, not
				 * a pointer to another cell.
				 */
			old_cell = NULL;
		} else {
			old_cell = rt_info->rt_list;
		}
		new_cell->next = old_cell;
		rt_info->rt_list = new_cell;
		rt_info->rt_status = UNSOLVED;
		*location = NULL; 
	}
}

rt_private char *next_item (char *ptr)
{
	int first_char = 0;

	for (;;) {
		if (!(isspace(*(unsigned char *) ptr)) && !first_char ) 
			first_char = 1;
		else if (isspace(*(unsigned char *)ptr) && first_char)
			break;
		ptr++;
	}
	return (ptr);
}

rt_private void read_header(char rt_type)
{
	/* Read header and make the dynamic type correspondance table */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	int nb_lines, i, k, old_count;
	int dtype, new_dtype;
	long size;
	uint32 nb_gen;
	size_t bsize = 1024;
	char vis_name[512];
	char * temp_buf;
	jmp_buf exenv;
#ifdef ISE_GC
	volatile char g_status = rt_g_data.status;
#endif
	RTXD;

	errno = 0;

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
#ifdef ISE_GC
		rt_g_data.status = g_status;		/* If a crash occurs, since we may disable the GC in the
										 * code below, we need to make sure to restore the status
										 * to what it originally was. */
#endif
		ereturn(MTC_NOARG);				/* Propagate exception */
	}
	r_buffer = (char*) eif_rt_xmalloc (bsize * sizeof (char), C_T, GC_OFF);
	if (r_buffer == (char *)0)
		xraise (EN_MEM);

	/* Read the old maximum dyn type */
	if (readline(r_buffer, bsize) <= 0)
		eise_io("General retrieve: unable to read number of different Eiffel types.");
	if (sscanf(r_buffer,"%d\n", &old_count) != 1)
		eise_io("General retrieve: unable to read number of different Eiffel types.");
	/* create a correspondance table */
	dtypes = (int *) eif_rt_xmalloc(old_count * sizeof(int), C_T, GC_OFF);
	if (dtypes == (int *) 0)
		xraise(EN_MEM);

	if (rt_type == GENERAL_STORE_4_0) {
		sorted_attributes = (unsigned int **) eif_rt_xmalloc(scount * sizeof(unsigned int *), C_T, GC_OFF);
#ifdef DEBUG_GENERAL_STORE
printf ("Allocating sorted_attributes (scount: %d) %lx\n", scount, sorted_attributes);
#endif
		if (sorted_attributes == (unsigned int **)0) {
			eif_rt_xfree ((char *) dtypes);
			xraise(EN_MEM);
			}
		}
		memset (sorted_attributes, 0, scount * sizeof(unsigned int *));

	/* Read the number of lines */
	if (readline(r_buffer, bsize) <= 0)
		eise_io("General retrieve: unable to read number of header lines.");
	if (sscanf(r_buffer,"%d\n", &nb_lines) != 1)
		eise_io("General retrieve: unable to read number of header lines.");

	for(i=0; i<nb_lines; i++) {
		if (readline(r_buffer, bsize) <= 0)
			eise_io("General retrieve: unable to read current header line.");

		temp_buf = r_buffer;

		if (4 != sscanf(r_buffer, "%d %s %ld %d",&dtype,vis_name,&size,&nb_gen))
			eise_io("General retrieve: unable to read type description.");

		for (k = 1 ; k <= 4 ; k++)
			temp_buf = next_item (temp_buf);

		if (nb_gen > 0) {
			struct cecil_info *info;
			int32 *t;
			int matched;
			uint32 j, index;
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
			info = cecil_info (NULL, vis_name);
			if (info == NULL) {
				eraise(vis_name, EN_RETR);	/* Cannot find class */
			}

			if (info->nb_param != nb_gen) {
				eraise(vis_name, EN_RETR);	/* No good generic count */
			}

			for (j=0; j<nb_gen; j++) {		/* Read meta-types */
				if (sscanf(temp_buf," %ld", &gtype[j]) != 1)
					eise_io("General retrieve: unable to read generic information.");
				temp_buf = next_item (temp_buf);
					
			}

			for (t = info->patterns; /* empty */; /* empty */) {

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
			index = (int) ((t - info->patterns) / nb_gen);
			new_dtype = info->dynamic_types[index];
			if (nb_gen > MAX_GENERICS) {
				eif_rt_xfree ((char *) gtype);
				eif_rt_xfree ((char *) itype);
			}
		} else {
			struct cecil_info *info;

				/* Non generic class */
			info = cecil_info (NULL, vis_name);
			if (info == NULL) {
				eraise(vis_name, EN_RETR);	/* Cannot find class */
			}
			new_dtype = info->dynamic_type;
		}
		if (EIF_Size(new_dtype) != size) {
			eraise(vis_name, EN_RETR);		/* No good size */
		}
		dtypes[dtype] = new_dtype;

		if (rt_type == GENERAL_STORE_4_0)
			sort_attributes(new_dtype);
	}
	eif_rt_xfree (r_buffer);
	r_buffer = (char *) 0;
	expop(&eif_stack);
}


#ifdef RECOVERABLE_SCAFFOLDING
rt_private void iread_header(EIF_CONTEXT_NOARG)
{
	/* Read header and make the dynamic type correspondance table */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	int nb_lines, i, k, old_count;
	int dtype, new_dtype;
	uint32 nb_gen, bsize = 1024;
	char vis_name[512];
	char * temp_buf;
	uint32 num_attrib;
	long read_attrib;
	char att_name[512];
	int * volatile attrib_order = NULL;
	jmp_buf exenv;
#ifdef ISE_GC
	volatile char g_status = rt_g_data.status;
#endif
	RTXD;

	errno = 0;

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
#ifdef ISE_GC
		rt_g_data.status = g_status;		/* If a crash occurs, since we may disable the GC in the
										 * code below, we need to make sure to restore the status
										 * to what it originally was. */
#endif
		ereturn(MTC_NOARG);				/* Propagate exception */
	}

	r_buffer = (char*) eif_rt_xmalloc (bsize * sizeof (char), C_T, GC_OFF);
	if (r_buffer == (char *) 0)
		xraise (EN_MEM);

	/* Read the old maximum dyn type */
	if (idr_read_line(r_buffer, bsize) == 0)
		eise_io("Independent retrieve: unable to read number of different Eiffel types.");
	if (sscanf(r_buffer,"%d\n", &old_count) != 1)
		eise_io("Independent retrieve: unable to read number of different Eiffel types.");

			/* We need to make sure that `dtypes' and `spec_elm_size' arrays are large enough
			 * to store all types in retrieving system. */
	if (old_count < eif_par_table2_size) {
			/* We use `eif_par_table2_size' as it will give us a correct size in
			 * both workbench/melted/finalized mode of the number of dynamic types
			 * FIXME: Manu 06/24/2004: Maybe we ought to have a query that would
			 * represent this value without being specific to generic conformance. */
		old_count = eif_par_table2_size + 1;
	}

		/* create a correspondance table */
	dtypes = (int *) eif_rt_xmalloc(old_count * sizeof(int), C_T, GC_OFF);
	if (dtypes == (int *)0)
		xraise (EN_MEM);
	spec_elm_size = (uint32 *) eif_rt_xmalloc (old_count * sizeof (uint32), C_T, GC_OFF);
	if (spec_elm_size == (uint32 *)0)
		xraise (EN_MEM);
	if (idr_read_line(r_buffer, bsize) == 0)
		eise_io("Independent retrieve: unable to read OVERHEAD size.");
	if (sscanf(r_buffer,"%d\n", &old_overhead) != 1)
		eise_io("Independent retrieve: unable to read OVERHEAD size.");
	if (dtypes == (int *) 0)
		xraise(EN_MEM);

	/* Read the number of lines */
	if (idr_read_line(r_buffer, bsize) == 0)
		eise_io("Independent retrieve: unable to read number of header lines.");
	if (sscanf(r_buffer,"%d\n", &nb_lines) != 1)
		eise_io("Independent retrieve: unable to read number of header lines.");

	for(i=0; i<nb_lines; i++) {
		if (idr_read_line(r_buffer, bsize) == 0)
			eise_io("Independent retrieve: unable to read current header line.");

		temp_buf = r_buffer;

		if (3 != sscanf(r_buffer, "%d %s %d",&dtype,vis_name,&nb_gen))
			eise_io("Independent retrieve: unable to read type description.");

		for (k = 1 ; k <= 3 ; k++)
			temp_buf = next_item (temp_buf);

		if (nb_gen > 0) {
			struct cecil_info *info;
			int32 *t;
			int matched;
			uint32 j, index;
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

			info = cecil_info (NULL, vis_name);
			if (info == NULL) {
				eraise(vis_name, EN_RETR);	/* Cannot find class */
			}

			if (info->nb_param != nb_gen) {
				eraise(vis_name, EN_RETR);	/* No good generic count */
			}

			for (j=0; j<nb_gen; j++) {		/* Read meta-types */
				if (sscanf(temp_buf," %ld", &gtype[j]) != 1)
					eise_io("Independent retrieve: unable to read generic information.");
				temp_buf = next_item (temp_buf);
					
			}

			for (t = info->patterns; /* empty */; /* empty */) {

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
			index = (int) ((t - info->patterns) / nb_gen);
			new_dtype = info->dynamic_types[index];
			if (nb_gen > MAX_GENERICS) {
				eif_rt_xfree ((char *) gtype);
				eif_rt_xfree ((char *) itype);
			}
		} else {
			struct cecil_info *info;

				/* Non generic class */
			info = cecil_info (NULL, vis_name);
			if (info == NULL) {
				eraise(vis_name, EN_RETR);	/* Cannot find class */
			}
			new_dtype = info->dynamic_type;
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
				attrib_order = (int *) eif_rt_xmalloc (num_attrib * sizeof (int), C_T, GC_OFF);
				if (attrib_order == (int *)0)
					xraise (EN_MEM);
				for (; num_attrib > 0;) {
					if (idr_read_line(r_buffer, bsize) == 0) {
						eif_rt_xfree ((char *) attrib_order);
						eise_io("Independent retrieve: unable to read attribute description.");
					}
					if (sscanf(r_buffer," %lu %s", &read_attrib, att_name) != 2) {
						eif_rt_xfree ((char *) attrib_order);
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
									eif_rt_xfree ((char *) attrib_order);
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
								eif_rt_xfree ((char *) attrib_order);
								(void) strcat (vis_name + strlen (vis_name), ".");
								(void) strcat (vis_name + strlen (vis_name), att_name);
								eraise(vis_name, EN_RETR);
									/* non matching attributes */
							}
						} else {
							*(attrib_order + num_attrib) = num_attrib;
						}
					} else {
						eif_rt_xfree ((char *) attrib_order);
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
	eif_rt_xfree (r_buffer);
	r_buffer = (char*) 0;
	expop(&eif_stack);
}
#endif


#ifdef RECOVERABLE_DEBUG

static char *type2name (long type)
{
	char *name;
	switch (type & SK_HEAD) {
		case SK_EXP:     name = "expanded";       break;
		case SK_BOOL:    name = "BOOLEAN";        break;
		case SK_CHAR:    name = "CHARACTER";      break;
		case SK_UINT8:   name = "NATURAL_8";      break;
		case SK_UINT16:  name = "NATURAL_16";     break;
		case SK_UINT:    name = "NATURAL_32";     break;
		case SK_UINT64:  name = "NATURAL_64";     break;
		case SK_INT8:    name = "INTEGER_8";      break;
		case SK_INT16:   name = "INTEGER_16";     break;
		case SK_INT32:   name = "INTEGER_32";     break;
		case SK_INT64:   name = "INTEGER_64";     break;
		case SK_REAL32:  name = "REAL_32";        break;
		case SK_WCHAR:   name = "WIDE_CHARACTER"; break;
		case SK_REAL64:  name = "REAL_64";        break;
		case SK_BIT:     name = "BIT";            break;
		case SK_POINTER: name = "POINTER";        break;
		case SK_REF:     name = "REFERENCE";      break;
		default: name = "***UNDEFINED***";        break;
	}
	return name;
}

rt_shared char *name_of_attribute_type (int16 **type)
{
	static char buffer [512 + 9];
	char *result;
	int16 dftype = **type;

	REQUIRE ("Not a formal parameter", dftype != FORMAL_TYPE);

	if (dftype == TUPLE_TYPE) {
		*type += TUPLE_OFFSET;
		dftype = **type;
	}

	if (dftype >= 0) {
		dftype = RTUD(dftype);
		if (EIF_IS_EXPANDED_TYPE(System (dftype).flags)) {
			result = System (dftype).cn_generator;
		} else {
			sprintf (buffer, "expanded %s", System (dftype).cn_generator);
			result = buffer;
		}
	} else if (dftype <= FORMAL_TYPE) {
		sprintf (buffer, "%c", 'F' + FORMAL_TYPE - dftype);
		result = buffer;
	}
	return result;
}

rt_private char *name_of_old_attribute_type (int16 **type)
{
	int16 dftype = **type;
	static char buffer [512 + 9];
	char *result;

	REQUIRE ("Not a formal parameter", dftype != FORMAL_TYPE);

	if (dftype >= 0) {
		if (type_conversions->type_index[dftype] == TYPE_UNDEFINED) {
			sprintf (buffer, "NOT_YET_KNOWN (%d)", dftype);
			result = buffer;
		}
		else
			result = type_description (dftype)->name;
	} else if (dftype == TUPLE_TYPE) {
		(*type) += TUPLE_OFFSET;
		result = "TUPLE";
	} else if (dftype <= FORMAL_TYPE) {
		sprintf (buffer, "%c", 'F' + FORMAL_TYPE - dftype);
		result = buffer;
	}
	return result;
}

rt_private void print_old_attribute_type (int16 *atypes)
{
	int i = 0;
	int16 *typearr = atypes;
	for (; (*typearr != TERMINATOR); ) {
		printf ("%s%s", i==0 ? "" : i==1 ? " [" : ", ",
				name_of_old_attribute_type (&typearr));
		typearr += 1;
		i++;
	}
	printf ("%s", i > 1 ? "]" : "");
}

rt_private void print_attribute_type (int16 *gtypes)
{
	int i = 0;
	int16 *typearr = gtypes;
	
	for (; (*typearr != TERMINATOR); ) {
		printf ("%s%s", i==0 ? "" : i==1 ? " [" : ", ",
				name_of_attribute_type (&typearr));
		typearr += 1;
		i++;
	}
	printf ("%s", i > 1 ? "]" : "");
}

rt_shared char *generic_name (int32 gtype, int old_types)
{
	static char buffer[512 + 9];
	char *result;
	if (gtype == SK_DTYPE)	/* To be kept for handling old storables which were using SK_DTYPE. */
		result = "REFERENCE";
	else switch (gtype & SK_HEAD) {
		case SK_EXP:
			strcpy (buffer, "expanded ");
			if (!old_types)
				result = System (gtype & SK_DTYPE).cn_generator;
			else if (type_conversions->type_index[gtype & SK_DTYPE] == TYPE_UNDEFINED) {
				sprintf (buffer, "NOT_YET_KNOWN (%d)", gtype & SK_DTYPE);
				result = buffer;
			}
			else
				result = type_description (gtype & SK_DTYPE)->name;
			break;
		case SK_BOOL:    result = "BOOLEAN";        break;
		case SK_CHAR:    result = "CHARACTER";      break;
		case SK_UINT8:   result = "NATURAL_8";      break;
		case SK_UINT16:  result = "NATURAL_16";     break;
		case SK_UINT:    result = "NATURAL_32";     break;
		case SK_UINT64:  result = "NATURAL_64";     break;
		case SK_INT8:    result = "INTEGER_8";      break;
		case SK_INT16:   result = "INTEGER_16";     break;
		case SK_INT32:   result = "INTEGER_32";     break;
		case SK_INT64:   result = "INTEGER_64";     break;
		case SK_REAL32:  result = "REAL_32";        break;
		case SK_WCHAR:   result = "WIDE_CHARACTER"; break;
		case SK_REAL64:  result = "REAL_64";        break;
		case SK_POINTER: result = "POINTER";        break;
		case SK_REF:     result = "REFERENCE";      break;
		default:
			sprintf (buffer, "UNKNOWN (0x%08x)", gtype);
			result = buffer;
			break;
						 
	}
	return result;
}

rt_shared void print_old_generic_names (int32 *gtypes, int count)
{
	if (count > 0) {
		int i;
		printf ("[");
		for (i=0; i<count; ++i)
			printf ("%s%s", i > 0 ? ", " : "", generic_name (gtypes [i], 1));
		printf ("]");
	}
}

rt_shared void print_generic_names (struct cecil_info *info, int type)
{
	int i, j, found = 0;
	int32 *patterns;

	for (i = 0; i < info->nb_param ; ++i) {
		if (info->dynamic_types[i] == type) {
			found = 1;
			printf ("[");
			*patterns = info->patterns + i * info->nb_param;
			for (j = 0; j < info->nb_param; ++j) {
				printf ("%s%s", j > 0 ? ", " : "", generic_name (patterns[j], 0));
			}
			printf ("]");
		}
	}

	if (found == 0) {
		printf ("[UNKNOWN_GENERIC_TYPE]");
	}
}

rt_shared void print_object_summary (
		char *prefix, EIF_REFERENCE object, long expanded_offset, uint32 flags)
{
	type_descriptor *conv = type_description (flags & EO_TYPE);
	if (object == NULL)
		printf ("  old %s\n", conv->name);
	else {
		EIF_REFERENCE o = object;
		int special = (HEADER (object)->ov_flags & EO_SPEC) != 0;
		if (expanded_offset > 0)
			o = (EIF_REFERENCE) ((char *) o + expanded_offset);
		printf ("%s%s%s [%p]\n", prefix, (expanded_offset > 0) ? "expanded " : "",
				special ? conv->name : EIF_OBJECT_TYPE (o), o);
	}
}

#endif

/*
doc:	<routine name="old_attribute_type_matched" export="private">
doc:		<summary>Find out if `gtype' and `atype' corresponds to the same type. This is similar to `attribute_type_matched' except this one takes care of storable versions that are strictly less than INDEPENDENT_STORE_5_5.</summary>
doc:		<param name="gtype" type="int16 **">Type array for attribute defined in retrieving system.</param>
doc:		<param name="atype" type="int16 **">Type array for attribute defined in storing system (here it uses the encoding for storable versions that are strictly less than INDEPENDENT_STORE_5_5.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>GC mutex</synchronization>
doc:	</routine>
*/
rt_private int old_attribute_type_matched (int16 **gtype, int16 **atype)
{
#ifdef EIF_ASSERTIONS
	RT_GET_CONTEXT
#endif

	int result = 1;
	int16 dftype = **gtype;
	int16 aftype = **atype;

	CHECK("version valid", rt_kind_version < INDEPENDENT_STORE_5_5);

	if (aftype <= OLD_EXPANDED_LEVEL) {
		aftype = OLD_EXPANDED_LEVEL - aftype;
	}

	if (aftype == OLD_TUPLE_TYPE) {
		if (dftype == TUPLE_TYPE) {
				/* Former encoding had 3 values: uniformizer, nb generics, TUPLE base id. */
			(*atype) += 3;
				/* New encoding has `TUPLE_OFFSET' values that we can skip. */
			(*gtype) += TUPLE_OFFSET;
			aftype = **atype;
			dftype = **gtype;
		} else {
			result = 0;
		}
	}

	if (result) {
		if (aftype <= OLD_FORMAL_TYPE) {
			if (dftype == FORMAL_TYPE) {
					/* Former encoding store formal position in `aftype', now next element
					 * is position. */
				(*gtype)++;
				dftype = **gtype;
				result = ((OLD_FORMAL_TYPE - aftype ) == dftype);
			} else {
				result = 0;
			}
		} else if (aftype == OLD_BIT_TYPE) {
			if (dftype == egc_bit_dtype) {
				(*atype)++;
				(*gtype)++;
				result = (**gtype == **atype);
			} else {
				result = 0;
			}
		} else if (aftype < 0) {
				/* Former encoding has a special encoding for basic types, new one doesn't need it.
				 * However we need to apply `RTUD_INV' on `egc_xxx_dtype' to have a valid
				 * typearr identifier. */
			switch (aftype) {
				case OLD_CHARACTER_TYPE: result = (dftype == RTID(egc_char_dtype)); break;
				case OLD_BOOLEAN_TYPE: result = (dftype == RTID(egc_bool_dtype)); break;
				case OLD_INTEGER_8_TYPE: result = (dftype == RTID(egc_int8_dtype)); break;
				case OLD_INTEGER_16_TYPE: result = (dftype == RTID(egc_int16_dtype)); break;
				case OLD_INTEGER_32_TYPE: result = (dftype == RTID(egc_int32_dtype)); break;
				case OLD_INTEGER_64_TYPE: result = (dftype == RTID(egc_int64_dtype)); break;
				case OLD_REAL_32_TYPE: result = (dftype == RTID(egc_real32_dtype)); break;
				case OLD_REAL_64_TYPE: result = (dftype == RTID(egc_real64_dtype)); break;
				case OLD_POINTER_TYPE: result = (dftype == RTID(egc_point_dtype)); break;
				case OLD_WIDE_CHAR_TYPE: result = (dftype == RTID(egc_wchar_dtype)); break;
				default:
					result = 0;
			}
		} else {
			if (dftype >= 0) {
					/* This is a normal type, nothing special to be done. */
				int16 g = RTUD(dftype);
				if (type_defined (aftype)) {
					result = (g == type_description (aftype)->new_type);
				} else {
					result = 0;
				}
			} else {
				result = 0;
			}
		}
	}

	return result;
}

rt_private int attribute_type_matched (int16 **gtype, int16 **atype)
{
	RT_GET_CONTEXT
	int result = 1;
	int16 dftype = **gtype;
	int16 aftype = **atype;

	if (rt_kind_version < INDEPENDENT_STORE_5_5) {
		result = old_attribute_type_matched (gtype, atype);
	} else {
		if (dftype == TUPLE_TYPE) {
			if (aftype == TUPLE_TYPE) {
				(*gtype) += TUPLE_OFFSET;
				(*atype) += TUPLE_OFFSET;
				dftype = **gtype;
				aftype = **atype;
			} else {
				result = 0;
			}
		}

		if (dftype == FORMAL_TYPE) {
			if (aftype == FORMAL_TYPE) {
				(*gtype)++;
				(*atype)++;
				result = (**gtype == **atype ? 1 : 0);
			} else {
				result = 0;
			}
		} else if (result) {
			if (dftype >= 0  &&  aftype >= 0) {
				int16 g = RTUD (dftype);
				if (type_defined (aftype)) {
					result = (g == type_description (aftype)->new_type);
				} else {
					result = 0;
				}
			} else {
				result = (dftype == aftype ? 1 : 0);
			}
		}
	}

	return result;
}

rt_private int attribute_types_matched (int16 *gtypes, int16 *atypes)
{
	RT_GET_CONTEXT
	int result;
	int16 atype = atypes[0];
	if (type_defined (atype) &&
			type_description (atype)->new_dftype != TYPE_UNDEFINED) {
		int16 dftype;
		int i, l_count = CIDARR_SIZE;
		int16 *l_cid = cidarr;
		for (i = 0; gtypes[i] != TERMINATOR; i++) {
				/* Make sure we don't go outside the bounds of `l_cid'. */
			if ((i + 1) >= l_count) {
					/* Reallocate array to allow ranges between `0' and `(i + 1) + 1'. */
				if (l_count >= CIDARR_SIZE) {
						/* Let's resize our existing allocated `l_cid' array by 1.5 times. */
					l_count = (2 * (i + 3)) / 2; 
					l_cid = (int16 *) realloc (l_cid, l_count * sizeof(int16));
				} else {
						/* Create a new memory block and copy content of `cidarr' in it. */
					l_cid = (int16 *) malloc ((i + 3) * sizeof(int16));
					l_count = i + 3;
					memcpy (l_cid, cidarr, CIDARR_SIZE * sizeof(int16));
				}
			}
			l_cid [i + 1] = gtypes[i];
		}
		l_cid [0] = i;
		l_cid [i + 1] = TERMINATOR;
		dftype = eif_compound_id (NULL, 0, l_cid[1], l_cid);
		if (l_cid != cidarr) {
			free(l_cid);
		}
		result = (dftype == type_description (atype)->new_dftype);
	}
	else {
		/* If `gtypes' is shorter than `atypes', we accept this, as it
		 * means that generic parameters were removed.
		 */
		result = 1;
		for (; (result == 1) && (*gtypes != TERMINATOR); gtypes++, atypes++) {
			result = attribute_type_matched (&gtypes, &atypes);
		}
	}
	return result;
}

/* The index of the attribute in `type' matching `att_type' and `att_name'
 * A result of -1 means no match found.
 */
rt_private int find_attribute (int dtype, char *att_name, uint32 att_type, int16 *atypes)
{
	int result = -1;
	if (dtype != -1) {
		long num_attrib = System (dtype).cn_nbattr;
		long i;

		for (i=0; i<num_attrib && result == -1; i++) {
			/* check if basic type and name of attribute match request */
			if ((System (dtype).cn_types[i] & SK_HEAD) == att_type &&
				strcmp (System (dtype).cn_names[i], att_name) == 0) {

				/* If either no reference type detail is provided, or the
				 * reference type detail matches the request, then we have
				 * matched the attribute.
				 */
				if (atypes == NULL ||
						attribute_types_matched (System (dtype).cn_gtypes[i]+1, atypes)) {
					result = i;
				}
			}
		}
#ifdef RECOVERABLE_DEBUG
		printf ("      %s %s: ", (result == -1 ? "-" : " "), att_name);
		if (result != -1)
			print_attribute_type (System (dtype).cn_gtypes[result]+1);
		else {
			if (atypes == NULL)
				printf (type2name (att_type));
			else
				print_old_attribute_type (atypes);
		}
		printf ("\n");
#endif
	}
	return result;
}

rt_private void iread_header_new (EIF_CONTEXT_NOARG)
{
	/* Read header and make the dynamic type correspondance table */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	char vis_name[512];
	int old_count, nb_lines, i;
	int bsize = 1024;
	jmp_buf exenv;
#ifdef ISE_GC
	volatile char g_status = rt_g_data.status;
#endif
	RTXD;

	errno = 0;

	excatch (&exenv);	/* Record pseudo execution vector */
	if (setjmp (exenv)) {
		rt_clean ();			/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
#ifdef ISE_GC
		rt_g_data.status = g_status;		/* If a crash occurs, since we may disable the GC in the
										 * code below, we need to make sure to restore the status
										 * to what it originally was. */
#endif
		ereturn (MTC_NOARG);	/* Propagate exception */
	}

	r_buffer = (char*) eif_rt_xmalloc (bsize * sizeof (char), C_T, GC_OFF);
	if (r_buffer == NULL)
		xraise (EN_MEM);

	/* Read the old maximum dyn type */
	if (idr_read_line (r_buffer, bsize) == 0)
		eise_io ("Independent retrieve: unable to read number of different Eiffel types.");
	if (sscanf (r_buffer,"%d\n", &old_count) != 1)
		eise_io ("Independent retrieve: unable to read number of different Eiffel types.");

			/* We need to make sure that `dtypes' and `spec_elm_size' arrays are large enough
			 * to store all types in retrieving system. */
	if (old_count < eif_par_table2_size) {
			/* We use `eif_par_table2_size' as it will give us a correct size in
			 * both workbench/melted/finalized mode of the number of dynamic types
			 * FIXME: Manu 06/24/2004: Maybe we ought to have a query that would
			 * represent this value without being specific to generic conformance. */
		old_count = eif_par_table2_size + 1;
	}

		/* create a correspondance table */
	dtypes = (int *) eif_rt_xmalloc (old_count * sizeof(int), C_T, GC_OFF);
	if (dtypes == NULL)
		xraise (EN_MEM);
	spec_elm_size = (uint32 *) eif_rt_xmalloc (old_count * sizeof (uint32), C_T, GC_OFF);
	if (spec_elm_size == NULL)
		xraise (EN_MEM);
	if (idr_read_line (r_buffer, bsize) == 0)
		eise_io ("Independent retrieve: unable to read OVERHEAD size.");
	if (sscanf (r_buffer,"%d\n", &old_overhead) != 1)
		eise_io ("Independent retrieve: unable to read OVERHEAD size.");

	/* Read the number of lines */
	if (idr_read_line (r_buffer, bsize) == 0)
		eise_io ("Independent retrieve: unable to read number of header lines.");
	if (sscanf (r_buffer,"%d\n", &nb_lines) != 1)
		eise_io ("Independent retrieve: unable to read number of header lines.");
	type_conversions = new_type_conversion_table (old_count, nb_lines);

	for (i=0; i<nb_lines; i++) {
		type_descriptor *conv;
		attribute_detail *attributes = NULL;
		int dtype, new_dtype = -1;
		int num_attrib;
		uint32 nb_gen;
		char *temp_buf;
		long j;
		int m;

		if (idr_read_line (r_buffer, bsize) == 0)
			eise_io ("Independent retrieve: unable to read current header line.");

		temp_buf = r_buffer;

		if (3 != sscanf (r_buffer, "%d %s %d", &dtype, vis_name, &nb_gen))
			eise_io ("Independent retrieve: unable to read type description.");

		type_conversions->type_index[dtype] = i;
		conv = type_conversions->descriptions + i;
		conv->old_type = dtype;

		for (m = 1 ; m <= 3 ; m++)
			temp_buf = next_item (temp_buf);

		/* Determine dynamic type in current system corresponding to type
		 * in storing system */
		if (nb_gen == 0) {
			/* Non generic class */
			struct cecil_info *info = cecil_info (conv, vis_name);
			if (info == NULL)
				new_dtype = -1;		/* Cannot find class name */
			else
				new_dtype = info->dynamic_type;
#ifdef RECOVERABLE_DEBUG
			if (new_dtype == -1)
				printf ("Type %d {%s} not in system ***\n", dtype, vis_name);
			else
				printf ("Type %d {%s} -> %d {%s}\n",
						dtype, vis_name, new_dtype, eif_typename ((int16) new_dtype));
#endif
		}
		else {
			/* Generic class */
			struct cecil_info *info;
			uint32 j;

			/* Read meta-types */
			conv->generics = (int32 *) eif_rt_xmalloc (nb_gen * sizeof (int32), C_T, GC_OFF);
			if (conv->generics == NULL)
				xraise (EN_MEM);
			conv->generic_count = nb_gen;
			for (j=0; j<nb_gen; j++) {
				long gtype;
				if (sscanf (temp_buf," %ld", &gtype) != 1)
					eise_io ("Independent retrieve: unable to read generic information.");
				CHECK ("old storable version", rt_kind_version < INDEPENDENT_STORE_5_5);
				if (gtype == SK_DTYPE) {
						/* Before we use to store SK_DTYPE, now we store SK_REF for
						 * references. */
					conv->generics[j] = SK_REF;
				} else {
					conv->generics[j] = gtype;
				}
				temp_buf = next_item (temp_buf);
			}

			info = cecil_info (conv, vis_name);
			if (info == NULL) {
				new_dtype = -1;		/* Cannot find generic class name */
#ifdef RECOVERABLE_DEBUG
				printf ("Type %d {%s} not in system ***\n", dtype, vis_name);
#endif
			} else if (info->nb_param != nb_gen) {
				new_dtype = -1;		/* Generic parameter count does not match */
#ifdef RECOVERABLE_DEBUG
				printf ("Type %d {%s} has different generic parameter count ***\n",
						dtype, vis_name);
#endif
			} else {
				int32 *gtypes = conv->generics;
				int32 *t;
				int matched;
				int index;

#ifdef RECOVERABLE_DEBUG
				printf ("Type %d {%s ", dtype, vis_name);
				print_old_generic_names ((int32 *) gtypes, nb_gen);
				printf ("}\n");
#endif
				for (t = info->patterns; ; ) {
					if ((unsigned int) *t == SK_INVALID) /* Cannot find good meta-type */
						eraise (vis_name, EN_RETR);
					matched = 1;					/* Assume a perfect match */
#ifdef RECOVERABLE_DEBUG
					printf ("        ? %d {%s ",
							info->dynamic_types[(t-info->patterns)/nb_gen], vis_name);
					print_generic_names (info, (t-info->patterns)/nb_gen);
					printf ("}");
#endif
					for (j=0; j<nb_gen; j++) {
						int32 gt = gtypes[j];
						int32 itype = *t++;
						if (((itype & SK_HEAD) == SK_EXP) && ((gt & SK_HEAD) == SK_EXP)) {
							matched = (type_description (gt & SK_DTYPE)->new_type != (itype & SK_DTYPE));
						} else {
							matched = (gt == itype);
						}
					}
					if (matched) {					/* We found the type */
#ifdef RECOVERABLE_DEBUG
						printf (" *\n");
#endif
						t -= nb_gen;
						break;						/* End of loop processing */
					}
#ifdef RECOVERABLE_DEBUG
					printf ("\n");
#endif
				}
				index = (int) ((t - info->patterns) / nb_gen);
				new_dtype = info->dynamic_types[index];
			}
		}

		dtypes[dtype] = new_dtype;			/* store new type on old type */
		conv->new_type = new_dtype;

		conv->name = (char *) eif_rt_xmalloc (strlen(vis_name)+1, C_T, GC_OFF);
		if (conv->name == NULL)
			xraise (EN_MEM);
		else
			strcpy (conv->name, vis_name);

		if (sscanf (temp_buf," %d", &num_attrib) != 1)
				/* error no value in buffer */
			eise_io ("Independent retrieve: unable to read number of attributes.");

#ifdef RECOVERABLE_DEBUG
		printf ("    %d attribute%s\n", num_attrib, num_attrib != 1 ? "s" : "");
#endif

		/* Build type correspondence table */
		conv->attribute_count = num_attrib;
		if (num_attrib == 0) {
			conv->mismatched = 0;
			conv->attributes = NULL;
		}
		else {
			/* Only eif_malloc memory and process if the object has attributes. */
			long att_type;

			attributes = (attribute_detail *)
					eif_rt_xmalloc (num_attrib * sizeof (attribute_detail), C_T, GC_OFF);
			if (attributes == NULL)
				xraise (EN_MEM);
			conv->attributes = attributes;

			for (j=num_attrib-1; j>=0; j--) {
				if (idr_read_line (r_buffer, bsize) == 0) {
					eif_rt_xfree ((char *) attributes);
					eise_io ("Independent retrieve: unable to read attribute description.");
				}
				if (sscanf (r_buffer," %lu %s", &att_type, vis_name) != 2) {
					eif_rt_xfree ((char *) attributes);
					eise_io ("Independent retrieve: unable to read attribute description.");
				}
				if (att_type == SK_BIT)
					eraise ("BIT type unsupported", EN_RETR);
				attributes[j].name = (char *) eif_rt_xmalloc (strlen (vis_name) +1, C_T, GC_OFF);
				if (attributes[j].name == NULL)
					xraise (EN_MEM);
				else
					strcpy (attributes[j].name, vis_name);
				attributes[j].basic_type = att_type;
				attributes[j].types = NULL;
				attributes[j].new_index = find_attribute (new_dtype, vis_name, att_type, NULL);
			}
		}

		/* Determine if every attribute in new type has match in old type */
		if (new_dtype != -1) {
			for (j=0; j<System (new_dtype).cn_nbattr; j++) {
				int found = 0;
				long k;
				for (k=0; k<num_attrib && !found; k++)
					found = (attributes[k].new_index == j);
				if (!found) {
#ifdef RECOVERABLE_DEBUG
					printf ("        %s: %s (--ADDED--)\n", System (new_dtype).cn_names[j],
							type2name (System (new_dtype).cn_types[j]));
#endif
					conv->mismatched = 1;
					break;
				}
			}
		}
#ifdef RECOVERABLE_DEBUG
		if (num_attrib > 0) {
			printf ("    ordering [");
			for (j=0; j< num_attrib; j++)
				printf ("%s%d", j==0 ? "" : ", ", attributes[j].new_index);
			printf ("]%s\n", conv->mismatched ? " (MISMATCHED)" : "");
		}
#endif
	}
	eif_rt_xfree (r_buffer);
	r_buffer = (char*) 0;
	expop (&eif_stack);
}

rt_private int16 map_generics (struct cecil_info *info, int16 count, int32 *generics)
{
	int16 result = TYPE_NOT_PRESENT;
	int i;
	/* For each set of generic parameters in the list... */
	for (i=0; (unsigned int) info->patterns[i] != SK_INVALID; i+=count) {
		int matched = 1;
		int k;
		for (k=0; k<count && matched; k++) {
			/* Compare each generic parameter of current type against each
			 * tuple value of the candidate type.
			 */
			int32 otype = generics[k];
			int32 ntype = info->patterns[i+k];
			if (((ntype & SK_HEAD) == SK_EXP) && ((otype & SK_HEAD) == SK_EXP)) {
				type_descriptor *t = NULL;
				if (type_defined ((int16) (otype & SK_DTYPE)))
					t = type_description (otype & SK_DTYPE);
				if (t != NULL && t->new_type >= 0)
					matched = (t->new_type == (ntype & SK_DTYPE));
				else {
					matched = 0;
					result = TYPE_UNRESOLVED_GENERIC;
				}
			} else {
				matched = (ntype == otype);
			}
		}
		if (matched) {					/* We found the type */
			int type_index = i / count;
			result = info->dynamic_types[type_index];
			break;
		}
	}
	return result;
}

/* Map the type from the storing system, described by `conv', to a type in
 * the retrieving system. Returns non-zero if the mapping of the type was
 * changed. If an unresolved generic type was found, the value at
 * `unresolved' is incremented.
 */
rt_private int map_type (type_descriptor *conv, int *unresolved)
{
	RT_GET_CONTEXT
	int result = 0;
	char *name = class_translation_lookup (conv->name);
	struct cecil_info *ginfo = cecil_info (conv, name); 
	if (ginfo != NULL && ginfo->nb_param == conv->generic_count) {
		if (ginfo->nb_param > 0) {
			/* Generic class in storing and retrieving systems */
			int16 orig_value = conv->new_type;
			conv->new_type = map_generics (ginfo, conv->generic_count, conv->generics);
			if (conv->new_type != orig_value) {
				result = 1;
			}
			if (conv->new_type == TYPE_UNRESOLVED_GENERIC) {
				(*unresolved)++;
			}
		} else {
			conv->new_type = ginfo->dynamic_type;
			result = 1;
		}
	} else if (ginfo == NULL) {
		if (strchr (name, '[') != NULL) {
			int16 new_id = eif_type_id (name);
			if (new_id == -1)
				conv->new_type = TYPE_NOT_PRESENT;
			else {
				conv->new_dftype = new_id;
				conv->new_type = Deif_bid (new_id);
			}
		} else {
				/* If we are here type was not found in current system. */
			conv->new_type = TYPE_NOT_PRESENT;
		}
		result = 1;
	} else {
		conv->new_type = TYPE_NOT_PRESENT;
		result = 1;
	}
	if (result && conv->new_type >= 0)
		dtypes[conv->old_type] = conv->new_type;

#ifdef RECOVERABLE_DEBUG
	if (result) {
		printf ("Type %d %s", (int) conv->old_type, conv->name);
		if (conv->generic_count > 0) {
			printf (" ");
			print_old_generic_names (conv->generics, conv->generic_count);
		}
		if (conv->new_type == TYPE_NOT_PRESENT)
			printf (" -> NOT IN SYSTEM");
		else if (conv->new_type >= 0) {
			printf (" -> %d %s", (int) conv->new_type, eif_typename (conv->new_type));
			if (ginfo != NULL && ginfo->nb_param > 0) {
				printf (" ");
				print_generic_names (ginfo, conv->new_type);
			}
		}
		printf ("\n");
	}
#endif
	return result;
}

/* Attempt to resolve types in storing system by finding the corresponding
 * type in the retrieving (i.e. current) system. Because some generic types
 * cannot be resolved until other types are resolved, we continue to make
 * passes until either all generic types are resolved or no further
 * mappings could be made.
 */
rt_private void map_types (void)
{
	RT_GET_CONTEXT
	int map_count, unresolved_types;
#ifdef RECOVERABLE_DEBUG
	printf ("-- Mapping types\n");
#endif
	REQUIRE ("Finite types", type_conversions->count > 0);
	do {
		int i;
		for (unresolved_types=0, map_count = 0, i=0; i<type_conversions->count; i++) {
			type_descriptor *conv = type_conversions->descriptions + i;
			CHECK ("Old type known", conv->old_type >= 0);
			if (conv->new_type < 0 && conv->new_type != TYPE_NOT_PRESENT)
				map_count += map_type (conv, &unresolved_types);
		}
	} while (unresolved_types > 0 && map_count > 0);
}

rt_private void check_mismatch (type_descriptor *t)
{
	int i;
		/* Generate mismatch error when retrieving an old TUPLE specification
		 * which has attributes in a system with the new TUPLE specification with
		 * no attributes */
	if
		((Deif_bid(t->new_type) == egc_tup_dtype) &&
		 (System(t->new_type).cn_nbattr != t->attribute_count))
	{
		t->mismatched = 1;
	}
	/* Determine if every attribute in new type has match in old type */
	for (i=0; i<System (t->new_type).cn_nbattr; i++) {
		int found = 0;
		int k;
		for (k = 0; k < t->attribute_count && !found; k++)
			found = (t->attributes[k].new_index == i);
		if (!found) {
			t->mismatched = 1;
#ifdef RECOVERABLE_DEBUG
			printf ("      + %s: ", System (t->new_type).cn_names[i]);
			print_attribute_type (System (t->new_type).cn_gtypes[i]+1);
			printf ("\n");
#endif
		}
	}
}

rt_private void map_type_attributes (type_descriptor *t)
{
	int i;
#ifdef RECOVERABLE_DEBUG
	printf ("Type %d %s, %d attribute%s\n",
			t->new_type, eif_typename (t->new_type),
			t->attribute_count, t->attribute_count != 1 ? "s" : "");
#endif

	for (i=0; i<t->attribute_count; i++) {
		attribute_detail *a = t->attributes + i;
		a->new_index = find_attribute (t->new_type, a->name, a->basic_type, a->types);
	}

	check_mismatch (t);

#ifdef RECOVERABLE_DEBUG
	if (t->attribute_count > 0) {
		printf ("    ordering [");
		for (i=0; i<t->attribute_count; i++)
			printf ("%s%d", i==0 ? "" : ", ", t->attributes[i].new_index);
		printf ("]%s\n", t->mismatched ? " (MISMATCHED)" : "");
	}
#endif
}

rt_private void map_attributes (void)
{
	RT_GET_CONTEXT
	int i;
#ifdef RECOVERABLE_DEBUG
	printf ("-- Mapping attributes\n");
#endif
	for (i=0; i<type_conversions->count; i++) {
		type_descriptor *t = type_conversions->descriptions + i;
		if (t->new_type >= 0)
			map_type_attributes (t);
	}
}

rt_private void rread_attribute (attribute_detail *a)
{
	int16 name_length;
	int16 num_atypes;
	char basic_type;

	/* Read attribute name */
	ridr_multi_int16 (&name_length, 1);
	a->name = (char *) eif_rt_xmalloc (name_length + 1, C_T, GC_OFF);
	if (a->name == NULL)
		xraise (EN_MEM);
	ridr_multi_char ((EIF_CHARACTER *) a->name, name_length);
	a->name[name_length] = '\0';

	/* Reader attribute basic type */
	ridr_multi_char ((EIF_CHARACTER *) &basic_type, 1);
	a->basic_type = ((uint32) basic_type << 24);
	if (a->basic_type == SK_BIT)
		eraise ("BIT type unsupported", EN_RETR);

	/* Reader attribute type array */
	ridr_multi_int16 (&num_atypes, 1);
	a->types = (int16 *) cmalloc ((num_atypes + 1) * sizeof (int16));
	if (a->types == NULL)
		xraise (EN_MEM);
	ridr_multi_int16 (a->types, num_atypes);
	a->types[num_atypes] = TERMINATOR;

#ifdef RECOVERABLE_DEBUG
	printf ("        %s: ", a->name);
	print_old_attribute_type (a->types);
	printf ("\n");
#endif
}

rt_private void rread_type (int type_index)
{
	RT_GET_CONTEXT
	char *vis_name;
	type_descriptor *conv;
	int16 nb_gen, num_attrib, name_length, dtype;
	int32 flags;

	ridr_multi_int16 (&name_length, 1);
	vis_name = (char *) eif_rt_xmalloc (name_length + 1, C_T, GC_OFF);
	if (vis_name == NULL)
		xraise (EN_MEM);
	ridr_multi_char ((EIF_CHARACTER *) vis_name, name_length);
	vis_name[name_length] = '\0';
	if (rt_kind_version >= INDEPENDENT_STORE_5_5) {
		ridr_multi_int32 (&flags, 1);
	} else {
			/* Old storable did not save this information, we default to `0', meaning
			 * that all retrieved types will be looked up first in the reference
			 * tables, and if not found in the expanded one.
			 */
		flags = 0;
	}
	ridr_multi_int16 (&dtype, 1);
	ridr_multi_int16 (&nb_gen, 1);

	type_conversions->type_index[dtype] = type_index;
	conv = type_conversions->descriptions + type_index;
	CHECK ("Not yet defined", conv->new_type == TYPE_UNDEFINED);
	conv->name = vis_name;
	conv->flags = flags;
	conv->old_type = dtype;

	/* Determine dynamic type in current system corresponding to type
	 * in storing system */
	if (nb_gen > 0) {
		conv->generics = (int32 *) eif_rt_xmalloc (nb_gen * sizeof (int32), C_T, GC_OFF);
		if (conv->generics == NULL)
			xraise (EN_MEM);
		conv->generic_count = nb_gen;
		ridr_multi_int32 (conv->generics, nb_gen);
		if (rt_kind_version < INDEPENDENT_STORE_5_5) {
				/* Convert SK_DTYPE usage by SK_REF */
			int i;
			for (i = 0; i < nb_gen; i++) {
				if (conv->generics [i] == SK_DTYPE) {
					conv->generics [i] = SK_REF;
				}
			}
		}
	}
	ridr_multi_int16 (&num_attrib, 1);
	conv->attribute_count = num_attrib;

#ifdef RECOVERABLE_DEBUG
	printf ("Type %d %s%s", (int) dtype, vis_name, nb_gen > 0 ? " " : "");
	if (nb_gen > 0)
		print_old_generic_names (conv->generics, conv->generic_count);
	printf (", %d attribute%s\n", num_attrib, num_attrib != 1 ? "s" : "");
#endif

	if (num_attrib > 0) {
		int i;
		attribute_detail *attributes = (attribute_detail *)
				eif_rt_xmalloc (num_attrib * sizeof (attribute_detail), C_T, GC_OFF);
		if (attributes == NULL)
			xraise (EN_MEM);
		conv->attributes = attributes;

		for (i=0; i<num_attrib; i++)
			rread_attribute (attributes + i);
	}
}

rt_private void rread_header (EIF_CONTEXT_NOARG)
{
	/* Read header and make the dynamic type correspondance table */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	int16 ohead, old_max_types, type_count, i;
	jmp_buf exenv;
#ifdef ISE_GC
	volatile char g_status = rt_g_data.status;
#endif
	RTXD;

	errno = 0;

	excatch (&exenv);	/* Record pseudo execution vector */
	if (setjmp (exenv)) {
		rt_clean ();			/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
#ifdef ISE_GC
		rt_g_data.status = g_status;		/* If a crash occurs, since we may disable the GC in the
										 * code below, we need to make sure to restore the status
										 * to what it originally was. */
#endif
		ereturn (MTC_NOARG);	/* Propagate exception */
	}

	ridr_multi_int16 (&ohead, 1);
	old_overhead = ohead;
	ridr_multi_int16 (&old_max_types, 1);
	ridr_multi_int16 (&type_count, 1);
#ifdef RECOVERABLE_DEBUG
	printf ("-- Reading header: %d types\n", type_count);
#endif

			/* We need to make sure that `dtypes' and `spec_elm_size' arrays are large enough
			 * to store all types in retrieving system. */
	if (old_max_types < eif_par_table2_size) {
			/* We use `eif_par_table2_size' as it will give us a correct size in
			 * both workbench/melted/finalized mode of the number of dynamic types
			 * FIXME: Manu 06/24/2004: Maybe we ought to have a query that would
			 * represent this value without being specific to generic conformance. */
		old_max_types = eif_par_table2_size + 1;
	}

	spec_elm_size = (uint32 *) eif_rt_xmalloc (old_max_types * sizeof (uint32), C_T, GC_OFF);
	if (spec_elm_size == NULL)
		xraise (EN_MEM);

	/* create a correspondance table, still needed by rt_id_read_cid() */
	dtypes = (int *) eif_rt_xmalloc (old_max_types * sizeof(int), C_T, GC_OFF);
	if (dtypes == NULL)
		xraise (EN_MEM);

	type_conversions = new_type_conversion_table (old_max_types, type_count);

	for (i=0; i<type_count; i++)
		rread_type (i);

	if (rt_kind_version < INDEPENDENT_STORE_5_5) {
			/* Store basic type information. */
		dtypes[egc_bool_dtype] = egc_bool_dtype;
		dtypes[egc_int8_dtype] = egc_int8_dtype;
		dtypes[egc_int16_dtype] = egc_int16_dtype;
		dtypes[egc_int32_dtype] = egc_int32_dtype;
		dtypes[egc_int64_dtype] = egc_int64_dtype;
		dtypes[egc_real32_dtype] = egc_real32_dtype;
		dtypes[egc_real64_dtype] = egc_real64_dtype;
		dtypes[egc_char_dtype] = egc_char_dtype;
		dtypes[egc_wchar_dtype] = egc_wchar_dtype;
		dtypes[egc_point_dtype] = egc_point_dtype;
	}

	map_types ();
	map_attributes ();

	expop (&eif_stack);
}

rt_private size_t readline (register char *ptr, size_t maxlen)
{
	size_t num_char = 1;
	char c;

	for (; num_char < maxlen; num_char++) {
		buffer_read (&c, sizeof(char));
		*ptr++ = c;
		if (c == '\n') {
			break;
		}
	}
	*ptr = '\0';
	return num_char;
}
		
rt_private void buffer_read (register char *ptr, size_t size)
{
	RT_GET_CONTEXT
	size_t l_cur_pos = current_position;
	size_t l_end_of_buffer = end_of_buffer;

	REQUIRE("ptr_not_null", ptr);
	REQUIRE("size_positive", size > 0);

	while (size > 0) {
		if (l_cur_pos + size > l_end_of_buffer) {
			if (l_end_of_buffer > 0) {
				size_t l_padding = l_end_of_buffer - l_cur_pos;
				memcpy (ptr, general_buffer + l_cur_pos, l_padding);
				size -= l_padding;
				ptr += l_padding;
			}
				/* Load remaing bytes in `general_buffer'. */
			l_end_of_buffer = retrieve_read_func ();
			end_of_buffer = l_end_of_buffer;
			l_cur_pos = 0;
			if (l_end_of_buffer == 0) {
				eraise("incomplete file" , EN_RETR);
			}
		} else {
			memcpy (ptr, general_buffer + l_cur_pos, size);
			l_cur_pos += size;
				/* No need to continue here as we could read it all. */
			break;
		}
	}
	current_position = l_cur_pos;
}

rt_public size_t retrieve_read (void)
{
	RT_GET_CONTEXT
	char * ptr = general_buffer;
	int read_size;
	int part_read = 0;

	if ((char_read_func ((char *)&read_size, sizeof (short))) < sizeof (short))
		eise_io("Retrieve: unable to read buffer size.");
	CHECK("read_size_positive", read_size > 0);

	while (read_size > 0) {
		part_read = char_read_func (ptr, read_size);
		if (part_read <= 0) {
				/* If we read 0 bytes, it means that we reached the end of file,
				 * so we are missing something, instead of going further we stop */
			eio();
		}
		read_size -= part_read;
		ptr += part_read;
	}
	return read_size;
}

rt_public size_t retrieve_read_with_compression (void)
{
	RT_GET_CONTEXT
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
		if (part_read <= 0) {
				/* If we read 0 bytes, it means that we reached the end of file,
				 * so we are missing something, instead of going further we stop */
			eio();
		}
		read_size -= part_read;
		ptr += part_read;
	}
	
	dcmps_in_ptr = cmps_general_buffer;
	dcmps_out_ptr = general_buffer;
	
	eif_decompress ((unsigned char*)dcmps_in_ptr,
					(unsigned long)dcmps_in_size,
					(unsigned char*)dcmps_out_ptr,
					(unsigned long*)&dcmps_out_size);
	
	CHECK("dcmps_out_size_positive", dcmps_out_size > 0);
	return dcmps_out_size;
}

/*
doc:	<routine name="gen_object_read" export="private">
doc:		<summary>Retrieve content of `object' whose flags are `nflags'. The reason why we don't query the header of `object' is that in some cases `object' may have no header (e.g. an expanded without references in a special object). Version for general store.</summary>
doc:		<param name="object" type="EIF_REFERENCE">Object for which we are retrieving data.</param>
doc:		<param name="parent" type="EIF_REFERENCE">If `object' is expanded, then `parent' correspond to the object containing `object'. Otherwise `parent' is identical to `object'.</param>
doc:		<param name="nflags" type="uint32">Flags of `object'.</param>
doc:		<thread_safety>Safe using thread safe routines and per thread data.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_private void gen_object_read (EIF_REFERENCE object, EIF_REFERENCE parent, uint32 nflags)
{
	RT_GET_CONTEXT
	long attrib_offset;
	uint32 o_type;
	uint32 num_attrib;
	uint32 flags;

	flags = Mapped_flags(nflags);
	o_type = flags & EO_TYPE;
	num_attrib = System(o_type).cn_nbattr;

	if (num_attrib > 0) {
		for (; num_attrib > 0;) {
			uint32 types_cn;

			num_attrib--;
			attrib_offset = get_alpha_offset(o_type, num_attrib);
			types_cn = *(System(o_type).cn_types + num_attrib);

			switch (types_cn & SK_HEAD) {
				case SK_UINT8: buffer_read(object + attrib_offset, sizeof(EIF_NATURAL_8)); break;
				case SK_UINT16: buffer_read(object + attrib_offset, sizeof(EIF_NATURAL_16)); break;
				case SK_UINT32: buffer_read(object + attrib_offset, sizeof(EIF_NATURAL_32)); break;
				case SK_UINT64: buffer_read(object + attrib_offset, sizeof(EIF_NATURAL_64)); break;
				case SK_INT8: buffer_read(object + attrib_offset, sizeof(EIF_INTEGER_8)); break;
				case SK_INT16: buffer_read(object + attrib_offset, sizeof(EIF_INTEGER_16)); break;
				case SK_INT32: buffer_read(object + attrib_offset, sizeof(EIF_INTEGER_32)); break;
				case SK_INT64: buffer_read(object + attrib_offset, sizeof(EIF_INTEGER_64)); break;
				case SK_WCHAR: buffer_read(object + attrib_offset, sizeof(EIF_WIDE_CHAR)); break;
				case SK_REAL32: buffer_read(object + attrib_offset, sizeof(EIF_REAL_32)); break;
				case SK_REAL64: buffer_read(object + attrib_offset, sizeof(EIF_REAL_64)); break;
				case SK_BOOL:
				case SK_CHAR:
					buffer_read(object + attrib_offset, sizeof(EIF_CHARACTER));
					break;
				case SK_BIT:
						{
							/* int q; */ /* %%ss removed */
							uint32 old_flags, hflags;
							struct bit *bptr = (struct bit *)(object + attrib_offset);

							HEADER(bptr)->ov_flags = egc_bit_dtype;
							buffer_read((char *)&old_flags, sizeof(uint32));
							hflags = rt_read_cid (old_flags);
							HEADER(bptr)->ov_flags = hflags & (EO_COMP | EO_REF);

							buffer_read((char *) bptr, bptr->b_length);
							if ((types_cn & SK_DTYPE) != LENGTH(bptr))
								eise_io("General retrieve: mismatch size for BIT object.");
						}

					break;
				case SK_EXP: {
					uint32  old_flags, hflags;
					EIF_REFERENCE l_buffer [1];

					buffer_read((char *) l_buffer, sizeof(EIF_REFERENCE));
					buffer_read((char *) &old_flags, sizeof(uint32));
					hflags = rt_read_cid (old_flags);

						/* No need to set `ov_size' or `ov_flags' as it is done while creating
						 * the object */
					gen_object_read (object + attrib_offset, parent, hflags);

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
			EIF_REFERENCE ref, o_ptr;

			o_ptr = RT_SPECIAL_INFO(object);
			count = RT_SPECIAL_COUNT_WITH_INFO(o_ptr);

			if (flags & EO_TUPLE) {
				buffer_read(object, count * sizeof(EIF_TYPED_ELEMENT));
			} else if (!(flags & EO_REF)) {			/* Special of simple types */
				uint32 dgen;
				dgen = special_generic_type (o_type);
				switch (dgen & SK_HEAD) {
					case SK_UINT8: buffer_read(object, count*sizeof(EIF_NATURAL_8)); break;
					case SK_UINT16: buffer_read(object, count*sizeof(EIF_NATURAL_16)); break;
					case SK_UINT32: buffer_read(object, count*sizeof(EIF_NATURAL_32)); break;
					case SK_UINT64: buffer_read(object, count*sizeof(EIF_NATURAL_64)); break;
					case SK_INT8: buffer_read(object, count*sizeof(EIF_INTEGER_8)); break;
					case SK_INT16: buffer_read(object, count*sizeof(EIF_INTEGER_16)); break;
					case SK_INT32: buffer_read(object, count*sizeof(EIF_INTEGER_32)); break;
					case SK_INT64: buffer_read(object, count*sizeof(EIF_INTEGER_64)); break;
					case SK_BOOL:
					case SK_CHAR:
						buffer_read(object, count*sizeof(EIF_CHARACTER));
						break;
					case SK_WCHAR: buffer_read(object, count*sizeof(EIF_WIDE_CHAR)); break;
					case SK_REAL32: buffer_read(object, count*sizeof(EIF_REAL_32)); break;
					case SK_REAL64: buffer_read(object, count*sizeof(EIF_REAL_64)); break;
					case SK_EXP: {
						uint32 old_flags, hflags;

						elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ptr);
						buffer_read((char *) &old_flags, sizeof(uint32));
						hflags = rt_read_cid (old_flags);
#ifdef WORKBENCH
						ref = object + OVERHEAD;
#else
						ref = object;
#endif
						for (; count > 0; count --, ref += elem_size) {
#ifdef WORKBENCH
							HEADER(ref)->ov_flags = (hflags & (EO_REF|EO_EXP|EO_COMP|EO_TYPE));
							HEADER(ref)->ov_size = (uint32)(ref - parent);
#endif
							gen_object_read (ref, parent, hflags);						
						}
						}
						break;
					case SK_BIT: {
						/* uint32 l;*/ /* %%ss removed */

						elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ptr);
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
					hflags = rt_read_cid (old_flags);
					elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ptr);
					for (ref = object + OVERHEAD; count > 0; count --, ref += elem_size) {
						HEADER(ref)->ov_flags = (hflags & (EO_REF|EO_COMP|EO_TYPE));
						HEADER(ref)->ov_size = (uint32)(ref - parent);
						gen_object_read (ref, parent, hflags);
					}
				}
			}
		} 
	}
}

/*
doc:	<routine name="object_read" export="private">
doc:		<summary>Retrieve content of `object' whose flags are `nflags'. The reason why we don't query the header of `object' is that in some cases `object' may have no header (e.g. an expanded without references in a special object). Version for independent store.</summary>
doc:		<param name="object" type="EIF_REFERENCE">Object for which we are retrieving data.</param>
doc:		<param name="parent" type="EIF_REFERENCE">If `object' is expanded, then `parent' correspond to the object containing `object'. Otherwise `parent' is identical to `object'.</param>
doc:		<param name="nflags" type="uint32">Flags of `object'.</param>
doc:		<thread_safety>Safe using thread safe routines and per thread data.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_private void object_read (EIF_REFERENCE object, EIF_REFERENCE parent, uint32 nflags)
{
	RT_GET_CONTEXT
#if DEBUG & 1
	int z;
#endif
	long attrib_offset;
	uint32 o_type;
	uint32 num_attrib;
	uint32 flags;
	int *attrib_order;

	flags = Mapped_flags(nflags);
	o_type = flags & EO_TYPE;
	num_attrib = System(o_type).cn_nbattr;
	attrib_order = dattrib[o_type];

	if (num_attrib > 0) {
		for (; num_attrib > 0;) {
			uint32 types_cn;

			num_attrib--;

			attrib_offset = get_offset(o_type, attrib_order[num_attrib]);
			types_cn = *(System(o_type).cn_types + num_attrib);

			switch (types_cn & SK_HEAD) {
					/* FIXME: Manu: the following 4 entries are meaningless but are there for consistency,
					 * that is to say each time we manipulate the signed SK_INTXX we need to manipulate the
					 * unsigned SK_UINTXX too. */
				case SK_UINT8: ridr_multi_int8 ((EIF_NATURAL_8 *) (object + attrib_offset), 1); break;
				case SK_UINT16: ridr_multi_int16 ((EIF_NATURAL_16 *) (object + attrib_offset), 1); break;
				case SK_UINT32: ridr_multi_int32 ((EIF_NATURAL_32 *) (object + attrib_offset), 1); break;
				case SK_UINT64: ridr_multi_int64 ((EIF_NATURAL_64 *) (object + attrib_offset), 1); break;
				case SK_INT8: ridr_multi_int8 ((EIF_INTEGER_8 *) (object + attrib_offset), 1); break;
				case SK_INT16: ridr_multi_int16 ((EIF_INTEGER_16 *) (object + attrib_offset), 1); break;
				case SK_INT32: ridr_multi_int32 ((EIF_INTEGER_32 *) (object + attrib_offset), 1); break;
				case SK_INT64: ridr_multi_int64 ((EIF_INTEGER_64 *) (object + attrib_offset), 1); break;
				case SK_BOOL:
				case SK_CHAR:
					ridr_multi_char ((EIF_CHARACTER *) (object + attrib_offset), 1); break;
				case SK_WCHAR: ridr_multi_int32 ((EIF_INTEGER_32 *) (object + attrib_offset), 1); break;
				case SK_REAL32: ridr_multi_float ((EIF_REAL_32 *) (object + attrib_offset), 1); break;
				case SK_REAL64: ridr_multi_double ((EIF_REAL_64 *) (object + attrib_offset), 1); break;
				case SK_BIT:
						{
#if DEBUG & 1
							int q;
#endif
							uint32 old_flags, hflags;
							struct bit *bptr = (struct bit *)(object + attrib_offset);

							HEADER(bptr)->ov_flags = egc_bit_dtype;
							ridr_norm_int (&old_flags);
							hflags = rt_id_read_cid (old_flags);
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
					EIF_REFERENCE l_buffer [1];

					ridr_multi_any ((char *) l_buffer, 1);
					ridr_norm_int (&old_flags);
					hflags = rt_id_read_cid (old_flags);

#if DEBUG & 1
					printf ("\n %lx", *((EIF_REFERENCE *)(object + attrib_offset)));
					printf (" %lx", old_flags);
#endif
						/* No need to set `ov_size' or `ov_flags' as it is done while creating
						 * the object */
					object_read (object + attrib_offset, parent, hflags);

					}
					break;
				case SK_REF:
					ridr_multi_any (object + attrib_offset, 1);
#if DEBUG & 1
					printf (" %lx", *((EIF_REFERENCE *)(object + attrib_offset)));
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
			EIF_REFERENCE ref, o_ptr;

			o_ptr = RT_SPECIAL_INFO(object);
			count = RT_SPECIAL_COUNT_WITH_INFO(o_ptr);
	
			if (flags & EO_TUPLE) {
				object_rread_tuple(object, count);
			} else if (!(flags & EO_REF)) {			/* Special of simple types */
				uint32 dgen;
				dgen = special_generic_type (o_type);
				switch (dgen & SK_HEAD) {
						/* FIXME: Manu: the following 4 entries are meaningless but are there for consistency,
						 * that is to say each time we manipulate the signed SK_INTXX we need to manipulate the
						 * unsigned SK_UINTXX too. */
					case SK_UINT8: ridr_multi_int8 ((EIF_NATURAL_8 *) object, count); break;
					case SK_UINT16: ridr_multi_int16 ((EIF_NATURAL_16 *) object, count); break;
					case SK_UINT32: ridr_multi_int32 ((EIF_NATURAL_32 *) object, count); break;
					case SK_UINT64: ridr_multi_int64 ((EIF_NATURAL_64 *) object, count); break;
					case SK_INT8: ridr_multi_int8 ((EIF_INTEGER_8 *)object, count); break;
					case SK_INT16: ridr_multi_int16 ((EIF_INTEGER_16 *)object, count); break;
					case SK_INT32: ridr_multi_int32 ((EIF_INTEGER_32 *)object, count); break;
					case SK_INT64: ridr_multi_int64 ((EIF_INTEGER_64 *)object, count); break;
					case SK_BOOL:
					case SK_CHAR: ridr_multi_char ((EIF_CHARACTER *) object, count); break;
					case SK_WCHAR: ridr_multi_int32 ((EIF_INTEGER_32 *) object, count); break;
					case SK_REAL32: ridr_multi_float ((EIF_REAL_32 *)object, count); break;
					case SK_REAL64: ridr_multi_double ((EIF_REAL_64 *)object, count); break;
					case SK_EXP: {
						uint32  old_flags, hflags;

						elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ptr);
						ridr_norm_int (&old_flags);
						hflags = rt_id_read_cid (old_flags);
#ifdef WORKBENCH
						ref = object + OVERHEAD;
#else
						ref = object;
#endif
						for (ref = object + OVERHEAD; count > 0; count --, ref += elem_size) {
#ifdef WORKBENCH
							HEADER(ref)->ov_flags = (hflags & (EO_REF|EO_EXP|EO_COMP|EO_TYPE));
							HEADER(ref)->ov_size = (uint32)(ref - parent);
#endif
							object_read (ref, parent, hflags);
						}
					}
						break;
					case SK_BIT: 
						elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ptr);
						ridr_multi_bit ((struct bit *)object, count, elem_size);
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
				} else {						/* Special of composites */
					uint32  old_flags, hflags;

					ridr_norm_int (&old_flags);
					hflags = rt_read_cid (old_flags);
					elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ptr);
					for (ref = object + OVERHEAD; count > 0; count --, ref += elem_size) {
						HEADER(ref)->ov_flags = (hflags & (EO_REF|EO_COMP|EO_TYPE));
						HEADER(ref)->ov_size = (uint32)(ref - parent);
						object_read (ref, parent, hflags);
					}
				}
			}
		} 
	}
}

/*
doc:	<routine name="object_rread_attributes" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Read a non-special object, of type in storing system described by `old_flags', into `object' (possibly offset by `expanded_offset' if object is expanded) of type `new_flags'. Version for recoverable storable. If a mismatch occur, then return type contains a SPECIAL instances with the attributes that were not put into `object'.</summary>
doc:		<param name="object" type="EIF_REFERENCE">Object for which we are retrieving data.</param>
doc:		<param name="new_flags" type="uint32">New flags of `object' in retrieving system.</param>
doc:		<param name="old_flags" type="uint32">Flags of `object' in storing system.</param>
doc:		<param name="expanded_offset" type="long">Offset in `object' from where data should be retrieved.</param>
doc:		<return>NULL when there is no mismatch, otherwise a SPECIAL containing the old data for the `object' in the storing system.<return>
doc:		<thread_safety>Safe using thread safe routines and per thread data.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_private EIF_REFERENCE object_rread_attributes (
		EIF_REFERENCE object, uint32 new_flags, uint32 old_flags, long expanded_offset)
{
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	EIF_REFERENCE result = NULL;
	EIF_REFERENCE old_values = NULL;
	EIF_REFERENCE comp_values = NULL;
	type_descriptor *conv = type_description (old_flags & EO_TYPE);
	attribute_detail *attributes = conv->attributes;
	uint32 num_attrib = conv->attribute_count;
	uint32 new_type = conv->new_type;
	uint32 new_num_attrib;
	int mismatched = object != NULL && conv->mismatched;
	int i;

	if (num_attrib == 0)
		return NULL;		/* Nothing to read if no attributes */

#ifdef ISE_GC
	REQUIRE ("No GC", rt_g_data.status & GC_STOP);
#endif
	REQUIRE ("Attribute order exists", attributes != NULL);
	REQUIRE ("Offset only for expanded", object == NULL  ||
			(new_flags & EO_EXP) || expanded_offset == 0);

#ifdef RECOVERABLE_DEBUG
	if (expanded_offset > 0)
		print_object_summary ("      ", object, expanded_offset, old_flags);
#endif

	if (conv->new_type >= 0) {
		new_num_attrib = System (new_type).cn_nbattr;
	} else {
			/* Old type is not found in current system, so it is
			 * as if there were no attributes. */
		new_num_attrib = 0;
	}

	RT_GC_PROTECT(object);
	if (mismatched) {
		old_values = new_spref (num_attrib);
		RT_GC_PROTECT(old_values);
		if (new_flags & EO_COMP) {
			comp_values = new_spref (new_num_attrib + 1);
			RT_GC_PROTECT(comp_values);
			((EIF_REFERENCE *) comp_values)[new_num_attrib] = old_values;
			RTAR (comp_values, old_values);
		}
	}

	for (i=num_attrib - 1; i >= 0; i--) {
		multi_value value;
		uint32 old_attrib_type = attributes[i].basic_type;
		int new_attrib_index = attributes[i].new_index;
		EIF_REFERENCE old_value = NULL;
		void *attr_address = NULL;
		long attrib_offset = 0;

		if (object != NULL && new_attrib_index != -1) {
			char *obj_address = (char *) object + expanded_offset;
			attrib_offset = get_offset (new_type, new_attrib_index);
			attr_address = obj_address + attrib_offset;
		}

		switch (old_attrib_type & SK_HEAD) {
				/* FIXME: Manu: the following 4 entries are meaningless but are there for consistency,
				 * that is to say each time we manipulate the signed SK_INTXX we need to manipulate the
				 * unsigned SK_UINTXX too. */
			case SK_UINT8:
				ridr_multi_int8 (&value.vuint8, 1);
				if (attr_address != NULL)
					*(EIF_NATURAL_8 *) attr_address = value.vuint8;
				if (mismatched) {
					old_value = RTLN (egc_int8_ref_dtype);
					*(EIF_NATURAL_8 *) old_value = value.vuint8;
				}
				break;
			case SK_UINT16:
				ridr_multi_int16 (&value.vuint16, 1);
				if (attr_address != NULL)
					*(EIF_NATURAL_16 *) attr_address = value.vuint16;
				if (mismatched) {
					old_value = RTLN (egc_int16_ref_dtype);
					*(EIF_NATURAL_16 *) old_value = value.vuint16;
				}
				break;
			case SK_UINT32:
				ridr_multi_int32 (&value.vuint32, 1);
				if (attr_address != NULL)
					*(EIF_NATURAL_32 *) attr_address = value.vuint32;
				if (mismatched) {
					old_value = RTLN (egc_int32_ref_dtype);
					*(EIF_NATURAL_32 *) old_value = value.vuint32;
				}
				break;
			case SK_UINT64:
				ridr_multi_int64 (&value.vuint64, 1);
				if (attr_address != NULL)
					*(EIF_NATURAL_64 *) attr_address = value.vuint64;
				if (mismatched) {
					old_value = RTLN (egc_int64_ref_dtype);
					*(EIF_NATURAL_64 *) old_value = value.vuint64;
				}
				break;
			case SK_INT8:
				ridr_multi_int8 (&value.vint8, 1);
				if (attr_address != NULL)
					*(EIF_INTEGER_8 *) attr_address = value.vint8;
				if (mismatched) {
					old_value = RTLN (egc_int8_ref_dtype);
					*(EIF_INTEGER_8 *) old_value = value.vint8;
				}
				break;
			case SK_INT16:
				ridr_multi_int16 (&value.vint16, 1);
				if (attr_address != NULL)
					*(EIF_INTEGER_16 *) attr_address = value.vint16;
				if (mismatched) {
					old_value = RTLN (egc_int16_ref_dtype);
					*(EIF_INTEGER_16 *) old_value = value.vint16;
				}
				break;
			case SK_INT32:
				ridr_multi_int32 (&value.vint32, 1);
				if (attr_address != NULL)
					*(EIF_INTEGER_32 *) attr_address = value.vint32;
				if (mismatched) {
					old_value = RTLN (egc_int32_ref_dtype);
					*(EIF_INTEGER_32 *) old_value = value.vint32;
				}
				break;
			case SK_INT64:
				ridr_multi_int64 (&value.vint64, 1);
				if (attr_address != NULL)
					*(EIF_INTEGER_64 *) attr_address = value.vint64;
				if (mismatched) {
					old_value = RTLN (egc_int64_ref_dtype);
					*(EIF_INTEGER_64 *) old_value = value.vint64;
				}
				break;
			case SK_BOOL :
				ridr_multi_char (&value.vbool, 1);
				if (attr_address != NULL)
					*(EIF_BOOLEAN *) attr_address = value.vbool;
				if (mismatched) {
					old_value = RTLN (egc_bool_ref_dtype);
					*(EIF_BOOLEAN *) old_value = value.vbool;
				}
				break;
			case SK_CHAR:
				ridr_multi_char (&value.vchar, 1);
				if (attr_address != NULL)
					*(EIF_CHARACTER *) attr_address = value.vchar;
				if (mismatched) {
					old_value = RTLN (egc_char_ref_dtype);
					*(EIF_CHARACTER *) old_value = value.vchar;
				}
				break;
			case SK_WCHAR:
				ridr_multi_int32 (&value.vint32, 1);
				if (attr_address != NULL)
					*(EIF_WIDE_CHAR *) attr_address = value.vwchar;
				if (mismatched) {
					old_value = RTLN (egc_wchar_ref_dtype);
					*(EIF_WIDE_CHAR *) old_value = value.vwchar;
				}
				break;
			case SK_REAL32:
				ridr_multi_float (&value.vreal, 1);
				if (attr_address != NULL)
					*(EIF_REAL_32 *) attr_address = value.vreal;
				if (mismatched) {
					old_value = RTLN (egc_real32_ref_dtype);
					*(EIF_REAL_32 *) old_value = value.vreal;
				}
				break;
			case SK_REAL64:
				ridr_multi_double (&value.vdbl, 1);
				if (attr_address != NULL)
					*(EIF_REAL_64 *) attr_address = value.vdbl;
				if (mismatched) {
					old_value = RTLN (egc_real64_ref_dtype);
					*(EIF_REAL_64 *) old_value = value.vdbl;
				}
				break;
			case SK_POINTER:
				ridr_multi_any ((char *) &value.vptr, 1);
				if (attr_address != NULL) {
					if (! eif_discard_pointer_values)
						*(EIF_POINTER *) attr_address = value.vptr;
				}
				if (mismatched) {
					old_value = RTLN (egc_point_ref_dtype);
					if (! eif_discard_pointer_values)
						*(EIF_POINTER *) old_value = value.vptr;
				}
				break;
			case SK_REF:
				ridr_multi_any ((char *) &value.vref, 1);
				if (attr_address != NULL)
					*(EIF_REFERENCE *) attr_address = value.vref;
				if (mismatched) {
					old_value = value.vref;
				}
				break;
			case SK_EXP: {
				uint32  o_flags, hflags;
				EIF_REFERENCE old_vals = NULL;
				EIF_REFERENCE l_buffer;
				ridr_multi_any ((char *) &l_buffer, 1);
				ridr_norm_int (&o_flags);
				hflags = rt_id_read_cid (o_flags);
				if (object == NULL) {
					old_vals = object_rread_attributes (NULL, hflags, o_flags, 0L);
					CHECK ("No mismatches", old_vals == NULL);
				}
				else {
					if (mismatched) {
						old_value =
							emalloc (type_description (o_flags & EO_TYPE)->new_type);
					}
					if (attr_address == NULL)
						old_vals = object_rread_attributes (old_value, hflags, o_flags, 0L);
					else {
						attr_address = (char *) object + expanded_offset + attrib_offset;
						old_vals = object_rread_attributes (
								object, hflags, o_flags, expanded_offset + attrib_offset);
						if (mismatched)
							ecopy (attr_address, old_value);
					}
					if (mismatched && old_vals != NULL)
						add_mismatch (old_value, old_vals);
				}
				if (attr_address != NULL && old_vals != NULL) {
					/* Expanded attribute is mismatched */
					if (comp_values == NULL) {
							/* Current composite object is not mismatched */
						comp_values = new_spref (new_num_attrib);
						RT_GC_PROTECT(comp_values);
					}
					((EIF_REFERENCE *) comp_values)[new_attrib_index] = old_vals;
					RTAR (comp_values, old_vals);
				}
				break;
			}
			default:
					/* Since an exception is being thrown make sure to free our Eiffel
					 * objects from the GC update. */
				if (comp_values) {
					RT_GC_WEAN(comp_values);
				}
				if (old_value) {
					RT_GC_WEAN(old_value);
				}
				RT_GC_WEAN(object);
				eise_io ("Recoverable retrieve: not a supported object.");
		}
		if (mismatched && old_value != NULL ) {
			((EIF_REFERENCE *) old_values)[i] = old_value;
			if ((old_attrib_type & SK_HEAD) == SK_REF) {
				update_reference (old_values, (EIF_REFERENCE *) old_values + i);
			} else {
				RTAR (old_values, old_value);
			}
		}
	}
	if (comp_values != NULL)
		result = comp_values;
	else if (old_values != NULL)
		result = old_values;

	if (comp_values) {
		RT_GC_WEAN(comp_values);
	}
	if (old_values) {
		RT_GC_WEAN(old_values);
	}
	RT_GC_WEAN (object);

	return result;
}

/* Read `count' expanded values, each of size `elem_size', into special `object'.
 */
rt_private EIF_REFERENCE object_rread_special_expanded (EIF_REFERENCE object, EIF_INTEGER count)
{
	EIF_REFERENCE result = NULL;
	EIF_INTEGER spec_size = RT_SPECIAL_ELEM_SIZE (object);
	type_descriptor *conv;
	uint32 new_type;
	uint32 old_flags, hflags, new_flags;
	int i;
#ifndef WORKBENCH
	int l_has_references;
#endif

	ridr_norm_int (&old_flags);
	hflags = rt_id_read_cid (old_flags);
	conv = type_description (old_flags & EO_TYPE);
	new_type = conv->new_type;
	new_flags = new_type | (old_flags & EO_UPPER);
	if (conv->mismatched) {
		EIF_GET_CONTEXT
		RT_GC_PROTECT(object);
		result = new_spref (count);
		RT_GC_WEAN(object);
	}
#ifndef WORKBENCH
	l_has_references = References (Deif_bid(new_type)) > 0;
#endif
	for (i=0; i<count; i++) {
		EIF_REFERENCE old_values, ref = NULL;
		long offset = 0;
		if (object != NULL) {
#ifndef WORKBENCH
			if (l_has_references) {
#endif
				offset = OVERHEAD + (i * spec_size);
				ref = (EIF_REFERENCE)((char *) object + offset);
				HEADER (ref)->ov_flags = (new_flags & (EO_REF|EO_EXP|EO_COMP|EO_TYPE));
				HEADER (ref)->ov_size = (uint32) offset;
#ifndef WORKBENCH
			} else {
				offset = i * spec_size;
			}
#endif
		}
		old_values = object_rread_attributes (object, hflags, old_flags, offset);
		if (old_values != NULL) {
			CHECK ("Mismatch consistency", old_values != NULL);
			((EIF_REFERENCE *) result)[i] = old_values;
			RTAR (result, old_values);
		}
	}
	return result;
}

/* Read a special object, of type in storing system described by `flags',
 * consisting of `count' elements, each of size `elem_size', into `object.
 */
rt_private EIF_REFERENCE object_rread_special (
		EIF_REFERENCE object, uint32 flags, uint32 count)
{
	RT_GET_CONTEXT
	EIF_REFERENCE result = NULL;
	type_descriptor *conv = type_description (flags & EO_TYPE);
	EIF_REFERENCE addr, trash = NULL;

	CHECK ("Must have generics", conv->generic_count > 0);
	if (object != NULL)
		addr = object;
	else {
		trash = (EIF_REFERENCE) eif_rt_xmalloc (count * sizeof (multi_value), C_T, GC_OFF);
		addr = trash;
	}
	if (!(flags & EO_REF)) {			/* Special of simple types */
		switch (conv->generics[0] & SK_HEAD) {
				/* FIXME: Manu: the following 4 entries are meaningless but are there for consistency,
				 * that is to say each time we manipulate the signed SK_INTXX we need to manipulate the
				 * unsigned SK_UINTXX too. */
			case SK_UINT8: ridr_multi_int8 ((EIF_NATURAL_8 *) addr, count); break;
			case SK_UINT16: ridr_multi_int16 ((EIF_NATURAL_16 *) addr, count); break;
			case SK_UINT32: ridr_multi_int32 ((EIF_NATURAL_32 *) addr, count); break;
			case SK_UINT64: ridr_multi_int64 ((EIF_NATURAL_64 *) addr, count); break;
			case SK_INT8:   ridr_multi_int8   ((EIF_INTEGER_8  *) addr, count); break;
			case SK_INT16:  ridr_multi_int16  ((EIF_INTEGER_16 *) addr, count); break;
			case SK_INT32:  ridr_multi_int32  ((EIF_INTEGER_32 *) addr, count); break;
			case SK_INT64:  ridr_multi_int64  ((EIF_INTEGER_64 *) addr, count); break;
			case SK_BOOL:
			case SK_CHAR:   ridr_multi_char   ((EIF_CHARACTER  *) addr, count); break;
			case SK_WCHAR:  ridr_multi_int32  ((EIF_INTEGER_32 *) addr, count); break;
			case SK_REAL32:  ridr_multi_float  ((EIF_REAL_32 *) addr, count); break;
			case SK_REAL64: ridr_multi_double ((EIF_REAL_64     *) addr, count); break;

			case SK_EXP:
				result = object_rread_special_expanded (object, count);
				break;

			case SK_POINTER:
				ridr_multi_any (addr, count);
				if (eif_discard_pointer_values)
					memset (addr, 0, count * sizeof (EIF_POINTER));
				break;

			default:
				eise_io ("Recoverable retrieve: unsupported object.");
				break;
		}
	}
	else if (flags & EO_COMP)		/* Special of composites */
		result = object_rread_special_expanded (object, count);
	else							/* Special of references */
		ridr_multi_any ((char *) addr, count);

	if (trash != NULL)
		eif_rt_xfree (trash);

	return result;
}

/* Read a tuple object, of type in storing system described by `flags',
 * consisting of `count' elements, each of size `elem_size', into `object.
 */
rt_private void object_rread_tuple (EIF_REFERENCE object, uint32 count)
{
	RT_GET_CONTEXT

	EIF_REFERENCE addr, trash = NULL;
	EIF_TYPED_ELEMENT *l_item;
	char l_type;

	if (object != NULL)
		addr = object;
	else {
		trash = (EIF_REFERENCE) eif_rt_xmalloc (count * sizeof (EIF_TYPED_ELEMENT), C_T, GC_OFF);
		addr = trash;
	}

	l_item = (EIF_TYPED_ELEMENT *) addr;
		/* Don't forget that first element of TUPLE is just a placeholder
		 * to avoid offset computation from Eiffel code */
	l_item++;
	count--;
	if (rt_kind_version >= INDEPENDENT_STORE_5_5) {
		for (; count > 0; count--, l_item++) {
			ridr_multi_char(&l_type, 1);
			CHECK("Same type", l_type == eif_tuple_item_type(l_item));
			switch (l_type) {
				case EIF_REFERENCE_CODE: ridr_multi_any ((char*) &eif_reference_tuple_item(l_item), 1); break;
				case EIF_BOOLEAN_CODE: ridr_multi_char (&eif_boolean_tuple_item(l_item), 1); break;
				case EIF_CHARACTER_CODE: ridr_multi_char (&eif_character_tuple_item(l_item), 1); break;
				case EIF_REAL_64_CODE: ridr_multi_double (&eif_real_64_tuple_item(l_item), 1); break;
				case EIF_REAL_32_CODE: ridr_multi_float (&eif_real_32_tuple_item(l_item), 1); break;
				case EIF_NATURAL_8_CODE: ridr_multi_int8 (&eif_natural_8_tuple_item(l_item), 1); break;
				case EIF_NATURAL_16_CODE: ridr_multi_int16 (&eif_natural_16_tuple_item(l_item), 1); break;
				case EIF_NATURAL_32_CODE: ridr_multi_int32 (&eif_natural_32_tuple_item(l_item), 1); break;
				case EIF_NATURAL_64_CODE: ridr_multi_int64 (&eif_natural_64_tuple_item(l_item), 1); break;
				case EIF_INTEGER_8_CODE: ridr_multi_int8 (&eif_integer_8_tuple_item(l_item), 1); break;
				case EIF_INTEGER_16_CODE: ridr_multi_int16 (&eif_integer_16_tuple_item(l_item), 1); break;
				case EIF_INTEGER_32_CODE: ridr_multi_int32 (&eif_integer_32_tuple_item(l_item), 1); break;
				case EIF_INTEGER_64_CODE: ridr_multi_int64 (&eif_integer_64_tuple_item(l_item), 1); break;
				case EIF_POINTER_CODE: ridr_multi_any ((char *) &eif_pointer_tuple_item(l_item), 1); break;
				case EIF_WIDE_CHAR_CODE: ridr_multi_int32 (&eif_wide_character_tuple_item(l_item), 1); break;
				default:
					eise_io ("Recoverable retrieve: unsupported tuple element type.");
			}
		}
	} else {
		for (; count > 0; count--, l_item++) {
			ridr_multi_char(&l_type, 1);
			switch (l_type) {
				case OLD_EIF_REFERENCE_CODE: ridr_multi_any ((char*) &eif_reference_tuple_item(l_item), 1); break;
				case OLD_EIF_BOOLEAN_CODE: ridr_multi_char (&eif_boolean_tuple_item(l_item), 1); break;
				case OLD_EIF_CHARACTER_CODE: ridr_multi_char (&eif_character_tuple_item(l_item), 1); break;
				case OLD_EIF_REAL_64_CODE: ridr_multi_double (&eif_real_64_tuple_item(l_item), 1); break;
				case OLD_EIF_REAL_32_CODE: ridr_multi_float (&eif_real_32_tuple_item(l_item), 1); break;
				case OLD_EIF_INTEGER_8_CODE: ridr_multi_int8 (&eif_integer_8_tuple_item(l_item), 1); break;
				case OLD_EIF_INTEGER_16_CODE: ridr_multi_int16 (&eif_integer_16_tuple_item(l_item), 1); break;
				case OLD_EIF_INTEGER_32_CODE: ridr_multi_int32 (&eif_integer_32_tuple_item(l_item), 1); break;
				case OLD_EIF_INTEGER_64_CODE: ridr_multi_int64 (&eif_integer_64_tuple_item(l_item), 1); break;
				case OLD_EIF_POINTER_CODE: ridr_multi_any ((char *) &eif_pointer_tuple_item(l_item), 1); break;
				case OLD_EIF_WIDE_CHAR_CODE: ridr_multi_int32 (&eif_wide_character_tuple_item(l_item), 1); break;
				default:
					eise_io ("Recoverable retrieve: unsupported tuple element type.");
			}
		}
	}

	if (trash != NULL)
		eif_rt_xfree (trash);
}

rt_private int char_read(char *pointer, int size)
{
	RT_GET_CONTEXT
	return read(r_fides, pointer, size);
}

rt_private int stream_read(char *pointer, int size)
{
	RT_GET_CONTEXT
	if (stream_buffer_size - stream_buffer_position < (size_t) size) {
		stream_buffer_size += buffer_size;
		stream_buffer = (char *) eif_realloc (stream_buffer, stream_buffer_size);
	}	

	memcpy (pointer, (stream_buffer + stream_buffer_position), size);
	stream_buffer_position += size;
	return size;
}

/*
doc:	<routine name="cecil_info" export="private">
doc:		<summary>Find CECIL information about a given class. If we are retrieving a storable version greater than INDEPENDENT_STORE_5_5, then a type descriptor was provided and we search on either the reference or expanded tables of CECIL depending on the value of the type descriptor. Otherwise no type descriptor is provided and we use an heuristic which first search for the reference version, and then for the expanded version.</summary>
doc:		<param name="conv" type="type_descriptor *">Type descriptor for the class we are looking for.</param>
doc:		<param name="name" type="char *">Name of the class we are looking for.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>GC mutex</synchronization>
doc:	</routine>
*/

rt_private struct cecil_info * cecil_info (type_descriptor *conv, char *name)
{
	RT_GET_CONTEXT
	struct cecil_info * result;

	REQUIRE("valid_conv", (rt_kind_version < INDEPENDENT_STORE_5_5) || (conv != NULL));

	if (rt_kind_version >= INDEPENDENT_STORE_5_5) {
		if (conv->flags & EIF_IS_EXPANDED_FLAG) {
			result = (struct cecil_info *) ct_value (&egc_ce_exp_type, name);
		} else {
			result = (struct cecil_info *) ct_value (&egc_ce_type, name);
		}
	} else {
			/* Heuristic for storable. We look in the non-expanded classes first. */
		result = (struct cecil_info *) ct_value (&egc_ce_type, name);
		if (result == NULL) {
				/* Not found in non-expanded classes table,
				 * hopefully it is in the expanded table. */
			result = (struct cecil_info *) ct_value (&egc_ce_exp_type, name);
		} else {
				/* We found it in the non-expanded classes table. Let's check that indeed
				 * it is not declared as an expanded class in the retrieval system. Because
				 * if it is we assume that we are retrieving the expanded class and not
				 * the reference. */
			if (result->nb_param == 0) {
				if (EIF_IS_TYPE_DECLARED_AS_EXPANDED(System(result->dynamic_type))) {
					result = (struct cecil_info *) ct_value (&egc_ce_exp_type, name);
				}
			} else {
				if (EIF_IS_TYPE_DECLARED_AS_EXPANDED(System(result->dynamic_types[0]))) {
					result = (struct cecil_info *) ct_value (&egc_ce_exp_type, name);
				}
			}
		}
	}

	return result;
}

/*
doc:	<routine name="rt_read_cid" return_type="uint32" export="private">
doc:		<summary>Given `oflags', flags of the stored object, let's find the new flags in the retrieving system. This routine only works for basic and general store. For independent store, one has to use `rt_id_read_cid'.</summary>
doc:		<param name="oflags" type="uint32">Flags of the stored object.</param>
doc:		<return>New flags for the retrieving system.</return>
doc:		<thread_safety>Safe using thread safe routines and per thread data.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_private uint32 rt_read_cid (uint32 oflags)
{
	RT_GET_CONTEXT
	int16 count, dftype;
	int16 *l_cid;

	dftype = oflags & EO_TYPE;
	if (rt_kind) {
		dftype = dtypes [dftype];
	}

	buffer_read ((char *) &count, sizeof (int16));

	if (count >= 2) {
			/* We now read the generic parameters' type. */
		if (count >= CIDARR_SIZE) {
				/* In case it is more than the allocated memory for `cidarr'.
				 * `count + 2' because `l_cid' array has indices between the
				 * range of `0' to `count + 1'*/
			l_cid = (int16 *) malloc ((count + 2) * sizeof(int16));
		} else {
			l_cid = cidarr;
		}
		l_cid [0] = count;
		buffer_read ((char *) (l_cid + 1), count * sizeof (int16));
		l_cid [count + 1] = TERMINATOR;

		if (rt_kind) {
			dftype = eif_gen_id_from_cid (l_cid, dtypes);
		} else {
			dftype = eif_gen_id_from_cid (l_cid, (int *)0);
		}

		if (count >= CIDARR_SIZE) {
				/* Let's free the allocated array. */
			free (l_cid);
		}
	}

	return (uint32) ((oflags & EO_UPPER) | dftype);
}

/*
doc:	<routine name="rt_id_read_cid" return_type="uint32" export="private">
doc:		<summary>Given `oflags', flags of the stored object, let's find the new flags in the retrieving system. This routine only works for independent store, for basic and general store one has to use `rt_read_cid'.</summary>
doc:		<param name="oflags" type="uint32">Flags of the stored object.</param>
doc:		<return>New flags for the retrieving system.</return>
doc:		<thread_safety>Safe using thread safe routines and per thread data.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_private uint32 rt_id_read_cid (uint32 oflags)
{
	RT_GET_CONTEXT
	uint32 l_real_count, count, val;
	int16 dftype, *ip, *l_cid;
	int i;

	dftype = oflags & EO_TYPE;
	if (rt_kind) {
		dftype = dtypes [dftype];
	}

	ridr_norm_int (&count);    

	if (count >= 2) {
			/* We now read the generic parameters' type. */
		if (count >= CIDARR_SIZE) {
				/* In case it is more than the allocated memory for `cidarr'.
				 * `count + 2' because `l_cid' array has indices between the
				 * range of `0' to `count + 1'*/
			l_cid = (int16 *) malloc ((count + 2) * sizeof(int16));
		} else {
			l_cid = cidarr;
		}

		if (rt_kind_version >= INDEPENDENT_STORE_5_5) {
			l_real_count = count;
			ip = l_cid + 1;
			for (i = count; i; --i, ++ip) {
				ridr_norm_int (&val);
				*ip = (int16) val;
			}
		} else {
				/* Read old format of `cid' array corresponding to storable versions strictly less
				 * than INDEPENDENT_STORE_5_5 and convert as we go to new format. */
			ip = l_cid + 1;
			l_real_count = 0;
			for (i = count; i; --i) {
				ridr_norm_int (&val);
				dftype = (int16) val;
				if (dftype <= OLD_EXPANDED_LEVEL) {
					ip[l_real_count] = OLD_EXPANDED_LEVEL - dftype;
					l_real_count++;
				} else if (dftype == OLD_TUPLE_TYPE) {
					ip[l_real_count] = TUPLE_TYPE;
					l_real_count++;
					ridr_norm_int (&val);	/* Uniformizer, not used. */
					ridr_norm_int (&val);	/* Nb of generics. */
					ip[l_real_count] = (int16) val;
					l_real_count++;
					ridr_norm_int (&val);	/* Base id for TUPLE */
					ip[l_real_count] = (int16) val;
					l_real_count++;
						/* We skip the already treated elements */
					i -= 3;
				} else if (dftype <= OLD_FORMAL_TYPE) {
					ip[l_real_count] = FORMAL_TYPE;
					l_real_count++;
						/* This is the only place where the new encoding is bigger than the old one.
						 * So we need to make sure that we are in the proper bounds of the `l_cid' array. */
					if ((l_real_count + 1) >= count) {
							/* Reallocate array to allow ranges between `0' and `(l_real_count + 1) + 1'. */
						if (count >= CIDARR_SIZE) {
								/* Let's resize our existing allocated `l_cid' array. */
							l_cid = (int16 *) realloc (l_cid, (l_real_count + 3) * sizeof(int16));
						} else {
								/* Create a new memory block and copy content of `cidarr' in it. */
							l_cid = (int16 *) malloc ((l_real_count + 3) * sizeof(int16));
							memcpy (l_cid, cidarr, CIDARR_SIZE * sizeof(int16));
						}
						ip = l_cid + 1;
					}
					ip[l_real_count] = OLD_FORMAL_TYPE - dftype;	/* Insert position of formal */
					l_real_count++;
				} else {
					switch (dftype) {
						case OLD_CHARACTER_TYPE: ip[l_real_count] = egc_char_dtype; l_real_count++; break;
						case OLD_BOOLEAN_TYPE: ip[l_real_count] = egc_bool_dtype; l_real_count++; break;
						case OLD_INTEGER_8_TYPE: ip[l_real_count] = egc_int8_dtype; l_real_count++; break;
						case OLD_INTEGER_16_TYPE: ip[l_real_count] = egc_int16_dtype; l_real_count++; break;
						case OLD_INTEGER_32_TYPE: ip[l_real_count] = egc_int32_dtype; l_real_count++; break;
						case OLD_INTEGER_64_TYPE: ip[l_real_count] = egc_int64_dtype; l_real_count++; break;
						case OLD_REAL_32_TYPE: ip[l_real_count] = egc_real32_dtype; l_real_count++; break;
						case OLD_REAL_64_TYPE: ip[l_real_count] = egc_real64_dtype; l_real_count++; break;
						case OLD_POINTER_TYPE: ip[l_real_count] = egc_point_dtype; l_real_count++; break;
						case OLD_WIDE_CHAR_TYPE: ip[l_real_count] = egc_wchar_dtype; l_real_count++; break;
						case OLD_BIT_TYPE:
							ip[l_real_count] = egc_bit_dtype;
							l_real_count++;
							ridr_norm_int (&val);	/* Number of bits. */
							ip[l_real_count] = (int16) val;
							i--;
							break;
						default:
							ip[l_real_count] = dftype;
							l_real_count++;
					}
				}
			}
		}

		l_cid [0] = (int16) l_real_count;
		l_cid [l_real_count + 1] = TERMINATOR;

		if (rt_kind) {
			dftype = eif_gen_id_from_cid (l_cid, dtypes);
		} else {
			dftype = eif_gen_id_from_cid (l_cid, NULL);
		}

		if (count >= CIDARR_SIZE) {
				/* Let's free the allocated array. */
			free (l_cid);
		}
	}

	return (uint32) ((oflags & EO_UPPER) | dftype);
}

/*
doc:</file>
*/
