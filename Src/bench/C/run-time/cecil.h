/*

  ####   ######   ####      #    #               #    #
 #    #  #       #    #     #    #               #    #
 #       #####   #          #    #               ######
 #       #       #          #    #        ###    #    #
 #    #  #       #    #     #    #        ###    #    #
  ####   ######   ####      #    ######   ###    #    #

	Definitions and macros for the C-Eiffel Call-In Library.
*/

#ifndef _cecil_h_
#define _cecil_h_

#include "plug.h"

/*
 * Main declarations (should be user visible)
 */

/* Macros to remap cryptic names to meaningful ones. Note that the
 * interface defined in ETL uses the remaped names. Only this interface
 * is guaranteed.
 */
#define eif_create			eifcreate		/* Object creation */
#define eif_type_id			eifcid			/* Get class ID */
#define eif_expand			eifexp			/* Force expanded class ID */
#define eif_generic_id		eifgid			/* Get class ID for generic types */
#define eif_proc			eifproc			/* Get an Eiffel procedure */
#define eif_fn_int			eiflong			/* Get an Eiffel function */
#define eif_fn_char			eifchar
#define eif_fn_float		eifreal
#define eif_fn_double		eifdouble
#define eif_fn_ref			eifref
#define eif_fn_bool			eifbool
#define eif_fn_bit			eifbit
#define eif_fn_pointer		eifptr
#define eif_type			eiftype			/* Dynamic type ID */
#define eif_name			eifname			/* Reverts class ID to name */
#define eif_bit_clone		eifbcln			/* Clones a bit structure */

/* Types defined for easier reference when dealing with function pointers.
 * Their use is not compulsory it's only a matter of "convenience"--RAM.
 * (I mean, within the run-time source, of course. However, sometimes it makes
 * things a lot easier to grasp--see hector.c for instance.)
 */
typedef void			(*EIF_PROC)();		/* Function returning void */
typedef long			(*EIF_FN_INT)();	/* Function returning long */
typedef char			(*EIF_FN_BOOL)();	/* Function returning boolean */
typedef char			(*EIF_FN_CHAR)();	/* Function returning char */
typedef float			(*EIF_FN_FLOAT)();	/* Function returning float */
typedef double			(*EIF_FN_DOUBLE)();	/* Function returning double */
typedef char *			(*EIF_FN_REF)();	/* Function returning reference */
typedef char *			(*EIF_FN_POINTER)();	/* Function returning pointer */
typedef struct bit *	(*EIF_FN_BIT)();	/* Function returning bits */
typedef char *			EIF_OBJ;			/* Object through hector tables */
typedef struct bit *	EIF_BIT;			/* Structure used for bits */
typedef int32			EIF_TYPE_ID;		/* Type handled by Cecil */

/* Accessing an attribute in read/write mode (this is both an lvalue and
 * a rvalue). The 'type' is the C type of the attribute being accessed. It
 * must be correct or havoc will result. It can't be used to access bits
 * because of the lack of bit type in C.
 */
#define eif_field(object,name,type)	*(type *)(eifaddr(object,name))

/* Accessing bits is done via special macros, because they have no counterpart
 * in C. We provide macros for reading and writing bit fields in an Eiffel
 * object, as well as macros to handle the EIF_BIT type.
 */
#define eif_bit_attr		eifgbit			/* Return EIF_BIT attribute */
#define eif_bit_set_attr	eifsbit			/* Copy supplied bit into another */
#define eif_bit_length(x)	(x)->b_length	/* Length of EIF_BIT item */
#define eif_bit_ith			eifibit			/* Value of the ith bit */
#define eif_bit_set			eifsibit		/* Set ith bit to 1 */
#define eif_bit_clear		eifribit		/* Reset ith bit to 0 */

/* Maps an Eiffel type on a C type (for use in eif_field) */
typedef long			EIF_INTEGER;
typedef unsigned char	EIF_CHARACTER;
typedef float			EIF_REAL;
typedef double			EIF_DOUBLE;
typedef char *			EIF_REFERENCE;
typedef char *			EIF_POINTER;
typedef unsigned char	EIF_BOOLEAN;

/* Error report codes */
#define EIF_NO_TYPE			(-1)			/* No type associated to a name */
#define EIF_NO_BFIELD		((EIF_BIT) 0)	/* No bit field associated */
#define EIF_NO_BIT			2				/* Indexing a bit out of range */

/*
 * Structures used by Cecil (aka private informations)
 */

/* This is the structure which describes the hash table index by strings: the
 * array of keys and the array of values, along with the table's size and the
 * number of recorded elements.
 */
struct ctable {
	int32 h_size;		/* Size of table (prime number) */
	int h_sval;			/* Size of each value item, in bytes */
	char **h_keys;		/* Array of keys (pointer to an array of strings) */
	char *h_values;		/* Array of values (pointer needs casting) */
};

/* Information on generic types. The structure records the number of generic
 * parameters and an array which gives the type ids for every possible meta-
 * type as defined in the compiler (i.e. simple types plus expandeds).
 * The array gt_gen holds patterns like [INTERGER, REFERENCE] in an unstructured
 * way (i.e. they are simply gathered in a whole array, for static intialization
 * purposes). The end of the array is signaled by a *single* SK_INVALID marker.
 * All the types are skeleton types as declared in struct.h. For references,
 * we don't need the dynamic type, so we simply use SK_DTYPE.
 * The gt_type array then lists the associated types (entry at "index" i in
 * gt_gen is associated to the same index i in gt_type).
 */
struct gt_info {
	int gt_param;		/* Number of generic parameters */
	int32 *gt_gen;		/* Generic parameters patterns */
	int16 *gt_type;		/* Type ID associated with each meta-type */
};

/*
 * Functions and variables declarations.
 */

/* The ce_rname is indexed by dynamic type (i.e. it won't work on simple
 * types). Only the SK_DTYPE part of the type_id is kept for the intersection.
 */

#ifndef WORKBENCH
extern struct ctable ce_rname[];		/* Routine names -> function pointer */
#endif

extern struct ctable ce_type;			/* Class name -> type ID */
extern struct ctable ce_gtype;			/* Generic class name -> gt_info */

extern EIF_TYPE_ID eifcid();			/* Get a class ID */
extern EIF_TYPE_ID eifexp();			/* Force expansion */

#ifdef I_STDARG
extern EIF_TYPE_ID eifgid(char *class_name, ...);	/* Get a generic class ID */
#else
extern EIF_TYPE_ID eifgid();					/* Get a generic class ID */
#endif

extern EIF_OBJ eifcreate();				/* Object creation */

extern EIF_PROC eifproc();				/* Pointer to Eiffel procedure */
extern EIF_FN_INT eiflong();			/* Eiffel function returning INTEGER */
extern EIF_FN_CHAR eifchar();			/* Eiffel function returning CHAR */
extern EIF_FN_FLOAT eifreal();			/* Eiffel function returning REAL */
extern EIF_FN_DOUBLE eifdouble();		/* Eiffel function returning DOUBLE */
extern EIF_FN_BIT eifbit();				/* Eiffel function returning BIT */
extern EIF_FN_BOOL eifbool();			/* Eiffel function returning BOOLEAN */
extern EIF_FN_POINTER eifptr();			/* Eiffel function returning POINTER */
extern EIF_FN_REF eifref();				/* Eiffel function returning ANY */

extern int eiftype();					/* Give dynamic type of EIF_OBJ */
extern char *eifname();					/* Give class name from class ID */
extern char *eifaddr();					/* Compute address of attribute */
extern EIF_BIT eifgbit();				/* Get a bit field structure */
extern void eifsbit();					/* Set a bit field structure */
extern char eifibit();					/* Access ith bit in bit field */
extern int eifsibit();					/* Set ith bit to 1 */
extern int eifribit();					/* Reset ith bit to 0 */
extern EIF_BIT eifbcln();				/* Eiffel bit cloning */

#ifndef WORKBENCH
#define Cecil(x)	ce_rname[x]			/* Final mode acces to hash table */
#else
#define Cecil(x)	System(x).cn_cecil	/* Workbench mode access */
#endif

extern char *ct_value();				/* Hash table query */

#endif
