indexing

	description: "Token locations in files"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class TOKEN_LOCATION

creation

	reset

feature -- Access

	start_position, end_position: INTEGER
			-- Position in file

	line_number: INTEGER
			-- Line number in file

feature -- Setting

	reset is
			-- Reset to start of file.
		do
			start_position := 0
			end_position := 0
			line_number := 1
		ensure
			start_position_set: start_position = 0
			end_position_set: end_position = 0
			line_number_set: line_number = 1
		end

	go_to (c: INTEGER) is
			-- Move to the next token:
			--   `c' characters have been read.
		do
			start_position := end_position
			end_position := end_position + c
		ensure
			start_position_set: start_position = old end_position
			end_position_set: end_position = old end_position + c
		end

	set_line_number (l: INTEGER) is
			-- Set `line_number' to `l'.
		do
			line_number := l
		ensure
			line_number_set: line_number = l
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
