indexing
	description: "[
		ICorDebugGenericValue
			GetValue([out] void *pTo);
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_HEAP_VALUE

inherit
	ICOR_DEBUG_VALUE

create 
	make_by_pointer
	
--feature -- QueryInterface
--
--	query_interface_icor_debug_box_value: ICOR_DEBUG_HEAP_VALUE is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_query_interface_ICorDebugBoxValue (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--				Result.add_ref
--			end
--		ensure
----			success: last_call_success = 0
--		end
--
--	query_interface_icor_debug_string_value: ICOR_DEBUG_STRING_VALUE is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_query_interface_ICorDebugStringValue (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--				Result.add_ref
--			end
--		ensure
----			success: last_call_success = 0
--		end
--
--	query_interface_icor_debug_array_value: ICOR_DEBUG_HEAP_VALUE is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_query_interface_ICorDebugArrayValue (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--				Result.add_ref
--			end
--		ensure
----			success: last_call_success = 0
--		end

feature {ICOR_EXPORTER} -- Access

	is_valid: BOOLEAN is
			-- IsValid tests whether the object is valid
		local
			l_result: INTEGER
		do
			last_call_success := cpp_is_valid (item, $l_result)
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_is_valid (obj: POINTER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugHeapValue signature(BOOL*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"IsValid"
		end

feature {NONE} -- Implementation / QueryInterface

--	cpp_query_interface_ICorDebugBoxValue (obj: POINTER; a_p: POINTER): INTEGER is
--		external
--			"C++ inline use %"cli_debugger_utils.h%""
--		alias
--			"((ICorDebugHeapValue *) $obj)->QueryInterface (IID_ICorDebugBoxValue, (void **) $a_p)"
--		end
--
--	cpp_query_interface_ICorDebugStringValue (obj: POINTER; a_p: POINTER): INTEGER is
--		external
--			"C++ inline use %"cli_debugger_utils.h%""
--		alias
--			"((ICorDebugHeapValue *) $obj)->QueryInterface (IID_ICorDebugStringValue, (void **) $a_p)"
--		end
--
--	cpp_query_interface_ICorDebugArrayValue (obj: POINTER; a_p: POINTER): INTEGER is
--		external
--			"C++ inline use %"cli_debugger_utils.h%""
--		alias
--			"((ICorDebugHeapValue *) $obj)->QueryInterface (IID_ICorDebugArrayValue, (void **) $a_p)"
--		end

end -- class ICOR_DEBUG_HEAP_VALUE

