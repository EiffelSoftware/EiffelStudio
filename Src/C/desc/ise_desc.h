/*
	description: "Facilities for DESC which is now obsolete."
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

#ifndef _DESC_DLL_H_
#define _DESC_DLL_H_

#ifndef _INC_WINDOWS
#	define STRICT
#	include <windows.h>
#endif

#include <eif_portable.h>

/* From class SHARED_LIBRARY_CONSTANTS */

#define T_array 			 0
#define T_boolean			 1
#define T_character			 2
#define T_real64			 3
#define T_integer			 4
#define T_no_type			10
#define T_pointer			 5
#define T_real32			 6
#define T_reference			 7
#define T_short_integer 	 8
#define T_string			 9


__declspec(dllexport) BOOL  desc_call_dll32_boolean (FARPROC ProcAddress, EIF_INTEGER ArgCount,EIF_INTEGER ArgValues []);
__declspec(dllexport) EIF_CHARACTER  desc_call_dll32_character (FARPROC ProcAddress, EIF_INTEGER ArgCount, EIF_INTEGER ArgValues []);
__declspec(dllexport) EIF_REAL_64  desc_call_dll32_double (FARPROC ProcAddress, EIF_INTEGER ArgCount, EIF_INTEGER ArgValues []);
__declspec(dllexport) EIF_INTEGER  desc_call_dll32_integer (FARPROC ProcAddress, EIF_INTEGER ArgCount, EIF_INTEGER ArgValues []);
__declspec(dllexport) LPVOID  desc_call_dll32_pointer (FARPROC ProcAddress, EIF_INTEGER ArgCount, EIF_INTEGER ArgValues []);
__declspec(dllexport) EIF_REAL_32  desc_call_dll32_real (FARPROC ProcAddress, EIF_INTEGER ArgCount, EIF_INTEGER ArgValues []);
__declspec(dllexport) LPVOID  desc_call_dll32_reference (FARPROC ProcAddress, EIF_INTEGER ArgCount, EIF_INTEGER ArgValues []);
__declspec(dllexport) void  desc_call_dll32_procedure (FARPROC ProcAddress, EIF_INTEGER ArgCount, EIF_INTEGER ArgValues []);
__declspec(dllexport) int  desc_call_dll32_short_integer (FARPROC ProcAddress, EIF_INTEGER ArgCount, EIF_INTEGER ArgValues []);
__declspec(dllexport) LPSTR  desc_call_dll32_string (FARPROC ProcAddress, EIF_INTEGER ArgCount, EIF_INTEGER ArgValues []);
__declspec(dllexport) FARPROC  desc_get_function_index_pointer (HINSTANCE module_ptr, EIF_INTEGER func_index);
__declspec(dllexport) FARPROC  desc_get_function_pointer (HINSTANCE module_ptr, LPCSTR func_name);
__declspec(dllexport) int  desc_get_size (int type);

#endif /* _DESC_H_ */
