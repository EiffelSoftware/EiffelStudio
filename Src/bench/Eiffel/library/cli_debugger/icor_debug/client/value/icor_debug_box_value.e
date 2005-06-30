indexing
	description: "[
		ICorDebugBoxValue
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_BOX_VALUE

inherit
	ICOR_DEBUG_HEAP_VALUE

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	get_object: ICOR_DEBUG_OBJECT_VALUE is
			-- GetObject
		local
			p: POINTER
		do
			last_call_success := cpp_get_object (item, $p)
			if p /= Default_pointer then
				create Result.make_value_by_pointer (p)
			end
		end

feature {NONE} -- Implementation

	cpp_get_object (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugBoxValue signature(ICorDebugObjectValue**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetObject"
		end

end -- class ICOR_DEBUG_BOX_VALUE

