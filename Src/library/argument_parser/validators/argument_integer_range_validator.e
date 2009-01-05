note
	description: "A command line switch file validator that checks if an integer is with a value range."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_INTEGER_RANGE_VALIDATOR

inherit
	ARGUMENT_NUMERIC_RANGE_VALIDATOR [INTEGER_64]
		redefine
			validate_value
		end

create
	make

feature {NONE} -- Validation

	validate_value (a_value: READABLE_STRING_8)
			-- <Precursor>
		local
			l_value: INTEGER_64
		do
			if a_value.is_integer_64 then
				l_value := a_value.to_integer_64
				if l_value < min or else l_value > max then
					invalidate_option ((create {STRING_FORMATTER}).format (e_not_within_range, [l_value, min, max]))
				end
			else
				invalidate_option (e_invalid_number)
			end
		end

;note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
