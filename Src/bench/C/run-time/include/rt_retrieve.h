/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
	Declarations for retrieve mechanism.
*/

#ifndef _rt_retrieve_h_
#define _rt_retrieve_h_

#include "eif_retrieve.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * In case of an unsolved reference, a structure rt_cell contain the
 * description of it, i.e the key in the hash table where the parent 
 * object is plus the offset where the unsolved reference is.
 */
typedef enum {RTU_KEYED, RTU_INDIRECTION} rt_unsolved_t;
struct rt_cell {
	struct rt_cell *next;
	size_t offset;
	rt_unsolved_t status;
	union {
		rt_uint_ptr key;		/* key of SOLVED record when `status' == RTU_KEYED */
		EIF_OBJECT rtu_obj;		/* hector reference when `status' == RTU_INDIRECTION */
	} u;
};

/*
 * Item structure of the hash table used for solving ahead references
 */	
typedef enum {UNSOLVED, SOLVED, DROPPED} rt_status_t;
struct rt_struct {
	rt_status_t rt_status;			/* Is the reference solved or not ? */
	union {
		EIF_OBJECT rtu_obj;			/* status=SOLVED:   Hector reference */
		struct rt_cell  *rtu_cell;	/* status=UNSOLVED: Detail about location to change */
		int16 old_type;				/* status=DROPPED:  Type not in current system */
	} rtu_data; 
};

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
		/* Pointer to array of class translation entries */
	class_translation *table;

		/* Maximum number of entries in `translations'. */
	unsigned int max_count;

		/* Number of entries in `translations'. */
	unsigned int count;
} class_translations_table;	/* Table of class name translations */

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

		/* Skeleton flags in storing system. */
	uint16 flags;

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
	uint16 generic_count;

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

#define rt_list 	rtu_data.rtu_cell
#define rt_obj		rtu_data.rtu_obj


extern EIF_REFERENCE ise_compiler_retrieve (EIF_INTEGER f_desc, EIF_INTEGER a_pos, size_t (*ret_func) (void));

extern struct htable *rt_table;	/* Table used for solving references */
extern int32 nb_recorded;		/* Number of items recorded in Hector */
extern char rt_kind;
extern char rt_kind_version;
extern size_t end_of_buffer;

extern size_t (*retrieve_read_func)(void);

/*
 * Utilities
 */

extern char *rt_make(void);			/* Retrieve object graph */
extern char *rt_nmake(EIF_CONTEXT long int objectCount);		/* Retrieve `n' objects */

extern size_t old_retrieve_read(void);
extern size_t retrieve_read(void);

extern size_t old_retrieve_read_with_compression(void);
extern size_t retrieve_read_with_compression(void);

extern void rt_init_retrieve(size_t (*retrieve_function) (void), int (*char_read_function)(char *, int), int buf_size);
extern void rt_reset_retrieve(void);

extern int (*char_read_func)(char *, int);

#ifdef EIF_THREADS
extern void eif_retrieve_thread_init (void);
#endif


#ifdef __cplusplus
}
#endif

#endif
