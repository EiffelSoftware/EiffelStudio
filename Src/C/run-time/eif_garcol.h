/*
	description: "Declarations for garbage collector routines."
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

#ifndef _eif_garcol_h_
#define _eif_garcol_h_

#include "eif_portable.h"
#include "eif_macros.h"
#include "eif_struct.h"
#ifndef TEST
#include "eif_plug.h"		/* Not wanted when runnning tests */
#endif

#include "eif_malloc.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS
#ifdef ISE_GC
RT_LNK struct stack loc_stack;	/* Local indirection stack */
RT_LNK struct stack loc_set;	/* Local variable stack */
#endif
RT_LNK struct stack once_set;	/* Once functions */
RT_LNK struct stack oms_set;	/* Once manifest strings */
#endif

/*
 * Eiffel flags -- edit with care.
 */
#define EO_MARK		0x8000		/* Garbage collector's mark */
#define EO_TUPLE	0x4000		/* Assertion loop control flag: in creation routine */
#define EO_DISP		0x2000		/* Does object's associated class define `dispose' */
#define EO_AGE		0x1e00		/* Object's age before immortality */
#define EO_SPEC		0x0100		/* Object is special (C area) */
#define EO_REF		0x0080		/* Special object is full of references */
#define EO_STORE	0x0040		/* Mark for objects to be stored */
#define EO_OLD		0x0020		/* Object belongs to the old generation */
#define EO_REM		0x0010		/* Object belongs to the remembered set */
#define EO_NEW		0x0008		/* Object is new, outside scavenge zone */
#define EO_C		0x0004		/* Object is a C one (malloc'ed) */
#define EO_EXP		0x0002		/* Object is an expanded one */
#define EO_COMP		0x0001		/* Composite (has expanded or special) */
#define EO_MOVED	(EO_NEW | EO_MARK)

/*
 * Object type.
 */
#define eif_is_nested_expanded(flags) (((flags) & (EO_EXP | EO_REF)) == (EO_EXP))
#define eif_is_boxed_expanded(flags)  (((flags) & (EO_EXP | EO_REF)) == (EO_EXP | EO_REF))
#define eif_is_expanded(flags)        (((flags) & (EO_EXP)) == (EO_EXP))

/* Exported data-structure declarations */
RT_LNK EIF_REFERENCE root_obj;	/* Address of `root' object */	

#ifdef WORKBENCH
RT_LNK EIF_REFERENCE rt_extension_obj;	/* Address of `rt_extension' object */	
#endif

RT_LNK EIF_REFERENCE except_mnger;	/* Address of EXCEPTION_MANAGER object */	

/* General-purpose exported functions */
RT_LNK void plsc(void);					/* Partial scavenging */
RT_LNK void reclaim(void);				/* Reclaim all the objects */
RT_LNK int collect(void);				/* Generation-based collector */
#ifdef ISE_GC
RT_LNK void check_gc_tracking(EIF_REFERENCE, EIF_REFERENCE);
RT_LNK void eremb(EIF_REFERENCE obj);				/* Remembers old object */
RT_LNK void erembq(EIF_REFERENCE obj);				/* Quick veersion (no GC call) of eremb */
#endif
RT_LNK EIF_REFERENCE *onceset(void);				/* Recording of once function result */
RT_LNK void new_onceset(EIF_REFERENCE);				/* Recording of once function result */
#if defined(WORKBENCH) || defined(EIF_THREADS)
RT_LNK ONCE_INDEX once_index (BODY_INDEX code_id);		/* Calculate index of once routine */
#endif
#ifdef EIF_THREADS
RT_LNK ONCE_INDEX process_once_index (BODY_INDEX code_id);	/* Calculate index of process-relative once routine */
RT_LNK void globalonceset(EIF_REFERENCE);			/* Recording of once function result */
#endif
RT_LNK void register_oms (EIF_REFERENCE *address);	/* Register an address of a once manifest string */
RT_LNK void eif_gc_stop(void);				/* Stop the garbage collector */
RT_LNK void eif_gc_run(void);				/* Restart the garbage collector */

#ifdef __cplusplus
}
#endif

#endif
