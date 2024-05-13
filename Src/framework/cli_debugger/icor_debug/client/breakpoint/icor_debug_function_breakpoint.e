note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_FUNCTION_BREAKPOINT

inherit
	ICOR_DEBUG_BREAKPOINT

feature {ICOR_EXPORTER} -- Access

	get_function: ICOR_DEBUG_FUNCTION
			-- Reference to the ICorDebugFunction.
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_function (item, $p))
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_function (p, Current)
			end
		ensure
			success: last_call_success = 0
		end

	get_offset: NATURAL_32
			-- Get Offset.
		do
			set_last_call_success (cpp_get_offset (item, $Result))
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_get_function (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugFunctionBreakpoint signature(ICorDebugFunction**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetFunction"
		end

	cpp_get_offset (obj: POINTER; a_p: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugFunctionBreakpoint signature(ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetOffset"
		end

end
