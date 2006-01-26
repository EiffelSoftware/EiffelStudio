indexing
	description: "Hash table used for querying pixmap coordinates in matrix"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_PIXMAP_LOOKUP_TABLE

inherit
	HASH_TABLE [INTEGER, INTEGER]

create
	make_with_values

feature {NONE} -- Initialization

	make_with_values (a_columns, a_rows: INTEGER) is
			-- Create lookup table to for matrix pixmap retrieval.
		require
			columns_valid: a_columns > 0
			rows_valid: a_rows > 0
		do
			make (a_columns * a_rows)
			columns := a_columns
			rows := a_rows
		ensure
			columns_set: columns = a_columns
			rows_set: rows = a_rows
		end

feature -- Insert

	add_pixmap (a_column, a_row, a_constant: INTEGER) is
		require
			valid_column: a_column > 0 and then a_column <= columns
			valid_row: a_row > 0 and then a_row <= rows
		do
			put (columns * (a_row - 1) + a_column, a_constant)
		end

feature -- Access

	columns: INTEGER
		-- Number of columns used for lookup.

	rows: INTEGER
		-- Number of rows used for lookup.	

end
