/*

 #####   ######   #####  #####      #    ######  #    #  ######           ####
 #    #  #          #    #    #     #    #       #    #  #               #    #
 #    #  #####      #    #    #     #    #####   #    #  #####           #
 #####   #          #    #####      #    #       #    #  #        ###    #
 #   #   #          #    #   #      #    #        #  #   #        ###    #    #
 #    #  ######     #    #    #     #    ######    ##    ######   ###     ####

	Eiffel retrieve mechanism.
*/

/*
doc:<file name="retrieve.c" header="eif_retrieve.h" version="$Id$" summary="Retrieval part of object serialization.">
*/

#include "eif_portable.h"
#include "rt_lmalloc.h"
#include "eif_project.h" /* for egc_ce_gtype, egc_bit_dtype */
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
/* A translation of a class name in the storing system into a new name in
 * the retrieving system.
 */
typedef struct {
		/* Name in storing system (key) */
	char *old_name;
		/* Name in retrieving system (value) */
	char *new_name;
} class_translation;

typedef struct {
		/* Name of attribute in storing system */
	char *name;

		/* Types of attribute and any generic parameters */
	int16 *types;

		/* Basic type in storing system */
	uint32 basic_type;

		/* Index of attribute in retrieving system. A value of -1 means
		 * that attribute does not have a match in retrieving system.
		 */
	int16 new_index;
} attribute_detail;

/* Special values for the `type_index' elements of `type_table' and the
 * `new_type' field of `type_descriptor'.
 */
enum type_state {
		 /* The corresponding type is not present in the new system */
	TYPE_NOT_PRESENT = -1,

		 /* No entry for this type was found in the header */
	TYPE_UNDEFINED = -2,

		 /* The generic type has not yet been resolved */
	TYPE_UNRESOLVED_GENERIC = -3
};

/* Describes a type in the storing system, with sufficient information to
 * convert it into a type in the retrieving system.
 */
typedef struct {
		/* Name of type in storing system */
	char *name;

		/* Array of length `attribute_count' indexed by attribute in
		 * storing system and containing the type of the attribute in the
		 * storing system.
		 */
	attribute_detail *attributes;

		/* Array of generic type patterns if `generic_count' is non-zero.
		 */
	int32 *generics;

		/* Type in storing system. */
	int16 old_type;

		/* Type in retrieving system corresponding to `old_type' in storing
		 * system. See the type_state enumeration for special values for this
		 * field.
		 */
	int16 new_type;

		/* New full dynamic type to use in place of generics recorded for
		 * object.
		 */
	int16 new_dftype;

		/* Count of attributes in storing system */
	int16 attribute_count;

		/* Count of generic arguments in storing system */
	int16 generic_count;

		/* Were attributes added to type in retrieving system? */
	int16 mismatched;

} type_descriptor;

/* Describes a table of information which describes types read from the
 * header of a stored object tree.
 */
typedef struct {
		/* A table of indexes into `descriptions', indexed by the type
		 * value in the storing system. The length of this index will be
		 * equal to the number of dynamic types in the storing system. See
		 * the type_state enumeration for special values for these
		 * elements.
		 */
	int16 *type_index;

		/* Table of type descriptions for the types found in the header of
		 * an independent or recoverable stored object.
		 */
	type_descriptor *descriptions;

		/* Number of elements in `descriptions'. This will be equal to the
		 * number of dynamic types recorded in the header of the stored
		 * object.
		 */
	uint16 count;
} type_table;

typedef struct {
		/* Indirection to special object of references containing objects
		 * which are mismatched and require correction. There are three
		 * cases of objects in this special, which affect the
		 * interpretation of `objects':
		 * (1) The object being corrected is a normal object without EO_COMP.
		 *    The object at the same position in `values' is a special
		 *    object containing the attribute values of the object in the
		 *    storing system in the order of those attributes in the
		 *    storing system.
		 * (2) The object being corrected is a normal object with EO_COMP.
		 *    The object at the same position in `values' is a special
		 *    object of references, of a length equal to the number of
		 *    attributes of the object in the retrieving system (and
		 *    possibly one larger). Each occupied position of this special
		 *    will correspond (by attribute index of the object in the
		 *    retrieving system) to a mismatched expanded attribute of the
		 *    associated object in `objects', and will point to another
		 *    special object of references whose length is equal to the
		 *    original number of attributes of the expanded attribute and
		 *    containing the original values of the attributes of the
		 *    expanded attribute in much the same way as in case (1). If
		 *    the object in `objects' is itself mismatched, its original
		 *    values will be found similar to case (1), but at the position
		 *    of the special in `values' which is one more than the number
		 *    of attributes of the object in the retrieving system.
		 * (3) The object is a special object.
		 *    The object in values will be a special object of expanded
		 *    objects which are mismatched. The corresponding value in
		 *    `values' will be a special object of references, of the same
		 *    length, and each position will reference another special
		 *    object of references of a length equal to the original number
		 *    of attributes of the corresponding expanded object and
		 *    contain the original values of the expanded.
		 */
	EIF_OBJECT objects;

		/* Indirection to special object containing the old values of
		 * the objects in `objects'. The interpretation of the value of
		 * this field in dependent upon what kind of object is at the same
		 * position in `objects'.
		 */
	EIF_OBJECT values;

		/* Potentional number of objects in `objects' and `values'.
		 */
	uint32 capacity;

		/* Actual number of objects in `objects' and `values'. */
	uint32 count;
} mismatch_table;

typedef union {
	EIF_BOOLEAN		vbool;
	EIF_CHARACTER	vchar;
	EIF_WIDE_CHAR	vwchar;
	EIF_INTEGER_8	vint8;
	EIF_INTEGER_16	vint16;
	EIF_INTEGER_32	vint32;
	EIF_INTEGER_64	vint64;
	EIF_REAL		vreal;
	EIF_DOUBLE		vdbl;
	EIF_REFERENCE	vref;
	EIF_POINTER		vptr;
} multi_value;

/*
doc:	<attribute name="rt_table" return_type="struct htable *" export="shared">
doc:		<summary>Table used for solving references.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_shared struct htable *rt_table;

/*
doc:	<attribute name="nb_recorded" return_type="int32" export="shared">
doc:		<summary>Number of items recorded in `hec_stack' during retrieval.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_shared int32 nb_recorded = 0;

/*
doc:	<attribute name="rt_kind" return_type="char" export="shared">
doc:		<summary>Kind of storable.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_shared char rt_kind;

/*
doc:	<attribute name="rt_kind_version" return_type="char" export="shared">
doc:		<summary>Version of storable. Only used for independent store.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_shared char rt_kind_version;

/*
doc:	<attribute name="eif_discard_pointer_value" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>To discard or not the pointer value upon retrieval. By default we do not keep the value as a pointer value represent allocated memory which might not be present at retrieval time.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>STORABLE</eiffel_classes>
doc:		<fixme>Could be a in a private per thread or global and protected through a mutex.</fixme>
doc:	</attribute>
*/
rt_public EIF_BOOLEAN eif_discard_pointer_values = EIF_TRUE;

/*
doc:	<attribute name="type_conversions" return_type="type_table *" export="private">
doc:		<summary></summary>
doc:		<access></access>
doc:		<indexing></indexing>
doc:		<thread_safety></thread_safety>
doc:		<synchronization></synchronization>
doc:		<eiffel_classes></eiffel_classes>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_private type_table *type_conversions;

/*
doc:	<attribute name="mismatches" return_type="mismatch_table *" export="private">
doc:		<summary></summary>
doc:		<access></access>
doc:		<indexing></indexing>
doc:		<thread_safety></thread_safety>
doc:		<synchronization></synchronization>
doc:		<eiffel_classes></eiffel_classes>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_private mismatch_table *mismatches;

/*
doc:	<attribute name="dattrib" return_type="int **" export="private">
doc:		<summary>Pointer to attribyte offsets in each object for independent store.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>[dftype][i-th attribute]</indexing>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a per thread data.</fixme>
doc:	</attribute>
*/
rt_private int **dattrib;

/*
doc:	<attribute name="dtypes" return_type="int *" export="private">
doc:		<summary>Conversion between dtypes found in storable file and dtypes of current system. Used for general and independent store.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>[old dftype]</indexing>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_private int *dtypes;

/*
doc:	<attribute name="spec_elm_size" return_type="uint32 *" export="private">
doc:		<summary>Array of special element sizes. Only used for special of expanded types where definition of expanded types is different in stored file and retrieval system.</summary>
doc:		<access>Read/Write</access>
doc:		<indexing>[old dftype]</indexing>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a per thread data. </fixme>
doc:	</attribute>
*/
rt_private uint32 *spec_elm_size;

/*
doc:	<attribute name="old_overhead" return_type="uint32" export="private">
doc:		<summary>Overhead size from stored object which might be different from retrieval system. Used only in case of special of expanded objects.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_private uint32 old_overhead = 0;

/*
doc:	<attribute name="r_buffer" return_type="char *" export="private">
doc:		<summary>Buffer for reading of storable header.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_private char * r_buffer = NULL;

#ifndef EIF_THREADS
/*
doc:	<attribute name="r_fides" return_type="int" export="private">
doc:		<summary>File descriptor use for retrieve.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_private int r_fides;
#endif

/*
doc:	<attribute name="class_translations" return_type="unamed struct" export="private">
doc:		<summary></summary>
doc:		<access></access>
doc:		<indexing></indexing>
doc:		<thread_safety></thread_safety>
doc:		<synchronization></synchronization>
doc:		<eiffel_classes></eiffel_classes>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_private struct {
		/* Pointer to array of class translation entries */
	class_translation *table;

		/* Maximum number of entries in `translations'. */
	unsigned int max_count;

		/* Number of entries in `translations'. */
	unsigned int count;
} class_translations;	/* Table of class name translations */

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
rt_private EIF_REFERENCE object_rread_attributes (EIF_REFERENCE object, uint32 flags, long expanded_offset);
rt_private void object_read (EIF_REFERENCE object, EIF_REFERENCE parent);		/* read the individual attributes of the object*/
rt_private void gen_object_read (EIF_REFERENCE object, EIF_REFERENCE parent);	/* read the individual attributes of the object*/

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

/*
doc:	<attribute name="retrieve_read_func" return_type="int (*)(void)" export="private">
doc:		<summary>High level function to read storable file. It uses `char_read_func' to actually read bytes of the file.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in private per thread data.</fixme>
doc:	</attribute>
*/
rt_private int (*retrieve_read_func)(void) = retrieve_read_with_compression;

/*
doc:	<attribute name="char_read_func" return_type="int (*)(char *buf, int n)" export="shared">
doc:		<summary>Read `n' bytes from content of storable and store it in allocated buffer `buf'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread.</fixme>
doc:	</attribute>
*/
rt_shared int (*char_read_func)(char *, int) = char_read;

/*
doc:	<attribute name="old_retrieve_read_func" return_type="int (*)(void)" export="private">
doc:		<summary>Nice hack for compiler so that compiler can use a different `retrieve_read_func' for its modified use of store/retrieve. So each time we use the compiler one, at the end we restore the `old' one which is the default one for traditional store/retrieve.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data. Also I'm not sure this is really needed anymore?</fixme>
doc:	</attribute>
*/
rt_private int (*old_retrieve_read_func)(void) = retrieve_read_with_compression;

/*
doc:	<attribute name="old_char_read_func" return_type="int (*)(char *, int)" export="private">
doc:		<summary>Nice hack for compiler so that compiler can use a different `char_read_func' for its modified use of store/retrieve. So each time we use the compiler one, at the end we restore the `old' one which is the default one for traditional store/retrieve.</summary>
doc:		<access>Read/Wriite</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data. Also I'm not sure this is really needed anymore?</fixme>
doc:	</attribute>
*/
rt_private int (*old_char_read_func)(char *, int) = char_read;

/*
doc:	<attribute name="old_rt_kind" return_type="char" export="private">
doc:		<summary>Old kind of storable.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data. Also I'm not sure this is really needed anymore?</fixme>
doc:	</attribute>
*/
rt_private char old_rt_kind;			/* Kind of storable */

/*
doc:	<attribute name="old_buffer_size" return_type="long" export="private">
doc:		<summary>Old buffer size.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data. Also I'm not sure this is really needed anymore?</fixme>
doc:	</attribute>
*/
rt_private long old_buffer_size = RETRIEVE_BUFFER_SIZE;

/*
doc:	<attribute name="end_of_buffer" return_type="int" export="shared">
doc:		<summary>Size after decompression of decompressed data.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_shared int end_of_buffer = 0;

/*
 * Convenience functions
 */

/*
doc:	<attribute name="stream_buffer" return_type="char *" export="private">
doc:		<summary>Pointer to memory buffer where storable is located.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a per thread data. Code in `stream_read' does not make sense at all since no resizing of `stream_buffer' will occur (we are reading not writing here!). </fixme>
doc:	</attribute>
*/
rt_private char *stream_buffer;

/*
doc:	<attribute name="stream_buffer_position" return_type="int" export="private">
doc:		<summary>Position of cursor in `stream_buffer' while reading storable.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a per thread data.</fixme>
doc:	</attribute>
*/
rt_private int stream_buffer_position;

/*
doc:	<attribute name="stream_buffer_size" return_type="long" export="private">
doc:		<summary>Size of `stream_buffer'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a per thread data.</fixme>
doc:	</attribute>
*/
rt_private long stream_buffer_size;

/*
doc:	<attribute name="cidarr" return_type="int16 [256]" export="private">
doc:		<summary>Static CID array.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Should be in a private per thread data. Fixed size is not good. It should be a resizable array.</fixme>
doc:	</attribute>
*/
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

rt_private type_table *new_type_conversion_table (int max_types, int num_types)
{
	type_table *result;
	size_t table_size, index_size;
	int i;

	result = (type_table*) xmalloc (sizeof (type_table), C_T, GC_OFF);
	if (result == NULL)
		xraise (EN_MEM);

	table_size = num_types * sizeof (type_descriptor);
	result->descriptions = (type_descriptor*) xmalloc (table_size, C_T, GC_OFF);
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
	result->type_index = (int16 *) xmalloc (index_size, C_T, GC_OFF);
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
			xfree ((char *) table->type_index);
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
						xfree (a->name);
						a->name = NULL;
						if (a->types != NULL) {
							xfree ((char *) a->types);
							a->types = NULL;
						}
					}
					xfree ((char *) t->attributes);
					t->attributes = NULL;
				}
				if (t->generics != NULL) {
					xfree ((char *) t->generics);
					t->generics = NULL;
				}
				if (t->name != NULL) {
					xfree (t->name);
					t->name = NULL;
				}
			}
			xfree ((char *) table->descriptions);
			table->descriptions = NULL;
		}
		xfree ((char *) table);
	}
}

rt_private int type_defined (int16 old_type)
{
	int result = 0;
	if (old_type >= 0)
		result = type_conversions->type_index[old_type] != TYPE_UNDEFINED;
	return result;
}

rt_private type_descriptor *type_description (int32 old_type)
{
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
			CHRPAD (count * sizeof (EIF_REFERENCE)) + LNGPAD (2), FALSE);
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
	mismatch_table *result = (mismatch_table *) xmalloc (
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
	mismatches->capacity *= 2;
	mismatches->objects = eif_protect (
			sprealloc (eif_wean (mismatches->objects), mismatches->capacity));
	mismatches->values = eif_protect (
			sprealloc (eif_wean (mismatches->values), mismatches->capacity));
}

rt_private void free_mismatch_table (mismatch_table *table)
{
	eif_wean (table->objects);
	eif_wean (table->values);
	table->objects = NULL;
	table->values = NULL;
	table->capacity = 0;
	table->count = 0;
	xfree ((char *) table);
}

/*
 * Function definitions
 */


/* TODO: How should data be placed into `mismatch_information'?
 */
/*
doc:	<attribute name="mismatch_information_initialiize" return_type="EIF_PROCEDURE" export="private">
doc:		<summary>Re-initialization of `mismatch_information' table used by MISMATCH_CORRECTOR.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>MISMATCH_CORRECTOR, MISMATCH_INFORMATION</eiffel_classes>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_private EIF_PROCEDURE mismatch_information_intialize;

/*
doc:	<attribute name="mismatch_information_add" return_type="EIF_PROCEDURE" export="private">
doc:		<summary>Insert new items in `mismatch_information' table </summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>MISMATCH_CORRECTOR, MISMATCH_INFORMATION</eiffel_classes>
doc:		<fixme>Should be in a private per thread data.</fixme>
doc:	</attribute>
*/
rt_private EIF_PROCEDURE mismatch_information_add;

/*
doc:	<attribute name="mismtach_information" return_type="EIF_OBJECT" export="private">
doc:		<summary>Protected reference to `mismatch_information' of MISMATCH_CORRECTOR.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>MISMATCH_CORRECTOR, MISMATCH_INFORMATION</eiffel_classes>
doc:		<fixme>Should be in a private per thread data as it `mismatch_information' is a once per thread at the Eiffel level.</fixme>
doc:	</attribute>
*/
rt_private EIF_OBJECT mismatch_information_object;

rt_public void set_mismatch_information_access (
		EIF_OBJECT object, EIF_PROCEDURE init, EIF_PROCEDURE add)
{
	if (mismatch_information_object != NULL)
		eif_wean (mismatch_information_object);
	mismatch_information_object = eif_adopt (object);
	mismatch_information_intialize = init;
	mismatch_information_add = add;
}

rt_private void set_mismatch_information (
		EIF_REFERENCE object, EIF_REFERENCE values, type_table *conversions)
{
	EIF_OBJECT vals_i = eif_protect (values);
	int16 new_type = Dtype (object);
	type_descriptor *conv = type_description_for_new (conversions, new_type);
	EIF_REFERENCE class_name;
	int i;

	REQUIRE ("Values in special", HEADER (values)->ov_flags & EO_SPEC);
	mismatch_information_intialize (eif_access (mismatch_information_object));

	/* Store class name in table */
	class_name = eif_gen_typename_of_type ((int16) Dftype (object));
	mismatch_information_add (
			eif_access (mismatch_information_object), class_name, "class");

	/* Store atribute values in table */
	for (i=0; i<conv->attribute_count; i++) {
		attribute_detail *att = conv->attributes + i;
		EIF_REFERENCE old_value = ((EIF_REFERENCE *) eif_access (vals_i))[i];
		mismatch_information_add (
				eif_access (mismatch_information_object), old_value, att->name);
	}
	eif_wean (vals_i);
}

rt_private void correct_object_mismatch (
		EIF_REFERENCE object, EIF_REFERENCE values, type_table *conversions)
{
	EIF_GET_CONTEXT
	EIF_BOOLEAN asserting;
	EIF_BOOLEAN collecting;

	REQUIRE ("Values in special", HEADER (values)->ov_flags & EO_SPEC);

	RT_GC_PROTECT(object);
	RT_GC_PROTECT(values);
	set_mismatch_information (object, values, conversions);
#ifdef RECOVERABLE_DEBUG
	printf ("  calling correct_mismatch on %s [%p]\n", EIF_OBJECT_TYPE (object), object);
#endif
	asserting = c_check_assert (EIF_FALSE);
	collecting = gc_ison ();
	gc_stop ();
	egc_correct_mismatch (object);
	if (collecting)
		gc_run ();
	c_check_assert (asserting);

	RT_GC_WEAN_N(2);
}

rt_private void correct_one_mismatch (
		EIF_REFERENCE object, EIF_REFERENCE values, type_table *conversions)
{
	uint32 flags = HEADER (object)->ov_flags;
	EIF_INTEGER count = RT_SPECIAL_COUNT (values);
	EIF_OBJECT obj_i = eif_protect (object);
	EIF_OBJECT vals_i = eif_protect (values);

#ifdef RECOVERABLE_DEBUG
	printf ("Correcting %s [%p]\n", EIF_OBJECT_TYPE (eif_access (obj_i)),
			eif_access (obj_i));
#endif
	REQUIRE ("Values in special", HEADER (values)->ov_flags & EO_SPEC);
	if (flags & EO_TUPLE) {
		correct_object_mismatch (eif_access (obj_i), eif_access (vals_i), conversions);
	} else if (flags & EO_SPEC) {
		EIF_INTEGER i;
		EIF_INTEGER ocount = RT_SPECIAL_COUNT (eif_access (obj_i));
		EIF_INTEGER oelem_size = RT_SPECIAL_ELEM_SIZE (eif_access (obj_i));
		CHECK ("Consistent length", ocount == count);
		for (i=0; i<ocount; i++) {
			EIF_REFERENCE ref = (EIF_REFERENCE) (
					(char *) eif_access (obj_i) + OVERHEAD + (i * oelem_size));
			EIF_REFERENCE vals = ((EIF_REFERENCE *) eif_access (vals_i))[i];
			correct_object_mismatch (ref, vals, conversions);
		}
	}
	else if (flags & EO_COMP) {
		uint32 dtype = flags & EO_TYPE;
		long num_attr = System (dtype).cn_nbattr;
		long i;
		CHECK ("Not too short", count == num_attr || count == num_attr + 1);
		for (i=0; i<num_attr; i++) {
			EIF_REFERENCE vals = ((EIF_REFERENCE *) eif_access (vals_i))[i];
			if (vals != NULL) {
				long attrib_offset;
				EIF_REFERENCE ref;
				CHECK ("Expanded attribute", System (dtype).cn_types[i] & SK_EXP);
				attrib_offset = get_offset (dtype, i);
				ref = (char *) eif_access (obj_i) + attrib_offset;
				correct_object_mismatch (ref, vals, conversions);
			}
		}
		if (count == num_attr + 1) {
			EIF_REFERENCE vals = ((EIF_REFERENCE *) eif_access (vals_i))[num_attr];
			correct_object_mismatch (eif_access (obj_i), vals, conversions);
		}
	}
	else {
		correct_object_mismatch (eif_access (obj_i), eif_access (vals_i), conversions);
	}
	eif_wean (obj_i);
	eif_wean (vals_i);
}

/* Calls `correct_mismatch' on all objects contained in `mm'.
 * Returns non-zero if corrections were attempted on one or more mismatches.
 */
rt_private int correct_mismatches (mismatch_table *mm, type_table *conversions)
{
	int result = 0;
	uint32 i;

	if (mismatch_information_object == NULL  ||
		mismatch_information_intialize == NULL  ||
		mismatch_information_add == NULL)
		return 0;

#ifdef RECOVERABLE_DEBUG
	if (mm->count > 0)
		printf ("-- Performing mismatch correction\n");
#endif
	for (i=0; i < mm->count; i++) {
		EIF_REFERENCE object = ((EIF_REFERENCE *) eif_access (mm->objects))[i];
		EIF_REFERENCE values = ((EIF_REFERENCE *) eif_access (mm->values))[i];
		CHECK ("Values in special", HEADER (values)->ov_flags & EO_SPEC);
		correct_one_mismatch (object, values, conversions);
		result = 1;
	}
	return result;
}

rt_public EIF_REFERENCE eretrieve(EIF_INTEGER file_desc)
{
	RT_GET_CONTEXT
	r_fides = file_desc;

	return portable_retrieve(char_read);
}

rt_public EIF_REFERENCE stream_eretrieve(EIF_POINTER *buffer, EIF_INTEGER size, EIF_INTEGER start_pos, EIF_INTEGER *real_size)
{
	EIF_REFERENCE new_object;
	stream_buffer = (char *) *buffer;
	stream_buffer_size = size;
	stream_buffer_position = start_pos;

	new_object = portable_retrieve(stream_read);
	*real_size = stream_buffer_position;
	return new_object;
}

#ifdef RECOVERABLE_SCAFFOLDING
/*
doc:	<attribute name="eif_use_old_independent_retrieve" return_type="EIF_BOOLEAN" export="private">
doc:		<summary>Do we want to use old independent format or new one that can fix some mismatch? Default new one.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>STORABLE</eiffel_classes>
doc:		<fixme>Should be in a private per thread data. Is this obsolete now?</fixme>
doc:	</attribute>
*/
rt_private EIF_BOOLEAN eif_use_old_independent_retrieve = EIF_FALSE;
rt_public void eif_set_old_independent_retrieve (EIF_BOOLEAN state)
{
	eif_use_old_independent_retrieve = state;
}
#endif

rt_public EIF_REFERENCE portable_retrieve(int (*char_read_function)(char *, int))
{
	/* Retrieve object store in file `filename' */

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
		case RECOVERABLE_STORE_5_3:
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
		xfree((char *) dtypes);					/* Free the correspondance table */
	}
	if ((rt_kind == INDEPENDENT_STORE) || (rt_kind == RECOVERABLE_STORE)) {
		xfree((char *) spec_elm_size);					/* Free the element size table */
	}

	ht_free(rt_table);					/* Free hash table descriptor */
#ifdef ISE_GC
	epop(&hec_stack, nb_recorded);		/* Pop hector records */
#endif
	switch (rt_type) {
		case GENERAL_STORE_4_0: 
			free_sorted_attributes();
			break;
		case INDEPENDENT_STORE_4_3:
		case INDEPENDENT_STORE_4_4:
		case INDEPENDENT_STORE_5_0:
		case RECOVERABLE_STORE_5_3:
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
		int corrected;
		type_table *conversions = type_conversions;
		mismatch_table *mm = mismatches;
		type_conversions = NULL;
		mismatches = NULL;

		/* Global variables are freed at this point, allowing safe call-back
		 * into the run-time (another retrieve?) by the application, which
		 * is called into by correct_mismatches().
		 */
		corrected = correct_mismatches (mm, conversions);
		free_mismatch_table (mm);
		free_type_conversion_table (conversions);
		retrieved = eif_wean (retrieved_i);
#ifdef PRINT_OBJECT
		if (corrected) {
			printf ("Corrected object:\n");
			print_object (retrieved);
		}
#endif
	}
#ifdef RECOVERABLE_DEBUG
	fflush (stdout);
#endif

	return retrieved;
}

rt_public EIF_REFERENCE ise_compiler_retrieve (EIF_INTEGER f_desc, EIF_INTEGER a_pos, int (*retrieve_function) (void))
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
#ifdef ISE_GC
	epop(&hec_stack, nb_recorded);		/* Pop hector records */
#endif
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

rt_private void independent_retrieve_reset (void)
	/* Clean allocated data structures for independent store */
{
	int i;

	run_idr_destroy ();
	if (idr_temp_buf != NULL) {
		xfree (idr_temp_buf);
		idr_temp_buf = NULL;
	}
	if (dattrib != NULL) {
		for (i = 0; i < scount; i++) {
			if (*(dattrib + i))
				xfree ((char *)(*(dattrib +i)));
		}
		xfree ((char *) dattrib);
		dattrib = NULL;
	}
}

/* Create a hash table to hold `count' objects, each of `size'. */
rt_private struct htable *create_hash_table (int32 count, size_t size)
{
	struct htable *result = (struct htable*)
			xmalloc (sizeof (struct htable), C_T, GC_OFF);
	if (result == NULL)
		xraise (EN_MEM);
	if (ht_create (result, count, size) == -1)
		xraise (EN_MEM);
	ht_zero (result);
	return result;
}

rt_public void class_translation_clear (void)
{
	REQUIRE ("Table consistency",
			(class_translations.max_count == 0) == (class_translations.table == NULL));
	if (class_translations.table != NULL) {
		unsigned int i;
		for (i=0; i<class_translations.count; i++) {
			xfree ((char *) class_translations.table[i].old_name);
			class_translations.table[i].old_name = NULL;

			xfree ((char *) class_translations.table[i].new_name);
			class_translations.table[i].new_name = NULL;
		}
		xfree ((char *) class_translations.table);
		class_translations.table = NULL;
		class_translations.max_count = 0;
		class_translations.count = 0;
	}
	ENSURE ("Table consistency",
			(class_translations.max_count == 0) == (class_translations.table == NULL));
}

rt_private void class_translation_grow (void)
{
	REQUIRE ("Table consistency",
			(class_translations.max_count == 0) == (class_translations.table == NULL));
	if (class_translations.max_count == 0) {
		int max_count = 5;
		class_translations.table =
				(class_translation *) xcalloc (max_count, sizeof (class_translation));
		if (class_translations.table == NULL)
			xraise (EN_MEM);
		class_translations.max_count = max_count;
		class_translations.count = 0;
	}
	else {
		int new_max_count = class_translations.max_count * 2;
		class_translation *new_table =
				(class_translation *) xcalloc (new_max_count, sizeof (class_translation));
		if (new_table == NULL)
			xraise (EN_MEM);
		memcpy (new_table, class_translations.table,
				class_translations.count * sizeof (class_translation));
		xfree ((char *) class_translations.table);
		class_translations.table = new_table;
		class_translations.max_count = new_max_count;
	}
	ENSURE ("Table consistency",
			(class_translations.max_count == 0) == (class_translations.table == NULL));
}

rt_private char *class_translation_lookup (char *old_name)
{
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
	class_translation *trans = NULL;
	char *newnm;
	unsigned int i;
	REQUIRE ("Old name exists", old_name != NULL && old_name[0] != '\0');
	REQUIRE ("New name exists", new_name != NULL && new_name[0] != '\0');
	newnm = (char *) xmalloc (strlen (new_name) + 1, C_T, GC_OFF);
	if (newnm == NULL)
		xraise (EN_MEM);
	strcpy (newnm, new_name);
	for (i=0; i<class_translations.count && trans == NULL; i++) {
		if (strcmp (class_translations.table[i].old_name, old_name) == 0)
			trans = class_translations.table + i;
	}
	if (trans != NULL) {
		/* Key already in table */
		xfree (trans->new_name);
		trans->new_name = newnm;
	}
	else {
		/* Key not yet in table */
		if (class_translations.count == class_translations.max_count)
			class_translation_grow ();
		trans = class_translations.table + class_translations.count;
		++class_translations.count;
		trans->new_name = newnm;
		trans->old_name = (char *) xmalloc (strlen (old_name) + 1, C_T, GC_OFF);
		if (trans->old_name == NULL)
			xraise (EN_MEM);
		strcpy (trans->old_name, old_name);
	}
	ENSURE ("Count not too high",
			class_translations.count <= class_translations.max_count);
}

rt_public EIF_INTEGER class_translation_count (void)
{
	return class_translations.count;
}

/* Old name for translation `i', where `i' is a zero-based index from 0 up
 * to class_translation_count().
 */
rt_public char *class_translation_old (EIF_INTEGER i)
{
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
	char *result = NULL;
	REQUIRE ("Valid index", 0 <= i && i < (EIF_INTEGER) class_translations.count);
	if (0 <= i && i < (EIF_INTEGER) class_translations.count)
		result = class_translations.table[i].new_name;
	return result;
}

rt_private void rt_create_table (int32 count)
{
	rt_table = create_hash_table (count, sizeof (struct rt_struct));
}

rt_shared uint32 special_generic_type (uint32 o_type)
{
	int16 *gt_type;
	int32 *gt_gen;
	int nb_gen;
	char *vis_name = System (o_type).cn_generator;
	struct gt_info *info = (struct gt_info *) ct_value (&egc_ce_gtype, vis_name);

	CHECK ("Must be generic", info != NULL);

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
	return *gt_gen;
}

rt_public EIF_REFERENCE rt_make(void)
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
#ifdef ISE_GC
	char g_status = g_data.status;
#endif
	jmp_buf exenv;
	RTXD;

	REQUIRE ("Positive count", objectCount > 0);

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
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
		g_data.status |= GC_STOP;
#endif /* ISE_GC */

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

#ifdef ISE_GC
			/* Restore garbage collector status */
		g_data.status = g_status;
#endif /* ISE_GC */
	}
	expop(&eif_stack);
	return newadd;
}

rt_public EIF_REFERENCE grt_make(void)
{
		/* Make the retrieve of all objects in file */
	long objectCount;

		/* Read the object count in the file header */
	buffer_read((char *) &objectCount, sizeof(long));

	return grt_nmake(objectCount);
}

rt_public EIF_REFERENCE grt_nmake(long int objectCount)
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */
	EIF_GET_CONTEXT
	char *oldadd;
	char * volatile newadd = (char *) 0;
	EIF_OBJECT new_hector;
	uint32 crflags, fflags, flags;
	volatile uint32 spec_size = 0;
	volatile long int n = objectCount;
#ifdef ISE_GC
	char g_status = g_data.status;
#endif
	jmp_buf exenv;
	RTXD;

	REQUIRE ("Positive count", objectCount > 0);

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
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
		rt_read_cid (&crflags, &fflags, flags);

#if DEBUG & 1
		printf (" %x", flags);
#endif

		/* Read a possible size */
		if (flags & EO_SPEC) {
			uint32 count, elm_size;
			long nb_byte;
			if (flags & EO_TUPLE) {
				spec_size = sizeof(EIF_TYPED_ELEMENT);
			} else {
				uint32 dgen, spec_type;

				spec_type = dtypes[flags & EO_TYPE];
				dgen = special_generic_type (spec_type);

				if (!((dgen & SK_HEAD) == SK_EXP)) {
					switch (dgen) {
						case SK_INT8: spec_size = sizeof (EIF_INTEGER_8); break;
						case SK_INT16: spec_size = sizeof (EIF_INTEGER_16); break;
						case SK_INT32: spec_size = sizeof (EIF_INTEGER_32); break;
						case SK_INT64: spec_size = sizeof (EIF_INTEGER_64); break;
						case SK_CHAR: spec_size = sizeof (EIF_CHARACTER); break;
						case SK_WCHAR: spec_size = sizeof (EIF_WIDE_CHAR); break;
						case SK_BOOL: spec_size = sizeof (EIF_BOOLEAN); break;
						case SK_FLOAT: spec_size = sizeof (EIF_REAL); break;
						case SK_DOUBLE: spec_size = sizeof (EIF_DOUBLE); break;
						case SK_POINTER: spec_size = sizeof (EIF_POINTER); break;
						case SK_DTYPE:
						case SK_REF: spec_size = sizeof (EIF_OBJECT); break;
						default:
							if (dgen & SK_BIT) 
								spec_size = BITOFF(dgen & SK_DTYPE);
							else
								eise_io("General retrieve: not an Eiffel object.");
					}
				} else {
					spec_size = EIF_Size((uint16)(dgen & SK_DTYPE)) + OVERHEAD;
				}
			}
			buffer_read((char *) &count, sizeof(uint32));
			nb_byte = CHRPAD(count * spec_size ) + LNGPAD_2;
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
		g_data.status |= GC_STOP;
#endif /* ISE_GC */

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

#ifdef ISE_GC
			/* Restore garbage collector status */
		g_data.status = g_status;
#endif /* ISE_GC */
	}
	expop(&eif_stack);

	return newadd;
}

rt_public EIF_REFERENCE irt_make(void)
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

rt_public EIF_REFERENCE irt_nmake(long int objectCount)
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
#ifdef ISE_GC
	char g_status = g_data.status;
#endif
	jmp_buf exenv;
	RTXD;

	REQUIRE ("Positive count", objectCount > 0);

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
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
		rt_id_read_cid (&crflags, &fflags, flags);

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
						case SK_INT8: spec_size = sizeof (EIF_INTEGER_8); break;
						case SK_INT16: spec_size = sizeof (EIF_INTEGER_16); break;
						case SK_INT32: spec_size = sizeof (EIF_INTEGER_32); break;
						case SK_INT64: spec_size = sizeof (EIF_INTEGER_64); break;
						case SK_CHAR: spec_size = sizeof (EIF_CHARACTER); break;
						case SK_WCHAR: spec_size = sizeof (EIF_WIDE_CHAR); break;
						case SK_BOOL: spec_size = sizeof (EIF_BOOLEAN); break;
						case SK_FLOAT: spec_size = sizeof (EIF_REAL); break;
						case SK_DOUBLE: spec_size = sizeof (EIF_DOUBLE); break;
						case SK_POINTER: spec_size = sizeof (EIF_POINTER); break;
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
			}
			ridr_norm_int (&count);
			nb_byte = CHRPAD(count * spec_size ) + LNGPAD_2;
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
		g_data.status |= GC_STOP;
#endif /* ISE_GC */

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

#ifdef ISE_GC
			/* Restore garbage collector status */
		g_data.status = g_status;
#endif /* ISE_GC */
	}
	expop(&eif_stack);
	return newadd;
}

rt_public EIF_REFERENCE rrt_make (void)
{
	/* Make the retrieve of all objects in file */
	EIF_INTEGER_32 objectCount;

	/* Read the object count in the file header */
	ridr_multi_int32 (&objectCount, 1);

	return rrt_nmake (objectCount);
}

/* Add `object' and its `old_values' into the mismatch table for later
 * correction.
 */
rt_private void add_mismatch (EIF_REFERENCE object, EIF_REFERENCE old_values)
{
	EIF_REFERENCE spec;

	REQUIRE ("No GC", g_data.status & GC_STOP);
	if (mismatches->count == mismatches->capacity)
		grow_mismatch_table ();

	spec = eif_access (mismatches->values);
	((EIF_REFERENCE *) spec)[mismatches->count] = old_values;
	RTAS_OPT (old_values, mismatches->count, spec);

	spec = eif_access (mismatches->objects);
	((EIF_REFERENCE *) spec)[mismatches->count] = object;
	RTAS_OPT (object, mismatches->count, spec);

	++mismatches->count;
}

/* Create a DROPPED record for the address `old' in the storing system.
 * An exception is raised for a dropped object (due to its generating type
 * missing from the retrieving syste) only when an attribute is found to
 * actually reference it.
 */
rt_private void rt_dropped (register EIF_REFERENCE old, int16 old_type)
{
	unsigned long key = (unsigned long) old - 1;
	struct rt_struct *info = (struct rt_struct *) ht_first(rt_table, key);
	info->rt_status = DROPPED;
	info->rtu_data.old_type = old_type;
}

rt_private EIF_REFERENCE new_special_object (int new_type, uint32 crflags, uint32 count)
{
	EIF_REFERENCE result;
	long nb_byte;
	uint32 spec_size = 0;
	uint32 dgen = special_generic_type (new_type);

	if ((dgen & SK_HEAD) == SK_EXP)
		spec_size = EIF_Size ((uint16) (dgen & SK_DTYPE)) + OVERHEAD;
	else switch (dgen) {
		case SK_INT8:    spec_size = sizeof (EIF_INTEGER_8);  break;
		case SK_INT16:   spec_size = sizeof (EIF_INTEGER_16); break;
		case SK_INT32:   spec_size = sizeof (EIF_INTEGER_32); break;
		case SK_INT64:   spec_size = sizeof (EIF_INTEGER_64); break;
		case SK_CHAR:    spec_size = sizeof (EIF_CHARACTER);  break;
		case SK_WCHAR:   spec_size = sizeof (EIF_WIDE_CHAR);  break;
		case SK_BOOL:    spec_size = sizeof (EIF_BOOLEAN);    break;
		case SK_FLOAT:   spec_size = sizeof (EIF_REAL);       break;
		case SK_DOUBLE : spec_size = sizeof (EIF_DOUBLE);     break;
		case SK_POINTER: spec_size = sizeof (EIF_POINTER);    break;
		case SK_DTYPE:
		case SK_REF:     spec_size = sizeof (EIF_REFERENCE);  break;

		default:
			if (dgen & SK_BIT) 
				spec_size = BITOFF (dgen & SK_DTYPE);
			else
				eise_io ("Independent retrieve: not an Eiffel object.");
	}
	nb_byte = CHRPAD (count * spec_size) + LNGPAD_2;
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
	EIF_GET_CONTEXT
	EIF_REFERENCE volatile newadd = NULL;
	volatile long int i;
	jmp_buf exenv;
#ifdef ISE_GC
	char g_status = g_data.status;
#endif
	RTXD;

	REQUIRE ("Positive count", objectCount > 0);

	excatch (&exenv);	/* Record pseudo execution vector */
	if (setjmp (exenv)) {
		rt_clean ();			/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
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
		uint32 crflags, fflags, flags;
		uint32 count;
		int16 old_type;
		EIF_REFERENCE oldadd;
		type_descriptor *conv;

		/* Read address in storing system and object flags (w/dynamic type) */
		ridr_multi_any ((char *) &oldadd, 1);
		ridr_norm_int (&flags);
		rt_id_read_cid (&crflags, &fflags, flags);

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
		g_data.status |= GC_STOP;
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
				object_rread_attributes (NULL, flags, 0L);
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
				old_values = object_rread_attributes (eif_access (new_hector), flags, 0L);
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
		g_data.status = g_status;
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
#ifdef ISE_GC
	epop(&hec_stack, nb_recorded);				/* Pop hector records */
#endif
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

	unsigned long key = ((unsigned long) old) - 1;	/* Key in the hash table */
	unsigned long solved_key;
	long offset;
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
		RTAS(supplier, client);					/* Age check */

		xfree((char *) rt_unsolved);		/* Free reference solving cell */
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

	long nb_references = 0;
	uint32 flags, fflags;
	EIF_REFERENCE reference, addr;
	union overhead *zone = HEADER(new_obj);
	int nb_attr = 0;
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
	struct rt_struct *rt_info;
	unsigned long key = ((unsigned long) reference) - 1;
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
		RTAS(supplier, new_obj);					/* Age check */
	} else {
		/* Reference is stil unsolved */
		struct rt_cell *new_cell, *old_cell;

		new_cell = (struct rt_cell *) xmalloc(sizeof(struct rt_cell), C_T, GC_OFF);
		if (new_cell == (struct rt_cell *)0)
			xraise (EN_MEM);
		new_cell->status = RTU_KEYED;
		new_cell->u.key = ((unsigned long) old) - 1;
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
	EIF_REFERENCE reference = *location;
	unsigned long key = ((unsigned long) reference) - 1;
	struct rt_struct *rt_info = (struct rt_struct *) ht_first (rt_table, key);
	if (rt_info->rt_status == SOLVED) {
		/* Reference is already solved */
		EIF_REFERENCE supplier = eif_access (rt_info->rt_obj);
		*location = supplier;			/* Attachment */
		RTAS(supplier, object);
	} else {
		/* Reference is still unsolved */
		struct rt_cell *new_cell, *old_cell;
		EIF_OBJECT new_hector = hrecord (object);
		nb_recorded++;

		new_cell = (struct rt_cell *) xmalloc (sizeof (struct rt_cell), C_T, GC_OFF);
		if (new_cell == NULL)
			xraise (EN_MEM);
		new_cell->status = RTU_INDIRECTION;
		new_cell->u.rtu_obj = new_hector;
		new_cell->offset = (char *) location - (char *) object;
		old_cell = rt_info->rt_list;
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
		rt_clean();				/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
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


#ifdef RECOVERABLE_SCAFFOLDING
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
		rt_clean();				/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
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
			eise_io("Independent retrieve: unable to read type description.");

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
#endif


#ifdef RECOVERABLE_DEBUG

static char *type2name (long type)
{
	char *name;
	switch (type & SK_HEAD) {
		case SK_EXP:     name = "expanded";       break;
		case SK_BOOL:    name = "BOOLEAN";        break;
		case SK_CHAR:    name = "CHARACTER";      break;
		case SK_INT8:    name = "INTEGER8";       break;
		case SK_INT:     name = "INTEGER";        break;
		case SK_INT16:   name = "INTEGER16";      break;
		case SK_FLOAT:   name = "REAL";           break;
		case SK_WCHAR:   name = "WIDE_CHARACTER"; break;
		case SK_DOUBLE:  name = "DOUBLE";         break;
		case SK_INT64:   name = "INTEGER64";      break;
		case SK_BIT:     name = "BIT";            break;
		case SK_POINTER: name = "POINTER";        break;
		case SK_REF:     name = "REFERENCE";      break;
		default: name = "***UNDEFINED***";        break;
	}
	return name;
}

rt_shared char *name_of_basic_attribute_type (int16 type)
{
	char *result;
	CHECK ("Basic type", type < 0 && type > EXPANDED_LEVEL);
	switch (type) {
		case CHARACTER_TYPE:     result = "CHARACTER";     break;
		case BOOLEAN_TYPE:       result = "BOOLEAN";       break;
		case INTEGER_TYPE:       result = "INTEGER";       break;
		case REAL_TYPE:          result = "REAL";          break;
		case DOUBLE_TYPE:        result = "DOUBLE";        break;
		case BIT_TYPE:           result = "BIT";           break;
		case POINTER_TYPE:       result = "POINTER";       break;
		case NONE_TYPE:          result = "NONE";          break;
		case INTERNAL_TYPE:      result = "INTERNAL";      break;
		case LIKE_ARG_TYPE:      result = "LIKE_ARG";      break;
		case LIKE_CURRENT_TYPE:  result = "like Current";  break;
		case LIKE_PFEATURE_TYPE: result = "LIKE_PFEATURE"; break;
		case LIKE_FEATURE_TYPE:  result = "LIKE_FEATURE";  break;
		case TUPLE_TYPE:         result = "TUPLE";         break;
		case INTEGER_8_TYPE:     result = "INTEGER_8";     break;
		case INTEGER_16_TYPE:    result = "INTEGER_16";    break;
		case INTEGER_64_TYPE:    result = "INTEGER_64";    break;
		default:                 result = "**UNDEFINED**"; break;
	}
	return result;
}

rt_shared char *name_of_attribute_type (int16 **type)
{
	static char buffer [512 + 9];
	char *result;
	int is_expanded = 0;
	int16 dftype = **type;

	if (dftype <= EXPANDED_LEVEL) {
		dftype = EXPANDED_LEVEL - dftype;
		is_expanded = 1;
	}

	if (dftype == TUPLE_TYPE) {
		*type += 3;
		dftype = **type;
		if (dftype <= EXPANDED_LEVEL) {
			dftype = EXPANDED_LEVEL - dftype;
			is_expanded = 1;
		}
	}

	if (dftype >= 0) {
		dftype = RTUD(dftype);
		if (!is_expanded) {
			result = System (dftype).cn_generator;
		} else {
			sprintf (buffer, "expanded %s", System (dftype).cn_generator);
			result = buffer;
		}
	} else if (dftype <= FORMAL_TYPE) {
		sprintf (buffer, "%c", 'F' + FORMAL_TYPE - dftype);
		result = buffer;
	}
	else
		result = name_of_basic_attribute_type (dftype);
	return result;
}

rt_private char *name_of_old_attribute_type (int16 **type)
{
	rt_shared char *name_of_basic_attribute_type (int16 type);
	int16 dftype = **type;
	static char buffer [512 + 9];
	char *result;
	if (dftype >= 0) {
		if (type_conversions->type_index[dftype] == TYPE_UNDEFINED) {
			sprintf (buffer, "NOT_YET_KNOWN (%d)", dftype);
			result = buffer;
		}
		else
			result = type_description (dftype)->name;
	} else if (dftype <= EXPANDED_LEVEL) {
		if (type_conversions->type_index[EXPANDED_LEVEL - dftype] == TYPE_UNDEFINED) {
			sprintf (buffer, "NOT_YET_KNOWN (%d)", EXPANDED_LEVEL - dftype);
			result = buffer;
		}
		else {
			sprintf (buffer, "expanded %s",
					type_description (EXPANDED_LEVEL - dftype)->name);
			result = buffer;
		}
	} else if (dftype == TUPLE_TYPE) {
		(*type) += 3;
		result = "TUPLE";
	} else if (dftype <= FORMAL_TYPE) {
		sprintf (buffer, "%c", 'F' + FORMAL_TYPE - dftype);
		result = buffer;
	}
	else
		result = name_of_basic_attribute_type (dftype);
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
	if (gtype == SK_DTYPE)
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
		case SK_INT8:    result = "INTEGER_8";      break;
		case SK_INT:     result = "INTEGER";        break;
		case SK_INT16:   result = "INTEGER_16";     break;
		case SK_FLOAT:   result = "REAL";           break;
		case SK_WCHAR:   result = "WIDE_CHARACTER"; break;
		case SK_DOUBLE:  result = "DOUBLE";         break;
		case SK_INT64:   result = "INTEGER_64";     break;
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

rt_shared void print_generic_names (struct gt_info *info, int type)
{
	int i;
	printf ("[");
	for (i=0; (unsigned int) info->gt_type[i] != SK_INVALID; ++i)
		if (info->gt_type[i] == type)
			break;

	if ((unsigned int) info->gt_type[i] == SK_INVALID)
		printf ("UNKNOWN_GENERIC_TYPE");
	else {
		int32 *gt_gen = info->gt_gen + i * info->gt_param;
		int j;
		for (j=0; j<info->gt_param; ++j)
			printf ("%s%s", j > 0 ? ", " : "", generic_name (gt_gen[j], 0));
	}
	printf ("]");
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

rt_private int attribute_type_matched (int16 **gtype, int16 **atype)
{
	int result = 1;
	int16 dftype = **gtype;
	int16 aftype = **atype;

	if (dftype <= EXPANDED_LEVEL) {
		if (aftype <= EXPANDED_LEVEL) {
			dftype = EXPANDED_LEVEL - dftype;
			aftype = EXPANDED_LEVEL - aftype;
		} else {
			result = 0;
		}
	}

	if (result && (dftype == TUPLE_TYPE)) {
		if (aftype == TUPLE_TYPE) {
			(*gtype) += 3;
			(*atype) += 3;
			dftype = **gtype;
			aftype = **atype;

			if (dftype <= EXPANDED_LEVEL) {
				if (aftype <= EXPANDED_LEVEL) {
					dftype = EXPANDED_LEVEL - dftype;
					aftype = EXPANDED_LEVEL - aftype;
				} else {
					result = 0;
				}
			}
		} else {
			result = 0;
		}
	}

	if
		((result) && ((dftype == LIKE_FEATURE_TYPE)||(dftype == LIKE_PFEATURE_TYPE) ||
		(dftype == LIKE_ARG_TYPE) || (dftype == LIKE_CURRENT_TYPE)))
	{
		if
			((aftype == LIKE_FEATURE_TYPE)||(aftype == LIKE_PFEATURE_TYPE) ||
			(aftype == LIKE_ARG_TYPE) || (aftype == LIKE_CURRENT_TYPE))
		{
			(*gtype) += 2;
			(*atype) += 2;
			result = attribute_type_matched (gtype, atype);
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
		} else if (dftype < 0  &&  aftype < 0) {
				result = (dftype == aftype);
		} else {
			result = 0;
		}
	}

	return result;
}

rt_private int attribute_types_matched (int16 *gtypes, int16 *atypes)
{
	int result;
	int16 atype = atypes[0];
	if (atype <= EXPANDED_LEVEL)
		atype = EXPANDED_LEVEL - atype;
	if (type_defined (atype) &&
			type_description (atype)->new_dftype != TYPE_UNDEFINED) {
		int16 dftype;
		int i;
		for (i=0; gtypes[i] != TERMINATOR; i++)
			cidarr[i+1] = gtypes[i];
		cidarr[0] = i;
		cidarr [i+1] = -1;
		dftype = eif_compound_id (NULL, 0, cidarr[1], cidarr);
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
	EIF_GET_CONTEXT
	char vis_name[512];
	int old_count, nb_lines, i;
	int bsize = 1024;
	jmp_buf exenv;
	RTXD;

	errno = 0;

	excatch (&exenv);	/* Record pseudo execution vector */
	if (setjmp (exenv)) {
		rt_clean ();			/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
		ereturn (MTC_NOARG);	/* Propagate exception */
	}

	r_buffer = (char*) xmalloc (bsize * sizeof (char), C_T, GC_OFF);
	if (r_buffer == NULL)
		xraise (EN_MEM);

	/* Read the old maximum dyn type */
	if (idr_read_line (r_buffer, bsize) <= 0)
		eise_io ("Independent retrieve: unable to read number of different Eiffel types.");
	if (sscanf (r_buffer,"%d\n", &old_count) != 1)
		eise_io ("Independent retrieve: unable to read number of different Eiffel types.");
	/* create a correspondance table */
	dtypes = (int *) xmalloc (old_count * sizeof(int), C_T, GC_OFF);
	if (dtypes == NULL)
		xraise (EN_MEM);
	spec_elm_size = (uint32 *) xmalloc (old_count * sizeof (uint32), C_T, GC_OFF);
	if (spec_elm_size == NULL)
		xraise (EN_MEM);
	if (idr_read_line (r_buffer, bsize) <= 0)
		eise_io ("Independent retrieve: unable to read OVERHEAD size.");
	if (sscanf (r_buffer,"%d\n", &old_overhead) != 1)
		eise_io ("Independent retrieve: unable to read OVERHEAD size.");

	/* Read the number of lines */
	if (idr_read_line (r_buffer, bsize) <= 0)
		eise_io ("Independent retrieve: unable to read number of header lines.");
	if (sscanf (r_buffer,"%d\n", &nb_lines) != 1)
		eise_io ("Independent retrieve: unable to read number of header lines.");
	type_conversions = new_type_conversion_table (old_count, nb_lines);

	for (i=0; i<nb_lines; i++) {
		type_descriptor *conv;
		attribute_detail *attributes = NULL;
		int dtype, new_dtype = -1;
		int num_attrib;
		int nb_gen;
		char *temp_buf;
		long j;
		int m;

		if (idr_read_line (r_buffer, bsize) <= 0)
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
			int32 *addr = (int32 *) ct_value (&egc_ce_type, vis_name);
			if (addr == NULL)
				new_dtype = -1;		/* Cannot find class name */
			else
				new_dtype = *addr & SK_DTYPE;
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
			struct gt_info *info;
			int j;

			/* Read meta-types */
			conv->generics = (int32 *) xmalloc (nb_gen * sizeof (int32), C_T, GC_OFF);
			if (conv->generics == NULL)
				xraise (EN_MEM);
			conv->generic_count = nb_gen;
			for (j=0; j<nb_gen; j++) {
				long gtype;
				if (sscanf (temp_buf," %ld", &gtype) != 1)
					eise_io ("Independent retrieve: unable to read generic information.");
				conv->generics[j] = gtype;
				temp_buf = next_item (temp_buf);
			}

			info = (struct gt_info *) ct_value (&egc_ce_gtype, vis_name);
			if (info == NULL) {
				new_dtype = -1;		/* Cannot find generic class name */
#ifdef RECOVERABLE_DEBUG
				printf ("Type %d {%s} not in system ***\n", dtype, vis_name);
#endif
			}
			else if (info->gt_param != nb_gen) {
				new_dtype = -1;		/* Generic parameter count does not match */
#ifdef RECOVERABLE_DEBUG
				printf ("Type %d {%s} has different generic parameter count ***\n",
						dtype, vis_name);
#endif
			}
			else {
				int32 *gtypes = conv->generics;
				int32 *t;
				int matched;
				int index;

#ifdef RECOVERABLE_DEBUG
				printf ("Type %d {%s ", dtype, vis_name);
				print_old_generic_names ((int32 *) gtypes, nb_gen);
				printf ("}\n");
#endif
				for (t = info->gt_gen; ; ) {
					if ((unsigned int) *t == SK_INVALID) /* Cannot find good meta-type */
						eraise (vis_name, EN_RETR);
					matched = 1;					/* Assume a perfect match */
#ifdef RECOVERABLE_DEBUG
					printf ("        ? %d {%s ",
							info->gt_type[(t-info->gt_gen)/nb_gen] & SK_DTYPE, vis_name);
					print_generic_names (info, (t-info->gt_gen)/nb_gen);
					printf ("}");
#endif
					for (j=0; j<nb_gen; j++) {
						int32 gt = gtypes[j];
						int32 itype = *t++;
						if (itype != gt)	{ /* Matching done on the fly */
							/* If both types are not expandeds, then no match */
							if (!((itype & SK_EXP) && (gt & SK_EXP)))
								matched = 0;
							/* If dynamic type of expandeds are not equivalent,
							 * then no match */
							else if (type_description (gt & SK_DTYPE)->new_type !=
										(itype & SK_DTYPE))
								matched = 0;
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
				index = (int) ((t - info->gt_gen) / nb_gen);
				new_dtype = info->gt_type[index] & SK_DTYPE;
			}
		}

		dtypes[dtype] = new_dtype;			/* store new type on old type */
		conv->new_type = new_dtype;

		conv->name = (char *) xmalloc (strlen(vis_name)+1, C_T, GC_OFF);
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
					xmalloc (num_attrib * sizeof (attribute_detail), C_T, GC_OFF);
			if (attributes == NULL)
				xraise (EN_MEM);
			conv->attributes = attributes;

			for (j=num_attrib-1; j>=0; j--) {
				if (idr_read_line (r_buffer, bsize) <= 0) {
					xfree ((char *) attributes);
					eise_io ("Independent retrieve: unable to read attribute description.");
				}
				if (sscanf (r_buffer," %lu %s", &att_type, vis_name) != 2) {
					xfree ((char *) attributes);
					eise_io ("Independent retrieve: unable to read attribute description.");
				}
				if (att_type == SK_BIT)
					eraise ("BIT type unsupported", EN_RETR);
				attributes[j].name = (char *) xmalloc (strlen (vis_name) +1, C_T, GC_OFF);
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
	xfree (r_buffer);
	r_buffer = (char*) 0;
	expop (&eif_stack);
}

rt_private int16 map_generics (struct gt_info *info, int16 count, int32 *generics)
{
	int16 result = TYPE_NOT_PRESENT;
	int i;
	/* For each tuple of generic parameters in the list... */
	for (i=0; (unsigned int) info->gt_gen[i] != SK_INVALID; i+=count) {
		int matched = 1;
		int k;
		for (k=0; k<count && matched; k++) {
			/* Compare each generic parameter of current type against each
			 * tuple value of the candidate type.
			 */
			int32 otype = generics[k];
			int32 ntype = info->gt_gen[i+k];
			if ((ntype & SK_EXP) == 0  && (otype & SK_EXP) == 0)
				matched = (ntype == otype);
			else if ((ntype & SK_EXP) && (otype & SK_EXP)) {
				type_descriptor *t = NULL;
				if (type_defined ((int16) (otype & SK_DTYPE)))
					t = type_description (otype & SK_DTYPE);
				if (t != NULL && t->new_type >= 0)
					matched = (t->new_type == (ntype & SK_DTYPE));
				else {
					matched = 0;
					result = TYPE_UNRESOLVED_GENERIC;
				}
			}
			else
				matched = 0;
		}
		if (matched) {					/* We found the type */
			int type_index = i / count;
			result = info->gt_type[type_index] & SK_DTYPE;
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
	int result = 0;
	char *name = class_translation_lookup (conv->name);
	struct gt_info *ginfo = (struct gt_info *) ct_value (&egc_ce_gtype, name);
	if (ginfo != NULL && ginfo->gt_param == conv->generic_count) {
		/* Generic class in storing and retrieving systems */
		int16 orig_value = conv->new_type;
		conv->new_type = map_generics (ginfo, conv->generic_count, conv->generics);
		if (conv->new_type != orig_value)
			result = 1;
		if (conv->new_type == TYPE_UNRESOLVED_GENERIC)
			(*unresolved)++;
	}
	else if (ginfo == NULL) {
		if (strchr (name, '[') != NULL) {
			int16 new_id = eif_type_id (name);
			if (new_id == -1)
				conv->new_type = TYPE_NOT_PRESENT;
			else {
				conv->new_dftype = new_id;
				conv->new_type = Deif_bid (new_id);
			}
			result = 1;
		}
		else {
			/* Non-generic class in storing and retrieving systems */
			int32 *addr = (int32 *) ct_value (&egc_ce_type, name);
			if (addr == NULL)
				conv->new_type = TYPE_NOT_PRESENT;
			else
				conv->new_type = *addr & SK_DTYPE;
			result = 1;
		}
	}
	else {
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
			if (ginfo != NULL && ginfo->gt_param > 0) {
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
	int map_count, unresolved_types;
#ifdef RECOVERABLE_DEBUG
	printf ("-- Mapping types\n");
#endif
	REQUIRE ("Finite types", type_conversions->count > 0);
	do {
		char *last_name;
		int i;
		for (unresolved_types=0, map_count = 0, i=0; i<type_conversions->count; i++) {
			type_descriptor *conv = type_conversions->descriptions + i;
			CHECK ("Old type known", conv->old_type >= 0);
			last_name = conv->name;
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
		for (k=0; k<t->attribute_count && !found; k++)
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
	a->name = (char *) xmalloc (name_length + 1, C_T, GC_OFF);
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
	char *vis_name;
	type_descriptor *conv;
	int16 nb_gen;
	int16 num_attrib;
	int16 name_length;
	int16 dtype;

	ridr_multi_int16 (&name_length, 1);
	vis_name = (char *) xmalloc (name_length + 1, C_T, GC_OFF);
	if (vis_name == NULL)
		xraise (EN_MEM);
	ridr_multi_char ((EIF_CHARACTER *) vis_name, name_length);
	vis_name[name_length] = '\0';
	ridr_multi_int16 (&dtype, 1);
	ridr_multi_int16 (&nb_gen, 1);

	type_conversions->type_index[dtype] = type_index;
	conv = type_conversions->descriptions + type_index;
	CHECK ("Not yet defined", conv->new_type == TYPE_UNDEFINED);
	conv->name = vis_name;
	conv->old_type = dtype;

	/* Determine dynamic type in current system corresponding to type
	 * in storing system */
	if (nb_gen > 0) {
		conv->generics = (int32 *) xmalloc (nb_gen * sizeof (int32), C_T, GC_OFF);
		if (conv->generics == NULL)
			xraise (EN_MEM);
		conv->generic_count = nb_gen;
		ridr_multi_int32 (conv->generics, nb_gen);
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
				xmalloc (num_attrib * sizeof (attribute_detail), C_T, GC_OFF);
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
	EIF_GET_CONTEXT
	int16 ohead, old_max_types, type_count, i;
	jmp_buf exenv;
	RTXD;

	errno = 0;

	excatch (&exenv);	/* Record pseudo execution vector */
	if (setjmp (exenv)) {
		rt_clean ();			/* Clean data structure */
		RTXSC;					/* Restore stack contexts */
		ereturn (MTC_NOARG);	/* Propagate exception */
	}

	ridr_multi_int16 (&ohead, 1);
	old_overhead = ohead;
	ridr_multi_int16 (&old_max_types, 1);
	ridr_multi_int16 (&type_count, 1);
#ifdef RECOVERABLE_DEBUG
	printf ("-- Reading header: %d types\n", type_count);
#endif

	spec_elm_size = (uint32 *) xmalloc (old_max_types * sizeof (uint32), C_T, GC_OFF);
	if (spec_elm_size == NULL)
		xraise (EN_MEM);

	/* create a correspondance table, still needed by rt_id_read_cid() */
	dtypes = (int *) xmalloc (old_max_types * sizeof(int), C_T, GC_OFF);
	if (dtypes == NULL)
		xraise (EN_MEM);

	type_conversions = new_type_conversion_table (old_max_types, type_count);

	for (i=0; i<type_count; i++)
		rread_type (i);

	map_types ();
	map_attributes ();

	expop (&eif_stack);
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

rt_private void gen_object_read (EIF_REFERENCE object, EIF_REFERENCE parent)
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

			num_attrib--;
			attrib_offset = get_alpha_offset(o_type, num_attrib);
			types_cn = *(System(o_type).cn_types + num_attrib);

			switch (types_cn & SK_HEAD) {
				case SK_INT8: buffer_read(object + attrib_offset, sizeof(EIF_INTEGER_8)); break;
				case SK_INT16: buffer_read(object + attrib_offset, sizeof(EIF_INTEGER_16)); break;
				case SK_INT32: buffer_read(object + attrib_offset, sizeof(EIF_INTEGER_32)); break;
				case SK_INT64: buffer_read(object + attrib_offset, sizeof(EIF_INTEGER_64)); break;
				case SK_WCHAR: buffer_read(object + attrib_offset, sizeof(EIF_WIDE_CHAR)); break;
				case SK_FLOAT: buffer_read(object + attrib_offset, sizeof(EIF_REAL)); break;
				case SK_DOUBLE: buffer_read(object + attrib_offset, sizeof(EIF_DOUBLE)); break;
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
							rt_read_cid ((uint32 *) 0, &hflags, old_flags);
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
					rt_read_cid ((uint32 *) 0, &hflags, old_flags);

						/* No need to set `ov_size' or `ov_flags' as it is done while creating
						 * the object */
					gen_object_read (object + attrib_offset, parent);						

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
					case SK_INT8: buffer_read(object, count*sizeof(EIF_INTEGER_8)); break;
					case SK_INT16: buffer_read(object, count*sizeof(EIF_INTEGER_16)); break;
					case SK_INT32: buffer_read(object, count*sizeof(EIF_INTEGER_32)); break;
					case SK_INT64: buffer_read(object, count*sizeof(EIF_INTEGER_64)); break;
					case SK_BOOL:
					case SK_CHAR:
						buffer_read(object, count*sizeof(EIF_CHARACTER));
						break;
					case SK_WCHAR: buffer_read(object, count*sizeof(EIF_WIDE_CHAR)); break;
					case SK_FLOAT: buffer_read(object, count*sizeof(EIF_REAL)); break;
					case SK_DOUBLE: buffer_read(object, count*sizeof(EIF_DOUBLE)); break;
					case SK_EXP: {
						uint32 old_flags, hflags;

						elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ptr);
						buffer_read((char *) &old_flags, sizeof(uint32));
						rt_read_cid ((uint32 *) 0, &hflags, old_flags);
						for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
	
							HEADER(ref)->ov_flags = (hflags & (EO_REF|EO_EXP|EO_COMP|EO_TYPE));
							HEADER(ref)->ov_size = (uint32)(ref - parent);
							gen_object_read (ref, parent);						
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
					rt_read_cid ((uint32 *) 0, &hflags, old_flags);
					elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ptr);
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


rt_private void object_read (EIF_REFERENCE object, EIF_REFERENCE parent)
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

			num_attrib--;

			attrib_offset = get_offset(o_type, attrib_order[num_attrib]);
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
					EIF_REFERENCE l_buffer [1];

					ridr_multi_any ((char *) l_buffer, 1);
					ridr_norm_int (&old_flags);
					rt_id_read_cid ((uint32 *) 0, &hflags, old_flags);

#if DEBUG & 1
					printf ("\n %lx", *((EIF_REFERENCE *)(object + attrib_offset)));
					printf (" %lx", old_flags);
#endif
						/* No need to set `ov_size' or `ov_flags' as it is done while creating
						 * the object */
					object_read (object + attrib_offset, parent);						

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
					case SK_INT8: ridr_multi_int8 ((EIF_INTEGER_8 *)object, count); break;
					case SK_INT16: ridr_multi_int16 ((EIF_INTEGER_16 *)object, count); break;
					case SK_INT32: ridr_multi_int32 ((EIF_INTEGER_32 *)object, count); break;
					case SK_INT64: ridr_multi_int64 ((EIF_INTEGER_64 *)object, count); break;
					case SK_BOOL:
					case SK_CHAR: ridr_multi_char ((EIF_CHARACTER *) object, count); break;
					case SK_WCHAR: ridr_multi_int32 ((EIF_INTEGER_32 *) object, count); break;
					case SK_FLOAT: ridr_multi_float ((EIF_REAL *)object, count); break;
					case SK_DOUBLE: ridr_multi_double ((EIF_DOUBLE *)object, count); break;
					case SK_EXP: {
						uint32  old_flags, hflags;

						elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ptr);
						ridr_norm_int (&old_flags);
						rt_id_read_cid ((uint32 *) 0, &hflags, old_flags);
						for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
							HEADER(ref)->ov_flags = (hflags & (EO_REF|EO_EXP|EO_COMP|EO_TYPE));
							HEADER(ref)->ov_size = (uint32)(ref - parent);
							object_read (ref, parent);						
	
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
					rt_read_cid ((uint32 *) 0, &hflags, old_flags);
					elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(o_ptr);
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

/* Read a non-special object, of type in storing system described by
 * `flags', into `object (possibly offset by `expanded_offset' if object is
 * expanded).
 */
rt_private EIF_REFERENCE object_rread_attributes (
		EIF_REFERENCE object, uint32 flags, long expanded_offset)
{
	EIF_REFERENCE result = NULL;
	EIF_REFERENCE old_values = NULL;
	EIF_REFERENCE comp_values = NULL;
	type_descriptor *conv = type_description (flags & EO_TYPE);
	attribute_detail *attributes = conv->attributes;
	uint32 num_attrib = conv->attribute_count;
	uint32 new_type = conv->new_type;
	uint32 new_num_attrib = System (new_type).cn_nbattr;
	int mismatched = object != NULL && conv->mismatched;
	int i;

	if (num_attrib == 0)
		return NULL;		/* Nothing to read if no attributes */

	REQUIRE ("No GC", g_data.status & GC_STOP);
	REQUIRE ("Attribute order exists", attributes != NULL);
	REQUIRE ("Offset only for expanded", object == NULL  ||
			(HEADER (object)->ov_flags & EO_COMP) || expanded_offset == 0);

#ifdef RECOVERABLE_DEBUG
	if (expanded_offset > 0)
		print_object_summary ("      ", object, expanded_offset, flags);
#endif

	if (mismatched)
	{
		old_values = new_spref (num_attrib);
		if (old_values == NULL)
			xraise (EN_MEM);

		if (HEADER (object)->ov_flags & EO_COMP) {
			comp_values = new_spref (new_num_attrib + 1);
			if (comp_values == NULL)
				xraise (EN_MEM);
			((EIF_REFERENCE *) comp_values)[new_num_attrib] = old_values;
			RTAS_OPT (old_values, i, comp_values);
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
			case SK_FLOAT:
				ridr_multi_float (&value.vreal, 1);
				if (attr_address != NULL)
					*(EIF_REAL *) attr_address = value.vreal;
				if (mismatched) {
					old_value = RTLN (egc_real_ref_dtype);
					*(EIF_REAL *) old_value = value.vreal;
				}
				break;
			case SK_DOUBLE:
				ridr_multi_double (&value.vdbl, 1);
				if (attr_address != NULL)
					*(EIF_DOUBLE *) attr_address = value.vdbl;
				if (mismatched) {
					old_value = RTLN (egc_doub_ref_dtype);
					*(EIF_DOUBLE *) old_value = value.vdbl;
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
				uint32  old_flags, hflags;
				EIF_REFERENCE old_vals = NULL;
				EIF_REFERENCE l_buffer;
				ridr_multi_any ((char *) &l_buffer, 1);
				ridr_norm_int (&old_flags);
				rt_id_read_cid (NULL, &hflags, old_flags);
				if (object == NULL) {
					old_vals = object_rread_attributes (NULL, old_flags, 0L);
					CHECK ("No mismatches", old_vals == NULL);
				}
				else {
					if (mismatched) {
						old_value =
							emalloc (type_description (old_flags & EO_TYPE)->new_type);
					}
					if (attr_address == NULL)
						old_vals = object_rread_attributes (old_value, old_flags, 0L);
					else {
						attr_address = (char *) object +
								expanded_offset + attrib_offset;
						old_vals = object_rread_attributes (
								object, old_flags, expanded_offset + attrib_offset);
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
						if (comp_values == NULL)
							xraise (EN_MEM);
					}
					((EIF_REFERENCE *) comp_values)[new_attrib_index] = old_vals;
					RTAS_OPT (old_vals, i, comp_values);
				}
				break;
			}
			default:
				eise_io ("Recoverable retrieve: not a supported object.");
		}
		if (mismatched && old_value != NULL ) {
			((EIF_REFERENCE *) old_values)[i] = old_value;
			if ((old_attrib_type & SK_HEAD) == SK_REF)
				update_reference (old_values, (EIF_REFERENCE *) old_values + i);
			else
				RTAS_OPT (old_value, i, old_values);
		}
	}
	if (comp_values != NULL)
		result = comp_values;
	else if (old_values != NULL)
		result = old_values;
	return result;
}

/* Read `count' expanded values, each of size `elem_size', into special `object'.
 */
rt_private EIF_REFERENCE object_rread_special_expanded (
		EIF_REFERENCE object, EIF_INTEGER count)
{
	EIF_REFERENCE result = NULL;
	EIF_INTEGER spec_size = RT_SPECIAL_ELEM_SIZE (object);
	type_descriptor *conv;
	uint32 new_type;
	uint32 old_flags, hflags, new_flags;
	int i;

	ridr_norm_int (&old_flags);
	rt_id_read_cid (NULL, &hflags, old_flags);
	conv = type_description (old_flags & EO_TYPE);
	new_type = conv->new_type;
	new_flags = new_type | (old_flags & EO_UPPER);
	if (conv->mismatched)
		result = new_spref (count);
	for (i=0; i<count; i++) {
		EIF_REFERENCE old_values, ref = NULL;
		long offset = 0;
		if (object != NULL) {
			offset = OVERHEAD + (i * spec_size);
			ref = (EIF_REFERENCE)((char *) object + offset);
			HEADER (ref)->ov_flags = (new_flags & (EO_REF|EO_EXP|EO_COMP|EO_TYPE));
			HEADER (ref)->ov_size = (uint32) offset;
		}
		old_values = object_rread_attributes (object, old_flags, offset);
		if (old_values != NULL) {
			CHECK ("Mismatch consistency", old_values != NULL);
			((EIF_REFERENCE *) result)[i] = old_values;
			RTAS_OPT (old_values, i, result);
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
	EIF_REFERENCE result = NULL;
	type_descriptor *conv = type_description (flags & EO_TYPE);
	EIF_REFERENCE addr, trash = NULL;

	CHECK ("Must have generics", conv->generic_count > 0);
	if (object != NULL)
		addr = object;
	else {
		trash = (EIF_REFERENCE) xmalloc (count * sizeof (multi_value), C_T, GC_OFF);
		addr = trash;
	}
	if (!(flags & EO_REF)) {			/* Special of simple types */
		switch (conv->generics[0] & SK_HEAD) {
			case SK_INT8:   ridr_multi_int8   ((EIF_INTEGER_8  *) addr, count); break;
			case SK_INT16:  ridr_multi_int16  ((EIF_INTEGER_16 *) addr, count); break;
			case SK_INT32:  ridr_multi_int32  ((EIF_INTEGER_32 *) addr, count); break;
			case SK_INT64:  ridr_multi_int64  ((EIF_INTEGER_64 *) addr, count); break;
			case SK_BOOL:
			case SK_CHAR:   ridr_multi_char   ((EIF_CHARACTER  *) addr, count); break;
			case SK_WCHAR:  ridr_multi_int32  ((EIF_INTEGER_32 *) addr, count); break;
			case SK_FLOAT:  ridr_multi_float  ((EIF_REAL       *) addr, count); break;
			case SK_DOUBLE: ridr_multi_double ((EIF_DOUBLE     *) addr, count); break;

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
		xfree (trash);

	return result;
}

/* Read a tuple object, of type in storing system described by `flags',
 * consisting of `count' elements, each of size `elem_size', into `object.
 */
rt_private void object_rread_tuple (EIF_REFERENCE object, uint32 count)
{
	EIF_REFERENCE addr, trash = NULL;
	EIF_TYPED_ELEMENT *l_item;
	char l_type;

	if (object != NULL)
		addr = object;
	else {
		trash = (EIF_REFERENCE) xmalloc (count * sizeof (EIF_TYPED_ELEMENT), C_T, GC_OFF);
		addr = trash;
	}

	l_item = (EIF_TYPED_ELEMENT *) addr;
		/* Don't forget that first element of TUPLE is just a placeholder
		 * to avoid offset computation from Eiffel code */
	l_item++;
	count--;
	for (; count > 0; count--, l_item++) {
		ridr_multi_char(&l_type, 1);
		CHECK("Same type", l_type == eif_tuple_item_type(l_item));
		switch (l_type) {
			case EIF_REFERENCE_CODE: ridr_multi_any ((char*) &eif_reference_tuple_item(l_item), 1); break;
			case EIF_BOOLEAN_CODE: ridr_multi_char (&eif_boolean_tuple_item(l_item), 1); break;
			case EIF_CHARACTER_CODE: ridr_multi_char (&eif_character_tuple_item(l_item), 1); break;
			case EIF_DOUBLE_CODE: ridr_multi_double (&eif_double_tuple_item(l_item), 1); break;
			case EIF_REAL_CODE: ridr_multi_float (&eif_real_tuple_item(l_item), 1); break;
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

	if (trash != NULL)
		xfree (trash);
}

rt_private int char_read(char *pointer, int size)
{
	RT_GET_CONTEXT
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

/*
doc:</file>
*/
