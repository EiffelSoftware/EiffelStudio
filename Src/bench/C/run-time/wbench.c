/*
 #    #  #####   ######  #    #   ####   #    #           ####
 #    #  #    #  #       ##   #  #    #  #    #          #    #
 #    #  #####   #####   # #  #  #       ######          #
 # ## #  #    #  #       #  # #  #       #    #   ###    #
 ##  ##  #    #  #       #   ##  #    #  #    #   ###    #    #
 #    #  #####   ######  #    #   ####   #    #   ###     ####

		Workbench primitives
*/

#include "config.h"
#include "macros.h"
#include "malloc.h"
#include "garcol.h"
#include "struct.h"
#include "hashin.h"
#include "except.h"
#include "wbench.h"
#include "interp.h"
#include "plug.h"
#include "project.h"			/* for tabinit() */

/* The following functions implement the access to object features and 
 * attributes in workbench mode, they are:
 * `wfeat (static_type, feature_id, dyn_type)'
 * `wpfeat (origin, offset, dyn_type)'
 * `wfeat_inv (static_type, feature_id, name, object)'
 * `wpfeat_inv (origin, offset, name, object)'
 * `wattr (static_type, feature_id, dyn_type)'
 * `wpattr (origin, offset, dyn_type)'
 * `wattr_inv (static_type, feature_id, name, object)'
 * `wpattr_inv (origin, offset, name, object)'
 * `wtype (static_type, feature_id, dyn_type)'
 * `wptype (origin, offset, dyn_type)'
 * `wdisp (dyn_type)'
 */

rt_public char *(*wfeat(int static_type, int32 feature_id, int dyn_type))(EIF_CONTEXT_NOARG /* ??? */)
{
	/* Function pointer associated to Eiffel feature of feature id
	 * `feature_id' accessed in Eiffel static type `static_type' to
	 * apply on an object of dynamic type `dyn_type'.
	 * Return a function pointer.
	 */
	EIF_GET_CONTEXT
	int32 rout_id;
	uint16 body_index;
	uint32 body_id;

	nstcall = 0;								/* No invariant check */
	rout_id = Routids(static_type)[feature_id]; /* Get the routine id */
	CBodyIdx(body_index,rout_id,dyn_type);		/* Get the body index */
	body_id = dispatch[body_index];

	if (body_id < zeroc) {
		return frozen[body_id];			 /* Frozen feature */
	}
	else 
#ifndef DLE
	{
		IC = melt[body_id];				 /* Position byte code to interpret */
		return pattern[MPatId(body_id)].toi;
	}
#else
	if (body_id < dle_level) {
		IC = melt[body_id];				 /* Position byte code to interpret */
		return pattern[MPatId(body_id)].toi;
	} else if (body_id < dle_zeroc) {
		return dle_frozen[body_id];		 /* Frozen feature in the DC-set */
	} else {
		IC = dle_melt[body_id];			 /* Position byte code to interpret */
		return pattern[DLEMPatId(body_id)].toi;
	}
#endif
}

rt_public char *(*wpfeat(int32 origin, int32 offset, int dyn_type))(EIF_CONTEXT_NOARG /* ??? */)
{
	/* Function pointer associated to Eiffel feature of origin class
	 * `origin', identified by `offset' in that class, and to
	 * apply on an object of dynamic type `dyn_type'.
	 * Return a function pointer.
	 */
	EIF_GET_CONTEXT
	uint32 body_id;

	nstcall = 0;								/* No invariant check */
	body_id = dispatch[desc_tab[origin][dyn_type][offset].info];

	if (body_id < zeroc) {
		return frozen[body_id];			 /* Frozen feature */
	}
	else 
#ifndef DLE
	{
		IC = melt[body_id];				 /* Position byte code to interpret */
		return pattern[MPatId(body_id)].toi;
	}
#else
	if (body_id < dle_level) {
		IC = melt[body_id];				 /* Position byte code to interpret */
		return pattern[MPatId(body_id)].toi;
	} else if (body_id < dle_zeroc) {
		return dle_frozen[body_id];		 /* Frozen feature in the DC-set */
	} else {
		IC = dle_melt[body_id];			 /* Position byte code to interpret */
		return pattern[DLEMPatId(body_id)].toi;
	}
#endif
}

rt_public char *(*wfeat_inv(int static_type, int32 feature_id, char *name, char *object))(EIF_CONTEXT_NOARG /* ??? */)
{
	/* Function pointer associated to Eiffel feature of feature id
	 * `feature_id' accessed in Eiffel static type `static_type' to
	 * apply on an object `object'.
	 * Return a function pointer.
	 */
	EIF_GET_CONTEXT
	int dyn_type;
	int32 rout_id;
	uint16 body_index;
	uint32 body_id;

	if (object == (char *) 0)			/* Void reference check */
			/* Raise an exception for a feature named `name' applied
			 * to a void reference. */
		eraise(name, EN_VOID);

	nstcall = 1;						/* Invariant check on */

	dyn_type = Dtype(object);

	rout_id = Routids(static_type)[feature_id];
	CBodyIdx(body_index,rout_id,dyn_type);
	body_id = dispatch[body_index];

	if (body_id < zeroc)
		return frozen[body_id];
	else 
#ifndef DLE
	{
		IC = melt[body_id];	
		return pattern[MPatId(body_id)].toi;
	}
#else
	if (body_id < dle_level) {
			/* Static melted routine */
		IC = melt[body_id];	
		return pattern[MPatId(body_id)].toi;
	} else if (body_id < dle_zeroc) {
			/* Dynamic frozen routine */
		return dle_frozen[body_id];
	} else {
			/* Dynamic melted routine */
		IC = dle_melt[body_id];	
		return pattern[DLEMPatId(body_id)].toi;
	}
#endif
}

rt_public char *(*wpfeat_inv(int32 origin, int32 offset, char *name, char *object))(EIF_CONTEXT_NOARG /* ??? */)
{
	/* Function pointer associated to Eiffel feature of origin class
	 * `origin', identified by `offset' in that class, and to
	 * apply on an object `object'
	 * Return a function pointer.
	 */
	EIF_GET_CONTEXT
	int dyn_type;
	uint32 body_id;

	if (object == (char *) 0)			/* Void reference check */
			/* Raise an exception for a feature named `name' applied
			 * to a void reference. */
		eraise(name, EN_VOID);

	nstcall = 1;						/* Invariant check on */

	dyn_type = Dtype(object);

	body_id = dispatch[desc_tab[origin][dyn_type][offset].info];

	if (body_id < zeroc)
		return frozen[body_id];
	else 
#ifndef DLE
	{
		IC = melt[body_id];	
		return pattern[MPatId(body_id)].toi;
	}
#else
	if (body_id < dle_level) {
			/* Static melted routine */
		IC = melt[body_id];	
		return pattern[MPatId(body_id)].toi;
	} else if (body_id < dle_zeroc) {
			/* Dynamic frozen routine */
		return dle_frozen[body_id];
	} else {
			/* Dynamic melted routine */
		IC = dle_melt[body_id];	
		return pattern[DLEMPatId(body_id)].toi;
	}
#endif
}


rt_public void wexp(EIF_CONTEXT int static_type, int32 feature_id, int dyn_type, char *object)
{
	/* Call the creation of the expanded.
	 * with static type `stype', dynamic type `dtype' and
	 * feature id `fid'. Apply the function to `object'
	 */
	EIF_GET_CONTEXT
	int32 rout_id;
	uint16 body_index;
	uint32 body_id;
	char *OLD_IC;

	nstcall = 0;								/* No invariant check */
	rout_id = Routids(static_type)[feature_id]; /* Get the routine id */
	CBodyIdx(body_index,rout_id,dyn_type);		/* Get the body index */
	body_id = dispatch[body_index];

	OLD_IC = IC;								/* Save old IC */
	if (body_id < zeroc) 
		((void (*)()) (frozen[body_id])) (object);	/* Frozen feature */
									/* Call frozen creation routine */
	else 
#ifndef DLE
	{
		IC = melt[body_id];	 		/* Position byte code to interpret */
		((void (*)()) (pattern[MPatId(body_id)].toi)) (object);
									/* Call melted creation routine */
	}
#else
	if (body_id < dle_level) {
			/* Static melted routine */
		IC = melt[body_id];	 		/* Position byte code to interpret */
		((void (*)()) (pattern[MPatId(body_id)].toi)) (object);
									/* Call melted creation routine */
	} else if (body_id < dle_zeroc) {
			/* Dynamic frozen routine */
		((void (*)()) (dle_frozen[body_id])) (object);	/* Frozen feature */
									/* Call frozen creation routine */
	} else {
			/* Dynamic melted routine */
		IC = dle_melt[body_id];	 		/* Position byte code to interpret */
		((void (*)()) (pattern[DLEMPatId(body_id)].toi)) (object);
									/* Call melted creation routine */
	}
#endif
	IC = OLD_IC;					/* Restore old IC.
									 * This was needed if expanded objects
									 * had expanded objects (which has a
									 * creation routine which in turn call
									 * the interpreter) so that 
									 * the IC was return to the previous 
									 * state.
									 */
}

rt_public void wpexp(EIF_CONTEXT int32 origin, int32 offset, int dyn_type, char *object)
{
	/* Call the creation of the expanded (when precompiled).
	 * with origin class `origin', dynamic type `dtype' and
	 * offset `offset'. Apply the function to `object'
	 */

	EIF_GET_CONTEXT
	uint32 body_id;
	char *OLD_IC;

	nstcall = 0;								/* No invariant check */
	body_id = dispatch[desc_tab[origin][dyn_type][offset].info];

	OLD_IC = IC;								/* Save old IC */
	if (body_id < zeroc) 
		((void (*)()) (frozen[body_id])) (object);	/* Frozen feature */
									/* Call frozen creation routine */
	else 
#ifndef DLE
	{
		IC = melt[body_id];	 		/* Position byte code to interpret */
		((void (*)()) (pattern[MPatId(body_id)].toi)) (object);
									/* Call melted creation routine */
	}
#else
	if (body_id < dle_level) {
			/* Static melted routine */
		IC = melt[body_id];	 		/* Position byte code to interpret */
		((void (*)()) (pattern[MPatId(body_id)].toi)) (object);
									/* Call melted creation routine */
	} else if (body_id < dle_zeroc) {
			/* Dynamic frozen routine */
		((void (*)()) (dle_frozen[body_id])) (object);	/* Frozen feature */
									/* Call frozen creation routine */
	} else {
			/* Dynamic melted routine */
		IC = dle_melt[body_id];	 		/* Position byte code to interpret */
		((void (*)()) (pattern[DLEMPatId(body_id)].toi)) (object);
									/* Call melted creation routine */
	}
#endif
	IC = OLD_IC;					/* Restore old IC.
									 * This was needed if expanded objects
									 * had expanded objects (which has a
									 * creation routine which in turn call
									 * the interpreter) so that 
									 * the IC was return to the previous 
									 * state.
									 */
}

rt_public long wattr(int static_type, int32 feature_id, int dyn_type)
{
	/* Offset of attribute of feature id `feature_id' in the class of
	 * static type `static_type' in an object of dynamic type `dyn_type'.
	 * Return a long integer.
	 */

	int32 rout_id;
	long offset;

	rout_id = Routids(static_type)[feature_id];
	CAttrOffs(offset,rout_id,dyn_type);
	return (offset);
}

rt_public long wpattr(int32 origin, int32 offset, int dyn_type)
{
	/* Offset of precompiled attribute of origin class `origin', identified by
	 * `offset' in that class, in an object of dynamic type `dyn_type'.
	 * Return a long integer.
	 */

	return (desc_tab[origin][dyn_type][offset].info);
}

rt_public long wattr_inv (int static_type, int32 feature_id, char *name, char *object)
                
                 
             	/* Target object */
           		/* Feature name to apply */
{
	/* Offset of attribute of feature id `feature_id' in the class of
	 * static type `static_type' in an object `object'.
	 * Return a long integer.
	 * Invariants are currently not being checked on attribute access
	 * The code is commented out -- FRED
	 */

	int dyn_type;
	int32 rout_id;
	long offset;

	if (object == (char *) 0)			/* Void reference check */
			/* Raise an exception for a feature named `fname' applied
			 * to a void reference. */
		eraise(name, EN_VOID);

	dyn_type = Dtype(object);

/*
 * Commented out by FRED
 *
 *	if (~in_assertion & WASC(dyn_type) & CK_INVARIANT) {
 *		in_assertion = ~0;
 *		chkinv(object);
 *		in_assertion = 0;
 *	}
 */

	rout_id = Routids(static_type)[feature_id];
	CAttrOffs(offset,rout_id,dyn_type);
	return (offset);
}

rt_public long wpattr_inv (int32 origin, int32 offset, char *name, char *object)
                     
             	/* Target object */
           		/* Feature name to apply */
{
	/* Offset of precompiled attribute of origin class `origin', identified by
	 * `offset' in that class, in an object `object'.
	 * Return a long integer.
	 * Invariants are currently not being checked on attribute access
	 * The code is commented out -- FRED
	 */

	int dyn_type;

	if (object == (char *) 0)			/* Void reference check */
			/* Raise an exception for a feature named `fname' applied
			 * to a void reference. */
		eraise(name, EN_VOID);

	dyn_type = Dtype(object);

/*
 * Commented out by FRED
 *
 *	if (~in_assertion & WASC(dyn_type) & CK_INVARIANT) {
 *		in_assertion = ~0;
 *		chkinv(object);
 *		in_assertion = 0;
 *	}
 */

	return (desc_tab[origin][dyn_type][offset].info);
}

rt_public int wtype(int static_type, int32 feature_id, int dyn_type)
{
	/* Type of feature of routine id `rout_id' in the class of
	 * dynamic type `dyn_type'.
	 * Return an integer.
	 */ 

	int32 rout_id;
	int type;

	rout_id = Routids(static_type)[feature_id];
	CFeatType(type,rout_id,dyn_type);
	type = RTUD(type);
	return (type & SK_DTYPE);
}

rt_public int wptype(int32 origin, int32 offset, int dyn_type)
{
	/* Type of feature of routine identified by `offset' in its origin class
	 * `origin' and to be applied on an object of dynamic type `dyn_type'.
	 * Return an integer.
	 */ 

	int type;

	type = RTUD(desc_tab[origin][dyn_type][offset].type);
	return (type & SK_DTYPE);
}

rt_public char *(*wdisp(int dyn_type))(EIF_CONTEXT_NOARG /* ??? */)
{
	/* Function pointer associated to Eiffel feature of routine id
	 * `routine_id' accessed in Eiffel dynamic type `dyn_type'.
	 * Return a function pointer.
	 */
	EIF_GET_CONTEXT
	uint16 body_index;
	uint32 body_id;

	nstcall = 0;								/* No invariant check */
	CBodyIdx(body_index,disp_rout_id,dyn_type);	/* Get the body index */
	body_id = dispatch[body_index];

	if (body_id < zeroc) {
		return frozen[body_id];		 /* Frozen feature */
	}
	else 
#ifndef DLE
	{
		IC = melt[body_id];	 /* Position byte code to interpret */
		return pattern[MPatId(body_id)].toi;
	}
#else
	if (body_id < dle_level) {
			/* Static melted routine */
		IC = melt[body_id];	 /* Position byte code to interpret */
		return pattern[MPatId(body_id)].toi;
	} else if (body_id < dle_zeroc) {
			/* Dynamic frozen feature */
		return dle_frozen[body_id];
	} else {
			/* Dynamic melted routine */
		IC = dle_melt[body_id];	 /* Position byte code to interpret */
		return pattern[DLEMPatId(body_id)].toi;
	}
#endif
}

/*
 * Initialization of the run time feature call structures. 
 * The central call structure is called `desc_tab'.
 * It contains one entry per class (NOT class type) and
 * it is indexed by class id (not the toplogical id).
 * The entry for a given class is a table of descriptor
 * pointers, and is indexed by "dynamic" class type ids.
 */

struct desc_info ***desc_tab; 			/* Global descriptor table */

/* Temporary structures used for the construction
 * of the global descriptor table. The `bounds_tab' table
 * contains the bounds (minimum and maximum dynamic class
 * type ids) for each class in the system.
 */

struct bounds { 			/* Structure used to record min/max dtypes */
	int16 min;
	int16 max;
};
struct bounds *bounds_tab;	/* Bounds of the various classes */
char desc_fill;				/* Flag for descriptor table initialization */

/* Temporary structures for melted descriptors 
 * When the byte code file is read, all new 
 * descriptors are recorded, so that they can
 * be porperly inserted during the insertion pass
 */

struct mdesc {				/* Structure used to record melted descriptor */
	struct desc_info *desc_ptr;
	int16 origin;
	int16 type;
};

struct mdesc *mdesc_tab;	/* Temporary table of melted descriptors */
int mdesc_count;			/* Number of melted descriptors */
int mdesc_tab_size;			/* Size of the `mdesc_tab' */
#define MDESC_INC 10000		/* Size increment of `mdesc_tab' */

/* The following routines are used to build the
 * global descriptor table
 */

rt_public void init_desc(void)
{
	/* Initialize the temporary structures used for the
	 * construction of the global descriptor table.
	 */

	int i;
	struct bounds def;

	def.max = -1; def.min = ccount;
	bounds_tab = (struct bounds *) 
			cmalloc (sizeof(struct bounds) * (ccount + 1));	
	if ((struct bounds *) 0 == bounds_tab)
		enomem(MTC_NOARG);
	mdesc_tab = (struct mdesc *) 
			cmalloc (sizeof(struct mdesc) * MDESC_INC);
	if ((struct mdesc *) 0 == mdesc_tab)
		enomem(MTC_NOARG);
	mdesc_tab_size = MDESC_INC;
	mdesc_count = 0;
	
	for (i=0;i<=ccount;i++)
		bounds_tab[i] = def;

	desc_fill = 0;
	tabinit();
}

rt_public void put_desc(struct desc_info *desc_ptr, int org, int dtype)
{
	/* If the `desc_fill' flag is set to false, simply record
	 * the value of the dynamic type (to compute the size
	 * of the global descriptor table)
	 * Otherwise (the global table has already been allocated)
	 * insert the descriptor pointer at the appropriate location
	 */

	struct bounds *b;

	if (0 != desc_fill) {
		(desc_tab[org])[dtype] = desc_ptr;
	} else {
		b = bounds_tab+org;
		b->min += (dtype<b->min)?(dtype-b->min):0;
		b->max += (dtype>b->max)?(dtype-b->max):0;
	}
}

rt_public void put_mdesc(struct desc_info *desc_ptr, int org, int dtype)
{
	/* Record melted descriptor:
	 * Record the value of the dynamic type (to compute the size
	 * of the global descriptor table)
	 * Save the descripotr pointer and the insertion information
	 * for the actual insertion.
	 */
	struct bounds *b;
	struct mdesc md;

	/* Update bounds table */

	if (0 == desc_fill) {
		b = bounds_tab+org;
		b->min += (dtype<b->min)?(dtype-b->min):0;
		b->max += (dtype>b->max)?(dtype-b->max):0;
	}	

	/* Insert information in temporary table */

	if (mdesc_tab_size <= mdesc_count) { 
		mdesc_tab_size += MDESC_INC;
		mdesc_tab = (struct mdesc *) 
				crealloc ((char *) mdesc_tab, sizeof(struct mdesc) * mdesc_tab_size);	
		if ((struct mdesc *) 0 == mdesc_tab)
			enomem(MTC_NOARG);
	}

	md.desc_ptr = desc_ptr;
	md.origin = org;
	md.type = dtype;

	mdesc_tab[mdesc_count++] = md;
}

rt_public void create_desc(void)
{
	struct bounds *b;
	int i, upper;
	struct desc_info **tab;
	struct mdesc *mdesc_ptr;
	int size;

	for (i=upper=0;i<=ccount;i++) {
		b = bounds_tab+i;
		upper += (-1==b->max)?0:(i-upper);
	}

	/* Allocation of the global descriptor table.
	 */

	desc_tab = (struct desc_info ***) 
			cmalloc (sizeof(struct desc_info **) * (upper + 1));
	if ((struct desc_info ***) 0 == desc_tab)
		enomem(MTC_NOARG);

	/* Allocation of the subtables
	 * and insertion
	 */

	for (i=0;i<=upper;i++) {
		b = bounds_tab+i;
		size = b->max - b->min + 1;
		if (size > 0) {
			tab = (struct desc_info **) 
				cmalloc (sizeof(struct desc_info *) * size);
			if ((struct desc_info **) 0 == tab)
				enomem(MTC_NOARG);
			/* The hack of the century */
			desc_tab[i] = tab - b->min; 
		}
	}


	/* Free temporary structure */
	xfree((char *) bounds_tab);

	/* Actually fill the call structure */

	desc_fill = 1;
	tabinit();

	/* Fill the call structures with the melted descriptors */

	for(i=0;i<mdesc_count;i++) {
		mdesc_ptr = &(mdesc_tab[i]);
		(desc_tab[mdesc_ptr->origin])[mdesc_ptr->type] 
				= mdesc_ptr->desc_ptr;
	}

	/* Free temporary structure */
	xfree((char *) mdesc_tab);
}
