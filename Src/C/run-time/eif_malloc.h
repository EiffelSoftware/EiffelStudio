/*
	description: "Declarations for malloc routines."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2009, Eiffel Software."
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

#ifndef _eif_malloc_h_
#define _eif_malloc_h_

#include "eif_portable.h"
#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Useful shortcuts for accessing fields.
 */
#define ov_next		ov_head.ovu.ovu_next
#define ov_flags	ov_head.ovu.ovs.flags
#define ov_dtype	ov_head.ovu.ovs.dtype
#define ov_dftype	ov_head.ovu.ovs.dftype
/* #define ov_dftype	(ov_head.ovu.ovs.dftype_inc + fcount) */
#define ov_fwd		ov_head.ovu.ovu_fwd
#define ov_size		ov_head.ovs_size
#ifdef EIF_TID
#define ovs_tid     ov_head.ovs_tid
#endif
#define ovs_pid     ovu.ovs.scp_pid

/*
 * Masks used on the ovs_size field.
 */
#ifdef EIF_64_BITS
#define B_SIZE		RTU64C(0x07ffffffffffffff)			/* Get the size of the block */
#define B_BUSY		RTU64C(0x8000000000000000)			/* Block is not free */
#define B_C			RTU64C(0x4000000000000000)			/* Block is a C block */
#define B_LAST		RTU64C(0x2000000000000000)			/* Block is the last one in chunk */
#define B_FWD		RTU64C(0x1000000000000000)			/* Forwarded Eiffel object */
#define B_CTYPE		RTU64C(0x0800000000000000)			/* Block belongs to a C type chunk */
#else
#define B_SIZE		0x07ffffff			/* Get the size of the block */
#define B_BUSY		0x80000000			/* Block is not free */
#define B_C			0x40000000			/* Block is a C block */
#define B_LAST		0x20000000			/* Block is the last one in chunk */
#define B_FWD		0x10000000			/* Forwarded Eiffel object */
#define B_CTYPE		0x08000000			/* Block belongs to a C type chunk */
#endif
#define B_NEW		(B_BUSY | B_C)		/* For newly created blocks */

/*
 * Object access low-level routines.
 */
#define OVERHEAD	sizeof(union overhead)			/* Malloc overhead */
#define HEADER(p)	(((union overhead *) (p))-1)	/* Fetch header address */


/*
 * Functions return type.
 */
RT_LNK EIF_REFERENCE emalloc(EIF_TYPE_INDEX type);				/* Allocate an Eiffel object */
RT_LNK EIF_REFERENCE emalloc_as_old(EIF_TYPE_INDEX type);			/* Allocate an Eiffel object as an old object */
RT_LNK EIF_REFERENCE emalloc_size(EIF_TYPE_INDEX ftype, EIF_TYPE_INDEX dtype, uint32 size);	/* Allocate an Eiffel object */
RT_LNK EIF_REFERENCE bmalloc(uint16 size);			/* Bit object creation */
RT_LNK EIF_REFERENCE special_malloc (uint16 flags, EIF_TYPE_INDEX dftype, EIF_INTEGER nb, uint32 element_size, EIF_BOOLEAN atomic);
RT_LNK EIF_REFERENCE eif_type_malloc (EIF_TYPE_INDEX ftype);
RT_LNK EIF_REFERENCE tuple_malloc (EIF_TYPE_INDEX ftype);	/* Allocated tuple object */
RT_LNK EIF_REFERENCE tuple_malloc_specific (EIF_TYPE_INDEX ftype, uint32 count, EIF_BOOLEAN atomic);	/* Allocated tuple object */
RT_LNK EIF_REFERENCE smart_emalloc (EIF_TYPE_INDEX ftype);
RT_LNK EIF_REFERENCE sp_init (EIF_REFERENCE obj, EIF_TYPE_INDEX dftype, EIF_INTEGER lower, EIF_INTEGER upper);	/* Initialize special object of expanded */

RT_LNK EIF_REFERENCE strmalloc(unsigned int nbytes);		/* Allocate a string. */
						/* Set the string header. */
RT_LNK void *cmalloc(size_t nbytes);				/* Allocate a C object */
RT_LNK EIF_REFERENCE sprealloc(EIF_REFERENCE ptr, unsigned int nbitems);			/* Reallocate an Eiffel special object */

RT_LNK EIF_REFERENCE eif_box(EIF_TYPED_VALUE v);                  /* Create a boxed version of a basic value */

RT_LNK EIF_REFERENCE *rt_type_set;
RT_LNK rt_uint_ptr volatile rt_type_set_count;

#ifdef __cplusplus
}
#endif

#endif
