indexing
	description: "Token locations in files"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	TOKEN_LOCATION

create
	reset

feature -- Access

	start_position, end_position: INTEGER
			-- Position in file

	line_number: INTEGER
			-- Line number in file
			
	start_column_position, end_column_position: INTEGER
			-- Position in Current line at `line_number' line in file.

feature -- Setting

	reset is
			-- Reset to start of file.
		do
			start_position := 0
			end_position := 0
			reset_column_positions
			line_number := 1
		ensure
			start_position_set: start_position = 0
			end_position_set: end_position = 0
			line_number_set: line_number = 1
			start_column_position_set: start_column_position = 0
			end_column_position_set: end_column_position = 0
		end

	go_to (c: INTEGER) is
			-- Move to the next token:
			--   `c' characters have been read.
		do
			start_position := end_position
			end_position := end_position + c
			start_column_position := end_column_position
			end_column_position := end_column_position + c
		ensure
			start_position_set: start_position = old end_position
			end_position_set: end_position = old end_position + c
			start_column_position_set: start_column_position = old end_column_position
			end_column_position_set: end_column_position = old end_column_position + c
		end

	reset_column_positions is
			-- Reset `column_position' to `0' as we have most likely started a new line.
		do
			start_column_position := 0
			end_column_position := 0
		ensure
			start_column_position_set: start_column_position = 0
			end_column_position_set: end_column_position = 0
		end
		
	set_line_number (l: INTEGER) is
			-- Set `line_number' to `l'.
		do
			line_number := l
		ensure
			line_number_set: line_number = l
		end

feature {AST_EIFFEL} -- Settings

	set_start_position (s: like start_position) is
		require
			valid_s: s > 0
		do
			start_position := s
		ensure
			start_position_set: start_position = s
		end

	set_end_position (s: like end_position) is
		require
			valid_s: s > 0
		do
			end_position := s
		ensure
			end_position_set: end_position = s
		end

end -- class TOKEN_LOCATION


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
