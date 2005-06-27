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
	
feature {ICOR_EXPORTER} -- Access

	is_valid: BOOLEAN is
			-- IsValid tests whether the object is valid
		local
			l_result: INTEGER
		do
			last_call_success := cpp_is_valid (item, $l_result)
			Result := (l_result /= 0) --| TRUE = 1 , FALSE = 0
		end
		
	last_error_was_object_neutered: BOOLEAN is
			-- last call returned an Object_neutered error code ?
		do
			Result := error_code_is_object_neutered (last_call_success)
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

end -- class ICOR_DEBUG_HEAP_VALUE

