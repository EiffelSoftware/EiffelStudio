/*

  ####   ######   ####      #    #                ####
 #    #  #       #    #     #    #               #    #
 #       #####   #          #    #               #
 #       #       #          #    #        ###    #
 #    #  #       #    #     #    #        ###    #    #
  ####   ######   ####      #    ######   ###     ####


	C-Eiffel Call-In Library.
*/

#include "config.h"
#include "malloc.h"
#include "garcol.h"
#include "cecil.h"
#include "hector.h"
#include "struct.h"
#include "tools.h"
#include "eiffel.h"				/* Need string header */
#include "macros.h"

#ifdef I_STDARG
#include <stdarg.h>
#else
#ifdef I_VARARGS
#include <varargs.h>
#endif
#endif

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#define GEN_MAX	4				/* Maximum number of generic parameters */

/* Function declarations */
private int cid_to_dtype();		/* Converts a class ID into a dynamic type */
private int locate();			/* Locate attribute by name in skeleton */

#ifndef lint
private char *rcsid =
	"$Id$";
#endif

/*
 * Type ID handling
 */

public EIF_TYPE_ID eifcid(class)
char *class;
{
	/* Return class ID of a class name. If the class id is not available or
	 * the associated type is generic, then EIF_NO_TYPE is returned.
	 */
	
	EIF_TYPE_ID *value;			/* Pointer to value stored in H table */

	/* If the name is a null pointer, return an error condition */
	if ((char *) 0 == class)
		return EIF_NO_TYPE;

	/* Look-up in hash table, error if item not found */
	value = (EIF_TYPE_ID *) ct_value(&ce_type, class);
	if ((EIF_TYPE_ID *) 0 == value)
		return EIF_NO_TYPE;		/* Not found (maybe type is generic?) */
	
	return *value;				/* The associated type ID */
}

public EIF_TYPE_ID eifexp(id)
EIF_TYPE_ID id;
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

/* VARARGS2 */
public EIF_TYPE_ID eifgid(va_alist)
va_dcl		/* Variable number of arguments (no ; needed) */
{
	/* Return class ID of a generic class. The first argument is the class
	 * ID of the base type, followed by the class IDs of the formal generic
	 * parameters.
	 */

	va_list ap;					/* The variable argument list */
	char *class;				/* Class name (base of generic type) */
	struct gt_info *type;		/* Informations on the generic type */
	int32 gtype[GEN_MAX];		/* Generic information for current type */
	int32 itype[GEN_MAX];		/* Generic information for inspected type */
	int32 *t;					/* To walk through the gt_gen array */
	int32 type_id;				/* A type ID (Cecil's view) */
	int gen_param;				/* Number of generic parameters */
	int matched;				/* Did the inspected type matched our entry? */
	int i;

	va_start(ap);				/* Start processing of argument list */
	class = va_arg(ap, char *);	/* The first argument is a class name */

#ifdef DEBUG
	printf ("eifgid: computing EIF_TYPE_ID of %s\n", class);
#endif

	/* Now do a first search in the ce_gtype H-table to know how many generic
	 * parameters we have to get from the stack. If the class is not found,
	 * then either it is not a generic type or it was not declared as visible.
	 * Anyway, return the EIF_NO_TYPE error code.
	 */

	type = (struct gt_info *) ct_value(&ce_gtype, class);
	if ((struct gt_info *) 0 == type) {	/* Not found in H-table */
		va_end(ap);						/* End processing of argument list */
#ifdef DEBUG
	printf ("eifgid: class not found in the ce_gtype table\n");
#endif
		return EIF_NO_TYPE;				/* Error condition */
	}

	/* Now extract from the stack the number of parameters and build an array
	 * out of them. Then lookup in the gt_gen array to find a matching generic
	 * information. For the purposes of the look-up, class types are transformed
	 * into SK_DTYPE (meta-type reference).
	 */

	gen_param = type->gt_param;			/* Number of generic parameters */
#ifdef DEBUG
	printf ("eifgid: nb of generics = %d\n", gen_param);
#endif
	for (i = 0; i < gen_param; i++) {
		type_id = va_arg(ap, EIF_TYPE_ID);		/* Get a type ID from stack */
#ifdef DEBUG
	printf ("eifgid: type_id = %d\n", type_id);
#endif
		if (0 == ((uint32) type_id & SK_REF))	/* A pure reference type */
			type_id = SK_DTYPE;					/* Force meta-type reference */
#ifdef DEBUG
	printf ("eifgid: type_id = %d\n", type_id);
#endif
		gtype[i] = type_id;						/* Build our generic array */
	}
	va_end(ap);				/* End processing of argument list */

	/* At this point, we have built the generic informations of the type in the
	 * gtype array and gen_param holds the number of generic parameters, so that
	 * we know how much information is significant within the array. Now, we
	 * have to start a linear look-up in the gt_gen array. The number of
	 * instances in the system should be small anyway, so it should not cost too
	 * much time.
	 */

	for (t = type->gt_gen; /* empty */; /* empty */) {

		if (*t == SK_INVALID)		/* End of array indicator */
			return EIF_NO_TYPE;		/* Signals: error occurred */

		/* Fetch the generic meta-types which are forthcomming in the itype
		 * array (inspected type).
		 * Then compare the itype built against the gtype we got. If they match,
		 * we found the type and exit the loop. Otherwise, we continue...
		 */

		matched = 1;						/* Assume a perfect match */
		for (i = 0; i < gen_param; i++) {	/* Built itype for comparaison */
			itype[i] = *t++;
			if (itype[i] != gtype[i])		/* Matching done on the fly */
				matched = 0;				/* The types do not match */
		}
		if (matched) {		/* We found the type */
			t -= gen_param;
			break;			/* End of loop processing */
		}
	}

	/* To compute the index in the gt_type array where we can find the type ID,
	 * we have to count how many items we inspected and divide by the number
	 * of generic parameters. The 't' variable points one location after the
	 * match, hence the '-1' in the formula below.
	 * No it doesn't, the instruction  "t -= gen_param" brings it back
	 * exactly where it should be -- FRED
	 */
	
	i = (t - type->gt_gen) / gen_param;

#ifdef DEBUG
	printf ("eifgid: i = %d\n", i);
#endif

	return type->gt_type[i];		/* The requested generic type ID */
}

/*
 * Object creation
 */

public EIF_OBJ eifcreate(cid)
EIF_TYPE_ID cid;
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
		return (EIF_OBJ) 0;			/* No creation, return null pointer */

	object = emalloc(dtype);		/* Create object */

	return henter(object);			/* Return the indirection pointer */
}

/*
 * Function pointers handling
 */

public EIF_PROC eifproc(routine, cid)
char *routine;
EIF_TYPE_ID cid;
{
	return (EIF_PROC) eifref(routine, cid);		/* Eiffel procedure */
}

public EIF_FN_INT eiflong(routine, cid)
char *routine;
EIF_TYPE_ID cid;
{
	return (EIF_FN_INT) eifref(routine, cid);	/* Function returning INTEGER */
}

public EIF_FN_CHAR eifchar(routine, cid)
char *routine;
EIF_TYPE_ID cid;
{
	return (EIF_FN_CHAR) eifref(routine, cid);	/* Function returning CHAR */
}

public EIF_FN_FLOAT eifreal(routine, cid)
char *routine;
EIF_TYPE_ID cid;
{
	return (EIF_FN_FLOAT) eifref(routine, cid);	/* Function returning REAL */
}

public EIF_FN_DOUBLE eifdouble(routine, cid)
char *routine;
EIF_TYPE_ID cid;
{
	return (EIF_FN_DOUBLE) eifref(routine, cid);	/* Returning DOUBLE */
}

public EIF_FN_BIT eifbit(routine, cid)
char *routine;
EIF_TYPE_ID cid;
{
	return (EIF_FN_BIT) eifref(routine, cid);	/* Function returning BIT */
}

public EIF_FN_BOOL eifbool(routine, cid)
char *routine;
EIF_TYPE_ID cid;
{
	return (EIF_FN_BOOL) eifref(routine, cid);	/* Function returning BOOLEAN */
}

public EIF_FN_POINTER eifptr(routine, cid)
char *routine;
EIF_TYPE_ID cid;
{
	return (EIF_FN_POINTER) eifref(routine, cid);	/* Returning POINTER */
}

public EIF_FN_REF eifref(routine, cid)
char *routine;
EIF_TYPE_ID cid;
{
	/* Look for the routine named 'routine' in the type 'cid' (there is no
	 * polymorphism here). Return a pointer to the routine if found, or the
	 * null pointer if the routine does not exist.
	 */

	int dtype = cid_to_dtype(cid);		/* Compute dynamic type from class ID */
	struct ctable *ptr_table;			/* H table holding function pointers */
#ifdef WORKBENCH
	int32 *feature_ptr;
	int32 rout_id;
	uint32 body_id;
	int16 body_index;
#endif

	if (dtype < 0)						/* Invalid type (not a reference) */
		return (EIF_FN_REF) 0;			/* Cannot use Cecil on simple types */

	ptr_table = &Cecil(dtype);			/* Get associated H table */

#ifndef WORKBENCH
	return *(EIF_FN_REF *) ct_value(ptr_table, routine);	/* Code location */
#else
	if ((feature_ptr = (int32 *) ct_value(ptr_table, routine)) == (int32*)0)
		return (EIF_FN_REF) 0;

	rout_id = (System(dtype).cn_routids)[*feature_ptr];
	CBodyIdx(body_index,rout_id,dtype);
	body_id = dispatch[body_index];

	if (body_id < zeroc)
		/* Frozen feature */
		return frozen[body_id];
	else
		xraise(EN_DOL);
#endif
}

/*
 * Class ID versus dynamic type
 */

public int eiftype(object)
EIF_OBJ *object;
{
	/* Return the dynamic type of the specified object */

	return Dtype(eif_access(object));
}

public char *eifname(cid)
EIF_TYPE_ID cid;
{
	/* Return the name of the class whose ID is cid. It is a pointer to
	 * static data. For generic types, only the base name of the class
	 * is returned.
	 */

	int dtype = cid_to_dtype(cid);		/* Convert to dynamic type */

	if (dtype < 0)						/* Not a reference type */
		return (char *) 0;

	return System(dtype).cn_generator;	/* Pointer to static data */
}

private int cid_to_dtype(cid)
EIF_TYPE_ID cid;
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

public char *eifaddr(object, name)
char *object;
char *name;
{
	/* Returns the physical address of the attribute named 'name' in the given
	 * object (note that the address of the object is expected -- we do not
	 * want an Hector indirection pointer).
	 */
	
	int i;							/* Index in skeleton */
#ifdef WORKBENCH
	int32 rout_id;					/* Attribute routine id */
	int16 dtype;					/* Object dynamic type */
	long offset;
#endif

	i = locate(object, name);		/* Locate attribute in skeleton */
	if (i == -1)					/* Attribute not found */
		return (char *) 0;			/* Will certainly raise a bus error */

#ifndef WORKBENCH
	return (char *) (object + ((System(Dtype(object)).cn_offsets[i])[Dtype(object)]));
#else
	dtype = Dtype(object);
	rout_id = System(dtype).cn_attr[i]; 
	CAttrOffs(offset,rout_id,dtype);
	return object + offset;
#endif
}

private int locate(object, name)
char *object;
char *name;
{
	/* Locate the attribute 'name' in the specified object and return the index
	 * in the cn_offsets array, or -1 if there is no such attribute.
	 */

	struct cnode *sk;				/* Skeleton entry in system */
	char **n;						/* Pointer in cn_names array */
	int nb_attr;					/* Number of attributes */
	int i;

	if (object == (char *) 0)		/* Null pointer */
		return -1;					/* Differ the bus error */

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
		return -1;					/* Will certainly raise a bus error */

	return i;			/* Index in the attribute array */
}

/*
 * Bit field handling
 */

public EIF_BIT eifgbit(object, name)
char *object;
char *name;
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
	if (i == -1)					/* Attribute not found */
		return EIF_NO_BFIELD;		/* No bit field */

	sk = &System(Dtype(object));	/* Fetch skeleton entry */

#ifndef WORKBENCH
	if (!(sk->cn_types[i] & SK_BIT))
		return EIF_NO_BFIELD;		/* Wrong type (not a bit field) */

	return (EIF_BIT) (object + (*sk->cn_offsets[i]));
#else
	dtype = Dtype(object);
	rout_id = System(dtype).cn_attr[i];
	CAttrOffs(offset,rout_id,dtype);

	return (EIF_BIT) (object + offset);
#endif
}

public void eifsbit(object, name, bit)
char *object;
char *name;
EIF_BIT bit;
{
	/* Sets the bit field 'name' of 'object' to bit. Do nothing if the fields
	 * is not a bit one or if 'bit' is a void pointer.
	 */
	
	EIF_BIT obj_field;				/* Address of the bit field in object */
	int size;						/* Size of the whole bit field (in bytes) */

	if (bit == (EIF_BIT) 0)			/* Abort on void reference */
		return;
	
	obj_field = eifgbit(object, name);	/* Get address of bit field */
	if (obj_field == EIF_NO_BFIELD)		/* Eh! This is not a bit field! */
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

public char eifibit(bit, i)
EIF_BIT bit;
int i;
{
	/* Return the value of the ith bit in 'bit', starting numbering at 1.
	 * If 'i' is not in the range, return EIF_NO_BIT.
	 */
	
	if (bit == (EIF_BIT) 0)			/* Null pointer */
		return EIF_NO_BIT;			/* No bit then! */

	if (i < 1 || i > bit->b_length)
		return EIF_NO_BIT;			/* Index out of range */

	i--;			/* Run-time macros work with index starting at 0 */

	return RTBI(bit, i);			/* Access to bit i */
}

public int eifsibit(bit, i)
EIF_BIT bit;
int i;
{
	/* Set the bit 'i' to 1 in the bit field 'bit'. If out of range or a null
	 * bit field is provided, do nothing and return -1.
	 */

	if (bit == (EIF_BIT) 0)			/* Null pointer */
		return -1;					/* No action */

	if (i < 1 || i > bit->b_length)
		return -1;					/* Index out of range */

	i--;			/* Run-time macros work with index starting at 0 */
	RTBS(bit, i);	/* Set bit i to 1 */

	return 0;		/* Ok */
}

public int eifribit(bit, i)
EIF_BIT bit;
int i;
{
	/* Reset the bit 'i' to 0 in the bit field 'bit'. If out of range or a null
	 * bit field is provided, do nothing and return -1.
	 */

	if (bit == (EIF_BIT) 0)			/* Null pointer */
		return -1;					/* No action */

	if (i < 1 || i > bit->b_length)
		return -1;					/* Index out of range */

	i--;			/* Run-time macros work with index starting at 0 */
	RTBR(bit, i);	/* Reset bit i to 0 */

	return 0;		/* Ok */
}

public EIF_BIT eifbcln(bit)
EIF_BIT bit;
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
}

/*
 * Hash table handling
 */

shared char *ct_value(ct, key)
struct ctable *ct;
register1 char *key;
{
	/* Look for item associated with given key and returns a pointer to its
	 * location in the value array. Return a null pointer if item is not found.
	 */
	
	register2 long pos;		/* Position in H table */
	register3 int32 hsize;		/* Size of H table */
	register4 char **hkeys;		/* Array of keys */
	register5 int32 try = 0;	/* Count number of attempts */
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
		try < hsize;
		try++, pos = (pos + inc) % hsize
	) {
		if (hkeys[pos] == (char *) 0)
			break;
		else if (0 == strcmp(hkeys[pos], key))
			return ct->h_values + (pos * ct->h_sval);
	}

	return (char *) 0;			/* Item was not found */
}

