indexing
	description: "Represents a user passed argument option for integer arguments."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_INTEGER_OPTION

inherit
	ARGUMENT_OPTION

create {ARGUMENT_INTEGER_SWITCH}
	make,
	make_with_value

convert
	integer_8_value: {INTEGER_8},
	integer_16_value: {INTEGER_16},
	integer_32_value: {INTEGER_32},
	integer_64_value: {INTEGER_64}

feature -- Access

	integer_8_value: INTEGER_8
			-- `value' as an {INTEGER_8}
		require
			has_value: has_value
		do
			Result := value.to_integer_8
		end

	integer_16_value: INTEGER_16
			-- `value' as an {INTEGER_16}
		require
			has_value: has_value
		do
			Result := value.to_integer_16
		end

	integer_32_value: INTEGER_32
			-- `value' as an {INTEGER_32}
		require
			has_value: has_value
		do
			Result := value.to_integer_32
		end

	integer_64_value: INTEGER_64
			-- `value' as an {INTEGER_64}
		require
			has_value: has_value
		do
			Result := value.to_integer_64
		end

invariant
	value_is_integer: has_value implies value.is_integer

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class {ARGUMENT_INTEGER_OPTION}
