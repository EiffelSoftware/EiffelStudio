indexing
	description: "Access to the class DB_TABLES_ACCESS"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DB_TABLES_ACCESS_USE

feature -- Status report

	is_valid_code (code: INTEGER): BOOLEAN is
			-- Does `code' represents a database table?
		do
			Result := tables.is_valid (code)
		end

	tables_set: BOOLEAN is
			-- Is abstract description of database tables
			-- set?
		do
			Result := tables_cell.item /= Void
		end

feature {NONE} -- Access

	tables: DB_TABLES_ACCESS is
			-- Abstract description of database tables.
		require
			tables_set: tables_set
		do
			Result := tables_cell.item
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Basic operations

	set_tables (t: DB_TABLES_ACCESS) is
			-- Set `t' to `tables'.
		require
			not_void: t /= Void
		do
			tables_cell.put (t)
		ensure
			tables_set: tables_set
		end

feature {NONE} -- Implementation

	tables_cell: CELL [DB_TABLES_ACCESS] is
			-- `tables' cell.
		once
			create Result.put (Void)
		end

end -- class DB_TABLES_ACCESS_USE

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
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
