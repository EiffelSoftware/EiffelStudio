indexing
	description: "[
		ICorDebugGenericValue
			GetValue([out] void *pTo);
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_GENERIC_VALUE

inherit
	ICOR_DEBUG_VALUE_WITH_VALUE

create 
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	get_value (a_result: POINTER) is
			-- GetValue copies the value into the specified buffer
		do
			last_call_success := cpp_get_value (item, a_result)
		end

feature {NONE} -- Implementation

	cpp_get_value (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugGenericValue signature(void*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetValue"
		end

end -- class ICOR_DEBUG_GENERIC_VALUE

