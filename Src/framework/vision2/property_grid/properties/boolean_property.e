note
	description: "Boolean item in a property grid."
	date: "$Date$"
	revision: "$Revision$"

class
	BOOLEAN_PROPERTY

inherit
	CHOICE_PROPERTY [BOOLEAN]
		redefine
			convert_to_data
		end

create
	make_with_value

feature {NONE} -- Initialization

	make_with_value (a_name: like name; a_value: BOOLEAN)
			-- Create with `a_value'.
		do
			make_with_choices (a_name, create {ARRAYED_LIST [BOOLEAN]}.make_from_array (<<True, False>>))
			disable_text_editing
			set_value (a_value)
		end

feature {NONE} -- Implementation

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		do
			if convert_to_data_agent /= Void then
				Result := convert_to_data_agent.item ([a_string])
			else
				if a_string.is_boolean then
					Result := a_string.to_boolean
				end
			end
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
