indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_MODULE_BREAKPOINT

inherit
	ICOR_DEBUG_BREAKPOINT

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	get_module: ICOR_DEBUG_MODULE is
			-- Reference to the ICorDebugModule.
		local
			p: POINTER
		do
			last_call_success := cpp_get_module (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_get_module (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModuleBreakpoint signature(ICorDebugModule**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetModule"
		end	

end -- class ICOR_DEBUG_MODULE_BREAKPOINT
