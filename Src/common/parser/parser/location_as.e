indexing
	description: "Locations in Eiffel text files"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	LOCATION_AS

create
	make, make_null, make_from_other
	
feature {NONE} -- Initialization

	make (l, c, p, s: INTEGER) is
			-- Initialize current with line `l', column `c' and count `s'.
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
		do
			set_position (l, c, p, s)
		ensure
			line_set: l <= max_line implies line = l
			no_line_set: l > max_line implies line = no_line
			column_set: c <= max_column implies column = c
			no_column_set: c > max_column implies column = no_column
			position_set: position = p
			location_count_set: location_count = s
		end
		
	make_from_other (other: LOCATION_AS) is
			-- Copy `other' data into Current
		require
			other_not_void: other /= Void
		do
			internal_location := other.internal_location
			internal_count := other.internal_count
			position := other.position
		ensure
			internal_location_set: internal_location = other.internal_location
			internal_count_set: internal_count = other.internal_count
		end
		
	make_null is
			-- Initialize current with (0,0) as `line' and `column'.
		do
		ensure
			is_null: is_null
		end
		
feature -- Access

	line: INTEGER is
			-- Line number in file of Current
		do
			Result := (internal_location & line_mask).to_integer_32
		end
		
	column: INTEGER is
			-- Column number in file of Current
		do
			Result := (internal_location |>> column_shift).to_integer_32
		end
		
	position: INTEGER
			-- Position in file of Current

	final_position: INTEGER is
			-- Ending position of Current in file
		do
			Result := position + internal_count.to_integer_32 - 1
		end

	final_column: INTEGER is
			-- Column number plus count. Assume it is on one line.
		do
			Result := (internal_location |>> column_shift).to_integer_32 +
				internal_count.to_integer_32
		end
		
	location_count: INTEGER is
			-- Length of Current.
		do
			Result := internal_count.to_integer_32
		end
			
feature -- Setting

	set_position (l, c, p, s: INTEGER) is
			-- Initialize current with line `l', column `c', position `p' and count `s'.
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
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
		ensure
			line_set: l <= max_line implies line = l
			no_line_set: l > max_line implies line = no_line
			column_set: c <= max_column implies column = c
			no_column_set: c > max_column implies column = no_column
			position_set: position = p
			location_count_set: s <= max_count implies location_count = s
			no_location_count_set: s > max_count implies location_count = 0
		end

feature -- Access: Constants

	no_line, no_column: INTEGER is 0
			-- Value for `line' or `column' when `is_null'

	max_line: INTEGER is 0x007FFFFF
			-- Maximum value for `line'
	
	max_column: INTEGER is 0x000001FF
			-- Maximum value for `column'
			
	max_count: INTEGER is 0x0000FFFF
			-- Maximum value for `location_count'
	
	line_mask: NATURAL_32 is {NATURAL_32} 8388607 -- 0x007FFFFF
			-- Mask to get line information
			
	column_mask: NATURAL_32 is {NATURAL_32} 0xFF800000
			-- Mask to get column information
			
	column_shift: INTEGER is 23
			-- Number of shift to the left needed to get column information

feature -- Status Report

	is_null: BOOLEAN is
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
			
end -- class LOCATION_AS

--|----------------------------------------------------------------
--| Copyright (C) 1999, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
