indexing
	description: "Element representing a database table"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DB_TABLE

inherit
	DB_TABLES_ACCESS_USE

feature -- Initialization

	make is
			-- Create all the attributes.
		do
			set_default
		end

	set_default is
			-- Sets object default values.
			-- WARNING: Default primary and foreign key values
			-- MUST NOT be valid database values!
		deferred
		end

feature -- Access

	table_description: DB_TABLE_DESCRIPTION is deferred end
			-- Description associated to the table.

end -- class DB_TABLE


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

