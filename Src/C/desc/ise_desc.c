/*
	description: "File for ise_desc.dll. DESC is the Dynamic Shared External Call."
	date:		"$Date$"
	revision:	"$Revision$"
	obsolete:	"Use traditional external mechanism instead."
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

#include "ise_desc.h"

/*
 * PUSH_ALL macro:
 * Push on the stack each values of `ArgValues' with the
 * C calling convention.
 * `ArgCount' is the number of parameters.
 * `ArgTypes' contains the parameter types.
 * This macro cannot be a function to keep the stack *virtually empty*
 * for the compiler.
 */

#define PUSH_ALL \
	int i; \
	EIF_INTEGER j; \
	for (i = ArgCount-1; i >= 0; i--) \
			{ \
			j = ArgValues [i];      \
			__asm   push j  \
			}

#define POP_ALL \
	__asm add esp, ArgCount \
	__asm add esp, ArgCount \
	__asm add esp, ArgCount \
	__asm add esp, ArgCount         

__declspec(dllexport) BOOL desc_call_dll32_boolean
(
	FARPROC ProcAddress,
	EIF_INTEGER ArgCount,
	EIF_INTEGER ArgValues []
)
{
	/*
	 * `ProcAddress' is the address of the function to call
	 *       (see function `desc_get_function_pointer'
	 *        and `desc_get_function_index_pointer' ).
	 * `ArgCount' is the number of parameters.
	 * `ArgTypes' contains the parameter types.
	 * `ArgVales' contains the parameter values.
	 */

	typedef BOOL  (* FN) (void);
	BOOL x;

	/* Push all the arguments */
	PUSH_ALL

	/* Call the function */
	x = ((FN) ProcAddress)();

	POP_ALL 
 
	return x;
}

__declspec(dllexport) EIF_CHARACTER  desc_call_dll32_character
(
	FARPROC ProcAddress,
	EIF_INTEGER ArgCount,
	EIF_INTEGER ArgValues []
)
{
	/* See `desc_call_dll32_boolean' routine comment. */
	typedef EIF_CHARACTER  (* FN) (void);
	EIF_CHARACTER x;

	/* Push all the arguments */
	PUSH_ALL

	/* Call the function */
	x = ((FN) ProcAddress)();

	POP_ALL 
 
	return x;
}

__declspec(dllexport) EIF_REAL_64  desc_call_dll32_double
(
	FARPROC ProcAddress,
	EIF_INTEGER ArgCount,
	EIF_INTEGER ArgValues []
)
{
	/* See `desc_call_dll32_boolean' routine comment. */

	typedef EIF_REAL_64  (* FN) (void);
	EIF_REAL_64 x;

	PUSH_ALL

	/* Call the function */
	x = ((FN) ProcAddress)();

	POP_ALL 
 
	return x;
}

__declspec(dllexport) EIF_INTEGER  desc_call_dll32_integer
(
	FARPROC ProcAddress,
	EIF_INTEGER ArgCount,
	EIF_INTEGER ArgValues []
)
{
	/* See `desc_call_dll32_boolean' routine comment. */

	typedef EIF_INTEGER  (* FN) (void);
	EIF_INTEGER x;

	PUSH_ALL

	/* Call the function */
	x = ((FN) ProcAddress)();

	POP_ALL 
 
	return x;

}

__declspec(dllexport) LPVOID  desc_call_dll32_pointer
(
	FARPROC ProcAddress,
	EIF_INTEGER ArgCount,
	EIF_INTEGER ArgValues []
)
{

	typedef LPVOID  (* FN) (void);
	LPVOID x;

	PUSH_ALL
	/* Call the function */
	x = ((FN) ProcAddress)();

	POP_ALL 
 
	return x;
}

__declspec(dllexport) EIF_REAL_32  desc_call_dll32_real
(
	FARPROC ProcAddress,
	EIF_INTEGER ArgCount,
	EIF_INTEGER ArgValues []
)
{

	typedef EIF_REAL_32  (* FN) (void);
	EIF_REAL_32 x;

	PUSH_ALL

	/* Call the function */
	x = ((FN) ProcAddress)();

	POP_ALL 
 
	return x;

}

__declspec(dllexport) LPVOID  desc_call_dll32_reference
(
	FARPROC ProcAddress,
	EIF_INTEGER ArgCount,
	EIF_INTEGER ArgValues []
)
{
	/* See `desc_call_dll32_boolean' routine comment. */

	typedef LPVOID  (* FN) (void);
	LPVOID x;

	PUSH_ALL

	/* Call the function */
	x = ((FN) ProcAddress)();

	POP_ALL 
 
	return x;

}

__declspec(dllexport) void  desc_call_dll32_procedure
(
	FARPROC ProcAddress,
	EIF_INTEGER ArgCount,
	EIF_INTEGER ArgValues []
)
{
	/* See `desc_call_dll32_boolean' routine comment. */

	typedef void  (* FN) (void);

	PUSH_ALL

	/* Call the function */
	((FN) ProcAddress)();

	POP_ALL 
 
	return;

}

__declspec(dllexport) int  desc_call_dll32_short_integer
(
	FARPROC ProcAddress,
	EIF_INTEGER ArgCount,
	EIF_INTEGER ArgValues []
)
{
	/* See `desc_call_dll32_boolean' routine comment. */

	typedef int  (* FN) (void);
	int x;

	PUSH_ALL

		/* Call the function */
	x = ((FN) ProcAddress)();

	POP_ALL 
 
	return x;

}

__declspec(dllexport) LPSTR  desc_call_dll32_string
(
	FARPROC ProcAddress,
	EIF_INTEGER ArgCount,
	EIF_INTEGER ArgValues []
)
{
	/* See `desc_call_dll32_boolean' routine comment. */

	typedef LPSTR (* FN) (void);
	LPSTR x;

	PUSH_ALL

	/* Call the function */
	x = ((FN) ProcAddress)();

	POP_ALL 
 
	return x;
}

__declspec(dllexport) FARPROC  desc_get_function_index_pointer (HINSTANCE module_ptr, EIF_INTEGER func_index)
{
	/* Retrieve an address by the index `func_index'. */

	return GetProcAddress (module_ptr, MAKEINTRESOURCE(func_index));
}

__declspec(dllexport) FARPROC  desc_get_function_pointer (HINSTANCE module_ptr, LPCSTR func_name)
{
	/* Retrieve an address by the name `func_name'. */

	return GetProcAddress (module_ptr, func_name);
}

__declspec(dllexport) int desc_get_size (int type)
{
	/* Size in bytes of `type'. Used to write/read the parameters. */

	switch (type)
	{
		case T_array: return sizeof (LPVOID);
		case T_boolean: return sizeof (EIF_CHARACTER)*4;
		case T_character: return sizeof (EIF_CHARACTER)*4;
		case T_real64: return sizeof (EIF_REAL_64);
		case T_integer: return sizeof (EIF_INTEGER);
		case T_no_type: return 0;
		case T_pointer: return sizeof (LPVOID);
		case T_real32: return sizeof (EIF_REAL_32);
		case T_reference: return sizeof (LPVOID);
		case T_short_integer: return sizeof (EIF_INTEGER);
		case T_string: return sizeof (LPSTR);
	}
	return 0;
}
