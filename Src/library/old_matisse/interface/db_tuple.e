indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: RDBMS

class DB_TUPLE

inherit

	DB_RESULT
		redefine
			implementation, data
		end

creation -- Creation procedures

	copy, make

feature -- Status report

	data: DB_DATA_SQL is
			-- Loaded data returned from last SQL query result
		do
			Result := implementation.data
		end

	item (index: INTEGER): ANY is
			-- Retrieved value at `index' position in `data'.
		do
			Result := implementation.item (index)
		end

	column_name (index: INTEGER): STRING is
			-- Name of `index'-th item in Current tuple.
		do
			Result := implementation.column_name (index)
		end

	count: INTEGER is
			-- Number of columns in Current tuple
		do
			Result := implementation.count
		end

	empty: BOOLEAN is
			-- Is Curren tuple empty?
		do
			if implementation = Void then
				Result := true	
			else
				Result := (count = 0)
			end
		end

feature {NONE} -- Implementation

	implementation: DB_TUPLE_I
			-- Handle reference to specific database implementation

end -- class DB_TUPLE


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
