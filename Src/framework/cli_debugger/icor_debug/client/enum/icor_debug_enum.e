note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_ENUM

inherit
	ICOR_DEBUG_I

feature {ICOR_EXPORTER} -- Access Property

	is_empty: BOOLEAN
		do
			Result := get_count = 0
		end

feature {ICOR_EXPORTER} -- Access

	skip (a_nb: INTEGER)
			-- Skip the next a_nb entries
			-- if a_nb is zero, we don't skip any
		do
			if a_nb > 0 then
				set_last_call_success (cpp_skip (item, a_nb))
			end
		end

	reset
		do
			set_last_call_success (cpp_reset (item))
		ensure
			success: last_call_success = 0
		end

	get_clone: ICOR_DEBUG_ENUM
		local
			p: POINTER
		do
			set_last_call_success (cpp_clone (item, $p))
			if p /= default_pointer then
				Result := new_enum (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_count: INTEGER
		do
			set_last_call_success (cpp_get_count (item, $Result))
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_skip (obj: POINTER; a_nb: INTEGER): INTEGER
		external
			"[
				C++ ICorDebugEnum signature(ULONG): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Skip"
		end

	cpp_reset (obj: POINTER): INTEGER
		external
			"[
				C++ ICorDebugEnum signature(): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Reset"
		end

	cpp_clone (obj: POINTER; a_result: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugEnum signature(ICorDebugEnum**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Clone"
		end

	cpp_get_count (obj: POINTER; a_p_count: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugEnum signature(ULONG*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetCount"
		end

note
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
