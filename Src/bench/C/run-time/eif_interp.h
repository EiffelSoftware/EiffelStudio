/*
	description: "Interpreter declarations and definitions."
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

#ifndef _eif_interp_h_
#define _eif_interp_h_

#include "eif_globals.h"
#include <stdio.h>		/* %%zs added: for FILE definition line 91 */
#include "eif_portable.h"
#include "eif_struct.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS
#ifdef WORKBENCH
RT_LNK struct opstack cop_stack;	/* Operational stack */
RT_LNK unsigned char *IC;			/* Interpreter Counter (like PC on a CPU) */
#endif
#endif

/* Macros for easy reference */
#define it_char		itu.itu_char
#define it_int8		itu.itu_int8
#define it_int16	itu.itu_int16
#define it_wchar	itu.itu_wchar
#define it_int32	itu.itu_int32
#define it_int64	itu.itu_int64
#define it_real32	itu.itu_real32
#define it_real64	itu.itu_real64
#define	it_uint8	itu.itu_uint8
#define	it_uint16	itu.itu_uint16
#define	it_uint32	itu.itu_uint32
#define	it_uint64	itu.itu_uint64
#define it_ref		itu.itu_ref
#define it_ptr		itu.itu_ptr
#define it_bit		itu.itu_bit

/* Interpreter interface to outside world */
RT_LNK void xinterp(unsigned char *icval);					/* Compound from a given address */
RT_LNK struct item *opush(register struct item *val);			/* Push value on operational stack */
RT_LNK struct item *opop(void);									/* Remove value from operational stack */

/* Macro used to prepare a cell on top of the stack */
#define iget()	opush((struct item *) 0)	/* Push empty cell on stack */

#ifdef __cplusplus
}
#endif

#endif
