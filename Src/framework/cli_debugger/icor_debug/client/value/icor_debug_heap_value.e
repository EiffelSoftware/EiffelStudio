note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_HEAP_VALUE

inherit
	ICOR_DEBUG_VALUE

feature {ICOR_EXPORTER} -- Access

	is_valid: BOOLEAN
			-- IsValid tests whether the object is valid
		local
			r: INTEGER
		do
			set_last_call_success (cpp_is_valid (item, $r))
			Result := (r /= 0) --| TRUE = 1 , FALSE = 0
		end

	last_error_was_object_neutered: BOOLEAN
			-- last call returned an Object_neutered error code ?
		do
			Result := error_code_is_object_neutered (last_call_success)
		end

feature {NONE} -- Implementation

	cpp_is_valid (obj: POINTER; a_result: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugHeapValue signature(BOOL*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"IsValid"
		end

end
