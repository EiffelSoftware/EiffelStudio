/*
  ####   ######   ####      #    #               #    #
 #    #  #       #    #     #    #               #    #
 #       #####   #          #    #               ######
 #       #       #          #    #        ###    #    #
 #    #  #       #    #     #    #        ###    #    #
  ####   ######   ####      #    ######   ###    #    #

	Definitions and macros for the C-Eiffel Call-In Library.
*/

#ifndef _eif_cecil_h_
#define _eif_cecil_h_

#include "eif_plug.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Main declarations (should be user visible)
 */

/* Macros to remap cryptic names to meaningful ones. Note that the
 * interface defined in ETL uses the remaped names. Only this interface
 * is guaranteed.
 */

/*
 * Specific Cecil types.
 */ 

typedef char *			EIF_OBJECT;			/* Eiffel object: safe indirecteion to an Eiffel reference */
typedef struct bit *	EIF_BIT;			/* Structure used for bits */
typedef int32			EIF_TYPE_ID;		/* Type handled by Cecil */

#define eif_create			eifcreate		/* Object creation */
#define eif_expand			eifexp			/* Force expanded class ID */


/* Macros returning the address of an Eiffel routine. If it fails,
 * it returns a NULL pointer or raises an Visible exception, if 
 * enabled
 */

#define eif_procedure	eifproc			/* Get an Eiffel procedure */
#define eif_integer_function	eiflong			/* Get an Eiffel function */
#define eif_character_function	eifchar	/* Get an Eiffel function returning an Eiffel Character */
#define eif_real_function	eifreal	/* Get an Eiffel function returning an Eiffel Real */
#define eif_double_function	eifdouble	/* Get an Eiffel function returning an Eiffel Double */
#define eif_reference_function	eifref	/* Get an Eiffel function returning an Eiffel Reference */
#define eif_boolean_function	eifbool	/* Get an Eiffel function returning an Eiffel Boolean */
#define eif_bit_function	eifbit	/* Get an Eiffel function returning an Eiffel Bit */
#define eif_pointer_function	eifptr	/* Get an Eiffel function returning an Eiffel Pointer */

/*
 * Miscellaneous Macros
 */

#define eif_type			eiftype			/* Dynamic type ID */
#define eif_name			eifname			/* Reverts class ID to name */
#define eif_bit_clone		eifbcln			/* Clones a bit structure */
#define eif_attribute_type    eifattrtype           /* Get the type of an attribute, returns EIF_NO_TYPE if fails */
#define eif_locate  eiflocate   /* Return index of a given attribute in a given object */

/*
 * Aliases
 */

#define eif_type_by_name	eif_type_id
#define eif_name_by_tid		eif_name

/* 
 * Cecil exception settings
 */

#define eif_enable_visible_exception   eifvisex /* When a class or a feature is not visible, raise an exception */
#define eif_disable_visible_exception eifuvisex /* Disable the visible exception */

/* Types defined for easier reference when dealing with function pointers.
 * Their use is not compulsory it's only a matter of "convenience".
 * They do not guarantee the type checking of the parameters
 * passed as arguments.	
 */

typedef void	(*EIF_PROCEDURE)(EIF_REFERENCE, ...);		/* Returns void */
typedef EIF_INTEGER	(*EIF_INTEGER_FUNCTION)(EIF_REFERENCE, ...);		/* Returns an Eiffel Integer */
typedef EIF_BOOLEAN	(*EIF_BOOLEAN_FUNCTION)(EIF_REFERENCE, ...);		/* Returns an Eiffel Boolean */
typedef EIF_CHARACTER	(*EIF_CHARACTER_FUNCTION)(EIF_REFERENCE, ...);		/* Returns char */
typedef EIF_REAL	(*EIF_REAL_FUNCTION)(EIF_REFERENCE, ...);	/* Returns an Eiffel Real */
typedef EIF_DOUBLE	(*EIF_DOUBLE_FUNCTION)(EIF_REFERENCE, ...);	/* Returns an Eiffel Double */
typedef EIF_REFERENCE (*EIF_REFERENCE_FUNCTION)(EIF_REFERENCE, ...);		/* Returns an Eiffel Reference */
typedef EIF_POINTER (*EIF_POINTER_FUNCTION)(EIF_REFERENCE, ...);	/* Returns an Eiffel Pointer */
typedef EIF_BIT	(*EIF_BIT_FUNCTION)(EIF_REFERENCE, ...);	/* Returns an Eiffel Bits */

/* 
 * Convention for attribute types
 */

#define EIF_POINTER_TYPE	0
#define EIF_REFERENCE_TYPE	1
#define EIF_CHARACTER_TYPE	2
#define EIF_BOOLEAN_TYPE	3
#define EIF_INTEGER_TYPE	4
#define EIF_INTEGER_32_TYPE	4
#define EIF_REAL_TYPE		5
#define EIF_DOUBLE_TYPE		6
#define EIF_EXPANDED_TYPE	7
#define EIF_BIT_TYPE		8
#define EIF_INTEGER_8_TYPE	9
#define EIF_INTEGER_16_TYPE	10
#define EIF_INTEGER_64_TYPE 11
#define EIF_WIDE_CHAR_TYPE	12



/* Accessing an attribute in read/write mode (this is both an lvalue and
 * a rvalue). The 'type' is the C type of the attribute being accessed. It
 * must be correct or havoc will result. It can't be used to access bits
 * because of the lack of bit type in C. 
 * Attention! It returns an EIF_REFERENCE, which might be obsolete after a
 * GC collection.
 */
#define attribute_exists(object,name) \
	(eif_locate (object, name) == -1)? EIF_FALSE : EIF_TRUE
#define eif_field(object,name,type) *(type *)(eifaddr(object,name, NULL))	/* Obsolete. Use "eif_attribute" instead. */
#define eif_attribute(object,name,type,ret) *(type *)(eifaddr(object,name,ret)) /* Returns the attribute of an object. Return status in "ret".*/

#define eif_attribute_safe(object,name,type_int,ret) eif_field_safe(object, name, type_int, ret)	/* For debugging: check type. Must be preceded by *(EIF_TYPE*) */

/* Miscellaneous useful functions. */

/* Make an Eiffel array from a C array:
 * `eif_array' is the direct reference to the Eiffel array.
 * `c_array' is the C array.
 * `nelts' the number of elements to copy in the eiffel array, it has to
 * be equal to `eif_array.count'.
 * type is an Eiffel type.
 */
#define eif_make_from_c(eif_array, c_array, nelts, type) \
	{ \
		EIF_REFERENCE area = eif_field (eif_array, \
										"area", EIF_REFERENCE); \
		memcpy ((type *) area, c_array, nelts * sizeof (type));\
	}

/* Accessing bits is done via special macros, because they have no counterpart
 * in C. We provide macros for reading and writing bit fields in an Eiffel
 * object, as well as macros to handle the EIF_BIT type.
 */
#define eif_bit_attribute		eifgbit			/* Return EIF_BIT attribute */
#define eif_bit_set_attribute	eifsbit			/* Copy supplied bit into another */
#define eif_bit_length(x)	(x)->b_length	/* Length of EIF_BIT item */
#define eif_bit_ith			eifibit			/* Value of the ith bit */
#define eif_bit_set			eifsibit		/* Set ith bit to 1 */
#define eif_bit_clear		eifribit		/* Reset ith bit to 0 */

/*
 * Creation an Eiffel string.
 */

#define	eif_string(x) RTMS(x)	
		/* Create an Eiffel string from a C string `x' */

/* 
 * Error report codes 
 */

#define EIF_NO_TYPE			(-1)			/* No type associated to a name */
#define EIF_NO_BIT_FIELD		((EIF_BIT) 0)	/* No bit field associated */
#define EIF_NO_BIT			2				/* Indexing a bit out of range */
#define EIF_NO_ATTRIBUTE	(-1)			/* No attribute found */
#define EIF_WRONG_TYPE	(-2)			/* Wrong type */
#define EIF_CECIL_OK	(0)			/* Function returned successfully. */
#define EIF_CECIL_ERROR	(1)			/* Function returned unsuccessfully. */

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
 * The array gt_gen holds patterns like [INTEGER, REFERENCE] in an unstructured
 * way (i.e. they are simply gathered in a whole array, for static intialization
 * purposes). The end of the array is signaled by a *single* SK_INVALID marker.
 * All the types are skeleton types as declared in eif_struct.h. For references,
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
 * 	Obsolete Macros  
 */

#define eif_proc			eifproc			/* Get an Eiffel procedure (Obsolete) use `eif_procedure' instead */
#define eif_fn_int			eiflong			/* Use `eif_integer_function' instead */
#define eif_fn_char		eifchar	/* Use `eif_character_function' instead */
#define eif_fn_float	eifreal	/* Use `eif_real_function' instead */
#define eif_fn_double	eifdouble	/* Use `eif_double_function' instead */
#define eif_fn_ref			eifref	/* Use `eif_reference_function' instead */
#define eif_fn_bool			eifbool	/* Use `eif_boolean_function' instead */
#define eif_fn_bit			eifbit	/* Use `eif_bit_function' instead */
#define eif_fn_pointer		eifptr	/* Use `eif_pointer_function' instead */



#define EIF_PROC EIF_PROCEDURE		/* Use EIF_PROCEDURE instead */
#define EIF_FN_INT EIF_INTEGER_FUNCTION		/* Use EIF_INTEGER_FUNCTION instead */
#define EIF_FN_BOOL EIF_BOOLEAN_FUNCTION		/* Use EIF_BOOLEAN_FUNCTION instead*/
#define EIF_FN_CHAR EIF_CHARACTER_FUNCTION		/* Use EIF_CHARACTER_FUNCTION instead  */
#define EIF_FN_FLOAT EIF_REAL_FUNCTION	/* Use EIF_REAL_FUNCTION instead */
#define EIF_FN_DOUBLE EIF_DOUBLE_FUNCTION	/* Use EIF_DOUBLE_FUNCTION instead */
#define EIF_FN_REF EIF_REFERENCE_FUNCTION /* use EIF_REFERENCE_FUNCTION instead */
#define EIF_FN_POINTER EIF_POINTER_FUNCTION	/* Use EIF_POINTER_FUNCTION instead */
#define EIF_FN_BIT EIF_BIT_FUNCTION	/*  Use EIF_BIT_FUNCTION instead */


#define	EIF_OBJ	EIF_OBJECT						/* Use EIF_OBJECT instead */
#define eif_bit_attr		eifgbit			/* Return EIF_BIT attribute */
#define eif_bit_set_attr	eifsbit			/* Copy supplied bit into another */

#define EIF_NO_BFIELD		((EIF_BIT) 0)	/* No bit field associated */

/*
 * Functions and variables declarations.
 */

/* The ce_rname is indexed by dynamic type (i.e. it won't work on simple
 * types). Only the SK_DTYPE part of the type_id is kept for the intersection.
 */

#ifndef WORKBENCH
extern struct ctable fce_rname[];		/* Routine names -> function pointer */
#endif

RT_LNK  void eifvisex (void);          /* Enable the visible exception (in current thread) */
RT_LNK void eifuvisex (void);          /* Disable visible exception (in current thread) */
RT_LNK int eifattrtype (char *attr_name, EIF_TYPE_ID cid);
										/* Type of `attr_name' from class id `cid' */
RT_LNK EIF_TYPE_ID eifcid(char *class_name);		     /* Get a class ID */
RT_LNK EIF_TYPE_ID eifexp(EIF_TYPE_ID id);			/* Force expansion */

RT_LNK EIF_OBJECT eifcreate(EIF_TYPE_ID cid);				/* Object creation */

RT_LNK EIF_PROCEDURE eifproc(char *routine, EIF_TYPE_ID cid);				/* Pointer to Eiffel procedure */
RT_LNK EIF_INTEGER_FUNCTION eiflong(char *routine, EIF_TYPE_ID cid);			/* Eiffel function returning INTEGER */
RT_LNK EIF_CHARACTER_FUNCTION eifchar(char *routine, EIF_TYPE_ID cid);			/* Eiffel function returning CHAR */
RT_LNK EIF_REAL_FUNCTION eifreal(char *routine, EIF_TYPE_ID cid);			/* Eiffel function returning REAL */
RT_LNK EIF_DOUBLE_FUNCTION eifdouble(char *routine, EIF_TYPE_ID cid);		/* Eiffel function returning DOUBLE */
RT_LNK EIF_BIT_FUNCTION eifbit(char *routine, EIF_TYPE_ID cid);				/* Eiffel function returning BIT */
RT_LNK EIF_BOOLEAN_FUNCTION eifbool(char *routine, EIF_TYPE_ID cid);			/* Eiffel function returning BOOLEAN */
RT_LNK EIF_POINTER_FUNCTION eifptr(char *routine, EIF_TYPE_ID cid);			/* Eiffel function returning POINTER */
RT_LNK EIF_REFERENCE_FUNCTION eifref(char *routine, EIF_TYPE_ID cid);				/* Eiffel function returning ANY */

RT_LNK EIF_TYPE_ID eiftype(EIF_OBJECT object);					/* Give dynamic type of EIF_OBJECT. Obsoletem, use "eif_type_by_object". */
RT_LNK EIF_TYPE_ID eif_type_by_object (EIF_REFERENCE object);					/* Give dynamic type of EIF_OBJECT */
RT_LNK char *eifname(EIF_TYPE_ID cid);					/* Give class name from class ID */
RT_LNK void *eif_field_safe (EIF_REFERENCE object, char *name, int type_int, int * const ret);					/* Safely Compute address of attribute, checking type validityi. Must be preceded by *(EIF_TYPE*). */
RT_LNK void *old_eifaddr(EIF_REFERENCE object, char *name);					/* Compute address of attribute. Old version. */
RT_LNK void *eifaddr(EIF_REFERENCE object, char *name, int * const ret);					/* Compute address of attribute */
RT_LNK EIF_BIT eifgbit(EIF_REFERENCE object, char *name);				/* Get a bit field structure */
RT_LNK void eifsbit(EIF_REFERENCE object, char *name, EIF_BIT bit);					/* Set a bit field structure */
RT_LNK char eifibit(EIF_BIT bit, int i);					/* Access ith bit in bit field */
RT_LNK int eifsibit(EIF_BIT bit, int i);					/* Set ith bit to 1 */
RT_LNK int eifribit(EIF_BIT bit, int i);					/* Reset ith bit to 0 */
RT_LNK EIF_BIT eifbcln(EIF_BIT bit);				/* Eiffel bit cloning */

/* Dynamic Type id of an object of type `type_string' */
RT_LNK EIF_TYPE_ID eif_type_id (char *type_string);

RT_LNK int eiflocate(EIF_OBJECT object, char *name); /* Return the index of attribute `name' in EIF_OBJECT `object'*/


/* 
 * Initialization 
 */

RT_LNK void  failure(void);					/* The Eiffel exectution failed */
RT_LNK void eif_rtinit(int argc, char **argv, char **envp);				/* Eiffel run-time initialization */

#ifndef WORKBENCH
#define Cecil(x)	egc_ce_rname[x]			/* Final mode acces to hash table */
#else
#define Cecil(x)	System(x).cn_cecil	/* Workbench mode access */
#endif

extern char *ct_value(struct ctable *ct, register char *key);				/* Hash table query */

#ifdef EIF_THREADS
/* 
 * Initialization in MT mode. 
 */

RT_LNK void  eif_cecil_init ();	
RT_LNK void eif_cecil_reclaim ();

/*
 * Initialization of non Eiffel Threads.
 */

RT_LNK void eif_set_thr_context ();

#endif	/* EIF_THREADS */

#ifdef __cplusplus
}
#endif

#endif
