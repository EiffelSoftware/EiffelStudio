indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_FUNCTION_BREAKPOINT

inherit
	ICOR_DEBUG_BREAKPOINT

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	get_function: ICOR_DEBUG_FUNCTION is
			-- Reference to the ICorDebugFunction.
		local
			p: POINTER
		do
			last_call_success := cpp_get_function (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_offset: INTEGER is
			-- Get Offset.
		do
			last_call_success := cpp_get_offset (item, $Result)
		ensure
			success: last_call_success = 0
		end
		
feature {NONE} -- Implementation

	cpp_get_function (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFunctionBreakpoint signature(ICorDebugFunction**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetFunction"
		end	

	cpp_get_offset (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFunctionBreakpoint signature(ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetOffset"
		end	

end -- class ICOR_DEBUG_FUNCTION_BREAKPOINT
