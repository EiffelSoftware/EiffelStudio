/*

 #####   #       #    #   ####            ####
 #    #  #       #    #  #    #          #    #
 #    #  #       #    #  #               #
 #####   #       #    #  #  ###   ###    #
 #       #       #    #  #    #   ###    #    #
 #       ######   ####    ####    ###     ####

	A set of routines to plug the run-time in the generated C code.
*/

#include "config.h"
#include "plug.h"
#include "malloc.h"
#include "eiffel.h"
#include "option.h"
#include "macros.h"
#include "except.h"
#include "local.h"
#include "interp.h"
#include "hashin.h"
#include "bits.h"

#ifndef lint
private char *rcsid =
	"$Id$";
#endif

/* The nested call flag is sete to 1 when a feature call is made within a
 * dot expression. We need to check the invariant before and after the call
 * on those features. This global variable is saved immediately in a local
 * variable upon entrance in the feature, so this is merely an added optional
 * parameter.
 */
public int nstcall = 0;					/* Is current call a nested one? */

private void recursive_chkinv();		/* Internal invariant control loop */

/*
 * Manifest array creation for strip
 */

public char *striparr(curr, dtype, items, nbr)
register1 char *curr;
register2 int dtype;
register3 char **items;
register4 long nbr;
{
	/* Create an Eiffel ARRAY[ANY] using current object curr. 
	 * This routine creates the object and returns a pointer to the newly
	 * allocated array or raises a "No more memory" exception.
	 * This object will contain all the attributes of curr except for
	 * items.
	 */

	char *array, *sp, *o_ref; 
	char *new_obj , *new_attr;
	long nbr_attr, offset, stripped_nbr;
	struct cnode *obj_desc;
#ifndef WORKBENCH
	register5 long **offsets;
#else
	register6 int32 *rout_ids;
#endif
	register7 char** attr_names;
	char *attr;
	int i;
	char found;
	int16 curr_dtype;
	uint32 type, *types;

	curr_dtype = Dtype(curr);	/* Dynamic type of current object instance */
	obj_desc = &System(dtype); 	/* Dynamic type where strip is defined */
	nbr_attr = obj_desc->cn_nbattr;
	attr_names = obj_desc->cn_names;
#ifndef WORKBENCH
    offsets = obj_desc->cn_offsets;
#else
    rout_ids = obj_desc->cn_attr;
#endif
	types = obj_desc->cn_types;

	stripped_nbr = nbr_attr - nbr;
	array = emalloc(arr_dtype);	/* If we return, it succeeded */
	epush(&loc_stack, &array); 	/* Protect address in case it moves */
	(arrmake)(array, 1L, stripped_nbr);	
								/* Call feature `make' in class ARRAY[ANY] */
	sp = *(char **) array;
	epush (&loc_stack, &sp);	/* Protect address in case it moves */

	while (nbr_attr--) {
		found = NULL;
		for (i=0; i<nbr & (!found); i++) {
			attr = items[i];
			if (!(strcmp (attr, attr_names[nbr_attr])))
				found = 't';
		}
		if (!found) {
			type = types[nbr_attr];
#ifndef WORKBENCH
			o_ref = curr + (offsets[nbr_attr][curr_dtype]);		
#else
			o_ref = curr + ((long *) Table(rout_ids[nbr_attr])) [curr_dtype];
#endif
			switch(type & SK_HEAD) {
			case SK_REF:
				new_obj = *(char **) o_ref;
				break;
			case SK_CHAR:
				new_obj = RTLN(char_ref_dtype);
				*new_obj = * (char *) o_ref;
				break;
			case SK_BOOL:
				new_obj = RTLN(bool_ref_dtype);
				*new_obj = * (char *) o_ref;
				break;
			case SK_INT:
				new_obj = RTLN(int_ref_dtype);
				*(long *) new_obj = *(long *) o_ref;
				break;
			case SK_DOUBLE:
				new_obj = RTLN(doub_ref_dtype);
#ifndef WORKBENCH
printf ("bug in metamorphosis for double in final mode\n");
#else
				*(double *) new_obj = *(double *) o_ref;
#endif
				break;
			case SK_FLOAT:
				new_obj = RTLN(real_ref_dtype);
				*(float *) new_obj = *(float *) o_ref;
				break;
			case SK_POINTER:
				new_obj = RTLN(point_ref_dtype);
				*(fnptr *) new_obj = *(fnptr *) o_ref;
				break;
			case SK_BIT:
				new_obj = b_clone(o_ref);
				break;
			default:
				panic("unknown attribute type");
				/* NOTREACHED */
			}
		*((char **) sp) = new_obj;
		sp += sizeof (char *);
		}
	}
	epop(&loc_stack, 1);		/* Remove protection for area */
	epop(&loc_stack, 1);		/* Remove protection for array */
	return array;
}

public char *makestr(s, len)
register1 char *s;
register2 int len;
{
	/* Makes an Eiffel STRING object from a C string.
	 * This routine creates the object and returns a pointer to the newly
	 * allocated string or raises a "No more memory" exception.
	 */
	
	char *string;					/* Were string object is located */

	string = emalloc(str_dtype);	/* If we return, it succeeded */
	epush(&loc_stack, &string);		/* Protect address in case it moves */
	(strmake)(string, len);			/* Call feature `make' in class STRING */
	(strset)(string, len);			/* Call feature `set_count' in STRING */

	/* Copy C string `s' in special object `area' of the new string
	 * descriptor `string'. We know the `area' is the very first reference
	 * of the STRING object, hence the simple de-referencing.
	 */

	bcopy(s, *(char **)string, len);
	epop(&loc_stack, 1);			/* Remove protection */

	return string;
}

/*
 * Conformance query
 */

public char econfg(obj1,obj2)
char *obj1, *obj2;
{
	/* Does dynamic type of `obj2' conform to dynamic type of `obj1' ? */

	if ((char *) 0 == obj1 || (char *) 0 == obj2)
		return (char) 0;

	return (char) econfm(Dtype(obj1), Dtype(obj2));

}

public int econfm(ancestor, heir)
int heir;		/* If conformance is true, this must be the heir type */
int ancestor;	/* And this must be the ancestor then */
{
	/* Does dynamic type `heir' conform to dynamic type `ancestor' ? */

	struct conform *ct = co_table[ancestor];
	unsigned int i;
	int j, k;
	int16 min;

	min = ct->co_min;
	if (heir >= min && heir <= ct->co_max) {
		/* Since the compiler assumed there is 8 bits on a character,
		 * we do the same thing here and hardwire the `8' constant
		 * value. -- FREDD
		 */
		k = heir - min;
		i = (unsigned int) ct->co_tab [k / 8];
		j = 7 - (k % 8);
		return (i & (1 << j)) >> j;
	}

	return 0;
}

/*
 * Special object count
 */

public long sp_count(spobject)
char *spobject;
{
	/* Return the count of a special object */

	char *ref = spobject + (HEADER(spobject)->ov_size & B_SIZE) - LNGPAD(2);

	return *(long *)ref;
}


/*
 * Invariant checking
 */

public void chkinv (obj, where)
char *obj;
int where;		/* Invariant is beeing checked before or after compound? */
{
	/* Check invariant on object `obj'. Assumes that `obj' is not null */

	union overhead *zone = HEADER(obj);
	int dtype = Dtype(obj);

	if (
#ifdef WORKBENCH
		WASC(dtype) & CK_INVARIANT &&
#endif
		!(zone->ov_flags & EO_INV)
	) {
		epush(&loc_stack, &obj);				/* Protect against GC moves */
		zone->ov_flags |= EO_INV;				/* Avoid loops in checks */
		recursive_chkinv(dtype, obj, where);	/* Recurive invariant check */
		HEADER(obj)->ov_flags &= ~EO_INV;		/* Unmark the object */
		epop(&loc_stack, 1);					/* Release GC protection */
	}
}

private void recursive_chkinv(dtype, obj, where)
int dtype;
char *obj;
int where;		/* Invariant is being checked before or after compound? */
{
	/* Recursive invariant check. */

	struct cnode *node = esystem + dtype;
	int *cn_parents;
	void (*cn_inv)();
	int p_type;
#ifdef WORKBENCH
	int32 inv_body_id;			/* Invariant body id */
#endif

	epush(&loc_stack, &obj);		/* Automatic protection of `obj' */
	cn_parents = node->cn_parents;	/* Recursion on parents first. */

	/* The list of parent dynamic types is always terminated by a
	 * -1 value. -- FREDD
	 */
	while ((p_type = *cn_parents++) != -1)
		/* Call to potential parent invariant */
		recursive_chkinv(p_type, obj, where);

	/* Invariant check */
#ifndef WORKBENCH
	cn_inv = node->cn_inv;
	if (cn_inv != (void (*)()) 0)
		(cn_inv)(obj, where);
#else
	{
		uint32 body_id;
		uint32 body_index;
		struct item *last;

		body_index =
			((struct ca_info *) Table(INVARIANT_ID))[dtype].ca_id;
		body_id = dispatch[body_index];
		if (body_id < zeroc) { 		/* Frozen invariant */
			((void (*)()) frozen[body_id])(obj, where);
		} else {					/* Melted invariant */
			last = iget();
			last->type = SK_REF;
			last->it_ref = obj;
			IC = melt[body_id - zeroc];
			xiinv(IC, where);
		}
	}
#endif

	/* No more propection for `obj' */
	epop(&loc_stack, 1);
}

#ifdef WORKBENCH

char *(*dispose_routine(type))()
uint32 type;
{
	/* Dispose routine associated with type `type'.
	 * Return 0 if does not exist
	 */

	uint32 dispose_id;

	dispose_id = esystem[type].dispose_id;
	
	if (dispose_id)
		return wdisp(dispose_id);	/* Has dispose */
	else
		return 0;
}

char *cr_exp(type)
uint32 type;							/* Dynamic type */
{
	/* Creates expanded object of type `type'. If it has
	 * a creation routine then call it.
	 */

	char *result;
	register1 struct cnode *exp_desc;	/* Expanded object description */
	int32 feature_id;               	/* Creation procedure feature id */
	int32 static_id;                	/* Creation procedure feature id */

	result = emalloc(type);
	exp_desc = &System(type);
	feature_id = exp_desc->cn_creation_id;
	static_id = exp_desc->static_id;	
	if (feature_id)
		callexp(result, feature_id, static_id);	/* Call creation routine */

	return result;
}

/*
 * Standard initialization routine for composite objects in
 * workbench mode
 */

void wstdinit(obj, parent)
char *obj;		/* Object we want to initialize */
char *parent;	/* Parent (enclosing object) */
{
	/* Initialize composite object `obj' */

	int dtype;						/* Dunamic type of `obj' */
	union overhead *zone = HEADER(obj);
	long i, nb;
	long nb_exp = 0L;
	long nb_ref;					/* Number of references in `obj' */
	uint32 type;
	int32 *cn_attr;
	uint32 *cn_types;
	long nb_attr;
	struct cnode *desc;
	RTLD;

	/* We have to get GC hooks, in case the creation routines we call on the
	 * expanded objects create some objects.
	 */

	RTLI(2);
	l[0] = obj;
	l[1] = parent;
	zone->ov_flags |= EO_COMP;				/* Set the composite flag of `obj' */

	dtype = Dtype(obj);
	desc = &System(dtype);
	cn_attr = desc->cn_attr;
	nb_attr = desc->cn_nbattr;
	nb_ref = desc->nb_ref;				/* Reference number */
	cn_types = desc->cn_types;
	for (i = 0; i < nb_attr; i++) {	/* Iteration on attributes descriptions */
		type = cn_types[i];
		switch (type & SK_HEAD) {
		case SK_EXP:						/* Found an expanded attribute */
			{
			struct cnode *exp_desc;			/* Expanded object description */
			long offset;					/* Attribute offset */
			int exp_dtype;					/* Expanded dynamic type */
			int32 feature_id;				/* Creation procedure feature id */		
			int32 static_id;				/* Creation procedure feature id */		

			offset = ((long *) Table(cn_attr[i]))[dtype];
			exp_dtype = (int) (type & SK_DTYPE);
			exp_desc = &System(exp_dtype);
			feature_id = exp_desc->cn_creation_id;
			static_id = exp_desc->static_id;
			/* Set the expanded reference */
			*(char **) (l[0] + REFACS(nb_ref - ++nb_exp)) = l[0] + offset;
			
			/* Set the flags of the expanded object */
			zone = HEADER(l[0] + offset);
			zone->ov_flags = exp_dtype;
			zone->ov_flags |= EO_EXP;
			zone->ov_size = offset + (l[0] - l[1]);

			if (feature_id)
				callexp(l[0] + offset, feature_id, static_id);

			/* If expanded object is composite also, initialize it. */
			if (System(exp_dtype).cn_composite)
				wstdinit(l[0] + offset, l[1]);
			}
			break;
		case SK_BIT:
			{
			long offset;					/* Attribute offset */
			extern int bit_dtype;			/* Bit dynamic type */
		
			/* Set dynamic type for bit expanded object */	
			offset = ((long *) Table(cn_attr[i]))[dtype];
			zone = HEADER(l[0] + offset);
			zone->ov_flags = bit_dtype;
			zone->ov_flags |= EO_EXP;
			zone->ov_size = offset + (l[0] - l[1]);
			
			*(uint32 *)(l[0] + offset) = type & SK_BMASK; /* Write bit size */
			}
			break;
		default:
			break;
		}
	}

	RTLE;
}
#endif

#ifndef WORKBENCH

void rt_norout()
{
	/* Function called when Eiffel is supposed to call a deferred feature
	 * without any implementation in final mode
	 */

	RTEC(EN_VOID);
}

#endif
