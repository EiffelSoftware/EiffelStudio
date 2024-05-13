note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_BOX_VALUE

inherit
	ICOR_DEBUG_HEAP_VALUE

feature {ICOR_EXPORTER} -- Access

	get_object: ICOR_DEBUG_OBJECT_VALUE
			-- GetObject
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_object (item, $p))
			if p /= Default_pointer then
				Result := new_object_value (p)
			end
		end

feature {NONE} -- Implementation

	cpp_get_object (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugBoxValue signature(ICorDebugObjectValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetObject"
		end

end
