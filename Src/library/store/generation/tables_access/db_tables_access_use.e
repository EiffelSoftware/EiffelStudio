indexing
	description: "Access to the class DB_SPECIFIC_TABLES_ACCESS"
	author: "Cedric Reduron"
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

feature {NONE} -- Access

	tables: DB_SPECIFIC_TABLES_ACCESS is
			-- Description of specific database tables.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

end -- class DB_TABLES_USE

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
