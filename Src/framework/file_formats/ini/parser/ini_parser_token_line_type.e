note
	description: "Represents a parser token line type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

expanded class
	INI_PARSER_TOKEN_LINE_TYPE

create
	default_create,
	make_from_integer

convert
	make_from_integer ({INTEGER}),
	to_integer: {INTEGER}

feature {NONE} -- Initialization

	make_from_integer (i: INTEGER)
			-- Initializes `Current' using `i' to correspond to a token member (see Access)
		require
			i_is_member: i >= min_member and i <= max_member
		do
			value := i
		ensure
			value_set: value = i
		end

feature -- Access

	unknown: INTEGER = 0x00
			-- Unknown line

	section: INTEGER = 0x01
			-- Section label line

	property: INTEGER = 0x02
			-- Property assigner line

	comment: INTEGER = 0x03
			-- Comment line

feature -- Access

	min_member: INTEGER
			-- Minimum value member
		do
			Result := unknown
		end

	max_member: INTEGER
			-- Maximum value member
		do
			Result := comment
		end

feature -- HASHABLE Implementation

	hash_code: INTEGER
			-- Hash code value
		do
			Result := value
		end

feature -- Conversion

	to_integer: INTEGER
			-- Converts `Current' to an INTEGER
		do
			Result := value
		ensure
			result_set: Result = value
		end

feature {NONE} -- Implementation

	value: INTEGER
			-- Internal value

invariant
	value_is_member: value >= min_member and value <= max_member

note
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

end -- class {INI_PARSER_TOKEN_LINE_TYPE}
