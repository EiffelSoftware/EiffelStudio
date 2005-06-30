indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_VALUE_ENUM

inherit

	ICOR_DEBUG_ENUM_WITH_NEXT [ICOR_DEBUG_VALUE]
		rename
			icor_object_made_by_pointer as icor_debug_value_made_by_pointer
		redefine
			icor_debug_value_made_by_pointer
		end

create 
	make_by_pointer

feature {NONE} -- Implementation

	icor_debug_value_made_by_pointer (a_p: POINTER): ICOR_DEBUG_VALUE is
		do
			create Result.make_value_by_pointer (a_p)
		end

	call_cpp_next (obj: POINTER; a_celt: INTEGER; a_p: POINTER; a_pceltfetched: POINTER): INTEGER is
		do
			Result := cpp_next (obj, a_celt, a_p, a_pceltfetched)
		end

	cpp_next (obj: POINTER; a_celt: INTEGER; a_p: POINTER; a_pceltfetched: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugValueEnum signature(ULONG,ICorDebugValue**, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Next"
		end

end -- class ICOR_DEBUG_VALUE_ENUM

