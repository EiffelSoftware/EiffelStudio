indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_ENUM

inherit
	ICOR_OBJECT

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access Property

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
			p: POINTER
		do
			last_call_success := cpp_clone (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
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
				use "cli_debugger_headers.h"
			]"
		alias
			"Skip"
		end

	cpp_reset (obj: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugEnum signature(): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Reset"
		end

	cpp_clone (obj: POINTER; a_result: TYPED_POINTER [POINTER]): INTEGER is
		external
			"[
				C++ ICorDebugEnum signature(ICorDebugEnum**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Clone"
		end

	cpp_get_count (obj: POINTER; a_p_count: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugEnum signature(ULONG*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetCount"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ICOR_DEBUG_ENUM
