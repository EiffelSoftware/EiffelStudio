note
	description: "A command line switch file validator that checks if a property includes a name and value."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PROPERTY_VALIDATOR

inherit
	ARGUMENT_VALUE_VALIDATOR

feature {NONE} -- Validation

	validate_value (a_value: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			if a_value.occurrences ('=') /= 1 or else a_value.index_of ('=', 1) = 1 then
				invalidate_option (e_not_correctly_defined)
			end
		end

feature {NONE} -- Internationalization

	e_not_correctly_defined: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("Property setting switches must be defined as <property>=<value>")
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
