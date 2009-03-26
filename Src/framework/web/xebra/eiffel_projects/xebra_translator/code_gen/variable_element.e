note
	description: "[
		Used to render a name and its type.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	VARIABLE_ELEMENT

inherit
	SERVLET_ELEMENT

create
	make

feature -- Initialization

	make (a_name: STRING; a_type: STRING)
			-- `a_name': The name of the variable
			-- `a_type': The type of the variable
		require
			name_is_valid: not a_name.is_empty
			type_is_valid: not a_type.is_empty
		do
			name := a_name
			type := a_type
		end

feature -- Access

	name: STRING
			-- The name of the variable

	type: STRING
			-- The type of the variable

feature -- Implementation

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>
		do
			buf.put_string (name + ": " + type.as_upper)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
