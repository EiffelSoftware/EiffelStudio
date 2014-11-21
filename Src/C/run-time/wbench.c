/*
	description: "Workbench primitives."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2010, Eiffel Software."
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
doc:<file name="wbench.c" header="eif_wbench.h" version="$Id$" summary="Workbench primitives">
*/

#ifdef WORKBENCH

#include "eif_portable.h"
#include "rt_wbench.h"
#include "eif_project.h"
#include "rt_macros.h"
#include "rt_malloc.h"
#include "eif_garcol.h"
#include "rt_struct.h"
#include "rt_hashin.h"
#include "eif_except.h"
#include "eif_interp.h"
#include "eif_plug.h"
#include "rt_gen_conf.h"
#include "rt_assert.h"

/* The following functions implement the access to object features and 
 * attributes in workbench mode. */

#ifdef EIF_ASSERTIONS
/*
doc:	<routine name="rt_is_call_allowed" return_type="int" export="private">
doc:		<summary>Figure out if a call to an Eiffel routine is allowed. Typically it is allowed when no GC synchronization point is happening.</summary>
doc:		<return>Return 0 if not allowed, Non-zero otherwise</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Uses per thread data.</synchronization>
doc:	</routine>
*/
rt_private int rt_is_call_allowed(void)
{
#ifdef EIF_THREADS
		/* If they are 2 or more running threads, then we need to make
		 * sure that Eiffel code is not executing on the non GC thread. */
	if (eif_is_gc_collecting >= EIF_GC_STARTED_WITH_MULTIPLE_RUNNING_THREADS) {
		RT_GET_CONTEXT
			/* If we are the thread running the GC cycle, then we are ok. */
		return (gc_thread_status == EIF_THREAD_GC_RUNNING);
	} else {
		return 1;
	}
#else
	return 1;
#endif
}
#endif

/*
doc:	<routine name="wfeat" return_type="EIF_REFERENCE_FUNCTION" export="public">
doc:		<summary>Function pointer associated to Eiffel feature of routine ID `routine_id' applied to an object of dynamic type `dtype'.</summary>
doc:		<param name="routine_id" type="int">Routine ID of feature being called.</param>
doc:		<param name="dtype" type="EIF_TYPE_INDEX">Dynamic type of object on which feature will be applied.</param>
doc:		<return>Function pointer</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Uses per thread data.</synchronization>
doc:	</routine>
*/
rt_public EIF_REFERENCE_FUNCTION wfeat(int routine_id, EIF_TYPE_INDEX dtype)
{
	BODY_INDEX body_id;

	CHECK("Not called by non-GC thread", rt_is_call_allowed());

	CBodyId(body_id,routine_id,dtype);		/* Get the body index */

	if (egc_frozen [body_id])
		return egc_frozen[body_id];			 /* Frozen feature */
	else {
			/* Slow part. */
		EIF_GET_CONTEXT
		IC = melt[body_id];				 /* Position byte code to interpret */
		return pattern[MPatId(body_id)].toi;
	}
}

/*
doc:	<routine name="wfeat_inv" return_type="EIF_REFERENCE_FUNCTION" export="public">
doc:		<summary>Function pointer associated to a qualified call to Eiffel feature of routine ID `routine_id' and name `name' applied to an object `object'.</summary>
doc:		<param name="routine_id" type="int">Routine ID of feature being called.</param>
doc:		<param name="name" type="char *">Name of feature being called.</param>
doc:		<param name="object" type="EIF_REFERENCE">Object on which feature will be applied.</param>
doc:		<return>Function pointer</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Uses per thread data.</synchronization>
doc:	</routine>
*/
rt_public EIF_REFERENCE_FUNCTION wfeat_inv(int routine_id, char *name, EIF_REFERENCE object)
{
	if (object == NULL) {			/* Void reference check */
			/* Raise an exception for a feature named `name' applied
			 * to a void reference. */
		eraise(name, EN_VOID);
		return NULL;
	} else {
		return wfeat(routine_id, Dtype(object));
	}
}

/*
doc:	<routine name="wattr" return_type="long" export="public">
doc:		<summary>Attribute offset of attribute of routine ID `routine_id' applied to an object of dynamic type `dtype'.</summary>
doc:		<param name="routine_id" type="int">Routine ID of attribute being accessed.</param>
doc:		<param name="dtype" type="EIF_TYPE_INDEX">Dynamic type of object on which attribute will be accessed.</param>
doc:		<return>Offset</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Uses per thread data.</synchronization>
doc:	</routine>
*/
rt_public long wattr(int routine_id, EIF_TYPE_INDEX dtype)
{
	long offset;

	CHECK("Not called by non-GC thread", rt_is_call_allowed());

	CAttrOffs(offset,routine_id,dtype);
	return (offset);
}

/*
doc:	<routine name="wattr_inv" return_type="long" export="public">
doc:		<summary>Attribute offset of a qualified access to attribute of routine ID `routine_id' and name `name' applied to an object `object'. Note that invariants are not currently checked (code simply commented out for future reference).</summary>
doc:		<param name="routine_id" type="int">Routine ID of attribute being accessed.</param>
doc:		<param name="name" type="char *">Name of feature being called.</param>
doc:		<param name="object" type="EIF_REFERENCE">Object on which attribute will be accessed.</param>
doc:		<return>Offset</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Uses per thread data.</synchronization>
doc:	</routine>
*/
rt_public long wattr_inv (int routine_id, char *name, EIF_REFERENCE object)
{
	if (object == NULL) {			/* Void reference check */
			/* Raise an exception for a feature named `name' applied
			 * to a void reference. */
		eraise(name, EN_VOID);
		return 0;
	} else {
		/* Invariants are not currently checked on attribute access. */
 /* 
		if (~in_assertion & WASC(Dtype(object)) & CK_INVARIANT) {
			in_assertion = ~0;
			chkinv(object);
			in_assertion = 0;
		}
 */
		return wattr(routine_id, Dtype(object));
	}
}

/*
doc:	<routine name="wtype_gen" return_type="EIF_TYPE_INDEX" export="public">
doc:		<summary>Type of a generic feature of routine ID `routine_id' applied to an object of dynamic type `dtype' and full dynamic type `dftype'.</summary>
doc:		<param name="routine_id" type="int">Routine ID of generic feature for which we need to know the type in the context of `dftype'.</param>
doc:		<param name="dtype" type="EIF_TYPE_INDEX">Dynamic type ID of generic feature where type will be looked up.</param>
doc:		<param name="dftype" type="EIF_TYPE_INDEX">Full Dynamic type ID of generic feature where type will be looked up.</param>
doc:		<return>Function pointer</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Uses per thread data.</synchronization>
doc:	</routine>
*/
rt_public EIF_TYPE_INDEX wtype_gen(int routine_id, EIF_TYPE_INDEX dtype, EIF_TYPE_INDEX dftype)
{
	struct rout_info info;
	struct desc_info *desc;
	EIF_TYPE_INDEX *gen_type;

	CHECK("Not called by non-GC thread", rt_is_call_allowed());
	info = eorg_table[routine_id];
	desc = &(((desc_tab[info.origin])[dtype])[info.offset]);
	gen_type = desc->gen_type;

	if (gen_type) {
		return eif_compound_id (dftype, gen_type);
	} else {
		return desc->type;
	}
}

/*
doc:	<routine name="rt_wexp" export="shared">
doc:		<summary>Call the creation procedure of routine ID `routine_id' for expanded object `object' of dynamic type `dyn_type'.</summary>
doc:		<param name="routine_id" type="int">Routine ID of creation procedure.</param>
doc:		<param name="dyn_type" type="EIF_TYPE_INDEX">Dynamic type ID of `object'.</param>
doc:		<param name="object" type="EIF_REFERENCE">Object on which creation procedure will be called.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Uses per thread data.</synchronization>
doc:	</routine>
*/

rt_shared void rt_wexp(int routine_id, EIF_TYPE_INDEX dyn_type, EIF_REFERENCE object)
{
	EIF_GET_CONTEXT
	unsigned char *OLD_IC;

	REQUIRE("Not called by non-GC thread", rt_is_call_allowed());
	REQUIRE("Consistent object", Dtype(object) == dyn_type);

	nstcall = 0;					/* No invariant check */

	OLD_IC = IC;					/* Save old IC */
	((void (*)(EIF_REFERENCE)) (wfeat(routine_id, dyn_type))) (object);
	IC = OLD_IC;					/* Restore old IC.
									 * This was needed if expanded objects
									 * had expanded objects (which has a
									 * creation routine which in turn call
									 * the interpreter) so that 
									 * the IC was return to the previous 
									 * state.
									 */
}

rt_public EIF_REFERENCE_FUNCTION wdisp(EIF_TYPE_INDEX dyn_type)
{
	/* Function pointer associated to Eiffel feature of routine id
	 * `routine_id' accessed in Eiffel dynamic type `dyn_type'.
	 * Return a function pointer.
	 */
	EIF_GET_CONTEXT
	BODY_INDEX body_id;

	CHECK("GC running", rt_is_call_allowed());

	nstcall = 0;								/* No invariant check */
	CBodyId(body_id,egc_disp_rout_id,dyn_type);	/* Get the body index */

	if (egc_frozen [body_id])
		return egc_frozen[body_id];		 /* Frozen feature */
	else {
		IC = melt[body_id];	 /* Position byte code to interpret */
		return pattern[MPatId(body_id)].toi;
	}
}

rt_public EIF_REFERENCE_FUNCTION wcopy(EIF_TYPE_INDEX dyn_type)
{
	/* Function pointer associated to Eiffel feature of routine id
	 * `routine_id' accessed in Eiffel dynamic type `dyn_type'.
	 * Return a function pointer.
	 */
	EIF_GET_CONTEXT
	BODY_INDEX body_id;

	CHECK("Not called by non-GC thread", rt_is_call_allowed());

	nstcall = 0;								/* No invariant check */
	CBodyId(body_id,egc_copy_rout_id,dyn_type);	/* Get the body index */

	if (egc_frozen [body_id])
		return egc_frozen[body_id];		 /* Frozen feature */
	else {
		IC = melt[body_id];	 /* Position byte code to interpret */
		return pattern[MPatId(body_id)].toi;
	}
}

rt_public EIF_REFERENCE_FUNCTION wis_equal(EIF_TYPE_INDEX dyn_type)
{
	/* Function pointer associated to Eiffel feature of routine id
	 * `routine_id' accessed in Eiffel dynamic type `dyn_type'.
	 * Return a function pointer.
	 */
	EIF_GET_CONTEXT
	BODY_INDEX body_id;

	CHECK("Not called by non-GC thread", rt_is_call_allowed());

	nstcall = 0;								/* No invariant check */
	CBodyId(body_id,egc_is_equal_rout_id,dyn_type);	/* Get the body index */

	if (egc_frozen [body_id])
		return egc_frozen[body_id];		 /* Frozen feature */
	else {
		IC = melt[body_id];	 /* Position byte code to interpret */
		return pattern[MPatId(body_id)].toi;
	}
}

/*
doc:	<attribute name="desc_tab" return_type="struct desc_info ***" export="shared">
doc:		<summary>Global descriptor table. Initialization of the run-time feature call structures. The central call structure is called `desc_tab'. It contains one entry per class (NOT class type) and it is indexed by class id (not the toplogical id). The entry for a given class is a table of descriptor pointers, and is indexed by "dynamic" class type ids.</summary>
doc:		<access>Read/Write once</access>
doc:		<indexing>[class_id, dtype, offset]</indexing>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized once through `put_desc' called from InitXXX routines generated in *d.c files</synchronization>
doc:	</attribute>
*/
rt_shared struct desc_info ***desc_tab;


struct bounds { 			/* Structure used to record min/max dtypes */
	EIF_TYPE_INDEX min;
	EIF_TYPE_INDEX max;
};

/*
doc:	<attribute name="bounds_tab" return_type="struct bounds *" export="private">
doc:		<summary>Bounds of the various classes. Temporary structures used for the construction of the global descriptor table. The `bounds_tab' table contains the bounds (minimum and maximum dynamic class type ids) for each class in the system.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since only used during initialization.</synchronization>
doc:	</attribute>
*/
rt_private struct bounds *bounds_tab;

/*
doc:	<attribute name="desc_fill" return_type="char" export="public">
doc:		<summary>Flag for descriptor table initialization. Is it an actual insertion or do we wish to compute the size?</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since only done during application initialization.</synchronization>
doc:	</attribute>
*/
rt_public char desc_fill;				/* Flag for descriptor table initialization */

struct mdesc {				/* Structure used to record melted descriptor */
	struct desc_info *desc_ptr;
	EIF_TYPE_INDEX origin;
	EIF_TYPE_INDEX type;
};

/*
doc:	<attribute name="mdesc_tab" return_type="struct mdesc *" export="private">
doc:		<summary>Temporary table of melted descriptors. When byte code is read, all new descriptors are recorded, so that they can be properly inserted during insertion pass.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since only done during application initialization.</synchronization>
doc:	</attribute>
*/
rt_private struct mdesc *mdesc_tab;

/*
doc:	<attribute name="mdesc_count" return_type="int" export="private">
doc:		<summary>Number of melted descriptors in `mdesc_tab'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since only done during application initialization.</synchronization>
doc:	</attribute>
*/
rt_private int mdesc_count;

/*
doc:	<attribute name="mdesc_tab_size" return_type="int" export="private">
doc:		<summary>Size of `mdesc_tab'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since only done during application initialization.</synchronization>
doc:	</attribute>
*/
rt_private int mdesc_tab_size;

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

	def.max = 0;
	def.min = (EIF_TYPE_INDEX) ccount;
	bounds_tab = (struct bounds *) cmalloc (sizeof(struct bounds) * (ccount + 1));	
	if (bounds_tab == NULL)
		enomem(MTC_NOARG);
	mdesc_tab = (struct mdesc *) cmalloc (sizeof(struct mdesc) * MDESC_INC);
	if (mdesc_tab == NULL)
		enomem(MTC_NOARG);
	mdesc_tab_size = MDESC_INC;
	mdesc_count = 0;
	
	for (i=0;i<=ccount;i++)
		bounds_tab[i] = def;

	desc_fill = 0;
	egc_tabinit();
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
		b->min = (EIF_TYPE_INDEX) (dtype < b->min ? dtype : b->min);
		b->max = (EIF_TYPE_INDEX) (dtype > b->max ? dtype : b->max);
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
		b->min = (EIF_TYPE_INDEX) (dtype < b->min ? dtype : b->min);
		b->max = (EIF_TYPE_INDEX) (dtype > b->max ? dtype : b->max);
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
	md.origin = (EIF_TYPE_INDEX) org;
	md.type = (EIF_TYPE_INDEX) dtype;

	mdesc_tab[mdesc_count++] = md;
}

rt_public void create_desc(void)
{
	struct bounds *b;
	int i;
	struct desc_info **tab;
	struct mdesc *mdesc_ptr;
	int size;

		/* Allocation of the global descriptor table. */
	desc_tab = (struct desc_info ***) cmalloc (sizeof(struct desc_info **) * (ccount + 1));
	if (!desc_tab) {
		enomem(MTC_NOARG);
	}

	/* Allocation of the subtables
	 * and insertion
	 */

	for (i=0;i<=ccount;i++) {
		b = bounds_tab+i;
		size = b->max - b->min + 1;
		if (size > 0) {
			tab = (struct desc_info **) cmalloc (size * sizeof(struct desc_info *));
			if (!tab) {
				enomem(MTC_NOARG);
			}
				/* The hack of the century */
			desc_tab[i] = tab - b->min; 
		}
	}


	/* Free temporary structure */
	eif_rt_xfree((char *) bounds_tab);

	/* Actually fill the call structure */

	desc_fill = 1;
	egc_tabinit();

	/* Fill the call structures with the melted descriptors */

	for(i=0;i<mdesc_count;i++) {
		mdesc_ptr = &(mdesc_tab[i]);
		(desc_tab[mdesc_ptr->origin])[mdesc_ptr->type] 
				= mdesc_ptr->desc_ptr;
	}

	/* Free temporary structure */
	eif_rt_xfree((char *) mdesc_tab);
}


rt_public void eif_invoke_test_routine (EIF_REFERENCE obj, int body_id)
{

	EIF_GET_CONTEXT

	EIF_REFERENCE_FUNCTION rout;

	nstcall = 1;                                            /* Invariant check on */

	if (egc_frozen [body_id])
			rout = egc_frozen[body_id];                      /* Frozen feature */
	else {
			IC = melt[body_id];
			rout = pattern[MPatId(body_id)].toi;
	}
	
	(FUNCTION_CAST(void, (EIF_REFERENCE)) rout)(obj);
}


#endif

/*
doc:</file>
*/
