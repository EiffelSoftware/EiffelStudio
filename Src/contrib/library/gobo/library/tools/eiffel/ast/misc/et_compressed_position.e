indexing

	description:

		"Positions in Eiffel texts, compressed in memory"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_COMPRESSED_POSITION

inherit

	ET_POSITION

create

	make, make_default

feature {NONE} -- Initialization

	make (a_line, a_column: INTEGER) is
			-- Create a new position.
		require
			a_line_positive: a_line >= 0
			a_column_positive: a_column >= 0
		do
			set_position (a_line, a_column)
		ensure
			line_set: a_line <= maximum_line implies line = a_line
			no_line_set: a_line > maximum_line implies line = no_line
			column_set: a_column <= maximum_column implies column = a_column
			no_column_set: a_column > maximum_column implies column = no_column
		end

	make_default is
			-- Create a new default position.
		do
			compressed_position := 0
		ensure
			line_set: line = no_line
			column_set: column = no_column
		end

feature -- Access

	line: INTEGER is
			-- Line number
			-- (between 1 and 8388607, 0 if unknown or overflow)
		do
			Result := compressed_position // 256
		end

	column: INTEGER is
			-- Column number
			-- (between 1 and 255, 0 if unknown or overflow)
		do
			Result := compressed_position \\ 256
		end

feature -- Setting

	set_position (a_line, a_column: INTEGER) is
			-- Set to new position.
		require
			a_line_positive: a_line >= 0
			a_column_positive: a_column >= 0
		local
			l, c: INTEGER
		do
			if a_line > maximum_line then
				l := no_line
			else
				l := a_line
			end
			if a_column > maximum_column then
				c := no_column
			else
				c := a_column
			end
			compressed_position := 256 * l + c
		ensure
			line_set: a_line <= maximum_line implies line = a_line
			no_line_set: a_line > maximum_line implies line = no_line
			column_set: a_column <= maximum_column implies column = a_column
			no_column_set: a_column > maximum_column implies column = no_column
		end

feature -- Constants

	maximum_line: INTEGER is 8388607
			-- Maxumum line number (2^23-1)

	maximum_column: INTEGER is 255
			-- Maximum column number (2^8-1)

feature {NONE} -- Implementation

	compressed_position: INTEGER
			-- Compressed position
			-- column: 8 first bits
			-- line: 23 next bits

invariant

	compressed_position_positive: compressed_position >= 0

end
