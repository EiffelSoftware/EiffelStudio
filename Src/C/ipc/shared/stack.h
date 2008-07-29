/*
	description: "Definition and declaration for stack dumping package."
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

#ifndef _stack_h_
#define _stack_h_

#include "eif_portable.h"
#include "eif_except.h"
#include "rt_interp.h"

/* Unified (Windows/Unix) Stream declaration */
#include "stream.h"

/* Once objects are sent as a structure instead of a tagged out string as
 * with other objects. Not only does it spares CPU cycles and headaches for
 * the programmer (me!), but it makes things smoother to handle--RAM.
 */
struct once {					/* A once object */
	char *obj_addr;				/* Object's address */
	int obj_type;				/* Dynamic type of object */
};

/* Structure returned by dumps */
struct dump {
	int dmp_type;					/* Union discriminent */
	union {
		EIF_TYPED_VALUE *dmpu_item;	/* Operational stack cell */
		struct ex_vect *dmpu_vect;	/* Exception vector */
		struct once dmpu_obj;		/* Once address */
	} dmpu;
};

/* Shortcut addressing macros */
#define dmp_item	dmpu.dmpu_item
#define dmp_vect	dmpu.dmpu_vect
#define dmp_obj		dmpu.dmpu_obj

/* Union discriminent type */
#define DMP_ITEM	0			/* Opertional stack cell */
#define DMP_VECT	1			/* Exception vector */
#define DMP_OBJ		2			/* Object address */
#define DMP_MELTED	3			/* Exception vector (same as DMP_VECT) - The routine is melted */
#define DMP_VOID	4			/* No more arguments or locals to be sent. */
#define DMP_EXCEPTION_ITEM	5	/* Returning Object as Exception */

/* Visible routine */
extern void send_stack(EIF_PSTREAM s, uint32 nb_elems);	/* Send a stack dump to ewb */
extern void send_stack_variables(EIF_PSTREAM s, int where); /* dump the locals/arguments for a given feature on stack */
extern void send_once_result(EIF_PSTREAM s, MTOT OResult, int otype); /* Send result of once function to ewb */
extern EIF_DEBUG_VALUE stack_debug_value(uint32 stack_level, uint32 loc_type, uint32 loc_number);

#endif /* _stack_h_ */
