note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_BREAKPOINT

inherit
	ICOR_DEBUG_I

feature {ICOR_EXPORTER} -- QueryInterface

	query_interface_icor_debug_function_breakpoint: ICOR_DEBUG_FUNCTION_BREAKPOINT
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugFunctionBreakpoint (item, $p))
			if p /= default_pointer then
				Result := new_function_breakpoint (p)
			end
		end

	query_interface_icor_debug_value_breakpoint: ICOR_DEBUG_VALUE_BREAKPOINT
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugValueBreakpoint (item, $p))
			if p /= default_pointer then
				Result := new_value_breakpoint (p)
			end
		end

	query_interface_icor_debug_module_breakpoint: ICOR_DEBUG_MODULE_BREAKPOINT
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugModuleBreakpoint (item, $p))
			if p /= default_pointer then
				Result := new_module_breakpoint (p)
			end
		end

feature {ICOR_EXPORTER} -- Access

	activate (a_active: BOOLEAN)
			-- Activate the breakpoint
		do
			set_last_call_success (cpp_activate (item, a_active.to_integer))
		ensure
			success: last_call_success = 0
		end

	is_active: BOOLEAN
			-- Is active ?
		local
			r: INTEGER
		do
			set_last_call_success (cpp_is_active (item, $r))
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
end
