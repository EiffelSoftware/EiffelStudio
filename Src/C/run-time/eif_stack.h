/*
	description: "Stack representation and various ways to iterate them."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2013, Eiffel Software."
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
doc:<file name="stack.c" header="eif_traverse.h" version="$Id$" summary="Stack representation and manipulations">
*/

#ifndef _eif_stack_h_
#define _eif_stack_h_

#include "eif_portable.h"
#include "eif_eiffel.h"

/* Undefine any possible definition of EIF_STACK_TYPE_NAME and EIF_STACK_TYPE to avoid C compiler issue. */
#ifdef EIF_STACK_TYPE_NAME
#undef EIF_STACK_TYPE_NAME
#endif
#ifdef EIF_STACK_TYPE
#undef EIF_STACK_TYPE
#endif
#ifdef EIF_STACK_ELEM_COMPARISON
#undef EIF_STACK_ELEM_COMPARISON
#endif

/* Let's define our simple stack of Eiffel objects: rem_set, ... */
#define EIF_STACK_TYPE_NAME o
#define EIF_STACK_TYPE	EIF_REFERENCE
#include "eif_stack.interface"
#undef EIF_STACK_TYPE_NAME
#undef EIF_STACK_TYPE

/* Let's define our simple stack of address to Eiffel objects: loc_set, ... */
#define EIF_STACK_TYPE_NAME oa
#define EIF_STACK_TYPE	EIF_REFERENCE *
#include "eif_stack.interface"
#undef EIF_STACK_TYPE_NAME
#undef EIF_STACK_TYPE

#ifdef WORKBENCH
/* Stack used by the interpreter (C code operational stack) */
#define EIF_STACK_TYPE_NAME c_op
#define EIF_STACK_TYPE	EIF_TYPED_ADDRESS 
#define EIF_STACK_ELEM_COMPARISON(x,y)	memcmp(x, y, sizeof(EIF_STACK_TYPE)) == 0
#include "eif_stack.interface"
#undef EIF_STACK_TYPE_NAME
#undef EIF_STACK_TYPE
#undef EIF_STACK_ELEM_COMPARISON

/* Stack used by the interpreter (byte code operational stack) */
#define EIF_STACK_TYPE_NAME op
#define EIF_STACK_TYPE	EIF_TYPED_VALUE 
#define EIF_STACK_ELEM_COMPARISON(x,y)	memcmp(x, y, sizeof(EIF_STACK_TYPE)) == 0
#include "eif_stack.interface"
#undef EIF_STACK_TYPE_NAME
#undef EIF_STACK_TYPE
#undef EIF_STACK_ELEM_COMPARISON

/* Stack used by the debugger (context stack) */
#define EIF_STACK_TYPE_NAME db
#define EIF_STACK_TYPE	struct dcall 
#define EIF_STACK_ELEM_COMPARISON(x,y)	memcmp(x, y, sizeof(EIF_STACK_TYPE)) == 0
#include "eif_stack.interface"
#undef EIF_STACK_TYPE_NAME
#undef EIF_STACK_TYPE
#undef EIF_STACK_ELEM_COMPARISON
#endif

/* Macros for efficient stack access. */

/*
doc:	<macro name="EIF_STACK_TOP_ADDRESS" return_type="EIF_STACK_TYPE" export="public">
doc:		<summary>Address of the last added element of the stack `stk'.</summary>
doc:		<param name="stk" type="struct stack">Stack where to look for a free entry</param>
doc:	</macro>
*/
#define EIF_STACK_TOP_ADDRESS(stk)	((stk).st_cur->sk_top - 1)

/*
doc:	<macro name="EIF_STACK_TOP" return_type="EIF_STACK_TYPE" export="public">
doc:		<summary>The last added element of the stack `stk'.</summary>
doc:		<param name="stk" type="struct stack">Stack where to look for a free entry</param>
doc:	</macro>
*/
#define EIF_STACK_TOP(stk)	*EIF_STACK_TOP(stk)

#endif

/*
doc:</file>
*/
