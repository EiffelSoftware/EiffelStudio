note
	description: "Locations in Eiffel text files"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LOCATION_AS

create
	make, make_null, make_from_other

feature {NONE} -- Initialization

	make (l, c, p, n, cc, cp, cn: INTEGER)
			-- Initialize current with line `l', column `c' and count `n';
			-- character column `cc', character position `cp' and character count `cn'.
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
			cc_non_negative: cc >= 0
			cp_non_negative: cp >= 0
			cn_non_negative: cn >= 0
		do
			set_position (l, c, p, n, cc, cp, cn)
		ensure
			line_set: l <= max_line implies line = l
			no_line_set: l > max_line implies line = no_line
			column_set: c <= max_column implies column = c
			no_column_set: c > max_column implies column = no_column
			position_set: position = p
			location_count_set: n <= max_count implies location_count = n
			no_location_count_set: n > max_count implies location_count = 0
			character_column_set: cc <= max_character_column implies character_column = cc
			no_character_column_set: cc > max_character_column implies character_column = no_column
			character_position_set: character_position = cp
			character_location_count_set: cn <= max_character_count implies character_count = cn
			no_character_location_count_set: cn > max_character_count implies character_count = 0
		end

	make_from_other (other: LOCATION_AS)
			-- Copy `other' data into Current
		require
			other_not_void: other /= Void
		do
			internal_location := other.internal_location
			internal_count := other.internal_count
			position := other.position
			internal_character_column := other.internal_character_column
			internal_character_count := other.internal_character_count
			character_position := other.character_position
		ensure
			internal_location_set: internal_location = other.internal_location
			internal_count_set: internal_count = other.internal_count
			position_set: position = other.position
			internal_character_column_set: internal_character_column = other.internal_character_column
			internal_character_count_set: internal_character_count = other.internal_character_count
			character_position_set: character_position = other.character_position
		end

	make_null
			-- Initialize current with (0,0) as `line' and `column'.
		do
		ensure
			is_null: is_null
		end

feature -- Access

	line: INTEGER
			-- Line number in file of Current
		do
			Result := (internal_location & line_mask).to_integer_32
		end

	column: INTEGER
			-- Column number in file of Current
		do
			Result := (internal_location |>> column_shift).to_integer_32
		end

	position: INTEGER
			-- Position in file of Current

	final_position: INTEGER
			-- Ending position of Current in file
		do
			Result := position + internal_count.to_integer_32 - 1
		end

	final_column: INTEGER
			-- Column number plus count. Assume it is on one line.
		do
			Result := (internal_location |>> column_shift).to_integer_32 +
				internal_count.to_integer_32
		end

	location_count: INTEGER
			-- Length of Current.
		do
			Result := internal_count.to_integer_32
		end

feature -- Access

	character_column: INTEGER_32
			-- Column number in characters
		do
			Result := internal_character_column.to_integer_32
		end

	character_position: INTEGER_32
			-- Character position in file

	final_character_position: INTEGER_32
			-- Ending character position in file
		do
			Result := character_position + character_count - 1
		end

	character_count: INTEGER_32
			-- Length of current in characters
		do
			Result := internal_character_count.to_integer_32
		end

feature -- Setting

	set_position (l, c, p, s, cc, cp, cs: INTEGER)
			-- Initialize current with line `l', column `c', position `p' and count `s';
			-- character column `cc', character position `cp' and character count `cs'.
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
			cc_non_negative: cc >= 0
			cp_non_negative: cp >= 0
			cs_non_negative: cs >= 0
		do
			if l > max_line then
				internal_location := 0
			else
				if c > max_column then
					internal_location := l.to_natural_32
				else
					internal_location := (c.to_natural_32 |<< 23) + l.to_natural_32
				end
			end
			if s > max_count then
				internal_count := 0
			else
				internal_count := s.to_natural_16
			end
			position := p

			if cc > max_character_column then
				internal_character_column := 0
			else
				internal_character_column := cc.to_natural_16
			end
			if cs > max_character_count then
				internal_character_count := 0
			else
				internal_character_count := cs.to_natural_16
			end
			character_position := cp
		ensure
			line_set: l <= max_line implies line = l
			no_line_set: l > max_line implies line = no_line
			column_set: c <= max_column implies column = c
			no_column_set: c > max_column implies column = no_column
			position_set: position = p
			location_count_set: s <= max_count implies location_count = s
			no_location_count_set: s > max_count implies location_count = 0
			character_column_set: cc <= max_character_column implies character_column = cc
			no_character_column_set: cc > max_character_column implies character_column = no_column
			character_position_set: character_position = cp
			character_location_count_set: cs <= max_character_count implies character_count = cs
			no_character_location_count_set: cs > max_character_count implies character_count = 0
		end

feature -- Access: Constants

	no_line, no_column: INTEGER = 0
			-- Value for `line' or `column' when `is_null'

	max_line: INTEGER = 0x007FFFFF
			-- Maximum value for `line'

	max_column: INTEGER = 0x000001FF
			-- Maximum value for `column'

	max_count: INTEGER = 0x0000FFFF
			-- Maximum value for `location_count'

	max_character_column: INTEGER = 0x0000FFFF
			-- Maximum value for `character_column'

	max_character_count: INTEGER = 0x0000FFFF
			-- Maximum value for `character_location_count'

	line_mask: NATURAL_32 = 0x007FFFFF
			-- Mask to get line information

	column_mask: NATURAL_32 = 0xFF800000
			-- Mask to get column information

	column_shift: INTEGER = 23
			-- Number of shift to the left needed to get column information

feature -- Status Report

	is_null: BOOLEAN
			-- Does current represent a null location?
		do
			Result := internal_location = 0
		end

feature {LOCATION_AS} -- Internal position

	internal_location: NATURAL_32
			-- Space efficient encoding of `line',`column' position.
			-- First 9 bits for the column
			-- Last 23 bits for the line

	internal_count: NATURAL_16
			-- Space efficient encoding of `location_count'.

	internal_character_column: NATURAL_16
			-- Space efficient encoding of `character_column'.

	internal_character_count: NATURAL_16;
			-- Space efficient encoding of `character_count'.

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class LOCATION_AS

