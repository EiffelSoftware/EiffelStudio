indexing
	description: "[
		ICorDebugGenericValue
			GetValue([out] void *pTo);
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_GENERIC_VALUE

inherit
	ICOR_DEBUG_VALUE_WITH_VALUE

create 
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	get_value (a_result: POINTER) is
			-- GetValue copies the value into the specified buffer
		do
			last_call_success := cpp_get_value (item, a_result)
		end

	set_value (a_val: POINTER) is
			-- SetValue copies a new value from the specified buffer. The buffer should
			-- be the appropriate size for the simple type.

		do
			last_call_success := cpp_set_value (item, a_val)
		end

feature {NONE} -- Implementation

	cpp_get_value (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugGenericValue signature(void*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetValue"
		end


	cpp_set_value (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugGenericValue signature(void*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"SetValue"
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

end -- class ICOR_DEBUG_GENERIC_VALUE

