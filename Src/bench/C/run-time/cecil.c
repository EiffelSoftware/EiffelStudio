/*

  ####   ######   ####      #    #                ####
 #    #  #       #    #     #    #               #    #
 #       #####   #          #    #               #
 #       #       #          #    #        ###    #
 #    #  #       #    #     #    #        ###    #    #
  ####   ######   ####      #    ######   ###     ####


	C-Eiffel Call-In Library.
*/

#include "eif_project.h"
#include "eif_config.h"

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#include "eif_malloc.h"
#include "eif_garcol.h"
#include "eif_cecil.h"
#include "eif_hector.h"
#include "eif_struct.h"
#include "eif_tools.h"
#include "eif_eiffel.h"				/* Need string header */
#include "eif_macros.h"

#ifdef I_STDARG
#include <stdarg.h>
#else
#ifdef I_VARARGS
#include <varargs.h>
#endif
#endif

#define GEN_MAX	8				/* Maximum number of generic parameters */

/* Function declarations */
rt_private int cid_to_dtype(EIF_TYPE_ID cid);		/* Converts a class ID into a dynamic type */
rt_private int locate(char *object, char *name);			/* Locate attribute by name in skeleton */
rt_public int eiflocate (EIF_OBJECT object, char *name);

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

#ifndef EIF_THREADS
/* If this variable is non-null, cecil will raise an exception when trying
 * to get the address of a routine of an invisible class.
 */

rt_shared unsigned char eif_ignore_invisible = (unsigned char) 0;
#endif

/* 
 * `visible' exception handling
 */

rt_public void eifvisex (void) {
    /* Enable the visible exception */

    EIF_GET_CONTEXT
    eif_ignore_invisible = (unsigned char) 0;
    EIF_END_GET_CONTEXT
}

rt_public void eifuvisex (void)  {
    /* Disable visible exception */

    EIF_GET_CONTEXT
    eif_ignore_invisible = (unsigned char) 1;
    EIF_END_GET_CONTEXT
}

/* 
 * Type checking
 */

rt_public int eifattrtype (char *attr_name, EIF_TYPE_ID cid) {
    /* Return type of `routine' defined in class of type `cid' */
   
    EIF_GET_CONTEXT
    struct cnode *sk;               /* Skeleton entry in system */
    char **n;                       /* Pointer in cn_names array */
    int nb_attr;                    /* Number of attributes */
    int i;
    uint32 field_type;              /* for scanning type */
    if (cid == EIF_NO_TYPE)
        eif_panic ("Unknown dynamic type\n");  /* Check if dynamic exists */


    sk = &System(Deif_bid(cid_to_dtype(cid)));    /* Fetch skeleton entry */
    nb_attr = sk->cn_nbattr;        /* Number of attributes */


    for (i = 0, n = sk->cn_names; i < nb_attr; i++, n++)
        if (0 == strcmp(attr_name, *n))
            break;                  /* Attribute was found */

    if (i == nb_attr)               /* Attribute not found */
        return EIF_NO_TYPE;                  /* Will certainly raise a bus error */

    field_type = sk->cn_types[i];
    switch (field_type & SK_HEAD)   {

        case SK_REF:    return EIF_REFERENCE_TYPE;
        case SK_CHAR:   return EIF_CHARACTER_TYPE;
        case SK_BOOL:   return EIF_BOOLEAN_TYPE;
        case SK_INT:    return EIF_INTEGER_TYPE;
        case SK_FLOAT:  return EIF_REAL_TYPE;
        case SK_DOUBLE: return EIF_DOUBLE_TYPE;
        case SK_EXP:    return EIF_EXPANDED_TYPE;
        case SK_BIT:    return EIF_BIT_TYPE;
        case SK_POINTER:    return EIF_POINTER_TYPE;
        default:        return EIF_NO_TYPE;
    }
    EIF_END_GET_CONTEXT
}  

/*
 * Type ID handling
 */

rt_public EIF_TYPE_ID eifcid(char *class)
{
	/* Return class ID of a class name. If the class id is not available or
	 * the associated type is generic, then EIF_NO_TYPE is returned.
	 */
	
	EIF_TYPE_ID *value;			/* Pointer to value stored in H table */

	/* If the name is a null pointer, return an error condition */
	if ((char *) 0 == class)
		return EIF_NO_TYPE;

	/* Look-up in hash table, error if item not found */
	value = (EIF_TYPE_ID *) ct_value(&egc_ce_type, class);
	if ((EIF_TYPE_ID *) 0 == value)
		return EIF_NO_TYPE;		/* Not found (maybe type is generic?) */
	
	return *value;				/* The associated type ID */
}

rt_public EIF_TYPE_ID eifexp(EIF_TYPE_ID id)
{
	/* Take a type ID and return the type ID for an expanded type, hence
	 * forcing the expansion. If the type was already that of an expanded,
	 * then this is a no-op operation.
	 */

	if (id == EIF_NO_TYPE)
		return EIF_NO_TYPE;		/* Invalid type */
	
	/* Set the SK_EXP bit to mark type as an expanded. As EIF_TYPE_ID is a
	 * signed int, it is a better to cast it to unsigned before doing bit
	 * masking (one never knows)--RAM.
	 */
	
	return (EIF_TYPE_ID) ((uint32) id & SK_EXP);	/* Force the expanded bit */
}

/*
 * Object creation
 */

rt_public EIF_OBJECT eifcreate(EIF_TYPE_ID cid)
{
	/* Create an instance of class 'cid', but does not call any creation
	 * routine. Return the address in the indirection table (access to the
	 * real object done via a macro (objects are moving). Exceptions will
	 * occur if the object cannot be created for some reason.
	 */

	char *object;					/* Eiffel object's physical address */
	int dtype;						/* Dynamic type associated with class ID */
	
	dtype = cid_to_dtype(cid);		/* Convert class ID to dynamic type */
	if (dtype < 0)					/* Was not a valid reference type */
		return (EIF_OBJECT) 0;			/* No creation, return null pointer */

	object = emalloc(dtype);		/* Create object */

	return henter(object);			/* Return the indirection pointer */
}

/*
 * Function pointers handling
 */

rt_public EIF_PROCEDURE eifproc(char *routine, EIF_TYPE_ID cid)
{
	return (EIF_PROCEDURE) eifref(routine, cid);		/* Eiffel procedure */
}

rt_public EIF_INTEGER_FUNCTION eiflong(char *routine, EIF_TYPE_ID cid)
{
	return (EIF_INTEGER_FUNCTION) eifref(routine, cid);	/* Function returning INTEGER */
}

rt_public EIF_CHARACTER_FUNCTION eifchar(char *routine, EIF_TYPE_ID cid)
{
	return (EIF_CHARACTER_FUNCTION) eifref(routine, cid);	/* Function returning CHAR */
}

rt_public EIF_REAL_FUNCTION eifreal(char *routine, EIF_TYPE_ID cid)
{
	return (EIF_REAL_FUNCTION) eifref(routine, cid);	/* Function returning REAL */
}

rt_public EIF_DOUBLE_FUNCTION eifdouble(char *routine, EIF_TYPE_ID cid)
{
	return (EIF_DOUBLE_FUNCTION) eifref(routine, cid);	/* Returning DOUBLE */
}

rt_public EIF_BIT_FUNCTION eifbit(char *routine, EIF_TYPE_ID cid)
{
	return (EIF_BIT_FUNCTION) eifref(routine, cid);	/* Function returning BIT */
}

rt_public EIF_BOOLEAN_FUNCTION eifbool(char *routine, EIF_TYPE_ID cid)
{
	return (EIF_BOOLEAN_FUNCTION) eifref(routine, cid);	/* Function returning BOOLEAN */
}

rt_public EIF_POINTER_FUNCTION eifptr(char *routine, EIF_TYPE_ID cid)
{
	return (EIF_POINTER_FUNCTION) eifref(routine, cid);	/* Returning POINTER */
}

rt_public EIF_REFERENCE_FUNCTION eifref(char *routine, EIF_TYPE_ID cid)
{
	/* Look for the routine named 'routine' in the type 'cid' (there is no
	 * polymorphism here). Return a pointer to the routine if found, or the
	 * null pointer if the routine does not exist.
	 */

	EIF_GET_CONTEXT

	int dtype = Deif_bid(cid_to_dtype(cid));		/* Compute dynamic type from class ID */
	struct ctable *ptr_table;			/* H table holding function pointers */
#ifdef WORKBENCH
	int32 *feature_ptr;
	int32 rout_id;
	uint32 body_id;
	uint16 body_index;
	int32 *cn_routids;
#else
	EIF_REFERENCE_FUNCTION *ref;
#endif

	if (cid == EIF_NO_TYPE)	/* No type id */
		return (EIF_REFERENCE_FUNCTION) 0;

	if (dtype < 0)						/* Invalid type (not a reference) */
		return (EIF_REFERENCE_FUNCTION) 0;			/* Cannot use Cecil on simple types */
	ptr_table = &Cecil(dtype);			/* Get associated H table */

#ifndef WORKBENCH
	ref = (EIF_REFERENCE_FUNCTION *) ct_value(ptr_table, routine);	/* Code location */
	if (!ref && !eif_ignore_invisible)
		eraise ("Unknown routine (visible?)", EN_PROG);
	return *ref;
#else
	if ((feature_ptr = (int32 *) ct_value(ptr_table, routine)) == (int32*)0) {
		if (!eif_ignore_invisible)
			eraise ("Unknown routine (visible?)", EN_PROG);
		return (EIF_REFERENCE_FUNCTION) 0;
	}
	cn_routids = System(dtype).cn_routids;
	if (cn_routids)
		rout_id = cn_routids[*feature_ptr];
	else /* precompiled routine */
		rout_id = *feature_ptr;
	CBodyIdx(body_index,rout_id,dtype);
	body_id = dispatch[body_index];

	if (body_id < zeroc)
		/* Frozen feature */
		return egc_frozen[body_id];
	else
#ifndef DLE
		xraise(MTC EN_DOL);
#else
	if (body_id < dle_level)
			/* Static melted routine */
		xraise(EN_DOL);
	else if (body_id < dle_zeroc)
			/* Dynamic frozen feature */
		return dle_frozen[body_id];
	else
			/* Dynamic melted routine */
		xraise(EN_DOL);
#endif
#endif

	EIF_END_GET_CONTEXT
}

/*
 * Class ID versus dynamic type
 */

rt_public EIF_TYPE_ID eif_type_by_object (EIF_REFERENCE object)
{
	/* Return type id of the direct reference "object" */
	return Dftype (object);
}
	
rt_public EIF_TYPE_ID eiftype(EIF_OBJECT object)
{
	/* Obsolete. Use "eif_type_by_object" instead.
	 * Return the Type id of the specified object. 
 	 */

	return Dftype(eif_access(object));
}

rt_public char *eifname(EIF_TYPE_ID cid)
{
	/* Return the name of the class whose ID is cid. It is a pointer to
	 * static data. For generic types, only the base name of the class
	 * is returned.
	 */


	int dtype = Deif_bid(cid_to_dtype(cid));		/* Convert to dynamic type */

	if ((dtype < 0) || (cid == EIF_NO_TYPE))						/* Not a reference type */
		return (char *) 0;

	return System(dtype).cn_generator;	/* Pointer to static data */
}

rt_private int cid_to_dtype(EIF_TYPE_ID cid)
{
	/* Converts a class ID to a dynamic type. Returns -1 if the class ID is not
	 * that of a reference type. Expanded types are ignored, of course, for the
	 * purpose of dynamic type computation.
	 */

	if ((uint32) cid & SK_SIMPLE)		/* Type is a simple type */
		return -1;						/* No valid dynamic type */
	
	return (uint32) cid & SK_DTYPE;		/* Return the dynamic type part */
}

/*
 * Field access (attributes)
 */

rt_public void *eif_field_safe (EIF_REFERENCE object, char *name, int type_int, int * const ret)
{
	/* Like eif_attribute, but perform a type checking between the type	
	 * given by "type_int" and the actual type of the attribute.
	 * Return EIF_WRONG_TYPE, if this fails.
	 */

	void *addr;
	int tid;

	addr = eifaddr (object, name, ret);

	if (*ret != EIF_CECIL_OK)	/* Was "eifaddr" successfull? */
		return addr;	/* Return "addr" with error code in "ret". */	

	tid = eif_type_by_object (object);	/* Get type id for "eif_attribute_type" */
	if (tid == EIF_NO_TYPE)	/* No type id? */
		eif_panic ("Object has no type id.");/* Should not happen. */

	if (eif_attribute_type (name, tid) != type_int)  {	/* Do types match. */
		*ret = EIF_WRONG_TYPE;	/* Wrong type. */
		return addr;	
	}

} 	/* eif_field_safe */
	

rt_public void *eifaddr(EIF_REFERENCE object, char *name, int * const ret)
{
	/*
	 * Returns the physical address of the attribute named 'name' in the given
	 * object (note that the address of the object is expected -- we do not
	 * want an Hector indirection pointer).
	 * If it fails, "*ret" is EIF_NO_ATTRIBUTE, EIF_CECIL_OK, otherwise.
	 * (was necessary was getting value of basic types failed).
	 */
	
	int i;							/* Index in skeleton */
#ifdef WORKBENCH
	int32 rout_id;					/* Attribute routine id */
	int16 dtype;					/* Object dynamic type */
	long offset;
#endif

	i = locate(object, name);		/* Locate attribute in skeleton */
	if (i == EIF_NO_ATTRIBUTE) {					/* Attribute not found */
		void **failed;				/* Necessary for avoiding seg. fault */
		*ret = EIF_NO_ATTRIBUTE;	/* Set "*ret" */
		failed = (void **) malloc (sizeof(void *));	
		*failed = (void *) 0;
		return failed;	/* So that "*(EIF_TYPE *) failed" does not crash */
	}

	*ret = EIF_CECIL_OK; 	/* Set "*ret" for successfull return. */
#ifndef WORKBENCH
	return (void *) (object + (System(Dtype(object)).cn_offsets[i]));
#else
	dtype = Dtype(object);
	rout_id = System(dtype).cn_attr[i]; 
	CAttrOffs(offset,rout_id,dtype);
	
	return (void *) (object + offset);
#endif
}


rt_public int eiflocate (EIF_OBJECT object, char *name) {
    /* Return the index of attribute `name' in EIF_OBJECT `object' */

    return locate (eif_access (object), name);
}

rt_private int locate(char *object, char *name)
{
	/* Locate the attribute 'name' in the specified object and return the index
	 * in the cn_offsets array, or EIF_NO_ATTRIBUTE if there is no such attribute.
	 */

	struct cnode *sk;				/* Skeleton entry in system */
	char **n;						/* Pointer in cn_names array */
	int nb_attr;					/* Number of attributes */
	int i;

	if (object == (char *) 0)		/* Null pointer */
		return EIF_NO_ATTRIBUTE;					/* Differ the bus error */

	sk = &System(Dtype(object));	/* Fetch skeleton entry */
	nb_attr = sk->cn_nbattr;		/* Number of attributes */

	/* The lookup to find the attribute is done in a linear way. This makes the
	 * access to an attribute slower, by comparaison with a routine call. It is
	 * however possible to bypass Cecil if the object location does not move,
	 * by calling eifaddr() directly and storing the address somewhere. Then
	 * use the C de-referencing mechanism (non-portable accross Eiffel compilers
	 * of course, as ETL does not mention eifaddr)--RAM.
	 */

	for (i = 0, n = sk->cn_names; i < nb_attr; i++, n++)
		if (0 == strcmp(name, *n))
			break;					/* Attribute was found */

	if (i == nb_attr)				/* Attribute not found */
		return EIF_NO_ATTRIBUTE;					/* Will certainly raise a bus error */

	return i;			/* Index in the attribute array */
}

/*
 * Bit field handling
 */

rt_public EIF_BIT eifgbit(char *object, char *name)
{
	/* Return a pointer the bit field 'name' in the object, or an error if
	 * no such bit field is found.
	 */

	int i;							/* Index in skeleton structure */
	struct cnode *sk;				/* Skeleton entry in system */
#ifdef WORKBENCH
	int32 rout_id;					/* Bit attribute routine id */
	int16 dtype;					/* Object dynamic type */
	long offset;					/* Bit attribute offset */
#endif

	i = locate(object, name);		/* Locate attribute by name */
	if (i == EIF_NO_ATTRIBUTE)					/* Attribute not found */
		return EIF_NO_BIT_FIELD;		/* No bit field */

	sk = &System(Dtype(object));	/* Fetch skeleton entry */

#ifndef WORKBENCH
	if (!(sk->cn_types[i] & SK_BIT))
		return EIF_NO_BIT_FIELD;		/* Wrong type (not a bit field) */

	return (EIF_BIT) (object + (sk->cn_offsets[i]));
#else
	dtype = Dtype(object);
	rout_id = System(dtype).cn_attr[i];
	CAttrOffs(offset,rout_id,dtype);

	return (EIF_BIT) (object + offset);
#endif
}

rt_public void eifsbit(char *object, char *name, EIF_BIT bit)
{
	/* Sets the bit field 'name' of 'object' to bit. Do nothing if the fields
	 * is not a bit one or if 'bit' is a void pointer.
	 */
	
	EIF_BIT obj_field;				/* Address of the bit field in object */
	int size;						/* Size of the whole bit field (in bytes) */

	if (bit == (EIF_BIT) 0)			/* Abort on void reference */
		return;
	
	obj_field = eifgbit(object, name);	/* Get address of bit field */
	if (obj_field == EIF_NO_BIT_FIELD)		/* Eh! This is not a bit field! */
		return;							/* Do nothing */

	/* The size of the whole bit field is the size of the long which holds the
	 * length of the bit field (in bits) plus the size of the field itself.
	 */

	size = LNGSIZ + (obj_field->b_length / BITLONG +
		(obj_field->b_length % BITLONG) ? 0 : 1) * LNGSIZ;

	/* Copy the bit field 'bit' into obj_field. No check is made to ensure the
	 * field is big enough (that would cost one more look-up in the skeleton).
	 */

	bcopy((char *) bit, (char *) obj_field, size);
}

rt_public char eifibit(EIF_BIT bit, int i)
{
	/* Return the value of the ith bit in 'bit', starting numbering at 1.
	 * If 'i' is not in the range, return EIF_NO_BIT.
	 */
	
	if (bit == (EIF_BIT) 0)			/* Null pointer */
		return EIF_NO_BIT;			/* No bit then! */

	if (i < 1 || (uint32) i > bit->b_length)
		return EIF_NO_BIT;			/* Index out of range */

	i--;			/* Run-time macros work with index starting at 0 */

	return RTBI(bit, i);			/* Access to bit i */
}

rt_public int eifsibit(EIF_BIT bit, int i)
{
	/* Set the bit 'i' to 1 in the bit field 'bit'. If out of range or a null
	 * bit field is provided, do nothing and return -1.
	 */

	if (bit == (EIF_BIT) 0)			/* Null pointer */
		return -1;					/* No action */

	if (i < 1 || (uint32) i > bit->b_length)
		return -1;					/* Index out of range */

	i--;			/* Run-time macros work with index starting at 0 */
	RTBS(bit, i);	/* Set bit i to 1 */

	return 0;		/* Ok */
}

rt_public int eifribit(EIF_BIT bit, int i)
{
	/* Reset the bit 'i' to 0 in the bit field 'bit'. If out of range or a null
	 * bit field is provided, do nothing and return -1.
	 */

	if (bit == (EIF_BIT) 0)			/* Null pointer */
		return -1;					/* No action */

	if (i < 1 || (uint32) i > bit->b_length)
		return -1;					/* Index out of range */

	i--;			/* Run-time macros work with index starting at 0 */
	RTBR(bit, i);	/* Reset bit i to 0 */

	return 0;		/* Ok */
}

rt_public EIF_BIT eifbcln(EIF_BIT bit)
{
	/* Clones the bit field structure given as argument */

	EIF_BIT new_bit;				/* The fresh new copy of the bit field */
	int size;						/* Size of the bit field container */

	if (bit == (EIF_BIT) 0)
		return (EIF_BIT) 0;
	
	/* The size of the whole bit field is the size of the long which holds the
	 * length of the bit field (in bits) plus the size of the field itself.
	 */

	size = LNGSIZ + (bit->b_length / BITLONG +
		(bit->b_length % BITLONG) ? 0 : 1) * LNGSIZ;

	new_bit = (EIF_BIT) xmalloc(size, C_T, GC_OFF);
	if (new_bit == (EIF_BIT) 0)
		return (EIF_BIT) 0;			/* Could not allocate memory */

	/* Copy the bit field 'bit' into obj_field. No check is made to ensure the
	 * field is big enough (that would cost one more look-up in the skeleton).
	 */

	bcopy((char *) bit, (char *) new_bit, size);
	return (new_bit);
}

/*
 * Hash table handling
 */

rt_shared char *ct_value(struct ctable *ct, register char *key)
{
	/* Look for item associated with given key and returns a pointer to its
	 * location in the value array. Return a null pointer if item is not found.
	 */
	
	register2 long pos;		/* Position in H table */
	register3 int32 hsize;		/* Size of H table */
	register4 char **hkeys;		/* Array of keys */

	register5 int32 tryv = (int32) 0;	/* Count number of attempts */
	register6 long inc;		/* Loop increment */

	/* Initializations */
	hsize = ct->h_size;
	hkeys = ct->h_keys;

	if (hsize == 0)
		return (char *) 0;			/* Item was not found */

	/* Jump from one hashed position to another until we find the value or
	 * go to an empty entry or reached the end of the table.
	 */
	inc = hashcode(key, (long) strlen(key));
	for (
		pos = inc % hsize, inc = 1 + (inc % (hsize - 1));
		tryv < hsize; 
		tryv++, pos = (pos + inc) % hsize
	) {
		if (hkeys[pos] == (char *) 0)
			break;
		else if (0 == strcmp(hkeys[pos], key))
			return ct->h_values + (pos * ct->h_sval);
	}

	return (char *) 0;			/* Item was not found */
}

