note
	description: "A special signature containing only one native type descriptor. Used for marshalling."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_MD_NATIVE_TYPE_SIGNATURE

inherit

	CIL_MD_SIGNATURE

create
	make

feature -- Reset

	reset
			-- Reset current for new signature definition
		do
			current_position := 0
		ensure
			current_position_set: current_position = 0
		end

feature -- Setting

	set_native_type (a_type: INTEGER_8)
			-- Insert `a_type' into Current.
		do
			internal_put (a_type, current_position)
			current_position := current_position + 1
		end

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software"
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

end
