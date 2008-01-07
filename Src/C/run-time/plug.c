/*
	description: "A set of routines to plug the run-time in the generated C code."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2007, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="plug.c" header="eif_plug.h" version="$Id$" summary="Set of routines to plug run-time into generated C code">
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
#include "rt_except.h"
#include "eif_local.h"
#include "rt_interp.h"
#if !defined CUSTOM || defined NEED_HASHIN_H
#include "rt_hashin.h"
#endif
#include "eif_bits.h"
#include "rt_struct.h"
#include "x2c.h"		/* For macro LNGPAD */
#include <string.h>
#include "rt_assert.h"		/* For assertions checkings. */
#include "rt_gen_conf.h"
#include "rt_gen_types.h"
#include "rt_garcol.h"
#include "rt_globals.h"

#ifdef WORKBENCH
rt_public void discard_breakpoints(void);
rt_public void undiscard_breakpoints(void);
#endif

#ifndef EIF_THREADS
/*
doc:	<attribute name="nstcall" return_type="int" export="public">
doc:		<summary>Is current call a nested one? The nested call flag is set to 1 when a feature call is made within a dot expression. We need to check the invariant before and after the call on those features. This global variable is saved immediately in a local variable upon entrance in the feature, so this is merely an added optional parameter.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data.</synchronization>
doc:	</attribute>
*/
rt_public int nstcall = 0;
rt_public int16 caller_assertion_level = 0;
#endif /* EIF_THREADS */

rt_private void recursive_chkinv(EIF_TYPE_INDEX dtype, EIF_REFERENCE obj, int where);		/* Internal invariant control loop */

/*
 * ARRAY [STRING] creation for initialization of argument of root's
 * class creation routine
 */

rt_public EIF_REFERENCE argarr(int argc, char **argv)
{
	/* Create an Eiffel ARRAY [STRING] with the values contained in
	 * `argv'
	 */
	EIF_GET_CONTEXT
	EIF_REFERENCE array, sp;
	EIF_TYPE_INDEX typres;
	int i;

	/*
	 * Create the array
	 */

	typres = eif_typeof_array_of (egc_str_dtype);
	array = emalloc(typres);		/* If we return, it succeeded */
	RT_GC_PROTECT(array); 		/* Protect address in case it moves */
	nstcall = 0;					/* Turn invariant checking off */
#ifdef WORKBENCH
	discard_breakpoints(); /* prevent the debugger from stopping in the following 2 functions */
	{
		EIF_TYPED_VALUE u_lower;
		EIF_TYPED_VALUE u_upper;
		u_lower.type = SK_INT32;
		u_lower.it_i4 = 0;
		u_upper.type = SK_INT32;
		u_upper.it_i4 = argc-1;
		(egc_arrmake)(array, u_lower, u_upper);	/* Call the `make' routine of ARRAY */
	}
#else
	(egc_arrmake)(array, (EIF_INTEGER) 0, argc-1);	/* Call the `make' routine of ARRAY */
#endif
	sp = *(EIF_REFERENCE *) array;			/* Get the area of the ARRAY */
	RT_GC_PROTECT (sp);		/* Protect the area */

	/* 
	 * Fill the array
	 */
	for (i=0; i<argc; i++) {
		((EIF_REFERENCE *) sp)[i] = makestr(argv[i], strlen(argv[i]));
		RTAR(sp, ((EIF_REFERENCE *)sp)[i]);
	}

#ifdef WORKBENCH
	undiscard_breakpoints(); /* the debugger can now stop again */
#endif
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
	long *offsets;
#else
	int32 *rout_ids;
	long offset;
#endif
	char** attr_names;
	int i;
	char found;
	uint32 type, *types;
	long offset_bis = 0;					/* offset already taken :-) */
	EIF_TYPE_INDEX   typres;
#ifdef WORKBENCH
	EIF_TYPE_INDEX curr_dtype;

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

	typres = eif_typeof_array_of(egc_any_dtype);
	array = emalloc(typres);	/* If we return, it succeeded */
	nstcall = 0;
#ifdef WORKBENCH
	{
		EIF_TYPED_VALUE u_lower;
		EIF_TYPED_VALUE u_upper;
		u_lower.type = SK_INT32;
		u_lower.it_i4 = 1;
		u_upper.type = SK_INT32;
		u_upper.it_i4 = stripped_nbr;
		(egc_arrmake)(array, u_lower, u_upper); /* Call feature `make' in class ARRAY[ANY] */
	}
#else
	(egc_arrmake)(array, (EIF_INTEGER) 1, stripped_nbr); /* Call feature `make' in class ARRAY[ANY] */
#endif

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
			case SK_UINT8:
				new_obj = RTLN(egc_uint8_ref_dtype);
				*(EIF_NATURAL_8 *) new_obj = *(EIF_NATURAL_8 *) o_ref;
				break;
			case SK_UINT16:
				new_obj = RTLN(egc_uint16_ref_dtype);
				*(EIF_NATURAL_16 *) new_obj = *(EIF_NATURAL_16 *) o_ref;
				break;
			case SK_UINT32:
				new_obj = RTLN(egc_uint32_ref_dtype);
				*(EIF_NATURAL_32 *) new_obj = *(EIF_NATURAL_32 *) o_ref;
				break;
			case SK_UINT64:
				new_obj = RTLN(egc_uint64_ref_dtype);
				*(EIF_NATURAL_64 *) new_obj = *(EIF_NATURAL_64 *) o_ref;
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
			case SK_REAL64:
				new_obj = RTLN(egc_real64_ref_dtype);
				*(EIF_REAL_64 *) new_obj = *(EIF_REAL_64 *) o_ref;
				break;
			case SK_REAL32:
				new_obj = RTLN(egc_real32_ref_dtype);
				*(EIF_REAL_32 *) new_obj = *(EIF_REAL_32 *) o_ref;
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

rt_public EIF_REFERENCE makestr(register char *s, register size_t len)
	/* Makes an Eiffel STRING object from a C string.
	 * This routine creates the object and returns a pointer to the newly
	 * allocated string or raises a "No more memory" exception.
	 */
{
	return makestr_with_hash (s, len, 0);
}

rt_public EIF_REFERENCE makestr_with_hash (register char *s, register size_t len, register int a_hash)
	/* Makes an Eiffel STRING object from a C string with precomputed hash code value `a_hash'.
	 * This routine creates the object and returns a pointer to the newly
	 * allocated string or raises a "No more memory" exception.
	 */
{
	EIF_GET_CONTEXT
	EIF_REFERENCE string;					/* Were string object is located */

	string = emalloc(egc_str_dtype);	/* If we return, it succeeded */

	RT_GC_PROTECT(string); /* Protect address in case it moves */

#ifdef WORKBENCH
	discard_breakpoints(); /* prevent the debugger from stopping in the following 2 functions */
#endif
	nstcall = 0;
	RT_STRING_MAKE(string, (EIF_INTEGER) len);		/* Call feature `make' in class STRING */
	RT_STRING_SET_HASH_CODE(string, a_hash);
	RT_STRING_SET_COUNT(string, len);
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
doc:	<routine name="makestr_with_hash_as_old" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Makes an Eiffel STRING object from a C string with precomputed hash code value `a_hash'. The Eiffel object is allocated as an old object as we know it will last for the complete execution of the system. It is mostly used for once manifest strings so that the GC only mark the object while doing a full collection, not for the small collections.</summary>
doc:		<param name="s" type="char *">C string used to create the Eiffel string.</param>
doc:		<param name="len" type="size_t">Length of the C string `s'.</param>
doc:		<param name="a_hash" type="int">Hashcode of `s'.</param>
doc:		<return>A newly allocated string with the same content as `s' if successful, otherwise throw an exception.</return>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE makestr_with_hash_as_old (register char *s, register size_t len, register int a_hash)
{
	EIF_GET_CONTEXT
	EIF_REFERENCE string;					/* Were string object is located */

	string = emalloc_as_old (egc_str_dtype); /* If we return, it succeeded */

	RT_GC_PROTECT(string); /* Protect address in case it moves */

#ifdef WORKBENCH
	discard_breakpoints(); /* prevent the debugger from stopping in the following 2 functions */
#endif
	nstcall = 0;
	RT_STRING_MAKE(string, (EIF_INTEGER) len);		/* Call feature `make' in class STRING */
	RT_STRING_SET_HASH_CODE(string, a_hash);
	RT_STRING_SET_COUNT(string, len);
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
	/* Return the count of a special or TUPLE object */

	EIF_INTEGER res; 

	REQUIRE ("Not null.", spobject != NULL);
	REQUIRE ("Must be a special object", HEADER (spobject)->ov_flags & EO_SPEC);

	res = RT_SPECIAL_COUNT(spobject);

	ENSURE ("Must be positive", res >= 0);

	return res;
}

rt_public EIF_INTEGER sp_elem_size(EIF_REFERENCE spobject)
{
	/* Return the size of the element of a SPECIAL */

	EIF_INTEGER res;

	REQUIRE ("Not null.", spobject != NULL);
	REQUIRE ("Must be a special object", HEADER (spobject)->ov_flags & EO_SPEC);

	res = RT_SPECIAL_ELEM_SIZE(spobject);

	ENSURE ("Must be positive", res >= 0);

	return res;
}


/*
 * Invariant checking
 */

#ifndef EIF_THREADS
/*
doc:	<attribute name="inv_mark_tablep" return_type="char *" export="private">
doc:		<summary>Marking table to avoid checking the same invariant several times.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private char *inv_mark_tablep = (char * ) 0;
#endif /* EIF_THREADS */

rt_public void chkinv (EIF_REFERENCE obj, int where)
		  
		  		/* Invariant is beeing checked before or after compound? */
{
	/* Check invariant on object `obj'. Assumes that `obj' is not null */
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	
	/* Store the `where' infomation for later use */
	echentry = !where;

	if (inv_mark_tablep == (char *) 0)
		if ((inv_mark_tablep = (char *) cmalloc (scount * sizeof(char))) == (char *) 0)
			enomem(MTC_NOARG);

	memset  (inv_mark_tablep, 0, scount);

	recursive_chkinv(MTC Dtype(obj), obj, where);	/* Recurive invariant check */
}

rt_public void chkcinv(EIF_REFERENCE obj)
{
	/* Check invariant of `obj' after creation. */
	EIF_GET_CONTEXT
	if (~in_assertion & (WASC(Dtype(obj))) & CK_INVARIANT) {
		chkinv(MTC obj,1);}
}

rt_private void recursive_chkinv(EIF_TYPE_INDEX dtype, EIF_REFERENCE obj, int where)
		  
		  
		  		/* Invariant is being checked before or after compound? */
{
	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	/* Recursive invariant check. */
	struct cnode *node = esystem + dtype;
	EIF_TYPE_INDEX *cn_parents;
	EIF_TYPE_INDEX p_type;
	jmp_buf exenv;

	if (dtype == 0) return;		/* ANY does not have invariants */

	if ((char) 0 != inv_mark_tablep[dtype]) {/* Already checked */
		return;
	} else {
		inv_mark_tablep[dtype] = (char) 1;	/* Mark as checked */
	}

	excatch(&exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		RT_GC_WEAN(obj);	/* Remove protection. This fixes eweasel test#melt076 and possibly others. */
		ereturn();			/* Propagate exception */
	}

	RT_GC_PROTECT(obj);	/* Automatic protection of `obj' */
	cn_parents = node->cn_parents;	/* Recursion on parents first. */

	/* The list of parent dynamic types is always terminated by a
	 * -1 value. -- FREDD
	 */
	while ((p_type = *cn_parents++) != TERMINATOR)
		/* Call to potential parent invariant */
		recursive_chkinv(MTC p_type, obj, where);

	/* Invariant check */
#ifndef WORKBENCH
	{
		void (*cn_inv)(EIF_REFERENCE, EIF_INTEGER);
		cn_inv = FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER)) node->cn_inv;
		if (cn_inv)
			(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER)) cn_inv)(obj, where);
	}
#else
	{
		BODY_INDEX body_id;
		EIF_TYPED_VALUE *last;

		CBodyId(body_id,INVARIANT_ID,dtype);
		if (body_id != INVALID_ID) {
			if (egc_frozen [body_id]) {	/* Frozen invariant */
				(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER)) egc_frozen[body_id])
				  	(obj, where);
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

		/* Restore exception stack. */
	expop(&eif_stack);
}

/*
doc:	<routine name="cr_exp" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Create a new expanded object of type `type' and call its associated creation procedure.</summary>
doc:		<param name="type" type="EIF_TYPE_INDEX">An Eiffel expanded object type.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE cr_exp(EIF_TYPE_INDEX type)
	/* Create an instance of expanded object of dynamic type id `type'. */
{
	EIF_GET_CONTEXT
	EIF_REFERENCE result;

	result = RTLN(type);
	RT_GC_PROTECT(result);	/* Protect address in case it moves */
	init_exp (result);
	RT_GC_WEAN(result);            /* Remove protection */

	return result;
}

/*
doc:	<routine name="init_exp" return_type="void" export="public">
doc:		<summary>Initialize object `obj' by calling associated creation procedure.</summary>
doc:		<param name="obj" type="EIF_REFERENCE">An Eiffel expanded object.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/

void init_exp (EIF_REFERENCE obj)
{
#ifndef WORKBENCH
	void *(*creation_procedure)(EIF_REFERENCE);	/* Initialization routine to be called */

	creation_procedure = (void *(*) (EIF_REFERENCE)) egc_exp_create[Dtype(obj)];
	if (creation_procedure) {
		creation_procedure (obj);
	}
#else
	EIF_TYPE_INDEX dtype = Dtype(obj);
	struct cnode *exp_desc;	/* Expanded object description */
	exp_desc = &System(Dtype(obj));

	if (exp_desc->cn_routids) {
		int32 feature_id;              	/* Creation procedure feature id */
		int32 static_id;               	/* Creation procedure static id */

		feature_id = exp_desc->cn_creation_id;
		static_id = exp_desc->cn_static_id;	
		if (feature_id) {					/* Call creation routine */
			wexp(static_id, feature_id, dtype, obj);
		}
	} else {							/* precompiled creation routine */
		int32 origin;					/* Origin class id */       
		int32 offset;					/* Offset in origin class */

		origin = exp_desc->cn_creation_id;
		offset = exp_desc->cn_static_id;
		if (origin) {						/* Call creation routine */
			wpexp(origin, offset, dtype, obj);
		}
	}
#endif
}

#ifdef WORKBENCH
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
	EIF_TYPE_INDEX dtype;						/* Dunamic type of `obj' */
	union overhead *zone = HEADER(obj);
	long i; /* %%ss removed , nb; */
	long nb_exp = 0L;
	long nb_ref;					/* Number of references in `obj' */
	uint32 type;
	int32 *cn_attr;
	uint32 *cn_types;
	EIF_TYPE_INDEX **cn_gtypes;
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
	nb_ref = desc->cn_nbref;				/* Reference number */
	cn_types = desc->cn_types;
	cn_gtypes = desc->cn_gtypes;

	for (i = 0; i < nb_attr; i++) {	/* Iteration on attributes descriptions */
		type = cn_types[i];
		switch (type & SK_HEAD) {
		case SK_EXP:						/* Found an expanded attribute */
			{
			struct cnode *exp_desc;			/* Expanded object description */
			/* char *OLD_IC; */ /* %%ss removed */
			uint32 exp_offset;				/* Attribute offset */
			EIF_TYPE_INDEX orig_exp_dtype, exp_dtype;	/* Expanded dynamic type */
			EIF_TYPE_INDEX *cid, dftype;

			CAttrOffs(exp_offset,cn_attr[i],dtype);
			orig_exp_dtype = exp_dtype = (EIF_TYPE_INDEX) (type & SK_DTYPE);
			exp_desc = &System(exp_dtype);
			/* Set the expanded reference */
			*(EIF_REFERENCE *) (obj + REFACS(nb_ref - ++nb_exp)) = obj + exp_offset;

			cid = cn_gtypes [i];

			if (cid && (cid [1] != TERMINATOR)) {
				dftype = eif_compound_id (NULL, Dftype (obj), exp_dtype, cid);
				exp_dtype = To_dtype(dftype);
			} else {
				dftype = exp_dtype;
			}

			/* Set the flags of the expanded object */
			zone = HEADER(obj + exp_offset);
			zone->ov_flags = EO_EXP;
			zone->ov_dftype = dftype;
			zone->ov_dtype = exp_dtype;
			CHECK("valid offset", (obj - parent) <= 0x7FFFFFFF);
			zone->ov_size = exp_offset + (uint32) (obj - parent);

			/* If expanded object is composite also, initialize it. */
			if (EIF_IS_COMPOSITE_TYPE(System(orig_exp_dtype))) {
				wstdinit(obj + exp_offset, parent);
			}

			if (exp_desc->cn_routids) {
				int32 feature_id;			/* Creation procedure feature id */
				int32 static_id;			/* Creation procedure static id */

				feature_id = exp_desc->cn_creation_id;
				static_id = exp_desc->cn_static_id;	
				if (feature_id)				/* Call creation routine */
					wexp(static_id, feature_id, orig_exp_dtype, obj + exp_offset);
			} else {						/* precompiled creation routine */
				int32 origin;				/* Origin class id */       
				int32 offset;				/* Offset in origin class */
		
				origin = exp_desc->cn_creation_id;
				offset = exp_desc->cn_static_id;
				if (origin)					/* Call creation routine */
					wpexp(origin, offset, orig_exp_dtype, obj + exp_offset);
			}
			}
			break;
		case SK_BIT:
			{
			uint32 offset;					/* Attribute offset */
		
			/* Set dynamic type for bit expanded object */	
			CAttrOffs(offset,cn_attr[i],dtype);
			zone = HEADER(obj + offset);
			zone->ov_dftype = egc_bit_dtype;
			zone->ov_dtype = egc_bit_dtype;
			zone->ov_flags |= EO_EXP;
			CHECK("valid offset", (obj - parent) <= 0x7FFFFFFF);
			zone->ov_size = offset + (uint32) (obj - parent);
			
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

/*
doc:</file>
*/
