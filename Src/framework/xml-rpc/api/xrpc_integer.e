﻿note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	XRPC_INTEGER

inherit
	XRPC_INTEGRAL_VALUE [INTEGER]

create
	make

create {XRPC_LOAD_CALLBACKS}
	make_from_string

convert
	make ({INTEGER_32}),
	value: {INTEGER_32}

feature -- Access

	type: XRPC_TYPE
			-- Actual type of the value.
		once
			Result := {XRPC_TYPE}.integer
		end

feature {NONE} -- Element change

	set_value_from_string (a_string: READABLE_STRING_32)
			-- <Precursor>
		local
			l_valid: BOOLEAN
		do
			l_valid := a_string.is_integer_32
			if l_valid then
				value := a_string.to_integer_32
			else
				value := 0
			end
			is_valid := l_valid
		end

feature -- Basic operations: Visitor

	visit (a_visitor: XRPC_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_integer (Current)
		end

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
