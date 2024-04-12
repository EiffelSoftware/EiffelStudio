note
	description: "[
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_BREAKPOINT

inherit
	ICOR_OBJECT

create 
	make_by_pointer

feature {ICOR_EXPORTER} -- QueryInterface

	query_interface_icor_debug_function_breakpoint: ICOR_DEBUG_FUNCTION_BREAKPOINT
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugFunctionBreakpoint (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end
		
	query_interface_icor_debug_value_breakpoint: ICOR_DEBUG_VALUE_BREAKPOINT
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugValueBreakpoint (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end		
		
	query_interface_icor_debug_module_breakpoint: ICOR_DEBUG_MODULE_BREAKPOINT
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugModuleBreakpoint (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end			
		
feature {ICOR_EXPORTER} -- Access

	activate (a_active: BOOLEAN)
			-- Activate the breakpoint
		do
			last_call_success := cpp_activate (item, a_active.to_integer)
		ensure
			success: last_call_success = 0
		end

	is_active: BOOLEAN
			-- Is active ?
		local
			r: INTEGER
		do
			last_call_success := cpp_is_active (item, $r)
			Result := r /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- QueryInterface Implementation

	cpp_query_interface_ICorDebugFunctionBreakpoint (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugBreakpoint *) $obj)->QueryInterface (IID_ICorDebugFunctionBreakpoint, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugValueBreakpoint (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugBreakpoint *) $obj)->QueryInterface (IID_ICorDebugValueBreakpoint, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugModuleBreakpoint (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugBreakpoint *) $obj)->QueryInterface (IID_ICorDebugModuleBreakpoint, (void **) $a_p)"
		end
		
feature {NONE} -- Implementation

	cpp_activate (obj: POINTER; a_bool: INTEGER): INTEGER
		external
			"[
				C++ ICorDebugBreakpoint signature(BOOL): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Activate"
		end		

	cpp_is_active (obj: POINTER; a_result: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugBreakpoint signature(BOOL*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"IsActive"
		end		

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ICOR_DEBUG_BREAKPOINT
