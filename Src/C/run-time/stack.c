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

#include "eif_portable.h"
#include "eif_eiffel.h"
#include "rt_globals.h"
#include "rt_globals_access.h"
#include "rt_assert.h"
#include "rt_sig.h"
#include "rt_garcol.h"
#include "rt_malloc.h"
#include "eif_stack.h"

/* Undefine any possible definition of EIF_STACK_TYPE_NAME and EIF_STACK_TYPE to avoid C compiler issue. */
#ifdef EIF_STACK_TYPE_NAME
#undef EIF_STACK_TYPE_NAME
#endif
#ifdef EIF_STACK_TYPE
#undef EIF_STACK_TYPE
#endif
#ifdef EIF_STACK_IS_STRUCT_ELEMENT
#undef EIF_STACK_IS_STRUCT_ELEMENT
#endif

/* Let's define our simple stack of Eiffel objects: rem_set, ... */
#define EIF_STACK_TYPE_NAME o
#define EIF_STACK_TYPE	EIF_REFERENCE
#include "rt_stack.implementation"
#undef EIF_STACK_TYPE_NAME
#undef EIF_STACK_TYPE

/* Let's define our simple stack of address to Eiffel objects: loc_set, ... */
#define EIF_STACK_TYPE_NAME oa
#define EIF_STACK_TYPE	EIF_REFERENCE *
#include "rt_stack.implementation"
#undef EIF_STACK_TYPE_NAME
#undef EIF_STACK_TYPE

#ifdef WORKBENCH
/* Stack used by the interpreter (C code operational stack) */
#define EIF_STACK_TYPE_NAME c_op
#define EIF_STACK_TYPE	EIF_TYPED_ADDRESS 
#define EIF_STACK_IS_STRUCT_ELEMENT
#include "rt_stack.implementation"
#undef EIF_STACK_TYPE_NAME
#undef EIF_STACK_TYPE
#undef EIF_STACK_IS_STRUCT_ELEMENT

/* Stack used by the interpreter (byte code operational stack) */
#define EIF_STACK_TYPE_NAME op
#define EIF_STACK_TYPE	EIF_TYPED_VALUE 
#define EIF_STACK_IS_STRUCT_ELEMENT
#include "rt_stack.implementation"
#undef EIF_STACK_TYPE_NAME
#undef EIF_STACK_TYPE
#undef EIF_STACK_IS_STRUCT_ELEMENT

/* Stack used by the debugger (context stack) */
#define EIF_STACK_TYPE_NAME db
#define EIF_STACK_TYPE	struct dcall 
#define EIF_STACK_IS_STRUCT_ELEMENT
#include "rt_stack.implementation"
#undef EIF_STACK_TYPE_NAME
#undef EIF_STACK_TYPE
#undef EIF_STACK_IS_STRUCT_ELEMENT
#endif

/*
doc:</file>
*/
