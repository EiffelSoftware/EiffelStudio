indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_VALUE_BREAKPOINT

inherit
	ICOR_DEBUG_BREAKPOINT

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

--	get_value: ICOR_DEBUG_VALUE is
--			-- Reference to the ICorDebugValue.
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_get_value (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--			end
--		ensure
--			success: last_call_success = 0
--		end

feature {NONE} -- Implementation

	cpp_get_value (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugValueBreakpoint signature(ICorDebugValue**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetValue"
		end	

end -- class ICOR_DEBUG_VALUE_BREAKPOINT
