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
		obsolete
			"Please use `is_empty' instead to remain %
			%consistant with CONTAINER `is_empty' feature."
		do
			Result := is_empty
		end

	is_empty: BOOLEAN is
			-- Is Curren tuple empty?
		do
			if implementation = Void then
				Result := true	
			else
				Result := (count = 0)
			end
		end

feature {NONE} -- Implementation

	implementation: DATABASE_TUPLE [DATABASE]
			-- Handle reference to specific database implementation

end -- class DB_TUPLE



--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

