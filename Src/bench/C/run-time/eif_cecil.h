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

#define EIF_REFERENCE_TYPE  1
#define EIF_CHARACTER_TYPE  2
#define EIF_BOOLEAN_TYPE    3
#define EIF_INTEGER_TYPE    4
#define EIF_REAL_TYPE       5
#define EIF_DOUBLE_TYPE     6
#define EIF_EXPANDED_TYPE   7
#define EIF_BIT_TYPE        8
#define EIF_POINTER_TYPE    0

#define eif_create			eifcreate		/* Object creation */
#define eif_expand			eifexp			/* Force expanded class ID */
#define eif_proc			eifproc			/* Get an Eiffel procedure */
#define eif_fn_int			eiflong			/* Get an Eiffel function */
#define eif_fn_char			eifchar
#define eif_fn_float		eifreal
#define eif_fn_double		eifdouble
#define eif_fn_ref			eifref
#define eif_fn_bool			eifbool
#define eif_fn_bit			eifbit
#define eif_fn_pointer		eifptr
#define	eif_routine			eifrout	/*  Get the pointer to the Eiffel routine */
#define eif_type			eiftype			/* Dynamic type ID */
#define eif_name			eifname			/* Reverts class ID to name */
#define eif_bit_clone		eifbcln			/* Clones a bit structure */
#define eif_enable_visible_exception   eifvisex /* When a class is not visible, raise an exception */
#define eif_disable_visible_exception eifuvisex /* Disable the visible exception */
#define eif_return_type    eifreturntype           /* Get the return type of feature, 0 if procedure */

/* Types defined for easier reference when dealing with function pointers.
 * Their use is not compulsory it's only a matter of "convenience"--RAM.
 * (I mean, within the run-time source, of course. However, sometimes it makes
 * things a lot easier to grasp--see hector.c for instance.)
 */
typedef void	(*EIF_PROC)(EIF_REFERENCE, ...);		/* Returns void */
typedef long	(*EIF_FN_INT)(EIF_REFERENCE, ...);		/* Returns long */
typedef char	(*EIF_FN_BOOL)(EIF_REFERENCE, ...);		/* Returns boolean */
typedef char	(*EIF_FN_CHAR)(EIF_REFERENCE, ...);		/* Returns char */
typedef float	(*EIF_FN_FLOAT)(EIF_REFERENCE, ...);	/* Returns float */
typedef double	(*EIF_FN_DOUBLE)(EIF_REFERENCE, ...);	/* Returns double */
typedef char *	(*EIF_FN_REF)(EIF_REFERENCE, ...);		/* Returns reference */
typedef char *	(*EIF_FN_POINTER)(EIF_REFERENCE, ...);	/* Returns pointer */
typedef struct bit*	(*EIF_FN_BIT)(EIF_REFERENCE, ...);	/* Returns bits */

typedef char *			EIF_OBJ;			/* Object through hector tables */
typedef struct bit *	EIF_BIT;			/* Structure used for bits */
typedef int32			EIF_TYPE_ID;		/* Type handled by Cecil */

/* Accessing an attribute in read/write mode (this is both an lvalue and
 * a rvalue). The 'type' is the C type of the attribute being accessed. It
 * must be correct or havoc will result. It can't be used to access bits
 * because of the lack of bit type in C.
 */
#define eif_field(object,name,type)	*(type *)(eifaddr(object,name))
#define eif_locate  eiflocate   /* Return index of a given attribute in a given object */

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
RT_LNK int eifreturntype (char *class_name, EIF_TYPE_ID cid);
										/* Return type of `cid' from `class_name' */
RT_LNK EIF_TYPE_ID eifcid(char *class_name);		     /* Get a class ID */
RT_LNK EIF_TYPE_ID eifexp(EIF_TYPE_ID id);			/* Force expansion */

RT_LNK EIF_OBJ eifcreate(EIF_TYPE_ID cid);				/* Object creation */

RT_LNK EIF_PROC eifproc(char *routine, EIF_TYPE_ID cid);				/* Pointer to Eiffel procedure */
RT_LNK EIF_FN_INT eiflong(char *routine, EIF_TYPE_ID cid);			/* Eiffel function returning INTEGER */
RT_LNK EIF_FN_CHAR eifchar(char *routine, EIF_TYPE_ID cid);			/* Eiffel function returning CHAR */
RT_LNK EIF_FN_FLOAT eifreal(char *routine, EIF_TYPE_ID cid);			/* Eiffel function returning REAL */
RT_LNK EIF_FN_DOUBLE eifdouble(char *routine, EIF_TYPE_ID cid);		/* Eiffel function returning DOUBLE */
RT_LNK EIF_FN_BIT eifbit(char *routine, EIF_TYPE_ID cid);				/* Eiffel function returning BIT */
RT_LNK EIF_FN_BOOL eifbool(char *routine, EIF_TYPE_ID cid);			/* Eiffel function returning BOOLEAN */
RT_LNK EIF_FN_POINTER eifptr(char *routine, EIF_TYPE_ID cid);			/* Eiffel function returning POINTER */
RT_LNK  EIF_POINTER eifrout (EIF_OBJ rout_name, EIF_OBJ class_name);
    /* Get the pointer to the Eiffel routine described by its 
     * name `rout_name' and its class `class_name'
     */
RT_LNK EIF_FN_REF eifref(char *routine, EIF_TYPE_ID cid);				/* Eiffel function returning ANY */

RT_LNK int eiftype(EIF_OBJ object);					/* Give dynamic type of EIF_OBJ */
RT_LNK char *eifname(EIF_TYPE_ID cid);					/* Give class name from class ID */
RT_LNK char *eifaddr(char *object, char *name);					/* Compute address of attribute */
RT_LNK EIF_BIT eifgbit(char *object, char *name);				/* Get a bit field structure */
RT_LNK void eifsbit(char *object, char *name, EIF_BIT bit);					/* Set a bit field structure */
RT_LNK char eifibit(EIF_BIT bit, int i);					/* Access ith bit in bit field */
RT_LNK int eifsibit(EIF_BIT bit, int i);					/* Set ith bit to 1 */
RT_LNK int eifribit(EIF_BIT bit, int i);					/* Reset ith bit to 0 */
RT_LNK EIF_BIT eifbcln(EIF_BIT bit);				/* Eiffel bit cloning */


RT_LNK int eiflocate(EIF_OBJ object, char *name); /* Return the index of attribute `name' in EIF_OBJ `object'*/


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

#ifdef __cplusplus
}
#endif

#endif
