/*
	description: "Declarations for plugging routines and structures."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
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

#ifndef _eif_plug_h_
#define _eif_plug_h_

#include "eif_portable.h"
#include "eif_types.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS
RT_LNK int nstcall;	/* Nested call global variable: signals a nested call and
					 * trigger an invariant check in generated C routines  */
RT_LNK int eif_optimize_return;	/* Signals a polymorphic call to not create an Eiffel object. */
RT_LNK EIF_TYPED_VALUE eif_optimized_return_value;		/* Location where optimized call store result. */
#endif

/* Structure used to represent bits in the object. The first long integer
 * is the length of the bit field. It is then followed by enough long integers
 * to store the value of the bits.
 * The declaration of the structure is tricky: the value field is declared as
 * a pointer on an array of one time, but as C does no range checking, this
 * perfectly suits our needs--RAM.
 */

struct bit {
	uint16 b_length;				/* Length of the bit field */
	uint32 b_value[1];				/* Array long integers holding value */
};

#define	eif_make_string	makestr	/* Returns an Eiffel string */

/*
 * Run time functions used by generated C code.
 */

RT_LNK EIF_REFERENCE makestr_with_hash(register char *s, register size_t len, register int a_hash);
RT_LNK EIF_REFERENCE makestr_with_hash_as_old(register char *s, register size_t len, register int a_hash);
RT_LNK EIF_REFERENCE makestr(register char *s, register size_t len);
RT_LNK EIF_REFERENCE makebit(char *bit, uint16 bit_count);		/* Build an Eiffel bit object */
extern EIF_REFERENCE striparr(EIF_REFERENCE curr, int dtype, EIF_REFERENCE *items, long int nbr);			/* Build an Eiffel ARRAY[ANY] object for strip*/

RT_LNK EIF_REFERENCE argarr(int argc, char **argv);		/* ARRAY[STRING] creation from command line arguments */

extern long *eif_lower_table;		/* ARRAY `lower' (array optimization) */
extern long *eif_area_table;		/* ARRAY `area' (array optimization) */

RT_LNK EIF_REFERENCE cr_exp(EIF_TYPE_INDEX type);	/* Creation of expanded objects */
RT_LNK void init_exp(EIF_REFERENCE obj);		/* Initialization of expanded objects */

#ifdef WORKBENCH
extern void wstdinit(EIF_REFERENCE obj, EIF_REFERENCE parent);				/* Composite objects initialization */
#endif

/* Array of class node (indexed by dynamic type). It is statically allocated
 * in production mode and dynamically in workbench mode.
 */
RT_LNK struct cnode *esystem;	/* Describes a full Eiffel system */
#define System(type)		esystem[type]	/* Object description */

#ifndef WORKBENCH
extern long *esize;		/* Size of object given DType */
#define EIF_Size(type)		esize[type] 	/* Object's size */
#else
#define EIF_Size(type)		esystem[type].cn_size
#endif


/*
 * Miscellaneous routines.
 */
  
/* Conformance query in class GENERAL */
#define econfg(obj1, obj2) \
	(((EIF_REFERENCE) obj1 == (EIF_REFERENCE) 0) || ((EIF_REFERENCE) obj2 == (EIF_REFERENCE) 0 )) ? EIF_FALSE: \
		eif_gen_conf(Dftype(obj2), Dftype(obj1))
  
/* Are dynamic types of `obj1' and `obj2' identical? */
#define estypeg(obj1, obj2) \
	(((EIF_REFERENCE) obj1 == (EIF_REFERENCE) 0) || ((EIF_REFERENCE) obj2 == (EIF_REFERENCE) 0))? EIF_FALSE: \
		(Dftype(obj1) == Dftype(obj2))

RT_LNK EIF_INTEGER sp_count(EIF_REFERENCE spobject);		/* Count of a special object */
RT_LNK EIF_INTEGER sp_elem_size(EIF_REFERENCE spobject);	/* Size of element a special object */
RT_LNK void chkinv(EIF_REFERENCE obj, int where);	/* Invariant control call */
RT_LNK void chkcinv(EIF_REFERENCE obj);			/* Creation invariant call */	

#ifndef WORKBENCH
RT_LNK void rt_norout(EIF_REFERENCE);		/* No function pointer */
#endif

#ifdef __cplusplus
}
#endif

#endif

