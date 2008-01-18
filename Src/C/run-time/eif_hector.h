/*
	description: "Declarations for Hector."
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

#ifndef _eif_hector_h_
#define _eif_hector_h_

#include "eif_cecil.h"
#include "eif_garcol.h"		/* For struct stack */
#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS
#ifdef ISE_GC
RT_LNK struct stack hec_stack;	/* Indirection table "hector" */
#endif
#endif

/* Macros to remap cryptic names to meaningful ones. Note that the
 * interface defined in ETL uses the remaped names. Only this interface
 * is guaranteed.
 */
#if defined(ISE_GC) && !defined(EIF_IL_DLL)
#define eif_access(_x)	(*(EIF_REFERENCE *) (_x))	/* Access object through hector */
#define eif_frozen(object)	(HEADER(object)->ov_size & B_C)			/* Is object frozen? */
#else
#define eif_access(obj)		(obj)
#define eif_frozen(obj)		1		/* Always frozen since they do not move */
#endif

/* Declaration of hector routines */
#ifdef DEBUG2
extern int stck_nb_items (const struct stack stk);
extern int stck_nb_items_free_stack ();
#endif

#if defined(ISE_GC) && !defined(EIF_IL_DLL)
RT_LNK EIF_REFERENCE eif_freeze(EIF_OBJECT object);	/* Freeze object's address (no more move) */
RT_LNK EIF_OBJECT eif_adopt(EIF_OBJECT object);		/* The C wants to keep the reference */
RT_LNK EIF_REFERENCE eif_wean(EIF_OBJECT object);		/* Weans a previously adopted reference */
extern void eif_unfreeze(EIF_REFERENCE object);			/* Forget a frozen memory address */
RT_LNK EIF_OBJECT eif_protect (EIF_REFERENCE object);		/* Low-level entry in hector table */
RT_LNK EIF_OBJECT hrecord(EIF_REFERENCE object);	/* Record entry in hector table, only for code generation */
#else
#define eif_freeze(object)	(object)
#define eif_adopt(object)	(object)
#define eif_wean(object)	(object)
#define eif_unfreeze(object)
#define eif_protect(object)	(object)
#define hrecord(object)	(object)
#endif

#ifdef __cplusplus
}
#endif

#endif

