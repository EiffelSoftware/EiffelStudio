indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_VALUE_ENUM

inherit

	ICOR_DEBUG_ENUM_WITH_NEXT [ICOR_DEBUG_VALUE]

create 
	make_by_pointer

feature {NONE} -- Implementation

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

