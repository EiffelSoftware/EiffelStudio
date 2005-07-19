indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_ENUM

inherit
	ICOR_OBJECT
		redefine
			init_icor
		end

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	init_icor is
			-- 
		do
			Precursor
			count := get_count
		end	
		
feature {ICOR_EXPORTER} -- Access Property

	count: INTEGER
	
	is_empty: BOOLEAN is
		do
			Result := get_count = 0
		end

feature {ICOR_EXPORTER} -- Access

	skip (a_nb: INTEGER) is
			-- Skip the next a_nb entries
			-- if a_nb is zero, we don't skip any
		do
			if a_nb > 0 then
				last_call_success := cpp_skip (item, a_nb)
			end
		end

	reset is
		do
			last_call_success := cpp_reset (item)
		ensure
			success: last_call_success = 0
		end

	get_clone: ICOR_DEBUG_ENUM is
		local
			l_p: POINTER
		do
			last_call_success := cpp_clone (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		ensure
			success: last_call_success = 0
		end

	get_count: INTEGER is
		do
			last_call_success := cpp_get_count (item, $Result)
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_skip (obj: POINTER; a_nb: INTEGER): INTEGER is
		external
			"[
				C++ ICorDebugEnum signature(ULONG): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Skip"
		end

	cpp_reset (obj: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugEnum signature(): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Reset"
		end

	cpp_clone (obj: POINTER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugEnum signature(ICorDebugEnum**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Clone"
		end

	cpp_get_count (obj: POINTER; a_p_count: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugEnum signature(ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetCount"
		end

end -- class ICOR_DEBUG_ENUM
