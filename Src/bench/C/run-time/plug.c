/*

 #####   #       #    #   ####            ####
 #    #  #       #    #  #    #          #    #
 #    #  #       #    #  #               #
 #####   #       #    #  #  ###   ###    #
 #       #       #    #  #    #   ###    #    #
 #       ######   ####    ####    ###     ####

	A set of routines to plug the run-time in the generated C code.
*/

#include "eif_portable.h"
#include "eif_eiffel.h"
#include "eif_project.h" /* for egc... */
#include "eif_plug.h"
#include "eif_malloc.h"
#if !defined CUSTOM || defined NEED_OPTION_H
#include "eif_option.h"
#endif
#include "rt_macros.h"
#include "eif_except.h"
#include "eif_local.h"
#include "eif_interp.h"
#if !defined CUSTOM || defined NEED_HASHIN_H
#include "eif_hashin.h"
#endif
#include "eif_bits.h"
#include "x2c.h"		/* For macro LNGPAD */
#include <string.h>
#include "rt_assert.h"		/* For assertions checkings. */

#ifdef WORKBENCH
rt_public void discard_breakpoints(void);
rt_public void undiscard_breakpoints(void);
#endif

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

#ifndef EIF_THREADS
/* The nested call flag is set to 1 when a feature call is made within a
 * dot expression. We need to check the invariant before and after the call
 * on those features. This global variable is saved immediately in a local
 * variable upon entrance in the feature, so this is merely an added optional
 * parameter.
 */
rt_public int nstcall = 0;	/* Is current call a nested one? */ /* %%ss mt */
#endif /* EIF_THREADS */

rt_private void recursive_chkinv(EIF_CONTEXT int dtype, EIF_REFERENCE obj, int where);		/* Internal invariant control loop */

/*
 * ARRAY [STRING] creation for initialization of argument of root's
 * class creation routine
 */

rt_public EIF_REFERENCE argarr(EIF_CONTEXT int argc, char **argv)
{
	/* Create an Eiffel ARRAY [STRING] with the values contained in
	 * `argv'
	 */
	EIF_GET_CONTEXT
	EIF_REFERENCE array, sp;
	int16 typres;
	int i;

	/*
	 * Create the array
	 */

	typres = eif_typeof_array_of ((int16)egc_str_dtype);
	array = emalloc((uint32)typres);		/* If we return, it succeeded */
	RT_GC_PROTECT(array); 		/* Protect address in case it moves */
	nstcall = 0;					/* Turn invariant checking off */
	(egc_arrmake)(array, (EIF_INTEGER) 0, argc-1);	/* Call the `make' routine of ARRAY */
	sp = *(EIF_REFERENCE *) array;			/* Get the area of the ARRAY */
	RT_GC_PROTECT (sp);		/* Protect the area */

	/* 
	 * Fill the array
	 */
	for (i=0;i<argc;i++) {
		((EIF_REFERENCE *) sp)[i] = makestr(argv[i], strlen(argv[i]));
	}

	RT_GC_WEAN_N(2);		/* Remove protection for the area and the array */
	return array;
}

/*
 * Manifest array creation for strip
 */

rt_public EIF_REFERENCE striparr(EIF_REFERENCE curr, int dtype, char **items, long int nbr)
{
	/* Create an Eiffel ARRAY[ANY] using current object curr. 
	 * This routine creates the object and returns a pointer to the newly
	 * allocated array or raises a "No more memory" exception.
	 * This object will contain all the attributes of curr except for
	 * items.
	 */
	EIF_GET_CONTEXT
	EIF_REFERENCE array = NULL;
	EIF_REFERENCE sp = NULL;
	EIF_REFERENCE o_ref = NULL;
	EIF_REFERENCE new_obj = NULL;
	EIF_REFERENCE attr = NULL;
	long nbr_attr, stripped_nbr;
	struct cnode *obj_desc;
#ifndef WORKBENCH
	register5 long *offsets;
#else
	register6 int32 *rout_ids;
	long offset;
#endif
	register7 char** attr_names;
	int i;
	char found;
	uint32 type, *types;
	long offset_bis = 0;					/* offset already taken :-) */
	int16   typres;
#ifdef WORKBENCH
	int16 curr_dtype;

	curr_dtype = Dtype(curr);	/* Dynamic type of current object instance */
#endif

		/* Protect all object references */
	RT_GC_PROTECT(curr);
	RT_GC_PROTECT(array);
	RT_GC_PROTECT(sp);
	RT_GC_PROTECT(o_ref);
	RT_GC_PROTECT(new_obj);
	RT_GC_PROTECT(attr);

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
	nstcall = 0;
	(egc_arrmake)(array, (EIF_INTEGER) 1, stripped_nbr);	
								/* Call feature `make' in class ARRAY[ANY] */

	sp = *(EIF_REFERENCE *) array;		/* Get the area of the ARRAY */

	while (nbr_attr--) {
		found = (char) 0;
		for (i=0; (i < nbr) && (!found); i++) {
			attr = items[i];
			if (!(strcmp (attr, attr_names[nbr_attr])))
				found = 't';
		}
		if (!found) {
			type = types[nbr_attr];
#ifndef WORKBENCH
			o_ref = curr + (offsets[nbr_attr]);		
#else
			CAttrOffs(offset,rout_ids[nbr_attr],curr_dtype);
			o_ref = curr + offset;
#endif
			switch(type & SK_HEAD) {
			case SK_REF:
				new_obj = *(EIF_REFERENCE *) o_ref;
				break;
			case SK_CHAR:
				new_obj = RTLN(egc_char_ref_dtype);
				*(EIF_CHARACTER *) new_obj = * (EIF_CHARACTER *) o_ref;
				break;
			case SK_WCHAR:
				new_obj = RTLN(egc_wchar_ref_dtype);
				*(EIF_WIDE_CHAR *) new_obj = *(EIF_WIDE_CHAR *) o_ref;
				break;
			case SK_BOOL:
				new_obj = RTLN(egc_bool_ref_dtype);
				*(EIF_BOOLEAN *) new_obj = *(EIF_BOOLEAN *) o_ref;
				break;
			case SK_INT8:
				new_obj = RTLN(egc_int8_ref_dtype);
				*(EIF_INTEGER_8 *) new_obj = *(EIF_INTEGER_8 *) o_ref;
				break;
			case SK_INT16:
				new_obj = RTLN(egc_int16_ref_dtype);
				*(EIF_INTEGER_16 *) new_obj = *(EIF_INTEGER_16 *) o_ref;
				break;
			case SK_INT32:
				new_obj = RTLN(egc_int32_ref_dtype);
				*(EIF_INTEGER_32 *) new_obj = *(EIF_INTEGER_32 *) o_ref;
				break;
			case SK_INT64:
				new_obj = RTLN(egc_int64_ref_dtype);
				*(EIF_INTEGER_64 *) new_obj = *(EIF_INTEGER_64 *) o_ref;
				break;
			case SK_DOUBLE:
				new_obj = RTLN(egc_doub_ref_dtype);
				*(EIF_DOUBLE *) new_obj = *(EIF_DOUBLE *) o_ref;
				break;
			case SK_FLOAT:
				new_obj = RTLN(egc_real_ref_dtype);
				*(EIF_REAL *) new_obj = *(EIF_REAL *) o_ref;
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
		((EIF_REFERENCE *) sp)[offset_bis++] = new_obj;
		}
	}
	RT_GC_WEAN_N(6);		/* Remove protection for Eiffel objects*/
	return array;
}

rt_public EIF_REFERENCE makestr(register char *s, register int len)
{
	/* Makes an Eiffel STRING object from a C string.
	 * This routine creates the object and returns a pointer to the newly
	 * allocated string or raises a "No more memory" exception.
	 */
	EIF_GET_CONTEXT
	EIF_REFERENCE string;					/* Were string object is located */

	string = emalloc(egc_str_dtype);	/* If we return, it succeeded */

	RT_GC_PROTECT(string); /* Protect address in case it moves */

#ifdef WORKBENCH
	discard_breakpoints(); /* prevent the debugger from stopping in the following 2 functions */
#endif
	nstcall = 0;
	(egc_strmake)(string, (EIF_INTEGER) len);		/* Call feature `make' in class STRING */
	nstcall = 0;
	(egc_strset)(string, (EIF_INTEGER) len);		/* Call feature `set_count' in STRING */
#ifdef WORKBENCH
	undiscard_breakpoints(); /* the debugger can now stop again */
#endif

	/* Copy C string `s' in special object `area' of the new string
	 * descriptor `string'. We know the `area' is the very first reference
	 * of the STRING object, hence the simple de-referencing.
	 */

	memcpy (*(EIF_REFERENCE *)string, s, len);
	RT_GC_WEAN(string);			/* Remove protection */

	return string;
}

/*
 * Special object count
 */

rt_public EIF_INTEGER sp_count(EIF_REFERENCE spobject)
{
	/* Return the count of a special object */

	EIF_REFERENCE ref; 

	REQUIRE ("Not null.", spobject != NULL);
	REQUIRE ("Must be a special object", HEADER (spobject)->ov_flags & EO_SPEC);

	ref = spobject + (HEADER(spobject)->ov_size & B_SIZE) - LNGPAD_2;

	ENSURE ("Must be positive", *(EIF_INTEGER *) ref >= 0);

	return *(EIF_INTEGER *)ref;
}


/*
 * Invariant checking
 */

#ifndef EIF_THREADS
rt_private char *inv_mark_tablep = (char * ) 0;	/* Marking table to avoid checking the same 
									 * invariant several times
									 */ /* %%ss mt renamed conflicting with interp.c */
#endif /* EIF_THREADS */

rt_public void chkinv (EIF_CONTEXT EIF_REFERENCE obj, int where)
		  
		  		/* Invariant is beeing checked before or after compound? */
{
	/* Check invariant on object `obj'. Assumes that `obj' is not null */
	EIF_GET_CONTEXT
	  /*	union overhead *zone = HEADER(obj);    (not used in this fct) */
	int dtype = Dtype(obj);

	if (inv_mark_tablep == (char *) 0)
		if ((inv_mark_tablep = (char *) cmalloc (scount * sizeof(char))) == (char *) 0)
			enomem(MTC_NOARG);

	memset  (inv_mark_tablep, 0, scount);

	recursive_chkinv(MTC dtype, obj, where);	/* Recurive invariant check */
}

#ifdef WORKBENCH
rt_public void chkcinv(EIF_CONTEXT EIF_REFERENCE obj)
{
	/* Check invariant of `obj' after creation. */
	EIF_GET_CONTEXT
	if (~in_assertion & (WASC(Dtype(obj))) & CK_INVARIANT) {
		chkinv(MTC obj,1);}
}
#endif

rt_private void recursive_chkinv(EIF_CONTEXT int dtype, EIF_REFERENCE obj, int where)
		  
		  
		  		/* Invariant is being checked before or after compound? */
{
	/* Recursive invariant check. */
	EIF_GET_CONTEXT
	struct cnode *node = esystem + dtype;
	int *cn_parents;
	int p_type;

	if (dtype <= 0) return;		/* ANY does not have invariants */

	if ((char) 0 != inv_mark_tablep[dtype])	/* Already checked */
		return;
	else
		inv_mark_tablep[dtype] = (char) 1;	/* Mark as checked */

	RT_GC_PROTECT(obj);	/* Automatic protection of `obj' */
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
		uint16 body_id;
		struct item *last;

		CBodyId(body_id,INVARIANT_ID,dtype);
		if (body_id != INVALID_ID) {
			if (egc_frozen [body_id]) {	/* Frozen invariant */
				((void (*)()) egc_frozen[body_id])(obj, where);
			} else 
				/* Melted invariant */
			{					
				last = iget();
				last->type = SK_REF;
				last->it_ref = obj;
				IC = melt[body_id];
				xiinv(MTC IC, where);
			}
		}
	}
#endif

	/* No more propection for `obj' */
	RT_GC_WEAN(obj);
}

#ifdef WORKBENCH

EIF_REFERENCE cr_exp(uint32 type)
										/* Dynamic type */
{
	/* Creates expanded object of type `type'. If it has
	 * a creation routine then call it.
	 */

	EIF_GET_CONTEXT
	EIF_REFERENCE result;
	register1 struct cnode *exp_desc;	/* Expanded object description */

	result = emalloc(type);
	exp_desc = &System(Deif_bid(type));
	if (exp_desc->cn_routids) {
		int32 feature_id;              	/* Creation procedure feature id */
		int32 static_id;               	/* Creation procedure static id */

		feature_id = exp_desc->cn_creation_id;
		static_id = exp_desc->static_id;	
		if (feature_id) {					/* Call creation routine */
			RT_GC_PROTECT(result);	/* Protect address in case it moves */
			wexp(static_id, feature_id, Deif_bid(type), result);
			RT_GC_WEAN(result);            /* Remove protection */
		}
	} else {							/* precompiled creation routine */
		int32 origin;					/* Origin class id */       
		int32 offset;					/* Offset in origin class */

		origin = exp_desc->cn_creation_id;
		offset = exp_desc->static_id;
		if (origin) {						/* Call creation routine */
			RT_GC_PROTECT(result);	/* Protect address in case it moves */
			wpexp(origin, offset, Deif_bid(type), result);
			RT_GC_WEAN(result);            /* Remove protection */
		}
	}
	return result;
}

/*
 * Standard initialization routine for composite objects in
 * workbench mode
 */

void wstdinit(EIF_REFERENCE obj, EIF_REFERENCE parent)
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
	int16 **cn_gtypes;
	long nb_attr;
	struct cnode *desc;
	RTLD;

	/* We have to get GC hooks, in case the creation routines we call on the
	 * expanded objects create some objects.
	 */

	RTLI(2);
	RTLR(0,obj);
	RTLR(1,parent);
	zone->ov_flags |= EO_COMP;				/* Set the composite flag of `obj' */

	dtype = Dtype(obj);
	desc = &System(dtype);
	cn_attr = desc->cn_attr;
	nb_attr = desc->cn_nbattr;
	nb_ref = desc->nb_ref;				/* Reference number */
	cn_types = desc->cn_types;
	cn_gtypes = desc->cn_gtypes;

	for (i = 0; i < nb_attr; i++) {	/* Iteration on attributes descriptions */
		type = cn_types[i];
		switch (type & SK_HEAD) {
		case SK_EXP:						/* Found an expanded attribute */
			{
			struct cnode *exp_desc;			/* Expanded object description */
			/* char *OLD_IC; */ /* %%ss removed */
			long exp_offset;				/* Attribute offset */
			int orig_exp_dtype, exp_dtype;	/* Expanded dynamic type */
			int16 *cid, dftype;

			CAttrOffs(exp_offset,cn_attr[i],dtype);
			orig_exp_dtype = exp_dtype = (int) (type & SK_DTYPE);
			exp_desc = &System(exp_dtype);
			/* Set the expanded reference */
			*(EIF_REFERENCE *) (obj + REFACS(nb_ref - ++nb_exp)) = obj + exp_offset;

			cid = cn_gtypes [i];

			if ((cid != (int16 *) 0) && (cid [1] != -1)) {
				dftype = eif_compound_id ((int16 *)0, parent,(int16) (exp_dtype & EO_TYPE), cid);
				exp_dtype = (exp_dtype & EO_UPPER) | dftype;
			}

			/* Set the flags of the expanded object */
			zone = HEADER(obj + exp_offset);
			zone->ov_flags = exp_dtype;
			zone->ov_flags |= EO_EXP;
			zone->ov_size = exp_offset + (obj - parent);

			/* If expanded object is composite also, initialize it. */
			if (System(orig_exp_dtype).cn_composite)
				wstdinit(obj + exp_offset, parent);

			if (exp_desc->cn_routids) {
				int32 feature_id;			/* Creation procedure feature id */
				int32 static_id;			/* Creation procedure static id */

				feature_id = exp_desc->cn_creation_id;
				static_id = exp_desc->static_id;	
				if (feature_id)				/* Call creation routine */
					wexp(static_id, feature_id, orig_exp_dtype, obj + exp_offset);
			} else {						/* precompiled creation routine */
				int32 origin;				/* Origin class id */       
				int32 offset;				/* Offset in origin class */
		
				origin = exp_desc->cn_creation_id;
				offset = exp_desc->static_id;
				if (origin)					/* Call creation routine */
					wpexp(origin, offset, orig_exp_dtype, obj + exp_offset);
			}
			}
			break;
		case SK_BIT:
			{
			long offset;					/* Attribute offset */
		
			/* Set dynamic type for bit expanded object */	
			CAttrOffs(offset,cn_attr[i],dtype);
			zone = HEADER(obj + offset);
			zone->ov_flags = egc_bit_dtype;
			zone->ov_flags |= EO_EXP;
			zone->ov_size = offset + (obj - parent);
			
			*(uint32 *)(obj + offset) = type & SK_BMASK; /* Write bit size */

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

void rt_norout(EIF_REFERENCE dummy) 
{
	/* Function called when Eiffel is supposed to call a deferred feature
	 * without any implementation in final mode.
	 */

	RTEC(EN_VOID);
}

#endif
