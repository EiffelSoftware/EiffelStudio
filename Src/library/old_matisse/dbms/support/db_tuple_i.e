indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: RDBMS

deferred class DB_TUPLE_I

inherit

	HANDLE_USE

	DB_RESULT_I
		redefine
			data
		end

feature -- Status report

	data: DB_DATA_SQL is
		deferred
		end

	item (index: INTEGER): ANY is
			-- Value of `index' column in current row
			-- pointed to by active database cursor
		do
			Result := data.item (index)
		end

	map_table: ARRAY [INTEGER] is
			-- Association table returning k-th field 	
			-- position mapping i-th column value of current active tuple
		do
			Result := data.map_table
		ensure then
			resulting_data: Result = data.map_table
		end

	count: INTEGER is
			-- Number of items
		do
			Result := data.count
		ensure
			resulting_data: Result = data.count
		end

	column_name (position: INTEGER): STRING is
			-- Name of the `position'-th column
		do
			Result := data.column_name (position)
		ensure
			resulting_data: Result = data.column_name (position)
		end

feature -- Status setting

	fill_in (no_descriptor: INTEGER) is
			-- Fill in current tuple with database cursor.
		require else
			data_exists: data /= Void
		do
			data.fill_in (no_descriptor)
		end

	update_map_table (object: ANY) is
			-- Update map table according to new `object'.
		require else
			data_exists: data /= Void
		do
			data.update_map_table (object)
		end

end -- class DB_TUPLE_I


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

