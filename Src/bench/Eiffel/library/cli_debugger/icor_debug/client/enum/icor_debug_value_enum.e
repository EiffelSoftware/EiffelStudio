indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class ICOR_DEBUG_VALUE_ENUM

