indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_BREAKPOINT

inherit
	ICOR_OBJECT

create 
	make_by_pointer
	
	
feature {ICOR_EXPORTER} -- QueryInterface

	query_interface_icor_debug_function_breakpoint: ICOR_DEBUG_FUNCTION_BREAKPOINT is
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugFunctionBreakpoint (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end
		
	query_interface_icor_debug_value_breakpoint: ICOR_DEBUG_VALUE_BREAKPOINT is
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugValueBreakpoint (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end		
		
	query_interface_icor_debug_module_breakpoint: ICOR_DEBUG_MODULE_BREAKPOINT is
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugModuleBreakpoint (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end			
		
feature {ICOR_EXPORTER} -- Access

	activate (a_active: BOOLEAN) is
			-- Activate the breakpoint
		do
			last_call_success := cpp_activate (item, a_active.to_integer)
		ensure
			success: last_call_success = 0
		end

	is_active: BOOLEAN is
			-- Is active ?
		local
			l_result: INTEGER
		do
			last_call_success := cpp_is_active (item, $l_result)
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- QueryInterface Implementation

	cpp_query_interface_ICorDebugFunctionBreakpoint (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugBreakpoint *) $obj)->QueryInterface (IID_ICorDebugFunctionBreakpoint, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugValueBreakpoint (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugBreakpoint *) $obj)->QueryInterface (IID_ICorDebugValueBreakpoint, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugModuleBreakpoint (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugBreakpoint *) $obj)->QueryInterface (IID_ICorDebugModuleBreakpoint, (void **) $a_p)"
		end
		
feature {NONE} -- Implementation

	cpp_activate (obj: POINTER; a_bool: INTEGER): INTEGER is
		external
			"[
				C++ ICorDebugBreakpoint signature(BOOL): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Activate"
		end		

	cpp_is_active (obj: POINTER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugBreakpoint signature(BOOL*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"IsActive"
		end		

end -- class ICOR_DEBUG_BREAKPOINT
