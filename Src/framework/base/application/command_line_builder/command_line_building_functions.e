note
	description: "[
		Utility client or ancestor to use when building command lines for application
		that use the Eiffel Software argument parser library.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_LINE_BUILDING_FUNCTIONS

feature -- Access

	is_using_separated_switch_values: BOOLEAN assign set_is_using_separated_switch_values
			-- Indicates if switch values are separated from their switch and not
			-- qualified using a ':' (by default)

feature -- Status Setting

	set_is_using_separated_switch_values (a_use: like is_using_separated_switch_values)
			-- Sets `use_separated_switch_values' with `a_use'.
		do
			is_using_separated_switch_values := a_use
		ensure
			is_using_separated_switch_values_set: is_using_separated_switch_values = a_use
		end

feature -- Command line switch building

	quote_string (a_value: READABLE_STRING_8): STRING
			-- Surrounds `a_value' with quotation marks
		require
			a_value_attached: a_value /= VOid
			not_a_value_is_empty: not a_value.is_empty
		do
			create Result.make (a_value.count + 2)
			Result.append_character (quote_char)
			Result.append (a_value)
			Result.append_character (quote_char)
		ensure
			result_attached: attached Result
			result_has_valid_cound: Result.count >= 3
			result_starts_with_quote: Result.item (1) = quote_char
			result_ends_with_quote: Result.item (Result.count) = quote_char
		end

	switch_string (a_name: READABLE_STRING_8; a_value: detachable READABLE_STRING_8; a_quote: BOOLEAN): STRING
			-- Builds a command line switch with value `a_value', if `a_value' is attached.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			not_a_value_is_empty: attached a_value implies not a_value.is_empty
		do
			if attached a_value then
				create Result.make (255)
				Result.append_character (switch_qualifier)
				Result.append (a_name)
				Result.append_character (switch_value_qualifer)
				if a_quote then
					Result.append (quote_string (a_value))
				else
					Result.append (a_value)
				end
				Result.append_character (space_char)
			else
				create Result.make_empty
			end
		ensure
			result_attached: attached Result
			not_result_is_empty: attached a_value implies not Result.is_empty
		end

	switch_bool_string (a_name: READABLE_STRING_8; a_value: BOOLEAN): STRING
			-- Builds a command line boolean switch for `a_name'
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		do
			if a_value then
				create Result.make (a_name.count + 2)
				Result.append_character (switch_qualifier)
				Result.append (a_name)
				Result.append_character (space_char)
			else
				create Result.make_empty
			end
		ensure
			result_attached: attached Result
			not_result_is_empty: a_value implies not Result.is_empty
		end

feature {NONE} -- Special characters

	switch_qualifier: CHARACTER_8 = '-'
			-- Command-line switch qualifer character

	switch_value_qualifer: CHARACTER
			-- Character used to separate an switch from it's value
		do
			if is_using_separated_switch_values then
				Result := space_char
			else
				Result := colon_char
			end
		end

	colon_char: CHARACTER_8 = ':'
			-- Colon character

	quote_char: CHARACTER_8 = '"'
			-- Quotation character

	space_char: CHARACTER_8 = ' ';
			-- Space character

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

end -- class {COMMAND_LINE_BUILDING_FUNCTIONS}
