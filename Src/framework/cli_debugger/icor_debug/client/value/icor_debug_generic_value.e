note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_GENERIC_VALUE

inherit
	ICOR_DEBUG_VALUE_WITH_VALUE

feature {ICOR_EXPORTER} -- Access

	get_value (a_result: POINTER)
			-- GetValue copies the value into the specified buffer
		do
			set_last_call_success (cpp_get_value (item, a_result))
		end

	set_value (a_val: POINTER)
			-- SetValue copies a new value from the specified buffer. The buffer should
			-- be the appropriate size for the simple type.

		do
			set_last_call_success (cpp_set_value (item, a_val))
		end

feature {NONE} -- Implementation

	cpp_get_value (obj: POINTER; a_p: POINTER): INTEGER
		external
			"[
				C++ ICorDebugGenericValue signature(void*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetValue"
		end

	cpp_set_value (obj: POINTER; a_p: POINTER): INTEGER
		external
			"[
				C++ ICorDebugGenericValue signature(void*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"SetValue"
		end

end
