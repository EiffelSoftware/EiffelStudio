/*

 #####   #       #    #   ####            ####
 #    #  #       #    #  #    #          #    #
 #    #  #       #    #  #               #
 #####   #       #    #  #  ###   ###    #
 #       #       #    #  #    #   ###    #    #
 #       ######   ####    ####    ###     ####

	A set of routines to plug the run-time in the generated C code.
*/

#include "eif_project.h" /* for egc... */
#include "eif_config.h"
#include "eif_eiffel.h"
#include "eif_plug.h"
#include "eif_malloc.h"
#if !defined CUSTOM || defined NEED_OPTION_H
#include "eif_option.h"
#endif
#include "eif_macros.h"
#include "eif_except.h"
#include "eif_local.h"
#include "eif_interp.h"
#if !defined CUSTOM || defined NEED_HASHIN_H
#include "eif_hashin.h"
#endif
#include "eif_bits.h"
#include "x2c.h"		/* For macro LNGPAD */


#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

#ifndef EIF_THREADS
/* The nested call flag is sete to 1 when a feature call is made within a
 * dot expression. We need to check the invariant before and after the call
 * on those features. This global variable is saved immediately in a local
 * variable upon entrance in the feature, so this is merely an added optional
 * parameter.
 */
rt_public int nstcall = 0;	/* Is current call a nested one? */ /* %%ss mt */
#endif /* EIF_THREADS */

rt_private void recursive_chkinv(EIF_CONTEXT int dtype, char *obj, int where);		/* Internal invariant control loop */

/*
 * ARRAY [STRING] creation for initialization of argument of root's
 * class creation routine
 */

rt_public char *argarr(EIF_CONTEXT int argc, char **argv)
{
	/* Create an Eiffel ARRAY [STRING] with the values contained in
	 * `argv'
	 */
	EIF_GET_CONTEXT
	char *array, *sp;
	int16 typres;
	int i;

	/*
	 * Create the array
	 */

	typres = eif_typeof_array_of ((int16)egc_str_dtype);
	array = emalloc((uint32)typres);		/* If we return, it succeeded */
	epush(&loc_stack, (char *) &array); 		/* Protect address in case it moves */
	nstcall = 0;					/* Turn invariant checking off */
	(egc_arrmake)(array, 0L, argc-1);	/* Call the `make' routine of ARRAY */
	sp = *(char **) array;			/* Get the area of the ARRAY */
	epush (&loc_stack, (char *) &sp);		/* Protect the area */

	/* 
	 * Fill the array
	 */
	for (i=0;i<argc;i++) {
		((char **) sp)[i] = makestr(argv[i], strlen(argv[i]));
	}

	epop(&loc_stack, 1);		/* Remove protection for area */
	epop(&loc_stack, 1);		/* Remove protection for array */
	return array;

	EIF_END_GET_CONTEXT
}

/*
 * Manifest array creation for strip
 */

rt_public char *striparr(EIF_CONTEXT register char *curr, register int dtype, register char **items, register long int nbr)
{
	/* Create an Eiffel ARRAY[ANY] using current object curr. 
	 * This routine creates the object and returns a pointer to the newly
	 * allocated array or raises a "No more memory" exception.
	 * This object will contain all the attributes of curr except for
	 * items.
	 */
	EIF_GET_CONTEXT
	char *array, *sp, *o_ref; 
	char *new_obj;
	long nbr_attr, stripped_nbr;
	struct cnode *obj_desc;
#ifndef WORKBENCH
	register5 long **offsets;
#else
	register6 int32 *rout_ids;
	long offset;
#endif
	register7 char** attr_names;
	char *attr;
	int i;
	char found;
	int16 curr_dtype;
	uint32 type, *types;
	long offset_bis = 0;					/* offset already taken :-) */
	int16   typres;

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

	typres = eif_typeof_array_of((int16)egc_any_dtype);
	array = emalloc((uint32)typres);	/* If we return, it succeeded */
	epush(&loc_stack, (char *) &array); 	/* Protect address in case it moves */
	nstcall = 0;
	(egc_arrmake)(array, 1L, stripped_nbr);	
								/* Call feature `make' in class ARRAY[ANY] */

	sp = *(char **) array;		/* Get the area of the ARRAY */
	epush (&loc_stack, (char *) &sp);	/* Protect the area */

	while (nbr_attr--) {
		found = (char) NULL;
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
			CAttrOffs(offset,rout_ids[nbr_attr],curr_dtype);
			o_ref = curr + offset;
#endif
			switch(type & SK_HEAD) {
			case SK_REF:
				new_obj = *(char **) o_ref;
				break;
			case SK_CHAR:
				new_obj = RTLN(egc_char_ref_dtype);
				*new_obj = * (char *) o_ref;
				break;
			case SK_BOOL:
				new_obj = RTLN(egc_bool_ref_dtype);
				*new_obj = * (char *) o_ref;
				break;
			case SK_INT:
				new_obj = RTLN(egc_int_ref_dtype);
				*(long *) new_obj = *(long *) o_ref;
				break;
			case SK_DOUBLE:
				new_obj = RTLN(egc_doub_ref_dtype);
				*(double *) new_obj = *(double *) o_ref;
				break;
			case SK_FLOAT:
				new_obj = RTLN(egc_real_ref_dtype);
				*(float *) new_obj = *(float *) o_ref;
				break;
			case SK_POINTER:
				new_obj = RTLN(egc_point_ref_dtype);
				*(fnptr *) new_obj = *(fnptr *) o_ref;
				break;
			case SK_BIT:
				new_obj = b_clone(o_ref);
				break;
			default:
				eif_panic(MTC "unknown attribute type");
				/* NOTREACHED */
			}
	/* It might seem heavy to add the offset each time instead
	 * of taking a pointer which would move from one address
	 * to the following one. But `array' can move and such a pointer 
	 * should be protected. If we push this pointer on the loc_stack,
	 * it is lost on the first call to the GC. Waiting for a better idea.
	 * -- Fabrice.
	 */		
		((char **) sp)[offset_bis++] = new_obj;
		}
	}
	epop(&loc_stack, 1);		/* Remove protection for area */
	epop(&loc_stack, 1);		/* Remove protection for array */
	return array;

	EIF_END_GET_CONTEXT
}

rt_public char *makestr(EIF_CONTEXT register char *s, register int len)
{
	/* Makes an Eiffel STRING object from a C string.
	 * This routine creates the object and returns a pointer to the newly
	 * allocated string or raises a "No more memory" exception.
	 */
	EIF_GET_CONTEXT
	char *string;					/* Were string object is located */

	string = emalloc(egc_str_dtype);	/* If we return, it succeeded */
	epush(&loc_stack, (char *) &string); /* Protect address in case it moves */
	nstcall = 0;
	(egc_strmake)(string, len);		/* Call feature `make' in class STRING */
	nstcall = 0;
	(egc_strset)(string, len);		/* Call feature `set_count' in STRING */

	/* Copy C string `s' in special object `area' of the new string
	 * descriptor `string'. We know the `area' is the very first reference
	 * of the STRING object, hence the simple de-referencing.
	 */

	bcopy(s, *(char **)string, len);
	epop(&loc_stack, 1);			/* Remove protection */

	return string;

	EIF_END_GET_CONTEXT
}

/*
 * Conformance query
 */

rt_public int econfm(int ancestor, int heir)
			 	/* If conformance is true, this must be the ancestor type */
				/* And this must be the heir then */
{
	/* Does dynamic type `heir' conform to dynamic type `ancestor' ? */
	return eif_gen_conf ((int16) heir, (int16) ancestor);
/*
	struct conform *ct = co_table[ancestor];
	unsigned int i;
	int j, k;
	int16 min;

	min = ct->co_min;
	if (heir >= min && heir <= ct->co_max) {
*/
		/* Since the compiler assumed there is 8 bits on a character,
		 * we do the same thing here and hardwire the `8' constant
		 * value. -- FREDD
		 */
/*
		k = heir - min;
		i = (unsigned int) ct->co_tab [k / 8];
		j = 7 - (k % 8);
		return (i & (1 << j)) >> j;
	}

	return 0;
*/
}

/*
 * Special object count
 */

rt_public long sp_count(char *spobject)
{
	/* Return the count of a special object */

	char *ref = spobject + (HEADER(spobject)->ov_size & B_SIZE) - LNGPAD_2;

	return *(long *)ref;
}


/*
 * Invariant checking
 */

#ifndef EIF_THREADS
rt_private char *inv_mark_tablep = (char *) 0;	/* Marking table to avoid checking the same 
									 * invariant several times
									 */ /* %%ss mt renamed conflicting with interp.c */
#endif /* EIF_THREADS */

rt_public void chkinv (EIF_CONTEXT char *obj, int where)
		  
		  		/* Invariant is beeing checked before or after compound? */
{
	/* Check invariant on object `obj'. Assumes that `obj' is not null */
	EIF_GET_CONTEXT
	  /*	union overhead *zone = HEADER(obj);    (not used in this fct) */
	int dtype = Dtype(obj);

	if (inv_mark_tablep == (char *) 0)
		if ((inv_mark_tablep = (char *) cmalloc (scount * sizeof(char))) == (char *) 0)
			enomem(MTC_NOARG);

	bzero (inv_mark_tablep, scount);

	recursive_chkinv(MTC dtype, obj, where);	/* Recurive invariant check */

	EIF_END_GET_CONTEXT
}

#ifdef WORKBENCH
rt_public void chkcinv(EIF_CONTEXT char *obj)
{
	/* Check invariant of `obj' after creation. */
	EIF_GET_CONTEXT
	if (~in_assertion & (WASC(Dtype(obj))) & CK_INVARIANT) {
		chkinv(MTC obj,1);}
	EIF_END_GET_CONTEXT
}
#endif

rt_private void recursive_chkinv(EIF_CONTEXT int dtype, char *obj, int where)
		  
		  
		  		/* Invariant is being checked before or after compound? */
{
	/* Recursive invariant check. */
	EIF_GET_CONTEXT
	struct cnode *node = esystem + dtype;
	int *cn_parents;
	int p_type;

	if (dtype <= 2) return;		/* ANY, GENERAL and PLATFORM do not have invariants */

	if ((char) 0 != inv_mark_tablep[dtype])	/* Already checked */
		return;
	else
		inv_mark_tablep[dtype] = (char) 1;	/* Mark as checked */

	epush(&loc_stack, (char *) &obj);	/* Automatic protection of `obj' */
	cn_parents = node->cn_parents;	/* Recursion on parents first. */

	/* The list of parent dynamic types is always terminated by a
	 * -1 value. -- FREDD
	 */
	while ((p_type = *cn_parents++) != -1)
		/* Call to potential parent invariant */
		recursive_chkinv(MTC p_type, obj, where);

	/* Invariant check */
#ifndef WORKBENCH
	{
		void (*cn_inv)(); /* %%ss moved from above */
		cn_inv = node->cn_inv;
		if (cn_inv != (void (*)()) 0)
			(cn_inv)(obj, where);
	}
#else
	{
		uint32 body_id;
		uint16 body_index;
		struct item *last;

		CBodyIdx(body_index,INVARIANT_ID,dtype);
		if (body_index != INVALID_INDEX) {
			body_id = dispatch[body_index];
			if (body_id < zeroc) { 		/* Frozen invariant */
				((void (*)()) egc_frozen[body_id])(obj, where);
			} else 
#ifndef DLE
				/* Melted invariant */
			{					
				last = iget();
				last->type = SK_REF;
				last->it_ref = obj;
				IC = melt[body_id];
				xiinv(MTC IC, where);
			}
#else
			if (body_id < dle_level) {
					/* Static melted invariant */
				last = iget();
				last->type = SK_REF;
				last->it_ref = obj;
				IC = melt[body_id];
				xiinv(MTC IC, where);
			} else if (body_id < dle_zeroc) {
					/* Dynamic frozen invariant */
				((void (*)()) dle_frozen[body_id])(obj, where);
			} else {
					/* Dynamic melted invariant */
				last = iget();
				last->type = SK_REF;
				last->it_ref = obj;
				IC = dle_melt[body_id];
				xiinv(MTC IC, where);
			}
#endif
		}
	}
#endif

	/* No more propection for `obj' */
	epop(&loc_stack, 1);

	EIF_END_GET_CONTEXT
}

#ifdef WORKBENCH

char *cr_exp(uint32 type)
										/* Dynamic type */
{
	/* Creates expanded object of type `type'. If it has
	 * a creation routine then call it.
	 */

	EIF_GET_CONTEXT
	char *result;
	register1 struct cnode *exp_desc;	/* Expanded object description */

	result = emalloc(type);
	epush(&loc_stack, (char *)(&result));	/* Protect address in case it moves */
	exp_desc = &System(Deif_bid(type));
	if (exp_desc->cn_routids) {
		int32 feature_id;              	/* Creation procedure feature id */
		int32 static_id;               	/* Creation procedure static id */

		feature_id = exp_desc->cn_creation_id;
		static_id = exp_desc->static_id;	
		if (feature_id)					/* Call creation routine */
			wexp(static_id, feature_id, Deif_bid(type), result);
	} else {							/* precompiled creation routine */
		int32 origin;					/* Origin class id */       
		int32 offset;					/* Offset in origin class */

		origin = exp_desc->cn_creation_id;
		offset = exp_desc->static_id;
		if (origin)						/* Call creation routine */
			wpexp(origin, offset, Deif_bid(type), result);
	}
	epop(&loc_stack, 1);            /* Remove protection */
	return result;
	EIF_END_GET_CONTEXT
}

/*
 * Standard initialization routine for composite objects in
 * workbench mode
 */

void wstdinit(char *obj, char *parent)
		  		/* Object we want to initialize */
				/* Parent (enclosing object) */
{
	/* Initialize composite object `obj' */

	EIF_GET_CONTEXT
	int dtype;						/* Dunamic type of `obj' */
	union overhead *zone = HEADER(obj);
	long i; /* %%ss removed , nb; */
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
			/* char *OLD_IC; */ /* %%ss removed */
			long offset;					/* Attribute offset */
			int exp_dtype;					/* Expanded dynamic type */

			CAttrOffs(offset,cn_attr[i],dtype);
			exp_dtype = (int) (type & SK_DTYPE);
			exp_desc = &System(exp_dtype);
			/* Set the expanded reference */
			*(char **) (l[0] + REFACS(nb_ref - ++nb_exp)) = l[0] + offset;
			
			/* Set the flags of the expanded object */
			zone = HEADER(l[0] + offset);
			zone->ov_flags = exp_dtype;
			zone->ov_flags |= EO_EXP;
			zone->ov_size = offset + (l[0] - l[1]);

			/* If expanded object is composite also, initialize it. */
			if (System(exp_dtype).cn_composite)
				wstdinit(l[0] + offset, l[1]);

			if (exp_desc->cn_routids) {
				int32 feature_id;			/* Creation procedure feature id */
				int32 static_id;			/* Creation procedure static id */

				feature_id = exp_desc->cn_creation_id;
				static_id = exp_desc->static_id;	
				if (feature_id)				/* Call creation routine */
					wexp(static_id, feature_id, exp_dtype, l[0] + offset);
			} else {						/* precompiled creation routine */
				int32 origin;				/* Origin class id */       
				int32 offset;				/* Offset in origin class */
		
				origin = exp_desc->cn_creation_id;
				offset = exp_desc->static_id;
				if (origin)					/* Call creation routine */
					wpexp(origin, offset, exp_dtype, l[0] + offset);
			}
			}
			break;
		case SK_BIT:
			{
			long offset;					/* Attribute offset */
		
			/* Set dynamic type for bit expanded object */	
			CAttrOffs(offset,cn_attr[i],dtype);
			zone = HEADER(l[0] + offset);
			zone->ov_flags = egc_bit_dtype;
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
	EIF_END_GET_CONTEXT
}
#endif

#ifndef WORKBENCH

void rt_norout(void) /* %%ss global */
{
	/* Function called when Eiffel is supposed to call a deferred feature
	 * without any implementation in final mode
	 */

	RTEC(EN_VOID);
}

#endif
