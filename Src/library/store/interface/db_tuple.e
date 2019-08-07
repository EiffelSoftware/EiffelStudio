note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: RDBMS

class DB_TUPLE

inherit
	DB_RESULT
		redefine
			data
		end

create
	copy, make

feature -- Status report

	data: DB_DATA_SQL
			-- Loaded data returned from last SQL query result
		do
			Result := implementation.data
		end

	item alias "[]" (index: INTEGER): detachable ANY
			-- Retrieved value at `index' position in `data'.
		require
			valid_index: valid_index (index)
		do
			Result := implementation.item (index)
		end

	column_name (index: INTEGER): detachable STRING
			-- Name of `index'-th item in Current tuple.
		do
			Result := implementation.column_name (index)
		end

	valid_index (index: INTEGER): BOOLEAN
			-- Is `index' a valid index for Current?
		do
			Result := implementation.valid_index (index)
		end

	count: INTEGER
			-- Number of columns in Current tuple
		do
			Result := implementation.count
		end

	empty: BOOLEAN
			-- Is Current tuple empty?
		obsolete
			"Please use `is_empty' instead to remain %
			%consistant with CONTAINER `is_empty' feature [2017-11-30]."
		do
			Result := is_empty
		end

	is_empty: BOOLEAN
			-- Is Current tuple empty?
		do
			Result := implementation.count = 0
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class DB_TUPLE
